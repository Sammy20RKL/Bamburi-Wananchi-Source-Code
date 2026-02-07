codeunit 52004 "Workflow Responses HR"
{
    trigger OnRun()
    begin
    end;

    var
        // Committment: Codeunit "Commitments Mgt HR";
        HRMgnt: Codeunit "HR Management";

    procedure ReleaseLeaveRecallRequest(var LeaveRecall: Record "Employee Off/Holiday")
    var
        LeaveRec: Record "Employee Off/Holiday";
    begin
        LeaveRec.Reset();
        LeaveRec.SetRange("No.", LeaveRecall."No.");
        if LeaveRec.FindFirst() then begin
            LeaveRec.Status := LeaveRec.Status::Released;
            LeaveRec.Modify(true);
            //Recall
            HRMgnt.LeaveRecall(LeaveRec."No.");
        end;
    end;

    procedure ReopenLeaveRecallRequest(var LeaveRecall: Record "Employee Off/Holiday")
    var
        LeaveRec: Record "Employee Off/Holiday";
    begin
        LeaveRec.Reset();
        LeaveRec.SetRange("No.", LeaveRecall."No.");
        if LeaveRec.FindFirst() then begin
            LeaveRec.Status := LeaveRecall.Status::Open;
            LeaveRec.Modify(true)
        end;
    end;

    procedure ReopenLeave(var LeaveReq: Record "Leave Application")
    var
        Leave: Record "Leave Application";
    begin
        Leave.Reset();
        Leave.SetRange("Application No", LeaveReq."Application No");
        if Leave.FindFirst() then begin
            Leave.Status := Leave.Status::Open;
            Leave.Modify(true);
        end;
    end;

    procedure ReleaseLeave(var LeaveReq: Record "Leave Application")
    var
        Leave: Record "Leave Application";
    begin
        Leave.Reset();
        Leave.SetRange("Application No", LeaveReq."Application No");
        if Leave.FindFirst() then begin
            // Message('Current Leave status is %1', Leave.Status);
            Leave.Validate(Status, Leave.Status::Released);
            Leave.Modify(true);
            //Message('Leave status is %1', Leave.Status);
            HRMgnt.LeaveApplication(Leave."Application No");

            HRMgnt.NotifyLeaveReliever(Leave."Application No");
            // Message('2 Leave status is %1', Leave.Status);
            //if guiAllowed then begin
            //if Confirm('Do you want to notify the leave applicant and their reliever(s)', false) then

            // end else
            //  HRMgnt.NotifyLeaveReliever(Leave."Application No");
        end;
        Leave.Reset();
        // Leave.SetRange("Application No", LeaveReq."Application No");
        // if Leave.FindFirst() then
        //     HRMgnt.LeaveApplication(Leave."Application No");
    end;





    procedure ReleaseLeaveEntitlementRequest(var LeaveEntitle: Record Employee)
    begin
    end;

    procedure ReopenLeaveEntitlementRequest(var LeaveEntitle: Record Employee)
    begin
    end;

    procedure ReleaseEmpActingPromotion(var EmpActingProm: Record "Employee Acting Position")
    var
        Employee: Record "HR Employees";
        EmpActingPromRec: Record "Employee Acting Position";
    begin
        EmpActingPromRec.Reset();
        EmpActingPromRec.SetRange(No, EmpActingProm.No);
        if EmpActingPromRec.FindFirst() then begin
            case EmpActingPromRec."Document Type" of
                EmpActingPromRec."Document Type"::Acting:
                    begin
                        Employee.Reset();
                        Employee.SetRange("No.", EmpActingPromRec."Acting Employee No.");
                        if Employee.Find('-') then begin
                            EmpActingPromRec.TestField("End Date");
                            // if Employee."End Date" > Today then
                            //     Error('This Employee is already on an acting Capacity');

                            // Employee."Acting No" := EmpActingPromRec.No;
                            // Employee."Acting Position" := EmpActingPromRec.Position;
                            // Employee."Acting Description" := EmpActingPromRec."Job Description";
                            // Employee."Relieved Employee" := EmpActingPromRec."Relieved Employee";
                            // Employee."Relieved Name" := EmpActingPromRec."Relieved Name";
                            // Employee."Start Date" := EmpActingPromRec."Start Date";
                            // Employee."End Date" := EmpActingPromRec."End Date";
                            // Employee."Reason for Acting" := EmpActingPromRec.Reason;
                            // Employee.Modify();
                        end;
                    end;
                EmpActingPromRec."Document Type"::Promotion:
                    begin
                        Employee.Reset();
                        Employee.SetRange("No.", EmpActingPromRec."Acting Employee No.");
                        if Employee.Find('-') then begin
                            Employee."Job Title" := EmpActingPromRec."Job Description";
                            Employee."Job Position" := EmpActingPromRec."Desired Position";
                            Employee.Modify();
                        end;
                        // EmpActingPromRec.Promoted := true;
                        // EmpActingPromRec.Modify;
                    end;
            end;

            EmpActingPromRec.Status := EmpActingPromRec.Status::Approved;
            EmpActingPromRec.Modify(true);
        end;
    end;

    procedure ReopenEmpActingPromotion(var EmpActingProm: Record "Employee Acting Position")
    var
        EmpActingPromRec: Record "Employee Acting Position";
    begin
        EmpActingPromRec.Reset();
        EmpActingPromRec.SetRange(No, EmpActingProm.No);
        if EmpActingPromRec.FindFirst() then begin
            EmpActingPromRec.Status := EmpActingPromRec.Status::New;
            EmpActingPromRec.Modify(true);
        end;
    end;

    procedure ReleaseLeaveAdj(LeaveAdj: Record "Leave Bal Adjustment Header")
    var
        LeaveAdjRec: Record "Leave Bal Adjustment Header";
    begin
        if LeaveAdjRec.Get(LeaveAdj.Code) then begin
            LeaveAdjRec.Status := LeaveAdjRec.Status::Released;
            LeaveAdjRec.Modify();
        end;
    end;

    procedure ReopenLeaveAdj(LeaveAdj: Record "Leave Bal Adjustment Header")
    var
        LeaveAdjRec: Record "Leave Bal Adjustment Header";
    begin
        if LeaveAdjRec.Get(LeaveAdj.Code) then begin
            LeaveAdjRec.Status := LeaveAdjRec.Status::Open;
            LeaveAdjRec.Modify();
        end;
    end;


}
