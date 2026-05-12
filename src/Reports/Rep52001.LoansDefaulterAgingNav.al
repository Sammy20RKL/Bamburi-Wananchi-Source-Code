#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52001 "Loans Defaulter Aging Nav"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Loans Defaulter Aging.rdlc';

    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            CalcFields = "Outstanding Balance", "Last Pay Date";
            DataItemTableView = where("Outstanding Balance" = filter(> 0), Posted = const(true), Reversed = const(false));
            RequestFilterFields = "Loan  No.", "Client Code", "Outstanding Balance", "Date filter", "Account No";
            column(ReportForNavId_4645; 4645)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(Company_Name; Company.Name)
            {
            }
            column(Company_Address; Company.Address)
            {
            }
            column(Company_Address_2; Company."Address 2")
            {
            }
            column(Company_Phone_No; Company."Phone No.")
            {
            }
            column(Company_Fax_No; Company."Fax No.")
            {
            }
            column(Company_Picture; Company.Picture)
            {
            }
            column(Company_Letter_Head; Company.Address)
            {
            }
            column(Company_Email; Company."E-Mail")
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(USERID; UserId)
            {
            }
            column(Loans__Loan__No__; "Loan  No.")
            {
            }
            column(Arrears; Arrears)
            {
            }
            column(DaysInArrears_LoansRegister; "Loans Register"."Loan Insurance Paid")
            {
            }
            column(Loans__Loan_Product_Type_; "Loans Register"."Loan Product Type")
            {
            }
            column(Loans_Loans__Staff_No_; "Loans Register"."Staff No")
            {
            }
            column(Loans__Client_Name_; "Client Name")
            {
            }
            column(ClientCode_LoansRegister; "Loans Register"."Client Code")
            {
            }
            column(Loans_Loans__Outstanding_Balance_; "Loans Register"."Outstanding Balance")
            {
            }
            column(V2Month_; "2Month")
            {
            }
            column(V3Month_; "3Month")
            {
            }
            column(Over3Month; Over3Month)
            {
            }
            column(V1Month_; "1Month")
            {
            }
            column(V0Month_; "0Month")
            {
            }
            column(AmountinArrears_LoansRegister; "Loans Register"."Amount in Arrears")
            {
            }
            column(NoofMonthsinArrears_LoansRegister; "Loans Register"."No of Months in Arrears")
            {
            }
            column(Loans_Loans__Outstanding_Balance__Control1000000016; "Loans Register"."Outstanding Balance")
            {
            }
            column(InterestDue_LoansRegister; "Loans Register"."Interest Due")
            {
            }
            column(Loans__Approved_Amount_; "Approved Amount")
            {
            }
            column(Loans_Loans__Interest_Due_; "Loans Register"."Interest Due")
            {
            }
            column(TotalBalance; "Loans Register"."Outstanding Balance" + "Loans Register"."Interest Due")
            {
            }
            column(V1MonthC_; "1MonthC")
            {
            }
            column(V2MonthC_; "2MonthC")
            {
            }
            column(V3MonthC_; "3MonthC")
            {
            }
            column(Over3MonthC; Over3MonthC)
            {
            }
            column(NoLoans; NoLoans)
            {
            }
            column(GrandTotal; GrandTotal)
            {
            }
            column(V0Month__Control1102760031; "0Month")
            {
            }
            column(V1Month__Control1102760032; "1Month")
            {
            }
            column(V2Month__Control1102760033; "2Month")
            {
            }
            column(V3Month__Control1102760034; "3Month")
            {
            }
            column(Over3Month_Control1102760035; Over3Month)
            {
            }
            column(V0MonthC_; "0MonthC")
            {
            }
            column(Loans_Aging_Analysis__SASRA_Caption; Loans_Aging_Analysis__SASRA_CaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Loans__Loan__No__Caption; FieldCaption("Loan  No."))
            {
            }
            column(Loan_TypeCaption; Loan_TypeCaptionLbl)
            {
            }
            column(Staff_No_Caption; Staff_No_CaptionLbl)
            {
            }
            column(Loans__Client_Name_Caption; FieldCaption("Client Name"))
            {
            }
            column(Oustanding_BalanceCaption; Oustanding_BalanceCaptionLbl)
            {
            }
            column(PerformingCaption; PerformingCaptionLbl)
            {
            }
            column(V1___30_Days_Caption; V1___30_Days_CaptionLbl)
            {
            }
            column(V0_Days_Caption; V0_Days_CaptionLbl)
            {
            }
            column(WatchCaption; WatchCaptionLbl)
            {
            }
            column(V31___180_Days_Caption; V31___180_Days_CaptionLbl)
            {
            }
            column(SubstandardCaption; SubstandardCaptionLbl)
            {
            }
            column(V181___360_Days_Caption; V181___360_Days_CaptionLbl)
            {
            }
            column(DoubtfulCaption; DoubtfulCaptionLbl)
            {
            }
            column(Over_360_DaysCaption; Over_360_DaysCaptionLbl)
            {
            }
            column(LossCaption; LossCaptionLbl)
            {
            }
            column(TotalsCaption; TotalsCaptionLbl)
            {
            }
            column(CountCaption; CountCaptionLbl)
            {
            }
            column(Grand_TotalCaption; Grand_TotalCaptionLbl)
            {
            }
            column(LoanProductType; "Loans Register"."Loan Product Type")
            {
            }
            column(AsAt; AsAt)
            {
            }
            column(Days; "No.ofMonthsinArrears")
            {
            }

            trigger OnAfterGetRecord()
            var
                RepaymentDate: Date;
            begin
                // 1. Calculate Outstanding Balance
                "Loans Register".CalcFields("Outstanding Balance");
                LBal := "Loans Register"."Outstanding Balance";

                // 2. Check if Repayment Schedule exists
                DateFilter := '..' + Format(AsAt);
                LSchedule.Reset();
                LSchedule.SetRange("Loan No.", "Loans Register"."Loan  No.");
                LSchedule.SetFilter("Repayment Date", DateFilter);

                if not LSchedule.Find('-') then begin
                    Loans.Reset();
                    Loans.SetRange("Loan  No.", "Loans Register"."Loan  No.");
                    if Loans.Find('-') then begin
                        // Optionally regenerate repayment schedule
                        // SFactory.FnGenerateRepaymentSchedule(Loans."Loan  No.");
                    end;
                end;

                // 3. Calculate LastMonth if frequency is monthly
                RepaymentPeriod := AsAt;
                if "Loans Register"."Repayment Frequency" = "repayment frequency"::Monthly then begin
                    if RepaymentPeriod = CalcDate('CM', RepaymentPeriod) then
                        LastMonth := RepaymentPeriod
                    else
                        LastMonth := CalcDate('-1M', RepaymentPeriod);

                    LastMonth := CalcDate('CM', LastMonth);
                end;

                // 4. Expected Balance & Arrears
                Loans.Reset();
                Loans.SetRange("Loan  No.", "Loans Register"."Loan  No.");
                Loans.SetFilter("Date filter", DateFilter);
                if Loans.Find('-') then begin
                    Loans.CalcFields("Outstanding Balance", "Scheduled Principal to Date", "Principal Paid", "Schedule Repayments");

                    ScheduledLoanBal := Loans."Scheduled Principal to Date";
                    ExpectedBalance := ROUND(Loans."Approved Amount" - ScheduledLoanBal, 1, '<');
                    Arrears := LBal - ExpectedBalance;
                    if Arrears < 0 then Arrears := 0;
                end;

                // 5. If schedule exists for current month, recalculate arrears
                RepaymentDate := CalcDate('CM', AsAt);
                LSchedule.Reset();
                LSchedule.SetRange("Loan No.", "Loans Register"."Loan  No.");
                LSchedule.SetRange("Repayment Date", RepaymentDate);
                if LSchedule.FindLast() then begin
                    ScheduleBal := LSchedule."Loan Amount";
                    if ScheduleBal > 0 then
                        Arrears := LBal - ScheduleBal;
                end;

                // Ensure non-negative arrears
                if Arrears < 0 then
                    Arrears := 0;

                "Amount in Arrears" := Arrears;
                Modify();

                // 6. Calculate No. of Months in Arrears
                if Loans.Installments > 0 then
                    LoanPrincipleNew := Loans."Approved Amount" / Loans.Installments
                else
                    CurrReport.Skip();

                if LoanPrincipleNew > 0 then
                    "No.ofMonthsinArrears" := ROUND((Arrears / LoanPrincipleNew) * 30, 1, '>')
                else
                    CurrReport.Skip();

                // 7. Special product exclusion
                if Loans."Loan Product Type" = '24' then begin
                    "No.ofMonthsinArrears" := 0;
                    "Amount in Arrears" := 0;
                    Arrears := 0;
                end;

                // 8. Loan Category classification
                case true of
                    "No.ofMonthsinArrears" <= 90:
                        "Loans Register"."Loans Category" := "loans category"::Perfoming;
                    "No.ofMonthsinArrears" <= 360:
                        "Loans Register"."Loans Category" := "loans category"::Watch;
                    else
                        "Loans Register"."Loans Category" := "loans category"::Loss;
                end;

                "No of Months in Arrears" := "No.ofMonthsinArrears";
                "Loans Register"."Loan Insurance Paid" := "No.ofMonthsinArrears";
                "Loans Register".Modify();

                // 9. Age analysis buckets
                case "Loans Register"."Loans Category" of
                    "loans category"::Perfoming:
                        "0Month" := LBal;
                    "loans category"::Watch:
                        "1Month" := LBal;
                    "loans category"::Substandard:
                        "2Month" := LBal;
                    "loans category"::Doubtful:
                        "3Month" := LBal;
                    "loans category"::Loss:
                        Over3Month := LBal;
                end;

                // 10. Grand totals
                GrandTotal += LBal;

                if ("1Month" + "2Month" + "3Month" + Over3Month) > 0 then
                    NoLoans += 1;
            end;

            trigger OnPreDataItem()
            begin
                CurrReport.CreateTotals("0Month", "1Month", "2Month", "3Month", Over3Month);
                GrandTotal := 0;
                Company.Get();
                Company.CalcFields(Company.Picture, Company.Picture);


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

                        LoanApp."Days In Arrears" := 0;
                        LoanApp."Amount in Arrears" := 0;
                        LoanApp."No of Days in Arrears" := 0;
                        LoanApp."No of Months in Arrears" := 0;
                        LoanApp."Loans Category" := "loans category"::Perfoming;

                        LoanApp.Modify();
                    until LoanApp.Next = 0;
                end;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("As At"; AsAt)
                {
                    ApplicationArea = Basic;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

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
}

