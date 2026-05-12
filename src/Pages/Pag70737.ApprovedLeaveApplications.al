// /// <summary>
// /// Page Approved Leave Applications (ID 51532737).
// /// </summary>
// page 70737 "Approved Leave Applications"
// {
//     ApplicationArea = All;
//     CardPageID = "HR Leave Application Card";
//     Caption = 'Approved Leave Applications';
//     DeleteAllowed = false;
//     ModifyAllowed = false;
//     InsertAllowed = false;
//     PageType = List;
//     UsageCategory = Lists;
//     SourceTable = "HR Leave Application";
//     SourceTableView = WHERE(Status = FILTER(Approved));

//     layout
//     {
//         area(content)
//         {
//             repeater(Sthng)
//             {
//                 Editable = false;
//                 field("Application Code"; Rec."Application Code")
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Application No';
//                 }
//                 field("Applicant Staff No."; Rec."Applicant Staff No.")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field(Names; Rec.Names)
//                 {
//                     Caption = 'Names';
//                     ApplicationArea = All;
//                     Editable = false;
//                 }
//                 field("Days Applied"; Rec."Days Applied")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Start Date"; Rec."Start Date")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Return Date"; Rec."Return Date")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("End Date"; Rec."End Date")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field(Status; Rec.Status)
//                 {
//                     ApplicationArea = All;
//                     Style = Attention;
//                     StyleExpr = TRUE;
//                 }
//             }
//         }
//         area(factboxes)
//         {
//             part("HR Leave Applicaitons Factbox"; "HR Leave Applicaitons Factbox")
//             {
//                 ApplicationArea = All;
//                 SubPageLink = "No." = FIELD("Applicant Staff No.");
//             }
//             systempart(ttty; Outlook)
//             {
//                 ApplicationArea = All;
//             }
//         }
//     }

//     actions
//     {
//     }

//     trigger OnAfterGetRecord();
//     begin
//         HREmp.RESET;
//         IF HREmp.GET(Rec."Applicant Staff No.") THEN BEGIN
//             EmpName := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
//         END ELSE BEGIN
//             EmpName := 'n/a';
//         END;
//     end;

//     var
//         EmpName: Text;
//         HREmp: Record "HR Employees";

//     procedure TESTFIELDS();
//     begin
//         Rec.TESTFIELD("Leave Type");
//         Rec.TESTFIELD("Days Applied");
//         Rec.TESTFIELD("Start Date");
//         Rec.TESTFIELD(Reliever);
//         Rec.TESTFIELD("Applicant Supervisor");
//     end;

//     procedure TestLeaveFamily();
//     var
//         LeaveFamily: Record "HR Leave Family Groups";
//         LeaveFamilyEmployees: Record "HR Leave Family Employees";
//         Employees: Record "HR Employees";
//     begin
//         /*
//         LeaveFamilyEmployees.SETRANGE(LeaveFamilyEmployees."Employee No","Employee No");
//         IF LeaveFamilyEmployees.FINDSET THEN //find the leave family employee is associated with
//         REPEAT
//           LeaveFamily.SETRANGE(LeaveFamily.Code,LeaveFamilyEmployees.Family);
//           LeaveFamily.SETFILTER(LeaveFamily."Max Employees On Leave",'>0');
//           IF LeaveFamily.FINDSET THEN //find the status other employees on the same leave family
//             BEGIN
//               Employees.SETRANGE(Employees."No.",LeaveFamilyEmployees."Employee No");
//               Employees.SETRANGE(Employees."Leave Status",Employees."Leave Status"::"0");
//               IF Employees.COUNT>LeaveFamily."Max Employees On Leave" THEN
//               ERROR('The Maximum number of employees on leave for this family has been exceeded, Contact th HR manager for more information');
//             END
//         UNTIL LeaveFamilyEmployees.NEXT = 0;
//         */

//     end;
// }
