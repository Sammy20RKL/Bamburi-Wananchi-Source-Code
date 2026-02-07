// /// <summary>
// /// Page HR Leave Application Card (ID 51532047).
// /// </summary>
// page 70047 "HR Leave Application Card"
// {
//     // version HRMIS 2016 VRS1.0

//     DeleteAllowed = false;
//     PageType = Card;
//     PromotedActionCategories = 'New,Process,Report,Functions';
//     SourceTable = "HR Leave Application";
//     ApplicationArea = All;
//     UsageCategory = Lists;

//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 Caption = 'General';
//                 field("Application Code"; Rec."Application Code")
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Application No';
//                     Editable = false;
//                     Importance = Promoted;

//                     // trigger OnValidate();
//                     // begin
//                     //     CurrPage.UPDATE;
//                     // end;
//                 }
//                 field("Application Date"; Rec."Application Date")
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                 }
//                 field("Applicant Staff No."; Rec."Applicant Staff No.")
//                 {
//                     ApplicationArea = All;
//                     Caption = 'No.';
//                     // Enabled = false;
//                     // Importance = Promoted;
//                 }
//                 field("Names"; Rec."Names")
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Name';
//                     Editable = false;
//                     Importance = Promoted;
//                 }
//                 field("Job Tittle"; Rec."Job Tittle")
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Job Title';
//                     Editable = false;
//                     Importance = Promoted;
//                 }
//                 field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                     Caption = 'Department';
//                 }
//                 field("Applicant Supervisor"; Rec."Applicant Supervisor")
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                 }
//                 field("Responsibility Center"; Rec."Responsibility Center")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Supervisor Email"; Rec."Supervisor Email")
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                 }
//                 field("**"; '')
//                 {
//                     Caption = '*';
//                 }
//                 field("Leave Calendar Code"; Rec."Leave Calendar Code")
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field("Leave Type"; Rec."Leave Type")
//                 {
//                     ApplicationArea = All;
//                     Importance = Promoted;
//                     ShowMandatory = true;

//                     trigger OnValidate();
//                     begin
//                         GetLeaveStats(Rec."Leave Type");
//                     end;
//                 }
//                 field("Days Applied"; Rec."Days Applied")
//                 {
//                     ApplicationArea = All;
//                     Importance = Promoted;
//                     ShowMandatory = true;

