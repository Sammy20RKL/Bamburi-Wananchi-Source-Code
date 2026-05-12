#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 56037 "Transfers-Posted"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "BOSA Transfers";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = false;
                field(No; Rec.No)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Schedule Total"; Rec."Schedule Total")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Approved; Rec.Approved)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        if Rec.Status = Rec.Status::Approved then
                            Rec.Approved := true;
                        Rec.Modify;

                        if Rec.Status <> Rec.Status::Open then
                            TransfersEditable := false
                        else
                            TransfersEditable := true;
                    end;
                }
            }
            part(Control1102760014; "Transfer Schedule")
            {
                Editable = false;
                SubPageLink = "No." = field(No);
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Posting)
            {
                action(Print)
                {
                    ApplicationArea = Basic;
                    Caption = 'Print';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        BTRANS.Reset;
                        BTRANS.SetRange(BTRANS.No, Rec.No);
                        if BTRANS.Find('-') then begin
                            Report.Run(50293, true, true, BTRANS);
                        end;
                    end;
                }
                separator(Action1000000005)
                {
                }
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Image = Approval;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        Doc_Type := Doc_type::"BOSA Transfer";
                        ApprovalEntries.SetRecordFilters(Database::"BOSA Transfers", Doc_Type, Rec.No);
                        ApprovalEntries.Run;
                    end;
                }
                action("Send Approval Request")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                        Text001: label 'This batch is already pending approval';
                        NoSeriesMgt: Codeunit "No. Series";
                    begin
                        if Rec.Status <> Rec.Status::Open then
                            Error(Text001);


                        // if ApprovalMgt.CheckBOSATransWorkflowEnabled(Rec) then
                        //   ApprovalMgt.OnSendBOSATransForApproval(Rec);

                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        //IF ApprovalMgt.CancelInterbankApprovalRequest(Rec,TRUE,TRUE) THEN;
                        // ApprovalMgt.OnCancelBOSATransApprovalRequest(Rec);
                    end;
                }
                separator(Action1000000001)
                {
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        if Rec.Status <> Rec.Status::Open then
            TransfersEditable := false
        else
            TransfersEditable := true;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        Error('Not Allowed!');
    end;

    trigger OnOpenPage()
    begin
        if Rec.Status <> Rec.Status::Open then
            TransfersEditable := false
        else
            TransfersEditable := true;
    end;

    var
        users: Record User;
        GenJournalLine: Record "Gen. Journal Line";
        DefaultBatch: Record "Gen. Journal Batch";
        BSched: Record "BOSA Transfer Schedule";
        BTRANS: Record "BOSA Transfers";
        DActivity: Code[20];
        DBranch: Code[20];
        UsersID: Record User;
        FundsUSer: Record "Funds User Setup";
        Jtemplate: Code[10];
        Jbatch: Code[10];
        Doc_Type: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batches,"Payment Voucher","Petty Cash",Requisition,Loan,Interbank,Imprest,Checkoff,"FOSA Account Opening",StandingOrder,HRJob,HRLeave,"HRTransport Request",HRTraining,"HREmp Requsition",MicroTrans,"Account Reactivation","Overdraft ",BLA,"Member Editable","FOSA Opening","Loan Batching",Leave,"Imprest Requisition","Imprest Surrender","Stores Requisition","Funds Transfer","Change Request","Staff Claims","BOSA Transfer","Loan Tranche","Loan TopUp","Memb Opening","Member Withdrawal";
        ApprovalMgt: Codeunit "Approvals Mgmt.";
        TransfersEditable: Boolean;
}

