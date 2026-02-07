page 52011 "Leave Entitlement Entries"
{
    ApplicationArea = All;
    Caption = 'Leave Entitlement Entries';
    PageType = List;
    SourceTable = "Leave Entitlement Entry";
    UsageCategory = None;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Employee Category"; Rec."Employee Category")
                {
                    ToolTip = 'Specifies the value of the Employee Category field.';
                    Visible = false;
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ToolTip = 'Specifies the value of the Country/Region Code field.';
                }
                field(Days; Rec.Days)
                {
                    ToolTip = 'Specifies the value of the Days field.';
                }
                field("Days Earned per Month"; Rec."Days Earned per Month")
                {
                    ToolTip = 'Specifies the value of the Days Earned per Month field.';
                    Editable = EarnDaysEditable;
                    ShowMandatory = true;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetPageControls();
    end;

    var
        LeaveType: Record "Leave Type";
        EarnDaysEditable: Boolean;

    local procedure SetPageControls()
    begin
        if LeaveType.Get(Rec."Leave Type Code") then begin
            if LeaveType."Earn Days" then
                EarnDaysEditable := true
            else
                EarnDaysEditable := false;
        end else
            EarnDaysEditable := false;
    end;
}
