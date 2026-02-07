// codeunit 50004 "Custom Workflow Events"
// {

//     trigger OnRun()
//     begin
//         //AddEventsToLib();
//     end;

//     var
//         WFHandler: Codeunit "Workflow Event Handling";
//         WorkflowManagement: Codeunit "Workflow Management";
//         WFEventHandler: Codeunit "Workflow Event Handling";
//         SurestepWFEvents: Codeunit "Custom Workflow Events";
//         WFResponseHandler: Codeunit "Workflow Response Handling";

//     [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowEventsToLibrary', '', false, false)]

//     procedure OnAddWorkflowEventsToLibrary()
//     begin

//         //---------------------------------------------1. Approval Events--------------------------------------------------------------
//         //Membership Application
//         WFHandler.AddEventToLibrary(RunWorkflowOnSendMembershipApplicationForApprovalCode,
//                             Database::"Membership Applications", 'Approval of Membership Application is Requested.', 0, false);
//         WFHandler.AddEventToLibrary(RunWorkflowOnCancelMembershipApplicationApprovalRequestCode,
//                                     Database::"Membership Applications", 'An Approval request for  Membership Application is canceled.', 0, false);
//         //-------------------------------------------End Approval Events-------------------------------------------------------------

//         //--------------------------------------------Membership Re-Application----------------------
//         //Membership RE-Application
//         WFHandler.AddEventToLibrary(RunWorkflowOnSendMemberReapplicationForApprovalCode,
//                             Database::"Member Reapplication", 'Approval of Membership RE-Application is Requested.', 0, false);
//         WFHandler.AddEventToLibrary(RunWorkflowOnCancelMemberReapplicationApprovalRequestCode,
//                                     Database::"Member Reapplication", 'An Approval request for  Re-Membership Application is canceled.', 0, false);
//         //-----Member exit
//         WFHandler.AddEventToLibrary(RunWorkflowOnSendMembershipExitApplicationForApprovalCode,
//         Database::"Membership Exist", 'Approval of Membership Exit is Requested.', 0, false);
//         WFHandler.AddEventToLibrary(RunWorkflowOnCancelMembershipExitApplicationApprovalRequestCode,
//                                     Database::"Membership Exist", 'An Approval request for Exit Application is canceled.', 0, false);
//         //Loans Application
//         WFHandler.AddEventToLibrary(RunWorkflowOnSendLoanApplicationForApprovalCode,
//                             Database::"Loans Register", 'Approval of Loan Application is Requested.', 0, false);
//         WFHandler.AddEventToLibrary(RunWorkflowOnCancelLoanApplicationApprovalRequestCode,
//                                     Database::"Loans Register", 'An Approval request for  Loan Application is canceled.', 0, false);
//         //-------------------------------------------End Approval Events-------------------------------------------------------------
//         //BOSA Transfers
//         WFHandler.AddEventToLibrary(RunWorkflowOnSendBOSATransForApprovalCode,
//                             Database::"BOSA Transfers", 'Approval of Bosa Transfer is Requested.', 0, false);
//         WFHandler.AddEventToLibrary(RunWorkflowOnCancelBOSATransApprovalRequestCode,
//                                     Database::"BOSA Transfers", 'An Approval request for  Bosa Transfer is canceled.', 0, false);
//         //-------------------------------------------End Approval Events-------------------------------------------------------------
//         //Loan Batch Disbursements
//         WFHandler.AddEventToLibrary(RunWorkflowOnSendLoanBatchForApprovalCode,
//                             Database::"Loan Disburesment-Batching", 'Approval of a Loan Batch document is requested.', 0, false);
//         WFHandler.AddEventToLibrary(RunWorkflowOnCancelLoanBatchApprovalRequestCode,
//                                     Database::"Loan Disburesment-Batching", 'An Approval request for a Loan Batch document is canceled.', 0, false);
//         //-------------------------------------------End Approval Events-------------------------------------------------------------
//         //Loans TopUp
//         WFHandler.AddEventToLibrary(RunWorkflowOnSendLoanTopUpForApprovalCode,
//                             Database::"Loan Top Up.", 'Approval of Loan Top Up is Requested.', 0, false);
//         WFHandler.AddEventToLibrary(RunWorkflowOnCancelLoanTopUpApprovalRequestCode,
//                                     Database::"Loan Top Up.", 'An Approval request for  Loan Top Up is canceled.', 0, false);
//         //Change Request
//         WFHandler.AddEventToLibrary(RunWorkflowOnSendMemberChangeRequestForApprovalCode,
//                             Database::"Change Request", 'Approval of Change Request is Requested.', 0, false);
//         WFHandler.AddEventToLibrary(RunWorkflowOnCancelMemberChangeRequestApprovalRequestCode,
//                                     Database::"Change Request", 'An Approval request for  Change Request is canceled.', 0, false);

