Page 56131 "Loan Disburesment Batch Card"
{
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Loan Disburesment-Batching";
    SourceTableView = where(Posted = const(false), Source = const(BOSA));

    layout
    {
        area(content)
        {
            field("Batch No."; Rec."Batch No.")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            field(Source; Rec.Source)
            {
                ApplicationArea = Basic;
                Editable = SourceEditable;
            }
            field("Batch Type"; Rec."Batch Type")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            field("Description/Remarks"; Rec."Description/Remarks")
            {
                ApplicationArea = Basic;
                //Editable = DescriptionEditable;
                Editable = true;
            }
            field(Status; Rec.Status)
            {
                ApplicationArea = Basic;
                Editable = true;
            }
            field("Total Loan Amount"; Rec."Total Loan Amount")
            {
                ApplicationArea = Basic;
            }
            field("No of Loans"; Rec."No of Loans")
            {
                ApplicationArea = Basic;
            }
            field("Mode Of Disbursement"; Rec."Mode Of Disbursement")
            {
                ApplicationArea = Basic;
                Editable = ModeofDisburementEditable;
                Visible = false;

                trigger OnValidate()
                begin
                    if Rec."Mode Of Disbursement" <> Rec."mode of disbursement"::Cheque then Rec."Cheque No." := Rec."Batch No.";
                    Rec.Modify;
                end;
            }
            field("Document No."; Rec."Document No.")
            {
                ApplicationArea = Basic;
                Editable = DocumentNoEditable;

                trigger OnValidate()
                begin
                end;
            }
            field(o; Rec."Posting Date")
            {
                ApplicationArea = Basic;
                Caption = 'Posting Date';
                Editable = PostingDateEditable;
            }
            // field("BOSA Bank Account"; "BOSA Bank Account")
            // {
            //     ApplicationArea = Basic;
            //     Caption = 'Paying Bank';
            //     Editable = PayingAccountEditable;
            // }
            // field("Cheque No."; LoansBatch."Cheque No.")
            // {
            //     ApplicationArea = Basic;
            //     Editable = ChequeNoEditable;
            // }
            part("`"; "Loans Sub-Page List Disburse")
            {
                Editable = false;
                SubPageLink = "Batch No." = field("Batch No.");
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group(LoansB)
            {
                Caption = 'Batch';

                action("Send A&pproval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    Enabled = SendApprovalEditable;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        Text001: label 'This Batch is already pending approval';
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        SrestepApprovalsCodeUnit: Codeunit SurestepApprovalsCodeUnit;
                    begin
                        LoanApps.Reset;
                        LoanApps.SetRange(LoanApps."Batch No.", Rec."Batch No.");
                        if LoanApps.Find('-') = false then Error('You cannot send an empty batch for approval');
                        Rec.TestField("Description/Remarks");
                        if Rec.Status <> Rec.Status::Open then Error(Text001);
                        if Confirm('Send Approval Request?', false) = true then begin
                            // Status := Status::Approved;
                            // rec.Modify(true);
                            // Message('Approved');
                            SrestepApprovalsCodeUnit.SendLoanBatchRequestForApproval(rec."Batch No.", Rec);
                        end;
                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Request';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Process;
                    Enabled = CancelApprovalEditable;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                        SrestepApprovalsCodeUnit: Codeunit SurestepApprovalsCodeUnit;
                    begin
                        if Confirm('Cancel Approval?', false) = true then begin
                            SrestepApprovalsCodeUnit.CancelLoanBatchRequestForApproval(rec."Batch No.", Rec);
                        end;
                    end;
                }
                action(Post)
                {
                    ApplicationArea = Basic;
                    Caption = 'Post Batch';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    Enabled = PostEnabled;

                    trigger OnAction()
                    var
                        Text001: label 'The Batch need to be approved.';
                        ProcessingFees: Decimal;
                        ExciseGL: Code[50];
                        PepeaShares: Decimal;
                        SaccoDeposits: Decimal;
                    begin
                        if Rec.Posted = true then Error('Batch already posted.');
                        if Rec.Status <> Rec.Status::Approved then Error(Format(Text001));
                        if Confirm('Are you sure you want to post this batch?', false) = false then begin
                            exit;
                        end
                        else begin
                            Rec.TestField("Description/Remarks");
                            Rec.TestField("Posting Date");
                            Rec.TestField("Document No.");
                            //PRORATED DAYS
                            EndMonth := CalcDate('-1D', CalcDate('1M', Dmy2date(1, Date2dmy(Rec."Posting Date", 2), Date2dmy(Rec."Posting Date", 3))));
                            RemainingDays := (EndMonth - Rec."Posting Date") + 1;
                            TMonthDays := Date2dmy(EndMonth, 1);
                            //PRORATED DAYS
                            //Delete Journal Lines
                            GenJournalLine.Reset;
                            GenJournalLine.SetRange("Journal Template Name", 'PAYMENTS');
                            GenJournalLine.SetRange("Journal Batch Name", 'LOANS');
                            GenJournalLine.DeleteAll;
                            GenSetUp.Get;
                            DActivity := '';
                            DBranch := '';
                            LoanApps.Reset;
                            LoanApps.SetRange(LoanApps."Batch No.", Rec."Batch No.");
                            //LoanApps.SetFilter(LoanApps."Loan Status", '<>Rejected');
                            if LoanApps.Find('-') then begin
                                repeat
                                    FnInsertBOSALines(LoanApps, LoanApps."Loan  No.");
                                    FnSendDisburesmentSMS(LoanApps."Loan  No.", LoanApps."Client Code");
                                    LoanApps."Loan Status" := LoanApps."Loan Status"::Issued;
                                    LoanApps.Posted := true;
                                    LoanApps."Posted By" := UserId;
                                    LoanApps."Posting Date" := Today;
                                    LoanApps."Issued Date" := LoanApps."Loan Disbursement Date";
                                    LoanApps."Approval Status" := LoanApps."Approval Status"::Approved;
                                    LoanApps."Loans Category-SASRA" := LoanApps."Loans Category-SASRA"::Perfoming;
                                    LoanApps.Modify;
                                    //.................................................
                                    CurrPage.close();
                                until LoanApps.Next = 0;
                            end;
                        end;
                        //CU posting
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'PAYMENTS');
                        GenJournalLine.SetRange("Journal Batch Name", 'LOANS');
                        if GenJournalLine.Find('-') then begin
                            Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
                        end;
                        Message('Loan has successfully been posted and member notified');
                        Rec.Posted := true;
                        Rec."Posting Date" := Today;
                        Rec."Posted By" := UserId;
                    end;
                }
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        UpdateControl();
    end;

    var
        Text001: label 'Status must be open';
        MovementTracker: Record "File Movement Tracker";
        FileMovementTracker: Record "File Movement Tracker";
        NextStage: Integer;
        EntryNo: Integer;
        NextLocation: Text[100];
        LoansBatch: Record "Loan Disburesment-Batching";
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
        Loans: Record "Loans Register";
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
        //GLPosting: Codeunit "Gen. Jnl.-Post Line";
        LoanTopUp: Record "Loan Offset Details";
        Vend: Record Vendor;
        BOSAInt: Decimal;
        TopUpComm: Decimal;
        DActivity: Code[20];
        DBranch: Code[20];
        UsersID: Record User;
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
        LoanApps: Record "Loans Register";
        Banks: Record "Bank Account";
        BatchTopUpAmount: Decimal;
        BatchTopUpComm: Decimal;
        TotalSpecialLoan: Decimal;
        SpecialLoanCl: Record "Loan Special Clearance";
        Loans2: Record "Loans Register";
        DActivityBOSA: Code[20];
        DBranchBOSA: Code[20];
        Refunds: Record "Loan Products Setup";
        TotalRefunds: Decimal;
        WithdrawalFee: Decimal;
        NetPayable: Decimal;
        NetRefund: Decimal;
        FWithdrawal: Decimal;
        OutstandingInt: Decimal;
        TSC: Decimal;
        LoanDisbAmount: Decimal;
        NegFee: Decimal;
        DValue: Record "Dimension Value";
        ChBank: Code[20];
        Trans: Record Transactions;
        TransactionCharges: Record "Transaction Charges";
        BChequeRegister: Record "Banker Cheque Register";
        OtherCommitments: Record "Other Commitements Clearance";
        BoostingComm: Decimal;
        BoostingCommTotal: Decimal;
        BridgedLoans: Record "Loan Special Clearance";
        InterestDue: Decimal;
        ContractualShares: Decimal;
        BridgingChanged: Boolean;
        BankersChqNo: Code[20];
        LastPayee: Text[100];
        RunningAmount: Decimal;
        BankersChqNo2: Code[20];
        BankersChqNo3: Code[20];
        EndMonth: Date;
        RemainingDays: Integer;
        PrincipalRepay: Decimal;
        InterestRepay: Decimal;
        TMonthDays: Integer;
        SMSMessage: Record "Loan Appraisal Salary Details";
        iEntryNo: Integer;
        Temp: Record Customer;
        Jtemplate: Code[30];
        JBatch: Code[30];
        LBatches: Record "Loan Disburesment-Batching";
        ///ApprovalMgt: Codeunit "Export F/O Consolidation"; 
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batches,"Payment Voucher","Petty Cash",Requisition,Loan,Interbank,Imprest,Checkoff,"FOSA Account Opening",StandingOrder,HRJob,HRLeave,"HRTransport Request",HRTraining,"HREmp Requsition",MicroTrans,"Account Reactivation","Overdraft ",BLA,"Member Editable","FOSA Opening","Loan Batching",Leave,"Imprest Requisition","Imprest Surrender","Stores Requisition","Funds Transfer","Change Request","Staff Claims","BOSA Transfer","Loan Tranche","Loan TopUp","Memb Opening","Member Withdrawal";
        DescriptionEditable: Boolean;
        ModeofDisburementEditable: Boolean;
        ChequeEFT: Boolean;
        DocumentNoEditable: Boolean;
        PostingDateEditable: Boolean;
        SourceEditable: Boolean;
        PayingAccountEditable: Boolean;
        ChequeNoEditable: Boolean;
        ChequeNameEditable: Boolean;
        upfronts: Decimal;
        EmergencyInt: Decimal;
        Table_id: Integer;
        Doc_No: Code[20];
        Doc_Type: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Account Opening","Member Closure",Loan,"Loan Batch";
        Deductions: Decimal;
        BatchBoostingCom: Decimal;
        HisaRepayment: Decimal;
        HisaLoan: Record "Loans Register";
        BatchHisaRepayment: Decimal;
        BatchFosaHisaComm: Decimal;
        BatchHisaShareBoostComm: Decimal;
        BatchShareCap: Decimal;
        BatchIntinArr: Decimal;
        Loaninsurance: Decimal;
        TLoaninsurance: Decimal;
        ProductCharges: Record "Loan Product Charges";
        InsuranceAcc: Code[20];
        PTEN: Code[20];
        LoanTypes: Record "Loan Products Setup";
        Customer: Record Customer;
        DataSheet: Record "Data Sheet Main";
        TotBoost: Decimal;
        ShareAmount: Decimal;
        Commitm: Decimal;
        Scharge: Decimal;
        EftAmount: Decimal;
        EFTDeduc: Decimal;
        linecharges: Decimal;
        AccountOpening: Codeunit SureAccountCharges;
        Membz: Record Customer;
        SFactory: Codeunit "Swizzsoft Factory";
        BATCH_TEMPLATE: Code[100];
        BATCH_NAME: Code[100];
        DOCUMENT_NO: Code[100];
        BalanceCutOffDate: Date;
        SMSMessages: Record "SMS Messages";
        compinfo: Record "Company Information";
        SendApprovalEditable: Boolean;
        CancelApprovalEditable: Boolean;
        PostEnabled: Boolean;
        VarAmounttoDisburse: Decimal;
        DirbursementDate: Date;
        VarLoanNo: Code[20];

    local procedure FnInsertBOSALines(var LoanApps: Record "Loans Register"; LoanNo: Code[30])
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
        VarLoanNo := LoanNo;
        BATCH_TEMPLATE := 'PAYMENTS';
        BATCH_NAME := 'LOANS';
        DOCUMENT_NO := VarLoanNo;
        IF LoanApps.GET(VarLoanNo) THEN BEGIN
            repeat
                //--------------------Generate Schedule
                Sfactorycode.FnGenerateRepaymentSchedule(LoanApps."Loan  No.");
                DirbursementDate := Rec."Posting Date";
                VarAmounttoDisburse := LoanApps."Approved Amount";
                //....................PRORATED DAYS
                EndMonth := CALCDATE('-1D', CALCDATE('1M', DMY2DATE(1, DATE2DMY(Today, 2), DATE2DMY(Today, 3))));
                RemainingDays := (EndMonth - Today) + 1;
                TMonthDays := DATE2DMY(EndMonth, 1);
                //....................Ensure that If Batch doesnt exist then create
                IF NOT GenBatch.GET(BATCH_TEMPLATE, BATCH_NAME) THEN BEGIN
                    GenBatch.INIT;
                    GenBatch."Journal Template Name" := BATCH_TEMPLATE;
                    GenBatch.Name := BATCH_NAME;
                    GenBatch.INSERT;
                END;
                //....................Reset General Journal Lines
                GenJournalLine.RESET;
                GenJournalLine.SETRANGE("Journal Template Name", BATCH_TEMPLATE);
                GenJournalLine.SETRANGE("Journal Batch Name", BATCH_NAME);
                GenJournalLine.DELETEALL;
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
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, LoanApps."Loan  No.", LineNo, GenJournalLine."Transaction Type"::Loan, GenJournalLine."Account Type"::Customer, LoanApps."Client Code", DirbursementDate, VarAmounttoDisburse, 'BOSA', Rec."Batch No.", 'Loan Disbursement - ' + LoanApps."Loan Product Type", LoanApps."Loan  No.");
                //--------------------------------RECOVER OVERDRAFT()-------------------------------------------------------

                //...................Cater for Loan Offset Now !
                LoanApps.CalcFields(LoanApps."Top Up Amount");
                if LoanApps."Top Up Amount" > 0 then begin
                    LoanTopUp.RESET;
                    LoanTopUp.SETRANGE(LoanTopUp."Loan No.", LoanApps."Loan  No.");
                    IF LoanTopUp.FIND('-') THEN BEGIN
                        repeat
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, LoanApps."Loan  No.", LineNo, GenJournalLine."Transaction Type"::"Loan Repayment", GenJournalLine."Account Type"::Customer, LoanApps."Client Code", DirbursementDate, Round(LoanTopUp."Principle Top Up", 0.01, '=') * -1, 'BOSA', Rec."Batch No.", 'Loan OffSet By - ' + LoanApps."Loan  No.", LoanTopUp."Loan Top Up");
                            //..................Recover Interest On Top Up
                            // LineNo := LineNo + 10000;
                            // SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, LoanApps."Loan  No.", LineNo, GenJournalLine."Transaction Type"::"Interest Paid", GenJournalLine."Account Type"::Customer, LoanApps."Client Code", DirbursementDate, Round(LoanTopUp."Interest Top Up", 0.01, '=') * -1, 'BOSA', "Batch No.", 'Interest Due Paid on top up - ', LoanTopUp."Loan Top Up");
                            //If there is top up commission charged write it here start
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, LoanApps."Loan  No.", LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::"G/L Account", GenSetUp."Top up Account", DirbursementDate, Round(LoanTopUp.Commision, 0.01, '=') * -1, 'BOSA', Rec."Batch No.", 'Commision on top up - ', LoanTopUp."Loan Top Up");
                            //If there is top up commission charged write it here end
                            AmountTop := (Round(LoanTopUp."Principle Top Up", 0.01, '=') + Round(LoanTopUp.Commision, 0.01, '='));
                            VarAmounttoDisburse := VarAmounttoDisburse - (Round(LoanTopUp."Principle Top Up", 0.01, '=') + Round(LoanTopUp.Commision, 0.01, '='));
                        // VarAmounttoDisburse := VarAmounttoDisburse - ;
                        UNTIL LoanTopUp.NEXT = 0;
                    END;
                end;
                //If there is top up commission charged write it here start
                //If there is top up commission charged write it here end
                //.....Valuation
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, LoanApps."Loan  No.", LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::"G/L Account", GenSetUp."Asset Valuation Cost", DirbursementDate, Round(LoanApps."Valuation Cost", 0.01, '=') * -1, 'BOSA', Rec."Batch No.", 'Loan Principle Amount ' + Format(LoanApps."Loan  No."), '');
                VarAmounttoDisburse := VarAmounttoDisburse - LoanApps."Valuation Cost";
                //...Debosting amount
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, LoanApps."Loan  No.", LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::"G/L Account", GenSetUp."Boosting Fees Account", DirbursementDate, Round(LoanApps."Deboost Commision", 0.01, '=') * -1, 'BOSA', Rec."Batch No.", 'Debosting commision ' + Format(LoanApps."Loan  No."), '');
                VarAmounttoDisburse := VarAmounttoDisburse - LoanApps."Deboost Commision";
                //Debosting commsion
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, LoanApps."Loan  No.", LineNo, GenJournalLine."Transaction Type"::"Deposit Contribution", GenJournalLine."Account Type"::Customer, LoanApps."Client Code", DirbursementDate, Round(LoanApps."Deboost Amount", 0.01, '=') * -1, 'BOSA', Rec."Batch No.", 'Debosted shares ' + Format(LoanApps."Loan  No."), '');
                VarAmounttoDisburse := VarAmounttoDisburse - LoanApps."Deboost Amount";
                //..Legal Fees
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, LoanApps."Loan  No.", LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::"G/L Account", GenSetUp."Legal Fees", DirbursementDate, Round(LoanApps."Legal Cost", 0.01, '=') * -1, 'BOSA', Rec."Batch No.", 'Loan Principle Amount ' + Format(LoanApps."Loan  No."), '');
                VarAmounttoDisburse := VarAmounttoDisburse - LoanApps."Legal Cost";

                NetAmount := VarAmounttoDisburse - (LoanApps."Loan Processing Fee" + LoanApps."Loan Dirbusement Fee" + LoanApps."Loan Insurance");
                //***************************Loan Product Charges code
                PCharges.Reset();
                PCharges.SETRANGE(PCharges."Product Code", LoanApps."Loan Product Type");
                IF PCharges.FIND('-') THEN BEGIN
                    REPEAT
                        PCharges.TESTFIELD(PCharges."G/L Account");
                        LineNo := LineNo + 10000;
                        GenJournalLine.INIT;
                        GenJournalLine."Journal Template Name" := BATCH_TEMPLATE;
                        GenJournalLine."Journal Batch Name" := BATCH_NAME;
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."Account Type"::"G/L Account";
                        GenJournalLine."Account No." := PCharges."G/L Account";
                        GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                        GenJournalLine."Document No." := LoanApps."Loan  No.";
                        GenJournalLine."External Document No." := LoanApps."Loan  No.";
                        GenJournalLine."Posting Date" := DirbursementDate;
                        GenJournalLine.Description := PCharges.Description + '-' + Format(LoanApps."Loan  No.");
                        IF PCharges."Use Perc" = TRUE THEN BEGIN
                            GenJournalLine.Amount := Round((LoanApps."Approved Amount" * (PCharges.Percentage / 100)), 0.01, '=') * -1
                        END
                        ELSE
                            IF PCharges."Use Perc" = false then begin
                                if (NetAmount >= 1000000) then
                                    GenJournalLine.Amount := Round(PCharges.Amount2, 0.01, '=') * -1
                                else
                                    GenJournalLine.Amount := Round(PCharges.Amount, 0.01, '=') * -1
                            end;
                        GenJournalLine.VALIDATE(GenJournalLine.Amount);
                        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                        IF GenJournalLine.Amount <> 0 THEN GenJournalLine.INSERT;

                    UNTIL PCharges.NEXT = 0;
                END;
                VarAmounttoDisburse := VarAmounttoDisburse - (LoanApps."Loan Processing Fee" + LoanApps."Loan Dirbusement Fee" + LoanApps."Loan Insurance");
                //end of code
                //------------------------------------2. CREDIT MEMBER BANK A/C---------------------------------------------------------------------------------------------

                //------------------------------------2. CREDIT MEMBER BANK A/C---------------------------------------------------------------------------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, LoanApps."Loan  No.", LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::"Bank Account", LoanApps."Paying Bank Account No", DirbursementDate, VarAmounttoDisburse * -1, 'BOSA', Rec."Batch No.", 'Loan Principle Amount ' + Format(LoanApps."Loan  No.") + ' ' + Format(LoanApps."Client Name"), '');
            until LoanApps.Next = 0;
        end;
    end;

    procedure UpdateControl()
    begin
        if Rec.Status = Rec.Status::Open then begin
            DescriptionEditable := true;
            ModeofDisburementEditable := false;
            DocumentNoEditable := false;
            PostingDateEditable := false;
            SourceEditable := true;
            PayingAccountEditable := true;
            ChequeNoEditable := false;
            ChequeNameEditable := false;
            SendApprovalEditable := true;
            CancelApprovalEditable := false;
            PostEnabled := false;
        end;
        if Rec.Status = Rec.Status::"Pending Approval" then begin
            DescriptionEditable := false;
            ModeofDisburementEditable := false;
            DocumentNoEditable := false;
            PostingDateEditable := false;
            SourceEditable := false;
            PayingAccountEditable := false;
            ChequeNoEditable := false;
            ChequeNameEditable := false;
            SendApprovalEditable := false;
            CancelApprovalEditable := true;
            PostEnabled := false;
        end;
        if Rec.Status = Rec.Status::Rejected then begin
            DescriptionEditable := false;
            ModeofDisburementEditable := false;
            DocumentNoEditable := false;
            PostingDateEditable := false;
            SourceEditable := false;
            PayingAccountEditable := false;
            ChequeNoEditable := false;
            ChequeNameEditable := false;
            SendApprovalEditable := true;
            CancelApprovalEditable := false;
            PostEnabled := false;
        end;
        if Rec.Status = Rec.Status::Approved then begin
            DescriptionEditable := false;
            ModeofDisburementEditable := true;
            DocumentNoEditable := true;
            SourceEditable := false;
            PostingDateEditable := true;
            PayingAccountEditable := true; //FALSE;
            ChequeNoEditable := true;
            ChequeNameEditable := true;
            SendApprovalEditable := false;
            CancelApprovalEditable := false;
            PostEnabled := true;
        end;
    end;

    procedure FnSendDisburesmentSMS(LoanNo: Code[20]; AccountNo: Code[20])
    var
        msg: Text[250];
        PhoneNo: Text[250];
    begin
        LoanApps.Reset();
        LoanApps.SetRange(LoanApps."Loan  No.", LoanNo);
        if LoanApps.Find('-') then begin
            msg := '';
            msg := 'Dear Member, Your ' + Format(LoanApps."Loan Product Type") + ' loan application of KSHs.' + Format(LoanApps."Requested Amount") + ' has been processed and it will be deposited to your Bank Account.';
            PhoneNo := FnGetPhoneNo(LoanApps."Client Code");
            SendSMSMessage(LoanApps."Client Code", msg, PhoneNo);
        end;
    end;

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

    local procedure FnGetMemberBranch(MemberNo: Code[50]): Code[100]
    var
        MemberBranch: Code[100];
    begin
        Cust.Reset;
        Cust.SetRange(Cust."No.", MemberNo);
        if Cust.Find('-') then begin
            MemberBranch := Cust."Global Dimension 2 Code";
        end;
        exit(MemberBranch);
    end;

    trigger OnAfterGetRecord()
    begin
        CurrPage.Editable := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        SalesSetup: Record "Sacco No. Series";
    // NoSeriesMgt: Codeunit "No. Series";
    begin
        if Rec."Batch No." = '' then begin
            SalesSetup.Get();
            SalesSetup.TestField(SalesSetup."Loans Batch Nos");
            //NoSeriesMgt.InitSeries(SalesSetup."Loans Batch Nos", xRec."No. Series", 0D, Rec."Batch No.", Rec."No. Series");
            Rec."Document No." := Rec."Batch No.";
            Rec."Prepared By" := UserId;
            Rec.Source := Rec.Source::BOSA;
            xRec."Date Created" := Today;
        end;
    end;
}
