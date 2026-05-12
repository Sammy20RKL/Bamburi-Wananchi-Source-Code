
codeunit 56150 "Loan Aging Code Unit"
{
    trigger OnRun()
    begin
        runLoansUpdate();
    end;

    var
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

    procedure runLoansUpdate()
    begin
        AsAt := Today;
        DFilter := '..' + Format(AsAt);
        LoanApp.SetFilter(LoanApp."Date filter", DFilter);
        LoanApp.SetFilter(LoanApp."Issued Date", '<=%1', AsAt);
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


        LoanApp.Reset;
        loanapp.SetFilter(loanapp."Date filter", DFilter);
        loanapp.SetCurrentKey(loanapp."Client Code", loanapp."Application Date");
        loanapp.Ascending(false);
        if loanapp.Find('-') then begin
            repeat
                // loanapp.CalcFields("Outstanding Balance");
                OnAfterGetRecord(loanapp."Loan  No.");
            until loanapp.Next = 0;
        end;


    end;

    procedure OnAfterGetRecord("Loan  No.": Code[30])
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
        RepaymentPeriod := AsAt;

        LoanApp.Reset;
        LoanApp.SetRange(LoanApp."Loan  No.", "Loan  No.");
        if LoanApp.FindSet then begin
            LoanApp.CalcFields(loanapp."Outstanding Balance");

            if LoanApp.Rescheduled = false then begin
                FunscheduledLoan();
            end else
                if LoanApp.Rescheduled = true then begin
                    FunRescheduleLoan();
                end;

        end;
    end;

    procedure OnPreDataItem()
    begin
        DFilter := '..' + Format(AsAt);
        LoanApp.SetFilter(LoanApp."Date filter", DFilter);
        LoanApp.SetFilter(LoanApp."Issued Date", '<=%1', AsAt);
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



    local procedure FunscheduledLoan()
    var
    // Loans: Record LoanApp;
    begin
        //IF LoanApp."Expected Date of Completion" < TODAY THEN BEGIN
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
        Loans.SetRange(Loans.Rescheduled, false);
        if Loans.Find('-') then begin
            Loans.CalcFields("Outstanding Balance");
            ApprovedAmount := Loans."Outstanding Balance";

            //*******************************************************************************************************************
            if LoanApp."Repayment Frequency" = LoanApp."repayment frequency"::Monthly then begin
                LastMonth := RepaymentPeriod;
                Last2Months := CalcDate('-1M', RepaymentPeriod);
                // MESSAGE('last month is %1',Last2Months);
            end;
            ExpectedDateofCompletion := CalcDate(Format(Loans.Installments) + 'M', Loans."Issued Date");
            //  MESSAGE('exp month is %1',ExpectedDateofCompletion);
            //...........................................................................................................Get Scheduled Balance
            //DateFilter:='..'+FORMAT(LastMonth);
            LSchedule.Reset;
            LSchedule.SetRange(LSchedule."Loan No.", LoanApp."Loan  No.");
            LSchedule.SetFilter(LSchedule."Repayment Date", '<=%1', AsAt);
            if LSchedule.FindLast then begin
                ScheduledLoanBal := ROUND(LSchedule."Loan Balance", 1, '=');
            end;
            //MESSAGE ('ScheduledLoanBal is fdf %1|',ScheduledLoanBal);

            //*********************************************************************************************************************************************88
            Rescheduledate := LSchedule."Repayment Date";

            LSchedule.Reset;
            LSchedule.SetRange(LSchedule."Loan No.", LoanApp."Loan  No.");
            LSchedule.SetRange(LSchedule."Instalment No", 1);

            if LSchedule.FindFirst then begin

                MonthlyRepayment := ROUND(LSchedule."Principal Repayment", 1, '=');//Monthly Repayment

                if (ScheduledLoanBal = 0) and (LSchedule."Repayment Date" > LastMonth) then
                    ScheduledLoanBal := ApprovedAmount;
            end else begin

                ScheduledLoanBal := 0;
            end;

            //  MESSAGE ('2date is fdf %1|out schbal is %2|month repay is %3',LSchedule."Repayment Date",ScheduledLoanBal,MonthlyRepayment);
            //********************************************************************************************************************************************************

            DateFilter := '..' + Format(AsAt);
            Loans.Reset;
            Loans.SetRange(Loans."Loan  No.", LoanApp."Loan  No.");
            Loans.SetFilter(Loans."Date filter", DateFilter);
            if Loans.Find('-') then begin
                Loans.CalcFields(Loans."Outstanding Balance", Loans."Scheduled Principal to Date", Loans."Principal Paid", Loans."Schedule Repayments");
                LBal := ROUND(Loans."Outstanding Balance", 1, '=');
                ;
                // MESSAGE('###This is the ouT BAL RESCH %1 ',LBal)
            end;
            //**************************************************************************************************************************************************************
            issueddate := CalcDate('1M', Loans."Issued Date");
            //   MESSAGE ('issue  are %1',issueddate);
            if issueddate > AsAt then begin
                Arrears := 0;
            end else begin
                //           IF ExpectedDateofCompletion > TODAY THEN BEGIN
                //             Arrears := LoanApp."Outstanding Balance"
                //             END ELSE BEGIN
                Arrears := LBal - ScheduledLoanBal;
            end;
            //  MESSAGE ('Arrears are %1',Arrears);

            //MESSAGE ('montrepa is %1',MonthlyRepayment);
            ///******************************************************************************************************************************************************
            if (Arrears < 0) or (Arrears = 0) then begin
                Arrears := 0
            end else
                Arrears := Arrears;
            LoanApp."Amount in Arrears" := Arrears;

            // MESSAGE ('ex date is %1',ExpectedDateofCompletion);


            if MonthlyRepayment <> 0 then begin
                LoanApp."Days In Arrears" := ROUND((Arrears / MonthlyRepayment) * 30, 1, '<');

            end;
            LoanApp.Modify;

            /// MESSAGE ('arre is %1',LoanApp."Days In Arrears");
            //.........................................................................................................End Amount in Arrears
            //***************************************************************************************************************************************************
            if Arrears <> 0 then begin
                if MonthlyRepayment = 0 then begin
                    NoofMonthsinArrears := 13 * 30;//12+
                end else begin
                    DateDiff := (LastMonth - ExpectedDateofCompletion) / 30;
                    // MESSAGE ('dated is %1',DateDiff);
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
            // MESSAGE ('NoofMonthsinArrears IS %1' ,NoofMonthsinArrears);
            Cat := '';
            if (ExpectedDateofCompletion < AsAt) then begin
                // MESSAGE ('ex date IS %1' ,ExpectedDateofCompletion);
                daysinarr := 361;
            end else begin
                daysinarr := LoanApp."Days In Arrears";
            end;
            //  MESSAGE (FORMAT(daysinarr));
            //...........................................................................................................loan category

            if (Arrears = 0) then begin
                LoanApp."Loans Category" := Loans."loans category"::Perfoming;
                LoanApp."Loans Category-SASRA" := Loans."loans category-sasra"::Perfoming;
                LoanApp.Performing := true;
                Sorting := 1;
                Cat := Format(Loans."loans category"::Perfoming);
                Cat := Format(Loans."loans category-sasra"::Perfoming);
                "0Month" := LBal;
                "0MonthC" := "0MonthC" + 1;
                LoanApp.Modify;
            end else
                if (daysinarr < 1) then begin
                    LoanApp."Loans Category" := Loans."loans category"::Perfoming;
                    LoanApp."Loans Category-SASRA" := Loans."loans category-sasra"::Perfoming;
                    LoanApp.Performing := true;
                    Sorting := 1;
                    Cat := Format(Loans."loans category"::Perfoming);
                    Cat := Format(Loans."loans category-sasra"::Perfoming);
                    "0Month" := LBal;
                    "0MonthC" := "0MonthC" + 1;
                    LoanApp.Modify;
                end else
                    if (daysinarr >= 1) and (daysinarr <= 30) then begin
                        LoanApp."Loans Category" := Loans."loans category"::Watch;
                        LoanApp."Loans Category-SASRA" := Loans."loans category-sasra"::Watch;
                        LoanApp.watch := true;
                        Sorting := 2;
                        Cat := Format(Loans."loans category"::Watch);
                        Cat := Format(Loans."loans category-sasra"::Watch);
                        "1Month" := LBal;
                        "1MonthC" := "1MonthC" + 1;
                        LoanApp.Modify;
                    end else
                        if (daysinarr > 30) and (daysinarr <= 180) then begin
                            LoanApp."Loans Category" := Loans."loans category"::Substandard;
                            LoanApp."Loans Category-SASRA" := Loans."loans category-sasra"::Substandard;
                            LoanApp.Substandard := true;
                            Sorting := 3;
                            Cat := Format(Loans."loans category"::Substandard);
                            Cat := Format(Loans."loans category-sasra"::Substandard);
                            "2Month" := LBal;
                            "2MonthC" := "2MonthC" + 1;
                            LoanApp.Modify;
                        end else
                            if (daysinarr > 180) and (daysinarr <= 360) then begin
                                LoanApp."Loans Category" := Loans."loans category"::Doubtful;
                                LoanApp."Loans Category-SASRA" := Loans."loans category-sasra"::Doubtful;
                                LoanApp.Doubtful := true;
                                Sorting := 4;
                                Cat := Format(Loans."loans category"::Doubtful);
                                Cat := Format(Loans."loans category-sasra"::Doubtful);
                                "3Month" := LBal;
                                "3MonthC" := "3MonthC" + 1;
                                LoanApp.Modify;
                            end else
                                if (daysinarr > 360) then begin
                                    LoanApp."Loans Category" := Loans."loans category"::Loss;
                                    LoanApp."Loans Category-SASRA" := Loans."loans category-sasra"::Loss;
                                    LoanApp.loss := true;
                                    Sorting := 5;
                                    Cat := Format(Loans."loans category"::Loss);
                                    Cat := Format(Loans."loans category-sasra"::Loss);
                                    Over3Month := LBal;
                                    Over3MonthC := Over3MonthC + 1;
                                    LoanApp.Modify;

                                    //   END ELSE
                                    //      IF (ExpectedDateofCompletion > AsAt) THEN BEGIN
                                    //        MESSAGE ('2date is fdf %1|out schbal is %2|month repay is %3',LSchedule."Repayment Date",ScheduledLoanBal,MonthlyRepayment);
                                    //     LoanApp."Loans Category":=Loans."Loans Category"::Loss;
                                    //    LoanApp."Loans Category-SASRA":=Loans."Loans Category-SASRA"::Loss;
                                    //    LoanApp.loss:=TRUE;
                                    //    Sorting:=5;
                                    //    Cat:=FORMAT(Loans."Loans Category"::Loss);
                                    //    Over3Month:=LBal;
                                    //    Over3MonthC:=Over3MonthC+1;
                                    //    LoanApp.MODIFY;

                                end;
            if NoofMonthsinArrears > 1 then
                periodArrear := AsAt - Rescheduledate;


            LoanApp."Days In Arrears" := periodArrear;//ROUND(NoofMonthsinArrears,1,'=');
            LoanApp."No of Months in Arrears" := NoofMonthsinArrears;
            //MESSAGE (FORMAT(LoanApp."No of Months in Arrears"));
            LoanApp.Modify;

            GrandTotal := GrandTotal + LoanApp."Outstanding Balance";

            if ("0Month" + "1Month" + "2Month" + "3Month" + Over3Month) > 0 then
                NoLoans := NoLoans + 1;

        end;
        //END;
        // IF LoanApp."Expected Date of Completion" > TODAY THEN BEGIN
        //
        //
        //  END
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
            Loans.CalcFields(Loans."Outstanding Balance");
            ApprovedAmount := Loans."Outstanding Balance";

            //*******************************************************************************************************************
            if LoanApp."Repayment Frequency" = LoanApp."repayment frequency"::Monthly then begin
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
            LSchedule.SetRange(LSchedule."Loan No.", LoanApp."Loan  No.");
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
            Loans.SetRange(Loans."Loan  No.", LoanApp."Loan  No.");
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
            LoanApp."Amount in Arrears" := Arrears;
            if MonthlyRepayment <> 0 then begin
                if Arrears > MonthlyRepayment then
                    LoanApp."Days In Arrears" := ROUND((Arrears / MonthlyRepayment) * 30, 1, '<');
                if Arrears < MonthlyRepayment then
                    LoanApp."Days In Arrears" := 0;

            end;
            LoanApp.Modify;

            //.........................................................................................................End Amount in Arrears
            /* IF Arrears<> 0 THEN BEGIN
                 IF MonthlyRepayment=0 THEN BEGIN
                   NoofMonthsinArrears:=13*30;//12+
                 END ELSE BEGIN
                   DateDiff:=(LastMonth-ExpectedDateofCompletion)/30;
                   IF DateDiff>=1 THEN BEGIN
                     NoofMonthsinArrears:=13*30//13+;
                      END ELSE BEGIN
                     NoofMonthsinArrears:=ROUND((Arrears/MonthlyRepayment)*29,1,'>');
                   END;
                 END;
             END;*/
            //  MESSAGE ('NoofMonthsinArrears IS %1' ,NoofMonthsinArrears);
            Cat := '';
            daysinarr := LoanApp."Days In Arrears";
            if MonthlyRepayment <> 0 then begin
                if Arrears > MonthlyRepayment then
                    NoofMonthsinArrears := ROUND((Arrears / MonthlyRepayment), 0.5, '>');

                if Arrears < MonthlyRepayment then
                    NoofMonthsinArrears := 0;
            end;


            //MESSAGE ('NoofMonthsinArrears IS %1' ,daysinarr);

            //...........................................................................................................loan category
            if (Arrears = 0) then begin
                LoanApp."Loans Category" := Loans."loans category"::Perfoming;
                LoanApp."Loans Category-SASRA" := Loans."loans category-sasra"::Perfoming;
                LoanApp.Performing := true;
                Sorting := 1;
                Cat := Format(Loans."loans category"::Perfoming);
                Cat := Format(Loans."loans category-sasra"::Perfoming);
                "0Month" := LBal;
                "0MonthC" := "0MonthC" + 1;
                LoanApp.Modify;
            end else
                if (daysinarr < 1) then begin
                    LoanApp."Loans Category" := Loans."loans category"::Perfoming;
                    LoanApp."Loans Category-SASRA" := Loans."loans category-sasra"::Perfoming;
                    LoanApp.Performing := true;
                    Sorting := 1;
                    Cat := Format(Loans."loans category"::Perfoming);
                    Cat := Format(Loans."loans category-sasra"::Perfoming);
                    "0Month" := LBal;
                    "0MonthC" := "0MonthC" + 1;
                    LoanApp.Modify;
                end else
                    if (daysinarr >= 1) and (daysinarr <= 30) then begin
                        LoanApp."Loans Category" := Loans."loans category"::Watch;
                        LoanApp."Loans Category-SASRA" := Loans."loans category-sasra"::Watch;
                        LoanApp.watch := true;
                        Sorting := 2;
                        Cat := Format(Loans."loans category"::Watch);
                        Cat := Format(Loans."loans category-sasra"::Watch);
                        "1Month" := LBal;
                        "1MonthC" := "1MonthC" + 1;
                        LoanApp.Modify;
                    end else
                        if (daysinarr > 30) and (daysinarr <= 180) then begin
                            LoanApp."Loans Category" := Loans."loans category"::Substandard;
                            LoanApp."Loans Category-SASRA" := Loans."loans category-sasra"::Substandard;
                            LoanApp.Substandard := true;
                            Sorting := 3;
                            Cat := Format(Loans."loans category"::Substandard);
                            Cat := Format(Loans."loans category-sasra"::Substandard);
                            "2Month" := LBal;
                            "2MonthC" := "2MonthC" + 1;
                            LoanApp.Modify;
                        end else
                            if (daysinarr > 180) and (daysinarr <= 360) then begin
                                LoanApp."Loans Category" := Loans."loans category"::Doubtful;
                                LoanApp."Loans Category-SASRA" := Loans."loans category-sasra"::Doubtful;
                                LoanApp.Doubtful := true;
                                Sorting := 4;
                                Cat := Format(Loans."loans category"::Doubtful);
                                Cat := Format(Loans."loans category-sasra"::Doubtful);
                                "3Month" := LBal;
                                "3MonthC" := "3MonthC" + 1;
                                LoanApp.Modify;
                            end else
                                if (daysinarr > 360) then begin
                                    LoanApp."Loans Category" := Loans."loans category"::Loss;
                                    LoanApp."Loans Category-SASRA" := Loans."loans category-sasra"::Loss;
                                    LoanApp.loss := true;
                                    Sorting := 5;
                                    Cat := Format(Loans."loans category"::Loss);
                                    Cat := Format(Loans."loans category-sasra"::Loss);
                                    Over3Month := LBal;
                                    Over3MonthC := Over3MonthC + 1;
                                    LoanApp.Modify;
                                end;
            if daysinarr > 1 then
                LoanApp."Days In Arrears" := periodArrear;//ROUND(NoofMonthsinArrears,1,'=');
                                                          // MESSAGE('here');
                                                          //  LoanApp."No of Months in Arrears":=FORMAT(NoofMonthsinArrears);
                                                          // MESSAGE('here2');
                                                          //MESSAGE (FORMAT(LoanApp."No of Months in Arrears"));
                                                          // LoanApp.Rescheduled := true;
            LoanApp.Modify;

            GrandTotal := GrandTotal + LoanApp."Outstanding Balance";

            if ("0Month" + "1Month" + "2Month" + "3Month" + Over3Month) > 0 then
                NoLoans := NoLoans + 1;

            periodArrear := AsAt - Rescheduledate;

        end;

    end;



}
