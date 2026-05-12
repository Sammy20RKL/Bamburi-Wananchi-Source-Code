// /// <summary>
// /// Report HR Leave Application (ID 51532276).
// /// </summary>
// report 72276 "HR Leave Application"
// {
//     // version HRMIS 2016 VRS1.0

//     DefaultLayout = RDLC;
//     UsageCategory = ReportsAndAnalysis;
//     RDLCLayout = './Layouts/Investments/HR Leave Application.rdl';

//     dataset
//     {
//         dataitem("HR Leave Application"; "HR Leave Application")
//         {
//             RequestFilterFields = "Applicant Staff No.";

//             // ReqFilterHeading = 'Document Number';
//             column(CI_Picture; CI.Picture)
//             {
//             }
//             column(CI_Address; CI.Address)
//             {
//             }
//             column(CI__Address_2______CI__Post_Code_; CI."Address 2" + ' ' + CI."Post Code")
//             {
//             }
//             column(CI_City; CI.City)
//             {
//             }
//             column(CI_PhoneNo; CI."Phone No.")
//             {
//             }
//             column(COMPANYNAME; COMPANYNAME)
//             {
//             }
//             column(Names; Names)
//             {
//             }
//             column(LeaveBalance; dLeft)
//             {
//             }
//             column(SuperviorApprovedDays; "HR Leave Application"."Days Applied")
//             {
//             }
//             column(EmployeeNo_HRLeaveApplication; "HR Leave Application"."Applicant Staff No.")
//             {
//                 IncludeCaption = true;
//             }
//             column(DaysApplied_HRLeaveApplication; "HR Leave Application"."Days Applied")
//             {
//                 IncludeCaption = true;
//             }
//             column(ApplicationCode_HRLeaveApplication; "HR Leave Application"."Application Code")
//             {
//                 IncludeCaption = true;
//             }
//             column(RequestLeaveAllowance_HRLeaveApplication; "HR Leave Application"."Request Leave Allowance")
//             {
//                 IncludeCaption = true;
//             }
//             column(LeaveAllowanceAmount_HRLeaveApplication; "HR Leave Application"."Leave Allowance Amount")
//             {
//                 IncludeCaption = true;
//             }
//             column(NumberofPreviousAttempts_HRLeaveApplication; "HR Leave Application"."Number of Previous Attempts")
//             {
//                 IncludeCaption = true;
//             }
//             column(DetailsofExamination_HRLeaveApplication; "HR Leave Application"."Details of Examination")
//             {
//                 IncludeCaption = true;
//             }
//             column(DateofExam_HRLeavseApplication; "HR Leave Application"."Date of Exam")
//             {
//                 IncludeCaption = true;
//             }
//             column(Reliever_HRLeaveApplication; "HR Leave Application".Reliever)
//             {
//                 IncludeCaption = true;
//             }
//             column(RelieverName_HRLeaveApplication; "HR Leave Application"."Reliever Name")
//             {
//                 IncludeCaption = true;
//             }
//             column(StartDate_HRLeaveApplication; "HR Leave Application"."Start Date")
//             {
//                 IncludeCaption = true;
//             }
//             column(ReturnDate_HRLeaveApplication; "HR Leave Application"."Return Date")
//             {
//                 IncludeCaption = true;
//             }
//             column(LeaveType_HRLeaveApplication; "HR Leave Application"."Leave Type")
//             {
//                 IncludeCaption = true;
//             }
//             column(JobTittle_HRLeaveApplication; "HR Leave Application"."Job Tittle")
//             {
//                 IncludeCaption = true;
//             }
//             column(ApplicationDate_HRLeaveApplication; "HR Leave Application"."Application Date")
//             {
//                 IncludeCaption = true;
//             }
//             column(EmailAddress_HRLeaveApplication; "HR Leave Application"."E-mail Address")
//             {
//                 IncludeCaption = true;
//             }
//             column(CellPhoneNumber_HRLeaveApplication; "HR Leave Application"."Cell Phone Number")
//             {
//                 IncludeCaption = true;
//             }
//             column(Approveddays_HRLeaveApplication; "HR Leave Application"."Approved days")
//             {
//             }
//             column(Approver1; Approver1)
//             {
//             }
//             column(Approver2; Approver2)
//             {
//             }
//             column(Approver3; Approver3)
//             {
//             }
//             dataitem("Approval Comment Line"; "Approval Comment Line")
//             {
//                 DataItemLink = "Document No." = FIELD("Application Code");
//                 DataItemTableView = SORTING("Entry No.")
//                                     ORDER(Ascending);
//                 // column(ApprovedDays_ApprovalCommentLine; "Approval Comment Line"."Approved Days")
//                 // {
//                 //     IncludeCaption = true;
//                 // }
//                 // column(ApprovedStartDate_ApprovalCommentLine; "Approval Comment Line"."Approved Start Date")
//                 // {
//                 //     IncludeCaption = true;
//                 // }
//                 // column(ApprovedReturnDate_ApprovalCommentLine; "Approval Comment Line"."Approved Return Date")
//                 // {
//                 //     IncludeCaption = true;
//                 // }
//                 // column(Reason_ApprovalCommentLine; "Approval Comment Line".Reason)
//                 // {
//                 //     IncludeCaption = true;
//                 // }
//                 // column(LeaveAllowanceGranted_ApprovalCommentLine; "Approval Comment Line"."Leave Allowance Granted")
//                 // {
//                 //     IncludeCaption = true;
//                 // }
//             }
//             dataitem("Approval Entry"; "Approval Entry")
//             {
//                 DataItemLink = "Document No." = FIELD("Application Code");
//                 DataItemTableView = SORTING("Table ID", "Document Type", "Document No.", "Sequence No.")
//                                     ORDER(Ascending);
//                 column(ApproverID_ApprovalEntry; "Approval Entry"."Approver ID")
//                 {
//                     IncludeCaption = true;
//                 }
//                 column(SequenceNo_ApprovalEntry; "Approval Entry"."Sequence No.")
//                 {
//                 }
//                 column(SenderID_ApprovalEntry; "Approval Entry"."Sender ID")
//                 {
//                 }
//                 column(DateTimeSentforApproval_ApprovalEntry; "Approval Entry"."Date-Time Sent for Approval")
//                 {
//                 }
//                 column(LastDateTimeModified_ApprovalEntry; "Approval Entry"."Last Date-Time Modified")
//                 {
//                 }
//                 dataitem("User Setup"; "User Setup")
//                 {
//                     DataItemLink = "User ID" = FIELD("Approver ID");
//                     DataItemTableView = SORTING("User ID")
//                                         ORDER(Ascending);
//                 }
//             }

