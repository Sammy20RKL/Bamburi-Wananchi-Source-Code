page 52017 "Leave Statistics Factbox"
{

    ApplicationArea = All;
    Caption = 'Leave Statistics Factbox';
    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = CardPart;
    SourceTable = "HR Employees";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'Leave Statistics';
                ShowCaption = false;
                field("Leave Entitlment"; Rec."Leave Entitlement")
                {
                    ToolTip = 'Specifies the value of the Leave Entitlment field.';
                    Caption = 'Leave Entitlement';
                }
                field(LeaveEarnedToDate; LeaveEarnedToDate)
                {
                    ToolTip = 'Specifies the value of the Leave Earned To Date field.';
                    Caption = 'Leave Earned To Date';
                }
                //field()
                field("Recalled Days"; Rec."Leave Recall Days")
                {
                    ToolTip = 'Specifies the value of the Recalled Days field.';
                    Caption = 'Recalled Days';
                }
                field("Days Absent"; Rec."Days Absent")
                {
                    ToolTip = 'Specifies the value of the Days Absent field.';
                    Caption = 'Days Absent';
                }
                field("Balance brought forward"; Rec."Leave Balance Brought Forward")
                {
                    ToolTip = 'Specifies the value of the Balance brought forward field.';
                    Caption = 'Balance Brought Forward';
                }
                field("Total Leave Days Taken"; Rec."Leave Days Taken")
                {
                    ToolTip = 'Specifies the value of the Total Leave Days Taken field.';
                    Caption = 'Leave Days Taken';
                }
                field("Leave Balance"; Rec."Leave Balance")
                {
                    ToolTip = 'Specifies the value of the Leave balance field.';
                    Caption = 'Leave Balance';
                }
            }
        }
    }

    var
        HRManagement: Codeunit "HR Management";
        LeaveEarnedToDate: Decimal;

    procedure GetLeaveEarnedToDate(LeaveTypeCode: Code[20])
    begin
        LeaveEarnedToDate := HRManagement.GetLeaveDaysEarnedToDate(Rec, LeaveTypeCode);
        // Rec.leave
    end;
}






