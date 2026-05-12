page 52018 "Leave Adjustment List"
{
    ApplicationArea = All;
    CardPageID = "Leave Adjustment Header";
    PageType = List;
    SourceTable = "Leave Bal Adjustment Header";
    Caption = 'Leave Adjustment List';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field';
                }
                field(Posted; Rec.Posted)
                {
                    ToolTip = 'Specifies the value of the Posted field';
                }
                field("Posted By"; Rec."Posted By")
                {
                    ToolTip = 'Specifies the value of the Posted By field';
                }
                field("Posted Date"; Rec."Posted Date")
                {
                    ToolTip = 'Specifies the value of the Posted Date field';
                }
            }
        }
    }

    actions
    {
    }
}





