// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Page 51516385 "Loan Application Card(New)"
// {
//     DeleteAllowed = false;
//     PageType = Card;
//     PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
//     SourceTable = "Loans Register";
//     SourceTableView = where(Source = const(BOSA),
//                             Posted = const(false));

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
//                     Caption = 'Member';
//                     Editable = MNoEditable;
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
//                 field("Insider-board"; Rec."Insider-board")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Insider-Employee"; Rec."Insider-Employee")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Pension No"; Rec."Pension No")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Member Deposits"; Rec."Member Deposits")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Member Deposits';
//                 }
//                 field("Total Outstanding Loan BAL"; Rec."Total Outstanding Loan BAL")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Total Outstanding Loan Balance';
//                     Editable = false;
//                 }
//                 field("GuarantorShip Liability"; Rec."GuarantorShip Liability")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Arrear Amount"; Rec."Affidavit - Estimated Value 2")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field(Bridging; Rec.Bridging)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Factoring';
//                     Visible = false;
//                 }
//                 field(Refinancing; Rec.Refinancing)
//                 {
//                     ApplicationArea = Basic;
//                     Visible = false;
//                 }
//                 field(Consolidation; Rec.Consolidation)
//                 {
//                     ApplicationArea = Basic;
//                     Visible = true;
//                 }
//                 field("Insurance Upfront"; Rec."Insurance Upfront")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Charge Insurance Upfront';
//                     Visible = false;
//                 }
//                 field("Application Date"; Rec."Application Date")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = true;

//                     trigger OnValidate()
//                     begin
//                         Rec.TestField(Posted, false);
//                     end;
//                 }
//                 field("Loan Product Type"; Rec."Loan Product Type")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = LProdTypeEditable;
//                 }
//                 field("Type Of Loan Duration"; Rec."Type Of Loan Duration")
//                 {
//                     ApplicationArea = Basic;
//                     Visible = false;
//                 }
//                 field(Installments; Rec.Installments)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Repayment Period[Months]';
//                     Editable = InstallmentEditable;

//                     trigger OnValidate()
//                     begin
//                         Rec.TestField(Posted, false);
//                     end;
//                 }
//                 field(Interest; Rec.Interest)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Requested Amount"; Rec."Requested Amount")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Amount Applied';
//                     Editable = AppliedAmountEditable;

//                     trigger OnValidate()
//                     begin
//                         Rec.TestField(Posted, false);
//                     end;
//                 }
//                 field("Disburesment Type"; Rec."Disburesment Type")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Boost this Loan"; Rec."Boost this Loan")
//                 {
//                     ApplicationArea = Basic;
//                     Visible = false;
//                 }
//                 field("Boosted Amount"; Rec."Boosted Amount")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = true;
//                     Visible = false;
//                 }
//                 field("Boosting Commision"; Rec."Boosting Commision")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field("Penalty Amount"; Rec."Penalty Amount")
//                 {
//                     ApplicationArea = Basic;
//                     Visible = false;
//                 }
//                 field("Lumpsum Amount Charge"; Rec."Lumpsum Amount Charge")
//                 {
//                     ApplicationArea = Basic;
//                     Visible = false;
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
//                     Editable = ApprovedAmountEditable;

//                     trigger OnValidate()
//                     begin
//                         Rec.TestField(Posted, false);
//                     end;
//                 }
//                 field("Amount To Disburse"; Rec."Amount To Disburse")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Registration Date"; Rec."Registration Date")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = true;
//                     Enabled = false;
//                     Style = Unfavorable;
//                     StyleExpr = true;
//                 }
//                 field("Main-Sector"; Rec."Main-Sector")
//                 {
//                     ApplicationArea = Basic;
//                     ShowMandatory = true;
//                 }
//                 field("Sub-sector"; Rec."Sub-sector")
//                 {
//                     ApplicationArea = Basic;
//                     ShowMandatory = true;
//                     TableRelation = "Sub Sector".Code where(No = field("Main-Sector"));
//                 }
//                 field("Specific-Sector"; Rec."Specific-Sector")
//                 {
//                     ApplicationArea = Basic;
//                     ShowMandatory = true;
//                     TableRelation = "Specific Sector".Code where(No = field("Sub-sector"));
//                 }
//                 field("Loan Purpose"; Rec."Loan Purpose")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = LoanPurposeEditable;
//                 }
//                 field("Received Copy Of ID"; Rec."Received Copy Of ID")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = CopyofIDEditable;
//                 }
//                 field("Received Payslip/Bank Statemen"; Rec."Received Payslip/Bank Statemen")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = CopyofPayslipEditable;
//                 }
//                 field("Witnessed By"; Rec."Witnessed By")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = WitnessEditable;
//                     ShowMandatory = true;
//                 }
//                 field("Witness Name"; Rec."Witness Name")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Repayment Method"; Rec."Repayment Method")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field(Repayment; Rec.Repayment)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                     Importance = Promoted;
//                 }
//                 field("Loan Principle Repayment"; Rec."Loan Principle Repayment")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Principle Repayment';
//                     Editable = false;
//                     Enabled = false;
//                     Importance = Promoted;
//                     Style = Favorable;
//                     StyleExpr = true;
//                 }
//                 field("Loan Interest Repayment"; Rec."Loan Interest Repayment")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Interest Repayment';
//                     Editable = false;
//                     Enabled = false;
//                     Style = Favorable;
//                     StyleExpr = true;
//                 }
//                 field(Insurance; Rec.Insurance)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field("Approved Repayment"; Rec."Approved Repayment")
//                 {
//                     ApplicationArea = Basic;
//                     Visible = false;
//                 }
//                 field("Loan Status"; Rec."Loan Status")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;

//                     trigger OnValidate()
//                     begin
//                         UpdateControl();

//                         /*IF LoanType.GET('DISCOUNT') THEN BEGIN
//                         IF (("Approved Amount")-("Special Loan Amount"+"Other Rec.Commitments Clearance"+SpecialComm))
//                              < 0 THEN
//                         ERROR('Bridging amount more than the loans applied/approved.');
                        
//                         END;
                        
                        
//                         IF "Loan Status" = "Loan Status"::Appraisal THEN BEGIN
//                         StatusPermissions.RESET;
//                         StatusPermissions.SETRANGE(StatusPermissions."User ID",USERID);
//                         StatusPermissions.SETRANGE(StatusPermissions."Function",StatusPermissions."Function"::"Bosa Loan Appraisal");
//                         IF StatusPermissions.FIND('-') = FALSE THEN
//                         ERROR('You do not have permissions to Appraise this Loan.');
                        
//                         END ELSE BEGIN
                        
//                         IF "Loan Status" = "Loan Status"::Approved THEN BEGIN
//                         StatusPermissions.RESET;
//                         StatusPermissions.SETRANGE(StatusPermissions."User ID",USERID);
//                         StatusPermissions.SETRANGE(StatusPermissions."Function",StatusPermissions."Function"::"Bosa Loan Approval");
//                         IF StatusPermissions.FIND('-') = FALSE THEN
//                         ERROR('You do not have permissions to Approve this Loan.');
                        
//                         "Date Approved":=TODAY;
//                         END;
//                         END;
//                         //END;
                        
                        
//                         {
//                         ccEmail:='';
                        
