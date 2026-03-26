codeunit 59025 "Bamburi Loan Distribution"
{
    procedure ProcessAllCheckoffLines(HeaderNo: Code[20]; LoanCutOffDate: Date)
    var
        CheckoffLine: Record "Bamburi CheckoffLines";
        TempLoansRegister: Record "Loans Register" temporary;
        TempRepaySchedule: Record "Loan Repayment Schedule" temporary;
        ProcessedCount: Integer;
        SkippedCount: Integer;
    begin
        if LoanCutOffDate = 0D then
            Error('Please specify a valid Loan CutOff Date before distributing.');

        CheckoffLine.Reset();
        CheckoffLine.SetRange("Receipt Header No", HeaderNo);
        CheckoffLine.SetRange(Posted, false);

        if not CheckoffLine.FindSet() then begin
            Message('Please import checkoff first.');
            exit;
        end;

        // ---------------------------------------------------------------
        // STEP 1: Bulk load all active loans for all members in one query
        // ---------------------------------------------------------------
        PreloadActiveLoans(CheckoffLine, LoanCutOffDate, TempLoansRegister);

        // ---------------------------------------------------------------
        // STEP 2: Bulk load all repayment schedules for those loans in one query
        // ---------------------------------------------------------------
        PreloadRepaymentSchedules(TempLoansRegister, LoanCutOffDate, TempRepaySchedule);

        // ---------------------------------------------------------------
        // STEP 3: Process each checkoff line purely from memory — no more DB hits
        // ---------------------------------------------------------------
        CheckoffLine.Reset();
        CheckoffLine.SetRange("Receipt Header No", HeaderNo);
        CheckoffLine.SetRange(Posted, false);

        if CheckoffLine.FindSet() then
            repeat
                if CheckoffLine."Total Loans" > 0 then begin
                    DistributeTotalLoans(CheckoffLine, LoanCutOffDate, TempLoansRegister, TempRepaySchedule);
                    ProcessedCount += 1;
                end else
                    SkippedCount += 1;
            until CheckoffLine.Next() = 0;

        if ProcessedCount > 0 then
            Message('Distribution complete Successfully.', ProcessedCount, SkippedCount)
        else
            Message('No members with Total Loans');
    end;

    // =====================================================================
    // PRELOAD PROCEDURES — Run once for the entire batch
    // =====================================================================

    local procedure PreloadActiveLoans(var CheckoffLine: Record "Bamburi CheckoffLines"; LoanCutOffDate: Date; var TempLoansRegister: Record "Loans Register" temporary)
    var
        LoansRegister: Record "Loans Register";
        MemberFilter: Text;
    begin
        // Build a pipe-separated member filter from all checkoff lines
        CheckoffLine.Reset();
        repeat
            if MemberFilter = '' then
                MemberFilter := CheckoffLine."Member No"
            else
                MemberFilter := MemberFilter + '|' + CheckoffLine."Member No";
        until CheckoffLine.Next() = 0;

        if MemberFilter = '' then
            exit;

        // One single query to load ALL active loans for ALL members in the batch
        LoansRegister.Reset();
        LoansRegister.SetFilter("Client Code", MemberFilter);
        LoansRegister.SetFilter("Loan Product Type", 'NORM1|NORM2|EMER|KIVUK|MWOK|SCHLOAN|MBUY');
        LoansRegister.SetRange(Posted, true);
        LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
        LoansRegister.SetFilter("Repayment Start Date", '..%1', LoanCutOffDate);
        LoansRegister.Ascending(false); // Most recent first — same as original ProcessLoan

        TempLoansRegister.Reset();
        TempLoansRegister.DeleteAll();

        if LoansRegister.FindSet() then
            repeat
                TempLoansRegister := LoansRegister;
                if TempLoansRegister.Insert() then; // Silent — skip duplicates if any
            until LoansRegister.Next() = 0;
    end;

    local procedure PreloadRepaymentSchedules(var TempLoansRegister: Record "Loans Register" temporary; LoanCutOffDate: Date; var TempRepaySchedule: Record "Loan Repayment Schedule" temporary)
    var
        LoanRepaymentSchedule: Record "Loan Repayment Schedule";
        LoanNoFilter: Text;
    begin
        // Build loan number filter from the preloaded loans temp table
        TempLoansRegister.Reset();
        if not TempLoansRegister.FindSet() then
            exit;

        repeat
            if LoanNoFilter = '' then
                LoanNoFilter := TempLoansRegister."Loan  No."
            else
                LoanNoFilter := LoanNoFilter + '|' + TempLoansRegister."Loan  No.";
        until TempLoansRegister.Next() = 0;

        if LoanNoFilter = '' then
            exit;

        // One single query to load ALL relevant unpaid schedule lines for the month
        LoanRepaymentSchedule.Reset();
        LoanRepaymentSchedule.SetFilter("Loan No.", LoanNoFilter);
        LoanRepaymentSchedule.SetRange(Paid, false);
        LoanRepaymentSchedule.SetRange("Repayment Date", CalcDate('<-CM>', LoanCutOffDate), LoanCutOffDate);
        LoanRepaymentSchedule.SetCurrentKey("Loan No.", "Member No.", "Reschedule No", "Instalment No");
        LoanRepaymentSchedule.Ascending(true);

        TempRepaySchedule.Reset();
        TempRepaySchedule.DeleteAll();

        if LoanRepaymentSchedule.FindSet() then
            repeat
                TempRepaySchedule := LoanRepaymentSchedule;
                if TempRepaySchedule.Insert() then; // Silent — skip duplicates if any
            until LoanRepaymentSchedule.Next() = 0;
    end;

    // =====================================================================
    // DISTRIBUTION — Uses temp data only, zero DB calls
    // =====================================================================

    procedure DistributeTotalLoans(var CheckoffLine: Record "Bamburi CheckoffLines"; LoanCutOffDate: Date; var TempLoansRegister: Record "Loans Register" temporary; var TempRepaySchedule: Record "Loan Repayment Schedule" temporary)
    var
        RemainingAmount: Decimal;
        InterestAmt: Decimal;
        PrincipalAmt: Decimal;
        TotalAmt: Decimal;
        OriginalDeposit: Decimal;
        ActiveLoanCount: Integer;
        LoanIndex: Integer;
    begin
        OriginalDeposit := CheckoffLine."Deposit Contribution";

        ClearAllLoanFields(CheckoffLine);
        CheckoffLine."Deposit Contribution" := OriginalDeposit;

        RemainingAmount := CheckoffLine."Total Loans";

        if RemainingAmount <= 0 then begin
            CheckoffLine."Deposit Contribution" := OriginalDeposit;
            CheckoffLine.Modify(true);
            exit;
        end;

        // Count and index from temp memory — no DB calls
        ActiveLoanCount := CountActiveLoans(CheckoffLine."Member No", TempLoansRegister);
        LoanIndex := 0;

        // 1. Normal Loan 1
        if HasActiveLoan(CheckoffLine."Member No", 'NORM1', TempLoansRegister) then
            LoanIndex += 1;
        RemainingAmount := ProcessLoan(CheckoffLine."Member No", 'NORM1', RemainingAmount, LoanCutOffDate,
            InterestAmt, PrincipalAmt, TotalAmt, LoanIndex = ActiveLoanCount,
            TempLoansRegister, TempRepaySchedule);
        if TotalAmt > 0 then begin
            CheckoffLine."Normal Loan 1 Interest" := InterestAmt;
            CheckoffLine."Normal Loan 1 Principle" := PrincipalAmt;
            CheckoffLine."Normal Loan 1 Amount" := TotalAmt;
        end;

        // 3. Emergency Loan
        if HasActiveLoan(CheckoffLine."Member No", 'EMER', TempLoansRegister) then
            LoanIndex += 1;
        RemainingAmount := ProcessLoan(CheckoffLine."Member No", 'EMER', RemainingAmount, LoanCutOffDate,
            InterestAmt, PrincipalAmt, TotalAmt, LoanIndex = ActiveLoanCount,
            TempLoansRegister, TempRepaySchedule);
        if TotalAmt > 0 then begin
            CheckoffLine."Emergency Loan Interest" := InterestAmt;
            CheckoffLine."Emergency Loan  Principle" := PrincipalAmt;
            CheckoffLine."Emergency Loan Amount" := TotalAmt;
        end;

        // 4. Kivukio Loan
        if HasActiveLoan(CheckoffLine."Member No", 'KIVUK', TempLoansRegister) then
            LoanIndex += 1;
        RemainingAmount := ProcessLoan(CheckoffLine."Member No", 'KIVUK', RemainingAmount, LoanCutOffDate,
            InterestAmt, PrincipalAmt, TotalAmt, LoanIndex = ActiveLoanCount,
            TempLoansRegister, TempRepaySchedule);
        if TotalAmt > 0 then begin
            CheckoffLine."Kivukio Loan Interest" := InterestAmt;
            CheckoffLine."Kivukio Loan Principle" := PrincipalAmt;
            CheckoffLine."Kivukio Loan Amount" := TotalAmt;
        end;

        // 5. Mwokozi Loan
        if HasActiveLoan(CheckoffLine."Member No", 'MWOK', TempLoansRegister) then
            LoanIndex += 1;
        RemainingAmount := ProcessLoan(CheckoffLine."Member No", 'MWOK', RemainingAmount, LoanCutOffDate,
            InterestAmt, PrincipalAmt, TotalAmt, LoanIndex = ActiveLoanCount,
            TempLoansRegister, TempRepaySchedule);
        if TotalAmt > 0 then begin
            CheckoffLine."Mwokozi Loan Interest" := InterestAmt;
            CheckoffLine."Mwokozi Loan Principle" := PrincipalAmt;
            CheckoffLine."Mwokozi Loan Amount" := TotalAmt;
        end;

        // 6. School Fees Loan
        if HasActiveLoan(CheckoffLine."Member No", 'SCHLOAN', TempLoansRegister) then
            LoanIndex += 1;
        RemainingAmount := ProcessLoan(CheckoffLine."Member No", 'SCHLOAN', RemainingAmount, LoanCutOffDate,
            InterestAmt, PrincipalAmt, TotalAmt, LoanIndex = ActiveLoanCount,
            TempLoansRegister, TempRepaySchedule);
        if TotalAmt > 0 then begin
            CheckoffLine."School Fees Interest" := InterestAmt;
            CheckoffLine."School Fees Principle" := PrincipalAmt;
            CheckoffLine."School Fees Amount" := TotalAmt;
        end;

        // 7. Mbuyu Loan
        if HasActiveLoan(CheckoffLine."Member No", 'MBUY', TempLoansRegister) then
            LoanIndex += 1;
        RemainingAmount := ProcessLoan(CheckoffLine."Member No", 'MBUY', RemainingAmount, LoanCutOffDate,
            InterestAmt, PrincipalAmt, TotalAmt, LoanIndex = ActiveLoanCount,
            TempLoansRegister, TempRepaySchedule);
        if TotalAmt > 0 then begin
            CheckoffLine."Mbuyu Loan Interest" := InterestAmt;
            CheckoffLine."Mbuyu Loan Principle" := PrincipalAmt;
            CheckoffLine."Mbuyu Loan Amount" := TotalAmt;
        end;

        // 2. Normal Loan 2
        if HasActiveLoan(CheckoffLine."Member No", 'NORM2', TempLoansRegister) then
            LoanIndex += 1;
        RemainingAmount := ProcessLoan(CheckoffLine."Member No", 'NORM2', RemainingAmount, LoanCutOffDate,
            InterestAmt, PrincipalAmt, TotalAmt, LoanIndex = ActiveLoanCount,
            TempLoansRegister, TempRepaySchedule);
        if TotalAmt > 0 then begin
            CheckoffLine."Normal Loan 2 Interest" := InterestAmt;
            CheckoffLine."Normal Loan 2 Principle" := PrincipalAmt;
            CheckoffLine."Normal Loan 2 Amount" := TotalAmt;
        end;

        // Any leftover goes back to deposit — same as original
        CheckoffLine."Deposit Contribution" := OriginalDeposit + RemainingAmount;
        CheckoffLine.Modify(true);
    end;

    // =====================================================================
    // HELPER PROCEDURES — All operate on temp records, zero DB calls
    // =====================================================================

    local procedure HasActiveLoan(MemberNo: Code[20]; LoanProductCode: Code[10]; var TempLoansRegister: Record "Loans Register" temporary): Boolean
    begin
        TempLoansRegister.Reset();
        TempLoansRegister.SetRange("Client Code", MemberNo);
        TempLoansRegister.SetRange("Loan Product Type", LoanProductCode);
        exit(TempLoansRegister.FindFirst());
    end;

    local procedure CountActiveLoans(MemberNo: Code[20]; var TempLoansRegister: Record "Loans Register" temporary): Integer
    var
        Count: Integer;
    begin
        Count := 0;
        if HasActiveLoan(MemberNo, 'NORM1', TempLoansRegister) then Count += 1;
        if HasActiveLoan(MemberNo, 'NORM2', TempLoansRegister) then Count += 1;
        if HasActiveLoan(MemberNo, 'EMER', TempLoansRegister) then Count += 1;
        if HasActiveLoan(MemberNo, 'KIVUK', TempLoansRegister) then Count += 1;
        if HasActiveLoan(MemberNo, 'MWOK', TempLoansRegister) then Count += 1;
        if HasActiveLoan(MemberNo, 'SCHLOAN', TempLoansRegister) then Count += 1;
        if HasActiveLoan(MemberNo, 'MBUY', TempLoansRegister) then Count += 1;
        exit(Count);
    end;

    local procedure ProcessLoan(
        MemberNo: Code[20];
        LoanProductCode: Code[10];
        AvailableAmount: Decimal;
        CutOffDate: Date;
        var InterestToPay: Decimal;
        var PrincipalToPay: Decimal;
        var TotalToPay: Decimal;
        IsLastLoan: Boolean;
        var TempLoansRegister: Record "Loans Register" temporary;
        var TempRepaySchedule: Record "Loan Repayment Schedule" temporary
    ): Decimal
    begin
        InterestToPay := 0;
        PrincipalToPay := 0;
        TotalToPay := 0;

        if AvailableAmount <= 0 then
            exit(0);

        // Look up from temp memory — same logic as original FindFirst
        TempLoansRegister.Reset();
        TempLoansRegister.SetRange("Client Code", MemberNo);
        TempLoansRegister.SetRange("Loan Product Type", LoanProductCode);
        TempLoansRegister.Ascending(false); // Most recent first — same as original

        if not TempLoansRegister.FindFirst() then
            exit(AvailableAmount); // No loan found — amount passes through to deposit

        exit(ProcessScheduledLoan(TempLoansRegister, MemberNo, AvailableAmount,
            InterestToPay, PrincipalToPay, TotalToPay, IsLastLoan, TempRepaySchedule));
    end;

    local procedure ProcessScheduledLoan(
        TempLoansRegister: Record "Loans Register" temporary;
        MemberNo: Code[20];
        AvailableAmount: Decimal;
        var InterestToPay: Decimal;
        var PrincipalToPay: Decimal;
        var TotalToPay: Decimal;
        IsLastLoan: Boolean;
        var TempRepaySchedule: Record "Loan Repayment Schedule" temporary
    ): Decimal
    var
        InstallmentInterest: Decimal;
        InstallmentPrincipal: Decimal;
        InterestPaid: Decimal;
        PrincipalPaid: Decimal;
    begin
        // Look up schedule from temp memory — already filtered to unpaid + current month
        TempRepaySchedule.Reset();
        TempRepaySchedule.SetRange("Loan No.", TempLoansRegister."Loan  No.");
        TempRepaySchedule.SetRange("Member No.", MemberNo);
        TempRepaySchedule.SetCurrentKey("Loan No.", "Member No.", "Reschedule No", "Instalment No");
        TempRepaySchedule.Ascending(true);

        if not TempRepaySchedule.FindFirst() then
            exit(AvailableAmount); // No schedule line — amount passes through

        InstallmentInterest := Round(TempRepaySchedule."Monthly Interest", 1, '>');
        InstallmentPrincipal := Round(TempRepaySchedule."Principal Repayment", 1, '>');

        InterestPaid := 0;
        PrincipalPaid := 0;

        // Step 1: Pay Interest first — same as original
        if InstallmentInterest > 0 then begin
            if AvailableAmount >= InstallmentInterest then begin
                InterestPaid := InstallmentInterest;
                AvailableAmount := AvailableAmount - InstallmentInterest;
            end else begin
                InterestPaid := AvailableAmount;
                AvailableAmount := 0;
            end;
        end;

        // Step 2: Pay Principal — same as original
        if AvailableAmount > 0 then begin
            if IsLastLoan then begin
                // Last loan gets ALL remaining — same as original
                PrincipalPaid := AvailableAmount;
                AvailableAmount := 0;
            end else begin
                if InstallmentPrincipal > 0 then begin
                    if AvailableAmount >= InstallmentPrincipal then begin
                        PrincipalPaid := InstallmentPrincipal;
                        AvailableAmount := AvailableAmount - InstallmentPrincipal;
                    end else begin
                        PrincipalPaid := AvailableAmount;
                        AvailableAmount := 0;
                    end;
                end;
            end;
        end;

        InterestToPay := InterestPaid;
        PrincipalToPay := PrincipalPaid;
        TotalToPay := InterestToPay + PrincipalToPay;

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
    end;
}