//                     trigger OnValidate();
//                     begin
//                         IF Rec."Days Applied" > dLeft THEN ERROR('Days applied exceeds Leave balance');
//                         //Message('Full Emp Name is %1', HREmp.fullname());
//                     end;
//                 }
//                 field("Start Date"; Rec."Start Date")
//                 {
//                     ApplicationArea = All;
//                     Importance = Promoted;
//                     ShowMandatory = true;
//                 }
//                 field("Return Date"; Rec."Return Date")
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                 }
//                 field("***"; '')
//                 {
//                     Caption = '*';
//                 }
//                 field(dAlloc; dAlloc)
//                 {
//                     Caption = 'Allocated days';
//                     Editable = false;
//                 }
//                 field(dEarnd; dEarnd)
//                 {
//                     Caption = 'Total Leave Days';
//                     Editable = false;
//                     Style = Strong;
//                     Visible = false;
//                     StyleExpr = TRUE;
//                 }
//                 field(dTaken; dTaken)
//                 {
//                     Caption = 'Total Leave Taken';
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                 }
//                 field(dLeft; dLeft)
//                 {
//                     Caption = 'Leave Balance';
//                     Editable = false;
//                     Enabled = false;
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                 }
//                 field("****"; '')
//                 {
//                     Caption = '*';
//                 }
//                 field("Reliever"; Rec."Reliever")
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Reliever Code';
//                     ShowMandatory = true;
//                 }
//                 field("Reliever Name"; Rec."Reliever Name")
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                 }
//                 field("Applicant Comments"; Rec."Applicant Comments")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Approver Comments"; Rec."Approver Comments")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("*****"; '')
//                 {
//                     Caption = '*';
//                 }
//                 field("Posted"; Rec."Posted")
//                 {
//                     ApplicationArea = All;
//                     Enabled = false;
//                 }
//                 field("Posted By"; Rec."Posted By")
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                 }
//                 field("Date Posted"; Rec."Date Posted")
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                 }
//                 field("Time Posted"; Rec."Time Posted")
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                 }
//                 field("Status"; Rec."Status")
//                 {
//                     ApplicationArea = All;
//                     Style = Attention;
//                     Editable = false;
//                     StyleExpr = TRUE;
//                     trigger OnValidate()
//                     begin
//                         CurrPage.UPDATE; // refresh the page UI
//                     end;
//                 }
//             }
//             group("More Leave Details")
//             {
//                 Caption = 'More Leave Details';
//                 field("Cell Phone Number"; Rec."Cell Phone Number")
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Other Cell Phone Number';
//                     Importance = Promoted;
//                 }
//                 field("E-mail Address"; Rec."E-mail Address")
//                 {
//                     ApplicationArea = All;
//                     Editable = true;
//                     Importance = Promoted;
//                 }
//                 field("Details of Examination"; Rec."Details of Examination")
//                 {
//                     ApplicationArea = All;
//                     Importance = Promoted;
//                 }
//                 field("Date of Exam"; Rec."Date of Exam")
//                 {
//                     ApplicationArea = All;
//                     Importance = Promoted;
//                 }
//                 field("Number of Previous Attempts"; Rec."Number of Previous Attempts")
//                 {
//                     ApplicationArea = All;
//                 }
//             }
//         }
//         area(factboxes)
//         {
//             systempart(Outlook; Outlook)
//             {
//                 ApplicationArea = All;
//             }
//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             group("Approval Request")
//             {
//                 Caption = 'Approval Request';
//                 action(SendApprovalRequest)
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Send Approval Request';
//                     Image = SendApprovalRequest;
//                     Promoted = true;
//                     PromotedCategory = Category4;
//                     PromotedIsBig = true;

//                     trigger OnAction();
//                     var
//                         VarVariant: Variant;
//                         CustomApprovals: Codeunit "Custom Approvals Codeunit";
//                     begin
//                         Rec.TESTFIELD("Start Date");
//                         Rec.TESTFIELD("Days Applied");
//                         Rec.TESTFIELD(Reliever);

//                         /*IF ApprovalsMgmt.CheckLeaveApprovalsWorkflowEnabled(Rec) THEN
//                           ApprovalsMgmt.OnSendLeaveForApproval(Rec);*/
//                         VarVariant := Rec;
//                         IF CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) THEN begin
//                             CustomApprovals.OnSendDocForApproval(VarVariant);
//                             Message('Approval Request Sent!');
//                             CurrPage.Close();
//                         end;

//                     end;
//                 }
//                 action("Cancel Approval Request")
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Cancel Approval Request';
//                     Promoted = true;
//                     PromotedCategory = Category4;
//                     PromotedIsBig = true;

//                     trigger OnAction();
//                     var
//                         VarVariant: Variant;
//                         CustomApprovals: Codeunit "Custom Approvals Codeunit";
//                     begin
//                         /*ApprovalsMgmt.OnCancelLeaveApprovalRequest(Rec);*/
//                         VarVariant := Rec;
//                         CustomApprovals.OnCancelDocApprovalRequest(VarVariant);

//                     end;
//                 }
//                 action(Approvals)
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Approvals';
//                     Image = Approvals;
//                     Promoted = true;
//                     PromotedCategory = Category4;

//                     trigger OnAction();
//                     var
//                         Approvalentries: Page "Approval Entries";
//                     begin
//                         ApprovalsMgmt.OpenApprovalEntriesPage(Rec.RECORDID);
//                         /*DocumentType:=DocumentType::Leave;
//                         Approvalentries.Setfilters(DATABASE::"HR Leave Application",DocumentType,"Application Code");
//                         Approvalentries.RUN;*/