//                         LoanG.RESET;
//                         LoanG.SETRANGE(LoanG."Loan No","Loan  No.");
//                         IF LoanG.FIND('-') THEN BEGIN
//                         REPEAT
//                         IF CustE.GET(LoanG."Member No") THEN BEGIN
//                         IF CustE."E-Mail" <> '' THEN BEGIN
//                         IF ccEmail = '' THEN
//                         ccEmail:=CustE."E-Mail"
//                         ELSE
//                         ccEmail:=ccEmail + ';' + CustE."E-Mail";
//                         END;
//                         END;
//                         UNTIL LoanG.NEXT = 0;
//                         END;
                        
                        
                        
//                         IF "Loan Status"="Loan Status"::Approved THEN BEGIN
//                         CLEAR(Notification);
//                         IF CustE.GET("Client Code") THEN BEGIN
//                         Notification.NewMessage(CustE."E-Mail",ccEmail,'Loan Status',
//                         'We are happy to inform you that your ' + "Loan Product Type" + ' loan application of ' + FORMAT("Requested Amount")
//                          + ' has been approved.' + ' (Dynamics NAV ERP)','',FALSE);
//                         END;
                        
                        
//                         END ELSE IF "Loan Status"="Loan Status"::Appraisal THEN BEGIN
//                         DocN:='';
//                         DocM:='';
//                         DocF:='';
//                         DNar:='';
                        
//                         IF "Copy of ID"= FALSE THEN BEGIN
//                         DocN:='Please avail your ';
//                         DocM:='Copy of ID.';
//                         DocF:=' to facilitate further processing.'
//                         END;
                        
//                         IF Contract= FALSE THEN BEGIN
//                         DocN:='Please avail your ';
//                         DocM:=DocM + ' Contract.';
//                         DocF:=' to facilitate further processing.'
//                         END;
                        
//                         IF Payslip= FALSE THEN BEGIN
//                         DocN:='Please avail your ';
//                         DocM:=DocM + ' Payslip.';
//                         DocF:=' to facilitate further processing.'
//                         END;
                        
//                         DNar:=DocN + DocM + DocF;
                        
                        
//                         CLEAR(Notification);
//                         IF CustE.GET("Client Code") THEN BEGIN
//                         Notification.NewMessage(CustE."E-Mail",ccEmail,'Loan Status',
//                         'Your ' + "Loan Product Type" + ' loan application of Ksh.' + FORMAT("Requested Amount")
//                         + ' has been received and it is now at the appraisal stage. ' +
//                          DNar + ' (Dynamics NAV ERP)'
//                         ,'',FALSE);
//                         END;
                        
                        
//                         END ELSE BEGIN
//                         CLEAR(Notification);
                        
//                         IF CustE.GET("Client Code") THEN BEGIN
//                         Notification.NewMessage(CustE."E-Mail",ccEmail,'Loan Status',
//                         'We are sorry to inform you that your ' + "Loan Product Type" + ' loan application of ' + FORMAT("Requested Amount")
//                         + ' has been rejected.' + ' (Dynamics NAV ERP)'
//                         ,'',FALSE);
//                         END;
                        
//                         END;
                        
//                         }
//                           {
//                         //SMS Notification
//                         Cust.RESET;
//                         Cust.SETRANGE(Cust."No.","Client Code");
//                         IF Cust.FIND('-') THEN BEGIN
//                         Cust.Rec.TestField(Cust."Phone No.");
//                         END;
                        
                        
//                         Cust.RESET;
//                         Cust.SETRANGE(Cust."No.","Client Code");
//                         IF Cust.FIND('-') THEN BEGIN
//                         SMSMessage.INIT;
//                         SMSMessage."SMS Message":=Cust."Phone No."+'*'+' Your loan app. of date ' + FORMAT("Application Date")
//                         + ' of type ' + "Loan Product Type" +' of amount ' +FORMAT("Approved Amount")+' has been issued. Thank you.';
//                         SMSMessage."Date Entered":=TODAY;
//                         SMSMessage."Time Entered":=TIME;
//                         SMSMessage."SMS Sent":=SMSMessage."SMS Sent"::No;
//                         SMSMessage.INSERT;
//                         END;
//                         //SMS Notification
//                         }   */

//                     end;
//                 }
//                 field("Batch No."; Rec."Batch No.")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = BatchNoEditable;
//                     Visible = false;
//                 }
//                 field("Captured By"; Rec."Captured By")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Is Top Up"; Rec."Is Top Up")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Top Up Amount"; Rec."Top Up Amount")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Top Up Amount';
//                 }
//                 field("Total TopUp Commission"; Rec."Total TopUp Commission")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Total TopUp Comission';
//                     Editable = false;
//                 }
//                 field("Loan Deductions"; Rec."Loan Deductions")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Repayment Frequency"; Rec."Repayment Frequency")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                     Enabled = false;
//                 }
//                 field("Mode of Disbursement"; Rec."Mode of Disbursement")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = true;
//                     Visible = false;
//                 }
//                 field("Loan Disbursement Date"; Rec."Loan Disbursement Date")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = true;
//                     Visible = false;
//                 }
//                 field("Cheque No."; Rec."Cheque No.")
//                 {
//                     ApplicationArea = Basic;
//                     Visible = false;

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
//                     Visible = false;
//                 }
//                 field("Expected Date of Completion"; Rec."Expected Date of Completion")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field("External EFT"; Rec."External EFT")
//                 {
//                     ApplicationArea = Basic;
//                     Visible = false;
//                 }
//                 field(Nextdisbursementdate; Rec.Nextdisbursementdate)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Next Disbursement Date';
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
//                 }
//                 field("Board Approval Status"; Rec."Board Approval Status")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field("Board Approved By"; Rec."Board Approved By")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field("Board Approval Comment"; Rec."Board Approval Comment")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field("Rejection  Remark"; Rec."Rejection  Remark")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = RejectionRemarkEditable;
//                 }
//                 field("Recovery Mode"; Rec."Recovery Mode")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = RecoveryModeEditable;
//                 }
//                 field(Remarks; Rec.Remarks)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = Remarkseditable;
//                     Visible = true;
//                 }
//             }
//             group("Salary Details")
//             {
//                 Caption = 'Salary Details';
//             }
//             group(Earnings)
//             {
//                 Caption = 'Earnings';
//                 field("Gross Pay"; Rec."Gross Pay")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Basic Pay';
//                 }
//                 field("Other Income"; Rec."Other Income")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Basic Pay H"; Rec."Basic Pay H")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Basic Pay';
//                     Visible = false;
//                 }
//                 field("Total Deductions"; Rec."Total Deductions")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Net Income"; Rec."Net Income")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("House AllowanceH"; Rec."House AllowanceH")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'House Allowance';
//                     Visible = false;
//                 }
//                 field("Medical AllowanceH"; Rec."Medical AllowanceH")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Medical Allowance';
//                     Visible = false;
//                 }
//                 field("Transport/Bus Fare"; Rec."Transport/Bus Fare")
//                 {
//                     ApplicationArea = Basic;
//                     Visible = false;
//                 }
//                 field("Provident Fund"; Rec."Provident Fund")
//                 {
//                     ApplicationArea = Basic;
//                     Visible = false;
//                 }
//             }
//             group("Non-Taxable Deductions")
//             {
//                 Caption = 'Non-Taxable Deductions';
//                 Visible = false;
//                 field("Pension Scheme"; Rec."Pension Scheme")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Total Provident Fund';
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
//                 Visible = false;
//                 field(PAYE; PAYE)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(NSSF; Rec.NSSF)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(NHIF; Rec.NHIF)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Staff Union Contribution"; Rec."Staff Union Contribution")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Union Dues';
//                 }
//                 field("Monthly Contribution"; Rec."Monthly Contribution")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Deposits';
//                 }
//                 field("Risk MGT"; Rec."Risk MGT")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Benevolent Fund';
//                 }
//                 field("Medical Insurance"; Rec."Medical Insurance")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Life Insurance"; Rec."Life Insurance")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Gold Save / NIS';
//                 }
//                 field("Provident Fund (Self)"; Rec."Provident Fund (Self)")
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
//                 field("Existing Loan Repayments"; Rec."Existing Loan Repayments")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
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
//                 field(UtilizableAmount; Rec."Utilizable Amount")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Bridge Amount Release"; Rec."Bridge Amount Release")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Cleared Loan Repayment';
//                 }
//                 field("Net Utilizable Amount"; Rec."Net Utilizable Amount")
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
//             group("Bank Account Details")
//             {
//                 Caption = 'Bank Account Details';
//                 field("Bank code"; Rec."Bank code")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Bank Name"; Rec."Bank Name")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Bank Account"; Rec."Bank Account")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//             }
//         }
//         area(factboxes)
//         {
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
//                 action("Loan Application Form")
//                 {
//                     ApplicationArea = Basic;
//                     Image = Form;
//                     Promoted = true;
//                     PromotedCategory = "Report";
//                     Visible = false;

