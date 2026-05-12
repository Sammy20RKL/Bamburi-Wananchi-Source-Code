#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50991 "Member Net Risk Rating Scale"
{
    PageType = List;
    SourceTable = "Member Net Risk Rating Scale";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Minimum Risk Rate"; Rec."Minimum Risk Rate")
                {
                    ApplicationArea = Basic;
                }
                field("Maximum Risk Rate"; Rec."Maximum Risk Rate")
                {
                    ApplicationArea = Basic;
                }
                field("Risk Scale"; Rec."Risk Scale")
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

