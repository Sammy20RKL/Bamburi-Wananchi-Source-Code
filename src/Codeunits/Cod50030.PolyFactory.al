#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 50030 "Poly Factory"
{

    trigger OnRun()
    begin

        //*************Get Member Deposits**********************//

        //MESSAGE(FORMAT(KnGetInterestBalanceOneLoan('DLN0380')));
        //MESSAGE(FORMAT(KnGetLoanBalanceOneLoan('BLN00038')));
        //KnGenerateRepaymentSchedule('25828');
        /*ObjLoans.RESET;
        //ObjLoans.SETRANGE("Loan  No.",'1920');
        //ObjLoans.SETFILTER("Date filter",'..'+FORMAT(20181111D));
        ObjLoans.SETRANGE(ObjLoans."Loan Status",ObjLoans."Loan Status"::Issued);
        IF ObjLoans.FINDSET(TRUE) THEN BEGIN
          REPEAT
          //ObjLoans.CALCFIELDS("Scheduled Principal to Date");
          KnGenerateRepaymentSchedule(ObjLoans."Loan  No.");
          UNTIL ObjLoans.NEXT=0;
        END;
        MESSAGE('Completed');
       */

    end;

    var
        MemberLed: Integer;
        TotalGuarantorship: Decimal;
        GenLedgerSetup: Record "General Ledger Setup";
        PostingCode: Codeunit "Gen. Jnl.-Post Line";
        Gnljnline: Record "Gen. Journal Line";
        Jnlinepost: Codeunit "Gen. Jnl.-Post Line";
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        EntryNo: Integer;
        Temp: Record "Funds User Setup";
        Jtemplate: Code[30];
        JBatch: Code[30];
        KentourFactory: Codeunit "Poly Factory";
        ObjLoans: Record 51371;


    procedure KnGetMemberShares(ClientCode: Code[20]) Amount: Decimal
    var
        ObjMembersReg: Record 51364;
    begin
        ObjMembersReg.Reset;
        ObjMembersReg.SetRange(ObjMembersReg."No.", ClientCode);
        if ObjMembersReg.Find('-') then begin
            ObjMembersReg.CalcFields(ObjMembersReg."Current Shares");
            Amount := ObjMembersReg."Current Shares";
        end;
        exit(Amount);


        //*************Get Deposit Multiplier for a loan product**********************//
    end;


    procedure KnGetDividendAmount(ClientCode: Code[20]) Amount: Decimal
    var
        ObjMembersReg: Record 51364;
    begin
        ObjMembersReg.Reset;
        ObjMembersReg.SetRange(ObjMembersReg."No.", ClientCode);
        if ObjMembersReg.Find('-') then begin
            ObjMembersReg.CalcFields(ObjMembersReg."Dividend Amount");
            Amount := ObjMembersReg."Dividend Amount";
        end;
        exit(Amount);


        //*************Get Deposit Multiplier for a loan product**********************//
    end;


    procedure KnGetPaidRejoiningFee(ClientCode: Code[20]) Amount: Decimal
    var
        ObjMembersReg: Record 51364;
    begin
        /*ObjMembersReg.RESET;
        ObjMembersReg.SETRANGE(ObjMembersReg."No.",ClientCode);
        IF ObjMembersReg.FIND ('-') THEN
          BEGIN
            ObjMembersReg.CALCFIELDS(ObjMembersReg."Rejoining Fee");
            Amount:= ObjMembersReg."Rejoining Fee";
            END;
        EXIT(Amount);
        */

        //*************Get Deposit Multiplier for a loan product**********************//

    end;


    procedure KnGetPaidByLaws(ClientCode: Code[20]) Amount: Decimal
    var
        ObjMembersReg: Record 51364;
    begin
        /*ObjMembersReg.RESET;
        ObjMembersReg.SETRANGE(ObjMembersReg."No.",ClientCode);
        IF ObjMembersReg.FIND ('-') THEN
          BEGIN
            ObjMembersReg.CALCFIELDS(ObjMembersReg."By Laws");
            Amount:= ObjMembersReg."By Laws";
            END;
        EXIT(Amount);
        
        */
        //*************Get Deposit Multiplier for a loan product**********************//

    end;


    procedure KnGetDepositMultiplier(LoanProductType: Code[15]) Multiplier: Decimal
    var
        ObjLoanProductType: Record 51381;
    begin
        ObjLoanProductType.Reset;
        ObjLoanProductType.SetRange(ObjLoanProductType.Code, LoanProductType);
        if ObjLoanProductType.Find('-') then begin
            Multiplier := ObjLoanProductType."Shares Multiplier";
        end;
        exit(Multiplier);


        //*************Get percentage used to find the maximum amount a member can guarantee with**********************//
    end;


    procedure KnGetMaxLoanAmount(LoanProductType: Code[15]) Multiplier: Decimal
    var
        ObjLoanProductType: Record 51381;
    begin
        ObjLoanProductType.Reset;
        ObjLoanProductType.SetRange(ObjLoanProductType.Code, LoanProductType);
        if ObjLoanProductType.Find('-') then begin
            Multiplier := ObjLoanProductType."Max. Loan Amount";
        end;
        exit(Multiplier);


        //*************Get percentage used to find the maximum amount a member can guarantee with**********************//
    end;


    procedure KnGetMaximumDepositMultiplier() percentage: Decimal
    var
        ObjSaccoGeneralSetup: Record 51398;
    begin
        /*ObjSaccoGeneralSetup.GET;
        percentage:=ObjSaccoGeneralSetup."Percentage of Maximum Deposits";
        EXIT (percentage);
        
        
        //***************Get the total amount of collateral used***************
        */

    end;


    procedure KnGetCollateralAmount(LoanNo: Code[15]) Amount: Decimal
    var
        ObjCollateralDetails: Record 51374;
    begin
        ObjCollateralDetails.Reset;
        ObjCollateralDetails.SetRange(ObjCollateralDetails."Loan No", LoanNo);
        if ObjCollateralDetails.FindSet then begin
            repeat
                Amount := Amount + ObjCollateralDetails."Guarantee Value";
            until ObjCollateralDetails.Next = 0;
        end;
        exit(Amount);

        //***************Get the total amount Guaranteed for loan appraisal***************//
    end;


    procedure KnGetAmountGuaranteed(LoanNo: Code[15]) Amount: Decimal
    var
        ObjGuaranteeDetails: Record 51372;
    begin
        ObjGuaranteeDetails.Reset;
        ObjGuaranteeDetails.SetRange(ObjGuaranteeDetails."Loan No", LoanNo);
        ObjGuaranteeDetails.SetRange(ObjGuaranteeDetails.Substituted, false);
        if ObjGuaranteeDetails.Find('-') then begin
            //MESSAGE('text %1',LoanNo);
            repeat
                Amount := Amount + ObjGuaranteeDetails."Amont Guaranteed";
            until ObjGuaranteeDetails.Next = 0;
        end;
        exit(Amount);


        //***************Get a members total free shares***************//
    end;


    procedure KnGetOriginalAmountGuaranteed(LoanNo: Code[15]) Amount: Decimal
    var
        ObjGuaranteeDetails: Record 51372;
    begin
        /*ObjGuaranteeDetails.RESET;
        ObjGuaranteeDetails.SETRANGE(ObjGuaranteeDetails."Loan No",LoanNo);
        IF ObjGuaranteeDetails.FIND('-') THEN BEGIN
            //MESSAGE('text %1',LoanNo);
            REPEAT
              Amount:=Amount+ObjGuaranteeDetails."Original Amount Guaranteed";
            UNTIL ObjGuaranteeDetails.NEXT=0;
          END;
          EXIT (Amount);
        
        */
        //***************Get a members total free shares***************//

    end;


    procedure KnGetFreeShares(MemberNo: Code[20]; LoanNo: Code[20]) Amount: Decimal
    var
        ObjMemberRegister: Record 51364;
        ObjGuaranteeDetails: Record 51372;
        TotalCommited: Decimal;
    begin
        ObjMemberRegister.Reset;
        ObjMemberRegister.SetRange(ObjMemberRegister."No.", MemberNo);
        if ObjMemberRegister.Find('-') then begin
            ObjMemberRegister.CalcFields(ObjMemberRegister."Current Shares", ObjMemberRegister."Total Committed Shares");
            if ObjMemberRegister."Total Committed Shares" > 0 then
                TotalCommited := ObjMemberRegister."Total Committed Shares"
            else
                TotalCommited := 0;
            Amount := (ObjMemberRegister."Current Shares" + KnGetSelfAmountGuaranteedLoan(LoanNo)) - TotalCommited;
            if Amount > 0 then
                Amount := Amount
            else
                Amount := 0;
        end;
        exit(Amount);


        //***************find out if certain conditions will be ralaxed in appraisal***************//
    end;


    procedure KnGetIfRelaxed(LoanNo: Code[15]): Boolean
    var
        ObjLoansRegister: Record 51371;
    begin
        /*ObjLoansRegister.RESET;
        ObjLoansRegister.SETRANGE(ObjLoansRegister."Loan  No.",LoanNo);
        IF ObjLoansRegister.FIND('-') THEN
          BEGIN
            IF ObjLoansRegister.Relaxed THEN
              EXIT (TRUE)
            ELSE
              EXIT(FALSE);
          END;
          */
        //***********Get boosted deposits for a member************//

    end;


    procedure KnGetRecommendedAmount(LoanProductType: Code[15]; ClientCode: Code[20]; LoanNo: Code[15]; AppliedAmount: Decimal; Relaxed: Boolean) Amount: Decimal
    var
        MaxEligible: Decimal;
        "EligibleByGuarantor&Collateral": Decimal;
        QualifyingAmount: Decimal;
        LoanBalance: Decimal;
        NotConsolidated: Decimal;
        TotalTopUp: Decimal;
        BoostedAMount: Decimal;
        MemberDeposits: Decimal;
    begin
        LoanBalance := KnGetLoanBalanceLns(ClientCode) - KnGetTotalBrigdedAmount(LoanNo);
        NotConsolidated := LoanBalance - TotalTopUp;
        MemberDeposits := KnGetMemberShares(ClientCode);
        //BoostedAMount:=KnCheckForBoostedAmount(ClientCode);
        if Relaxed then
            BoostedAMount := 0
        else
            BoostedAMount := BoostedAMount;
        if KnCheckIfRecommendedAmountDependOnDeposits(LoanProductType) then
            MaxEligible := KnGetMemberShares(ClientCode)
        else
            MaxEligible := ((KnGetDepositMultiplier(LoanProductType) * (KnGetMemberShares(ClientCode) - BoostedAMount)) - LoanBalance) + BoostedAMount;
        "EligibleByGuarantor&Collateral" := KnGetAmountGuaranteed(LoanNo) + KnGetCollateralAmount(LoanNo);
        if "EligibleByGuarantor&Collateral" > MaxEligible then begin
            QualifyingAmount := MaxEligible;
        end else
            QualifyingAmount := "EligibleByGuarantor&Collateral";

        if QualifyingAmount > AppliedAmount then
            Amount := AppliedAmount
        else
            Amount := QualifyingAmount;

        if LoanProductType = 'D308' then begin
            if (MemberDeposits) < AppliedAmount then
                Amount := MemberDeposits
            else
                Amount := AppliedAmount;
        end;

        exit(Amount);


        //**********get the number of guarantors used to guarantee loan**************//
    end;


    procedure KnGetNoOfGuarantors(LoanNo: Code[15]) No: Integer
    var
        ObjLoanGuaranteeDetails: Record 51372;
    begin
        ObjLoanGuaranteeDetails.Reset;
        ObjLoanGuaranteeDetails.SetRange(ObjLoanGuaranteeDetails."Loan No", LoanNo);
        if ObjLoanGuaranteeDetails.FindSet then begin
            No := ObjLoanGuaranteeDetails.Count;
        end;

        exit(No);


        //*************Get total loan balance for a member*********//
    end;


    procedure KnGetLoanBalance(ClientCode: Code[20]) Amount: Decimal
    var
        ObjLoansRegister: Record 51371;
    begin
        ObjLoansRegister.Reset;
        ObjLoansRegister.SetRange(ObjLoansRegister."Client Code", ClientCode);
        if ObjLoansRegister.FindSet then begin
            repeat
                ObjLoansRegister.CalcFields("Outstanding Balance");
                Amount := Amount + ObjLoansRegister."Outstanding Balance";
            until ObjLoansRegister.Next = 0;
        end;

        exit(Amount);


        //*******calculate a third of a members netpay**********//
    end;


    procedure KnGetAThirdOfNetPay(LoanNo: Code[10]) Amount: Decimal
    var
        ObjLoansRegister: Record 51371;
    begin
        ObjLoansRegister.Reset;
        ObjLoansRegister.SetRange(ObjLoansRegister."Loan  No.", LoanNo);
        if ObjLoansRegister.Find('-') then begin
            Amount := ROUND((ObjLoansRegister."Gross Pay" / 3), 1, '>')
        end;
        exit(Amount);

        //*************get total deductions of member(from salaries)*****//
    end;


    procedure KnGetTotalDeductions(LoanNo: Code[10]) Amount: Decimal
    var
        ObjLoansRegister: Record 51371;
    begin
        ObjLoansRegister.Reset;
        ObjLoansRegister.SetRange(ObjLoansRegister."Loan  No.", LoanNo);
        if ObjLoansRegister.Find('-') then begin
            Amount := ObjLoansRegister."Total Deductions"
        end;
        exit(Amount);

        //************calculate monthly repayment from approved amount*******//
    end;


    procedure KnCalculateMonthlyRepayment(LoanNo: Code[10]; var ApproveAmount: Decimal) Amount: Decimal
    var
        ObjLoansregister: Record 51371;
        LPrincipal: Decimal;
        LInterest: Decimal;
        InterestRate: Decimal;
        RepayPeriod: Integer;
        LoanAmount: Decimal;
    begin
        ObjLoansregister.Reset;
        ObjLoansregister.SetRange(ObjLoansregister."Loan  No.", LoanNo);
        if ObjLoansregister.Find('-') then begin
            //IF ObjLoansregister."Repayment Method"=ObjLoansregister."Repayment Method"::"Reducing Balance" THEN BEGIN
            InterestRate := ObjLoansregister.Interest;
            RepayPeriod := ObjLoansregister.Installments;
            LoanAmount := ObjLoansregister."Approved Amount";
            LInterest := ROUND(ApproveAmount / 100 / 12 * InterestRate, 0.0005, '>');
            Amount := ROUND((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -(RepayPeriod))) * (LoanAmount), 0.0005, '>');
            LPrincipal := Amount - LInterest;
            //END;
        end;
        exit(Amount);

        //*******get total amount brigded********//
    end;


    procedure KnGetTotalBrigdedAmount(LoanNo: Code[15]) Amount: Decimal
    var
        ObjLoanTopUpDetails: Record 51376;
    begin
        ObjLoanTopUpDetails.Reset;
        ObjLoanTopUpDetails.SetRange(ObjLoanTopUpDetails."Loan No.", LoanNo);
        if ObjLoanTopUpDetails.FindSet then begin
            repeat
                Amount := Amount + ObjLoanTopUpDetails."Total Top Up";
            until ObjLoanTopUpDetails.Next = 0;
        end;
        exit(Amount);
    end;


    procedure KnGetMaximumGuaranteeAmount(ClientCode: Code[20]; LoanNo: Code[20]) Amount: Decimal
    var
        ObjMemberRegister: Record 51364;
        TotalCommited: Decimal;
    begin
        ObjMemberRegister.Reset;
        ObjMemberRegister.SetRange(ObjMemberRegister."No.", ClientCode);
        if ObjMemberRegister.Find('-') then begin
            ObjMemberRegister.CalcFields(ObjMemberRegister."Current Shares", ObjMemberRegister."Total Committed Shares");
            if ObjMemberRegister."Total Committed Shares" > 0 then
                TotalCommited := ObjMemberRegister."Total Committed Shares"
            else
                TotalCommited := 0;
            Amount := ((ObjMemberRegister."Current Shares") * (KnGetMaximumDepositMultiplier / 100)) + KnGetSelfAmountGuaranteedLoan(LoanNo) - TotalCommited;
            if Amount > 0 then
                Amount := Amount
            else
                Amount := 0;
        end;
        exit(Amount);




        //Amount:=KnGetFreeShares(ClientCode,LoanNo)*(KnGetMaximumDepositMultiplier/100);
        Amount := KnGetFreeShares(ClientCode, LoanNo) * (KnGetMaximumDepositMultiplier / 100);
        exit(Amount);


        //*********Get previous month from the run date input*****//
    end;


    procedure KnGetPreviousMonthLastDate(LoanNum: Code[10]; RunDate: Date) LastMonthDate: Date
    var
        ObjLoansReg: Record 51371;
    begin
        if ObjLoansReg.Get(LoanNum) then begin
            if (ObjLoansReg."Repayment Frequency" = ObjLoansReg."repayment frequency"::Monthly) then begin
                if (RunDate = CalcDate('CM', RunDate)) then begin
                    LastMonthDate := RunDate;
                end else begin
                    LastMonthDate := CalcDate('-1M', RunDate);
                end;
                LastMonthDate := CalcDate('CM', LastMonthDate);
            end;
        end;

        exit(LastMonthDate);
    end;


    procedure KnGetScheduledExpectedBalance(LoanNum: Code[10]; RunDate: Date) ScheduleBal: Decimal
    var
        ObjRepaySch: Record 51375;
    begin
        ScheduleBal := 0;

        ObjRepaySch.Reset;
        ObjRepaySch.SetRange(ObjRepaySch."Loan No.", LoanNum);
        ObjRepaySch.SetFilter(ObjRepaySch."Repayment Date", '%1', RunDate);
        if ObjRepaySch.Find('-') then begin
            //ObjRepaySch.CALCSUMS("Monthly Repayment");
            ScheduleBal := ObjRepaySch."Loan Balance";
        end else begin
            ScheduleBal := 0;
        end;
        //MESSAGE('ScheduleBal %1  RunDate%2',ScheduleBal,RunDate);
        exit(ScheduleBal);
    end;


    procedure KnGetScheduledExpectedRepayment(LoanNum: Code[10]; RunDate: Date) ScheduleBal: Decimal
    var
        ObjRepaySch: Record 51375;
    begin
        ScheduleBal := 0;

        ObjRepaySch.Reset;
        ObjRepaySch.SetRange(ObjRepaySch."Loan No.", LoanNum);
        ObjRepaySch.SetRange(ObjRepaySch."Repayment Date", RunDate);
        if ObjRepaySch.Find('-') then begin
            ScheduleBal := ObjRepaySch."Principal Repayment";
        end else begin
            ScheduleBal := 0;
        end;
        exit(ScheduleBal);
    end;


    procedure FnGetLoanBalance(LoanNum: Code[10]; RunDate: Date) LoanBal: Decimal
    var
        ObjLoanReg: Record 51371;
    begin
        LoanBal := 0;

        ObjLoanReg.Reset;
        ObjLoanReg.SetRange(ObjLoanReg."Loan  No.", LoanNum);
        //ObjLoanReg.SETFILTER(ObjLoanReg."Date filter",'%1..%2'+FORMAT(RunDate);
        if ObjLoanReg.Find('-') then begin
            ObjLoanReg.CalcFields(ObjLoanReg."Outstanding Balance");
            LoanBal := ObjLoanReg."Outstanding Balance";
        end;

        exit(LoanBal);
    end;


    procedure KnCalculateLoanArrears(LoanBalance: Decimal; RunDate: Date; ExpCompDate: Date; ScheduleBalance: Decimal) Arrears: Decimal
    var
        ObjSchedule: Record 51375;
        ObjLoansReg: Record 51371;
    begin
        Arrears := 0;

        if ExpCompDate < RunDate then begin
            Arrears := LoanBalance;
        end else begin
            if ScheduleBalance >= 0 then begin
                Arrears := LoanBalance - ScheduleBalance;
            end else
                Arrears := 0;
            if Arrears < 0 then
                Arrears := 0
            else
                Arrears := Arrears;
        end;
        if Arrears < 0 then
            Arrears := 0;
        exit(Arrears);
    end;


    procedure KnCalculatePeriodInArrears(Arrears: Decimal; PRepay: Decimal; RunDate: Date; ExpCompletionDate: Date) PeriodArrears: Decimal
    begin
        PeriodArrears := 0;

        if Arrears > 0 then begin
            if ExpCompletionDate < RunDate then begin
                PeriodArrears := ROUND((RunDate - ExpCompletionDate) / 30, 1, '=');
            end else
                PeriodArrears := ROUND(Arrears / PRepay, 1, '=');
        end;

        exit(PeriodArrears);
    end;


    procedure KnClassifyLoans(LoanNum: Code[10]; PeriodArrears: Decimal; AmountArrears: Decimal; RunDate: Date) Class: Integer
    var
        ObjLoansReg: Record 51371;
        DFactory: Codeunit "Periodic Activities";
    begin
        /*IF ObjLoansReg.GET(LoanNum) THEN
          BEGIN
            IF (AmountArrears=0) OR (PeriodArrears<2) THEN
              BEGIN
                ObjLoansReg."Loans Category":=ObjLoansReg."Loans Category"::Perfoming;
                ObjLoansReg."Loans Category-SASRA":=ObjLoansReg."Loans Category-SASRA"::Performing;
                ObjLoansReg."Period In Arears":=PeriodArrears;
                ObjLoansReg.Arears:=AmountArrears;
                Class:=1;
                ObjLoansReg.MODIFY;
               END ELSE
              IF (PeriodArrears >=2) AND (PeriodArrears <3) THEN
              BEGIN
                ObjLoansReg."Loans Category":=ObjLoansReg."Loans Category"::Watch;
                ObjLoansReg."Loans Category-SASRA":=ObjLoansReg."Loans Category-SASRA"::Watch;
                ObjLoansReg."Period In Arears":=PeriodArrears;
                IF DFactory.KnCheckForFullDefaulter(ObjLoansReg."Client Code",RunDate) THEN
                  BEGIN
                   ObjLoansReg.Defaulter:=TRUE;
                  END;
                 IF DFactory.KnCheckForPartialDefaulter(ObjLoansReg."Client Code",RunDate) THEN
                   BEGIN
                     ObjLoansReg."Partial Defaulter":=TRUE;
                    END;
                ObjLoansReg.Arears:=AmountArrears;
                Class:=2;
                ObjLoansReg.MODIFY;
              END ELSE
              IF (PeriodArrears >=3) AND (PeriodArrears <=6) THEN
                BEGIN
                  ObjLoansReg."Loans Category":=ObjLoansReg."Loans Category"::Substandard;
                  ObjLoansReg."Loans Category-SASRA":=ObjLoansReg."Loans Category-SASRA"::Substandard;
                  ObjLoansReg."Period In Arears":=PeriodArrears;
                  IF DFactory.KnCheckForFullDefaulter(ObjLoansReg."Client Code",RunDate) THEN
                  BEGIN
                   ObjLoansReg.Defaulter:=TRUE;
                  END;
                  IF DFactory.KnCheckForPartialDefaulter(ObjLoansReg."Client Code",RunDate) THEN
                   BEGIN
                     ObjLoansReg."Partial Defaulter":=TRUE;
                    END;
                  ObjLoansReg.Arears:=AmountArrears;
                  Class:=3;
                  ObjLoansReg.MODIFY;
              END ELSE
              IF (PeriodArrears >6) AND (PeriodArrears <=12) THEN
                BEGIN
                  ObjLoansReg."Loans Category":=ObjLoansReg."Loans Category"::Doubtful;
                  ObjLoansReg."Loans Category-SASRA":=ObjLoansReg."Loans Category-SASRA"::Doubtful;
                  ObjLoansReg."Period In Arears":=PeriodArrears;
                  IF DFactory.KnCheckForFullDefaulter(ObjLoansReg."Client Code",RunDate) THEN
                  BEGIN
                   ObjLoansReg.Defaulter:=TRUE;
                  END;
                  IF DFactory.KnCheckForPartialDefaulter(ObjLoansReg."Client Code",RunDate) THEN
                   BEGIN
                     ObjLoansReg."Partial Defaulter":=TRUE;
                    END;
                  ObjLoansReg.Arears:=AmountArrears;
                  Class:=4;
                  ObjLoansReg.MODIFY;
              END ELSE
              IF (PeriodArrears >12) THEN BEGIN
                  ObjLoansReg."Loans Category":=ObjLoansReg."Loans Category"::Loss;
                  ObjLoansReg."Loans Category-SASRA":=ObjLoansReg."Loans Category-SASRA"::Loss;
                  ObjLoansReg."Period In Arears":=PeriodArrears;
                  IF DFactory.KnCheckForFullDefaulter(ObjLoansReg."Client Code",RunDate) THEN
                  BEGIN
                   ObjLoansReg.Defaulter:=TRUE;
                  END;
                  IF DFactory.KnCheckForPartialDefaulter(ObjLoansReg."Client Code",RunDate) THEN BEGIN
                     ObjLoansReg."Partial Defaulter":=TRUE;
                    END;
                  ObjLoansReg.Arears:=AmountArrears;
                  Class:=5;
                  ObjLoansReg.MODIFY;
                  END;
        
                IF ObjLoansReg."Repayment Start Date" > RunDate THEN BEGIN
                  ObjLoansReg."Loans Category":=ObjLoansReg."Loans Category"::Perfoming;
                  ObjLoansReg."Loans Category-SASRA":=ObjLoansReg."Loans Category-SASRA"::Performing;
                  ObjLoansReg."Period In Arears":=0;
                  ObjLoansReg.Defaulter:=FALSE;
                  ObjLoansReg."Partial Defaulter":=FALSE;
                  ObjLoansReg.Arears:=0;
                  Class:=1;
                  ObjLoansReg.MODIFY;
                  END;
        
              ObjLoansReg.MODIFY;
            END;
        
        EXIT(Class);
        */

    end;


    procedure KnGetSecurity("Loan No": Code[10]) Name: Text
    var
        ObjLoanCollateral: Record 51374;
    begin
        ObjLoanCollateral.Reset;
        ObjLoanCollateral.SetRange(ObjLoanCollateral."Loan No", "Loan No");
        if ObjLoanCollateral.Find('-') then begin
            Name := ObjLoanCollateral."Security Details";
        end;
        exit(Name);
    end;


    procedure KnGetGuarantee("Loan No": Code[10]) Shares: Boolean
    var
        ObjLoanguarantor: Record 51372;
    begin
        ObjLoanguarantor.Reset;
        ObjLoanguarantor.SetRange(ObjLoanguarantor."Loan No", "Loan No");
        if ObjLoanguarantor.Find('-') then begin
            Shares := true;
        end else
            Shares := false;
        exit(Shares);
    end;


    procedure KnGetLastPrinciplePaid(LoanNo: Code[10]; LastDate: Date): Decimal
    var
        MembLedger: Record 51365;
        principle: Decimal;
    begin
        principle := 0;
        MembLedger.Reset;
        MembLedger.SetRange(MembLedger."Loan No", LoanNo);
        MembLedger.SetRange(MembLedger."Posting Date", LastDate);
        MembLedger.SetRange(MembLedger."Transaction Type", MembLedger."transaction type"::"Loan Repayment");
        if MembLedger.FindSet(true) then begin
            repeat
                principle := (principle + (MembLedger.Amount * -1));
            until MembLedger.Next = 0;
        end;
        exit(principle);
    end;


    procedure KnGetLastInterestPaid(LoanNo: Code[10]; LastDate: Date): Decimal
    var
        MembLedger: Record 51365;
        principle: Decimal;
    begin
        principle := 0;
        MembLedger.Reset;
        MembLedger.SetRange(MembLedger."Loan No", LoanNo);
        MembLedger.SetRange(MembLedger."Posting Date", LastDate);
        MembLedger.SetFilter(MembLedger."Transaction Type", 'Interest Paid');
        if MembLedger.FindSet(true) then begin
            repeat
                principle := (principle + (MembLedger.Amount * -1));
            until MembLedger.Next = 0;
        end;
        exit(principle);
    end;


    procedure KnNotifyExpiringCollaterals()
    var
        ObjLoanCollateral: Record 51374;
        Date: Date;
        SMSMessage: Record 51471;
        iEntryNo: Integer;
    begin
        /*Date:=CALCDATE('+3M',TODAY);
        Date:=TODAY;
        ObjLoanCollateral.RESET;
        //ObjLoanCollateral.SETRANGE(ObjLoanCollateral."Loan No",LoanNo);
        ObjLoanCollateral.SETFILTER(ObjLoanCollateral."Expiry date",'=%1',Date);
        IF ObjLoanCollateral.FINDSET THEN BEGIN
            REPEAT
              SMSMessage.RESET;
              IF SMSMessage.FIND('+') THEN BEGIN
              iEntryNo:=SMSMessage."Entry No";
              iEntryNo:=iEntryNo+1;
              END
              ELSE BEGIN
              iEntryNo:=1;
              END;
        
        
             SMSMessage.INIT;
             SMSMessage."Entry No":=iEntryNo;
             SMSMessage."Batch No":='COLLATERAL';
             SMSMessage."Document No":='';
             SMSMessage."Account No":=ObjLoanCollateral."Loan No";
             SMSMessage."Date Entered":=TODAY;
             SMSMessage."Time Entered":=TIME;
             SMSMessage.Source:='COLLATERALS';
             SMSMessage."Entered By":=USERID;
             SMSMessage."Sent To Server":=SMSMessage."Sent To Server"::No;
             SMSMessage."SMS Message":='Your comprehensive insurance of'+FORMAT(ObjLoanCollateral."Security Details")+' of loan '+FORMAT(ObjLoanCollateral."Loan Type")+' is going to expire on '+FORMAT(ObjLoanCollateral."Expiry date");
             SMSMessage."Telephone No":=ObjLoanCollateral."Tellephone No.";
             IF ((ObjLoanCollateral."Tellephone No."<>'') AND (SMSMessage."SMS Message"<>'')) THEN
             SMSMessage.INSERT;
            UNTIL ObjLoanCollateral.NEXT=0;
          END;
        */

    end;


    procedure KnNotifyMemberForLoanRejection(LoanNo: Code[10])
    var
        ObjLoansRegister: Record 51371;
        SMSMessage: Record 51471;
        iEntryNo: Integer;
    begin
        /*ObjLoansRegister.RESET;
        ObjLoansRegister.SETRANGE(ObjLoansRegister."Loan  No.",LoanNo);
        IF ObjLoansRegister.FIND('-') THEN BEGIN
            SMSMessage.RESET;
              IF SMSMessage.FIND('+') THEN BEGIN
              iEntryNo:=SMSMessage."Entry No";
              iEntryNo:=iEntryNo+1;
              END
              ELSE BEGIN
              iEntryNo:=1;
              END;
        
        
             SMSMessage.INIT;
             SMSMessage."Entry No":=iEntryNo;
             SMSMessage."Batch No":='COLLATERAL';
             SMSMessage."Document No":='';
             SMSMessage."Account No":=LoanNo;
             SMSMessage."Date Entered":=TODAY;
             SMSMessage."Time Entered":=TIME;
             SMSMessage.Source:='COLLATERALS';
             SMSMessage."Entered By":=USERID;
             SMSMessage."Sent To Server":=SMSMessage."Sent To Server"::No;
             SMSMessage."SMS Message":='Your loan of type '+FORMAT(ObjLoansRegister."Loan Product Type")+' has been rejected Reason: '+FORMAT(ObjLoansRegister."Rejection  Remark");
             SMSMessage."Telephone No":=ObjLoansRegister."Phone No.";
             IF ((ObjLoansRegister."Phone No."<>'') AND (SMSMessage."SMS Message"<>'')) THEN
             SMSMessage.INSERT;
          END;
        */

    end;


    procedure KnGetCurrentPeriodForLoan(LoanNo: Code[10]) Period: Integer
    var
        ObjLoanRepaymentSchedule: Record 51375;
        PrevMonth: Date;
        DateParm: Date;
        RepaymentDate: Date;
    begin
        ObjLoanRepaymentSchedule.Reset;
        ObjLoanRepaymentSchedule.SetRange(ObjLoanRepaymentSchedule."Loan No.", LoanNo);
        if ObjLoanRepaymentSchedule.Find('-') then begin
            PrevMonth := KnGetPreviousMonthLastDate(LoanNo, Today);
            repeat
                //ObjLoanRepaymentSchedule.SETRANGE(ObjLoanRepaymentSchedule."Repayment Date",PrevMonth);
                DateParm := CalcDate('CM', ObjLoanRepaymentSchedule."Repayment Date");
                if DateParm = PrevMonth then begin
                    Period := ObjLoanRepaymentSchedule."Instalment No";
                end;
            until ObjLoanRepaymentSchedule.Next = 0;
        end;
    end;


    procedure KnGetLoanInstalments(LoanNo: Code[10]) Instalments: Integer
    var
        ObjLoansRegister: Record 51371;
    begin
        if ObjLoansRegister.Get(LoanNo) then begin
            Instalments := ObjLoansRegister.Installments;
        end;

        exit(Instalments);
    end;


    procedure KnCheckIfLoanTypeIsBridgable(LoanType: Code[10]): Boolean
    var
        ObjLoanProductSetUp: Record 51381;
    begin
        /*ObjLoanProductSetUp.RESET;
        ObjLoanProductSetUp.SETRANGE(ObjLoanProductSetUp.Code,LoanType);
        IF ObjLoanProductSetUp.FIND('-') THEN
          BEGIN
            IF ObjLoanProductSetUp.Bridgable THEN
              EXIT(TRUE)
            ELSE
              EXIT(FALSE);
          END;
        */

    end;


    procedure KnCheckIfLoanTypeCanBeRefinanced(LoanType: Code[10]): Boolean
    var
        ObjLoanProductSetUp: Record 51381;
    begin
        ObjLoanProductSetUp.Reset;
        ObjLoanProductSetUp.SetRange(ObjLoanProductSetUp.Code, LoanType);
        if ObjLoanProductSetUp.Find('-') then begin
            if ObjLoanProductSetUp.Refinanced then
                exit(true)
            else
                exit(false);
        end;


        //*****************reduce liability of the guarantor************//
    end;


    procedure KnUpdateAmountGuaranteed(LoanNo: Code[10]; AmountPaid: Decimal; ClientCode: Code[20])
    var
        ObjLoansGuaranteeDetails: Record 51372;
        Amount: Decimal;
        LoanBalance: Decimal;
        ApprovedAmount: Decimal;
        AmountGuaranteed: Decimal;
        MembersReg: Record 51364;
        freedSharesRetained: Decimal;
        PrevAmount: Decimal;
    begin
        /*TotalGuarantorship:=0;
        LoanBalance:=KnGetLoanBalanceOneLoan(LoanNo)+AmountPaid;
        ApprovedAmount:=KnGetLoanAppAmount(LoanNo);
        AmountGuaranteed:=KnGetOriginalAmountGuaranteed(LoanNo);
        ObjLoansGuaranteeDetails.RESET;
        ObjLoansGuaranteeDetails.SETRANGE(ObjLoansGuaranteeDetails."Loan No",LoanNo);
        IF ObjLoansGuaranteeDetails.FINDSET THEN
          BEGIN
           REPEAT
             Amount:=0;
             freedSharesRetained:=0;
             IF AmountGuaranteed>0 THEN
             Amount:=ROUND(((KnGetAMountGuaranteedByM(ObjLoansGuaranteeDetails."Member No",ObjLoansGuaranteeDetails."Loan No")/AmountGuaranteed)*LoanBalance),0.5,'>');
             TotalGuarantorship:=TotalGuarantorship+Amount;
             PrevAmount:=ObjLoansGuaranteeDetails."Amont Guaranteed";
             ObjLoansGuaranteeDetails."Amont Guaranteed":=Amount;
        
        //Check if Guarantor has Shares Retained
             IF MembersReg.GET(ObjLoansGuaranteeDetails."Member No") THEN BEGIN
                MembersReg.CALCFIELDS("Shares Retained");
        
                //Get Amount to free
                freedSharesRetained:=PrevAmount-Amount;
        
               IF (MembersReg."Shares Retained ">0) AND (freedSharesRetained>0) THEN BEGIN
               IF MembersReg."Shares Retained ">Amount THEN
                 freedSharesRetained:=freedSharesRetained
               ELSE
                 freedSharesRetained:=MembersReg." Shares Retained";
               END;
             END;
             ObjLoansGuaranteeDetails."Amount to Free":=freedSharesRetained;
             ObjLoansGuaranteeDetails.MODIFY(TRUE);
        
            UNTIL ObjLoansGuaranteeDetails.NEXT=0;
          END;
        
        //Update for self guarantee
        ObjLoansGuaranteeDetails.RESET;
        ObjLoansGuaranteeDetails.SETRANGE(ObjLoansGuaranteeDetails."Loan No",LoanNo);
        ObjLoansGuaranteeDetails.SETRANGE(ObjLoansGuaranteeDetails."Self Guarantee",TRUE);
        IF ObjLoansGuaranteeDetails.FINDSET THEN
          BEGIN
             Amount:=0;
             IF AmountGuaranteed>0 THEN BEGIN
             ObjLoansGuaranteeDetails."Amont Guaranteed":=LoanBalance-TotalGuarantorship;
             ObjLoansGuaranteeDetails.MODIFY(TRUE);
             END;
          END;
        
        //Calculate the total amount guaranteed by a member excluding self guarantee*******
        */

    end;


    procedure KnGetAMountGuaranteedByMember(ClientCode: Code[20]) Amount: Decimal
    var
        ObjLoansGuaranteeDetails: Record 51372;
    begin
        ObjLoansGuaranteeDetails.Reset;
        ObjLoansGuaranteeDetails.SetRange(ObjLoansGuaranteeDetails."Member No", ClientCode);
        ObjLoansGuaranteeDetails.SetRange(ObjLoansGuaranteeDetails."Self Guarantee", false);
        ObjLoansGuaranteeDetails.SetRange(ObjLoansGuaranteeDetails.Substituted, false);
        if ObjLoansGuaranteeDetails.FindSet then begin
            repeat
                if ObjLoansGuaranteeDetails."Amont Guaranteed" > 0 then
                    //MESSAGE('Loan no %1 amount %2',ObjLoansGuaranteeDetails."Loan No",ObjLoansGuaranteeDetails."Amont Guaranteed");
                    Amount := Amount + ObjLoansGuaranteeDetails."Amont Guaranteed";
            until ObjLoansGuaranteeDetails.Next = 0;
        end;
        exit(Amount);

        //*************Get the total paid insurance of all years******//
    end;


    procedure KnGetInsurancePaid(ClientCode: Code[20]) Amount: Decimal
    var
        ObjMembersRegister: Record 51364;
    begin
        ObjMembersRegister.Reset;
        ObjMembersRegister.SetRange(ObjMembersRegister."No.", ClientCode);
        if ObjMembersRegister.Find('-') then begin
            ObjMembersRegister.CalcFields(ObjMembersRegister."Insurance Fund");
            Amount := ObjMembersRegister."Insurance Fund";
        end;
        exit(Amount);

        //********************Get the paid insurance for the current year*******//
    end;


    procedure KnGetPaidInsurance(ClientCode: Code[15]) Amount: Decimal
    var
        ObjMembersRegister: Record 51364;
        UpperBound: Date;
    begin
        ObjMembersRegister.Reset;
        ObjMembersRegister.SetRange(ObjMembersRegister."No.", ClientCode);
        if ObjMembersRegister.Find('-') then begin
            ObjMembersRegister.CalcFields("Insurance Fund");
            Amount := ObjMembersRegister."Insurance Fund";
        end;
        exit(Amount);

        //*******************calculate demand saving balances******************//
    end;


    procedure KnGetUnpaidStocks(ClientCode: Code[20]) Amount: Decimal
    var
        ObjMembersRegister: Record 51364;
    begin
        /*ObjMembersRegister.RESET;
        ObjMembersRegister.SETRANGE(ObjMembersRegister."No.",ClientCode);
        IF ObjMembersRegister.FIND('-') THEN
          BEGIN
           ObjMembersRegister.CALCFIELDS(ObjMembersRegister."Current Shares");
           Amount:=ObjMembersRegister.Stocks;
          END;
        
        EXIT(Amount);
        
        //******************get the total amount of overpaid loans*********** //
        */

    end;


    procedure KnGetOverPaidLoans(ClientCode: Code[20]) Amount: Decimal
    var
        ObjLoansRegister: Record 51371;
    begin
        ObjLoansRegister.Reset;
        ObjLoansRegister.SetRange(ObjLoansRegister."Client Code", ClientCode);
        if ObjLoansRegister.FindSet then begin
            ObjLoansRegister.CalcFields("Outstanding Balance");
            if ObjLoansRegister."Outstanding Balance" < 0 then begin
                repeat
                    Amount := (ObjLoansRegister."Outstanding Balance" * -1) + Amount;
                until ObjLoansRegister.Next = 0;
            end;
        end;
        exit(Amount);

        //******************get loan product type*******************//
    end;


    procedure KnGetLoanProductType(LoanNo: Code[15]) LoanType: Code[20]
    var
        ObjLoansRegister: Record 51371;
    begin
        ObjLoansRegister.Reset;
        ObjLoansRegister.SetRange(ObjLoansRegister."Loan  No.", LoanNo);
        if ObjLoansRegister.Find('-') then begin
            LoanType := ObjLoansRegister."Loan Product Type";
        end;
        exit(LoanType);


        //******************get loan product name*******************//
    end;


    procedure KnGetLoanProductTypeName(LoanNo: Code[15]) LoanType: Text[50]
    var
        ObjLoansRegister: Record 51371;
    begin
        ObjLoansRegister.Reset;
        ObjLoansRegister.SetRange(ObjLoansRegister."Loan  No.", LoanNo);
        if ObjLoansRegister.Find('-') then begin
            LoanType := ObjLoansRegister."Loan Product Type Name";
        end;
        exit(LoanType);


        //****************get share capital balance**************//
    end;


    procedure KnGetShareCapital(MemberNo: Code[15]) Amount: Decimal
    var
        ObjMemberRegister: Record 51364;
    begin
        /*IF ObjMemberRegister.GET(MemberNo) THEN
          BEGIN
            ObjMemberRegister.CALCFIELDS("Share Cap");
            Amount:=ObjMemberRegister."Share Cap";
          END;
        EXIT(Amount);
        */

        //*****************get the branch of the user*************//

    end;


    procedure KnGetUserBranch(UserId: Code[10]) Branch: Code[10]
    var
        ObjUsers: Record User;
    begin
        ObjUsers.Reset;
        ObjUsers.SetRange(ObjUsers."User Security ID", UserId);
        if ObjUsers.Find('-') then begin
            // Branch := ObjUsers."Branch Code";
        end;
        exit(Branch);
    end;


    procedure KnGetElapsePeriod(AccountNo: Code[20]) Days: Integer
    var
        objformreception: Record 51562;
        Date: Date;
    begin
        /*Date:=CALCDATE('+60D',objformreception."Notice Date");
        objformreception.RESET
        */

        //*****************Get total interest member is expecte to pay from the schedule***********//

    end;


    procedure KnGetCummulativeInterest(LoanNo: Code[20]) Amount: Decimal
    var
        ObjLoanRepaymentSchedule: Record 51375;
    begin
        ObjLoanRepaymentSchedule.Reset;
        ObjLoanRepaymentSchedule.SetRange(ObjLoanRepaymentSchedule."Loan No.", LoanNo);
        if ObjLoanRepaymentSchedule.FindSet then begin
            repeat
                Amount := Amount + ObjLoanRepaymentSchedule."Monthly Interest";
            until ObjLoanRepaymentSchedule.Next = 0;
        end;

        exit(Amount);


        //*************Get status of demand savings account************//
    end;


    procedure KnGetDemandSavingStatus(MemberNo: Code[20]): Boolean
    var
        ObjMembersRegister: Record 51364;
    begin
        /*IF ObjMembersRegister.GET(MemberNo) THEN
          BEGIN
            IF (ObjMembersRegister."Demand Savings Status"=ObjMembersRegister."Demand Savings Status"::Active) AND (ObjMembersRegister.Status=ObjMembersRegister.Status::Active) THEN
              EXIT(TRUE)
            ELSE
              EXIT(FALSE);
          END;
        */
        //************Check if 60 days of withdrawal notice has ellapsed*******//

    end;


    procedure KnCheckIf60DayshaveElapsed(FormNo: Code[10]; RunDate: Date): Boolean
    var
        ObjFormReception: Record 51562;
        Date: Date;
    begin
        /*IF ObjFormReception.GET(FormNo) THEN
          BEGIN
            Date:=CALCDATE('-60D',RunDate);
            IF Date>=ObjFormReception."Notice Date" THEN
              EXIT(TRUE)
            ELSE
              EXIT(FALSE)
            END;
        
        //**************check if withdrawal requirements are met********* //
        */

    end;


    procedure KnGetMemberWithdrawalRequirements(FormNo: Code[15]; Type: Boolean): Boolean
    var
        ObjFormReception: Record 51562;
    begin
        if ObjFormReception.Get(FormNo) then begin
            if Type then
                exit(true)
            else
                exit(false)
        end;

        //************check if loan repayment is going to clear a loan**********//
    end;


    procedure KnCheckIfLoanIsBeingCleared(LoanNo: Code[10]; Amount: Decimal): Boolean
    var
        ObjLoansRegister: Record 51371;
    begin
        if (Amount * -1) >= FnGetLoanBalance(LoanNo, Today) then
            exit(true)
        else
            exit(false);


        //***********************check if loan is being cleared and notify guarantor who had retained deposits****************//
    end;


    procedure KnCheckForWithdrawnGuarantorsAndNotifyOfLoanClearance(LoanNo: Code[15]; Amount: Decimal): Boolean
    var
        ObjLoanGuaranteeDetails: Record 51372;
    begin
        /*IF KnCheckIfLoanIsBeingCleared(LoanNo,Amount) THEN
          BEGIN
            ObjLoanGuaranteeDetails.RESET;
            ObjLoanGuaranteeDetails.SETRANGE(ObjLoanGuaranteeDetails."Loan No",LoanNo);
            ObjLoanGuaranteeDetails.SETRANGE(ObjLoanGuaranteeDetails."Member Withdrawn",TRUE);
            IF ObjLoanGuaranteeDetails.FINDSET THEN
              BEGIN
                REPEAT
                  FnSendSMS('LOAN','The loan you guaranteed has been cleared',ObjLoanGuaranteeDetails."Member No",ObjLoanGuaranteeDetails."Phone No.");
                UNTIL ObjLoanGuaranteeDetails.NEXT=0;
              END;
          END;
        */
        //**************send sms**********//

    end;


    procedure FnSendSMS(SMSSource: Text; SMSBody: Text; CurrentAccountNo: Text; MobileNumber: Text)
    var
        SMSMessage: Record 51471;
        iEntryNo: Integer;
        ObjGenSetUp: Record 51398;
        ObjCompInfo: Record "Company Information";
    begin
        ObjGenSetUp.Get;
        ObjCompInfo.Get;

        SMSMessage.Reset;
        if SMSMessage.Find('+') then begin
            iEntryNo := SMSMessage."Entry No";
            iEntryNo := iEntryNo + 1;
        end
        else begin
            iEntryNo := 1;
        end;


        SMSMessage.Init;
        SMSMessage."Entry No" := iEntryNo;
        SMSMessage."Batch No" := CurrentAccountNo;
        SMSMessage."Document No" := '';
        SMSMessage."Account No" := CurrentAccountNo;
        SMSMessage."Date Entered" := Today;
        SMSMessage."Time Entered" := Time;
        SMSMessage.Source := SMSSource;
        SMSMessage."Entered By" := UserId;
        SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
        SMSMessage."SMS Message" := SMSBody + '.' + ObjCompInfo.Name + ' ' + ObjGenSetUp."Customer Care No";
        SMSMessage."Telephone No" := MobileNumber;
        if ((MobileNumber <> '') and (SMSBody <> '')) then
            SMSMessage.Insert;


        //*******************check if 14 days are reamining to refund date**************//
    end;


    procedure KnCheckIf14DaysAreRemainingAndNotify(): Boolean
    var
        ObjFormReception: Record 51562;
        Date: Date;
        EllapsindDate: Date;
    begin
        /*ObjFormReception.RESET;
        ObjFormReception.SETRANGE(ObjFormReception.Type,ObjFormReception.Type::"Membership Withdrawal");
        IF ObjFormReception.FINDSET THEN
          BEGIN
            REPEAT
              IF ObjFormReception."Notice Date"<>0D THEN
                BEGIN
                  Date:=CALCDATE('+14D',TODAY);
                  EllapsindDate:=CALCDATE('+60D',ObjFormReception."Notice Date");
                  IF EllapsindDate=Date THEN
                    FnSendSMS('WITHDRAWAL','14 days are remaining to your refund',ObjFormReception."Account No",ObjFormReception."Mobile No");
                END;
            UNTIL ObjFormReception.NEXT=0;
          END;
        
        //*************check if withdrawal notice has been placed by a member********** //
        */

    end;


    procedure KnCheckIfNoticeForWithdrawalhasBeenSubmited(MemberNo: Code[20]): Boolean
    var
        ObjFormReception: Record 51562;
    begin
        /*ObjFormReception.RESET;
        ObjFormReception.SETRANGE(ObjFormReception."Account No",MemberNo);
        ObjFormReception.SETRANGE(ObjFormReception.Type,ObjFormReception.Type::"Membership Withdrawal");
        ObjFormReception.SETRANGE(ObjFormReception.Submited,TRUE);
        ObjFormReception.SETRANGE(ObjFormReception."Witdrawal Status",ObjFormReception."Witdrawal Status"::Active);
        IF ObjFormReception.FIND('-') THEN
          EXIT(TRUE)
        ELSE
          EXIT(TRUE)
        
        
        //***********get amount from insurance for deceased people******** //
        */

    end;


    procedure KnGetInsuranceBenefits(MemberNo: Code[15]) Amount: Decimal
    var
        ObjMembersRegister: Record 51364;
    begin
        /*IF ObjMembersRegister.GET(MemberNo) THEN
          BEGIN
            ObjMembersRegister.CALCFIELDS("Share Cap");
            Amount:=ObjMembersRegister."Share Cap";
          END;
        EXIT(Amount);
        
        */
        //**************Calculate monthly loan payment per month per member*************//

    end;


    procedure KnCalculateLoanMonthlyPaymentPerMember(FirstDateOfMonth: Date; LastdateOfMonth: Date; LoanNo: Code[10]) Amount: Decimal
    var
        ObjMemberLedgerEntry: Record 51365;
    begin
        ObjMemberLedgerEntry.Reset;
        ObjMemberLedgerEntry.SetRange(ObjMemberLedgerEntry."Loan No", LoanNo);
        ObjMemberLedgerEntry.SetRange(ObjMemberLedgerEntry."Transaction Type", ObjMemberLedgerEntry."transaction type"::"Loan Repayment");
        ObjMemberLedgerEntry.SetFilter(ObjMemberLedgerEntry."Posting Date", '%1..%2', FirstDateOfMonth, LastdateOfMonth);
        if ObjMemberLedgerEntry.FindSet then begin
            repeat
                Amount := ObjMemberLedgerEntry.Amount - Amount;
            until ObjMemberLedgerEntry.Next = 0;
        end;
        exit(-Amount);


        //**************Calculate monthly Interest payment per month per member*************//
    end;


    procedure KnCalculateInterestMonthlyPaymentPerMember(FirstDateOfMonth: Date; LastdateOfMonth: Date; LoanNo: Code[10]) Amount: Decimal
    var
        ObjMemberLedgerEntry: Record 51365;
    begin
        ObjMemberLedgerEntry.Reset;
        ObjMemberLedgerEntry.SetRange(ObjMemberLedgerEntry."Loan No", LoanNo);
        ObjMemberLedgerEntry.SetRange(ObjMemberLedgerEntry."Transaction Type", ObjMemberLedgerEntry."transaction type"::"Interest Paid");
        ObjMemberLedgerEntry.SetFilter(ObjMemberLedgerEntry."Posting Date", '%1..%2', FirstDateOfMonth, LastdateOfMonth);
        if ObjMemberLedgerEntry.FindSet then begin
            repeat
                Amount := ObjMemberLedgerEntry.Amount - Amount;
            until ObjMemberLedgerEntry.Next = 0;
        end;
        exit(-Amount);


        //******************update guarantor table with disbursement and completion date****************//
    end;


    procedure KnUpdateLoanGuaranteeDetails(LoanNo: Code[15]; LoanDisbursemnetDate: Date; ExpecteddateOfCompletion: Date; RepaymentStartDate: Date)
    var
        ObjLoanGuaranteeDetails: Record 51372;
    begin
        /*ObjLoanGuaranteeDetails.RESET;
        ObjLoanGuaranteeDetails.SETRANGE(ObjLoanGuaranteeDetails."Loan No",LoanNo);
        IF ObjLoanGuaranteeDetails.FINDSET THEN
          BEGIN
            REPEAT
              ObjLoanGuaranteeDetails."Loan Disbursement Date":=LoanDisbursemnetDate;
              ObjLoanGuaranteeDetails."Expected date of completion":=ExpecteddateOfCompletion;
              ObjLoanGuaranteeDetails."Repayment Start date":=RepaymentStartDate;
              ObjLoanGuaranteeDetails.MODIFY(TRUE);
            UNTIL ObjLoanGuaranteeDetails.NEXT=0;
          END;
        
        */
        //*******************************create journal lines with balanced account type*********************//

    end;


    procedure KnUpdateLoanGuaranteeDetailsApprovedAmt(LoanNo: Code[15]; ApprovedAmount: Decimal; Instalments: Integer)
    var
        ObjLoanGuaranteeDetails: Record 51372;
    begin
        /*ObjLoanGuaranteeDetails.RESET;
        ObjLoanGuaranteeDetails.SETRANGE(ObjLoanGuaranteeDetails."Loan No",LoanNo);
        IF ObjLoanGuaranteeDetails.FINDSET THEN
          BEGIN
            REPEAT
              ObjLoanGuaranteeDetails."Approved Amount":=ApprovedAmount;
              ObjLoanGuaranteeDetails."Loan Period":=Instalments;
            UNTIL ObjLoanGuaranteeDetails.NEXT=0;
          END;
        
        */
        //*******************************create journal lines with balanced account type*********************//

    end;


    procedure KnCreateGnlJournalLineBalanced(TemplateName: Text; BatchName: Text; DocumentNo: Code[30]; LineNo: Integer; TransactionType: Option " ","Registration Fee",Loan,Repayment,"Interest Due","Interest Paid","Deposit Contribution","Shares Capital",Dividend,"Insurance Contribution","Demand Savings","Insurance Charge","Retained Shares","Demand Savings Withdrawal","Stock Due","Stock paid","Insurance Benefits","Demand Activation",ByLaws,"Dividend Advance","Rejoining Fee","Unallocated Funds"; AccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Member,Investor; AccountNo: Code[50]; TransactionDate: Date; TransactionAmount: Decimal; DimensionActivity: Code[40]; ExternalDocumentNo: Code[50]; TransactionDescription: Text; LoanNumber: Code[50]; BalancingAccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Member; BalancingAccountNo: Code[40]; DefaulterPaymentType: Option " ",Attachement,"Subsequent Payment","Guarantor Payment",Reversal)
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := TemplateName;
        GenJournalLine."Journal Batch Name" := BatchName;
        GenJournalLine."Document No." := DocumentNo;
        GenJournalLine."External Document No." := ExternalDocumentNo;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Transaction Type" := TransactionType;
        //GenJournalLine."Defaulter Payment Type":=DefaulterPaymentType;
        GenJournalLine."Account Type" := AccountType;
        GenJournalLine."Account No." := AccountNo;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := TransactionDate;
        GenJournalLine.Description := TransactionDescription;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := TransactionAmount;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Bal. Account Type" := BalancingAccountType;
        GenJournalLine."Bal. Account No." := BalancingAccountNo;
        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
        GenJournalLine."Shortcut Dimension 1 Code" := DimensionActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := 'NAIROBI';
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;


        //*****************check if a member has done a withdrawal for the last six months***************//
    end;


    procedure KnDeactivateAccounts(MemberNo: Code[10])
    var
        ObjMembersRegister: Record 51364;
    begin
    end;


    procedure KnUpdateStatusToActive(MemberNo: Code[20])
    var
        ObjMembersRegister: Record 51364;
    begin
        if ObjMembersRegister.Get(MemberNo) then begin
            if ObjMembersRegister.Status = ObjMembersRegister.Status::"Non-Active" then begin
                ObjMembersRegister.Status := ObjMembersRegister.Status::Active;
                ObjMembersRegister.Modify(true);
            end;
        end;
    end;


    procedure KnUpdateDemandSavingsStatusToActive(MemberNo: Code[20])
    var
        ObjMembersRegister: Record 51364;
    begin
        /*IF ObjMembersRegister.GET(MemberNo) THEN
          BEGIN
            IF ObjMembersRegister."Demand Savings Status"=ObjMembersRegister."Demand Savings Status"::Dormant THEN
              BEGIN
                ObjMembersRegister."Demand Savings Status":=ObjMembersRegister."Demand Savings Status"::Active;
                ObjMembersRegister.MODIFY(TRUE);
              END;
          END;
          */

    end;


    procedure KnCheckIfMemberHasWithdrawalNotice(MemberNo: Code[10]): Boolean
    var
        ObjFormReception: Record 51562;
    begin
        /*ObjFormReception.RESET;
        ObjFormReception.SETRANGE(ObjFormReception."Account No",MemberNo);
        ObjFormReception.SETRANGE(ObjFormReception.Type,ObjFormReception.Type::"Membership Withdrawal");
        ObjFormReception.SETRANGE(ObjFormReception."Witdrawal Status",ObjFormReception."Witdrawal Status"::Active);
        ObjFormReception.SETRANGE(ObjFormReception.Submited,TRUE);
        IF ObjFormReception.FIND('-') THEN
          BEGIN
            IF KnNetRefundableToMember(MemberNo)>=0 THEN
              EXIT(TRUE)
            ELSE
              EXIT(FALSE);
          END ELSE
        EXIT(FALSE);
        */

    end;


    procedure KnCalculateLoanMonthlyPaymentPerMemberPerProduct(FirstDateOfMonth: Date; LastdateOfMonth: Date; ProductType: Code[10]) Amount: Decimal
    var
        ObjLoansReg: Record 51371;
    begin
        ObjLoansReg.Reset;
        ObjLoansReg.SetRange(ObjLoansReg."Loan Product Type", ProductType);
        ObjLoansReg.SetFilter(ObjLoansReg."Issued Date", '%1..%2', FirstDateOfMonth, LastdateOfMonth);
        if ObjLoansReg.FindSet then begin
            repeat
                if ObjLoansReg."Amount Disbursed" > 0 then
                    Amount := ObjLoansReg."Amount Disbursed" + Amount;
            until ObjLoansReg.Next = 0;
        end;
        exit(Amount);

        //**************Calculate monthly Interest payment per month per product*************//
    end;


    procedure KnCalculateInterestMonthlyPaymentPerProduct(FirstDateOfMonth: Date; LastdateOfMonth: Date; ProductType: Code[10]) Amount: Decimal
    var
        ObjLoansReg: Record 51371;
    begin
        /*ObjLoansReg.RESET;
        ObjLoansReg.SETRANGE(ObjLoansReg."Loan Product Type",ProductType);
        ObjLoansReg.SETFILTER(ObjLoansReg."Date filter",'%1..%2',FirstDateOfMonth,LastdateOfMonth);
        IF ObjLoansReg.FINDSET THEN
          BEGIN
            ObjLoansReg.CALCFIELDS(ObjLoansReg."Interest Paid");
            REPEAT
              Amount:=ObjLoansReg."Interest Paid"-Amount;
            UNTIL ObjLoansReg.NEXT=0;
          END;
        EXIT(Amount);
        */

    end;


    procedure KnCalculatePercantageofAmountGuaranteed(LoanNo: Code[10])
    var
        LoanGuarantors: Record 51372;
    begin
        /*LoanGuarantors.RESET;
        LoanGuarantors.SETRANGE(LoanGuarantors."Loan No",LoanNo);
        IF LoanGuarantors.FIND('-') THEN
         BEGIN
           REPEAT
             IF KnGetAmountGuaranteed(LoanNo)>0 THEN
             LoanGuarantors.Percentage:=(LoanGuarantors."Amont Guaranteed"/KnGetAmountGuaranteed(LoanNo))*100;
             LoanGuarantors.MODIFY(TRUE);
           UNTIL LoanGuarantors.NEXT=0;
         END;
         */

    end;


    procedure KnGenerateRepaymentSchedule(LoanNumber: Code[50])
    var
        LoansRec: Record 51371;
        LoansR: Record 51371;
        LoanAmount: Decimal;
        InterestRate: Decimal;
        RepayPeriod: Integer;
        LBalance: Decimal;
        RunDate: Date;
        InstalNo: Decimal;
        RepayInterval: DateFormula;
        TotalMRepay: Decimal;
        LInterest: Decimal;
        LPrincipal: Decimal;
        RepayCode: Code[40];
        GrPrinciple: Integer;
        GrInterest: Integer;
        QPrinciple: Decimal;
        QCounter: Integer;
        InPeriod: DateFormula;
        InitialInstal: Integer;
        InitialGraceInt: Integer;
        RSchedule: Record 51375;
        WhichDay: Integer;
    begin
        LoansRec.Reset;
        LoansRec.SetRange(LoansRec."Loan  No.", LoanNumber);
        if LoansRec.Find('-') then begin
            if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Daily then
                Evaluate(InPeriod, '1D')
            else if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Weekly then
                Evaluate(InPeriod, '1W')
            else if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Monthly then
                Evaluate(InPeriod, '1M')
            else if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Quaterly then
                Evaluate(InPeriod, '1Q');
            QCounter := 0;
            QCounter := 3;
            GrPrinciple := LoansRec."Grace Period - Principle (M)";
            GrInterest := LoansRec."Grace Period - Interest (M)";
            InitialGraceInt := LoansRec."Grace Period - Interest (M)";

            LoansR.Reset;
            LoansR.SetRange(LoansR."Loan  No.", LoansRec."Loan  No.");
            LoansR.SetFilter(LoansR."Approved Amount", '>%1', 0);
            //LoansR.SETFILTER(LoansR.Posted,'=%1',TRUE);
            if LoansR.Find('-') then begin
                LoansRec.TestField(LoansRec."Loan Disbursement Date");
                LoansRec.TestField(LoansRec."Repayment Start Date");

                RSchedule.Reset;
                RSchedule.SetRange(RSchedule."Loan No.", LoansR."Loan  No.");
                RSchedule.DeleteAll;



                LoanAmount := LoansR."Approved Amount";
                InterestRate := LoansR.Interest;
                RepayPeriod := LoansR.Installments;
                InitialInstal := LoansR.Installments + LoansRec."Grace Period - Principle (M)";
                LBalance := LoansR."Approved Amount";
                RunDate := LoansR."Repayment Start Date";
                InstalNo := 0;

                //Repayment Frequency
                if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Daily then
                    RunDate := CalcDate('-1D', RunDate)
                else if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Weekly then
                    RunDate := CalcDate('-1W', RunDate)
                else if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Monthly then
                    RunDate := CalcDate('-1M', RunDate)
                else if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Quaterly then
                    RunDate := CalcDate('-1Q', RunDate);
                //Repayment Frequency


                repeat
                    InstalNo := InstalNo + 1;
                    //Repayment Frequency
                    if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Daily then
                        RunDate := CalcDate('1D', RunDate)
                    else if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Weekly then
                        RunDate := CalcDate('1W', RunDate)
                    else if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Monthly then
                        RunDate := CalcDate('1M', RunDate)
                    else if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Quaterly then
                        RunDate := CalcDate('1Q', RunDate);

                    if LoansRec."Repayment Method" = LoansRec."repayment method"::Amortised then begin
                        LoansRec.TestField(LoansRec.Interest);
                        LoansRec.TestField(LoansRec.Installments);
                        TotalMRepay := ROUND((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -(RepayPeriod))) * (LoanAmount), 0.0001, '>');
                        LInterest := ROUND(LBalance / 100 / 12 * InterestRate, 0.0001, '>');
                        LPrincipal := TotalMRepay - LInterest;
                    end;

                    if LoansRec."Repayment Method" = LoansRec."repayment method"::"Straight Line" then begin
                        LoansRec.TestField(LoansRec.Interest);
                        LoansRec.TestField(LoansRec.Installments);
                        LPrincipal := LoanAmount / RepayPeriod;
                        LInterest := (InterestRate / 12 / 100) * LoanAmount / RepayPeriod;
                    end;

                    if LoansRec."Repayment Method" = LoansRec."repayment method"::"Reducing Balance" then begin
                        LoansRec.TestField(LoansRec.Interest);
                        LoansRec.TestField(LoansRec.Installments);
                        TotalMRepay := ROUND((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -(RepayPeriod))) * (LoanAmount), 0.0001, '>');
                        LInterest := ROUND(LBalance / 100 / 12 * InterestRate, 0.0001, '>');
                        LPrincipal := TotalMRepay - LInterest;
                    end;

                    if LoansRec."Repayment Method" = LoansRec."repayment method"::Constants then begin
                        LoansRec.TestField(LoansRec.Repayment);
                        if LBalance < LoansRec.Repayment then
                            LPrincipal := LBalance
                        else
                            LPrincipal := LoansRec.Repayment;
                        LInterest := LoansRec.Interest;
                    end;

                    //Grace Period
                    if GrPrinciple > 0 then begin
                        LPrincipal := 0
                    end else begin
                        LBalance := LBalance - LPrincipal;

                    end;

                    if GrInterest > 0 then
                        LInterest := 0;

                    GrPrinciple := GrPrinciple - 1;
                    GrInterest := GrInterest - 1;
                    Evaluate(RepayCode, Format(InstalNo));


                    RSchedule.Init;
                    RSchedule."Repayment Code" := RepayCode;
                    RSchedule."Interest Rate" := InterestRate;
                    RSchedule."Loan No." := LoansRec."Loan  No.";
                    RSchedule."Loan Amount" := LoanAmount;
                    RSchedule."Instalment No" := InstalNo;
                    RSchedule."Repayment Date" := CalcDate('CM', RunDate);
                    RSchedule."Member No." := LoansRec."Client Code";
                    RSchedule."Loan Category" := LoansRec."Loan Product Type";
                    RSchedule."Monthly Repayment" := LInterest + LPrincipal;
                    RSchedule."Monthly Interest" := LInterest;
                    RSchedule."Loan Balance" := LBalance;
                    RSchedule."Principal Repayment" := LPrincipal;
                    RSchedule.Insert;
                    WhichDay := Date2dwy(RSchedule."Repayment Date", 1);
                until LBalance < 1

                //END;
            end;

            Commit;
        end;
    end;


    procedure KnGenerate2ndDefaulterNotices(LoanNo: Code[10]; FirstNoticeDate: Date)
    var
        ObjLoansGuaranteeDetails: Record 51372;
        ObjSaccoGenSetUp: Record 51398;
        DateOfInterest: Date;
    begin
        /*ObjLoansGuaranteeDetails.RESET;
        ObjLoansGuaranteeDetails.SETRANGE(ObjLoansGuaranteeDetails."Loan No",LoanNo);
        IF ObjLoansGuaranteeDetails.FIND('-') THEN
          BEGIN
            MESSAGE('here');
            ObjSaccoGenSetUp.GET();
            DateOfInterest:=CALCDATE(ObjSaccoGenSetUp."2nd Notice Date",FirstNoticeDate);
            IF DateOfInterest=TODAY THEN
              BEGIN
               REPEAT
                REPORT.RUN(51516392,TRUE,FALSE,ObjLoansGuaranteeDetails);
               UNTIL ObjLoansGuaranteeDetails.NEXT=0;
              END;
          END;
        */

    end;


    procedure KnGetRegistrationFeePaid(MemberNo: Code[10]): Decimal
    var
        ObjMemberReg: Record 51364;
        Amount: Decimal;
    begin
        if ObjMemberReg.Get(MemberNo) then begin
            ObjMemberReg.CalcFields("Registration Fee Paid");
            Amount := ObjMemberReg."Registration Fee Paid";
        end;

        exit(Amount);
    end;


    procedure KnCalculateLoanTopUpFee(LoanNo: Code[10]): Decimal
    var
        TopUpFee: Decimal;
        ObjLoanTopUp: Record 51376;
        TotalAmount: Decimal;
        Commision: Decimal;
        ObjSaccoGenSetUp: Record 51398;
    begin
        ObjSaccoGenSetUp.Get;
        ObjLoanTopUp.Reset;
        ObjLoanTopUp.SetRange(ObjLoanTopUp."Loan No.", LoanNo);
        if ObjLoanTopUp.Find('-') then begin
            repeat
                TotalAmount := ObjLoanTopUp."Total Top Up" + TotalAmount;
            until ObjLoanTopUp.Next = 0;
            Commision := (ObjSaccoGenSetUp."Loan Top Up Commision(%)" / 100) * TotalAmount;
            if Commision > ObjSaccoGenSetUp."Loan Top Up Commision(Min)" then
                TopUpFee := Commision
            else
                TopUpFee := ObjSaccoGenSetUp."Loan Top Up Commision(Min)";
        end;
        exit(TopUpFee);
    end;


    procedure KnGetMemberPhoneNo(MemberNo: Code[15]): Code[20]
    var
        ObjMembersReg: Record 51364;
        PhoneNo: Code[20];
    begin
        if ObjMembersReg.Get(MemberNo) then begin
            PhoneNo := ObjMembersReg."Mobile Phone No";
        end;

        exit(PhoneNo);
    end;


    procedure KnGetMemberEmailAddress(MemberNo: Code[15]): Code[50]
    var
        ObjMembersReg: Record 51364;
        Email: Code[50];
    begin
        if ObjMembersReg.Get(MemberNo) then begin
            Email := ObjMembersReg."E-Mail";
        end;

        exit(Email);
    end;


    procedure KnCheckIfMemberHasConsolidaterLoan(MemberNo: Code[20]; LoanType: Code[20]): Boolean
    var
        ObjLoansReg: Record 51371;
    begin
        ObjLoansReg.Reset;
        ObjLoansReg.SetRange(ObjLoansReg."Client Code", MemberNo);
        ObjLoansReg.SetFilter(ObjLoansReg."Loan Product Type", '%1|%2', 'D301', 'D302');
        if ObjLoansReg.Find('-') then begin
            if (ObjLoansReg."Loan Product Type" = 'D301') or (ObjLoansReg."Loan Product Type" = 'D302') then
                exit(true)
            else
                exit(false);
        end;
    end;


    procedure KnCheckIfLoanTypeIsConsolidater(LoanType: Code[10]): Boolean
    var
        ObjLoanProductSetUp: Record 51381;
    begin
        if ObjLoanProductSetUp.Get(LoanType) then begin
            if ObjLoanProductSetUp.Consolidater then
                exit(true)
            else
                exit(false);
        end;
    end;


    procedure KnCheckIfRecommendedAmountDependOnDeposits(LoanType: Code[10]): Boolean
    var
        ObjLoanProductSetUp: Record 51381;
    begin
        if ObjLoanProductSetUp.Get(LoanType) then begin
            if ObjLoanProductSetUp."Appraise Deposits" then
                exit(true)
            else
                exit(false);
        end;
    end;


    procedure KnGetSelfAMountGuaranteed(ClientCode: Code[20]) Amount: Decimal
    var
        ObjLoansGuaranteeDetails: Record 51372;
    begin
        ObjLoansGuaranteeDetails.Reset;
        ObjLoansGuaranteeDetails.SetRange(ObjLoansGuaranteeDetails."Member No", ClientCode);
        ObjLoansGuaranteeDetails.SetRange(ObjLoansGuaranteeDetails."Self Guarantee", true);
        if ObjLoansGuaranteeDetails.FindSet then begin
            repeat
                ObjLoansGuaranteeDetails.CalcFields(ObjLoansGuaranteeDetails."Outstanding Balance");
                if ObjLoansGuaranteeDetails."Outstanding Balance" > 0 then
                    Amount := Amount + ObjLoansGuaranteeDetails."Amont Guaranteed";
            until ObjLoansGuaranteeDetails.Next = 0;
        end;
        exit(Amount);

        //*************Get the total paid insurance of all years******//
    end;


    procedure KnCalculateLoanProductCharges(LoanType: Code[10]; ApprovedAmount: Decimal; LoanNo: Code[10]): Decimal
    var
        ObjLoanProductCharges: Record 51383;
        Amount: Decimal;
        ObjLoansReg: Record 51371;
    begin
        if ObjLoansReg.Get(LoanNo) then begin
            ObjLoanProductCharges.Reset;
            ObjLoanProductCharges.SetRange(ObjLoanProductCharges."Product Code", LoanType);
            if ObjLoanProductCharges.Find('-') then begin
                repeat
                    if ObjLoanProductCharges."Use Perc" then
                        Amount := (ObjLoanProductCharges.Percentage / 100) * ApprovedAmount
                    else
                        Amount := ObjLoanProductCharges.Amount;
                until ObjLoanProductCharges.Next = 0;
            end;
        end;
        exit(Amount);
    end;


    procedure KnFindMinimumDepositTierContribution(LoanNo: Code[10]; ApprovedAmount: Decimal): Decimal
    var
        DepositContribution: Decimal;
        DepositTier: Record 51402;
    begin
        DepositTier.Reset;
        DepositTier.SetCurrentkey(Code);
        if DepositTier.FindFirst then begin
            repeat
                if ((ApprovedAmount >= DepositTier."Minimum Amount") and (ApprovedAmount <= DepositTier."Maximum Amount")) then begin
                    DepositContribution := DepositTier."Minimum Dep Contributions";
                end;
            until DepositTier.Next = 0;
        end;

        exit(DepositContribution);
    end;


    procedure KnCheckForActiveMember(MemberNo: Code[10]): Boolean
    var
        ObjMemberReg: Record 51364;
    begin
        if ObjMemberReg.Get(MemberNo) then begin
            if ObjMemberReg.Status = ObjMemberReg.Status::Active then
                exit(true)
            else
                exit(false)
        end;
    end;


    procedure KnGetTotalAccruedInterest(ClientCode: Code[20]) Amount: Decimal
    var
        ObjLoansRegister: Record 51371;
    begin
        ObjLoansRegister.Reset;
        ObjLoansRegister.SetRange(ObjLoansRegister."Client Code", ClientCode);
        if ObjLoansRegister.FindSet then begin
            repeat
                ObjLoansRegister.CalcFields("Oustanding Interest");
                Amount := Amount + ObjLoansRegister."Oustanding Interest";
            until ObjLoansRegister.Next = 0;
        end;

        exit(Amount);


        //*******calculate a third of a members netpay**********//
    end;


    procedure KnNetRefundableToMember(MemberNo: Code[10]): Decimal
    var
        ObjMemberReg: Record 51364;
        ObjLoansReg: Record 51371;
        ObjSaccoGenSetUp: Record 51398;
        UnpaidShareCap: Decimal;
        LoanBalance: Decimal;
        AcruedInterest: Decimal;
        UnpaidInsurance: Decimal;
        UnpaidStocks: Decimal;
        DemandSavings: Decimal;
        NetRufandable: Decimal;
        DepositBalances: Decimal;
        CommitedShares: Decimal;
    begin
        DepositBalances := KnGetMemberShares(MemberNo);
        //DemandSavings:=KnGetDemandSavingsBalance(MemberNo);
        LoanBalance := KnGetLoanBalance(MemberNo);
        AcruedInterest := KnGetTotalAccruedInterest(MemberNo);
        UnpaidShareCap := ObjSaccoGenSetUp."Retained Shares" - KnGetShareCapital(MemberNo);
        if UnpaidShareCap > 0 then
            UnpaidShareCap := UnpaidShareCap
        else
            UnpaidShareCap := 0;
        UnpaidInsurance := KnGetInsurancePaid(MemberNo);
        UnpaidStocks := KnGetUnpaidStocks(MemberNo);

        NetRufandable := (DepositBalances + DemandSavings) - (LoanBalance + AcruedInterest + UnpaidShareCap + UnpaidInsurance + UnpaidStocks);

        exit(NetRufandable);
    end;


    procedure KnCheckIfUserHasTheMemberFile(MemberNo: Code[20]; FileType: Code[50]; UserID: Code[50]): Boolean
    var
        ObjFileRequest: Record 51296;
    begin
        /*ObjFileRequest.RESET;
        ObjFileRequest.SETRANGE(ObjFileRequest."Account No.",MemberNo);
        //ObjFileRequest.SETRANGE(ObjFileRequest."File Type",FileType);
        ObjFileRequest.SETRANGE(ObjFileRequest."Current Owner",UserID);
        ObjFileRequest.SETRANGE(ObjFileRequest.Returned,FALSE);
        IF ObjFileRequest.FIND('-') THEN
          EXIT(TRUE)
        ELSE
          EXIT(FALSE);
        */

    end;


    procedure KnAccrueLeaveDays()
    var
        HRSetup: Record 51181;
        LeaveGjline: Record 51228;
        HREmailParameters: Record 51208;
        HRLeavePeriods: Record 51189;
        HRJournalBatch: Record 51188;
        HRLeaveEntries: Record 51227;
        HREmp: Record 51160;
        LineNo: Integer;
    begin
        /*HRSetup.RESET;
        IF HRSetup.FIND('-') THEN BEGIN
        
        LeaveGjline.RESET;
        LeaveGjline.SETRANGE("Journal Template Name",HRSetup."Leave Template");
        LeaveGjline.SETRANGE("Journal Batch Name",HRSetup."Leave Batch");
        LeaveGjline.DELETEALL;
        
        HREmp.RESET;
        IF HREmp.FIND('-') THEN
           BEGIN
             REPEAT
              LineNo:=LineNo+10000;
              LeaveGjline.INIT;
              LeaveGjline."Journal Template Name":=HRSetup."Leave Template";
              LeaveGjline."Journal Batch Name":=HRSetup."Leave Batch";
              LeaveGjline."Line No.":=LineNo;
              LeaveGjline."Leave Period":=HRLeavePeriods.Name;
              LeaveGjline."Leave Application No.":=HREmp."No.";
              LeaveGjline."Document No.":=HREmp."No.";
              LeaveGjline."Staff No.":=HREmp."No.";
              LeaveGjline.VALIDATE(LeaveGjline."Staff No.");
              LeaveGjline."Posting Date":=TODAY;
              LeaveGjline."Leave Entry Type":=LeaveGjline."Leave Entry Type"::Positive;
              LeaveGjline."Leave Approval Date":=TODAY;
              LeaveGjline.Description:='Days Earned for '+FORMAT(LeaveGjline."Posting Date");
              LeaveGjline."Leave Type":='ANNUAL';
              //------------------------------------------------------------
              //HRSetup.RESET;
              //HRSetup.FIND('-');
              HRSetup.TESTFIELD(HRSetup."Leave Posting Period[FROM]");
              HRSetup.TESTFIELD(HRSetup."Leave Posting Period[TO]");
              //------------------------------------------------------------
              LeaveGjline."Leave Period Start Date":=HRSetup."Leave Posting Period[FROM]";
              LeaveGjline."Leave Period End Date":=HRSetup."Leave Posting Period[TO]";
              LeaveGjline."No. of Days":=HRSetup."Days Accrued Monthly";
              IF LeaveGjline."No. of Days"<>0 THEN
                LeaveGjline.INSERT(TRUE);
              UNTIL HREmp.NEXT=0;
            END;
              //Post Journal
               LeaveGjline.RESET;
               LeaveGjline.SETRANGE("Journal Template Name",HRSetup."Leave Template");
               LeaveGjline.SETRANGE("Journal Batch Name",HRSetup."Leave Batch");
               IF LeaveGjline.FIND('-') THEN BEGIN
                 CODEUNIT.RUN(CODEUNIT::"HR Leave Jnl.-Post-Accrue",LeaveGjline);
               END;
         END;
        */

    end;


    procedure KnGetMemberBankAccountNo(MemberNo: Code[15]): Code[30]
    var
        ObjMembersReg: Record 51364;
        AccountNo: Code[20];
    begin
        if ObjMembersReg.Get(MemberNo) then begin
            AccountNo := ObjMembersReg."Bank Account No.";
        end;

        exit(AccountNo);
    end;


    procedure KnGetMemberBankName(MemberNo: Code[15]): Text
    var
        ObjMembersReg: Record 51364;
        BankName: Text;
    begin
        /*IF ObjMembersReg.GET(MemberNo) THEN
          BEGIN
            BankName:=ObjMembersReg."Bank Name";
          END;
        
        EXIT(BankName);
        */

    end;


    procedure KnCheckIfBankHasMaxBalance(BankNo: Code[20]): Boolean
    var
        ObjBankAccount: Record "Bank Account";
        Amount: Decimal;
    begin
        /*IF ObjBankAccount.GET(BankNo) THEN
          BEGIN
            IF ObjBankAccount."Witholding  Limit" THEN
              EXIT(TRUE)
            ELSE
              EXIT(FALSE)
          END;
          */

    end;


    procedure KnGetMaxAmountForBank(BankNo: Code[20]): Decimal
    var
        ObjBankAccount: Record "Bank Account";
        Amount: Decimal;
    begin
        /*IF ObjBankAccount.GET(BankNo) THEN
          BEGIN
            Amount:=ObjBankAccount."Maximum Bank Limit";
          END;
        
        EXIT(Amount);
        */

    end;


    procedure KnGetBankAccountBalance(BankNo: Code[20]): Decimal
    var
        ObjBankAccount: Record "Bank Account";
        Amount: Decimal;
    begin
        if ObjBankAccount.Get(BankNo) then begin
            ObjBankAccount.CalcFields(Balance);
            Amount := ObjBankAccount.Balance;
        end;

        exit(Amount);
    end;


    procedure KnGetMemberBankCode(MemberNo: Code[15]): Code[30]
    var
        ObjMembersReg: Record 51364;
        AccountNo: Code[20];
    begin
        if ObjMembersReg.Get(MemberNo) then begin
            AccountNo := ObjMembersReg."Bank Code";
        end;

        exit(AccountNo);
    end;


    procedure KnGetMemberBranchCode(MemberNo: Code[15]): Code[30]
    var
        ObjMembersReg: Record 51364;
        AccountNo: Code[20];
    begin
        if ObjMembersReg.Get(MemberNo) then begin
            AccountNo := ObjMembersReg."Bank Code" + ObjMembersReg."Bank Branch Code";
        end;

        exit(AccountNo);
    end;


    procedure KnNotifyExpiringInsuranceScheme()
    var
        ObjMedicalSchemeMembers: Record 51285;
        Date: Date;
        // SMTPSetup: Record "SMTP Mail Setup";
        iEntryNo: Integer;
        HRSetup: Record 51181;
        // SMTPMail: Codeunit "SMTP Mail";
        EmailMessage: Text;
    begin
        /*HRSetup.GET;
        SMTPSetup.GET;
        Date:=CALCDATE(HRSetup."IM Expiry Notification",TODAY);
        Date:=TODAY;
        ObjMedicalSchemeMembers.RESET;
        ObjMedicalSchemeMembers.SETRANGE(ObjMedicalSchemeMembers."Expiry date",Date);
        IF ObjMedicalSchemeMembers.FIND('-') THEN
        BEGIN
         EmailMessage:='This is to notify you that the Insurance of '+FORMAT(ObjMedicalSchemeMembers."First Name")+' is expiring on '+FORMAT(ObjMedicalSchemeMembers."Expiry date");
          REPEAT
              IF HRSetup."Notification Email"<>'' THEN  BEGIN
                SMTPSetup.GET;
                SMTPMail.CreateMessage(SMTPSetup."Email Sender Name",SMTPSetup."Email Sender Address",HRSetup."Notification Email",'Expiring Insurances','',TRUE);
                SMTPMail.AppendBody(STRSUBSTNO(EmailMessage,USERID));
                SMTPMail.AppendBody(SMTPSetup."Email Sender Name");
                SMTPMail.AppendBody('<br><br>');
                SMTPMail.Send;
              END;
            UNTIL ObjMedicalSchemeMembers.NEXT=0;
        END;
        */

    end;


    procedure KnCheckIFileIsInCirculation(MemberNo: Code[20]; FileType: Code[50]; UserID: Code[50]) Owner: Code[50]
    var
        ObjFileRequest: Record 51296;
    begin
        /*ObjFileRequest.RESET;
        ObjFileRequest.SETRANGE(ObjFileRequest."Account No.",MemberNo);
        ObjFileRequest.SETRANGE(ObjFileRequest."File Type",FileType);
        ObjFileRequest.SETRANGE(ObjFileRequest.Returned,FALSE);
        ObjFileRequest.SETRANGE(ObjFileRequest.Status,ObjFileRequest.Status::InCirculation);
        IF ObjFileRequest.FIND('-') THEN
          EXIT(ObjFileRequest."Current Owner")
        */

    end;


    procedure knConvertMobilePhoneNo(MobilePhoneNo: Code[30]): Code[20]
    var
        NewPhoneNo: Code[20];
        TailPhoneNo: Code[20];
    begin
        TailPhoneNo := CopyStr(MobilePhoneNo, 2, 9);
        NewPhoneNo := '+254' + TailPhoneNo;

        exit(NewPhoneNo);
    end;


    procedure KnGetLoanAppAmount(LoanNo: Code[20]) Amount: Decimal
    var
        ObjLoansRegister: Record 51371;
    begin
        ObjLoansRegister.Reset;
        ObjLoansRegister.SetRange(ObjLoansRegister."Loan  No.", LoanNo);
        if ObjLoansRegister.Find('-') then begin
            Amount := Amount + ObjLoansRegister."Approved Amount";
        end;

        exit(Amount);


        //*******calculate a third of a members netpay**********//
    end;


    procedure KnGetLoanBalanceOneLoan(LoanNo: Code[20]) Amount: Decimal
    var
        ObjLoansRegister: Record 51371;
        MeReg: Record 51364;
    begin
        ObjLoansRegister.Reset;
        ObjLoansRegister.SetRange(ObjLoansRegister."Loan  No.", LoanNo);
        if ObjLoansRegister.Find('-') then begin
            ObjLoansRegister.CalcFields(ObjLoansRegister."Outstanding Balance");
            Amount := Amount + ObjLoansRegister."Outstanding Balance";
        end;

        exit(Amount);


        //*******calculate a third of a members netpay**********//
    end;


    procedure KnGetSelfAmountGuaranteedLoan(LoanNo: Code[15]) Amount: Decimal
    var
        ObjGuaranteeDetails: Record 51372;
    begin
        ObjGuaranteeDetails.Reset;
        ObjGuaranteeDetails.SetRange(ObjGuaranteeDetails."Loan No", LoanNo);
        ObjGuaranteeDetails.SetRange(ObjGuaranteeDetails."Self Guarantee", true);
        if ObjGuaranteeDetails.Find('-') then begin
            repeat
                if KnGetLoanBalanceOneLoan(LoanNo) > 0 then
                    Amount := Amount + ObjGuaranteeDetails."Amont Guaranteed";
            until ObjGuaranteeDetails.Next = 0;
        end;
        exit(Amount);


        //***************Get a members total free shares***************//
    end;


    procedure KnGetEftFee() Amount: Decimal
    var
        SaccoGeneralSetUp: Record 51398;
    begin
        SaccoGeneralSetUp.Get();
        Amount := SaccoGeneralSetUp."EFT Fee";
        exit(Amount);
    end;


    procedure FnCalculateDividendQualifyingAmt(MemberNo: Code[10]; Date: Date): Decimal
    var
        LastYearEnd: Date;
        JanuaryStart: Date;
        JanuaryEnd: Date;
        FebStart: Date;
        FebEnd: Date;
        MarchStart: Date;
        MarchEnd: Date;
        AprilStart: Date;
        AprilEnd: Date;
        MayStart: Date;
        MayEnd: Date;
        JuneStart: Date;
        JuneEnd: Date;
        JulyStart: Date;
        JulyEnd: Date;
        AugustStart: Date;
        AugustEnd: Date;
        SeptStart: Date;
        SeptEnd: Date;
        OctStart: Date;
        OctEnd: Date;
        NovStart: Date;
        NovEnd: Date;
        DecStart: Date;
        DecEnd: Date;
        LastYearAmt: Integer;
        JanuaryAmt: Decimal;
        FebruaryAmt: Decimal;
        MarchAmt: Decimal;
        AprilAmt: Decimal;
        MayAmt: Decimal;
        JuneAmt: Decimal;
        JulyAmt: Decimal;
        AugustAmt: Decimal;
        SpetemberAmt: Decimal;
        OctoberAmt: Decimal;
        NovemberAmt: Decimal;
        DecemberAmt: Decimal;
        TotalAmt: Decimal;
        Cust: Record 51364;
        GenSetUp: Record 51398;
    begin
        /*JanuaryStart:=CALCDATE('-CY',Date);
        LastYearEnd:=CALCDATE('-1D',JanuaryStart);
        JanuaryEnd:=CALCDATE('+CM',JanuaryStart);
        FebStart:=CALCDATE('+1D',JanuaryEnd);
        FebEnd:=CALCDATE('+CM',FebStart);
        MarchStart:=CALCDATE('+1D',FebEnd);
        MarchEnd:=CALCDATE('+CM',MarchStart);
        AprilStart:=CALCDATE('+1D',MarchEnd);
        AprilEnd:=CALCDATE('+CM',AprilStart);
        MayStart:=CALCDATE('+1D',AprilEnd);
        MayEnd:=CALCDATE('+CM',MayStart);
        JuneStart:=CALCDATE('+1D',MayEnd);
        JuneEnd:=CALCDATE('+CM',JuneStart);
        JulyStart:=CALCDATE('+1D',JuneEnd);
        JulyEnd:=CALCDATE('+CM',JulyStart);
        AugustStart:=CALCDATE('+1D',JulyEnd);
        AugustEnd:=CALCDATE('+CM',AugustStart);
        SeptStart:=CALCDATE('+1D',AugustEnd);
        SeptEnd:=CALCDATE('+CM',SeptStart);
        OctStart:=CALCDATE('+1D',SeptEnd);
        OctEnd:=CALCDATE('+CM',OctStart);
        NovStart:=CALCDATE('+1D',OctEnd);
        NovEnd:=CALCDATE('+CM',NovStart);
        DecStart:=CALCDATE('+1D',NovEnd);
        DecEnd:=CALCDATE('+CM',DecStart);
        GenSetUp.GET;
        //last year
        Cust.RESET;
        Cust.SETCURRENTKEY("No.");
        Cust.SETRANGE(Cust."No.",MemberNo);
        Cust.SETFILTER(Cust."Date Filter",'..%1',LastYearEnd);
        IF Cust.FIND('-') THEN BEGIN
          Cust.CALCFIELDS(Cust."Current Shares",Cust."Share Cap");
          IF (Cust."Current Shares" <> 0)   THEN BEGIN
            LastYearAmt:=(Cust."Current Shares")*(12/12);
          END;
        END;
        
        //january
        Cust.RESET;
        Cust.SETCURRENTKEY("No.");
        Cust.SETRANGE(Cust."No.",MemberNo);
        Cust.SETFILTER(Cust."Date Filter",'%1..%2',JanuaryStart,JanuaryEnd);
        IF Cust.FIND('-') THEN BEGIN
          Cust.CALCFIELDS(Cust."Current Shares",Cust."Share Cap");
          IF (Cust."Current Shares" <> 0)   THEN BEGIN
            JanuaryAmt:=(Cust."Current Shares")*(11/12);
          END;
        END;
        
        
        //february
        Cust.RESET;
        Cust.SETCURRENTKEY("No.");
        Cust.SETRANGE(Cust."No.",MemberNo);
        Cust.SETFILTER(Cust."Date Filter",'%1..%2',FebStart,FebEnd);
        IF Cust.FIND('-') THEN BEGIN
          Cust.CALCFIELDS(Cust."Current Shares",Cust."Share Cap");
          IF (Cust."Current Shares" <> 0)   THEN BEGIN
            FebruaryAmt:=(Cust."Current Shares")*(10/12);
          END;
        END;
        
        
        //march
        Cust.RESET;
        Cust.SETCURRENTKEY("No.");
        Cust.SETRANGE(Cust."No.",MemberNo);
        Cust.SETFILTER(Cust."Date Filter",'..%1',MarchStart,MarchEnd);
        IF Cust.FIND('-') THEN BEGIN
          Cust.CALCFIELDS(Cust."Current Shares",Cust."Share Cap");
          IF (Cust."Current Shares" <> 0)   THEN BEGIN
            MarchAmt:=(Cust."Current Shares")*(9/12);
          END;
        END;
        
        //April
        Cust.RESET;
        Cust.SETCURRENTKEY("No.");
        Cust.SETRANGE(Cust."No.",MemberNo);
        Cust.SETFILTER(Cust."Date Filter",'%1..%2',AprilStart,AprilEnd);
        IF Cust.FIND('-') THEN BEGIN
          Cust.CALCFIELDS(Cust."Current Shares",Cust."Share Cap");
          IF (Cust."Current Shares" <> 0)   THEN BEGIN
            AprilAmt:=(Cust."Current Shares")*(8/12);
          END;
        END;
        
        
        //May
        Cust.RESET;
        Cust.SETCURRENTKEY("No.");
        Cust.SETRANGE(Cust."No.",MemberNo);
        Cust.SETFILTER(Cust."Date Filter",'%1..%2',MayStart,MayEnd);
        IF Cust.FIND('-') THEN BEGIN
          Cust.CALCFIELDS(Cust."Current Shares",Cust."Share Cap");
          IF (Cust."Current Shares" <> 0)   THEN BEGIN
            MayAmt:=(Cust."Current Shares")*(7/12);
          END;
        END;
        
        
        //June
        Cust.RESET;
        Cust.SETCURRENTKEY("No.");
        Cust.SETRANGE(Cust."No.",MemberNo);
        Cust.SETFILTER(Cust."Date Filter",'%1..%2',JuneStart,JuneEnd);
        IF Cust.FIND('-') THEN BEGIN
          Cust.CALCFIELDS(Cust."Current Shares",Cust."Share Cap");
          IF (Cust."Current Shares" <> 0)   THEN BEGIN
            JuneAmt:=(Cust."Current Shares")*(6/12);
          END;
        END;
        
        //July
        Cust.RESET;
        Cust.SETCURRENTKEY("No.");
        Cust.SETRANGE(Cust."No.",MemberNo);
        Cust.SETFILTER(Cust."Date Filter",'%1..%2',JulyStart,JulyEnd);
        IF Cust.FIND('-') THEN BEGIN
          Cust.CALCFIELDS(Cust."Current Shares",Cust."Share Cap");
          IF (Cust."Current Shares" <> 0)   THEN BEGIN
            JulyAmt:=(Cust."Current Shares")*(5/12);
          END;
        END;
        
        //August
        Cust.RESET;
        Cust.SETCURRENTKEY("No.");
        Cust.SETRANGE(Cust."No.",MemberNo);
        Cust.SETFILTER(Cust."Date Filter",'%1..%2',AugustStart,AugustEnd);
        IF Cust.FIND('-') THEN BEGIN
          Cust.CALCFIELDS(Cust."Current Shares",Cust."Share Cap");
          IF (Cust."Current Shares" <> 0)   THEN BEGIN
            AugustAmt:=(Cust."Current Shares")*(4/12);
          END;
        END;
        
        //September
        Cust.RESET;
        Cust.SETCURRENTKEY("No.");
        Cust.SETRANGE(Cust."No.",MemberNo);
        Cust.SETFILTER(Cust."Date Filter",'%1..%2',SeptStart,SeptEnd);
        IF Cust.FIND('-') THEN BEGIN
          Cust.CALCFIELDS(Cust."Current Shares",Cust."Share Cap");
          IF (Cust."Current Shares" <> 0)   THEN BEGIN
            SpetemberAmt:=(Cust."Current Shares")*(3/12);
          END;
        END;
        
        //October
        Cust.RESET;
        Cust.SETCURRENTKEY("No.");
        Cust.SETRANGE(Cust."No.",MemberNo);
        Cust.SETFILTER(Cust."Date Filter",'%1..%2',OctStart,OctEnd);
        IF Cust.FIND('-') THEN BEGIN
          Cust.CALCFIELDS(Cust."Current Shares",Cust."Share Cap");
          IF (Cust."Current Shares" <> 0)   THEN BEGIN
            OctoberAmt:=(Cust."Current Shares")*(2/12);
          END;
        END;
        
        
        //November
        Cust.RESET;
        Cust.SETCURRENTKEY("No.");
        Cust.SETRANGE(Cust."No.",MemberNo);
        Cust.SETFILTER(Cust."Date Filter",'%1..%2',NovStart,NovEnd);
        IF Cust.FIND('-') THEN BEGIN
          Cust.CALCFIELDS(Cust."Current Shares",Cust."Share Cap");
          IF (Cust."Current Shares" <> 0)   THEN BEGIN
            NovemberAmt:=(Cust."Current Shares")*(1/12);
          END;
        END;
        
        TotalAmt:=LastYearAmt+JanuaryAmt+FebruaryAmt+MarchAmt+AprilAmt+MayAmt+JuneAmt+JulyAmt+AugustAmt+SpetemberAmt+OctoberAmt+NovemberAmt;
        EXIT(TotalAmt);
        */

    end;


    procedure KnCheckIfMemberIsDefaulter(MemberNo: Code[20]): Boolean
    var
        ObjLoansRegister: Record 51371;
    begin
        ObjLoansRegister.Reset;
        ObjLoansRegister.SetRange(ObjLoansRegister."Client Code", MemberNo);
        ObjLoansRegister.SetRange(ObjLoansRegister.Defaulter, true);
        if ObjLoansRegister.Find('-') then
            exit(true)
        else
            exit(false)
    end;


    procedure FnSendEmail(EmpCode: Code[20]; TrainigSubject: Text)
    var
        HrEmployee: Record 51160;
        // SMTPMail: Codeunit "SMTP Mail";
        // SMTPSetup: Record "SMTP Mail Setup";
        FileName: Text[100];
        Attachment: Text[250];
        CompanyInfo: Record "Company Information";
        Email: Text[30];
        DisburesmentMessage: label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:9pt">Hello, Hope this finds you well</p><p style="font-family:Verdana,Arial;font-size:9pt">This is to confirm that your Training Application has been Approved </p><p style="font-family:Verdana,Arial;font-size:9pt">Training Subject <b>%2</b></p><br>Regards<p>%3</p><p><b>KENTOURS SACCO LTD</b></p>';
    begin
        // SMTPSetup.Get();
        // HrEmployee.Reset;
        // HrEmployee.SetRange(HrEmployee."No.", EmpCode);
        // if HrEmployee.Find('-') then begin
        //     Email := HrEmployee."E-Mail";
        //     if Email <> '' then begin
        //         SMTPMail.CreateMessage(SMTPSetup."Email Sender Name", SMTPSetup."Email Sender Address", Email, 'Training Approval', '', true);
        //         SMTPMail.AppendBody(StrSubstNo(DisburesmentMessage, HrEmployee."First Name", TrainigSubject, UserId));
        //         SMTPMail.AppendBody(SMTPSetup."Email Sender Name");
        //         SMTPMail.AppendBody('<br><br>');
        //         SMTPMail.AddAttachment(FileName, Attachment);
        //         SMTPMail.Send;
        //     end;
        // end;
    end;


    procedure KnGetLastPayrollPeriod(): Date
    var
        PayrollCalender: Record 51322;
        Period: Date;
    begin
        PayrollCalender.Reset;
        PayrollCalender.SetRange(PayrollCalender.Closed, false);
        if PayrollCalender.FindLast then begin
            Period := PayrollCalender."Date Opened";
        end;

        exit(Period);
    end;


    procedure fnInsertBridgingDetails(LoanType: Code[30]; LoanNo: Code[30]; MemberNo: Code[30]; RelaxedConditions: Boolean)
    var
        LoansRegister: Record 51371;
        LoanOffsetDetails: Record 51376;
    begin
        /*LoansRegister.RESET;
        LoansRegister.SETRANGE(LoansRegister."Client Code",MemberNo);
        LoansRegister.SETRANGE(LoansRegister."Loan Product Type",LoanType);
        LoansRegister.SETFILTER(LoansRegister."Outstanding Balance",'>%1',0);
        IF LoansRegister.FIND('-') THEN
          BEGIN
            LoanOffsetDetails.RESET;
            LoanOffsetDetails.SETRANGE(LoanOffsetDetails."Loan No.",LoanNo);
            IF LoanOffsetDetails.FINDSET THEN
              LoanOffsetDetails.DELETEALL;
        
            WITH LoanOffsetDetails DO
              BEGIN
                INIT;
                "Loan No.":=LoanNo;
                "Client Code":=MemberNo;
                Bridging:=TRUE;
                Relaxed:=RelaxedConditions;
                "Loan Top Up":=LoansRegister."Loan  No.";
                INSERT(TRUE);
              END;
        
            LoanOffsetDetails.RESET;
            LoanOffsetDetails.SETRANGE(LoanOffsetDetails."Loan No.",LoanNo);
            IF LoanOffsetDetails.FIND('-') THEN
              BEGIN
                LoanOffsetDetails.VALIDATE(LoanOffsetDetails."Loan Top Up");
                LoanOffsetDetails.MODIFY(TRUE);
              END;
          END;
        */

    end;


    procedure knCheckIfSubsequentDefaulterPayment(LoanNo: Code[30]): Boolean
    var
        LoansRegisterLocal: Record 51371;
    begin
        LoansRegisterLocal.Reset;
        if LoansRegisterLocal.Get(LoanNo) then begin
            if (LoansRegisterLocal.Attached) and (not LoansRegisterLocal.Reversed) then
                exit(true)
            else
                exit(false);
        end;
    end;


    procedure knGetInterestRate(LoanType: Code[40]; Instalments: Integer) IntRate: Decimal
    var
        LoanProductsSetup: Record 51381;
    begin
        /*LoanProductsSetup.RESET;
        IF LoanProductsSetup.GET(LoanType) THEN
          BEGIN
            IF Instalments<=LoanProductsSetup."Band I Maximum" THEN
              IntRate:=LoanProductsSetup."Interest rate"
            ELSE
              IntRate:=LoanProductsSetup."Interest Rate2"
          END;
        
        EXIT(IntRate);
        */

    end;


    procedure knInsertDataSheetMain(MemberNo: Code[20]; PayrollNo: Code[30]; EmployerCode: Code[70]; AdjustmentType: Option " ","Registration Fee","Rejoining Fee","Deposit Contriution","Share Capital","Insurance Contribution","Stock Payment","By Laws","Loan Adjustment","Demand Savings"; AdjustmentDate: Date; AdjustmentAmount: Decimal; LoanNo: Code[20]; LoanProductType: Code[40]; PrevAmount: Decimal)
    var
        DataSheetMain: Record 51417;
    begin
        DataSheetMain.Reset;
        DataSheetMain.SetRange(DataSheetMain."PF/Staff No", PayrollNo);
        DataSheetMain.SetRange(DataSheetMain.Employer, EmployerCode);
        DataSheetMain.SetRange(DataSheetMain."Adjustment Type", AdjustmentType);
        if DataSheetMain.Find('-') then
            DataSheetMain.DeleteAll;

        with DataSheetMain do begin
            Init;
            "Member No" := MemberNo;
            Validate("Member No");
            "PF/Staff No" := PayrollNo;
            Employer := EmployerCode;
            "Adjustment Type" := AdjustmentType;
            Date := AdjustmentDate;
            Amount := AdjustmentAmount;
            "Amount OFF" := PrevAmount;
            "Loan Type" := LoanProductType;
            "Remark/LoanNO" := LoanNo;
            Insert;
        end;
    end;


    procedure knInsertRefinanceDetails(LoanNo: Code[20]; LoanToRefinance: Code[20]; Relax: Boolean; ClientCode: Code[30]; LoanType: Code[30])
    var
        LoansRegister: Record 51371;
    begin
        /*LoansRegister.RESET;
        LoansRegister.SETRANGE(LoansRegister."Loan  No.",LoanNo);
        IF LoansRegister.FIND('-') THEN
          BEGIN
            LoanToRefinance:=knGetLoanToRefinance(LoanType,ClientCode);
            LoansRegister."Loan To Refinance":=LoanToRefinance;
            LoansRegister."Relax Refinance Condition":=Relax;
            LoansRegister.MODIFY(TRUE);
          END;
        */

    end;


    procedure knGetLoanToRefinance(LoanType: Code[40]; ClientCode: Code[30]) LoanNo: Code[20]
    var
        LoansRegister: Record 51371;
    begin
        /*LoansRegister.RESET;
        LoansRegister.SETRANGE(LoansRegister."Client Code",ClientCode);
        LoansRegister.SETRANGE(LoansRegister."Loan Product Type",LoanType);
        LoansRegister.SETFILTER(LoansRegister."Outstanding Balance",'>%1',0);
        IF LoansRegister.FINDFIRST THEN
          BEGIN
            LoanNo:=LoansRegister."Loan  No.";
          END;
        
        EXIT(LoanNo);
        */

    end;


    procedure knGetLoanTypeToRefinance() LoanType: Code[100]
    var
        LoanProductsSetup: Record 51381;
    begin
        /*LoanProductsSetup.RESET;
        LoanProductsSetup.SETRANGE(LoanProductsSetup.Refinanced,TRUE);
        IF LoanProductsSetup.FINDFIRST THEN
          BEGIN
            LoanType:=LoanProductsSetup.Code;
          END;
        
        EXIT(LoanType);
        */

    end;

    local procedure KnCheckIfperiodExist(MemberNo: Code[30]; Period: Date): Boolean
    var
        DemandSavingsInterestBuffer: Record 51915;
    begin
        /*DemandSavingsInterestBuffer.RESET;
        DemandSavingsInterestBuffer.SETRANGE(DemandSavingsInterestBuffer."Member No",MemberNo);
        DemandSavingsInterestBuffer.SETRANGE(DemandSavingsInterestBuffer.Period,Period);
        IF DemandSavingsInterestBuffer.FIND('-') THEN
          EXIT(TRUE)
        ELSE
          EXIT(FALSE);
        */

    end;


    procedure knGetDemandSavings(MemberNo: Code[30]; StartDate: Date; EndDate: Date) Amount: Decimal
    var
        MemberLedgEntry: Record 51365;
    begin
        /*MemberLedgEntry.RESET;
        MemberLedgEntry.SETRANGE(MemberLedgEntry."Customer No.",MemberNo);
        //MemberLedgEntry.SETRANGE(MemberLedgEntry."Transaction Type",MemberLedgEntry."Transaction Type"::"Demand Savings");
        MemberLedgEntry.SETFILTER(MemberLedgEntry."Posting Date",'>%1',StartDate);
        MemberLedgEntry.SETFILTER(MemberLedgEntry."Posting Date",'<%1',EndDate);
        IF MemberLedgEntry.FINDSET THEN
          BEGIN
            REPEAT
              IF (MemberLedgEntry."Transaction Type"=MemberLedgEntry."Transaction Type"::"Demand Savings") OR (MemberLedgEntry."Transaction Type"=MemberLedgEntry."Transaction Type"::"Demand Savings Withdrawal") THEN
              Amount:=Amount+MemberLedgEntry.Amount;
            UNTIL MemberLedgEntry.NEXT=0;
          END;
        
        EXIT(Amount);
        */

    end;


    procedure KnGetLoanBalancePremium(ClientCode: Code[20]) Amount: Decimal
    var
        ObjLoansRegister: Record 51371;
    begin
        ObjLoansRegister.Reset;
        ObjLoansRegister.SetRange(ObjLoansRegister."Client Code", ClientCode);
        ObjLoansRegister.SetRange(ObjLoansRegister."Loan Product Type", 'D302');
        if ObjLoansRegister.FindSet then begin
            repeat
                ObjLoansRegister.CalcFields("Outstanding Balance");
                Amount := Amount + ObjLoansRegister."Outstanding Balance";
            until ObjLoansRegister.Next = 0;
        end;

        exit(Amount);


        //*******calculate a third of a members netpay**********//
    end;


    procedure KnGetLoanBalanceRefinance(ClientCode: Code[20]) Amount: Decimal
    var
        ObjLoansRegister: Record 51371;
    begin
        ObjLoansRegister.Reset;
        ObjLoansRegister.SetRange(ObjLoansRegister."Client Code", ClientCode);
        ObjLoansRegister.SetRange(ObjLoansRegister."Loan Product Type", 'D312');
        if ObjLoansRegister.FindSet then begin
            repeat
                ObjLoansRegister.CalcFields("Outstanding Balance");
                Amount := Amount + ObjLoansRegister."Outstanding Balance";
            until ObjLoansRegister.Next = 0;
        end;

        exit(Amount);


        //*******calculate a third of a members netpay**********//
    end;


    procedure KnGetInterestBalanceOneLoan(LoanNo: Code[20]) Amount: Decimal
    var
        ObjLoansRegister: Record 51371;
    begin
        ObjLoansRegister.Reset;
        ObjLoansRegister.SetRange(ObjLoansRegister."Loan  No.", LoanNo);
        if ObjLoansRegister.Find('-') then begin
            ObjLoansRegister.CalcFields("Oustanding Interest");
            Amount := Amount + ObjLoansRegister."Oustanding Interest";
        end;

        exit(Amount);


        //*******calculate a third of a members netpay**********//
    end;


    procedure KnGetAMountGuaranteedByM(ClientCode: Code[20]; LoanNo: Code[20]) Amount: Decimal
    var
        ObjLoansGuaranteeDetails: Record 51372;
    begin
        ObjLoansGuaranteeDetails.Reset;
        ObjLoansGuaranteeDetails.SetRange(ObjLoansGuaranteeDetails."Member No", ClientCode);
        ObjLoansGuaranteeDetails.SetRange(ObjLoansGuaranteeDetails."Loan No", LoanNo);
        ObjLoansGuaranteeDetails.SetRange(ObjLoansGuaranteeDetails.Substituted, false);
        if ObjLoansGuaranteeDetails.FindSet then begin
            Amount := Amount + ObjLoansGuaranteeDetails."Amont Guaranteed";
        end;
        exit(Amount);

        //*************Get the total paid insurance of all years******//
    end;

    procedure FnPostRetinedDeposits(MemberR: Record 51364; DocNo: Code[20]; LoanNo: Code[20]; FreedAmt: Decimal; Dim1: Text[50]; Dim2: Text[50])
    var
        LineN: Integer;
        GenJournalLine: Record "Gen. Journal Line";
    begin

        //Delete journal line

        Temp.Get(UserId);
        Jtemplate := Temp."Payment Journal Template";
        JBatch := Temp."Payment Journal Batch";

        if Jtemplate = '' then begin
            Error('Ensure the payment Template is set up in Cash Office Setup');
        end;

        if JBatch = '' then begin
            Error('Ensure the payment Batch is set up in the Cash Office Setup')
        end;


        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", Jtemplate);
        GenJournalLine.SetRange("Journal Batch Name", JBatch);
        GenJournalLine.DeleteAll;
        //End of Deletion

        //Deposit
        LineN := LineN + 10000;
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := Jtemplate;
        GenJournalLine."Journal Batch Name" := JBatch;
        GenJournalLine."Line No." := LineN;
        GenJournalLine."Document No." := DocNo;
        GenJournalLine."Posting Date" := Today;
        GenJournalLine."External Document No." := LoanNo;
        GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
        GenJournalLine."Account No." := MemberR."No.";
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine.Description := 'Free Shares Retained on Repayment of loan attached to defaulter for -:' + MemberR.Name;
        //CALCFIELDS("Committed Shares");
        GenJournalLine.Amount := -ROUND(FreedAmt, 0.0005, '>');
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Benevolent Fund";
        GenJournalLine."Loan No" := LoanNo;
        GenJournalLine."Shortcut Dimension 1 Code" := Dim1;
        GenJournalLine."Shortcut Dimension 2 Code" := Dim2;
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;

        //Deposit
        LineN := LineN + 10000;
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := Jtemplate;
        GenJournalLine."Journal Batch Name" := JBatch;
        GenJournalLine."Line No." := LineN;
        GenJournalLine."Document No." := DocNo;
        GenJournalLine."Posting Date" := Today;
        GenJournalLine."External Document No." := LoanNo;
        GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
        GenJournalLine."Account No." := MemberR."No.";
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine.Description := 'Free Shares Retained on Repayment of loan attached to defaulter for -:' + MemberR.Name;
        //CALCFIELDS("Committed Shares");
        GenJournalLine.Amount := ROUND(FreedAmt, 0.0005, '>');
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::"Share Capital";
        GenJournalLine."Loan No" := LoanNo;
        GenJournalLine."Shortcut Dimension 1 Code" := Dim1;
        GenJournalLine."Shortcut Dimension 2 Code" := Dim2;
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;

        //Post New
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", Jtemplate);
        GenJournalLine.SetRange("Journal Batch Name", JBatch);
        if GenJournalLine.Find('-') then begin
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Batch", GenJournalLine);
        end;
    end;


    procedure KnGetUnallocatedFundsBalance(ClientCode: Code[20]) Amount: Decimal
    var
        ObjMembersRegister: Record 51364;
    begin
        ObjMembersRegister.Reset;
        ObjMembersRegister.SetRange(ObjMembersRegister."No.", ClientCode);
        if ObjMembersRegister.Find('-') then begin
            ObjMembersRegister.CalcFields(ObjMembersRegister."Un-allocated Funds");
            Amount := ObjMembersRegister."Un-allocated Funds";
        end;

        exit(Amount);


        //******************get the total amount of unpaid stock**************//
    end;


    procedure KnGetUnpaidByLaws(ClientCode: Code[20]) Amount: Decimal
    var
        ObjMembersRegister: Record 51364;
    begin
        /*ObjMembersRegister.RESET;
        ObjMembersRegister.SETRANGE(ObjMembersRegister."No.",ClientCode);
        IF ObjMembersRegister.FIND('-') THEN
          BEGIN
           ObjMembersRegister.CALCFIELDS(ObjMembersRegister."By Laws");
           Amount:=ObjMembersRegister."By Laws";
          END;
        
        EXIT(Amount);
        */
        //******************get the total amount of overpaid loans***********//

    end;


    procedure KnGetLoanBalanceBridging(ClientCode: Code[20]; BridgingType: Code[20]) Amount: Decimal
    var
        ObjLoansRegister: Record 51371;
    begin
        ObjLoansRegister.Reset;
        ObjLoansRegister.SetRange(ObjLoansRegister."Client Code", ClientCode);
        ObjLoansRegister.SetFilter(ObjLoansRegister."Loan Product Type", '<>%1', BridgingType);
        if ObjLoansRegister.FindSet then begin
            repeat
                ObjLoansRegister.CalcFields("Outstanding Balance");
                Amount := Amount + ObjLoansRegister."Outstanding Balance";
            until ObjLoansRegister.Next = 0;
        end;

        exit(Amount);


        //*******calculate a third of a members netpay**********//
    end;


    procedure KnGetLoanBalanceLns(ClientCode: Code[20]) Amount: Decimal
    var
        ObjLoansRegister: Record 51371;
    begin
        ObjLoansRegister.Reset;
        ObjLoansRegister.SetRange(ObjLoansRegister."Client Code", ClientCode);
        if ObjLoansRegister.FindSet then begin
            repeat
                ObjLoansRegister.CalcFields("Outstanding Balance");
                if ObjLoansRegister."Outstanding Balance" > 0 then
                    Amount := Amount + ObjLoansRegister."Outstanding Balance";
            until ObjLoansRegister.Next = 0;
        end;

        exit(Amount);


        //*******calculate a third of a members netpay**********//
    end;


    procedure KnGetLoanBalancePositive(ClientCode: Code[20]) Amount: Decimal
    var
        ObjLoansRegister: Record 51371;
    begin
        ObjLoansRegister.Reset;
        ObjLoansRegister.SetRange(ObjLoansRegister."Client Code", ClientCode);
        if ObjLoansRegister.FindSet then begin
            repeat
                ObjLoansRegister.CalcFields("Outstanding Balance");
                if ObjLoansRegister."Outstanding Balance" > 0 then
                    Amount := Amount + ObjLoansRegister."Outstanding Balance";
            until ObjLoansRegister.Next = 0;
        end;

        exit(Amount);


        //*******calculate a third of a members netpay**********//
    end;


    procedure KnGetLoanBalanceOverpaid(ClientCode: Code[20]) Amount: Decimal
    var
        ObjLoansRegister: Record 51371;
    begin
        ObjLoansRegister.Reset;
        ObjLoansRegister.SetRange(ObjLoansRegister."Client Code", ClientCode);
        if ObjLoansRegister.FindSet then begin
            repeat
                ObjLoansRegister.CalcFields("Outstanding Balance");
                if ObjLoansRegister."Outstanding Balance" < 0 then
                    Amount := Amount + ObjLoansRegister."Outstanding Balance";
            until ObjLoansRegister.Next = 0;
        end;

        exit(Amount);


        //*******calculate a third of a members netpay**********//
    end;

    procedure KnGetInterestForRemainingPeriod(LoanNN: Code[20]) totalInterest: Decimal
    var
        MemberMpay: Decimal;
        MemberInterestMpay: Decimal;
        LoansR: Record 51371;
        RemainingPeriod: Integer;
    begin

        if LoansR.Get(LoanNN) then begin
            RemainingPeriod := LoansR.Installments;//-KentoursFactory.KnGetCurrentPeriodForLoan(LoansR."Loan  No.");
            if (RemainingPeriod > 0) and (LoansR.Interest > 0) then begin
                LoansR.CalcFields("Outstanding Balance");
                MemberMpay := (LoansR.Interest / 12 / 100) / (1 - Power((1 + (LoansR.Interest / 12 / 100)), -RemainingPeriod)) * LoansR."Outstanding Balance";
                MemberInterestMpay := (MemberMpay - (LoansR."Outstanding Balance" / RemainingPeriod));
                totalInterest := MemberInterestMpay * RemainingPeriod;
            end;
            if totalInterest < 0 then
                totalInterest := 0;
        end;
    end;


    procedure FnGetLoanBalanceNoOverPayment(ClientCod: Code[20]; LoanProdType: Code[30]) LoanBal: Decimal
    var
        ObjLoanReg: Record 51371;
    begin
        LoanBal := 0;

        ObjLoanReg.Reset;
        ObjLoanReg.SetRange(ObjLoanReg."Client Code", ClientCod);
        ObjLoanReg.SetRange(ObjLoanReg."Loan Product Type", LoanProdType);
        if ObjLoanReg.Find('-') then begin
            repeat
                ObjLoanReg.CalcFields(ObjLoanReg."Outstanding Balance");
                if ObjLoanReg."Outstanding Balance" > 0 then
                    LoanBal := LoanBal + ObjLoanReg."Outstanding Balance";

            until ObjLoanReg.Next = 0;
        end;

        exit(LoanBal);
    end;


    procedure FnGetInterestBalanceNoOverPayment(ClientCod: Code[20]; LoanProdType: Code[30]) LoanBal: Decimal
    var
        ObjLoanReg: Record 51371;
    begin
        LoanBal := 0;

        ObjLoanReg.Reset;
        ObjLoanReg.SetRange(ObjLoanReg."Client Code", ClientCod);
        ObjLoanReg.SetRange(ObjLoanReg."Loan Product Type", LoanProdType);
        if ObjLoanReg.Find('-') then begin
            repeat
                ObjLoanReg.CalcFields(ObjLoanReg."Oustanding Interest");
                if ObjLoanReg."Oustanding Interest" > 0 then
                    LoanBal := LoanBal + ObjLoanReg."Oustanding Interest";

            until ObjLoanReg.Next = 0;
        end;

        exit(LoanBal);
    end;
}

