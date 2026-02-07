// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Page 56046 "Loan Reschedule Card"
// {
//     DeleteAllowed = false;
//     PageType = Card;
//     PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
//     SourceTable = "Loans Register";
//     SourceTableView = where(Posted = const(false));

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
//                         Rec.TestField(Posted, false);
//                     end;
//                 }
//                 field("Loan Product Type"; Rec."Loan Product Type")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field(Installments; Rec.Installments)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = InstallmentEditable;

//                     trigger OnValidate()
//                     begin
//                         Rec.TestField(Posted, false);
//                     end;
//                 }
//                 field(Interest; Rec.Interest)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Reason For Loan Reschedule"; Rec."Reason For Loan Reschedule")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Requested Amount"; Rec."Requested Amount")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Amount Applied';
//                     Editable = false;

//                     trigger OnValidate()
//                     begin
//                         Rec.TestField(Posted, false);
//                     end;
//                 }
//                 field("Recommended Amount"; Rec."Recommended Amount")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Qualifying Amount';
//                     Editable = false;
//                 }
//                 field("Approved Amount"; Rec."Approved Amount")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Approved Amount';
//                     Editable = false;

//                     trigger OnValidate()
//                     begin
//                         Rec.TestField(Posted, false);
//                     end;
//                 }
//                 field("Loan Purpose"; Rec."Loan Purpose")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = true;
//                     Visible = true;
//                 }
//                 field(Remarks; Rec.Remarks)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = true;
//                     Visible = true;
//                 }
//                 field("Repayment Method"; Rec."Repayment Method")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field(Repayment; Rec.Repayment)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = RepaymentEditable;
//                 }
//                 field("Approved Repayment"; Rec."Approved Repayment")
//                 {
//                     ApplicationArea = Basic;
//                     Visible = false;
//                 }
//                 field("Loan Status"; Rec."Loan Status")
//                 {
//                     ApplicationArea = Basic;

//                     trigger OnValidate()
//                     begin
//                         UpdateControl();
//                     end;
//                 }
//                 field("Batch No."; Rec."Batch No.")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Captured By"; Rec."Captured By")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Top Up Amount"; Rec."Top Up Amount")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Top Up Amount';
//                 }
//                 field("Total TopUp Commission"; Rec."Total TopUp Commission")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Total TopUp Interest';
//                 }
//                 field("Repayment Frequency"; Rec."Repayment Frequency")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = RepayFrequencyEditable;
//                 }
//                 field("Mode of Disbursement"; Rec."Mode of Disbursement")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = ModeofDisburesmentEdit;
//                 }
//                 field("Loan Rescheduled By"; Rec."Loan Rescheduled By")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Loan Rescheduled Date"; Rec."Loan Rescheduled Date")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Loan Disbursement Date"; Rec."Loan Disbursement Date")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = true;
//                 }
//                 field("Cheque No."; Rec."Cheque No.")
//                 {
//                     ApplicationArea = Basic;
//                     Visible = true;

//                     trigger OnValidate()
//                     begin
//                         if StrLen(Rec."Cheque No.") > 6 then
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
//                 field(Posted; Rec.Posted)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field("Approval Status"; Rec."Approval Status")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                     Visible = true;
//                 }
//                 field("Rejection  Remark"; Rec."Rejection  Remark")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = RejectionRemarkEditable;
//                 }
//             }
//             part(Control1000000004; "Loans Guarantee Details")
//             {
//                 Caption = 'Guarantors  Detail';
//                 SubPageLink = "Loan No" = field("Loan  No.");
//             }
//             part(Control1000000005; "Loan Collateral Security")
//             {
//                 Caption = 'Other Securities';
//                 SubPageLink = "Loan No" = field("Loan  No.");
//             }
//         }
//         area(factboxes)
//         {
//             part(Control1000000010; "Member Statistics FactBox")
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
//                 Caption = 'Loan';
//                 Image = AnalysisView;
//                 action("Member Statement")
//                 {
//                     ApplicationArea = Basic;
//                     Promoted = true;
//                     PromotedCategory = "Report";

