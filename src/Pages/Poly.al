// Page 57305 "Mobile Loans Disbursement Card"
// {
//     DeleteAllowed = false;
//     PageType = Card;
//     InsertAllowed = false;
//     PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
//     SourceTable = "Loans Register";
//     SourceTableView = where(Source = const(BOSA), Posted = const(false));

//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 Caption = 'General';

//                 field("Loan  No."; Rec."Loan  No.")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Client Code"; Rec."Client Code")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Member No';
//                     Editable = MNoEditable;
//                     ShowMandatory = true;
//                 }
//                 field("Account No"; Rec."Account No")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = AccountNoEditable;
//                     Style = StrongAccent;
//                 }
//                 field("Client Name"; Rec."Client Name")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                     Style = StrongAccent;
//                 }
//                 field("Member Deposits"; Rec."Member Deposits")
//                 {
//                     ApplicationArea = Basic;
//                     Style = Unfavorable;
//                 }
//                 field("Application Date"; Rec."Application Date")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = true;

//                     trigger OnValidate()
//                     begin
//                         //TestField(Posted, false);
//                     end;
//                 }
//                 field("Loan Product Type"; Rec."Loan Product Type")
//                 {
//                     ApplicationArea = Basic;
//                     Style = StrongAccent;
//                     Editable = LProdTypeEditable;
//                     ShowMandatory = true;

//                     trigger OnValidate()
//                     begin
//                     end;
//                 }
//                 field(Installments; Rec.Installments)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = InstallmentEditable;
//                     ShowMandatory = true;

//                     trigger OnValidate()
//                     begin
//                         Rec.TestField(Posted, false);
//                     end;
//                 }
//                 field(Interest; Rec.Interest)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = EditableField;
//                     Caption = 'Interest Rate';
//                 }
//                 field("Requested Amount"; Rec."Requested Amount")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Amount Applied';
//                     Editable = AppliedAmountEditable;
//                     ShowMandatory = true;
//                     Style = Strong;

//                     trigger OnValidate()
//                     begin
//                         Rec.TestField(Posted, false);
//                     end;
//                 }
//                 field("Approved Amount"; Rec."Approved Amount")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Approved Amount';
//                     Editable = false;
//                     ShowMandatory = true;

//                     trigger OnValidate()
//                     begin
//                         Rec.TestField(Posted, false);
//                     end;
//                 }
//                 field("Main Sector"; Rec."Main-Sector")
//                 {
//                     ApplicationArea = Basic;
//                     ShowMandatory = true;
//                     Style = Ambiguous;
//                     Editable = MNoEditable;

//                     trigger OnValidate()
//                     begin
//                         Rec.TestField(Posted, false);
//                     end;
//                 }
//                 field("Sub-Sector"; Rec."Sub-Sector")
//                 {
//                     ApplicationArea = Basic;
//                     ShowMandatory = true;
//                     Style = Ambiguous;
//                     Editable = MNoEditable;

//                     trigger OnValidate()
//                     begin
//                         Rec.TestField(Posted, false);
//                     end;
//                 }
//                 field("Specific Sector"; Rec."Specific-Sector")
//                 {
//                     ApplicationArea = Basic;
//                     ShowMandatory = true;
//                     Style = Ambiguous;
//                     Editable = MNoEditable;

//                     trigger OnValidate()
//                     begin
//                         Rec.TestField(Posted, false);
//                     end;
//                 }
//                 field(Remarks; Rec.Remarks)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = MNoEditable;
//                     Visible = true;
//                 }
//                 field("Repayment Method"; Rec."Repayment Method")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Loan Principle Repayment"; Rec."Loan Principle Repayment")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Loan Interest Repayment"; Rec."Loan Interest Repayment")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field(Repayment; Rec.Repayment)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Disburesment Type"; Rec."Disburesment Type")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Loan Status"; Rec."Loan Status")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;

//                     trigger OnValidate()
//                     begin
//                         // UpdateControl();
//                     end;
//                 }
//                 field("Approval Status"; Rec."Approval Status")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Repayment Frequency"; Rec."Repayment Frequency")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = RepayFrequencyEditable;
//                     Style = StrongAccent;
//                     ShowMandatory = true;
//                 }
//                 field("Recovery Mode"; Rec."Recovery Mode")
//                 {
//                     ApplicationArea = Basic;
//                     Style = StrongAccent;
//                     ShowMandatory = true;
//                     Editable = MNoEditable;
//                     OptionCaption = 'Checkoff,Standing Order,Salary,Pension,Direct Debits,Tea,Milk,Tea Bonus,Dividend,Christmas';
//                 }
//                 field("Mode of Disbursement"; Rec."Mode of Disbursement")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = MNoEditable;
//                     ShowMandatory = true;
//                 }
//                 field("Paying Bank Account No"; Rec."Paying Bank Account No")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = true;
//                 }
//                 field("Batch No."; Rec."Batch No.")
//                 {
//                     Editable = true;
//                     ApplicationArea = Basic;
//                 }
//                 field("Loan Disbursement Date"; Rec."Loan Disbursement Date")
//                 {
//                     ApplicationArea = Basic;
//                     // Editable = MNoEditable;
//                     Editable = true;
//                     Style = StrongAccent;
//                     ShowMandatory = true;
//                 }
//                 field("Repayment Start Date"; Rec."Repayment Start Date")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Expected Date of Completion"; Rec."Expected Date of Completion")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Captured By"; Rec."Captured By")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//             }
//         }
//         area(factboxes)
//         {
//             part("Member Statistics FactBox"; "Member Statistics FactBox")
//             {
//                 SubPageLink = "No." = field("Client Code");
//             }
//         }
//     }
//     actions
//     {
//         area(navigation)
//         {
//             group(Loan)
//             {
//                 action("POST")
//                 {
//                     Caption = 'POST LOAN';
//                     Enabled = true;
//                     Image = PrepaymentPostPrint;
//                     PromotedIsBig = true;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     Visible = false;
//                     trigger OnAction()
//                     var
//                         FundsUserSetup: Record "Funds User Setup";
//                         CustLed: Record "Cust. Ledger Entry";
//                         MissingAmount: Decimal;
//                     begin

//                         LoanApps.Reset;
//                         LoanApps.SetRange(LoanApps."Loan  No.", Rec."Loan  No.");
//                         if LoanApps.FindSet then begin
//                             PostLoan(Rec."Doc No Used", swizzkasTransTable."Account No", Rec."Approved Amount", 1);
//                             //.................................................
//                             Message('Loan has successfully been posted and member notified');
//                             CurrPage.close();
//                         end;
//                     end;
//                 }
//             }
//         }
//     }

//     trigger OnOpenPage()
//     begin
//         Rec.SetRange(Posted, false);
//     end;

