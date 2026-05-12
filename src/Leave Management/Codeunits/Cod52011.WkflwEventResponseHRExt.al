codeunit 52011 "Wkflw Event Response HR Ext"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsePredecessorsToLibrary', '', false, false)]
    local procedure OnAddWorkflowResponsePredecessorsToLibrary(ResponseFunctionName: Code[128])
    var
        WorkflowEventHandling: Codeunit "Wkfl Event Handle HR Ext";
        WorkFlowResponse: Codeunit "Workflow Response Handling";
    begin
        case ResponseFunctionName of
            WorkFlowResponse.SetStatusToPendingApprovalCode():
                begin
                    //Leave Application
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode(), WorkflowEventHandling.RunworkflowOnSendLeaveApplicationforApprovalCode());
                    //Recruitment
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode(), WorkflowEventHandling.RunworkflowOnSendRecruitmentRequestforApprovalCode());
                    //Training Request
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode(), WorkflowEventHandling.RunworkflowOnSendTrainingRequestforApprovalCode());
                    //Transport Request
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode(), WorkflowEventHandling.RunWorkflowOnSendTransportForApprovalCode());
                    //Employee Appraisal
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode(), WorkflowEventHandling.RunworkflowOnSendEmployeeAppraisalRequestforApprovalCode());
                    //Leave Recall
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode(), WorkflowEventHandling.RunworkflowOnSendLeaveRecallRequestforApprovalCode());
                    //Employee Transfers
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode(), WorkflowEventHandling.RunworkflowOnSendEmployeeTransferRequestforApprovalCode());
                    //Loan Application
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode(), WorkflowEventHandling.RunworkflowOnSendLoanApplicationforApprovalCode());
                    //Emp Acting and Promotion
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode(), WorkflowEventHandling.RunWorkflowOnSendEmpActingPromotionForApprovalCode());
                    //Leave Adj
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode(), WorkflowEventHandling.RunWorkflowOnSendLeaveAdjForApprovalCode());
                    //New Emp appraisal
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode(), WorkflowEventHandling.RunworkflowOnSendNewEmpAppraisalforApprovalCode());
                    //Payroll Approval
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode(), WorkflowEventHandling.RunworkflowOnSendPayrollApprovalforApprovalCode());
                    //Payroll Request
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode(), WorkflowEventHandling.RunworkflowOnSendPayrollRequestforApprovalCode());
                    //Allowance Register
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode(), WorkflowEventHandling.RunworkflowOnSendAllowanceRegisterforApprovalCode());
                    // New Employee
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode(), WorkflowEventHandling.RunWorkflowOnSendNewEmployeeForApprovalCode());
                end;
            WorkFlowResponse.CreateApprovalRequestsCode():
                begin
                    //Leave Application
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode(), WorkflowEventHandling.RunworkflowOnSendLeaveApplicationforApprovalCode());
                    //Recruitment
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode(), WorkflowEventHandling.RunworkflowOnSendRecruitmentRequestforApprovalCode());
                    //Training Request
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode(), WorkflowEventHandling.RunworkflowOnSendTrainingRequestforApprovalCode());
                    //Transport Request
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode(), WorkflowEventHandling.RunWorkflowOnSendTransportForApprovalCode());
                    //Employee Appraisal
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode(), WorkflowEventHandling.RunworkflowOnSendEmployeeAppraisalRequestforApprovalCode());
                    //Leave Recall
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode(), WorkflowEventHandling.RunworkflowOnSendLeaveRecallRequestforApprovalCode());
                    //Employee Transfers
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode(), WorkflowEventHandling.RunworkflowOnSendEmployeeTransferRequestforApprovalCode());
                    //Loan Application
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode(), WorkflowEventHandling.RunworkflowOnSendLoanApplicationforApprovalCode());
                    //Employee Acting Promotion
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode(), WorkflowEventHandling.RunWorkflowOnSendEmpActingPromotionForApprovalCode());
                    //Leave Adj
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode(), WorkflowEventHandling.RunWorkflowOnSendLeaveAdjForApprovalCode());
                    //New emp appraisal
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode(), WorkflowEventHandling.RunworkflowOnSendNewEmpAppraisalforApprovalCode());
                    //Payroll Approval
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode(), WorkflowEventHandling.RunworkflowOnSendPayrollApprovalforApprovalCode());
                    //Payroll Request
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode(), WorkflowEventHandling.RunworkflowOnSendPayrollRequestforApprovalCode());
                    //Allowance Register
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode(), WorkflowEventHandling.RunworkflowOnSendAllowanceRegisterforApprovalCode());
                    //New Employee
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode(), WorkflowEventHandling.RunWorkflowOnSendNewEmployeeForApprovalCode());
                end;
            WorkFlowResponse.SendApprovalRequestForApprovalCode():
                begin
                    //Leave Application
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode(), WorkflowEventHandling.RunworkflowOnSendLeaveApplicationforApprovalCode());
                    //Recruitment
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode(), WorkflowEventHandling.RunworkflowOnSendRecruitmentRequestforApprovalCode());
                    //Training Request
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode(), WorkflowEventHandling.RunworkflowOnSendTrainingRequestforApprovalCode());
                    //Transport Request
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode(), WorkflowEventHandling.RunWorkflowOnSendTransportForApprovalCode());
                    //Employee Appraisal
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode(), WorkflowEventHandling.RunworkflowOnSendEmployeeAppraisalRequestforApprovalCode());
                    //Leave Recall
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode(), WorkflowEventHandling.RunworkflowOnSendLeaveRecallRequestforApprovalCode());
                    //Employee Transfers
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode(), WorkflowEventHandling.RunworkflowOnSendEmployeeTransferRequestforApprovalCode());
                    //Loan Application
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode(), WorkflowEventHandling.RunworkflowOnSendLoanApplicationforApprovalCode());
                    //Emp Acting and Promotion
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode(), WorkflowEventHandling.RunWorkflowOnSendEmpActingPromotionForApprovalCode());
                    //Leave Adj
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode(), WorkflowEventHandling.RunWorkflowOnSendLeaveAdjForApprovalCode());
                    //New emp appraisal
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode(), WorkflowEventHandling.RunworkflowOnSendNewEmpAppraisalforApprovalCode());
                    //Payroll Approval
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode(), WorkflowEventHandling.RunworkflowOnSendPayrollApprovalforApprovalCode());
                    //Payroll Request
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode(), WorkflowEventHandling.RunworkflowOnSendPayrollRequestforApprovalCode());
                    //Allowance Register
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode(), WorkflowEventHandling.RunworkflowOnSendAllowanceRegisterforApprovalCode());
                    // New Employee
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode(), WorkflowEventHandling.RunWorkflowOnSendNewEmployeeForApprovalCode());
                end;
            WorkFlowResponse.OpenDocumentCode():
                begin
                    //Leave Application
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode(), WorkflowEventHandling.RunworkflowOnCancelLeaveApplicationApprovalRequestCode());
                    //Recruitment
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode(), WorkflowEventHandling.RunworkflowOnCancelRecruitmentRequestApprovalCode());
                    //Training Request
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode(), WorkflowEventHandling.RunworkflowOnCancelTrainingRequestApprovalRequestCode());
                    //Transport Request
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode(), WorkflowEventHandling.RunWorkflowOnCancelTransportApprovalRequestCode());
                    //Employee Appraisal
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode(), WorkflowEventHandling.RunworkflowOnCancelEmployeeAppraisalRequestApprovalRequestCode());
                    //Leave Recall
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode(), WorkflowEventHandling.RunworkflowOnCancelLeaveRecallApprovalRequestCode());
                    //Employee Transfers
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode(), WorkflowEventHandling.RunworkflowOnCancelEmployeeTransferApprovalRequestCode());
                    //Loan Application
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode(), WorkflowEventHandling.RunworkflowOnCancelLoanApplicationApprovalRequestCode());
                    //Employee Acting and Promotion
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode(), WorkflowEventHandling.RunWorkflowOnRejectEmpActingPromotionCode());
                    //Leave Adj
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode(), WorkflowEventHandling.RunWorkflowOnCancelLeaveAdjForApprovalCode());
                    //New emp appraisal
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode(), WorkflowEventHandling.RunworkflowOnCancelNewEmpAppraisalApprovalRequestCode());
                    //Payroll Approval
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode(), WorkflowEventHandling.RunworkflowOnCancelPayrollApprovalRequestCode());
                    //Payroll Request
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode(), WorkflowEventHandling.RunworkflowOnCancelPayrollRequestApprovalRequestCode());
                    //Allowance Register
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode(), WorkflowEventHandling.RunworkflowOnCancelAllowanceRegisterApprovalRequestCode());
                    // New Employee
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode(), WorkflowEventHandling.RunWorkflowOnCancelNewEmployeeApprovalRequestCode());
                end;
            WorkFlowResponse.CancelAllApprovalRequestsCode():
                begin
                    //Leave Application
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode(), WorkflowEventHandling.RunworkflowOnCancelLeaveApplicationApprovalRequestCode());
                    //Recruitment
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode(), WorkflowEventHandling.RunworkflowOnCancelRecruitmentRequestApprovalCode());
                    //Training Request
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode(), WorkflowEventHandling.RunworkflowOnCancelTrainingRequestApprovalRequestCode());
                    //Transport Request
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode(), WorkflowEventHandling.RunWorkflowOnCancelTransportApprovalRequestCode());
                    //Employee Appraisal
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode(), WorkflowEventHandling.RunworkflowOnCancelEmployeeAppraisalRequestApprovalRequestCode());
                    //Leave Recall
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode(), WorkflowEventHandling.RunworkflowOnCancelLeaveRecallApprovalRequestCode());
                    //Employee Transfers
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode(), WorkflowEventHandling.RunworkflowOnCancelEmployeeTransferApprovalRequestCode());
                    //Loan Application
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode(), WorkflowEventHandling.RunworkflowOnCancelLoanApplicationApprovalRequestCode());
                    //Employee Acting and Promotion
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode(), WorkflowEventHandling.RunWorkflowOnCancelEmpActingPromotionApprovalRequestCode());
                    //Leave Adj
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode(), WorkflowEventHandling.RunWorkflowOnCancelLeaveAdjForApprovalCode());
                    //New emp appraisal
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode(), WorkflowEventHandling.RunworkflowOnCancelNewEmpAppraisalApprovalRequestCode());
                    //Payroll Approval
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode(), WorkflowEventHandling.RunworkflowOnCancelPayrollApprovalRequestCode());
                    //Payroll Request
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode(), WorkflowEventHandling.RunworkflowOnCancelPayrollRequestApprovalRequestCode());
                    //Allowance Register
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode(), WorkflowEventHandling.RunworkflowOnCancelAllowanceRegisterApprovalRequestCode());
                    // New Employee
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode(), WorkflowEventHandling.RunWorkflowOnCancelNewEmployeeApprovalRequestCode());
                end;
            WorkFlowResponse.ReleaseDocumentCode():
                begin
                    //Leave Application
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.ReleaseDocumentCode(), WorkflowEventHandling.RunWorkfowOnAfterReleaseLeaveApplicationCode());
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', false, false)]
    local procedure OnReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        LRecall: Record "Employee Off/Holiday";
        LeaveApp: Record "Leave Application";
        LAdj: Record "Leave Bal Adjustment Header";
        WorkflowResponses: Codeunit "Workflow Responses HR";
        Emp: Record "Employee";
        EActingPosition: Record "Employee Acting Position";
        VarVariant: Variant;
    begin
        VarVariant := RecRef;
        case RecRef.Number of
            //Leave Application
            Database::"Leave Application":
                begin
                    LeaveApp.SetView(RecRef.GetView());
                    Handled := true;
                    WorkflowResponses.ReleaseLeave(VarVariant);
                end;


            //Leave Recall
            Database::"Employee Off/Holiday":
                begin
                    LRecall.SetView(RecRef.GetView());
                    Handled := true;
                    WorkflowResponses.ReleaseLeaveRecallRequest(VarVariant);
                end;

            //Emp acting and Promotion
            Database::"Employee Acting Position":
                begin
                    EActingPosition.SetView(RecRef.GetView());
                    Handled := true;
                    WorkflowResponses.ReleaseEmpActingPromotion(VarVariant);
                end;
            //Leave Adj
            Database::"Leave Bal Adjustment Header":
                begin
                    LAdj.SetView(RecRef.GetView());
                    Handled := true;
                    WorkflowResponses.ReleaseLeaveAdj(VarVariant);
                end;


            // New Employee
            Database::"Employee":
                begin
                    Emp.SetView(RecRef.GetView());
                    Handled := true;
                    //WorkflowResponses.ReleaseNewEmployeeApplication(VarVariant);
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnOpenDocument', '', false, false)]
    local procedure OnOpenDocument(RecRef: RecordRef; var Handled: Boolean)
    var

        EActingPosition: Record "Employee Acting Position";
        LRecall: Record "Employee Off/Holiday";
        LeaveApp: Record "Leave Application";
        LAdj: Record "Leave Bal Adjustment Header";

        Emp: Record "Employee";
        WorkflowResponses: Codeunit "Workflow Responses HR";
        VarVariant: Variant;
    begin
        VarVariant := RecRef;

        case RecRef.Number of
            //Leave Application
            Database::"Leave Application":
                begin
                    LeaveApp.SetView(RecRef.GetView());
                    Handled := true;
                    WorkflowResponses.ReopenLeave(VarVariant);
                end;

            //Leave Recall
            Database::"Employee Off/Holiday":
                begin
                    LRecall.SetView(RecRef.GetView());
                    Handled := true;
                    WorkflowResponses.ReopenLeaveRecallRequest(VarVariant);
                end;

            //Emp acting and Promotion
            Database::"Employee Acting Position":
                begin
                    EActingPosition.SetView(RecRef.GetView());
                    Handled := true;
                    WorkflowResponses.ReopenEmpActingPromotion(VarVariant);
                end;
            //Leave Adj
            Database::"Leave Bal Adjustment Header":
                begin
                    LAdj.SetView(RecRef.GetView());
                    Handled := true;
                    WorkflowResponses.ReopenLeaveAdj(VarVariant);
                end;

            // New Employee
            Database::"Employee":
                begin
                    Emp.SetView(RecRef.GetView());
                    Handled := true;
                    //   WorkflowResponses.ReopenNewEmployeeApplication(VarVariant);
                end;
        end;
    end;
}





