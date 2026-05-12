#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50933 "Bulk Withdrawal Appl card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Bulk Withdrawal Application";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Transaction No"; Rec."Transaction No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic;
                    // Editable = MemberNoEditable;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Amount to Withdraw"; Rec."Amount to Withdraw")
                {
                    ApplicationArea = Basic;
                    // Editable = AmounttoWithdrawEditable;
                }
                field("Date for Withdrawal"; Rec."Date for Withdrawal")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Fee on Withdrawal"; Rec."Fee on Withdrawal")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Reason for Bulk Withdrawal"; Rec."Reason for Bulk Withdrawal")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Noticed Updated"; Rec."Noticed Updated")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Notice Updated By"; Rec."Notice Updated By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date Notified"; Rec."Date Notified")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
        area(factboxes)
        {
            part(Control1000000029; "Mwanangu Statistics FactBox")
            {
                SubPageLink = "No." = field("Account No");
            }
            part(Control1000000028; "Member Statistics FactBox")
            {
                SubPageLink = "No." = field("Member No");
            }
            part(Control1000000027; "Vendor Picture-Uploaded")
            {
                SubPageLink = "No." = field("Account No");
            }
            part(Control1000000026; "Vendor Signature-Uploaded")
            {
                SubPageLink = "No." = field("Account No");
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Update Bulk Notice")
            {
                ApplicationArea = Basic;
                Enabled = true;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Rec.Status <> Rec.Status::Approved then begin
                        Error('This document has to be approved');
                    end;

                    if Rec."Noticed Updated" = true then begin
                        Error('This Application has already been updated');
                    end;


                    if Confirm('Are you sure you want to updated the Bulk Withdrawal Details', false) = true then begin
                        if Accounts.Get(Rec."Account No") then begin
                            //     Accounts."Bulk Withdrawal Appl Done" := true;
                            //     Accounts."Bulk Withdrawal App Done By" := UserId;
                            //     Accounts."Bulk Withdrawal Appl Amount" := Rec."Amount to Withdraw";
                            //     Accounts."Bulk Withdrawal Fee" := Rec."Fee on Withdrawal";
                            //     Accounts."Bulk Withdrawal App Date For W" := Rec."Date for Withdrawal";
                            //     Accounts."Bulk Withdrawal Appl Date" := Today;
                            // Accounts.Modify;

                            Rec."Noticed Updated" := true;
                            Rec."Notice Updated By" := UserId;
                            Rec."Date Notified" := Today;
                        end;
                    end;
                    Message('Bulk Details Updated Succesfully');
                end;
            }
            group(Approvals)
            {
                Caption = 'Approvals';
                action(Approval)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approval;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin

                        DocumentType := Documenttype::BulkWithdrawal;
                        ApprovalEntries.SetRecordFilters(Database::"Bulk Withdrawal Application", DocumentType, Rec."Transaction No");
                        ApprovalEntries.Run;
                    end;
                }
                action("Send Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Enabled = (not OpenApprovalEntriesExist) and EnabledApprovalWorkflowsExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        Text001: label 'This transaction is already pending approval';
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin

                        // if ApprovalsMgmt.CheckBulkWithdrawalApprovalsWorkflowEnabled(Rec) then
                        //     ApprovalsMgmt.OnSendBulkWithdrawalForApproval(Rec)
                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Request';
                    Enabled = CanCancelApprovalForRecord;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        // if ApprovalsMgmt.CheckBulkWithdrawalApprovalsWorkflowEnabled(Rec) then
                        //     ApprovalsMgmt.OnCancelBulkWithdrawalApprovalRequest(Rec);

                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        FnAddRecordRestriction();

        EnablePosting := false;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        EnabledApprovalWorkflowsExist := true;
        if Rec.Status = Rec.Status::Approved then begin
            OpenApprovalEntriesExist := false;
            CanCancelApprovalForRecord := false;
            EnabledApprovalWorkflowsExist := false;
        end;
        if (Rec.Status = Rec.Status::Approved) then
            EnablePosting := true;
    end;

    trigger OnAfterGetRecord()
    begin
        FnAddRecordRestriction();
    end;

    trigger OnOpenPage()
    begin
        FnAddRecordRestriction();
    end;

    var
        Accounts: Record Vendor;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication,BulkWithdrawal;
        MemberNoEditable: Boolean;
        SavingsProductEditable: Boolean;
        AccountNoEditable: Boolean;
        AmounttoWithdrawEditable: Boolean;
        ReasonEditable: Boolean;
        OpenApprovalEntriesExist: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        EventFilter: Text;
        EnablePosting: Boolean;
        ObjTransactions: Record 51441;
        WithdrawalDateEditable: Boolean;

    local procedure FnAddRecordRestriction()
    begin
        if Rec.Status = Rec.Status::Open then begin
            MemberNoEditable := true;
            SavingsProductEditable := true;
            AccountNoEditable := true;
            AmounttoWithdrawEditable := true;
            WithdrawalDateEditable := true;
            ReasonEditable := true
        end else
            if Rec.Status = Rec.Status::"Pending Approval" then begin
                MemberNoEditable := false;
                SavingsProductEditable := false;
                AccountNoEditable := false;
                AmounttoWithdrawEditable := false;
                WithdrawalDateEditable := false;
                ReasonEditable := false
            end else
                if Rec.Status = Rec.Status::Approved then begin
                    MemberNoEditable := false;
                    SavingsProductEditable := false;
                    AccountNoEditable := false;
                    AmounttoWithdrawEditable := false;
                    WithdrawalDateEditable := false;
                    ReasonEditable := false
                end;

    end;
}

