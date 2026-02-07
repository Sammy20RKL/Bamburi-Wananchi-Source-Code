
codeunit 50005 "Guarantor Management"
{
    trigger OnRun()
    begin
        // UpdateCommittedSharesForLoan('BLN_0004417');
        // fnGetMemberGuarantorshipLiability('2074');
        UpdateLoanGuarantorsCommitment();
    end;

    var
        ObjMembers: Record Customer;
        ObjLoans: Record "Loans Register";
        ObjLoanSecurities: Record "Loan Collateral Details";
        ObjLoanGuarantors: Record "Loans Guarantee Details";
        DialogBox: Dialog;

    procedure UpdateLoanGuarantorsCommitment()
    var
        ObjLoanGuarantors: Record "Loans Guarantee Details";
        LoanNo: Code[30];
        ProcessedLoans: Dictionary of [Code[30], Boolean];
    begin
        ProcessedLoans.Add('LoanNo', true);//ProcessedLoans := Dictionary of [Code[30], Boolean].Create();

        ObjLoanGuarantors.Reset();
        ObjLoanGuarantors.SetRange(Substituted, false); // Optional: skip substituted lines
        if ObjLoanGuarantors.FindSet() then begin
            repeat
                LoanNo := ObjLoanGuarantors."Loan No";

                DialogBox.Open('Updating committed shares for Loan : ' + Format(LoanNo) + ' Please wait');

                // Avoid recalculating the same LoanNo multiple times
                if not ProcessedLoans.ContainsKey(LoanNo) then begin
                    UpdateCommittedSharesForLoan(LoanNo);
                    ProcessedLoans.Add(LoanNo, true);
                end;
            until ObjLoanGuarantors.Next() = 0;
        end;
        DialogBox.Close();
    end;


    procedure fnGetMemberGuarantorshipLiability(MemberNo: Code[30]) guarantorshipAmount: Decimal
    var
        commitedShares: Decimal;
        totalCommitedShares: Decimal;
        maxFigure: Decimal;
    begin
        totalCommitedShares := 0;
        guarantorshipAmount := 0;

        //Calculate member maximum = Shares times 2
        ObjMembers.Reset;
        ObjMembers.SetRange(ObjMembers."No.", MemberNo);
        if ObjMembers.FindSet() then begin
            ObjMembers.CalcFields("Current Shares", "Shares Retained");
            maxFigure := ROUND((ObjMembers."Current Shares" * 2), 1, '=');
        end;

        //get their total committed shares....
        totalCommitedShares := ROUND(getAmountGuaranteed(MemberNo), 1, '=');
        //calculate their remaining ability
        guarantorshipAmount := maxFigure - totalCommitedShares;

        //not less than zero
        if guarantorshipAmount < 0 then guarantorshipAmount := 0;

        exit(guarantorshipAmount);
    end;

    procedure fnGetMemberGuarantorshipLiabilityperLoan(MemberNo: Code[30]; loanNumber: Code[30]) guarantorshipAmount: Decimal
    var
        commitedShares: Decimal;
        totalCommitedShares: Decimal;
        maxFigure: Decimal;
    begin
        totalCommitedShares := 0;
        guarantorshipAmount := 0;

        //Calculate member maximum = Shares times 2
        ObjMembers.Reset;
        ObjMembers.SetRange(ObjMembers."No.", MemberNo);
        if ObjMembers.FindSet() then begin
            ObjMembers.CalcFields("Current Shares", "Shares Retained");
            maxFigure := ROUND((ObjMembers."Current Shares" * 2), 1, '=');
        end;

        //get their total committed shares....
        totalCommitedShares := ROUND(getAmountGuaranteedPerLoan(MemberNo, loanNumber), 1, '=');
        //calculate their remaining ability
        guarantorshipAmount := maxFigure - totalCommitedShares;

        //not less than zero
        if guarantorshipAmount < 0 then guarantorshipAmount := 0;

        exit(guarantorshipAmount);
    end;

    procedure fnGetMemberSelfGuarantorshipLiability(MemberNo: Code[30]) guarantorshipAmount: Decimal
    var
        commitedShares: Decimal;
        totalCommitedShares: Decimal;
        maxFigure: Decimal;
    begin
        totalCommitedShares := 0;
        guarantorshipAmount := 0;

        // Calculate member maximum: based on Current Shares
        ObjMembers.Reset();
        ObjMembers.SetRange("No.", MemberNo);
        if ObjMembers.FindFirst() then begin
            ObjMembers.CalcFields("Current Shares", "Shares Retained");

            if (ObjMembers."Personal No" = '') or format(ObjMembers."Personal No").Contains('PM') then
                // 80% of shares for Private Members (no Personal No)
                MaxFigure := Round(ObjMembers."Current Shares" * 0.80, 1, '=')
            else
                // Otherwise: 25% of (Shares * 2)
                MaxFigure := Round(ObjMembers."Current Shares" * 2 * 0.25, 1, '=');

        end;

        //get their total committed shares....
        totalCommitedShares := ROUND(getAmountSelfGuaranteed(MemberNo), 1, '=');
        //calculate their remaining ability
        guarantorshipAmount := maxFigure - totalCommitedShares;

        //not less than zero
        if guarantorshipAmount < 0 then guarantorshipAmount := 0;

        exit(guarantorshipAmount);
    end;

    local procedure getAmountGuaranteed(memberNumber: Code[30]) amountInuse: Decimal
    begin
        amountInuse := 0;
        ObjLoanGuarantors.Reset;
        ObjLoanGuarantors.SetRange(ObjLoanGuarantors."Member No", memberNumber);
        ObjLoanGuarantors.SetRange(Substituted, false);
        if ObjLoanGuarantors.FindSet then begin
            repeat
                // UpdateCommittedSharesForLoan(ObjLoanGuarantors."Loan No");
                ObjLoanGuarantors.CalcFields(ObjLoanGuarantors."Outstanding Balance");
                if ObjLoanGuarantors."Outstanding Balance" > 0 then begin
                    amountInuse := amountInuse + ObjLoanGuarantors."Committed Shares";

                end;
            until ObjLoanGuarantors.Next = 0;
        end;
    end;

    local procedure getAmountGuaranteedPerLoan(memberNumber: Code[30]; loanNumber: Code[30]) amountInuse: Decimal
    begin
        amountInuse := 0;
        ObjLoanGuarantors.Reset;
        ObjLoanGuarantors.SetRange(ObjLoanGuarantors."Member No", memberNumber);
        ObjLoanGuarantors.SetRange(ObjLoanGuarantors."Loan No", loanNumber);
        ObjLoanGuarantors.SetRange(Substituted, false);
        if ObjLoanGuarantors.FindSet then begin
            repeat
                // UpdateCommittedSharesForLoan(ObjLoanGuarantors."Loan No");
                ObjLoanGuarantors.CalcFields(ObjLoanGuarantors."Outstanding Balance");
                if ObjLoanGuarantors."Outstanding Balance" > 0 then begin
                    amountInuse := amountInuse + ObjLoanGuarantors."Committed Shares";

                end;
            until ObjLoanGuarantors.Next = 0;
        end;
    end;

    local procedure getAmountSelfGuaranteed(memberNumber: Code[30]) amountInuse: Decimal
    begin
        amountInuse := 0;
        ObjLoanGuarantors.Reset;
        ObjLoanGuarantors.SetRange(ObjLoanGuarantors."Member No", memberNumber);
        ObjLoanGuarantors.SetRange(ObjLoanGuarantors."Self Guarantee", true);
        ObjLoanGuarantors.SetRange(Substituted, false);
        if ObjLoanGuarantors.FindSet then begin
            repeat
                // UpdateCommittedSharesForLoan(ObjLoanGuarantors."Loan No");
                ObjLoanGuarantors.CalcFields(ObjLoanGuarantors."Outstanding Balance");
                if ObjLoanGuarantors."Outstanding Balance" > 0 then begin
                    amountInuse := amountInuse + ObjLoanGuarantors."Committed Shares";

                end;
            until ObjLoanGuarantors.Next = 0;
        end;
    end;

    procedure UpdateCommittedSharesForLoan(LoanNo: Code[30])
    var
        Guarantor: Record "Loans Guarantee Details";
        collaterals: Record "Loan Collateral Details";
        TotalAmountGuaranteed: Decimal;
        TotalOutstanding: Decimal;
        calcValue: Decimal;
        collateralValue: Decimal;
    begin
        calcValue := 0;
        collateralValue := 0;
        // Step 1: Calculate total Amount Guaranteed and Outstanding Balance for this loan
        Guarantor.Reset();
        Guarantor.SetRange("Loan No", LoanNo);
        Guarantor.SetRange(Substituted, false); // exclude substituted guarantors
        if Guarantor.FindSet() then begin
            TotalAmountGuaranteed := 0;
            TotalOutstanding := 0;
            Guarantor.CalcFields("Outstanding Balance");
            TotalOutstanding := Guarantor."Outstanding Balance"; // all share same loan
            repeat
                TotalAmountGuaranteed += Guarantor."Amont Guaranteed";
            until Guarantor.Next() = 0;
        end;

        //get the collateral values
        collaterals.Reset();
        collaterals.SetRange("Loan No", LoanNo);
        // collaterals.SetRange();
        if collaterals.FindSet() then begin
            repeat
                collateralValue += collaterals."Guarantee Value";
            until collaterals.Next() = 0;
        end;
        //Add collateral value to the total Amount
        TotalAmountGuaranteed := TotalAmountGuaranteed + collateralValue;

        if TotalAmountGuaranteed < 1 then begin
            Guarantor."Committed Shares" := 0;
            Guarantor.Modify();
            exit;
        end;

        // Step 2: Recalculate and update each guarantor's committed shares
        Guarantor.Reset();
        Guarantor.SetRange("Loan No", LoanNo);
        Guarantor.SetRange(Substituted, false);
        if Guarantor.FindSet() then begin
            repeat
                // TotalOutstanding := Guarantor."Outstanding Balance";
                calcValue :=
                    ROUND(
                        (Guarantor."Amont Guaranteed" / TotalAmountGuaranteed) * TotalOutstanding,
                        1, '='
                    );
                if calcValue < 0 then calcValue := 0;
                Guarantor."Committed Shares" := calcValue;

                Guarantor.Modify();
            until Guarantor.Next() = 0;
        end;
    end;

}
