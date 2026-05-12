Page 56048 "Loan Appeal List"
{
    ApplicationArea = All;
    CardPageId = "Loan Appeal Card";
    Caption = 'Loan Appeal List';
    PageType = List;
    SourceTable = "Loan Appeal";
    Editable = false;
    SourceTableView = where(Appealed = const(false));



    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Loan Number"; Rec."Loan Number")
                {
                    ToolTip = 'Specifies the value of the Loan Number field.';
                    Editable = false;
                }
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    ToolTip = 'Specifies the value of the Loan Product Type field.';
                    Editable = false;
                }
                field("Amount Applied"; Rec."Amount Applied")
                {
                    ToolTip = 'Specifies the value of the Amount Applied field.';
                    Editable = false;
                }
                field(Type; rec.Type)
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("New Amount"; Rec."New Amount")
                {
                    ToolTip = 'Specifies the value of the New Amount field.';
                    Editable = false;
                    // Visible = false;
                }
                field("Oustanding Balance"; Rec."Oustanding Balance")
                {
                    ToolTip = 'Specifies the value of the Oustanding Balance field.';
                    Editable = false;
                }
                field(Installments; Rec.Installments)
                {
                    ToolTip = 'Specifies the value of the Installments field.';
                    Editable = false;
                }

            }
        }

    }


}