//                     trigger OnAction()
//                     begin
//                         LoanApp.Reset;
//                         LoanApp.SetRange(LoanApp."Loan  No.", Rec."Loan  No.");
//                         if LoanApp.Find('-') then begin
//                             Report.Run(51516896, true, false, LoanApp);
//                         end;
//                     end;
//                 }
//                 action("Loan Appraisal")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Loan Appraisal';
//                     Enabled = EditableAction;
//                     Image = GanttChart;
//                     Promoted = true;
//                     PromotedCategory = Category4;
//                     PromotedOnly = true;

//                     trigger OnAction()
//                     begin
//                         //************************************************

//                         Rec.TestField("Received Copy Of ID");
//                         Rec.TestField("Received Payslip/Bank Statemen");
//                         Rec.TestField("Main-Sector");
//                         Rec.TestField("Sub-sector");
//                         Rec.TestField("Specific-Sector");
//                         Rec.Validate("Recovery Mode");
//                         Rec.TestField("Requested Amount");
//                         Rec.TestField("Loan Purpose");

//                         //*******************************************************
//                         if (Rec.Consolidation) or (Rec.Refinancing) or (Rec.Bridging) then begin
//                             Rec.CalcFields("Top Up Amount");
//                             if Rec."Top Up Amount" <= 0 then
//                                 Error('Please Select loan to offset!');
//                         end;
//                         if Rec."Notify Guarantor SMS" = false then
//                             Error('Please notify guarantors first before you proceed.');
//                         //*********************************************************

//                         //IF "Loan Status" = "Loan Status"::Application THEN

//                         "Loan Status" := "loan status"::Appraisal;
//                         Rec.Modify;
//                         Rec.Commit;
//                         LoanApp.Reset;
//                         LoanApp.SetRange(LoanApp."Loan  No.", "Loan  No.");
//                         if LoanApp.Find('-') then begin
//                             Report.Run(51516384, true, false, LoanApp);
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
//                     Visible = false;

//                     trigger OnAction()
//                     begin
//                         if "Repayment Frequency" = "repayment frequency"::Daily then
//                             Evaluate(InPeriod, '1D')
//                         else if "Repayment Frequency" = "repayment frequency"::Weekly then
//                             Evaluate(InPeriod, '1W')
//                         else if "Repayment Frequency" = "repayment frequency"::Monthly then
//                             Evaluate(InPeriod, '1M')
//                         else if "Repayment Frequency" = "repayment frequency"::Quaterly then
//                             Evaluate(InPeriod, '1Q');


//                         QCounter := 0;
//                         QCounter := 3;
//                         ScheduleBal := 0;
//                         //EVALUATE(InPeriod,'1D');
//                         GrPrinciple := "Grace Period - Principle (M)";
//                         GrInterest := "Grace Period - Interest (M)";
//                         InitialGraceInt := "Grace Period - Interest (M)";

//                         LoansR.Reset;
//                         LoansR.SetRange(LoansR."Loan  No.", "Loan  No.");
//                         if LoansR.Find('-') then begin

//                             Rec.TestField("Loan Disbursement Date");
//                             Rec.TestField("Repayment Start Date");

//                             RSchedule.Reset;
//                             RSchedule.SetRange(RSchedule."Loan No.", "Loan  No.");
//                             RSchedule.DeleteAll;

//                             LoanAmount := LoansR."Approved Amount" + LoansR."Capitalized Charges";
//                             InterestRate := LoansR.Interest;
//                             RepayPeriod := LoansR.Installments;
//                             InitialInstal := LoansR.Installments + "Grace Period - Principle (M)";
//                             LBalance := LoansR."Approved Amount" + LoansR."Capitalized Charges";
//                             LNBalance := LoansR."Outstanding Balance";
//                             RunDate := "Repayment Start Date";

//                             InstalNo := 0;
//                             Evaluate(RepayInterval, '1W');

//                             //Repayment Frequency
//                             if "Repayment Frequency" = "repayment frequency"::Daily then
//                                 RunDate := CalcDate('-1D', RunDate)
//                             else if "Repayment Frequency" = "repayment frequency"::Weekly then
//                                 RunDate := CalcDate('-1W', RunDate)
//                             else if "Repayment Frequency" = "repayment frequency"::Monthly then
//                                 RunDate := CalcDate('-1M', RunDate)
//                             else if "Repayment Frequency" = "repayment frequency"::Quaterly then
//                                 RunDate := CalcDate('-1Q', RunDate);
//                             //Repayment Frequency


//                             repeat
//                                 InstalNo := InstalNo + 1;
//                                 ScheduleBal := LBalance;

//                                 //*************Repayment Frequency***********************//
//                                 if "Repayment Frequency" = "repayment frequency"::Daily then
//                                     RunDate := CalcDate('1D', RunDate)
//                                 else if "Repayment Frequency" = "repayment frequency"::Weekly then
//                                     RunDate := CalcDate('1W', RunDate)
//                                 else if "Repayment Frequency" = "repayment frequency"::Monthly then
//                                     RunDate := CalcDate('1M', RunDate)
//                                 else if "Repayment Frequency" = "repayment frequency"::Quaterly then
//                                     RunDate := CalcDate('1Q', RunDate);






//                                 //*******************If Amortised****************************//
//                                 if "Repayment Method" = "repayment method"::Amortised then begin
//                                     Rec.TestField(Installments);
//                                     Rec.TestField(Interest);
//                                     Rec.TestField(Installments);
//                                     TotalMRepay := ROUND((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -RepayPeriod)) * LoanAmount, 1, '>');
//                                     TotalMRepay := (InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -RepayPeriod)) * LoanAmount;
//                                     LInterest := ROUND(LBalance / 100 / 12 * InterestRate);

//                                     LPrincipal := TotalMRepay - LInterest;
//                                 end;



