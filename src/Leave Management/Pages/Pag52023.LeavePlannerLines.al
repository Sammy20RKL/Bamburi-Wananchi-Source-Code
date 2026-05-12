page 52023 "Leave Planner Lines"
{
    ApplicationArea = All;
    AutoSplitKey = true;
    Caption = 'Leave Planner Lines';
    PageType = ListPart;
    SourceTable = "Leave Planner Lines";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Employee No."; Rec."Employee No.")
                {
                    ToolTip = 'Specifies the value of the Employee No. field.';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the value of the Employee Name field.';
                }
                field("Leave Type"; Rec."Leave Type")
                {
                    ToolTip = 'Specifies the value of the Leave Type field.';
                }
                field("No. of Days"; Rec."No. of Days")
                {
                    ToolTip = 'Specifies the value of the No. of Days field.';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field.';
                }
                field("End Date"; Rec."End Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field.';
                    Editable = false;
                }
                field("Resumption Date"; Rec."Resumption Date")
                {
                    ToolTip = 'Specifies the value of the Resumption Date field.';
                    Editable = false;
                }

            }
        }
    }
}






