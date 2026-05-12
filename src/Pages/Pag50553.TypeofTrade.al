#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50553 "Type of Trade"
{
    PageType = List;
    SourceTable = "Type of Trade";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Type of Trade"; Rec."Type of Trade")
                {
                    ApplicationArea = Basic;
                }
                field("Trade Description"; Rec."Trade Description")
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