//                                 if "Repayment Method" = "repayment method"::"Straight Line" then begin
//                                     Rec.TestField(Installments);
//                                     LPrincipal := ROUND(LoanAmount / RepayPeriod, 1, '>');
//                                     if ("Loan Product Type" = '15') or ("Loan Product Type" = '16') then begin
//                                         LInterest := 0;
//                                     end else begin
//                                         LInterest := ROUND((InterestRate / 1200) * LoanAmount, 1, '>');
//                                     end;

//                                     Repayment := LPrincipal + LInterest;
//                                     "Loan Principle Repayment" := LPrincipal;
//                                     "Loan Interest Repayment" := LInterest;
//                                 end;


//                                 if "Repayment Method" = "repayment method"::"Reducing Balance" then begin
//                                     Rec.TestField(Interest);
//                                     Rec.TestField(Installments);
//                                     LPrincipal := ROUND(LoanAmount / RepayPeriod, 1, '>');
//                                     LInterest := ROUND((InterestRate / 12 / 100) * LBalance, 1, '>');
//                                 end;

//                                 if "Repayment Method" = "repayment method"::Constants then begin
//                                     Rec.TestField(Repayment);
//                                     if LBalance < Repayment then
//                                         LPrincipal := LBalance
//                                     else
//                                         LPrincipal := Repayment;
//                                     LInterest := Interest;
//                                 end;


//                                 //Grace Period
//                                 if GrPrinciple > 0 then begin
//                                     LPrincipal := 0
//                                 end else begin
//                                     if "Instalment Period" <> InPeriod then
//                                         LBalance := LBalance - LPrincipal;
//                                     ScheduleBal := ScheduleBal - LPrincipal;
//                                 end;

//                                 if GrInterest > 0 then
//                                     LInterest := 0;

//                                 GrPrinciple := GrPrinciple - 1;
//                                 GrInterest := GrInterest - 1;
//                                 LInterest := ROUND(LoansR."Approved Amount" * LoansR.Interest / 12 * (RepayPeriod + 1) / (200 * RepayPeriod), 0.05, '>'); //For Nafaka Only
//                                                                                                                                                           //Grace Period
//                                 RSchedule.Init;
//                                 RSchedule."Repayment Code" := RepayCode;
//                                 RSchedule."Loan No." := "Loan  No.";
//                                 RSchedule."Loan Amount" := LoanAmount;
//                                 RSchedule."Instalment No" := InstalNo;
//                                 RSchedule."Repayment Date" := CalcDate('CM', RunDate);
//                                 RSchedule."Member No." := "Client Code";
//                                 RSchedule."Loan Category" := "Loan Product Type";
//                                 RSchedule."Monthly Repayment" := LInterest + LPrincipal;
//                                 RSchedule."Monthly Interest" := LInterest;
//                                 RSchedule."Principal Repayment" := LPrincipal;
//                                 RSchedule."Loan Balance" := ScheduleBal;
//                                 RSchedule.Insert;
//                                 WhichDay := Date2dwy(RSchedule."Repayment Date", 1);


//                             until LBalance < 1

//                         end;

//                         Rec.Commit;

//                         LoanApp.Reset;
//                         LoanApp.SetRange(LoanApp."Loan  No.", Rec."Loan  No.");
//                         if LoanApp.Find('-') then
//                             if LoanApp."Loan Product Type" <> 'INST' then begin
//                                 Report.Run(51516477, true, false, LoanApp);
//                             end else begin
//                                 Report.Run(51516477, true, false, LoanApp);
//                             end;
//                     end;
//                 }
//                 action("Reset Loan Application")
//                 {
//                     ApplicationArea = Basic;
//                     Enabled = EditableAction;
//                     Image = RefreshExcise;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     PromotedOnly = true;

//                     trigger OnAction()
//                     begin
//                         LoanApp.Reset;
//                         LoanApp.SetRange(LoanApp."Loan  No.", "Loan  No.");
//                         if LoanApp.Find('-') then begin
//                             "Client Code" := '';
//                             "Client Name" := '';
//                             "ID NO" := '';
//                             "Staff No" := '';
//                             Installments := 0;
//                             Interest := 0;
//                             "Requested Amount" := 0;
//                             "Approved Amount" := 0;
//                             "Application Date" := Today;
//                             Rec.Modify;
//                         end;
//                     end;
//                 }
//                 action("Update PAYE")
//                 {
//                     ApplicationArea = Basic;
//                     Enabled = EditableAction;
//                     Image = PayrollStatistics;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     PromotedOnly = true;
//                     Visible = false;

//                     trigger OnAction()
//                     begin
//                         GenSetUp.Get();
//                         Nettakehome := "Gross Pay" * 1 / 3; //Normally should be 1/3 of Basic
//                         //MESSAGE('%1',Nettakehome);
//                         /*IF GenSetUp."Minimum Take home"<>0 THEN BEGIN
//                           Nettakehome:=GenSetUp."Minimum Take home";
//                           END;*/
//                         Rec.Modify;


//                         GrossPay := "Basic Pay H" + "Medical AllowanceH" + "House AllowanceH" + "Other Income" + "Transport/Bus Fare";
//                         "Gross Pay" := GrossPay;
//                         Rec.Modify;

//                         Rec.CalcFields("Bridge Amount Release");

//                         "Utilizable Amount" := 0;
//                         NetUtilizable := 0;

//                         OTrelief := "Other Tax Relief";
//                         "Chargeable Pay" := "Gross Pay" - "Provident Fund" - "Pension Scheme";
//                         if Disabled <> true then begin
//                             Rec.PAYE := SFactory.FnCalculatePaye("Chargeable Pay") - "Other Tax Relief";
//                         end;
//                         TotalDeductions := "Monthly Contribution" + NSSF + NHIF + PAYE + "Risk MGT" + "Staff Union Contribution" + "Medical Insurance"
//                         + "Life Insurance" + "Other Liabilities" + "Other Loans Repayments" + "Sacco Deductions" + "Provident Fund (Self)" + "Existing Loan Repayments";
//                         Message('Gross Salary is %1 # Total Deductions=%2 # 1/3 of Basic is %3', "Gross Pay", TotalDeductions, ROUND("Basic Pay H" / 3, 0.5, '<'));
//                         "Utilizable Amount" := GrossPay - (TotalDeductions + "Basic Pay H" / 3);
//                         TotalDeductions := "Monthly Contribution" + NSSF + NHIF + PAYE + "Risk MGT" + "Staff Union Contribution" + "Medical Insurance"
//                         + "Life Insurance" + "Other Liabilities" + "Other Loans Repayments" + "Sacco Deductions" + "Provident Fund (Self)" + "Existing Loan Repayments";


//                         NetUtilizable := "Utilizable Amount" + "Bridge Amount Release" + "Non Payroll Payments";
//                         "Net Utilizable Amount" := NetUtilizable;
//                         "Total DeductionsH" := TotalDeductions;
//                         "Net take Home" := Nettakehome;
//                         Rec.Modify;

//                         if "Loan Product Type" = 'EMERGENCY 6' then begin
//                             NetUtilizable := "Gross Pay" - TotalDeductions - 5500;
//                             "Utilizable Amount" := GrossPay - TotalDeductions - 5500;//"Utilizable Amount"+"Bridge Amount Release"+"Non Payroll Payments";
//                             "Net Utilizable Amount" := NetUtilizable;
//                             "Total DeductionsH" := TotalDeductions;
//                             "Net take Home" := Nettakehome;
//                             Rec.Modify;
//                         end;

