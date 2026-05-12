#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
codeunit 51018 "SwizzsoftAutomation"
{

    trigger OnRun()
    begin
        //MESSAGE('%1',FnRunAutorecovery('L01001022368','','022368'));// L01001005356
        //FnUpdatePrincipleDue();
        //FnRunPrinciple();
        //FnRunChargeStatement();
        //FnRecoverOverDraft('L01001022371');
        //FnBackOfficeFeeRecovery('','','');
    end;

    var
        objVendor: Record Vendor;
        objTransactions: Record Transactions;
        //RptAutorecovery: Report "Loans AutoRecovery";
        Gnljnline: Record "Gen. Journal Line";
        objTaskSchedule: Record "Sure Task Schedule";
        ChargeStatement: Boolean;
        NextTaskDate: Date;
        genstup: Record "Sacco General Set-Up";
        RunBal: Decimal;
        ObjVendors: Record Vendor;
        ObjLoanRegister: Record "Loans Register";
        LoanApp: Record "Loans Register";
        LineN: Integer;
        DocumentNo: Code[100];
        ObjMembers: Record Customer;
        ObjLoans: Record "Loans Register";
        SFactory: Codeunit "Swizzsoft Factory";
        BATCH_TEMPLATE: Code[100];
        BATCH_NAME: Code[100];
        DOCUMENT_NO: Code[100];
        VendorBalance: Decimal;
        DeductedPrincipal: Boolean;
        ObjOverdraftRegister: Record "Over Draft Register";

    //.......................New Automation
    procedure GetVendorAccounts() response: Text
    var
        Vendor: Record Vendor;
    begin
        Vendor.Reset();
        Vendor.SetFilter(Vendor."Company Code", '<>%1', 'MMHSACCO');
        Vendor.SetRange(Vendor."Account Type", 'ORDINARY');
        if Vendor.Find('-') = false then begin
            response := 'No vendor accounts found for this number.';
        end else begin
            repeat
                response := response + Vendor."No." + '|' + Vendor."Company Code" + '|' + Vendor."BOSA Account No" + ';';
            until Vendor.Next = 0;
        end;
    end;

    procedure GetStandingOrders() response: Text
    var
        StandingOrders: Record "Standing Orders";
    begin
        StandingOrders.Reset();
        StandingOrders.SetRange(StandingOrders.Status, StandingOrders.Status::Approved);
        if StandingOrders.Find('-') then begin
            repeat
                response := response + StandingOrders."No." + '|' + StandingOrders."Source Account No." + ';';
            until StandingOrders.Next = 0;
        end else begin
            response := 'No standing orders found';
        end;
    end;
    //.....................................
    procedure FnRunStandingOrders(VendorNumber: Code[100])
    begin

        objVendor.Reset;
        objVendor.SetRange(objVendor."No.", VendorNumber);
        if objVendor.Find('-') then begin
            Report.Run(50272, false, false, objVendor);
        end
    end;


    procedure FnRunAutorecovery(VendorNumber: Code[100]; CompanyCode: Code[100]; BosaNo: Code[100]) FinishedRunning: Boolean
    var
        Employer: Code[100];
        ObjTempLoans: Record "Temp Loans Balances";
    begin
        genstup.Get();
        BATCH_TEMPLATE := 'GENERAL';
        BATCH_NAME := 'ARECOVERY';
        DOCUMENT_NO := 'RCV' + Format(Today);

        Gnljnline.Reset;
        Gnljnline.SetRange(Gnljnline."Journal Template Name", BATCH_TEMPLATE);
        Gnljnline.SetRange(Gnljnline."Journal Batch Name", BATCH_NAME);
        Gnljnline.DeleteAll;
        VendorBalance := FnGetFosaAccountBalance(VendorNumber);
        DeductedPrincipal := false;
        RunBal := 0;
        RunBal := VendorBalance;
        //RunBal := FnRecoverOverDraft(VendorNumber, RunBal);
        RunBal := FnBackOfficeFeeRecovery(BosaNo, VendorNumber, RunBal);
        if (VendorBalance > 0)
        //AND (CompanyCode<>'MMHSACCO')  AND (CompanyCode<>'ZOE KENYA'))
        then begin
            RunBal := FnRunInterest(BosaNo, RunBal);
            RunBal := FnRunPrinciple(BosaNo, RunBal);
        end;
        Gnljnline.Reset;
        Gnljnline.SetRange("Journal Template Name", BATCH_TEMPLATE);
        Gnljnline.SetRange("Journal Batch Name", BATCH_NAME);
        if Gnljnline.Find('-') then begin
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Batch", Gnljnline);
        end;


        exit(DeductedPrincipal);
    end;


    procedure FnRunChargeStatement(): Text
    var
        ChargeStatementResult: Text;
    begin

        //This bit is just for testing
        objTaskSchedule.Reset;
        objTaskSchedule.SetRange(objTaskSchedule.Task, 0);
        if objTaskSchedule.Find('-') then
            //Testing

            if FnChargeStatementScheduler(objTaskSchedule.Task::StatementCharge) = true then begin
                objVendor.Reset;
                if objVendor.Find('-') then begin
                    //Report.Run(50313,FALSE,FALSE,objVendor);
                    //ChargeStatementResult:='Charge Statement Successfully run. Next Statement Charge scheduled for '+FORMAT(NextTaskDate);
                end
            end
            else
                //ChargeStatementResult:='Cannot Run Report Now. Next Statement Charge scheduled for '+FORMAT(NextTaskDate);
                // MESSAGE(ChargeStatementResult);
                exit(ChargeStatementResult);
    end;

    local procedure FnChargeStatementScheduler(Task: Option): Boolean
    var
        FutureDate: Date;
        DateExpression: Text[100];
        ValMonth: Integer;
        ValYear: Integer;
        ValDay: Integer;
    begin
        ChargeStatement := false;
        objTaskSchedule.Reset;
        objTaskSchedule.SetRange(objTaskSchedule.Task, objTaskSchedule.Task::StatementCharge);
        if objTaskSchedule.Find('-') then begin
            NextTaskDate := objTaskSchedule."Next Task Date";
            if objTaskSchedule."Next Task Date" = Today then begin
                DateExpression := '<CD+' + Format(objTaskSchedule.frequency) + '>';
                FutureDate := CalcDate(DateExpression, objTaskSchedule."Next Task Date");
                ValDay := Date2dmy(FutureDate, 1);
                ValMonth := Date2dmy(FutureDate, 2);
                ValYear := Date2dmy(FutureDate, 3);
                NextTaskDate := Dmy2date(ValDay, ValMonth, ValYear);
                objTaskSchedule."Next Task Date" := NextTaskDate;
                objTaskSchedule.Modify;
                ChargeStatement := true;
            end
        end;
        exit(ChargeStatement);
    end;

    local procedure FnRunInterest(BNumber: Code[100]; RunningBalance: Decimal) NewRunningBalance: Decimal
    var
        AmountToDeduct: Decimal;
    begin
        if RunningBalance > 0 then begin
            LoanApp.LockTable;
            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            // LoanApp.SetRange(LoanApp."Recovery Mode", LoanApp."recovery mode"::"Direct Debits");
            LoanApp.SetRange(LoanApp."Client Code", BNumber);
            if LoanApp.Find('-') then begin
                repeat
                    LoanApp.CalcFields(LoanApp."Oustanding Interest");
                    IF (LoanApp."Loan Product Type" <> 'OKOA') and (LoanApp."Loan Product Type" <> 'OVERDRAFT') and (LoanApp.Source <> LoanApp.Source::MICRO) then begin
                        LoanApp.CalcFields(LoanApp."Oustanding Interest");
                        if LoanApp."Oustanding Interest" > 0 then begin
                            if RunningBalance > 0 then begin
                                AmountToDeduct := 0;
                                AmountToDeduct := ROUND(LoanApp."Oustanding Interest", 0.05, '>');
                                if RunningBalance <= AmountToDeduct then
                                    AmountToDeduct := RunningBalance;
                                //---------------------DEBIT FOSA-------------------------------------------------
                                LineN := LineN + 10000;
                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineN, Gnljnline."transaction type"::" ",
                                Gnljnline."account type"::Vendor, LoanApp."Account No", Today, AmountToDeduct, 'FOSA', LoanApp."Loan  No.",
                                LoanApp."Loan Product Type" + '-Interest Paid', '');
                                //----------------------CREDIT LOAN INTEREST--------------------------------------
                                LineN := LineN + 10000;
                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineN, Gnljnline."transaction type"::"Interest Paid",
                                Gnljnline."account type"::Customer, LoanApp."Client Code", Today, AmountToDeduct * -1, Format(LoanApp.Source), LoanApp."Loan  No.",
                                LoanApp."Loan Product Type" + '-Interest Paid', LoanApp."Loan  No.");
                                RunningBalance := RunningBalance - Abs(AmountToDeduct);
                            end;
                        end;
                    end else
                        IF (LoanApp."Loan Product Type" = 'OKOA') OR (LoanApp."Loan Product Type" = 'OVERDRAFT') then begin
                            //...............Check Interest Arrears
                            LoanApp.CalcFields(LoanApp."Oustanding Interest");
                            if LoanApp."Oustanding Interest" > 0 then begin
                                if RunningBalance > 0 then begin
                                    AmountToDeduct := 0;
                                    AmountToDeduct := ROUND(FnArrearsAmount(LoanApp."Loan  No.", LoanApp."Oustanding Interest", LoanApp."Client Code"), 0.05, '>');
                                    if RunningBalance <= AmountToDeduct then
                                        AmountToDeduct := RunningBalance;
                                    //---------------------DEBIT FOSA-------------------------------------------------
                                    LineN := LineN + 10000;
                                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineN, Gnljnline."transaction type"::" ",
                                    Gnljnline."account type"::Vendor, LoanApp."Account No", Today, AmountToDeduct, 'FOSA', LoanApp."Loan  No.",
                                    LoanApp."Loan Product Type" + '-Interest Paid', '');
                                    //----------------------CREDIT LOAN INTEREST--------------------------------------
                                    LineN := LineN + 10000;
                                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineN, Gnljnline."transaction type"::"Interest Paid",
                                    Gnljnline."account type"::Customer, LoanApp."Client Code", Today, AmountToDeduct * -1, Format(LoanApp.Source), LoanApp."Loan  No.",
                                    LoanApp."Loan Product Type" + '-Interest Paid', LoanApp."Loan  No.");
                                    RunningBalance := RunningBalance - Abs(AmountToDeduct);
                                end;
                            end;

                        end else
                            if LoanApp.Source = LoanApp.Source::MICRO then begin
                                if (LoanApp."Loan Disbursement Date" <> 0D) AND (LoanApp."Loan Disbursement Date" >= 20230807D) then begin
                                    if LoanApp."Oustanding Interest" > 0 then begin
                                        if RunningBalance > 0 then begin
                                            AmountToDeduct := 0;
                                            AmountToDeduct := ROUND(FnArrearsAmount(LoanApp."Loan  No.", LoanApp."Oustanding Interest", LoanApp."Client Code"), 0.05, '>');
                                            if RunningBalance <= AmountToDeduct then
                                                AmountToDeduct := RunningBalance;
                                            //---------------------DEBIT FOSA-------------------------------------------------
                                            LineN := LineN + 10000;
                                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineN, Gnljnline."transaction type"::" ",
                                            Gnljnline."account type"::Vendor, LoanApp."Account No", Today, AmountToDeduct, 'FOSA', LoanApp."Loan  No.",
                                            LoanApp."Loan Product Type" + '-Interest Paid', '');
                                            //----------------------CREDIT LOAN INTEREST--------------------------------------
                                            LineN := LineN + 10000;
                                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineN, Gnljnline."transaction type"::"Interest Paid",
                                            Gnljnline."account type"::Customer, LoanApp."Client Code", Today, AmountToDeduct * -1, Format(LoanApp.Source), LoanApp."Loan  No.",
                                            LoanApp."Loan Product Type" + '-Interest Paid', LoanApp."Loan  No.");
                                            RunningBalance := RunningBalance - Abs(AmountToDeduct);
                                        end;
                                    end;
                                end;
                                //  else begin
                                //     ///Old Loans
                                // end;
                            end;
                until LoanApp.Next = 0;
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnRunPrinciple(BNumber: Code[100]; RunningBalance: Decimal) NewRunningBalance: Decimal
    var
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        AmountToDeduct: Decimal;
        WhatISaved: Decimal;
        PrincipleDue: Decimal;
    begin

        if RunningBalance > 0 then begin
            varTotalRepay := 0;
            varMultipleLoan := 0;
            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            LoanApp.SetRange(LoanApp."Client Code", BNumber);
            LoanApp.SetRange(LoanApp."Recovery Mode", LoanApp."recovery mode"::Checkoff);
            LoanApp.SetFilter(LoanApp."Repayment Start Date", '<=%1', Today); //Repayment Must have Started!!
            if LoanApp.Find('-') then begin
                repeat
                    if RunningBalance > 0 then begin
                        PrincipleDue := SFactory.FnGetPrincipalDueFiltered(LoanApp, '..' + Format(Today));
                        if PrincipleDue > 0 then begin
                            AmountToDeduct := PrincipleDue;
                            if PrincipleDue > RunningBalance then
                                AmountToDeduct := RunningBalance;
                            //---------------------DEBIT FOSA-------------------------------------------------
                            LineN := LineN + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineN, Gnljnline."transaction type"::" ",
                            Gnljnline."account type"::Vendor, LoanApp."Account No", Today, AmountToDeduct, 'FOSA', LoanApp."Loan  No.",
                            LoanApp."Loan Product Type" + '-Loan Repayment', '');
                            //----------------------CREDIT LOAN REPAYMENT--------------------------------------
                            LineN := LineN + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineN, Gnljnline."transaction type"::"Loan Repayment",
                            Gnljnline."account type"::Customer, LoanApp."Client Code", Today, AmountToDeduct * -1, Format(LoanApp.Source), LoanApp."Loan  No.",
                            LoanApp."Loan Product Type" + '-Loan Repayment', LoanApp."Loan  No.");
                            DeductedPrincipal := true;
                            RunningBalance := RunningBalance - AmountToDeduct;
                        end;
                    end;
                until LoanApp.Next = 0;
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnGetMemberBranch(MemberNo: Code[50]): Code[100]
    var
        MemberBranch: Code[100];
    begin
        ObjMembers.Reset;
        ObjMembers.SetRange(ObjMembers."No.", MemberNo);
        if ObjMembers.Find('-') then begin
            MemberBranch := ObjMembers."Global Dimension 2 Code";
        end;
        exit(MemberBranch);
    end;


    procedure FnGetFosaAccountBalance(Acc: Code[30]) Bal: Decimal
    var
        ObjVendor: Record Vendor;
    begin
        if ObjVendor.Get(Acc) then begin
            ObjVendor.CalcFields(ObjVendor."Balance (LCY)", ObjVendor."ATM Transactions", ObjVendor."Uncleared Cheques");
            Bal := ObjVendor."Balance (LCY)" - (ObjVendor."ATM Transactions" + FnGetMinimumAllowedBalance(ObjVendor."Account Type") + ObjVendor."Uncleared Cheques");
        end
    end;

    local procedure FnGetMinimumAllowedBalance(ProductCode: Code[60]) MinimumBalance: Decimal
    var
        ObjProducts: Record "Account Types-Saving Products";
    begin
        ObjProducts.Reset;
        ObjProducts.SetRange(ObjProducts.Code, ProductCode);
        if ObjProducts.Find('-') then
            MinimumBalance := ObjProducts."Minimum Balance";
    end;

    local procedure FnRecoverOverDraft("Account No": Code[100]; RunningBalance: Decimal): Decimal
    var
        ObjVendor: Record Vendor;
        ObjOverDraft: Record "Over Draft Register";
        ObjOverDraftSetup: Record "Overdraft Setup";
        AmountToDeduct: Decimal;
        ODNumber: Code[100];
        StartDate: Date;
    begin
        if RunningBalance > 0 then begin
            ODNumber := FnGetApprovedOverDraftNo("Account No");
            ObjOverDraftSetup.Get();
            AmountToDeduct := 0;
            StartDate := FnGetODRecoveryStartDate(ODNumber);
            ObjVendor.Reset;
            ObjVendor.SetRange(ObjVendor."No.", "Account No");
            //MESSAGE('%1 %2',StartDate, ODNumber);
            if ((ObjVendor.Find('-')) and (Today >= StartDate)) then begin
                ObjVendor.CalcFields(ObjVendor."Oustanding Overdraft interest", ObjVendor.Balance, ObjVendor."Outstanding Overdraft");
                if ObjVendor."Outstanding Overdraft" > 0 then begin
                    LineN := LineN + 10000;
                    AmountToDeduct := FnGetMonthlyRepayment("Account No");

                    if ObjVendor."Outstanding Overdraft" <= AmountToDeduct then
                        AmountToDeduct := ObjVendor."Outstanding Overdraft";

                    if RunningBalance <= AmountToDeduct then
                        AmountToDeduct := RunningBalance;

                    SFactory.FnCreateGnlJournalLineBalancedCashier(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineN, Gnljnline."transaction type"::" ", Gnljnline."account type"::Vendor,
                    "Account No", Today, AmountToDeduct, 'FOSA', ODNumber, ODNumber + ' Overdraft Paid', '',
                    Gnljnline."account type"::"G/L Account", ObjOverDraftSetup."Control Account", ODNumber, Gnljnline."overdraft codes"::"Overdraft Paid");
                    RunningBalance := RunningBalance - AmountToDeduct;
                end;
            end;
        end;
        /*
        IF AmountToDeduct:=FnGetMonthlyRepayment("Account No") AND objVendor."Outstanding Overdraft">0 THEN
        BEGIN
        StartDate:=FnGetODRecoveryStartDate(ODNumber)+1M;
        
        END;
        */
        exit(RunningBalance);

    end;

    local procedure FnGetApprovedOverDraftNo(AccNo: Code[100]): Code[100]
    var
        ObjOverdraftRegister: Record "Over Draft Register";
    begin
        ObjOverdraftRegister.Reset;
        ObjOverdraftRegister.SetRange(ObjOverdraftRegister."Account No", AccNo);
        ObjOverdraftRegister.SetRange(ObjOverdraftRegister.Status, ObjOverdraftRegister.Status::Approved);
        ObjOverdraftRegister.SetRange(ObjOverdraftRegister."Overdraft Status", ObjOverdraftRegister."overdraft status"::Active);
        ObjOverdraftRegister.SetRange(ObjOverdraftRegister."Running Overdraft", true);
        ObjOverdraftRegister.SetRange(ObjOverdraftRegister."Recovery Mode", ObjOverdraftRegister."recovery mode"::Direct);
        if ObjOverdraftRegister.FindFirst then
            exit(ObjOverdraftRegister."Over Draft No");
    end;

    local procedure FnGetMonthlyRepayment(AccNo: Code[100]): Decimal
    var
        ObjOverdraftRegister: Record "Over Draft Register";
    begin
        ObjOverdraftRegister.Reset;
        ObjOverdraftRegister.SetRange(ObjOverdraftRegister."Account No", AccNo);
        ObjOverdraftRegister.SetRange(ObjOverdraftRegister.Status, ObjOverdraftRegister.Status::Approved);
        ObjOverdraftRegister.SetRange(ObjOverdraftRegister."Overdraft Status", ObjOverdraftRegister."overdraft status"::Active);
        ObjOverdraftRegister.SetRange(ObjOverdraftRegister."Running Overdraft", true);
        ObjOverdraftRegister.SetRange(ObjOverdraftRegister."Recovery Mode", ObjOverdraftRegister."recovery mode"::Direct);
        if ObjOverdraftRegister.FindFirst then
            exit(ObjOverdraftRegister."Monthly Overdraft Repayment" + ObjOverdraftRegister."Monthly Interest Repayment" + (100 / ObjOverdraftRegister."Overdraft period(Months)"));
    end;

    local procedure FnBackOfficeFeeRecovery(BosaNumber: Code[100]; FosaAccount: Code[100]; RunningBalance: Decimal): Decimal
    var
        ObjMember: Record Customer;
        ObjVendor: Record Vendor;
        AmountToDeduct: Decimal;
    begin
        if RunningBalance > 0 then begin
            genstup.Get();
            AmountToDeduct := 0;
            ObjMember.Reset;
            ObjMember.SetRange(ObjMember."No.", BosaNumber);
            ObjMember.SetFilter(ObjMember."Registration Date", '>=%1', 20180101D); //automate as from 1st Jan 2018
            ObjMember.SetFilter(ObjMember."Date Filter", '..' + Format(Today));
            if ObjMember.Find('-') then begin
                ObjMember.CalcFields(ObjMember."Registration Fee Paid", ObjMember."Current Shares");
                if ObjMember."Current Shares" > 0 then begin
                    if ObjMember."Registration Fee Paid" <= genstup."Registration Fee" then
                        AmountToDeduct := genstup."Registration Fee" - ObjMember."Registration Fee Paid";
                    if RunningBalance < AmountToDeduct then
                        AmountToDeduct := RunningBalance;
                    //----------------------------------1.CREDIT MEMBER----------------------------------------------
                    LineN := LineN + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineN, Gnljnline."transaction type"::"Registration Fee", Gnljnline."account type"::Customer,
                    BosaNumber, Today, AmountToDeduct * -1, 'BOSA', '', 'Bosa Registration ', '');

                    //----------------------------------2.DEBIT VENDOR----------------------------------------------
                    LineN := LineN + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineN, Gnljnline."transaction type"::" ", Gnljnline."account type"::Vendor,
                    FosaAccount, Today, AmountToDeduct, 'FOSA', '', 'Bosa Registration ', '');

                end;

            end;

        end;
        exit(RunningBalance);

    end;

    local procedure FnGetODRecoveryStartDate(ODNumber: Code[100]): Date
    begin
        ObjOverdraftRegister.Reset;
        ObjOverdraftRegister.SetRange("Over Draft No", ODNumber);
        if ObjOverdraftRegister.Find('-') then
            exit(ObjOverdraftRegister."Overdraft Repayment Start Date");
    end;

    local procedure FnArrearsAmount(LoanNo: Code[30]; OustandingInterest: Decimal; ClientCode: Code[50]): Decimal
    var
        RepaymentSchedule: Record "Loan Repayment Schedule";
        ExpectedInt: Decimal;
        custledgerentry: Record "Cust. Ledger Entry";
        PaidInt: Decimal;
        IntArrears: Decimal;
    begin
        ExpectedInt := 0;
        PaidInt := 0;
        IntArrears := 0;
        RepaymentSchedule.Reset();
        RepaymentSchedule.SetRange(RepaymentSchedule."Loan No.", LoanNo);
        RepaymentSchedule.SetFilter(RepaymentSchedule."Repayment Date", '%1..%2', 0D, Today);
        IF RepaymentSchedule.Find('-') THEN begin
            repeat
                ExpectedInt += RepaymentSchedule."Monthly Interest";
            until RepaymentSchedule.Next = 0;
        end;
        //.................................................................
        custledgerentry.Reset();
        custledgerentry.SetRange(custledgerentry."Customer No.", ClientCode);
        custledgerentry.SetRange(custledgerentry.Reversed, false);
        custledgerentry.SetRange(custledgerentry."Transaction Type", custledgerentry."Transaction Type"::"Interest Paid");
        if custledgerentry.find('-') then begin
            repeat
                PaidInt += (custledgerentry."Amount Posted") * -1;
            until custledgerentry.Next = 0;
        end;
        IntArrears := ExpectedInt - PaidInt;
        if IntArrears < 0 then
            IntArrears := 0;
        exit(IntArrears);
    end;
}

