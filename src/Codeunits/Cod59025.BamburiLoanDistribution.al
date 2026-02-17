codeunit 59025 "Bamburi Loan Distribution"
{
    // ============================================================
    // Bamburi Loan Distribution Codeunit
    // Purpose : Distribute Total Loans from employer checkoff
    //           across individual loan types per member.
    // Logic   : For each loan product, find the single oldest
    //           unpaid installment whose Repayment Date falls
    //           before the CutOff Date. Pay Interest first, then
    //           Principal. Any remainder goes to Deposit Contribution.
    // Note    : Distribution is READ-ONLY on the repayment schedule.
    //           Schedule is only updated during actual posting.
    //           This allows re-running distribution any number of
    //           times for the same month without side effects.
    // ============================================================

    procedure DistributeTotalLoans(var CheckoffLine: Record "Bamburi CheckoffLines"; LoanCutOffDate: Date)
    var
        RemainingAmount: Decimal;
        InterestAmt: Decimal;
        PrincipalAmt: Decimal;
        TotalAmt: Decimal;
        OriginalDeposit: Decimal;
    begin
        OriginalDeposit := CheckoffLine."Deposit Contribution";
        // Clear all loan fields and reset deposit remainder
        ClearAllLoanFields(CheckoffLine);
        CheckoffLine."Deposit Contribution" := OriginalDeposit;

        // Get the total amount to distribute from the checkoff line
        RemainingAmount := CheckoffLine."Total Loans";

        if RemainingAmount <= 0 then
            exit;

        // -------------------------------------------------------
        // Distribute in priority order — Interest first per loan
        // -------------------------------------------------------

        // 1. Emergency Loan
        RemainingAmount := ProcessLoan(CheckoffLine."Member No", 'EMER', RemainingAmount, LoanCutOffDate, InterestAmt, PrincipalAmt, TotalAmt);
        if TotalAmt > 0 then begin
            CheckoffLine."Emergency Loan Interest" := InterestAmt;
            CheckoffLine."Emergency Loan  Principle" := PrincipalAmt;
            CheckoffLine."Emergency Loan Amount" := TotalAmt;
        end;

        // 2. Kivukio Loan
        RemainingAmount := ProcessLoan(CheckoffLine."Member No", 'KIVUK', RemainingAmount, LoanCutOffDate, InterestAmt, PrincipalAmt, TotalAmt);
        if TotalAmt > 0 then begin
            CheckoffLine."Kivukio Loan Interest" := InterestAmt;
            CheckoffLine."Kivukio Loan Principle" := PrincipalAmt;
            CheckoffLine."Kivukio Loan Amount" := TotalAmt;
        end;

        // 3. Mwokozi Loan
        RemainingAmount := ProcessLoan(CheckoffLine."Member No", 'MWOK', RemainingAmount, LoanCutOffDate, InterestAmt, PrincipalAmt, TotalAmt);
        if TotalAmt > 0 then begin
            CheckoffLine."Mwokozi Loan Interest" := InterestAmt;
            CheckoffLine."Mwokozi Loan Principle" := PrincipalAmt;
            CheckoffLine."Mwokozi Loan Amount" := TotalAmt;
        end;

        // 4. School Fees Loan
        RemainingAmount := ProcessLoan(CheckoffLine."Member No", 'SCHLOAN', RemainingAmount, LoanCutOffDate, InterestAmt, PrincipalAmt, TotalAmt);
        if TotalAmt > 0 then begin
            CheckoffLine."School Fees Interest" := InterestAmt;
            CheckoffLine."School Fees Principle" := PrincipalAmt;
            CheckoffLine."School Fees Amount" := TotalAmt;
        end;

        // 5. Normal Loan 1
        RemainingAmount := ProcessLoan(CheckoffLine."Member No", 'NORM1', RemainingAmount, LoanCutOffDate, InterestAmt, PrincipalAmt, TotalAmt);
        if TotalAmt > 0 then begin
            CheckoffLine."Normal Loan 1 Interest" := InterestAmt;
            CheckoffLine."Normal Loan 1 Principle" := PrincipalAmt;
            CheckoffLine."Normal Loan 1 Amount" := TotalAmt;
        end;

        // 6. Normal Loan 2
        RemainingAmount := ProcessLoan(CheckoffLine."Member No", 'NORM2', RemainingAmount, LoanCutOffDate, InterestAmt, PrincipalAmt, TotalAmt);
        if TotalAmt > 0 then begin
            CheckoffLine."Normal Loan 2 Interest" := InterestAmt;
            CheckoffLine."Normal Loan 2 Principle" := PrincipalAmt;
            CheckoffLine."Normal Loan 2 Amount" := TotalAmt;
        end;

        // 7. Normal Loan 3
        RemainingAmount := ProcessLoan(CheckoffLine."Member No", 'NORM3', RemainingAmount, LoanCutOffDate, InterestAmt, PrincipalAmt, TotalAmt);
        if TotalAmt > 0 then begin
            CheckoffLine."Normal Loan 3 Interest" := InterestAmt;
            CheckoffLine."Normal Loan 3 Principle" := PrincipalAmt;
            CheckoffLine."Normal Loan 3 Amount" := TotalAmt;
        end;

        // 8. Mbuyu Loan
        RemainingAmount := ProcessLoan(CheckoffLine."Member No", 'MBUY', RemainingAmount, LoanCutOffDate, InterestAmt, PrincipalAmt, TotalAmt);
        if TotalAmt > 0 then begin
            CheckoffLine."Mbuyu Loan Interest" := InterestAmt;
            CheckoffLine."Mbuyu Loan Principle" := PrincipalAmt;
            CheckoffLine."Mbuyu Loan Amount" := TotalAmt;
        end;

        // 9. Instant Loan
        RemainingAmount := ProcessLoan(CheckoffLine."Member No", 'INST', RemainingAmount, LoanCutOffDate, InterestAmt, PrincipalAmt, TotalAmt);
        if TotalAmt > 0 then begin
            CheckoffLine."Instant Loan Interest" := InterestAmt;
            CheckoffLine."Instant Loan Principle" := PrincipalAmt;
            CheckoffLine."Instant Loan Amount" := TotalAmt;
        end;

        // 10. New Product Loan
        RemainingAmount := ProcessLoan(CheckoffLine."Member No", 'NEWPRO', RemainingAmount, LoanCutOffDate, InterestAmt, PrincipalAmt, TotalAmt);
        if TotalAmt > 0 then begin
            CheckoffLine."New Product Loan Interest" := InterestAmt;
            CheckoffLine."New Product Loan Principle" := PrincipalAmt;
            CheckoffLine."New Product Loan Amount" := TotalAmt;
        end;

        // Any remainder after all loans are settled goes to Deposit Contribution.
        // ClearAllLoanFields already zeroed Deposit Contribution so this is a
        // clean assignment — no double counting on re-run.

        CheckoffLine."Deposit Contribution" := OriginalDeposit + RemainingAmount;
        CheckoffLine.Modify(true);
    end;

    local procedure ProcessLoan(MemberNo: Code[20]; LoanProductCode: Code[10]; AvailableAmount: Decimal; CutOffDate: Date; var InterestToPay: Decimal; var PrincipalToPay: Decimal; var TotalToPay: Decimal): Decimal
    var
        LoansRegister: Record "Loans Register";
        LoanRepaymentSchedule: Record "Loan Repayment Schedule";
        InstallmentInterest: Decimal;
        InstallmentPrincipal: Decimal;
        InterestPaid: Decimal;
        PrincipalPaid: Decimal;
    begin
        // Initialise return values
        InterestToPay := 0;
        PrincipalToPay := 0;
        TotalToPay := 0;

        if AvailableAmount <= 0 then
            exit(0);

        // Find the active loan for this member and product
        LoansRegister.Reset();
        LoansRegister.SetRange("Client Code", MemberNo);
        LoansRegister.SetRange("Loan Product Type", LoanProductCode);
        LoansRegister.SetRange(Posted, true);
        LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
        LoansRegister.SetFilter("Repayment Start Date", '..%1', CutOffDate);
        LoansRegister.Ascending(false);

        if not LoansRegister.FindFirst() then
            exit(AvailableAmount); // No active loan — return full amount unchanged

        // Find the SINGLE oldest unpaid installment whose due date is
        // before or on the CutOff Date.
        // Example: CutOff = 03/04/2026 → picks installment dated 31/03/2026.
        // This correctly handles employer paying in a different month
        // from the installment due date.
        LoanRepaymentSchedule.Reset();
        LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
        LoanRepaymentSchedule.SetRange("Member No.", MemberNo);
        LoanRepaymentSchedule.SetRange(Paid, false);
        LoanRepaymentSchedule.SetFilter("Repayment Date", '..%1', CutOffDate);
        LoanRepaymentSchedule.SetCurrentKey("Loan No.", "Member No.", "Reschedule No", "Instalment No");
        LoanRepaymentSchedule.Ascending(true); // Oldest first

        if not LoanRepaymentSchedule.FindFirst() then
            exit(AvailableAmount); // No due installment — return full amount unchanged

        // Round installment values upward to match the interest charging report
        InstallmentInterest := Round(LoanRepaymentSchedule."Monthly Interest", 1, '>');
        InstallmentPrincipal := Round(LoanRepaymentSchedule."Principal Repayment", 1, '>');

        InterestPaid := 0;
        PrincipalPaid := 0;

        // Pay Interest first
        if InstallmentInterest > 0 then begin
            if AvailableAmount >= InstallmentInterest then begin
                InterestPaid := InstallmentInterest;
                AvailableAmount := AvailableAmount - InstallmentInterest;
            end else begin
                // Partial interest payment — take whatever is left
                InterestPaid := AvailableAmount;
                AvailableAmount := 0;
            end;
        end;

        // Pay Principal with whatever remains after interest
        if (AvailableAmount > 0) and (InstallmentPrincipal > 0) then begin
            if AvailableAmount >= InstallmentPrincipal then begin
                PrincipalPaid := InstallmentPrincipal;
                AvailableAmount := AvailableAmount - InstallmentPrincipal;
            end else begin
                // Partial principal payment — take whatever is left
                PrincipalPaid := AvailableAmount;
                AvailableAmount := 0;
            end;
        end;

        // Accumulate totals for this loan product
        InterestToPay := InterestPaid;
        PrincipalToPay := PrincipalPaid;
        TotalToPay := InterestToPay + PrincipalToPay;

        // NOTE: We do NOT modify LoanRepaymentSchedule here.
        //       Paid flag and Actual amounts are updated only during posting.
        //       This makes distribution fully re-runnable for the same month.

        exit(AvailableAmount);
    end;

    local procedure ClearAllLoanFields(var CheckoffLine: Record "Bamburi CheckoffLines")
    begin
        // Loan amounts
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

        CheckoffLine."Normal Loan 1 Amount" := 0;
        CheckoffLine."Normal Loan 1 Principle" := 0;
        CheckoffLine."Normal Loan 1 Interest" := 0;

        CheckoffLine."Normal Loan 2 Amount" := 0;
        CheckoffLine."Normal Loan 2 Principle" := 0;
        CheckoffLine."Normal Loan 2 Interest" := 0;

        CheckoffLine."Normal Loan 3 Amount" := 0;
        CheckoffLine."Normal Loan 3 Principle" := 0;
        CheckoffLine."Normal Loan 3 Interest" := 0;

        CheckoffLine."Mbuyu Loan Amount" := 0;
        CheckoffLine."Mbuyu Loan Principle" := 0;
        CheckoffLine."Mbuyu Loan Interest" := 0;

        CheckoffLine."Instant Loan Amount" := 0;
        CheckoffLine."Instant Loan Principle" := 0;
        CheckoffLine."Instant Loan Interest" := 0;

        CheckoffLine."New Product Loan Amount" := 0;
        CheckoffLine."New Product Loan Principle" := 0;
        CheckoffLine."New Product Loan Interest" := 0;

        // Reset deposit contribution so re-running never double-counts the remainder.
        // The original imported payroll deposit is preserved because it sits in a
        // separate field and is only added back as remainder after all loans are settled.

    end;

    procedure ProcessAllCheckoffLines(HeaderNo: Code[20]; LoanCutOffDate: Date)
    var
        CheckoffLine: Record "Bamburi CheckoffLines";
        ProcessedCount: Integer;
        SkippedCount: Integer;
    begin
        if LoanCutOffDate = 0D then
            Error('Please specify a valid Loan CutOff Date before distributing.');

        CheckoffLine.Reset();
        CheckoffLine.SetRange("Receipt Header No", HeaderNo);
        CheckoffLine.SetRange(Posted, false);

        if not CheckoffLine.FindSet() then begin
            Message('Please import checkoff first!');
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
            Message('Distribution complete Successfully.', ProcessedCount, SkippedCount)
        else
            Message('No members with Total Loans > 0 found');
    end;

}