//             trigger OnAfterGetRecord();
//             begin
//                 dAlloc := 0;
//                 Reimb := 0;
//                 dEarnd := 0;
//                 dTaken := 0;
//                 dLeft := 0;
//                 cReimbsd := 0;
//                 cPerDay := 0;
//                 cbf := 0;

//                 HREmp.RESET;
//                 IF HREmp.GET("HR Leave Application"."Applicant Staff No.") THEN BEGIN
//                     HRLeaveCal.RESET;
//                     HRLeaveCal.SETRANGE(HRLeaveCal."Current Leave Calendar", TRUE);
//                     IF NOT HRLeaveCal.FIND('-') THEN ERROR('Leave Calendar not setup');

//                     //Filter by Leave Period from HR Setup
//                     HRLeaveLedgerEntries.RESET;
//                     HRLeaveLedgerEntries.SETRANGE(HRLeaveLedgerEntries."Staff No.", "HR Leave Application"."Applicant Staff No.");
//                     HRLeaveLedgerEntries.SETRANGE(HRLeaveLedgerEntries."Leave Entry Type", HRLeaveLedgerEntries."Leave Entry Type"::Positive);
//                     HRLeaveLedgerEntries.SETFILTER(HRLeaveLedgerEntries."Posting Date", '<=%1', "HR Leave Application"."Application Date");
//                     HRLeaveLedgerEntries.SETRANGE(HRLeaveLedgerEntries."Leave Period", HRLeaveCal."Calendar Code");
//                     HRLeaveLedgerEntries.SETRANGE(HRLeaveLedgerEntries."Leave Type", "HR Leave Application"."Leave Type");
//                     IF HRLeaveLedgerEntries.FIND('-') THEN BEGIN
//                         dAlloc := 0;
//                         REPEAT
//                             dAlloc := HRLeaveLedgerEntries."No. of days" + dAlloc;
//                         UNTIL HRLeaveLedgerEntries.NEXT = 0;
//                     END;


