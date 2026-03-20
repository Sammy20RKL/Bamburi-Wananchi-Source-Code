page 70746 "Monthly Advice List"
{
    Caption = 'Monthly Advice';
    PageType = List;
    ApplicationArea = All;
    SourceTable = "Monthly Advice";

    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                field("Entry No"; Rec."Entry No") { ApplicationArea = All; }
                field("Member No."; Rec."Member No.") { ApplicationArea = All; }
                field("Staff No."; Rec."Staff No.") { ApplicationArea = All; }
                field("Name"; Rec."Name") { ApplicationArea = All; }
                field("Loan Type"; Rec."Loan Type") { ApplicationArea = All; }
                field("Period"; Rec."Period") { ApplicationArea = All; }
                field("Advice Date"; Rec."Advice Date") { ApplicationArea = All; }
                field("Account No"; Rec."Account No") { ApplicationArea = All; }
                field("Share Capital"; Rec."Share Capital") { ApplicationArea = All; }
                field("Monthly Deposits Contribution"; Rec."Monthly Deposits Contribution") { ApplicationArea = All; }
                field("Monthly Deposit Contribution"; Rec."Monthly Deposit Contribution") { ApplicationArea = All; }
                field("Registration Fees"; Rec."Registration Fees") { ApplicationArea = All; }
                field("Insurance"; Rec."Insurance") { ApplicationArea = All; }
                field("Loan Principle"; Rec."Loan Principle") { ApplicationArea = All; }
                field("Loan Interest"; Rec."Loan Interest") { ApplicationArea = All; }
                field("Interest"; Rec."Interest") { ApplicationArea = All; }
                field("Loans"; Rec."Loans") { ApplicationArea = All; }
                field("Xmas Contribution"; Rec."Xmas Contribution") { ApplicationArea = All; }
                field("Penalty BOSA"; Rec."Penalty BOSA") { ApplicationArea = All; }
                field("Total"; Rec."Total") { ApplicationArea = All; }
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            action(ExportToExcel)
            {

            }
        }
    }
}