//                     end;
//                 }
//             }
//             group(Approval)
//             {
//                 Caption = 'Approval';
//                 action(Approve)
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Approve';
//                     Image = Approve;
//                     Promoted = true;
//                     PromotedCategory = Category4;
//                     PromotedIsBig = true;
//                     Visible = OpenApprovalEntriesExistForCurrUser;

//                     trigger OnAction();
//                     var
//                         ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//                     begin
//                         ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RECORDID);
//                     end;
//                 }
//                 action(Reject)
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Reject';
//                     Image = Reject;
//                     Promoted = true;
//                     PromotedCategory = Category4;
//                     PromotedIsBig = true;
//                     Visible = OpenApprovalEntriesExistForCurrUser;

//                     trigger OnAction();
//                     var
//                         ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//                     begin
//                         ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RECORDID);
//                     end;
//                 }
//                 action(Delegate)
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Delegate';
//                     Image = Delegate;
//                     Promoted = true;
//                     PromotedCategory = Category4;
//                     Visible = OpenApprovalEntriesExistForCurrUser;

//                     trigger OnAction();
//                     var
//                         ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//                     begin
//                         ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RECORDID);
//                     end;
//                 }
//             }
//             group(Reliver)
//             {
//                 Caption = 'Reliver';
//                 action("Additional Reliver")
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Additional Reliver';
//                     Image = Employee;
//                     Promoted = true;
//                     PromotedCategory = Category4;
//                     RunObject = Page "HR Leave Reliver";
//                     RunPageLink = "leave No" = FIELD("Application Code"),
//                                   Employee = FIELD("Applicant Staff No.");
//                 }
//             }
//             group(Posting)
//             {
//                 Visible = IsApproved;
//                 action(Post)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Post Leave';
//                     Image = Post;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     PromotedOnly = true;
//                     ShortcutKey = 'F11';
//                     // Enabled = IsApproved;

//                     trigger OnAction()
//                     begin
//                         if Confirm('Are you sure you want to post this leave now?') then begin
//                             CreateLeaveLedgerEntries();
//                             CurrPage.Close();
//                         end;

//                     end;
//                 }
//             }
//         }
//     }

//     trigger OnAfterGetRecord();
//     begin
//         //Get Employee Details
//         //FillVariables;

//         if Rec.Status = Rec.Status::Approved then
//             IsApproved := true
//         else
//             IsApproved := false;

//         //Message('IsApproved status is %1:', IsApproved);

//         UserSetup.RESET;
//         UserSetup.SETRANGE("User ID", USERID);
//         IF UserSetup.FINDFIRST THEN Rec."Responsibility Center" := UserSetup."Responsibility Center";

//         //Get leave statistics
//         GetLeaveStats(Rec."Leave Type");

//         //Approvals
//         SetControlAppearance;
//     end;

//     trigger OnAfterGetCurrRecord()
//     begin
//         if Rec.Status = Rec.Status::Approved then
//             IsApproved := true
//         else
//             IsApproved := false;
//     end;

//     trigger OnInsertRecord(BelowxRec: Boolean): Boolean;
//     begin
//         HRLeaveCal.RESET;
//         HRLeaveCal.SETRANGE(HRLeaveCal."Current Leave Calendar", TRUE);
//         IF HRLeaveCal.FIND('-') THEN Rec."Leave Calendar Code" := HRLeaveCal."Calendar Code";

//         HRLeaveApp.RESET;
//         HRLeaveApp.SETRANGE(HRLeaveApp.Status, HRLeaveApp.Status::New);
//         HRLeaveApp.SETRANGE(HRLeaveApp."Applicant User ID", USERID);
//         IF HRLeaveApp.FIND('-') THEN BEGIN
//             IF HRLeaveApp.COUNT > 0 THEN BEGIN
//                 ERROR('There are still some un-utilized Leave Application Documents [ %1 ]. Please utilise them first'
//                       , HRLeaveApp."Application Code");
//             END;
//         END;
//     end;

