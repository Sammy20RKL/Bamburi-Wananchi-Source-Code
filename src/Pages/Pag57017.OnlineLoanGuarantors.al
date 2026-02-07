namespace PolyTech.PolyTech;
page 57017 "Online Loan Guarantors"
{
    ApplicationArea = All;
    Caption = 'Online Loan Guarantors';
    PageType = ListPart;
    SourceTable = "Online Loan Guarantors";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No"; Rec."Entry No")
                {
                }
                field("Loan Application No"; Rec."Loan Application No")
                {
                }
                field("Member No"; Rec."Member No")
                {
                }
                field(Names; Rec.Names)
                {
                }
                field("Email Address"; Rec."Email Address")
                {
                }
                field("ID No"; Rec."ID No")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Approval Status"; Rec."Approval Status")
                {
                }
            }
        }
    }
}
