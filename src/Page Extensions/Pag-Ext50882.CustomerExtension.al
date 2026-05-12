pageextension 50882 CustomerExtension extends "Customer Card"
{
    layout
    {
        // Add changes to page layout here
        addafter(Address)
        {
            field("Customer Type"; Rec."Customer Type")
            {
                ApplicationArea = all;
            }
            field("Employer Code"; Rec."Employer Code")
            {
                ApplicationArea = all;
            }
            field("Employer Name"; Rec."Employer Name")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }
    }

    actions
    {

        // Add changes to page actions here
    }

    var
        myInt: Integer;
}