//                     end;
//                 }
//                 action("Move to Appraisal")
//                 {
//                     ApplicationArea = Basic;
//                     Image = Recalculate;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     PromotedOnly = true;
//                     Visible = false;

//                     trigger OnAction()
//                     begin
//                         if (Consolidation) or (Refinancing) or (Bridging) then begin
//                             Rec.CalcFields("Top Up Amount");
//                             if "Top Up Amount" <= 0 then
//                                 Error('Please Select loan to offset!');
//                         end;


//                         LoanGuar.Reset;
//                         LoanGuar.SetRange(LoanGuar."Loan No", "Loan  No.");
//                         if LoanGuar.Find('-') then begin

//                         end else
//                             "Notify Guarantor SMS" := true;
//                         Rec.Modify(true);

//                         if "Notify Guarantor SMS" = false then
//                             Error('Please notify guarantors first before you proceed.');
//                         if Confirm('Are you sure you want to move this Loan to Appraisal Stage ?', true) = false then
//                             exit;
//                         "Loan Status" := "loan status"::Appraisal;
//                         Rec.Modify;
//                     end;
//                 }
//                 action("Notify Guarantors")
//                 {
//                     ApplicationArea = Basic;
//                     Image = Email;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     PromotedOnly = true;
//                     Visible = ActionVisible;

//                     trigger OnAction()
//                     begin
//                         compinfo.Get();
//                         if Confirm('Are you sure you want to notify Guarantors about this Loan ?', true) = false then
//                             exit;
//                         if "Notify Guarantor SMS" then begin
//                             if Confirm('You have already notified Guarantors about this Loan.Do you want to send another SMS ?', true) = false then
//                                 exit;
//                         end;
//                         "Notify Guarantor SMS" := true;
//                         LoanGuar.Reset;
//                         LoanGuar.SetRange(LoanGuar."Loan No", "Loan  No.");
//                         if LoanGuar.Find('-') then begin
//                             repeat
//                                 Cust.Reset;
//                                 Cust.SetRange(Cust."No.", LoanGuar."Member No");
//                                 if Cust.Find('-') then begin
//                                     SFactory.FnSendSMS('LOAN GUARANTORS', 'You have guaranteed ' + "Client Name" + ' a ' + "Loan Product Type Name" + ' of ' + Format(LoanGuar."Amont Guaranteed")
//                                    + '. Call' + compinfo."Phone No." + ' if in dispute', Cust."FOSA Account No.", Cust."Phone No.");
//                                 end;
//                             until LoanGuar.Next = 0;
//                         end;
//                         "Notify Guarantor SMS" := true;
//                         Rec.Modify;
//                         SFactory.FnSendSMS('LOAN APPRAISAL',
//                       /*'Your loan application of KSHs.'+FORMAT("Requested Amount")+' has been received and your qualification is KSHs.'+FORMAT("Approved Amount")+'. The application is being processed',
//                       SFactory.FnGetFosaAccount("Client Code"),SFactory.FnGetPhoneNumber(Rec));*/

//                       'Your loan application of KSHs.' + Format("Requested Amount") + ' has been received' + '. And is being processed',
//                         SFactory.FnGetFosaAccount("Client Code"), SFactory.FnGetPhoneNumber(Rec));
//                         Rec.Modify;

//                     end;
//                 }
//                 action("Re-Open Application")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Re-Open Application';
//                     Image = Cancel;
//                     Promoted = true;
//                     PromotedCategory = Category4;
//                     Visible = false;

//                     trigger OnAction()
//                     var
//                         ApprovalMgt: Codeunit "Approvals Mgmt.";
//                     begin
//                         if Posted then
//                             Error('Loan is already posted');
//                         if ("Loan Status" <> "loan status"::Appraisal) then// AND ("Approval Status"<>"Approval Status"::Open) THEN
//                             Error('Loan Status Must be Appraised');
//                         "Loan Status" := "loan status"::Application;
//                         "Approval Status" := "approval status"::Open;
//                         Rec.Modify;
//                         Message('Application re-opened');
//                     end;
//                 }
//             }
//             group(Approvals)
//             {
//                 Caption = 'Approvals';
//                 action("Send Approval Request")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Send A&pproval Request';
//                     Enabled = (not OpenApprovalEntriesExist) and EnabledApprovalWorkflowsExist;
//                     Image = SendApprovalRequest;
//                     Promoted = true;
//                     PromotedCategory = Category4;
//                     PromotedOnly = true;

//                     trigger OnAction()
//                     var
//                         Text001: label 'This transaction is already pending approval';
//                         ApprovalMgt: Codeunit "Approvals Mgmt.";
//                     begin





//                         //Check Whether There are Guarantors Captured..
//                         // IF LoanType.GET("Loan Product Type") THEN BEGIN
//                         //  IF LoanType."Appraise Guarantors" THEN BEGIN
//                         //  LoanGuar.RESET;
//                         //  LoanGuar.SETRANGE("Loan No","Loan  No.");
//                         //  IF NOT LoanGuar.FIND('-') THEN
//                         //
//                         //    ObjSecurities.RESET;
//                         //    ObjSecurities.SETRANGE(ObjSecurities."Loan No","Loan  No.");
//                         //    IF ObjSecurities.FINDSET THEN
//                         //      BEGIN
//                         //      END ELSE
//                         //      ERROR('Please %1 enter guarantor Information for %2',UPPERCASE(USERID),"Client Code");
//                         //  END;
//                         //  END;
//                         //End Check for Existing Loan of the Same Product
//                         //IF  NOT "Override Appraisal Appro Amnt" THEN //-- Override Appraisal (Not Recommended)
//                         //IF (("Approved Amount"<=0) OR ("Recommended Amount"<=0)) THEN ERROR ('Kindly Appraise your loan application before sending approval request');
//                         if LoanType.Get("Loan Product Type") then begin
//                             LoansRec.Reset;
//                             LoansRec.SetRange(LoansRec."Client Code", "Client Code");
//                             LoansRec.SetRange(LoansRec."Loan Product Type", "Loan Product Type");
//                             if LoansRec.Find('-') then begin
//                                 totalLn := 0;
//                                 LoanCount := 0;
//                                 repeat
//                                     LoansRec.Rec.CalcFields(LoansRec."Outstanding Balance");
//                                     if LoansRec."Outstanding Balance" > 0 then
//                                         LoanCount := LoanCount + 1;
//                                     totalLn := totalLn + LoansRec."Outstanding Balance";
//                                 until LoansRec.Next = 0;
//                                 //    IF (totalLn>0) AND (LoanCount>=LoanType."Maximum No. Of Runing Loans") AND ("Top Up Amount"=0) THEN BEGIN
//                                 //    ERROR('The Member can only have a maximum of '+FORMAT(LoanCount)+' %1s',LoanType."Product Description");
//                                 //    END;
//                             end;
//                         end;
//                         // LoansRec.RESET;
//                         // LoansRec.SETRANGE(LoansRec."BOSA No","BOSA No");
//                         // LoansRec.SETRANGE(LoansRec."Loan Product Type","Loan Product Type");
//                         // IF LoansRec.FIND('-') THEN BEGIN
//                         // REPEAT
//                         //  IF LoansRec."Loan Product Type"<>'GUR' THEN BEGIN
//                         //      LoansRec.Rec.CalcFields(LoansRec."Outstanding Balance",LoansRec."Top Up Amount");
//                         //      IF (LoansRec."Outstanding Balance">1) AND ("Top Up Amount"=0) AND ("Loan to Reschedule"='') THEN BEGIN
//                         //      ERROR('The Member has an exsiting %1',"Loan Product Type");
//                         // END;
//                         // END;
//                         // UNTIL LoansRec.NEXT=0;
//                         // END;