//         //-------------------------------------------End Approval Events-------------------------------------------------------------
//         //CEEP Change Request
//         WFHandler.AddEventToLibrary(RunWorkflowOnSendCEEPChangeRequestForApprovalCode,
//                             Database::"CEEP Change Request", 'Approval of CEEP Change Request is Requested.', 0, false);
//         WFHandler.AddEventToLibrary(RunWorkflowOnCancelCEEPChangeRequestApprovalRequestCode,
//                                     Database::"CEEP Change Request", 'An Approval request for CEEP Change Request is canceled.', 0, false);

//         //Leave Application
//         // WFHandler.AddEventToLibrary(RunWorkflowOnSendLeaveApplicationForApprovalCode,
//         //                     Database::"HR Leave Application", 'Approval of Leave Application is Requested.', 0, false);
//         // WFHandler.AddEventToLibrary(RunWorkflowOnCancelLeaveApplicationApprovalRequestCode,
//         //                             Database::"HR Leave Application", 'An Approval request for  Leave Application is canceled.', 0, false);
//         //Guarantor Substitution
//         WFHandler.AddEventToLibrary(RunWorkflowOnSendGuarantorSubForApprovalCode,
//                             Database::"Guarantorship Substitution H", 'Approval of Guarantor Substitution is Requested.', 0, false);
//         WFHandler.AddEventToLibrary(RunWorkflowOnCancelGuarantorSubApprovalRequestCode,
//                                     Database::"Guarantorship Substitution H", 'An Approval request for Guarantor Substitution is canceled.', 0, false);

//         //Payment Voucher
//         WFHandler.AddEventToLibrary(RunWorkflowOnSendPaymentVoucherForApprovalCode,
//                             Database::"Payment Header", 'Approval of Payment Voucher is Requested.', 0, false);
//         WFHandler.AddEventToLibrary(RunWorkflowOnCancelPaymentVoucherApprovalRequestCode,
//                                     Database::"Payment Header", 'An Approval request for  Payment Voucher is canceled.', 0, false);
//         //Petty Cash Reimbursement
//         WFHandler.AddEventToLibrary(RunWorkflowOnSendPettyCashReimbersementForApprovalCode,
//                             Database::"Funds Transfer Header", 'Approval of PettyCash Reimbursment is Requested.', 0, false);
//         WFHandler.AddEventToLibrary(RunWorkflowOnCancelPettyCashReimbersementApprovalRequestCode,
//                                     Database::"Funds Transfer Header", 'An Approval request for  PettyCash Reimbursement is canceled.', 0, false);
//         //-------------------------------------------------------------------------
//         //FOSA Product Application
//         WFHandler.AddEventToLibrary(RunWorkflowOnSendFOSAProductApplicationForApprovalCode,
//                             Database::"Accounts Applications Details", 'Approval of FOSA Product Application is Requested.', 0, false);
//         WFHandler.AddEventToLibrary(RunWorkflowOnCancelFOSAProductApplicationApprovalRequestCode,
//                                     Database::"Accounts Applications Details", 'An Approval request for  FOSA Product Application is canceled.', 0, false);
//         //11.Loan Recovery Application
//         WFHandler.AddEventToLibrary(RunWorkflowOnSendLoanRecoveryApplicationForApprovalCode,
//                             Database::"Loan Recovery Header", 'Approval of Loan Recovery Application is Requested.', 0, false);
//         WFHandler.AddEventToLibrary(RunWorkflowOnCancelLoanRecoveryApplicationApprovalRequestCode,
//                                     Database::"Loan Recovery Header", 'An Approval request for  Loan Recovery Application is canceled.', 0, false);

