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
                textelement(EmployerCodeText) { }
                textelement(StaffNoText) { }
                textelement(StaffNumberText) { }
                textelement(NameText) { }
                textelement(DepositText) { }
                textelement(TShirtText) { }
                textelement(TotalLoansText) { }
                textelement(GrandTotalText) { }
                textelement(OtherProductsText) { }

                trigger OnBeforeInsertRecord()
                var
                    DepositDec: Decimal;
                    TShirtDec: Decimal;
                    TotalLoansDec: Decimal;
                    GrandTotalDec: Decimal;
                    OtherProductsDec: Decimal;
                    StaffNo: Code[20];
                    CleanDeposit: Text;
                    CleanTShirt: Text;
                    CleanTotalLoans: Text;
                    CleanGrandTotal: Text;
                    CleanOtherProducts: Text;

                    MemberNo: Code[50];
                    MemberName: Text[100];
                    MemberID: Code[20];
                begin
                    RowCounter += 1;

                    // Skip completely empty rows
                    if (StaffNoText = '') and (NameText = '') then
                        currXMLport.Skip();

                    // Get and clean the Staff No from Col 2
                    StaffNo := CopyStr(DelChr(StaffNoText, '=', ' '), 1, 20);

                    // Skip if StaffNo is empty or not numeric (header rows etc.)
                    if (StaffNo = '') or not IsNumeric(StaffNo) then
                        currXMLport.Skip();

                    // Clean all numeric fields - remove commas, spaces, quotes
                    CleanDeposit := DelChr(DepositText, '=', '," ');
                    CleanTShirt := DelChr(TShirtText, '=', '," ');
                    CleanTotalLoans := DelChr(TotalLoansText, '=', '," ');
                    CleanGrandTotal := DelChr(GrandTotalText, '=', '," ');
                    CleanOtherProducts := DelChr(OtherProductsText, '=', '," ');

                    // Handle dashes and empty values → treat as 0
                    if (CleanDeposit = '-') or (CleanDeposit = '') then CleanDeposit := '0';
                    if (CleanTShirt = '-') or (CleanTShirt = '') then CleanTShirt := '0';
                    if (CleanTotalLoans = '-') or (CleanTotalLoans = '') then CleanTotalLoans := '0';
                    if (CleanGrandTotal = '-') or (CleanGrandTotal = '') then CleanGrandTotal := '0';
                    if (CleanOtherProducts = '-') or (CleanOtherProducts = '') then CleanOtherProducts := '0';

                    // Convert to decimals safely
                    if not Evaluate(DepositDec, CleanDeposit) then DepositDec := 0;
                    if not Evaluate(TShirtDec, CleanTShirt) then TShirtDec := 0;
                    if not Evaluate(TotalLoansDec, CleanTotalLoans) then TotalLoansDec := 0;
                    if not Evaluate(GrandTotalDec, CleanGrandTotal) then GrandTotalDec := 0;
                    if not Evaluate(OtherProductsDec, CleanOtherProducts) then OtherProductsDec := 0;

                    // Validate member exists using Staff No (Col 2)
                    if not GetMemberDetails(StaffNo, MemberNo, MemberName, MemberID) then begin
                        FailedRows += 1;
                        if FailedMembers <> '' then
                            FailedMembers += '\';
                        FailedMembers += StaffNo + ' (' + CopyStr(NameText, 1, 30) + ')';
                        currXMLport.Skip();
                    end;

                    // Build the record
                    BamburiCheckoffLines.Init();
                    BamburiCheckoffLines.SetSkipCalcTotals(true);

                    BamburiCheckoffLines."Receipt Header No" := ReceiptHeaderNo;
                    BamburiCheckoffLines."Entry No" := Format(SuccessRows + 1);
                    BamburiCheckoffLines."Staff/Payroll No" := StaffNo;
                    BamburiCheckoffLines."Member No" := MemberNo;
                    BamburiCheckoffLines."Member Found" := true;
                    BamburiCheckoffLines.Name := CopyStr(MemberName, 1, 50);
                    BamburiCheckoffLines."ID No." := MemberID;

                    // Map CSV values to fields
                    BamburiCheckoffLines."Deposit Contribution" := DepositDec;
                    BamburiCheckoffLines."T-Shirt" := TShirtDec;
                    BamburiCheckoffLines."Total Loans" := TotalLoansDec;
                    BamburiCheckoffLines."Grand Total" := GrandTotalDec;
                    BamburiCheckoffLines."Other Products" := OtherProductsDec;

                    // Set remaining loan/contribution fields to zero
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
                       '****************************\' +
                       'Successfully imported: ' + Format(SuccessRows) + ' rows\';

        if FailedRows > 0 then begin
            MessageText += 'Failed: ' + Format(FailedRows) + ' rows\\' +
                           'Members not found:\' + FailedMembers;
        end;

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