//     var
//         swizzkasTransTable: Record "SwizzKash Transactions";
//         ClientCode: Code[40];
//         DirbursementDate: Date;
//         VarAmounttoDisburse: Decimal;
//         LoanGuar: Record "Loans Guarantee Details";
//         SMSMessages: Record "SMS Messages";
//         i: Integer;
//         LoanType: Record "Loan Products Setup";
//         PeriodDueDate: Date;
//         ScheduleRep: Record "Loan Repayment Schedule";
//         RunningDate: Date;
//         G: Integer;
//         IssuedDate: Date;
//         GracePeiodEndDate: Date;
//         InstalmentEnddate: Date;
//         GracePerodDays: Integer;
//         InstalmentDays: Integer;
//         NoOfGracePeriod: Integer;
//         NewSchedule: Record "Loan Repayment Schedule";
//         RSchedule: Record "Loan Repayment Schedule";
//         GP: Text[30];
//         ScheduleCode: Code[20];
//         PreviewShedule: Record "Loan Repayment Schedule";
//         PeriodInterval: Code[10];
//         CustomerRecord: Record Customer;
//         Gnljnline: Record "Gen. Journal Line";
//         //  Jnlinepost: Codeunit "Gen. Jnl.-Post Line";
//         CumInterest: Decimal;
//         NewPrincipal: Decimal;
//         PeriodPrRepayment: Decimal;
//         GenBatch: Record "Gen. Journal Batch";
//         LineNo: Integer;
//         GnljnlineCopy: Record "Gen. Journal Line";
//         NewLNApplicNo: Code[10];
//         Cust: Record Customer;
//         LoanApp: Record "Loans Register";
//         TestAmt: Decimal;
//         CustRec: Record Customer;
//         CustPostingGroup: Record "Customer Posting Group";
//         GenSetUp: Record "Sacco General Set-Up";
//         PCharges: Record "Loan Product Charges";
//         TCharges: Decimal;
//         LAppCharges: Record "Loan Applicaton Charges";
//         LoansR: Record "Loans Register";
//         LoanAmount: Decimal;
//         InterestRate: Decimal;
//         RepayPeriod: Integer;
//         LBalance: Decimal;
//         RunDate: Date;
//         InstalNo: Decimal;
//         RepayInterval: DateFormula;
//         TotalMRepay: Decimal;
//         LInterest: Decimal;
//         LPrincipal: Decimal;
//         RepayCode: Code[40];
//         GrPrinciple: Integer;
//         GrInterest: Integer;
//         QPrinciple: Decimal;
//         QCounter: Integer;
//         InPeriod: DateFormula;
//         InitialInstal: Integer;
//         InitialGraceInt: Integer;
//         GenJournalLine: Record "Gen. Journal Line";
//         FOSAComm: Decimal;
//         BOSAComm: Decimal;
//         LoanTopUp: Record "Loan Offset Details";
//         Vend: Record Vendor;
//         BOSAInt: Decimal;
//         TopUpComm: Decimal;
//         DActivity: Code[20];
//         DBranch: Code[20];
//         TotalTopupComm: Decimal;
//         Notification: Codeunit Mail;
//         CustE: Record Customer;
//         DocN: Text[50];
//         DocM: Text[100];
//         DNar: Text[250];
//         DocF: Text[50];
//         MailBody: Text[250];
//         ccEmail: Text[250];
//         LoanG: Record "Loans Guarantee Details";
//         SpecialComm: Decimal;
//         FOSAName: Text[150];
//         IDNo: Code[50];
//         MovementTracker: Record "Movement Tracker";
//         DiscountingAmount: Decimal;
//         StatusPermissions: Record "Status Change Permision";
//         BridgedLoans: Record "Loan Special Clearance";
//         SMSMessage: Record "SMS Messages";
//         InstallNo2: Integer;
//         currency: Record "Currency Exchange Rate";
//         CURRENCYFACTOR: Decimal;
//         LoanApps: Record "Loans Register";
//         LoanDisbAmount: Decimal;
//         BatchTopUpAmount: Decimal;
//         BatchTopUpComm: Decimal;
//         Disbursement: Record "Loan Disburesment-Batching";
//         SchDate: Date;
//         DisbDate: Date;
//         WhichDay: Integer;
//         LBatches: Record "Loans Register";
//         SalDetails: Record "Loan Appraisal Salary Details";
//         LGuarantors: Record "Loans Guarantee Details";
//         Text001: label 'Status Must Be Open';
//         DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batches,"Payment Voucher","Petty Cash",Requisition,Loan,Interbank,Imprest,Checkoff,"FOSA Account Opening",StandingOrder,HRJob,HRLeave,"HRTransport Request",HRTraining,"HREmp Requsition",MicroTrans,"Account Reactivation","Overdraft ",BLA,"Member Editable","FOSA Opening","Loan Batching",Leave,"Imprest Requisition","Imprest Surrender","Stores Requisition","Funds Transfer","Change Request","Staff Claims","BOSA Transfer","Loan Tranche","Loan TopUp","Memb Opening","Member Withdrawal";
//         CurrpageEditable: Boolean;
//         LoanStatusEditable: Boolean;
//         MNoEditable: Boolean;
//         ApplcDateEditable: Boolean;
//         LProdTypeEditable: Boolean;
//         InstallmentEditable: Boolean;
//         AppliedAmountEditable: Boolean;
//         ApprovedAmountEditable: Boolean;
//         RepayMethodEditable: Boolean;
//         RepaymentEditable: Boolean;
//         BatchNoEditable: Boolean;
//         RepayFrequencyEditable: Boolean;
//         ModeofDisburesmentEdit: Boolean;
//         DisbursementDateEditable: Boolean;
//         AccountNoEditable: Boolean;
//         LNBalance: Decimal;
//         ApprovalEntries: Record "Approval Entry";
//         RejectionRemarkEditable: Boolean;
//         ApprovalEntry: Record "Approval Entry";
//         Table_id: Integer;
//         Doc_No: Code[20];
//         PepeaShares: Decimal;
//         SaccoDeposits: Decimal;
//         Doc_Type: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Account Opening","Member Closure",Loan;
//         ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//         compinfo: Record "Company Information";
//         iEntryNo: Integer;
//         eMAIL: Text;
//         "Telephone No": Integer;
//         Text002: label 'The Loan has already been approved';
//         LoanSecurities: Integer;
//         EditableField: Boolean;
//         SFactory: Codeunit "Swizzsoft Factory";
//         OpenApprovalEntriesExist: Boolean;
//         TemplateName: Code[50];
//         BatchName: Code[50];
//         EnabledApprovalWorkflowsExist: Boolean;
//         RecordApproved: Boolean;
//         SrestepApprovalsCodeUnit: Codeunit SurestepApprovalsCodeUnit;
//         CanCancelApprovalForRecord: Boolean;
//         MpesaDisbus: Record "Mobile Loans";
//         GenLedgerSetup: Record "General Ledger Setup";
//         LoanProductsSetup: Record "Loan Products Setup";
//         GenBatches: Record "Gen. Journal Batch";
//         MPESACharge: Decimal;
//         GLPosting: Codeunit "Gen. Jnl.-Post line";