//                         //Check For Same Loan Product & Offset
//                         LoanApp.Reset;
//                         LoanApp.SetRange("Client Code", "Client Code");
//                         LoanApp.SetRange(Posted, true);
//                         LoanApp.SetRange("Loan Product Type", "Loan Product Type");
//                         LoanApp.SetFilter("Outstanding Balance", '>0');
//                         if LoanApp.Find('-') then begin
//                             repeat
//                                 if ProdFac.Get("Loan Product Type") then begin
//                                     if ProdFac."Allow Multiple Running Loans" = false then begin
//                                         LoansTopup.Reset;
//                                         LoansTopup.SetRange("Loan Top Up", LoanApp."Loan  No.");
//                                         LoansTopup.SetRange("Loan No.", "Loan  No.");
//                                         if not LoansTopup.Find('-') then
//                                             Error('Member already has an existing Loan %1 of same product', LoanApp."Loan  No.");
//                                     end;
//                                 end;
//                             until LoanApp.Next = 0;
//                         end;


//                         // IF "Loan Status" <> "Loan Status"::Appraisal THEN
//                         //  ERROR('Loan must first move to appraisal before it can be sent for approval');
//                         if LoanType.Get("Loan Product Type") then begin
//                             if LoanType."Appraise Guarantors" then begin
//                                 LoanGuar.Reset;
//                                 LoanGuar.SetRange("Loan No", "Loan  No.");
//                                 if LoanGuar.Find('-') then begin
//                                     if LoanType.Get("Loan Product Type") then begin
//                                         if LoanGuar.Count < LoanType."Min No. Of Guarantors" then
//                                             Error('You must capture atleast ' + Format(LoanType."Min No. Of Guarantors") + ' guarantors for ' + "Loan Product Type");
//                                     end;
//                                 end;
//                             end;
//                         end;


//                         if "Approved Amount" = 0 then Error('Loan Must Be Upraised before sending Approval');
//                         Rec.Validate("Recovery Mode");
//                         Rec.TestField("Requested Amount");
//                         Rec.TestField("Recovery Mode");
//                         Rec.TestField("Loan Purpose");

//                         if "Loan Status" <> "loan status"::Appraisal then
//                             Error(Text002);



//                         if "Approval Status" <> "approval status"::Open then
//                             Error(Text001);

//                         if ApprovalsMgmt.CheckLoanApplicationApprovalsWorkflowEnabled(Rec) then
//                             ApprovalsMgmt.OnSendLoanApplicationForApproval(Rec);

//                         GenSetUp.Get();

//                         //................2030
//                         if GenSetUp."Send Loan App SMS" = true then begin
//                             FnSendReceivedApplicationSMS();
//                         end;



//                         // IF GenSetUp."Send Loan App Email"=TRUE THEN BEGIN
//                         //  FnSendReceivedLoanApplEmail("Loan  No.");
//                         //  END;
//                         //
//                         // IF GenSetUp."Send Guarantorship SMS"=TRUE THEN BEGIN
//                         //  FnSendGuarantorAppSMS("Loan  No.");
//                         //  END;//Commented for sending many sms to lonee and guarantor
//                     end;
//                 }
//                 action("Cancel Approval Request")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Cancel Approval Request';
//                     Enabled = CanCancelApprovalForRecord;
//                     Image = CancelApprovalRequest;
//                     Promoted = true;
//                     PromotedCategory = Category4;
//                     PromotedOnly = true;

//                     trigger OnAction()
//                     var
//                         ApprovalMgt: Codeunit "Approvals Mgmt.";
//                     begin


//                         if ApprovalsMgmt.CheckLoanApplicationApprovalsWorkflowEnabled(Rec) then
//                             ApprovalsMgmt.OnCancelLoanApplicationApprovalRequest(Rec);
//                     end;
//                 }
//                 action(Approval)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Approvals';
//                     Image = Approvals;
//                     Promoted = true;
//                     PromotedCategory = Category4;
//                     PromotedOnly = true;

//                     trigger OnAction()
//                     var
//                         ApprovalEntries: Page "Approval Entries";
//                     begin

//                         DocumentType := Documenttype::LoanApplication;
//                         ApprovalEntries.Setfilters(Database::"Loans Register", DocumentType, "Loan  No.");
//                         ApprovalEntries.Run;
//                     end;
//                 }
//                 action("Loan Arrears")
//                 {
//                     ApplicationArea = Basic;
//                     Promoted = true;
//                     PromotedCategory = "Report";
//                     PromotedIsBig = true;

//                     trigger OnAction()
//                     begin
//                         Cust.Reset;
//                         Cust.SetRange(Cust."No.", "Client Code");
//                         if Cust.Find('-') then
//                             Report.Run(51516270, true, false, Cust);
//                     end;
//                 }
//             }
//         }
//     }

//     trigger OnAfterGetCurrRecord()
//     begin
//         UpdateControl();
//         EnableCreateMember := false;
//         EditableAction := true;
//         OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
//         CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RecordId);
//         EnabledApprovalWorkflowsExist := true;
//         if Rec."Approval Status" = "approval status"::Approved then begin
//             OpenApprovalEntriesExist := false;
//             CanCancelApprovalForRecord := false;
//             EnabledApprovalWorkflowsExist := false;
//         end;
//         if (Rec."Approval Status" = "approval status"::Approved) then
//             EnableCreateMember := true;

//         if Rec."Approval Status" <> "approval status"::Open then
//             EditableAction := false;
//     end;

//     trigger OnAfterGetRecord()
//     begin
//         Source := Source::BOSA;
//     end;

//     trigger OnInsertRecord(BelowxRec: Boolean): Boolean
//     begin
//         LoansR.Reset;
//         LoansR.SetRange(LoansR.Posted, false);
//         LoansR.SetRange(LoansR."Captured By", UserId);
//         LoansR.SetRange("Loan Status", "loan status"::Approved);
//         if LoansR."Client Name" = '' then begin
//             if LoansR.Count > 1 then begin
//                 if Confirm('There are still some Unused Loan Nos. Continue?', false) = false then begin
//                     Error('There are still some Unused Loan Nos. Please utilise them first');
//                 end;
//             end;
//         end;
//     end;

//     trigger OnRec.ModifyRecord(): Boolean
//     begin
//         LoanAppPermisions();
//     end;

//     trigger OnNewRecord(BelowxRec: Boolean)
//     begin
//         Source := Source::BOSA;
//         "Mode of Disbursement" := "mode of disbursement"::"Bank Transfer";
//         Discard := Discard::"1";

//         //Check Application Of the Same Loan Product
//         LoansRec.Reset;
//         LoansRec.SetRange(LoansRec."BOSA No", "BOSA No");
//         LoansRec.SetRange(LoansRec."Loan Product Type", "Loan Product Type");
//         if LoansRec.Find('-') then begin
//             repeat
//                 if LoansRec."Loan Product Type" <> 'GUR' then begin
//                     LoansRec.Rec.CalcFields(LoansRec."Outstanding Balance", LoansRec."Top Up Amount");
//                     if (LoansRec."Outstanding Balance" > 1) and ("Top Up Amount" = 0) and ("Loan to Reschedule" = '') then begin
//                         Error('The Member has an exsiting %1', "Loan Product Type");
//                     end;
//                 end;
//             until LoansRec.Next = 0;
//         end;
//     end;

