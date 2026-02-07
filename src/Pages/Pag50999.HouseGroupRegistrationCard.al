#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50999 "House Group Registration Card"
{
    PageType = Card;
    SourceTable = "House Groups Registration";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Cell Group Code"; Rec."Cell Group Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Cell Group Name"; Rec."Cell Group Name")
                {
                    ApplicationArea = Basic;
                }
                field("Date Formed"; Rec."Date Formed")
                {
                    ApplicationArea = Basic;
                }
                field("Meeting Date"; Rec."Meeting Date")
                {
                    ApplicationArea = Basic;
                }
                field("Group Leader"; Rec."Group Leader")
                {
                    ApplicationArea = Basic;
                }
                field("Group Leader Name"; Rec."Group Leader Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Group Leader Email"; Rec."Group Leader Email")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Assistant group Leader"; Rec."Assistant group Leader")
                {
                    ApplicationArea = Basic;
                }
                field("Assistant Group Name"; Rec."Assistant Group Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Assistant Group Leader Email"; Rec."Assistant Group Leader Email")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Credit Officer"; Rec."Credit Officer")
                {
                    ApplicationArea = Basic;
                }
                field("Field Officer"; Rec."Field Officer")
                {
                    ApplicationArea = Basic;
                }
                field("Meeting Place"; Rec."Meeting Place")
                {
                    ApplicationArea = Basic;
                }
                field("No of Members"; Rec."No of Members")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Created On"; Rec."Created On")
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
            action(EnableCreateHouse)
            {
                ApplicationArea = Basic;
                Caption = 'Create Group';
                Enabled = EnableCreateHouse;
                Image = Customer;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to Create this House Group?', false) = true then begin
                        if ObjSaccoNos.Get then begin
                            ObjSaccoNos.TestField(ObjSaccoNos."House Group Nos");
                            VarHouseNo := NoSeriesMgt.GetNextNo(ObjSaccoNos."House Group Nos", 0D, true);

                            ObjHouseG.Init;
                            ObjHouseG."Cell Group Code" := VarHouseNo;
                            ObjHouseG."Cell Group Name" := Rec."Cell Group Name";
                            ObjHouseG."Group Leader" := Rec."Group Leader";
                            ObjHouseG."Group Leader Name" := Rec."Group Leader Name";
                            ObjHouseG."Group Leader Email" := Rec."Group Leader Email";
                            ObjHouseG."Group Leader Phone No" := Rec."Group Leader Phone No";
                            ObjHouseG."Assistant group Leader" := Rec."Assistant group Leader";
                            ObjHouseG."Assistant Group Name" := Rec."Assistant Group Name";
                            ObjHouseG."Assistant Group Leader Email" := Rec."Assistant Group Leader Email";
                            ObjHouseG."Assistant Group Leader Phone N" := Rec."Assistant Group Leader Phone N";
                            ObjHouseG."Meeting Place" := Rec."Meeting Place";
                            ObjHouseG.Insert;

                        end;
                    end;
                end;
            }
            action("Send Approval Request")
            {
                ApplicationArea = Basic;
                Caption = 'Send Approval Request';
                Enabled = (not OpenApprovalEntriesExist) and EnabledApprovalWorkflowsExist;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;

                trigger OnAction()
                var
                    Text001: label 'This request is already pending approval';
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin

                    // if ApprovalsMgmt.CheckHouseRegistrationApprovalsWorkflowEnabled(Rec) then
                    //     ApprovalsMgmt.OnSendHouseRegistrationForApproval(Rec);
                end;
            }
            action("Cancel Approval Request")
            {
                ApplicationArea = Basic;
                Caption = 'Cancel Approval Request';
                Enabled = CanCancelApprovalForRecord;
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;

                trigger OnAction()
                var
                    Approvalmgt: Codeunit "Approvals Mgmt.";
                begin
                    if Confirm('Are you sure you want to cancel this approval request', false) = true then
                        // ApprovalsMgmt.OnCancelHouseRegistrationApprovalRequest(Rec);
                    Rec.Status := Rec.Status::Open;
                    Rec.Modify;
                end;
            }
            action(Approval)
            {
                ApplicationArea = Basic;
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                begin
                    DocumentType := Documenttype::HouseRegistration;
                    ApprovalEntries.SetRecordFilters(Database::"House Groups Registration", DocumentType, Rec."Cell Group Code");
                    ApprovalEntries.Run;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        EnableCreateHouse := false;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        EnabledApprovalWorkflowsExist := true;

        if ((Rec.Status = Rec.Status::Approved)) then
            EnableCreateHouse := true;
    end;

    trigger OnOpenPage()
    begin
        EnableCreateHouse := false;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        EnabledApprovalWorkflowsExist := true;

        if ((Rec.Status = Rec.Status::Approved)) then
            EnableCreateHouse := true;
    end;

    var
        ObjCellGroups: Record 51915;
        ObjCust: Record 51364;
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication,BulkWithdrawal,PackageLodging,PackageRetrieval,HouseChange,CRMTraining,PettyCash,StaffClaims,MemberAgentNOKChange,HouseRegistration,LoanPayOff;
        EnableCreateHouse: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        EnabledApprovalWorkflowsExist: Boolean;
        MemberNoEditable: Boolean;
        AccountNoEditable: Boolean;
        ChangeTypeEditable: Boolean;
        AccountTypeEditable: Boolean;
        VarBOSANOKVisible: Boolean;
        VarFOSANOKVisible: Boolean;
        VarAccountAgentVisible: Boolean;
        ObjSaccoNos: Record 51399;
        VarHouseNo: Code[30];
        ObjHouseG: Record 51915;
        NoSeriesMgt: Codeunit "No. Series";
}

