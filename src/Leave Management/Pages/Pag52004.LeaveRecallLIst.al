page 52004 "Leave Recall List"
{
    ApplicationArea = All;
    CardPageID = "Leave Recall";
    Editable = false;
    PageType = List;
    SourceTable = "Employee Off/Holiday";
    Caption = 'Leave Recall List';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field';
                }
                field(Date; Rec.Date)
                {
                    ToolTip = 'Specifies the value of the Date field';
                }
                field("Recall Date"; Rec."Recall Date")
                {
                    ToolTip = 'Specifies the value of the Recall Date field';
                }
                field("Recalled By"; Rec."Recalled By")
                {
                    ToolTip = 'Specifies the value of the Recalled By field';
                }
                field("Reason for Recall"; Rec."Reason for Recall")
                {
                    ToolTip = 'Specifies the value of the Reason for Recall field';
                }
                field("Recalled From"; Rec."Recalled From")
                {
                    ToolTip = 'Specifies the value of the Recalled From field';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field';
                }
            }
        }
    }

    actions
    {
    }
}





