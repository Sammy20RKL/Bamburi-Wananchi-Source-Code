page 52009 "Leave Application List"
{
    ApplicationArea = All;
    CardPageID = "Leave Application Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Leave Application";
    Caption = 'Leave Application List';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Application No"; Rec."Application No")
                {
                    ToolTip = 'Specifies the value of the Application No field';
                }
                field("Application Date"; Rec."Application Date")
                {
                    ToolTip = 'Specifies the value of the Application Date field';
                }
                field("Employee No"; Rec."Employee No")
                {
                    ToolTip = 'Specifies the value of the Employee No field';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the value of the Employee Name field';
                }
                field("Days Applied"; Rec."Days Applied")
                {
                    ToolTip = 'Specifies the value of the Days Applied field';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field';
                }
                field("End Date"; Rec."End Date")
                {
                    ToolTip = 'Specifies the value of the End Date field';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field';
                }
                field("Leave Period"; Rec."Leave Period")
                {
                    ToolTip = 'Specifies the value of the Leave Period field';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
    end;
}





