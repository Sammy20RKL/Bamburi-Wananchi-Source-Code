#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50908 "Loans Disb Batch List(MICRO)"
{
    // CardPageID = "Loan Disb Batch Card(MICRO)";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = 51377;
    SourceTableView = where(Posted = filter(false),
                            Source = filter(MICRO));

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field(Source; Rec.Source)
                {
                    ApplicationArea = Basic;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field("No of Loans"; Rec."No of Loans")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Mode Of Disbursement"; Rec."Mode Of Disbursement")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
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

                    trigger OnAction()
                    begin
                        /*LoansBatch.RESET;
                        LoansBatch.SETRANGE(LoansBatch."Batch No.","Batch No.");
                        IF LoansBatch.FIND('-') THEN BEGIN
                        REPORT.RUN(,TRUE,FALSE,LoansBatch);
                        END;
                        */

                    end;
                }
                separator(Action1102755008)
                {
                }
                action("Member Card")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Card';
                    Image = Customer;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        /*
                        LoanApp.RESET;
                        LoanApp.SETRANGE(LoanApp."Loan  No.",CurrPage.LoansSubForm.GetLoanNo);
                        IF LoanApp.FIND('-') THEN BEGIN
                        Cust.RESET;
                        Cust.SETRANGE(Cust."No.",LoanApp."Client Code");
                        IF Cust.FIND('-') THEN
                        PAGE.RUNMODAL(,Cust);
                        END;
                        */

                    end;
                }
                action("Loan Appraisal")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Appraisal';
                    Image = Statistics;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        /*
                        LoanApp.RESET;
                        //LoanApp.SETRANGE(LoanApp."Loan  No.",CurrPage.LoansSubForm.PAGE.GetLoanNo);
                        IF LoanApp.FIND('-') THEN BEGIN
                        IF COPYSTR(LoanApp."Loan Product Type",1,2) = 'PL' THEN
                        REPORT.RUN(,TRUE,FALSE,LoanApp)
                        ELSE
                        REPORT.RUN(,TRUE,FALSE,LoanApp);
                        END;
                        */

                    end;
                }
            }
        }
    }

    var
        ApprovalsSetup: Record "Approval Entry";
        MovementTracker: Record 51395;
        FileMovementTracker: Record 51395;
        NextStage: Integer;
        EntryNo: Integer;
        NextLocation: Text[100];
        LoansBatch: Record 51377;
        i: Integer;
        LoanType: Record 51381;
        PeriodDueDate: Date;
        ScheduleRep: Record 51375;
        RunningDate: Date;
        G: Integer;
        IssuedDate: Date;
        GracePeiodEndDate: Date;
        InstalmentEnddate: Date;
        GracePerodDays: Integer;
        InstalmentDays: Integer;
        NoOfGracePeriod: Integer;
        NewSchedule: Record 51375;
        RSchedule: Record 51375;
        GP: Text[30];
        ScheduleCode: Code[20];
        PreviewShedule: Record 51375;
        PeriodInterval: Code[10];
        CustomerRecord: Record 51375;
        Gnljnline: Record "Gen. Journal Line";
        Jnlinepost: Codeunit "Gen. Jnl.-Post Line";
        CumInterest: Decimal;
        NewPrincipal: Decimal;
        PeriodPrRepayment: Decimal;
        GenBatch: Record "Gen. Journal Batch";
        LineNo: Integer;
        GnljnlineCopy: Record "Gen. Journal Line";
        NewLNApplicNo: Code[10];
        Cust: Record 51364;
        LoanApp: Record 51371;
        TestAmt: Decimal;
        CustRec: Record 51364;
        CustPostingGroup: Record "Customer Posting Group";
        GenSetUp: Record 51398;
        PCharges: Record 51383;
        TCharges: Decimal;
        LAppCharges: Record 51385;
        Loans: Record 51371;
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
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        LoanTopUp: Record 51376;
        Vend: Record Vendor;
        BOSAInt: Decimal;
        TopUpComm: Decimal;
        DActivity: Code[20];
        DBranch: Code[20];
        UsersID: Record User;
        TotalTopupComm: Decimal;
        CustE: Record 51364;
        DocN: Text[50];
        DocM: Text[100];
        DNar: Text[250];
        DocF: Text[50];
        MailBody: Text[250];
        ccEmail: Text[250];
        LoanG: Record 51372;
        SpecialComm: Decimal;
        LoanApps: Record 51371;
        Banks: Record "Bank Account";
        BatchTopUpAmount: Decimal;
        BatchTopUpComm: Decimal;
        TotalSpecialLoan: Decimal;
        SpecialLoanCl: Record 51379;
        Loans2: Record 51371;
        DActivityBOSA: Code[20];
        DBranchBOSA: Code[20];
        Refunds: Record 51381;
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
        Trans: Record 51441;
        TransactionCharges: Record 51442;
        BChequeRegister: Record 51313;
        OtherCommitments: Record 51403;
        BoostingComm: Decimal;
        BoostingCommTotal: Decimal;
        BridgedLoans: Record 51379;
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
        SMSMessage: Record 51471;
        iEntryNo: Integer;
        Temp: Record Customer;
        Jtemplate: Code[30];
        JBatch: Code[30];
        LBatches: Record 51377;
        ApprovalMgt: Codeunit "Approvals Mgmt.";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batches,"Payment Voucher","Petty Cash",Requisition,Loan,Imprest,ImprestSurrender,Interbank;
}

