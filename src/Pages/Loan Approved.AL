// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Page 51516574 "Loans Application Card(Approv)"
// {
//     DelayedInsert = false;
//     DeleteAllowed = false;
//     InsertAllowed = false;
//     ModifyAllowed = true;
//     PageType = Card;
//     ShowFilter = false;
//     SourceTable = "Loans Register";

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
//                 field("Staff No"; Rec."Staff No")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Staff No';
//                     Editable = false;
//                 }
//                 field("Client Code"; Rec."Client Code")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Member';
//                     Editable = MNoEditable;
//                 }
//                 field("Account No"; Rec."Account No")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = AccountNoEditable;
//                     Visible = false;
//                 }
//                 field("Client Name"; Rec."Client Name")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("ID NO"; Rec."ID NO")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field("Member Deposits"; Rec."Member Deposits")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Application Date"; Rec."Application Date")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = ApplcDateEditable;

//                     trigger OnValidate()
//                     begin
//                         TestField(Posted, false);
//                     end;
//                 }
//                 field("Loan Product Type"; Rec."Loan Product Type")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = LProdTypeEditable;
//                 }
//                 field(Interest; Interest)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field(Installments; Installments)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = InstallmentEditable;

//                     trigger OnValidate()
//                     begin
//                         TestField(Posted, false);
//                     end;
//                 }
//                 field("Product Currency Code"; Rec."Product Currency Code")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                     Enabled = true;
//                     Visible = false;
//                 }
//                 field("Requested Amount"; Rec."Requested Amount")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Amount Applied';
//                     Editable = AppliedAmountEditable;

//                     trigger OnValidate()
//                     begin
//                         TestField(Posted, false);
//                     end;
//                 }
//                 field("Boost this Loan"; Rec."Boost this Loan")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = AppliedAmountEditable;
//                 }
//                 field("Boosted Amount"; Rec."Boosted Amount")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = AppliedAmountEditable;
//                 }
//                 field("Recommended Amount"; Rec."Recommended Amount")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Approved Amount"; Rec."Approved Amount")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Approved Amount';
//                     Editable = false;
//                     Enabled = false;

//                     trigger OnValidate()
//                     begin
//                         TestField(Posted, false);
//                     end;
//                 }
//                 field("Paying Bank Account No"; Rec."Paying Bank Account No")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("G/L Account"; Rec."G/L Account")
//                 {
//                     ApplicationArea = Basic;
//                     Visible = false;

//                     trigger OnValidate()
//                     begin
//                         if GLAccount.Get("Account No") then begin
//                             "G/L Account Name" := GLAccount.Name;
//                         end;
//                     end;
//                 }
//                 field("G/L Account Name"; Rec."G/L Account Name")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'G/L Account Name';
//                     Editable = false;
//                     Enabled = false;
//                     Visible = false;

//                     trigger OnValidate()
//                     begin

//                         if GLAccount.Get("Account No") then begin
//                             "G/L Account Name" := GLAccount.Name;
//                         end;
//                     end;
//                 }
//                 field("Loan Purpose"; Rec."Loan Purpose")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = true;
//                     Visible = false;
//                 }
//                 field(Remarks; Remarks)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = RemarksEditable;
//                     Visible = false;
//                 }
//                 field("Repayment Method"; Rec."Repayment Method")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field(Repayment; Repayment)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = RepaymentEditable;
//                 }
//                 field("Loan Principle Repayment"; Rec."Loan Principle Repayment")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Principle Repayment';
//                 }
//                 field("Loan Interest Repayment"; Rec."Loan Interest Repayment")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Interest Repayment';
//                 }
//                 field(Insurance; Insurance)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Approved Repayment"; Rec."Approved Repayment")
//                 {
//                     ApplicationArea = Basic;
//                     Visible = false;
//                 }
//                 field("Loan Status"; Rec."Loan Status")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = LoanStatusEditable;

//                     trigger OnValidate()
//                     begin
//                         //UpdateControl();
//                     end;
//                 }
//                 field("Repayment Frequency"; Rec."Repayment Frequency")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = RepayFrequencyEditable;
//                 }
//                 field("Mode of Disbursement"; Rec."Mode of Disbursement")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Loan Disbursement Date"; Rec."Loan Disbursement Date")
//                 {
//                     ApplicationArea = Basic;
//                     AssistEdit = true;
//                     Editable = EditableField;
//                     Enabled = EditableField;
//                     Importance = Promoted;
//                     NotBlank = true;
//                     ShowMandatory = true;
//                     Style = Attention;
//                     StyleExpr = true;
//                 }
//                 field("Cheque No."; Rec."Cheque No.")
//                 {
//                     ApplicationArea = Basic;
//                     Visible = false;

//                     trigger OnValidate()
//                     begin
//                         if StrLen("Cheque No.") > 6 then
//                             Error('Document No. cannot contain More than 6 Characters.');
//                     end;
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
//                 field("External EFT"; Rec."External EFT")
//                 {
//                     ApplicationArea = Basic;
//                     Visible = false;
//                 }
//                 field("Approval Status"; Rec."Approval Status")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                     Enabled = false;
//                 }
//                 field("partially Bridged"; Rec."partially Bridged")
//                 {
//                     ApplicationArea = Basic;
//                     Visible = false;
//                 }
//                 field(Posted; Posted)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field("Total TopUp Commission"; Rec."Total TopUp Commission")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Top Up Amount"; Rec."Top Up Amount")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Bridged Amount';
//                 }
//                 field("Captured By"; Rec."Captured By")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Rejection  Remark"; Rec."Rejection  Remark")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = RejectionRemarkEditable;
//                 }
//                 field("MERCHANDISE Type"; Rec."Product Type")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Batch No."; Rec."Batch No.")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = true;
//                     Visible = true;
//                 }
//             }
//             group("Disbursement Information")
//             {
//                 Caption = 'Disbursement Information';
//                 field("Disburesment Type"; Rec."Disburesment Type")
//                 {
//                     ApplicationArea = Basic;
//                     Style = Attention;
//                     StyleExpr = true;
//                 }
//             }
//             group(Earnings)
//             {
//                 Caption = 'Earnings';
//                 Editable = false;
//                 Visible = false;
//                 field("Basic Pay H"; Rec."Basic Pay H")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Basic Pay';
//                 }
//                 field("House AllowanceH"; Rec."House AllowanceH")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'House Allowance';
//                 }
//                 field("Medical AllowanceH"; Rec."Medical AllowanceH")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Medical Allowance';
//                 }
//                 field("Transport/Bus Fare"; Rec."Transport/Bus Fare")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Other Income"; Rec."Other Income")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(GrossPay; GrossPay)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Nettakehome; Nettakehome)
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
//             group("Non-Taxable Deductions")
//             {
//                 Caption = 'Non-Taxable Deductions';
//                 Editable = false;
//                 Visible = false;
//                 field("Pension Scheme"; Rec."Pension Scheme")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Other Non-Taxable"; Rec."Other Non-Taxable")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Other Tax Relief"; Rec."Other Tax Relief")
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
//             group(Deductions)
//             {
//                 Caption = 'Deductions';
//                 Editable = false;
//                 Visible = false;
//                 field("Monthly Contribution"; Rec."Monthly Contribution")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(NHIF; NHIF)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(NSSF; NSSF)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(PAYE; PAYE)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Risk MGT"; Rec."Risk MGT")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Medical Insurance"; Rec."Medical Insurance")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Life Insurance"; Rec."Life Insurance")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Other Liabilities"; Rec."Other Liabilities")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Sacco Deductions"; Rec."Sacco Deductions")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Other Loans Repayments"; Rec."Other Loans Repayments")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Bank Loan Repayments';
//                 }
//                 field(TotalDeductions; TotalDeductions)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Total Deductions';
//                 }
//                 field(UtilizableAmount; "Utilizable Amount")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Bridge Amount Release"; Rec."Bridge Amount Release")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Cleared Loan Repayment';
//                 }
//                 field(NetUtilizable; NetUtilizable)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Net Utilizable Amount';
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(navigation)
//         {
//             group(Loan)
//             {
//                 Caption = 'Loan';
//                 Image = AnalysisView;
//                 action("Loan Appraisal")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Loan Appraisal';
//                     Enabled = true;
//                     Image = GanttChart;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     PromotedOnly = true;
//                     Visible = false;

//                     trigger OnAction()
//                     begin
//                         TestField("Mode of Disbursement");
//                         LoanApp.Reset;
//                         LoanApp.SetRange(LoanApp."Loan  No.", "Loan  No.");
//                         if LoanApp.Find('-') then begin
//                             if LoanApp.Source = LoanApp.Source::BOSA then
//                                 Report.Run(51516384, true, false, LoanApp)
//                             else
//                                 Report.Run(51516384, true, false, LoanApp)
//                         end;
//                     end;
//                 }
//                 action("Member Statement")
//                 {
//                     ApplicationArea = Basic;
//                     Promoted = true;
//                     PromotedCategory = "Report";
//                     PromotedOnly = true;

//                     trigger OnAction()
//                     begin
//                         Cust.Reset;
//                         Cust.SetRange(Cust."No.", "Client Code");
//                         Report.Run(51516886, true, false, Cust);
//                     end;
//                 }
//                 action("View Schedule")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'View Schedule';
//                     Image = "Table";
//                     Promoted = true;
//                     PromotedCategory = "Report";
//                     PromotedOnly = true;
//                     ShortCutKey = 'Ctrl+F7';

//                     trigger OnAction()
//                     begin
//                         if "Loan Disbursement Date" = 0D then
//                             Error('Please enter the disbursement Date');

//                         SFactory.FnGenerateRepaymentSchedule(Rec."Loan  No.");
//                         LoanApp.Reset;
//                         LoanApp.SetRange(LoanApp."Loan  No.", "Loan  No.");
//                         if LoanApp.Find('-') then
//                             Report.Run(51516477, true, false, LoanApp);
//                     end;
//                 }
//                 action("Loan Payment Voucher")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Loan Payment Voucher';
//                     Promoted = true;
//                     PromotedCategory = "Report";
//                     PromotedIsBig = true;
//                     Visible = false;

//                     trigger OnAction()
//                     begin
//                         LoanApp.Reset;
//                         LoanApp.SetRange(LoanApp."Loan  No.", "Loan  No.");
//                         if LoanApp.FindFirst then begin
//                             Report.Run(51516049, true, false, LoanApp);
//                         end;
//                     end;
//                 }
//                 action(Post)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Post Loan';
//                     Image = Post;
//                     Promoted = true;
//                     PromotedCategory = Process;

//                     trigger OnAction()
//                     var
//                         Text001: label 'The Batch need to be approved.';
//                     begin

//                         if Confirm('Are you sure you want to post this Loan?', true) = false then
//                             exit;
//                         if "Approval Status" <> "approval status"::Approved then
//                             Error('Loan is not Approved');
//                         if Usersetup.Get(UserId) then begin
//                             if Usersetup."Post Loans" = false then
//                                 Error('You dont have permissions to Post a Loan! ')
//                         end;
//                         //MESSAGE(FORMAT("Paying Bank Account No"));

