Page 50046 "Loan Recovery Lines"
{
    ApplicationArea = All;
    Caption = 'Loan Recovery Lines';
    PageType = List;
    SourceTable = "Loan Recovery List";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Source; Rec.Source)
                {
                }
                field("Member No"; Rec."Member No")
                {
                }
                field("Member Name"; Rec."Member Name")
                {
                    Editable = false;
                }
                field("Loan No."; Rec."Loan No.")
                {
                }
                field("Loan Type"; Rec."Loan Type")
                {
                    Editable = false;
                }
                field("Total Amount To Recover"; Rec."Total Amount To Recover")
                {
                    Style = Strong;
                    trigger OnValidate()
                    begin
                        ABC := 0;
                        ABC := Rec."Total Amount To Recover";
                        if Rec."Total Amount To Recover" < 0 then begin
                            error('Amount recovered cannot be less than zero')
                        end else
                            if Rec."Total Amount To Recover" = 0 then begin
                                Rec."Principal Amount To Recover" := 0;
                                Rec."Interest Amount To Recover" := 0;
                            end else
                                if Rec."Total Amount To Recover" > 0 then begin
                                    loansreg.Reset();
                                    loansreg.SetRange(loansreg."Loan  No.", Rec."Loan No.");
                                    loansreg.SetAutoCalcFields(loansreg."Outstanding Balance", loansreg."Oustanding Interest");
                                    if loansreg.Find('-') then begin
                                        if (loansreg."Loan Product Type" <> 'OVERDRAFT') OR (loansreg."Loan Product Type" <> 'OKOA') then begin
                                            if loansreg."Oustanding Interest" > 0 then begin
                                                if ABC > loansreg."Oustanding Interest" then begin
                                                    Rec."Interest Amount To Recover" := loansreg."Oustanding Interest";
                                                end else
                                                    if ABC <= loansreg."Oustanding Interest" then begin
                                                        Rec."Interest Amount To Recover" := ABC;
                                                    end;
                                            end;
                                            ABC := ABC - Rec."Interest Amount To Recover";
                                            if ABC > 0 then begin
                                                IF loansreg."Outstanding Balance" > 0 THEN begin
                                                    if ABC > loansreg."Outstanding Balance" then begin
                                                        Rec."Principal Amount To Recover" := loansreg."Outstanding Balance";
                                                    end else
                                                        if ABC <= loansreg."Outstanding Balance" then begin
                                                            Rec."Principal Amount To Recover" := ABC;
                                                        end;
                                                end;
                                            end;
                                            ABC := ABC - Rec."Principal Amount To Recover";
                                            If ABC > 0 then begin
                                                Error('Your recovery amount of Ksh. ' + Format(Rec."Total Amount To Recover") + 'is greater than the total loan balance of Ksh. ' + Format(Rec."Outstanding Balance" + Rec."Outstanding Interest"));
                                            end;
                                        end else
                                            if (loansreg."Loan Product Type" = 'OVERDRAFT') OR (loansreg."Loan Product Type" = 'OKOA') then begin
                                                FnRecoverOVOKOALoans();
                                            end;

                                    end;
                                end;
                    end;
                }
                field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                    Editable = false;
                }
                field("Outstanding Interest"; Rec."Outstanding Interest")
                {
                    Editable = false;
                }
                field("Amount In Arrears"; Rec."Amount In Arrears")
                {
                    Editable = false;
                }

                field("Principal To Recover"; Rec."Principal Amount To Recover")
                {
                    Style = StandardAccent;
                }
                field("Interest To Recover"; Rec."Interest Amount To Recover")
                {
                    Style = StandardAccent;
                }

                field("Approved Loan Amount"; Rec."Approved Loan Amount")
                {
                    Editable = false;
                }
                field("Loan Instalments"; Rec."Loan Instalments")
                {
                    Editable = false;
                }
                field("Interest Rate"; Rec."Interest Rate")
                {
                    Editable = false;
                }

            }
        }
    }
    var
        loansreg: Record "Loans Register";
        ABC: Decimal;

    local procedure FnRecoverOVOKOALoans()
    var
        DueInterestIs: Decimal;
    begin
        //If loan is due then recover outstanding Interest(Only Outstanding)
        ABC := 0;
        ABC := Rec."Total Amount To Recover";
        if Rec."Outstanding Interest" > 0 then begin
            If FnLoanInterestIsDue() then begin
                DueInterestIs := 0;
                DueInterestIs := FnGetDueInterest();
                if ABC > DueInterestIs then begin
                    Rec."Interest Amount To Recover" := DueInterestIs;
                end else
                    if ABC <= DueInterestIs then begin
                        Rec."Interest Amount To Recover" := ABC;
                    end;
            end else
                If not FnLoanInterestIsDue() then begin
                    if ABC > FnGetMonthlyInterest() then begin
                        Rec."Interest Amount To Recover" := FnGetMonthlyInterest();
                    end else
                        if ABC <= FnGetMonthlyInterest() then begin
                            Rec."Interest Amount To Recover" := ABC;
                        end;
                end;
            ABC := ABC - Rec."Interest Amount To Recover";
        end;
        if Rec."Outstanding Balance" > 0 then begin
            if ABC > 0 then begin
                if ABC > Rec."Outstanding Balance" then begin
                    Rec."Principal Amount To Recover" := Rec."Outstanding Balance";
                end else
                    if ABC <= Rec."Outstanding Balance" then begin
                        Rec."Principal Amount To Recover" := ABC;
                    end;
            end;
        end;


        //If Not Due make sure than Interest is also accomodated

        //"Interest Amount To Recover" := Fn

    end;

    local procedure FnLoanInterestIsDue(): Boolean
    var
        LoanRepaymentSchedule: Record "Loan Repayment Schedule";
    begin
        LoanRepaymentSchedule.Reset();
        LoanRepaymentSchedule.SetRange(LoanRepaymentSchedule."Loan No.", Rec."Loan No.");
        LoanRepaymentSchedule.SetFilter(LoanRepaymentSchedule."Repayment Date", '%1..%2', 0D, Today);
        if LoanRepaymentSchedule.Find('-') = true then begin
            exit(true);
        end;
        exit(false);
    end;

    local procedure FnGetDueInterest(): Decimal
    var
        LoanRepaymentSchedule: Record "Loan Repayment Schedule";
        DueAmounts: Decimal;
    begin
        DueAmounts := 0;
        LoanRepaymentSchedule.Reset();
        LoanRepaymentSchedule.SetRange(LoanRepaymentSchedule."Loan No.", Rec."Loan No.");
        LoanRepaymentSchedule.SetFilter(LoanRepaymentSchedule."Repayment Date", '%1..%2', 0D, Today);
        if LoanRepaymentSchedule.Find('-') = true then begin
            repeat
                DueAmounts += LoanRepaymentSchedule."Monthly Interest";
            until LoanRepaymentSchedule.Next = 0;
            exit(DueAmounts);
        end;
        exit(DueAmounts);
    end;

    local procedure FnGetMonthlyInterest(): Decimal
    var
        LoanRepaymentSchedule: Record "Loan Repayment Schedule";
    begin
        LoanRepaymentSchedule.Reset();
        LoanRepaymentSchedule.SetRange(LoanRepaymentSchedule."Loan No.", Rec."Loan No.");
        if LoanRepaymentSchedule.Find('-') = true then begin
            exit(LoanRepaymentSchedule."Monthly Interest");
        end;
    end;
}
