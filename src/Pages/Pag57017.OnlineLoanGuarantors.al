namespace Bamburi.Bamburi;
page 57017 "Online Loan Guarantors"
{
    ApplicationArea = All;
    Caption = 'Online Loan Guarantors';
    PageType = ListPart;
    DeleteAllowed = true;
    InsertAllowed = false;
    Editable = true;
    SourceTable = "Online Loan Guarantors";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No"; Rec."Entry No")
                {
                    Editable = false;
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
                field(Telephone; Rec.Telephone)
                {
                }
                field("ID No"; Rec."ID No")
                {
                }
                field(Amount; Rec.Amount)
                {
                    Editable = false;
                }
                field(Approved; Rec.Approved)
                {
                    Editable = true;
                }
            }
        }
    }
}