//                     trigger OnAction()
//                     begin
//                         Cust.Reset;
//                         Cust.SetRange(Cust."No.", Rec."Client Code");
//                         Report.Run(50223, true, false, Cust);
//                     end;
//                 }
//                 separator(Action1102760046)
//                 {
//                 }
//                 action("View Schedule")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'View Schedule';
//                     Image = ViewDetails;
//                     Promoted = true;
//                     PromotedCategory = "Report";
//                     ShortCutKey = 'Ctrl+F7';

//                     trigger OnAction()
//                     begin
//                         if Rec."Repayment Frequency" = Rec."repayment frequency"::Daily then
//                             Evaluate(InPeriod, '1D')
//                         else
//                             if Rec."Repayment Frequency" = Rec."repayment frequency"::Weekly then
//                                 Evaluate(InPeriod, '1W')
//                             else
//                                 if Rec."Repayment Frequency" = Rec."repayment frequency"::Monthly then
//                                     Evaluate(InPeriod, '1M')
//                                 else
//                                     if Rec."Repayment Frequency" = Rec."repayment frequency"::Quaterly then
//                                         Evaluate(InPeriod, '1Q');


//                         QCounter := 0;
//                         QCounter := 3;
//                         //EVALUATE(InPeriod,'1D');
//                         GrPrinciple := Rec."Grace Period - Principle (M)";
//                         GrInterest := Rec."Grace Period - Interest (M)";
//                         InitialGraceInt := Rec."Grace Period - Interest (M)";

//                         LoansR.Reset;
//                         LoansR.SetRange(LoansR."Loan  No.", Rec."Loan  No.");
//                         if LoansR.Find('-') then begin

//                             Rec.TestField("Loan Disbursement Date");
//                             Rec.TestField("Repayment Start Date");

//                             RSchedule.Reset;
//                             RSchedule.SetRange(RSchedule."Loan No.", Rec."Loan  No.");
//                             RSchedule.DeleteAll;

//                             LoanAmount := LoansR."Approved Amount";
//                             InterestRate := LoansR.Interest;
//                             RepayPeriod := LoansR.Installments;
//                             InitialInstal := LoansR.Installments + Rec."Grace Period - Principle (M)";
//                             LBalance := LoansR."Approved Amount";
//                             LNBalance := LoansR."Outstanding Balance";
//                             RunDate := Rec."Repayment Start Date";

//                             InstalNo := 0;
//                             Evaluate(RepayInterval, '1W');

//                             //Repayment Frequency
//                             if Rec."Repayment Frequency" = Rec."repayment frequency"::Daily then
//                                 RunDate := CalcDate('-1D', RunDate)
//                             else
//                                 if Rec."Repayment Frequency" = Rec."repayment frequency"::Weekly then
//                                     RunDate := CalcDate('-1W', RunDate)
//                                 else
//                                     if Rec."Repayment Frequency" = Rec."repayment frequency"::Monthly then
//                                         RunDate := CalcDate('-1M', RunDate)
//                                     else
//                                         if Rec."Repayment Frequency" = Rec."repayment frequency"::Quaterly then
//                                             RunDate := CalcDate('-1Q', RunDate);
//                             //Repayment Frequency


//                             repeat
//                                 InstalNo := InstalNo + 1;


//                                 //*************Repayment Frequency***********************//
//                                 if Rec."Repayment Frequency" = Rec."repayment frequency"::Daily then
//                                     RunDate := CalcDate('1D', RunDate)
//                                 else
//                                     if Rec."Repayment Frequency" = Rec."repayment frequency"::Weekly then
//                                         RunDate := CalcDate('1W', RunDate)
//                                     else
//                                         if Rec."Repayment Frequency" = Rec."repayment frequency"::Monthly then
//                                             RunDate := CalcDate('1M', RunDate)
//                                         else
//                                             if Rec."Repayment Frequency" = Rec."repayment frequency"::Quaterly then
//                                                 RunDate := CalcDate('1Q', RunDate);






