xmlport 50106 "Bamburi Checkoff 2026"
{
    Caption = 'Bamburi Checkoff Import';
    Format = VariableText;
    FieldSeparator = ',';

    schema
    {
        textelement(Root)
        {
            tableelement(BamburiCheckoffLines; "Bamburi CheckoffLines")
            {
                AutoSave = false;
                AutoReplace = false;
                AutoUpdate = false;

                textelement(StaffNoText) { }
                textelement(NameText) { }
                textelement(LoanText) { }
                textelement(SharesText) { }
                textelement(TotalText) { }

                trigger OnBeforeInsertRecord()
                var
                    LoanDec: Decimal;
                    DepositDec: Decimal;
                    TotalDec: Decimal;
                    StaffNo: Code[20];
                    CleanLoan: Text;
                    CleanDeposit: Text;
                    CleanTotal: Text;
                    MemberNo: Code[50];
                    MemberName: Text[100];
                    MemberID: Code[20];
                begin
                    // Skip empty rows
                    if (StaffNoText = '') and (NameText = '') then
                        currXMLport.Skip();

                    // Clean Staff No
                    StaffNo := CopyStr(DelChr(StaffNoText, '=', ' '), 1, 20);

                    // Skip header/title/total rows — not numeric
                    if (StaffNo = '') or not IsNumeric(StaffNo) then
                        currXMLport.Skip();

                    // Clean numeric fields — remove commas, spaces, quotes, dashes
                    CleanLoan := DelChr(LoanText, '=', '," ');
                    CleanDeposit := DelChr(SharesText, '=', '," ');
                    CleanTotal := DelChr(TotalText, '=', '," ');

                    if (CleanLoan = '-') or (CleanLoan = '') then CleanLoan := '0';
                    if (CleanDeposit = '-') or (CleanDeposit = '') then CleanDeposit := '0';
                    if (CleanTotal = '-') or (CleanTotal = '') then CleanTotal := '0';

                    if not Evaluate(LoanDec, CleanLoan) then LoanDec := 0;
                    if not Evaluate(DepositDec, CleanDeposit) then DepositDec := 0;
                    if not Evaluate(TotalDec, CleanTotal) then TotalDec := 0;

                    // Validate member exists
                    if not GetMemberDetails(StaffNo, MemberNo, MemberName, MemberID) then begin
                        FailedRows += 1;
                        if FailedMembers <> '' then
                            FailedMembers += '\';
                        FailedMembers += StaffNo + ' (' + CopyStr(NameText, 1, 30) + ')';
                        currXMLport.Skip();
                    end;

                    // Build record
                    BamburiCheckoffLines.Init();
                    BamburiCheckoffLines.SetSkipCalcTotals(true);

                    BamburiCheckoffLines."Receipt Header No" := ReceiptHeaderNo;
                    BamburiCheckoffLines."Entry No" := Format(SuccessRows + 1);
                    BamburiCheckoffLines."Staff/Payroll No" := StaffNo;
                    BamburiCheckoffLines."Member No" := MemberNo;
                    BamburiCheckoffLines."Member Found" := true;
                    BamburiCheckoffLines.Name := CopyStr(MemberName, 1, 50);
                    BamburiCheckoffLines."ID No." := MemberID;

                    BamburiCheckoffLines."Total Loans" := LoanDec;      // Col 3
                    BamburiCheckoffLines."Deposit Contribution" := DepositDec;   // Col 4 ← Shares = Deposit
                    BamburiCheckoffLines."Grand Total" := TotalDec;     // Col 5

                    // Zero out unused fields
                    BamburiCheckoffLines."T-Shirt" := 0;
                    BamburiCheckoffLines."Share Capital" := 0;
                    BamburiCheckoffLines.Benevolent := 0;
                    BamburiCheckoffLines.Insurance := 0;
                    BamburiCheckoffLines.Registration := 0;
                    BamburiCheckoffLines.Holiday := 0;
                    BamburiCheckoffLines."Other Products" := 0;

                    BamburiCheckoffLines.Insert(true);
                    SuccessRows += 1;
                end;
            }
        }
    }

    var
        ReceiptHeaderNo: Code[20];
        SuccessRows: Integer;
        FailedRows: Integer;
        FailedMembers: Text;

    trigger OnPreXmlPort()
    begin
        if ReceiptHeaderNo = '' then
            Error('Receipt Header Number must be set before import.');

        SuccessRows := 0;
        FailedRows := 0;
        FailedMembers := '';
    end;

    trigger OnPostXmlPort()
    var
        MessageText: Text;
    begin
        MessageText := 'Import Completed\' +
                       '****************************\' +
                       'Successfully imported: ' + Format(SuccessRows) + ' rows\';

        if FailedRows > 0 then
            MessageText += 'Failed: ' + Format(FailedRows) + ' rows\\' +
                           'Members not found:\' + FailedMembers;

        Message(MessageText);
    end;

    local procedure GetMemberDetails(StaffNo: Code[20]; var MemberNo: Code[50]; var MemberName: Text[100]; var MemberID: Code[20]): Boolean
    var
        Cust: Record Customer;
    begin
        Cust.Reset();
        Cust.SetRange("Personal No", StaffNo);
        Cust.SetFilter("Customer Type", '%1|%2', Cust."Customer Type"::BOSA, Cust."Customer Type"::STAFF);
        if Cust.FindFirst() then begin
            MemberNo := Cust."No.";
            MemberName := Cust.Name;
            MemberID := Cust."ID No.";
            exit(true);
        end;
        exit(false);
    end;

    local procedure IsNumeric(TextValue: Text): Boolean
    var
        TestDecimal: Decimal;
    begin
        exit(Evaluate(TestDecimal, TextValue));
    end;

    procedure SetReceiptHeaderNo(NewReceiptHeaderNo: Code[20])
    begin
        ReceiptHeaderNo := NewReceiptHeaderNo;
    end;
}