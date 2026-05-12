#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50567 "Cheque Discounting card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Cheque Discounting";

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
                    Editable = MemberNoEditable;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Savings Product"; Rec."Savings Product")
                {
                    ApplicationArea = Basic;
                    Editable = SavingsProductEditable;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic;
                    Editable = AccountNoEditable;
                }
                field("Cheque to Discount"; Rec."Cheque to Discount")
                {
                    ApplicationArea = Basic;
                    Editable = ChequetoDiscountEditable;
                }
                field("Cheque Amount"; Rec."Cheque Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Cheque No"; Rec."Cheque No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Outstanding Discounted Cheque"; Rec."Outstanding Discounted Cheque")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Expected Maturity Date"; Rec."Expected Maturity Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Percentage Discount"; Rec."Percentage Discount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Discount Amount Allowable"; Rec."Discount Amount Allowable")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Amount Discounted"; Rec."Amount Discounted")
                {
                    ApplicationArea = Basic;
                    Editable = AmounttoDiscountEditable;
                }
                field("Discounted Amount+Fee"; Rec."Discounted Amount+Fee")
                {
                    ApplicationArea = Basic;
                    Caption = 'Discounted Amount-Commission';
                    Editable = false;
                    Visible = false;
                }
                field("Cheque Discounting Commission"; Rec."Cheque Discounting Commission")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Excise Duty"; Rec."Excise Duty")
                {
                    ApplicationArea = Basic;
                    Editable = false;
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
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date Posted"; Rec."Date Posted")
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
            action("Post Cheque Discount")
            {
                ApplicationArea = Basic;
                Enabled = EnablePosting;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    Rec.TestField(Posted, false);
                    Rec.TestField(Status, Rec.Status::Approved);
                    if Confirm('Are you sure you want to discount this Cheque ?', false) = true then begin
                        if Rec.Status <> Rec.Status::Approved then begin
                            Error('Status Must be Approved')
                        end else
                            if Accounts.Get(Rec."Account No") then
                                Accounts."Cheque Discounted" := Accounts."Cheque Discounted" + Rec."Amount Discounted";
                        Accounts."Comission On Cheque Discount" := Rec."Discounted Amount+Fee" - Rec."Amount Discounted";
                        Accounts.Modify;
                    end;
                    GenSetup.Get;

                    ObjDiscountingLedger.Init;
                    ObjDiscountingLedger.No := Rec."Transaction No";
                    ObjDiscountingLedger."External Transaction No" := Rec."Transaction No";
                    ObjDiscountingLedger."Cheque No" := Rec."Cheque No";
                    ObjDiscountingLedger.Amount := Rec."Amount Discounted";
                    ObjDiscountingLedger.Debit := Rec."Amount Discounted";
                    ObjDiscountingLedger."Transaction Type" := ObjDiscountingLedger."transaction type"::Discounting;
                    ObjDiscountingLedger."Posting Date" := Today;
                    ObjDiscountingLedger."Fosa Account" := Rec."Account No";
                    ObjDiscountingLedger."User ID" := UserId;
                    ObjDiscountingLedger.Insert;


                    BATCH_TEMPLATE := 'GENERAL';
                    BATCH_NAME := 'FTRANS';
                    DOCUMENT_NO := Rec."Transaction No";

                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                    GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                    GenJournalLine.DeleteAll;

                    //-----------------Post Journals---------------------------------------------------
                    //--------------1. Debit FOSA (With Transaction Charges)------------------------------------------------------------------
                    LineNo := LineNo + 1000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, Rec."Account No", Today, Rec."Cheque Discounting Commission", 'FOSA', Rec."Cheque No", 'Cheque Discounting Charges', '');
                    //--------------2. Debit FOSA(With Excise Duty)--------------------------------------------------------------------------
                    LineNo := LineNo + 1000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, Rec."Account No", Today, Rec."Excise Duty", 'FOSA', Rec."Cheque No", 'Excise Duty', '');

                    //--------------4. Credit Cheque Discounting Income (With Transaction Charges)------------------------------------------------------------------
                    LineNo := LineNo + 1000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::"G/L Account", GenSetup."Cheque Discounting Fee Account", Today, Rec."Cheque Discounting Commission" * -1, 'FOSA', Rec."Cheque No", 'Cheque Discounting Charges', '');
                    //--------------5. Credit Excise(With Excise Duty)--------------------------------------------------------------------------
                    LineNo := LineNo + 1000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::"G/L Account", GenSetup."Excise Duty Account", Today, Rec."Excise Duty" * -1, 'FOSA', Rec."Cheque No", 'Excise Duty', '');
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                    GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                    if GenJournalLine.Find('-') then begin
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                        Message('Discounting Posted Successfully!');
                    end;
                    //---------------------End---------------------------------------------------------
                    Message('Cheque has been discounted Successfully');
                    Rec.Posted := true;
                    Rec."Posted By" := UserId;
                    Rec."Date Posted" := Today;

                    ObjTransactions.Reset;
                    ObjTransactions.SetRange(ObjTransactions.No, Rec."Cheque to Discount");
                    if ObjTransactions.FindSet then begin
                        ObjTransactions."Cheque Discounted Amount" := Rec."Amount Discounted";
                        ObjTransactions.Modify;
                    end;
                end;
            }
            group(Approvals)
            {
                Caption = 'Approvals';
                action("Send Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Enabled = (not OpenApprovalEntriesExist) and EnabledApprovalWorkflowsExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        Text001: label 'This transaction is already pending approval';
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin

                        // if ApprovalsMgmt.CheckChequeDiscountingApprovalsWorkflowEnabled(Rec) then
                        //     ApprovalsMgmt.OnSendChequeDiscountingForApproval(Rec)
                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Request';
                    Enabled = CanCancelApprovalForRecord;
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        // if ApprovalsMgmt.CheckChequeDiscountingApprovalsWorkflowEnabled(Rec) then
                        //     ApprovalsMgmt.OnCancelChequeDiscountingApprovalRequest(Rec);
                    end;
                }
                action(Approval)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin

                        DocumentType := Documenttype::ChequeDiscounting;
                        ApprovalEntries.SetRecordFilters(Database::"Cheque Discounting", DocumentType, Rec."Transaction No");
                        ApprovalEntries.Run;
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
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting;
        MemberNoEditable: Boolean;
        SavingsProductEditable: Boolean;
        AccountNoEditable: Boolean;
        ChequetoDiscountEditable: Boolean;
        AmounttoDiscountEditable: Boolean;
        OpenApprovalEntriesExist: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        EventFilter: Text;
        EnablePosting: Boolean;
        ObjTransactions: Record Transactions;
        SFactory: Codeunit "Swizzsoft Factory.";
        BATCH_TEMPLATE: Code[100];
        BATCH_NAME: Code[100];
        DOCUMENT_NO: Code[100];
        LineNo: Integer;
        GenJournalLine: Record "Gen. Journal Line";
        GenSetup: Record "Sacco General Set-Up";
        ObjDiscountingLedger: Record "Discounting Ledger Entry";

    local procedure FnAddRecordRestriction()
    begin
        if Rec.Status = Rec.Status::Open then begin
            MemberNoEditable := true;
            SavingsProductEditable := true;
            AccountNoEditable := true;
            ChequetoDiscountEditable := true;
            AmounttoDiscountEditable := true
        end else
            if Rec.Status = Rec.Status::"Pending Approval" then begin
                MemberNoEditable := false;
                SavingsProductEditable := false;
                AccountNoEditable := false;
                ChequetoDiscountEditable := false;
                AmounttoDiscountEditable := false
            end else
                if Rec.Status = Rec.Status::Approved then begin
                    MemberNoEditable := false;
                    SavingsProductEditable := false;
                    AccountNoEditable := false;
                    ChequetoDiscountEditable := false;
                    AmounttoDiscountEditable := false
                end;
    end;
}

