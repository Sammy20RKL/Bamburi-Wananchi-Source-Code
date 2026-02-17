xmlport 50105 "Bamburi Checkoff Import"
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
                textelement(DepositText) { }
                // textelement(ShareCapitalText) { }
                textelement(TotalText) { }

                trigger OnBeforeInsertRecord()
                var
                    LoanDec: Decimal;
                    DepositDec: Decimal;
                    // ShareCapitalDec: Decimal;
                    TotalDec: Decimal;
                    StaffNo: Code[20];
                    CleanLoan: Text;
                    CleanDeposit: Text;
                    // CleanShareCapital: Text;
                    CleanTotal: Text;
                    MemberNo: Code[50];
                    MemberName: Text[100];
                begin
                    RowCounter += 1;

                    // Skip completely empty rows
                    if (StaffNoText = '') and (NameText = '') and (LoanText = '') then
                        currXMLport.Skip();

                    // Skip header/title rows (non-numeric staff numbers)
                    StaffNo := CopyStr(DelChr(StaffNoText, '=', ' '), 1, 20);
                    if (StaffNo = '') then//or not IsNumeric(StaffNo) then
                        currXMLport.Skip();

                    // Clean and prepare values
                    CleanLoan := DelChr(LoanText, '=', '," ');
                    CleanDeposit := DelChr(DepositText, '=', '," ');
                    // CleanShareCapital := DelChr(ShareCapitalText, '=', '," ');
                    CleanTotal := DelChr(TotalText, '=', '," ');

                    // Handle dashes and empty values
                    if (CleanLoan = '-') or (CleanLoan = '') then
                        CleanLoan := '0';
                    if (CleanDeposit = '-') or (CleanDeposit = '') then
                        CleanDeposit := '0';
                    //if (CleanShareCapital = '-') or (CleanShareCapital = '') then
                    //  CleanShareCapital := '0';
                    if (CleanTotal = '-') or (CleanTotal = '') then
                        CleanTotal := '0';

                    LoanDec := 0;
                    DepositDec := 0;
                    //ShareCapitalDec := 0;
                    TotalDec := 0;

                    // Convert to decimals
                    if not Evaluate(LoanDec, CleanLoan) then
                        LoanDec := 0;

                    if not Evaluate(DepositDec, CleanDeposit) then
                        DepositDec := 0;
                    // if not Evaluate(ShareCapitalDec, CleanShareCapital) then
                    //   ShareCapitalDec := 0;

                    if not Evaluate(TotalDec, CleanTotal) then
                        TotalDec := 0;

                    // Check if member exists and get their details
                    if not GetMemberDetails(StaffNo, MemberNo, MemberName) then begin
                        FailedRows += 1;
                        if FailedMembers <> '' then
                            FailedMembers += '\';
                        FailedMembers += StaffNo + ' (' + CopyStr(NameText, 1, 30) + ')';
                        currXMLport.Skip();
                    end;

                    // Insert record
                    BamburiCheckoffLines.Init();
                    BamburiCheckoffLines.SetSkipCalcTotals(true); // Don't recalculate during import

                    BamburiCheckoffLines."Receipt Header No" := ReceiptHeaderNo;
                    BamburiCheckoffLines."Entry No" := Format(SuccessRows + 1); // Line counter starting from 1
                    BamburiCheckoffLines."Staff/Payroll No" := StaffNo;
                    BamburiCheckoffLines."Member No" := MemberNo;
                    BamburiCheckoffLines."Member Found" := true;
                    BamburiCheckoffLines.Name := CopyStr(MemberName, 1, 50); // Use actual member name

                    // Import the values from CSV
                    BamburiCheckoffLines."Total Loans" := LoanDec;
                    BamburiCheckoffLines."Deposit Contribution" := DepositDec;
                    BamburiCheckoffLines."Grand Total" := TotalDec;
                    //BamburiCheckoffLines."Share Capital" := ShareCapitalDec;

                    // Set other fields to zero
                    BamburiCheckoffLines."Share Capital" := 0;
                    BamburiCheckoffLines.Benevolent := 0;
                    BamburiCheckoffLines.Insurance := 0;
                    BamburiCheckoffLines.Registration := 0;
                    BamburiCheckoffLines.Holiday := 0;

                    BamburiCheckoffLines.Insert(true);
                    SuccessRows += 1;
                end;
            }
        }
    }

    var
        ReceiptHeaderNo: Code[20];
        RowCounter: Integer;
        SuccessRows: Integer;
        FailedRows: Integer;
        FailedMembers: Text;

    trigger OnPreXmlPort()
    begin
        if ReceiptHeaderNo = '' then
            Error('Receipt Header Number must be set before import.');

        RowCounter := 0;
        SuccessRows := 0;
        FailedRows := 0;
        FailedMembers := '';
    end;

    trigger OnPostXmlPort()
    var
        MessageText: Text;
    begin
        MessageText := 'Import Completed\' +
                      '================\' +
                      'Successfully imported: ' + Format(SuccessRows) + ' rows\';

        if FailedRows > 0 then begin
            MessageText += 'Failed: ' + Format(FailedRows) + ' rows\\' +
                          'Members not found:\' + FailedMembers;
        end;

        Message(MessageText);
    end;

    local procedure GetMemberDetails(StaffNo: Code[20]; var MemberNo: Code[50]; var MemberName: Text[100]): Boolean
    var
        Cust: Record Customer;
    begin
        Cust.SetRange("Personal No", StaffNo);
        Cust.SetRange("Customer Type", Cust."Customer Type"::Member);

        if Cust.FindFirst() then begin
            MemberNo := Cust."No.";
            MemberName := Cust.Name;
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