//     trigger OnNextRecord(Steps: Integer): Integer
//     begin
//         /*IF "Loan Status"="Loan Status"::Approved THEN
//         CurrPage.EDITABLE:=FALSE; */

//     end;

//     trigger OnOpenPage()
//     begin
//         //SETRANGE(Posted,FALSE);
//         /*IF "Loan Status"="Loan Status"::Approved THEN
//         CurrPage.EDITABLE:=FALSE;*/
//         if "Loan Status" = "loan status"::Application then
//             ActionVisible := true;

//     end;

//     var
//         i: Integer;
//         LoanType: Record UnknownRecord51516381;
//         PeriodDueDate: Date;
//         ScheduleRep: Record UnknownRecord51516375;
//         LoanGuar: Record UnknownRecord51516372;
//         RunningDate: Date;
//         G: Integer;
//         IssuedDate: Date;
//         SMSMessages: Record UnknownRecord51516471;
//         iEntryNo: Integer;
//         GracePeiodEndDate: Date;
//         InstalmentEnddate: Date;
//         GracePerodDays: Integer;
//         InstalmentDays: Integer;
//         NoOfGracePeriod: Integer;
//         NewSchedule: Record UnknownRecord51516375;
//         RSchedule: Record UnknownRecord51516375;
//         GP: Text[30];
//         ScheduleCode: Code[20];
//         PreviewShedule: Record UnknownRecord51516375;
//         PeriodInterval: Code[10];
//         CustomerRecord: Record UnknownRecord51516364;
//         Gnljnline: Record "Gen. Journal Line";
//         Jnlinepost: Codeunit "Gen. Jnl.-Post Line";
//         CumInterest: Decimal;
//         NewPrincipal: Decimal;
//         PeriodPrRepayment: Decimal;
//         GenBatch: Record "Gen. Journal Batch";
//         LineNo: Integer;
//         GnljnlineCopy: Record "Gen. Journal Line";
//         NewLNApplicNo: Code[10];
//         Cust: Record UnknownRecord51516364;
//         LoanApp: Record UnknownRecord51516371;
//         TestAmt: Decimal;
//         CustRec: Record UnknownRecord51516364;
//         CustPostingGroup: Record "Customer Posting Group";
//         GenSetUp: Record UnknownRecord51516398;
//         PCharges: Record UnknownRecord51516383;
//         TCharges: Decimal;
//         LAppCharges: Record UnknownRecord51516385;
//         LoansR: Record UnknownRecord51516371;
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
//         LoanTopUp: Record UnknownRecord51516376;
//         Vend: Record Vendor;
//         BOSAInt: Decimal;
//         TopUpComm: Decimal;
//         DActivity: Code[20];
//         DBranch: Code[20];
//         TotalTopupComm: Decimal;
//         CustE: Record UnknownRecord51516364;
//         DocN: Text[50];
//         DocM: Text[100];
//         DNar: Text[250];
//         DocF: Text[50];
//         MailBody: Text[250];
//         ccEmail: Text[250];
//         LoanG: Record UnknownRecord51516372;
//         SpecialComm: Decimal;
//         FOSAName: Text[150];
//         IDNo: Code[50];
//         MovementTracker: Record UnknownRecord51516394;
//         DiscountingAmount: Decimal;
//         StatusPermissions: Record UnknownRecord51516452;
//         BridgedLoans: Record UnknownRecord51516379;
//         SMSMessage: Record UnknownRecord51516471;
//         InstallNo2: Integer;
//         currency: Record "Currency Exchange Rate";
//         CURRENCYFACTOR: Decimal;
//         LoanApps: Record UnknownRecord51516371;
//         LoanDisbAmount: Decimal;
//         BatchTopUpAmount: Decimal;
//         BatchTopUpComm: Decimal;
//         Disbursement: Record UnknownRecord51516377;
//         SchDate: Date;
//         DisbDate: Date;
//         WhichDay: Integer;
//         LBatches: Record UnknownRecord51516371;
//         SalDetails: Record UnknownRecord51516373;
//         LGuarantors: Record UnknownRecord51516372;
//         Text001: label 'Status Must Be Open';
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
//         TAXABLEPAY: Record UnknownRecord51516478;
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
//         PartPay: Record UnknownRecord51516494;
//         PartPayTotal: Decimal;
//         AmountPayable: Decimal;
//         RepaySched: Record UnknownRecord51516375;
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
//         LoansRec: Record UnknownRecord51516371;
//         RecoveryModeEditable: Boolean;
//         RemarksEditable: Boolean;
//         CopyofIDEditable: Boolean;
//         CopyofPayslipEditable: Boolean;
//         LoanAppMessage: label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:9pt">Welcome to Nafaka Sacco</p><p style="font-family:Verdana,Arial;font-size:9pt">This is to confirm that your Loan Application has been received and Undergoing Approval</p><p style="font-family:Verdana,Arial;font-size:9pt"> </b></p><br>Regards<p>%3</p><p><b>Nafaka Sacco Ltd</b></p>';
//         ScheduleBal: Decimal;
//         OpenApprovalEntriesExist: Boolean;
//         EnabledApprovalWorkflowsExist: Boolean;
//         CanCancelApprovalForRecord: Boolean;
//         EventFilter: Text;
//         EnableCreateMember: Boolean;
//         EditableAction: Boolean;
//         SFactory: Codeunit UnknownCodeunit51516007;
//         SMSMessageText: label 'Your loan application of KSHs.%1 has been received and your qualification is KSHs.%2 The application is being processed.%3.';
//         totalLn: Decimal;
//         LoanCount: Integer;
//         ActionVisible: Boolean;
//         ObjSecurities: Record UnknownRecord51516374;
//         BoostingVisible: Boolean;
//         LoanOffsetDetails: Record UnknownRecord51516376;
//         ProdFac: Record UnknownRecord51516381;
//         LoansTopup: Record UnknownRecord51516376;
//         Text002: label 'Kindly Appraisal Loan First ';


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
//             LoanReferee1NameEditable := true;
//             LoanReferee2NameEditable := true;
//             LoanReferee1MobileEditable := true;
//             LoanReferee2MobileEditable := true;
//             LoanReferee1AddressEditable := true;
//             LoanReferee2AddressEditable := true;
//             LoanReferee1PhyAddressEditable := true;
//             LoanReferee2PhyAddressEditable := true;
//             LoanReferee1RelationEditable := true;
//             LoanReferee2RelationEditable := true;
//             WitnessEditable := true;
//             LoanPurposeEditable := true;
//             RecoveryModeEditable := true;
//             RemarksEditable := true;
//             LoanPurposeEditable := true;
//             CopyofIDEditable := true;
//             CopyofPayslipEditable := true;
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
//             LoanReferee1NameEditable := false;
//             LoanReferee2NameEditable := false;
//             LoanReferee1MobileEditable := false;
//             LoanReferee2MobileEditable := false;
//             LoanReferee1AddressEditable := false;
//             LoanReferee2AddressEditable := false;
//             LoanReferee1PhyAddressEditable := false;
//             LoanReferee2PhyAddressEditable := false;
//             LoanReferee1RelationEditable := false;
//             LoanReferee2RelationEditable := false;
//             WitnessEditable := false;
//             LoanPurposeEditable := false;
//             RecoveryModeEditable := false;
//             RemarksEditable := false;
//             LoanPurposeEditable := false;
//             CopyofIDEditable := false;
//             CopyofPayslipEditable := false;
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
//             LoanReferee1NameEditable := false;
//             LoanReferee2NameEditable := false;
//             LoanReferee1MobileEditable := false;
//             LoanReferee2MobileEditable := false;
//             LoanReferee1AddressEditable := false;
//             LoanReferee2AddressEditable := false;
//             LoanReferee1PhyAddressEditable := false;
//             LoanReferee2PhyAddressEditable := false;
//             LoanReferee1RelationEditable := false;
//             LoanReferee2RelationEditable := false;
//             WitnessEditable := false;
//             LoanPurposeEditable := false;
//             RecoveryModeEditable := false;
//             RemarksEditable := false;
//             LoanPurposeEditable := false;
//             CopyofIDEditable := false;
//             CopyofPayslipEditable := false;
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
//             LoanReferee1NameEditable := false;
//             LoanReferee2NameEditable := false;
//             LoanReferee1MobileEditable := false;
//             LoanReferee2MobileEditable := false;
//             LoanReferee1AddressEditable := false;
//             LoanReferee2AddressEditable := false;
//             LoanReferee1PhyAddressEditable := false;
//             LoanReferee2PhyAddressEditable := false;
//             LoanReferee1RelationEditable := false;
//             LoanReferee2RelationEditable := false;
//             WitnessEditable := false;
//             LoanPurposeEditable := false;
//             RecoveryModeEditable := false;
//             RemarksEditable := false;
//             LoanPurposeEditable := false;
//         end;
//     end;


