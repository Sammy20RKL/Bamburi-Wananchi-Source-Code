codeunit 59025 "Bamburi Loan Distribution"
{
    procedure DistributeTotalLoans(var CheckoffLine: Record "Bamburi CheckoffLines"; LoanCutOffDate: Date)
    var
        RemainingAmount: Decimal;
        InterestAmt: Decimal;
        PrincipalAmt: Decimal;
        TotalAmt: Decimal;
    begin
        // Initialize all loan fields to zero
        ClearAllLoanFields(CheckoffLine);

        // Get the total amount to distribute
        RemainingAmount := CheckoffLine."Total Loans";

        if RemainingAmount <= 0 then
            exit;

        // Distribute in priority order (Interest first for each loan type)

        // 1. Emergency Loan - Type 'EMER'
        RemainingAmount := ProcessLoan(CheckoffLine."Member No", 'EMER', RemainingAmount, LoanCutOffDate, InterestAmt, PrincipalAmt, TotalAmt);
        if TotalAmt > 0 then begin
            CheckoffLine."Emergency Loan Interest" := InterestAmt;
            CheckoffLine."Emergency Loan  Principle" := PrincipalAmt;
            CheckoffLine."Emergency Loan Amount" := TotalAmt;
        end;

        // 2. Kivukio Loan - Type 'KIVUK'
        RemainingAmount := ProcessLoan(CheckoffLine."Member No", 'KIVUK', RemainingAmount, LoanCutOffDate, InterestAmt, PrincipalAmt, TotalAmt);
        if TotalAmt > 0 then begin
            CheckoffLine."Kivukio Loan Interest" := InterestAmt;
            CheckoffLine."Kivukio Loan Principle" := PrincipalAmt;
            CheckoffLine."Kivukio Loan Amount" := TotalAmt;
        end;

        // 3. Mwokozi Loan - Type 'MWOK'
        RemainingAmount := ProcessLoan(CheckoffLine."Member No", 'MWOK', RemainingAmount, LoanCutOffDate, InterestAmt, PrincipalAmt, TotalAmt);
        if TotalAmt > 0 then begin
            CheckoffLine."Mwokozi Loan Interest" := InterestAmt;
            CheckoffLine."Mwokozi Loan Principle" := PrincipalAmt;
            CheckoffLine."Mwokozi Loan Amount" := TotalAmt;
        end;

        // 4. School Fees Loan - Type 'SCHLOAN'
        RemainingAmount := ProcessLoan(CheckoffLine."Member No", 'SCHLOAN', RemainingAmount, LoanCutOffDate, InterestAmt, PrincipalAmt, TotalAmt);
        if TotalAmt > 0 then begin
            CheckoffLine."School Fees Interest" := InterestAmt;
            CheckoffLine."School Fees Principle" := PrincipalAmt;
            CheckoffLine."School Fees Amount" := TotalAmt;
        end;

        // 5. Normal Loan 1 - Type 'NORM1'
        RemainingAmount := ProcessLoan(CheckoffLine."Member No", 'NORM1', RemainingAmount, LoanCutOffDate, InterestAmt, PrincipalAmt, TotalAmt);
        if TotalAmt > 0 then begin
            CheckoffLine."Normal Loan 1 Interest" := InterestAmt;
            CheckoffLine."Normal Loan 1 Principle" := PrincipalAmt;
            CheckoffLine."Normal Loan 1 Amount" := TotalAmt;
        end;

        // 6. Normal Loan 2 - Type 'NORM2'
        RemainingAmount := ProcessLoan(CheckoffLine."Member No", 'NORM2', RemainingAmount, LoanCutOffDate, InterestAmt, PrincipalAmt, TotalAmt);
        if TotalAmt > 0 then begin
            CheckoffLine."Normal Loan 2 Interest" := InterestAmt;
            CheckoffLine."Normal Loan 2 Principle" := PrincipalAmt;
            CheckoffLine."Normal Loan 2 Amount" := TotalAmt;
        end;

        // 7. Normal Loan 3 - Type 'NORM3'
        RemainingAmount := ProcessLoan(CheckoffLine."Member No", 'NORM3', RemainingAmount, LoanCutOffDate, InterestAmt, PrincipalAmt, TotalAmt);
        if TotalAmt > 0 then begin
            CheckoffLine."Normal Loan 3 Interest" := InterestAmt;
            CheckoffLine."Normal Loan 3 Principle" := PrincipalAmt;
            CheckoffLine."Normal Loan 3 Amount" := TotalAmt;
        end;

        // 8. Normal Loan 4 - Type 'NORM4'
        RemainingAmount := ProcessLoan(CheckoffLine."Member No", 'NORM4', RemainingAmount, LoanCutOffDate, InterestAmt, PrincipalAmt, TotalAmt);
        if TotalAmt > 0 then begin
            CheckoffLine."Normal loan 4 Interest" := InterestAmt;
            CheckoffLine."Normal loan 4 Principle" := PrincipalAmt;
            CheckoffLine."Normal loan 4 Amount" := TotalAmt;
        end;

        // 9. Instant Loan - Type 'INST'
        RemainingAmount := ProcessLoan(CheckoffLine."Member No", 'INST', RemainingAmount, LoanCutOffDate, InterestAmt, PrincipalAmt, TotalAmt);
        if TotalAmt > 0 then begin
            CheckoffLine."Instant Loan Interest" := InterestAmt;
            CheckoffLine."Instant Loan Principle" := PrincipalAmt;
            CheckoffLine."Instant Loan Amount" := TotalAmt;
        end;

        // 10. New Product Loan - Type 'NEWPRO'
        RemainingAmount := ProcessLoan(CheckoffLine."Member No", 'NEWPRO', RemainingAmount, LoanCutOffDate, InterestAmt, PrincipalAmt, TotalAmt);
        if TotalAmt > 0 then begin
            CheckoffLine."New Product Loan Interest" := InterestAmt;
            CheckoffLine."New Product Loan Principle" := PrincipalAmt;
            CheckoffLine."New Product Loan Amount" := TotalAmt;
        end;

        // If there's any remaining amount, transfer to Deposit Contribution
        if RemainingAmount > 0 then begin
            CheckoffLine."Deposit Contribution" := CheckoffLine."Deposit Contribution" + RemainingAmount;
        end;

        // Update the checkoff line
        CheckoffLine.Modify(true);
    end;

    local procedure ProcessLoan(
        MemberNo: Code[20];
        LoanProductCode: Code[10];
        AvailableAmount: Decimal;
        CutOffDate: Date;
        var InterestToPay: Decimal;
        var PrincipalToPay: Decimal;
        var TotalToPay: Decimal
    ): Decimal
    var
        LoansRegister: Record "Loans Register";

        LoanRepaymentSchedule: Record "Loan Repayment Schedule";

        ScheduledInterest: Decimal;

        ScheduledPrincipal: Decimal;

        BeginMonthDate: Date;
    begin
        // Initialize return values
        InterestToPay := 0;

        PrincipalToPay := 0;

        TotalToPay := 0;

        if AvailableAmount <= 0 then
            exit(0);

        // Calculate begin month date (15th of previous month to cutoff date)
        BeginMonthDate := CalcDate('<-CM+14D>', CutOffDate);

        // Find the active loan for this member and loan type
        LoansRegister.Reset();
        LoansRegister.SetRange("Client Code", MemberNo);
        LoansRegister.SetRange("Loan Product Type", LoanProductCode);
        LoansRegister.SetRange(Posted, true);
        LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
        LoansRegister.SetAutoCalcFields("Outstanding Balance", "Oustanding Interest");
        LoansRegister.SetCurrentKey("Client Code", "Application Date");
        LoansRegister.SetFilter("Repayment Start Date", '..%1', CutOffDate);
        LoansRegister.Ascending(false); // Latest loans first

        if not LoansRegister.FindFirst() then
            exit(AvailableAmount); // No active loan found, return full amount

        // Calculate outstanding balances
        LoansRegister.CalcFields("Outstanding Balance", "Oustanding Interest", "Interest Due");

        // Initialize scheduled amounts
        ScheduledInterest := 0;
        ScheduledPrincipal := 0;

        // CRITICAL: Find the repayment schedule entry for THIS MONTH
        LoanRepaymentSchedule.Reset();
        LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
        LoanRepaymentSchedule.SetFilter("Repayment Date", '%1..%2', CutOffDate, CalcDate('CM', CutOffDate));

        if LoanRepaymentSchedule.FindLast() then begin
            // FOUND SCHEDULE FOR THIS MONTH - Use actual scheduled amounts
            ScheduledInterest := Round(LoanRepaymentSchedule."Monthly Interest", 0.01, '=');
            ScheduledPrincipal := Round(LoanRepaymentSchedule."Principal Repayment", 0.01, '=');

            // Validate against outstanding balances
            if ScheduledPrincipal > LoansRegister."Outstanding Balance" then
                ScheduledPrincipal := Round(LoansRegister."Outstanding Balance", 0.01, '=');

            if ScheduledInterest > LoansRegister."Oustanding Interest" then
                ScheduledInterest := Round(LoansRegister."Oustanding Interest", 0.01, '=');

        end else begin
            // NO SCHEDULE FOUND FOR THIS MONTH - Try to find ANY schedule entry
            LoanRepaymentSchedule.Reset();
            LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");

            if LoanRepaymentSchedule.FindLast() then begin
                // Use the last schedule entry amounts
                ScheduledInterest := Round(LoanRepaymentSchedule."Monthly Interest", 0.01, '=');
                ScheduledPrincipal := Round(LoanRepaymentSchedule."Principal Repayment", 0.01, '=');

                // Validate against outstanding balances
                if ScheduledPrincipal > LoansRegister."Outstanding Balance" then
                    ScheduledPrincipal := Round(LoansRegister."Outstanding Balance", 0.01, '=');

                if ScheduledInterest > LoansRegister."Oustanding Interest" then
                    ScheduledInterest := Round(LoansRegister."Oustanding Interest", 0.01, '=');

            end else begin
                // FALLBACK: No schedule at all - use outstanding balances
                // Calculate interest manually if needed
                if LoansRegister."Oustanding Interest" > 0 then
                    ScheduledInterest := Round(LoansRegister."Oustanding Interest", 0.01, '=')
                else
                    ScheduledInterest := Round(LoansRegister."Approved Amount" * (LoansRegister.Interest / 1200), 0.01, '=');

                ScheduledPrincipal := Round(LoansRegister."Outstanding Balance", 0.01, '=');
            end;
        end;

        // NOW DISTRIBUTE THE AVAILABLE AMOUNT
        // STEP 1: PAY INTEREST FIRST (Priority 1)
        if ScheduledInterest > 0 then begin
            if AvailableAmount >= ScheduledInterest then begin
                // Full interest can be paid
                InterestToPay := ScheduledInterest;
                AvailableAmount := AvailableAmount - ScheduledInterest;
            end else begin
                // Partial interest payment
                InterestToPay := AvailableAmount;
                AvailableAmount := 0;
            end;
        end;

        // STEP 2: PAY PRINCIPAL SECOND (Priority 2)
        if (AvailableAmount > 0) and (ScheduledPrincipal > 0) then begin
            if AvailableAmount >= ScheduledPrincipal then begin
                // Full principal can be paid
                PrincipalToPay := ScheduledPrincipal;
                AvailableAmount := AvailableAmount - ScheduledPrincipal;
            end else begin
                // Partial principal payment
                PrincipalToPay := AvailableAmount;
                AvailableAmount := 0;
            end;
        end;

        // Calculate total amount allocated to this loan
        TotalToPay := Round(InterestToPay + PrincipalToPay, 0.01, '=');

        // Return remaining amount
        exit(AvailableAmount);
    end;

    local procedure ClearAllLoanFields(var CheckoffLine: Record "Bamburi CheckoffLines")
    begin
        CheckoffLine."Emergency Loan Amount" := 0;
        CheckoffLine."Emergency Loan  Principle" := 0;
        CheckoffLine."Emergency Loan Interest" := 0;

        CheckoffLine."Kivukio Loan Amount" := 0;
        CheckoffLine."Kivukio Loan Principle" := 0;
        CheckoffLine."Kivukio Loan Interest" := 0;

        CheckoffLine."Mwokozi Loan Amount" := 0;
        CheckoffLine."Mwokozi Loan Principle" := 0;
        CheckoffLine."Mwokozi Loan Interest" := 0;

        CheckoffLine."School Fees Amount" := 0;
        CheckoffLine."School Fees Principle" := 0;
        CheckoffLine."School Fees Interest" := 0;

        CheckoffLine."New Product Loan Amount" := 0;
        CheckoffLine."New Product Loan Principle" := 0;
        CheckoffLine."New Product Loan Interest" := 0;

        CheckoffLine."Normal Loan 1 Amount" := 0;
        CheckoffLine."Normal Loan 1 Principle" := 0;
        CheckoffLine."Normal Loan 1 Interest" := 0;

        CheckoffLine."Normal Loan 2 Amount" := 0;
        CheckoffLine."Normal Loan 2 Principle" := 0;
        CheckoffLine."Normal Loan 2 Interest" := 0;

        CheckoffLine."Normal Loan 3 Amount" := 0;
        CheckoffLine."Normal Loan 3 Principle" := 0;
        CheckoffLine."Normal Loan 3 Interest" := 0;

        CheckoffLine."Normal loan 4 Amount" := 0;
        CheckoffLine."Normal loan 4 Principle" := 0;
        CheckoffLine."Normal loan 4 Interest" := 0;

        CheckoffLine."Instant Loan Amount" := 0;
        CheckoffLine."Instant Loan Principle" := 0;
        CheckoffLine."Instant Loan Interest" := 0;
    end;

    procedure ProcessAllCheckoffLines(HeaderNo: Code[20]; LoanCutOffDate: Date)
    var
        CheckoffLine: Record "Bamburi CheckoffLines";
        ProcessedCount: Integer;
        SkippedCount: Integer;
    begin
        CheckoffLine.Reset();
        CheckoffLine.SetRange("Receipt Header No", HeaderNo);
        CheckoffLine.SetRange(Posted, false);

        if not CheckoffLine.FindSet() then begin
            Message('No checkoff lines found. Please import checkoff data first.');
            exit;
        end;

        repeat
            if CheckoffLine."Total Loans" > 0 then begin
                DistributeTotalLoans(CheckoffLine, LoanCutOffDate);
                ProcessedCount += 1;
            end else
                SkippedCount += 1;
        until CheckoffLine.Next() = 0;

        if ProcessedCount > 0 then
            Message('Successfully distributed loans for %1 member(s)', ProcessedCount, SkippedCount)
        else
            Message('No members with Total Loans > 0 found.');
    end;
}
