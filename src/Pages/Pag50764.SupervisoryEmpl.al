#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50764 "Supervisory$Empl"
{
    PageType = List;
    SourceTable = "Supervisory$Board$Empl";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("Position held"; Rec."Position held")
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