//                         if ("Loan Product Type" = '21') or ("Loan Product Type" = '26') then begin
//                             "Paying Bank Account No" := ' '
//                         end else begin
//                             // TESTFIELD ("Paying Bank Account No");
//                         end;
//                         //MESSAGE(FORMAT("Paying Bank Account No"));
//                         if "Loan Product Type" = '26' then begin
//                             //  TESTFIELD("Product Type");
//                             if "Product Type" = "product type"::" " then
//                                 Error('Kindly Enter Mercandise Type');
//                         end;
//                         if Posted = true then
//                             Error('Loan already posted.');
//                         "Posting Date" := "Loan Disbursement Date";
//                         if "Loan Disbursement Date" = 0D then
//                             Error('Please enter the disbursement Date');
//                         SFactory.FnGenerateRepaymentSchedule(Rec."Loan  No.");
//                         //MESSAGE('3test is %1',LoanApp."Loan  No.");
//                         //*********************************************************************P
//                         FnPostLoan();
//                         //**********************************************************************
//                         Message('Loan posted successfully.');
//                         CurrPage.Close;
//                     end;
//                 }
//             }
//         }
//     }

//     trigger OnAfterGetCurrRecord()
//     begin
//         EditableField := true;
//     end;

//     trigger OnAfterGetRecord()
//     begin
//         EditableField := true;
//     end;

//     trigger OnInsertRecord(BelowxRec: Boolean): Boolean
//     begin
//         if GLAccount.Get("Account No") then begin
//             "G/L Account Name" := GLAccount.Name;
//         end;
//     end;

//     trigger OnModifyRecord(): Boolean
//     begin
//         if GLAccount.Get("Account No") then begin
//             "G/L Account Name" := GLAccount.Name;
//         end;
//     end;

//     trigger OnOpenPage()
//     begin
//         EditableField := true;
//     end;

//     var
//         "Product Type": Option " ",Tank,Mattress;
//         "G/L Account Name": Text[100];
//         LoansGuaranteeDetails: Record 51372;
//         RunningBal: Decimal;
//         KNFactory: Codeunit UnknownCodeunit51516007;
//         TaxChargeAmount2: Decimal;
//         ProductChargesAmount2: Decimal;
//         TaxChargeAmount1: Decimal;
//         ProductChargesAmount: Decimal;
//         ObjLoanProductCharges: Record 51383;
//         loans: Record 51371;
//         HisaLoan: Record 51371;
//         BatchHisaRepayment: Decimal;
//         BatchFosaHisaComm: Decimal;
//         BatchHisaShareBoostComm: Decimal;
//         BatchShareCap: Decimal;
//         BatchIntinArr: Decimal;
//         Loaninsurance: Decimal;
//         TLoaninsurance: Decimal;
//         ProductCharges: Record 51383;
//         InsuranceAcc: Code[20];
//         DataSheet: Record 51417;
//         SMSAcc: Code[10];
//         SMSFee: Decimal;
//         InterestUpfrontSavers: Decimal;
//         SaccoInterest: Decimal;
//         Customer: Record 51364;
//         LoanTypes: Record 51381;
//         PTEN: Text;
//         Jtemplate: Code[30];
//         JBatch: Code[30];
//         FundsUserSetup: Record 51031;
//         SendEmail: Boolean;
//         Filename: Text[100];
//         SMTPSetup: Record "SMTP Mail Setup";
//         SMTPMail: Codeunit UnknownCodeunit400;
//         MembersReg: Record 51364;
//         Attachment: Text[250];
//         LnPP: Record 51371;
//         LoanDisBatchLines: Record 51645;
//         PenaltyAccount: Code[30];
//         Commision: Decimal;
//         TopAmount: Decimal;
//         ProductChargesAmount1: Decimal;
//         TaxChargeAmount: Decimal;
//         PRODUCTCHARGESFEE: Decimal;
//         i: Integer;
//         LoanType: Record 51381;
//         PeriodDueDate: Date;
//         ScheduleRep: Record 51375;
//         LoanGuar: Record 51372;
//         RunningDate: Date;
//         G: Integer;
//         IssuedDate: Date;
//         SMSMessages: Record 51471;
//         iEntryNo: Integer;
//         GracePeiodEndDate: Date;
//         InstalmentEnddate: Date;
//         GracePerodDays: Integer;
//         InstalmentDays: Integer;
//         NoOfGracePeriod: Integer;
//         NewSchedule: Record 51375;
//         RSchedule: Record 51375;
//         GP: Text[30];
//         ScheduleCode: Code[20];
//         PreviewShedule: Record 51375;
//         PeriodInterval: Code[10];
//         CustomerRecord: Record 51364;
//         Gnljnline: Record "Gen. Journal Line";
//         Jnlinepost: Codeunit "Gen. Jnl.-Post Line";
//         CumInterest: Decimal;
//         NewPrincipal: Decimal;
//         PeriodPrRepayment: Decimal;
//         GenBatch: Record "Gen. Journal Batch";
//         LineNo: Integer;
//         GnljnlineCopy: Record "Gen. Journal Line";
//         NewLNApplicNo: Code[10];
//         Cust: Record 51364;
//         LoanApp: Record 51371;
//         TestAmt: Decimal;
//         CustRec: Record 51364;
//         CustPostingGroup: Record "Customer Posting Group";
//         GenSetUp: Record 51398;
//         PCharges: Record 51383;
//         TCharges: Decimal;
//         LAppCharges: Record 51385;
//         LoansR: Record 51371;
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
//         GLPosting: Codeunit "Gen. Jnl.-Post Line";
//         LoanTopUp: Record 51376;
//         Vend: Record Vendor;
//         BOSAInt: Decimal;
//         TopUpComm: Decimal;
//         DActivity: Code[20];
//         DBranch: Code[20];
//         TotalTopupComm: Decimal;
//         CustE: Record 51364;
//         DocN: Text[50];
//         DocM: Text[100];
//         DNar: Text[250];
//         DocF: Text[50];
//         MailBody: Text[250];
//         ccEmail: Text[250];
//         LoanG: Record 51372;
//         SpecialComm: Decimal;
//         FOSAName: Text[150];
//         IDNo: Code[50];
//         MovementTracker: Record 51394;
//         DiscountingAmount: Decimal;
//         StatusPermissions: Record 51452;
//         BridgedLoans: Record 51379;
//         SMSMessage: Record 51471;
//         InstallNo2: Integer;
//         currency: Record "Currency Exchange Rate";
//         CURRENCYFACTOR: Decimal;
//         LoanApps: Record 51371;
//         LoanDisbAmount: Decimal;
//         BatchTopUpAmount: Decimal;
//         BatchTopUpComm: Decimal;
//         Disbursement: Record 51377;
//         SchDate: Date;
//         DisbDate: Date;
//         WhichDay: Integer;
//         LBatches: Record 51371;
//         SalDetails: Record 51373;
//         LGuarantors: Record 51372;
//         DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal;
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
//         Doc_Type: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal;
//         ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//         GrossPay: Decimal;
//         Nettakehome: Decimal;
//         TotalDeductions: Decimal;
//         UtilizableAmount: Decimal;
//         NetUtilizable: Decimal;
//         Deductions: Decimal;
//         Benov: Decimal;
//         TAXABLEPAY: Record 51478;
//         PAYE: Decimal;
//         PAYESUM: Decimal;
//         BAND1: Decimal;
//         BAND2: Decimal;
//         BAND3: Decimal;
//         BAND4: Decimal;
//         BAND5: Decimal;
//         Taxrelief: Decimal;
//         OTrelief: Decimal;
//         Chargeable: Decimal;
//         PartPay: Record 51494;
//         PartPayTotal: Decimal;
//         AmountPayable: Decimal;
//         RepaySched: Record 51375;
//         LoanReferee1NameEditable: Boolean;
//         LoanReferee2NameEditable: Boolean;
//         LoanReferee1MobileEditable: Boolean;
//         LoanReferee2MobileEditable: Boolean;
//         LoanReferee1AddressEditable: Boolean;
//         LoanReferee2AddressEditable: Boolean;
//         LoanReferee1PhyAddressEditable: Boolean;
//         LoanReferee2PhyAddressEditable: Boolean;
//         LoanReferee1RelationEditable: Boolean;
//         LoanReferee2RelationEditable: Boolean;
//         LoanPurposeEditable: Boolean;
//         WitnessEditable: Boolean;
//         compinfo: Record "Company Information";
//         CummulativeGuarantee: Decimal;
//         LoansRec: Record 51371;
//         RecoveryModeEditable: Boolean;
//         RemarksEditable: Boolean;
//         CopyofIDEditable: Boolean;
//         CopyofPayslipEditable: Boolean;
//         ScheduleBal: Decimal;
//         SFactory: Codeunit UnknownCodeunit51516007;
//         BATCH_NAME: Code[50];
//         BATCH_TEMPLATE: Code[50];
//         ReschedulingFees: Decimal;
//         ReschedulingFeeAccount: Code[50];
//         LoanProcessingFee: Decimal;
//         ExciseDuty: Decimal;
//         EditableField: Boolean;
//         DOCUMENT_NO: Code[40];
//         Usersetup: Record "User Setup";
//         GLAccount: Record "G/L Account";


//     procedure UpdateControl()
//     begin
//         if "Approval Status" = "approval status"::Open then begin
//             MNoEditable := true;
//             ApplcDateEditable := false;
//             LoanStatusEditable := false;
//             LProdTypeEditable := true;
//             InstallmentEditable := true;
//             AppliedAmountEditable := true;
//             ApprovedAmountEditable := true;
//             RepayMethodEditable := true;
//             RepaymentEditable := true;
//             BatchNoEditable := false;
//             RepayFrequencyEditable := true;
//             ModeofDisburesmentEdit := true;
//             DisbursementDateEditable := false;
//             BatchNoEditable := false;
//             RemarksEditable := false;
//         end;

//         if "Approval Status" = "approval status"::Pending then begin
//             MNoEditable := false;
//             ApplcDateEditable := false;
//             LoanStatusEditable := false;
//             LProdTypeEditable := false;
//             InstallmentEditable := false;
//             AppliedAmountEditable := false;
//             ApprovedAmountEditable := true;
//             RepayMethodEditable := true;
//             RepaymentEditable := true;
//             BatchNoEditable := false;
//             RepayFrequencyEditable := false;
//             ModeofDisburesmentEdit := true;
//             DisbursementDateEditable := false;
//             BatchNoEditable := false;
//             RemarksEditable := false;
//         end;

//         if "Approval Status" = "approval status"::Rejected then begin
//             MNoEditable := false;
//             AccountNoEditable := false;
//             ApplcDateEditable := false;
//             LoanStatusEditable := false;
//             LProdTypeEditable := false;
//             InstallmentEditable := false;
//             AppliedAmountEditable := false;
//             ApprovedAmountEditable := false;
//             RepayMethodEditable := false;
//             RepaymentEditable := false;
//             BatchNoEditable := false;
//             RepayFrequencyEditable := false;
//             ModeofDisburesmentEdit := false;
//             DisbursementDateEditable := false;
//             RejectionRemarkEditable := false;
//             BatchNoEditable := false;
//             RemarksEditable := false;
//         end;

