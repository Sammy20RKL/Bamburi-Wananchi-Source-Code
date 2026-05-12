page 52016 "Leave Relievers"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Leave Relievers";
    Caption = 'Leave Relievers';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Staff No"; Rec."Staff No")
                {
                    ToolTip = 'Specifies the value of the Staff No field';
                }
                field("Staff Name"; Rec."Staff Name")
                {
                    ToolTip = 'Specifies the value of the Staff Name field';
                }
                field("Leave Code"; Rec."Leave Code")
                {
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Leave Code field';
                }
            }
        }
    }

    actions
    {
    }
}