//     trigger OnOpenPage();
//     begin
//         GetLeaveStats(Rec."Leave Type");
//         UserSetup.RESET;
//         UserSetup.SETRANGE("User ID", USERID);
//         IF UserSetup.FINDFIRST THEN Rec."Responsibility Center" := UserSetup."Responsibility Center";

//         IF (Rec.Status = Rec.Status::Approved) OR (Rec.Status = Rec.Status::Pending) THEN
//             CurrPage.EDITABLE := FALSE;
//         if Rec.Status = Rec.Status::Approved then
//             IsApproved := true
//         else
//             IsApproved := false;

//     end;

//     procedure CreateLeaveLedgerEntries()
//     begin
//         IF Rec.Status = Rec.Status::Posted THEN
//             ERROR('Leave Already posted');
//         HRSetup.RESET;
//         IF HRSetup.FIND('-') THEN BEGIN
//             LeaveGjline.RESET;
//             LeaveGjline.SETRANGE("Journal Template Name", HRSetup."Leave Template");
//             LeaveGjline.SETRANGE("Journal Batch Name", HRSetup."Leave Batch");
//             LeaveGjline.DELETEALL;
//             //Dave
//             HRSetup.TESTFIELD(HRSetup."Leave Template");
//             HRSetup.TESTFIELD(HRSetup."Leave Batch");
//             "LineNo." := 10000;
//             LeaveGjline.INIT;
//             LeaveGjline."Journal Template Name" := HRSetup."Leave Template";
//             LeaveGjline."Journal Batch Name" := HRSetup."Leave Batch";
//             LeaveGjline."Line No." := "LineNo.";
//             LeaveGjline."Leave Period" := FORMAT(DATE2DMY(TODAY, 3));
//             LeaveGjline."Leave Application No." := Rec."Application Code";
//             LeaveGjline."Document No." := Rec."Application Code";
//             LeaveGjline."Staff No." := Rec."Applicant Staff No.";
//             LeaveGjline.VALIDATE(LeaveGjline."Staff No.");
//             LeaveGjline."Posting Date" := TODAY;
//             LeaveGjline."Leave Entry Type" := LeaveGjline."Leave Entry Type"::Negative;
//             //LeaveGjline."Leave Approval Date" := TODAY;
//             LeaveGjline.Description := 'Leave Taken';
//             LeaveGjline."Leave Type" := rec."Leave Type";
//             LeaveGjline."Leave Calendar Code" := Rec."Leave Calendar Code";
//             LeaveGjline."Leave Period Start Date" := Rec."Start Date";
//             LeaveGjline."Leave Period End Date" := Rec."End Date";

//             //Message('lEAVE CALENDAR CODE %1', LeaveGjline."Leave Calendar Code");

//             HRSetup.TESTFIELD(HRSetup."Leave Posting Period[FROM]");
//             HRSetup.TESTFIELD(HRSetup."Leave Posting Period[TO]");
//             //------------------------------------------------------------
//             // LeaveGjline."Leave Period Start Date" := HRSetup."Leave Posting Period[FROM]";
//             // LeaveGjline."Leave Period End Date" := HRSetup."Leave Posting Period[TO]";
//             LeaveGjline."No. of Days" := Rec."Approved days" * -1;
//             IF LeaveGjline."No. of Days" <> 0 THEN
//                 LeaveGjline.INSERT(TRUE);

//             //Post Journal
//             LeaveGjline.RESET;
//             LeaveGjline.SETRANGE("Journal Template Name", HRSetup."Leave Template");
//             LeaveGjline.SETRANGE("Journal Batch Name", HRSetup."Leave Batch");
//             IF LeaveGjline.FIND('-') THEN BEGIN
//                 CODEUNIT.RUN(CODEUNIT::"HR Leave Jnl.-Post", LeaveGjline);
//             END;
//             Rec.Status := Rec.Status::Posted;
//             Rec."Posting Date" := TODAY;
//             Rec.Posted := true;
//             Rec."Posted By" := USERID;
//             Rec."Time Posted" := TIME;