//                                 //*******************If Amortised****************************//
//                                 if Rec."Repayment Method" = Rec."repayment method"::Amortised then begin
//                                     Rec.TestField(Installments);
//                                     Rec.TestField(Interest);
//                                     Rec.TestField(Installments);
//                                     TotalMRepay := ROUND((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -RepayPeriod)) * LoanAmount, 1, '>');
//                                     TotalMRepay := (InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -RepayPeriod)) * LoanAmount;
//                                     LInterest := ROUND(LBalance / 100 / 12 * InterestRate);

//                                     LPrincipal := TotalMRepay - LInterest;
//                                 end;



//                                 if Rec."Repayment Method" = Rec."repayment method"::"Straight Line" then begin
//                                     Rec.TestField(Installments);
//                                     LPrincipal := ROUND(LoanAmount / RepayPeriod, 1, '>');
//                                     if (Rec."Loan Product Type" = 'INST') or (Rec."Loan Product Type" = 'MAZAO') then begin
//                                         LInterest := 0;
//                                     end else begin
//                                         LInterest := ROUND((InterestRate / 100) * LoanAmount, 1, '>');
//                                     end;

//                                     Rec.Repayment := LPrincipal + LInterest;
//                                     Rec."Loan Principle Repayment" := LPrincipal;
//                                     Rec."Loan Interest Repayment" := LInterest;
//                                 end;


//                                 if Rec."Repayment Method" = Rec."repayment method"::"Reducing Balance" then begin
//                                     Rec.TestField(Interest);
//                                     Rec.TestField(Installments);
//                                     LPrincipal := ROUND(LoanAmount / RepayPeriod, 1, '>');
//                                     LInterest := ROUND((InterestRate / 12 / 100) * LBalance, 1, '>');
//                                 end;

//                                 if Rec."Repayment Method" = Rec."repayment method"::Constants then begin
//                                     Rec.TestField(Repayment);
//                                     if LBalance < Rec.Repayment then
//                                         LPrincipal := LBalance
//                                     else
//                                         LPrincipal := Rec.Repayment;
//                                     LInterest := Rec.Interest;
//                                 end;


//                                 //Grace Period
//                                 if GrPrinciple > 0 then begin
//                                     LPrincipal := 0
//                                 end else begin
//                                     if Rec."Instalment Period" <> InPeriod then
//                                         LBalance := LBalance - LPrincipal;

//                                 end;

//                                 if GrInterest > 0 then
//                                     LInterest := 0;

//                                 GrPrinciple := GrPrinciple - 1;
//                                 GrInterest := GrInterest - 1;

//                                 //Grace Period
//                                 RSchedule.Init;
//                                 RSchedule."Repayment Code" := RepayCode;
//                                 RSchedule."Loan No." := Rec."Loan  No.";
//                                 RSchedule."Loan Amount" := LoanAmount;
//                                 RSchedule."Instalment No" := InstalNo;
//                                 RSchedule."Repayment Date" := RunDate;
//                                 RSchedule."Member No." := Rec."Client Code";
//                                 RSchedule."Loan Category" := Rec."Loan Product Type";
//                                 RSchedule."Monthly Repayment" := LInterest + LPrincipal;
//                                 RSchedule."Monthly Interest" := LInterest;
//                                 RSchedule."Principal Repayment" := LPrincipal;
//                                 RSchedule.Insert;
//                                 WhichDay := Date2dwy(RSchedule."Repayment Date", 1);


//                             until LBalance < 1

//                         end;

//                         Commit;

