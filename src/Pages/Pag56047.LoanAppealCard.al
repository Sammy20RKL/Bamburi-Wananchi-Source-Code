Page 56047 "Loan Appeal Card"
{
    ApplicationArea = All;
    Caption = 'Loan Restructure Card';
    PageType = Card;
    SourceTable = "Loan Appeal";
    Editable = true;


    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Loan Number"; Rec."Loan Number")
                {
                    ToolTip = 'Specifies the value of the Loan Number field.';
                    ApplicationArea = all;
                }

                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    ToolTip = 'Specifies the value of the Loan Product Type field.';
                    Editable = false;
                }
                field("Amount Applied"; Rec."Amount Applied")
                {
                    ToolTip = 'Specifies the value of the Amount Applied field.';
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Installments; Rec.Installments)
                {
                    ToolTip = 'Specifies the value of the Installments field.';
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Interest; Rec.Interest)
                {
                    ToolTip = 'Specifies the value of the Interest field.';
                    ApplicationArea = all;
                    Editable = false;
                }


                field("Oustanding Balance"; Rec."Oustanding Balance")
                {
                    ToolTip = 'Specifies the value of the Oustanding Balance field.';
                    ApplicationArea = all;
                    Editable = false;
                }
                field("New Principle Amount"; Rec."New Principle Amount")
                {
                    ApplicationArea = all;
                }
                field("New Loan Product Type"; Rec."New Loan Product Type")
                {
                    ApplicationArea = all;
                }
                field(NewInterest; Rec.NewInterest)
                {

                    ApplicationArea = all;
                    Editable = false;
                    Caption = 'New Interest';
                }
                field(NewInstalmentPeriod; Rec.NewInstalmentPeriod)
                {
                    ApplicationArea = all;
                    Caption = 'New Installment Period';
                }
                field(NewInstallment; Rec.NewInstallment)
                {
                    ApplicationArea = all;
                    Caption = 'New Installment';
                }
                field("New Amount"; Rec."New Amount")
                {
                    ToolTip = 'Specifies the value of the New Amount field.';
                    Caption = 'Amount to Alter with';
                    ApplicationArea = all;
                    Editable = false;

                }


                field(Type; Rec.Type)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Reason For change?"; Rec."Reason For change?")
                {
                    ApplicationArea = all;
                    ShowMandatory = true;
                }
                field("Captured By"; Rec."Captured By")
                {
                    ApplicationArea = all;
                    Editable = FALSE;
                }
            }
            part(Control1000000004; "Loans Guarantee Details")
            {
                Caption = 'Guarantors  Detail';
                ApplicationArea = Basic;
                SubPageLink = "Loan No" = field("Loan Number");

            }
            part(Control1000000005; "Loan Collateral Security")
            {
                Caption = 'Other Securities';
                ApplicationArea = Basic;
                SubPageLink = "Loan No" = field("Loan Number");

            }
        }
        area(factboxes)
        {
            part("Member Statistics FactBox"; "Member Statistics FactBox")
            {
                SubPageLink = "No." = field("Member No.");
                ApplicationArea = Basic;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(ProcessLoanAppeal)
            {
                ApplicationArea = All;
                Caption = 'Process Loan Appeal';
                Promoted = true;
                PromotedCategory = Process;
                Image = AdjustEntries;
                trigger OnAction()
                begin
                    if Rec."Reason For change?" = '' then
                        Error('Please type the reason for change') else
                        StatusPermissions.Reset;
                    StatusPermissions.SetRange(StatusPermissions."User Id", UserId);
                    StatusPermissions.SetRange(StatusPermissions."Function", StatusPermissions."function"::"Can Appeal Loans");
                    if StatusPermissions.Find('-') = false then
                        Error('You do not have permissions to Appeal this Loan.')
                    else begin
                        if LoanType.Get(Rec."Loan Product Type") then
                            // BankNo := LoanType."Loan Bank Account";
                        BATCH_TEMPLATE := 'GENERAL';
                        BATCH_NAME := 'APPEAL';
                        DOCUMENT_NO := 'LOANAPPEAL';

                        ///Delete
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                        GenJournalLine.DeleteAll;
                        //end of Delete

                        rec.CalcFields(ClientCode);

                        if Rec.Type = Rec.type::Increase then begin
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::Loan,
                            GenJournalLine."account type"::Customer, Rec.ClientCode, Today, Rec."New Amount", 'BOSA', Rec."Loan Number", Rec."Loan Number" + ' Loan Appeal', Rec."Loan Number");

                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                            GenJournalLine."account type"::"Bank Account", BankNo, Today, Rec."New Amount" * -1, 'BOSA', Rec."Loan Number", Rec."Loan Number" + ' Loan Appeal', ' ');

                        end else
                            if Rec.Type = Rec.type::Decrease then begin
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::Loan,
                                GenJournalLine."account type"::Customer, Rec.ClientCode, Today, Rec."New Amount", 'BOSA', Rec."Loan Number", Rec."Loan Number" + ' Loan Appeal', Rec."Loan Number");

                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                GenJournalLine."account type"::"Bank Account", BankNo, Today, Rec."New Amount" * -1, 'BOSA', Rec."Loan Number", Rec."Loan Number" + ' Loan Appeal', ' ');

                            end;
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                        if GenJournalLine.Find('-') then begin
                            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Batch", GenJournalLine);
                        end;
                        Message('%1 Loan for %2 has Succesfully been Appealed', Rec."Loan Number", Rec.ClientCode);
                        LoanReg.Reset();
                        LoanReg.SetRange(LoanReg."Loan  No.", Rec."Loan Number");
                        if LoanReg.Find('-') then begin
                            LoanReg."Approved Amount" := Rec."New Principle Amount";
                            LoanReg."Requested Amount" := Rec."New Principle Amount";
                            LoanReg."Loan Disbursed Amount" := Rec."New Principle Amount";
                            LoanReg.Installments := Rec.NewInstallment;
                            LoanReg."Instalment Period" := Rec.NewInstalmentPeriod;
                            LoanReg."Loan Product Type" := Rec."New Loan Product Type";
                            LoanReg.Modify();
                            SFactory.FnGenerateRepaymentSchedule(Rec."Loan Number");
                            Rec.Appealed := true;
                            Rec.Modify();
                        end;

                    end;

                end;
            }

            action("View Schedule")
            {
                ApplicationArea = Basic;
                Caption = 'View Schedule';
                Image = ViewDetails;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    LoanApp.Reset;
                    LoanApp.SetRange(LoanApp."Loan  No.", Rec."Loan Number");
                    if LoanApp.Find('-') then begin
                        Report.Run(50477, true, false, LoanApp);
                    end;
                end;
            }
        }

    }
    var
        SFactory: Codeunit "Swizzsoft Factory";
        LoanApp: record "Loans Register";
        BATCH_TEMPLATE: Code[30];
        BATCH_NAME: Code[30];
        DOCUMENT_NO: Code[30];
        LineNo: Integer;
        GenJournalLine: Record "Gen. Journal Line";
        LoanType: Record "Loan Products Setup";
        LoanReg: Record "Loans Register";
        BankNo: Code[30];
        StatusPermissions: Record "Status Change Permision";
}
