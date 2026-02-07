
codeunit 56701 LoanAgingProcessor
{
    trigger OnRun()
    begin
        UpdateLoanArrears(Today);
    end;

    var
        periodArrear: Decimal;
        Rescheduledate: Date;
        ExpectedBalance: Decimal;
        // "1Month": Decimal;
        // "2Month": Decimal;
        // "3Month": Decimal;
        // Over3Month: Decimal;
        // "0MonthC": Decimal;
        // "1MonthC": Decimal;
        // "2MonthC": Decimal;
        // "3MonthC": Decimal;
        // Over3MonthC: Decimal;
        NoLoans: Integer;
        GrandTotal: Decimal;
        // "0Month": Decimal;
        LSchedule: Record "Loan Repayment Schedule";
        RepaymentPeriod: Date;
        LastMonth: Date;
        ScheduledLoanBal: Decimal;
        DateFilter: Text;
        LBal: Decimal;
        Arrears: Decimal;
        NoofMonthsinArrears: Decimal;
        MonthlyRepayment: Decimal;
        Last2Months: Date;
        // Sorting: Integer;
        ApprovedAmount: Decimal;
        ExpectedDateofCompletion: Date;
        DateDiff: Decimal;
        OutstandBal: Decimal;
        issueddate: Date;
        daysinarr: Decimal;
        LoansRegister: Record "Loans Register";
        LoansTotal: Integer;
        Reached: integer;
        PercentageDone: Decimal;
        DialogBox: Dialog;

    procedure UpdateLoanArrears(AsAt: Date)
    var
        Loans: Record "Loans Register";
        loanNumber: Code[20];
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
        // Cat := '';

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

        //get the loan from the main LoansRegister table
        LoansRegister.Reset();
        LoansRegister.SetRange(LoansRegister.Posted, true);
        LoansRegister.SetFilter(LoansRegister."Date filter", '..' + Format(AsAt));
        LoansRegister.SetAutocalcFields(LoansRegister."Scheduled Principle Payments", LoansRegister."Schedule Loan Amount Issued", LoansRegister."Schedule Installments", LoansRegister."Outstanding Balance", LoansRegister."Oustanding Interest", LoansRegister."Scheduled Interest Payments", LoansRegister."Interest Paid", LoansRegister."Principal Paid");
        if LoansRegister.Find('-') then begin

            LoansTotal := 0;
            LoansTotal := LoansRegister.Count();
            Reached := 0;
            PercentageDone := 0;

            repeat
                //re-assign values
                NoofMonthsinArrears := 0;
                ApprovedAmount := 0;
                DateDiff := 0;
                MonthlyRepayment := 0;
                ScheduledLoanBal := 0;
                LBal := 0;
                Arrears := 0;
                OutstandBal := 0;
                ExpectedDateofCompletion := 0D;
                // Cat := '';

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

                daysinarr := 0;
                periodArrear := 0;

                // //.............Update Armotised loan schedules
                //............................................
                Reached := Reached + 1;
                PercentageDone := (Reached / LoansTotal) * 100;
                DialogBox.Open('Processing ' + Format(Reached) + ' of ' + Format(LoansTotal) + ': Percentage= ' + Format(Round(PercentageDone)));

                loanNumber := LoansRegister."Loan  No.";
                Loans.Reset;
                Loans.SetRange(Loans."Loan  No.", LoansRegister."Loan  No.");
                // Loans.SetRange(Loans.Rescheduled, false);
                if Loans.Find('-') then begin
                    Loans.CalcFields("Outstanding Balance");
                    ApprovedAmount := Loans."Outstanding Balance";

                    //just work with loans with balances
                    if ApprovedAmount > 0 then begin

                        //*******************************************************************************************************************
                        if LoansRegister."Repayment Frequency" = LoansRegister."repayment frequency"::Monthly then begin
                            LastMonth := RepaymentPeriod;
                            Last2Months := CalcDate('-1M', AsAt);
                        end;

                        //get the expected date of completion..
                        ExpectedDateofCompletion := CalcDate(Format(Loans.Installments) + 'M', Loans."Loan Disbursement Date");// "Issued Date");

                        //get the scheduled balance as per AsAt date...
                        LSchedule.Reset;
                        LSchedule.SetRange(LSchedule."Loan No.", loanNumber);
                        LSchedule.SetFilter(LSchedule."Repayment Date", '<=%1', AsAt);
                        if LSchedule.FindLast then begin
                            ScheduledLoanBal := ROUND(LSchedule."Loan Balance", 1, '=');
                        end;

                        //*********************************************************************************************************************************************88
                        Rescheduledate := LSchedule."Repayment Date";

                        //cross check the scheduled balance might be the loan amt(Outstanding Balance), for new loans
                        LSchedule.Reset;
                        LSchedule.SetRange(LSchedule."Loan No.", loanNumber);
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
                        Loans.SetRange(Loans."Loan  No.", loanNumber);
                        Loans.SetFilter(Loans."Date filter", DateFilter);
                        if Loans.Find('-') then begin
                            Loans.CalcFields(Loans."Outstanding Balance");
                            LBal := ROUND(Loans."Outstanding Balance", 1, '=');
                        end;
                        //**************************************************************************************************************************************************************
                        //Calculatee the Arrears in respect to loans issued within this month
                        issueddate := CalcDate('1M', Loans."Loan Disbursement Date");// "Issued Date");
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
                        LoansRegister."Amount in Arrears" := Arrears;

                        //update the days in Arrears
                        if MonthlyRepayment <> 0 then begin
                            LoansRegister."Days In Arrears" := ROUND((Arrears / MonthlyRepayment) * 30, 1, '<');

                        end;

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
                            daysinarr := LoansRegister."Days In Arrears";
                        end;
                        //...........................................................................................................loan category

                        // update the SASRA Categorizations
                        if (Arrears = 0) then begin
                            LoansRegister."Loans Category" := Loans."loans category"::Perfoming;
                            LoansRegister."Loans Category-SASRA" := Loans."loans category-sasra"::Perfoming;
                            LoansRegister.Performing := true;
                        end else
                            if (daysinarr < 1) then begin
                                LoansRegister."Loans Category" := Loans."loans category"::Perfoming;
                                LoansRegister."Loans Category-SASRA" := Loans."loans category-sasra"::Perfoming;
                                LoansRegister.Performing := true;
                            end else
                                if (daysinarr >= 1) and (daysinarr <= 30) then begin
                                    LoansRegister."Loans Category" := Loans."loans category"::Watch;
                                    LoansRegister."Loans Category-SASRA" := Loans."loans category-sasra"::Watch;
                                    LoansRegister.watch := true;
                                end else
                                    if (daysinarr > 30) and (daysinarr <= 180) then begin
                                        LoansRegister."Loans Category" := Loans."loans category"::Substandard;
                                        LoansRegister."Loans Category-SASRA" := Loans."loans category-sasra"::Substandard;
                                        LoansRegister.Substandard := true;
                                    end else
                                        if (daysinarr > 180) and (daysinarr <= 360) then begin
                                            LoansRegister."Loans Category" := Loans."loans category"::Doubtful;
                                            LoansRegister."Loans Category-SASRA" := Loans."loans category-sasra"::Doubtful;
                                            LoansRegister.Doubtful := true;
                                        end else
                                            if (daysinarr > 360) then begin
                                                LoansRegister."Loans Category" := Loans."loans category"::Loss;
                                                LoansRegister."Loans Category-SASRA" := Loans."loans category-sasra"::Loss;
                                                LoansRegister.loss := true;
                                            end;
                        if NoofMonthsinArrears > 1 then
                            periodArrear := AsAt - Rescheduledate;

                        LoansRegister."Days In Arrears" := periodArrear;
                        LoansRegister."No of Months in Arrears" := NoofMonthsinArrears;
                        LoansRegister.Modify(true);
                    end;
                end;
            until LoansRegister.Next = 0;
        end;
        DialogBox.Close();
    end;

}
