#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 56175 "Bosa Receipts H Card-Checkoff."
{

    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "ReceiptsProcessing_H-Checkoff";
    SourceTableView = where(Posted = const(false));

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
                    Enabled = false;
                }
                field("Date Entered"; Rec."Date Entered")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Posting date"; Rec."Posting date")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Loan CutOff Date"; Rec."Loan CutOff Date")
                {
                    ApplicationArea = Basic;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic;
                }
                field("Total Count"; Rec."Total Count")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = Basic;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Account No"; Rec."Account No")
                {

                    ApplicationArea = Basic;
                }
                field("Employer Code"; Rec."Employer Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Employer Name"; Rec."Employer Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = Basic;
                }

                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Scheduled Amount"; Rec."Scheduled Amount")
                {
                    ApplicationArea = Basic;
                }
            }
            part("Bosa receipt lines"; "Bosa Receipt line-Checkoff")
            {
                SubPageLink = "Receipt Header No" = field(No);
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("<XMLport Import receipts>")
            {
                ApplicationArea = Basic;
                Caption = 'Import Checkoff';
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = XMLport "Import Checkoff Block";
            }
            group(ActionGroup1102755021)
            {
            }
            action("Validate Receipts")
            {
                ApplicationArea = Basic;
                Caption = 'Validate Receipts';
                Image = ValidateEmailLoggingSetup;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin


                    RcptBufLines.Reset;
                    RcptBufLines.SetRange(RcptBufLines."Receipt Header No", Rec.No);
                    if RcptBufLines.Find('-') then begin
                        repeat

                            Memb.Reset;
                            Memb.SetRange(Memb."No.", RcptBufLines."Staff/Payroll No");
                            //Memb.SETRANGE(Memb."Employer Code",RcptBufLines."Employer Code");
                            if Memb.Find('-') then begin

                                RcptBufLines."Member No" := Memb."No.";
                                RcptBufLines.Name := Memb.Name;
                                RcptBufLines."ID No." := Memb."ID No.";
                                // RcptBufLines."FOSA Account" := Memb."FOSA Account";

                                // Vendor.Reset;
                                // Vendor.SetRange(Vendor."Staff No", Memb."Payroll/Staff No");
                                // Vendor.SetRange(Vendor."Account Type", 'CHRISTMAS');
                                // if Vendor.Find('-') then begin

                                //     RcptBufLines."Xmas Account" := Vendor."No.";

                                //     RcptBufLines."Xmas Contribution" := Vendor."Monthly Contribution";
                                //     RcptBufLines.Modify;
                                // end;





                                RcptBufLines."Member Found" := true;
                                RcptBufLines.Modify;
                            end;
                        until RcptBufLines.Next = 0;
                    end;
                    Message('Successfully validated');
                end;
            }
            group(ActionGroup1102755019)
            {
            }
            action("Post check off")
            {
                ApplicationArea = Basic;
                Caption = 'Post check off';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    UsersID: Record User;
                    FundsUSer: Record "Funds User Setup";
                    GenJnlManagement: Codeunit GenJnlManagement;
                    GenBatch: Record "Gen. Journal Batch";
                begin

                    genstup.Get();
                    if Rec.Posted = true then
                        Error('This Check Off has already been posted');
                    if Rec."Account No" = '' then
                        Error('You must specify the Account No.');
                    if Rec."Document No" = '' then
                        Error('You must specify the Document No.');
                    if Rec."Posting date" = 0D then
                        Error('You must specify the Posting date.');
                    if Rec."Posting date" = 0D then
                        Error('You must specify the Posting date.');
                    if Rec."Loan CutOff Date" = 0D then
                        Error('You must specify the Loan CutOff Date.');
                    Datefilter := '..' + Format(Rec."Loan CutOff Date");
                    IssueDate := Rec."Loan CutOff Date";
                    //General Journals
                    // if FundsUSer.Get(UserId) then begin
                    Jtemplate := 'GENERAL';
                    Jbatch := 'CHECKOFF';
                    // end;
                    //Delete journal
                    Gnljnline.Reset;
                    Gnljnline.SetRange("Journal Template Name", Jtemplate);
                    Gnljnline.SetRange("Journal Batch Name", Jbatch);
                    if Gnljnline.Find('-') then begin
                        Gnljnline.DeleteAll;
                    end;

                    RunBal := 0;
                    TotalWelfareAmount := 0;
                    Rec.CalcFields("Scheduled Amount");
                    if Rec."Scheduled Amount" <> Rec.Amount then begin
                        ERROR('Scheduled Amount Is Not Equal To Cheque Amount');
                    end;

                    Rec.CalcFields("Scheduled Amount");
                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := Jtemplate;
                    Gnljnline."Journal Batch Name" := Jbatch;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Rec."Account Type";
                    Gnljnline."Account No." := Rec."Account No";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := Rec."Document No";
                    Gnljnline."Posting Date" := Rec."Posting date";
                    Gnljnline.Description := 'CHECKOFF ' + Rec.Remarks;
                    Gnljnline.Amount := Rec."Scheduled Amount";
                    Gnljnline.Validate(Gnljnline.Amount);
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    Gnljnline."Shortcut Dimension 2 Code" := 'NAIROBI';
                    Gnljnline.Validate(Gnljnline."Shortcut Dimension 1 Code");
                    Gnljnline.Validate(Gnljnline."Shortcut Dimension 2 Code");
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert(true);
                    //End Of control


                    RcptBufLines.Reset;
                    RcptBufLines.SetRange(RcptBufLines."Receipt Header No", Rec.No);
                    RcptBufLines.SetRange(RcptBufLines.Posted, false);
                    if RcptBufLines.Find('-') then begin
                        repeat
                            RunBal := 0;
                            RunBal := RcptBufLines.Amount;
                            RunBal := FnRunInterest(RcptBufLines, RunBal, Rec."Loan CutOff Date");
                            RunBal := FnRunPrinciple(RcptBufLines, RunBal, Rec."Loan CutOff Date");
                            RunBal := FnRunEntranceFee(RcptBufLines, RunBal);
                            RunBal := FnRunShareCapital(RcptBufLines, RunBal);
                            RunBal := FnRunDepositContribution(RcptBufLines, RunBal);
                            RunBal := FnRunHolidayContribution(RcptBufLines, RunBal);
                            RunBal := FnRunAlphaContribution(RcptBufLines, RunBal);
                            RunBal := FnRunHousingContribution(RcptBufLines, RunBal);
                            RunBal := FnRunjunioroneContribution(RcptBufLines, RunBal);
                            RunBal := FnRunjuniortwoContribution(RcptBufLines, RunBal);
                            RunBal := FnRunjuniorThreeContribution(RcptBufLines, RunBal);
                            //  RunBal := FnRecoverPrincipleFromExcess(RcptBufLines, RunBal);
                            FnTransferExcessToUnallocatedFunds(RcptBufLines, RunBal);
                        until RcptBufLines.Next = 0;
                    end;

                    //Post control

                    Message('CheckOff Successfully Generated');


                    Gnljnline.Reset;
                    Gnljnline.SetRange("Journal Template Name", Jtemplate);
                    Gnljnline.SetRange("Journal Batch Name", Jbatch);
                    if Gnljnline.Find('-') then
                        Page.Run(page::"General Journal", Gnljnline);


                    // Gnljnline.SetRange("Journal Template Name", Jtemplate);
                    // Gnljnline.SetRange("Journal Batch Name", Jbatch);
                    // if Gnljnline.Find('-') then
                    // GenJnlManagement.TemplateSelectionFromBatch(GenBatch);
                    //Post New  //To be Uncommented after thorough tests
                    /*Gnljnline.RESET;
                    Gnljnline.SETRANGE("Journal Template Name",Jtemplate);
                    Gnljnline.SETRANGE("Journal Batch Name",Jbatch);
                    IF Gnljnline.FIND('-') THEN BEGIN
                    CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post",Gnljnline);
                    END;
                    Posted:=True;
                    MODIFY;*/

                    //Posted:=TRUE;

                end;
            }
            action("Processed Checkoff")
            {
                ApplicationArea = Basic;
                Image = POST;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to mark this Checkoff as Processed', false) = true then begin
                        Rec.Posted := true;
                        Rec."Posted By" := UserId;
                        Rec.Modify;
                    end;
                end;
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Posting date" := Today;
        Rec."Date Entered" := Today;
    end;

    var
        Gnljnline: Record "Gen. Journal Line";
        PDate: Date;
        DocNo: Code[20];
        RunBal: Decimal;
        ReceiptsProcessingLines: Record "ReceiptsProcessing_L-Checkoff";
        LineNo: Integer;
        LBatches: Record "Loan Disburesment-Batching";
        Jtemplate: Code[30];
        JBatch: Code[30];
        "Cheque No.": Code[20];
        DActivityBOSA: Code[20];
        DBranchBOSA: Code[20];
        ReptProcHeader: Record "ReceiptsProcessing_H-Checkoff";
        Cust: Record Customer;
        MembPostGroup: Record "Customer Posting Group";
        Loantable: Record "Loans Register";
        LRepayment: Decimal;
        RcptBufLines: Record "ReceiptsProcessing_L-Checkoff";
        LoanType: Record "Loan Products Setup";
        LoanApp: Record "Loans Register";
        Interest: Decimal;
        LineN: Integer;
        TotalRepay: Decimal;
        MultipleLoan: Integer;
        LType: Text;
        MonthlyAmount: Decimal;
        ShRec: Decimal;
        SHARESCAP: Decimal;
        DIFF: Decimal;
        DIFFPAID: Decimal;
        genstup: Record "Sacco General Set-Up";
        Memb: Record Customer;
        INSURANCE: Decimal;
        GenBatches: Record "Gen. Journal Batch";
        Datefilter: Text[50];
        ReceiptLine: Record "ReceiptsProcessing_L-Checkoff";
        XMAS: Decimal;
        MemberRec: Record Customer;
        Vendor: Record Vendor;
        IssueDate: Date;
        startDate: Date;
        TotalWelfareAmount: Decimal;
        LoanRepS: Record "Loan Repayment Schedule";
        MonthlyRepay: Decimal;
        cm: Date;
        mm: Code[10];
        Lschedule: Record "Loan Repayment Schedule";
        ScheduleRepayment: Decimal;

    local procedure FnRunInterest(ObjRcptBuffer: Record "ReceiptsProcessing_L-Checkoff"; RunningBalance: Decimal; LoanCutoffDate: Date): Decimal
    var
        AmountToDeduct: Decimal;
        InterestToRecover: Decimal;
    begin
        if RunningBalance > 0 then begin
            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No");
            LoanApp.SetRange(LoanApp."Client Code", ObjRcptBuffer."Member No");
            LoanApp.SetRange(LoanApp."Recovery Mode", LoanApp."recovery mode"::Checkoff);
            //LoanApp.SETFILTER(LoanApp."Date filter",Datefilter); //Deduct all interest outstanding regardless of date
            //LoanApp.SETRANGE(LoanApp."Issued Date",startDate,IssueDate);
            if LoanApp.FindSet() then begin
                repeat
                    LoanApp.CalcFields(LoanApp."Oustanding Interest");
                    if (LoanApp."Oustanding Interest" > 0) and (LoanApp."Issued Date" <= LoanCutoffDate) then begin
                        if RunningBalance > 0 then //300
                          begin
                            AmountToDeduct := 0;
                            InterestToRecover := (LoanApp."Oustanding Interest");//100
                            if RunningBalance >= InterestToRecover then
                                AmountToDeduct := InterestToRecover
                            else
                                AmountToDeduct := RunningBalance;

                            LineN := LineN + 10000;
                            Gnljnline.Init;
                            Gnljnline."Journal Template Name" := Jtemplate;
                            Gnljnline."Journal Batch Name" := Jbatch;
                            Gnljnline."Line No." := LineN;
                            Gnljnline."Account Type" := Gnljnline."bal. account type"::Customer;
                            Gnljnline."Account No." := LoanApp."Client Code";
                            Gnljnline.Validate(Gnljnline."Account No.");
                            Gnljnline."Document No." := Rec."Document No";
                            Gnljnline."Posting Date" := Rec."Posting date";
                            Gnljnline.Description := LoanApp."Loan Product Type" + '-Loan Interest Paid ';
                            Gnljnline.Amount := -1 * AmountToDeduct;
                            Gnljnline.Validate(Gnljnline.Amount);
                            Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Interest Paid";
                            Gnljnline."Loan No" := LoanApp."Loan  No.";

                            Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                            Gnljnline."Shortcut Dimension 2 Code" := FnGetMemberBranch(LoanApp."Client Code");
                            Gnljnline.Validate(Gnljnline."Shortcut Dimension 1 Code");
                            Gnljnline.Validate(Gnljnline."Shortcut Dimension 2 Code");
                            if Gnljnline.Amount <> 0 then
                                Gnljnline.Insert;
                            RunningBalance := RunningBalance - Abs(Gnljnline.Amount);
                        end;
                    end;
                until LoanApp.Next = 0;
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnRunPrinciple(ObjRcptBuffer: Record "ReceiptsProcessing_L-Checkoff"; RunningBalance: Decimal; LoanCutoffDate: Date): Decimal
    var
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        AmountToDeduct: Decimal;
        NewOutstandingBal: Decimal;
    begin

        if RunningBalance > 0 then begin
            varTotalRepay := 0;
            varMultipleLoan := 0;
            MonthlyRepay := 0;
            ScheduleRepayment := 0;

            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No");
            LoanApp.SetRange(LoanApp."Client Code", ObjRcptBuffer."Member No");
            LoanApp.SetRange(LoanApp."Recovery Mode", LoanApp."recovery mode"::Checkoff);
            //LoanApp.SETRANGE(LoanApp."Issued Date",startDate,IssueDate);
            if LoanApp.Findset then begin

                repeat
                    if RunningBalance > 0 then begin
                        LoanApp.CalcFields(LoanApp."Outstanding Balance", LoanApp."Oustanding Interest");
                        if (LoanApp."Outstanding Balance" > 0) then begin
                            if (LoanApp."Issued Date" <= LoanCutoffDate) then begin

                                if LoanApp."Oustanding Interest" >= 0 then begin
                                    AmountToDeduct := RunningBalance;
                                    NewOutstandingBal := LoanApp."Outstanding Balance" - RunningBalance;
                                    if AmountToDeduct >= (LoanApp.Repayment - LoanApp."Oustanding Interest") then begin
                                        MonthlyRepay := LoanApp.Repayment - LoanApp."Oustanding Interest";
                                        NewOutstandingBal := LoanApp."Outstanding Balance" - MonthlyRepay;
                                    end else if AmountToDeduct < (LoanApp.Repayment - LoanApp."Oustanding Interest") then begin
                                        MonthlyRepay := AmountToDeduct;
                                        NewOutstandingBal := LoanApp."Outstanding Balance" - MonthlyRepay;
                                    end;
                                end;
                                if MonthlyRepay >= LoanApp."Outstanding Balance" then begin
                                    // AmountToDeduct:=LoanApp."Outstanding Balance";
                                    // NewOutstandingBal:=LoanApp."Outstanding Balance"-AmountToDeduct;
                                    MonthlyRepay := LoanApp."Outstanding Balance";
                                    NewOutstandingBal := LoanApp."Outstanding Balance" - MonthlyRepay;
                                end;


                                //GET SCHEDULE REPYAMENT

                                Lschedule.Reset;
                                Lschedule.SetRange(Lschedule."Loan No.", LoanApp."Loan  No.");
                                //Lschedule.SETRANGE(Lschedule."Repayment Date","Posting date");
                                if Lschedule.FindFirst then begin
                                    LoanApp.CalcFields(LoanApp."Outstanding Balance", LoanApp."Oustanding Interest");
                                    //ScheduleRepayment:=Lschedule."Principal Repayment";
                                    ScheduleRepayment := Lschedule."Monthly Repayment" - LoanApp."Oustanding Interest";
                                    if ScheduleRepayment > LoanApp."Outstanding Balance" then begin
                                        ScheduleRepayment := LoanApp."Outstanding Balance"
                                    end else
                                        ScheduleRepayment := ScheduleRepayment;
                                end;

                                LineN := LineN + 10000;
                                Gnljnline.Init;
                                Gnljnline."Journal Template Name" := Jtemplate;
                                Gnljnline."Journal Batch Name" := Jbatch;
                                Gnljnline."Line No." := LineN;
                                Gnljnline."Account Type" := Gnljnline."bal. account type"::Customer;
                                Gnljnline."Account No." := LoanApp."Client Code";
                                Gnljnline.Validate(Gnljnline."Account No.");
                                Gnljnline."Document No." := Rec."Document No";
                                Gnljnline."Posting Date" := Rec."Posting date";
                                Gnljnline.Description := LoanApp."Loan Product Type" + '-Loan Repayment ';
                                if RunningBalance > ScheduleRepayment then begin
                                    Gnljnline.Amount := ScheduleRepayment * -1//MonthlyRepay*-1;
                                end else
                                    Gnljnline.Amount := RunningBalance * -1;
                                Gnljnline.Validate(Gnljnline.Amount);
                                Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Loan Repayment";
                                Gnljnline."Loan No" := LoanApp."Loan  No.";
                                Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                                Gnljnline."Shortcut Dimension 2 Code" := FnGetMemberBranch(LoanApp."Client Code");
                                Gnljnline.Validate(Gnljnline."Shortcut Dimension 1 Code");
                                Gnljnline.Validate(Gnljnline."Shortcut Dimension 2 Code");
                                if Gnljnline.Amount <> 0 then
                                    Gnljnline.Insert();
                                RunningBalance := RunningBalance - Abs(Gnljnline.Amount);
                            end;
                        end;
                    end;
                until LoanApp.Next = 0;
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnRunEntranceFee(ObjRcptBuffer: Record "ReceiptsProcessing_L-Checkoff"; RunningBalance: Decimal): Decimal
    var
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        ObjMember: Record Customer;
        AmountToDeduct: Decimal;
    begin
        if RunningBalance > 0 then begin
            ObjMember.Reset;
            ObjMember.SetRange(ObjMember."No.", ObjRcptBuffer."Member No");
            ObjMember.SetRange(ObjMember."Payroll/Staff No", ObjRcptBuffer."Staff/Payroll No");
            ObjMember.SetRange(ObjMember."Employer Code", ObjRcptBuffer."Employer Code");
            ObjMember.SetFilter(ObjMember."Registration Date", '>%1', 20230115D); //To Ensure deduction is for New Members Only
            if ObjMember.Find('-') then begin
                repeat
                    ObjMember.CalcFields(ObjMember."Registration Fee Paid");
                    if Abs(ObjMember."Registration Fee Paid") < 500 then begin
                        if ObjMember."Registration Date" <> 0D then begin

                            AmountToDeduct := 0;
                            AmountToDeduct := genstup."Registration Fee" - Abs(ObjMember."Registration Fee Paid");
                            if RunningBalance <= AmountToDeduct then
                                AmountToDeduct := RunningBalance;

                            LineN := LineN + 10000;
                            Gnljnline.Init;
                            Gnljnline."Journal Template Name" := Jtemplate;
                            Gnljnline."Journal Batch Name" := Jbatch;
                            Gnljnline."Line No." := LineN;
                            Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                            Gnljnline."Account No." := RcptBufLines."Member No";
                            Gnljnline.Validate(Gnljnline."Account No.");
                            Gnljnline."Document No." := Rec."Document No";
                            Gnljnline."Posting Date" := Rec."Posting date";
                            Gnljnline.Description := 'Registration Fee ' + Rec.Remarks;
                            Gnljnline.Amount := AmountToDeduct * -1;
                            Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Registration Fee";
                            Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                            Gnljnline."Shortcut Dimension 2 Code" := ObjMember."Global Dimension 2 Code";
                            Gnljnline.Validate(Gnljnline."Shortcut Dimension 1 Code");
                            Gnljnline.Validate(Gnljnline."Shortcut Dimension 2 Code");
                            Gnljnline.Validate(Gnljnline.Amount);
                            if Gnljnline.Amount <> 0 then
                                Gnljnline.Insert;
                            RunningBalance := RunningBalance - Abs(Gnljnline.Amount);
                        end;
                    end;
                until Cust.Next = 0;
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnRunShareCapital(ObjRcptBuffer: Record "ReceiptsProcessing_L-Checkoff"; RunningBalance: Decimal): Decimal
    var
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        ObjMember: Record Customer;
        AmountToDeduct: Decimal;
    begin
        if RunningBalance > 0 then begin
            ObjMember.Reset;
            ObjMember.SetRange(ObjMember."No.", ObjRcptBuffer."Member No");
            // ObjMember.SETRANGE(ObjMember."Employer Code",ObjRcptBuffer."Employer Code");
            ObjMember.SetRange(ObjMember."Customer Type", ObjMember."customer type"::Member);
            if ObjMember.Find('-') then begin
                //REPEAT Deducted once unless otherwise advised
                ObjMember.CalcFields(ObjMember."Shares Retained");
                // if ObjMember."Shares Retained" < genstup."Retained Shares" then begin
                //     SHARESCAP := genstup."Retained Shares";
                DIFF := ObjMember."Monthly ShareCap Cont.";

                if DIFF > 1 then begin
                    if RunningBalance > 0 then begin
                        AmountToDeduct := 0;
                        AmountToDeduct := DIFF;
                        // if DIFF > 500 then
                        //     AmountToDeduct := 500;
                        if RunningBalance <= AmountToDeduct then
                            AmountToDeduct := RunningBalance;

                        LineN := LineN + 10000;
                        Gnljnline.Init;
                        Gnljnline."Journal Template Name" := Jtemplate;
                        Gnljnline."Journal Batch Name" := Jbatch;
                        Gnljnline."Line No." := LineN;
                        Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                        Gnljnline."Account No." := ObjRcptBuffer."Member No";
                        Gnljnline.Validate(Gnljnline."Account No.");
                        Gnljnline."Document No." := Rec."Document No";
                        Gnljnline."Posting Date" := Rec."Posting date";
                        Gnljnline.Description := 'Share Capital';
                        Gnljnline.Amount := AmountToDeduct * -1;
                        Gnljnline.Validate(Gnljnline.Amount);
                        Gnljnline."Transaction Type" := Gnljnline."Transaction Type"::"Share Capital";
                        Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                        Gnljnline."Shortcut Dimension 2 Code" := ObjMember."Global Dimension 2 Code";
                        Gnljnline.Validate(Gnljnline."Shortcut Dimension 1 Code");
                        Gnljnline.Validate(Gnljnline."Shortcut Dimension 2 Code");
                        if Gnljnline.Amount <> 0 then
                            Gnljnline.Insert;
                        RunningBalance := RunningBalance - Abs(Gnljnline.Amount);
                    end;
                end;
                // end;
                //UNTIL RcptBufLines.NEXT=0;
            end;

            exit(RunningBalance);
        end;
    end;

    local procedure FnRunDepositContribution(ObjRcptBuffer: Record "ReceiptsProcessing_L-Checkoff"; RunningBalance: Decimal): Decimal
    var
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        ObjMember: Record Customer;
        AmountToDeduct: Decimal;
    begin
        if RunningBalance > 0 then begin
            ObjMember.Reset;
            ObjMember.SetRange(ObjMember."No.", ObjRcptBuffer."Member No");
            //ObjMember.SETRANGE(ObjMember."Employer Code",ObjRcptBuffer."Employer Code");
            ObjMember.SetRange(ObjMember."Customer Type", ObjMember."customer type"::Member);
            if ObjMember.Find('-') then begin
                AmountToDeduct := 0;
                AmountToDeduct := (ObjMember."Monthly Contribution");
                if RunningBalance <= AmountToDeduct then
                    AmountToDeduct := RunningBalance;

                LineN := LineN + 10000;
                Gnljnline.Init;
                Gnljnline."Journal Template Name" := Jtemplate;
                Gnljnline."Journal Batch Name" := Jbatch;
                Gnljnline."Line No." := LineN;
                Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                Gnljnline."Account No." := ObjRcptBuffer."Member No";
                Gnljnline.Validate(Gnljnline."Account No.");
                Gnljnline."Document No." := Rec."Document No";
                Gnljnline."Posting Date" := Rec."Posting date";
                Gnljnline.Description := 'Deposits Contribution';
                Gnljnline.Amount := AmountToDeduct * -1;
                Gnljnline.Validate(Gnljnline.Amount);
                Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Deposit Contribution";
                Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                Gnljnline."Shortcut Dimension 2 Code" := ObjMember."Global Dimension 2 Code";
                Gnljnline.Validate(Gnljnline."Shortcut Dimension 1 Code");
                Gnljnline.Validate(Gnljnline."Shortcut Dimension 2 Code");
                if Gnljnline.Amount <> 0 then
                    Gnljnline.Insert;
                RunningBalance := RunningBalance - Abs(Gnljnline.Amount * -1);
            end;

            exit(RunningBalance);
        end;
    end;

    local procedure FnRunHolidayContribution(ObjRcptBuffer: Record "ReceiptsProcessing_L-Checkoff"; RunningBalance: Decimal): Decimal
    var
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        ObjMember: Record Customer;
        AmountToDeduct: Decimal;
    begin
        if RunningBalance > 0 then begin
            ObjMember.Reset;
            ObjMember.SetRange(ObjMember."No.", ObjRcptBuffer."Member No");
            //ObjMember.SETRANGE(ObjMember."Employer Code",ObjRcptBuffer."Employer Code");
            ObjMember.SetRange(ObjMember."Customer Type", ObjMember."customer type"::Member);
            if ObjMember.Find('-') then begin
                AmountToDeduct := 0;
                AmountToDeduct := (ObjMember."Likizo Contribution");
                if RunningBalance <= AmountToDeduct then
                    AmountToDeduct := RunningBalance;

                LineN := LineN + 10000;
                Gnljnline.Init;
                Gnljnline."Journal Template Name" := Jtemplate;
                Gnljnline."Journal Batch Name" := Jbatch;
                Gnljnline."Line No." := LineN;
                Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                Gnljnline."Account No." := ObjRcptBuffer."Member No";
                Gnljnline.Validate(Gnljnline."Account No.");
                Gnljnline."Document No." := Rec."Document No";
                Gnljnline."Posting Date" := Rec."Posting date";
                Gnljnline.Description := 'Holiday Savings';
                Gnljnline.Amount := AmountToDeduct * -1;
                Gnljnline.Validate(Gnljnline.Amount);
                Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Holiday Savings";// Holiday_Savers;
                Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                Gnljnline."Shortcut Dimension 2 Code" := ObjMember."Global Dimension 2 Code";
                Gnljnline.Validate(Gnljnline."Shortcut Dimension 1 Code");
                Gnljnline.Validate(Gnljnline."Shortcut Dimension 2 Code");
                if Gnljnline.Amount <> 0 then
                    Gnljnline.Insert;
                RunningBalance := RunningBalance - Abs(Gnljnline.Amount * -1);
            end;

            exit(RunningBalance);
        end;
    end;

    local procedure FnRunHousingContribution(ObjRcptBuffer: Record "ReceiptsProcessing_L-Checkoff"; RunningBalance: Decimal): Decimal
    var
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        ObjMember: Record Customer;
        AmountToDeduct: Decimal;
    begin
        if RunningBalance > 0 then begin
            ObjMember.Reset;
            ObjMember.SetRange(ObjMember."No.", ObjRcptBuffer."Member No");
            //ObjMember.SETRANGE(ObjMember."Employer Code",ObjRcptBuffer."Employer Code");
            ObjMember.SetRange(ObjMember."Customer Type", ObjMember."customer type"::Member);
            if ObjMember.Find('-') then begin
                AmountToDeduct := 0;
                AmountToDeduct := (ObjMember."Likizo Contribution");// "Housing Contribution");
                if RunningBalance <= AmountToDeduct then
                    AmountToDeduct := RunningBalance;

                LineN := LineN + 10000;
                Gnljnline.Init;
                Gnljnline."Journal Template Name" := Jtemplate;
                Gnljnline."Journal Batch Name" := Jbatch;
                Gnljnline."Line No." := LineN;
                Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                Gnljnline."Account No." := ObjRcptBuffer."Member No";
                Gnljnline.Validate(Gnljnline."Account No.");
                Gnljnline."Document No." := Rec."Document No";
                Gnljnline."Posting Date" := Rec."Posting date";
                Gnljnline.Description := 'Housing Contribution';
                Gnljnline.Amount := AmountToDeduct * -1;
                Gnljnline.Validate(Gnljnline.Amount);
                Gnljnline."Transaction Type" := Gnljnline."transaction type"::Investment;
                Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                Gnljnline."Shortcut Dimension 2 Code" := ObjMember."Global Dimension 2 Code";
                Gnljnline.Validate(Gnljnline."Shortcut Dimension 1 Code");
                Gnljnline.Validate(Gnljnline."Shortcut Dimension 2 Code");
                if Gnljnline.Amount <> 0 then
                    Gnljnline.Insert;
                RunningBalance := RunningBalance - Abs(Gnljnline.Amount * -1);
            end;

            exit(RunningBalance);
        end;
    end;

    // local procedure FnRunXmasContribution(ObjRcptBuffer: Record "ReceiptsProcessing_L-Checkoff";RunningBalance: Decimal) :Decimal
    // var
    //     varTotalRepay: Decimal;
    //     varMultipleLoan: Decimal;
    //     varLRepayment: Decimal;
    //     ObjMember: Record Customer;
    //     AmountToDeduct: Decimal;
    // begin
    //     if RunningBalance > 0 then
    //       begin
    //             AmountToDeduct:=0;
    //             AmountToDeduct:=(ObjRcptBuffer."Xmas Contribution");;
    //             if RunningBalance <=AmountToDeduct then
    //             AmountToDeduct:=RunningBalance;

    //             LineN:=LineN+10000;

    //             Gnljnline.Init;
    //             Gnljnline."Journal Template Name":=Jtemplate;
    //             Gnljnline."Journal Batch Name":=Jbatch;
    //             Gnljnline."Line No.":=LineN;
    //             Gnljnline."Account Type":=Gnljnline."account type"::Vendor;
    //             Gnljnline."Account No.":=RcptBufLines."Xmas Account";
    //             Gnljnline.Validate(Gnljnline."Account No.");
    //             Gnljnline."Document No.":="Document No";
    //             Gnljnline."Posting Date":="Posting date";
    //             Gnljnline.Description:='Xmas Contribution';
    //             Gnljnline.Amount:=AmountToDeduct*-1;
    //             Gnljnline.Validate(Gnljnline.Amount);
    //             Gnljnline."Shortcut Dimension 1 Code":='BOSA';
    //             Gnljnline."Shortcut Dimension 2 Code":=FnGetMemberBranch(ObjRcptBuffer."Member No");
    //             Gnljnline.Validate(Gnljnline."Shortcut Dimension 1 Code");
    //             Gnljnline.Validate(Gnljnline."Shortcut Dimension 2 Code");
    //             if Gnljnline.Amount<>0 then
    //             Gnljnline.Insert;
    //             RunningBalance:=RunningBalance-Abs(Gnljnline.Amount);
    //     exit(RunningBalance);
    //     end;
    // end;

    local procedure FnRecoverPrincipleFromExcess(ObjRcptBuffer: Record "ReceiptsProcessing_L-Checkoff"; RunningBalance: Decimal): Decimal
    var
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        ObjTempLoans: Record "Temp Loans Balances";
        AmountToDeduct: Decimal;
    begin
        if RunningBalance > 0 then begin
            varTotalRepay := 0;
            varMultipleLoan := 0;

            ObjTempLoans.Reset;
            ObjTempLoans.SetRange(ObjTempLoans."Loan No", ObjRcptBuffer."Member No");
            if ObjTempLoans.Find('-') then begin
                repeat
                    if RunningBalance > 0 then begin
                        if ObjTempLoans."Outstanding Balance" > 0 then begin
                            AmountToDeduct := RunningBalance;
                            if AmountToDeduct >= ObjTempLoans."Outstanding Balance" then
                                AmountToDeduct := ObjTempLoans."Outstanding Balance";
                            LineN := LineN + 10000;
                            Gnljnline.Init;
                            Gnljnline."Journal Template Name" := Jtemplate;
                            Gnljnline."Journal Batch Name" := Jbatch;
                            Gnljnline."Line No." := LineN;
                            Gnljnline."Account Type" := Gnljnline."bal. account type"::Customer;
                            Gnljnline."Account No." := LoanApp."Client Code";
                            Gnljnline.Validate(Gnljnline."Account No.");
                            Gnljnline."Document No." := Rec."Document No";
                            Gnljnline."Posting Date" := Rec."Posting date";
                            Gnljnline.Description := LoanApp."Loan Product Type" + '-Repayment from excess checkoff'; //TODO Change the Narrative after testing
                            Gnljnline.Amount := AmountToDeduct * -1;
                            Gnljnline.Validate(Gnljnline.Amount);
                            Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Loan Repayment";
                            Gnljnline."Loan No" := LoanApp."Loan  No.";
                            Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                            Gnljnline."Shortcut Dimension 2 Code" := FnGetMemberBranch(ObjTempLoans."Loan No");
                            Gnljnline.Validate(Gnljnline."Shortcut Dimension 1 Code");
                            Gnljnline.Validate(Gnljnline."Shortcut Dimension 2 Code");
                            if Gnljnline.Amount <> 0 then
                                Gnljnline.Insert;
                            RunningBalance := RunningBalance - Abs(Gnljnline.Amount);
                        end;
                    end;
                until ObjTempLoans.Next = 0;
            end;
            exit(RunningBalance);
        end;
    end;



    local procedure FnGetMemberBranch(MemberNo: Code[50]): Code[100]
    var
        MemberBranch: Code[100];
    begin
        Cust.Reset;
        Cust.SetRange(Cust."No.", MemberNo);
        if Cust.Find('-') then begin
            MemberBranch := Cust."Global Dimension 2 Code";
        end;
        exit(MemberBranch);
    end;

    local procedure FnTransferExcessToUnallocatedFunds(ObjRcptBuffer: Record "ReceiptsProcessing_L-Checkoff"; RunningBalance: Decimal)
    var
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        ObjMember: Record Customer;
        AmountToDeduct: Decimal;
        AmountToTransfer: Decimal;
    begin
        if RunningBalance > 0 then begin
            ObjMember.Reset;
            ObjMember.SetRange(ObjMember."No.", ObjRcptBuffer."Member No");
            // ObjMember.SETRANGE(ObjMember."Employer Code",ObjRcptBuffer."Employer Code");
            ObjMember.SetRange(ObjMember."Customer Type", ObjMember."customer type"::Member);
            if ObjMember.Find('-') then begin
                AmountToTransfer := 0;
                AmountToTransfer := RunningBalance;

                LineN := LineN + 10000;
                Gnljnline.Init;
                Gnljnline."Journal Template Name" := Jtemplate;
                Gnljnline."Journal Batch Name" := Jbatch;
                Gnljnline."Line No." := LineN;
                Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                Gnljnline."Account No." := ObjRcptBuffer."Member No";
                Gnljnline.Validate(Gnljnline."Account No.");
                Gnljnline."Document No." := Rec."Document No";
                Gnljnline."Posting Date" := Rec."Posting date";
                Gnljnline.Description := 'Unallocated Funds';
                Gnljnline.Amount := AmountToTransfer * -1;
                Gnljnline.Validate(Gnljnline.Amount);
                Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Unallocated Funds";
                Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                Gnljnline."Shortcut Dimension 2 Code" := ObjMember."Global Dimension 2 Code";
                Gnljnline.Validate(Gnljnline."Shortcut Dimension 1 Code");
                Gnljnline.Validate(Gnljnline."Shortcut Dimension 2 Code");
                if Gnljnline.Amount <> 0 then
                    Gnljnline.Insert;
            end;
        end;
    end;

    local procedure FnRecoverWelfare(ObjRcptBuffer: Record "ReceiptsProcessing_L-Checkoff"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjVendor: Record Vendor;
    begin
        if RunningBalance > 0 then begin
            if Rec."Employer Code" = 'MMHSACCO' then begin
                AmountToDeduct := RunningBalance;
                if RunningBalance >= 200 then
                    AmountToDeduct := 200;
                TotalWelfareAmount := TotalWelfareAmount + AmountToDeduct;
                RunningBalance := RunningBalance - Abs(AmountToDeduct);
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnRunAlphaContribution(ObjRcptBuffer: Record "ReceiptsProcessing_L-Checkoff"; RunningBalance: Decimal): Decimal
    var
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        ObjMember: Record Customer;
        AmountToDeduct: Decimal;
    begin
        if RunningBalance > 0 then begin
            ObjMember.Reset;
            ObjMember.SetRange(ObjMember."No.", ObjRcptBuffer."Member No");
            //ObjMember.SETRANGE(ObjMember."Employer Code",ObjRcptBuffer."Employer Code");
            ObjMember.SetRange(ObjMember."Customer Type", ObjMember."customer type"::Member);
            if ObjMember.Find('-') then begin
                AmountToDeduct := 0;
                AmountToDeduct := (ObjMember."Alpha Savings");
                if RunningBalance <= AmountToDeduct then
                    AmountToDeduct := RunningBalance;

                LineN := LineN + 10000;
                Gnljnline.Init;
                Gnljnline."Journal Template Name" := Jtemplate;
                Gnljnline."Journal Batch Name" := Jbatch;
                Gnljnline."Line No." := LineN;
                Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                Gnljnline."Account No." := ObjRcptBuffer."Member No";
                Gnljnline.Validate(Gnljnline."Account No.");
                Gnljnline."Document No." := Rec."Document No";
                Gnljnline."Posting Date" := Rec."Posting date";
                Gnljnline.Description := 'Alpha Savings';
                Gnljnline.Amount := AmountToDeduct * -1;
                Gnljnline.Validate(Gnljnline.Amount);
                //Gnljnline."Transaction Type" := Gnljnline."transaction type"::Alpha_savings;
                Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                Gnljnline."Shortcut Dimension 2 Code" := ObjMember."Global Dimension 2 Code";
                Gnljnline.Validate(Gnljnline."Shortcut Dimension 1 Code");
                Gnljnline.Validate(Gnljnline."Shortcut Dimension 2 Code");
                if Gnljnline.Amount <> 0 then
                    Gnljnline.Insert;
                RunningBalance := RunningBalance - Abs(Gnljnline.Amount * -1);
            end;

            exit(RunningBalance);
        end;
    end;



    local procedure FnRunjunioroneContribution(ObjRcptBuffer: Record "ReceiptsProcessing_L-Checkoff"; RunningBalance: Decimal): Decimal
    var
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        ObjMember: Record Customer;
        AmountToDeduct: Decimal;
    begin
        if RunningBalance > 0 then begin
            ObjMember.Reset;
            ObjMember.SetRange(ObjMember."No.", ObjRcptBuffer."Member No");
            //ObjMember.SETRANGE(ObjMember."Employer Code",ObjRcptBuffer."Employer Code");
            ObjMember.SetRange(ObjMember."Customer Type", ObjMember."customer type"::Member);
            if ObjMember.Find('-') then begin
                AmountToDeduct := 0;
                AmountToDeduct := (ObjMember."Alpha Savings");
                if RunningBalance <= AmountToDeduct then
                    AmountToDeduct := RunningBalance;

                LineN := LineN + 10000;
                Gnljnline.Init;
                Gnljnline."Journal Template Name" := Jtemplate;
                Gnljnline."Journal Batch Name" := Jbatch;
                Gnljnline."Line No." := LineN;
                Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                Gnljnline."Account No." := ObjRcptBuffer."Member No";
                Gnljnline.Validate(Gnljnline."Account No.");
                Gnljnline."Document No." := Rec."Document No";
                Gnljnline."Posting Date" := Rec."Posting date";
                Gnljnline.Description := 'Junior Savings';
                Gnljnline.Amount := AmountToDeduct * -1;
                Gnljnline.Validate(Gnljnline.Amount);
                //Gnljnline."Transaction Type" := Gnljnline."transaction type"::Alpha_savings;// junior_1;
                Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                Gnljnline."Shortcut Dimension 2 Code" := ObjMember."Global Dimension 2 Code";
                Gnljnline.Validate(Gnljnline."Shortcut Dimension 1 Code");
                Gnljnline.Validate(Gnljnline."Shortcut Dimension 2 Code");
                if Gnljnline.Amount <> 0 then
                    Gnljnline.Insert;
                RunningBalance := RunningBalance - Abs(Gnljnline.Amount * -1);
            end;

            exit(RunningBalance);
        end;
    end;

    local procedure FnRunjuniortwoContribution(ObjRcptBuffer: Record "ReceiptsProcessing_L-Checkoff"; RunningBalance: Decimal): Decimal
    var
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        ObjMember: Record Customer;
        AmountToDeduct: Decimal;
    begin
        if RunningBalance > 0 then begin
            ObjMember.Reset;
            ObjMember.SetRange(ObjMember."No.", ObjRcptBuffer."Member No");
            //ObjMember.SETRANGE(ObjMember."Employer Code",ObjRcptBuffer."Employer Code");
            ObjMember.SetRange(ObjMember."Customer Type", ObjMember."customer type"::Member);
            if ObjMember.Find('-') then begin
                AmountToDeduct := 0;
                AmountToDeduct := (ObjMember."Alpha Savings");
                if RunningBalance <= AmountToDeduct then
                    AmountToDeduct := RunningBalance;

                LineN := LineN + 10000;
                Gnljnline.Init;
                Gnljnline."Journal Template Name" := Jtemplate;
                Gnljnline."Journal Batch Name" := Jbatch;
                Gnljnline."Line No." := LineN;
                Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                Gnljnline."Account No." := ObjRcptBuffer."Member No";
                Gnljnline.Validate(Gnljnline."Account No.");
                Gnljnline."Document No." := Rec."Document No";
                Gnljnline."Posting Date" := Rec."Posting date";
                Gnljnline.Description := 'Junior Savings';
                Gnljnline.Amount := AmountToDeduct * -1;
                Gnljnline.Validate(Gnljnline.Amount);
                // Gnljnline."Transaction Type" := Gnljnline."transaction type"::Alpha_savings;
                Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                Gnljnline."Shortcut Dimension 2 Code" := ObjMember."Global Dimension 2 Code";
                Gnljnline.Validate(Gnljnline."Shortcut Dimension 1 Code");
                Gnljnline.Validate(Gnljnline."Shortcut Dimension 2 Code");
                if Gnljnline.Amount <> 0 then
                    Gnljnline.Insert;
                RunningBalance := RunningBalance - Abs(Gnljnline.Amount * -1);
            end;

            exit(RunningBalance);
        end;
    end;

    local procedure FnRunjuniorThreeContribution(ObjRcptBuffer: Record "ReceiptsProcessing_L-Checkoff"; RunningBalance: Decimal): Decimal
    var
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        ObjMember: Record Customer;
        AmountToDeduct: Decimal;
    begin
        if RunningBalance > 0 then begin
            ObjMember.Reset;
            ObjMember.SetRange(ObjMember."No.", ObjRcptBuffer."Member No");
            //ObjMember.SETRANGE(ObjMember."Employer Code",ObjRcptBuffer."Employer Code");
            ObjMember.SetRange(ObjMember."Customer Type", ObjMember."customer type"::Member);
            if ObjMember.Find('-') then begin
                AmountToDeduct := 0;
                AmountToDeduct := (ObjMember."Alpha Savings");
                if RunningBalance <= AmountToDeduct then
                    AmountToDeduct := RunningBalance;

                LineN := LineN + 10000;
                Gnljnline.Init;
                Gnljnline."Journal Template Name" := Jtemplate;
                Gnljnline."Journal Batch Name" := Jbatch;
                Gnljnline."Line No." := LineN;
                Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                Gnljnline."Account No." := ObjRcptBuffer."Member No";
                Gnljnline.Validate(Gnljnline."Account No.");
                Gnljnline."Document No." := Rec."Document No";
                Gnljnline."Posting Date" := Rec."Posting date";
                Gnljnline.Description := 'Junior Savings one';
                Gnljnline.Amount := AmountToDeduct * -1;
                Gnljnline.Validate(Gnljnline.Amount);
                //   Gnljnline."Transaction Type" := Gnljnline."transaction type"::Alpha_savings;
                Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                Gnljnline."Shortcut Dimension 2 Code" := ObjMember."Global Dimension 2 Code";
                Gnljnline.Validate(Gnljnline."Shortcut Dimension 1 Code");
                Gnljnline.Validate(Gnljnline."Shortcut Dimension 2 Code");
                if Gnljnline.Amount <> 0 then
                    Gnljnline.Insert;
                RunningBalance := RunningBalance - Abs(Gnljnline.Amount * -1);
            end;

            exit(RunningBalance);
        end;
    end;
}

