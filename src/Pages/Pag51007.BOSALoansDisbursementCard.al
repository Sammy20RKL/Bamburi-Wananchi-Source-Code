Page 51007 "BOSA Loans Disbursement Card"
{
    DeleteAllowed = false;
    PageType = Card;
    InsertAllowed = false;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Loans Register";
    SourceTableView = where(Source = const(BOSA), Posted = const(false));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Loan  No."; Rec."Loan  No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Client Code"; Rec."Client Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member No';
                    Editable = MNoEditable;
                    ShowMandatory = true;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic;
                    Editable = AccountNoEditable;
                    Style = StrongAccent;
                }
                field("Client Name"; Rec."Client Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = StrongAccent;
                }
                field("Member Deposits"; Rec."Member Deposits")
                {
                    ApplicationArea = Basic;
                    Style = Unfavorable;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = Basic;
                    Editable = true;

                    trigger OnValidate()
                    begin
                        //TestField(Posted, false);
                    end;
                }
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    ApplicationArea = Basic;
                    Style = StrongAccent;
                    Editable = LProdTypeEditable;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                    end;
                }
                field(Installments; Rec.Installments)
                {
                    ApplicationArea = Basic;
                    Editable = InstallmentEditable;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        Rec.TestField(Posted, false);
                    end;
                }
                field(Interest; Rec.Interest)
                {
                    ApplicationArea = Basic;
                    Editable = EditableField;
                    Caption = 'Interest Rate';
                }
                field("Requested Amount"; Rec."Requested Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Amount Applied';
                    Editable = AppliedAmountEditable;
                    ShowMandatory = true;
                    Style = Strong;

                    trigger OnValidate()
                    begin
                        Rec.TestField(Posted, false);
                    end;
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Approved Amount';
                    Editable = false;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        Rec.TestField(Posted, false);
                    end;
                }
                field("Main Sector"; Rec."Main-Sector")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                    Style = Ambiguous;
                    Editable = MNoEditable;

                    trigger OnValidate()
                    begin
                        Rec.TestField(Posted, false);
                    end;
                }
                field("Sub-Sector"; Rec."Sub-Sector")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                    Style = Ambiguous;
                    Editable = MNoEditable;

                    trigger OnValidate()
                    begin
                        Rec.TestField(Posted, false);
                    end;
                }
                field("Specific Sector"; Rec."Specific-Sector")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                    Style = Ambiguous;
                    Editable = MNoEditable;

                    trigger OnValidate()
                    begin
                        Rec.TestField(Posted, false);
                    end;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic;
                    Editable = MNoEditable;
                    Visible = true;
                }
                field("Repayment Method"; Rec."Repayment Method")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Principle Repayment"; Rec."Loan Principle Repayment")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Interest Repayment"; Rec."Loan Interest Repayment")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Repayment; Rec.Repayment)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Disburesment Type"; Rec."Disburesment Type")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Status"; Rec."Loan Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;

                    trigger OnValidate()
                    begin
                        UpdateControl();
                    end;
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Repayment Frequency"; Rec."Repayment Frequency")
                {
                    ApplicationArea = Basic;
                    Editable = RepayFrequencyEditable;
                    Style = StrongAccent;
                    ShowMandatory = true;
                }
                field("Recovery Mode"; Rec."Recovery Mode")
                {
                    ApplicationArea = Basic;
                    Style = StrongAccent;
                    ShowMandatory = true;
                    Editable = MNoEditable;
                    OptionCaption = 'Checkoff,Standing Order,Salary,Pension,Direct Debits,Tea,Milk,Tea Bonus,Dividend,Christmas';
                }
                field("Mode of Disbursement"; Rec."Mode of Disbursement")
                {
                    ApplicationArea = Basic;
                    Editable = MNoEditable;
                    ShowMandatory = true;
                }
                field("Paying Bank Account No"; Rec."Paying Bank Account No")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Batch No."; Rec."Batch No.")
                {
                    Editable = true;
                    ApplicationArea = Basic;
                }
                field("Loan Disbursement Date"; Rec."Loan Disbursement Date")
                {
                    ApplicationArea = Basic;
                    // Editable = MNoEditable;
                    Editable = true;
                    Style = StrongAccent;
                    ShowMandatory = true;
                }
                field("Repayment Start Date"; Rec."Repayment Start Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Expected Date of Completion"; Rec."Expected Date of Completion")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Captured By"; Rec."Captured By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            part(Control1000000004; "Loans Guarantee Details")
            {
                Caption = 'Guarantors  Detail';
                SubPageLink = "Loan No" = field("Loan  No.");
                Editable = MNoEditable;
            }
            part(Control1000000005; "Loan Collateral Security")
            {
                Caption = 'Other Securities';
                SubPageLink = "Loan No" = field("Loan  No.");
                Editable = MNoEditable;
            }
            part(Control1000000002; "Loan Appraisal Salary Details")
            {
                Caption = 'Salary Details';
                Editable = MNoEditable;
                SubPageLink = "Loan No" = field("Loan  No."), "Client Code" = field("Client Code");
            }
            part(Missings; "Missing Contributions")
            {
                Caption = 'Missing Contributions';
                SubPageLink = "Loan Number" = field("Loan  No."), "Member Number" = field("Client Code");
            }
        }
        area(factboxes)
        {
            part("Member Statistics FactBox"; "Member Statistics FactBox")
            {
                SubPageLink = "No." = field("Client Code");
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group(Loan)
            {
                action("POST")
                {
                    Caption = 'POST LOAN';
                    Enabled = true;
                    Image = PrepaymentPostPrint;
                    PromotedIsBig = true;
                    Promoted = true;
                    PromotedCategory = Process;
                    // Visible = false;
                    trigger OnAction()
                    var
                        FundsUserSetup: Record "Funds User Setup";
                        CustLed: Record "Cust. Ledger Entry";
                        MissingAmount: Decimal;
                        Member: Record Customer;
                    begin
                        If FnCanPostLoans(UserId) = false then begin
                            Error('Prohibited ! You are not allowed to POST this Loan');
                        end;
                        // Check email Address
                        // if Member.Get(Rec."Client Code") then
                        //     if Member."E-Mail" = '' then
                        //         Error('Prohibited! Please add an email address for this member');

                        if (Rec."Loan Product Type" = '21') or (Rec."Loan Product Type" = '26') then begin
                            Rec."Paying Bank Account No" := ' '
                        end;
                        if Rec."Disburesment Type" <> Rec."Disburesment Type"::"Tranche/Multiple Disbursement" then
                            Rec.TestField("Paying Bank Account No");
                        if Rec.Posted = true then begin
                            Error('Prohibited ! The loan is already Posted');
                        end;
                        Rec.CalcFields("Outstanding Balance");
                        if Rec."Outstanding Balance" > 0 then begin
                            Error('Prohibited ! The loan is already Posted');
                        end;
                        if Rec."Loan Status" <> Rec."Loan Status"::Approved then begin
                            Error('Prohibited ! The loan is Status MUST be Approved');
                        end;

                        if Rec."Paying Bank Account No" <> '' then
                            if Confirm('Are you sure you want to Disburse this Loan from Bank Account. ' + Format(Rec."Paying Bank Account No") + ' ?', false) = false then begin
                                exit;
                            end;
                        if Confirm('Are you sure you want to POST Loan Approved amount of Ksh. ' + Format(Rec."Approved Amount") + ' to member -' + Format(Rec."Client Name") + ' ?', false) = false then begin
                            exit;
                        end else begin

                            TemplateName := 'GENERAL';
                            BatchName := 'LOANS';


                            //....................Ensure that If Batch doesnt exist then create
                            IF NOT GenBatch.GET(TemplateName, BatchName) THEN BEGIN
                                GenBatch.INIT;
                                GenBatch."Journal Template Name" := TemplateName;
                                GenBatch.Name := BatchName;
                                GenBatch.Insert();
                            END;
                            //....................Reset General Journal Lines
                            GenJournalLine.Reset();
                            GenJournalLine.SETRANGE("Journal Template Name", TemplateName);
                            GenJournalLine.SETRANGE("Journal Batch Name", BatchName);
                            GenJournalLine.DeleteAll();

                            LoanApps.Reset();
                            LoanApps.SetRange(LoanApps."Loan  No.", Rec."Loan  No.");
                            if LoanApps.FindSet then begin
                                repeat
                                    VarAmounttoDisburse := Rec."Approved Amount";
                                    MissingAmount := 0;

                                    // MissingAmount := FnCheckMissingContributions(Rec."Client Code");
                                    // VarAmounttoDisburse := VarAmounttoDisburse - MissingAmount;

                                    FnInsertBOSALines(LoanApps, LoanApps."Loan  No.", VarAmounttoDisburse);
                                    //exit;
                                    GenJournalLine.RESET;
                                    GenJournalLine.SETRANGE("Journal Template Name", TemplateName);
                                    GenJournalLine.SETRANGE("Journal Batch Name", BatchName);
                                    if GenJournalLine.Find('-') then begin
                                        CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch", GenJournalLine);

                                        Rec."Loan Status" := Rec."Loan Status"::Issued;
                                        Rec.Posted := true;
                                        Rec."Posted By" := UserId;
                                        Rec."Posting Date" := Today;
                                        Rec."Issued Date" := Rec."Loan Disbursement Date";
                                        Rec."Approval Status" := Rec."Approval Status"::Approved;
                                        Rec."Loans Category-SASRA" := Rec."Loans Category-SASRA"::Perfoming;
                                        Rec.Modify();
                                        //Send Notifications
                                        FnSendNotifications();
                                        // SendMail();//--------email Addresses in the System

                                    end;
                                until LoanApps.Next = 0;
                                //.................................................
                                Message('Loan has successfully been posted and member notified');

                                //Audit Entries
                                if (UserId <> 'MOBILE') and (UserId <> 'ATM') and (UserId <> 'AGENCY') then begin
                                    EntryNos := 0;
                                    if Audit.FindLast then
                                        EntryNos := 1 + Audit."Entry No";
                                    Audit.Init();
                                    Audit."Entry No" := EntryNos;
                                    Audit."Transaction Type" := 'Loan Disbursement';
                                    Audit."Loan Number" := Rec."Loan  No.";
                                    Audit."Document Number" := Rec."Loan  No.";
                                    Audit.UsersId := UserId;
                                    Audit.Amount := Rec."Requested Amount";
                                    Audit.Date := Today;
                                    Audit.Time := Time;
                                    Audit.Source := 'LOAN Disbursement';
                                    Audit.Insert();
                                    Commit();
                                end;
                                //End Audit Entries
                                CurrPage.Update();
                                CurrPage.close();
                            end;
                        end;
                    end;
                }
                action("Send Approvals")
                {
                    Caption = 'Send For Approval';
                    Visible = false;
                    Enabled = (not OpenApprovalEntriesExist) AND EnabledApprovalWorkflowsExist AND (not RecordApproved);
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        FnCheckForTestFields();
                        if Confirm('Send Approval Request For Loan Application of Ksh. ' + Format(Rec."Approved Amount") + ' applied by ' + Format(Rec."Client Name") + ' ?', false) = false then begin
                            exit;
                        end
                        else begin
                            SrestepApprovalsCodeUnit.SendLoanApplicationsRequestForApproval(rec."Loan  No.", Rec);
                            FnSendLoanApprovalNotifications();
                            CurrPage.close();
                        end;
                    end;
                }
                action("Cancel Approvals")
                {
                    Caption = 'Cancel For Approval';
                    Enabled = CanCancelApprovalForRecord;
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    visible = false;

                    trigger OnAction()
                    begin
                        if Confirm('Cancel Approval?', false) = false then begin
                            exit;
                        end
                        else begin
                            SrestepApprovalsCodeUnit.CancelLoanApplicationsRequestForApproval(rec."Loan  No.", Rec);
                            CurrPage.Close();
                        end;
                    end;
                }
                action("View Schedule")
                {
                    ApplicationArea = Basic;
                    Caption = 'View Schedule';
                    Image = ViewDetails;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        if (Rec."Repayment Start Date" = 0D) then Error('Please enter Disbursement Date to continue');
                        SFactory.FnGenerateRepaymentSchedule(Rec."Loan  No.");
                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", Rec."Loan  No.");
                        if LoanApp.Find('-') then begin
                            Report.Run(50477, true, false, LoanApp);
                        end;
                    end;
                }
                action("Loans to Offset")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loans to Offset';
                    //Enabled = (not OpenApprovalEntriesExist) AND EnabledApprovalWorkflowsExist AND (not RecordApproved);
                    Image = AddAction;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Loan Offset Detail List";
                    RunPageLink = "Loan No." = field("Loan  No."), "Client Code" = field("Client Code");
                }
                action("Reoppen Application")
                {
                    ApplicationArea = basic;
                    Caption = 'Re open Application';
                    Image = Open;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        if Rec.Posted = true then begin
                            Error('Prohibited ! The loan is already Posted');
                        end;
                        Rec.CalcFields("Outstanding Balance");
                        if Rec."Outstanding Balance" > 0 then begin
                            Error('Prohibited ! The loan is already Posted');
                        end;

                        if Confirm('Are you sure you want to re open this Loan?', true) = true then begin
                            Rec."loan status" := Rec."loan status"::Application;
                            Rec."Approval Status" := Rec."Approval Status"::Open;
                            // Rec."Appraisal Status":=Rec."Appraisal Status"::
                            Rec.Modify(true);

                            Message('Loan Application Re-Opened Successfly');
                            CurrPage.Close();
                        end;
                    end;
                }
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        UpdateControl();
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(REC.RecordId); //Return No and allow sending of approval request.
        EnabledApprovalWorkflowsExist := true;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        LoansR.Reset;
        LoansR.SetRange(LoansR.Posted, false);
        LoansR.SetRange(LoansR."Captured By", UserId);
        if LoansR."Client Name" = '' then begin
            if LoansR.Count > 1 then begin
                if Confirm('There are still some Unused Loan Nos. Continue?', false) = false then begin
                    Error('There are still some Unused Loan Nos. Please utilise them first');
                end;
            end;
        end;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        LoanAppPermisions();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Source := Rec.Source::BOSA;
        Rec."Mode of Disbursement" := Rec."mode of disbursement"::Cheque;
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
    end;

    trigger OnOpenPage()
    begin
        Rec.SetRange(Posted, false);
        // Rec.SetRange("Loan Status",issued);
    end;

    var
        ClientCode: Code[40];
        Audit: record "Audit Entries";
        EntryNos: Integer;
        DirbursementDate: Date;
        VarAmounttoDisburse: Decimal;
        LoanGuar: Record "Loans Guarantee Details";
        SMSMessages: Record "SMS Messages";
        i: Integer;
        LoanType: Record "Loan Products Setup";
        PeriodDueDate: Date;
        ScheduleRep: Record "Loan Repayment Schedule";
        RunningDate: Date;
        G: Integer;
        IssuedDate: Date;
        GracePeiodEndDate: Date;
        InstalmentEnddate: Date;
        GracePerodDays: Integer;
        InstalmentDays: Integer;
        NoOfGracePeriod: Integer;
        NewSchedule: Record "Loan Repayment Schedule";
        RSchedule: Record "Loan Repayment Schedule";
        GP: Text[30];
        ScheduleCode: Code[20];
        PreviewShedule: Record "Loan Repayment Schedule";
        PeriodInterval: Code[10];
        CustomerRecord: Record Customer;
        Gnljnline: Record "Gen. Journal Line";
        //  Jnlinepost: Codeunit "Gen. Jnl.-Post Line";
        CumInterest: Decimal;
        NewPrincipal: Decimal;
        PeriodPrRepayment: Decimal;
        GenBatch: Record "Gen. Journal Batch";
        LineNo: Integer;
        GnljnlineCopy: Record "Gen. Journal Line";
        NewLNApplicNo: Code[10];
        Cust: Record Customer;
        LoanApp: Record "Loans Register";
        TestAmt: Decimal;
        CustRec: Record Customer;
        CustPostingGroup: Record "Customer Posting Group";
        GenSetUp: Record "Sacco General Set-Up";
        PCharges: Record "Loan Product Charges";
        TCharges: Decimal;
        LAppCharges: Record "Loan Applicaton Charges";
        LoansR: Record "Loans Register";
        LoanAmount: Decimal;
        InterestRate: Decimal;
        RepayPeriod: Integer;
        LBalance: Decimal;
        RunDate: Date;
        InstalNo: Decimal;
        RepayInterval: DateFormula;
        TotalMRepay: Decimal;
        LInterest: Decimal;
        LPrincipal: Decimal;
        RepayCode: Code[40];
        GrPrinciple: Integer;
        GrInterest: Integer;
        QPrinciple: Decimal;
        QCounter: Integer;
        InPeriod: DateFormula;
        InitialInstal: Integer;
        InitialGraceInt: Integer;
        GenJournalLine: Record "Gen. Journal Line";
        FOSAComm: Decimal;
        BOSAComm: Decimal;
        LoanTopUp: Record "Loan Offset Details";
        Vend: Record Vendor;
        BOSAInt: Decimal;
        TopUpComm: Decimal;
        DActivity: Code[20];
        DBranch: Code[20];
        TotalTopupComm: Decimal;
        Notification: Codeunit Mail;
        CustE: Record Customer;
        DocN: Text[50];
        DocM: Text[100];
        DNar: Text[250];
        DocF: Text[50];
        MailBody: Text[250];
        ccEmail: Text[250];
        LoanG: Record "Loans Guarantee Details";
        SpecialComm: Decimal;
        FOSAName: Text[150];
        IDNo: Code[50];
        MovementTracker: Record "Movement Tracker";
        DiscountingAmount: Decimal;
        StatusPermissions: Record "Status Change Permision";
        BridgedLoans: Record "Loan Special Clearance";
        SMSMessage: Record "SMS Messages";
        InstallNo2: Integer;
        currency: Record "Currency Exchange Rate";
        CURRENCYFACTOR: Decimal;
        LoanApps: Record "Loans Register";
        LoanDisbAmount: Decimal;
        BatchTopUpAmount: Decimal;
        BatchTopUpComm: Decimal;
        Disbursement: Record "Loan Disburesment-Batching";
        SchDate: Date;
        DisbDate: Date;
        WhichDay: Integer;
        LBatches: Record "Loans Register";
        SalDetails: Record "Loan Appraisal Salary Details";
        LGuarantors: Record "Loans Guarantee Details";
        Text001: label 'Status Must Be Open';
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batches,"Payment Voucher","Petty Cash",Requisition,Loan,Interbank,Imprest,Checkoff,"FOSA Account Opening",StandingOrder,HRJob,HRLeave,"HRTransport Request",HRTraining,"HREmp Requsition",MicroTrans,"Account Reactivation","Overdraft ",BLA,"Member Editable","FOSA Opening","Loan Batching",Leave,"Imprest Requisition","Imprest Surrender","Stores Requisition","Funds Transfer","Change Request","Staff Claims","BOSA Transfer","Loan Tranche","Loan TopUp","Memb Opening","Member Withdrawal";
        CurrpageEditable: Boolean;
        LoanStatusEditable: Boolean;
        MNoEditable: Boolean;
        ApplcDateEditable: Boolean;
        LProdTypeEditable: Boolean;
        InstallmentEditable: Boolean;
        AppliedAmountEditable: Boolean;
        ApprovedAmountEditable: Boolean;
        RepayMethodEditable: Boolean;
        RepaymentEditable: Boolean;
        BatchNoEditable: Boolean;
        RepayFrequencyEditable: Boolean;
        ModeofDisburesmentEdit: Boolean;
        DisbursementDateEditable: Boolean;
        AccountNoEditable: Boolean;
        LNBalance: Decimal;
        ApprovalEntries: Record "Approval Entry";
        RejectionRemarkEditable: Boolean;
        ApprovalEntry: Record "Approval Entry";
        Table_id: Integer;
        Doc_No: Code[20];
        PepeaShares: Decimal;
        SaccoDeposits: Decimal;
        Doc_Type: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Account Opening","Member Closure",Loan;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        compinfo: Record "Company Information";
        iEntryNo: Integer;
        eMAIL: Text;
        "Telephone No": Integer;
        Text002: label 'The Loan has already been approved';
        LoanSecurities: Integer;
        EditableField: Boolean;
        SFactory: Codeunit "Swizzsoft Factory";
        OpenApprovalEntriesExist: Boolean;
        TemplateName: Code[50];
        BatchName: Code[50];
        EnabledApprovalWorkflowsExist: Boolean;
        RecordApproved: Boolean;
        SrestepApprovalsCodeUnit: Codeunit SurestepApprovalsCodeUnit;
        CanCancelApprovalForRecord: Boolean;

    procedure UpdateControl()
    begin
        if Rec."Loan Status" = Rec."loan status"::Application then begin
            RecordApproved := false;
            MNoEditable := true;
            ApplcDateEditable := false;
            LoanStatusEditable := true;
            LProdTypeEditable := true;
            InstallmentEditable := true;
            AppliedAmountEditable := true;
            ApprovedAmountEditable := true;
            RepayMethodEditable := true;
            RepaymentEditable := true;
            BatchNoEditable := false;
            RepayFrequencyEditable := true;
            ModeofDisburesmentEdit := true;
            DisbursementDateEditable := false;
            CanCancelApprovalForRecord := false;
        end;
        if Rec."Loan Status" = Rec."loan status"::Appraisal then begin
            RecordApproved := true;
            MNoEditable := false;
            ApplcDateEditable := false;
            LoanStatusEditable := false;
            LProdTypeEditable := false;
            InstallmentEditable := false;
            AppliedAmountEditable := false;
            ApprovedAmountEditable := true;
            RepayMethodEditable := true;
            RepaymentEditable := true;
            BatchNoEditable := false;
            RepayFrequencyEditable := false;
            ModeofDisburesmentEdit := true;
            DisbursementDateEditable := false;
            CanCancelApprovalForRecord := true;
        end;
        if Rec."Loan Status" = Rec."loan status"::Rejected then begin
            RecordApproved := true;
            MNoEditable := false;
            AccountNoEditable := false;
            ApplcDateEditable := false;
            LoanStatusEditable := false;
            LProdTypeEditable := false;
            InstallmentEditable := false;
            AppliedAmountEditable := false;
            ApprovedAmountEditable := false;
            RepayMethodEditable := false;
            RepaymentEditable := false;
            BatchNoEditable := false;
            RepayFrequencyEditable := false;
            ModeofDisburesmentEdit := false;
            DisbursementDateEditable := false;
            RejectionRemarkEditable := false;
            CanCancelApprovalForRecord := false;
        end;
        if Rec."Approval Status" = Rec."approval status"::Approved then begin
            RecordApproved := true;
            MNoEditable := false;
            AccountNoEditable := false;
            LoanStatusEditable := false;
            ApplcDateEditable := false;
            LProdTypeEditable := false;
            InstallmentEditable := false;
            AppliedAmountEditable := false;
            ApprovedAmountEditable := false;
            RepayMethodEditable := false;
            RepaymentEditable := false;
            BatchNoEditable := true;
            RepayFrequencyEditable := false;
            ModeofDisburesmentEdit := true;
            DisbursementDateEditable := true;
            RejectionRemarkEditable := false;
            RecordApproved := true;
            CanCancelApprovalForRecord := false;
        end;
    end;

    procedure LoanAppPermisions()
    begin
    end;

    procedure SendSMS()
    begin
        GenSetUp.Get;
        compinfo.Get;
        if GenSetUp."Send SMS Notifications" = true then begin
            //SMS MESSAGE
            SMSMessage.Reset;
            if SMSMessage.Find('+') then begin
                iEntryNo := SMSMessage."Entry No";
                iEntryNo := iEntryNo + 1;
            end
            else begin
                iEntryNo := 1;
            end;
            SMSMessage.Init;
            SMSMessage."Entry No" := iEntryNo;
            SMSMessage."Batch No" := Rec."Batch No.";
            SMSMessage."Document No" := Rec."Loan  No.";
            SMSMessage."Account No" := Rec."Account No";
            SMSMessage."Date Entered" := Today;
            SMSMessage."Time Entered" := Time;
            SMSMessage.Source := 'LOANS';
            SMSMessage."Entered By" := UserId;
            SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
            SMSMessage."SMS Message" := 'Your' + Format(Rec."Loan Product Type Name") + 'Loan Application of amount ' + Format(Rec."Requested Amount") + ' for ' + Rec."Client Code" + ' ' + Rec."Client Name" + ' has been received and is being Processed ' + compinfo.Name + ' ' + GenSetUp."Customer Care No";
            Cust.Reset;
            Cust.SetRange(Cust."No.", Rec."Client Code");
            if Cust.Find('-') then begin
                SMSMessage."Telephone No" := Cust."Mobile Phone No";
            end;
            SMSMessage.Insert;
        end;
    end;


    local procedure FnCheckForTestFields()
    var
        LoanType: Record "Loan Products Setup";
        LoanGuarantors: Record "Loans Guarantee Details";
    begin
        //--------------------
        if Rec."Approval Status" = Rec."Approval Status"::Approved then begin
            Error('The loan has already been approved');
        end;
        if Rec."Approval Status" <> Rec."Approval Status"::Open then begin
            Error('Approval status MUST be Open');
        end;
        Rec.TestField("Requested Amount");
        Rec.TestField("Main-Sector");
        Rec.TestField("Sub-Sector");
        Rec.TestField("Specific-Sector");
        Rec.TestField("Loan Product Type");
        Rec.TestField("Mode of Disbursement");
        //----------------------
        if LoanType.get(Rec."Loan Product Type") then begin
            if LoanType."Appraise Guarantors" = true then begin
                LoanGuarantors.Reset();
                LoanGuarantors.SetRange(LoanGuarantors."Loan No", Rec."Loan  No.");
                if LoanGuarantors.find('-') then begin
                    Error('Please Insert Loan Applicant Guarantor Details!');
                end;
            end;
        end;
    end;



    local procedure FnSendLoanApprovalNotifications()
    var
    begin
        //...........................Notify Loaner
        SMSMessages.RESET;
        IF SMSMessages.FIND('+') THEN BEGIN
            iEntryNo := SMSMessages."Entry No";
            iEntryNo := iEntryNo + 1;
        END
        ELSE BEGIN
            iEntryNo := 1;
        END;
        SMSMessages.RESET;
        SMSMessages.INIT;
        SMSMessages."Entry No" := iEntryNo;
        SMSMessages."Account No" := Rec."Client Code";
        SMSMessages."Date Entered" := TODAY;
        SMSMessages."Time Entered" := TIME;
        SMSMessages.Source := 'LOAN APPL';
        SMSMessages."Entered By" := USERID;
        SMSMessages."Sent To Server" := SMSMessages."Sent To Server"::No;
        SMSMessages."SMS Message" := 'Your' + Format(Rec."Loan Product Type Name") + 'loan application of KSHs.' + FORMAT(Rec."Requested Amount") + ' has been received. Polytech Sacco Ltd.';
        Cust.RESET;
        IF Cust.GET(Rec."Client Code") THEN
            if Cust."Mobile Phone No" <> '' then begin
                SMSMessages."Telephone No" := Cust."Mobile Phone No";
            end
            else
                if (Cust."Mobile Phone No" = '') and (Cust."Mobile Phone No." <> '') then begin
                    SMSMessages."Telephone No" := Cust."Mobile Phone No.";
                end;
        SMSMessages.INSERT;
        //.......................................Notify Guarantors
        LoanGuar.RESET;
        LoanGuar.SETRANGE(LoanGuar."Loan No", Rec."Loan  No.");
        IF LoanGuar.FIND('-') THEN BEGIN
            REPEAT
                Cust.RESET;
                Cust.SETRANGE(Cust."No.", LoanGuar."Member No");
                IF Cust.FIND('-') THEN BEGIN
                    SMSMessages.RESET;
                    IF SMSMessages.FIND('+') THEN BEGIN
                        iEntryNo := SMSMessages."Entry No";
                        iEntryNo := iEntryNo + 1;
                    END
                    ELSE BEGIN
                        iEntryNo := 1;
                    END;
                    SMSMessages.INIT;
                    SMSMessages."Entry No" := iEntryNo;
                    SMSMessages."Account No" := LoanGuar."Member No";
                    SMSMessages."Date Entered" := TODAY;
                    SMSMessages."Time Entered" := TIME;
                    SMSMessages.Source := 'LOAN GUARANTORS';
                    SMSMessages."Entered By" := USERID;
                    SMSMessages."Sent To Server" := SMSMessages."Sent To Server"::No;
                    IF LoanApp.GET(LoanGuar."Loan No") THEN SMSMessages."SMS Message" := 'You have guaranteed an amount of ' + FORMAT(LoanGuar."Amont Guaranteed") + ' to ' + Rec."Client Name" + '  ' + 'Loan Type ' + Rec."Loan Product Type Name" + ' ' + 'of ' + FORMAT(Rec."Requested Amount") + ' at Polytech Sacco Ltd. Call 0726050260 if in dispute';
                    ;
                    SMSMessages."Telephone No" := Cust."Phone No.";
                    SMSMessages.INSERT;
                END;
            UNTIL LoanGuar.NEXT = 0;
        END;
    end;

    local procedure FnMemberHasAnExistingLoanSameProduct(): Boolean
    var
        LoansReg: Record "Loans Register";
        Balance: Decimal;
    begin
        Balance := 0;
        LoansReg.Reset();
        LoansReg.SetRange(LoansReg."Client Code", Rec."Client Code");
        LoansReg.SetRange(LoansReg."Loan Product Type", Rec."Loan Product Type");
        LoansReg.SetRange(LoansReg.Posted, true);
        LoansReg.SetAutoCalcFields(LoansReg."Outstanding Balance", LoansReg."Oustanding Interest");
        if LoansReg.Find('-') then begin
            repeat
                Balance += LoansReg."Outstanding Balance" + LoansReg."Oustanding Interest";
            until LoansReg.Next = 0;
        end;
        if Balance > 0 then begin
            exit(true)
        end
        else
            if Balance <= 0 then begin
                exit(false);
            end;
    end;

    local procedure FnGetProductOutstandingBal(): Decimal
    var
        LoansReg: Record "Loans Register";
        Balance: Decimal;
    begin
        Balance := 0;
        LoansReg.Reset();
        LoansReg.SetRange(LoansReg."Client Code", Rec."Client Code");
        LoansReg.SetRange(LoansReg."Loan Product Type", Rec."Loan Product Type");
        LoansReg.SetRange(LoansReg.Posted, true);
        LoansReg.SetAutoCalcFields(LoansReg."Outstanding Balance", LoansReg."Oustanding Interest");
        if LoansReg.Find('-') then begin
            repeat
                Balance += LoansReg."Outstanding Balance" + LoansReg."Oustanding Interest";
            until LoansReg.Next = 0;
        end;
        exit(Balance);
    end;

    local procedure FnCheckMissingContributions(memberNumber: Code[20]) MissingAmount: Decimal
    var
        DepositRec: Record "Cust. Ledger Entry";
        CurrentYear: Integer;
        StartMonth, CurrentMonth, i : Integer;
        MissingMonths: List of [Integer];
        Found: Boolean;
        StartDate, EndDate, PostingDate : Date;
        monthlyContribution: Decimal;
    begin
        MissingAmount := 0;
        monthlyContribution := GetMonthlyContribution(memberNumber);

        CurrentYear := Date2DMY(Today, 3);
        CurrentMonth := Date2DMY(Today, 2);
        StartMonth := 1;

        for i := StartMonth to CurrentMonth do begin
            Found := false;

            StartDate := DMY2Date(i, 1, CurrentYear);
            EndDate := CALCDATE('<1M>', StartDate) - 1;

            PostingDate := DirbursementDate;

            StartDate := DMY2Date(1, i, CurrentYear);
            EndDate := CALCDATE('<1M>', StartDate) - 1;

            DepositRec.Reset();
            DepositRec.SetRange("Customer No.", memberNumber);
            DepositRec.SetRange("Posting Date", StartDate, EndDate);
            DepositRec.SetRange("Transaction Type", DepositRec."Transaction Type"::"Deposit Contribution");

            if DepositRec.FindFirst() then
                Found := true;

            if not Found then begin
                MissingMonths.Add(i);
                MissingAmount := MissingAmount + monthlyContribution;
                FnInsertMissingContributions(
                    memberNumber,
                    monthlyContribution,
                    Format(StartDate, 0, '<Month Text>'),
                    PostingDate);

                FnInsertMissingLines(
                    memberNumber,
                    monthlyContribution,
                    Format(StartDate, 0, '<Month Text>'),
                    StartDate,
                    i,
                    CurrentYear
                    );
            end;
        end;
    end;



    procedure GetMonthlyContribution(MemberNo: Code[20]) Amount: Decimal
    var
        memberRegister: Record Customer;
    begin
        Amount := 0;
        if memberRegister.Get(MemberNo) then
            Amount := memberRegister."Monthly Contribution";
    end;

    procedure FnInsertMissingLines(MemberNo: Code[20]; AmountPosted: Decimal; monthDeducted: Code[50]; postingDate: Date; iMonth: Integer; CurrentYear: Integer)
    var
        missingTable: Record "Missing Contributions";
    begin
        missingTable.Init();
        missingTable."Loan Number" := Rec."Loan  No.";
        missingTable."Member Number" := Rec."Client Code";
        missingTable.AmountPosted := AmountPosted;
        missingTable.Description := 'Loan-Deposits Contribution for ' + monthDeducted;
        missingTable."Batch No" := BatchName;
        missingTable."Member Name" := Rec."Client Name";
        missingTable."Month Missing" := DMY2Date(1, iMonth, CurrentYear);
        missingTable."Month Name" := monthDeducted;

        missingTable.Insert(true);
    end;

    procedure FnInsertMissingContributions(MemberNo: Code[20]; AmountPosted: Decimal; monthDeducted: Code[50]; postingDate: Date)
    var
    begin

        LineNo := LineNo + 10000;
        DirbursementDate := Rec."Loan Disbursement Date";

        SFactory.FnCreateGnlJournalLine(TemplateName
        , BatchName
        , Rec."Loan  No."
        , LineNo
        , GenJournalLine."Transaction Type"::"Deposit Contribution"
        , GenJournalLine."Account Type"::Customer
        , LoanApps."Client Code"
        , DirbursementDate
        , -AmountPosted
        , 'BOSA'
        , Rec."Loan  No."
        , 'Loan-Deposits Contribution for ' + monthDeducted
        , ''
        );
    end;


    local procedure FnInsertBOSALines(var LoanApps: Record "Loans Register"; LoanNo: Code[30]; VarAmounttoDisburse: Decimal)
    var
        EndMonth: Date;
        RemainingDays: Integer;
        TMonthDays: Integer;
        Sfactorycode: Codeunit "Swizzsoft Factory";
        AmountTop: Decimal;
        NetAmount: Decimal;
    begin
        AmountTop := 0;
        NetAmount := 0;
        //--------------------Generate Schedule
        Sfactorycode.FnGenerateRepaymentSchedule(Rec."Loan  No.");
        DirbursementDate := Rec."Loan Disbursement Date";
        // VarAmosunttoDisburse := Rec."Approved Amount";
        //....................PRORATED DAYS
        EndMonth := CALCDATE('-1D', CALCDATE('1M', DMY2DATE(1, DATE2DMY(Today, 2), DATE2DMY(Today, 3))));
        RemainingDays := (EndMonth - Today) + 1;
        TMonthDays := DATE2DMY(EndMonth, 1);

        //....................Loan Posting Lines
        GenSetUp.GET;
        DActivity := '';
        DBranch := '';
        IF Cust.GET(LoanApps."Client Code") THEN BEGIN
            DActivity := Cust."Global Dimension 1 Code";
            DBranch := Cust."Global Dimension 2 Code";
        END;
        //**************Loan Principal Posting**********************************
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Rec."Loan  No.", LineNo, GenJournalLine."Transaction Type"::Loan, GenJournalLine."Account Type"::Customer, LoanApps."Client Code", DirbursementDate, Rec."Approved Amount", 'BOSA', LoanApps."Loan  No.", 'Loan Disbursement - ' + LoanApps."Loan Product Type", LoanApps."Loan  No.");
        //--------------------------------RECOVER OVERDRAFT()-------------------------------------------------------
        //Code Here

        //...................Cater for Loan Offset Now !
        Rec.CalcFields("Top Up Amount");
        if Rec."Top Up Amount" > 0 then begin
            LoanTopUp.RESET;
            LoanTopUp.SETRANGE(LoanTopUp."Loan No.", Rec."Loan  No.");
            IF LoanTopUp.FIND('-') THEN BEGIN
                repeat
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Rec."Loan  No.", LineNo, GenJournalLine."Transaction Type"::"Loan Repayment", GenJournalLine."Account Type"::Customer, LoanApps."Client Code", DirbursementDate, LoanTopUp."Principle Top Up" * -1, 'BOSA', LoanApps."Loan  No.", 'Loan OffSet By - ' + LoanApps."Loan  No.", LoanTopUp."Loan Top Up");
                    //..................Recover Interest On Top Up
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Rec."Loan  No.", LineNo, GenJournalLine."Transaction Type"::"Interest Paid", GenJournalLine."Account Type"::Customer, LoanApps."Client Code", DirbursementDate, LoanTopUp."Interest Top Up" * -1, 'BOSA', LoanApps."Loan  No.", 'Interest Due Paid on top up - ', LoanTopUp."Loan Top Up");
                    //If there is top up commission charged write it here start
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(TemplateName, BatchName, LoanApps."Loan  No.", LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::"G/L Account", GenSetUp."Top up Account", DirbursementDate, LoanTopUp.Commision * -1, 'BOSA', Rec."Batch No.", 'Commision on top up - ', LoanTopUp."Loan Top Up");

                    AmountTop := (LoanTopUp."Principle Top Up" + LoanTopUp."Interest Top Up" + LoanTopUp.Commision);
                    VarAmounttoDisburse := VarAmounttoDisburse - (LoanTopUp."Principle Top Up" + LoanTopUp."Interest Top Up" + LoanTopUp.Commision);
                UNTIL LoanTopUp.NEXT = 0;
            END;
        end;
        //If there is top up commission charged write it here start // "Loan Insurance"
        //If there is top up commission charged write it here end

        //***************************Loan Product Charges code
        PCharges.Reset();
        PCharges.SETRANGE(PCharges."Product Code", Rec."Loan Product Type");
        IF PCharges.FIND('-') THEN BEGIN
            REPEAT
                //Credit G/L
                PCharges.TESTFIELD(PCharges."G/L Account");
                LineNo := LineNo + 10000;
                GenJournalLine.INIT;
                GenJournalLine."Journal Template Name" := TemplateName;
                GenJournalLine."Journal Batch Name" := BatchName;
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."Account Type"::"G/L Account";
                GenJournalLine."Account No." := PCharges."G/L Account";
                GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                GenJournalLine."Document No." := Rec."Loan  No.";
                GenJournalLine."External Document No." := Rec."Loan  No.";
                GenJournalLine."Posting Date" := DirbursementDate;
                GenJournalLine.Description := PCharges.Description + '-' + Format(Rec."Loan  No.");
                IF PCharges."Use Perc" = TRUE THEN BEGIN
                    GenJournalLine.Amount := (Rec."Approved Amount" * (PCharges.Percentage / 100)) * -1
                END
                ELSE
                    IF PCharges."Use Perc" = false then begin
                        if (NetAmount >= 1000000) then
                            GenJournalLine.Amount := PCharges.Amount2 * -1
                        else
                            GenJournalLine.Amount := PCharges.Amount * -1
                    end;
                GenJournalLine.VALIDATE(GenJournalLine.Amount);
                GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                IF GenJournalLine.Amount <> 0 THEN begin
                    GenJournalLine.INSERT;
                    VarAmounttoDisburse := VarAmounttoDisburse - (GenJournalLine.Amount * -1);
                end;
            UNTIL PCharges.NEXT = 0;

        END;

        NetAmount := VarAmounttoDisburse - (Rec."Loan Processing Fee" + Rec."Loan Dirbusement Fee" + Rec."Loan Insurance" /* + AmountTop */);

        //end of code
        //.....Valuation
        VarAmounttoDisburse := VarAmounttoDisburse - (/* Rec."Loan Processing Fee"  + */Rec."Loan Dirbusement Fee" /*+ Rec."Loan Insurance"*/);
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLine(TemplateName, BatchName, LoanApps."Loan  No.", LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::"G/L Account", GenSetUp."Asset Valuation Cost", DirbursementDate, LoanApps."Valuation Cost" * -1, 'BOSA', Rec."Batch No.", 'Loan Principle Amount ' + Format(LoanApps."Loan  No."), '');
        VarAmounttoDisburse := VarAmounttoDisburse - LoanApps."Valuation Cost";
        //...Debosting amount
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLine(TemplateName, BatchName, LoanApps."Loan  No.", LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::"G/L Account", GenSetUp."Boosting Fees Account", DirbursementDate, LoanApps."Deboost Commision" * -1, 'BOSA', Rec."Batch No.", 'Debosting commision ' + Format(LoanApps."Loan  No."), '');
        VarAmounttoDisburse := VarAmounttoDisburse - LoanApps."Deboost Commision";
        //Debosting commsion
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLine(TemplateName, BatchName, LoanApps."Loan  No.", LineNo, GenJournalLine."Transaction Type"::"Deposit Contribution", GenJournalLine."Account Type"::Customer, LoanApps."Client Code", DirbursementDate, LoanApps."Deboost Amount" * -1, 'BOSA', Rec."Batch No.", 'Debosted shares ' + Format(LoanApps."Loan  No."), '');
        VarAmounttoDisburse := VarAmounttoDisburse - LoanApps."Deboost Amount";
        //..Legal Fees
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLine(TemplateName, BatchName, LoanApps."Loan  No.", LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::"G/L Account", GenSetUp."Legal Fees", DirbursementDate, LoanApps."Legal Cost" * -1, 'BOSA', Rec."Batch No.", 'Loan Principle Amount ' + Format(LoanApps."Loan  No."), '');
        VarAmounttoDisburse := VarAmounttoDisburse - LoanApps."Legal Cost";
        //------------------------------------2. CREDIT MEMBER BANK A/C---------------------------------------------------------------------------------------------
        LineNo := LineNo + 10000;
        // SFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Rec."Loan  No.", LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::"Bank Account", LoanApps."Paying Bank Account No", DirbursementDate, VarAmounttoDisburse * -1, 'BOSA', LoanApps."Loan  No.", 'Loan Principle Amount ' + Format(Rec."Loan  No."), '');

        // Choose Account Based on Disbursement Type & Loan Product
        case LoanApps."Loan Product Type" of
            '21':
                begin
                    SFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Rec."Loan  No.", LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::"G/L Account", '101053', DirbursementDate, VarAmounttoDisburse * -1, 'BOSA', LoanApps."Loan  No.", Format(Rec."Loan  No.") + ' Loan disbursed for ' + LoanApps."Client Name", '');
                end;
            '26':
                begin
                    SFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Rec."Loan  No.", LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::"G/L Account", '201215', DirbursementDate, VarAmounttoDisburse * -1, 'BOSA', LoanApps."Loan  No.", Format(Rec."Loan  No.") + ' Loan disbursed for ' + LoanApps."Client Name", '');
                end;
            else begin
                if LoanApps."Disburesment Type" = LoanApps."disburesment type"::"Full/Single disbursement" then begin
                    SFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Rec."Loan  No.", LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::"Bank Account", LoanApps."Paying Bank Account No", DirbursementDate, VarAmounttoDisburse * -1, 'BOSA', LoanApps."Loan  No.", Format(Rec."Loan  No.") + ' Loan disbursed for ' + LoanApps."Client Name", '');
                end else
                    if LoanApps."Disburesment Type" = LoanApps."disburesment type"::"Tranche/Multiple Disbursement" then begin
                        SFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Rec."Loan  No.", LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::"G/L Account", '201209', DirbursementDate, VarAmounttoDisburse * -1, 'BOSA', LoanApps."Loan  No.", Format(Rec."Loan  No.") + ' Loan disbursed for ' + LoanApps."Client Name", '');
                    end;
            end;
        end;

    end;

    local procedure FnSendNotifications()
    var
        msg: Text[250];
        PhoneNo: Text[250];
        LoanDate: Date;
        DueDate: Date;
    begin
        msg := '';
        LoansR.Reset();
        LoansR.SetRange(LoansR."Loan  No.", Rec."Loan  No.");
        if LoansR.Find('-') then begin

            msg := 'Dear ' + SplitString(LoansR."Client Name", ' ') +
                   ', Your ' + Format(LoansR."Loan Product Type Name") +
                   ' loan application of KSHs.' + Format(Rec."Requested Amount") +
                   ' has been processed and deposited to your Account, ' +
                   ' The loan repayment start date will be ' + FORMAT(Rec."Repayment Start Date");

            PhoneNo := FnGetPhoneNo(Rec."Client Code");
            SendSMSMessage(Rec."Client Code", msg, PhoneNo);
        end;
    end;

    procedure SendMail()
    var
        EmailBody: Text[2000]; // Increased length to avoid truncation
        EmailSubject: Text[150];
        EmailAddress: Text[100];
        CompanyInfo: Record "Company Information";
        Member: Record Customer;
        MemberName: Text[100];
        EmailHelper: Codeunit Emailcodeunit;
        PhoneNo: Text[50];
        Loan: Record "Loans Register";
    begin
        // Initialize
        EmailBody := '';
        EmailSubject := 'Polytech Loan Application';
        CompanyInfo.Get();

        // Get Member Info
        if Member.Get(Rec."Client Code") then begin
            EmailAddress := Member."E-Mail";
            MemberName := Member.Name;
        end;

        // Get Loan Info
        if Loan.Get(Rec."Loan  No.") then begin
            EmailBody :=
                'Dear <b>' + SplitString(Loan."Client Name", ' ') + '</b>,<br/><br/>' +
                'Your ' + Format(Loan."Loan Product Type Name") +
                ' loan application of KShs. ' + Format(Rec."Requested Amount") +
                ' has been processed and deposited into your account.<br/>' +
                'The loan repayment start date will be  ' + Format(Rec."Repayment Start Date") + '.<br/><br/>' +
                'Thank you for choosing Polytech Sacco. ' + '.<br/><br/>' +
                'Kind regards,<br/><br/>' +
                CompanyInfo.Name + '<br/>' +
                CompanyInfo."Address 2" + '<br/>' +
                CompanyInfo.City + '<br/>' +
                // CompanyInfo."Country/Region Code" + '<br/>' +
                CompanyInfo."Phone No." + '<br/>' +
                CompanyInfo."E-Mail" + '<br/>' +
                CompanyInfo."Home Page";

        end;

        // Send Email
        if EmailBody <> '' then
            EmailHelper.SendMail(EmailAddress, EmailSubject, EmailBody);
    end;

    LOCAL PROCEDURE SplitString(sText: Text; separator: Text) Token: Text;
    VAR
        Pos: Integer;
        Tokenq: Text;
    BEGIN
        Pos := STRPOS(sText, separator);
        IF Pos > 0 THEN BEGIN
            Token := COPYSTR(sText, 1, Pos - 1);
            IF Pos + 1 <= STRLEN(sText) THEN
                sText := COPYSTR(sText, Pos + 1)
            ELSE
                sText := '';
        END ELSE BEGIN
            Token := sText;
            sText := '';
        END;
    END;

    local procedure SendSMSMessage(BOSANo: Code[20]; msg: Text[250]; PhoneNo: Text[250])
    begin
        SMSMessages.Reset;
        if SMSMessages.Find('+') then begin
            iEntryNo := SMSMessages."Entry No";
            iEntryNo := iEntryNo + 1;
        end
        else begin
            iEntryNo := 1;
        end;
        //--------------------------------------------------
        SMSMessages.Reset;
        SMSMessages.Init;
        SMSMessages."Entry No" := iEntryNo;
        SMSMessages."Account No" := BOSANo;
        SMSMessages."Date Entered" := Today;
        SMSMessages."Time Entered" := Time;
        SMSMessages.Source := 'LOANDISB';
        SMSMessages."Entered By" := UserId;
        SMSMessages."Sent To Server" := SMSMessages."sent to server"::No;
        SMSMessages."SMS Message" := msg;
        SMSMessages."Telephone No" := PhoneNo;
        SMSMessages.Insert;
    end;

    local procedure FnGetPhoneNo(ClientCode: Code[50]): Text[250]
    var
        Member: Record Customer;
        Vendor: Record Vendor;
    begin
        Member.Reset();
        Member.SetRange(Member."No.", ClientCode);
        if Member.Find('-') = true then begin
            if (Member."Mobile Phone No." <> '') and (Member."Mobile Phone No." <> '0') then begin
                exit(Member."Mobile Phone No.");
            end;
            if (Member."Mobile Phone No" <> '') and (Member."Mobile Phone No" <> '0') then begin
                exit(Member."Mobile Phone No");
            end;
            if (Member."Phone No." <> '') and (Member."Phone No." <> '0') then begin
                exit(Member."Phone No.");
            end;

            Vendor.Reset();
            Vendor.SetRange(Vendor."BOSA Account No", ClientCode);
            if Vendor.Find('-') then begin
                if (Vendor."Mobile Phone No." <> '') or (Vendor."Mobile Phone No." <> '0') then begin
                    exit(Vendor."Mobile Phone No.");
                end;
                if (Vendor."Mobile Phone No" <> '') or (Vendor."Mobile Phone No" <> '0') then begin
                    exit(Vendor."Mobile Phone No");
                end;
            end;
        end
        else
            if Member.find('-') = false then begin
                Vendor.Reset();
                Vendor.SetRange(Vendor."BOSA Account No", ClientCode);
                if Vendor.Find('-') then begin
                    if (Vendor."Mobile Phone No." <> '') or (Vendor."Mobile Phone No." <> '0') then begin
                        exit(Vendor."Mobile Phone No.");
                    end;
                    if (Vendor."Mobile Phone No" <> '') or (Vendor."Mobile Phone No" <> '0') then begin
                        exit(Vendor."Mobile Phone No");
                    end;
                end;
            end;
    end;

    local procedure FnCanPostLoans(UserId: Text): Boolean
    var
        UserSetUp: Record "User Setup";
    begin
        if UserSetUp.get(UserId) then begin
            if UserSetUp."Can POST Loans" = true then begin
                exit(true);
            end;
        end;
        exit(false);
    end;
}
