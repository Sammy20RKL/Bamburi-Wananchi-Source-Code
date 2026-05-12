//Replacing Workflow Integration codeunit for membership functions
Codeunit 50039 "SwizzsoftApprovalsCodeUnit"
{

    trigger OnRun()
    begin

    end;

    var
        MembApplicationTable: Record "Membership Applications";
        LoanApplications: Record "Loans Register";
        FOSAAccountsApp: record "Product Applications Details";
        LoanBatches: Record "Loan Disburesment-Batching";
        GuarantorSubstitution: Record "Guarantorship Substitution H";
        LeaveApplications: Record "HR Leave Application";
        FundsTransferHeader: Record "Funds Transfer Header";


    var
        Psalmkitswfevents: Codeunit "Custom Workflow Events";
        NoWorkflowEnabledErr: Label 'No Approval workflow for this record type is enabled';
        WorkflowManagement: Codeunit "Workflow Management";


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
        // exit(WorkflowManagement.CanExecuteWorkflow(LoansRegister, Psalmkitswfevents.RunWorkflowOnSendLoanApplicationForApprovalCode));
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


    //7)--------------------------------------------------------------------Send MembershipExit  Applications request For Approval start

    // procedure SendMembershipExitApplicationsRequestForApproval(MemberApplicationNo: Code[40]; var "Membership Exist": Record "Membership Exit")
    // begin
    //     if FnCheckIfMembershipExitApplicationApprovalsWorkflowEnabled(MembershipExit) then begin
    //         FnOnSendMembershipExitApplicationForApproval(MembershipExit);
    //     end;
    // end;

    // local procedure FnCheckIfMembershipExitApplicationApprovalsWorkflowEnabled(var "Membership Exist": Record "Membership Exit"): Boolean;
    // begin
    //     if not IsMembershipApplicationExitApprovalsWorkflowEnabled("Membership Exit") then
    //         Error(NoWorkflowEnabledErr);
    //     exit(true);
    // end;

    //.
    procedure CancelMembershipExitApplicationsRequestForApproval(MemberApplicationNo: Code[40]; var "Membership Exist": Record "Membership Exit")
    begin
        FnOnCancelMembershipExitApplicationApprovalRequest("Membership Exist");
    end;


    local procedure IsMembershipApplicationExitApprovalsWorkflowEnabled(var "Membership Exist": Record "Membership Exit"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow("Membership Exist", Psalmkitswfevents.RunWorkflowOnSendMembershipExitApplicationForApprovalCode));
    end;



    [IntegrationEvent(false, false)]

    procedure FnOnSendMembershipExitApplicationForApproval(var "Membership Exist": Record "Membership Exit")
    begin
    end;

    [IntegrationEvent(false, false)]

    procedure FnOnCancelMembershipExitApplicationApprovalRequest(var "Membership Exist": Record "Membership Exit")
    begin
    end;
    //------------------------------------------------------------------------------------------------------
    //7)--------------------------------------------------------------------Send Membership Applications request For Approval start
    procedure SendLeaveApplicationsRequestForApproval(LeaveApplicationNo: Code[40]; var "HR Leave Application": Record "HR Leave Application")
    begin
        if FnCheckIfLeaveApplicationApprovalsWorkflowEnabled("HR Leave Application") then begin
            FnOnSendLeaveApplicationForApproval("HR Leave Application");
        end;
    end;

    local procedure FnCheckIfLeaveApplicationApprovalsWorkflowEnabled(var "HR Leave Application": Record "HR Leave Application"): Boolean;
    begin
        if not IsLeaveApplicationApprovalsWorkflowEnabled("HR Leave Application") then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    //.
    procedure CancelLeaveApplicationsRequestForApproval(LeaveApplicationNo: Code[40]; var "HR Leave Application": Record "HR Leave Application")
    begin
        FnOnCancelLeaveApplicationApprovalRequest("HR Leave Application");
    end;


    local procedure IsLeaveApplicationApprovalsWorkflowEnabled(var LeaveApplication: Record "HR Leave Application"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(LeaveApplication, Psalmkitswfevents.RunWorkflowOnSendLeaveApplicationForApprovalCode));
    end;


    [IntegrationEvent(false, false)]

    procedure FnOnSendLeaveApplicationForApproval(var LeaveApplication: Record "HR Leave Application")
    begin
    end;

    [IntegrationEvent(false, false)]

    procedure FnOnCancelLeaveApplicationApprovalRequest(var LeaveApplication: Record "HR Leave Application")
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

    //...............................................................................
    //New FOSA Accounts Applications
    // procedure SendNewFOSAAccountApplicationsRequestForApproval(NewFOSAAccountApplicationNo: Code[40]; var "Product Applications Details": Record "Product Applications Details")
    // begin
    //     if FnCheckIfNewFOSAAccountApplicationApprovalsWorkflowEnabled("Product Applications Details") then begin
    //         FnOnSendNewFOSAAccountApplicationForApproval("Product Applications Details");
    //     end;
    // end;

    // local procedure FnCheckIfNewFOSAAccountApplicationApprovalsWorkflowEnabled(var "Product Applications Details": Record "Product Applications Details"): Boolean;
    // begin
    //     if not IsNewFOSAAccountApplicationApprovalsWorkflowEnabled("Product Applications Details") then
    //         Error(NoWorkflowEnabledErr);
    //     exit(true);
    // end;

    //.
    procedure CancelNewFOSAAccountApplicationsRequestForApproval(NewFOSAAccountApplicationNo: Code[40]; var "Product Applications Details": Record "Product Applications Details")
    begin
        FnOnCancelNewFOSAAccountApplicationApprovalRequest("Product Applications Details");
    end;




    [IntegrationEvent(false, false)]

    procedure FnOnSendNewFOSAAccountApplicationForApproval(var NewFOSAAccountApplication: Record "Product Applications Details")
    begin
    end;

    [IntegrationEvent(false, false)]

    procedure FnOnCancelNewFOSAAccountApplicationApprovalRequest(var NewFOSAAccountApplication: Record "Product Applications Details")
    begin
    end;
    //..................................................................................................

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
    //..................................................................................................
    //10)--------------------------------------------------------------------Send Teller request For Approval start
    // procedure SendTellerTransactionsRequestForApproval(TellerTransactions: Code[40]; var Transactions: Record Transactions)
    // begin
    //     if FnCheckIfTellerTransactionsApprovalsWorkflowEnabled(Transactions) then begin
    //         FnOnSendTellerTransactionsForApproval(Transactions);
    //     end;
    // end;

    // local procedure FnCheckIfTellerTransactionsApprovalsWorkflowEnabled(var Transactions: Record Transactions): Boolean;
    // begin
    //     if not IsTellerTransactionsApprovalsWorkflowEnabled(Transactions) then
    //         Error(NoWorkflowEnabledErr);
    //     exit(true);
    // end;

    //.
    procedure CancelTellerTransactionsRequestForApproval(TellerTransactions: Code[40]; var Transactions: Record Transactions)
    begin
        FnOnCancelTellerTransactionsApprovalRequest(Transactions);
    end;

    // local procedure IsTellerTransactionsApprovalsWorkflowEnabled(var TellerTransactions: Record Transactions): Boolean
    // begin
    //     exit(WorkflowManagement.CanExecuteWorkflow(TellerTransactions, Psalmkitswfevents.RunWorkflowOnSendTellerTransactionsForApprovalCode));
    // end;

    [IntegrationEvent(false, false)]

    procedure FnOnSendTellerTransactionsForApproval(var TellerTransactions: Record Transactions)
    begin
    end;

    [IntegrationEvent(false, false)]

    procedure FnOnCancelTellerTransactionsApprovalRequest(var TellerTransactions: Record Transactions)
    begin
    end;

    //------------------------------------------------------------------------------------------------------
    //11)Send STO For Approval Workflow
    // procedure SendSTOTransactionsRequestForApproval(STOTransactions: Code[40]; var "Standing Orders": Record "Standing Orders")
    // begin
    //     if FnCheckIfSTOTransactionsApprovalsWorkflowEnabled("Standing Orders") then begin
    //         FnOnSendSTOTransactionsForApproval("Standing Orders");
    //     end;
    // end;

    // local procedure FnCheckIfSTOTransactionsApprovalsWorkflowEnabled(var "Standing Orders": Record "Standing Orders"): Boolean;
    // begin
    //     if not IsSTOTransactionsApprovalsWorkflowEnabled("Standing Orders") then
    //         Error(NoWorkflowEnabledErr);
    //     exit(true);
    // end;

    //.
    procedure CancelSTOTransactionsRequestForApproval(STOTransactions: Code[40]; var "Standing Orders": Record "Standing Orders")
    begin
        FnOnCancelSTOTransactionsApprovalRequest("Standing Orders");
    end;

    // local procedure IsSTOTransactionsApprovalsWorkflowEnabled(var STOTransactions: Record "Standing Orders"): Boolean
    // begin
    //     exit(WorkflowManagement.CanExecuteWorkflow(STOTransactions, Psalmkitswfevents.RunWorkflowOnSendSTOTransactionsForApprovalCode));
    // end;

    [IntegrationEvent(false, false)]

    procedure FnOnSendSTOTransactionsForApproval(var STOTransactions: Record "Standing Orders")
    begin
    end;

    [IntegrationEvent(false, false)]

    procedure FnOnCancelSTOTransactionsApprovalRequest(var STOTransactions: Record "Standing Orders")
    begin
    end;
    //12 ATM Card Transactions................................................................................
    // procedure SendATMTransactionsRequestForApproval(ATMTransactions: Code[40]; var "ATM Card Applications": Record "ATM Card Applications")
    // begin
    //     if FnCheckIfATMTransactionsApprovalsWorkflowEnabled("ATM Card Applications") then begin
    //         FnOnSendATMTransactionsForApproval("ATM Card Applications");
    //     end;
    // end;

    // local procedure FnCheckIfATMTransactionsApprovalsWorkflowEnabled(var "ATM Card Applications": Record "ATM Card Applications"): Boolean;
    // begin
    //     if not IsATMTransactionsApprovalsWorkflowEnabled("ATM Card Applications") then
    //         Error(NoWorkflowEnabledErr);
    //     exit(true);
    // end;

    //.
    // procedure CancelATMTransactionsRequestForApproval(ATMTransactions: Code[40]; var "ATM Card Applications": Record "ATM Card Applications")
    // begin
    //     FnOnCancelATMTransactionsApprovalRequest("ATM Card Applications");
    // end;

    // local procedure IsATMTransactionsApprovalsWorkflowEnabled(var ATMTransactions: Record "ATM Card Applications"): Boolean
    // begin
    //     exit(WorkflowManagement.CanExecuteWorkflow(ATMTransactions, Psalmkitswfevents.RunWorkflowOnSendATMTransactionsForApprovalCode));
    // end;

    // [IntegrationEvent(false, false)]

    // procedure FnOnSendATMTransactionsForApproval(var ATMTransactions: Record "ATM Card Applications")
    // begin
    // end;

    // [IntegrationEvent(false, false)]

    // procedure FnOnCancelATMTransactionsApprovalRequest(var ATMTransactions: Record "ATM Card Applications")
    // begin
    // end;

    //13)--------------------------------------------------------------------Send BOSATransactions For Approval start
    procedure SendInternalTransfersTransactionsRequestForApproval(InternalTransfersTransactions: Code[40]; var SaccoTransfers: Record "Sacco Transfers")
    begin
        if FnCheckIfInternalTransfersTransactionsApprovalsWorkflowEnabled(SaccoTransfers) then begin
            FnOnSendInternalTransfersTransactionsForApproval(SaccoTransfers);
        end;
    end;

    local procedure FnCheckIfInternalTransfersTransactionsApprovalsWorkflowEnabled(var SaccoTransfers: Record "Sacco Transfers"): Boolean;
    begin
        if not IsInternalTransfersTransactionsApprovalsWorkflowEnabled(SaccoTransfers) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    //.
    procedure CancelInternalTransfersTransactionsRequestForApproval(InternalTransfersTransactions: Code[40]; var SaccoTransfers: Record "Sacco Transfers")
    begin
        FnOnCancelInternalTransfersTransactionsApprovalRequest(SaccoTransfers);
    end;

    local procedure IsInternalTransfersTransactionsApprovalsWorkflowEnabled(var InternalTransfersTransactions: Record "Sacco Transfers"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(InternalTransfersTransactions, Psalmkitswfevents.RunWorkflowOnSendInternalTransfersTransactionsForApprovalCode));
    end;

    [IntegrationEvent(false, false)]

    procedure FnOnSendInternalTransfersTransactionsForApproval(var InternalTransfersTransactions: Record "Sacco Transfers")
    begin
    end;

    [IntegrationEvent(false, false)]

    procedure FnOnCancelInternalTransfersTransactionsApprovalRequest(var InternalTransfersTransactions: Record "Sacco Transfers")
    begin
    end;



    //14)--------------------------------------------------------------------Send Payment voucher For Approval start
    procedure SendPaymentVoucherTransactionsRequestForApproval(PaymentVoucherTransactions: Code[40]; var PaymentHeader: Record "Payments Header")
    begin
        if FnCheckIfPaymentVoucherTransactionsApprovalsWorkflowEnabled(PaymentHeader) then begin
            FnOnSendPaymentVoucherTransactionsForApproval(PaymentHeader);
        end;
    end;

    local procedure FnCheckIfPaymentVoucherTransactionsApprovalsWorkflowEnabled(var PaymentHeader: Record "Payments Header"): Boolean;
    begin
        if not IsPaymentVoucherTransactionsApprovalsWorkflowEnabled(PaymentHeader) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    //.
    procedure CancelPaymentVoucherTransactionsRequestForApproval(PaymentVoucherTransactions: Code[40]; var PaymentHeader: Record "Payments Header")
    begin
        FnOnCancelPaymentVoucherTransactionsApprovalRequest(PaymentHeader);
    end;

    local procedure IsPaymentVoucherTransactionsApprovalsWorkflowEnabled(var PaymentVoucherTransactions: Record "Payments Header"): Boolean
    begin
        // exit(WorkflowManagement.CanExecuteWorkflow(PaymentVoucherTransactions, Psalmkitswfevents.RunWorkflowOnSendPaymentVoucherTransactionsForApprovalCode));
    end;

    [IntegrationEvent(false, false)]

    procedure FnOnSendPaymentVoucherTransactionsForApproval(var PaymentVoucherTransactions: Record "Payments Header")
    begin
    end;

    [IntegrationEvent(false, false)]

    procedure FnOnCancelPaymentVoucherTransactionsApprovalRequest(var PaymentVoucherTransactions: Record "Payments Header")
    begin
    end;
    //----My Payment Header Workflow implementation-------//

    //----------------------------------------------------------------Send for Appproval Implementation-------------------------------///
    procedure SendPaymentHeaderForApprovalCode(InternalTransactionTransfer: Code[40]; var PaymentHeader: Record "Payments Header")
    begin
        if FnCheckIfPaymentHeaderApprovalsWorkflowEnabled(PaymentHeader) then begin
            FnOnSendPaymentHeaderForApprovalCode(PaymentHeader);
        end;

    end;

    local procedure FnCheckIfPaymentHeaderApprovalsWorkflowEnabled(var PaymentHeader: Record "Payments Header"): Boolean;
    begin
        if not IsPaymentHeaderApprovalsWorkflowEnabled(PaymentHeader) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    local procedure IsPaymentHeaderApprovalsWorkflowEnabled(var InternalTransfersTransactions: Record "Payments Header"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(InternalTransfersTransactions, Psalmkitswfevents.RunWorkflowOnSendPaymentHeaderForApprovalCode));
    end;

    [IntegrationEvent(false, false)]
    procedure FnOnSendPaymentHeaderForApprovalCode(var InternalTransactions: Record "Payments Header")
    begin
    end;

    // ---------------------------------------  end of send Approval----------------------------------------------------------///

    //--------------------------------- Cancel the Payment Head Start ---------------------------------------------//    
    procedure CancelPaymentHeaderApprovalCode(InternalTransactionTransfer: Code[40]; var PaymentHeader: Record "Payments Header")
    begin
        FnOnCancelPaymentHeaderApprovalCode(PaymentHeader);
    end;

    [IntegrationEvent(false, false)]
    procedure FnOnCancelPaymentHeaderApprovalCode(var InternalTransactions: Record "Payments Header")
    begin
    end;

    // ---------------------------------------------- end of cancel Payment header -----------------------------------//
}

