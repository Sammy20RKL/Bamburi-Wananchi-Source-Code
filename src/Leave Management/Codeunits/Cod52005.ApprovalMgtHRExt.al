codeunit 52005 "Approval Mgt HR Ext"

{
    var
        WorkflowEventHandling: Codeunit "Wkfl Event Handle HR Ext";
        WorkFlowManagement: Codeunit "Workflow Management";
        NoWorkflowEnabledErr: Label 'No approval workflow for this record type is enabled.';


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', false, false)]
    local procedure OnPopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var

        LeaveRequest: Record "Leave Application";
        LeaveAdj: Record "Leave Bal Adjustment Header";

        Employee: Record "HR Employees";
        StaffAppraisalApprovalLbl: Label 'Staff Appraisal-%1 for the Period between %2 - %3', Comment = '%1 = Employee Name, %2 = Period Start, %3 = Period End';
    begin
        case RecRef.Number of

            //Leave Application
            Database::"Leave Application":
                begin
                    RecRef.SetTable(LeaveRequest);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::LeaveApplication;
                    ApprovalEntryArgument."Document No." := LeaveRequest."Application No";
                    ApprovalEntryArgument."Salespers./Purch. Code" := '';
                end;
            //Recruitment


            //Leave Adj
            Database::"Leave Bal Adjustment Header":
                begin
                    RecRef.SetTable(LeaveAdj);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::LeaveAdjustment;
                    ApprovalEntryArgument."Document No." := LeaveAdj.Code;
                    ApprovalEntryArgument.Description := 'Leave Adjustment';
                end;

        end;


    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSetStatusToPendingApproval', '', false, false)]
    local procedure OnSetStatusToPendingApproval(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var

        LeaveRecall: Record "Employee Off/Holiday";
        LeaveRequest: Record "Leave Application";
        LeaveAdj: Record "Leave Bal Adjustment Header";


        Employee: Record "HR Employees";
    begin
        case RecRef.Number of
            //Leave Application
            Database::"Leave Application":
                begin
                    RecRef.SetTable(LeaveRequest);
                    LeaveRequest.Validate(Status, LeaveRequest.Status::"Pending Approval");
                    LeaveRequest.Modify(true);
                    Variant := LeaveRequest;
                    IsHandled := true;

                end;


            //Leave Recall
            Database::"Employee Off/Holiday":
                begin
                    RecRef.SetTable(LeaveRecall);
                    LeaveRecall.Validate(Status, LeaveRecall.Status::"Pending Approval");
                    LeaveRecall.Modify(true);
                    Variant := LeaveRecall;
                    IsHandled := true;
                end;


            //Leave Adj
            Database::"Leave Bal Adjustment Header":
                begin
                    RecRef.SetTable(LeaveAdj);
                    LeaveAdj.Validate(Status, LeaveAdj.Status::"Pending Approval");
                    LeaveAdj.Modify(true);
                    Variant := LeaveAdj;
                    IsHandled := true;
                end;

        // New Employee Approval
        // Database::Employee:
        //     begin
        //         RecRef.SetTable(Employee);
        //         Employee.Validate("Approval Status", Employee."Approval Status"::"Pending Approval");
        //         Employee.Modify(true);
        //         Variant := Employee;
        //         IsHandled := true;
        //     end;
        end;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    local procedure PerformActionsOnRejectApprovalRequest(var ApprovalEntry: Record "Approval Entry")
    var
        EmpActing: Record "Employee Acting Position";
        Leave: Record "Leave Application";
        HRMgt: Codeunit "HR Management";
    // Employee: Record "HR Employees";
    begin
        //Employee Acting
        if EmpActing.Get(ApprovalEntry."Document No.") then begin
            EmpActing.Validate(Status, EmpActing.Status::Rejected);
            EmpActing.Modify();
        end;

        //Leave
        if Leave.Get(ApprovalEntry."Document No.") then begin
            if Confirm('Do you want to notify Leave Applicant that you have rejected their leave?', false) then
                HRMgt.NotifyLeaveApplicantOnRejection(Leave);
        end;
        // New Employee Approval
        // if Employee.Get(Employee."No.") then begin
        //     Employee.Validate("Approval Status", Employee."Approval Status"::Rejected);
        //     Employee.Modify();
        // end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnBeforeApprovalEntryInsert', '', false, false)]
    local procedure InsertCustomApprovalEntryFields(var ApprovalEntry: Record "Approval Entry"; ApprovalEntryArgument: Record "Approval Entry")
    var
        LeaveApp: Record "Leave Application";
        RecRef: RecordRef;
        LeaveApprovalLbl: Label 'Leave Application %1 - %2 Day(s) applied', Comment = '%1 = Employee Name, %2 = Days Applied';
    begin
        //Insert Descriptions
        case ApprovalEntry."Table ID" of
            Database::"Leave Application":
                begin
                    RecRef.Get(ApprovalEntryArgument."Record ID to Approve");
                    RecRef.SetTable(LeaveApp);
                    ApprovalEntryArgument.Description := StrSubstNo(LeaveApprovalLbl, LeaveApp."Employee Name", LeaveApp."Days Applied");
                end;

        end;
    end;


    // procedure CheckTransportWorkflowEnabled(var TransportReq: Record "Travel Requests"): Boolean
    // begin
    //     if not IsTransportWorkflowEnabled(TransportReq) then
    //         Error(NoWorkflowEnabledErr);
    //     exit(true);
    // end;

    // procedure IsTransportWorkflowEnabled(var TransportReq: Record "Travel Requests"): Boolean
    // begin
    //     exit(WorkflowManagement.CanExecuteWorkflow(TransportReq, WorkflowEventHandling.RunWorkflowOnSendTransportForApprovalCode()));
    // end;

    procedure CheckLeaveRequestWorkflowEnabled(var LeaveRequest: Record "Leave Application"): Boolean
    begin
        if not IsLeaveRequestWorkflowEnabled(LeaveRequest) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsLeaveRequestWorkflowEnabled(var LeaveRequest: Record "Leave Application"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(LeaveRequest, WorkflowEventHandling.RunworkflowOnSendLeaveApplicationforApprovalCode()));
    end;


    procedure CheckLeaveRecallWorkflowEnabled(var LeaveRecall: Record "Employee Off/Holiday"): Boolean
    begin
        if not IsLeaveRecallWorkflowEnabled(LeaveRecall) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsLeaveRecallWorkflowEnabled(var LeaveRecall: Record "Employee Off/Holiday"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(LeaveRecall, WorkflowEventHandling.RunworkflowOnSendLeaveRecallRequestforApprovalCode()));
    end;


    procedure CheckEmpActingAndPromotionWorkflowEnabled(var EmpActing: Record "Employee Acting Position"): Boolean
    begin
        if not IsEmpActingAndPromotionWorkflowEnabled(EmpActing) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsEmpActingAndPromotionWorkflowEnabled(var EmpActing: Record "Employee Acting Position"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(EmpActing, WorkflowEventHandling.RunWorkflowOnSendEmpActingPromotionForApprovalCode()));
    end;
    //leave adjustment approval

    procedure CheckLeaveAdjWorkflowEnabled(var LeaveAdj: Record "Leave Bal Adjustment Header"): Boolean
    begin
        if not IsLeaveAdjWorkflowEnabled(LeaveAdj) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsLeaveAdjWorkflowEnabled(var LeaveAdj: Record "Leave Bal Adjustment Header"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(LeaveAdj, WorkflowEventHandling.RunWorkflowOnSendLeaveAdjForApprovalCode()));
    end;



    // New Employee Approval
    procedure CheckNewEmployeeWorkflowEnabled(var Emp: Record Employee): Boolean
    begin
        if not IsNewEmployeeWorkflowEnabled(Emp) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsNewEmployeeWorkflowEnabled(var Emp: Record Employee): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(Emp, WorkflowEventHandling.RunworkflowOnSendNewEmployeeforApprovalCode()));
    end;


    // [IntegrationEvent(false, false)]
    // procedure OnSendTransportApprovalRequest(var TransportReq: Record "Travel Requests")
    // begin

    // end;

    // [IntegrationEvent(false, false)]
    // procedure OnCancelTransportApprovalRequest(var TransportReq: Record "Travel Requests")
    // begin

    // end;

    [IntegrationEvent(false, false)]
    procedure OnSendLeaveRequestApproval(var LeaveRequest: Record "Leave Application")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelLeaveRequestApproval(var LeaveRequest: Record "Leave Application")
    begin

    end;

    // [IntegrationEvent(false, false)]
    // procedure OnSendRecruitmentApprovalRequest(var RecruitmentRequest: Record "Recruitment Needs")
    // begin

    // end;

    // [IntegrationEvent(false, false)]
    // procedure OnCancelRecruitmentApprovalRequest(var RecruitmentRequest: Record "Recruitment Needs")
    // begin

    // end;

    // [IntegrationEvent(false, false)]
    // procedure OnSendTrainingRequestforApproval(var TrainingReq: Record "Training Request")
    // begin

    // end;

    // [IntegrationEvent(false, false)]
    // procedure OnCancelTrainingRequestApproval(var TrainingReq: Record "Training Request")
    // begin

    // end;

    // [IntegrationEvent(false, false)]
    // procedure OnSendEmployeeAppraisalRequestforApproval(var EmployeeAppraisal: Record "Employee Appraisal")
    // begin

    // end;

    // [IntegrationEvent(false, false)]
    // procedure OnCancelEmployeeAppraisalApprovalRequest(var EmployeeAppraisal: Record "Employee Appraisal")
    // begin

    // end;

    [IntegrationEvent(false, false)]
    procedure OnSendLeaveRecallRequestforApproval(var LeaveRecall: Record "Employee Off/Holiday")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelLeaveRecallApprovalRequest(var LeaveRecall: Record "Employee Off/Holiday")
    begin

    end;

    // [IntegrationEvent(false, false)]
    // procedure OnSendEmployeeTransfersRequestforApproval(var EmployeeTransfers: Record "Employee Transfers")
    // begin

    // end;

    // [IntegrationEvent(false, false)]
    // procedure OnCancelEmployeeTransfersApprovalRequest(var EmployeeTransfers: Record "Employee Transfers")
    // begin

    // end;

    // [IntegrationEvent(false, false)]
    // procedure OnSendPayrollChangeforApproval(var "Payroll Change": Record "Payroll Change Header")
    // begin

    // end;

    // [IntegrationEvent(false, false)]
    // procedure OnCancelPayrollChangeApproval(var "Payroll Change": Record "Payroll Change Header")
    // begin

    //  end;

    // [IntegrationEvent(false, false)]
    // procedure OnSendLoanApplicationRequestforApproval(var LoanApplication: Record "Payroll Loan Application")
    // begin

    // end;

    // [IntegrationEvent(false, false)]
    // procedure OnCancelLoanApplicationRequestApproval(var LoanApplication: Record "Payroll Loan Application")
    // begin

    // end;

    [IntegrationEvent(false, false)]
    procedure OnSendEmpActingAndPromotionRequestForApproval(var EmpActing: Record "Employee Acting Position")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelEmpActingAndPromotionRequestApproval(var EmpActing: Record "Employee Acting Position")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnSendLeaveAdjApproval(var LeaveAdj: Record "Leave Bal Adjustment Header")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelLeaveAdjApproval(var LeaveAdj: Record "Leave Bal Adjustment Header")
    begin

    end;

    // [IntegrationEvent(false, false)]
    // procedure OnSendNewEmpAppraisalRequestforApproval(var NewEmployeeAppraisal: Record "Employee Appraisal")
    // begin
    // end;

    // [IntegrationEvent(false, false)]
    // procedure OnCancelNewEmpAppraisalRequestApproval(var NewEmployeeAppraisal: Record "Employee Appraisal")
    // begin
    // end;

    // [IntegrationEvent(false, false)]
    // procedure OnSendPayrollApprovalRequest(var PayApproval: Record "Payroll Approval")
    // begin

    // end;

    // [IntegrationEvent(false, false)]
    // procedure OnCancelPayrollApprovalRequest(var PayApproval: Record "Payroll Approval")
    // begin

    // end;

    // [IntegrationEvent(false, false)]
    // procedure OnSendPayrollRequestForApproval(var PayrollRequest: Record "Payroll Requests")
    // begin

    // end;

    // [IntegrationEvent(false, false)]
    // procedure OnCancelPayrollRequestApprovalRequest(var PayrollRequest: Record "Payroll Requests")
    // begin

    // end;

    // [IntegrationEvent(false, false)]
    // procedure OnSendAllowanceRegisterForApproval(var AllowanceRegister: Record "Allowance Register")
    // begin

    // end;

    // [IntegrationEvent(false, false)]
    // procedure OnCancelAllowanceRegisterRequest(var AllowanceRegister: Record "Allowance Register")
    // begin

    // end;
    // New Employee Approval
    [IntegrationEvent(false, false)]
    procedure OnSendNewEmployeeApprovalRequest(var Emp: Record Employee)
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelNewEmployeeApprovalRequest(var Emp: Record Employee)
    begin

    end;
}





