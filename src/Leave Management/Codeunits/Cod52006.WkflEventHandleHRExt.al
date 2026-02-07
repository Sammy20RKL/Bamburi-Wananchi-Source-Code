codeunit 52006 "Wkfl Event Handle HR Ext"
{
    var
        WorkflowEvent: Codeunit "Workflow Event Handling";
        WorkflowManagement: Codeunit "Workflow Management";
        AllowanceRegisterCancelApprovalRequestDescTxt: Label 'An approval request for a Allowance Register is cancelled ';
        AllowanceRegisterSendforApprovalDescTxt: Label 'An approval for a Allowance Register is requested';
        EmpActingPromotionCancelApprovalTxt: Label 'An Approval for Employee acting and promotion is cancelled';
        EmpActingPromotionSendForApprovalTxt: Label 'An Approval for Employee acting and promotion is requested';
        EmployeeAppraisalCancelApprovalRequestDescTxt: Label 'An approval request for Employee Appraisal is cancelled';
        EmployeeAppraisalRequestSendforApprovalDescTxt: Label 'An approval request for Employee Appraisal is requested';
        LeaveAdjCancelApprovalTxt: Label 'An approval request for Leave Adjustment is cancelled';
        LeaveAdjSendApprovalTxt: Label 'An approval request for Leave Adjustment is requested';
        LeaveRecallApprovalRequestDescTxt: Label 'An approval for Leave Recall is requested';
        LeaveRecallCancelApprovalRequestDescTxt: Label 'An approval request for Leave Recall is cancelled';
        LeaveRequestCancelApprovalRequestDescTxt: Label 'An approval for Leave Application is cancelled ';
        LeaveRequestSendforApprovalDescTxt: Label 'An approval for Leave Application is requested';
        NewEmpAppraisalApprovalDescTxt: Label 'An approval for a new Employee Appraisal Request is requested ';
        NewEmpAppraisalCancelApprovalDescTxt: Label 'An approval for a new Employee Appraisal Request is cancelled';
        PayrollApprovalSendForApprovalEventDescTxt: Label 'Approval for a Payroll Approval is requested';
        PayrollApprReqCancelledEventDescTxt: Label 'An approval request for a Payroll Approval has been canceled.';
        PayrollChangeCancelApprovalRequestDescTxt: Label 'An approval for Payroll Change is cancelled ';
        PayrollChangeRequestforApprovalDescTxt: Label 'An approval for Payroll Change is requested ';
        PayrollLoanApplicationApprovalDescTxt: Label 'An approval for Payroll Loan Application is requested ';
        PayrollLoanApplicationCancelApprovalDescTxt: Label 'An approval for Payroll Loan application is cancelled';
        PayrollRequestCancelApprovalRequestDescTxt: Label 'An approval request for Payroll Request is cancelled ';
        PayrollRequestSendforApprovalDescTxt: Label 'An approval for Payroll Request is requested';
        RecruitmentRequestCancelApprovalRequestDescTxt: Label 'An approval request for Recruitment is cancelled';
        RecruitmentRequestSendforApprovalDescTxt: Label 'An approval for Recruitment is requested';
        TrainingRequestCancelApprovalRequestDescTxt: Label 'An approval request for Training Request is cancelled ';
        TrainingRequestSendforApprovalDescTxt: Label 'An approval request for Training is requested';
        TransportRequestCancelApprovalRequestDescTxt: Label 'An approval request for Transport Request is cancelled ';
        TransportRequestSendforApprovalDescTxt: Label 'An approval for Transport Request is requested';
        NewEmployeeSendforApprovalDescTxt: Label 'An approval for a new Employee is requested';
        NewEmployeeCancelApprovalRequestDescTxt: Label 'An approval request for a new Employee has been cancelled';




    procedure RunWorkflowOnSendTransportForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendTransportForApproval'));
    end;

    procedure RunWorkflowOnCancelTransportApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelTransportApprovalRequest'));
    end;

    procedure RunworkflowOnSendLeaveApplicationforApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunworkflowOnSendLeaveApplicationforApproval'));
    end;

    procedure RunworkflowOnCancelLeaveApplicationApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunworkflowOnCancelLeaveApplicationApprovalRequest'));
    end;

    procedure RunWorkfowOnAfterReleaseLeaveApplicationCode(): Code[128]
    begin
        exit(UpperCase('RunWorkfowOnAfterReleaseLeaveApplication'));
    end;

    procedure RunworkflowOnSendRecruitmentRequestforApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunworkflowOnSendRecruitmentRequestforApprovalCode'));
    end;

    procedure RunworkflowOnCancelRecruitmentRequestApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunworkflowOnCancelRecruitmentRequestApprovalCode'));
    end;

    procedure RunworkflowOnSendTrainingRequestforApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunworkflowOnSendTrainingRequestforApproval'));
    end;

    procedure RunworkflowOnCancelTrainingRequestApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunworkflowOnCancelTrainingRequestApprovalRequest'));
    end;

    procedure RunworkflowOnSendEmployeeAppraisalRequestforApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunworkflowOnSendEmployeeAppraisalRequestforApproval'));
    end;

    procedure RunworkflowOnCancelEmployeeAppraisalRequestApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunworkflowOnCancelEmployeeAppraisalApprovalRequest'));
    end;

    procedure RunworkflowOnSendLeaveRecallRequestforApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunworkflowOnSendLeaveRecallRequestforApproval'));
    end;

    procedure RunworkflowOnCancelLeaveRecallApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunworkflowOnCancelLeaveRecallApprovalRequest'));
    end;

    procedure RunworkflowOnSendEmployeeTransferRequestforApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunworkflowOnSendEmployeeAppraisalRequestforApproval'));
    end;

    procedure RunworkflowOnCancelEmployeeTransferApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunworkflowOnCancelEmployeeAppraisalApprovalRequest'));
    end;

    procedure RunworkflowOnSendPayrollChangeRequestforApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunworkflowOnSendPayrollChangeRequestforApproval'));
    end;

    procedure RunworkflowOnCancelPayrollChangeApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunworkflowOnCancelPayrollChangeApprovalRequest'));
    end;

    procedure RunworkflowOnSendLoanApplicationforApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunworkflowOnSendLoanApplicationforApproval'));
    end;

    procedure RunworkflowOnCancelLoanApplicationApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunworkflowOnCancelLoanApplicationApprovalRequest'));
    end;

    procedure RunWorkflowOnSendEmpActingPromotionForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendEmpActingPromotionForApproval'));
    end;

    procedure RunWorkflowOnCancelEmpActingPromotionApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelEmpActingPromotionApprovalRequest'));
    end;

    procedure RunWorkflowOnRejectEmpActingPromotionCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnRejectEmpActingPromotionApprovalRequest'));
    end;

    procedure RunWorkflowOnSendLeaveAdjForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendLeaveAdjForApproval'));
    end;

    procedure RunWorkflowOnCancelLeaveAdjForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelLeaveAdjForApproval'));
    end;

    procedure RunworkflowOnSendNewEmpAppraisalforApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunworkflowOnSendNewEmpAppraisalforApproval'));
    end;

    procedure RunworkflowOnCancelNewEmpAppraisalApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunworkflowOnCancelNewEmpAppraisalApprovalRequest'));
    end;

    procedure RunWorkflowOnSendPayrollApprovalForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendPayrollApprovalForApproval'));
    end;

    procedure RunWorkflowOnCancelPayrollApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelPayrollApprovalRequest'));
    end;

    procedure RunWorkflowOnSendPayrollRequestForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendPayrollRequestForApproval'));
    end;

    procedure RunWorkflowOnCancelPayrollRequestApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelPayrollRequestApprovalRequest'));
    end;

    procedure RunWorkflowOnSendAllowanceRegisterForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendAllowanceRegisterForApproval'));
    end;

    procedure RunWorkflowOnCancelAllowanceRegisterApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelAllowanceRegisterApprovalRequest'));
    end;
    // New Employee
    procedure RunWorkflowOnSendNewEmployeeForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendNewEmployeeForApproval'));
    end;

    procedure RunWorkflowOnCancelNewEmployeeApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelNewEmployeeApprovalRequest'));
    end;



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    local procedure OnAddWorkflowEventsToLibrary()
    begin
        //Leave Application
        WorkflowEvent.AddEventToLibrary(RunworkflowOnSendLeaveApplicationforApprovalCode(), Database::"Leave Application",
        LeaveRequestSendforApprovalDescTxt, 0, false);
        WorkflowEvent.AddEventToLibrary(RunworkflowOnCancelLeaveApplicationApprovalRequestCode(), Database::"Leave Application",
        LeaveRequestCancelApprovalRequestDescTxt, 0, false);

        //Leave Recall
        WorkflowEvent.AddEventToLibrary(RunworkflowOnSendLeaveRecallRequestforApprovalCode(), Database::"Employee Off/Holiday",
        LeaveRecallApprovalRequestDescTxt, 0, false);
        WorkflowEvent.AddEventToLibrary(RunworkflowOnCancelLeaveRecallApprovalRequestCode(), Database::"Employee Off/Holiday",
        LeaveRecallCancelApprovalRequestDescTxt, 0, false);

        //EmpActing and Promotion
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnCancelEmpActingPromotionApprovalRequestCode(), Database::"Employee Acting Position",
        EmpActingPromotionCancelApprovalTxt, 0, false);
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnSendEmpActingPromotionForApprovalCode(), Database::"Employee Acting Position",
        EmpActingPromotionSendForApprovalTxt, 0, false);
        //Leave Adj
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnSendLeaveAdjForApprovalCode(), Database::"Leave Bal Adjustment Header",
        LeaveAdjSendApprovalTxt, 0, false);
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnCancelLeaveAdjForApprovalCode(), Database::"Leave Bal Adjustment Header",
        LeaveAdjCancelApprovalTxt, 0, false);

        // New Employee
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnSendNewEmployeeForApprovalCode(), Database::"Employee",
        NewEmployeeSendforApprovalDescTxt, 0, false);
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnCancelNewEmployeeApprovalRequestCode(), Database::"Employee",
        NewEmployeeCancelApprovalRequestDescTxt, 0, false);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventPredecessorsToLibrary', '', false, false)]
    local procedure OnAddWorkflowEventPredecessorsToLibrary(EventFunctionName: Code[128])
    var
        WorkflowEvent: Codeunit "Workflow Event Handling";
    begin
        case EventFunctionName of
            //Leave Application
            RunworkflowOnCancelLeaveApplicationApprovalRequestCode():
                WorkflowEvent.AddEventPredecessor(RunworkflowOnCancelLeaveApplicationApprovalRequestCode(), RunworkflowOnSendLeaveApplicationforApprovalCode());
            //Recruitment
            RunworkflowOnCancelRecruitmentRequestApprovalCode():
                WorkflowEvent.AddEventPredecessor(RunworkflowOnCancelRecruitmentRequestApprovalCode(), RunworkflowOnSendRecruitmentRequestforApprovalCode());
            //Training Request
            RunworkflowOnCancelTrainingRequestApprovalRequestCode():
                WorkflowEvent.AddEventPredecessor(RunworkflowOnCancelTrainingRequestApprovalRequestCode(), RunworkflowOnSendTrainingRequestforApprovalCode());
            //Transport Requests
            RunWorkflowOnCancelTransportApprovalRequestCode():
                WorkflowEvent.AddEventPredecessor(RunWorkflowOnCancelTransportApprovalRequestCode(), RunWorkflowOnSendTransportForApprovalCode());
            //Leave Recall
            RunworkflowOnCancelLeaveRecallApprovalRequestCode():
                WorkflowEvent.AddEventPredecessor(RunworkflowOnCancelLeaveRecallApprovalRequestCode(), RunworkflowOnSendLeaveRecallRequestforApprovalCode());
            //Payroll Change
            RunworkflowOnCancelPayrollChangeApprovalRequestCode():
                WorkflowEvent.AddEventPredecessor(RunworkflowOnCancelPayrollChangeApprovalRequestCode(), RunworkflowOnSendPayrollChangeRequestforApprovalCode());
            //Loan Application
            RunworkflowOnCancelLoanApplicationApprovalRequestCode():
                WorkflowEvent.AddEventPredecessor(RunworkflowOnCancelLoanApplicationApprovalRequestCode(), RunworkflowOnSendLoanApplicationforApprovalCode());
            //Emp acting and Promotion
            RunWorkflowOnCancelEmpActingPromotionApprovalRequestCode():
                WorkflowEvent.AddEventPredecessor(RunWorkflowOnCancelEmpActingPromotionApprovalRequestCode(), RunWorkflowOnSendEmpActingPromotionForApprovalCode());
            //Leave Adj
            RunWorkflowOnSendLeaveAdjForApprovalCode():
                WorkflowEvent.AddEventPredecessor(RunWorkflowOnCancelLeaveAdjForApprovalCode(), RunWorkflowOnSendLeaveAdjForApprovalCode());
            //New Emp Appraisal
            RunworkflowOnCancelNewEmpAppraisalApprovalRequestCode():
                WorkflowEvent.AddEventPredecessor(RunworkflowOnCancelNewEmpAppraisalApprovalRequestCode(), RunworkflowOnSendNewEmpAppraisalforApprovalCode());
            //Payroll Approval
            RunworkflowOnCancelPayrollApprovalRequestCode():
                WorkflowEvent.AddEventPredecessor(RunworkflowOnCancelPayrollApprovalRequestCode(), RunworkflowOnSendPayrollApprovalforApprovalCode());
            //Payroll Request
            RunworkflowOnCancelPayrollRequestApprovalRequestCode():
                WorkflowEvent.AddEventPredecessor(RunworkflowOnCancelPayrollRequestApprovalRequestCode(), RunworkflowOnSendPayrollRequestforApprovalCode());
            //Allowance Register
            RunworkflowOnCancelAllowanceRegisterApprovalRequestCode():
                WorkflowEvent.AddEventPredecessor(RunworkflowOnCancelAllowanceRegisterApprovalRequestCode(), RunworkflowOnSendAllowanceRegisterforApprovalCode());
            // New Employee
            RunWorkflowOnCancelNewEmployeeApprovalRequestCode():
                WorkflowEvent.AddEventPredecessor(RunWorkflowOnCancelNewEmployeeApprovalRequestCode(), RunWorkflowOnSendNewEmployeeForApprovalCode());


            WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode():
                begin
                    //Leave Application
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode(), RunworkflowOnSendLeaveApplicationforApprovalCode());
                    //Recruitment
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode(), RunworkflowOnSendRecruitmentRequestforApprovalCode());
                    //Training Request
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode(), RunworkflowOnSendTrainingRequestforApprovalCode());
                    //Transport Request
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode(), RunWorkflowOnSendTransportForApprovalCode());
                    //Leave Recall
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode(), RunworkflowOnSendLeaveRecallRequestforApprovalCode());
                    //Payroll Change
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode(), RunworkflowOnSendPayrollChangeRequestforApprovalCode());
                    //Loan application
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode(), RunworkflowOnSendLoanApplicationforApprovalCode());
                    //Emp acting and Promotion
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode(), RunWorkflowOnSendEmpActingPromotionForApprovalCode());
                    //Leave Adj
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode(), RunWorkflowOnSendLeaveAdjForApprovalCode());
                    //New Emp Appraisal
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode(), RunworkflowOnSendNewEmpAppraisalforApprovalCode());
                    //Payroll Approval
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode(), RunworkflowOnSendPayrollApprovalforApprovalCode());
                    //Payroll Request
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode(), RunworkflowOnSendPayrollRequestforApprovalCode());
                    //Allowance Register
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode(), RunworkflowOnSendAllowanceRegisterforApprovalCode());
                    // New Employee
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode(), RunWorkflowOnSendNewEmployeeForApprovalCode());
                end;

            WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode():
                begin
                    //Leave Application
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode(), RunworkflowOnSendLeaveApplicationforApprovalCode());
                    //Recruitment
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode(), RunworkflowOnSendRecruitmentRequestforApprovalCode());
                    //Training Request
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode(), RunworkflowOnSendTrainingRequestforApprovalCode());
                    //Transport Request
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode(), RunWorkflowOnSendTransportForApprovalCode());
                    //Leave Recall
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode(), RunworkflowOnSendLeaveRecallRequestforApprovalCode());
                    //Payroll Change
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode(), RunworkflowOnSendPayrollChangeRequestforApprovalCode());
                    //Loan Application
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode(), RunworkflowOnSendLoanApplicationforApprovalCode());
                    //Emp acting and Promotion
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode(), RunWorkflowOnSendEmpActingPromotionForApprovalCode());
                    //Leave Adj
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode(), RunWorkflowOnSendLeaveAdjForApprovalCode());
                    //New Emp Appraisal
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode(), RunworkflowOnSendNewEmpAppraisalforApprovalCode());
                    //Payroll Approval
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode(), RunworkflowOnSendPayrollApprovalforApprovalCode());
                    //Payroll Request
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode(), RunworkflowOnSendPayrollRequestforApprovalCode());
                    //Allowance Register
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode(), RunworkflowOnSendAllowanceRegisterforApprovalCode());
                    // New Employee
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode(), RunWorkflowOnSendNewEmployeeForApprovalCode());
                end;
            WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode():
                begin
                    //Leave Application
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode(), RunworkflowOnSendLeaveApplicationforApprovalCode());
                    //Recruitment
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode(), RunworkflowOnSendRecruitmentRequestforApprovalCode());
                    //Training Request
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode(), RunworkflowOnSendTrainingRequestforApprovalCode());
                    //Transport Request
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode(), RunWorkflowOnSendTransportForApprovalCode());
                    //Leave Recall
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode(), RunworkflowOnSendLeaveRecallRequestforApprovalCode());
                    //Payroll Change
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode(), RunworkflowOnSendPayrollChangeRequestforApprovalCode());
                    //Loan Application
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode(), RunworkflowOnSendLoanApplicationforApprovalCode());
                    //Emp acting and Promotion
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode(), RunWorkflowOnSendEmpActingPromotionForApprovalCode());
                    //Leave Adj
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode(), RunWorkflowOnSendLeaveAdjForApprovalCode());
                    //New Emp Appraisal
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode(), RunworkflowOnSendNewEmpAppraisalforApprovalCode());
                    //Payroll Approval
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode(), RunworkflowOnSendPayrollApprovalforApprovalCode());
                    //Payroll Request
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode(), RunworkflowOnSendPayrollRequestforApprovalCode());
                    //Allowance Register
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode(), RunworkflowOnSendAllowanceRegisterforApprovalCode());
                    // New Employee
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode(), RunWorkflowOnSendNewEmployeeForApprovalCode());
                end;
        end;
    end;
    // Leave Application

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgt HR Ext", 'OnSendLeaveRequestApproval', '', false, false)]
    local procedure RunworkflowOnSendLeaveApplicationforApproval(var LeaveRequest: Record "Leave Application")
    begin
        WorkflowManagement.HandleEvent(RunworkflowOnSendLeaveApplicationforApprovalCode(), LeaveRequest);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgt HR Ext", 'OnCancelLeaveRequestApproval', '', false, false)]
    local procedure RunworkflowOnCancelLeaveApplicationApprovalRequest(var LeaveRequest: Record "Leave Application")
    begin
        WorkflowManagement.HandleEvent(RunworkflowOnCancelLeaveApplicationApprovalRequestCode(), LeaveRequest);
    end;

    // Leave Recall
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgt HR Ext", 'OnSendLeaveRecallRequestforApproval', '', false, false)]
    local procedure RunworkflowOnSendLeaveRecallRequestforApproval(var LeaveRecall: Record "Employee Off/Holiday")
    begin
        WorkflowManagement.HandleEvent(RunworkflowOnSendLeaveRecallRequestforApprovalCode(), LeaveRecall);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgt HR Ext", 'OnCancelLeaveRecallApprovalRequest', '', false, false)]
    local procedure RunworkflowOnCancelLeaveRecallApprovalRequest(var LeaveRecall: Record "Employee Off/Holiday")
    begin
        WorkflowManagement.HandleEvent(RunworkflowOnCancelLeaveRecallApprovalRequestCode(), LeaveRecall);
    end;
    //Emp Acting and Promotion


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgt HR Ext", 'OnSendEmpActingAndPromotionRequestForApproval', '', false, false)]
    local procedure RunWorkflowOnSendEmpActingPromotionForApproval(var EmpActing: Record "Employee Acting Position")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendEmpActingPromotionForApprovalCode(), EmpActing);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgt HR Ext", 'OnCancelEmpActingAndPromotionRequestApproval', '', false, false)]
    local procedure RunWorkflowOnCancelEmpActingPromotionApprovalRequest(var EmpActing: Record "Employee Acting Position")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelEmpActingPromotionApprovalRequestCode(), EmpActing);
    end;

    //Leave Adjustment Approvals
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgt HR Ext", 'OnSendLeaveAdjApproval', '', false, false)]
    local procedure RunWorkflowOnSendLeaveAdjForApproval(var LeaveAdj: Record "Leave Bal Adjustment Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendLeaveAdjForApprovalCode(), LeaveAdj);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgt HR Ext", 'OnCancelLeaveAdjApproval', '', false, false)]
    local procedure RunWorkflowOnCancelLeaveAdjForApproval(var LeaveAdj: Record "Leave Bal Adjustment Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelLeaveAdjForApprovalCode(), LeaveAdj);
    end;

    // New Employee
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgt HR Ext", 'OnSendNewEmployeeApprovalRequest', '', false, false)]
    local procedure RunWorkflowOnSendNewEmployeeForApproval(var Emp: Record "Employee")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendNewEmployeeForApprovalCode(), Emp);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgt HR Ext", 'OnCancelNewEmployeeApprovalRequest', '', false, false)]
    local procedure RunWorkflowOnCancelNewEmployeeApprovalRequest(var Emp: Record "Employee")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelNewEmployeeApprovalRequestCode(), Emp);
    end;
}





