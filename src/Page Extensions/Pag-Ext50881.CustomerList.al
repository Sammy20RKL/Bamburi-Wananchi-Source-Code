pageextension 50881 CustomerList extends "Customer List"

{

    layout
    {
        // Add changes to page layout here
        addafter(Name)
        {
            field("Personal No"; Rec."Personal No")
            {
                ApplicationArea = Basic;
                Caption = 'Payroll No.';
                // Visible = false;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        Rec.Reset();
        Rec.SetRange(rec."Customer Type", Rec."Customer Type"::Member);// Checkoff);
    end;

    var
        myInt: Integer;
}