//         //-------------------------------------------End Approval Events-------------------------------------------------------------
//     end;

//     [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowEventPredecessorsToLibrary', '', false, false)]
//     local procedure OnAddWorkflowEventPredecessorsToLibrary()
//     begin
//         //--------1.Approval,Rejection,Delegation Predecessors----------------------
//         //1. Membership Application

//         WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendMembershipApplicationForApprovalCode);

//         WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendMembershipApplicationForApprovalCode);

//         WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendMembershipApplicationForApprovalCode);


//         //Membership Re-Application
//         WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendMemberReapplicationForApprovalCode);

//         WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendMemberReapplicationForApprovalCode);

//         WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendMemberReapplicationForApprovalCode);

//         //Membership withdrawal

//         WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendMembershipApplicationForApprovalCode);

//         WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendMembershipApplicationForApprovalCode);

//         WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendMembershipApplicationForApprovalCode);

//         //2. Loan Application
//         WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendLoanApplicationForApprovalCode);

//         WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendLoanApplicationForApprovalCode);

//         WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendLoanApplicationForApprovalCode);

//         //3. BOSA Transfers
//         WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendBOSATransForApprovalCode);

//         WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendBOSATransForApprovalCode);

//         WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendBOSATransForApprovalCode);

//         //4. Loan Batch Disbursement
//         WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendLoanBatchForApprovalCode);

//         WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendLoanBatchForApprovalCode);

//         WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendLoanBatchForApprovalCode);

//         //5. Loan TopUp
//         WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendLoanTopUpForApprovalCode);

//         WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendLoanTopUpForApprovalCode);

//         WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendLoanTopUpForApprovalCode);
//         //6. Change Request
//         WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendMemberChangeRequestForApprovalCode);

//         WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendMemberChangeRequestForApprovalCode);

//         WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendMemberChangeRequestForApprovalCode);

//         //7. Leave Application

//         WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendLeaveApplicationForApprovalCode);

//         WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendLeaveApplicationForApprovalCode);

//         WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendLeaveApplicationForApprovalCode);

//         //8.Guarantor Substitution

//         WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendGuarantorSubForApprovalCode);

//         WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendGuarantorSubForApprovalCode);

//         WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendGuarantorSubForApprovalCode);
//         //8. Payment Voucher
//         WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendPaymentVoucherForApprovalCode);

//         WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendPaymentVoucherForApprovalCode);

//         WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendPaymentVoucherForApprovalCode);
//         //9. PettyCash Reimbursement
//         WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendPettyCashReimbersementForApprovalCode);

//         WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendPettyCashReimbersementForApprovalCode);

//         WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendPettyCashReimbersementForApprovalCode);
//         //10. FOSA Product Application

//         WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendFOSAProductApplicationForApprovalCode);

//         WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendFOSAProductApplicationForApprovalCode);

//         WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendFOSAProductApplicationForApprovalCode);
//         //11. Loan Recovery Application

//         WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendLoanRecoveryApplicationForApprovalCode);

//         WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendLoanRecoveryApplicationForApprovalCode);

//         WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendLoanRecoveryApplicationForApprovalCode);
//         //12. Change Request
//         WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendCEEPChangeRequestForApprovalCode);

//         WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendCEEPChangeRequestForApprovalCode);

//         WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendCEEPChangeRequestForApprovalCode);
//         //---------------------------------------End Approval,Rejection,Delegation Predecessors---------------------------------------------
//     end;
//     //...............................................................................................................................................................................
//     //A)Membership Applications
//     procedure RunWorkflowOnSendMembershipApplicationForApprovalCode(): Code[128]//
//     begin
//         exit(UpperCase('RunWorkflowOnSendMembershipApplicationForApproval'));
//     end;


