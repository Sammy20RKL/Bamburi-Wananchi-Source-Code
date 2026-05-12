#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 50009 "Swizzsoft Factory"
{

    trigger OnRun()
    begin
        //MESSAGE(FORMAT(FnGetFosaAccountBalance('0804-019444-00')));
        //MESSAGE(FORMAT(FnGetCashierTransactionBudding('CASHWD-S',1000)));
        //MESSAGE(FORMAT(FnGetMinimumAllowedBalance('CURRENT')));
        //FnSendSMS('Cashwi','my message','Fosaaccount');
        //MESSAGE(FnGetMpesaAccount());
        //FnUpdateMonthlyContributions();
        //FnReturnRetirementDate('006987');

        /*ObjLoans.RESET;
        ObjLoans.SETRANGE("Loan  No.",'BLN_00044');
        ObjLoans.SETFILTER("Date filter",'..'+FORMAT(20181111D));
        IF ObjLoans.FIND('-') THEN BEGIN
          ObjLoans.CALCFIELDS("Scheduled Principal to Date");
        MESSAGE('%1 %2',FnGetPrincipalDueFiltered(ObjLoans,'..'+FORMAT(TODAY)), ObjLoans."Scheduled Principal to Date");
        END;
        */

        FnPostGnlJournalLine('GENERAL', 'OB SURE');

        Message('Posting Completed successfully');


    end;

    var
        ObjTransCharges: Record 51442;
        UserSetup: Record "User Setup";
        ObjVendor: Record Vendor;
        ObjProducts: Record 51436;
        ObjMemberLedgerEntry: Record 51365;
        ObjLoans: Record 51371;
        ObjBanks: Record "Bank Account";
        ObjLoanProductSetup: Record 51381;
        ObjProductCharges: Record 51383;
        ObjMembers: Record 51364;
        ObjMembers2: Record 51364;
        ObjGenSetUp: Record 51398;
        ObjCompInfo: Record "Company Information";
        BAND1: Decimal;
        BAND2: Decimal;
        BAND3: Decimal;
        BAND4: Decimal;
        BAND5: Decimal;
        ObjMembershipWithdrawal: Record 51400;
        ObjSalesSetup: Record 51399;
        NoSeriesMgt: Codeunit "No. Series";
        ObjNoSeriesManagement: Codeunit "No. Series";
        ObjNextNo: Code[20];
        PostingDate: Date;
        ObjNoSeries: Record "No. Series Line";


    procedure FnGenerateRepaymentSchedule(LoanNumber: Code[50])
    var
        LoansRec: Record "Loans Register";
        TotalsInSchedule: Decimal;
        LoanAmountSchedule: Decimal;
        RSchedule: Record "Loan Repayment Schedule";
        LoanproductSetup: Record "Loan Products Setup";
        LoanAmount: Decimal;
        InterestRate: Decimal;
        RepayPeriod: Integer;
        InitialInstal: Decimal;
        LBalance: Decimal;
        RunDate: Date;
        InstalNo: Decimal;
        TotalMRepay: Decimal;
        LInterest: Decimal;
        LPrincipal: Decimal;
        GrPrinciple: Integer;
        GrInterest: Integer;
        RepayCode: Code[10];
        WhichDay: Integer;
        InterestVarianceOnlyNafaka: Decimal;
    begin
        LoansRec.Reset;
        LoansRec.SetRange(LoansRec."Loan  No.", LoanNumber);
        LoansRec.SetFilter(LoansRec."Approved Amount", '>%1', 0);
        //LoansRec.SetFilter(LoansRec.Posted, '=%1', false);
        if LoansRec.Find('-') then begin
            if (LoansRec."Repayment Start Date" <> 0D) then begin
                LInterest := 0;
                LPrincipal := 0;

                LoansRec.TestField(LoansRec."Loan Disbursement Date");
                LoansRec.TestField(LoansRec."Repayment Start Date");

                RSchedule.Reset;
                RSchedule.SetRange(RSchedule."Loan No.", LoansRec."Loan  No.");
                RSchedule.DeleteAll;

                LoanAmount := LoansRec."Approved Amount";
                InterestRate := LoansRec.Interest;
                RepayPeriod := LoansRec.Installments;
                InitialInstal := LoansRec.Installments + LoansRec."Grace Period - Principle (M)";
                LBalance := LoansRec."Approved Amount";
                RunDate := LoansRec."Repayment Start Date";
                InstalNo := 0;

                //Repayment Frequency
                if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Daily then
                    RunDate := CalcDate('-1D', RunDate)
                else
                    if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Weekly then
                        RunDate := CalcDate('-1W', RunDate)
                    else
                        if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Monthly then
                            RunDate := CalcDate('-1M', RunDate)
                        else
                            if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Quaterly then
                                RunDate := CalcDate('-1Q', RunDate);
                //Repayment Frequency


                repeat
                    InstalNo := InstalNo + 1;
                    //Repayment Frequency
                    if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Daily then
                        RunDate := CalcDate('1D', RunDate)
                    else
                        if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Weekly then
                            RunDate := CalcDate('1W', RunDate)
                        else
                            if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Monthly then
                                RunDate := CalcDate('1M', RunDate)
                            else
                                if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Quaterly then
                                    RunDate := CalcDate('1Q', RunDate);

                    LoanproductSetup.Get(LoansRec."Loan Product Type");
                    if LoanproductSetup."Repayment Method" = LoanproductSetup."repayment method"::Amortised then begin
                        LoansRec.TestField(LoansRec.Installments);
                        TotalMRepay := ROUND((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -(RepayPeriod))) * (LoanAmount), 0.0001, '>');
                        LInterest := ROUND(LBalance / 100 / 12 * InterestRate, 0.0001, '>');
                        LPrincipal := TotalMRepay - LInterest;

                        // TotalMRepay := (InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -RepayPeriod)) * LoanAmount;
                        // LInterest := ROUND(LBalance / 100 / 12 * InterestRate);
                        // LPrincipal := TotalMRepay - LInterest;
                    end else if LoanproductSetup."Repayment Method" = LoanproductSetup."repayment method"::"Straight Line" then begin
                        LoansRec.TestField(LoansRec.Interest);
                        LoansRec.TestField(LoansRec.Installments);
                        LPrincipal := LoanAmount / RepayPeriod;
                        LInterest := (InterestRate / 12 / 100) * LoanAmount;// / RepayPeriod;
                    end else if LoanproductSetup."Repayment Method" = LoanproductSetup."repayment method"::"Reducing Balance" then begin
                        LoansRec.TestField(LoansRec.Interest);
                        LoansRec.TestField(LoansRec.Installments);
                        LPrincipal := LoanAmount / RepayPeriod;
                        LInterest := (InterestRate / 12 / 100) * LBalance;
                    end else if LoanproductSetup."Repayment Method" = LoanproductSetup."Repayment Method"::"One-Time" then begin
                        LoansRec.TestField(LoansRec.Interest);
                        LoansRec.TestField(LoansRec.Installments);
                        LInterest := (LoanAmount * InterestRate / 100) / RepayPeriod;
                        if InstalNo = RepayPeriod then
                            LPrincipal := LoanAmount
                        else
                            LPrincipal := 0;
                    end;


                    //Grace Period
                    if GrPrinciple > 0 then begin
                        LPrincipal := 0
                    end else begin
                        LBalance := LBalance - LPrincipal;

                    end;

                    GrPrinciple := GrPrinciple - 1;
                    GrInterest := GrInterest - 1;
                    Evaluate(RepayCode, Format(InstalNo));


                    RSchedule.Init;
                    RSchedule."Repayment Code" := RepayCode;
                    RSchedule."Interest Rate" := InterestRate;
                    RSchedule."Loan No." := LoansRec."Loan  No.";
                    RSchedule."Loan Amount" := LoanAmount;
                    RSchedule."Instalment No" := InstalNo;
                    //RSchedule."Repayment Date" := RunDate;
                    RSchedule."Repayment Date" := CalcDate('CM', RunDate);
                    RSchedule."Member No." := LoansRec."Client Code";
                    RSchedule."Loan Category" := LoansRec."Loan Product Type";
                    RSchedule."Monthly Repayment" := LInterest + LPrincipal;
                    RSchedule."Monthly Interest" := LInterest;
                    RSchedule."Principal Repayment" := LPrincipal;
                    RSchedule."Loan Balance" := LBalance;
                    RSchedule.Insert;
                    WhichDay := Date2dwy(RSchedule."Repayment Date", 1);
                until LBalance < 1;

            end;
        end;
        // RSchedule.Reset;
        // RSchedule.SetRange(RSchedule."Loan No.", LoansRec."Loan  No.");
        // if RSchedule.FindLast() then begin   
        // LoansRec."Expected Date of Completion" := RSchedule."Repayment Date";
        // LoansRec.Modify;
        // end;

        Commit;

    end;

    procedure FnGenerateRepaymentScheduleMerged(LoanNumber: Code[50]): Boolean
    var
        LoansRec: Record "Loans Register";
        RSchedule: Record "Loan Repayment Schedule";
        LoanAmount: Decimal;
        InterestRate: Decimal;
        RepayPeriod: Integer;
        InitialInstal: Integer;
        LBalance: Decimal;
        RunDate: Date;
        InstalNo: Integer;
        TotalMRepay: Decimal;
        LInterest: Decimal;
        LPrincipal: Decimal;
        GrPrinciple: Integer;
        GrInterest: Integer;
        RepayCode: Code[30];
        RepaymentStartDate: Date;
        RepaymentFrequency: Integer;
        DateOffsetFormula: Text;
    begin
        // Find loan
        LoansRec.Reset;
        LoansRec.SetRange(LoansRec."Loan  No.", LoanNumber);
        LoansRec.SetFilter(LoansRec."Approved Amount", '>%1', 0);
        if not LoansRec.Find('-') then
            exit(false);

        // Required fields check
        LoansRec.TestField(LoansRec."Loan Disbursement Date");
        LoansRec.TestField(LoansRec."Repayment Start Date");

        // Prepare
        GrPrinciple := LoansRec."Grace Period - Principle (M)";
        GrInterest := LoansRec."Grace Period - Interest (M)";

        // Clear existing schedule
        RSchedule.Reset;
        RSchedule.SetRange(RSchedule."Loan No.", LoansRec."Loan  No.");
        RSchedule.DeleteAll;

        LoanAmount := LoansRec."Approved Amount";
        InterestRate := LoansRec.Interest;
        RepayPeriod := LoansRec.Installments;
        InitialInstal := LoansRec.Installments + LoansRec."Grace Period - Principle (M)";
        LBalance := LoanAmount;
        RepaymentStartDate := LoansRec."Repayment Start Date";
        InstalNo := 0;

        // Choose date offset formula base (we will compute RunDate per installment so first instal uses RepaymentStartDate)
        if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Daily then
            DateOffsetFormula := 'D'
        else
            if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Weekly then
                DateOffsetFormula := 'W'
            else
                if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Monthly then
                    DateOffsetFormula := 'M'
                else
                    if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Quaterly then
                        DateOffsetFormula := 'Q'
                    else
                        Error('Unsupported repayment frequency');

        // Repeat until balance is paid
        repeat
            InstalNo += 1;

            // compute current RunDate based on RepaymentStartDate and instal index
            case DateOffsetFormula of
                'D':
                    RunDate := CalcDate(Format(InstalNo - 1) + 'D', RepaymentStartDate);
                'W':
                    RunDate := CalcDate(Format(InstalNo - 1) + 'W', RepaymentStartDate);
                'M':
                    RunDate := CalcDate(Format(InstalNo - 1) + 'M', RepaymentStartDate);
                'Q':
                    RunDate := CalcDate(Format(InstalNo - 1) + 'Q', RepaymentStartDate);
            end;

            // Calculate repayment amounts depending on method
            if LoansRec."Repayment Method" = LoansRec."repayment method"::Amortised then begin
                LoansRec.TestField(LoansRec.Installments);
                LoansRec.TestField(LoansRec.Interest);

                // Monthly rate used for formula (InterestRate assumed annual percentage)
                TotalMRepay := (InterestRate / 12 / 100) / (1 - Power(1 + (InterestRate / 12 / 100), -RepayPeriod)) * LoanAmount;
                TotalMRepay := ROUND(TotalMRepay, 0.0001, '>');

                LInterest := ROUND(LBalance / 100 / 12 * InterestRate, 0.0001, '>');
                LPrincipal := TotalMRepay - LInterest;
            end else
                if LoansRec."Repayment Method" = LoansRec."repayment method"::"Straight Line" then begin
                    LoansRec.TestField(LoansRec.Installments);
                    LoansRec.TestField(LoansRec.Interest);

                    LPrincipal := ROUND(LoanAmount / RepayPeriod, 0.0001, '>');
                    // Interest spread evenly across instalments (annual -> monthly fraction applied to whole loan)
                    LInterest := ROUND((InterestRate / 12 / 100) * LoanAmount, 0.0001, '>');
                end else
                    if LoansRec."Repayment Method" = LoansRec."repayment method"::"Reducing Balance" then begin
                        LoansRec.TestField(LoansRec.Installments);
                        LoansRec.TestField(LoansRec.Interest);

                        LPrincipal := ROUND(LoanAmount / RepayPeriod, 0.0001, '>');
                        LInterest := ROUND((InterestRate / 12 / 100) * LBalance, 0.0001, '>');
                    end else
                        if LoansRec."Repayment Method" = LoansRec."repayment method"::Constants then begin
                            LoansRec.TestField(LoansRec.Repayment);

                            if LBalance < LoansRec.Repayment then
                                LPrincipal := LBalance
                            else
                                LPrincipal := LoansRec.Repayment;

                            LInterest := ROUND(LoansRec."Loan Interest Repayment" / LoansRec.Installments, 0.0001, '>');
                        end else
                            Error('Unsupported repayment method');

            // Grace period handling
            if GrPrinciple > 0 then
                LPrincipal := 0
            else
                LBalance := LBalance - LPrincipal;

            if GrInterest > 0 then
                LInterest := 0;

            GrPrinciple -= 1;
            GrInterest -= 1;

            // avoid negative small balances due to rounding
            if LBalance < 0 then
                LBalance := 0;

            Evaluate(RepayCode, Format(InstalNo));

            // Insert schedule line
            RSchedule.Init;
            RSchedule."Repayment Code" := RepayCode;
            RSchedule."Interest Rate" := InterestRate;
            RSchedule."Loan No." := LoansRec."Loan  No.";
            RSchedule."Loan Amount" := LoanAmount;
            RSchedule."Instalment No" := InstalNo;
            RSchedule."Repayment Date" := RunDate;
            RSchedule."Member No." := LoansRec."Client Code";
            RSchedule."Loan Category" := LoansRec."Loan Product Type";
            RSchedule."Monthly Repayment" := LInterest + LPrincipal;
            RSchedule."Monthly Interest" := LInterest;
            RSchedule."Principal Repayment" := LPrincipal;
            RSchedule."Loan Balance" := LBalance;
            RSchedule.Insert;

        until LBalance <= 0;

        Commit;
        exit(true);
    end;

    procedure FnGetCashierTransactionBudding(TransactionType: Code[100]; TransAmount: Decimal) TCharge: Decimal
    begin
        ObjTransCharges.Reset;
        ObjTransCharges.SetRange(ObjTransCharges."Transaction Type", TransactionType);
        ObjTransCharges.SetFilter(ObjTransCharges."Minimum Amount", '<=%1', TransAmount);
        ObjTransCharges.SetFilter(ObjTransCharges."Maximum Amount", '>=%1', TransAmount);
        TCharge := 0;
        if ObjTransCharges.FindSet then begin
            repeat
                TCharge := TCharge + ObjTransCharges."Charge Amount" + ObjTransCharges."Charge Amount" * 0.1;
            until ObjTransCharges.Next = 0;
        end;
    end;


    procedure FnGetUserBranch() branchCode: Code[20]
    begin
        UserSetup.Reset;
        UserSetup.SetRange(UserSetup."User id", UserId);
        if UserSetup.Find('-') then begin
            branchCode := UserSetup."Branch";
        end;
        exit(branchCode);
    end;

    procedure FnGetMemberApplicationAMLRiskRating(MemberNo: Code[20])
    var
        VarCategoryScore: Integer;
        VarResidencyScore: Integer;
        VarNatureofBusinessScore: Integer;
        VarEntityScore: Integer;
        VarIndustryScore: Integer;
        VarLenghtOfRelationshipScore: Integer;
        VarInternationalTradeScore: Integer;
        VarElectronicPaymentScore: Integer;
        // VarCardTypeScore: Integer;
        VarAccountTypeScore: Integer;
        // VarChannelTakenScore: Integer;
        VarAccountTypeOption: Option "International Wire Transfers","Local Wire Transfers","Mobile Transfers","None of the Above","Fixed/Call Deposit Accounts","KSA/Imara/MJA/Heritage)","Account with Sealed Safe deposit","Account with  Open Safe Deposit","All Loan Accounts",BOSA," Ufalme","ATM Debit",Credit,Both,"None","Non-face to face channels","Unsolicited Account Origination e.g. Walk-Ins","Cheque book",Others;
        MemberTotalRiskRatingScore: Decimal;
        MemberNetRiskScore: Decimal;
        ObjMemberDueDiligence: Record "Member Due Diligence Measures";
        ObjDueDiligenceSetup: Record "Member Due Diligence Measures";
        VarRiskRatingDescription: Text[50];
        VarRefereeScore: Decimal;
        VarRefereeRiskRate: Text;
        ObjCustRiskRates: Record "Customer Risk Rating";
        ObjRefereeSetup: Record "Referee Risk Rating Scale";
        ObjMemberRiskRate: Record "Individual Customer Risk Rate";
        ObjControlRiskRating: Record "Control Risk Rating";
        VarControlRiskRating: Decimal;
        ObjMembershipApplication: Record "Membership Applications";
        VarAccountTypeScoreVer1: Decimal;
        VarAccountTypeScoreVer2: Decimal;
        VarAccountTypeScoreVer3: Decimal;
        ObjMemberRiskRating: Record "Individual Customer Risk Rate2";
        ObjNetRiskScale: Record "Member Gross Risk Rating Scale";
        ObjProductsApp: Record "Membership Reg. Products Appli";// "Membership Applied Products";
        ObjProductRiskRating: Record "Product Risk Rating";
        VarAccountTypeOptionVer1: Option "International Wire Transfers","Local Wire Transfers","Mobile Transfers","None of the Above","Fixed/Call Deposit Accounts","KSA/Imara/MJA/Heritage)","Account with Sealed Safe deposit","Account with  Open Safe Deposit","All Loan Accounts",BOSA," Ufalme","ATM Debit",Credit,Both,"None","Non-face to face channels","Unsolicited Account Origination e.g. Walk-Ins","Cheque book",Others;
        VarAccountTypeOptionVer2: Option "International Wire Transfers","Local Wire Transfers","Mobile Transfers","None of the Above","Fixed/Call Deposit Accounts","KSA/Imara/MJA/Heritage)","Account with Sealed Safe deposit","Account with  Open Safe Deposit","All Loan Accounts",BOSA," Ufalme","ATM Debit",Credit,Both,"None","Non-face to face channels","Unsolicited Account Origination e.g. Walk-Ins","Cheque book",Others;
        VarAccountTypeOptionVer3: Option "International Wire Transfers","Local Wire Transfers","Mobile Transfers","None of the Above","Fixed/Call Deposit Accounts","KSA/Imara/MJA/Heritage)","Account with Sealed Safe deposit","Account with  Open Safe Deposit","All Loan Accounts",BOSA," Ufalme","ATM Debit",Credit,Both,"None","Non-face to face channels","Unsolicited Account Origination e.g. Walk-Ins","Cheque book",Others;
    begin

        ObjMembershipApplication.Reset;
        ObjMembershipApplication.SetRange(ObjMembershipApplication."No.", MemberNo);
        if ObjMembershipApplication.FindSet then begin
            ObjCustRiskRates.Reset;
            ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::Individuals);
            ObjCustRiskRates.SetRange(ObjCustRiskRates."Sub Category", ObjMembershipApplication."Individual Category");
            if ObjCustRiskRates.FindSet then begin
                VarCategoryScore := ObjCustRiskRates."Risk Score";

            end;
        end;


        ObjMembershipApplication.Reset;
        ObjMembershipApplication.SetRange(ObjMembershipApplication."No.", MemberNo);
        if ObjMembershipApplication.FindSet then begin
            ObjCustRiskRates.Reset;
            ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::Entities);
            ObjCustRiskRates.SetRange(ObjCustRiskRates."Sub Category", ObjMembershipApplication.Entities);
            if ObjCustRiskRates.FindSet then begin
                VarEntityScore := ObjCustRiskRates."Risk Score";

            end;
        end;

        ObjMembershipApplication.Reset;
        ObjMembershipApplication.SetRange(ObjMembershipApplication."No.", MemberNo);
        if ObjMembershipApplication.FindSet then begin
            ObjCustRiskRates.Reset;
            ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::"Residency Status");
            ObjCustRiskRates.SetRange(ObjCustRiskRates."Sub Category", ObjMembershipApplication."Member Residency Status");
            if ObjCustRiskRates.FindSet then begin
                VarResidencyScore := ObjCustRiskRates."Risk Score";
            end;
        end;


        ObjMembershipApplication.Reset;
        ObjMembershipApplication.SetRange(ObjMembershipApplication."No.", MemberNo);
        if ObjMembershipApplication.FindSet then begin
            //=============================================================Exisiting Referee
            ObjMemberRiskRate.Reset;
            ObjMemberRiskRate.SetRange(ObjMemberRiskRate."Membership Application No", ObjMembershipApplication."Referee Member No");
            if ObjMemberRiskRate.FindSet then begin
                if ObjMembershipApplication."Referee Member No" <> '' then begin

                    ObjRefereeSetup.Reset;
                    if ObjRefereeSetup.FindSet then begin
                        repeat
                            if (ObjMemberRiskRate."GROSS CUSTOMER AML RISK RATING" >= ObjRefereeSetup."Minimum Risk Rate") and
                              (ObjMemberRiskRate."GROSS CUSTOMER AML RISK RATING" <= ObjRefereeSetup."Maximum Risk Rate") then begin
                                VarRefereeScore := ObjRefereeSetup.Score;
                                VarRefereeRiskRate := ObjRefereeSetup.Description;
                            end;
                        until ObjRefereeSetup.Next = 0;
                    end;
                end;

                //=============================================================No Referee
                if ObjMembershipApplication."Referee Member No" = '' then begin
                    ObjRefereeSetup.Reset;
                    ObjRefereeSetup.SetFilter(ObjRefereeSetup.Description, '%1', 'Others with no referee');
                    if ObjRefereeSetup.FindSet then begin
                        VarRefereeScore := ObjRefereeSetup.Score;
                        VarRefereeRiskRate := 'Others with no referee';
                    end;
                end;
            end;


            ObjCustRiskRates.Reset;
            ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::"Residency Status");
            ObjCustRiskRates.SetRange(ObjCustRiskRates."Sub Category", ObjMembershipApplication."Member Residency Status");
            if ObjCustRiskRates.FindSet then begin
                VarResidencyScore := ObjCustRiskRates."Risk Score";
            end;
        end;

        ObjMembershipApplication.Reset;
        ObjMembershipApplication.SetRange(ObjMembershipApplication."No.", MemberNo);
        if ObjMembershipApplication.FindSet then begin
            ObjCustRiskRates.Reset;
            ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::Industry);
            ObjCustRiskRates.SetRange(ObjCustRiskRates."Sub Category", ObjMembershipApplication."Industry Type");
            if ObjCustRiskRates.FindSet then begin
                VarIndustryScore := ObjCustRiskRates."Risk Score";
            end;
        end;

        ObjMembershipApplication.Reset;
        ObjMembershipApplication.SetRange(ObjMembershipApplication."No.", MemberNo);
        if ObjMembershipApplication.FindSet then begin
            ObjCustRiskRates.Reset;
            ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::"Length Of Relationship");
            ObjCustRiskRates.SetRange(ObjCustRiskRates."Sub Category", ObjMembershipApplication."Length Of Relationship");
            if ObjCustRiskRates.FindSet then begin
                VarLenghtOfRelationshipScore := ObjCustRiskRates."Risk Score";
            end;
        end;

        ObjMembershipApplication.Reset;
        ObjMembershipApplication.SetRange(ObjMembershipApplication."No.", MemberNo);
        if ObjMembershipApplication.FindSet then begin
            ObjCustRiskRates.Reset;
            ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::"International Trade");
            ObjCustRiskRates.SetRange(ObjCustRiskRates."Sub Category", ObjMembershipApplication."International Trade");
            if ObjCustRiskRates.FindSet then begin
                VarInternationalTradeScore := ObjCustRiskRates."Risk Score";
            end;
        end;


        ObjMembershipApplication.Reset;
        ObjMembershipApplication.SetRange(ObjMembershipApplication."No.", MemberNo);
        if ObjMembershipApplication.FindSet then begin
            ObjProductRiskRating.Reset;
            ObjProductRiskRating.SetCurrentkey(ObjProductRiskRating."Product Type Code");
            ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Category", ObjProductRiskRating."product category"::"Electronic Payment");
            ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Type Code", ObjMembershipApplication."Electronic Payment");
            if ObjProductRiskRating.FindSet then begin
                VarElectronicPaymentScore := ObjProductRiskRating."Risk Score";
            end;
        end;


        //ObjProductRiskRating.GET();
        // ObjMembershipApplication.Reset;
        // ObjMembershipApplication.SetRange(ObjMembershipApplication."No.", MemberNo);
        // if ObjMembershipApplication.FindSet then begin

        //     ObjProductRiskRating.Reset;
        //     ObjProductRiskRating.SetCurrentkey(ObjProductRiskRating."Product Type Code");
        //     ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Category", ObjProductRiskRating."product category"::Cards);
        //     ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Type Code", ObjMembershipApplication."Cards Type Taken");
        //     if ObjProductRiskRating.FindSet then begin
        //         VarCardTypeScore := ObjProductRiskRating."Risk Score";
        //     end;
        // end;

        ObjProductRiskRating.Reset;
        ObjProductRiskRating.SetCurrentkey(ObjProductRiskRating."Product Type Code");
        ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Category", ObjProductRiskRating."product category"::Accounts);
        ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Type Code", ObjMembershipApplication."Accounts Type Taken");
        if ObjProductRiskRating.FindSet then begin
            VarAccountTypeScore := ObjProductRiskRating."Risk Score";
        end;

        // ObjProductRiskRating.Reset;
        // ObjProductRiskRating.SetCurrentkey(ObjProductRiskRating."Product Type Code");
        // ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Category", ObjProductRiskRating."product category"::Others);
        // ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Type Code", ObjMembershipApplication."Others(Channels)");
        // if ObjProductRiskRating.FindSet then begin
        //     VarChannelTakenScore := ObjProductRiskRating."Risk Score";
        // end;

        ObjProductsApp.Reset;
        ObjProductsApp.SetRange(ObjProductsApp."Membership Applicaton No", MemberNo);
        // ObjProductsApp.SetFilter(ObjProductsApp."Product Category", '<>%1', ObjProductsApp."Product Category"::FOSA);
        if ObjProductsApp.FindSet then begin
            repeat
                ObjProductRiskRating.Reset;
                ObjProductRiskRating.SetCurrentkey(ObjProductRiskRating."Product Type");
                ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Category", ObjProductRiskRating."product category"::Accounts);
                ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Type", ObjProductRiskRating."product type"::Credit);
                if ObjProductRiskRating.FindSet then begin
                    VarAccountTypeScoreVer1 := ObjProductRiskRating."Risk Score";
                    VarAccountTypeOptionVer1 := ObjProductRiskRating."product type"::Credit;
                    VarAccountTypeScore := ObjProductRiskRating."Risk Score";
                    VarAccountTypeOption := ObjProductRiskRating."product type"::Credit;
                end;
            until ObjProductsApp.Next = 0;
        end;

        ObjProductsApp.Reset;
        ObjProductsApp.SetRange(ObjProductsApp."Membership Applicaton No", MemberNo);
        // ObjProductsApp.SetFilter(ObjProductsApp."Product Category", '%1', ObjProductsApp."Product Category"::FOSA);
        //ObjProductsApp.SetFilter(ObjProductsApp.Product, '<>%1|%2', '503', '506');
        if ObjProductsApp.FindSet then begin

            repeat
                ObjProductRiskRating.Reset;
                ObjProductRiskRating.SetCurrentkey(ObjProductRiskRating."Product Type");
                ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Category", ObjProductRiskRating."product category"::Accounts);
                ObjProductRiskRating.SetFilter(ObjProductRiskRating."Product Type Code", '%1', ObjProductRiskRating."Product Type Code"::"FOSA(KSA");// 'Ordinary Savings');
                if ObjProductRiskRating.FindSet then begin
                    VarAccountTypeScoreVer2 := ObjProductRiskRating."Risk Score";
                    VarAccountTypeOptionVer2 := ObjProductRiskRating."product type"::Both;
                    VarAccountTypeScore := ObjProductRiskRating."Risk Score";
                    VarAccountTypeOption := ObjProductRiskRating."product type"::Both;
                end;
            until ObjProductsApp.Next = 0;
        end;




        if (VarAccountTypeScoreVer1 > VarAccountTypeScoreVer2) and (VarAccountTypeScoreVer1 > VarAccountTypeScoreVer3) then begin
            VarAccountTypeScore := VarAccountTypeScoreVer1;
            VarAccountTypeOption := VarAccountTypeOptionVer1
        end else
            if (VarAccountTypeScoreVer2 > VarAccountTypeScoreVer1) and (VarAccountTypeScoreVer2 > VarAccountTypeScoreVer3) then begin
                VarAccountTypeScore := VarAccountTypeScoreVer2;
                VarAccountTypeOption := VarAccountTypeOptionVer2
            end else
                if (VarAccountTypeScoreVer3 > VarAccountTypeScoreVer1) and (VarAccountTypeScoreVer3 > VarAccountTypeScoreVer2) then begin
                    VarAccountTypeScore := VarAccountTypeScoreVer3;
                    VarAccountTypeOption := VarAccountTypeOptionVer3
                end;


        //Create Entries on Membership Risk Rating Table
        ObjMemberRiskRating.Reset;
        ObjMemberRiskRating.SetRange(ObjMemberRiskRating."Membership Application No", MemberNo);
        if ObjMemberRiskRating.FindSet then begin
            ObjMemberRiskRating.DeleteAll;
        end;


        //===============================================Get Control Risk Rating
        ObjControlRiskRating.Reset;
        if ObjControlRiskRating.FindSet then begin
            ObjControlRiskRating.CalcSums(ObjControlRiskRating."Control Weight Aggregate");
            VarControlRiskRating := ObjControlRiskRating."Control Weight Aggregate";
        end;




        ObjMemberRiskRating.Init;
        ObjMemberRiskRating."Membership Application No" := MemberNo;

        ObjMemberRiskRating."What is the Customer Category?" := ObjMembershipApplication."Individual Category";
        ObjMemberRiskRating."Customer Category Score" := VarCategoryScore;
        ObjMemberRiskRating."What is the Member residency?" := ObjMembershipApplication."Member Residency Status";
        ObjMemberRiskRating."Member Residency Score" := VarResidencyScore;
        ObjMemberRiskRating."Cust Employment Risk?" := ObjMembershipApplication.Entities;
        ObjMemberRiskRating."Cust Employment Risk Score" := VarEntityScore;
        ObjMemberRiskRating."Cust Business Risk Industry?" := ObjMembershipApplication."Industry Type";
        ObjMemberRiskRating."Cust Bus. Risk Industry Score" := VarIndustryScore;
        ObjMemberRiskRating."Lenght Of Relationship?" := ObjMembershipApplication."Length Of Relationship";
        ObjMemberRiskRating."Length Of Relation Score" := VarLenghtOfRelationshipScore;
        ObjMemberRiskRating."Cust Involved in Intern. Trade" := ObjMembershipApplication."International Trade";
        ObjMemberRiskRating."Involve in Inter. Trade Score" := VarInternationalTradeScore;
        ObjMemberRiskRating."Account Type Taken?" := Format(VarAccountTypeOption);
        ObjMemberRiskRating."Account Type Taken Score" := VarAccountTypeScore;
        //ObjMemberRiskRating."Card Type Taken" := ObjMembershipApplication."Cards Type Taken";
        // ObjMemberRiskRating."Card Type Taken Score" := VarCardTypeScore;
        // ObjMemberRiskRating."Channel Taken?" := ObjMembershipApplication."Others(Channels)";
        // ObjMemberRiskRating."Channel Taken Score" := VarChannelTakenScore;
        ObjMemberRiskRating."Electronic Payments?" := ObjMembershipApplication."Electronic Payment";
        ObjMemberRiskRating."Referee Score" := VarRefereeScore;
        ObjMemberRiskRating."Member Referee Rate" := VarRefereeRiskRate;
        ObjMemberRiskRating."Electronic Payments Score" := VarElectronicPaymentScore;
        MemberTotalRiskRatingScore := VarCategoryScore + VarEntityScore + VarIndustryScore + VarInternationalTradeScore + VarRefereeScore + VarLenghtOfRelationshipScore + VarResidencyScore + VarAccountTypeScore
        + VarElectronicPaymentScore;
        ObjMemberRiskRating."GROSS CUSTOMER AML RISK RATING" := MemberTotalRiskRatingScore;
        ObjMemberRiskRating."BANK'S CONTROL RISK RATING" := VarControlRiskRating;
        ObjMemberRiskRating."CUSTOMER NET RISK RATING" := ROUND(ObjMemberRiskRating."GROSS CUSTOMER AML RISK RATING" / ObjMemberRiskRating."BANK'S CONTROL RISK RATING", 0.01, '>');
        MemberNetRiskScore := MemberTotalRiskRatingScore / VarControlRiskRating;
        ObjMemberRiskRating.Insert(true);


        ObjNetRiskScale.Reset;
        if ObjNetRiskScale.FindSet then begin
            repeat
                if (MemberTotalRiskRatingScore >= ObjNetRiskScale."Minimum Risk Rate") and (MemberTotalRiskRatingScore <= ObjNetRiskScale."Maximum Risk Rate") then begin
                    ObjMemberRiskRating."Risk Rate Scale" := ObjNetRiskScale."Risk Scale";
                    VarRiskRatingDescription := ObjNetRiskScale.Description;
                end;
            until ObjNetRiskScale.Next = 0;
        end else begin
            ObjMemberRiskRating."Risk Rate Scale" := MemberTotalRiskRatingScore;
        end;

        ObjMemberRiskRating.Validate(ObjMemberRiskRating."Membership Application No");
        ObjMemberRiskRating.Modify;


        ObjMemberDueDiligence.Reset;
        ObjMemberDueDiligence.SetRange(ObjMemberDueDiligence."Member No", MemberNo);
        if ObjMemberDueDiligence.FindSet then begin
            ObjMemberDueDiligence.DeleteAll;
        end;

        ObjDueDiligenceSetup.Reset;
        ObjDueDiligenceSetup.SetRange(ObjDueDiligenceSetup."Risk Rating Level", ObjMemberRiskRating."Risk Rate Scale");
        if ObjDueDiligenceSetup.FindSet then begin
            repeat
                ObjMemberDueDiligence.Init;
                ObjMemberDueDiligence."Member No" := MemberNo;
                if ObjMembershipApplication.Get(MemberNo) then begin
                    ObjMemberDueDiligence."Member Name" := ObjMembershipApplication.Name;
                end;
                ObjMemberDueDiligence."Due Diligence No" := ObjDueDiligenceSetup."Due Diligence No";
                ObjMemberDueDiligence."Risk Rating Level" := ObjMemberRiskRating."Risk Rate Scale";
                ObjMemberDueDiligence."Risk Rating Scale" := VarRiskRatingDescription;
                ObjMemberDueDiligence."Due Diligence Type" := ObjDueDiligenceSetup."Due Diligence Type";
                ObjMemberDueDiligence."Due Diligence Measure" := ObjDueDiligenceSetup."Due Diligence Measure";
                ObjMemberDueDiligence.Insert;
            until ObjDueDiligenceSetup.Next = 0;
        end;

        ObjMembershipApplication.Reset;
        ObjMembershipApplication.SetRange(ObjMembershipApplication."No.", MemberNo);
        if ObjMembershipApplication.Find('-') then begin
            if (MemberNetRiskScore > 0) and (MemberNetRiskScore < 4) then begin
                ObjMembershipApplication."Member Risk Level" := ObjMembershipApplication."Member Risk Level"::"Low Risk";
            end else
                if (MemberNetRiskScore > 4) and (MemberNetRiskScore < 8) then begin
                    ObjMembershipApplication."Member Risk Level" := ObjMembershipApplication."Member Risk Level"::"Medium Risk";
                end else
                    ObjMembershipApplication."Member Risk Level" := ObjMembershipApplication."Member Risk Level"::"High Risk";

            ObjMembershipApplication."Due Diligence Measure" := Format(MemberNetRiskScore);
            //ObjMembershipApplication."Due Diligence Measure" := ObjDueDiligenceSetup."Due Diligence Type";
            ObjMembershipApplication.Modify;
        end;
    end;

    procedure FnSendSMS(SMSSource: Text; SMSBody: Text; CurrentAccountNo: Text; MobileNumber: Text)
    var
        SMSMessage: Record 51471;
        iEntryNo: Integer;
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
    end;


    procedure FnCreateGnlJournalLine(TemplateName: Text; BatchName: Text; DocumentNo: Code[30]; LineNo: Integer; TransactionType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account"; AccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee,Member,Investor; AccountNo: Code[50]; TransactionDate: Date; TransactionAmount: Decimal; DimensionActivity: Code[40]; ExternalDocumentNo: Code[50]; TransactionDescription: Text; LoanNumber: Code[50])
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := TemplateName;
        GenJournalLine."Journal Batch Name" := BatchName;
        GenJournalLine."Document No." := DocumentNo;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := AccountType;
        GenJournalLine."Account No." := AccountNo;
        GenJournalLine."Transaction Type" := TransactionType;
        GenJournalLine."Loan No" := LoanNumber;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := TransactionDate;
        GenJournalLine.Description := TransactionDescription;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := TransactionAmount;
        GenJournalLine."External Document No." := ExternalDocumentNo;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Shortcut Dimension 1 Code" := DimensionActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := FnGetUserBranch();
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;
    end;


    procedure FnGetFosaAccountBalance(Acc: Code[30]) Bal: Decimal
    begin
        if ObjVendor.Get(Acc) then begin
            ObjVendor.CalcFields(ObjVendor."Balance (LCY)", ObjVendor."ATM Transactions", ObjVendor."Mobile Transactions", ObjVendor."Uncleared Cheques");
            Bal := ObjVendor."Balance (LCY)" - (ObjVendor."ATM Transactions" + ObjVendor."Mobile Transactions" + FnGetMinimumAllowedBalance(ObjVendor."Account Type"));
        end
    end;

    local procedure FnGetMinimumAllowedBalance(ProductCode: Code[60]) MinimumBalance: Decimal
    begin
        ObjProducts.Reset;
        ObjProducts.SetRange(ObjProducts.Code, ProductCode);
        if ObjProducts.Find('-') then
            MinimumBalance := ObjProducts."Minimum Balance";
    end;

    procedure FnCreateGnlJournalLineBalancedCashier(TemplateName: Text; BatchName: Text; DocumentNo: Code[30]; LineNo: Integer; TransactionType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account"; AccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Member,Investor; AccountNo: Code[50]; TransactionDate: Date; TransactionAmount: Decimal; DimensionActivity: Code[40]; ExternalDocumentNo: Code[50]; TransactionDescription: Text; LoanNumber: Code[50]; BalancingAccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Member; BalancingAccountNo: Code[40]; OverdraftNo: Code[100]; OverDraftTransaction: Option " ","Overdraft Granted","Overdraft Paid","Interest Accrued","Interest paid")
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
        GenJournalLine."Shortcut Dimension 2 Code" := FnGetMemberBranchUsingFosaAccount(AccountNo);
        GenJournalLine."Overdraft codes" := OverDraftTransaction;
        GenJournalLine."Overdraft NO" := OverdraftNo;
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;
    end;


    local procedure FnGetMemberLoanBalance(LoanNo: Code[50]; DateFilter: Date; TotalBalance: Decimal)
    begin
        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Loan  No.", LoanNo);
        ObjLoans.SetFilter(ObjLoans."Date filter", '..%1', DateFilter);
        if ObjMemberLedgerEntry.FindSet then begin
            TotalBalance := TotalBalance + ObjMemberLedgerEntry."Amount (LCY)";
        end;
    end;


    procedure FnGetTellerTillNo() TellerTillNo: Code[40]
    begin
        ObjBanks.Reset;
        ObjBanks.SetRange(ObjBanks."Account Type", ObjBanks."account type"::Cashier);
        ObjBanks.SetRange(ObjBanks.CashierID, UserId);
        if ObjBanks.Find('-') then begin
            TellerTillNo := ObjBanks."No.";
        end;
        exit(TellerTillNo);
    end;


    procedure FnGetMpesaAccount() TellerTillNo: Code[40]
    begin
        ObjBanks.Reset;
        ObjBanks.SetRange(ObjBanks."Account Type", ObjBanks."account type"::Treasury);
        ObjBanks.SetRange(ObjBanks."Bank Account No.", FnGetUserBranch());
        if ObjBanks.Find('-') then begin
            TellerTillNo := ObjBanks."No.";
        end;
        exit(TellerTillNo);
    end;


    procedure FnGetChargeFee(ProductCode: Code[50]; InsuredAmount: Decimal; ChargeType: Code[100]) FCharged: Decimal
    begin
        if ObjLoanProductSetup.Get(ProductCode) then begin
            ObjProductCharges.Reset;
            ObjProductCharges.SetRange(ObjProductCharges."Product Code", ProductCode);
            ObjProductCharges.SetRange(ObjProductCharges.Code, ChargeType);
            if ObjProductCharges.Find('-') then begin
                if ObjProductCharges."Use Perc" = true then begin
                    FCharged := InsuredAmount * (ObjProductCharges.Percentage / 100);
                end
                else
                    FCharged := ObjProductCharges.Amount;
            end;
        end;
        exit(FCharged);
    end;


    procedure FnGetChargeAccount(ProductCode: Code[50]; MemberCategory: Option Single,Joint,Corporate,Group,Parish,Church,"Church Department",Staff; ChargeType: Code[100]) ChargeGLAccount: Code[50]
    begin
        if ObjLoanProductSetup.Get(ProductCode) then begin
            ObjProductCharges.Reset;
            ObjProductCharges.SetRange(ObjProductCharges."Product Code", ProductCode);
            ObjProductCharges.SetRange(ObjProductCharges.Code, ChargeType);
            if ObjProductCharges.Find('-') then begin
                ChargeGLAccount := ObjProductCharges."G/L Account";
            end;
        end;
        exit(ChargeGLAccount);
    end;

    local procedure FnUpdateMonthlyContributions()
    begin
        ObjMembers.Reset;
        ObjMembers.SetCurrentkey(ObjMembers."No.");
        ObjMembers.SetRange(ObjMembers."Monthly Contribution", 0.0);
        if ObjMembers.FindSet then begin
            repeat
                ObjMembers2."Monthly Contribution" := 500;
                ObjMembers2.Modify;
            until ObjMembers.Next = 0;
            Message('Succesfully done');
        end;
    end;


    procedure FnGetUserBranchB(varUserId: Code[100]) branchCode: Code[20]
    begin
        UserSetup.Reset;
        UserSetup.SetRange(UserSetup."User Id", varUserId);
        if UserSetup.Find('-') then begin
            branchCode := UserSetup."Branch";
        end;
        exit(branchCode);
    end;


    procedure FnGetMemberBranch(MemberNo: Code[100]) MemberBranch: Code[100]
    var
        ObjMemberLocal: Record 51364;
    begin
        ObjMemberLocal.Reset;
        ObjMemberLocal.SetRange(ObjMemberLocal."No.", MemberNo);
        if ObjMemberLocal.Find('-') then begin
            // MemberBranch := ObjMemberLocal."Global Dimension 2 Code ";
        end;
        exit(MemberBranch);
    end;

    local procedure FnReturnRetirementDate(MemberNo: Code[50]): Date
    var
        ObjMembers: Record 51364;
    begin
        ObjGenSetUp.Get();
        ObjMembers.Reset;
        ObjMembers.SetRange(ObjMembers."No.", MemberNo);
        if ObjMembers.Find('-') then
            Message(Format(CalcDate(ObjGenSetUp."Retirement Age", ObjMembers."Date of Birth")));
        exit(CalcDate(ObjGenSetUp."Retirement Age", ObjMembers."Date of Birth"));
    end;


    procedure FnGetTransferFee(DisbursementMode: Option " ",Cheque,"Bank Transfer",EFT,RTGS,"Cheque NonMember"): Decimal
    var
        TransferFee: Decimal;
    begin
        ObjGenSetUp.Get();
        case DisbursementMode of
            Disbursementmode::"Bank Transfer":
                TransferFee := ObjGenSetUp."Loan Trasfer Fee-FOSA";

            Disbursementmode::Cheque:
                TransferFee := ObjGenSetUp."Loan Trasfer Fee-Cheque";

            Disbursementmode::"Cheque NonMember":
                TransferFee := ObjGenSetUp."Loan Trasfer Fee-EFT";

            Disbursementmode::EFT:
                TransferFee := ObjGenSetUp."Loan Trasfer Fee-RTGS";
        end;
        exit(TransferFee);
    end;


    procedure FnGetFosaAccount(MemberNo: Code[50]) FosaAccount: Code[50]
    var
        ObjMembers: Record 51364;
    begin
        ObjMembers.Reset;
        ObjMembers.SetRange(ObjMembers."No.", MemberNo);
        if ObjMembers.Find('-') then begin
            // FosaAccount := ObjMembers."FOSA Account No.";
        end;
        exit(FosaAccount);
    end;


    procedure FnClearGnlJournalLine(TemplateName: Text; BatchName: Text)
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenJournalLine.Reset;
        GenJournalLine.SetRange(GenJournalLine."Journal Template Name", TemplateName);
        GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", BatchName);
        if GenJournalLine.FindSet then begin
            GenJournalLine.DeleteAll;
        end;
    end;


    procedure FnPostGnlJournalLine(TemplateName: Text; BatchName: Text)
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenJournalLine.Reset;
        GenJournalLine.SetRange(GenJournalLine."Journal Template Name", TemplateName);
        GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", BatchName);
        if GenJournalLine.FindSet then begin
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Line", GenJournalLine);
        end;
    end;


    procedure FnCreateGnlJournalLineBalanced(TemplateName: Text; BatchName: Text; DocumentNo: Code[30]; LineNo: Integer; TransactionType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account","Loan Insurance Charged","Loan Insurance Paid"; AccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee,Member,Investor; AccountNo: Code[50]; TransactionDate: Date; TransactionDescription: Text; BalancingAccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Member,Investor; BalancingAccountNo: Code[50]; TransactionAmount: Decimal; DimensionActivity: Code[40]; LoanNo: Code[20])
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := TemplateName;
        GenJournalLine."Journal Batch Name" := BatchName;
        GenJournalLine."Document No." := DocumentNo;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Transaction Type" := TransactionType;
        GenJournalLine."Account Type" := AccountType;
        GenJournalLine."Account No." := AccountNo;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := TransactionDate;
        GenJournalLine.Description := TransactionDescription;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := TransactionAmount;
        GenJournalLine."Loan No" := LoanNo;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Bal. Account Type" := BalancingAccountType;
        GenJournalLine."Bal. Account No." := BalancingAccountNo;
        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
        GenJournalLine."Shortcut Dimension 1 Code" := DimensionActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := FnGetUserBranch();
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;
    end;


    procedure FnChargeExcise(ChargeCode: Code[100]): Boolean
    var
        ObjProductCharges: Record 51382;
    begin
        ObjProductCharges.Reset;
        ObjProductCharges.SetRange(Code, ChargeCode);
        if ObjProductCharges.Find('-') then
            exit(ObjProductCharges."Charge Excise");
    end;


    procedure FnGetInterestDueTodate(ObjLoans: Record 51371): Decimal
    var
        ObjLoanRegister: Record 51371;
    begin
        ObjLoans.SetFilter("Date filter", '..' + Format(Today));
        ObjLoans.CalcFields("Schedule Interest to Date", "Outstanding Balance");
        exit(ObjLoans."Schedule Interest to Date");
    end;


    procedure FnGetPhoneNumber(ObjLoans: Record 51371): Code[50]
    begin
        ObjMembers.Reset;
        ObjMembers.SetRange("No.", ObjLoans."Client Code");
        if ObjMembers.Find('-') then
            exit(ObjMembers."Mobile Phone No");
    end;

    local procedure FnBoosterLoansDisbursement(ObjLoanDetails: Record 51371): Code[40]
    var
        GenJournalLine: Record "Gen. Journal Line";
        CUNoSeriesManagement: Codeunit "No. Series";
        DocNumber: Code[100];
        loanTypes: Record 51381;
        ObjLoanX: Record 51371;
        LoansRec: Record 51371;
        Cust: Record 51364;
    begin
        loanTypes.Reset;
        loanTypes.SetRange(loanTypes.Code, 'BLOAN');
        if loanTypes.Find('-') then begin
            DocNumber := CUNoSeriesManagement.GetNextNo('LOANSB', 0D, true);
            LoansRec.Init;
            LoansRec."Loan  No." := DocNumber;
            // LoansRec.INSERT;

            if LoansRec.Get('BLN_00041') then begin
                LoansRec."Client Code" := ObjLoanDetails."Client Code";
                LoansRec.Validate(LoansRec."Client Code");
                LoansRec."Loan Product Type" := 'BLOAN';
                LoansRec.Validate(LoansRec."Loan Product Type");
                LoansRec.Interest := ObjLoanDetails.Interest;
                LoansRec."Loan Status" := LoansRec."loan status"::Issued;
                LoansRec."Application Date" := ObjLoanDetails."Application Date";
                LoansRec."Issued Date" := ObjLoanDetails."Posting Date";
                LoansRec."Loan Disbursement Date" := ObjLoanDetails."Loan Disbursement Date";
                LoansRec.Validate(LoansRec."Loan Disbursement Date");
                LoansRec."Mode of Disbursement" := LoansRec."mode of disbursement"::"Bank Transfer";
                LoansRec."Repayment Start Date" := ObjLoanDetails."Repayment Start Date";
                LoansRec."Global Dimension 1 Code" := 'BOSA';
                LoansRec."Global Dimension 2 Code" := FnGetUserBranch();
                LoansRec.Source := ObjLoanDetails.Source;
                LoansRec."Approval Status" := ObjLoanDetails."Approval Status";
                LoansRec.Repayment := ObjLoanDetails."Boosted Amount";
                LoansRec."Requested Amount" := ObjLoanDetails."Boosted Amount";
                LoansRec."Approved Amount" := ObjLoanDetails."Boosted Amount";
                LoansRec.Interest := ObjLoanDetails.Interest;
                LoansRec."Mode of Disbursement" := LoansRec."mode of disbursement"::"Bank Transfer";
                LoansRec.Posted := true;
                LoansRec."Advice Date" := Today;
                LoansRec.Modify;
            end;
        end;
        exit(DocNumber);
    end;

    procedure FnGetInterestDueFiltered(ObjLoans: Record 51371; DateFilter: Text): Decimal
    var
        ObjLoanRegister: Record 51371;
    begin
        ObjLoans.SetFilter("Date filter", DateFilter);
        ObjLoans.CalcFields("Schedule Interest to Date", "Outstanding Balance");
        exit(ObjLoans."Schedule Interest to Date");
    end;


    procedure FnGetPAYEBudCharge(ChargeCode: Code[10]): Decimal
    var
        ObjpayeCharges: Record 51478;
    begin
        ObjpayeCharges.Reset;
        ObjpayeCharges.SetRange("Tax Band", ChargeCode);
        if ObjpayeCharges.FindFirst then
            exit(ObjpayeCharges."Taxable Amount" * ObjpayeCharges.Percentage / 100);
    end;


    procedure FnPayeRate(ChargeCode: Code[10]): Decimal
    var
        ObjpayeCharges: Record 51478;
    begin
        ObjpayeCharges.Reset;
        ObjpayeCharges.SetRange("Tax Band", ChargeCode);
        if ObjpayeCharges.FindFirst then
            exit(ObjpayeCharges.Percentage / 100);
    end;

    procedure FnGetMemberBranchUsingFosaAccount(MemberNo: Code[100]) MemberBranch: Code[100]
    var
        ObjMemberLocal: Record Customer;
    begin
        ObjMemberLocal.Reset;
        ObjMemberLocal.SetRange(ObjMemberLocal."FOSA Account", MemberNo);
        if ObjMemberLocal.Find('-') then begin
            MemberBranch := ObjMemberLocal."Global Dimension 2 Code";
        end;
        exit(MemberBranch);

    end;



    procedure FnCalculatePaye(Chargeable: Decimal) PAYE: Decimal
    var
        TAXABLEPAY: Record "PAYE Brackets Credit";
        Taxrelief: Decimal;
        OTrelief: Decimal;
    begin
        PAYE := 0;
        if TAXABLEPAY.Find('-') then begin
            repeat
                if Chargeable > 0 then begin
                    case TAXABLEPAY."Tax Band" of
                        '01':
                            begin
                                if Chargeable > TAXABLEPAY."Upper Limit" then begin
                                    BAND1 := FnGetPAYEBudCharge('01');
                                    Chargeable := Chargeable - TAXABLEPAY."Taxable Amount";
                                end else begin
                                    if Chargeable > TAXABLEPAY."Taxable Amount" then begin
                                        BAND1 := FnGetPAYEBudCharge('01');
                                        Chargeable := Chargeable - TAXABLEPAY."Taxable Amount";
                                    end else begin
                                        BAND1 := Chargeable * FnPayeRate('01');
                                        Chargeable := 0;
                                    end;
                                end;
                            end;
                        '02':
                            begin
                                if Chargeable > TAXABLEPAY."Upper Limit" then begin
                                    BAND2 := FnGetPAYEBudCharge('02');
                                    Chargeable := Chargeable - TAXABLEPAY."Taxable Amount";
                                end else begin
                                    if Chargeable > TAXABLEPAY."Taxable Amount" then begin
                                        BAND2 := FnGetPAYEBudCharge('02');
                                        Chargeable := Chargeable - TAXABLEPAY."Taxable Amount";
                                    end else begin
                                        BAND2 := Chargeable * FnPayeRate('02');
                                        Chargeable := 0;
                                    end;
                                end;
                            end;
                        '03':
                            begin
                                if Chargeable > TAXABLEPAY."Upper Limit" then begin
                                    BAND3 := FnGetPAYEBudCharge('03');
                                    Chargeable := Chargeable - TAXABLEPAY."Taxable Amount";
                                end else begin
                                    if Chargeable > TAXABLEPAY."Taxable Amount" then begin
                                        BAND3 := FnGetPAYEBudCharge('03');
                                        Chargeable := Chargeable - TAXABLEPAY."Taxable Amount";
                                    end else begin
                                        BAND3 := Chargeable * FnPayeRate('03');
                                        Chargeable := 0;
                                    end;
                                end;
                            end;
                        '04':
                            begin
                                if Chargeable > TAXABLEPAY."Upper Limit" then begin
                                    BAND4 := FnGetPAYEBudCharge('04');
                                    Chargeable := Chargeable - TAXABLEPAY."Taxable Amount";
                                end else begin
                                    if Chargeable > TAXABLEPAY."Taxable Amount" then begin
                                        BAND4 := FnGetPAYEBudCharge('04');
                                        Chargeable := Chargeable - TAXABLEPAY."Taxable Amount";
                                    end else begin
                                        BAND4 := Chargeable * FnPayeRate('04');
                                        Chargeable := 0;
                                    end;
                                end;
                            end;
                        '05':
                            begin
                                BAND5 := Chargeable * FnPayeRate('05');
                            end;
                    end;
                end;
            until TAXABLEPAY.Next = 0;
        end;
        exit(BAND1 + BAND2 + BAND3 + BAND4 + BAND5 - 1280);
    end;

    procedure FnCreateGnlJournalLineBalanced(TemplateName: Text; BatchName: Text; DocumentNo: Code[30]; LineNo: Integer; TransactionType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account"; AccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Member,Investor; AccountNo: Code[50]; TransactionDate: Date; TransactionAmount: Decimal; DimensionActivity: Code[40]; ExternalDocumentNo: Code[50]; TransactionDescription: Text; LoanNumber: Code[50]; BalancingAccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Member; BalancingAccountNo: Code[40])
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
        GenJournalLine."Shortcut Dimension 2 Code" := FnGetUserBranch();
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;
    end;


    procedure FnGetUpfrontsTotal(ProductCode: Code[50]; InsuredAmount: Decimal) FCharged: Decimal
    var
        ObjLoanCharges: Record 51382;
    begin
        ObjProductCharges.Reset;
        ObjProductCharges.SetRange(ObjProductCharges."Product Code", ProductCode);
        if ObjProductCharges.Find('-') then begin
            repeat
                if ObjProductCharges."Use Perc" = true then begin
                    FCharged := InsuredAmount * (ObjProductCharges.Percentage / 100) + FCharged;
                    if ObjLoanCharges.Get(ObjProductCharges.Code) then begin
                        if ObjLoanCharges."Charge Excise" = true then
                            FCharged := FCharged + (InsuredAmount * (ObjProductCharges.Percentage / 100)) * 0.1;
                    end
                end
                else begin
                    FCharged := ObjProductCharges.Amount + FCharged;
                    if ObjLoanCharges.Get(ObjProductCharges.Code) then begin
                        if ObjLoanCharges."Charge Excise" = true then
                            FCharged := FCharged + ObjProductCharges.Amount * 0.1;
                    end
                end

            until ObjProductCharges.Next = 0;
        end;

        exit(FCharged);
    end;


    procedure FnGetPrincipalDueFiltered(ObjLoans: Record 51371; DateFilter: Text): Decimal
    var
        ObjLoanRegister: Record 51371;
    begin
        ObjLoans.SetFilter("Date filter", DateFilter);
        ObjLoans.CalcFields("Scheduled Principal to Date", "Outstanding Balance");
        exit(ObjLoans."Scheduled Principal to Date");
    end;


    procedure FnCreateMembershipWithdrawalApplication(MemberNo: Code[20]; ApplicationDate: Date; Reason: Option Relocation,"Financial Constraints","House/Group Challages","Join another Institution","Personal Reasons",Other; ClosureDate: Date)
    begin
        PostingDate := WorkDate;
        ObjSalesSetup.Get;
        //the below line is commented to avoid should be solved before these procedures are used
        //ObjNextNo := ObjNoSeriesManagement.TryGetNextNo(ObjSalesSetup."Closure  Nos", PostingDate);
        ObjNoSeries.Reset;
        ObjNoSeries.SetRange(ObjNoSeries."Series Code", ObjSalesSetup."Closure  Nos");
        if ObjNoSeries.FindSet then begin
            ObjNoSeries."Last No. Used" := IncStr(ObjNoSeries."Last No. Used");
            ObjNoSeries."Last Date Used" := Today;
            ObjNoSeries.Modify;
        end;


        ObjMembershipWithdrawal.Init;
        ObjMembershipWithdrawal."No." := ObjNextNo;
        ObjMembershipWithdrawal."Member No." := MemberNo;
        if ObjMembers.Get(MemberNo) then begin
            ObjMembershipWithdrawal."Member Name" := ObjMembers.Name;
        end;
        ObjMembershipWithdrawal."Withdrawal Application Date" := ApplicationDate;
        ObjMembershipWithdrawal."Closing Date" := ClosureDate;
        ObjMembershipWithdrawal."Reason For Withdrawal" := Reason;
        ObjMembershipWithdrawal.Insert;

        ObjMembershipWithdrawal.Validate(ObjMembershipWithdrawal."Member No.");
        ObjMembershipWithdrawal.Modify;

        Message('Withdrawal Application Created Succesfully,Application No  %1 ', ObjNextNo);
    end;

    procedure FnGeneratePostedLoansMissingRepaymentSchedule(LoanNumber: Code[50])
    var
        LoansRec: Record "Loans Register";
        RSchedule: Record "Loan Repayment Schedule";
        LoanProductSetup: Record "Loan Products Setup";
        LoanAmount: Decimal;
        InterestRate: Decimal;
        RepayPeriod: Integer;
        InitialInstal: Decimal;
        LBalance: Decimal;
        RunDate: Date;
        InstalNo: Decimal;
        TotalMRepay: Decimal;
        LInterest: Decimal;
        LPrincipal: Decimal;
        GrPrinciple: Integer;
        GrInterest: Integer;
        RepayCode: Code[10];
        WhichDay: Integer;
        InterestVarianceOnlyNafaka: Decimal;
    begin
        LoansRec.Reset;
        LoansRec.SetRange(LoansRec."Loan  No.", LoanNumber);
        LoansRec.SetFilter(LoansRec."Approved Amount", '>%1', 0);
        LoansRec.SetRange(LoansRec.Posted, true);
        LoanProductSetup.Reset;///LoanProductSetup."Repayment Method"
        LoanProductSetup.SetRange(LoanProductSetup.Code, LoansRec."Loan Product Type");
        LoanProductSetup.FindFirst;
        if LoansRec.Find('-') then begin
            if (LoansRec."Repayment Start Date" <> 0D) then begin
                if LoansRec."Loan Disbursement Date" = 0D then begin
                    LoansRec."Loan Disbursement Date" := 20170101D;
                end;
                if LoansRec."Repayment Start Date" = 0D then begin
                    LoansRec."Repayment Start Date" := 20170201D;
                end;
                LoansRec.TestField(LoansRec."Loan Disbursement Date");
                LoansRec.TestField(LoansRec."Repayment Start Date");
                if LoansRec.Interest = 0 then begin
                    LoansRec.Interest := 10;
                end;
                if LoansRec.Installments = 0 then begin
                    LoansRec.Installments := 12;
                end;

                RSchedule.Reset;
                RSchedule.SetRange(RSchedule."Loan No.", LoansRec."Loan  No.");
                if RSchedule.Find('-') = false then begin
                    LoanAmount := LoansRec."Approved Amount";
                    InterestRate := LoansRec.Interest;
                    RepayPeriod := LoansRec.Installments;
                    InitialInstal := LoansRec.Installments + LoansRec."Grace Period - Principle (M)";
                    LBalance := LoansRec."Approved Amount";
                    RunDate := LoansRec."Repayment Start Date";
                    InstalNo := 0;

                    //Repayment Frequency
                    if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Daily then
                        RunDate := CalcDate('-1D', RunDate)
                    else
                        if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Weekly then
                            RunDate := CalcDate('-1W', RunDate)
                        else
                            if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Monthly then
                                RunDate := CalcDate('-1M', RunDate)
                            else
                                if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Quaterly then
                                    RunDate := CalcDate('-1Q', RunDate);
                    //Repayment Frequency


                    repeat
                        InstalNo := InstalNo + 1;
                        //Repayment Frequency
                        if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Daily then
                            RunDate := CalcDate('1D', RunDate)
                        else
                            if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Weekly then
                                RunDate := CalcDate('1W', RunDate)
                            else
                                if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Monthly then
                                    RunDate := CalcDate('1M', RunDate)
                                else
                                    if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Quaterly then
                                        RunDate := CalcDate('1Q', RunDate);

                        if LoansRec."Repayment Method" = LoansRec."repayment method"::Amortised then begin
                            //LoansRec.TESTFIELD(LoansRec.Interest);
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
                            LPrincipal := LoanAmount / RepayPeriod;
                            LInterest := (InterestRate / 12 / 100) * LBalance;
                        end;

                        if LoansRec."Repayment Method" = LoansRec."repayment method"::Constants then begin
                            //LoansRec.TestField(LoansRec.Repayment);
                            // if LBalance < LoansRec.Repayment then
                            //     LPrincipal := LBalance
                            // else
                            LPrincipal := LoansRec.Repayment;
                            LInterest := Round((LoansRec."Loan Interest Repayment") / LoansRec.Installments, 0.0001, '>');
                        end;

                        //Grace Period
                        if GrPrinciple > 0 then begin
                            LPrincipal := 0
                        end else begin
                            LBalance := LBalance - LPrincipal;

                        end;

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
                        RSchedule."Principal Repayment" := LPrincipal;
                        RSchedule.Insert;
                        WhichDay := Date2dwy(RSchedule."Repayment Date", 1);
                    until LBalance < 1

                end;
            end;
        end;

        Commit;
    end;

    local procedure FnGenerateRepaymentScheduleReschedule(LoanNumber: Code[50])
    var
        LoansRec: Record 51371;
        RSchedule: Record 51375;
        LoanAmount: Decimal;
        InterestRate: Decimal;
        RepayPeriod: Integer;
        InitialInstal: Decimal;
        LBalance: Decimal;
        RunDate: Date;
        InstalNo: Decimal;
        TotalMRepay: Decimal;
        LInterest: Decimal;
        LPrincipal: Decimal;
        GrPrinciple: Integer;
        GrInterest: Integer;
        RepayCode: Code[10];
        WhichDay: Integer;
    begin
        LoansRec.Reset;
        LoansRec.SetRange(LoansRec."Loan  No.", LoanNumber);
        LoansRec.SetFilter(LoansRec."Approved Amount", '>%1', 0);
        LoansRec.SetFilter(LoansRec.Posted, '=%1', true);
        if LoansRec.Find('-') then begin
            LoansRec.CalcFields("Outstanding Balance");
            if (LoansRec."Loan Product Type" = 'DEFAULTER') and (LoansRec."Issued Date" <> 0D) and (LoansRec."Repayment Start Date" <> 0D) then begin
                LoansRec.TestField(LoansRec."Loan Disbursement Date");
                LoansRec.TestField(LoansRec."Repayment Start Date");

                RSchedule.Reset;
                RSchedule.SetRange(RSchedule."Loan No.", LoansRec."Loan  No.");
                RSchedule.DeleteAll;

                //LoanAmount:=LoansRec."Approved Amount";
                LoanAmount := LoansRec."Outstanding Balance";
                InterestRate := LoansRec.Interest;
                RepayPeriod := LoansRec.Installments;
                InitialInstal := LoansRec.Installments + LoansRec."Grace Period - Principle (M)";
                //LBalance:=LoansRec."Approved Amount";
                LBalance := LoansRec."Outstanding Balance";
                RunDate := LoansRec."Repayment Start Date";
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
                        //LoansRec.TESTFIELD(LoansRec.Interest);
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
                        LPrincipal := LoanAmount / RepayPeriod;
                        LInterest := (InterestRate / 12 / 100) * LBalance;
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
                    RSchedule."Repayment Date" := RunDate;
                    RSchedule."Member No." := LoansRec."Client Code";
                    RSchedule."Loan Category" := LoansRec."Loan Product Type";
                    RSchedule."Monthly Repayment" := LInterest + LPrincipal;
                    RSchedule."Monthly Interest" := LInterest;
                    RSchedule."Principal Repayment" := LPrincipal;
                    RSchedule.Insert;
                    WhichDay := Date2dwy(RSchedule."Repayment Date", 1);
                until LBalance < 1

            end;
        end;

        Commit;
    end;

}

