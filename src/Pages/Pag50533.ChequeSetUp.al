#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50533 "Cheque Set-Up"
{
    Editable = false;
    PageType = List;
    SourceTable = "Cheque Set Up";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cheque Code"; Rec."Cheque Code")
                {
                    ApplicationArea = Basic;
                }
                field("Number Of Leaf"; Rec."Number Of Leaf")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