//                         LoanApp.Reset;
//                         LoanApp.SetRange(LoanApp."Loan  No.", Rec."Loan  No.");
//                         if LoanApp.Find('-') then
//                             if LoanApp."Loan Product Type" <> 'INST' then begin
//                                 Report.Run(50477, true, false, LoanApp);
//                             end else begin
//                                 Report.Run(50477, true, false, LoanApp);
//                             end;
//                     end;
//                 }
//                 separator(Action1102755012)
//                 {
//                 }
//                 action("Loans to Offset")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Loans to Offset';
//                     Image = AddAction;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     RunObject = Page "Loan Offset Detail List";
//                     RunPageLink = "Loan No." = field("Loan  No."),
//                                   "Client Code" = field("Client Code");
//                 }
//                 separator(Action1102760039)
//                 {
//                 }
//                 action("Post Loan")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Reschedule Loan';
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     Visible = true;

//                     trigger OnAction()
//                     begin
//                         if Rec."Approval Status" <> Rec."approval status"::Approved then begin
//                             //     Error('You Can not post a loan that is not fully Approved')
//                         end else
//                             if Confirm('Are you Sure you want to reschedule this Loan', false) = true then begin
//                                 TemplateName := 'PAYMENTS';
//                                 BatchName := 'LOANS';


//                                 LoanApps.Reset;
//                                 LoanApps.SetRange(LoanApps."Loan  No.", Rec."Loan  No.");
//                                 if LoanApps.FindSet then begin
//                                     FnInsertBOSALines(LoanApps, LoanApps."Loan  No.");


//                                     //Post
//                                     GenJournalLine.Reset;
//                                     GenJournalLine.SetRange("Journal Template Name", 'PAYMENTS');
//                                     GenJournalLine.SetRange("Journal Batch Name", 'LOANS');
//                                     if GenJournalLine.Find('-') then begin
//                                         Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
//                                     end;

//                                     Rec.Posted := true;
//                                     Rec."Loan Status" := Rec."loan status"::Issued;
//                                     Rec."Approval Status" := Rec."approval status"::Approved;
//                                     Rec.Modify;

//                                     //Post New

//                                     Rec."Loan Rescheduled Date" := Rec."Loan Disbursement Date";
//                                     Rec."Loan Rescheduled By" := UserId;
//                                     Rec."Loan Reschedule" := true;
//                                     Rec.Modify;
//                                     Message('Loan Rescheduled successfully.');

//                                 end else begin
//                                     exit;
//                                 end;
//                             end;

//                     end;
//                 }
//                 group("More details")
//                 {
//                 }
//                 action("Salary Details")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Salary Details';
//                     Enabled = true;
//                     Image = StatisticsGroup;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     RunObject = Page "Loan Appraisal Salary Details";
//                     RunPageLink = "Loan No" = field("Loan  No."),
//                                   "Client Code" = field("Client Code");
//                     Visible = true;
//                 }
//                 action(Guarantors)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Guarantors';
//                     Image = ItemGroup;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     RunObject = Page "Loans Guarantee Details";
//                     RunPageLink = "Loan No" = field("Loan  No.");
//                 }
//             }
//             group(Approvals)
//             {
//                 Caption = 'Approvals';

//                 action("Send Approval Request")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Send Approval Request';
//                     Image = SendApprovalRequest;
//                     Promoted = true;
//                     PromotedCategory = Category4;

//                     trigger OnAction()
//                     var
//                         Text001: label 'This transaction is already pending approval';
//                         ApprovalMgt: Codeunit "Approvals Mgmt.";
//                         SrestepApprovalsCodeUnit: Codeunit SurestepApprovalsCodeUnit;
//                     begin
//                         //ENSURE THAT REQUESTED AMOUNT IS ENTERED
//                         Rec.TestField("Requested Amount");
//                         if Rec."Approval Status" <> Rec."approval status"::Open then
//                             Error(Text001);

//                         //End allocate batch number
//                         Doc_Type := Doc_type::Loan;
//                         Table_id := Database::"Loans Register";

//                         // if ApprovalsMgmt.CheckLoanAppApprovalsWorkflowEnabled(Rec) then
//                         //   ApprovalsMgmt.OnSendLoanAppDocForApproval(Rec);
//                         //........................
//                         if Confirm('Send Approval Request?', false) = true then begin
//                             SrestepApprovalsCodeUnit.SendLoanApplicationsRequestForApproval(rec."Loan  No.", Rec);
//                             Message('Approval Sent Success!');
//                             CurrPage.Close();
//                         end;

