#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 50200 "Import Checkoff Distributed"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Bamburi CheckoffLines"; "Bamburi CheckoffLines")
            {
                XmlName = 'Paybill';
                AutoSave = false;
                AutoReplace = false;
                AutoUpdate = false;


                textelement(Personal_no) { }
                textelement(SHARECAPITAL) { }
                textelement(DEPOSITCONTRIBUTION) { }
                textelement(REGISTRATION) { }
                textelement(TShirt) { }
                textelement(OthersProducts) { }
                textelement(EMERGENCYLOAN_AMOUNT) { }
                textelement(EMERGENCYLOAN_PR) { }
                textelement(EMERGENCYLOAN_INT) { }
                textelement(LOAN_NO1) { }
                textelement(KIVUKIOLOAN_AMOUNT) { }
                textelement(KIVUKIOLOAN_PR) { }
                textelement(KIVUKIOLOAN_INT) { }
                textelement(KIVUKIOLOAN_NO) { }
                textelement(MWOKOZILOAN_AMOUNT) { }
                textelement(MWOKOZILOAN_PR) { }
                textelement(MWOKOZILOAN_INT) { }
                textelement(SCHOOLFEES_AMOUNT) { }
                textelement(SCHOOLFEES_PR) { }
                textelement(SCHOOLFEES_INT) { }
                textelement(NORMALLOAN1_AMOUNT) { }
                textelement(NORMALLOAN1_PR) { }
                textelement(NORMALLOAN1_INT) { }
                textelement(NORM1_LOAN_NO) { }
                textelement(NORMALLOAN2_AMOUNT) { }
                textelement(NORMALLOAN2_PR) { }
                textelement(NORMALLOAN2_INT) { }
                textelement(Loan_No) { }
                textelement(MBUYULOAN_AMOUNT) { }
                textelement(MBUYULOAN_PR) { }
                textelement(MBUYULOAN_INT) { }
                textelement(HALLOHALLOLOAN_AMOUNT) { }
                textelement(HALLOHALLOLOAN_PR) { }
                textelement(HALLOHALLOLOAN_INT) { }

                textelement(TOTALLOANAmount) { }
                textelement(GRANTTOTAL) { }

                trigger OnBeforeInsertRecord()
                var
                    MemberNo: Code[50];
                    MemberName: Text[100];
                    MemberID: Code[20];
                    StaffNo: Code[20];
                begin
                    // Skip header/empty rows
                    if not IsNumeric(Personal_no) then
                        currXMLport.Skip();

                    StaffNo := CopyStr(DelChr(Personal_no, '=', ' '), 1, 20);
                    if StaffNo = '' then currXMLport.Skip();

                    // Validate member exists
                    if not GetMemberDetails(StaffNo, MemberNo, MemberName, MemberID) then begin
                        FailedRows += 1;
                        FailedMembers += '\' + StaffNo;
                        currXMLport.Skip();
                    end;

                    // Set member info
                    "Bamburi CheckoffLines".SetSkipCalcTotals(true);
                    "Bamburi CheckoffLines"."Receipt Header No" := ReceiptHeaderNo;
                    "Bamburi CheckoffLines"."Entry No" := Format(SuccessRows + 1);
                    "Bamburi CheckoffLines"."Staff/Payroll No" := StaffNo;
                    "Bamburi CheckoffLines"."Member No" := MemberNo;
                    "Bamburi CheckoffLines".Name := CopyStr(MemberName, 1, 50);
                    "Bamburi CheckoffLines"."ID No." := MemberID;
                    "Bamburi CheckoffLines"."Member Found" := true;

                    // Evaluate all decimal fields safely
                    CleanEvaluate(SHARECAPITAL, "Bamburi CheckoffLines"."Share Capital");
                    CleanEvaluate(DEPOSITCONTRIBUTION, "Bamburi CheckoffLines"."Deposit Contribution");
                    CleanEvaluate(REGISTRATION, "Bamburi CheckoffLines"."Registration");
                    CleanEvaluate(TShirt, "Bamburi CheckoffLines"."T-Shirt");
                    CleanEvaluate(OthersProducts, "Bamburi CheckoffLines"."Other Products");
                    CleanEvaluate(EMERGENCYLOAN_AMOUNT, "Bamburi CheckoffLines"."Emergency Loan Amount");
                    CleanEvaluate(EMERGENCYLOAN_PR, "Bamburi CheckoffLines"."Emergency Loan  Principle");
                    CleanEvaluate(EMERGENCYLOAN_INT, "Bamburi CheckoffLines"."Emergency Loan Interest");
                    "Bamburi CheckoffLines"."Loan No1" := CopyStr(DelChr(LOAN_NO1, '=', ' '), 1, 20);
                    // Loan not found - clear it but track it, don't skip the row
                    if "Bamburi CheckoffLines"."Loan No1" <> '' then begin
                        if not LoanRec.Get("Bamburi CheckoffLines"."Loan No1") then begin
                            FailedLoans += 1;
                            FailedLoanList += '\Loan Not Found: ' + "Bamburi CheckoffLines"."Loan No1" + ' (Staff: ' + StaffNo + ')';
                            "Bamburi CheckoffLines"."Loan No1" := ''; // clear invalid loan
                        end;
                    end;
                    CleanEvaluate(KIVUKIOLOAN_AMOUNT, "Bamburi CheckoffLines"."Kivukio Loan Amount");
                    CleanEvaluate(KIVUKIOLOAN_PR, "Bamburi CheckoffLines"."Kivukio Loan Principle");
                    CleanEvaluate(KIVUKIOLOAN_INT, "Bamburi CheckoffLines"."Kivukio Loan Interest");
                    "Bamburi CheckoffLines"."Kivukio Loan No." := CopyStr(DelChr(KIVUKIOLOAN_NO, '=', ' '), 1, 20);
                    // Loan not found - clear it but track it, don't skip the row
                    if "Bamburi CheckoffLines"."Kivukio Loan No." <> '' then begin
                        if not LoanRec.Get("Bamburi CheckoffLines"."Kivukio Loan No.") then begin
                            FailedLoans += 1;
                            FailedLoanList += '\Loan Not Found: ' + "Bamburi CheckoffLines"."Kivukio Loan No." + ' (Staff: ' + StaffNo + ')';
                            "Bamburi CheckoffLines"."Kivukio Loan No." := ''; // clear invalid loan
                        end;
                    end;
                    CleanEvaluate(MWOKOZILOAN_AMOUNT, "Bamburi CheckoffLines"."Mwokozi Loan Amount");
                    CleanEvaluate(MWOKOZILOAN_PR, "Bamburi CheckoffLines"."Mwokozi Loan Principle");
                    CleanEvaluate(MWOKOZILOAN_INT, "Bamburi CheckoffLines"."Mwokozi Loan Interest");
                    CleanEvaluate(SCHOOLFEES_AMOUNT, "Bamburi CheckoffLines"."School Fees Amount");
                    CleanEvaluate(SCHOOLFEES_PR, "Bamburi CheckoffLines"."School Fees Principle");
                    CleanEvaluate(SCHOOLFEES_INT, "Bamburi CheckoffLines"."School Fees Interest");
                    CleanEvaluate(NORMALLOAN1_AMOUNT, "Bamburi CheckoffLines"."Normal Loan 1 Amount");
                    CleanEvaluate(NORMALLOAN1_PR, "Bamburi CheckoffLines"."Normal Loan 1 Principle");
                    CleanEvaluate(NORMALLOAN1_INT, "Bamburi CheckoffLines"."Normal Loan 1 Interest");
                    "Bamburi CheckoffLines"."Norm1 Loan No." := CopyStr(DelChr(NORM1_LOAN_NO, '=', ' '), 1, 20);
                    //Loan not found - clear it but track it, don't skip the row
                    if "Bamburi CheckoffLines"."Norm1 Loan No." <> '' then begin
                        if not LoanRec.Get("Bamburi CheckoffLines"."Norm1 Loan No.") then begin
                            FailedLoans += 1;
                            FailedLoanList += '\Loan Not Found: ' + "Bamburi CheckoffLines"."Norm1 Loan No." + ' (Staff: ' + StaffNo + ')';
                            "Bamburi CheckoffLines"."Norm1 Loan No." := ''; // clear invalid loan
                        end;
                    end;
                    CleanEvaluate(NORMALLOAN2_AMOUNT, "Bamburi CheckoffLines"."Normal Loan 2 Amount");
                    CleanEvaluate(NORMALLOAN2_PR, "Bamburi CheckoffLines"."Normal Loan 2 Principle");
                    CleanEvaluate(NORMALLOAN2_INT, "Bamburi CheckoffLines"."Normal Loan 2 Interest");
                    "Bamburi CheckoffLines"."Loan No." := CopyStr(DelChr(Loan_No, '=', ' '), 1, 20);
                    // Loan not found - clear it but track it, don't skip the row
                    if "Bamburi CheckoffLines"."Loan No." <> '' then begin
                        if not LoanRec.Get("Bamburi CheckoffLines"."Loan No.") then begin
                            FailedLoans += 1;
                            FailedLoanList += '\Loan Not Found: ' + "Bamburi CheckoffLines"."Loan No." + ' (Staff: ' + StaffNo + ')';
                            "Bamburi CheckoffLines"."Loan No." := ''; // clear invalid loan
                        end;
                    end;
                    CleanEvaluate(MBUYULOAN_AMOUNT, "Bamburi CheckoffLines"."Mbuyu Loan Amount");
                    CleanEvaluate(MBUYULOAN_PR, "Bamburi CheckoffLines"."Mbuyu Loan Principle");
                    CleanEvaluate(MBUYULOAN_INT, "Bamburi CheckoffLines"."Mbuyu Loan Interest");
                    CleanEvaluate(HALLOHALLOLOAN_AMOUNT, "Bamburi CheckoffLines"."HALLO HALLO Loan Amount");
                    CleanEvaluate(HALLOHALLOLOAN_PR, "Bamburi CheckoffLines"."HALLO HALLO Loan Principle");
                    CleanEvaluate(HALLOHALLOLOAN_INT, "Bamburi CheckoffLines"."HALLO HALLO Loan Interest");
                    CleanEvaluate(TOTALLOANAmount, "Bamburi CheckoffLines"."Total Loans");
                    CleanEvaluate(GRANTTOTAL, "Bamburi CheckoffLines"."Grand Total");

                    "Bamburi CheckoffLines".Insert(true);
                    SuccessRows += 1;
                end;
            }
        }
    }

    requestpage
    {
        layout { }
        actions { }
    }

    var
        ReceiptHeaderNo: Code[20];
        SuccessRows: Integer;
        FailedRows: Integer;
        FailedMembers: Text;
        FailedLoans: Integer;
        FailedLoanList: Text;
        LoanRec: Record "Loans Register";

    trigger OnPreXmlPort()
    begin
        if ReceiptHeaderNo = '' then Error('Set Receipt Header No first');
        SuccessRows := 0;
        FailedRows := 0;
        FailedMembers := '';
        FailedLoans := 0;
        FailedLoanList := '';
    end;

    trigger OnPostXmlPort()
    begin
        //   Message('Done\Success: %1\Failed: %2\%3', SuccessRows, FailedRows, FailedMembers);
        Message('Done\Success: %1\Failed Members: %2\Failed Loans: %3\%4\%5',
    SuccessRows, FailedRows, FailedLoans, FailedMembers, FailedLoanList);
    end;

    procedure SetReceiptHeaderNo(No: Code[20])
    begin
        ReceiptHeaderNo := No;
    end;

    local procedure CleanEvaluate(RawText: Text; var TargetField: Decimal)
    var
        CleanText: Text;
        Result: Decimal;
    begin
        CleanText := DelChr(RawText, '=', '," ');
        if (CleanText = '') or (CleanText = '-') then begin
            TargetField := 0;
            exit;
        end;
        if not Evaluate(Result, CleanText) then
            Result := 0;
        TargetField := Result;
    end;

    local procedure IsNumeric(TextValue: Text): Boolean
    var
        TestDecimal: Decimal;
    begin
        exit(Evaluate(TestDecimal, DelChr(TextValue, '=', ' ')));
    end;

    local procedure GetMemberDetails(StaffNo: Code[20]; var MemberNo: Code[50]; var MemberName: Text[100]; var MemberID: Code[20]): Boolean
    var
        Cust: Record Customer;
    begin
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
}