//         if "Approval Status" = "approval status"::Approved then begin
//             MNoEditable := false;
//             AccountNoEditable := false;
//             LoanStatusEditable := false;
//             ApplcDateEditable := false;
//             LProdTypeEditable := false;
//             InstallmentEditable := false;
//             AppliedAmountEditable := false;
//             ApprovedAmountEditable := false;
//             RepayMethodEditable := false;
//             RepaymentEditable := false;
//             BatchNoEditable := true;
//             RepayFrequencyEditable := false;
//             ModeofDisburesmentEdit := true;
//             DisbursementDateEditable := true;
//             RejectionRemarkEditable := false;
//             BatchNoEditable := true;
//             RemarksEditable := false;
//         end;
//     end;


//     procedure LoanAppPermisions()
//     begin
//     end;

//     local procedure FnGenerateSchedule()
//     var
//         NLInterest: Decimal;
//         InterestVarianceOnlyNafaka: Decimal;
//     begin
//         if "Repayment Frequency" = "repayment frequency"::Daily then
//             Evaluate(InPeriod, '1D')
//         else if "Repayment Frequency" = "repayment frequency"::Weekly then
//             Evaluate(InPeriod, '1W')
//         else if "Repayment Frequency" = "repayment frequency"::Monthly then
//             Evaluate(InPeriod, '1M')
//         else if "Repayment Frequency" = "repayment frequency"::Quaterly then
//             Evaluate(InPeriod, '1Q');


//         QCounter := 0;
//         QCounter := 3;
//         ScheduleBal := 0;
//         GrPrinciple := "Grace Period - Principle (M)";
//         GrInterest := "Grace Period - Interest (M)";
//         InitialGraceInt := "Grace Period - Interest (M)";

//         LoansR.Reset;
//         LoansR.SetRange(LoansR."Loan  No.", "Loan  No.");
//         if LoansR.Find('-') then begin

//             TestField("Loan Disbursement Date");
//             TestField("Repayment Start Date");

//             RSchedule.Reset;
//             RSchedule.SetRange(RSchedule."Loan No.", "Loan  No.");
//             RSchedule.DeleteAll;

//             LoanAmount := LoansR."Approved Amount" + LoansR."Capitalized Charges";
//             InterestRate := LoansR.Interest;
//             RepayPeriod := LoansR.Installments;
//             InitialInstal := LoansR.Installments + "Grace Period - Principle (M)";
//             LBalance := LoansR."Approved Amount" + LoansR."Capitalized Charges";
//             LNBalance := LoansR."Outstanding Balance";
//             RunDate := "Repayment Start Date";

//             InstalNo := 0;
//             Evaluate(RepayInterval, '1W');

//             //Repayment Frequency
//             if "Repayment Frequency" = "repayment frequency"::Daily then
//                 RunDate := CalcDate('-1D', RunDate)
//             else if "Repayment Frequency" = "repayment frequency"::Weekly then
//                 RunDate := CalcDate('-1W', RunDate)
//             else if "Repayment Frequency" = "repayment frequency"::Monthly then
//                 RunDate := CalcDate('-1M', RunDate)
//             else if "Repayment Frequency" = "repayment frequency"::Quaterly then
//                 RunDate := CalcDate('-1Q', RunDate);
//             //Repayment Frequency


//             repeat
//                 InstalNo := InstalNo + 1;
//                 ScheduleBal := LBalance;

//                 //*************Repayment Frequency***********************//
//                 if "Repayment Frequency" = "repayment frequency"::Daily then
//                     RunDate := CalcDate('1D', RunDate)
//                 else if "Repayment Frequency" = "repayment frequency"::Weekly then
//                     RunDate := CalcDate('1W', RunDate)
//                 else if "Repayment Frequency" = "repayment frequency"::Monthly then
//                     RunDate := CalcDate('1M', RunDate)
//                 else if "Repayment Frequency" = "repayment frequency"::Quaterly then
//                     RunDate := CalcDate('1Q', RunDate);






//                 //*******************If Amortised****************************//
//                 if "Repayment Method" = "repayment method"::Amortised then begin
//                     TestField(Installments);
//                     TestField(Interest);
//                     TestField(Installments);
//                     TotalMRepay := ROUND((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -RepayPeriod)) * LoanAmount, 1, '>');
//                     TotalMRepay := (InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -RepayPeriod)) * LoanAmount;
//                     LInterest := ROUND(LBalance / 100 / 12 * InterestRate);

//                     LPrincipal := TotalMRepay - LInterest;
//                 end;



//                 if "Repayment Method" = "repayment method"::"Straight Line" then begin
//                     TestField(Installments);
//                     LPrincipal := ROUND(LoanAmount / RepayPeriod, 1, '>');
//                     if ("Loan Product Type" = 'INST') or ("Loan Product Type" = 'MAZAO') then begin
//                         LInterest := 0;
//                     end else begin
//                         LInterest := ROUND((InterestRate / 1200) * LoanAmount, 1, '>');
//                     end;

//                     Repayment := LPrincipal + LInterest;
//                     "Loan Principle Repayment" := LPrincipal;
//                     "Loan Interest Repayment" := LInterest;
//                 end;


//                 if "Repayment Method" = "repayment method"::"Reducing Balance" then begin
//                     TestField(Interest);
//                     TestField(Installments);
//                     LPrincipal := ROUND(LoanAmount / RepayPeriod, 1, '>');
//                     LInterest := ROUND((InterestRate / 12 / 100) * LBalance, 1, '>');
//                 end;

//                 if "Repayment Method" = "repayment method"::Constants then begin
//                     TestField(Repayment);
//                     if LBalance < Repayment then
//                         LPrincipal := LBalance
//                     else
//                         LPrincipal := Repayment;
//                     LInterest := Interest;
//                 end;


//                 //Grace Period
//                 if GrPrinciple > 0 then begin
//                     LPrincipal := 0
//                 end else begin
//                     if "Instalment Period" <> InPeriod then
//                         LBalance := LBalance - LPrincipal;
//                     ScheduleBal := ScheduleBal - LPrincipal;
//                 end;

//                 if GrInterest > 0 then
//                     LInterest := 0;

//                 GrPrinciple := GrPrinciple - 1;
//                 GrInterest := GrInterest - 1;

//                 //NLInterest:=ROUND(LoansRec."Approved Amount"*LoansRec.Interest/12*(RepayPeriod+1)/(200*RepayPeriod),1,'>'); //For Nafaka Only
//                 //InterestVarianceOnlyNafaka:=LInterest-NLInterest;

//                 RSchedule.Init;
//                 RSchedule."Repayment Code" := RepayCode;
//                 RSchedule."Loan No." := "Loan  No.";
//                 RSchedule."Loan Amount" := LoanAmount;
//                 RSchedule."Instalment No" := InstalNo;
//                 RSchedule."Repayment Date" := CalcDate('CM', RunDate);
//                 RSchedule."Member No." := "Client Code";
//                 RSchedule."Loan Category" := "Loan Product Type";
//                 RSchedule."Monthly Repayment" := LInterest + LPrincipal;
//                 RSchedule."Monthly Interest" := LInterest;
//                 RSchedule."Monthly Insurance" := ROUND(LInterest, 1, '>');
//                 //RSchedule."Close Schedule":=InterestVarianceOnlyNafaka;
//                 RSchedule."Principal Repayment" := LPrincipal;
//                 RSchedule."Loan Balance" := ScheduleBal;
//                 RSchedule.Insert;
//                 WhichDay := Date2dwy(RSchedule."Repayment Date", 1);


//             until LBalance < 1

//         end;
//         LoanApp.Reset;
//         LoanApp.SetRange("Loan  No.", "Loan  No.");
//         if LoanApp.Find('-') then begin
//             LoanApp.Repayment := LInterest + LPrincipal;
//             LoanApp.Modify;
//         end;
//         Commit;
//     end;

//     local procedure FnDisburseToCurrentAccount(LoanApps: Record 51371)
//     var
//         ProcessingFees: Decimal;
//         ProcessingFeesAcc: Code[50];
//         PChargeAmount: Decimal;
//         BLoan: Code[30];
//     begin
//         if (SFactory.FnGetFosaAccount(LoanApps."Client Code") = '') then
//             Error('Member must be assigned the ordinary Account.');

//         GenSetUp.Get();
//         LoanApps.CalcFields(LoanApps."Top Up Amount", LoanApps."Topup iNTEREST");
//         TCharges := 0;
//         TopUpComm := 0;
//         TotalTopupComm := LoanApps."Top Up Amount";

//         //------------------------------------1. DEBIT MEMBER LOAN A/C---------------------------------------------------------------------------------------------
//         LineNo := LineNo + 10000;
//         SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::Loan,
//         GenJournalLine."account type"::Member, LoanApps."Client Code", "Posting Date", LoanApps."Approved Amount", Format(LoanApps.Source), LoanApps."Loan  No.",
//         'Loan principle- ' + LoanApps."Loan Product Type" + '-' + LoanApps."Loan  No.", LoanApps."Loan  No.");
//         //--------------------------------(Debit Member Loan Account)---------------------------------------------

//         //------------------------------------2. CREDIT MEMBER FOSA A/C---------------------------------------------------------------------------------------------
//         LineNo := LineNo + 10000;
//         SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
//         GenJournalLine."account type"::Vendor, SFactory.FnGetFosaAccount(LoanApps."Client Code"), "Posting Date", LoanApps."Approved Amount" * -1, 'BOSA', LoanApps."Loan  No.",
//         'Loan Issued- ' + LoanApps."Loan Product Type", LoanApps."Loan  No.");
//         //----------------------------------(Credit Member Fosa Account)------------------------------------------------

//         //------------------------------------3. EARN/RECOVER PRODUCT CHARGES FROM FOSA A/C--------------------------------------
//         PCharges.Reset;
//         PCharges.SetRange(PCharges."Product Code", LoanApps."Loan Product Type");
//         if PCharges.Find('-') then begin
//             repeat
//                 PCharges.TestField(PCharges."G/L Account");
//                 GenSetUp.TestField(GenSetUp."Excise Duty Account");
//                 PChargeAmount := PCharges.Amount;
//                 if PCharges."Use Perc" = true then
//                     PChargeAmount := (LoanApps."Approved Amount" * PCharges.Percentage / 100);
//                 //-------------------EARN CHARGE-------------------------------------------
//                 if (LoanApp."Loan Product Type" <> 'EMERGENCY 20') or (LoanApp."Loan Product Type" <> 'EMERGENCY 6') then begin

//                     LineNo := LineNo + 10000;
//                     SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
//                     GenJournalLine."account type"::"G/L Account", PCharges."G/L Account", "Posting Date", PChargeAmount * -1, 'BOSA', LoanApps."Loan  No.",
//                     PCharges.Description + '-' + LoanApps."Client Code" + '-' + LoanApps."Loan Product Type" + '-' + LoanApps."Loan  No.", LoanApps."Loan  No.");
//                     //-------------------RECOVER-----------------------------------------------
//                     LineNo := LineNo + 10000;
//                     SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
//                     GenJournalLine."account type"::Vendor, SFactory.FnGetFosaAccount(LoanApps."Client Code"), "Posting Date", PChargeAmount, 'BOSA', LoanApps."Loan  No.",
//                     PCharges.Description + '-' + LoanApps."Loan Product Type", LoanApps."Loan  No.");
//                 end;
//                 //New Emergency Loans
//                 //-------------------EARN CHARGE-------------------------------------------
//                 if (LoanApp."Loan Product Type" = 'EMERGENCY 20') or (LoanApp."Loan Product Type" = 'EMERGENCY 6') and (PCharges.Code <> 'LPF') then begin

