// page 72602 "HR Leave Calendar List"
// {
//     // version HRMIS 2016 VRS1.0

//     CardPageID = "HR Leave Calendar Card";
//     DeleteAllowed = false;
//     InsertAllowed = false;
//     ModifyAllowed = false;
//     PageType = List;
//     SourceTable = "HR Leave Calendar";
//     ApplicationArea = All;

//     UsageCategory = Lists;
//     layout
//     {
//         area(content)
//         {
//             repeater(Group)
//             {
//                 field("Calendar Code"; Rec."Calendar Code")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Description"; Rec."Description")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Start Date"; Rec."Start Date")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("End Date"; Rec."End Date")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Current Leave Calendar"; Rec."Current Leave Calendar")
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
//     }
// }

