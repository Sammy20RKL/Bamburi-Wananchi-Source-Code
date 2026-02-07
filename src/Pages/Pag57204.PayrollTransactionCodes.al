namespace PolyTechERPSourceCode.PolyTechERPSourceCode;

page 57204 "Payroll Transaction Codes"
{
    ApplicationArea = All;
    Caption = 'Payroll Transaction Codes';
    PageType = List;
    SourceTable = "Payroll Transaction Code.";
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Transaction Code"; Rec."Transaction Code")
                {
                }
                field("Transaction Name"; Rec."Transaction Name")
                {
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                }
                field("pay period"; Rec."pay period")
                {
                }
                field("% of Basic"; Rec."% of Basic")
                {
                }
                field("Amount Preference"; Rec."Amount Preference")
                {
                }
                field("Balance Type"; Rec."Balance Type")
                {
                }
                field("Bank code"; Rec."Bank code")
                {
                }
                field(Blocked; Rec.Blocked)
                {
                }
                field("Co-Op Parameters"; Rec."Co-Op Parameters")
                {
                }
                field("Current Amount"; Rec."Current Amount")
                {
                }
                field("Current Amount(LCY)"; Rec."Current Amount(LCY)")
                {
                }
                field("Current Month Filter"; Rec."Current Month Filter")
                {
                }
                field("Customer Posting Group"; Rec."Customer Posting Group")
                {
                }
                field("Deduct Mortgage"; Rec."Deduct Mortgage")
                {
                }
                field("Deduct Premium"; Rec."Deduct Premium")
                {
                }
                field("Employee Code Filter"; Rec."Employee Code Filter")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field("Employer Deduction"; Rec."Employer Deduction")
                {
                }
                field("Exclude in NHIF"; Rec."Exclude in NHIF")
                {
                }
                field("Exclude in NSSF"; Rec."Exclude in NSSF")
                {
                }
                field("Formula for Management Prov"; Rec."Formula for Management Prov")
                {
                }
                field(Formulae; Rec.Formulae)
                {
                }
                field("Formulae for Employer"; Rec."Formulae for Employer")
                {
                }
                field(Frequency; Rec.Frequency)
                {
                }
                field("Fringe Benefit"; Rec."Fringe Benefit")
                {
                }
                field("G/L Account"; Rec."G/L Account")
                {
                }
                field("G/L Account Name"; Rec."G/L Account Name")
                {
                }
                field("Grouping Type"; Rec."Grouping Type")
                {
                }
                field("Include Employer Deduction"; Rec."Include Employer Deduction")
                {
                }
                field("Include in Levy Calculation"; Rec."Include in Levy Calculation")
                {
                }
                field("Insurance Code"; Rec."Insurance Code")
                {
                }
                field("Interest Rate"; Rec."Interest Rate")
                {
                }
                field("Is Cash"; Rec."Is Cash")
                {
                }
                field("Is Formulae"; Rec."Is Formulae")
                {
                }
                field("Is Loan Account"; Rec."Is Loan Account")
                {
                }
                field("IsCo-Op/LnRep"; Rec."IsCo-Op/LnRep")
                {
                }
                field(IsHouseAllowance; Rec.IsHouseAllowance)
                {
                }
                field("Loan Product"; Rec."Loan Product")
                {
                }
                field("Loan Product Name"; Rec."Loan Product Name")
                {
                }
                field(Months; Rec.Months)
                {
                }
                field("No. Series"; Rec."No. Series")
                {
                }
                field("Previous Amount"; Rec."Previous Amount")
                {
                }
                field("Previous Amount(LCY)"; Rec."Previous Amount(LCY)")
                {
                }
                field("Previous Month Filter"; Rec."Previous Month Filter")
                {
                }
                field("Repayment Method"; Rec."Repayment Method")
                {
                }
                field("Sacco Code"; Rec."Sacco Code")
                {
                }
                field("Special Transaction"; Rec."Special Transaction")
                {
                }
                field(SubLedger; Rec.SubLedger)
                {
                }
                field(Taxable; Rec.Taxable)
                {
                }
                field("Transaction Category"; Rec."Transaction Category")
                {
                }
                field("Transaction Specification"; Rec."Transaction Specification")
                {
                }
                field(Welfare; Rec.Welfare)
                {
                }
                field("Welfare code"; Rec."Welfare code")
                {
                }
            }
        }
    }
}
