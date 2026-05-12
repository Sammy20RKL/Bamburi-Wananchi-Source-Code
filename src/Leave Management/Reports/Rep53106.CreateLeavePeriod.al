report 53106 "Create Leave Period"
{
    ApplicationArea = All;
    Caption = 'Create Leave Period';
    ProcessingOnly = true;

    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                    Caption = 'Leave Period Details';
                    field(LeavePeriod; LeavePeriodCode)
                    {
                        Caption = 'Leave Period Code';
                        ApplicationArea = All;
                        ShowMandatory = true;
                    }
                    field(DescriptionTxt; DescriptionTxt)
                    {
                        Caption = 'Description';
                        ApplicationArea = All;
                        ShowMandatory = true;
                    }
                    field(StartDate; StartDate)
                    {
                        Caption = 'Leave Period Start Date';
                        ApplicationArea = All;
                        ShowMandatory = true;

                        trigger OnValidate()
                        begin
                            /* if Date2DMY(StartDate, 3) <> Date2DMY(Today, 3) then
                                Error(DateMustBeInCurrYearErr); */
                        end;
                    }
                    field(EndDate; EndDate)
                    {
                        Caption = 'Leave Period End Date';
                        ApplicationArea = All;
                        ShowMandatory = true;

                        trigger OnValidate()
                        begin
                            /* if Date2DMY(EndDate, 3) <> Date2DMY(Today, 3) then
                                Error(DateMustBeInCurrYearErr); */
                        end;
                    }
                }
            }
        }
    }

    trigger OnPreReport()
    begin
        LeavePeriods.Reset();
        if LeavePeriods.FindSet() then
            repeat
                ExistingLeavePeriodYear := Date2DMY(LeavePeriods."Start Date", 3);
                LeavePeriodYear := Date2DMY(StartDate, 3);
                if ExistingLeavePeriodYear = LeavePeriodYear then
                    Error(LeavePeriodForYearExistsErr, LeavePeriodYear);
            until LeavePeriods.Next() = 0;

        LeavePeriods.Init();
        LeavePeriods."Leave Period Code" := LeavePeriodCode;
        LeavePeriods.Description := DescriptionTxt;
        LeavePeriods."Start Date" := StartDate;
        LeavePeriods."End Date" := EndDate;
        LeavePeriods.Insert();

        if Confirm(AssignLeaveDaysConfirmMsg, false, LeavePeriods."Leave Period Code") then
            HRMgt.AssignLeaveDays(LeavePeriods);
    end;

    var
        LeavePeriods: Record "Leave Period";
        HRMgt: Codeunit "HR Management";
        LeavePeriodCode: Code[20];
        EndDate: Date;
        StartDate: Date;
        ExistingLeavePeriodYear, LeavePeriodYear : Integer;
        AssignLeaveDaysConfirmMsg: Label 'Do you want to assign leave days for Leave period %1?';
        LeavePeriodForYearExistsErr: Label 'Leave period for the year %1 already exists';
        DescriptionTxt: Text[100];
}