//             Rec.MODIFY;
//         END;

//     end;

//     var
//         HREmp: Record "HR Employees";
//         EmpJobDesc: Text[50];
//         //HRJobs: Record "HR Jobs";
//         LeaveGjline: Record "HR Journal Line";

//         SupervisorName: Text[60];
//         // SMTP : Codeunit "400";
//         URL: Text[500];

//         IsApproved: Boolean;
//         dAlloc: Decimal;
//         dEarnd: Decimal;
//         dTaken: Decimal;

//         dLeft: Decimal;
//         cReimbsd: Decimal;
//         cPerDay: Decimal;
//         cbf: Decimal;
//         HRSetup: Record "HR Setup";
//         EmpDimension_1: Text[60];
//         EmpDimension_2: Text[60];
//         HRLeaveApp: Record "HR Leave Application";
//         HRLeaveApp2: Record "HR Leave Application";

//         HRLeaveLedgerEntries: Record "HR Leave Ledger Entries";
//         EmpName: Text[70];
//         ApprovalComments: Page "Approval Comments";
//         NoSeriesMgt: Codeunit NoSeriesManagement;
//         UserSetup: Record "User Setup";
//         varDaysApplied: Integer;
//         HRLeaveTypes: Record "HR Leave Types";
//         BaseCalendarChange: Record "Base Calendar Change";
//         ReturnDateLoop: Boolean;
//         mSubject: Text[250];
//         ApplicantsEmail: Text[30];
//         //LeaveGjline: Record "HR Leave Journal Line";
//         "LineNo.": Integer;
//         sDate: Record 2000000007;
//         Customized: Record "HR Leave Calendar Lines";
//         HREmailParameters: Record "HR E-Mail Parameters";
//         HRJournalBatch: Record "HR Leave Journal Batch";
//         ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//         HRLeaveCal: Record "HR Leave Calendar";
//         OpenApprovalEntriesExistForCurrUser: Boolean;
//         OpenApprovalEntriesExist: Boolean;
//         ShowWorkflowStatus: Boolean;
//         DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batches,Loan,Checkoff,"FOSA Account Opening",StandingOrder,HRJob,HRLeave,"HRTransport Request",HRTraining,"HREmp Requsition",MicroTrans,"Account Reactivation","Overdraft ",BLA,"Member Editable","MSacco Applications","MSacco PinChange","MSacco PhoneChange","MSacco TransChange",BulkSMS,"Payment Voucher","Petty Cash",Imp,Requisition,ImpSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Bank Slip",Leave;

//     /// <summary>
//     /// FillVariables.
//     /// </summary>
//     procedure FillVariables();
//     begin
//         //Only modify document if status is not NEW
//         IF Rec.Status <> Rec.Status::New THEN BEGIN
//             //Fill Employee Details

//         END;
//     end;

//     /// <summary>
//     /// GetLeaveStats.
//     /// </summary>
//     /// <param name="LeaveType">Text[50].</param>
//     procedure GetLeaveStats(LeaveType: Text[50]);
//     begin

//         dAlloc := 0;
//         dEarnd := 0;
//         dTaken := 0;
//         dLeft := 0;
//         cReimbsd := 0;
//         cPerDay := 0;
//         cbf := 0;

//         // HREmp.RESET;
//         IF HREmp.GET(Rec."Applicant Staff No.") THEN BEGIN

//             HRLeaveCal.RESET;
//             HRLeaveCal.SETRANGE(HRLeaveCal."Current Leave Calendar", TRUE);
//             IF NOT HRLeaveCal.FIND('-') THEN ERROR('Leave Calendar not setup');

//             //Filter by Leave Period from HR Setup