//     LOCAL PROCEDURE PostLoan(documentNo: Code[20]; AccountNo: Code[50]; amount: Decimal; Period: Decimal) result: Code[30];
//     VAR
//         swizzkasTransTable: Record "SwizzKash Transactions";
//         membersTable: Record Customer;
//         vendorTable: Record Vendor;
//         loansRegisterTable: Record "Loans Register";
//         chargesTable: Record Charges;
//         LoanProdCharges: Record "Loan Product Charges";
//         SaccoNoSeries: Record "Sacco No. Series";
//         NoSeriesMgt: Codeunit NoSeriesManagement;
//         LoanRepSchedule: Record "Loan Repayment Schedule";
//         ObjLoanPurpose: Record "Loans Purpose";
//         SaccoNo: Record "Sacco No. Series";
//         GenSetUp: Record "Sacco General Set-Up";
//         SaccoGenSetup: Record "Sacco General Set-Up";
//         vendorCommAcc: Code[30];
//         vendorCommAmount: Decimal;
//         LoanAcc: Code[30];
//         InterestAcc: Code[30];
//         InterestAmount: Decimal;
//         AmountToCredit: Decimal;
//         AmountToDisburse: Decimal;
//         loanNo: Text[20];
//         loanType: Code[50];
//         InsuranceAcc: Code[10];
//         AmountDispursed: Decimal;
//         InterestPaid: Decimal;
//         LoanTypeTable: Record "Loan Products Setup";
//     BEGIN
//         loanType := '24';

//         swizzkasTransTable.RESET;
//         swizzkasTransTable.SETRANGE(swizzkasTransTable."Document No", documentNo);
//         swizzkasTransTable.SETRANGE(swizzkasTransTable.Posted, FALSE);
//         swizzkasTransTable.SETRANGE(swizzkasTransTable."Transaction Type", swizzkasTransTable."Transaction Type"::"Loan Application");
//         swizzkasTransTable.SETRANGE(swizzkasTransTable.Status, swizzkasTransTable.Status::Pending);
//         IF swizzkasTransTable.FIND('-') THEN BEGIN

//             GenSetUp.RESET;
//             GenSetUp.GET();
//             GenLedgerSetup.RESET;
//             GenLedgerSetup.GET;

//             // ** get loan and interest accounts **
//             LoanProductsSetup.RESET;
//             LoanProductsSetup.SETRANGE(LoanProductsSetup.Code, loanType);
//             IF LoanProductsSetup.FINDFIRST() THEN BEGIN
//                 LoanAcc := LoanProductsSetup."Loan Account";
//                 InterestAcc := LoanProductsSetup."Loan Interest Account";
//             END;

//             SaccoGenSetup.RESET;
//             SaccoGenSetup.GET;
//             //SaccoGenSetup.TESTFIELD("Mpesa Cash Withdrawal fee ac");


//             // -- get balance enquiry charges
//             chargesTable.RESET;
//             chargesTable.SETRANGE(Code, 'LNA');
//             IF chargesTable.FIND('-') THEN BEGIN
//                 vendorCommAcc := chargesTable."GL Account";
//                 // vendorCommAmount := chargesTable."Charge Amount";
//                 //saccoCommAmount:=chargesTable."Sacco Amount";
//                 //saccoCommAcc:='3000407';     // -- sacco commission account
//             END;

//             //Calculate Interest
//             // InterestAmount := ((LoanProductsSetup."Interest rate" / 12) / 100) * amount;
//             InterestAmount := ((LoanProductsSetup."Interest rate") / 100) * amount; //- per month
//             //2% Swizz Commission
//             vendorCommAmount := (2 / 100) * amount;
//             //The rest posts to he Sacco
//             InterestPaid := InterestAmount - vendorCommAmount;

//             AmountToCredit := amount;
//             // ** interest charged upfront , disburse amount less (interest+vendor commision)
//             AmountToDisburse := amount - InterestAmount;// (InterestAmount + vendorCommAmount);

//             vendorTable.RESET;
//             vendorTable.SETRANGE("No.", AccountNo);
//             IF NOT vendorTable.FIND('-') THEN BEGIN
//                 result := 'ACCNOTFOUND';
//                 swizzkasTransTable.Status := swizzkasTransTable.Status::Failed;
//                 swizzkasTransTable.Posted := TRUE;
//                 swizzkasTransTable."Posting Date" := TODAY;
//                 swizzkasTransTable.Comments := 'Failed.Account Not Found';
//                 swizzkasTransTable.MODIFY;
//                 EXIT;
//             END;

//             membersTable.RESET;
//             membersTable.SETRANGE(membersTable."No.", vendorTable."BOSA Account No");
//             IF membersTable.FIND('-') THEN BEGIN

//                 //******* Create Loan *********//
//                 SaccoNoSeries.RESET;
//                 SaccoNoSeries.GET;
//                 SaccoNoSeries.TESTFIELD(SaccoNoSeries."BOSA Loans Nos");
//                 NoSeriesMgt.InitSeries(SaccoNoSeries."BOSA Loans Nos", loansRegisterTable."No. Series", 0D, loansRegisterTable."Loan  No.", loansRegisterTable."No. Series");
//                 loanNo := loansRegisterTable."Loan  No.";

