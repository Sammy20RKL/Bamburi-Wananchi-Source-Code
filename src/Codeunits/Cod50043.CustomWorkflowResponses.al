
codeunit 50043 "Custom Workflow Responses"
{

    trigger OnRun()
    begin
    end;

    var
        WFEventHandler: Codeunit "Workflow Event Handling";
        SwizzsoftWFEvents: Codeunit "Custom Workflow Events";
        WFResponseHandler: Codeunit "Workflow Response Handling";
        MsgToSend: Text[250];
        CompanyInfo: Record "Company Information";


    procedure AddResponsesToLib()
    begin
        AddResponsePredecessors();
    end;


    procedure AddResponsePredecessors()
    begin

        // Payment Header
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
         SwizzsoftWFEvents.RunWorkflowOnSendPaymentHeaderForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SwizzsoftWFEvents.RunWorkflowOnSendPaymentHeaderForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SwizzsoftWFEvents.RunWorkflowOnSendPaymentHeaderForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SwizzsoftWFEvents.RunWorkflowOnCancelPaymentHeaderApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SwizzsoftWFEvents.RunWorkflowOnCancelPaymentHeaderApprovalCode);

        //Membership Application
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SwizzsoftWFEvents.RunWorkflowOnSendMembershipApplicationForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SwizzsoftWFEvents.RunWorkflowOnSendMembershipApplicationForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SwizzsoftWFEvents.RunWorkflowOnSendMembershipApplicationForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SwizzsoftWFEvents.RunWorkflowOnCancelMembershipApplicationApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SwizzsoftWFEvents.RunWorkflowOnCancelMembershipApplicationApprovalRequestCode);
        //Loan Application
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SwizzsoftWFEvents.RunWorkflowOnSendLoanApplicationForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SwizzsoftWFEvents.RunWorkflowOnSendLoanApplicationForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SwizzsoftWFEvents.RunWorkflowOnSendLoanApplicationForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SwizzsoftWFEvents.RunWorkflowOnCancelLoanApplicationApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SwizzsoftWFEvents.RunWorkflowOnCancelLoanApplicationApprovalRequestCode);

        //Loan Disbursement
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
        //                                          SwizzsoftWFEvents.RunWorkflowOnSendLoanDisbursementForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
        //                                          SwizzsoftWFEvents.RunWorkflowOnSendLoanDisbursementForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
        //                                          SwizzsoftWFEvents.RunWorkflowOnSendLoanDisbursementForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
        //                                          SwizzsoftWFEvents.RunWorkflowOnCancelLoanDisbursementApprovalRequestCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
        //                                          SwizzsoftWFEvents.RunWorkflowOnCancelLoanDisbursementApprovalRequestCode);

        //Membership Re-Application
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SwizzsoftWFEvents.RunWorkflowOnSendMemberReapplicationForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SwizzsoftWFEvents.RunWorkflowOnSendMemberReapplicationForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SwizzsoftWFEvents.RunWorkflowOnSendMemberReapplicationForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SwizzsoftWFEvents.RunWorkflowOnCancelMemberReapplicationApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SwizzsoftWFEvents.RunWorkflowOnCancelMemberReapplicationApprovalRequestCode);


        //Membership Withdrawal
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SwizzsoftWFEvents.RunWorkflowOnSendMembershipExitApplicationForApprovalCode());
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SwizzsoftWFEvents.RunWorkflowOnSendMembershipExitApplicationForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SwizzsoftWFEvents.RunWorkflowOnSendMembershipExitApplicationForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SwizzsoftWFEvents.RunWorkflowOnCancelMembershipApplicationApprovalRequestCode());
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SwizzsoftWFEvents.RunWorkflowOnCancelMembershipApplicationApprovalRequestCode);

        //ATM Card Application
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
        //                                          SwizzsoftWFEvents.RunWorkflowOnSendATMCardForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
        //                                          SwizzsoftWFEvents.RunWorkflowOnSendATMCardForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
        //                                          SwizzsoftWFEvents.RunWorkflowOnSendATMCardForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
        //                                          SwizzsoftWFEvents.RunWorkflowOnCancelATMCardApprovalRequestCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
        //                                          SwizzsoftWFEvents.RunWorkflowOnCancelATMCardApprovalRequestCode);

        //Guarantor Recovery
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
        //                                          SwizzsoftWFEvents.RunWorkflowOnSendGuarantorRecoveryForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
        //                                          SwizzsoftWFEvents.RunWorkflowOnSendGuarantorRecoveryForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
        //                                          SwizzsoftWFEvents.RunWorkflowOnSendGuarantorRecoveryForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
        //                                          SwizzsoftWFEvents.RunWorkflowOnCancelGuarantorRecoveryApprovalRequestCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
        //                                          SwizzsoftWFEvents.RunWorkflowOnCancelGuarantorRecoveryApprovalRequestCode);

        //Change Request
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SwizzsoftWFEvents.RunWorkflowOnSendMemberChangeRequestForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SwizzsoftWFEvents.RunWorkflowOnSendMemberChangeRequestForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SwizzsoftWFEvents.RunWorkflowOnSendMemberChangeRequestForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SwizzsoftWFEvents.RunWorkflowOnCancelMemberChangeRequestApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SwizzsoftWFEvents.RunWorkflowOnCancelMemberChangeRequestApprovalRequestCode);

        //13. Sacco Transfers
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode, SwizzsoftWFEvents.RunWorkflowOnSendInternalTransfersTransactionsForApprovalCode);

        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode, SwizzsoftWFEvents.RunWorkflowOnSendInternalTransfersTransactionsForApprovalCode);

        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode, SwizzsoftWFEvents.RunWorkflowOnSendInternalTransfersTransactionsForApprovalCode);


        //Cheque Discounting
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
        //                                          SwizzsoftWFEvents.RunWorkflowOnSendChequeDiscountingForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
        //                                          SwizzsoftWFEvents.RunWorkflowOnSendChequeDiscountingForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
        //                                          SwizzsoftWFEvents.RunWorkflowOnSendChequeDiscountingForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
        //                                          SwizzsoftWFEvents.RunWorkflowOnCancelChequeDiscountingApprovalRequestCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
        //                                          SwizzsoftWFEvents.RunWorkflowOnCancelChequeDiscountingApprovalRequestCode);

        // //Imprest Requisition
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
        //                                          SwizzsoftWFEvents.RunWorkflowOnSendImprestRequisitionForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
        //                                          SwizzsoftWFEvents.RunWorkflowOnSendImprestRequisitionForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
        //                                          SwizzsoftWFEvents.RunWorkflowOnSendImprestRequisitionForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
        //                                          SwizzsoftWFEvents.RunWorkflowOnCancelImprestRequisitionApprovalRequestCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
        //                                          SwizzsoftWFEvents.RunWorkflowOnCancelImprestRequisitionApprovalRequestCode);

        //Imprest Surrender
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
        //                                          SwizzsoftWFEvents.RunWorkflowOnSendImprestSurrenderForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
        //                                          SwizzsoftWFEvents.RunWorkflowOnSendImprestSurrenderForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
        //                                          SwizzsoftWFEvents.RunWorkflowOnSendImprestSurrenderForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
        //                                          SwizzsoftWFEvents.RunWorkflowOnCancelImprestSurrenderApprovalRequestCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
        //                                          SwizzsoftWFEvents.RunWorkflowOnCancelImprestSurrenderApprovalRequestCode);

        //Leave Application
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SwizzsoftWFEvents.RunWorkflowOnSendLeaveApplicationForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SwizzsoftWFEvents.RunWorkflowOnSendLeaveApplicationForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SwizzsoftWFEvents.RunWorkflowOnSendLeaveApplicationForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SwizzsoftWFEvents.RunWorkflowOnCancelLeaveApplicationApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SwizzsoftWFEvents.RunWorkflowOnCancelLeaveApplicationApprovalRequestCode);
        //Bulk Withdrawal
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
        //                                          SwizzsoftWFEvents.RunWorkflowOnSendBulkWithdrawalForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
        //                                          SwizzsoftWFEvents.RunWorkflowOnSendBulkWithdrawalForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
        //                                          SwizzsoftWFEvents.RunWorkflowOnSendBulkWithdrawalForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
        //                                          SwizzsoftWFEvents.RunWorkflowOnCancelBulkWithdrawalApprovalRequestCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
        //                                          SwizzsoftWFEvents.RunWorkflowOnCancelBulkWithdrawalApprovalRequestCode);

        //Petty Cash
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SwizzsoftWFEvents.RunWorkflowOnSendPettyCashReimbersementForApprovalCode());
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SwizzsoftWFEvents.RunWorkflowOnSendPettyCashReimbersementForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SwizzsoftWFEvents.RunWorkflowOnSendPettyCashReimbersementForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SwizzsoftWFEvents.RunWorkflowOnCancelPettyCashReimbersementApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
         SwizzsoftWFEvents.RunWorkflowOnCancelPettyCashReimbersementApprovalRequestCode());

        // //Staff Claims
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
        //                                          SwizzsoftWFEvents.RunWorkflowOnSendStaffClaimsForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
        //                                          SwizzsoftWFEvents.RunWorkflowOnSendStaffClaimsForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
        //                                          SwizzsoftWFEvents.RunWorkflowOnSendStaffClaimsForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
        //                                          SwizzsoftWFEvents.RunWorkflowOnCancelStaffClaimsApprovalRequestCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
        // SwizzsoftWFEvents.RunWorkflowOnCancelStaffClaimsApprovalRequestCode);

        //Member Agent/NOK Change
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
        //                                          SwizzsoftWFEvents.RunWorkflowOnSendMemberAgentNOKChangeForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
        //                                          SwizzsoftWFEvents.RunWorkflowOnSendMemberAgentNOKChangeForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
        //                                          SwizzsoftWFEvents.RunWorkflowOnSendMemberAgentNOKChangeForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
        //                                          SwizzsoftWFEvents.RunWorkflowOnCancelMemberAgentNOKChangeApprovalRequestCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
        //                                          SwizzsoftWFEvents.RunWorkflowOnCancelMemberAgentNOKChangeApprovalRequestCode);

        //House Registration
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
        //                                          SwizzsoftWFEvents.RunWorkflowOnSendHouseRegistrationForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
        //                                          SwizzsoftWFEvents.RunWorkflowOnSendHouseRegistrationForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
        //                                          SwizzsoftWFEvents.RunWorkflowOnSendHouseRegistrationForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
        //                                          SwizzsoftWFEvents.RunWorkflowOnCancelHouseRegistrationApprovalRequestCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
        //  SwizzsoftWFEvents.RunWorkflowOnCancelHouseRegistrationApprovalRequestCode);

        //Loan Payoff
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
        //                                          SwizzsoftWFEvents.RunWorkflowOnSendLoanPayOffForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
        //                                          SwizzsoftWFEvents.RunWorkflowOnSendLoanPayOffForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
        //                                          SwizzsoftWFEvents.RunWorkflowOnSendLoanPayOffForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
        //                                          SwizzsoftWFEvents.RunWorkflowOnCancelLoanPayOffApprovalRequestCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
        //  SwizzsoftWFEvents.RunWorkflowOnCancelLoanPayOffApprovalRequestCode);

        //Fixed Deposit
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
        //                                          SwizzsoftWFEvents.RunWorkflowOnSendFixedDepositForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
        //                                          SwizzsoftWFEvents.RunWorkflowOnSendFixedDepositForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
        //                                          SwizzsoftWFEvents.RunWorkflowOnSendFixedDepositForApprovalCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
        //                                          SwizzsoftWFEvents.RunWorkflowOnCancelFixedDepositApprovalRequestCode);
        // WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
        // SwizzsoftWFEvents.RunWorkflowOnCancelFixedDepositApprovalRequestCode);

        //-----------------------------End AddOn--------------------------------------------------------------------------------------
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnExecuteWorkflowResponse', '', true, true)]
    procedure SetStatusToPendingApproval(var Variant: Variant)
    var
        RecRef: RecordRef;
        IsHandled: Boolean;
        MembershipApplication: Record "Membership Applications";
        LoansRegister: Record "Loans Register";
        BOSATransfers: Record "BOSA Transfers";
        LoanBatchDisbursements: Record "Loan Disburesment-Batching";
        ChangeRequest: Record "Change Request";
        LeaveApplication: Record "HR Leave Application";
        GuarantorSubstitution: Record "Guarantorship Substitution H";
        PettyCashReimbersement: Record "Funds Transfer Header";
        NewFOSAAccountApplication: RECORD "Product Applications Details";
        TransactionsTable: Record Transactions;
        STOTransactions: record "Standing Orders";
        // ATMApplications: record "ATM Card Applications";
        SaccoTransfers: record "Sacco Transfers";
        PaymentVoucher: record "Payment Header";
    begin
        case RecRef.Number of
            //Payment Header
            Database::"Payments Header":
                begin
                    RecRef.SetTable(PaymentVoucher);
                    PaymentVoucher.Validate(Status, PaymentVoucher.Status::"Pending Approval");
                    PaymentVoucher.Modify(true);
                    Variant := PaymentVoucher;
                end;
            //SaccoTransfers
            Database::"Sacco Transfers":
                begin
                    RecRef.SetTable(SaccoTransfers);
                    SaccoTransfers.Validate(Status, SaccoTransfers.Status::Pending);
                    SaccoTransfers.Modify(true);
                    Variant := SaccoTransfers;

                end;
            Database::"Funds Transfer Header":
                begin
                    RecRef.SetTable(PettyCashReimbersement);
                    PettyCashReimbersement.Validate(Status, PettyCashReimbersement.Status::"Pending Approval");
                    PettyCashReimbersement.Modify(true);
                    Variant := PettyCashReimbersement;
                end;
            //Standing Orders
            Database::"Standing Orders":
                begin
                    RecRef.SetTable(STOTransactions);
                    STOTransactions.Validate(Status, STOTransactions.Status::Pending);
                    STOTransactions.Modify(true);
                    Variant := STOTransactions;
                end;
            //Guarantor Substitution
            Database::"Guarantorship Substitution H":
                begin
                    RecRef.SetTable(GuarantorSubstitution);
                    GuarantorSubstitution.Validate(Status, GuarantorSubstitution.Status::Pending);
                    GuarantorSubstitution.Modify(true);
                    Variant := GuarantorSubstitution;
                end;
            //Leave Application
            Database::"HR Leave Application":
                begin
                    RecRef.SetTable(LeaveApplication);
                    LeaveApplication.Validate(Status, LeaveApplication.Status::Pending);
                    LeaveApplication.Modify(true);
                    Variant := LeaveApplication;
                end;
            //Membership Application
            Database::"Membership Applications":
                begin
                    RecRef.SetTable(MembershipApplication);
                    MembershipApplication.Validate(Status, MembershipApplication.Status::"Pending Approval");
                    MembershipApplication."Sent for Approval By" := UserId;
                    MembershipApplication.Status := MembershipApplication.Status::"Pending Approval";
                    MembershipApplication."Approval Status" := MembershipApplication."Approval Status"::open;// Pending;
                    MembershipApplication."Membership Application Status" := MembershipApplication."Membership Application Status"::Pending;
                    MembershipApplication.Modify(true);
                    Variant := MembershipApplication;
                end;
            //New FOSA Product Application
            Database::"Product Applications Details":
                begin
                    RecRef.SetTable(NewFOSAAccountApplication);
                    NewFOSAAccountApplication.Validate(Status, NewFOSAAccountApplication.Status::Pending);
                    NewFOSAAccountApplication."Sent for Approval By" := UserId;
                    NewFOSAAccountApplication.Status := NewFOSAAccountApplication.Status::Pending;
                    NewFOSAAccountApplication.Modify(true);
                    Variant := NewFOSAAccountApplication;
                end;
            //Loan Application
            Database::"Loans Register":
                begin
                    RecRef.SetTable(LoansRegister);
                    LoansRegister.Validate("Approval Status", LoansRegister."Approval Status"::Pending);
                    LoansRegister.Validate("loan status", LoansRegister."loan status"::Appraisal);
                    LoansRegister.Modify(true);
                    Variant := LoansRegister;
                end;
            //BOSA Transfers
            Database::"BOSA Transfers":
                begin
                    RecRef.SetTable(BOSATransfers);
                    BOSATransfers.Approved := true;
                    BOSATransfers.Modify(true);
                    Variant := BOSATransfers;
                end;
            //Loan Batch Disbursements
            Database::"Loan Disburesment-Batching":
                begin
                    RecRef.SetTable(LoanBatchDisbursements);
                    LoanBatchDisbursements.Validate(status, LoanBatchDisbursements.status::"Pending Approval");
                    LoanBatchDisbursements.Modify(true);
                    Variant := LoanBatchDisbursements;
                end;
            //Change Request
            Database::"Change Request":
                begin
                    RecRef.SetTable(ChangeRequest);
                    ChangeRequest.Validate(status, ChangeRequest.Status::Pending);
                    ChangeRequest.Modify(true);
                    Variant := ChangeRequest;
                end;
            //Teller Transaction
            Database::Transactions:
                begin
                    RecRef.SetTable(TransactionsTable);
                    TransactionsTable.Validate(status, TransactionsTable.Status::Pending);
                    TransactionsTable.Modify(true);
                    Variant := TransactionsTable;
                end;

        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnOpenDocument', '', true, true)]
    local procedure OnOpenDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        MembershipApplication: Record "Membership Applications";
        LoansRegister: Record "Loans Register";
        BOSATransfers: Record "BOSA Transfers";
        LoanBatchDisbursements: Record "Loan Disburesment-Batching";
        LoanTopUp: Record "Loan Top Up.";
        ChangeRequest: Record "Change Request";
        // LeaveApplication: Record "HR Leave Application";
        GuarantorSubstitution: Record "Guarantorship Substitution H";
        PaymentVoucher: Record "Payments Header";
        PettyCashReimbersement: Record "Funds Transfer Header";
        FOSAProductApplication: Record "Accounts Applications Details";
        LoanRecoveryApplication: Record "Loan Recovery Header";
        CEEPChangeRequest: Record "CEEP Change Request";
        MembershipExist: Record "Membership Exist";
        MemberReapplication: Record "Member Reapplication";
        SaccoTransfers: Record "Sacco Transfers";

    begin
        case RecRef.Number of
            //Member Reapplication
            Database::"Member Reapplication":
                begin
                    RecRef.SetTable(MemberReapplication);
                    MemberReapplication.Validate(Status, MemberReapplication.Status::Open);
                    MemberReapplication.Modify(true);
                    Handled := true;
                end;
            //Member Exit
            Database::"Membership Exist":
                begin
                    RecRef.SetTable(MembershipExist);
                    MembershipExist.Validate(Status, MembershipExist.Status::Open);
                    MembershipExist.Modify(true);
                    Handled := true;
                end;
            //Pettycash payment
            DATABASE::"Funds Transfer Header":
                begin
                    RecRef.SetTable(PettyCashReimbersement);
                    PettyCashReimbersement.Status := PettyCashReimbersement.Status::Open;
                    PettyCashReimbersement.Modify(true);
                    Handled := true;
                end;
            //Payment Voucher
            DATABASE::"Payments Header":
                begin
                    RecRef.SetTable(PaymentVoucher);
                    PaymentVoucher.Status := PaymentVoucher.Status::New;
                    PaymentVoucher.Modify(true);
                    Handled := true;
                end;
            //Guarantor Substitution
            DATABASE::"Guarantorship Substitution H":
                begin
                    RecRef.SetTable(GuarantorSubstitution);
                    GuarantorSubstitution.Status := GuarantorSubstitution.Status::Open;
                    GuarantorSubstitution.Modify(true);
                    Handled := true;
                end;
            //Leave Application
            // DATABASE::"HR Leave Application":
            //     begin
            //         RecRef.SetTable(LeaveApplication);
            //         LeaveApplication.Status := LeaveApplication.Status::New;
            //         LeaveApplication.Modify(true);
            //         Handled := true;
            //     end;
            //Membership Application
            DATABASE::"Membership Applications":
                begin
                    RecRef.SetTable(MembershipApplication);
                    MembershipApplication.Status := MembershipApplication.Status::Open;
                    MembershipApplication.Modify(true);
                    Handled := true;
                end;
            //Loan Application
            Database::"Loans Register":
                begin
                    RecRef.SetTable(LoansRegister);
                    LoansRegister."Approval Status" := LoansRegister."Approval Status"::Open;
                    LoansRegister.Validate("loan status", LoansRegister."loan status"::Application);
                    LoansRegister.Modify(true);
                    Handled := true;
                end;
            //BOSA Transfers
            Database::"BOSA Transfers":
                begin
                    RecRef.SetTable(BOSATransfers);
                    BOSATransfers.Status := BOSATransfers.Status::Open;
                    BOSATransfers.Modify(true);
                    Handled := true;
                end;
            //Loan Batch Disbursements
            Database::"Loan Disburesment-Batching":
                begin
                    RecRef.SetTable(LoanBatchDisbursements);
                    LoanBatchDisbursements.status := LoanBatchDisbursements.status::Open;
                    LoanBatchDisbursements.Modify(true);
                    Handled := true;
                end;
            //Loan TopUp
            Database::"Loan Top Up.":
                begin
                    RecRef.SetTable(LoanTopUp);
                    LoanTopUp.status := LoanTopUp.status::Open;
                    LoanTopUp.Modify(true);
                    Handled := true;
                end;
            //CEEP Change Request
            Database::"CEEP Change Request":
                begin
                    RecRef.SetTable(CEEPChangeRequest);
                    CEEPChangeRequest.status := CEEPChangeRequest.status::Open;
                    CEEPChangeRequest.Modify(true);
                    Handled := true;
                end;
            //Change Request
            Database::"Change Request":
                begin
                    RecRef.SetTable(ChangeRequest);
                    ChangeRequest.status := ChangeRequest.status::Open;
                    ChangeRequest.Modify(true);
                    Handled := true;
                end;
            //FOSA Product Application
            DATABASE::"Accounts Applications Details":
                begin
                    RecRef.SetTable(FOSAProductApplication);
                    FOSAProductApplication.Status := FOSAProductApplication.Status::Open;
                    FOSAProductApplication.Modify(true);
                    Handled := true;
                end;
            //Loan Recovery Application
            DATABASE::"Loan Recovery Header":
                begin
                    RecRef.SetTable(LoanRecoveryApplication);
                    LoanRecoveryApplication.Status := LoanRecoveryApplication.Status::Open;
                    LoanRecoveryApplication.Modify(true);
                    Handled := true;
                end;

            //SaccoTransfers
            DATABASE::"Sacco Transfers":
                begin
                    RecRef.SetTable(SaccoTransfers);
                    SaccoTransfers.Status := SaccoTransfers.Status::Open;
                    SaccoTransfers.Modify(true);
                    Handled := true;
                end;
        end

    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Approvals Mgmt.", 'OnSetStatusToPendingApproval', '', false, false)]
    procedure OnSetStatusToPendingApproval(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var
        MembershipApplication: Record "Membership Applications";
        LoansRegister: Record "Loans Register";
        BOSATransfers: Record "BOSA Transfers";
        LoanBatchDisbursements: Record "Loan Disburesment-Batching";
        LoanTopUp: Record "Loan Top Up.";
        ChangeRequest: Record "Change Request";
        // LeaveApplication: Record "HR Leave Application";
        GuarantorSubstitution: Record "Guarantorship Substitution H";
        PaymentVoucher: Record "Payments Header";
        PettyCashReimbersement: Record "Funds Transfer Header";
        FOSAProductApplication: Record "Accounts Applications Details";
        LoanRecoveryApplication: Record "Loan Recovery Header";
        CEEPChangeRequest: Record "CEEP Change Request";
        MembershipExist: Record "Membership Exist";
        MemberReapplication: Record "Member Reapplication";
        SaccoTransfers: Record "Sacco Transfers";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of
            //Membership Reapplication
            Database::"Member Reapplication":
                begin
                    RecRef.SetTable(MemberReapplication);
                    MemberReapplication.Validate(Status, MemberReapplication.Status::Pending);
                    MemberReapplication.Modify(true);
                    IsHandled := true;
                end;
            //Membership exit
            Database::"Membership Exist":
                begin
                    RecRef.SetTable(MembershipExist);
                    MembershipExist.Validate(Status, MembershipExist.Status::Pending);
                    MembershipExist.Modify(true);
                    IsHandled := true;
                end;
            //PettyCash Reimbursement
            Database::"Funds Transfer Header":
                begin
                    RecRef.SetTable(PettyCashReimbersement);
                    PettyCashReimbersement.Validate(Status, PettyCashReimbersement.Status::"Pending Approval");
                    PettyCashReimbersement.Modify(true);
                    IsHandled := true;
                end;
            //Payment Voucher
            Database::"Payments Header":
                begin
                    RecRef.SetTable(PaymentVoucher);
                    PaymentVoucher.Validate(Status, PaymentVoucher.Status::"Pending Approval");
                    PaymentVoucher.Modify(true);
                    IsHandled := true;
                end;
            //Guarantor Substitution
            Database::"Guarantorship Substitution H":
                begin
                    RecRef.SetTable(GuarantorSubstitution);
                    GuarantorSubstitution.Validate(Status, GuarantorSubstitution.Status::Pending);
                    GuarantorSubstitution.Modify(true);
                    IsHandled := true;
                end;
            //Leave Application
            // Database::"HR Leave Application":
            //     begin
            //         RecRef.SetTable(LeaveApplication);
            //         LeaveApplication.Validate(Status, LeaveApplication.Status::"Pending Approval");
            //         LeaveApplication.Modify(true);
            //         IsHandled := true;
            //     end;
            //Membership Application
            Database::"Membership Applications":
                begin
                    RecRef.SetTable(MembershipApplication);
                    MembershipApplication.Validate(Status, MembershipApplication.Status::"Pending Approval");
                    MembershipApplication.Modify(true);
                    IsHandled := true;
                end;
            //FOSA Product Application
            Database::"Accounts Applications Details":
                begin
                    RecRef.SetTable(FOSAProductApplication);
                    FOSAProductApplication.Validate(Status, FOSAProductApplication.Status::Pending);
                    FOSAProductApplication.Modify(true);
                    IsHandled := true;
                end;

            // Loan Application
            Database::"Loans Register":
                begin
                    RecRef.SetTable(LoansRegister);
                    if LoansRegister.Get(LoansRegister."Loan  No.") then begin
                        LoansRegister.Validate("Approval Status", LoansRegister."Approval Status"::Pending);
                        LoansRegister.Validate("loan status", LoansRegister."loan status"::Appraisal);
                        LoansRegister.Modify(true);  // Ensure record is not outdated
                        //Variant := LoansRegister;
                        IsHandled := true;
                    end;
                end;


            //BOSA Transfers
            Database::"BOSA Transfers":
                begin
                    RecRef.SetTable(BOSATransfers);
                    BOSATransfers.Validate(Status, BOSATransfers.Status::"Pending Approval");
                    BOSATransfers.Modify(true);
                    IsHandled := true;
                end;
            //Loan Batch Disbursements
            Database::"Loan Disburesment-Batching":
                begin
                    RecRef.SetTable(LoanBatchDisbursements);
                    LoanBatchDisbursements.Validate(Status, LoanBatchDisbursements.Status::"Pending Approval");
                    LoanBatchDisbursements.Modify(true);
                    IsHandled := true;
                end;
            //Loan TopUp
            Database::"Loan Top Up.":
                begin
                    RecRef.SetTable(LoanTopUp);
                    LoanTopUp.Validate(Status, LoanTopUp.Status::Pending);
                    LoanTopUp.Modify(true);
                    IsHandled := true;
                end;
            //CEEP Change Request
            Database::"CEEP Change Request":
                begin
                    RecRef.SetTable(CEEPChangeRequest);
                    CEEPChangeRequest.Validate(Status, CEEPChangeRequest.Status::Pending);
                    CEEPChangeRequest.Modify(true);
                    IsHandled := true;
                end;
            //Change Request
            Database::"Change Request":
                begin
                    RecRef.SetTable(ChangeRequest);
                    ChangeRequest.Validate(Status, ChangeRequest.Status::Pending);
                    ChangeRequest.Modify(true);
                    IsHandled := true;
                end;
            //Loan Recovery Application
            Database::"Loan Recovery Header":
                begin
                    RecRef.SetTable(LoanRecoveryApplication);
                    LoanRecoveryApplication.Validate(Status, LoanRecoveryApplication.Status::Pending);
                    LoanRecoveryApplication.Modify(true);
                    IsHandled := true;
                end;
            //SaccoTransfers
            Database::"Sacco Transfers":
                begin
                    RecRef.SetTable(SaccoTransfers);
                    SaccoTransfers.Validate(Status, SaccoTransfers.Status::Pending);
                    SaccoTransfers.Modify(true);
                    IsHandled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', true, true)]
    local procedure OnReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        MemberShipApp: Record "Membership Applications";
        LoansRegister: Record "Loans Register";
        BOSATransfers: Record "BOSA Transfers";
        LoanBatchDisbursements: Record "Loan Disburesment-Batching";
        LoanTopUp: Record "Loan Top Up.";
        ChangeRequest: Record "Change Request";
        GuarantorSubstitution: Record "Guarantorship Substitution H";
        PaymentVoucher: Record "Payments Header";
        PettyCashReimbersement: Record "Funds Transfer Header";
        FOSAProductApplication: Record "Accounts Applications Details";
        LoanRecoveryApplication: Record "Loan Recovery Header";
        CEEPChangeRequest: Record "CEEP Change Request";
        MembershipExist: Record "Membership Exist";
        MemberReapplication: Record "Member Reapplication";
        SaccoTransfers: Record "Sacco Transfers";
    begin
        case RecRef.Number of
            //Membership Reapplication
            DATABASE::"Member Reapplication":
                begin
                    RecRef.SetTable(MemberReapplication);
                    MemberReapplication.Status := MemberReapplication.Status::Approved;
                    MemberReapplication.Modify(true);
                    Handled := true;
                end;
            //Membership Exit
            DATABASE::"Membership Exist":
                begin
                    RecRef.SetTable(MembershipExist);
                    MembershipExist.Status := MembershipExist.Status::Approved;
                    MembershipExist.Modify(true);
                    Handled := true;
                end;
            //Petty Cash Reimbursement
            DATABASE::"Funds Transfer Header":
                begin
                    RecRef.SetTable(PettyCashReimbersement);
                    PettyCashReimbersement.Status := PettyCashReimbersement.Status::Approved;
                    PettyCashReimbersement.Modify(true);
                    Handled := true;
                end;
            //"Payment Header"
            DATABASE::"Payments Header":
                begin
                    RecRef.SetTable(PaymentVoucher);
                    PaymentVoucher.Status := PaymentVoucher.Status::Approved;
                    PaymentVoucher.Modify(true);
                    Handled := true;
                end;
            //"Guarantorship Substitution H"
            DATABASE::"Guarantorship Substitution H":
                begin
                    RecRef.SetTable(GuarantorSubstitution);
                    GuarantorSubstitution.Status := GuarantorSubstitution.Status::Approved;
                    GuarantorSubstitution.Modify(true);
                    Handled := true;
                end;

            //Membership applications
            DATABASE::"Membership Applications":
                begin
                    RecRef.SetTable(MemberShipApp);
                    MemberShipApp.Status := MemberShipApp.Status::Approved;
                    MemberShipApp.Modify(true);
                    Handled := true;
                end;
            //FOSA Product applications
            DATABASE::"Accounts Applications Details":
                begin
                    RecRef.SetTable(FOSAProductApplication);
                    FOSAProductApplication.Status := FOSAProductApplication.Status::Approved;
                    FOSAProductApplication.Modify(true);
                    Handled := true;
                end;
            //Loans Applications
            Database::"Loans Register":
                begin
                    RecRef.SetTable(LoansRegister);
                    if LoansRegister.Get(LoansRegister."Loan  No.") then begin
                        LoansRegister.Validate("Approval Status", LoansRegister."Approval Status"::Approved);
                        LoansRegister.Validate("loan status", LoansRegister."loan status"::Approved);
                        LoansRegister.Modify(true);  // Ensure record is not outdated
                        Handled := true;
                    end;
                end;

            //BOSA Transfers
            DATABASE::"BOSA Transfers":
                begin
                    RecRef.SetTable(BOSATransfers);
                    BOSATransfers.Status := BOSATransfers.Status::Approved;
                    BOSATransfers."Approved By" := UserId;
                    BOSATransfers.Modify(true);
                    Handled := true;
                end;
            //Loan Batching
            DATABASE::"Loan Disburesment-Batching":
                begin
                    RecRef.SetTable(LoanBatchDisbursements);
                    LoanBatchDisbursements.Status := LoanBatchDisbursements.Status::Approved;
                    LoanBatchDisbursements.Modify(true);
                    Handled := true;
                end;
            //Loan TopUp
            DATABASE::"Loan Top Up.":
                begin
                    RecRef.SetTable(LoanTopUp);
                    LoanTopUp.Status := LoanTopUp.Status::Approved;
                    LoanTopUp.Modify(true);
                    Handled := true;
                end;
            //Change Request
            DATABASE::"Change Request":
                begin
                    RecRef.SetTable(ChangeRequest);
                    ChangeRequest.Status := ChangeRequest.Status::Approved;
                    ChangeRequest.Modify(true);
                    Handled := true;
                end;
            //CEEP Change Request
            DATABASE::"CEEP Change Request":
                begin
                    RecRef.SetTable(CEEPChangeRequest);
                    CEEPChangeRequest.Status := CEEPChangeRequest.Status::Approved;
                    CEEPChangeRequest."Approved by" := UserId;
                    CEEPChangeRequest."Approval Date" := Today;
                    CEEPChangeRequest.Modify(true);
                    Handled := true;
                end;
            //Loan Recovery applications
            DATABASE::"Loan Recovery Header":
                begin
                    RecRef.SetTable(LoanRecoveryApplication);
                    LoanRecoveryApplication.Status := LoanRecoveryApplication.Status::Approved;
                    LoanRecoveryApplication.Modify(true);
                    Handled := true;
                end;
            //"Sacco Transfers"
            DATABASE::"Sacco Transfers":
                begin
                    RecRef.SetTable(SaccoTransfers);
                    SaccoTransfers.Status := SaccoTransfers.Status::Approved;
                    SaccoTransfers.Modify(true);
                    Handled := true;
                end;
        end;

    end;
}
