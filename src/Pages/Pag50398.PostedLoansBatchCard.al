#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50398 "Posted Loans Batch Card"
{
    DeleteAllowed = false;
    // Editable = false;
    InsertAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Loan Disburesment-Batching";
    SourceTableView = where(Posted = const(true),
                            Source = filter(BOSA));

    layout
    {
        area(content)
        {
            field("Batch No."; Rec."Batch No.")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            field("Batch Type"; Rec."Batch Type")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            field("Description/Remarks"; Rec."Description/Remarks")
            {
                ApplicationArea = Basic;
            }
            field(Status; Rec.Status)
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            field(Posted; Rec.Posted)
            {
                Editable = true;
                ApplicationArea = Basic;
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
            }
            field("Document No."; Rec."Document No.")
            {
                ApplicationArea = Basic;

                trigger OnValidate()
                begin
                    if StrLen(Rec."Document No.") > 6 then
                        Error('Document No. cannot contain More than 6 Characters.');
                end;
            }
            field("Posting Date"; Rec."Posting Date")
            {
                ApplicationArea = Basic;
            }
            field("BOSA Bank Account"; Rec."BOSA Bank Account")
            {
                ApplicationArea = Basic;
            }
            field("Cheque Name"; Rec."Cheque Name")
            {
                ApplicationArea = Basic;
            }
            part(LoansSubForm; "Loans Sub-Page List")
            {
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
                action("Loans Schedule")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loans Schedule';
                    Image = SuggestPayment;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    RunObject = Report "Loans Batch Schedule";

                    trigger OnAction()
                    begin
                        /*LoansBatch.RESET;
                        LoansBatch.SETRANGE(LoansBatch."Batch No.","Batch No.");
                        IF LoansBatch.FIND('-') THEN BEGIN
                        Report.Run(50231,TRUE,FALSE,LoansBatch);
                        END;*/

                    end;
                }
                separator(Action1102760034)
                {
                }
                action("Member Card")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Card';
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Report "members card";

                    trigger OnAction()
                    begin
                        /*Cust1.RESET;
                       Cust1.SETRANGE(Cust1."No.",Cust1."No.");
                        IF Cust1.FINDFIRST THEN BEGIN
                         REPORT.RUN(REPORT::"members card",TRUE,FALSE,Cust1);
                        END;     */

                    end;
                }
                action("Loan Application")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Application Card';
                    Image = Loaners;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Loan Application Card";
                    Visible = true;

                    trigger OnAction()
                    begin
                        /*
                      LoanApp.RESET;
                      LoanApp.SETRANGE(LoanApp."Batch No.","Batch No.");
                      LoanApp.SETRANGE(LoanApp."Client Code",LoanApp."Client Code");
                      IF LoanApp.FIND('-') THEN
                      PAGE.RUN(51516245,TRUE,FALSE,LoanApp);    */

                    end;
                }
                action("Loan Appraisal")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Appraisal';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = true;

                    trigger OnAction()
                    begin

                        LoanApp.Reset;
                        //LoanApp.SETRANGE(LoanApp."Loan  No.",CurrPage.LoansSubForm.PAGE.GetLoanNo);
                        if LoanApp.Find('-') then begin
                            if CopyStr(LoanApp."Loan Product Type", 1, 2) = 'PL' then
                                Report.Run(50244, true, false, LoanApp)
                            else
                                Report.Run(50244, true, false, LoanApp);
                        end;
                    end;
                }
                separator(Action1102760045)
                {
                }
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approval;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        DocumentType := Documenttype::Batches;
                        //ApprovalEntries.SetRecordFilters(Database::Table51516167,DocumentType,"Batch No.");
                        ApprovalEntries.Run;
                    end;
                }
                action("Send A&pproval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    var
                        // ApprovalMgt: Codeunit "Export F/O Consolidation";
                        Text001: label 'This Batch is already pending approval';
                    begin
                        LBatches.Reset;
                        LBatches.SetRange(LBatches."Batch No.", Rec."Batch No.");
                        if LBatches.Find('-') then begin
                            if LBatches.Status <> LBatches.Status::Open then
                                Error(Text001);
                        end;

                        //End allocate batch number
                        //ApprovalMgt.SendBatchApprRequest(LBatches);
                    end;
                }
                action("Canel Approval Request")
                {
                    ApplicationArea = Basic;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    begin
                        //IF ApprovalMgt.CancelBatchAppr(Rec,TRUE,TRUE) THEN;
                    end;
                }
                action("Print Cheque")
                {
                    ApplicationArea = Basic;

                    trigger OnAction()
                    begin
                        Rec.Reset;
                        Rec.SetFilter("Batch No.", Rec."Batch No.");
                        if Confirm(Text002, true) then begin

                            //REPORT.RUN(,TRUE,TRUE,Rec);
                            Rec.Reset;
                        end;
                    end;
                }
                action("Export EFT")
                {
                    ApplicationArea = Basic;
                    Caption = 'Export EFT';
                    Image = SuggestPayment;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;

                    trigger OnAction()
                    begin

                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Batch No.", Rec."Batch No.");
                        if LoanApp.Find('-') then begin

                            Xmlport.Run(51516012, true, false, LoanApp);
                        end;
                    end;
                }
            }
        }
    }

    var
        Text001: label 'Status must be open';
        Text002: label 'Dou you want to print a Cheque for this payment';
        ApprovalsSetup: Record "Approval Setup";
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
        //Jnlinepost: Codeunit "Gen. Jnl.-Post Line";
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
        // GLPosting: Codeunit "Gen. Jnl.-Post Line";
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
        // ApprovalMgt: Codeunit "Export F/O Consolidation";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batches,"Payment Voucher","Petty Cash",Requisition,Loan,Imprest,ImprestSurrender,Interbank;
        DescriptionEditable: Boolean;
        ModeofDisburementEditable: Boolean;
        DocumentNoEditable: Boolean;
        PostingDateEditable: Boolean;
        SourceEditable: Boolean;
        PayingAccountEditable: Boolean;
        ChequeNoEditable: Boolean;
        ChequeNameEditable: Boolean;
        upfronts: Decimal;
        Cust1: Record Customer;
}