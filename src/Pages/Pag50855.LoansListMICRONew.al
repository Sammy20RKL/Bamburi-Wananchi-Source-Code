#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50855 "Loans List-MICRO(New)"
{
    CardPageID = "Loan Application MICRO(New)";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = List;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = 51371;
    SourceTableView = where(Source = const(MICRO),
                            Posted = const(false),
                            "Loan Status" = const(Application));

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(Overdue; Overdue)
                {
                    ApplicationArea = Basic;
                    Caption = 'OverDue';
                    Editable = false;
                    OptionCaption = 'Yes';
                    ToolTip = 'OverDue Entry';
                }
                field("Loan  No."; Rec."Loan  No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Old Account No."; Rec."Old Account No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Group Code"; Rec."Group Code")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Advice Type"; Rec."Advice Type")
                {
                    ApplicationArea = Basic;
                }
                field("Expected Date of Completion"; Rec."Expected Date of Completion")
                {
                    ApplicationArea = Basic;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Client Code"; Rec."Client Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("BOSA No"; Rec."BOSA No")
                {
                    ApplicationArea = Basic;
                }
                field("Issued Date"; Rec."Issued Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Client Name"; Rec."Client Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Loan)
            {
                Caption = 'Loan';
                Image = AnalysisView;
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
                        /*
                        LBatches.RESET;
                        LBatches.SETRANGE(LBatches."Loan  No.","Loan  No.");
                        IF LBatches.FIND('-') THEN BEGIN
                            ApprovalEntries.Setfilters(DATABASE::Loans,17,LBatches."Loan  No.");
                              ApprovalEntries.RUN;
                        END;
                        */
                        /*
                        DocumentType:=DocumentType::Loan;
                        ApprovalEntries.Setfilters(DATABASE::Loans,DocumentType,"Loan  No.");
                        ApprovalEntries.RUN;
                        */

                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Overdue := Overdue::" ";
        if FormatField(Rec) then
            Overdue := Overdue::Yes;
    end;

    var
        LoanType: Record 51240;
        NoSeriesMgt: Codeunit "No. Series";
        LoanApp: Record 51230;
        DiscountingAmount: Decimal;
        StatusPermissions: Record 51310;
        SpecialComm: Decimal;
        GenJournalLine: Record "Gen. Journal Line";
        LoansR: Record 51230;
        DActivity: Code[20];
        DBranch: Code[20];
        Vend: Record Vendor;
        LineNo: Integer;
        DoubleComm: Boolean;
        AvailableBal: Decimal;
        Account: Record Vendor;
        RunBal: Decimal;
        TotalRecovered: Decimal;
        OInterest: Decimal;
        OBal: Decimal;
        ReffNo: Code[20];
        DiscountCommission: Decimal;
        BridgedLoans: Record 51238;
        LoanAdj: Decimal;
        LoanAdjInt: Decimal;
        AdjustRemarks: Text[30];
        Princip: Decimal;
        Overdue: Option Yes," ";
        i: Integer;
        PeriodDueDate: Date;
        ScheduleRep: Record 51234;
        RunningDate: Date;
        G: Integer;
        IssuedDate: Date;
        GracePeiodEndDate: Date;
        InstalmentEnddate: Date;
        GracePerodDays: Integer;
        InstalmentDays: Integer;
        NoOfGracePeriod: Integer;
        NewSchedule: Record 51234;
        RSchedule: Record 51234;
        GP: Text[30];
        ScheduleCode: Code[20];
        PreviewShedule: Record 51234;
        PeriodInterval: Code[10];
        CustomerRecord: Record 51364;
        Gnljnline: Record "Gen. Journal Line";
        Jnlinepost: Codeunit "Gen. Jnl.-Post Line";
        CumInterest: Decimal;
        NewPrincipal: Decimal;
        PeriodPrRepayment: Decimal;
        GenBatch: Record "Gen. Journal Batch";
        GnljnlineCopy: Record "Gen. Journal Line";
        NewLNApplicNo: Code[10];
        Cust: Record 51364;
        TestAmt: Decimal;
        CustRec: Record 51364;
        CustPostingGroup: Record "Customer Posting Group";
        GenSetUp: Record "Sales & Receivables Setup";
        PCharges: Record 51241;
        TCharges: Decimal;
        LAppCharges: Record 51244;
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
        FOSAComm: Decimal;
        BOSAComm: Decimal;
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        LoanTopUp: Record 51235;
        BOSAInt: Decimal;
        TopUpComm: Decimal;
        TotalTopupComm: Decimal;
        CustE: Record 51364;
        DocN: Text[50];
        DocM: Text[100];
        DNar: Text[250];
        DocF: Text[50];
        MailBody: Text[250];
        ccEmail: Text[250];
        LoanG: Record 51231;
        FOSAName: Text[150];
        IDNo: Code[50];
        MovementTracker: Record 51253;
        SMSMessage: Record 51471;
        InstallNo2: Integer;
        currency: Record "Currency Exchange Rate";
        CURRENCYFACTOR: Decimal;
        LoanApps: Record 51230;
        LoanDisbAmount: Decimal;
        BatchTopUpAmount: Decimal;
        BatchTopUpComm: Decimal;
        Disbursement: Record 51279;
        SchDate: Date;
        DisbDate: Date;
        WhichDay: Integer;
        LBatches: Record 51230;
        SalDetails: Record 51232;
        LGuarantors: Record 51231;
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batches,"Payment Voucher","Petty Cash",Requisition,Loan,Imprest,ImprestSurrender,Interbank;


    procedure GetVariables(var LoanNo: Code[20]; var LoanProductType: Code[20])
    begin
        LoanNo := Rec."Loan  No.";
        LoanProductType := Rec."Loan Product Type";
    end;


    procedure FormatField(Rec: Record 51371) OK: Boolean
    begin
        if Rec."Outstanding Balance" > 0 then begin
            if (Rec."Expected Date of Completion" < Today) then
                exit(true)
            else
                exit(false);
        end;
    end;


    procedure CalledFrom()
    begin
        Overdue := Overdue::" ";
    end;
}

