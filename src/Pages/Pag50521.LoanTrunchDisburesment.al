#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50521 "Loan Trunch Disburesment"
{
    PageType = Card;
    SourceTable = "Loan trunch Disburesment";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan No"; Rec."Loan No")
                {
                    ApplicationArea = Basic;
                }
                field("Issue Date"; Rec."Issue Date")
                {
                    ApplicationArea = Basic;
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Disbursed Amount"; Rec."Disbursed Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Balance Outstanding"; Rec."Balance Outstanding")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Requested Amount"; Rec."Requested Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Amount to Disburse"; Rec."Amount to Disburse")
                {
                    ApplicationArea = Basic;
                }
                field("Mode of Disbursement"; Rec."Mode of Disbursement")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("FOSA Account"; Rec."FOSA Account")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque No/Reference No"; Rec."Cheque No/Reference No")
                {
                    ApplicationArea = Basic;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            group(ActionGroup1000000022)
            {
                action("Post Trunch")
                {
                    ApplicationArea = Basic;
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        Rec.TestField(Status, Rec.Status::Approved);
                        Rec.TestField(Posted, false);
                        if Confirm('Are You Sure you Want to Post this trunch?', false) = true then begin
                            BATCH_TEMPLATE := 'PAYMENTS';
                            BATCH_NAME := 'LOANS';
                            DOCUMENT_NO := Rec."Document No";
                            GenJournalLine.Reset;
                            GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                            GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                            GenJournalLine.DeleteAll;

                            //------------------------------------1. DEBIT MEMBER LOAN A/C---------------------------------------------------------------------------------------------
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::Loan,
                            GenJournalLine."account type"::Customer, Rec."Member No", Rec."Issue Date", Rec."Amount to Disburse", '', Rec."Loan No",
                            'Trunch Disbursment- ' + Rec."Loan No", Rec."Loan No");
                            //--------------------------------(Debit Member Loan Account)------------------------------------------------------------------------------------------------

                            //------------------------------------2. CREDIT MEMBER FOSA A/C---------------------------------------------------------------------------------------------
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                            GenJournalLine."account type"::Customer, Rec."FOSA Account", Rec."Issue Date", Rec."Amount to Disburse" * -1, 'BOSA', Rec."Loan No",
                            'Trunch Disbursment- ' + Rec."Loan No", Rec."Loan No");
                            //----------------------------------(Credit Member Fosa Account)------------------------------------------------


                            //Post
                            GenJournalLine.Reset;
                            GenJournalLine.SetRange("Journal Template Name", 'PAYMENTS');
                            GenJournalLine.SetRange("Journal Batch Name", 'LOANS');
                            if GenJournalLine.Find('-') then begin
                                Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
                            end;
                            Rec.Posted := true;
                            Rec."Posting Date" := Today;
                            Rec.Modify;
                            //Post New

                        end;
                        Message('Loan posted successfully.');
                    end;
                }
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
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        Text001: label 'This transaction is already pending approval';
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        // if ApprovalMgt.CheckTrunchApprovalsWorkflowEnabled(Rec) then begin
                        // //     ApprovalMgt.OnSendTrunchForApproval(Rec);
                        //     Message('here');
                        // end
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
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        // ApprovalMgt.OnCancelTrunchApprovalRequest(Rec);
                    end;
                }
                action(Approval)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                    end;
                }
                action("Print Report")
                {
                    ApplicationArea = Basic;
                    Image = "Report";
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        ObjTrunch.Reset;
                        ObjTrunch.SetRange("Document No", Rec."Document No");
                        if ObjTrunch.Find('-') then begin
                            Report.Run(50027, true, false, ObjTrunch);
                        end
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        EnabledApprovalWorkflowsExist := true;
        if Rec.Status = Rec.Status::Approved then begin
            OpenApprovalEntriesExist := false;
            CanCancelApprovalForRecord := false;
            EnabledApprovalWorkflowsExist := false;
        end;
    end;

    var
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        SFactory: Codeunit "Swizzsoft Factory.";
        BATCH_TEMPLATE: Code[50];
        BATCH_NAME: Code[50];
        DOCUMENT_NO: Code[50];
        EnabledApprovalWorkflowsExist: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        CanCancelApprovalForRecord: Boolean;
        EventFilter: Text;
        OpenApprovalEntriesExist: Boolean;
        ObjTrunch: Record "Loan trunch Disburesment";
}

