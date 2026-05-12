codeunit 50038 "Loan Classification-SASRA"
{
    trigger OnRun()
    begin

    end;

    procedure ClassifyLoansSASRA(LoanNo: Code[20]; datefilter: text[100])
    var
        LoanCount: Integer;
        DialogBox: Dialog;
        TotalLoans: Integer;
    begin
        LoanCount := 0;
        TotalLoans := 0;
        LoansRegister.Reset();
        LoansRegister.SetRange(LoansRegister."Loan  No.", LoanNo);
        LoansRegister.SetRange(LoansRegister.Posted, true);
        LoansRegister.SetFilter(LoansRegister."Date filter", datefilter);
        LoansRegister.SetAutoCalcFields(LoansRegister."Outstanding Balance", LoansRegister."Oustanding Interest");
        IF LoansRegister.Find('-') then begin
            //repeat
            //Reset The Loan
            LoansRegister."Amount in Arrears" := 0;
            LoansRegister."Interest In Arrears" := 0;
            LoansRegister."Principal In Arrears" := 0;
            LoansRegister."No of Days in Arrears" := 0;
            LoansRegister."No of Months in Arrears" := 0;
            LoansRegister."Loans Category-SASRA" := LoansRegister."Loans Category-SASRA"::" ";
            //...................................
            if LoansRegister."Outstanding Balance" <= 0 then begin
                FnUpdateLoanRecordZeroBal(LoansRegister."Loan  No.");
            end else
                if LoansRegister."Outstanding Balance" > 0 then begin
                    FnUpdateLoanRecordGreaterthanZeroBal(LoansRegister."Loan  No.", datefilter);
                end;
            LoansRegister.modify();
            //...................................
        end;
    end;

    local procedure FnUpdateLoanRecordZeroBal(LoanNo: Code[30])
    begin
        LoansRegister."Amount in Arrears" := 0;
        LoansRegister."Interest In Arrears" := 0;
        LoansRegister."Principal In Arrears" := 0;
        LoansRegister."No of Days in Arrears" := 0;
        LoansRegister."No of Months in Arrears" := 0;
        LoansRegister."Loans Category-SASRA" := LoansRegister."Loans Category-SASRA"::Perfoming;
    end;

    local procedure FnUpdateLoanRecordGreaterthanZeroBal(LoanNo: Code[30]; datefilter: Text[100])
    var
        ExpectedBalance: Decimal;
        PrincipalArrears: Decimal;
        MonthlyPrincipalRepayment: Decimal;
        NoOfMonthsInArrears: Decimal;
        NoOfDaysInArrears: Integer;
    begin
        //Get The Expected Balance As At Shedule
        ExpectedBalance := 0;
        ExpectedBalance := FnGetLoanExpectedBalance(LoanNo, datefilter);
        PrincipalArrears := 0;
        PrincipalArrears := (LoansRegister."Outstanding Balance" - ExpectedBalance);

        if PrincipalArrears > 1 then begin
            //Get Loan Monthly Principal Repayment(Amount/Installements)
            MonthlyPrincipalRepayment := 0;
            MonthlyPrincipalRepayment := Round(FnGetLoanAmount(LoanNo) / FnGetLoanInstallements(LoanNo), 1, '>');
            //Get No Of Months In Arrears
            NoOfMonthsInArrears := 0;
            IF MonthlyPrincipalRepayment <= 0 THEN begin
                if LoansRegister.Installments < 1 then begin
                    LoansRegister.Installments := 12;
                end;
                MonthlyPrincipalRepayment := Round(LoansRegister."Approved Amount" / LoansRegister.Installments, 1, '>');
            end;
            IF MonthlyPrincipalRepayment <= 0 THEN begin
                MonthlyPrincipalRepayment := LoansRegister."Outstanding Balance";
            end;
            IF MonthlyPrincipalRepayment <= 0 THEN begin
                MonthlyPrincipalRepayment := 1;
            end;
            NoOfMonthsInArrears := Round((PrincipalArrears / MonthlyPrincipalRepayment), 1, '>');
            //Get Days In Arrears
            NoOfDaysInArrears := 0;
            NoOfDaysInArrears := Round((PrincipalArrears / (MonthlyPrincipalRepayment / 30)), 1, '>');
            //Case To Update The Loan Category
            case
                NoOfMonthsInArrears of
                1:
                    begin
                        LoansRegister."Principal In Arrears" := PrincipalArrears;
                        LoansRegister."Interest In Arrears" := LoansRegister."Oustanding Interest";
                        LoansRegister."Amount in Arrears" := LoansRegister."Principal In Arrears" + LoansRegister."Interest In Arrears";
                        LoansRegister."Loans Category-SASRA" := LoansRegister."Loans Category-SASRA"::Watch;
                        LoansRegister."No of Months in Arrears" := NoOfMonthsInArrears;
                        LoansRegister."No of Days in Arrears" := NoOfDaysInArrears;
                    end;
                2, 3, 4, 5, 6:
                    begin
                        LoansRegister."Principal In Arrears" := PrincipalArrears;
                        LoansRegister."Interest In Arrears" := LoansRegister."Oustanding Interest";
                        LoansRegister."Amount in Arrears" := LoansRegister."Principal In Arrears" + LoansRegister."Interest In Arrears";
                        LoansRegister."Loans Category-SASRA" := LoansRegister."Loans Category-SASRA"::Substandard;
                        LoansRegister."No of Months in Arrears" := NoOfMonthsInArrears;
                        LoansRegister."No of Days in Arrears" := NoOfDaysInArrears;
                    end;
                7, 8, 9, 10, 11, 12:
                    begin
                        LoansRegister."Principal In Arrears" := PrincipalArrears;
                        LoansRegister."Interest In Arrears" := LoansRegister."Oustanding Interest";
                        LoansRegister."Amount in Arrears" := LoansRegister."Principal In Arrears" + LoansRegister."Interest In Arrears";
                        LoansRegister."Loans Category-SASRA" := LoansRegister."Loans Category-SASRA"::Doubtful;
                        LoansRegister."No of Months in Arrears" := NoOfMonthsInArrears;
                        LoansRegister."No of Days in Arrears" := NoOfDaysInArrears;
                    end;
                else begin
                    LoansRegister."Principal In Arrears" := PrincipalArrears;
                    LoansRegister."Interest In Arrears" := LoansRegister."Oustanding Interest";
                    LoansRegister."Amount in Arrears" := LoansRegister."Principal In Arrears" + LoansRegister."Interest In Arrears";
                    LoansRegister."Loans Category-SASRA" := LoansRegister."Loans Category-SASRA"::Loss;
                    LoansRegister."No of Months in Arrears" := NoOfMonthsInArrears;
                    LoansRegister."No of Days in Arrears" := NoOfDaysInArrears;
                end;
            end;
        end else
            if PrincipalArrears <= 1 then begin
                PrincipalArrears := 0;
                LoansRegister."Amount in Arrears" := 0;
                LoansRegister."Interest In Arrears" := LoansRegister."Oustanding Interest";
                LoansRegister."Principal In Arrears" := 0;
                LoansRegister."No of Days in Arrears" := 0;
                LoansRegister."No of Months in Arrears" := 0;
                LoansRegister."Loans Category-SASRA" := LoansRegister."Loans Category-SASRA"::Perfoming;
            end;
    end;

    procedure FnGetLoanExpectedBalance(LoanNo: Code[30]; datefilter: Text[100]): Decimal
    var
        LoanSchedule: record "Loan Repayment Schedule";
        SchedulePrincipleRepayments: Decimal;
        Sfactory: Codeunit "Swizzsoft Factory";
    begin
        SchedulePrincipleRepayments := 0;
        Sfactory.FnGeneratePostedLoansMissingRepaymentSchedule(LoanNo);
        SchedulePrincipleRepayments := 0;
        LoanSchedule.Reset();
        LoanSchedule.SetRange(LoanSchedule."Loan No.", LoanNo);
        LoanSchedule.SetFilter(LoanSchedule."Repayment Date", datefilter);
        if LoanSchedule.Find('-') then begin
            repeat
                SchedulePrincipleRepayments += LoanSchedule."Principal Repayment";
            until LoanSchedule.Next = 0;
        end;
        LoanSchedule.Reset();
        LoanSchedule.SetRange(LoanSchedule."Loan No.", LoanNo);
        if LoanSchedule.FindFirst() then begin
            exit(LoanSchedule."Loan Amount" - SchedulePrincipleRepayments);
        end;

    end;

    local procedure FnGetLoanAmount(LoanNo: Code[30]): Decimal
    var
        LoanSchedule: record "Loan Repayment Schedule";
        LoanAmount: Decimal;
    begin
        LoanAmount := 0;
        LoanSchedule.Reset();
        LoanSchedule.SetRange(LoanSchedule."Loan No.", LoanNo);
        if LoanSchedule.Find('-') then begin
            LoanAmount := LoanSchedule."Loan Amount";
        end;
        exit(LoanAmount);
    end;

    local procedure FnGetLoanInstallements(LoanNo: Code[30]): Decimal
    var
        LoanSchedule: record "Loan Repayment Schedule";
        NoOfInstallements: Decimal;
    begin
        NoOfInstallements := 0;
        LoanSchedule.Reset();
        LoanSchedule.SetRange(LoanSchedule."Loan No.", LoanNo);
        if LoanSchedule.Find('-') then begin
            NoOfInstallements := LoanSchedule.Count();
            exit(NoOfInstallements);
        end;
        NoOfInstallements := 12;
        exit(NoOfInstallements);
    end;


    var
        LoansRegister: Record "Loans Register";
}