//                     HRLeaveLedgerEntries.RESET;
//                     HRLeaveLedgerEntries.SETRANGE(HRLeaveLedgerEntries."Staff No.", "HR Leave Application"."Applicant Staff No.");
//                     HRLeaveLedgerEntries.SETRANGE(HRLeaveLedgerEntries."Leave Entry Type", HRLeaveLedgerEntries."Leave Entry Type"::Negative);
//                     HRLeaveLedgerEntries.SETFILTER(HRLeaveLedgerEntries."Posting Date", '<=%1', "HR Leave Application"."Application Date");

//                     HRLeaveLedgerEntries.SETRANGE(HRLeaveLedgerEntries."Leave Period", HRLeaveCal."Calendar Code");
//                     HRLeaveLedgerEntries.SETRANGE(HRLeaveLedgerEntries."Leave Type", "HR Leave Application"."Leave Type");
//                     IF HRLeaveLedgerEntries.FIND('-') THEN BEGIN
//                         dTaken := 0;
//                         REPEAT
//                             dTaken += abs(HRLeaveLedgerEntries."No. of days");
//                         UNTIL HRLeaveLedgerEntries.NEXT = 0;
//                     END;

//                     //Leave Balance
//                     dEarnd := dAlloc + dTaken;
//                     dLeft := dAlloc - abs(dTaken);

//                     //Reimbursed Leave Days
//                     cbf := HREmp."Reimbursed Leave Days";
//                     cReimbsd := HREmp."Cash - Leave Earned";
//                     cPerDay := HREmp."Cash per Leave Day";

//                 END;
//             end;

//             trigger OnPreDataItem();
//             begin
//                 //LastFieldNo := FIELDNO("No.");

//                 Approver1 := '';
//                 Approver2 := '';
//                 Approver3 := '';
//                 Date1 := 0D;
//                 Date2 := 0D;
//                 Date3 := 0D;

//                 ApprovalEntry.RESET;
//                 ApprovalEntry.SETRANGE(ApprovalEntry."Document No.", GETFILTER("HR Leave Application"."Application Code"));
//                 ApprovalEntry.SETRANGE(ApprovalEntry.Status, ApprovalEntry.Status::Approved);
//                 IF ApprovalEntry.FIND('-') THEN BEGIN
//                     REPEAT
//                         IF ApprovalEntry."Sequence No." = 1 THEN BEGIN
//                             Approver1 := ApprovalEntry."Sender ID";

//                             Approver2 := ApprovalEntry."Approver ID";
//                         END;

//                         IF ApprovalEntry."Sequence No." = 2 THEN BEGIN
//                             Approver3 := ApprovalEntry."Approver ID";
//                         END;
//                     UNTIL ApprovalEntry.NEXT = 0;
//                 END;


//             end;
//         }
//     }

//     requestpage
//     {

//         layout
//         {
//         }

//         actions
//         {
//         }
//     }

//     labels
//     {
//     }

//     trigger OnPreReport();
//     begin
//         CI.GET;
//         CI.CALCFIELDS(CI.Picture);
//     end;

//     var
//         CI: Record "Company Information";
//         LastFieldNo: Integer;
//         FooterPrinted: Boolean;
//         CurrCode: Code[10];
//         DOCNAME: Text[30];
//         CreationDoc: Boolean;
//         Approver1: Text;
//         Approver2: Text;
//         Approver3: Text;
//         Date1: Date;
//         Date2: Date;
//         Date3: Date;
//         ApprovalEntry: Record "Approval Entry";
//         dAlloc: Decimal;
//         dEarnd: Decimal;
//         dTaken: Decimal;
//         dLeft: Decimal;
//         cReimbsd: Decimal;
//         cPerDay: Decimal;
//         cbf: Decimal;
//         HRSetup: Record "HR Setup";
//         Reimb: Decimal;
//         HREmp: Record "HR Employees";
//         HRLeaveCal: Record "HR Leave Calendar";
//         HRLeaveLedgerEntries: Record "HR Leave Ledger Entries";
// }

