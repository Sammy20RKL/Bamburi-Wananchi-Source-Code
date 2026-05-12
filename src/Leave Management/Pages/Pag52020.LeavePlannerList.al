page 52020 "Leave Planner List"
{
    ApplicationArea = All;
    Caption = 'Leave Planner List';
    PageType = List;
    SourceTable = "Leave Planner Header";
    UsageCategory = Lists;
    CardPageId = "Leave Planner Card";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Leave Period"; Rec."Leave Period")
                {
                    ToolTip = 'Specifies the value of the Leave Period field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
            }
        }
    }
}