//                 loansRegisterTable.INIT;
//                 loansRegisterTable."Approved Amount" := amount;
//                 loansRegisterTable.Interest := LoanProductsSetup."Interest rate";
//                 loansRegisterTable."Instalment Period" := LoanProductsSetup."Instalment Period";
//                 loansRegisterTable.Repayment := amount + InterestAmount + MPESACharge;
//                 loansRegisterTable."Expected Date of Completion" := CALCDATE('1M', TODAY);
//                 //loansRegisterTable.Posted:=TRUE;
//                 //membersTable.CALCFIELDS(membersTable."Current Shares", membersTable."Outstanding Balance", membersTable."Current Loan");
//                 loansRegisterTable."Shares Balance" := membersTable."Current Shares";
//                 loansRegisterTable."Amount Disbursed" := amount;
//                 loansRegisterTable.Savings := membersTable."Current Shares";
//                 loansRegisterTable."Interest Paid" := 0;
//                 loansRegisterTable."Issued Date" := TODAY;
//                 loansRegisterTable.Source := LoanProductsSetup.Source;
//                 loansRegisterTable."Loan Disbursed Amount" := amount;
//                 loansRegisterTable."Scheduled Principal to Date" := AmountToDisburse;
//                 loansRegisterTable."Current Interest Paid" := 0;
//                 loansRegisterTable."Loan Disbursement Date" := TODAY;
//                 loansRegisterTable."Client Code" := membersTable."No.";
//                 loansRegisterTable."Client Name" := membersTable.Name;
//                 loansRegisterTable."Outstanding Balance to Date" := AmountToDisburse;
//                 loansRegisterTable."Existing Loan" := membersTable."Outstanding Balance";
//                 //loansRegisterTable."Staff No":=membersTable."Payroll/Staff No";
//                 loansRegisterTable.Gender := membersTable.Gender;
//                 loansRegisterTable."BOSA No" := membersTable."No.";
//                 // loansRegisterTable."Branch Code":=Vendor."Global Dimension 2 Code";
//                 loansRegisterTable."Requested Amount" := amount;
//                 loansRegisterTable."ID NO" := membersTable."ID No.";
//                 IF loansRegisterTable."Branch Code" = '' THEN loansRegisterTable."Branch Code" := membersTable."Global Dimension 2 Code";
//                 loansRegisterTable."Loan  No." := loanNo;
//                 loansRegisterTable."No. Series" := SaccoNoSeries."BOSA Loans Nos";
//                 loansRegisterTable."Doc No Used" := documentNo;
//                 loansRegisterTable."Loan Interest Repayment" := InterestAmount;
//                 loansRegisterTable."Loan Principle Repayment" := amount;
//                 loansRegisterTable."Loan Repayment" := amount;
//                 loansRegisterTable."Employer Code" := membersTable."Employer Code";
//                 loansRegisterTable."Approval Status" := loansRegisterTable."Approval Status"::Approved;
//                 loansRegisterTable."Account No" := membersTable."No.";
//                 loansRegisterTable."Application Date" := TODAY;
//                 loansRegisterTable."Loan Product Type" := LoanProductsSetup.Code;
//                 loansRegisterTable."Loan Product Type Name" := LoanProductsSetup."Product Description";
//                 loansRegisterTable."Loan Disbursement Date" := TODAY;
//                 loansRegisterTable."Repayment Start Date" := TODAY;
//                 loansRegisterTable."Recovery Mode" := loansRegisterTable."Recovery Mode"::Checkoff;
//                 loansRegisterTable."Mode of Disbursement" := loansRegisterTable."Mode of Disbursement"::" ";
//                 loansRegisterTable."Requested Amount" := amount;
//                 loansRegisterTable."Approved Amount" := amount;
//                 loansRegisterTable.Installments := 1;
//                 loansRegisterTable."Loan Amount" := amount;
//                 loansRegisterTable."Issued Date" := TODAY;
//                 loansRegisterTable."Outstanding Balance" := 0;//Update
//                 loansRegisterTable."Repayment Frequency" := loansRegisterTable."Repayment Frequency"::Monthly;
//                 loansRegisterTable.INSERT(TRUE);

//                 // InterestAmount:=0;

//                 //**********Process Loan*******************//

//                 GenJournalLine.RESET;
//                 GenJournalLine.SETRANGE("Journal Template Name", 'GENERAL');
//                 GenJournalLine.SETRANGE("Journal Batch Name", 'MOBILELOAN');
//                 GenJournalLine.DELETEALL;
//                 //end of deletion

//                 GenBatches.RESET;
//                 GenBatches.SETRANGE(GenBatches."Journal Template Name", 'GENERAL');
//                 GenBatches.SETRANGE(GenBatches.Name, 'MOBILELOAN');
//                 IF GenBatches.FIND('-') = FALSE THEN BEGIN
//                     GenBatches.INIT;
//                     GenBatches."Journal Template Name" := 'GENERAL';
//                     GenBatches.Name := 'MOBILELOAN';
//                     GenBatches.Description := 'Normal Loan';
//                     GenBatches.VALIDATE(GenBatches."Journal Template Name");
//                     GenBatches.VALIDATE(GenBatches.Name);
//                     GenBatches.INSERT;
//                 END;



//                 //Post Loan
//                 loansRegisterTable.RESET;
//                 loansRegisterTable.SETRANGE(loansRegisterTable."Loan  No.", loanNo);
//                 IF loansRegisterTable.FIND('-') THEN BEGIN

//                     //Dr loan Acc - 100%Amount
//                     LineNo := LineNo + 10000;
//                     GenJournalLine.INIT;
//                     GenJournalLine."Journal Template Name" := 'GENERAL';
//                     GenJournalLine."Journal Batch Name" := 'MOBILELOAN';
//                     GenJournalLine."Line No." := LineNo;
//                     GenJournalLine."Account Type" := GenJournalLine."Account Type"::Customer;
//                     GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::Loan;
//                     GenJournalLine."Loan No" := loansRegisterTable."Loan  No.";
//                     GenJournalLine."Account No." := membersTable."No.";
//                     GenJournalLine.VALIDATE(GenJournalLine."Account No.");
//                     GenJournalLine."Document No." := documentNo;
//                     GenJournalLine."External Document No." := membersTable."No.";
//                     GenJournalLine."Posting Date" := TODAY;
//                     GenJournalLine.Description := 'M-Polytech Loan Disbursment-' + loansRegisterTable."Loan  No.";
//                     GenJournalLine.Amount := amount;// AmountToDisburse;
//                     GenJournalLine.VALIDATE(GenJournalLine.Amount);
//                     IF GenJournalLine.Amount <> 0 THEN
//                         GenJournalLine.INSERT;


//                     //-------INTEREST CHARGED BEFORE INTEREST PAID - 7.5%.... FESTUS SWIZZ
//                     LineNo := LineNo + 10000;
//                     GenJournalLine.Init;
//                     GenJournalLine."Journal Template Name" := 'GENERAL';
//                     GenJournalLine."Journal Batch Name" := 'MOBILELOAN';
//                     GenJournalLine."Line No." := LineNo;
//                     GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
//                     GenJournalLine."Account No." := loansRegisterTable."Client Code";
//                     GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Due";
//                     GenJournalLine.Validate(GenJournalLine."Account No.");
//                     GenJournalLine."Document No." := documentNo;
//                     GenJournalLine."Posting Date" := Today;
//                     GenJournalLine.Description := 'INT Charged' + ' ' + Format(Today);
//                     if LoanTypeTable.Get(loansRegisterTable."Loan Product Type") then begin
//                         GenJournalLine.Amount := InterestAmount;
//                         GenJournalLine.Validate(GenJournalLine.Amount);
//                         GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
//                         GenJournalLine."Bal. Account No." := LoanTypeTable."Loan Interest Account";
//                         GenJournalLine."Loan Product Type" := LoanTypeTable.Code;
//                         GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
//                     end;
//                     if loansRegisterTable.Source = loansRegisterTable.Source::BOSA then begin
//                         GenJournalLine."Shortcut Dimension 1 Code" := membersTable."Global Dimension 1 Code";
//                         GenJournalLine."Shortcut Dimension 2 Code" := membersTable."Global Dimension 2 Code";
//                     end;
//                     GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
//                     GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
//                     GenJournalLine."Loan No" := loansRegisterTable."Loan  No.";

//                     if GenJournalLine.Amount <> 0 then
//                         GenJournalLine.Insert;
//                     ///----END INTEREST CHARGFED