//     procedure LoanAppPermisions()
//     begin
//     end;


//     procedure FnSendReceivedApplicationSMS()
//     begin

//         GenSetUp.Get;
//         compinfo.Get;



//         //SMS MESSAGE
//         SMSMessage.Reset;
//         if SMSMessage.Find('+') then begin
//             iEntryNo := SMSMessage."Entry No";
//             iEntryNo := iEntryNo + 1;
//         end
//         else begin
//             iEntryNo := 1;
//         end;


//         SMSMessage.Init;
//         SMSMessage."Entry No" := iEntryNo;
//         SMSMessage."Batch No" := "Batch No.";
//         SMSMessage."Document No" := "Loan  No.";
//         SMSMessage."Account No" := "Account No";
//         SMSMessage."Date Entered" := Today;
//         SMSMessage."Time Entered" := Time;
//         SMSMessage.Source := 'LOANAPP';
//         SMSMessage."Entered By" := UserId;
//         SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
//         SMSMessage."SMS Message" := 'Dear ' + "Client Name" + ' ,we acknowledge receipt of your duly filled ' + "Loan Product Type Name" + ' application Form of Kshs. '
//         + Format("Requested Amount") + ' .Processing is ongoing. Thank you. '
//         + compinfo.Name + ' ' + compinfo."Phone No.";
//         Cust.Reset;
//         Cust.SetRange(Cust."No.", "Client Code");
//         if Cust.Find('-') then begin
//             SMSMessage."Telephone No" := Cust."Mobile Phone No";
//         end;
//         if Cust."Mobile Phone No" <> '' then
//             SMSMessage.Insert;
//     end;

//     local procedure FnSendReceivedLoanApplEmail(LoanNo: Code[20])
//     var
//         LoanRec: Record UnknownRecord51516371;
//         SMTPMail: Codeunit UnknownCodeunit400;
//         SMTPSetup: Record "SMTP Mail Setup";
//         FileName: Text[100];
//         Attachment: Text[250];
//         CompanyInfo: Record "Company Information";
//         Cust: Record UnknownRecord51516364;
//         Email: Text[50];
//     begin
//         SMTPSetup.Get();

//         LoanRec.Reset;
//         LoanRec.SetRange(LoanRec."Loan  No.", LoanNo);
//         if LoanRec.Find('-') then begin
//             if Cust.Get(LoanRec."Client Code") then begin
//                 Email := Cust."E-Mail (Personal)";
//                 if Cust."E-Mail (Personal)" <> '' then begin

//                     if Email = '' then begin
//                         Error('Email Address Missing for LoanRecer Application number' + '-' + LoanRec."Loan  No.");
//                     end;
//                     if Email <> '' then
//                         SMTPMail.CreateMessage(SMTPSetup."Email Sender Name", SMTPSetup."Email Sender Address", Email, 'Loan Application', '', true);
//                     SMTPMail.AppendBody(StrSubstNo(LoanAppMessage, LoanRec."Client Name", IDNo, UserId));
//                     SMTPMail.AppendBody(SMTPSetup."Email Sender Name");
//                     SMTPMail.AppendBody('<br><br>');
//                     SMTPMail.AddAttachment(FileName, Attachment);
//                     SMTPMail.Send;
//                 end;
//             end;
//         end;
//     end;

//     local procedure FnSendGuarantorAppSMS(LoanNo: Code[20])
//     var
//         Cust: Record UnknownRecord51516364;
//         Sms: Record UnknownRecord51516471;
//     begin
//         /*LGuarantors.RESET;
//            LGuarantors.SETRANGE(LGuarantors."Loan No","Loan  No.");
//            IF LGuarantors.FINDFIRST THEN BEGIN
//            REPEAT
//            IF Cust.GET(LGuarantors."Member No") THEN
//            IF  Cust."Mobile Phone No"<>'' THEN
//               //SMS MESSAGE
//               SMSMessage.RESET;
//               IF SMSMessage.FIND('+') THEN BEGIN
//               iEntryNo:=SMSMessage."Entry No";
//               iEntryNo:=iEntryNo+1;
//               END
//               ELSE BEGIN
//               iEntryNo:=1;
//               END;
        
        
//               SMSMessage.INIT;
//               SMSMessage."Entry No":=iEntryNo;
//               SMSMessage."Batch No":="Batch No.";
//               SMSMessage."Document No":="Loan  No.";
//               SMSMessage."Account No":="Account No";
//               SMSMessage."Date Entered":=TODAY;
//               SMSMessage."Time Entered":=TIME;
//               SMSMessage.Source:='GUARANTORSHIP';
//               SMSMessage."Entered By":=USERID;
//               SMSMessage."Sent To Server":=SMSMessage."Sent To Server"::No;
//               SMSMessage."SMS Message":=('Dear '+LoanGuar.Name+' ,You have guaranteed M/No: '+"Client Code"+ '-' +"Client Name"+' a '+"Loan Product Type Name"+' of amount Kshs. '+FORMAT("Requested Amount")
//                     +'. For any queries call '+ compinfo."Phone No." +'.Thank You. '+ compinfo.Name);
//               Cust.SETRANGE(Cust."No.",LGuarantors."Member No");
//               IF Cust.FIND('-') THEN BEGIN
//               SMSMessage."Telephone No":=Cust."Mobile Phone No";
//               END;
//               IF Cust."Mobile Phone No"<>'' THEN
//               SMSMessage.INSERT;
        
//          UNTIL LGuarantors.NEXT =0;
//            END
//            */

//     end;
// }