//     procedure RunWorkflowOnCancelMembershipApplicationApprovalRequestCode(): Code[128]
//     begin
//         exit(UpperCase('RunWorkflowOnCancelMembershipApplicationApprovalRequest'));
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::SurestepApprovalsCodeUnit, 'FnOnSendMembershipApplicationForApproval', '', false, false)]

//     procedure RunWorkflowOnSendMembershipApplicationForApproval(var MembershipApplication: Record "Membership Applications")
//     begin
//         WorkflowManagement.HandleEvent(RunWorkflowOnSendMembershipApplicationForApprovalCode, MembershipApplication);
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::SurestepApprovalsCodeUnit, 'FnOnCancelMembershipApplicationApprovalRequest', '', false, false)]

//     procedure RunWorkflowOnCancelMembershipApplicationApprovalRequest(var MembershipApplication: Record "Membership Applications")
//     begin
//         WorkflowManagement.HandleEvent(RunWorkflowOnCancelMembershipApplicationApprovalRequestCode, MembershipApplication);
//     end;
//     //1)Membership Exit Application
//     procedure RunWorkflowOnSendMembershipExitApplicationForApprovalCode(): Code[128]//
//     begin
//         exit(UpperCase('RunWorkflowOnSendMembershipExitApplicationForApproval'));
//     end;


//     procedure RunWorkflowOnCancelMembershipExitApplicationApprovalRequestCode(): Code[128]
//     begin
//         exit(UpperCase('RunWorkflowOnCancelMembershipExitApplicationApprovalRequest'));
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::SurestepApprovalsCodeUnit, 'FnOnSendMembershipExitApplicationForApproval', '', false, false)]

//     procedure RunWorkflowOnSendMembershipExitApplicationForApproval(var "Membership Exist": Record "Membership Exist")
//     begin
//         WorkflowManagement.HandleEvent(RunWorkflowOnSendMembershipApplicationForApprovalCode, "Membership Exist");
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::SurestepApprovalsCodeUnit, 'FnOnCancelMembershipExitApplicationApprovalRequest', '', false, false)]

//     procedure RunWorkflowOnCancelMembershipExitApplicationApprovalRequest(var "Membership Exist": Record "Membership Exist")
//     begin
//         WorkflowManagement.HandleEvent(RunWorkflowOnCancelMembershipExitApplicationApprovalRequestCode, "Membership Exist");
//     end;
//     //2. Loan Applications
//     procedure RunWorkflowOnSendLoanApplicationForApprovalCode(): Code[128]//
//     begin
//         exit(UpperCase('RunWorkflowOnSendLoanApplicationForApproval'));
//     end;


//     procedure RunWorkflowOnCancelLoanApplicationApprovalRequestCode(): Code[128]
//     begin
//         exit(UpperCase('RunWorkflowOnCancelLoanApplicationApprovalRequest'));
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::SurestepApprovalsCodeUnit, 'FnOnSendLoanApplicationForApproval', '', false, false)]

//     procedure RunWorkflowOnSendLoanApplicationForApproval(var LoansRegister: Record "Loans Register")
//     begin
//         WorkflowManagement.HandleEvent(RunWorkflowOnSendLoanApplicationForApprovalCode, LoansRegister);
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::SurestepApprovalsCodeUnit, 'FnOnCancelLoanApplicationApprovalRequest', '', false, false)]

//     procedure RunWorkflowOnCancelLoanApplicationApprovalRequest(var LoansRegister: Record "Loans Register")
//     begin
//         WorkflowManagement.HandleEvent(RunWorkflowOnCancelLoanApplicationApprovalRequestCode, LoansRegister);
//     end;
//     //...................................................................................................

//     //3. BOSA Transfers
//     procedure RunWorkflowOnSendBOSATransForApprovalCode(): Code[128]//
//     begin
//         exit(UpperCase('RunWorkflowOnSendBOSATransForApproval'));
//     end;