//                     //Cr M-Wallet Acc - 100% amount
//                     LineNo := LineNo + 10000;
//                     GenJournalLine.INIT;
//                     GenJournalLine."Journal Template Name" := 'GENERAL';
//                     GenJournalLine."Journal Batch Name" := 'MOBILELOAN';
//                     GenJournalLine."Line No." := LineNo;
//                     GenJournalLine."Document No." := documentNo;
//                     GenJournalLine."Account Type" := GenJournalLine."Account Type"::Vendor;
//                     GenJournalLine."Account No." := vendorTable."No.";
//                     GenJournalLine.VALIDATE(GenJournalLine."Account No.");
//                     GenJournalLine."Loan No" := loansRegisterTable."Loan  No.";
//                     GenJournalLine."Posting Date" := TODAY;
//                     GenJournalLine.Description := 'M-Polytech Disbursment';
//                     GenJournalLine.Amount := -amount;
//                     GenJournalLine.VALIDATE(GenJournalLine.Amount);
//                     IF GenJournalLine.Amount <> 0 THEN
//                         GenJournalLine.INSERT;


//                     //Dr M-Wallet Acc - 7.5% InterestAmount
//                     LineNo := LineNo + 10000;
//                     GenJournalLine.INIT;
//                     GenJournalLine."Journal Template Name" := 'GENERAL';
//                     GenJournalLine."Journal Batch Name" := 'MOBILELOAN';
//                     GenJournalLine."Line No." := LineNo;
//                     GenJournalLine."Document No." := documentNo;
//                     GenJournalLine."Account Type" := GenJournalLine."Account Type"::Vendor;
//                     GenJournalLine."Account No." := vendorTable."No.";
//                     GenJournalLine.VALIDATE(GenJournalLine."Account No.");
//                     GenJournalLine."Loan No" := loansRegisterTable."Loan  No.";
//                     GenJournalLine."Posting Date" := TODAY;
//                     GenJournalLine.Description := 'M-Polytech Interest Charged';
//                     GenJournalLine.Amount := InterestAmount;
//                     GenJournalLine.VALIDATE(GenJournalLine.Amount);
//                     IF GenJournalLine.Amount <> 0 THEN
//                         GenJournalLine.INSERT;


//                     //Cr Interest Eloan - 5.5%
//                     //.....updated to pay the full interest Amount, then Charge Swizz Commision from the Interest Account .....7.5% InterestAmount
//                     LineNo := LineNo + 10000;
//                     GenJournalLine.INIT;
//                     GenJournalLine."Journal Template Name" := 'GENERAL';
//                     GenJournalLine."Journal Batch Name" := 'MOBILELOAN';
//                     GenJournalLine."Line No." := LineNo;
//                     GenJournalLine."Document No." := documentNo;
//                     GenJournalLine."Account Type" := GenJournalLine."Account Type"::Customer;
//                     GenJournalLine."Account No." := membersTable."No.";
//                     GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::"Interest Paid";//:"Interest Due";
//                     GenJournalLine."Loan No" := loansRegisterTable."Loan  No.";
//                     GenJournalLine.VALIDATE(GenJournalLine."Account No.");
//                     GenJournalLine."Posting Date" := TODAY;
//                     GenJournalLine."External Document No." := membersTable."No.";
//                     GenJournalLine.Description := documentNo + ' Interest Paid'; // -- interest paid
//                     GenJournalLine.Amount := -InterestAmount;// -InterestPaid;// ROUND(InterestPaid, 1, '>') * -1;
//                     GenJournalLine.VALIDATE(GenJournalLine.Amount);
//                     IF GenJournalLine.Amount <> 0 THEN
//                         GenJournalLine.INSERT;

//                     //Cr SwizzKash commission
//                     LineNo := LineNo + 10000;
//                     GenJournalLine.INIT;
//                     GenJournalLine."Journal Template Name" := 'GENERAL';
//                     GenJournalLine."Journal Batch Name" := 'MOBILELOAN';
//                     GenJournalLine."Line No." := LineNo;
//                     GenJournalLine."Document No." := documentNo;
//                     GenJournalLine."Account Type" := GenJournalLine."Account Type"::"G/L Account";
//                     GenJournalLine."Account No." := vendorCommAcc;
//                     GenJournalLine.VALIDATE(GenJournalLine."Account No.");
//                     GenJournalLine."Loan No" := loansRegisterTable."Loan  No.";
//                     GenJournalLine."Posting Date" := TODAY;
//                     GenJournalLine.Description := 'M-Polytech Vendor Comm';
//                     GenJournalLine.Amount := vendorCommAmount * -1;
//                     GenJournalLine.VALIDATE(GenJournalLine.Amount);
//                     //Updated here to get the Interest from The Loan Interest Account
//                     if LoanTypeTable.Get(loansRegisterTable."Loan Product Type") then begin
//                         GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
//                         GenJournalLine."Bal. Account No." := LoanTypeTable."Loan Interest Account";
//                         GenJournalLine."Loan Product Type" := LoanTypeTable.Code;
//                         GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
//                     end;
//                     IF GenJournalLine.Amount <> 0 THEN
//                         GenJournalLine.INSERT;
//                     // exit;
//                     //Post
//                     GenJournalLine.RESET;
//                     GenJournalLine.SETRANGE("Journal Template Name", 'GENERAL');
//                     GenJournalLine.SETRANGE("Journal Batch Name", 'MOBILELOAN');
//                     IF GenJournalLine.FIND('-') THEN BEGIN
//                         REPEAT
//                             GLPosting.RUN(GenJournalLine);
//                         UNTIL GenJournalLine.NEXT = 0;

//                         //***************Update Loan Status************//
//                         loansRegisterTable."Loan Status" := loansRegisterTable."Loan Status"::Issued;
//                         loansRegisterTable."Amount Disbursed" := AmountToCredit;
//                         loansRegisterTable.Posted := TRUE;
//                         loansRegisterTable."Interest Upfront Amount" := InterestAmount;
//                         loansRegisterTable."Outstanding Balance" := amount;
//                         loansRegisterTable.MODIFY;

//                         //=====================insert to Mpesa mobile disbursment
//                         MpesaDisbus.RESET;
//                         MpesaDisbus.SETRANGE(MpesaDisbus."Document No", documentNo);
//                         IF MpesaDisbus.FIND('-') = FALSE THEN BEGIN
//                             MpesaDisbus."Account No" := membersTable."No.";
//                             MpesaDisbus."Document Date" := TODAY;
//                             MpesaDisbus."Loan Amount" := amount;
//                             MpesaDisbus."Loan No" := loansRegisterTable."Loan  No.";
//                             MpesaDisbus."Document No" := documentNo;
//                             MpesaDisbus."Batch No" := 'MOBILE';
//                             MpesaDisbus."Date Entered" := TODAY;
//                             MpesaDisbus."Time Entered" := TIME;
//                             MpesaDisbus."Entered By" := USERID;
//                             MpesaDisbus."Member No" := membersTable."No.";
//                             MpesaDisbus."Telephone No" := membersTable."Phone No.";
//                             MpesaDisbus.Comments := 'Successfly Posted';
//                             //MpesaDisbus."Corporate No":='597676';
//                             MpesaDisbus."Delivery Center" := 'M-WALLET';
//                             MpesaDisbus."Customer Name" := membersTable.Name;
//                             MpesaDisbus.Status := MpesaDisbus.Status::Completed;// Closed;
//                             MpesaDisbus.Purpose := '24';
//                             MpesaDisbus.INSERT;
//                         END;
//                     END;

