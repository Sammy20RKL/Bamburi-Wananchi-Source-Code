page 52001 "Leave Periods"
{
    ApplicationArea = All;
    DelayedInsert = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Leave Period";
    Caption = 'Leave Periods';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Leave Period"; Rec."Leave Period Code")
                {
                    ToolTip = 'Specifies the value of the Leave Period field';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field';
                }
                field("End Date"; Rec."End Date")
                {
                    ToolTip = 'Specifies the value of the End Date field';
                }
                field(closed; Rec.closed)
                {
                    ToolTip = 'Specifies the value of the closed field';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Create Leave Period")
            {
                Image = CreateYear;
                //RunObject = report "Create Leave Period";
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                var
                    OpenLeavePeriodExistsErr: Label 'An open leave period %1 already exists. Please close it so as to create a new leave period.';
                begin
                    //Check for open periods
                    LeavePeriods.Reset();
                    LeavePeriods.SetRange(Closed, false);
                    if LeavePeriods.FindFirst() then
                        Error(OpenLeavePeriodExistsErr, LeavePeriods."Leave Period Code");

                    Report.Run(Report::"Create Leave Period", true, false);
                end;
            }
            action("Close Leave Period")
            {
                Image = CloseYear;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                Enabled = not Rec.Closed;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to close %1 leave period', false, Rec."Leave Period Code") then
                        HRMgt.CloseLeavePeriod(Rec);
                end;
            }
        }
    }

    var
        LeavePeriods: Record "Leave Period";
        HRMgt: Codeunit "HR Management";
}


