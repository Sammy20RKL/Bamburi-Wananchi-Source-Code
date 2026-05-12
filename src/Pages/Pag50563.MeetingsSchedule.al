#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50563 "Meetings Schedule"
{
    PageType = List;
    SourceTable = "Meetings Schedule";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Meeting Date"; Rec."Meeting Date")
                {
                    ApplicationArea = Basic;
                }
                field("Meeting Place"; Rec."Meeting Place")
                {
                    ApplicationArea = Basic;
                }
                field("Meeting Status"; Rec."Meeting Status")
                {
                    ApplicationArea = Basic;
                }
                field("Meeting Outcome(Brief)"; Rec."Meeting Outcome(Brief)")
                {
                    ApplicationArea = Basic;
                }
                field("User to Notify"; Rec."User to Notify")
                {
                    ApplicationArea = Basic;
                }
                field("User Email"; Rec."User Email")
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

