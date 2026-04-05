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

        PreloadActiveLoans(CheckoffLine, LoanCutOffDate, TempLoansRegister);
        PreloadRepaymentSchedules(TempLoansRegister, LoanCutOffDate, TempRepaySchedule);

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

    local procedure PreloadActiveLoans(var CheckoffLine: Record "Bamburi CheckoffLines"; LoanCutOffDate: Date; var TempLoansRegister: Record "Loans Register" temporary)
    var
        LoansRegister: Record "Loans Register";
        MemberFilter: Text;
    begin
        CheckoffLine.Reset();
        repeat
            if MemberFilter = '' then
                MemberFilter := CheckoffLine."Member No"
            else
                MemberFilter := MemberFilter + '|' + CheckoffLine."Member No";
        until CheckoffLine.Next() = 0;

        if MemberFilter = '' then
            exit;

        LoansRegister.Reset();
        LoansRegister.SetFilter("Client Code", MemberFilter);
        LoansRegister.SetFilter("Loan Product Type", 'NORM1|NORM2|EMER|KIVUK|MWOK|SCHLOAN|MBUY');
        LoansRegister.SetRange(Posted, true);
        LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
        // LoansRegister.SetFilter("Repayment Start Date", '..%1', LoanCutOffDate);
        LoansRegister.Ascending(false);

        TempLoansRegister.Reset();
        TempLoansRegister.DeleteAll();

        if LoansRegister.FindSet() then
            repeat
                TempLoansRegister := LoansRegister;
                if TempLoansRegister.Insert() then;
            until LoansRegister.Next() = 0;
    end;

    // RESTORED — original date filter, current month only
    local procedure PreloadRepaymentSchedules(var TempLoansRegister: Record "Loans Register" temporary; LoanCutOffDate: Date; var TempRepaySchedule: Record "Loan Repayment Schedule" temporary)
    var
        LoanRepaymentSchedule: Record "Loan Repayment Schedule";
        LoanNoFilter: Text;
    begin
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

        LoanRepaymentSchedule.Reset();
        LoanRepaymentSchedule.SetFilter("Loan No.", LoanNoFilter);
        LoanRepaymentSchedule.SetRange(Paid, false);
        // RESTORED — original current month filter
        //LoanRepaymentSchedule.SetRange("Repayment Date", CalcDate('<-CM>', LoanCutOffDate), LoanCutOffDate);
        LoanRepaymentSchedule.SetCurrentKey("Loan No.", "Member No.", "Reschedule No", "Instalment No");
        LoanRepaymentSchedule.Ascending(true);

        TempRepaySchedule.Reset();
        TempRepaySchedule.DeleteAll();

        if LoanRepaymentSchedule.FindSet() then
            repeat
                TempRepaySchedule := LoanRepaymentSchedule;
                if TempRepaySchedule.Insert() then;
            until LoanRepaymentSchedule.Next() = 0;
    end;

    procedure DistributeTotalLoans(var CheckoffLine: Record "Bamburi CheckoffLines"; LoanCutOffDate: Date; var TempLoansRegister: Record "Loans Register" temporary; var TempRepaySchedule: Record "Loan Repayment Schedule" temporary)
    var
        RemainingAmount: Decimal;
        InterestAmt: Decimal;
        PrincipalAmt: Decimal;
        TotalAmt: Decimal;
        OriginalDeposit: Decimal;
    // ActiveLoanCount: Integer;
    //LoanIndex: Integer;
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

        // ActiveLoanCount := CountActiveLoans(CheckoffLine."Member No", TempLoansRegister);
        // LoanIndex := 0;//LoanIndex = ActiveLoanCount

        // 1. Normal Loan 1
        // if HasActiveLoan(CheckoffLine."Member No", 'NORM1', TempLoansRegister) then
        //     LoanIndex += 1;
        RemainingAmount := ProcessLoan(CheckoffLine."Member No", 'NORM1', RemainingAmount, LoanCutOffDate, InterestAmt, PrincipalAmt, TotalAmt, false, TempLoansRegister, TempRepaySchedule);
        if TotalAmt > 0 then begin
            CheckoffLine."Normal Loan 1 Interest" := InterestAmt;
            CheckoffLine."Normal Loan 1 Principle" := PrincipalAmt;
            CheckoffLine."Normal Loan 1 Amount" := TotalAmt;
        end;

        // 2. Emergency Loan
        // if HasActiveLoan(CheckoffLine."Member No", 'EMER', TempLoansRegister) then
        //     LoanIndex += 1;
        RemainingAmount := ProcessLoan(CheckoffLine."Member No", 'EMER', RemainingAmount, LoanCutOffDate,
            InterestAmt, PrincipalAmt, TotalAmt, false,
            TempLoansRegister, TempRepaySchedule);
        if TotalAmt > 0 then begin
            CheckoffLine."Emergency Loan Interest" := InterestAmt;
            CheckoffLine."Emergency Loan  Principle" := PrincipalAmt;
            CheckoffLine."Emergency Loan Amount" := TotalAmt;
        end;

        // 3. Kivukio Loan
        // if HasActiveLoan(CheckoffLine."Member No", 'KIVUK', TempLoansRegister) then
        // LoanIndex += 1;
        RemainingAmount := ProcessLoan(CheckoffLine."Member No", 'KIVUK', RemainingAmount, LoanCutOffDate,
            InterestAmt, PrincipalAmt, TotalAmt, false,
            TempLoansRegister, TempRepaySchedule);
        if TotalAmt > 0 then begin
            CheckoffLine."Kivukio Loan Interest" := InterestAmt;
            CheckoffLine."Kivukio Loan Principle" := PrincipalAmt;
            CheckoffLine."Kivukio Loan Amount" := TotalAmt;
        end;

        // 4. Mwokozi Loan
        // if HasActiveLoan(CheckoffLine."Member No", 'MWOK', TempLoansRegister) then
        //     LoanIndex += 1;
        RemainingAmount := ProcessLoan(CheckoffLine."Member No", 'MWOK', RemainingAmount, LoanCutOffDate,
            InterestAmt, PrincipalAmt, TotalAmt, false,
            TempLoansRegister, TempRepaySchedule);
        if TotalAmt > 0 then begin
            CheckoffLine."Mwokozi Loan Interest" := InterestAmt;
            CheckoffLine."Mwokozi Loan Principle" := PrincipalAmt;
            CheckoffLine."Mwokozi Loan Amount" := TotalAmt;
        end;

        // 5. School Fees Loan
        // if HasActiveLoan(CheckoffLine."Member No", 'SCHLOAN', TempLoansRegister) then
        //     LoanIndex += 1;
        RemainingAmount := ProcessLoan(CheckoffLine."Member No", 'SCHLOAN', RemainingAmount, LoanCutOffDate,
            InterestAmt, PrincipalAmt, TotalAmt, false,
            TempLoansRegister, TempRepaySchedule);
        if TotalAmt > 0 then begin
            CheckoffLine."School Fees Interest" := InterestAmt;
            CheckoffLine."School Fees Principle" := PrincipalAmt;
            CheckoffLine."School Fees Amount" := TotalAmt;
        end;

        // 6. Mbuyu Loan
        // if HasActiveLoan(CheckoffLine."Member No", 'MBUY', TempLoansRegister) then
        //     LoanIndex += 1;
        RemainingAmount := ProcessLoan(CheckoffLine."Member No", 'MBUY', RemainingAmount, LoanCutOffDate,
            InterestAmt, PrincipalAmt, TotalAmt, false,
            TempLoansRegister, TempRepaySchedule);
        if TotalAmt > 0 then begin
            CheckoffLine."Mbuyu Loan Interest" := InterestAmt;
            CheckoffLine."Mbuyu Loan Principle" := PrincipalAmt;
            CheckoffLine."Mbuyu Loan Amount" := TotalAmt;
        end;

        // 7. Normal Loan 2
        // if HasActiveLoan(CheckoffLine."Member No", 'NORM2', TempLoansRegister) then
        //     LoanIndex += 1;
        RemainingAmount := ProcessLoan(CheckoffLine."Member No", 'NORM2', RemainingAmount, LoanCutOffDate,
            InterestAmt, PrincipalAmt, TotalAmt, false,
            TempLoansRegister, TempRepaySchedule);
        if TotalAmt > 0 then begin
            CheckoffLine."Normal Loan 2 Interest" := InterestAmt;
            CheckoffLine."Normal Loan 2 Principle" := PrincipalAmt;
            CheckoffLine."Normal Loan 2 Amount" := TotalAmt;
        end;

        // DUMP remaining to the true last active loan before sweeping
        if RemainingAmount > 0 then begin
            if HasActiveLoan(CheckoffLine."Member No", 'NORM2', TempLoansRegister) then begin
                CheckoffLine."Normal Loan 2 Principle" += RemainingAmount;
                CheckoffLine."Normal Loan 2 Amount" += RemainingAmount;
                RemainingAmount := 0;
            end else if HasActiveLoan(CheckoffLine."Member No", 'MBUY', TempLoansRegister) then begin
                CheckoffLine."Mbuyu Loan Principle" += RemainingAmount;
                CheckoffLine."Mbuyu Loan Amount" += RemainingAmount;
                RemainingAmount := 0;
            end else if HasActiveLoan(CheckoffLine."Member No", 'SCHLOAN', TempLoansRegister) then begin
                CheckoffLine."School Fees Principle" += RemainingAmount;
                CheckoffLine."School Fees Amount" += RemainingAmount;
                RemainingAmount := 0;
            end else if HasActiveLoan(CheckoffLine."Member No", 'MWOK', TempLoansRegister) then begin
                CheckoffLine."Mwokozi Loan Principle" += RemainingAmount;
                CheckoffLine."Mwokozi Loan Amount" += RemainingAmount;
                RemainingAmount := 0;
            end else if HasActiveLoan(CheckoffLine."Member No", 'KIVUK', TempLoansRegister) then begin
                CheckoffLine."Kivukio Loan Principle" += RemainingAmount;
                CheckoffLine."Kivukio Loan Amount" += RemainingAmount;
                RemainingAmount := 0;
            end else if HasActiveLoan(CheckoffLine."Member No", 'EMER', TempLoansRegister) then begin
                CheckoffLine."Emergency Loan  Principle" += RemainingAmount;
                CheckoffLine."Emergency Loan Amount" += RemainingAmount;
                RemainingAmount := 0;
            end else if HasActiveLoan(CheckoffLine."Member No", 'NORM1', TempLoansRegister) then begin
                CheckoffLine."Normal Loan 1 Principle" += RemainingAmount;
                CheckoffLine."Normal Loan 1 Amount" += RemainingAmount;
                RemainingAmount := 0;
            end;
        end;

        // NEW — check other loans before deposit
        if RemainingAmount > 0 then
            RemainingAmount := ClearRemainingLoanBalances(
                CheckoffLine."Member No", RemainingAmount, TempLoansRegister, CheckoffLine);

        CheckoffLine."Deposit Contribution" := OriginalDeposit + RemainingAmount;
        CheckoffLine.Modify(true);
    end;

    local procedure HasActiveLoan(MemberNo: Code[20]; LoanProductCode: Code[10]; var TempLoansRegister: Record "Loans Register" temporary): Boolean
    begin
        TempLoansRegister.Reset();
        TempLoansRegister.SetRange("Client Code", MemberNo);
        TempLoansRegister.SetRange("Loan Product Type", LoanProductCode);
        exit(TempLoansRegister.FindFirst());
    end;


    local procedure ProcessLoan(MemberNo: Code[20]; LoanProductCode: Code[10]; AvailableAmount: Decimal; CutOffDate: Date; var InterestToPay: Decimal; var PrincipalToPay: Decimal; var TotalToPay: Decimal; IsLastLoan: Boolean;
        var TempLoansRegister: Record "Loans Register" temporary;
        var TempRepaySchedule: Record "Loan Repayment Schedule" temporary
    ): Decimal
    begin
        InterestToPay := 0;
        PrincipalToPay := 0;
        TotalToPay := 0;

        if AvailableAmount <= 0 then
            exit(0);

        TempLoansRegister.Reset();
        TempLoansRegister.SetRange("Client Code", MemberNo);
        TempLoansRegister.SetRange("Loan Product Type", LoanProductCode);
        TempLoansRegister.Ascending(false);

        if not TempLoansRegister.FindFirst() then
            exit(AvailableAmount);

        exit(ProcessScheduledLoan(TempLoansRegister, MemberNo, AvailableAmount,
            InterestToPay, PrincipalToPay, TotalToPay, IsLastLoan, TempRepaySchedule));
    end;

    // RESTORED — exactly as original, no overpayment changes
    local procedure ProcessScheduledLoan(TempLoansRegister: Record "Loans Register" temporary; MemberNo: Code[20]; AvailableAmount: Decimal; var InterestToPay: Decimal; var PrincipalToPay: Decimal; var TotalToPay: Decimal; IsLastLoan: Boolean; var TempRepaySchedule: Record "Loan Repayment Schedule" temporary): Decimal
    var
        InstallmentInterest: Decimal;
        InstallmentPrincipal: Decimal;
        InterestPaid: Decimal;
        UsedCheckoff: Boolean;
        PrincipalPaid: Decimal;
        loansRegisterTable: Record "Loans Register";
        custLedgerEntry: Record "Cust. Ledger Entry";
    begin
        TempRepaySchedule.Reset();
        TempRepaySchedule.SetRange("Loan No.", TempLoansRegister."Loan  No.");
        TempRepaySchedule.SetRange("Member No.", MemberNo);
        TempRepaySchedule.SetCurrentKey("Loan No.", "Member No.", "Reschedule No", "Instalment No");
        TempRepaySchedule.Ascending(true);

        if not TempRepaySchedule.FindFirst() then
            exit(AvailableAmount);

        InstallmentInterest := Round(TempRepaySchedule."Monthly Interest", 1, '>');
        InstallmentPrincipal := Round(TempRepaySchedule."Principal Repayment", 1, '>');

        InterestPaid := 0;
        PrincipalPaid := 0;
        UsedCheckoff := false;

        // CHECK OLD LOANS FIRST
        loansRegisterTable.Reset();
        loansRegisterTable.SetRange("Client Code", MemberNo);
        loansRegisterTable.SetRange("Loan  No.", TempLoansRegister."Loan  No.");
        if loansRegisterTable.FindFirst() then
            if loansRegisterTable."Loan Disbursement Date" < 20251201D then begin

                // GET INTEREST FROM PREVIOUS CHECKOFF
                custLedgerEntry.Reset();
                custLedgerEntry.SetRange("Customer No.", MemberNo);
                custLedgerEntry.SetRange("Transaction Type", custLedgerEntry."Transaction Type"::"Interest Paid");
                custLedgerEntry.SetRange("Document No.", 'BWS CHECKOFF DEC2025');
                custLedgerEntry.SetRange("Loan No", TempLoansRegister."Loan  No.");
                if custLedgerEntry.FindLast() then begin
                    InterestPaid := custLedgerEntry."Amount Posted" * -1;
                    if AvailableAmount >= InterestPaid then
                        AvailableAmount := AvailableAmount - InterestPaid
                    else begin
                        InterestPaid := AvailableAmount;
                        AvailableAmount := 0;
                    end;
                    UsedCheckoff := true;
                end;

                // GET PRINCIPAL FROM PREVIOUS CHECKOFF
                if UsedCheckoff then begin
                    custLedgerEntry.Reset();
                    custLedgerEntry.SetRange("Customer No.", MemberNo);
                    custLedgerEntry.SetRange("Transaction Type", custLedgerEntry."Transaction Type"::"Loan Repayment");
                    custLedgerEntry.SetRange("Document No.", 'BWS CHECKOFF DEC2025');
                    custLedgerEntry.SetRange("Loan No", TempLoansRegister."Loan  No.");
                    if custLedgerEntry.FindLast() then begin
                        PrincipalPaid := custLedgerEntry."Amount Posted" * -1;
                        if AvailableAmount >= PrincipalPaid then
                            AvailableAmount := AvailableAmount - PrincipalPaid
                        else begin
                            PrincipalPaid := AvailableAmount;
                            AvailableAmount := 0;
                        end;
                    end;
                    // if UsedCheckoff and IsLastLoan and (AvailableAmount > 0) then begin
                    //     PrincipalPaid += AvailableAmount;
                    //     AvailableAmount := 0;
                    // end;
                end;
            end;

        // FALL BACK TO SCHEDULE IF NO CHECKOFF FOUND
        if not UsedCheckoff then begin
            if InstallmentInterest > 0 then begin
                if AvailableAmount >= InstallmentInterest then begin
                    InterestPaid := InstallmentInterest;
                    AvailableAmount := AvailableAmount - InstallmentInterest;
                end else begin
                    InterestPaid := AvailableAmount;
                    AvailableAmount := 0;
                end;
            end;
        end;


        if not UsedCheckoff then begin
            if AvailableAmount > 0 then begin
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

    // NEW — only addition, sweeps remaining to other loans before deposit
    local procedure ClearRemainingLoanBalances(MemberNo: Code[20]; RemainingAmount: Decimal; var TempLoansRegister: Record "Loans Register" temporary; var CheckoffLine: Record "Bamburi CheckoffLines"): Decimal
    var
        SweptAmount: Decimal;
    begin
        TempLoansRegister.Reset();
        TempLoansRegister.SetRange("Client Code", MemberNo);
        TempLoansRegister.SetFilter("Outstanding Balance", '>%1', 0);

        if TempLoansRegister.FindSet() then
            repeat
                if RemainingAmount <= 0 then
                    exit(0);

                if RemainingAmount >= TempLoansRegister."Outstanding Balance" then
                    SweptAmount := TempLoansRegister."Outstanding Balance"
                else
                    SweptAmount := RemainingAmount;

                RemainingAmount -= SweptAmount;

                case TempLoansRegister."Loan Product Type" of
                    'NORM1':
                        begin
                            CheckoffLine."Normal Loan 1 Principle" += SweptAmount;
                            CheckoffLine."Normal Loan 1 Amount" += SweptAmount;
                        end;
                    'NORM2':
                        begin
                            CheckoffLine."Normal Loan 2 Principle" += SweptAmount;
                            CheckoffLine."Normal Loan 2 Amount" += SweptAmount;
                        end;
                    'EMER':
                        begin
                            CheckoffLine."Emergency Loan  Principle" += SweptAmount;
                            CheckoffLine."Emergency Loan Amount" += SweptAmount;
                        end;
                    'KIVUK':
                        begin
                            CheckoffLine."Kivukio Loan Principle" += SweptAmount;
                            CheckoffLine."Kivukio Loan Amount" += SweptAmount;
                        end;
                    'MWOK':
                        begin
                            CheckoffLine."Mwokozi Loan Principle" += SweptAmount;
                            CheckoffLine."Mwokozi Loan Amount" += SweptAmount;
                        end;
                    'SCHLOAN':
                        begin
                            CheckoffLine."School Fees Principle" += SweptAmount;
                            CheckoffLine."School Fees Amount" += SweptAmount;
                        end;
                    'MBUY':
                        begin
                            CheckoffLine."Mbuyu Loan Principle" += SweptAmount;
                            CheckoffLine."Mbuyu Loan Amount" += SweptAmount;
                        end;
                end;
            until TempLoansRegister.Next() = 0;

        exit(RemainingAmount);
    end;
}