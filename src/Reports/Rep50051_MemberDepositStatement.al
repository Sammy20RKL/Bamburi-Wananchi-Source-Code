// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Report 50051 "Members Deposits Statement"
// {
//     ApplicationArea = All;
//     RDLCLayout = './Layouts/MemberDepositsStatement.rdlc';
//     UsageCategory = ReportsAndAnalysis;

//     dataset
//     {
//         dataitem(Customer; Customer)
//         {
//             RequestFilterFields = "No.", "Loan Product Filter", "Outstanding Balance", "Date Filter";
//             column(Payroll_Staff_No; "Payroll/Staff No")
//             {
//             }
//             column(Employer_Name; "Employer Name")
//             {
//             }
//             column(PayrollStaffNo_Members; "Payroll/Staff No")
//             {
//             }
//             column(No_Members; "No.")
//             {
//             }
//             column(MobilePhoneNo_MembersRegister; "Mobile Phone No")
//             {
//             }
//             column(Name_Members; Name)
//             {
//             }
//             column(Registration_Date; "Registration Date")
//             {

//             }
//             column(EmployerCode_Members; "Employer Code")
//             {
//             }
//             column(EmployerName; EmployerName)
//             {
//             }
//             column(PageNo_Members; CurrReport.PageNo)
//             {
//             }
//             column(Shares_Retained; "Shares Retained")
//             {
//             }
//             column(ShareCapBF; ShareCapBF)
//             {
//             }
//             column(IDNo_Members; "ID No.")
//             {
//             }
//             column(GlobalDimension2Code_Members; "Global Dimension 2 Code")
//             {
//             }
//             column(Company_Name; Company.Name)
//             {
//             }
//             column(Company_Address; Company.Address)
//             {
//             }
//             column(Company_Picture; Company.Picture)
//             {
//             }
//             column(Company_Phone; Company."Phone No.")
//             {
//             }
//             column(Company_SMS; Company."Phone No.")
//             {
//             }
//             column(Company_Email; Company."E-Mail")
//             {
//             }
//             dataitem(Deposits; "Cust. Ledger Entry")
//             {
//                 DataItemLink = "Customer No." = field("No."), "Posting Date" = field("Date Filter");
//                 DataItemTableView = sorting("Posting Date") where("Transaction Type" = const("Deposit Contribution"), Reversed = filter(false));
//                 column(OpeningBal; OpeningBal)
//                 {
//                 }
//                 column(ClosingBal; ClosingBal)
//                 {
//                 }
//                 column(TransactionType_Deposits; Deposits."Transaction Type")
//                 {
//                 }
//                 column(Amount_Deposits; Deposits.Amount)
//                 {
//                 }
//                 column(Description_Deposits; Deposits.Description)
//                 {
//                 }
//                 column(DocumentNo_Deposits; Deposits."Document No.")
//                 {
//                 }
//                 column(PostingDate_Deposits; Deposits."Posting Date")
//                 {
//                 }
//                 column(DebitAmount_Deposits; Deposits."Debit Amount")
//                 {
//                 }
//                 column(CreditAmount_Deposits; Deposits."Credit Amount")
//                 {
//                 }
//                 column(Deposits_Description; Deposits.Description)
//                 {
//                 }
//                 column(BalAccountNo_Deposits; Deposits."Bal. Account No.")
//                 {
//                 }
//                 column(BankCodeDeposits; BankCodeDeposits)
//                 {
//                 }
//                 column(USER2; Deposits."User ID")
//                 {
//                 }

//                 trigger OnAfterGetRecord()
//                 begin
//                     ClosingBal := ClosingBal - Deposits."Amount Posted";
//                     BankCodeDeposits := GetBankCode(Deposits);
//                     //........................
//                     if Deposits."Amount Posted" < 0 then begin
//                         Deposits."Credit Amount" := (Deposits."Amount Posted" * -1);
//                     end else
//                         if Deposits."Amount Posted" > 0 then begin
//                             Deposits."Debit Amount" := (Deposits."Amount Posted");
//                         end;