//                     LineNo := LineNo + 10000;
//                     SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
//                     GenJournalLine."account type"::"G/L Account", PCharges."G/L Account", "Posting Date", PChargeAmount * -1, 'BOSA', LoanApps."Loan  No.",
//                     PCharges.Description + '-' + LoanApps."Client Code" + '-' + LoanApps."Loan Product Type" + '-' + LoanApps."Loan  No.", LoanApps."Loan  No.");
//                     //-------------------RECOVER-----------------------------------------------
//                     LineNo := LineNo + 10000;
//                     SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
//                     GenJournalLine."account type"::Vendor, SFactory.FnGetFosaAccount(LoanApps."Client Code"), "Posting Date", PChargeAmount, 'BOSA', LoanApps."Loan  No.",
//                     PCharges.Description + '-' + LoanApps."Loan Product Type", LoanApps."Loan  No.");
//                 end;

//                 if (LoanApp."Loan Product Type" = 'EMERGENCY 20') or (LoanApp."Loan Product Type" = 'EMERGENCY 6') and (PCharges.Code = 'LPF') then begin

//                     LineNo := LineNo + 10000;
//                     SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
//                     GenJournalLine."account type"::"G/L Account", PCharges."G/L Account", "Posting Date", PChargeAmount * -1, 'BOSA', LoanApps."Loan  No.",
//                     PCharges.Description + '-' + LoanApps."Client Code" + '-' + LoanApps."Loan Product Type" + '-' + LoanApps."Loan  No.", LoanApps."Loan  No.");
//                     //-------------------RECOVER-----------------------------------------------
//                     LineNo := LineNo + 10000;
//                     SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
//                     GenJournalLine."account type"::Vendor, SFactory.FnGetFosaAccount(LoanApps."Client Code"), "Posting Date", PChargeAmount, 'BOSA', LoanApps."Loan  No.",
//                     PCharges.Description + '-' + LoanApps."Loan Product Type", LoanApps."Loan  No.");
//                 end;

//                 //End New Emergency Addition
//                 //------------------10% EXCISE DUTY----------------------------------------
//                 if SFactory.FnChargeExcise(PCharges.Code) then begin
//                     //-------------------Earn---------------------------------
//                     LineNo := LineNo + 10000;
//                     SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
//                     GenJournalLine."account type"::"G/L Account", GenSetUp."Excise Duty Account", "Posting Date", (PChargeAmount * -1) * 0.1, 'BOSA', LoanApps."Loan  No.",
//                     PCharges.Description + '-' + LoanApps."Client Code" + '-' + LoanApps."Loan Product Type" + '-' + LoanApps."Loan  No." + '- Excise(10%)', LoanApps."Loan  No.");
//                     //-----------------Recover---------------------------------
//                     LineNo := LineNo + 10000;
//                     SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
//                     GenJournalLine."account type"::Vendor, SFactory.FnGetFosaAccount(LoanApps."Client Code"), "Posting Date", PChargeAmount * 0.1, 'BOSA', LoanApps."Loan  No.",
//                     PCharges.Description + '-' + LoanApps."Loan Product Type" + ' - Excise(10%)', LoanApps."Loan  No.");
//                 end
//             //----------------END 10% EXCISE--------------------------------------------
//             until PCharges.Next = 0;
//         end;


//         //----------------------------------------4. PAY/RECOVER TOP UPS------------------------------------------------------------------------------------------
//         if LoanApps."Top Up Amount" > 0 then begin
//             LoanTopUp.Reset;
//             LoanTopUp.SetRange(LoanTopUp."Loan No.", LoanApps."Loan  No.");
//             if LoanTopUp.Find('-') then begin
//                 repeat
//                     //------------------------------------PAY-----------------------------------------------------------------------------------------------------------
//                     //------------------------------------Principal---------------------
//                     LineNo := LineNo + 10000;
//                     SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
//                     GenJournalLine."account type"::Member, LoanApps."Client Code", "Posting Date", LoanTopUp."Principle Top Up" * -1, 'BOSA', LoanTopUp."Loan Top Up",
//                     'Off Set By - ' + LoanApps."Client Code" + '-' + LoanApps."Loan Product Type" + '-' + LoanApps."Loan  No.", LoanTopUp."Loan Top Up");
//                     //------------------------------------Outstanding Interest----------
//                     LineNo := LineNo + 10000;
//                     SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
//                     GenJournalLine."account type"::Member, LoanApps."Client Code", "Posting Date", LoanTopUp."Interest Top Up" * -1, 'BOSA', LoanTopUp."Loan Top Up",
//                     'Interest Paid-' + '-' + LoanApps."Loan Product Type" + '-' + LoanApps."Loan  No.", LoanTopUp."Loan Top Up");
//                     //-------------------------------------Levy--------------------------
//                     LineNo := LineNo + 10000;
//                     if LoanType.Get(LoanApps."Loan Product Type") then begin
//                         SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
//                         GenJournalLine."account type"::"G/L Account", LoanType."Top Up Commision Account", "Posting Date", LoanTopUp.Commision * -1, 'BOSA', LoanTopUp."Loan Top Up",
//                         'Levy on Bridging -' + LoanApps."Client Code" + '-' + LoanApps."Loan Product Type" + '-' + LoanApps."Loan  No.", LoanTopUp."Loan Top Up");
//                     end;

//                     //-------------------------------------RECOVER-------------------------------------------------------------------------------------------------------
//                     //-------------------------------------Principal-----------------------------------------------------------------------------------------------
//                     LineNo := LineNo + 10000;
//                     SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
//                     GenJournalLine."account type"::Vendor, SFactory.FnGetFosaAccount(LoanApps."Client Code"), "Posting Date", LoanTopUp."Principle Top Up", 'BOSA', LoanTopUp."Loan Top Up",
//                     'Loan Offset  - ' + LoanApps."Loan Product Type", LoanTopUp."Loan Top Up");
//                     //-------------------------------------Outstanding Interest-------------------------------------------------------------------------------------
//                     LineNo := LineNo + 10000;
//                     SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
//                     GenJournalLine."account type"::Vendor, SFactory.FnGetFosaAccount(LoanApps."Client Code"), "Posting Date", LoanTopUp."Interest Top Up", 'BOSA', LoanTopUp."Loan Top Up",
//                     'Interest Due Paid on top up - ' + LoanApps."Loan Product Type", LoanTopUp."Loan Top Up");
//                     //--------------------------------------Levies--------------------------------------------------------------------------------------------------
//                     LineNo := LineNo + 10000;
//                     if LoanType.Get(LoanApps."Loan Product Type") then begin
//                         SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
//                         GenJournalLine."account type"::Vendor, SFactory.FnGetFosaAccount(LoanApps."Client Code"), "Posting Date", LoanTopUp.Commision, 'BOSA', LoanTopUp."Loan Top Up",
//                         'Levy on Bridging - ' + LoanApps."Loan Product Type", LoanTopUp."Loan Top Up");
//                     end;
//                 //-------------------------------------Update Datasheet for Top up-------------------------------------------------------------------------------
//                 //SFactory.FnUpdateDatasheetTopup(LoanTopUp,LoanApps);
//                 until LoanTopUp.Next = 0;
//             end;
//         end;







//         //-----------------------------------------5. BOOST DEPOSITS / RECOVER FROM FOSA A/C--------------------------------------------------------------------------------------------
//         if LoanApps."Boost this Loan" then begin
//             //---------------------------------------BOOST-----------------------------------------------
//             LineNo := LineNo + 10000;
//             BLoan := "Booster Loan No";
//             if BLoan = '' then begin
//                 BLoan := FnBoosterLoansDisbursement(Rec, LineNo); //Issue Loan
//                 "Booster Loan No" := BLoan;
//             end;
//             SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::Loan,
//             GenJournalLine."account type"::Member, LoanApps."Client Code", "Posting Date", LoanApps."Boosted Amount", 'BOSA', BLoan,
//             'Deposits Booster for ' + LoanApps."Loan  No.", BLoan);

//             //----------------------Credit FOSA a/c-----------------------------------------------------
//             LineNo := LineNo + 10000;
//             SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
//             GenJournalLine."account type"::Vendor, SFactory.FnGetFosaAccount(LoanApps."Client Code"), "Posting Date", LoanApps."Boosted Amount" * -1, 'BOSA', BLoan,
//             'Deposits Booster Loan-Booster Loan', BLoan);


//             //------------------------------Boost Deposits-----------------------------------------------
//             LineNo := LineNo + 10000;
//             SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
//             GenJournalLine."account type"::Member, "Client Code", "Posting Date", LoanApps."Boosted Amount" * -1, 'BOSA', BLoan,
//             'Deposits Booster Loan', BLoan);

//             //--------------------------------------RECOVER-----------------------------------------------
//             LineNo := LineNo + 10000;
//             SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
//             GenJournalLine."account type"::Vendor, SFactory.FnGetFosaAccount(LoanApps."Client Code"), "Posting Date", LoanApps."Boosted Amount", 'BOSA', BLoan,
//             'Deposits Booster Loan Recov.', BLoan);
//         end;







//         //-----------------------------------------6. EARN/RECOVER BOOSTING COMMISSION--------------------------------------------------------------------------------------------
//         if LoanApps."Boosting Commision" > 0 then begin
//             //---------------------------------------EARN-----------------------------------------------
//             LineNo := LineNo + 10000;
//             SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
//             GenJournalLine."account type"::"G/L Account", GenSetUp."Boosting Fees Account", "Posting Date", LoanApps."Boosting Commision" * -1, 'BOSA', BLoan,
//             'Boosting Commision- ' + LoanApps."Client Code" + LoanApps."Loan Product Type" + '-' + LoanApps."Loan  No.", LoanApps."Loan  No.");
//             //--------------------------------------RECOVER-----------------------------------------------
//             LineNo := LineNo + 10000;
//             SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
//             GenJournalLine."account type"::Vendor, SFactory.FnGetFosaAccount(LoanApps."Client Code"), "Posting Date", LoanApps."Boosting Commision", 'BOSA', BLoan,
//             'Deposits Booster Comm. Recov.', LoanApps."Loan  No.");
//         end;

//         //-----------------------------------------7. EARN/RECOVER BOOSTER LOAN PRINCIPAL--------------------------------------------------------------------------------------------
//         if LoanApps."Boosting Commision" > 0 then begin
//             //---------------------------------------PAY-----------------------------------------------
//             LineNo := LineNo + 10000;
//             SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
//             GenJournalLine."account type"::Member, "Client Code", "Posting Date", LoanApps."Boosted Amount" * -1, 'BOSA', BLoan,
//             'Deposits Booster Repayment-' + LoanApps."Client Code" + LoanApps."Loan Product Type", BLoan);
//             //--------------------------------------RECOVER-----------------------------------------------
//             LineNo := LineNo + 10000;
//             SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
//             GenJournalLine."account type"::Vendor, SFactory.FnGetFosaAccount(LoanApps."Client Code"), "Posting Date", LoanApps."Boosted Amount", 'BOSA', BLoan,
//             'Deposits Booster Loan Recov.', BLoan);
//         end;