//                     swizzkasTransTable.Status := swizzkasTransTable.Status::Completed;
//                     swizzkasTransTable."Loan No" := loansRegisterTable."Loan  No.";
//                     swizzkasTransTable.Posted := TRUE;
//                     swizzkasTransTable."Posting Date" := TODAY;
//                     swizzkasTransTable.Comments := 'POSTED';
//                     swizzkasTransTable.MODIFY;
//                     result := 'TRUE';
//                     // msg := 'Dear ' + SplitString(membersTable.Name, ' ') + ', Your M-Polytech LOAN No ' + loanNo
//                     //   + ' of Ksh ' + FORMAT((AmountToDisburse)) + ' has been disbursed to your M-WALLET Account, '
//                     //   + ' Your loan of KShs ' + FORMAT(amount) + ' is due on ' + FORMAT(CALCDATE('+1M', TODAY));

//                     //Do not send SMS
//                     // SMSMessage(documentNo, membersTable."No.", membersTable."Phone No.", msg);

//                 END;//Loans Register

//             END ELSE BEGIN
//                 result := 'ACCINEXISTENT';
//                 swizzkasTransTable.Status := swizzkasTransTable.Status::Failed;
//                 swizzkasTransTable.Posted := TRUE;
//                 swizzkasTransTable."Posting Date" := TODAY;
//                 swizzkasTransTable.Comments := 'Failed.Invalid Account';
//                 swizzkasTransTable.MODIFY;
//             END;

//         END;
//     END;

//     local procedure fnPostLoan(loanNumber: Code[30])
//     var
//         swizzkasTransTable: Record "SwizzKash Transactions";
//         membersTable: Record Customer;
//         vendorTable: Record Vendor;
//         loansRegisterTable: Record "Loans Register";
//         chargesTable: Record Charges;
//         LoanProdCharges: Record "Loan Product Charges";
//         SaccoNoSeries: Record "Sacco No. Series";
//         NoSeriesMgt: Codeunit NoSeriesManagement;
//         LoanRepSchedule: Record "Loan Repayment Schedule";
//         ObjLoanPurpose: Record "Loans Purpose";
//         SaccoNo: Record "Sacco No. Series";
//         GenSetUp: Record "Sacco General Set-Up";
//         SaccoGenSetup: Record "Sacco General Set-Up";
//         vendorCommAcc: Code[30];
//         vendorCommAmount: Decimal;
//         LoanAcc: Code[30];
//         InterestAcc: Code[30];
//         InterestAmount: Decimal;
//         AmountToCredit: Decimal;
//         AmountToDisburse: Decimal;
//         loanNo: Text[20];
//         loanType: Code[50];
//         InsuranceAcc: Code[10];
//         AmountDispursed: Decimal;
//         InterestPaid: Decimal;
//         LoanTypeTable: Record "Loan Products Setup";
//     BEGIN
//         loanType := '24';

//         IF swizzkasTransTable.FIND('-') THEN BEGIN

//             GenSetUp.RESET;
//             GenSetUp.GET();
//             GenLedgerSetup.RESET;
//             GenLedgerSetup.GET;

//             // ** get loan and interest accounts **
//             LoanProductsSetup.RESET;
//             LoanProductsSetup.SETRANGE(LoanProductsSetup.Code, loanType);
//             IF LoanProductsSetup.FINDFIRST() THEN BEGIN
//                 LoanAcc := LoanProductsSetup."Loan Account";
//                 InterestAcc := LoanProductsSetup."Loan Interest Account";
//             END;

//             SaccoGenSetup.RESET;
//             SaccoGenSetup.GET;
//             //SaccoGenSetup.TESTFIELD("Mpesa Cash Withdrawal fee ac");


//             // -- get balance enquiry charges
//             chargesTable.RESET;
//             chargesTable.SETRANGE(Code, 'LNA');
//             IF chargesTable.FIND('-') THEN BEGIN
//                 vendorCommAcc := chargesTable."GL Account";
//                 // vendorCommAmount := chargesTable."Charge Amount";
//                 //saccoCommAmount:=chargesTable."Sacco Amount";
//                 //saccoCommAcc:='3000407';     // -- sacco commission account
//             END;

//             //Calculate Interest
//             // InterestAmount := ((LoanProductsSetup."Interest rate" / 12) / 100) * amount;
//             InterestAmount := ((LoanProductsSetup."Interest rate") / 100) * amount; //- per month
//             //2% Swizz Commission
//             vendorCommAmount := (2 / 100) * amount;
//             //The rest posts to he Sacco
//             InterestPaid := InterestAmount - vendorCommAmount;

//             AmountToCredit := amount;
//             // ** interest charged upfront , disburse amount less (interest+vendor commision)
//             AmountToDisburse := amount - InterestAmount;// (InterestAmount + vendorCommAmount);



//             //******* Create Loan *********//
//             loansRegisterTable.Reset();
//             loansRegisterTable.SetRange("Loan  No.", loanNumber);
//             if loansRegisterTable.Find('-') then begin
// //Post Loan
//             loansRegisterTable.RESET;
//             loansRegisterTable.SETRANGE(loansRegisterTable."Loan  No.", loanNo);
//             IF loansRegisterTable.FIND('-') THEN BEGIN

//                 //Dr loan Acc - 100%Amount
//                 LineNo := LineNo + 10000;
//                 GenJournalLine.INIT;
//                 GenJournalLine."Journal Template Name" := 'GENERAL';
//                 GenJournalLine."Journal Batch Name" := 'MOBILELOAN';
//                 GenJournalLine."Line No." := LineNo;
//                 GenJournalLine."Account Type" := GenJournalLine."Account Type"::Customer;
//                 GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::Loan;
//                 GenJournalLine."Loan No" := loansRegisterTable."Loan  No.";
//                 GenJournalLine."Account No." := membersTable."No.";
//                 GenJournalLine.VALIDATE(GenJournalLine."Account No.");
//                 GenJournalLine."Document No." := documentNo;
//                 GenJournalLine."External Document No." := membersTable."No.";
//                 GenJournalLine."Posting Date" := TODAY;
//                 GenJournalLine.Description := 'M-Polytech Loan Disbursment-' + loansRegisterTable."Loan  No.";
//                 GenJournalLine.Amount := amount;// AmountToDisburse;
//                 GenJournalLine.VALIDATE(GenJournalLine.Amount);
//                 IF GenJournalLine.Amount <> 0 THEN
//                     GenJournalLine.INSERT;