//                     MembLedgerEntry.Reset();
//                     MembLedgerEntry.SetRange("Customer No.", TbMembReg."No.");
//                     if MembLedgerEntry.Find('-') then
//                         if MembLedgerEntry.IsEmpty() then begin
//                             CurrReport.Skip();
//                         end;

//                 end;

//                 trigger OnPreDataItem()
//                 begin
//                     ClosingBal := SharesBF;
//                     OpeningBal := SharesBF;
//                 end;
//             }
//             /* dataitem(ShareCapital; "Cust. Ledger Entry")
//             {
//                 DataItemLink = "Customer No." = field("No."), "Posting Date" = field("Date Filter");
//                 DataItemTableView = sorting("Posting Date") where("Transaction Type" = const("Share Capital"), Reversed = filter(false));
//                 column(OpeningBal; OpeningBal)
//                 {
//                 }
//                 column(ClosingBal; ClosingBal)
//                 {
//                 }
//                 column(TransactionType_Deposits; Deposits."Transaction Type")
//                 {
//                 }
//                 column(Amount_Deposits; Deposits.Amount)
//                 {
//                 }
//                 column(Description_Deposits; Deposits.Description)
//                 {
//                 }
//                 column(DocumentNo_Deposits; Deposits."Document No.")
//                 {
//                 }
//                 column(PostingDate_Deposits; Deposits."Posting Date")
//                 {
//                 }
//                 column(DebitAmount_Deposits; Deposits."Debit Amount")
//                 {
//                 }
//                 column(CreditAmount_Deposits; Deposits."Credit Amount")
//                 {
//                 }
//                 column(Deposits_Description; Deposits.Description)
//                 {
//                 }
//                 column(BalAccountNo_Deposits; Deposits."Bal. Account No.")
//                 {
//                 }
//                 column(BankCodeDeposits; BankCodeDeposits)
//                 {
//                 }
//                 column(USER2; Deposits."User ID")
//                 {
//                 }

//                 // trigger OnAfterGetRecord()
//                 // begin
//                 //     ClosingBal := ClosingBal - Deposits.Amount;
//                 //     BankCodeDeposits := GetBankCode(Deposits);
//                 //     //........................
//                 //     if Deposits.Amount < 0 then begin
//                 //         Deposits."Credit Amount" := (Deposits.Amount * -1);
//                 //     end else
//                 //         if Deposits.Amount > 0 then begin
//                 //             Deposits."Debit Amount" := (Deposits.Amount);
//                 //         end
//                 // end;

//                 // trigger OnPreDataItem()
//                 // begin
//                 //     ClosingBal := SharesBF;
//                 //     OpeningBal := SharesBF;
//                 // end;
//             } */

//             trigger OnAfterGetRecord()
//             begin
//                 SaccoEmp.Reset;
//                 SaccoEmp.SetRange(SaccoEmp.Code, "Employer Code");
//                 if SaccoEmp.Find('-') then
//                     EmployerName := SaccoEmp.Description;

//                 HolidayBF := 0;
//                 SharesBF := 0;
//                 InsuranceBF := 0;
//                 ShareCapBF := 0;
//                 RiskBF := 0;
//                 HseBF := 0;
//                 Dep1BF := 0;
//                 Dep2BF := 0;
//                 if DateFilterBF <> '' then begin
//                     Cust.Reset;
//                     Cust.SetRange(Cust."No.", "No.");
//                     Cust.SetFilter(Cust."Date Filter", DateFilterBF);
//                     if Cust.Find('-') then begin
//                         Cust.CalcFields(/* Cust.sha, */ Cust."Current Shares", Cust."Insurance Fund", Cust."Holiday Savings");
//                         SharesBF := Cust."Current Shares";
//                         ShareCapBF := Cust."Shares Retained";
//                         RiskBF := Cust."Insurance Fund";
//                         HolidayBF := Cust."Holiday Savings";
//                     end;
//                 end;
//             end;

//             trigger OnPreDataItem()
//             begin
//                 /*
//                 IF GETFILTER("Date Filter") <> '' THEN
//                 DateFilterBF:='..'+ FORMAT(CALCDATE('-1D',GETRANGEMIN("Date Filter")));
//                 */