//         //-----------------------------------------8. EARN/RECOVER BOOSTER LOAN INTEREST--------------------------------------------------------------------------------------------
//         if LoanApps."Boosting Commision" > 0 then begin
//             //---------------------------------------PAY-----------------------------------------------
//             LineNo := LineNo + 10000;
//             SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
//             GenJournalLine."account type"::Member, "Client Code", "Posting Date", LoanApps."Boosted Amount Interest" * -1, 'BOSA', BLoan,
//             'Deposits Booster Int - ' + LoanApps."Client Code" + LoanApps."Loan Product Type", BLoan);
//             //--------------------------------------RECOVER-----------------------------------------------
//             LineNo := LineNo + 10000;
//             SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
//             GenJournalLine."account type"::Vendor, SFactory.FnGetFosaAccount(LoanApps."Client Code"), "Posting Date", LoanApps."Boosted Amount Interest", 'BOSA', BLoan,
//             'Deposits Booster Int Recov.', BLoan);
//         end;

//         LoanApps."Net Payment to FOSA" := LoanApps."Approved Amount";
//         LoanApps."Processed Payment" := true;
//         Modify;
//         //SFactory.FnCheckLoanArrears(LoanApps."Account No");
//     end;

//     local procedure FnBoosterLoansDisbursement(ObjLoanDetails: Record 51371; LineNo: Integer): Code[40]
//     var
//         GenJournalLine: Record "Gen. Journal Line";
//         CUNoSeriesManagement: Codeunit UnknownCodeunit396;
//         DocNumber: Code[100];
//         loanTypes: Record 51381;
//         ObjLoanX: Record 51371;
//     begin
//         loanTypes.Reset;
//         loanTypes.SetRange(loanTypes.Code, 'BLOAN');
//         if loanTypes.Find('-') then begin
//             DocNumber := CUNoSeriesManagement.GetNextNo('LOANSB', 0D, true);
//             LoansRec.Init;
//             LoansRec."Loan  No." := DocNumber;
//             LoansRec.Insert;

//             if LoansRec.Get(LoansRec."Loan  No.") then begin
//                 LoansRec."Client Code" := ObjLoanDetails."Client Code";
//                 LoansRec.Validate(LoansRec."Client Code");
//                 LoansRec."Loan Product Type" := 'BLOAN';
//                 LoansRec.Validate(LoansRec."Loan Product Type");
//                 LoansRec.Interest := ObjLoanDetails.Interest;
//                 LoansRec."Loan Status" := LoansRec."loan status"::Issued;
//                 LoansRec."Application Date" := ObjLoanDetails."Application Date";
//                 LoansRec."Issued Date" := ObjLoanDetails."Posting Date";
//                 LoansRec."Loan Disbursement Date" := ObjLoanDetails."Loan Disbursement Date";
//                 LoansRec.Validate(LoansRec."Loan Disbursement Date");
//                 LoansRec."Mode of Disbursement" := LoansRec."mode of disbursement"::"Bank Transfer";
//                 LoansRec."Repayment Start Date" := ObjLoanDetails."Repayment Start Date";
//                 LoansRec."Global Dimension 1 Code" := 'BOSA';
//                 LoansRec."Global Dimension 2 Code" := SFactory.FnGetUserBranch();
//                 LoansRec.Source := ObjLoanDetails.Source;
//                 LoansRec."Approval Status" := ObjLoanDetails."Approval Status";
//                 LoansRec.Repayment := ObjLoanDetails."Boosted Amount";
//                 LoansRec."Requested Amount" := ObjLoanDetails."Boosted Amount";
//                 LoansRec."Approved Amount" := ObjLoanDetails."Boosted Amount";
//                 LoansRec.Interest := ObjLoanDetails.Interest;
//                 LoansRec."Mode of Disbursement" := LoansRec."mode of disbursement"::"Bank Transfer";
//                 LoansRec.Posted := true;
//                 LoansRec."Advice Date" := Today;
//                 LoansRec.Modify;
//             end;
//         end;
//         exit(DocNumber);
//     end;

//     local procedure FnPostLoan()
//     var
//         DisbAmtTemp: Decimal;
//         InsuranceIncomeAcc: Code[20];
//         InsuranceAmount: Decimal;
//     begin
//         FundsUserSetup.Get(UserId);
//         Jtemplate := FundsUserSetup."Payment Journal Template";
//         JBatch := FundsUserSetup."Payment Journal Batch";

//         if Jtemplate = '' then begin
//             Error('Ensure the Imprest Template is set up in Cash Office Setup');
//         end;
//         if JBatch = '' then begin
//             Error('Ensure the Imprest Batch is set up in the Cash Office Setup')
//         end;
//         TestField("Posting Date");
//         GenJournalLine.Reset;
//         GenJournalLine.SetRange("Journal Template Name", Jtemplate);
//         GenJournalLine.SetRange("Journal Batch Name", JBatch);
//         GenJournalLine.DeleteAll;

//         GenSetUp.Get();
//         //Disburesment Via Cheque**************************************************************
//         if ("Mode of Disbursement" = "mode of disbursement"::Cheque) or ("Mode of Disbursement" = "mode of disbursement"::RTGS) or ("Mode of Disbursement" = "mode of disbursement"::EFT) or ("Mode of Disbursement" = "mode of disbursement"::"Bank Transfer")
//           then begin
//             RunningBal := 0;
//             LoanApps.Reset;
//             LoanApps.SetRange(LoanApps."Loan  No.", "Loan  No.");
//             LoanApps.SetFilter(LoanApps."Loan Status", '<>Rejected');
//             if LoanApps.Find('-') then begin
//                 if LoanApps."Disburesment Type" = LoanApps."disburesment type"::"Tranche/Multiple Disbursement" then begin
//                     //"Partial Disbursement":= '101053';
//                     Modify;
//                 end;


//                 LoanApps.CalcFields(LoanApps."Top Up Amount", LoanApps."Topup iNTEREST");
//                 TCharges := 0;
//                 TopUpComm := 0;
//                 TotalTopupComm := 0;
//                 if LoanApps."Top Up Amount" > 0 then begin
//                     LoanTopUp.Reset;
//                     LoanTopUp.SetRange(LoanTopUp."Loan No.", LoanApps."Loan  No.");
//                     if LoanTopUp.Find('-') then begin
//                         TopUpComm := LoanTopUp.Commision;
//                         repeat
//                             GenJournalLine.Init;
//                             LineNo := LineNo + 10000;
//                             GenJournalLine."Journal Template Name" := Jtemplate;
//                             GenJournalLine."Journal Batch Name" := JBatch;
//                             GenJournalLine."Line No." := LineNo;
//                             GenJournalLine."Document No." := LoanApps."Loan  No.";
//                             GenJournalLine."Posting Date" := LoanApps."Loan Disbursement Date";
//                             GenJournalLine.Description := 'Principal paid on offset for' + '' + LoanTopUp."Loan No." + '' + 'by loan' + LoanApps."Loan  No.";
//                             GenJournalLine."External Document No." := LoanApps."Loan  No.";
//                             GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
//                             GenJournalLine."Account No." := LoanApps."Client Code";
//                             GenJournalLine.Validate(GenJournalLine."Account No.");
//                             GenJournalLine.Amount := ROUND(LoanTopUp."Principle Top Up", 1, '=') * -1;
//                             GenJournalLine.Validate(GenJournalLine.Amount);
//                             GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Loan Repayment";
//                             GenJournalLine."Loan No" := LoanTopUp."Loan Top Up";
//                             GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
//                             GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Cashier Branch";
//                             GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
//                             GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
//                             if GenJournalLine.Amount <> 0 then
//                                 GenJournalLine.Insert;
//                             TopAmount := TopAmount + LoanTopUp."Principle Top Up";
//                             RunningBal := RunningBal - LoanTopUp."Principle Top Up";

//                             GenJournalLine.Init;
//                             LineNo := LineNo + 10000;
//                             if LoanType.Get(LoanApps."Loan Product Type") then begin
//                                 GenJournalLine."Journal Template Name" := Jtemplate;
//                                 GenJournalLine."Journal Batch Name" := JBatch;
//                                 GenJournalLine."Line No." := LineNo;
//                                 GenJournalLine."Line No." := LineNo;
//                                 GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
//                                 GenJournalLine."Account No." := LoanApps."Client Code";
//                                 GenJournalLine.Validate(GenJournalLine."Account No.");
//                                 GenJournalLine."Document No." := LoanApps."Loan  No.";
//                                 GenJournalLine."Posting Date" := LoanApps."Loan Disbursement Date";
//                                 GenJournalLine.Description := 'Interest Due Paid on top up by loan no' + LoanApps."Loan  No.";
//                                 GenJournalLine.Amount := ROUND(LoanTopUp."Interest Top Up", 1, '=') * -1;
//                                 GenJournalLine."External Document No." := LoanApps."Loan  No.";
//                                 GenJournalLine.Validate(GenJournalLine.Amount);
//                                 GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
//                                 GenJournalLine."Loan No" := LoanTopUp."Loan Top Up";
//                                 GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
//                                 GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
//                                 GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
//                                 if GenJournalLine.Amount <> 0 then
//                                     GenJournalLine.Insert;
//                                 //MESSAGE('Interest Top Up %1',LoanTopUp."Interest Top Up");
//                                 TopAmount := TopAmount + LoanTopUp."Interest Top Up";
//                                 RunningBal := RunningBal - LoanTopUp."Interest Top Up";
//                             end;

//                             //Levy On Bridging-------------------------------------------------------
//                             if LoanType.Get(LoanApps."Loan Product Type") then begin
//                                 GenJournalLine.Init;
//                                 LineNo := LineNo + 10000;
//                                 if LoanTopUp.Commision > 0 then begin
//                                     // MESSAGE('LoanApps."Loan  No."is %1|accont is %2',LoanApps."Loan  No.",LoanType."Top Up Commision Account");
//                                     //MESSAGE('ndani');
//                                     GenJournalLine."Journal Template Name" := Jtemplate;
//                                     ;
//                                     GenJournalLine."Journal Batch Name" := JBatch;
//                                     GenJournalLine."Line No." := LineNo;
//                                     GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
//                                     GenJournalLine."Account No." := LoanType."Top Up Commision Account";
//                                     GenJournalLine.Validate(GenJournalLine."Account No.");
//                                     GenJournalLine."Document No." := LoanApps."Loan  No.";
//                                     GenJournalLine."Posting Date" := LoanApps."Loan Disbursement Date";
//                                     GenJournalLine.Description := 'Top Up Commission' + LoanTopUp."Loan No." + '' + LoanApps."Client Code";
//                                     TopUpComm := LoanTopUp.Commision;
//                                     //MESSAGE('TopUpCommis %1|',TopUpComm);
//                                     //TotalTopupComm:=TotalTopupComm+TopUpComm;
//                                     GenJournalLine.Amount := ROUND(TopUpComm, 1, '=') * -1;
//                                     GenJournalLine."External Document No." := LoanApps."Loan  No.";
//                                     GenJournalLine.Validate(GenJournalLine.Amount);
//                                     // GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::Vendor;
//                                     //GenJournalLine."Bal. Account No.":=LoanApps."Account No";
//                                     //GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
//                                     GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
//                                     //GenJournalLine."Shortcut Dimension 2 Code":=LoanApps."Check Utility";
//                                     GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
//                                     GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
//                                     if GenJournalLine.Amount <> 0 then
//                                         GenJournalLine.Insert;
//                                     TopAmount := TopAmount + TopUpComm;
//                                     RunningBal := RunningBal - LoanTopUp.Commision;
//                                 end;
//                             end;
//                         until LoanTopUp.Next = 0;
//                     end;
//                     // MESSAGE('RunningBal is %1',RunningBal);
//                     //MESSAGE('2test is %1|%2',LoanApp."Loan  No.",LoanTopUp."Total Top Up");

