codeunit 56701 LoanAgingProcessor
{
    trigger OnRun()
    begin
        // UpdateLoanArrears(Today,'');
    end;

    var
        LSchedule: Record "Loan Repayment Schedule";
        LoansRegister: Record "Loans Register";
        LoansTotal: Integer;
        Reached: Integer;
        PercentageDone: Decimal;
        DialogBox: Dialog;
        MonthsElapsed: Integer;

    procedure UpdateLoanArrears(AsAt: Date; loanNumberVar: Code[20])
    var
        Loans: Record "Loans Register";
        TempLoans: Record "Loans Register" temporary;
        loanNumber: Code[20];
        LBal: Decimal;
        Arrears: Decimal;
        CustLedgerEntry: Record "Cust. Ledger Entry";
        LastRepaymentDate: Date;
        // MonthlyRepayment: Decimal;
        ScheduledLoanBal: Decimal;
        // NoofMonthsinArrears: Decimal;
        // ExpectedDateofCompletion: Date;
        // Rescheduledate: Date;
        // periodArrear: Decimal;
        daysinarr: Decimal;
        // issueddate: Date;
        LastMonth: Date;
        DateFilter: Text;
        DialogOpen: Boolean;
    begin
        LastMonth := AsAt;
        DateFilter := '..' + Format(AsAt);

        // Load all posted loans issued on or before AsAt
        LoansRegister.Reset();
        LoansRegister.SetRange(LoansRegister.Posted, true);
        LoansRegister.SetFilter(LoansRegister."Issued Date", '<=%1', AsAt);
        if loanNumberVar <> '' then
            LoansRegister.SetRange("Loan  No.", loanNumberVar);

        if not LoansRegister.Find('-') then
            exit;

        LoansTotal := LoansRegister.Count();

        Reached := 0;
        DialogOpen := false;
        repeat
            // Reset per loan
            LBal := 0;
            Arrears := 0;
            // MonthlyRepayment := 0;
            // ScheduledLoanBal := 0;
            // NoofMonthsinArrears := 0;
            // ExpectedDateofCompletion := 0D;
            // Rescheduledate := 0D;
            // periodArrear := 0;
            ScheduledLoanBal := 0;
            daysinarr := 0;
            LoansRegister."Days In Arrears" := 0;

            Reached += 1;
            if (Reached mod 10) = 0 then begin
                PercentageDone := Round((Reached / LoansTotal) * 100, 1);
                DialogBox.Open('Processing ' + Format(Reached) + ' of ' + Format(LoansTotal) + ': ' + Format(PercentageDone) + '%');
                DialogOpen := true;

            end;

            loanNumber := LoansRegister."Loan  No.";

            // Skip loans missing key data
            if (LoansRegister."Loan Disbursement Date" = 0D) or (LoansRegister.Installments <= 0) then
                continue;

            // Get balance as at AsAt date using separate record
            Loans.Reset();
            Loans.SetRange(Loans."Loan  No.", loanNumber);
            Loans.SetFilter(Loans."Date filter", DateFilter);
            if Loans.Find('-') then begin
                Loans.CalcFields(Loans."Outstanding Balance");
                LBal := Round(Loans."Outstanding Balance", 1, '=');
            end;

            // Skip zero balance loans
            if LBal <= 0 then
                continue;

            // Get scheduled balance to calculate arrears
            LSchedule.Reset();
            LSchedule.SetCurrentKey(LSchedule."Loan No.", LSchedule."Repayment Date");
            LSchedule.SetRange(LSchedule."Loan No.", loanNumber);
            LSchedule.SetFilter(LSchedule."Repayment Date", '<=%1', AsAt);
            if LSchedule.FindLast() then
                ScheduledLoanBal := Round(LSchedule."Loan Balance", 1, '=');

            // Calculate arrears
            Arrears := LBal - ScheduledLoanBal;
            if Arrears < 0 then
                Arrears := 0;

            //Get last payment from customer ledger entries
            CustLedgerEntry.Reset();
            CustLedgerEntry.SetRange(CustLedgerEntry."Customer No.", LoansRegister."Client Code");
            CustLedgerEntry.SetRange(CustLedgerEntry."Loan No", loanNumber);
            CustLedgerEntry.SetFilter(CustLedgerEntry."Transaction Type", '%1|%2', CustLedgerEntry."Transaction Type"::"Loan Repayment",
            CustLedgerEntry."Transaction Type"::Loan);
            CustLedgerEntry.SetFilter(CustLedgerEntry."Posting Date", '..%1', AsAt);
            if CustLedgerEntry.FindLast() then
                LastRepaymentDate := CustLedgerEntry."Posting Date"
            else
                LastRepaymentDate := LoansRegister."Loan Disbursement Date";

            daysinarr := AsAt - LastRepaymentDate;

            if loanNumber in ['LND118', 'LND618'] then
                daysinarr := AsAt - DMY2Date(31, 12, 2013);
            IF loanNumber = 'LN8067' then
                daysinarr := AsAt - DMY2Date(30, 4, 2026);
            if daysinarr < 0 then
                daysinarr := 0;


            // Expected completion date
            // ExpectedDateofCompletion := CalcDate(Format(LoansRegister.Installments) + 'M', LoansRegister."Loan Disbursement Date");

            // // Get scheduled balance - last entry <= AsAt
            // LSchedule.Reset();
            // LSchedule.SetCurrentKey(LSchedule."Loan No.", LSchedule."Repayment Date");
            // LSchedule.SetRange(LSchedule."Loan No.", loanNumber);
            // LSchedule.SetFilter(LSchedule."Repayment Date", '<=%1', AsAt);
            // if LSchedule.FindLast() then begin
            //     ScheduledLoanBal := Round(LSchedule."Loan Balance", 1, '=');
            //     Rescheduledate := LSchedule."Repayment Date";
            // end;

            // // Get monthly repayment from first installment
            // LSchedule.SetRange(LSchedule."Repayment Date");
            // LSchedule.SetRange(LSchedule."Instalment No", 1);
            // if LSchedule.FindFirst() then begin
            //     MonthlyRepayment := Round(LSchedule."Principal Repayment", 1, '=');
            //     if (ScheduledLoanBal = 0) and (LSchedule."Repayment Date" > LastMonth) then
            //         ScheduledLoanBal := LBal;
            // end else begin
            //     ScheduledLoanBal := 0;

            //     LSchedule.Reset();
            //     LSchedule.SetRange("Loan No.", loanNumber);
            //     LSchedule.SetRange("Instalment No", 1);
            //     if LSchedule.FindFirst() then
            //         MonthlyRepayment := Round(LSchedule."Principal Repayment", 1, '=');
            // end;

            // if (MonthlyRepayment = 0) and (LoansRegister.Installments > 0) then
            //     MonthlyRepayment := Round(LoansRegister."Approved Amount" / LoansRegister.Installments, 1, '=');

            // if (ScheduledLoanBal = 0) and (MonthlyRepayment > 0) and (LoansRegister."Loan Disbursement Date" <> 0D) then begin

            //     MonthsElapsed := Round((AsAt - LoansRegister."Loan Disbursement Date") / 30, 1, '<');
            //     if MonthsElapsed > LoansRegister.Installments then
            //         MonthsElapsed := LoansRegister.Installments;
            //     ScheduledLoanBal := Round(LoansRegister."Approved Amount" - (MonthlyRepayment * MonthsElapsed), 1, '=');
            //     if ScheduledLoanBal < 0 then
            //         ScheduledLoanBal := 0;
            // end;
            // // Calculate arrears
            // issueddate := CalcDate('1M', LoansRegister."Loan Disbursement Date");
            // if issueddate > AsAt then
            //     Arrears := 0
            // else
            //     Arrears := LBal - ScheduledLoanBal;

            // if Arrears < 0 then
            //     Arrears := 0;

            // // Days in arrears
            // if MonthlyRepayment <> 0 then
            //     LoansRegister."Days In Arrears" := Round((Arrears / MonthlyRepayment) * 30, 1, '<');

            // IF MonthlyRepayment = 0 then LoansRegister."Days In Arrears" := 0;

            // // Months in arrears
            // if MonthlyRepayment <> 0 then
            //     NoofMonthsinArrears := Round((Arrears / MonthlyRepayment), 1, '<')
            // else
            //     if Arrears <> 0 then
            //         NoofMonthsinArrears := 13 * 30;

            // // Override days if loan past completion date
            // if (ExpectedDateofCompletion < AsAt) and (Rescheduledate = 0D) then
            //     daysinarr := AsAt - ExpectedDateofCompletion
            // else
            //     daysinarr := LoansRegister."Days In Arrears";

            // Set SASRA category
            if (Arrears >= -200) and (daysinarr <= 30) then begin
                // if daysinarr <= 30 then begin
                LoansRegister."Loans Category" := LoansRegister."loans category"::Perfoming;
                LoansRegister."Loans Category-SASRA" := LoansRegister."loans category-sasra"::Perfoming;
                LoansRegister.Performing := true;
                LoansRegister.watch := false;
                LoansRegister.Substandard := false;
                LoansRegister.Doubtful := false;
                LoansRegister.loss := false;
            end else if (daysinarr > 30) and (daysinarr <= 90) then begin
                LoansRegister."Loans Category" := LoansRegister."loans category"::Watch;
                LoansRegister."Loans Category-SASRA" := LoansRegister."loans category-sasra"::Watch;
                LoansRegister.Performing := false;
                LoansRegister.watch := true;
                LoansRegister.Substandard := false;
                LoansRegister.Doubtful := false;
                LoansRegister.loss := false;
            end else if (daysinarr > 90) and (daysinarr <= 180) then begin
                LoansRegister."Loans Category" := LoansRegister."loans category"::Substandard;
                LoansRegister."Loans Category-SASRA" := LoansRegister."loans category-sasra"::Substandard;
                LoansRegister.Performing := false;
                LoansRegister.watch := false;
                LoansRegister.Substandard := true;
                LoansRegister.Doubtful := false;
                LoansRegister.loss := false;
            end else if (daysinarr > 180) and (daysinarr <= 360) then begin
                LoansRegister."Loans Category" := LoansRegister."loans category"::Doubtful;
                LoansRegister."Loans Category-SASRA" := LoansRegister."loans category-sasra"::Doubtful;
                LoansRegister.Performing := false;
                LoansRegister.watch := false;
                LoansRegister.Substandard := false;
                LoansRegister.Doubtful := true;
                LoansRegister.loss := false;
            end else if daysinarr > 360 then begin
                LoansRegister."Loans Category" := LoansRegister."loans category"::Loss;
                LoansRegister."Loans Category-SASRA" := LoansRegister."loans category-sasra"::Loss;
                LoansRegister.Performing := false;
                LoansRegister.watch := false;
                LoansRegister.Substandard := false;
                LoansRegister.Doubtful := false;
                LoansRegister.loss := true;
            end;



            // LoansRegister."Amount in Arrears" := Arrears;
            // if (NoofMonthsinArrears > 1) and (Arrears > 0) then
            //     periodArrear := AsAt - Rescheduledate
            // else
            //     periodArrear := LoansRegister."Days In Arrears";

            LoansRegister."Amount in Arrears" := Arrears;
            LoansRegister."Days In Arrears" := daysinarr;
            LoansRegister."No of Months in Arrears" := Round(daysinarr / 30, 1, '<');
            // LoansRegister."No of Months in Arrears" := NoofMonthsinArrears;


            TempLoans.TransferFields(LoansRegister);
            if not TempLoans.Insert() then
                TempLoans.Modify();

        until LoansRegister.Next() = 0;
        if DialogOpen then
            DialogBox.Close();

        // BATCH SAVE - write all results to database at once
        if TempLoans.Find('-') then
            repeat
                if LoansRegister.Get(TempLoans."Loan  No.") then begin
                    LoansRegister."Amount in Arrears" := TempLoans."Amount in Arrears";
                    LoansRegister."Days In Arrears" := TempLoans."Days In Arrears";
                    LoansRegister."No of Months in Arrears" := TempLoans."No of Months in Arrears";
                    LoansRegister."Loans Category" := TempLoans."Loans Category";
                    LoansRegister."Loans Category-SASRA" := TempLoans."Loans Category-SASRA";
                    LoansRegister.Performing := TempLoans.Performing;
                    LoansRegister.watch := TempLoans.watch;
                    LoansRegister.Substandard := TempLoans.Substandard;
                    LoansRegister.Doubtful := TempLoans.Doubtful;
                    LoansRegister.loss := TempLoans.loss;
                    LoansRegister.Modify(true);
                end;
            until TempLoans.Next() = 0;
    end;
}