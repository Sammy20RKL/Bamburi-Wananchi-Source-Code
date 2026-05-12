//Replacing Workflow Integration codeunit for membership functions
codeunit 50044 "SurestepApprovalsCodeUnit"
{

    trigger OnRun()
    begin

    end;

    var
        MembApplicationTable: Record "Membership Applications";
        LoanApplications: Record "Loans Register";
        LoanBatches: Record "Loan Disburesment-Batching";
        GuarantorSubstitution: Record "Guarantorship Substitution H";
        PaymentVoucher: Record "Payments Header";
        FundsTransferHeader: Record "Funds Transfer Header";
        FOSAProductApplicationTable: Record "Accounts Applications Details";
        LoanRecoveryApplicationTable: Record "Loan Recovery Header";
        Psalmkitswfevents: Codeunit "Custom Workflow Events";
        NoWorkflowEnabledErr: Label 'No Approval workflow for this record type is enabled';
        WorkflowManagement: Codeunit "Workflow Management";


    /*     [EventSubscriber(ObjectType::Codeunit, 1535, 'OnPopulateApprovalEntryArgument', '', false, false)]
        local procedure OnPopulateApprovalEntryArgument(VAR RecRef: RecordRef; VAR ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
        var
            TbMembApps: Record "Membership Applications";
        begin
            CASE RecRef.NUMBER OF
                DATABASE::"Membership Applications":
                    begin
                        RecRef.SetTable(TbMembApps);
                        ApprovalEntryArgument."Document No." := TbMembApps."No.";
                        ApprovalEntryArgument."Document Type" := 12;
                    end;
            end;
        end; */



    //1)--------------------------------------------------------------------Send Membership Applications request For Approval start
    procedure SendMembershipApplicationsRequestForApproval(MemberApplicationNo: Code[40]; var "Membership Applications": Record "Membership Applications")
    begin
        if FnCheckIfMembershipApplicationApprovalsWorkflowEnabled("Membership Applications") then begin
            FnOnSendMembershipApplicationForApproval("Membership Applications");
        end;
    end;

    local procedure FnCheckIfMembershipApplicationApprovalsWorkflowEnabled(var "Membership Applications": Record "Membership Applications"): Boolean;
    begin
        if not IsMembershipApplicationApprovalsWorkflowEnabled("Membership Applications") then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    //.
    procedure CancelMembershipApplicationsRequestForApproval(MemberApplicationNo: Code[40]; var "Membership Applications": Record "Membership Applications")
    begin
        FnOnCancelMembershipApplicationApprovalRequest("Membership Applications");
    end;


    local procedure IsMembershipApplicationApprovalsWorkflowEnabled(var MembershipApplication: Record "Membership Applications"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(MembershipApplication, Psalmkitswfevents.RunWorkflowOnSendMembershipApplicationForApprovalCode));
    end;

    local procedure FnCheckIfBOSAAccountRegistrationIsAllowed()
    begin
        Error('Procedure FnCheckIfBOSAAccountRegistrationIsAllowed not implemented.');
    end;

    [IntegrationEvent(false, false)]

    procedure FnOnSendMembershipApplicationForApproval(var MembershipApplication: Record "Membership Applications")
    begin
    end;

    [IntegrationEvent(false, false)]

    procedure FnOnCancelMembershipApplicationApprovalRequest(var MembershipApplication: Record "Membership Applications")
    begin
    end;

    //2)--------------------------------------------------------------------Send Loan Applications request For Approval start
    procedure SendLoanApplicationsRequestForApproval(LoanNo: Code[40]; var "Loans Register": Record "Loans Register"): Boolean;
    begin
        if FnCheckIfLoanApplicationApprovalsWorkflowEnabled("Loans Register") then begin
            FnOnSendLoanApplicationForApproval("Loans Register");
        end;
        exit(true);
    end;

    local procedure FnCheckIfLoanApplicationApprovalsWorkflowEnabled(var "Loans Register": Record "Loans Register"): Boolean;
    begin
        if not IsLoanApplicationApprovalsWorkflowEnabled("Loans Register") then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    //.
    procedure CancelLoanApplicationsRequestForApproval(LoansRegister: Code[40]; var "Loans Register": Record "Loans Register"): Boolean;
    begin
        FnOnCancelLoanApplicationApprovalRequest("Loans Register");
        exit(true);
    end;


    local procedure IsLoanApplicationApprovalsWorkflowEnabled(var LoansRegister: Record "Loans Register"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(LoansRegister, Psalmkitswfevents.RunWorkflowOnSendLoanApplicationForApprovalCode));
    end;


    [IntegrationEvent(false, false)]

    procedure FnOnSendLoanApplicationForApproval(var LoansRegister: Record "Loans Register")
    begin
    end;

    [IntegrationEvent(false, false)]

    procedure FnOnCancelLoanApplicationApprovalRequest(var LoansRegister: Record "Loans Register")
    begin
    end;
    //------------------------------------------------------------------------------------------------------
    //3)--------------------------------------------------------------------Send BOSA Transfers request For Approval start
    procedure SendBOSATransForApproval(No: Code[40]; var "BOSA Transfers": Record "BOSA Transfers")
    begin
        if FnCheckIfBOSATransApprovalsWorkflowEnabled("BOSA Transfers") then begin
            FnOnSendBOSATransForApproval("BOSA Transfers");
        end;
    end;

    local procedure FnCheckIfBOSATransApprovalsWorkflowEnabled(var "BOSA Transfers": Record "BOSA Transfers"): Boolean;
    begin
        if not IsBOSATransApprovalsWorkflowEnabled("BOSA Transfers") then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    //.
    procedure CancelBOSATransRequestForApproval(BOSATransfers: Code[40]; var "BOSA Transfers": Record "BOSA Transfers")
    begin
        FnOnCancelBOSATransApprovalRequest("BOSA Transfers");
    end;


    local procedure IsBOSATransApprovalsWorkflowEnabled(var BOSATransfers: Record "BOSA Transfers"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(BOSATransfers, Psalmkitswfevents.RunWorkflowOnSendBOSATransForApprovalCode));
    end;


    [IntegrationEvent(false, false)]

    procedure FnOnSendBOSATransForApproval(var BOSATransfers: Record "BOSA Transfers")
    begin
    end;

    [IntegrationEvent(false, false)]

    procedure FnOnCancelBOSATransApprovalRequest(var BOSATransfers: Record "BOSA Transfers")
    begin
    end;
    //.................................................................................................

    //4)--------------------------------------------------------------------Send Loan Batches request For Approval start
    procedure SendLoanBatchRequestForApproval(LoanNo: Code[40]; var "Loan Disburesment-Batching": Record "Loan Disburesment-Batching")
    begin
        if FnCheckIfLoanBatchApprovalsWorkflowEnabled("Loan Disburesment-Batching") then begin
            FnOnSendLoanBatchForApproval("Loan Disburesment-Batching");
        end;
    end;

    local procedure FnCheckIfLoanBatchApprovalsWorkflowEnabled(var "Loan Disburesment-Batching": Record "Loan Disburesment-Batching"): Boolean;
    begin
        if not IsLoanBatchApprovalsWorkflowEnabled("Loan Disburesment-Batching") then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    //.
    procedure CancelLoanBatchRequestForApproval(LoanDisburesmentBatching: Code[40]; var "Loan Disburesment-Batching": Record "Loan Disburesment-Batching")
    begin
        FnOnCancelLoanBatchApprovalRequest("Loan Disburesment-Batching");
    end;


    local procedure IsLoanBatchApprovalsWorkflowEnabled(var LoanDisburesmentBatching: Record "Loan Disburesment-Batching"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(LoanDisburesmentBatching, Psalmkitswfevents.RunWorkflowOnSendLoanBatchForApprovalCode));
    end;


    [IntegrationEvent(false, false)]

    procedure FnOnSendLoanBatchForApproval(var LoanDisburesmentBatching: Record "Loan Disburesment-Batching")
    begin
    end;

    [IntegrationEvent(false, false)]

    procedure FnOnCancelLoanBatchApprovalRequest(var LoanDisburesmentBatching: Record "Loan Disburesment-Batching")
    begin
    end;
    //------------------------------------------------------------------------------------------------------
    //5)--------------------------------------------------------------------Send Loan TopUp request For Approval start
    procedure SendLoanTopUpRequestForApproval(DocNo: Code[40]; var "Loan Top Up.": Record "Loan Top Up.")
    begin
        if FnCheckIfLoanTopUpApprovalsWorkflowEnabled("Loan Top Up.") then begin
            FnOnSendLoanTopUpForApproval("Loan Top Up.");
        end;
    end;

    local procedure FnCheckIfLoanTopUpApprovalsWorkflowEnabled(var "Loan Top Up.": Record "Loan Top Up."): Boolean;
    begin
        if not IsLoanTopUpApprovalsWorkflowEnabled("Loan Top Up.") then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    //.
    procedure CancelLoanTopUpRequestForApproval(LoanTopUp: Code[40]; var "Loan Top Up.": Record "Loan Top Up.")
    begin
        FnOnCancelLoanTopUpApprovalRequest("Loan Top Up.");
    end;


    local procedure IsLoanTopUpApprovalsWorkflowEnabled(var LoanTopUp: Record "Loan Top Up."): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(LoanTopUp, Psalmkitswfevents.RunWorkflowOnSendLoanTopUpForApprovalCode));
    end;


    [IntegrationEvent(false, false)]

    procedure FnOnSendLoanTopUpForApproval(var LoanTopUp: Record "Loan Top Up.")
    begin
    end;

    [IntegrationEvent(false, false)]

    procedure FnOnCancelLoanTopUpApprovalRequest(var LoanTopUp: Record "Loan Top Up.")
    begin
    end;
    //------------------------------------------------------------------------------------------------------
    //6)--------------------------------------------------------------------Send Change request For Approval start
    procedure SendMemberChangeRequestForApproval(DocNo: Code[40]; var "Change Request": Record "Change Request")
    begin
        if FnCheckIfMemberChangeRequestApprovalsWorkflowEnabled("Change Request") then begin
            FnOnSendMemberChangeRequestForApproval("Change Request");
        end;
    end;

    local procedure FnCheckIfMemberChangeRequestApprovalsWorkflowEnabled(var "Change Request": Record "Change Request"): Boolean;
    begin
        if not IsMemberChangeRequestApprovalsWorkflowEnabled("Change Request") then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    //.
    procedure CancelMemberChangeRequestRequestForApproval(ChangeRequest: Code[40]; var "Change Request": Record "Change Request")
    begin
        FnOnCancelMemberChangeRequestApprovalRequest("Change Request");
    end;


    local procedure IsMemberChangeRequestApprovalsWorkflowEnabled(var ChangeRequest: Record "Change Request"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(ChangeRequest, Psalmkitswfevents.RunWorkflowOnSendMemberChangeRequestForApprovalCode));
    end;


    [IntegrationEvent(false, false)]

    procedure FnOnSendMemberChangeRequestForApproval(var ChangeRequest: Record "Change Request")
    begin
    end;

    [IntegrationEvent(false, false)]

    procedure FnOnCancelMemberChangeRequestApprovalRequest(var ChangeRequest: Record "Change Request")
    begin
    end;


    //Send MemberReapplication Card

    procedure SendMemberReapplicationRequestForApproval(DocNo: Code[40]; var MemberReapplication: Record "Member Reapplication")
    begin
        if FnCheckIfMemberMemberReapplicationApprovalsWorkflowEnabled(MemberReapplication) then begin
            FnOnSendMemberReapplicationForApproval(MemberReapplication);
        end;
    end;

    local procedure FnCheckIfMemberMemberReapplicationApprovalsWorkflowEnabled(var MemberReapplication: Record "Member Reapplication"): Boolean;
    begin
        if not IsMemberReapplicationApprovalsWorkflowEnabled(MemberReapplication) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    //.
    procedure CancelMemberReapplicationRequestForApproval(MemberRea: Code[40]; var MemberReapplication: Record "Member Reapplication")
    begin
        FnOnCancelMemberReapplicationApprovalRequest(MemberReapplication);
    end;


    local procedure IsMemberReapplicationApprovalsWorkflowEnabled(var MemberReapplication: Record "Member Reapplication"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(MemberReapplication, Psalmkitswfevents.RunWorkflowOnSendMemberReapplicationForApprovalCode));
    end;

    [IntegrationEvent(false, false)]

    procedure FnOnSendMemberReapplicationForApproval(var MemberReapplication: Record "Member Reapplication")
    begin
    end;

    [IntegrationEvent(false, false)]

    procedure FnOnCancelMemberReapplicationApprovalRequest(var MemberReapplication: Record "Member Reapplication")
    begin
    end;
    //------------------------------------------------------------------------------------------------------
    //7)--------------------------------------------------------------------Send MembershipExit  Applications request For Approval start

    procedure SendMembershipExitApplicationsRequestForApproval(MemberApplicationNo: Code[40]; var "Membership Exist": Record "Membership Exist")
    begin
        if FnCheckIfMembershipExitApplicationApprovalsWorkflowEnabled("Membership Exist") then begin
            FnOnSendMembershipExitApplicationForApproval("Membership Exist");
        end;
    end;

    local procedure FnCheckIfMembershipExitApplicationApprovalsWorkflowEnabled(var "Membership Exist": Record "Membership Exist"): Boolean;
    begin
        if not IsMembershipApplicationExitApprovalsWorkflowEnabled("Membership Exist") then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    //.
    procedure CancelMembershipExitApplicationsRequestForApproval(MemberApplicationNo: Code[40]; var "Membership Exist": Record "Membership Exist")
    begin
        FnOnCancelMembershipExitApplicationApprovalRequest("Membership Exist");
    end;


    local procedure IsMembershipApplicationExitApprovalsWorkflowEnabled(var "Membership Exist": Record "Membership Exist"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow("Membership Exist", Psalmkitswfevents.RunWorkflowOnSendMembershipExitApplicationForApprovalCode));
    end;



    [IntegrationEvent(false, false)]

    procedure FnOnSendMembershipExitApplicationForApproval(var "Membership Exist": Record "Membership Exist")
    begin
    end;

    [IntegrationEvent(false, false)]

    procedure FnOnCancelMembershipExitApplicationApprovalRequest(var "Membership Exist": Record "Membership Exist")
    begin
    end;

    //8)--------------------------------------------------------------------Guarantor Substitution request For Approval start
    procedure SendGuarantorSubRequestForApproval(GuarantorSubNo: Code[40]; var "Guarantorship Substitution H": Record "Guarantorship Substitution H")
    begin
        if FnCheckIfGuarantorSubApprovalsWorkflowEnabled("Guarantorship Substitution H") then begin
            FnOnSendGuarantorSubForApproval("Guarantorship Substitution H");
        end;
    end;

    local procedure FnCheckIfGuarantorSubApprovalsWorkflowEnabled(var "Guarantorship Substitution H": Record "Guarantorship Substitution H"): Boolean;
    begin
        if not IsGuarantorSubApprovalsWorkflowEnabled("Guarantorship Substitution H") then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    //.
    procedure CancelGuarantorSubRequestForApproval(GuarantorSubstitution: Code[40]; var "Guarantorship Substitution H": Record "Guarantorship Substitution H")
    begin
        FnOnCancelGuarantorSubApprovalRequest("Guarantorship Substitution H");
    end;


    local procedure IsGuarantorSubApprovalsWorkflowEnabled(var GuarantorSubstitution: Record "Guarantorship Substitution H"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(GuarantorSubstitution, Psalmkitswfevents.RunWorkflowOnSendGuarantorSubForApprovalCode));
    end;


    [IntegrationEvent(false, false)]

    procedure FnOnSendGuarantorSubForApproval(var GuarantorSubstitution: Record "Guarantorship Substitution H")
    begin
    end;

    [IntegrationEvent(false, false)]

    procedure FnOnCancelGuarantorSubApprovalRequest(var GuarantorSubstitution: Record "Guarantorship Substitution H")
    begin
    end;
    //=============================================================================
    procedure SendPaymentVoucherRequestForApproval(PaymentVoucher: Code[40]; var "Payment Header": Record "Payments Header")
    begin
        if FnCheckIfPaymentVoucherApprovalsWorkflowEnabled("Payment Header") then begin
            FnOnSendPaymentVoucherForApproval("Payment Header");
        end;
    end;

    local procedure FnCheckIfPaymentVoucherApprovalsWorkflowEnabled(var "Payment Header": Record "Payments Header"): Boolean;
    begin
        if not IsPaymentVoucherApprovalsWorkflowEnabled("Payment Header") then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    //.
    procedure CancelPaymentVoucherRequestForApproval(PaymentVoucher: Code[40]; var "Payment Header": Record "Payments Header")
    begin
        FnOnCancelPaymentVoucherApprovalRequest("Payment Header");
    end;


    local procedure IsPaymentVoucherApprovalsWorkflowEnabled(var PaymentVoucher: Record "Payments Header"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(PaymentVoucher, Psalmkitswfevents.RunWorkflowOnSendPaymentVoucherForApprovalCode));
    end;

    [IntegrationEvent(false, false)]

    procedure FnOnSendPaymentVoucherForApproval(var PaymentVoucher: Record "Payments Header")
    begin
    end;

    [IntegrationEvent(false, false)]

    procedure FnOnCancelPaymentVoucherApprovalRequest(var PaymentVoucher: Record "Payments Header")
    begin
    end;

    //=============================================================================
    procedure SendPettyCashReimbersementRequestForApproval(PettyCashReimbersement: Code[40]; var "Funds Transfer Header": Record "Funds Transfer Header")
    begin
        if FnCheckIfPettyCashReimbersementApprovalsWorkflowEnabled("Funds Transfer Header") then begin
            FnOnSendPettyCashReimbersementForApproval("Funds Transfer Header");
        end;
    end;

    local procedure FnCheckIfPettyCashReimbersementApprovalsWorkflowEnabled(var "Funds Transfer Header": Record "Funds Transfer Header"): Boolean;
    begin
        if not IsPettyCashReimbersementApprovalsWorkflowEnabled("Funds Transfer Header") then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;
    //=============================================================================Funds Transfer============
    procedure OnSendFundsTransferForApproval(FundsTransfer: Code[40]; var "Funds Transfer Header": Record "Funds Transfer Header")
    begin
        if FnCheckIfFundsTransferApprovalsWorkflowEnabled("Funds Transfer Header") then begin
            FnOnSendFundsTransferForApproval("Funds Transfer Header");
        end;
    end;

    local procedure FnCheckIfFundsTransferApprovalsWorkflowEnabled(var "Funds Transfer Header": Record "Funds Transfer Header"): Boolean;
    begin
        if not IsFundsTransferApprovalsWorkflowEnabled("Funds Transfer Header") then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    //.
    procedure CancelPettyCashReimbersementRequestForApproval(PettyCashReimbersement: Code[40]; var "Funds Transfer Header": Record "Funds Transfer Header")
    begin
        FnOnCancelPettyCashReimbersementApprovalRequest("Funds Transfer Header");
    end;

    local procedure IsPettyCashReimbersementApprovalsWorkflowEnabled(var PettyCashReimbersement: Record "Funds Transfer Header"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(PettyCashReimbersement, Psalmkitswfevents.RunWorkflowOnSendPettyCashReimbersementForApprovalCode));
    end;

    [IntegrationEvent(false, false)]

    procedure FnOnSendPettyCashReimbersementForApproval(var PettyCashReimbersement: Record "Funds Transfer Header")
    begin
    end;

    [IntegrationEvent(false, false)]

    procedure FnOnCancelPettyCashReimbersementApprovalRequest(var PettyCashReimbersement: Record "Funds Transfer Header")
    begin
    end;

    //Funds transfer
    procedure CancelFundsTransferRequestForApproval(FundsTransfer: Code[40]; var "Funds Transfer Header": Record "Funds Transfer Header")
    begin
        FnOnCancelFundsTransferApprovalRequest("Funds Transfer Header");
    end;

    local procedure IsFundsTransferApprovalsWorkflowEnabled(var FundsTransfer: Record "Funds Transfer Header"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(FundsTransfer, Psalmkitswfevents.RunWorkflowOnSendFundsTransferForApprovalCode));
    end;

    [IntegrationEvent(false, false)]

    procedure FnOnSendFundsTransferForApproval(var FundsTransfer: Record "Funds Transfer Header")
    begin
    end;

    [IntegrationEvent(false, false)]

    procedure FnOnCancelFundsTransferApprovalRequest(var FundsTransfer: Record "Funds Transfer Header")
    begin
    end;
    //-----------------------------------------------------------------Fosa Product Application
    procedure SendFOSAProductApplicationsRequestForApproval(FOSAProductApplicationNo: Code[40]; var "Accounts Applications Details": Record "Accounts Applications Details")
    begin
        if FnCheckIfFOSAProductApplicationApprovalsWorkflowEnabled("Accounts Applications Details") then begin
            FnOnSendFOSAProductApplicationForApproval("Accounts Applications Details");
        end;
    end;

    local procedure FnCheckIfFOSAProductApplicationApprovalsWorkflowEnabled(var "Accounts Applications Details": Record "Accounts Applications Details"): Boolean;
    begin
        if not IsFOSAProductApplicationApprovalsWorkflowEnabled("Accounts Applications Details") then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    //.
    procedure CancelFOSAProductApplicationsRequestForApproval(FOSAProductApplicationNo: Code[40]; var "Accounts Applications Details": Record "Accounts Applications Details")
    begin
        FnOnCancelFOSAProductApplicationApprovalRequest("Accounts Applications Details");
    end;


    local procedure IsFOSAProductApplicationApprovalsWorkflowEnabled(var FOSAProductApplication: Record "Accounts Applications Details"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(FOSAProductApplication, Psalmkitswfevents.RunWorkflowOnSendFOSAProductApplicationForApprovalCode));
    end;

    [IntegrationEvent(false, false)]

    procedure FnOnSendFOSAProductApplicationForApproval(var FOSAProductApplication: Record "Accounts Applications Details")
    begin
    end;

    [IntegrationEvent(false, false)]

    procedure FnOnCancelFOSAProductApplicationApprovalRequest(var FOSAProductApplication: Record "Accounts Applications Details")
    begin
    end;
    //11)-------------Send Loan Recovery Applications request For Approval start
    procedure SendLoanRecoveryApplicationsRequestForApproval(LoanRecoveryApplicationNo: Code[40]; var "Loan Recovery Header": Record "Loan Recovery Header")
    begin
        if FnCheckIfLoanRecoveryApplicationApprovalsWorkflowEnabled("Loan Recovery Header") then begin
            FnOnSendLoanRecoveryApplicationForApproval("Loan Recovery Header");
        end;
    end;

    local procedure FnCheckIfLoanRecoveryApplicationApprovalsWorkflowEnabled(var "Loan Recovery Header": Record "Loan Recovery Header"): Boolean;
    begin
        if not IsLoanRecoveryApplicationApprovalsWorkflowEnabled("Loan Recovery Header") then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    //.
    procedure CancelLoanRecoveryApplicationsRequestForApproval(LoanRecoveryApplicationNo: Code[40]; var "Loan Recovery Header": Record "Loan Recovery Header")
    begin
        FnOnCancelLoanRecoveryApplicationApprovalRequest("Loan Recovery Header");
    end;


    local procedure IsLoanRecoveryApplicationApprovalsWorkflowEnabled(var LoanRecoveryApplication: Record "Loan Recovery Header"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(LoanRecoveryApplication, Psalmkitswfevents.RunWorkflowOnSendLoanRecoveryApplicationForApprovalCode));
    end;

    [IntegrationEvent(false, false)]

    procedure FnOnSendLoanRecoveryApplicationForApproval(var LoanRecoveryApplication: Record "Loan Recovery Header")
    begin
    end;

    [IntegrationEvent(false, false)]

    procedure FnOnCancelLoanRecoveryApplicationApprovalRequest(var LoanRecoveryApplication: Record "Loan Recovery Header")
    begin
    end;
    //...............................................................................
    //6)--------------------------------------------------------------------Send Change request For Approval start
    procedure SendCEEPChangeRequestForApproval(DocNo: Code[40]; var "Change Request": Record "CEEP Change Request")
    begin
        if FnCheckIfCEEPChangeRequestApprovalsWorkflowEnabled("Change Request") then begin
            FnOnSendCEEPChangeRequestForApproval("Change Request");
        end;
    end;

    local procedure FnCheckIfCEEPChangeRequestApprovalsWorkflowEnabled(var "Change Request": Record "CEEP Change Request"): Boolean;
    begin
        if not IsCEEPChangeRequestApprovalsWorkflowEnabled("Change Request") then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    //.
    procedure CancelCEEPChangeRequestRequestForApproval(ChangeRequest: Code[40]; var "Change Request": Record "CEEP Change Request")
    begin
        FnOnCancelCEEPChangeRequestApprovalRequest("Change Request");
    end;


    local procedure IsCEEPChangeRequestApprovalsWorkflowEnabled(var ChangeRequest: Record "CEEP Change Request"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(ChangeRequest, Psalmkitswfevents.RunWorkflowOnSendCEEPChangeRequestForApprovalCode));
    end;


    [IntegrationEvent(false, false)]

    procedure FnOnSendCEEPChangeRequestForApproval(var ChangeRequest: Record "CEEP Change Request")
    begin
    end;

    [IntegrationEvent(false, false)]

    procedure FnOnCancelCEEPChangeRequestApprovalRequest(var ChangeRequest: Record "CEEP Change Request")
    begin
    end;

}

