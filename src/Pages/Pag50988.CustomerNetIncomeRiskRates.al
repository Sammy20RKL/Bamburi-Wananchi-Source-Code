#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50988 "Customer Net Income Risk Rates"
{
    PageType = List;
    SourceTable = 51932;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Min Annual Income"; Rec."Min Annual Income")
                {
                    ApplicationArea = Basic;
                }
                field("Max Annual Income"; Rec."Max Annual Income")
                {
                    ApplicationArea = Basic;
                }
                field("Risk Rate"; Rec."Risk Rate")
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