//                         //SMS MESSAGE

//                         SMSMessages.Reset;
//                         if SMSMessages.Find('+') then begin
//                             iEntryNo := SMSMessages."Entry No";
//                             iEntryNo := iEntryNo + 1;
//                         end
//                         else begin
//                             iEntryNo := 1;
//                         end;

//                         SMSMessages.Reset;
//                         SMSMessages.Init;
//                         SMSMessages."Entry No" := iEntryNo;
//                         SMSMessages."Account No" := Rec."Client Code";
//                         SMSMessages."Date Entered" := Today;
//                         SMSMessages."Time Entered" := Time;
//                         SMSMessages.Source := 'LOAN APPL';
//                         SMSMessages."Entered By" := UserId;
//                         SMSMessages."Sent To Server" := SMSMessages."sent to server"::No;
//                         SMSMessages."SMS Message" := 'Your loan application of KSHs.' + Format(Rec."Requested Amount") +
//                                                   ' has been received ' + CompanyInfo.Name + '.';
//                         Cust.Reset;
//                         if Cust.Get(Rec."Client Code") then
//                             SMSMessages."Telephone No" := Cust."Phone No.";
//                         SMSMessages.Insert;

//                     end;
//                 }
//                 action("Cancel Approval Request")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Cancel Approval Request';
//                     Image = Cancel;
//                     Promoted = true;
//                     PromotedCategory = Category4;

//                     trigger OnAction()
//                     var
//                         ApprovalMgt: Codeunit "Approvals Mgmt.";
//                         SrestepApprovalsCodeUnit: Codeunit SwizzsoftApprovalsCodeUnit;
//                     begin
//                         if Confirm('Cancel Approval?', false) = true then begin
//                             SrestepApprovalsCodeUnit.CancelLoanApplicationsRequestForApproval(rec."Loan  No.", Rec);
//                         end;
//                     end;
//                 }
//             }
//         }
//     }

//     trigger OnAfterGetCurrRecord()
//     begin
//         UpdateControl();
//     end;

//     trigger OnModifyRecord(): Boolean
//     begin
//         LoanAppPermisions();
//     end;

//     trigger OnNewRecord(BelowxRec: Boolean)
//     begin
//         //Source:=Source::BOSA;
//         //"Loan Appeal":=TRUE;
//         //MODIFY
//     end;

//     trigger OnNextRecord(Steps: Integer): Integer
//     begin
//         /*IF "Loan Status"="Loan Status"::Approved THEN
//         CurrPage.EDITABLE:=FALSE; */

//     end;

//     trigger OnOpenPage()
//     begin
//         Rec.SetRange(Posted, false);
//         /*IF "Loan Status"="Loan Status"::Approved THEN
//         CurrPage.EDITABLE:=FALSE;*/

//     end;

