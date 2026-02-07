codeunit 56151 "Loans Defaulter Aging Codeunit"
{
    trigger OnRun()
    begin
        AsAt := Today;
        OnPreDataItem();
    end;

    var
        LoanApp: Record "Loans Register";
        DFilter: Text;
        "1Month": Decimal;
        instalMade: Integer;
        LoanPrincipleNew: Decimal;
        ScheduleBal: Decimal;
        "2Month": Decimal;
        "3Month": Decimal;
        Over3Month: Decimal;
        ShowLoan: Boolean;
        AsAt: Date;
        LastDueDate: Date;
        DFormula: DateFormula;
        "0MonthC": Integer;
        "1MonthC": Integer;
        "2MonthC": Integer;
        "3MonthC": Integer;
        Over3MonthC: Integer;
        NoLoans: Integer;
        PhoneNo: Text[30];
        "StaffNo.": Text[30];
        Deposits: Decimal;
        GrandTotal: Decimal;
        "0Month": Decimal;
        FirstMonthDate: Date;
        EndMonthDate: Date;
        Loans_Aging_Analysis__SASRA_CaptionLbl: label 'Loans Aging Analysis (SASRA)';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Loan_TypeCaptionLbl: label 'Loan Type';
        Staff_No_CaptionLbl: label 'Staff No.';
        Oustanding_BalanceCaptionLbl: label 'Oustanding Balance';
        PerformingCaptionLbl: label 'Performing';
        V1___30_Days_CaptionLbl: label '(1 - 30 Days)';
        V0_Days_CaptionLbl: label '(0 Days)';
        WatchCaptionLbl: label 'Watch';
        V31___180_Days_CaptionLbl: label '(31 - 180 Days)';
        SubstandardCaptionLbl: label 'Substandard';
        V181___360_Days_CaptionLbl: label '(181 - 360 Days)';
        DoubtfulCaptionLbl: label 'Doubtful';
        Over_360_DaysCaptionLbl: label 'Over 360 Days';
        LossCaptionLbl: label 'Loss';
        TotalsCaptionLbl: label 'Totals';
        CountCaptionLbl: label 'Count';
        Grand_TotalCaptionLbl: label 'Grand Total';
        "0Day": Decimal;
        "1Day": Decimal;
        "2Day": Decimal;
        "3Day": Decimal;
        Over3Day: Decimal;
        LSchedule: Record "Loan Repayment Schedule";
        RepaymentPeriod: Date;
        Loans: Record "Loans Register";
        LastMonth: Date;
        ScheduledLoanBal: Decimal;
        DateFilter: Text;
        LBal: Decimal;
        Arrears: Decimal;
        "No.ofMonthsinArrears": Integer;
        Company: Record "Company Information";
        ExpectedBalance: Decimal;
        "Loans Register": Record "Loans Register";

    procedure OnAfterGetRecord()
    begin
        "Loans Register".CalcFields("Outstanding Balance");

        DateFilter := '..' + Format(AsAt);
        LSchedule.Reset;
        LSchedule.SetRange(LSchedule."Loan No.", "Loans Register"."Loan  No.");
        LSchedule.SetFilter(LSchedule."Repayment Date", DateFilter);
        if not LSchedule.Find('-') then begin

            Loans.Reset;
            Loans.SetRange(Loans."Loan  No.", "Loans Register"."Loan  No.");
            if Loans.Find('-') then begin
                //  SFactory.FnGenerateRepaymentSchedule(Loans."Loan  No.");
            end;
        end;
        RepaymentPeriod := AsAt;
        //MESSAGE(FORMAT(AsAt));
        if "Loans Register"."Repayment Frequency" = "Loans Register"."repayment frequency"::Monthly then begin
            if RepaymentPeriod = CalcDate('CM', RepaymentPeriod) then begin
                LastMonth := RepaymentPeriod;
            end else begin
                LastMonth := CalcDate('-1M', RepaymentPeriod);
            end;
            LastMonth := CalcDate('CM', LastMonth);
        end;

        DateFilter := '..' + Format(AsAt);
        Loans.Reset;
        Loans.SetRange(Loans."Loan  No.", "Loans Register"."Loan  No.");
        Loans.SetFilter(Loans."Date filter", DateFilter);
        if Loans.Find('-') then begin
            Loans.CalcFields(Loans."Outstanding Balance", Loans."Scheduled Principal to Date", Loans."Principal Paid", Loans."Schedule Repayments");
            //MESSAGE('##Loan Balance %1',FORMAT(LBal));

            ScheduledLoanBal := Loans."Scheduled Principal to Date";


            //MESSAGE(FORMAT(ScheduledLoanBal));
            ExpectedBalance := ROUND(Loans."Approved Amount" - ScheduledLoanBal, 1, '<');
            //MESSAGE('##Expected Balance %1',FORMAT(ExpectedBalance));
            Arrears := LBal - ExpectedBalance;
            if Arrears < 0 then Arrears := 0;

        end;
        LSchedule.Reset;
        LSchedule.SetRange(LSchedule."Loan No.", "Loans Register"."Loan  No.");
        LSchedule.SetRange(LSchedule."Repayment Date", CalcDate('CM', AsAt));
        //LSchedule.SETFILTER(LSchedule."Repayment Date",DateFilter);
        if LSchedule.FindLast then begin
            //IF LSchedule."Repayment Date"<CALCDATE('CM',AsAt))
            ScheduleBal := LSchedule."Loan Amount";

        end;
        //IF ScheduleBal <0 THEN BEGIN
        if ScheduleBal > 0 then begin
            //ScheduleBal:=0;


            Arrears := LBal - ScheduleBal;
        end;
        if ScheduleBal < 0 then begin
            Arrears := 0;
        end;

        if ((Arrears < 0) or (Arrears = 0)) then begin
            Arrears := 0
        end else
            Arrears := Arrears;
        "Loans Register"."Amount in Arrears" := Arrears;
        "Loans Register".Modify();

        if Loans.Installments > 0 then
            LoanPrincipleNew := Loans."Approved Amount" / Loans.Installments
        else begin
            // CurrReport.Skip();
        end;
        if LoanPrincipleNew > 0 then
            "No.ofMonthsinArrears" := ROUND((Arrears / LoanPrincipleNew) * 30, 1, '>')
        else begin
            // CurrReport.Skip();
        end;


        if Loans."Loan Product Type" = '24' then begin
            "No.ofMonthsinArrears" := 0;
            "Loans Register"."Amount in Arrears" := 0;
            Arrears := 0;
        end;

        if (("No.ofMonthsinArrears" >= 0) and ("No.ofMonthsinArrears" <= 90)) then begin
            "Loans Register"."Loans Category" := "Loans Register"."loans category"::Perfoming
        end else
            if (("No.ofMonthsinArrears" > 90) and ("No.ofMonthsinArrears" <= 360)) then begin
                "Loans Register"."Loans Category" := "Loans Register"."loans category"::Watch
            end else
                if ("No.ofMonthsinArrears" > 360) then begin
                    "Loans Register"."Loans Category" := "Loans Register"."loans category"::Watch
                end;
        "Loans Register"."No of Months in Arrears" := "No.ofMonthsinArrears";
        "Loans Register"."Loan Insurance Paid" := "No.ofMonthsinArrears";
        "Loans Register".Modify;


        if "Loans Register"."Loans Category" = "Loans Register"."loans category"::Perfoming then
            "0Month" := "Loans Register"."Outstanding Balance"
        else
            if "Loans Register"."Loans Category" = "Loans Register"."loans category"::Watch then
                "1Month" := "Loans Register"."Outstanding Balance"
            else
                if "Loans Register"."Loans Category" = "Loans Register"."loans category"::Substandard then
                    "2Month" := "Loans Register"."Outstanding Balance"
                else
                    if "Loans Register"."Loans Category" = "Loans Register"."loans category"::Doubtful then
                        "3Month" := "Loans Register"."Outstanding Balance"
                    else
                        if "Loans Register"."Loans Category" = "Loans Register"."loans category"::Loss then
                            Over3Month := "Loans Register"."Outstanding Balance";


        GrandTotal := GrandTotal + "Loans Register"."Outstanding Balance";

        if ("1Month" + "2Month" + "3Month" + Over3Month) > 0 then
            NoLoans := NoLoans + 1;
    end;

    procedure OnPreDataItem()
    begin
        // CurrReport.CreateTotals("0Month", "1Month", "2Month", "3Month", Over3Month);
        GrandTotal := 0;
        Company.Get();
        Company.CalcFields(Company.Picture, Company.Picture);
        //MESSAGE('bado kaka %1',"Loans Register"."Loan  No.");


        if AsAt = 0D then
            DFilter := '..' + Format(AsAt);
        "Loans Register".SetFilter("Loans Register"."Date filter", DFilter);
        "Loans Register".SetFilter("Loans Register"."Issued Date", '<=%1', AsAt);
        LoanApp.Reset;
        if LoanApp.FindSet then begin
            repeat
                LoanApp.Performing := false;
                LoanApp.watch := false;
                LoanApp.Substandard := false;
                LoanApp.Doubtful := false;
                LoanApp.loss := false;
                LoanApp.Modify;
            until LoanApp.Next = 0;
        end;
    end;



}