//             HRLeaveLedgerEntries.RESET;
//             HRLeaveLedgerEntries.SETRANGE(HRLeaveLedgerEntries."Staff No.", Rec."Applicant Staff No.");
//             HRLeaveLedgerEntries.SETFILTER(HRLeaveLedgerEntries."Leave Entry Type", '%1|%2', HRLeaveLedgerEntries."Leave Entry Type"::Positive, HRLeaveLedgerEntries."Leave Entry Type"::Reimbursement);
//             HRLeaveLedgerEntries.SETRANGE(HRLeaveLedgerEntries."Leave Period", HRLeaveCal."Calendar Code");
//             HRLeaveLedgerEntries.SETRANGE(HRLeaveLedgerEntries."Leave Type", LeaveType);
//             //dAlloc := 0;
//             if HRLeaveLedgerEntries.FindSet() then
//                 repeat
//                     dAlloc += HRLeaveLedgerEntries."No. of days";
//                 until HRLeaveLedgerEntries.Next() = 0;
//             //Message('Days Allocated of %1', dalloc);

//             // Days Taken
//             dTaken := 0;
//             HRLeaveLedgerEntries.RESET;
//             HRLeaveLedgerEntries.SETRANGE("Staff No.", Rec."Applicant Staff No.");
//             HRLeaveLedgerEntries.SETFILTER("Leave Entry Type", '%1', HRLeaveLedgerEntries."Leave Entry Type"::Negative);
//             HRLeaveLedgerEntries.SETRANGE(HRLeaveLedgerEntries."Leave Period", HRLeaveCal."Calendar Code");
//             HRLeaveLedgerEntries.SETRANGE("Leave Type", LeaveType);

//             IF HRLeaveLedgerEntries.FINDSET() THEN
//                 REPEAT
//                     dTaken += ABS(HRLeaveLedgerEntries."No. of days");
//                 UNTIL HRLeaveLedgerEntries.NEXT = 0;

//             // Message('Days taken total of %1', dTaken);
//             //Leave Balance

//             dEarnd := dAlloc + dTaken;
//             dLeft := dAlloc - dTaken;

//             //Reimbursed Leave Days
//             cbf := HREmp."Reimbursed Leave Days";
//             cReimbsd := HREmp."Cash - Leave Earned";
//             cPerDay := HREmp."Cash per Leave Day";

//         END;
//         /*

//         IF HREmp.GET("Applicant Staff No.") THEN
//         BEGIN
//             HREmp.SETFILTER(HREmp."Leave Type Filter",LeaveType);
//             HREmp.CALCFIELDS(HREmp."Allocated Leave Days");
//             dAlloc := HREmp."Allocated Leave Days";
//             //message(format(dAlloc));
//             HREmp.VALIDATE(HREmp."Allocated Leave Days");
//             dEarnd := HREmp."Total (Leave Days)";
//             HREmp.CALCFIELDS(HREmp."Total Leave Taken");
//             dTaken := HREmp."Total Leave Taken";
//               //dLeft:= dAlloc+dTaken;
//             dLeft :=  HREmp."Leave Balance";
//             cReimbsd :=HREmp."Cash - Leave Earned";
//             cPerDay := HREmp."Cash per Leave Day" ;
//             HREmp.CALCFIELDS(HREmp."Reimbursed Leave Days");
//             cbf:=HREmp."Reimbursed Leave Days";
//         END; */

//     end;

//     /// <summary>
//     /// TESTFIELDS.
//     /// </summary>
//     procedure TESTFIELDS();
//     begin
//         Rec.TESTFIELD("Leave Type");
//         Rec.TESTFIELD("Days Applied");
//         Rec.TESTFIELD("Start Date");
//         Rec.TESTFIELD(Reliever);
//         Rec.TESTFIELD("Applicant Supervisor");
//     end;

//     local procedure SetControlAppearance();
//     var
//         ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//     begin
//         //JobQueueVisible := "Job Queue Status" = "Job Queue Status"::"Scheduled for Posting";
//         //HasIncomingDocument := "Incoming Document Entry No." <> 0;
//         //SetExtDocNoMandatoryCondition;
//         OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RECORDID);
//         OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RECORDID);
//     end;
// }