//     var
//         i: Integer;
//         LoanType: Record "Loan Products Setup";
//         PeriodDueDate: Date;
//         ScheduleRep: Record "Loan Repayment Schedule";
//         LoanGuar: Record "Loans Guarantee Details";
//         RunningDate: Date;
//         G: Integer;
//         IssuedDate: Date;
//         SMSMessages: Record "SMS Messages";
//         iEntryNo: Integer;
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
//         Jnlinepost: Codeunit "Gen. Jnl.-Post Line";
//         CumInterest: Decimal;
//         NewPrincipal: Decimal;
//         PeriodPrRepayment: Decimal;
//         GenBatch: Record "Gen. Journal Batch";
//         LineNo: Integer;
//         SFactory: Codeunit "Swizzsoft Factory";
//         GnljnlineCopy: Record "Gen. Journal Line";
//         NewLNApplicNo: Code[10];
//         Cust: Record Customer;
//         LoanApp: Record "Loans Register";
//         TestAmt: Decimal;
//         CustRec: Record "Customer Posting Group";
//         CustPostingGroup: Record "Customer Posting Group";
//         GenSetUp: Record "Sacco General Set-Up";
//         PCharges: Record "Loan Product Charges";
//         TCharges: Decimal;
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
//         GLPosting: Codeunit "Gen. Jnl.-Post Line";
//         LoanTopUp: Record "Loan Offset Details";
//         Vend: Record Vendor;
//         TemplateName: Code[20];
//         BatchName: Code[20];
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
//         BridgedLoans: Record "Loan Offset Details";
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
//         DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batches,"Payment Voucher","Petty Cash",Requisition,Loan,Imprest,ImprestSurrender,Interbank;
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
//         Doc_Type: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Account Opening","Member Closure",Loan;
//         ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//         GrossPay: Decimal;
//         Nettakehome: Decimal;
//         TotalDeductions: Decimal;
//         UtilizableAmount: Decimal;
//         NetUtilizable: Decimal;
//         Deductions: Decimal;
//         Benov: Decimal;
//         // TAXABLEPAY: Record "Investment General Setup";
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
//         PartPayTotal: Decimal;
//         AmountPayable: Decimal;
//         CompanyInfo: Record "Company Information";
//         DirbursementDate: date;
//         VarAmounttoDisburse: Decimal;


//     procedure UpdateControl()
//     begin

//         if Rec."Loan Status" = Rec."loan status"::Application then begin
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
//         end;

//         if Rec."Loan Status" = Rec."loan status"::Appraisal then begin
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
//         end;

//         if Rec."Loan Status" = Rec."loan status"::Rejected then begin
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
//             RejectionRemarkEditable := false
//         end;

//         if Rec."Approval Status" = Rec."approval status"::Approved then begin
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
//         end;
//     end;


//     procedure LoanAppPermisions()
//     begin
//     end;

//     local procedure FnInsertBOSALines(var LoanApps: Record "Loans Register"; LoanNo: Code[30])
//     var
//         EndMonth: Date;
//         RemainingDays: Integer;
//         TMonthDays: Integer;
//         Sfactorycode: Codeunit "Swizzsoft Factory";
//         AmountTop: Decimal;
//         NetAmount: Decimal;
//     begin
//         AmountTop := 0;
//         NetAmount := 0;
//         //--------------------Generate Schedule
//         Sfactorycode.FnGenerateRepaymentSchedule(Rec."Loan  No.");
//         DirbursementDate := Rec."Loan Disbursement Date";
//         VarAmounttoDisburse := Rec."Approved Amount";
//         //....................PRORATED DAYS
//         EndMonth := CALCDATE('-1D', CALCDATE('1M', DMY2DATE(1, DATE2DMY(Today, 2), DATE2DMY(Today, 3))));
//         RemainingDays := (EndMonth - Today) + 1;
//         TMonthDays := DATE2DMY(EndMonth, 1);
//         //....................Ensure that If Batch doesnt exist then create
//         IF NOT GenBatch.GET(TemplateName, BatchName) THEN BEGIN
//             GenBatch.INIT;
//             GenBatch."Journal Template Name" := TemplateName;
//             GenBatch.Name := BatchName;
//             GenBatch.INSERT;
//         END;
//         //....................Reset General Journal Lines
//         GenJournalLine.RESET;
//         GenJournalLine.SETRANGE("Journal Template Name", TemplateName);
//         GenJournalLine.SETRANGE("Journal Batch Name", BatchName);
//         GenJournalLine.DELETEALL;
//         //....................Loan Posting Lines
//         GenSetUp.GET;
//         DActivity := '';
//         DBranch := '';
//         IF Cust.GET(LoanApps."Client Code") THEN BEGIN
//             DActivity := Cust."Global Dimension 1 Code";
//             DBranch := Cust."Global Dimension 2 Code";
//         END;
//         //**************Loan Principal Posting**********************************
//         LineNo := LineNo + 10000;
//         SFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Rec."Loan  No.", LineNo, GenJournalLine."Transaction Type"::Loan, GenJournalLine."Account Type"::Customer, LoanApps."Client Code", DirbursementDate, VarAmounttoDisburse, 'BOSA', LoanApps."Loan  No.", 'Loan Disbursement - ' + LoanApps."Loan Product Type", LoanApps."Loan  No.");
//         //--------------------------------RECOVER OVERDRAFT()-------------------------------------------------------
//         //Code Here

