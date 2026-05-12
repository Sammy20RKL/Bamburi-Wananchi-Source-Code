#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52000 "loan aging new Nav"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/loan aging new nav.rdlc';

    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            DataItemTableView = where(Posted = const(true), "Outstanding Balance" = filter(> 1));
            RequestFilterFields = "Loan  No.", "Client Code", "Loan Product Type", "Outstanding Balance";
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
            column(Arrears; "Loans Register"."Amount in Arrears")
            {
            }
            column(Loans__Loan_Product_Type_; "Loan Product Type")
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
            column(LoansCategory_LoansRegister; "Loans Register"."Loans Category")
            {
            }
            column(Sorting; Sorting)
            {
            }
            column(LoanProductType_LoansRegister; "Loans Register"."Loan Product Type")
            {
            }
            column(ApprovedAmount_LoansRegister; "Loans Register"."Approved Amount")
            {
            }
            column(IssuedDate_LoansRegister; "Loans Register"."Issued Date")
            {
            }
            column(Installments_LoansRegister; "Loans Register".Installments)
            {
            }
            column(LoanDisbursementDate_LoansRegister; "Loans Register"."Loan Disbursement Date")
            {
            }
            column(TotalPaid_LoansRegister; "Loans Register"."Total Paid")
            {
            }
            column(LoanBalanceatRescheduling_LoansRegister; "Loans Register"."Loan Balance at Rescheduling")
            {
            }
            column(LastPayDate_LoansRegister; "Loans Register"."Last Pay Date")
            {
            }
            column(RepaymentStartDate_LoansRegister; "Loans Register"."Repayment Start Date")
            {
            }
            column(CurrentRepayment_LoansRegister; "Loans Register"."Current Repayment")
            {
            }
            column(ExpectedDateofCompletion_LoansRegister; "Loans Register"."Expected Date of Completion")
            {
            }
            column(lastbalance; "Loans Register"."Outstanding Balance")
            {
            }
            column(period; "Loans Register"."Days In Arrears")
            {
            }

            trigger OnAfterGetRecord()
            begin
                Sorting := 0;
                "0MonthC" := 0;
                "1Month" := 0;
                "2Month" := 0;
                "3Month" := 0;
                Over3Month := 0;
                GrandTotal := 0;

                "Loans Register".CalcFields("Outstanding Balance");
                LBal := "Loans Register"."Outstanding Balance";
                if "Loans Register"."Loans Category-SASRA" = "Loans Register"."loans category-sasra"::Perfoming then begin
                    Sorting := 1;
                    "0MonthC" := "0MonthC" + 1;
                end;
                if "Loans Register"."Loans Category-SASRA" = "Loans Register"."loans category-sasra"::Watch then begin
                    Sorting := 2;
                    "1Month" := LBal;
                    "1MonthC" := "1MonthC" + 1;
                end;
                if "Loans Register"."Loans Category-SASRA" = "Loans Register"."loans category-sasra"::Substandard then begin
                    Sorting := 3;
                    "2Month" := LBal;
                    "2MonthC" := "2MonthC" + 1;
                end;
                if "Loans Register"."Loans Category-SASRA" = "Loans Register"."loans category-sasra"::Doubtful then begin
                    Sorting := 4;
                    "3Month" := LBal;
                    "3MonthC" := "3MonthC" + 1;
                end;
                if "Loans Register"."Loans Category-SASRA" = "Loans Register"."loans category-sasra"::Loss then begin
                    Sorting := 5;
                    Over3Month := LBal;
                    Over3MonthC := Over3MonthC + 1;
                end;

                GrandTotal := GrandTotal + "Loans Register"."Outstanding Balance";

                if ("0Month" + "1Month" + "2Month" + "3Month" + Over3Month) > 0 then
                    NoLoans := NoLoans + 1;
                // if
                // NoofMonthsinArrears := 0;
                // ApprovedAmount := 0;
                // DateDiff := 0;
                // MonthlyRepayment := 0;
                // ScheduledLoanBal := 0;
                // LBal := 0;
                // Arrears := 0;
                // OutstandBal := 0;
                // ExpectedDateofCompletion := 0D;
                // RepaymentPeriod := AsAt;

                // LoanApp.Reset;
                // LoanApp.SetRange(LoanApp."Loan  No.", "Loan  No.");
                // if LoanApp.FindSet then begin
                //     LoanApp.CalcFields("Outstanding Balance");
                //     if LoanApp."Outstanding Balance" < 0 then begin
                //         //skip loans with 0 balances
                //     end else begin
                //         if LoanApp.Rescheduled = false then begin
                //             FunscheduledLoan();
                //         end else
                //             if LoanApp.Rescheduled = true then begin
                //                 FunRescheduleLoan();
                //             end;
                //     end;
                // end;
            end;

            trigger OnPreDataItem()
            begin
                CurrReport.CreateTotals("0Month", "1Month", "2Month", "3Month", Over3Month);
                GrandTotal := 0;

                if AsAt = 0D then
                    DFilter := '..' + Format(AsAt);

                //Reset all loans within that period to performing...
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
                        LoanApp.Modify(true);
                    until LoanApp.Next = 0;
                end;

                LoanAgingProcessor.UpdateLoanArrears(AsAt);
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
        LoanAgingProcessor: Codeunit LoanAgingProcessor;
        LoansTotal: Integer;
        Reached: integer;
        PercentageDone: Decimal;
        DialogBox: Dialog;
        periodArrear: Decimal;
        Rescheduledate: Date;
        ExpectedBalance: Decimal;
        "1Month": Decimal;
        "2Month": Decimal;
        "3Month": Decimal;
        Over3Month: Decimal;
        ShowLoan: Boolean;
        AsAt: Date;
        LastDueDate: Date;
        DFormula: DateFormula;
        "0MonthC": Decimal;
        "1MonthC": Decimal;
        "2MonthC": Decimal;
        "3MonthC": Decimal;
        Over3MonthC: Decimal;
        NoLoans: Integer;
        PhoneNo: Text[30];
        "StaffNo.": Text[30];
        Deposits: Decimal;
        GrandTotal: Decimal;
        "0Month": Decimal;
        LoanProduct: Record "Loan Products Setup";
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
        NoofMonthsinArrears: Decimal;
        Company: Record "Company Information";
        MonthlyRepayment: Decimal;
        Last2Months: Date;
        Sorting: Integer;
        ApprovedAmount: Decimal;
        ExpectedDateofCompletion: Date;
        DateDiff: Decimal;
        DFilter: Text;
        Cat: Text[30];
        OutstandBal: Decimal;
        issueddate: Date;
        ldate: Date;
        Expertdate: Decimal;
        LoanApp: Record "Loans Register";
        daysinarr: Decimal;

    local procedure FunscheduledLoan()
    var
        Loans: Record "Loans Register";
    begin
        //Assign variables
        NoofMonthsinArrears := 0;
        ApprovedAmount := 0;
        DateDiff := 0;
        MonthlyRepayment := 0;
        ScheduledLoanBal := 0;
        LBal := 0;
        Arrears := 0;
        OutstandBal := 0;
        ExpectedDateofCompletion := 0D;
        Cat := '';

        Loans.Reset;
        Loans.SetRange(Loans."Loan  No.", LoanApp."Loan  No.");
        Loans.SetRange(Loans.Rescheduled, false);
        if Loans.Find('-') then begin
            Loans.CalcFields("Outstanding Balance");
            ApprovedAmount := Loans."Outstanding Balance";

            //*******************************************************************************************************************
            if "Loans Register"."Repayment Frequency" = "Loans Register"."repayment frequency"::Monthly then begin
                LastMonth := RepaymentPeriod;
                Last2Months := CalcDate('-1M', RepaymentPeriod);
            end;

            //get the expected date of completion..
            ExpectedDateofCompletion := CalcDate(Format(Loans.Installments) + 'M', Loans."Issued Date");

            //get the scheduled balance as per AsAt date...
            LSchedule.Reset;
            LSchedule.SetRange(LSchedule."Loan No.", LoanApp."Loan  No.");
            LSchedule.SetFilter(LSchedule."Repayment Date", '<=%1', AsAt);
            if LSchedule.FindLast then begin
                ScheduledLoanBal := ROUND(LSchedule."Loan Balance", 1, '=');
            end;

            //*********************************************************************************************************************************************88
            Rescheduledate := LSchedule."Repayment Date";

            //cross check the scheduled balance might be the loan amt(Outstanding Balance), for new loans
            LSchedule.Reset;
            LSchedule.SetRange(LSchedule."Loan No.", "Loans Register"."Loan  No.");
            LSchedule.SetRange(LSchedule."Instalment No", 1);
            if LSchedule.FindFirst then begin
                MonthlyRepayment := ROUND(LSchedule."Principal Repayment", 1, '=');
                if (ScheduledLoanBal = 0) and (LSchedule."Repayment Date" > LastMonth) then
                    ScheduledLoanBal := ApprovedAmount;
            end else begin
                ScheduledLoanBal := 0;
            end;

            //********************************************************************************************************************************************************
            //get the loan balance in regards to the Date filter given
            DateFilter := '..' + Format(AsAt);
            Loans.Reset;
            Loans.SetRange(Loans."Loan  No.", "Loans Register"."Loan  No.");
            Loans.SetFilter(Loans."Date filter", DateFilter);
            if Loans.Find('-') then begin
                Loans.CalcFields(Loans."Outstanding Balance");
                LBal := ROUND(Loans."Outstanding Balance", 1, '=');
            end;
            //**************************************************************************************************************************************************************
            //Calculatee the Arrears in respect to loans issued within this month
            issueddate := CalcDate('1M', Loans."Issued Date");
            if issueddate > AsAt then begin
                Arrears := 0;
            end else begin
                Arrears := LBal - ScheduledLoanBal;
            end;

            ///******************************************************************************************************************************************************
            if (Arrears < 0) or (Arrears = 0) then begin
                Arrears := 0
            end else
                Arrears := Arrears;
            "Loans Register"."Amount in Arrears" := Arrears;

            //update the days in Arrears
            if MonthlyRepayment <> 0 then begin
                "Loans Register"."Days In Arrears" := ROUND((Arrears / MonthlyRepayment) * 30, 1, '<');

            end;
            "Loans Register".Modify;

            //***************************************************************************************************************************************************
            if Arrears <> 0 then begin
                if MonthlyRepayment = 0 then begin
                    NoofMonthsinArrears := 13 * 30;
                end else begin
                    DateDiff := (LastMonth - ExpectedDateofCompletion) / 30;
                    if DateDiff >= 1 then begin
                        NoofMonthsinArrears := 13 * 30//13+;
                    end else begin
                        NoofMonthsinArrears := ROUND((Arrears / MonthlyRepayment) * 29, 1, '>');
                    end;
                end;
            end;
            //********************************************************************************************************************************
            if MonthlyRepayment <> 0 then begin
                NoofMonthsinArrears := ROUND((Arrears / MonthlyRepayment), 1, '<');
            end;
            if (ExpectedDateofCompletion < AsAt) then begin
                daysinarr := 361;
            end else begin
                daysinarr := "Loans Register"."Days In Arrears";
            end;
            //...........................................................................................................loan category

            // update the SASRA Categorizations
            if (Arrears = 0) then begin
                "Loans Register"."Loans Category" := Loans."loans category"::Perfoming;
                "Loans Register"."Loans Category-SASRA" := Loans."loans category-sasra"::Perfoming;
                "Loans Register".Performing := true;
                Sorting := 1;
                Cat := Format(Loans."loans category"::Perfoming);
                Cat := Format(Loans."loans category-sasra"::Perfoming);
                "0Month" := LBal;
                "0MonthC" := "0MonthC" + 1;
                // "Loans Register".Modify;
            end else
                if (daysinarr < 1) then begin
                    "Loans Register"."Loans Category" := Loans."loans category"::Perfoming;
                    "Loans Register"."Loans Category-SASRA" := Loans."loans category-sasra"::Perfoming;
                    "Loans Register".Performing := true;
                    Sorting := 1;
                    Cat := Format(Loans."loans category"::Perfoming);
                    Cat := Format(Loans."loans category-sasra"::Perfoming);
                    "0Month" := LBal;
                    "0MonthC" := "0MonthC" + 1;
                    // "Loans Register".Modify;
                end else
                    if (daysinarr >= 1) and (daysinarr <= 30) then begin
                        "Loans Register"."Loans Category" := Loans."loans category"::Watch;
                        "Loans Register"."Loans Category-SASRA" := Loans."loans category-sasra"::Watch;
                        "Loans Register".watch := true;
                        Sorting := 2;
                        Cat := Format(Loans."loans category"::Watch);
                        Cat := Format(Loans."loans category-sasra"::Watch);
                        "1Month" := LBal;
                        "1MonthC" := "1MonthC" + 1;
                        // "Loans Register".Modify;
                    end else
                        if (daysinarr > 30) and (daysinarr <= 180) then begin
                            "Loans Register"."Loans Category" := Loans."loans category"::Substandard;
                            "Loans Register"."Loans Category-SASRA" := Loans."loans category-sasra"::Substandard;
                            "Loans Register".Substandard := true;
                            Sorting := 3;
                            Cat := Format(Loans."loans category"::Substandard);
                            Cat := Format(Loans."loans category-sasra"::Substandard);
                            "2Month" := LBal;
                            "2MonthC" := "2MonthC" + 1;
                            // "Loans Register".Modify;
                        end else
                            if (daysinarr > 180) and (daysinarr <= 360) then begin
                                "Loans Register"."Loans Category" := Loans."loans category"::Doubtful;
                                "Loans Register"."Loans Category-SASRA" := Loans."loans category-sasra"::Doubtful;
                                "Loans Register".Doubtful := true;
                                Sorting := 4;
                                Cat := Format(Loans."loans category"::Doubtful);
                                Cat := Format(Loans."loans category-sasra"::Doubtful);
                                "3Month" := LBal;
                                "3MonthC" := "3MonthC" + 1;
                                // "Loans Register".Modify;
                            end else
                                if (daysinarr > 360) then begin
                                    "Loans Register"."Loans Category" := Loans."loans category"::Loss;
                                    "Loans Register"."Loans Category-SASRA" := Loans."loans category-sasra"::Loss;
                                    "Loans Register".loss := true;
                                    Sorting := 5;
                                    Cat := Format(Loans."loans category"::Loss);
                                    Cat := Format(Loans."loans category-sasra"::Loss);
                                    Over3Month := LBal;
                                    Over3MonthC := Over3MonthC + 1;
                                    // "Loans Register".Modify;

                                end;
            if NoofMonthsinArrears > 1 then
                periodArrear := AsAt - Rescheduledate;


            "Loans Register"."Days In Arrears" := periodArrear;
            "Loans Register"."No of Months in Arrears" := NoofMonthsinArrears;
            "Loans Register".Modify(true);

            GrandTotal := GrandTotal + "Loans Register"."Outstanding Balance";

            if ("0Month" + "1Month" + "2Month" + "3Month" + Over3Month) > 0 then
                NoLoans := NoLoans + 1;

        end;
    end;

    local procedure FunRescheduleLoan()
    begin
        NoofMonthsinArrears := 0;
        ApprovedAmount := 0;
        DateDiff := 0;
        MonthlyRepayment := 0;
        ScheduledLoanBal := 0;
        LBal := 0;
        Arrears := 0;
        OutstandBal := 0;
        ExpectedDateofCompletion := 0D;

        Loans.Reset;
        Loans.SetRange(Loans."Loan  No.", LoanApp."Loan  No.");
        //Loans.SETRANGE (Loans.Rescheduled,TRUE);
        if Loans.Find('-') then begin
            Loans.CalcFields("Outstanding Balance");
            ApprovedAmount := Loans."Outstanding Balance";

            //*******************************************************************************************************************
            if "Loans Register"."Repayment Frequency" = "Loans Register"."repayment frequency"::Monthly then begin
                //  IF RepaymentPeriod=CALCDATE('CM',RepaymentPeriod) THEN BEGIN
                LastMonth := RepaymentPeriod;
                // END ELSE BEGIN

                Last2Months := CalcDate('-1M', RepaymentPeriod);
                //        END;
                //      LastMonth:=CALCDATE('CM',LastMonth);
            end;
            //MESSAGE('Date issue is %1| Loan disb is %2',Loans."Issued Date",Loans."Loan Disbursement Date");
            ExpectedDateofCompletion := CalcDate(Format(Loans.Installments) + 'M', Loans."Loan Disbursement Date");
            //...........................................................................................................Get Scheduled Balance

            //DateFilter:='..'+FORMAT(LastMonth);
            LSchedule.Reset;
            LSchedule.SetRange(LSchedule."Loan No.", LoanApp."Loan  No.");
            LSchedule.SetFilter(LSchedule."Repayment Date", '<=%1', AsAt);
            if LSchedule.FindLast then begin
                ScheduledLoanBal := ROUND(LSchedule."Loan Balance", 1, '=');
            end;
            // MESSAGE ('date is fdf %1|out schbal is %2',LSchedule."Repayment Date",ScheduledLoanBal);
            Rescheduledate := LSchedule."Repayment Date";

            LSchedule.Reset;
            LSchedule.SetRange(LSchedule."Loan No.", "Loans Register"."Loan  No.");
            LSchedule.SetRange(LSchedule."Instalment No", 1);

            if LSchedule.FindFirst then begin

                MonthlyRepayment := ROUND(LSchedule."Principal Repayment", 1, '=');//Monthly Repayment

                if (ScheduledLoanBal = 0) and (LSchedule."Repayment Date" > LastMonth) then
                    ScheduledLoanBal := ApprovedAmount;
            end else begin
                ScheduledLoanBal := 0;
            end;
            //  MESSAGE('###This is the ScheduledLoanBal %1 ',ScheduledLoanBal);
            DateFilter := '..' + Format(AsAt);
            Loans.Reset;
            Loans.SetRange(Loans."Loan  No.", "Loans Register"."Loan  No.");
            Loans.SetFilter(Loans."Date filter", DateFilter);
            if Loans.Find('-') then begin
                Loans.CalcFields(Loans."Outstanding Balance", Loans."Scheduled Principal to Date", Loans."Principal Paid", Loans."Schedule Repayments");
                LBal := ROUND(Loans."Outstanding Balance", 1, '=');
                ;
                //MESSAGE('###This is the ouT BAL RESCH %1 ',LBal)
            end;

            //
            issueddate := CalcDate('1M', Loans."Loan Disbursement Date");
            // MESSAGE('Here');

            if issueddate > AsAt then begin
                Arrears := 0;
            end else begin
                Arrears := LBal - ScheduledLoanBal;
                // MESSAGE ('Arrears are %1|%2',Arrears,MonthlyRepayment);


            end;
            if (Arrears < 0) or (Arrears = 0) then begin
                Arrears := 0
            end else
                Arrears := Arrears;
            "Loans Register"."Amount in Arrears" := Arrears;
            if MonthlyRepayment <> 0 then begin
                if Arrears > MonthlyRepayment then
                    "Loans Register"."Days In Arrears" := ROUND((Arrears / MonthlyRepayment) * 30, 1, '<');
                if Arrears < MonthlyRepayment then
                    "Loans Register"."Days In Arrears" := 0;

            end;
            "Loans Register".Modify;

            //.........................................................................................................End Amount in Arrears

            Cat := '';
            daysinarr := "Loans Register"."Days In Arrears";
            if MonthlyRepayment <> 0 then begin
                if Arrears > MonthlyRepayment then
                    NoofMonthsinArrears := ROUND((Arrears / MonthlyRepayment), 0.5, '>');

                if Arrears < MonthlyRepayment then
                    NoofMonthsinArrears := 0;
            end;

            //...........................................................................................................loan category
            if (Arrears = 0) then begin
                "Loans Register"."Loans Category" := Loans."loans category"::Perfoming;
                "Loans Register"."Loans Category-SASRA" := Loans."loans category-sasra"::Perfoming;
                "Loans Register".Performing := true;
                Sorting := 1;
                Cat := Format(Loans."loans category"::Perfoming);
                Cat := Format(Loans."loans category-sasra"::Perfoming);
                "0Month" := LBal;
                "0MonthC" := "0MonthC" + 1;
                "Loans Register".Modify;
            end else
                if (daysinarr < 1) then begin
                    "Loans Register"."Loans Category" := Loans."loans category"::Perfoming;
                    "Loans Register"."Loans Category-SASRA" := Loans."loans category-sasra"::Perfoming;
                    "Loans Register".Performing := true;
                    Sorting := 1;
                    Cat := Format(Loans."loans category"::Perfoming);
                    Cat := Format(Loans."loans category-sasra"::Perfoming);
                    "0Month" := LBal;
                    "0MonthC" := "0MonthC" + 1;
                    "Loans Register".Modify;
                end else
                    if (daysinarr >= 1) and (daysinarr <= 30) then begin
                        "Loans Register"."Loans Category" := Loans."loans category"::Watch;
                        "Loans Register"."Loans Category-SASRA" := Loans."loans category-sasra"::Watch;
                        "Loans Register".watch := true;
                        Sorting := 2;
                        Cat := Format(Loans."loans category"::Watch);
                        Cat := Format(Loans."loans category-sasra"::Watch);
                        "1Month" := LBal;
                        "1MonthC" := "1MonthC" + 1;
                        "Loans Register".Modify;
                    end else
                        if (daysinarr > 30) and (daysinarr <= 180) then begin
                            "Loans Register"."Loans Category" := Loans."loans category"::Substandard;
                            "Loans Register"."Loans Category-SASRA" := Loans."loans category-sasra"::Substandard;
                            "Loans Register".Substandard := true;
                            Sorting := 3;
                            Cat := Format(Loans."loans category"::Substandard);
                            Cat := Format(Loans."loans category-sasra"::Substandard);
                            "2Month" := LBal;
                            "2MonthC" := "2MonthC" + 1;
                            "Loans Register".Modify;
                        end else
                            if (daysinarr > 180) and (daysinarr <= 360) then begin
                                "Loans Register"."Loans Category" := Loans."loans category"::Doubtful;
                                "Loans Register"."Loans Category-SASRA" := Loans."loans category-sasra"::Doubtful;
                                "Loans Register".Doubtful := true;
                                Sorting := 4;
                                Cat := Format(Loans."loans category"::Doubtful);
                                Cat := Format(Loans."loans category-sasra"::Doubtful);
                                "3Month" := LBal;
                                "3MonthC" := "3MonthC" + 1;
                                "Loans Register".Modify;
                            end else
                                if (daysinarr > 360) then begin
                                    "Loans Register"."Loans Category" := Loans."loans category"::Loss;
                                    "Loans Register"."Loans Category-SASRA" := Loans."loans category-sasra"::Loss;
                                    "Loans Register".loss := true;
                                    Sorting := 5;
                                    Cat := Format(Loans."loans category"::Loss);
                                    Cat := Format(Loans."loans category-sasra"::Loss);
                                    Over3Month := LBal;
                                    Over3MonthC := Over3MonthC + 1;
                                    "Loans Register".Modify;
                                end;
            if daysinarr > 1 then
                "Loans Register"."Days In Arrears" := periodArrear;
            "Loans Register".Modify;

            GrandTotal := GrandTotal + "Loans Register"."Outstanding Balance";

            if ("0Month" + "1Month" + "2Month" + "3Month" + Over3Month) > 0 then
                NoLoans := NoLoans + 1;

            periodArrear := AsAt - Rescheduledate;

        end;

    end;

}