//                 end;
//                 PTEN := '';
//                 if StrLen(LoanTopUp."Staff No") = 10 then begin
//                     PTEN := CopyStr(LoanTopUp."Staff No", 10);
//                 end else if StrLen(LoanTopUp."Staff No") = 9 then begin
//                     PTEN := CopyStr(LoanTopUp."Staff No", 9);
//                 end else if StrLen(LoanTopUp."Staff No") = 8 then begin
//                     PTEN := CopyStr(LoanTopUp."Staff No", 8);
//                 end else if StrLen(LoanTopUp."Staff No") = 7 then begin
//                     PTEN := CopyStr(LoanTopUp."Staff No", 7);
//                 end else if StrLen(LoanTopUp."Staff No") = 6 then begin
//                     PTEN := CopyStr(LoanTopUp."Staff No", 6);
//                 end else if StrLen(LoanTopUp."Staff No") = 5 then begin
//                     PTEN := CopyStr(LoanTopUp."Staff No", 5);
//                 end else if StrLen(LoanTopUp."Staff No") = 4 then begin
//                     PTEN := CopyStr(LoanTopUp."Staff No", 4);
//                 end else if StrLen(LoanTopUp."Staff No") = 3 then begin
//                     PTEN := CopyStr(LoanTopUp."Staff No", 3);
//                 end else if StrLen(LoanTopUp."Staff No") = 2 then begin
//                     PTEN := CopyStr(LoanTopUp."Staff No", 2);
//                 end else if StrLen(LoanTopUp."Staff No") = 1 then begin
//                     PTEN := CopyStr(LoanTopUp."Staff No", 1);
//                 end;
//                 if LoanTypes.Get(LoanTopUp."Loan Type") then begin
//                     if Customer.Get(LoanTopUp."Client Code") then begin
//                         DataSheet.Reset;
//                         DataSheet.SetRange(DataSheet."PF/Staff No", LoanApps."Staff No");
//                         DataSheet.SetRange(DataSheet."ID NO.", LoanApps."ID NO");
//                         DataSheet.SetRange(DataSheet.Date, LoanApps."Issued Date");
//                         DataSheet.SetRange(DataSheet."Remark/LoanNO", LoanTopUp."Loan Top Up");
//                         if DataSheet.Find('-') then begin
//                             DataSheet.Delete
//                         end;
//                         DataSheet.Reset;
//                         DataSheet.SetRange(DataSheet."PF/Staff No", LoanApps."Staff No");
//                         DataSheet.SetRange(DataSheet."ID NO.", LoanApps."ID NO");
//                         DataSheet.SetRange(DataSheet.Date, LoanApps."Issued Date");
//                         DataSheet.SetRange(DataSheet."Remark/LoanNO", LoanTopUp."Loan Top Up");
//                         if DataSheet.Find('-') then begin

//                             DataSheet.Init;
//                             DataSheet."PF/Staff No" := LoanTopUp."Staff No";
//                             DataSheet."Type of Deduction" := LoanTypes."Product Description";
//                             DataSheet."Remark/LoanNO" := LoanTopUp."Loan Top Up";
//                             DataSheet.Name := LoanApps."Client Code";
//                             DataSheet."ID NO." := LoanApps."ID NO";
//                             DataSheet."Amount ON" := 0;
//                             DataSheet."Amount OFF" := ROUND(LoanTopUp."Total Top Up", 1, '=');
//                             DataSheet."REF." := '2026';
//                             DataSheet."New Balance" := 0;
//                             DataSheet.Date := loans."Issued Date";
//                             DataSheet.Employer := Customer."Employer Code";
//                             DataSheet."Repayment Method" := Customer."Repayment Method";
//                             DataSheet."Transaction Type" := DataSheet."transaction type"::ADJUSTMENT;
//                             DataSheet."Sort Code" := PTEN;
//                             DataSheet.Insert;
//                         end;
//                     end;
//                 end;

//                 BatchTopUpAmount := 0;
//                 BatchTopUpComm := 0;
//                 BatchTopUpAmount := BatchTopUpAmount + LoanApps."Top Up Amount" + ROUND(LoanTopUp."Interest Top Up");
//                 BatchTopUpComm := BatchTopUpComm + TotalTopupComm;
//                 //check processing fee has issue
//                 TaxChargeAmount := 0;
//                 ProductChargesAmount1 := 0;
//                 ObjLoanProductCharges.Reset;
//                 ObjLoanProductCharges.SetRange(ObjLoanProductCharges."Product Code", LoanApps."Loan Product Type");
//                 ObjLoanProductCharges.SetFilter(ObjLoanProductCharges.Code, 'LPF');
//                 if ObjLoanProductCharges.Find('-') then begin
//                     PenaltyAccount := ObjLoanProductCharges."G/L Account";
//                     repeat
//                         LineNo := LineNo + 10000;
//                         GenJournalLine.Init;
//                         GenJournalLine."Journal Template Name" := Jtemplate;
//                         GenJournalLine."Journal Batch Name" := JBatch;
//                         GenJournalLine."Line No." := LineNo;
//                         GenJournalLine."Document No." := "Loan  No.";
//                         ;
//                         GenJournalLine."Posting Date" := "Posting Date";
//                         GenJournalLine."External Document No." := LoanApps."Loan  No.";
//                         GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
//                         GenJournalLine."Account No." := ObjLoanProductCharges."G/L Account";
//                         GenJournalLine.Validate(GenJournalLine."Account No.");
//                         GenJournalLine.Description := Format(ObjLoanProductCharges.Description + ' ' + LoanApps."Loan  No." + ' ' + LoanApps."Client Code");
//                         if ObjLoanProductCharges."Use Perc" then begin
//                             ProductChargesAmount1 := ProductChargesAmount1 + ((ObjLoanProductCharges.Percentage * LoanApps."Recommended Amount") / 100);
//                             //  MESSAGE('lpf is %1|recom is %2',ProductChargesAmount1,LoanApps."Recommended Amount");
//                             GenJournalLine.Amount := ROUND(ProductChargesAmount, 1, '=') * -1;
//                         end
//                         else begin
//                             ProductChargesAmount1 := ROUND((ProductChargesAmount1 + ObjLoanProductCharges.Amount));
//                             Message('lpf is %1', ProductChargesAmount1, 1, '=');

//                         end;
//                         if (ObjLoanProductCharges.Code = 'LPF') or (ObjLoanProductCharges.Code = 'LAP') then
//                             TaxChargeAmount := ROUND(ProductChargesAmount1, 1, '=') * (0.2);

//                         // MESSAGE('lpf is %1|taxamnt is %2',ProductChargesAmount1,TaxChargeAmount);

//                         if (LoanApps."Loan Product Type" = 'INSTANT') or (LoanApps."Loan Product Type" = 'KARIBU') then
//                             ProductChargesAmount1 := LoanApps."Loan Interest Repayment";
//                         GenJournalLine.Amount := (ROUND((ProductChargesAmount1 - TaxChargeAmount), 1, '=') * -1);
//                         // MESSAGE ('loan lpf is %1',GenJournalLine.Amount);
//                         GenJournalLine.Validate(GenJournalLine.Amount);
//                         GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
//                         GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Global Dimension 2 Code";
//                         if GenJournalLine.Amount <> 0 then
//                             GenJournalLine.Insert;
//                         // RunningBal:=RunningBal-ProductChargesAmount-ProductChargesAmount1;
//                         RunningBal := RunningBal - GenJournalLine.Amount;
//                     until ObjLoanProductCharges.Next = 0;
//                 end;

//                 TaxChargeAmount1 := 0;
//                 ProductChargesAmount2 := 0;
//                 ObjLoanProductCharges.Reset;
//                 ObjLoanProductCharges.SetRange(ObjLoanProductCharges."Product Code", LoanApps."Loan Product Type");
//                 ObjLoanProductCharges.SetFilter(ObjLoanProductCharges.Code, 'LAP');
//                 if ObjLoanProductCharges.Find('-') then begin
//                     PenaltyAccount := ObjLoanProductCharges."G/L Account";
//                     repeat
//                         LineNo := LineNo + 10000;
//                         GenJournalLine.Init;
//                         GenJournalLine."Journal Template Name" := Jtemplate;
//                         GenJournalLine."Journal Batch Name" := JBatch;
//                         GenJournalLine."Line No." := LineNo;
//                         GenJournalLine."Document No." := "Loan  No.";
//                         ;
//                         GenJournalLine."Posting Date" := "Posting Date";
//                         GenJournalLine."External Document No." := LoanApps."Loan  No.";
//                         GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
//                         GenJournalLine."Account No." := ObjLoanProductCharges."G/L Account";
//                         GenJournalLine.Validate(GenJournalLine."Account No.");
//                         GenJournalLine.Description := Format(ObjLoanProductCharges.Description + ' ' + LoanApps."Loan  No." + ' ' + LoanApps."Client Code");
//                         if ObjLoanProductCharges."Use Perc" then begin
//                             ProductChargesAmount2 := ProductChargesAmount2 + ((ObjLoanProductCharges.Percentage * LoanApps."Recommended Amount") / 100);
//                             GenJournalLine.Amount := ROUND(ProductChargesAmount2, 1, '=') * -1;
//                             //MESSAGE('test2lpf %1',ProductChargesAmount2);
//                         end
//                         else begin
//                             ProductChargesAmount2 := ProductChargesAmount2 + ObjLoanProductCharges.Amount;
//                         end;
//                         if (ObjLoanProductCharges.Code = 'LPF') or (ObjLoanProductCharges.Code = 'LAP') then
//                             TaxChargeAmount1 := (ProductChargesAmount2 * (0.2));

//                         if (LoanApps."Loan Product Type" = 'INSTANT') or (LoanApps."Loan Product Type" = 'KARIBU') then
//                             ProductChargesAmount2 := LoanApps."Loan Interest Repayment";
//                         GenJournalLine.Amount := (ROUND((ProductChargesAmount2 - TaxChargeAmount1), 1, '=') * -1);
//                         GenJournalLine.Validate(GenJournalLine.Amount);
//                         GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
//                         GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Global Dimension 2 Code";
//                         if GenJournalLine.Amount <> 0 then
//                             GenJournalLine.Insert;
//                         // RunningBal:=RunningBal-ProductChargesAmount2;
//                         RunningBal := RunningBal - GenJournalLine.Amount;