//                 if GetFilter("Date Filter") <> '' then
//                     DateFilterBF := '..' + Format(CalcDate('-1D', GetRangeMin("Date Filter")));
//                 //DateFilterBF:='..'+ FORMAT(GETRANGEMIN("Date Filter"));

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

//     trigger OnPreReport()
//     begin
//         Company.Get();
//         Company.CalcFields(Company.Picture);
//     end;

//     var
//         OpenBalance: Decimal;
//         CLosingBalance: Decimal;
//         OpenBalanceXmas: Decimal;
//         CLosingBalanceXmas: Decimal;
//         Cust: Record Customer;
//         OpeningBal: Decimal;
//         ClosingBal: Decimal;
//         FirstRec: Boolean;
//         PrevBal: Integer;
//         BalBF: Decimal;
//         LoansR: Record "Loans Register";
//         DateFilterBF: Text[150];
//         SharesBF: Decimal;
//         InsuranceBF: Decimal;
//         LoanBF: Decimal;
//         PrincipleBF: Decimal;
//         InterestBF: Decimal;
//         ShowZeroBal: Boolean;
//         ClosingBalSHCAP: Decimal;
//         ShareCapBF: Decimal;
//         RiskBF: Decimal;
//         DividendBF: Decimal;
//         Company: Record "Company Information";
//         OpenBalanceHse: Decimal;
//         CLosingBalanceHse: Decimal;
//         OpenBalanceDep1: Decimal;
//         CLosingBalanceDep1: Decimal;
//         OpenBalanceDep2: Decimal;
//         CLosingBalanceDep2: Decimal;
//         HseBF: Decimal;
//         Dep1BF: Decimal;
//         Dep2BF: Decimal;
//         OpeningBalInt: Decimal;
//         ClosingBalInt: Decimal;
//         InterestPaid: Decimal;
//         SumInterestPaid: Decimal;
//         OpenBalanceRisk: Decimal;
//         CLosingBalanceRisk: Decimal;
//         OpenBalanceDividend: Decimal;
//         ClosingBalanceDividend: Decimal;
//         OpenBalanceHoliday: Decimal;
//         ClosingBalanceHoliday: Decimal;
//         LoanSetup: Record "Loan Products Setup";
//         LoanName: Text[50];
//         SaccoEmp: Record "Sacco Employers";
//         EmployerName: Text[100];
//         OpenBalanceLoan: Decimal;
//         ClosingBalanceLoan: Decimal;
//         BankCodeShares: Text;
//         BankCodeDeposits: Text;
//         BankCodeDividend: Text;
//         BankCodeRisk: Text;
//         BankCodeInsurance: Text;
//         BankCodeLoan: Text;
//         BankCodeInterest: Text;
//         HolidayBF: Decimal;
//         BankCodeHoliday: Code[50];
//         ClosingBalHoliday: Decimal;
//         OpeningBalHoliday: Decimal;
//         BankCodeFOSAShares: Code[50];
//         ClosingBalanceFOSAShares: Decimal;
//         OpenBalanceFOSAShares: Decimal;
//         OpenBalancesPepeaShares: Decimal;
//         ClosingBalancePepeaShares: Decimal;
//         BankCodePepeaShares: Code[50];
//         OpenBalancesVanShares: Decimal;
//         ClosingBalanceVanShares: Decimal;
//         BankCodeVanShares: Code[50];
//         ApprovedAmount_Interest: Decimal;
//         LonRepaymentSchedule: Record "Loan Repayment Schedule";
//         TbMembReg: Record Customer;
//         MembLedgerEntry: Record "Cust. Ledger Entry";


//     local procedure GetBankCode(MembLedger: Record "Cust. Ledger Entry"): Text
//     var
//         BankLedger: Record "Bank Account Ledger Entry";
//     begin
//         BankLedger.Reset;
//         BankLedger.SetRange("Posting Date", MembLedger."Posting Date");
//         BankLedger.SetRange("Document No.", MembLedger."Document No.");
//         if BankLedger.FindFirst then
//             exit(BankLedger."Bank Account No.");
//         exit('');
//     end;
// }