//     procedure RunWorkflowOnCancelBOSATransApprovalRequestCode(): Code[128]
//     begin
//         exit(UpperCase('RunWorkflowOnCancelBOSATransApprovalRequest'));
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::SurestepApprovalsCodeUnit, 'FnOnSendBOSATransForApproval', '', false, false)]

//     procedure RunWorkflowOnSendBOSATransForApproval(var BOSATransfers: Record "BOSA Transfers")
//     begin
//         WorkflowManagement.HandleEvent(RunWorkflowOnSendBOSATransForApprovalCode, BOSATransfers);
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::SurestepApprovalsCodeUnit, 'FnOnCancelBOSATransApprovalRequest', '', false, false)]

//     procedure RunWorkflowOnCancelBOSATransApprovalRequest(var BOSATransfers: Record "BOSA Transfers")
//     begin
//         WorkflowManagement.HandleEvent(RunWorkflowOnCancelBOSATransApprovalRequestCode, BOSATransfers);
//     end;
//     //...................................................................................................
//     //4. Loan Batches
//     procedure RunWorkflowOnSendLoanBatchForApprovalCode(): Code[128]//
//     begin
//         exit(UpperCase('RunWorkflowOnSendLoanBatchForApproval'));
//     end;


//     procedure RunWorkflowOnCancelLoanBatchApprovalRequestCode(): Code[128]
//     begin
//         exit(UpperCase('RunWorkflowOnCancelLoanBatchApprovalRequest'));
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::SurestepApprovalsCodeUnit, 'FnOnSendLoanBatchForApproval', '', false, false)]

//     procedure RunWorkflowOnSendLoanBatchForApproval(var LoanDisburesmentBatching: Record "Loan Disburesment-Batching")
//     begin
//         WorkflowManagement.HandleEvent(RunWorkflowOnSendLoanBatchForApprovalCode, LoanDisburesmentBatching);
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::SurestepApprovalsCodeUnit, 'FnOnCancelLoanBatchApprovalRequest', '', false, false)]

//     procedure RunWorkflowOnCancelLoanBatchApprovalRequest(var LoanDisburesmentBatching: Record "Loan Disburesment-Batching")
//     begin
//         WorkflowManagement.HandleEvent(RunWorkflowOnCancelLoanBatchApprovalRequestCode, LoanDisburesmentBatching);
//     end;
//     //...................................................................................................
//     //5. Loan TopUp
//     procedure RunWorkflowOnSendLoanTopUpForApprovalCode(): Code[128]//
//     begin
//         exit(UpperCase('RunWorkflowOnSendLoanTopUpForApproval'));
//     end;


//     procedure RunWorkflowOnCancelLoanTopUpApprovalRequestCode(): Code[128]
//     begin
//         exit(UpperCase('RunWorkflowOnCancelLoanTopUpApprovalRequest'));
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::SurestepApprovalsCodeUnit, 'FnOnSendLoanTopUpForApproval', '', false, false)]

//     procedure RunWorkflowOnSendLoanTopUpForApproval(var LoanTopUp: Record "Loan Top Up.")
//     begin
//         WorkflowManagement.HandleEvent(RunWorkflowOnSendLoanTopUpForApprovalCode, LoanTopUp);
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::SurestepApprovalsCodeUnit, 'FnOnCancelLoanTopUpApprovalRequest', '', false, false)]

//     procedure RunWorkflowOnCancelLoanTopUpApprovalRequest(var LoanTopUp: Record "Loan Top Up.")
//     begin
//         WorkflowManagement.HandleEvent(RunWorkflowOnCancelLoanTopUpApprovalRequestCode, LoanTopUp);
//     end;
//     //...................................................................................................
//     //6. Change Request
//     procedure RunWorkflowOnSendMemberChangeRequestForApprovalCode(): Code[128]//
//     begin
//         exit(UpperCase('RunWorkflowOnSendMemberChangeRequestForApproval'));
//     end;