//                 //-------INTEREST CHARGED BEFORE INTEREST PAID - 7.5%.... FESTUS SWIZZ
//                 LineNo := LineNo + 10000;
//                 GenJournalLine.Init;
//                 GenJournalLine."Journal Template Name" := 'GENERAL';
//                 GenJournalLine."Journal Batch Name" := 'MOBILELOAN';
//                 GenJournalLine."Line No." := LineNo;
//                 GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
//                 GenJournalLine."Account No." := loansRegisterTable."Client Code";
//                 GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Due";
//                 GenJournalLine.Validate(GenJournalLine."Account No.");
//                 GenJournalLine."Document No." := documentNo;
//                 GenJournalLine."Posting Date" := Today;
//                 GenJournalLine.Description := 'INT Charged' + ' ' + Format(Today);
//                 if LoanTypeTable.Get(loansRegisterTable."Loan Product Type") then begin
//                     GenJournalLine.Amount := InterestAmount;
//                     GenJournalLine.Validate(GenJournalLine.Amount);
//                     GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
//                     GenJournalLine."Bal. Account No." := LoanTypeTable."Loan Interest Account";
//                     GenJournalLine."Loan Product Type" := LoanTypeTable.Code;
//                     GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
//                 end;
//                 if loansRegisterTable.Source = loansRegisterTable.Source::BOSA then begin
//                     GenJournalLine."Shortcut Dimension 1 Code" := membersTable."Global Dimension 1 Code";
//                     GenJournalLine."Shortcut Dimension 2 Code" := membersTable."Global Dimension 2 Code";
//                 end;
//                 GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
//                 GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
//                 GenJournalLine."Loan No" := loansRegisterTable."Loan  No.";

//                 if GenJournalLine.Amount <> 0 then
//                     GenJournalLine.Insert;
//                 ///----END INTEREST CHARGFED

//                 //Cr M-Wallet Acc - 100% amount
//                 LineNo := LineNo + 10000;
//                 GenJournalLine.INIT;
//                 GenJournalLine."Journal Template Name" := 'GENERAL';
//                 GenJournalLine."Journal Batch Name" := 'MOBILELOAN';
//                 GenJournalLine."Line No." := LineNo;
//                 GenJournalLine."Document No." := documentNo;
//                 GenJournalLine."Account Type" := GenJournalLine."Account Type"::Vendor;
//                 GenJournalLine."Account No." := vendorTable."No.";
//                 GenJournalLine.VALIDATE(GenJournalLine."Account No.");
//                 GenJournalLine."Loan No" := loansRegisterTable."Loan  No.";
//                 GenJournalLine."Posting Date" := TODAY;
//                 GenJournalLine.Description := 'M-Polytech Disbursment';
//                 GenJournalLine.Amount := -amount;
//                 GenJournalLine.VALIDATE(GenJournalLine.Amount);
//                 IF GenJournalLine.Amount <> 0 THEN
//                     GenJournalLine.INSERT;


//                 //Dr M-Wallet Acc - 7.5% InterestAmount
//                 LineNo := LineNo + 10000;
//                 GenJournalLine.INIT;
//                 GenJournalLine."Journal Template Name" := 'GENERAL';
//                 GenJournalLine."Journal Batch Name" := 'MOBILELOAN';
//                 GenJournalLine."Line No." := LineNo;
//                 GenJournalLine."Document No." := documentNo;
//                 GenJournalLine."Account Type" := GenJournalLine."Account Type"::Vendor;
//                 GenJournalLine."Account No." := vendorTable."No.";
//                 GenJournalLine.VALIDATE(GenJournalLine."Account No.");
//                 GenJournalLine."Loan No" := loansRegisterTable."Loan  No.";
//                 GenJournalLine."Posting Date" := TODAY;
//                 GenJournalLine.Description := 'M-Polytech Interest Charged';
//                 GenJournalLine.Amount := InterestAmount;
//                 GenJournalLine.VALIDATE(GenJournalLine.Amount);
//                 IF GenJournalLine.Amount <> 0 THEN
//                     GenJournalLine.INSERT;


//                 //Cr Interest Eloan - 5.5%
//                 //.....updated to pay the full interest Amount, then Charge Swizz Commision from the Interest Account .....7.5% InterestAmount
//                 LineNo := LineNo + 10000;
//                 GenJournalLine.INIT;
//                 GenJournalLine."Journal Template Name" := 'GENERAL';
//                 GenJournalLine."Journal Batch Name" := 'MOBILELOAN';
//                 GenJournalLine."Line No." := LineNo;
//                 GenJournalLine."Document No." := documentNo;
//                 GenJournalLine."Account Type" := GenJournalLine."Account Type"::Customer;
//                 GenJournalLine."Account No." := membersTable."No.";
//                 GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::"Interest Paid";//:"Interest Due";
//                 GenJournalLine."Loan No" := loansRegisterTable."Loan  No.";
//                 GenJournalLine.VALIDATE(GenJournalLine."Account No.");
//                 GenJournalLine."Posting Date" := TODAY;
//                 GenJournalLine."External Document No." := membersTable."No.";
//                 GenJournalLine.Description := documentNo + ' Interest Paid'; // -- interest paid
//                 GenJournalLine.Amount := -InterestAmount;// -InterestPaid;// ROUND(InterestPaid, 1, '>') * -1;
//                 GenJournalLine.VALIDATE(GenJournalLine.Amount);
//                 IF GenJournalLine.Amount <> 0 THEN
//                     GenJournalLine.INSERT;

//                 //Cr SwizzKash commission
//                 LineNo := LineNo + 10000;
//                 GenJournalLine.INIT;
//                 GenJournalLine."Journal Template Name" := 'GENERAL';
//                 GenJournalLine."Journal Batch Name" := 'MOBILELOAN';
//                 GenJournalLine."Line No." := LineNo;
//                 GenJournalLine."Document No." := documentNo;
//                 GenJournalLine."Account Type" := GenJournalLine."Account Type"::"G/L Account";
//                 GenJournalLine."Account No." := vendorCommAcc;
//                 GenJournalLine.VALIDATE(GenJournalLine."Account No.");
//                 GenJournalLine."Loan No" := loansRegisterTable."Loan  No.";
//                 GenJournalLine."Posting Date" := TODAY;
//                 GenJournalLine.Description := 'M-Polytech Vendor Comm';
//                 GenJournalLine.Amount := vendorCommAmount * -1;
//                 GenJournalLine.VALIDATE(GenJournalLine.Amount);
//                 //Updated here to get the Interest from The Loan Interest Account
//                 if LoanTypeTable.Get(loansRegisterTable."Loan Product Type") then begin
//                     GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
//                     GenJournalLine."Bal. Account No." := LoanTypeTable."Loan Interest Account";
//                     GenJournalLine."Loan Product Type" := LoanTypeTable.Code;
//                     GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
//                 end;
//                 IF GenJournalLine.Amount <> 0 THEN
//                     GenJournalLine.INSERT;
//                 // exit;
//                 //Post
//                 GenJournalLine.RESET;
//                 GenJournalLine.SETRANGE("Journal Template Name", 'GENERAL');
//                 GenJournalLine.SETRANGE("Journal Batch Name", 'MOBILELOAN');
//                 IF GenJournalLine.FIND('-') THEN BEGIN
//                     REPEAT
//                         GLPosting.RUN(GenJournalLine);
//                     UNTIL GenJournalLine.NEXT = 0;

