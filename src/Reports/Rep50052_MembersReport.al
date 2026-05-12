// Report 50052 MemberReport
// {
//     ApplicationArea = All;
//     Caption = 'Member Report';
//     RDLCLayout = './Layout/MembersReport.rdl';
//     UsageCategory = ReportsAndAnalysis;
//     dataset
//     {
//         dataitem(Customer; Customer)
//         {
//             DataItemTableView = sorting("No.") order(descending);
//             RequestFilterFields = "No.", "Date Filter", Status;
//             column(CompanyName; CompanyInfo.Name)
//             {
//             }
//             column(CompanyAddress; CompanyInfo.Address)
//             {
//             }
//             column(CompanyPhone; CompanyInfo."Phone No.")
//             {
//             }
//             column(CompanyPic; CompanyInfo.Picture)
//             {
//             }
//             column(CompanyEmail; CompanyInfo."E-Mail")
//             {
//             }
//             column(No; "No.")
//             {
//             }
//             column(Personal_No; "Personal No")
//             {

//             }
//             column(Name; Name)
//             { }
//             column(ID_No_; "ID No.")
//             { }
//             column(EntryNo; EntryNo)
//             { }
//             column(Monthly_Contribution; "Monthly Contribution")
//             { }
//             column(Deposits; Deposits) { }
//             column(Sharecapital; ShareCapital) { }
//             column(LoanBalance; LoanBalance) { }
//             column(Status; Status) { }
//             column(Address; Address) { }
//             column(Phone_No_; "Mobile Phone No") { }

//             trigger OnPreDataItem()
//             var
//                 myInt: Integer;
//             begin
//                 Deposits := 0;
//                 ShareCapital := 0;
//                 LoanBalance := 0;
//             end;

//             trigger OnAfterGetRecord()
//             begin
//                 // Ensure we are filtering correctly
//                 TbMembRegister.SetRange("No.", "No.");
//                 TbMembRegister.SetFilter("Date Filter", Datefilter);

//                 // Ensure a record is found
//                 // if TbMembRegister.FindFirst() then begin
//                 //     TbMembRegister.CalcFields("Current Shares", "Outstanding Balance", "Share Capital");
//                 //     Deposits := TbMembRegister."Current Shares";
//                 //     ShareCapital := TbMembRegister."Share Capital";
//                 //     LoanBalance := TbMembRegister."Outstanding Balance";
//                 // end else begin
//                 //     Message('No matching records found for %1 with filter %2', "No.", Datefilter);
//                 // end;

//                 EntryNo := EntryNo + 1;
//             end;


//         }
//     }
//     requestpage
//     {
//         layout
//         {
//             area(content)
//             {
//                 group(GroupName)
//                 {
//                 }
//             }
//         }
//         actions
//         {
//             area(processing)
//             {
//             }
//         }
//     }
//     trigger OnPreReport()
//     begin
//         CompanyInfo.Get();
//         CompanyInfo.CALCFIELDS(CompanyInfo.Picture);
//         Datefilter := TbMembRegister.GetFilter("Date Filter");
//     end;

//     var
//         CompanyInfo: Record "Company Information";
//         EntryNo: Integer;
//         LoanBalance: Decimal;
//         ShareCapital: Decimal;
//         Deposits: Decimal;
//         Datefilter: Text[100];
//         TbMembRegister: Record Customer;
// }