//                     until ObjLoanProductCharges.Next = 0;
//                 end;
//                 // MESSAGE('lpf is %1',ProductChargesAmount2);

//                 //end processing fee
//                 //jo
//                 TaxChargeAmount2 := 0;
//                 ObjLoanProductCharges.Reset;
//                 ObjLoanProductCharges.SetRange(ObjLoanProductCharges."Product Code", LoanApps."Loan Product Type");
//                 ObjLoanProductCharges.SetFilter(ObjLoanProductCharges.Code, 'LAP');
//                 ObjLoanProductCharges.SetFilter(ObjLoanProductCharges.Code, 'LPF');
//                 if ObjLoanProductCharges.Find('-') then begin
//                     TaxChargeAmount2 := ((ProductChargesAmount1 + ProductChargesAmount2) * (0.2));
//                     //MESSAGE('%1|%2|%3',TaxChargeAmount2,ProductChargesAmount2,ProductChargesAmount1);
//                     repeat
//                         LineNo := LineNo + 10000;
//                         GenJournalLine.Init;
//                         GenJournalLine."Journal Template Name" := Jtemplate;
//                         GenJournalLine."Journal Batch Name" := JBatch;
//                         GenJournalLine."Line No." := LineNo;
//                         GenJournalLine."Document No." := "Loan  No.";
//                         ;
//                         GenJournalLine."Posting Date" := "Posting Date";
//                         GenJournalLine."External Document No." := LoanApps."Loan  No.";
//                         GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
//                         GenJournalLine."Account No." := ObjLoanProductCharges."TAXE G/L ACCOUNT";
//                         GenJournalLine.Validate(GenJournalLine."Account No.");

//                         GenJournalLine.Description := Format('Tax Processing Fee' + ' ' + LoanApps."Loan  No." + ' ' + LoanApps."Client Code");
//                         GenJournalLine.Amount := ROUND(TaxChargeAmount2, 1, '=') * -1;
//                         GenJournalLine.Validate(GenJournalLine.Amount);
//                         GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
//                         GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Global Dimension 2 Code";
//                         if GenJournalLine.Amount <> 0 then
//                             GenJournalLine.Insert;
//                         // RunningBal:=RunningBal-TaxChargeAmount2;
//                         RunningBal := RunningBal - GenJournalLine.Amount;
//                     until ObjLoanProductCharges.Next = 0;
//                 end;
//                 //
//                 ///***********************************************************************************************
//                 if "Product Type" = "product type"::Tank then begin
//                     TaxChargeAmount := 0;
//                     ProductChargesAmount1 := 0;
//                     ProductChargesAmount := 0;
//                     ObjLoanProductCharges.Reset;
//                     ObjLoanProductCharges.SetRange(ObjLoanProductCharges."Product Code", LoanApps."Loan Product Type");
//                     ObjLoanProductCharges.SetFilter(ObjLoanProductCharges.Code, 'TANK');
//                     if ObjLoanProductCharges.Find('-') then begin
//                         repeat
//                             LineNo := LineNo + 10000;
//                             GenJournalLine.Init;
//                             GenJournalLine."Journal Template Name" := Jtemplate;
//                             GenJournalLine."Journal Batch Name" := JBatch;
//                             GenJournalLine."Line No." := LineNo;
//                             GenJournalLine."Document No." := "Loan  No.";
//                             ;
//                             GenJournalLine."Posting Date" := "Posting Date";
//                             GenJournalLine."External Document No." := LoanApps."Loan  No.";
//                             GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";

//                             PenaltyAccount := ObjLoanProductCharges."G/L Account";
//                             GenJournalLine."Account No." := PenaltyAccount;//'101219';
//                             GenJournalLine.Description := Format(ObjLoanProductCharges.Description + ' ' + LoanApps."Loan  No." + ' ' + LoanApps."Client Code");
//                             ProductChargesAmount1 := ((ObjLoanProductCharges.Percentage * LoanApps."Recommended Amount") / 100);
//                             GenJournalLine.Amount := ROUND(ProductChargesAmount1, 1, '=') * -1;
//                             GenJournalLine.Validate(GenJournalLine.Amount);
//                             GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
//                             GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Global Dimension 2 Code";
//                             if GenJournalLine.Amount <> 0 then
//                                 GenJournalLine.Insert;
//                             RunningBal := RunningBal - GenJournalLine.Amount;
//                         until ObjLoanProductCharges.Next = 0;
//                     end;
//                 end;
//                 //..
//                 if "Product Type" = "product type"::Mattress then begin
//                     TaxChargeAmount := 0;
//                     ProductChargesAmount1 := 0;
//                     ProductChargesAmount := 0;
//                     ObjLoanProductCharges.Reset;
//                     ObjLoanProductCharges.SetRange(ObjLoanProductCharges."Product Code", LoanApps."Loan Product Type");
//                     ObjLoanProductCharges.SetFilter(ObjLoanProductCharges.Code, 'MATTRESS');
//                     if ObjLoanProductCharges.Find('-') then begin
//                         repeat
//                             LineNo := LineNo + 10000;
//                             GenJournalLine.Init;
//                             GenJournalLine."Journal Template Name" := Jtemplate;
//                             GenJournalLine."Journal Batch Name" := JBatch;
//                             GenJournalLine."Line No." := LineNo;
//                             GenJournalLine."Document No." := "Loan  No.";
//                             ;
//                             GenJournalLine."Posting Date" := "Posting Date";
//                             GenJournalLine."External Document No." := LoanApps."Loan  No.";
//                             GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
//                             PenaltyAccount := ObjLoanProductCharges."G/L Account";
//                             GenJournalLine."Account No." := PenaltyAccount;
//                             ProductChargesAmount1 := ((ObjLoanProductCharges.Percentage * LoanApps."Recommended Amount") / 100);
//                             GenJournalLine.Amount := ROUND(ProductChargesAmount1, 1, '=') * -1;
//                             GenJournalLine.Validate(GenJournalLine.Amount);
//                             GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
//                             GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Global Dimension 2 Code";
//                             if GenJournalLine.Amount <> 0 then
//                                 GenJournalLine.Insert;
//                             RunningBal := RunningBal - GenJournalLine.Amount;
//                         until ObjLoanProductCharges.Next = 0;
//                     end;
//                 end;
//                 //MESSAGE('lpf is %1|....account com is %2',ProductChargesAmount1,PenaltyAccount);



//                 //*****************************************************************************************************


//                 //Boosting Shares Commision
//                 GenSetUp.Get();
//                 if LoanApps."Boosting Commision" > 0 then begin
//                     LineNo := LineNo + 10000;

//                     GenJournalLine.Init;
//                     GenJournalLine."Journal Template Name" := Jtemplate;
//                     GenJournalLine."Journal Batch Name" := JBatch;
//                     GenJournalLine."Line No." := LineNo;
//                     GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
//                     GenJournalLine."Account No." := GenSetUp."Boosting Fees Account";
//                     GenJournalLine.Validate(GenJournalLine."Account No.");
//                     GenJournalLine."Document No." := "Loan  No.";
//                     GenJournalLine."External Document No." := LoanApps."Loan  No.";
//                     GenJournalLine."Posting Date" := "Posting Date";
//                     GenJournalLine.Description := 'Boosting Commision' + LoanApps."Loan  No." + ' ' + LoanApps."Client Code";
//                     GenJournalLine.Amount := ROUND(LoanApps."Boosting Commision") * -1;
//                     GenJournalLine.Validate(GenJournalLine.Amount);
//                     Deductions += ROUND(GenJournalLine.Amount, 1, '=');
//                     GenJournalLine."Loan No" := LoanApps."Loan  No.";
//                     GenJournalLine.Validate(GenJournalLine.Amount);
//                     GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
//                     GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Global Dimension 2 Code";
//                     GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
//                     GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
//                     if GenJournalLine.Amount <> 0 then
//                         GenJournalLine.Insert;
//                     //  RunningBal:=RunningBal-LoanApps."Boosting Commision";
//                     RunningBal := RunningBal - GenJournalLine.Amount;

//                     //Boost Member Deposits
//                     LineNo := LineNo + 10000;

//                     GenJournalLine.Init;
//                     GenJournalLine."Journal Template Name" := Jtemplate;
//                     GenJournalLine."Journal Batch Name" := JBatch;
//                     GenJournalLine."Line No." := LineNo;
//                     GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
//                     GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Deposit Contribution";
//                     GenJournalLine."Account No." := LoanApps."Client Code";
//                     GenJournalLine.Validate(GenJournalLine."Account No.");
//                     GenJournalLine."Document No." := "Loan  No.";
//                     GenJournalLine."External Document No." := LoanApps."Loan  No.";
//                     GenJournalLine."Posting Date" := "Posting Date";
//                     GenJournalLine.Description := 'Deposit Boosting ' + LoanApps."Loan  No." + ' ' + LoanApps."Client Code";
//                     GenJournalLine.Amount := ROUND(LoanApps."Boosted Amount", 1, '=') * -1;
//                     GenJournalLine.Validate(GenJournalLine.Amount);
//                     Deductions += ROUND(GenJournalLine.Amount, 1, '=');
//                     GenJournalLine."Loan No" := LoanApps."Loan  No.";
//                     GenJournalLine.Validate(GenJournalLine.Amount);
//                     GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
//                     GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Global Dimension 2 Code";
//                     GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
//                     GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
//                     if GenJournalLine.Amount <> 0 then
//                         GenJournalLine.Insert;
//                     //  RunningBal:=RunningBal-LoanApps."Boosted Amount";
//                     RunningBal := RunningBal - GenJournalLine.Amount;
//                 end;
//                 //Lumpsum amount Charge
//                 if LoanApps."Lumpsum Amount Charge" > 0 then begin
//                     LineNo := LineNo + 10000;
//                     GenJournalLine.Init;
//                     GenJournalLine."Journal Template Name" := Jtemplate;
//                     GenJournalLine."Journal Batch Name" := JBatch;
//                     GenJournalLine."Line No." := LineNo;
//                     GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
//                     GenJournalLine."Account No." := GenSetUp."Boosting Fees Account";
//                     GenJournalLine.Validate(GenJournalLine."Account No.");
//                     GenJournalLine."Document No." := "Loan  No.";
//                     GenJournalLine."External Document No." := LoanApps."Loan  No.";
//                     GenJournalLine."Posting Date" := "Posting Date";
//                     GenJournalLine.Description := 'Boosting Commision' + LoanApps."Loan  No." + ' ' + LoanApps."Client Code";
//                     GenJournalLine.Amount := ROUND(LoanApps."Lumpsum Amount Charge", 1, '=') * -1;
//                     GenJournalLine.Validate(GenJournalLine.Amount);
//                     Deductions += ROUND(GenJournalLine.Amount, 1, '=');
//                     GenJournalLine."Loan No" := LoanApps."Loan  No.";
//                     GenJournalLine.Validate(GenJournalLine.Amount);
//                     GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
//                     GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Global Dimension 2 Code";
//                     GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
//                     GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
//                     if GenJournalLine.Amount <> 0 then
//                         GenJournalLine.Insert;
//                     RunningBal := RunningBal - GenJournalLine.Amount;

