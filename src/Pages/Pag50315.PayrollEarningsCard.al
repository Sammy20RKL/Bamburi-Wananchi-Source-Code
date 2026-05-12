#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50315 "Payroll Earnings Card."
{
    PageType = Card;
    SourceTable = "Payroll Transaction Code.";
    SourceTableView = where("Transaction Type" = const(Income));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Transaction Code"; Rec."Transaction Code")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Name"; Rec."Transaction Name")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field("Balance Type"; Rec."Balance Type")
                {
                    ApplicationArea = Basic;
                }
                field(Frequency; Rec.Frequency)
                {
                    ApplicationArea = Basic;
                }
                field(Taxable; Rec.Taxable)
                {
                    ApplicationArea = Basic;
                }
                field("Is Cash"; Rec."Is Cash")
                {
                    ApplicationArea = Basic;
                }
                field("Is Formulae"; Rec."Is Formulae")
                {
                    ApplicationArea = Basic;
                }
                field(Formulae; Rec.Formulae)
                {
                    ApplicationArea = Basic;
                }
                field("G/L Account"; Rec."G/L Account")
                {
                    ApplicationArea = Basic;
                }
                field("G/L Account Name"; Rec."G/L Account Name")
                {
                    ApplicationArea = Basic;
                }
                field(SubLedger; Rec.SubLedger)
                {
                    ApplicationArea = Basic;
                }
                field("Customer Posting Group"; Rec."Customer Posting Group")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Loan Details")
            {
                field("Deduct Premium"; Rec."Deduct Premium")
                {
                    ApplicationArea = Basic;
                }
                field("Interest Rate"; Rec."Interest Rate")
                {
                    ApplicationArea = Basic;
                }
                field("Repayment Method"; Rec."Repayment Method")
                {
                    ApplicationArea = Basic;
                }
                field("IsCo-Op/LnRep"; Rec."IsCo-Op/LnRep")
                {
                    ApplicationArea = Basic;
                }
                field("Deduct Mortgage"; Rec."Deduct Mortgage")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Other Setup")
            {
                field("Special Transaction"; Rec."Special Transaction")
                {
                    ApplicationArea = Basic;
                }
                field("Amount Preference"; Rec."Amount Preference")
                {
                    ApplicationArea = Basic;
                }
                field("Fringe Benefit"; Rec."Fringe Benefit")
                {
                    ApplicationArea = Basic;
                }
                field(IsHouseAllowance; Rec.IsHouseAllowance)
                {
                    ApplicationArea = Basic;
                }
                field("Employer Deduction"; Rec."Employer Deduction")
                {
                    ApplicationArea = Basic;
                }
                field("Include Employer Deduction"; Rec."Include Employer Deduction")
                {
                    ApplicationArea = Basic;
                }
                field("Formulae for Employer"; Rec."Formulae for Employer")
                {
                    ApplicationArea = Basic;
                }
                field("Co-Op Parameters"; Rec."Co-Op Parameters")
                {
                    ApplicationArea = Basic;
                }
                field(Welfare; Rec.Welfare)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Transaction Type" := Rec."transaction type"::Income;
    end;
}