//                     //***************Update Loan Status************//
//                     loansRegisterTable."Loan Status" := loansRegisterTable."Loan Status"::Issued;
//                     loansRegisterTable."Amount Disbursed" := AmountToCredit;
//                     loansRegisterTable.Posted := TRUE;
//                     loansRegisterTable."Interest Upfront Amount" := InterestAmount;
//                     loansRegisterTable."Outstanding Balance" := amount;
//                     loansRegisterTable.MODIFY;

                    
//                 END;

//                 swizzkasTransTable.Status := swizzkasTransTable.Status::Completed;
//                 swizzkasTransTable."Loan No" := loansRegisterTable."Loan  No.";
//                 swizzkasTransTable.Posted := TRUE;
//                 swizzkasTransTable."Posting Date" := TODAY;
//                 swizzkasTransTable.Comments := 'POSTED';
//                 swizzkasTransTable.MODIFY;
//             end;
            
//             loansRegisterTable."Approved Amount" := amount;
//             loansRegisterTable.Interest := LoanProductsSetup."Interest rate";
//             loansRegisterTable."Instalment Period" := LoanProductsSetup."Instalment Period";
//             loansRegisterTable.Repayment := amount + InterestAmount + MPESACharge;
//             loansRegisterTable."Expected Date of Completion" := CALCDATE('1M', TODAY);
//             //loansRegisterTable.Posted:=TRUE;
//             //membersTable.CALCFIELDS(membersTable."Current Shares", membersTable."Outstanding Balance", membersTable."Current Loan");
//             loansRegisterTable."Shares Balance" := membersTable."Current Shares";
//             loansRegisterTable."Amount Disbursed" := amount;
//             loansRegisterTable.Savings := membersTable."Current Shares";
//             loansRegisterTable."Interest Paid" := 0;
//             loansRegisterTable."Issued Date" := TODAY;
//             loansRegisterTable.Source := LoanProductsSetup.Source;
//             loansRegisterTable."Loan Disbursed Amount" := amount;
//             loansRegisterTable."Scheduled Principal to Date" := AmountToDisburse;
//             loansRegisterTable."Current Interest Paid" := 0;
//             loansRegisterTable."Loan Disbursement Date" := TODAY;
//             loansRegisterTable."Client Code" := membersTable."No.";
//             loansRegisterTable."Client Name" := membersTable.Name;
//             loansRegisterTable."Outstanding Balance to Date" := AmountToDisburse;
//             loansRegisterTable."Existing Loan" := membersTable."Outstanding Balance";
//             //loansRegisterTable."Staff No":=membersTable."Payroll/Staff No";
//             loansRegisterTable.Gender := membersTable.Gender;
//             loansRegisterTable."BOSA No" := membersTable."No.";
//             // loansRegisterTable."Branch Code":=Vendor."Global Dimension 2 Code";
//             loansRegisterTable."Requested Amount" := amount;
//             loansRegisterTable."ID NO" := membersTable."ID No.";
//             IF loansRegisterTable."Branch Code" = '' THEN loansRegisterTable."Branch Code" := membersTable."Global Dimension 2 Code";
//             loansRegisterTable."Loan  No." := loanNo;
//             loansRegisterTable."No. Series" := SaccoNoSeries."BOSA Loans Nos";
//             loansRegisterTable."Doc No Used" := documentNo;
//             loansRegisterTable."Loan Interest Repayment" := InterestAmount;
//             loansRegisterTable."Loan Principle Repayment" := amount;
//             loansRegisterTable."Loan Repayment" := amount;
//             loansRegisterTable."Employer Code" := membersTable."Employer Code";
//             loansRegisterTable."Approval Status" := loansRegisterTable."Approval Status"::Approved;
//             loansRegisterTable."Account No" := membersTable."No.";
//             loansRegisterTable."Application Date" := TODAY;
//             loansRegisterTable."Loan Product Type" := LoanProductsSetup.Code;
//             loansRegisterTable."Loan Product Type Name" := LoanProductsSetup."Product Description";
//             loansRegisterTable."Loan Disbursement Date" := TODAY;
//             loansRegisterTable."Repayment Start Date" := TODAY;
//             loansRegisterTable."Recovery Mode" := loansRegisterTable."Recovery Mode"::Checkoff;
//             loansRegisterTable."Mode of Disbursement" := loansRegisterTable."Mode of Disbursement"::" ";
//             loansRegisterTable."Requested Amount" := amount;
//             loansRegisterTable."Approved Amount" := amount;
//             loansRegisterTable.Installments := 1;
//             loansRegisterTable."Loan Amount" := amount;
//             loansRegisterTable."Issued Date" := TODAY;
//             loansRegisterTable."Outstanding Balance" := 0;//Update
//             loansRegisterTable."Repayment Frequency" := loansRegisterTable."Repayment Frequency"::Monthly;
//             loansRegisterTable.INSERT(TRUE);

//             // InterestAmount:=0;

//             //**********Process Loan*******************//

//             GenJournalLine.RESET;
//             GenJournalLine.SETRANGE("Journal Template Name", 'GENERAL');
//             GenJournalLine.SETRANGE("Journal Batch Name", 'MOBILELOAN');
//             GenJournalLine.DELETEALL;
//             //end of deletion

//             GenBatches.RESET;
//             GenBatches.SETRANGE(GenBatches."Journal Template Name", 'GENERAL');
//             GenBatches.SETRANGE(GenBatches.Name, 'MOBILELOAN');
//             IF GenBatches.FIND('-') = FALSE THEN BEGIN
//                 GenBatches.INIT;
//                 GenBatches."Journal Template Name" := 'GENERAL';
//                 GenBatches.Name := 'MOBILELOAN';
//                 GenBatches.Description := 'Normal Loan';
//                 GenBatches.VALIDATE(GenBatches."Journal Template Name");
//                 GenBatches.VALIDATE(GenBatches.Name);
//                 GenBatches.INSERT;
//             END;



            
//                 result := 'TRUE';
//                 // msg := 'Dear ' + SplitString(membersTable.Name, ' ') + ', Your M-Polytech LOAN No ' + loanNo
//                 //   + ' of Ksh ' + FORMAT((AmountToDisburse)) + ' has been disbursed to your M-WALLET Account, '
//                 //   + ' Your loan of KShs ' + FORMAT(amount) + ' is due on ' + FORMAT(CALCDATE('+1M', TODAY));

//                 //Do not send SMS
//                 // SMSMessage(documentNo, membersTable."No.", membersTable."Phone No.", msg);

//             END;//Loans Register



//         END;
//     END;

// }