//         //...................Cater for Loan Offset Now !
//         Rec.CalcFields("Top Up Amount");
//         if Rec."Top Up Amount" > 0 then begin
//             LoanTopUp.RESET;
//             LoanTopUp.SETRANGE(LoanTopUp."Loan No.", Rec."Loan  No.");
//             IF LoanTopUp.FIND('-') THEN BEGIN
//                 repeat
//                     LineNo := LineNo + 10000;
//                     SFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Rec."Loan  No.", LineNo, GenJournalLine."Transaction Type"::"Loan Repayment", GenJournalLine."Account Type"::Customer, LoanApps."Client Code", DirbursementDate, LoanTopUp."Principle Top Up" * -1, 'BOSA', LoanApps."Loan  No.", 'Loan OffSet By - ' + LoanApps."Loan  No.", LoanTopUp."Loan Top Up");
//                     //..................Recover Interest On Top Up
//                     LineNo := LineNo + 10000;
//                     SFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Rec."Loan  No.", LineNo, GenJournalLine."Transaction Type"::"Interest Paid", GenJournalLine."Account Type"::Customer, LoanApps."Client Code", DirbursementDate, LoanTopUp."Interest Top Up" * -1, 'BOSA', LoanApps."Loan  No.", 'Interest Due Paid on top up - ', LoanTopUp."Loan Top Up");
//                     //If there is top up commission charged write it here start
//                     LineNo := LineNo + 10000;
//                     SFactory.FnCreateGnlJournalLine(TemplateName, BatchName, LoanApps."Loan  No.", LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::"G/L Account", GenSetUp."Top up Account", DirbursementDate, LoanTopUp.Commision * -1, 'BOSA', Rec."Batch No.", 'Commision on top up - ', LoanTopUp."Loan Top Up");
//                     //If there is top up commission charged write it here end
//                     AmountTop := (LoanTopUp."Principle Top Up" + LoanTopUp."Interest Top Up" + LoanTopUp.Commision);
//                     VarAmounttoDisburse := VarAmounttoDisburse - (LoanTopUp."Principle Top Up" + LoanTopUp."Interest Top Up" + LoanTopUp.Commision);
//                 UNTIL LoanTopUp.NEXT = 0;
//             END;
//         end;
//         //If there is top up commission charged write it here start // "Loan Insurance"
//         //If there is top up commission charged write it here end

//         NetAmount := Rec."Approved Amount" - (Rec."Loan Processing Fee" + Rec."Loan Dirbusement Fee" + Rec."Loan Insurance" + AmountTop);
//         //***************************Loan Product Charges code
//         PCharges.Reset();
//         PCharges.SETRANGE(PCharges."Product Code", Rec."Loan Product Type");
//         IF PCharges.FIND('-') THEN BEGIN
//             REPEAT
//                 PCharges.TESTFIELD(PCharges."G/L Account");
//                 LineNo := LineNo + 10000;
//                 GenJournalLine.INIT;
//                 GenJournalLine."Journal Template Name" := TemplateName;
//                 GenJournalLine."Journal Batch Name" := BatchName;
//                 GenJournalLine."Line No." := LineNo;
//                 GenJournalLine."Account Type" := GenJournalLine."Account Type"::"G/L Account";
//                 GenJournalLine."Account No." := PCharges."G/L Account";
//                 GenJournalLine.VALIDATE(GenJournalLine."Account No.");
//                 GenJournalLine."Document No." := Rec."Loan  No.";
//                 GenJournalLine."External Document No." := Rec."Loan  No.";
//                 GenJournalLine."Posting Date" := DirbursementDate;
//                 GenJournalLine.Description := PCharges.Description + '-' + Format(Rec."Loan  No.");
//                 IF PCharges."Use Perc" = TRUE THEN BEGIN
//                     GenJournalLine.Amount := (Rec."Approved Amount" * (PCharges.Percentage / 100)) * -1
//                 END
//                 ELSE
//                     IF PCharges."Use Perc" = false then begin
//                         if (NetAmount >= 1000000) then
//                             GenJournalLine.Amount := PCharges.Amount * -1
//                         else
//                             GenJournalLine.Amount := PCharges.Amount * -1
//                     end;
//                 GenJournalLine.VALIDATE(GenJournalLine.Amount);
//                 GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
//                 GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
//                 IF GenJournalLine.Amount <> 0 THEN GenJournalLine.INSERT;