//     procedure RunWorkflowOnCancelMemberChangeRequestApprovalRequestCode(): Code[128]
//     begin
//         exit(UpperCase('RunWorkflowOnCancelMemberChangeRequestApprovalRequest'));
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::SurestepApprovalsCodeUnit, 'FnOnSendMemberChangeRequestForApproval', '', false, false)]

//     procedure RunWorkflowOnSendMemberChangeRequestForApproval(var ChangeRequest: Record "Change Request")
//     begin
//         WorkflowManagement.HandleEvent(RunWorkflowOnSendMemberChangeRequestForApprovalCode, ChangeRequest);
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::SurestepApprovalsCodeUnit, 'FnOnCancelMemberChangeRequestApprovalRequest', '', false, false)]

//     procedure RunWorkflowOnCancelMemberChangeRequestApprovalRequest(var ChangeRequest: Record "Change Request")
//     begin
//         WorkflowManagement.HandleEvent(RunWorkflowOnCancelMemberChangeRequestApprovalRequestCode, ChangeRequest);
//     end;
//     //A)Leave Applications
//     procedure RunWorkflowOnSendLeaveApplicationForApprovalCode(): Code[128]//
//     begin
//         exit(UpperCase('RunWorkflowOnSendLeaveApplicationForApproval'));
//     end;


//     procedure RunWorkflowOnCancelLeaveApplicationApprovalRequestCode(): Code[128]
//     begin
//         exit(UpperCase('RunWorkflowOnCancelLeaveApplicationApprovalRequest'));
//     end;

//     // [EventSubscriber(ObjectType::Codeunit, Codeunit::SurestepApprovalsCodeUnit, 'FnOnSendLeaveApplicationForApproval', '', false, false)]

//     // procedure RunWorkflowOnSendLeaveApplicationForApproval(var LeaveApplication: Record "HR Leave Application")
//     // begin
//     //     WorkflowManagement.HandleEvent(RunWorkflowOnSendLeaveApplicationForApprovalCode, LeaveApplication);
//     // end;

//     // [EventSubscriber(ObjectType::Codeunit, Codeunit::SurestepApprovalsCodeUnit, 'FnOnCancelLeaveApplicationApprovalRequest', '', false, false)]

//     // procedure RunWorkflowOnCancelLeaveApplicationApprovalRequest(var LeaveApplication: Record "HR Leave Application")
//     // begin
//     //     WorkflowManagement.HandleEvent(RunWorkflowOnCancelLeaveApplicationApprovalRequestCode, LeaveApplication);
//     // end;
//     //...................................................................................................
//     //8)Guarantor Substitution
//     procedure RunWorkflowOnSendGuarantorSubForApprovalCode(): Code[128]//
//     begin
//         exit(UpperCase('RunWorkflowOnSendGuarantorSubForApproval'));
//     end;


//     procedure RunWorkflowOnCancelGuarantorSubApprovalRequestCode(): Code[128]
//     begin
//         exit(UpperCase('RunWorkflowOnCancelGuarantorSubApprovalRequest'));
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::SurestepApprovalsCodeUnit, 'FnOnSendGuarantorSubForApproval', '', false, false)]

//     procedure RunWorkflowOnSendGuarantorSubForApproval(var GuarantorSubstitution: Record "Guarantorship Substitution H")
//     begin
//         WorkflowManagement.HandleEvent(RunWorkflowOnSendGuarantorSubForApprovalCode, GuarantorSubstitution);
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::SurestepApprovalsCodeUnit, 'FnOnCancelGuarantorSubApprovalRequest', '', false, false)]

//     procedure RunWorkflowOnCancelGuarantorSubApprovalRequest(var GuarantorSubstitution: Record "Guarantorship Substitution H")
//     begin
//         WorkflowManagement.HandleEvent(RunWorkflowOnCancelGuarantorSubApprovalRequestCode, GuarantorSubstitution);
//     end;
//     //------------------------------------------------------------------------
//     //8)Payment Voucher
//     procedure RunWorkflowOnSendPaymentVoucherForApprovalCode(): Code[128]//
//     begin
//         exit(UpperCase('RunWorkflowOnSendPaymentVoucherForApproval'));
//     end;


