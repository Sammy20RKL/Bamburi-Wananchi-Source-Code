#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50490 "Salary Processing Header"
{
    PageType = Card;
    SourceTable = "Salary Processing Headerr";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Entered By"; Rec."Entered By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date Entered"; Rec."Date Entered")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field("Posting date"; Rec."Posting date")
                {
                    ApplicationArea = Basic;
                }
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Exempt Loan Repayment"; Rec."Exempt Loan Repayment")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Total Count"; Rec."Total Count")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque No."; "Cheque No.")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Scheduled Amount"; Rec."Scheduled Amount")
                {
                    ApplicationArea = Basic;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Employer Code"; Rec."Employer Code")
                {
                    ApplicationArea = Basic;
                }
                field(Discard; Rec.Discard)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Pre-Post Blocked Status Update"; Rec."Pre-Post Blocked Status Update")
                {
                    ApplicationArea = Basic;
                    Caption = 'Pre-Post Blocked Status Updated';
                    Editable = false;
                    Visible = false;
                }
                field("Post-Post Blocked Statu Update"; Rec."Post-Post Blocked Statu Update")
                {
                    ApplicationArea = Basic;
                    Caption = 'Post-Post Blocked Status Updated';
                    Editable = false;
                    Visible = false;
                }
            }
            part("50000"; "Salary Processing Lines")
            {
                Caption = 'Salary Processing Lines';
                Enabled = false;
                SubPageLink = "Salary Header No." = field(No);
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(ActionGroup1102755021)
            {
                action("Clear Lines")
                {
                    ApplicationArea = Basic;
                    Enabled = not ActionEnabled;
                    Image = CheckList;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        if Confirm('This Action will clear all the Lines for the current Salary Document. Do you want to Continue') = false then
                            exit;
                        salarybuffer.Reset;
                        salarybuffer.SetRange(salarybuffer."Salary Header No.", Rec.No);
                        salarybuffer.DeleteAll;

                        BATCH_TEMPLATE := 'GENERAL';
                        BATCH_NAME := 'SALARIES';
                        DOCUMENT_NO := Rec.Remarks;
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                        GenJournalLine.DeleteAll;
                    end;
                }
                action("Import Salaries")
                {
                    ApplicationArea = Basic;
                    Enabled = not ActionEnabled;
                    Image = Import;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    // RunObject = XMLport 51516009;
                }
                action("Validate Data")
                {
                    ApplicationArea = Basic;
                    Enabled = not ActionEnabled;
                    Image = ViewCheck;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        AccountName: Text;
                    begin
                        Rec.TestField(No);
                        Rec.TestField("Document No");
                        salarybuffer.Reset;
                        salarybuffer.SetRange("Salary Header No.", Rec.No);
                        if salarybuffer.Find('-') then begin
                            repeat
                                salarybuffer."Account Name" := '';
                                salarybuffer.Modify;
                            until salarybuffer.Next = 0;
                        end;
                        salarybuffer.Reset;
                        salarybuffer.SetRange("Salary Header No.", Rec.No);
                        if salarybuffer.Find('-') then begin
                            repeat
                                AccountName := '';
                                ObjVendor.Reset;
                                ObjVendor.SetRange("Personal No.", salarybuffer."Staff No.");
                                if ObjVendor.Find('-') then begin
                                    AccountName := ObjVendor.Name;
                                    salarybuffer."Account No." := ObjVendor."No.";
                                    salarybuffer."Account Name" := AccountName;
                                    salarybuffer."Mobile Phone Number" := ObjVendor."Phone No.";
                                    salarybuffer.Modify;
                                end;
                            until salarybuffer.Next = 0;
                        end;
                        Message('Validation completed successfully.');
                    end;
                }
                action("Process Salaries")
                {
                    ApplicationArea = Basic;
                    Enabled = not ActionEnabled;
                    Image = Apply;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to Transfer this Salary to Journals ?') = false then
                            exit;

                        Rec.TestField("Document No");
                        Rec.TestField(Amount);
                        Rec.TestField("Cheque No.");
                        Datefilter := '..' + Format(Rec."Posting date");
                        if Rec.Amount <> Rec."Scheduled Amount" then
                            Error('Scheduled Amount must be equal to the Cheque Amount');

                        BATCH_TEMPLATE := 'GENERAL';
                        BATCH_NAME := 'SALARIES';
                        DOCUMENT_NO := Rec."Document No";
                        EXTERNAL_DOC_NO := "Cheque No.";
                        SMSCODE := '';
                        Counter := 0;

                        if Rec."Transaction Type" = Rec."transaction type"::"Nafaka Instant Savings" then begin
                            //SMSCODE:='SMSFEE_NIS';
                            FnNISProcessing();
                        end else begin
                            SMSCODE := 'SMSFEE_SAL';
                            FnSalaryProcessing();
                        end
                    end;
                }
                action("Mark as Posted")
                {
                    ApplicationArea = Basic;
                    Enabled = ActionEnabled;
                    Image = PostBatch;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to mark this process as Complete ?') = false then
                            exit;
                        Rec.TestField("Document No");
                        Rec.TestField(Amount);
                        salarybuffer.Reset;
                        salarybuffer.SetRange("Salary Header No.", Rec.No);

                        if salarybuffer.Find('-') then begin
                            Window.Open('Sending SMS to Members: @1@@@@@@@@@@@@@@@' + 'Record:#2###############');
                            TotalCount := salarybuffer.Count;
                            repeat
                                salarybuffer.CalcFields(salarybuffer."Mobile Phone Number");
                                Percentage := (ROUND(Counter / TotalCount * 10000, 1));
                                Counter := Counter + 1;
                                Window.Update(1, Percentage);
                                Window.Update(2, Counter);
                                if Rec."Transaction Type" = Rec."transaction type"::"Salary Processing" then
                                    SFactory.FnSendSMS('SALARIES', 'Your Salary has been processed at CHUNA Sacco. Dial *850#', salarybuffer."Account No.", salarybuffer."Mobile Phone Number")
                                //SFactory.FnSendSMS('SALARIES','Dear Member, Your 2018 STOCKTAKE allowance has been posted to your FOSA Account.Dial *850#',salarybuffer."Account No.",salarybuffer."Mobile Phone Number")
                                else
                                    //SFactory.FnSendSMS('NIS','Your Instant savings has been processed at NAFAKA Sacco. Dial *850#',salarybuffer."Account No.",salarybuffer."Mobile Phone Number");
                                    if ObjVendor.Get(salarybuffer."Account No.") then begin
                                        if ObjVendor."Salary Processing" = false then begin
                                            ObjVendor."Salary Processing" := true;
                                            ObjVendor.Modify;
                                        end
                                    end
                            until salarybuffer.Next = 0;
                        end;
                        Rec.Posted := true;
                        Rec."Posted By" := UserId;
                        Message('Process Completed Successfully. Account Holders will receive Salary processing notification via SMS');
                        Window.Close;
                    end;
                }
                action(Journals)
                {
                    ApplicationArea = Basic;
                    Caption = 'General Journal';
                    Image = Journals;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedOnly = true;
                    RunObject = Page "General Journal";
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        ObjVendorLedger.Reset;
        ObjVendorLedger.SetRange(ObjVendorLedger."Document No.", Rec."Document No");
        ObjVendorLedger.SetRange("External Document No.", "Cheque No.");
        if ObjVendorLedger.Find('-') then
            ActionEnabled := true;
    end;

    var
        Gnljnline: Record "Gen. Journal Line";
        PDate: Date;
        DocNo: Code[20];
        RunBal: Decimal;
        ReceiptsProcessingLines: Record "Checkoff Lines-Distributed";
        LineNo: Integer;
        LBatches: Record "Loan Disburesment-Batching";
        Jtemplate: Code[30];
        JBatch: Code[30];
        "Cheque No.": Code[20];
        DActivityBOSA: Code[20];
        DBranchBOSA: Code[20];
        ReptProcHeader: Record "Checkoff Header-Distributed";
        Cust: Record Customer;
        salarybuffer: Record "Salary Processing Lines";
        SalHeader: Record "Salary Processing Headerr";
        Sto: Record "Standing Orders";
        ELoanBuffer: Record "E-Loan Salary Buffer";
        ObjVendor: Record Vendor;
        MembLedg: Record "Member Ledger Entry";
        SFactory: Codeunit "Swizzsoft Factory.";
        BATCH_NAME: Code[50];
        BATCH_TEMPLATE: Code[50];
        DOCUMENT_NO: Code[40];
        GenJournalLine: Record "Gen. Journal Line";
        ActionEnabled: Boolean;
        ObjVendorLedger: Record "Vendor Ledger Entry";
        ObjGenSetup: Record "Sacco General Set-Up";
        Charges: Record Charges;
        SalProcessingFee: Decimal;
        LoanApp: Record "Loans Register";
        Datefilter: Text;
        DedStatus: Option Successfull,"Partial Deduction",Failed;
        ObjSTORegister: Record "Standing Order Register";
        ObjLoanProducts: Record "Loan Products Setup";
        Window: Dialog;
        TotalCount: Integer;
        Counter: Integer;
        Percentage: Integer;
        EXTERNAL_DOC_NO: Code[40];
        SMSCODE: Code[30];
        enddate: Date;

    local procedure FnPostSalaryToFosa(ObjSalaryLines: Record "Salary Processing Lines"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
    begin
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
        GenJournalLine."account type"::Customer, ObjSalaryLines."Account No.", Rec."Posting date", ObjSalaryLines.Amount * -1, 'FOSA', EXTERNAL_DOC_NO, Format(Rec."Transaction Type"), '');
        exit(RunningBalance);
    end;

    local procedure FnRecoverStatutories(ObjSalaryLines: Record "Salary Processing Lines"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
    begin
        ObjGenSetup.Get();
        if Charges.Get('SALARYP') then begin
            if Rec."Transaction Type" = Rec."transaction type"::"Salary Processing" then begin
                //---------EARN-------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::"G/L Account", Charges."GL Account", Rec."Posting date", Charges."Charge Amount" * -1, 'FOSA', EXTERNAL_DOC_NO,
                Format(Rec."Transaction Type") + ' Fee', '');
                //-----------RECOVER--------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::Vendor, ObjSalaryLines."Account No.", Rec."Posting date", Charges."Charge Amount", 'FOSA', EXTERNAL_DOC_NO,
                'Processing Fee', '');
                SalProcessingFee := Charges."Charge Amount";
                RunningBalance := RunningBalance - SalProcessingFee;
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::"G/L Account", ObjGenSetup."Excise Duty Account", Rec."Posting date", Charges."Charge Amount" * -0.2, 'FOSA', EXTERNAL_DOC_NO,
                Format(Rec."Transaction Type"), '');
                //--------------RECOVER------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::Vendor, ObjSalaryLines."Account No.", Rec."Posting date", Charges."Charge Amount" * 0.2, 'FOSA', EXTERNAL_DOC_NO,
                '20% Excise Duty on ' + Format(Rec."Transaction Type"), '');
                RunningBalance := RunningBalance - SalProcessingFee * 0.2;
            end;
        end;

        if Charges.Get(SMSCODE) then begin
            if Rec."Transaction Type" = Rec."transaction type"::"Salary Processing" then begin
                //--------------EARN----------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::"G/L Account", Charges."GL Account", Rec."Posting date", Charges."Charge Amount" * -1, 'FOSA', EXTERNAL_DOC_NO,
                Format(Rec."Transaction Type"), '');
                //--------------RECOVER------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::Vendor, ObjSalaryLines."Account No.", Rec."Posting date", Charges."Charge Amount", 'FOSA', EXTERNAL_DOC_NO,
                Charges.Description, '');
                RunningBalance := RunningBalance - Charges."Charge Amount";
            end;
        end;
        exit(RunningBalance);
    end;

    local procedure FnRecoverMobileLoanInterest(ObjRcptBuffer: Record "Salary Processing Lines"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
    begin
        if RunningBalance > 0 then begin
            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            LoanApp.SetRange(LoanApp."Client Code", ObjRcptBuffer."Account No.");
            LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
            LoanApp.SetFilter(Source, Format(LoanApp.Source::FOSA));
            LoanApp.SetFilter("Loan Product Type", 'MSADV');
            LoanApp.SetFilter(Posted, 'Yes');
            if LoanApp.Find('-') then begin
                repeat
                    LoanApp.CalcFields(LoanApp."Oustanding Interest");
                    LoanApp.CalcFields(LoanApp."Outstanding Balance");
                    // IF (SFactory.FnGetInterestDueFiltered(LoanApp,Datefilter)-ABS(LoanApp."Oustanding Interest"))>0 THEN
                    if LoanApp."Outstanding Balance" > 0 then begin
                        if RunningBalance > 0 then begin
                            AmountToDeduct := 0;
                            AmountToDeduct := LoanApp."Loan Interest Repayment";//SFactory.FnGetInterestDueFiltered(LoanApp,Datefilter)-ABS(LoanApp."Oustanding Interest");
                            if RunningBalance <= AmountToDeduct then
                                AmountToDeduct := RunningBalance;
                            //-------------PAY----------------------------
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                            GenJournalLine."account type"::Customer, ObjRcptBuffer."Account No.", Rec."Posting date", AmountToDeduct * -1, 'FOSA', EXTERNAL_DOC_NO,
                            Format(GenJournalLine."transaction type"::"Interest Paid"), LoanApp."Loan  No.");
                            //-------------RECOVER------------------------
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                            GenJournalLine."account type"::Vendor, ObjRcptBuffer."Account No.", Rec."Posting date", AmountToDeduct, 'FOSA', LoanApp."Loan  No.",
                            Format(GenJournalLine."transaction type"::"Interest Paid") + '-' + LoanApp."Loan Product Type", LoanApp."Loan  No.");

                            RunningBalance := RunningBalance - AmountToDeduct;
                        end;
                    end;
                until LoanApp.Next = 0;
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnRecoverMobileLoanPrincipal(ObjRcptBuffer: Record "Salary Processing Lines"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        varLRepayment: Decimal;
    begin
        if RunningBalance > 0 then begin
            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            LoanApp.SetRange(LoanApp."Client Code", ObjRcptBuffer."Account No.");
            LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
            LoanApp.SetFilter(Source, Format(LoanApp.Source::FOSA));
            LoanApp.SetFilter("Loan Product Type", 'MSADV');
            LoanApp.SetFilter(Posted, 'Yes');
            if LoanApp.Find('-') then begin
                repeat
                    if RunningBalance > 0 then begin
                        LoanApp.CalcFields(LoanApp."Outstanding Balance");
                        if LoanApp."Outstanding Balance" > 0 then begin
                            varLRepayment := 0;
                            varLRepayment := LoanApp."Loan Principle Repayment";
                            if LoanApp."Loan Product Type" = 'GUR' then
                                varLRepayment := LoanApp.Repayment;
                            if varLRepayment > 0 then begin
                                if varLRepayment > LoanApp."Outstanding Balance" then
                                    varLRepayment := LoanApp."Outstanding Balance";

                                if RunningBalance > 0 then begin
                                    if RunningBalance > varLRepayment then begin
                                        AmountToDeduct := varLRepayment;
                                    end
                                    else
                                        AmountToDeduct := RunningBalance;
                                end;
                                //---------------------PAY-------------------------------
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                                GenJournalLine."account type"::Customer, ObjRcptBuffer."Account No.", Rec."Posting date", AmountToDeduct * -1, 'FOSA', EXTERNAL_DOC_NO,
                                Format(GenJournalLine."transaction type"::"Loan Repayment"), LoanApp."Loan  No.");
                                //--------------------RECOVER-----------------------------
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                GenJournalLine."account type"::Vendor, ObjRcptBuffer."Account No.", Rec."Posting date", AmountToDeduct, 'FOSA', LoanApp."Loan  No.",
                                Format(GenJournalLine."transaction type"::"Loan Repayment") + '-' + LoanApp."Loan Product Type", LoanApp."Loan  No.");
                                RunningBalance := RunningBalance - AmountToDeduct;
                            end;
                        end;
                    end;
                until LoanApp.Next = 0;
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnRunInterest(ObjRcptBuffer: Record "Salary Processing Lines"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
    begin
        if RunningBalance > 0 then begin
            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            LoanApp.SetRange(LoanApp."Client Code", ObjRcptBuffer."Account No.");
            LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
            LoanApp.SetFilter(Source, Format(LoanApp.Source::FOSA));
            if LoanApp.Find('-') then begin
                repeat
                    if ObjLoanProducts.Get(LoanApp."Loan Product Type") then begin
                        if ObjLoanProducts."Recovery Method" = ObjLoanProducts."recovery method"::"Salary " then begin
                            LoanApp.CalcFields(LoanApp."Oustanding Interest");
                            LoanApp.CalcFields(LoanApp."Outstanding Balance");
                            //IF (SFactory.FnGetInterestDueFiltered(LoanApp,Datefilter)-ABS(LoanApp."Oustanding Interest"))>0 THEN
                            if LoanApp."Outstanding Balance" > 0 then begin
                                if RunningBalance > 0 then begin
                                    AmountToDeduct := 0;
                                    AmountToDeduct := LoanApp."Loan Interest Repayment";//SFactory.FnGetInterestDueFiltered(LoanApp,Datefilter)-ABS(LoanApp."Oustanding Interest");
                                    if RunningBalance <= AmountToDeduct then
                                        AmountToDeduct := RunningBalance;
                                    LineNo := LineNo + 10000;
                                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                                    GenJournalLine."account type"::Customer, ObjRcptBuffer."Account No.", Rec."Posting date", AmountToDeduct * -1, Format(LoanApp.Source), EXTERNAL_DOC_NO,
                                    Format(GenJournalLine."transaction type"::"Interest Paid"), LoanApp."Loan  No.");

                                    LineNo := LineNo + 10000;
                                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                    GenJournalLine."account type"::Vendor, ObjRcptBuffer."Account No.", Rec."Posting date", AmountToDeduct, Format(LoanApp.Source), LoanApp."Loan  No.",
                                    Format(GenJournalLine."transaction type"::"Interest Paid") + '-' + LoanApp."Loan Product Type", LoanApp."Loan  No.");
                                    RunningBalance := RunningBalance - AmountToDeduct;
                                end;
                            end;
                        end;
                    end;
                until LoanApp.Next = 0;
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnRunPrinciple(ObjRcptBuffer: Record "Salary Processing Lines"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
    begin
        if RunningBalance > 0 then begin
            varTotalRepay := 0;
            varMultipleLoan := 0;
            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            LoanApp.SetRange(LoanApp."Account No", ObjRcptBuffer."Account No.");//Account No for FOSA Loans

            //LoanApp.SETFILTER(LoanApp."Date filter",Datefilter);
            LoanApp.SetFilter(Source, Format(LoanApp.Source::FOSA));

            if LoanApp.Find('-') then begin
                repeat
                    // MESSAGE('am here');
                    if ObjLoanProducts.Get(LoanApp."Loan Product Type") then begin
                        if ObjLoanProducts."Recovery Method" = ObjLoanProducts."recovery method"::"Salary " then begin
                            //MESSAGE('run balance is %1',RunningBalance);
                            if RunningBalance > 0 then begin
                                LoanApp.CalcFields(LoanApp."Outstanding Balance");
                                if LoanApp."Outstanding Balance" > 0 then begin
                                    varLRepayment := 0;
                                    PRpayment := 0;
                                    varLRepayment := LoanApp."Loan Principle Repayment";
                                    if LoanApp."Loan Product Type" = 'GUR' then
                                        varLRepayment := LoanApp.Repayment;
                                    if varLRepayment > 0 then begin
                                        if varLRepayment > LoanApp."Outstanding Balance" then
                                            varLRepayment := LoanApp."Outstanding Balance";

                                        if RunningBalance > 0 then begin
                                            if RunningBalance > varLRepayment then begin
                                                AmountToDeduct := varLRepayment;
                                            end
                                            else
                                                AmountToDeduct := RunningBalance;
                                        end;

                                        // MESSAGE('loan no is %1',LoanApp."Loan  No.");
                                        //-------------PAY------------------
                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                                        GenJournalLine."account type"::Customer, LoanApp."Client Code", Rec."Posting date", AmountToDeduct * -1, Format(LoanApp.Source), EXTERNAL_DOC_NO,
                                        Format(GenJournalLine."transaction type"::"Loan Repayment"), LoanApp."Loan  No.");
                                        //-------------RECOVER---------------
                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                        GenJournalLine."account type"::Vendor, ObjRcptBuffer."Account No.", Rec."Posting date", AmountToDeduct, Format(LoanApp.Source), LoanApp."Loan  No.",
                                        Format(GenJournalLine."transaction type"::"Loan Repayment") + '-' + LoanApp."Loan Product Type", LoanApp."Loan  No.");
                                        RunningBalance := RunningBalance - AmountToDeduct;
                                    end;
                                end;
                            end;
                        end;
                    end;
                until LoanApp.Next = 0;
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnRunStandingOrders(ObjRcptBuffer: Record "Salary Processing Lines"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ObjStandingOrders: Record "Standing Orders";
    begin
        if RunningBalance > 0 then begin
            varTotalRepay := 0;
            varMultipleLoan := 0;
            ObjStandingOrders.Reset;
            ObjStandingOrders.SetCurrentkey("No.", "Source Account No.");
            ObjStandingOrders.SetRange("Source Account No.", ObjRcptBuffer."Account No.");
            ObjStandingOrders.SetRange(Status, ObjStandingOrders.Status::Approved);
            ObjStandingOrders.SetRange("Is Active", true);
            //ObjStandingOrders.SETRANGE("Standing Order Type",ObjStandingOrders."Standing Order Type"::Salary);
            if ObjStandingOrders.Find('-') then begin
                enddate := CalcDate('+1M', ObjStandingOrders."End Date");
                if enddate >= Today then begin
                    repeat
                        if RunningBalance > 0 then begin
                            if ObjStandingOrders."Next Run Date" = 0D then
                                ObjStandingOrders."Next Run Date" := ObjStandingOrders."Effective/Start Date";

                            //ObjStandingOrders.CALCFIELDS("Allocated Amount");
                            if RunningBalance >= ObjStandingOrders.Amount then begin
                                AmountToDeduct := ObjStandingOrders.Amount;
                                DedStatus := Dedstatus::Successfull;
                                if AmountToDeduct >= ObjStandingOrders.Balance then begin
                                    AmountToDeduct := ObjStandingOrders.Balance;
                                    ObjStandingOrders.Balance := 0;
                                    ObjStandingOrders."Next Run Date" := CalcDate(ObjStandingOrders.Frequency, ObjStandingOrders."Next Run Date");
                                    ObjStandingOrders.Unsuccessfull := false;
                                end
                                else begin
                                    ObjStandingOrders.Balance := ObjStandingOrders.Balance - AmountToDeduct;
                                    ObjStandingOrders.Unsuccessfull := true;
                                end;
                            end
                            else begin
                                if ObjStandingOrders."Don't Allow Partial Deduction" = true then begin
                                    AmountToDeduct := 0;
                                    DedStatus := Dedstatus::Failed;
                                    ObjStandingOrders.Balance := ObjStandingOrders.Amount;
                                    ObjStandingOrders.Unsuccessfull := true;
                                end
                                else begin
                                    DedStatus := Dedstatus::"Partial Deduction";
                                    ObjStandingOrders.Balance := ObjStandingOrders.Amount - AmountToDeduct;
                                    ObjStandingOrders.Unsuccessfull := true;
                                end;
                            end;



                            if ObjStandingOrders."Destination Account Type" <> ObjStandingOrders."destination account type"::BOSA then
                                RunningBalance := FnNonBosaStandingOrderTransaction(ObjStandingOrders, RunningBalance)
                            else begin
                                RunningBalance := FnBosaStandingOrderTransaction(ObjStandingOrders, RunningBalance)
                            end;


                            ObjStandingOrders.Effected := true;
                            ObjStandingOrders."Date Reset" := Today;
                            ObjStandingOrders."Next Run Date" := CalcDate('-1D', CalcDate('1M', Dmy2date(1, Date2dmy(CalcDate(ObjStandingOrders.Frequency, Today), 2), Date2dmy(CalcDate(ObjStandingOrders.Frequency, Today), 3))));
                            ObjStandingOrders.Modify;

                            FnRegisterProcessedStandingOrder(ObjStandingOrders, AmountToDeduct);
                        end;
                    until ObjStandingOrders.Next = 0;
                end;
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnCheckIfStandingOrderIsRunnable(ObjStandingOrders: Record "Standing Orders") DontEffect: Boolean
    begin
        DontEffect := false;

        if ObjStandingOrders."Effective/Start Date" <> 0D then begin
            if ObjStandingOrders."Effective/Start Date" > Today then begin
                if Date2dmy(Today, 2) <> Date2dmy(ObjStandingOrders."Effective/Start Date", 2) then
                    DontEffect := true;
            end;
        end;
        exit(DontEffect);
    end;

    local procedure FnNonBosaStandingOrderTransaction(ObjRcptBuffer: Record "Standing Orders"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ObjStandingOrders: Record "Standing Orders";
    begin
        if RunningBalance > 0 then begin
            //-------------RECOVER-----------------------------------------------------------------------------------------------------------------------
            if ObjVendor.Get(ObjRcptBuffer."Destination Account No.") then begin
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::Vendor, ObjRcptBuffer."Source Account No.", Rec."Posting date", ObjRcptBuffer.Amount, 'FOSA', ObjRcptBuffer."No.",
                'Standing Order to ' + ObjVendor.Name, '');
            end;
            //-------------PAY----------------------------------------------------------------------------------------------------------------------------
            if ObjVendor.Get(ObjRcptBuffer."Source Account No.") then begin
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::Vendor, ObjRcptBuffer."Destination Account No.", Rec."Posting date", ObjRcptBuffer.Amount * -1, 'FOSA', ObjRcptBuffer."No.",
                'Standing Order From ' + ObjVendor.Name, '');
                RunningBalance := RunningBalance - ObjRcptBuffer.Amount;
            end;

            exit(RunningBalance);
        end;
    end;

    local procedure FnBosaStandingOrderTransaction(ObjRcptBuffer: Record "Standing Orders"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ObjStandingOrders: Record "Standing Orders";
    begin
        if RunningBalance > 0 then begin
            ObjReceiptTransactions.Reset;
            ObjReceiptTransactions.SetRange("Document No", ObjRcptBuffer."No.");
            if ObjReceiptTransactions.Find('-') then begin
                //ObjReceiptTransactions.CALCFIELDS("Interest Amount");
                repeat
                    if ObjReceiptTransactions."Transaction Type" = ObjReceiptTransactions."transaction type"::"Loan Repayment" then begin
                        //-------------RECOVER principal-----------------------
                        if LoanApp.Get(ObjReceiptTransactions."Loan No.") then begin
                            LineNo := LineNo + 10000;
                            LoanApp.CalcFields("Outstanding Balance");
                            if LoanApp."Outstanding Balance" > 0 then begin
                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                                GenJournalLine."account type"::Customer, LoanApp."Client Code", Rec."Posting date", (ObjReceiptTransactions.Amount - ObjReceiptTransactions."Interest Amount") * -1,
                                'FOSA', ObjRcptBuffer."No.", Format(GenJournalLine."transaction type"::"Loan Repayment"), ObjReceiptTransactions."Loan No.");

                                //-------------PAY Principal----------------------------
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                GenJournalLine."account type"::Vendor, ObjRcptBuffer."Source Account No.", Rec."Posting date",
                                ObjReceiptTransactions.Amount - ObjReceiptTransactions."Interest Amount", 'FOSA', ObjRcptBuffer."No.",
                                Format(GenJournalLine."transaction type"::"Loan Repayment") + '-' + LoanApp."Loan Product Type", ObjReceiptTransactions."Loan No.");

                                RunningBalance := RunningBalance - (ObjReceiptTransactions.Amount - ObjReceiptTransactions."Interest Amount");

                                //-------------RECOVER Interest-----------------------
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                                GenJournalLine."account type"::Customer, LoanApp."Client Code", Rec."Posting date", ObjReceiptTransactions."Interest Amount" * -1,
                                'FOSA', ObjRcptBuffer."No.", Format(GenJournalLine."transaction type"::"Interest Paid"), ObjReceiptTransactions."Loan No.");

                                //-------------PAY Interest----------------------------
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                GenJournalLine."account type"::Vendor, ObjRcptBuffer."Source Account No.", Rec."Posting date",
                                ObjReceiptTransactions."Interest Amount", 'FOSA', ObjRcptBuffer."No.",
                                Format(GenJournalLine."transaction type"::"Interest Paid") + '-' + LoanApp."Loan Product Type", ObjReceiptTransactions."Loan No.");

                                RunningBalance := RunningBalance - ObjReceiptTransactions."Interest Amount";
                            end;
                        end;

                    end
                    else begin
                        //-------------RECOVER BOSA NONLoan Transactions-----------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, ObjReceiptTransactions."Transaction Type",
                        GenJournalLine."account type"::Customer, ObjRcptBuffer."BOSA Account No.", Rec."Posting date", ObjReceiptTransactions.Amount * -1,
                        'FOSA', ObjRcptBuffer."No.", Format(ObjReceiptTransactions."Transaction Type"), '');

                        //-------------PAY BOSA NONLoan Transaction----------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, ObjReceiptTransactions."transaction type"::" ",
                        GenJournalLine."account type"::Vendor, ObjRcptBuffer."Source Account No.", Rec."Posting date", ObjReceiptTransactions.Amount,
                        'FOSA', ObjRcptBuffer."No.", Format(ObjReceiptTransactions."Transaction Type"), '');

                        RunningBalance := RunningBalance - ObjReceiptTransactions.Amount;

                    end

                until ObjReceiptTransactions.Next = 0;
            end;

            exit(RunningBalance);
        end;
    end;

    local procedure FnRegisterProcessedStandingOrder(ObjStandingOrders: Record "Standing Orders"; AmountToDeduct: Decimal)
    begin
        ObjSTORegister.Reset;
        ObjSTORegister.SetRange("Document No.", Rec.No);
        if ObjSTORegister.Find('-') then
            ObjSTORegister.DeleteAll;

        ObjSTORegister.Init;
        ObjSTORegister."Register No." := '';
        ObjSTORegister.Validate(ObjSTORegister."Register No.");
        ObjSTORegister."Standing Order No." := ObjStandingOrders."No.";
        ObjSTORegister."Source Account No." := ObjStandingOrders."Source Account No.";
        ObjSTORegister."Staff/Payroll No." := ObjStandingOrders."Staff/Payroll No.";
        ObjSTORegister.Date := Today;
        ObjSTORegister."Account Name" := ObjStandingOrders."Account Name";
        ObjSTORegister."Destination Account Type" := ObjStandingOrders."Destination Account Type";
        ObjSTORegister."Destination Account No." := ObjStandingOrders."Destination Account No.";
        ObjSTORegister."Destination Account Name" := ObjStandingOrders."Destination Account Name";
        ObjSTORegister."BOSA Account No." := ObjStandingOrders."BOSA Account No.";
        ObjSTORegister."Effective/Start Date" := ObjStandingOrders."Effective/Start Date";
        ObjSTORegister."End Date" := ObjStandingOrders."End Date";
        ObjSTORegister.Duration := ObjStandingOrders.Duration;
        ObjSTORegister.Frequency := ObjStandingOrders.Frequency;
        ObjSTORegister."Don't Allow Partial Deduction" := ObjStandingOrders."Don't Allow Partial Deduction";
        ObjSTORegister."Deduction Status" := DedStatus;
        ObjSTORegister.Remarks := ObjStandingOrders."Standing Order Description";
        ObjSTORegister.Amount := ObjStandingOrders.Amount;
        ObjSTORegister."Amount Deducted" := AmountToDeduct;
        if ObjStandingOrders."Destination Account Type" = ObjStandingOrders."destination account type"::External then
            ObjSTORegister.EFT := true;
        ObjSTORegister."Document No." := Rec.No;
        ObjSTORegister.Insert(true);
    end;

    local procedure FnSalaryProcessing()
    begin
        BATCH_TEMPLATE := 'GENERAL';
        BATCH_NAME := 'SALARIES';
        DOCUMENT_NO := Rec."Document No";
        EXTERNAL_DOC_NO := "Cheque No.";
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
        GenJournalLine.DeleteAll;
        ObjGenSetup.Get();
        salarybuffer.Reset;
        salarybuffer.SetRange("Salary Header No.", Rec.No);

        if salarybuffer.Find('-') then begin
            Window.Open(Format(Rec."Transaction Type") + ': @1@@@@@@@@@@@@@@@' + 'Record:#2###############');
            TotalCount := salarybuffer.Count;
            repeat
                Percentage := (ROUND(Counter / TotalCount * 10000, 1));
                Counter := Counter + 1;
                Window.Update(1, Percentage);
                Window.Update(2, Counter);

                RunBal := salarybuffer.Amount;
                RunBal := FnPostSalaryToFosa(salarybuffer, RunBal);
                RunBal := FnRecoverStatutories(salarybuffer, RunBal);
                RunBal := FnRecoverMobileLoanInterest(salarybuffer, RunBal);
                RunBal := FnRunInterest(salarybuffer, RunBal);
                //RunBal:=FnRecoverMobileLoanPrincipal(salarybuffer,RunBal);
                RunBal := FnRunPrinciple(salarybuffer, RunBal);
            //        FnRunStandingOrders(salarybuffer,RunBal);

            until salarybuffer.Next = 0;
        end;
        //Balancing Journal Entry
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
        Rec."Account Type", Rec."Account No", Rec."Posting date", Rec.Amount, 'FOSA', EXTERNAL_DOC_NO, DOCUMENT_NO, '');
        Message('Salary journals Successfully Generated. BATCH NO=SALARIES.');
        Window.Close;
    end;

    local procedure FnNISProcessing()
    begin
        BATCH_TEMPLATE := 'GENERAL';
        BATCH_NAME := 'SALARIES';
        DOCUMENT_NO := Rec."Document No";
        EXTERNAL_DOC_NO := "Cheque No.";
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
        GenJournalLine.DeleteAll;
        ObjGenSetup.Get();
        salarybuffer.Reset;
        salarybuffer.SetRange("Salary Header No.", Rec.No);
        //salarybuffer.SETRANGE("Account No.",'2747-01616-06');
        if salarybuffer.Find('-') then begin
            Window.Open(Format(Rec."Transaction Type") + ': @1@@@@@@@@@@@@@@@' + 'Record:#2###############');
            TotalCount := salarybuffer.Count;
            repeat
                Percentage := (ROUND(Counter / TotalCount * 10000, 1));
                Counter := Counter + 1;
                Window.Update(1, Percentage);
                Window.Update(2, Counter);

                RunBal := salarybuffer.Amount;
                RunBal := FnPostSalaryToFosa(salarybuffer, RunBal);
                RunBal := FnRecoverStatutories(salarybuffer, RunBal);
            until salarybuffer.Next = 0;
        end;
        //Balancing Journal Entry
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
        Rec."Account Type", Rec."Account No", Rec."Posting date", Rec.Amount, 'FOSA', EXTERNAL_DOC_NO, DOCUMENT_NO, '');
        Message('NIS journals Successfully Generated. BATCH NO=SALARIES.');
        Window.Close;
    end;
}

