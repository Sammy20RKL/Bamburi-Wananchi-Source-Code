// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// page 50268 "HR Leave Applications List"
// {
//     ApplicationArea = Basic;
//     CardPageID = "HR Leave Application Card";
//     DeleteAllowed = true;
//     ModifyAllowed = true;
//     PageType = List;
//     SourceTable = "HR Leave Application";
//     SourceTableView = WHERE(Status = FILTER(New)/* , "Escalated to supervisor" = const(false) */);
//     UsageCategory = Lists;

//     layout
//     {
//         area(content)
//         {
//             repeater(Control1102755000)
//             {
//                 Editable = false;
//                 field("Application Code"; Rec."Application Code")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Application No';
//                     StyleExpr = true;
//                 }
//                 field("Employee No"; Rec."Employee No")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Leave Type"; Rec."Leave Type")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Days Applied"; Rec."Days Applied")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Start Date"; Rec."Start Date")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Return Date"; Rec."Return Date")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("End Date"; Rec."End Date")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Reliever Name"; Rec."Reliever Name")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Status; Rec.Status)
//                 {
//                     ApplicationArea = Basic;
//                     Style = StrongAccent;
//                     StyleExpr = true;
//                 }
//             }
//         }
//         area(factboxes)
//         {
//             part(Control1102755006; "HR Leave Applicaitons Factbox")
//             {
//                 SubPageLink = "No." = field("Employee No");
//             }
//         }
//     }

//     actions
//     {
//     }

//     trigger OnOpenPage()
//     begin
//         HREmp.Reset;
//         HREmp.SetRange(HREmp."User ID", UserId);
//         if HREmp.Find('-') then
//             Rec.SetRange("User ID", UserId)
//         else
//             Rec.SetRange("User ID", UserId);
//     end;

//     var
//         HRLeaveApp: Record "HR Leave Application";
//         HREmp: Record "HR Employees";


//     procedure TESTFIELDS()
//     begin
//         Rec.TestField("Leave Type");
//         Rec.TestField("Days Applied");
//         Rec.TestField("Start Date");
//         Rec.TestField(Reliever);
//         Rec.TestField(Supervisor);
//     end;


//     procedure TestLeaveFamily()
//     var
//         LeaveFamily: Record "HR Leave Family Groups";
//         LeaveFamilyEmployees: Record "HR Leave Family Employees";
//         Employees: Record "HR Employees";
//     begin
//         LeaveFamilyEmployees.SetRange(LeaveFamilyEmployees."Employee No", Rec."Employee No");
//         if LeaveFamilyEmployees.FindSet then //find the leave family employee is associated with
//             repeat
//                 LeaveFamily.SetRange(LeaveFamily.Code, LeaveFamilyEmployees.Family);
//                 LeaveFamily.SetFilter(LeaveFamily."Max Employees On Leave", '>0');
//                 if LeaveFamily.FindSet then //find the status other employees on the same leave family
//                   begin
//                     Employees.SetRange(Employees."No.", LeaveFamilyEmployees."Employee No");
//                     Employees.SetRange(Employees."Leave Status", Employees."leave status"::" ");
//                     if Employees.Count > LeaveFamily."Max Employees On Leave" then
//                         Error('The Maximum number of employees on leave for this family has been exceeded, Contact th HR manager for more information');
//                 end
//             until LeaveFamilyEmployees.Next = 0;
//     end;
// }