//     procedure RunWorkflowOnCancelPaymentVoucherApprovalRequestCode(): Code[128]
//     begin
//         exit(UpperCase('RunWorkflowOnCancelPaymentVoucherApprovalRequest'));
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::SurestepApprovalsCodeUnit, 'FnOnSendPaymentVoucherForApproval', '', false, false)]

//     procedure RunWorkflowOnSendPaymentVoucherForApproval(var PaymentVoucher: Record "Payments Header")
//     begin
//         WorkflowManagement.HandleEvent(RunWorkflowOnSendPaymentVoucherForApprovalCode, PaymentVoucher);
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::SurestepApprovalsCodeUnit, 'FnOnCancelPaymentVoucherApprovalRequest', '', false, false)]

//     procedure RunWorkflowOnCancelPaymentVoucherApprovalRequest(var PaymentVoucher: Record "Payments Header")
//     begin
//         WorkflowManagement.HandleEvent(RunWorkflowOnCancelPaymentVoucherApprovalRequestCode, PaymentVoucher);
//     end;
//     //---------------------------------------------------------------------------------
//     //9)Payment Voucher
//     procedure RunWorkflowOnSendPettyCashReimbersementForApprovalCode(): Code[128]//
//     begin
//         exit(UpperCase('RunWorkflowOnSendPettyCashReimbersementForApproval'));
//     end;


//     procedure RunWorkflowOnCancelPettyCashReimbersementApprovalRequestCode(): Code[128]
//     begin
//         exit(UpperCase('RunWorkflowOnCancelPettyCashReimbersementApprovalRequest'));
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::SurestepApprovalsCodeUnit, 'FnOnSendPettyCashReimbersementForApproval', '', false, false)]

//     procedure RunWorkflowOnSendPettyCashReimbersementForApproval(var PettyCashReimbersement: Record "Funds Transfer Header")
//     begin
//         WorkflowManagement.HandleEvent(RunWorkflowOnSendPettyCashReimbersementForApprovalCode, PettyCashReimbersement);
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::SurestepApprovalsCodeUnit, 'FnOnCancelPettyCashReimbersementApprovalRequest', '', false, false)]

//     procedure RunWorkflowOnCancelPettyCashReimbersementApprovalRequest(var PettyCashReimbersement: Record "Funds Transfer Header")
//     begin
//         WorkflowManagement.HandleEvent(RunWorkflowOnCancelPettyCashReimbersementApprovalRequestCode, PettyCashReimbersement);
//     end;


//     //10)FOSA Product Applications
//     procedure RunWorkflowOnSendFOSAProductApplicationForApprovalCode(): Code[128]//
//     begin
//         exit(UpperCase('RunWorkflowOnSendFOSAProductApplicationForApproval'));
//     end;


//     procedure RunWorkflowOnCancelFOSAProductApplicationApprovalRequestCode(): Code[128]
//     begin
//         exit(UpperCase('RunWorkflowOnCancelFOSAProductApplicationApprovalRequest'));
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::SurestepApprovalsCodeUnit, 'FnOnSendFOSAProductApplicationForApproval', '', false, false)]

//     procedure RunWorkflowOnSendFOSAProductApplicationForApproval(var FOSAProductApplication: Record "Accounts Applications Details")
//     begin
//         WorkflowManagement.HandleEvent(RunWorkflowOnSendFOSAProductApplicationForApprovalCode, FOSAProductApplication);
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::SurestepApprovalsCodeUnit, 'FnOnCancelFOSAProductApplicationApprovalRequest', '', false, false)]

//     procedure RunWorkflowOnCancelFOSAProductApplicationApprovalRequest(var FOSAProductApplication: Record "Accounts Applications Details")
//     begin
//         WorkflowManagement.HandleEvent(RunWorkflowOnCancelFOSAProductApplicationApprovalRequestCode, FOSAProductApplication);
//     end;
//     //12)Loan Recovery Applications
//     procedure RunWorkflowOnSendLoanRecoveryApplicationForApprovalCode(): Code[128]//
//     begin
//         exit(UpperCase('RunWorkflowOnSendLoanRecoveryApplicationForApproval'));
//     end;


