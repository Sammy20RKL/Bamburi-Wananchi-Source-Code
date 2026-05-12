#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50860 "Fixed Deposit Placement Card"
{
    PageType = Card;
    SourceTable = 51945;

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
                    Editable = VarMemberNoEditable;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Fixed Deposit Account No"; Rec."Fixed Deposit Account No")
                {
                    ApplicationArea = Basic;
                    Editable = VarAccountNoEditable;
                    ToolTip = 'Specify the Fixed Deposit Account to fix the amount';
                }
                field("Account to Tranfers FD Amount"; Rec."Account to Tranfers FD Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account to Tranfers Fixed Deposit Amount';
                    Editable = VarAccounttoTransferFDAmount;
                    ToolTip = 'Specify the savings account to transfer the amount to be fixed';
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Fixed Deposit Type"; Rec."Fixed Deposit Type")
                {
                    ApplicationArea = Basic;
                    Editable = VarFixedDepTypeEditable;
                }
                field("Fixed Duration"; Rec."Fixed Duration")
                {
                    ApplicationArea = Basic;
                    Editable = VarFDDurationEditable;
                }
                field("Fixed Deposit Start Date"; Rec."Fixed Deposit Start Date")
                {
                    ApplicationArea = Basic;
                    Editable = VarFDStartDateEditable;
                }
                field("Amount to Fix"; Rec."Amount to Fix")
                {
                    ApplicationArea = Basic;
                    Editable = VarAmountFixedEditable;
                }
                field("FD Interest Rate"; Rec."FD Interest Rate")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("FD Maturity Date"; Rec."FD Maturity Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Fixed Deposit Status"; Rec."Fixed Deposit Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Expected Interest Earned"; Rec."Expected Interest Earned")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Expected Tax After Term Period"; Rec."Expected Tax After Term Period")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Expected Net After Term Period"; Rec."Expected Net After Term Period")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Effected; Rec.Effected)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Effected By"; Rec."Effected By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date Effected"; Rec."Date Effected")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("FD Closed On"; Rec."FD Closed On")
                {
                    ApplicationArea = Basic;
                    Caption = 'Date Closed';
                    Editable = false;
                }
                field("FD Closed By"; Rec."FD Closed By")
                {
                    ApplicationArea = Basic;
                    Caption = 'Closed By';
                    Editable = false;
                }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Interest Earned to Date"; Rec."Interest Earned to Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
        area(factboxes)
        {
            part(Control33; "Mwanangu Statistics FactBox")
            {
                SubPageLink = "No." = field("Fixed Deposit Account No");
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(EnablePlaceFixedDeposit)
            {
                ApplicationArea = Basic;
                Caption = 'Place Fixed Deposit';
                Enabled = EnablePlaceFixedDeposit;
                Image = Customer;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to Place this Fixed Deposit?', false) = true then begin
                        if ObjAccount.Get(Rec."Fixed Deposit Account No") then begin
                            ObjAccount."Fixed Deposit Type" := Rec."Fixed Deposit Type";
                            ObjAccount."Fixed Deposit Start Date" := Rec."Fixed Deposit Start Date";
                            ObjAccount."Fixed Deposit Status" := Rec."Fixed Deposit Status";
                            ObjAccount."Fixed Duration" := Rec."FD Duration";
                            ObjAccount."FD Maturity Date" := Rec."FD Maturity Date";
                            ObjAccount."Interest rate" := Rec."FD Interest Rate";
                            ObjAccount."Expected Interest On Term Dep" := Rec."Expected Interest Earned";
                        end;
                    end;

                    Message(FDEffectedSuccesfully);
                    Rec.Effected := true;
                    Rec."Effected By" := UserId;
                    Rec."Date Effected" := WorkDate;
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

                    // if ApprovalsMgmt.CheckFixedDepositApprovalsWorkflowEnabled(Rec) then
                    //     ApprovalsMgmt.OnSendFixedDepositForApproval(Rec);
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
                    // if Confirm('Are you sure you want to cancel this approval request', false) = true then
                    //     ApprovalsMgmt.OnCancelFixedDepositApprovalRequest(Rec);
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
                    DocumentType := Documenttype::FixedDeposit;
                    ApprovalEntries.SetRecordFilters(Database::"Fixed Deposit Placement", DocumentType, Rec."Document No");
                    ApprovalEntries.Run;
                end;
            }
            action(PostFixedDepositFromSavings)
            {
                ApplicationArea = Basic;
                Caption = 'Post Fixed Deposit From Savings';
                Enabled = EnablePlaceFixedDeposit;
                Image = Payment;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin

                    ObjVendors.Reset;
                    ObjVendors.SetRange(ObjVendors."No.", Rec."Account to Tranfers FD Amount");
                    if ObjVendors.Find('-') then begin
                        ObjVendors.CalcFields(ObjVendors.Balance, ObjVendors."Uncleared Cheques");
                        AvailableBal := (ObjVendors.Balance - ObjVendors."Uncleared Cheques");

                        ObjAccTypes.Reset;
                        ObjAccTypes.SetRange(ObjAccTypes.Code, ObjVendors."Account Type");
                        if ObjAccTypes.Find('-') then
                            AvailableBal := AvailableBal - ObjAccTypes."Minimum Balance";
                    end;


                    if AvailableBal < Rec."Amount to Fix" then begin
                        Error('The FOSA Account has Less than the amount to Fix,Account balance is %1', AvailableBal);
                    end;

                    if Confirm('Do you want to effect this transfer from the Savings account', false) = true then
                        BATCH_TEMPLATE := 'GENERAL';
                    BATCH_NAME := 'DEFAULT';
                    DOCUMENT_NO := Rec."Document No";
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                    GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                    GenJournalLine.DeleteAll;




                    //------------------------------------1. CREDIT FIXED DEPOSIT A/C---------------------------------------------------------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, Rec."Fixed Deposit Account No", Today, Rec."Amount to Fix" * -1, 'FOSA', '',
                    'Fixed Deposit Amount- ' + '-' + Rec."Document No", '');
                    //--------------------------------(Credit fixed Deposit A/C)---------------------------------------------

                    //------------------------------------2. DEBIT FOSA SAVINGS A/C---------------------------------------------------------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, Rec."Account to Tranfers FD Amount", Today, Rec."Amount to Fix", 'FOSA', '',
                    'Fixed Deposit Amount- ' + '-' + Rec."Document No", '');
                    //----------------------------------(Debit Fosa Savings Account)------------------------------------------------

                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                    GenJournalLine.SetRange("Journal Batch Name", 'DEFAULT');
                    if GenJournalLine.Find('-') then
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);

                    Message(FDEffectedSuccesfully);
                    Rec.Effected := true;
                    Rec."Effected By" := UserId;
                    Rec."Date Effected" := WorkDate;
                end;
            }
            action(PostFixedDeposittoSavings)
            {
                ApplicationArea = Basic;
                Caption = 'Post Fixed Deposit to Savings';
                Enabled = EnablePlaceFixedDeposit;
                Image = Payment;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin

                    ObjVendors.Reset;
                    ObjVendors.SetRange(ObjVendors."No.", Rec."Fixed Deposit Account No");
                    if ObjVendors.Find('-') then begin
                        ObjVendors.CalcFields(ObjVendors.Balance, ObjVendors."Uncleared Cheques");
                        AvailableBal := (ObjVendors.Balance - ObjVendors."Uncleared Cheques");

                        ObjAccTypes.Reset;
                        ObjAccTypes.SetRange(ObjAccTypes.Code, ObjVendors."Account Type");
                        if ObjAccTypes.Find('-') then
                            AvailableBal := AvailableBal - ObjAccTypes."Minimum Balance";
                    end;


                    if AvailableBal < Rec."Amount to Fix" then begin
                        Error('The FOSA Account has Less than the amount to Fix,Account balance is %1', AvailableBal);
                    end;

                    if Confirm('Do you want to effect this transfer from the Savings account', false) = true then
                        BATCH_TEMPLATE := 'GENERAL';
                    BATCH_NAME := 'DEFAULT';
                    DOCUMENT_NO := Rec."Document No";
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                    GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                    GenJournalLine.DeleteAll;




                    //------------------------------------1. CREDIT FIXED DEPOSIT A/C---------------------------------------------------------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, Rec."Fixed Deposit Account No", Today, Rec."Amount to Fix" * -1, 'FOSA', '',
                    'Fixed Deposit Amount- ' + '-' + Rec."Document No", '');
                    //--------------------------------(Credit fixed Deposit A/C)---------------------------------------------

                    //------------------------------------2. DEBIT FOSA SAVINGS A/C---------------------------------------------------------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, Rec."Account to Tranfers FD Amount", Today, Rec."Amount to Fix", 'FOSA', '',
                    'Fixed Deposit Amount- ' + '-' + Rec."Document No", '');
                    //----------------------------------(Debit Fosa Savings Account)------------------------------------------------

                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                    GenJournalLine.SetRange("Journal Batch Name", 'DEFAULT');
                    if GenJournalLine.Find('-') then
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);

                    Message(FDTermination);
                    Rec.Closed := true;
                    Rec."FD Closed By" := UserId;
                    Rec."FD Closed On" := WorkDate;
                end;
            }
            action(RenewFixedDeposit)
            {
                ApplicationArea = Basic;
                Caption = 'Renew Fixed Deposit';
                Enabled = EnablePlaceFixedDeposit;
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Confirm('Do you want to Renew this Fixed Deposit', false) = true then begin
                        ObjVendors.Reset;
                        ObjVendors.SetRange(ObjVendors."No.", Rec."Fixed Deposit Account No");
                        if ObjVendors.Find('-') then begin

                            ObjVendors."Prevous Fixed Deposit Type" := Rec."Fixed Deposit Type";
                            ObjVendors."Prevous FD Deposit Status Type" := Rec."FDR Deposit Status Type";
                            ObjVendors."Prevous FD Maturity Date" := Rec."FD Maturity Date";
                            ObjVendors."Prevous FD Start Date" := Rec."Fixed Deposit Start Date";
                            ObjVendors."Prevous Fixed Duration" := Rec."FD Duration";
                            ObjVendors."Prevous Interest Rate FD" := Rec."FD Interest Rate";
                            ObjVendors."Prevous Expected Int On FD" := Rec."Expected Interest Earned";
                            ObjVendors."Date Renewed" := Today;


                            ObjVendors."Fixed Deposit Type" := '';
                            ObjVendors."FDR Deposit Status Type" := ObjVendors."fdr deposit status type"::New;
                            ObjVendors."FD Maturity Date" := 0D;
                            ObjVendors."Fixed Deposit Start Date" := 0D;
                            ObjVendors."Expected Interest On Term Dep" := 0;
                            ObjVendors."Interest rate" := 0;
                            ObjVendors."Amount to Transfer" := 0;
                            ObjVendors."Transfer Amount to Savings" := 0;
                            ObjVendors."Fixed Deposit Status" := Rec."fixed deposit status"::" ";


                            ObjInterestBuffer.Reset;
                            ObjInterestBuffer.SetRange(ObjInterestBuffer."Account No", Rec."Fixed Deposit Account No");
                            if ObjInterestBuffer.Find('-') then begin
                                ObjInterestBuffer.DeleteAll;
                            end;



                            ObjVendors."FDR Deposit Status Type" := ObjVendors."fdr deposit status type"::New;
                            ObjVendors.Modify;

                            Message('Fixed deposit renewed successfully');
                        end;
                    end;
                end;
            }
            action(TerminateFixedDeposit)
            {
                ApplicationArea = Basic;
                Caption = 'Terminate Fixed Deposit';
                Enabled = EnablePlaceFixedDeposit;
                Image = Close;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin

                    ObjVendors.Reset;
                    ObjVendors.SetRange(ObjVendors."No.", Rec."Fixed Deposit Account No");
                    if ObjVendors.Find('-') then begin
                        ObjVendors.CalcFields(ObjVendors.Balance, ObjVendors."Uncleared Cheques");
                        AvailableBal := (ObjVendors.Balance - ObjVendors."Uncleared Cheques");

                        ObjAccTypes.Reset;
                        ObjAccTypes.SetRange(ObjAccTypes.Code, ObjVendors."Account Type");
                        if ObjAccTypes.Find('-') then
                            AvailableBal := AvailableBal - ObjAccTypes."Minimum Balance";
                    end;


                    if AvailableBal < Rec."Amount to Fix" then begin
                        Error('The FOSA Account has Less than the amount to Fix,Account balance is %1', AvailableBal);
                    end;

                    if Confirm('Do you want to Terminate this Fixed Deposit', false) = true then
                        BATCH_TEMPLATE := 'GENERAL';
                    BATCH_NAME := 'DEFAULT';
                    DOCUMENT_NO := Rec."Document No";
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                    GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                    GenJournalLine.DeleteAll;




                    //------------------------------------1. DEBIT FIXED DEPOSIT A/C---------------------------------------------------------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, Rec."Fixed Deposit Account No", Today, Rec."Amount to Fix", 'FOSA', '',
                    'Fixed Deposit Terminated- ' + '-' + Rec."Document No", '');
                    //--------------------------------(Debit fixed Deposit A/C)---------------------------------------------

                    //------------------------------------2. CREDIT FOSA SAVINGS A/C---------------------------------------------------------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, Rec."Account to Tranfers FD Amount", Today, Rec."Amount to Fix" * -1, 'FOSA', '',
                    'Fixed Deposit Terminated- ' + '-' + Rec."Document No", '');
                    //----------------------------------(Credit Fosa Savings Account)------------------------------------------------

                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                    GenJournalLine.SetRange("Journal Batch Name", 'DEFAULT');
                    if GenJournalLine.Find('-') then
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);


                    Message(FDTermination);
                    Rec.Closed := true;
                    Rec."FD Closed By" := UserId;
                    Rec."FD Closed On" := WorkDate;
                end;
            }
            action(BreakCall)
            {
                ApplicationArea = Basic;
                Caption = 'Break Call Deposit';
                Enabled = EnablePlaceFixedDeposit;
                Image = Close;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    ObjAccount.Reset;
                    ObjAccount.SetRange(ObjAccount."No.", Rec."Fixed Deposit Account No");
                    if ObjAccount.Find('-') then
                        Report.Run(51516465, true, false, ObjAccount)
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        if Rec.Status = Rec.Status::Open then begin
            VarMemberNoEditable := true;
            VarAccountNoEditable := true;
            VarFixedDepTypeEditable := true;
            VarFDStartDateEditable := true;
            VarAmountFixedEditable := true;
            VarFDDurationEditable := true
        end else
            if Rec.Status = Rec.Status::"Pending Approval" then begin
                VarMemberNoEditable := false;
                VarAccountNoEditable := false;
                VarFixedDepTypeEditable := false;
                VarFDStartDateEditable := false;
                VarAmountFixedEditable := false;
                VarFDDurationEditable := false
            end else
                if Rec.Status = Rec.Status::Approved then begin
                    VarMemberNoEditable := false;
                    VarAccountNoEditable := false;
                    VarFixedDepTypeEditable := false;
                    VarFDStartDateEditable := false;
                    VarAmountFixedEditable := false;
                    VarFDDurationEditable := false;
                end;


        EnablePlaceFixedDeposit := false;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        EnabledApprovalWorkflowsExist := true;

        if ((Rec.Status = Rec.Status::Approved)) then
            EnablePlaceFixedDeposit := true;
    end;

    trigger OnOpenPage()
    begin
        if Rec.Status = Rec.Status::Open then begin
            VarMemberNoEditable := true;
            VarAccountNoEditable := true;
            VarFixedDepTypeEditable := true;
            VarFDStartDateEditable := true;
            VarAmountFixedEditable := true;
            VarAccounttoTransferFDAmount := true;
            VarFDDurationEditable := true
        end else
            if Rec.Status = Rec.Status::"Pending Approval" then begin
                VarMemberNoEditable := false;
                VarAccountNoEditable := false;
                VarFixedDepTypeEditable := false;
                VarFDStartDateEditable := false;
                VarAmountFixedEditable := false;
                VarAccounttoTransferFDAmount := false;
                VarFDDurationEditable := false
            end else
                if Rec.Status = Rec.Status::Approved then begin
                    VarMemberNoEditable := false;
                    VarAccountNoEditable := false;
                    VarFixedDepTypeEditable := false;
                    VarFDStartDateEditable := false;
                    VarAmountFixedEditable := false;
                    VarAccounttoTransferFDAmount := false;
                    VarFDDurationEditable := false;
                end;

        EnablePlaceFixedDeposit := false;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        EnabledApprovalWorkflowsExist := true;

        if ((Rec.Status = Rec.Status::Approved)) then
            EnablePlaceFixedDeposit := true;
    end;

    var
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication,BulkWithdrawal,PackageLodging,PackageRetrieval,HouseChange,CRMTraining,PettyCash,StaffClaims,MemberAgentNOKChange,HouseRegistration,LoanPayOff,FixedDeposit;
        EnablePlaceFixedDeposit: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        EnabledApprovalWorkflowsExist: Boolean;
        ObjVendors: Record Vendor;
        VarMemberNoEditable: Boolean;
        VarAccountNoEditable: Boolean;
        VarFixedDepTypeEditable: Boolean;
        VarFDDurationEditable: Boolean;
        VarFDStartDateEditable: Boolean;
        VarAmountFixedEditable: Boolean;
        VarAccounttoTransferFDAmount: Boolean;
        ObjAccTypes: Record 51436;
        ObjAccount: Record Vendor;
        AvailableBal: Decimal;
        GenJournalLine: Record "Gen. Journal Line";
        BATCH_TEMPLATE: Code[30];
        BATCH_NAME: Code[30];
        DOCUMENT_NO: Code[30];
        SFactory: Codeunit "Swizzsoft Factory";
        LineNo: Integer;
        ObjInterestBuffer: Record 51467;
        ErrorAlreadyEffected: label 'Fixed Deposit Already Effected';
        FDEffectedSuccesfully: label 'Fixed Deposit Effected Succesfully';
        FDTermination: label 'Fixed Deposit Terminated Sucessfully';
}

