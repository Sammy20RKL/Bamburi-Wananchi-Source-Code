pageextension 50620 "CustomerLookupExt" extends "Customer Lookup"
{
    layout
    {
        addafter(Name)
        {
            field("Personal No"; Rec."Personal No")
            {
                ApplicationArea = Basic;
                Caption = 'Payroll No.';
                Visible = true;
            }
            field("ID No."; Rec."ID No.")
            {

            }
            field("FOSA Account"; Rec."FOSA Account")
            {

            }
            field("Mobile Phone No"; Rec."Mobile Phone No")
            {

            }
            field("Account Category"; Rec."Account Category")
            {

            }

            field("Posting Group"; Rec."Customer Posting Group")
            {

            }
            field("Group Account"; Rec."Group Account")
            {

            }
            field(Names; Rec.Name) { }
            field("Payroll/Staff No"; Rec."Payroll/Staff No") { }


        }
        modify("Phone No.")
        {
            Visible = false;
        }
        modify("Post Code")
        {
            visible = false;
        }
        modify(Contact)
        {
            Visible = false;
        }


    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}