//     procedure RunWorkflowOnCancelLoanRecoveryApplicationApprovalRequestCode(): Code[128]
//     begin
//         exit(UpperCase('RunWorkflowOnCancelLoanRecoveryApplicationApprovalRequest'));
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::SurestepApprovalsCodeUnit, 'FnOnSendLoanRecoveryApplicationForApproval', '', false, false)]

//     procedure RunWorkflowOnSendLoanRecoveryApplicationForApproval(var LoanRecoveryApplication: Record "Loan Recovery Header")
//     begin
//         WorkflowManagement.HandleEvent(RunWorkflowOnSendLoanRecoveryApplicationForApprovalCode, LoanRecoveryApplication);
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::SurestepApprovalsCodeUnit, 'FnOnCancelLoanRecoveryApplicationApprovalRequest', '', false, false)]

//     procedure RunWorkflowOnCancelLoanRecoveryApplicationApprovalRequest(var LoanRecoveryApplication: Record "Loan Recovery Header")
//     begin
//         WorkflowManagement.HandleEvent(RunWorkflowOnCancelLoanRecoveryApplicationApprovalRequestCode, LoanRecoveryApplication);
//     end;
//     //...................................................................
//     //12.CEEP Change Request
//     procedure RunWorkflowOnSendCEEPChangeRequestForApprovalCode(): Code[128]//
//     begin
//         exit(UpperCase('RunWorkflowOnSendCEEPChangeRequestForApproval'));
//     end;


//     procedure RunWorkflowOnCancelCEEPChangeRequestApprovalRequestCode(): Code[128]
//     begin
//         exit(UpperCase('RunWorkflowOnCancelCEEPChangeRequestApprovalRequest'));
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::SurestepApprovalsCodeUnit, 'FnOnSendCEEPChangeRequestForApproval', '', false, false)]

//     procedure RunWorkflowOnSendCEEPChangeRequestForApproval(var ChangeRequest: Record "CEEP Change Request")
//     begin
//         WorkflowManagement.HandleEvent(RunWorkflowOnSendCEEPChangeRequestForApprovalCode, ChangeRequest);
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::SurestepApprovalsCodeUnit, 'FnOnCancelCEEPChangeRequestApprovalRequest', '', false, false)]

//     procedure RunWorkflowOnCancelCEEPChangeRequestApprovalRequest(var ChangeRequest: Record "CEEP Change Request")
//     begin
//         WorkflowManagement.HandleEvent(RunWorkflowOnCancelCEEPChangeRequestApprovalRequestCode, ChangeRequest);
//     end;

//     //13)Member Re-application
//     procedure RunWorkflowOnSendMemberReapplicationForApprovalCode(): Code[128]
//     begin
//         exit(UpperCase('RunWorkflowOnSendMemberReapplicationForApproval'));
//     end;


//     procedure RunWorkflowOnCancelMemberReapplicationApprovalRequestCode(): Code[128]
//     begin
//         exit(UpperCase('RunWorkflowOnCancelMemberReapplicationApprovalRequest'));
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::SurestepApprovalsCodeUnit, 'FnOnSendMemberReapplicationForApproval', '', false, false)]

//     procedure RunWorkflowOnSendMemberReapplicationForApproval(var MemberReapplication: Record "Member Reapplication")
//     begin
//         WorkflowManagement.HandleEvent(RunWorkflowOnSendMemberReapplicationForApprovalCode, MemberReapplication);
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::SurestepApprovalsCodeUnit, 'FnOnCancelMemberReapplicationApprovalRequest', '', false, false)]

//     procedure RunWorkflowOnCancelMemberReapplicationApprovalRequest(var MemberReapplication: Record "Member Reapplication")
//     begin
//         WorkflowManagement.HandleEvent(RunWorkflowOnCancelMemberReapplicationApprovalRequestCode, MemberReapplication);
//     end;
// }