//                     // RunningBal:=RunningBal-LoanApps."Lumpsum Amount Charge";
//                 end;

//                 //Penalty amount Charge
//                 if LoanApps."Penalty Amount" > 0 then begin
//                     LineNo := LineNo + 10000;

//                     GenJournalLine.Init;
//                     GenJournalLine."Journal Template Name" := Jtemplate;
//                     GenJournalLine."Journal Batch Name" := JBatch;
//                     GenJournalLine."Line No." := LineNo;
//                     GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
//                     GenJournalLine."Account No." := PenaltyAccount;
//                     GenJournalLine.Validate(GenJournalLine."Account No.");
//                     GenJournalLine."Document No." := "Loan  No.";
//                     GenJournalLine."External Document No." := LoanApps."Loan  No.";
//                     GenJournalLine."Posting Date" := "Posting Date";
//                     GenJournalLine.Description := 'Penalty charged' + LoanApps."Loan  No." + ' ' + LoanApps."Client Code";
//                     GenJournalLine.Amount := ROUND(LoanApps."Penalty Amount", 1, '=') * -1;
//                     GenJournalLine.Validate(GenJournalLine.Amount);
//                     Deductions += ROUND(GenJournalLine.Amount, 1, '=');
//                     GenJournalLine."Loan No" := LoanApps."Loan  No.";
//                     GenJournalLine.Validate(GenJournalLine.Amount);
//                     GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
//                     GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Global Dimension 2 Code";
//                     GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
//                     //Loaninsurance:=0;
//                     RunningBal := RunningBal - GenJournalLine.Amount;

//                     LineNo := LineNo + 10000;
//                     GenJournalLine.Init;
//                     GenJournalLine."Journal Template Name" := Jtemplate;
//                     GenJournalLine."Journal Batch Name" := JBatch;
//                     GenJournalLine."Line No." := LineNo;
//                     GenJournalLine."Document No." := "Loan  No.";
//                     GenJournalLine."Posting Date" := "Posting Date";
//                     GenJournalLine."External Document No." := LoanApps."Loan  No.";
//                     if (LoanApps."Loan Product Type" = 'INSTANT') or (LoanApps."Loan Product Type" = 'KARIBU') or LoanApps."Insurance Upfront" then begin
//                         GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
//                         GenJournalLine."Account No." := InsuranceIncomeAcc;
//                         GenJournalLine.Amount := ROUND(LoanApps.Insurance, 1, '=') * -1;
//                         GenJournalLine.Description := 'Loan Insurance Paid- ' + LoanApps."Loan  No." + ' ' + LoanApps."Client Code";
//                     end else begin
//                         GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
//                         GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Loan Insurance Charged";
//                         GenJournalLine."Account No." := LoanApps."Client Code";
//                         GenJournalLine.Amount := ROUND(LoanApps.Insurance, 1, '=');
//                         GenJournalLine.Description := 'Loan Insurance charged- ' + LoanApps."Loan  No." + ' ' + LoanApps."Client Code";
//                         GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
//                         GenJournalLine."Bal. Account No." := InsuranceAcc;
//                         GenJournalLine.Validate("Bal. Account No.");
//                     end;
//                     GenJournalLine.Validate(GenJournalLine."Account No.");
//                     GenJournalLine.Validate(GenJournalLine.Amount);
//                     Deductions += GenJournalLine.Amount;
//                     GenJournalLine."Loan No" := LoanApps."Loan  No.";
//                     GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
//                     GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Cashier Branch";
//                     if GenJournalLine.Amount <> 0 then
//                         GenJournalLine.Insert;
//                     //  RunningBal:=RunningBal-LoanApps.Insurance;
//                     RunningBal := RunningBal - GenJournalLine.Amount;

//                 end;
//                 //*************************************************
//                 GenJournalLine.Init;
//                 LineNo := LineNo + 10000;
//                 GenJournalLine."Journal Template Name" := Jtemplate;
//                 GenJournalLine."Journal Batch Name" := JBatch;
//                 GenJournalLine."Line No." := LineNo;
//                 GenJournalLine."Document No." := "Loan  No.";
//                 GenJournalLine."Posting Date" := "Posting Date";
//                 GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
//                 GenJournalLine.Validate(GenJournalLine."Account Type");
//                 GenJournalLine."Account No." := LoanApps."Client Code";
//                 GenJournalLine.Validate(GenJournalLine."Account No.");
//                 GenJournalLine.Description := LoanApps."Loan  No." + ' ' + 'MNO ' + LoanApps."Client Code" + ' ' + LoanApps."Employer Code";
//                 GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
//                 GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Cashier Branch";
//                 GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Loan;
//                 GenJournalLine."Loan No" := LoanApps."Loan  No.";
//                 GenJournalLine."External Document No." := LoanApps."Loan  No.";
//                 GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
//                 GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
//                 GenJournalLine.Amount := ROUND(LoanApps."Approved Amount", 1, '=');
//                 GenJournalLine.Validate(GenJournalLine.Amount);
//                 if GenJournalLine.Amount <> 0 then
//                     GenJournalLine.Insert;
//                 RunningBal := RunningBal - GenJournalLine.Amount;

//                 // MESSAGE('amont is %1',RunningBal);

//                 GenSetUp.Get;
//                 GenJournalLine.Init;
//                 LineNo := LineNo + 10000;
//                 GenJournalLine."Journal Template Name" := Jtemplate;
//                 GenJournalLine."Journal Batch Name" := JBatch;
//                 GenJournalLine."Line No." := LineNo;
//                 GenJournalLine."Document No." := "Loan  No.";
//                 GenJournalLine."Posting Date" := "Posting Date";
//                 LoanApps.Reset;
//                 LoanApps.SetRange(LoanApps."Loan  No.", "Loan  No.");
//                 if LoanApps.FindFirst then begin
//                     if LoanApps."Loan Product Type" <> '21' then begin
//                         if (LoanApps."Disburesment Type" = LoanApps."disburesment type"::"Full/Single disbursement") then
//                             GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
//                         GenJournalLine."Account No." := "Paying Bank Account No";
//                         GenJournalLine.Validate(GenJournalLine."Account No.");
//                         //GenJournalLine.Amount:=ROUND(LoanApps."Loan Disbursed Amount",1,'=')*-1;
//                         GenJournalLine.Amount := LoanApps."Loan Disbursed Amount" * -1;
//                     end;
//                     if LoanApps."Disburesment Type" = LoanApps."disburesment type"::"Tranche/Multiple Disbursement" then begin
//                         GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
//                         GenJournalLine.Validate(GenJournalLine."Account No.");
//                         GenJournalLine."Account No." := '201209';
//                         GenJournalLine.Validate(GenJournalLine."Account No.");
//                         // GenJournalLine.Amount:=ROUND(LoanApps."Loan Disbursed Amount",1,'=')*-1;
//                         GenJournalLine.Amount := LoanApps."Loan Disbursed Amount" * -1;

//                     end;
//                     if LoanApps."Loan Product Type" = '21' then begin
//                         GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
//                         GenJournalLine.Validate(GenJournalLine."Account No.");
//                         GenJournalLine."Account No." := '101053';
//                         // GenJournalLine.Amount:=ROUND(LoanApps."Loan Disbursed Amount",1,'=')*-1;
//                         GenJournalLine.Amount := (LoanApps."Loan Disbursed Amount") * -1;

//                     end;
//                     if LoanApps."Loan Product Type" = '26' then begin
//                         GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
//                         GenJournalLine.Validate(GenJournalLine."Account No.");
//                         GenJournalLine."Account No." := '201215';
//                         //GenJournalLine.Amount:=ROUND(LoanApps."Loan Disbursed Amount"-ProductChargesAmount1,1,'=')*-1;
//                         GenJournalLine.Amount := (LoanApps."Loan Disbursed Amount" - ProductChargesAmount1) * -1;
//                     end;
//                     // END;
//                     GenJournalLine.Validate(GenJournalLine."Account No.");
//                     GenJournalLine.Description := 'loan For :-' + LoanApps."Client Code" + ' ' + LoanApps."Client Name" + ' ' + LoanApps."Loan  No.";
//                     GenJournalLine.Validate(GenJournalLine.Amount);
//                     GenJournalLine."External Document No." := LoanApps."Loan  No.";
//                     GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
//                     GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Cashier Branch";
//                     GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
//                     GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
//                     if GenJournalLine.Amount <> 0 then
//                         GenJournalLine.Insert;
//                     RunningBal := RunningBal - GenJournalLine.Amount;
//                     // MESSAGE('GenJournalLine.Amount is %1',GenJournalLine.Amount);

//                 end;
//                 //EXIT;//Abel 2030
//                 KNFactory.FnSendSMS('LOANS', 'Dear ' + Format(LoanApps."Client Name") + ' we have disbursed ksh ' + Format(LoanApps."Approved Amount") + ' of your ' + Format(LoanApps."Loan Product Type Name") + ' Start repayment Date '
//                                                   + Format(LoanApps."Repayment Start Date") + ' ',
//                                                  LoanApps."Client Code", KNFactory.KnGetMemberPhoneNo(LoanApps."Client Code"));

//             end;
//             Commit;
//             //ERROR('Dont Post');
//             //cj

//             LnPP.Reset;
//             LnPP.SetRange(LnPP."Loan  No.", LoanApps."Loan  No.");
//             if LnPP.Find('-') then begin
//                 Report.Run(51516412, true, false, LnPP);
//                 //REPORT.RUN( 51516049,TRUE,FALSE,LnPP);51516081
//                 //  REPORT.RUN(51516477,TRUE,FALSE,LnPP);
//                 Report.Run(51516081, true, false, LnPP);

//             end;

//             /////****************************************************

//             LoansGuaranteeDetails.Reset;
//             LoansGuaranteeDetails.SetRange(LoansGuaranteeDetails."Loan No", "Loan  No.");
//             if LoansGuaranteeDetails.Find('-') then begin
//                 repeat
//                     LoansGuaranteeDetails."Application Statu" := false;
//                     LoansGuaranteeDetails.Posted := true;
//                     LoansGuaranteeDetails.Modify;
//                 until LoansGuaranteeDetails.Next = 0;
//             end;
//             /// to check
//             LoanApps."Issued Date" := "Loan Disbursement Date";
//             LoanApps."Loan Status" := "loan status"::Issued;
//             LoanApps."Amount Disbursed" := "Amount To Disburse";
//             LoanApps."Processed Payment" := true;
//             LoanApps.Posted := true;
//             LoanApps.Modify;

//         end;

//         // // // //    //**************************************************************************************post

//         GenJournalLine.Reset;
//         GenJournalLine.SetRange("Journal Template Name", Jtemplate);
//         GenJournalLine.SetRange("Journal Batch Name", JBatch);
//         if GenJournalLine.Find('-') then begin
//             Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
//         end;


//     end;
// }