//             UNTIL PCharges.NEXT = 0;
//         END;
//         //end of code
//         //.....Valuation
//         // VarAmounttoDisburse := VarAmounttoDisburse - (Rec."Loan Processing Fee" + Rec."Loan Dirbusement Fee" + Rec."Loan Insurance");
//         // LineNo := LineNo + 10000;
//         // SFactory.FnCreateGnlJournalLine(TemplateName, BatchName, LoanApps."Loan  No.", LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::"G/L Account", GenSetUp."Asset Valuation Cost", DirbursementDate, LoanApps."Valuation Cost" * -1, 'BOSA', Rec."Batch No.", 'Loan Principle Amount ' + Format(LoanApps."Loan  No."), '');
//         // VarAmounttoDisburse := VarAmounttoDisburse - LoanApps."Valuation Cost";
//         // //...Debosting amount
//         // LineNo := LineNo + 10000;
//         // SFactory.FnCreateGnlJournalLine(TemplateName, BatchName, LoanApps."Loan  No.", LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::"G/L Account", GenSetUp."Boosting Fees Account", DirbursementDate, LoanApps."Deboost Commision" * -1, 'BOSA', Rec."Batch No.", 'Debosting commision ' + Format(LoanApps."Loan  No."), '');
//         // VarAmounttoDisburse := VarAmounttoDisburse - LoanApps."Deboost Commision";
//         // //Debosting commsion
//         // LineNo := LineNo + 10000;
//         // SFactory.FnCreateGnlJournalLine(TemplateName, BatchName, LoanApps."Loan  No.", LineNo, GenJournalLine."Transaction Type"::"Deposit Contribution", GenJournalLine."Account Type"::Customer, LoanApps."Client Code", DirbursementDate, LoanApps."Deboost Amount" * -1, 'BOSA', Rec."Batch No.", 'Debosted shares ' + Format(LoanApps."Loan  No."), '');
//         // VarAmounttoDisburse := VarAmounttoDisburse - LoanApps."Deboost Amount";
//         // //..Legal Fees
//         // LineNo := LineNo + 10000;
//         // SFactory.FnCreateGnlJournalLine(TemplateName, BatchName, LoanApps."Loan  No.", LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::"G/L Account", GenSetUp."Legal Fees", DirbursementDate, LoanApps."Legal Cost" * -1, 'BOSA', Rec."Batch No.", 'Loan Principle Amount ' + Format(LoanApps."Loan  No."), '');
//         // VarAmounttoDisburse := VarAmounttoDisburse - LoanApps."Legal Cost";
//         //------------------------------------2. CREDIT MEMBER BANK A/C---------------------------------------------------------------------------------------------
//         LineNo := LineNo + 10000;
//         SFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Rec."Loan  No.", LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::"Bank Account", LoanApps."Paying Bank Account No", DirbursementDate, VarAmounttoDisburse * -1, 'BOSA', LoanApps."Loan  No.", 'Loan Principle Amount ' + Format(Rec."Loan  No."), '');
//     end;


// }
