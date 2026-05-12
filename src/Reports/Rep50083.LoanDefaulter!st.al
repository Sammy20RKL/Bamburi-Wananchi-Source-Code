// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Report 50053 "Loan Defaulter 1st Notice"
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = './Layouts/LoanDefaulter_1stNotice.rdl';

//     dataset
//     {
//         dataitem("Loans Register"; "Loans Register")
//         {
//             RequestFilterFields = "Client Code", "Loan  No.", "Loans Category-SASRA";
//             column(ReportForNavId_1102755000; 1102755000)
//             {
//             }
//             column(OutstandingBalance_Loans; "Loans Register"."Outstanding Balance")
//             {
//             }
//             column(LoanNo_Loans; "Loans Register"."Loan  No.")
//             {
//             }
//             column(LoanNo_LoansPrinciple; "Loans Register"."Approved Amount")
//             {
//             }
//             column(LoanNo_LoanDate; "Loans Register"."Issued Date")
//             {
//             }
//             column(LoanNo_LoanPeriod; "Loans Register"."Instalment Period")
//             {
//             }
//             column(LoanNo_LoanPeriodInt; "Loans Register".Installments)
//             {
//             }
//             column(recoverNoticedate; recoverNoticedate)
//             {
//             }
//             column(LoanProductTypeName_LoansRegister; "Loans Register"."Loan Product Type Name")
//             {
//             }
//             column(OutstandingInterest_Loans; "Loans Register"."Oustanding Interest")
//             {
//             }
//             column(ClientName_Loans; "Loans Register"."Client Name")
//             {
//             }
//             column(LoanProductType_LoansRegister; "Loans Register"."Loan Product Type")
//             {
//             }
//             column(ClientCode_Loans; "Loans Register"."Client Code")
//             {
//             }
//             column(RemainingPeriod; RemainingPeriod)
//             {
//             }
//             column(LBalance; LBalance)
//             {
//             }
//             column(LBalance1; LBalance1)
//             {
//             }
//             column(PrincipleInArrears;PrincipleInArrears)
//             {                
//             }
//             dataitem("Default Notices Register"; "Default Notices Register")
//             {
//                 DataItemLink = "Loan In Default" = field("Loan  No.");
//                 column(Loan_Outstanding_Balance; "Loan Outstanding Balance")
//                 {
//                 }
//                 column(Document_No; "Document No")
//                 {
//                 }
//                 column(Outstanding_Interest_DefaultNoticesRegister; "Default Notices Register"."Outstanding Interest")
//                 {
//                 }
//                 column(AmountInArrears_DefaultNoticesRegister; vararrearsamount)//varamountinarrears
//                 {
//                 }
//                 column(DaysInArrears_DefaultNoticesRegister; "Default Notices Register"."Days In Arrears")
//                 {
//                 }

//                 dataitem("Members Register"; Customer)
//                 {
//                     DataItemLink = "No." = field("Member No");
//                     RequestFilterFields = "No.";
//                     column(ReportForNavId_1102755005; 1102755005)
//                     {
//                     }
//                     column(City_Members; "Members Register".City)
//                     {
//                     }
//                     column(Address2_Members; "Members Register"."Address 2")
//                     {
//                     }
//                     column(Address_Members; "Members Register".Address)
//                     {
//                     }
//                     column(DOCNAME; DOCNAME)
//                     {
//                     }
//                     column(CName; CompanyInfo.Name)
//                     {
//                     }
//                     column(Caddress; CompanyInfo.Address)
//                     {
//                     }
//                     column(CmobileNo; CompanyInfo."Phone No.")
//                     {
//                     }
//                     column(clogo; CompanyInfo.Picture)
//                     {
//                     }
//                     column(Cwebsite; CompanyInfo."Home Page")
//                     {
//                     }
//                     column(Email; CompanyInfo."E-Mail")
//                     {
//                     }
//                     column(loansOFFICER; Lofficer)
//                     {
//                     }
//                     trigger OnAfterGetRecord()
//                     begin
//                         workString := CONVERTSTR(Customer.Name, ' ', ',');
//                         DearM := SELECTSTR(1, workString);
//                         Balance := 0;
//                         SharesB := 0;
//                     end;
//                 }
//             }

//             trigger OnAfterGetRecord()
//             BEGIN
//                 LBalance := 0;
//                 LBalance1 := 0;
//                 NoGuarantors := 1;
//                 TGrAmount := 0;
//                 GrAmount := 0;
//                 FGrAmount := 0;
//                 LastPayDate := 0D;
//                 Notified := TRUE;
//                 recoverNoticedate := CALCDATE('1M', TODAY);

//                 LoansREC.RESET();
//                 LoansREC.SETRANGE("Loan  No.", "Loan  No.");
//                 IF LoansREC.FIND('-') THEN BEGIN
//                     RemainingPeriod := LoansREC.Installments - ObjSwizzFactory.KnGetCurrentPeriodForLoan("Loan  No.");
//                         Message('ScheduleBalance in loansdefaulter %1 & Loan no %2', LoansRec."Schedule Repayment","Loan  No.");

//                     MemberLedgerEntry.RESET();
//                     MemberLedgerEntry.SETRANGE("Loan No", LoansREC."Loan  No.");
//                     IF MemberLedgerEntry.FINDLAST() THEN BEGIN
//                         IF (MemberLedgerEntry."Transaction Type" = MemberLedgerEntry."Transaction Type"::"Loan Repayment") OR
//                            (MemberLedgerEntry."Transaction Type" = MemberLedgerEntry."Transaction Type"::"Interest Paid") THEN
//                             LastPayDate := MemberLedgerEntry."Posting Date";
//                     END;

//                     IF LastPayDate = 0D THEN
//                         LastPayDate := LoansREC."Issued Date";

//                     LoansREC.CALCFIELDS(LoansREC."Outstanding Balance", LoansREC."Oustanding Interest");

//                     LBalance := LoansREC."Outstanding Balance" + LoansREC."Oustanding Interest";
//                     LBalance1 := LoansREC."Outstanding Balance";

//                     // Fetch repayment schedule
//                     defaultNotices.RESET();
//                     //defaultNotices.SetRange("Document No", defaultNotices."Document No");
//                     defaultNotices.SETRANGE("Loan In Default", LoansREC."Loan  No.");
//                     IF defaultNotices.FINDFIRST THEN BEGIN
//                         //defaultNotices.CALCFIELDS("Amount In Arrears");
//                         //VarArrearsAmount := defaultNotices."Amount In Arrears";
//                     END ELSE BEGIN
//                         //VarArrearsAmount := 0;
//                     END;


//                     // Message('Loan Balance: %1, Outstanding Balance: %2, Amount in Arrears: %3',
//                     //     LBalance, LBalance1, VarArrearsAmount);

//                     Balance -= LBalance;
//                     SharesB -= LBalance;

//                      LoanRepaymentSchedule.Reset();
//                     LoanRepaymentSchedule.SetRange("Loan No.", LoansREC."Loan  No.");
//                     LoanRepaymentSchedule.SetFilter("Repayment Date", '<=%1', Today);

//                     if LoanRepaymentSchedule.FindLast() then begin
//                         ScheduleBalance := LoanRepaymentSchedule."Loan Balance";
//                     end;

//                     PrincipleInArrears:= LoansREC."Approved Amount"-ScheduleBalance;
//                     VarArrearsAmount:=PrincipleInArrears + defaultNotices."Outstanding Interest";

//                     LoanGuar.RESET();
//                     LoanGuar.SETRANGE(LoanGuar."Loan No", LoansREC."Loan  No.");
//                     IF LoanGuar.FINDSET THEN BEGIN
//                         REPEAT
//                             GrAmount := LoanGuar."Amont Guaranteed";
//                             TGrAmount += GrAmount;
//                             FGrAmount := TGrAmount;
//                         UNTIL LoanGuar.NEXT = 0;
//                     END;

//                     LoansREC.CALCFIELDS(LoansREC."Outstanding Balance", LoansREC."Oustanding Interest");
//                     Lbal := ROUND(LoansREC."Outstanding Balance", 0.5, '=');
//                     INTBAL := LoansREC."Oustanding Interest";
//                     COMM := INTBAL * 0.5;
//                 END ELSE BEGIN
//                     Message('No loan record found for Loan No. %1', "Loan  No.");
//                 END;
//             END;
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
//         CompanyInfo.Get;
//         CompanyInfo.CalcFields(Picture);
//         DOCNAME := 'FIRST DEMAND NOTICE';
//         Lofficer := UserId;
//     end;

//     var
//         DOCNAME: Text[30];
//         PrincipleInArrears:Decimal;
//         CompanyInfo: Record "Company Information";
//         Lofficer: Text;
//         recoverNoticedate: Date;
//         RemainingPeriod: Integer;
//         MemberLedgerEntry: Record "Cust. Ledger Entry";
//         LoanRepaymentSchedule: Record "Loan Repayment Schedule";
//         ScheduleBalance: Decimal;
//         LoansREC: Record "Loans Register";
//         ObjSwizzFactory: Codeunit "Swizzsoft Factory.";
//         LastPayDate: Date;
//         VarArrearsAmount: Decimal;
//         NoGuarantors: Integer;
//         LBalance: Decimal;
//         LBalance1: Decimal;
//         Notified: Boolean;
//         Balance: Decimal;
//         SharesB: Decimal;
//         lbal: Decimal;
//         IntBal: Decimal;
//         COMM: Decimal;
//         BalanceType: Text;
//         LoanGuar: Record "Loans Guarantee Details";
//         TGrAmount: Decimal;
//         GrAmount: Decimal;
//         Customer: Record Customer;
//         workstring: Text;
//         DearM: Text;
//         FGrAmount: Decimal;
//         defaultNotices: Record "Default Notices Register";
// } 



// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 
// /*
// Report 50053 "Loan Defaulter 1st Notice"
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = './Layouts/LoanDefaulter_1stNotice.rdl';

//     dataset
//     {
//         dataitem("Default Notices Register"; "Default Notices Register")
//         {
//             RequestFilterFields = "Loan In Default", "Document No";
//             column(Document_No; "Document No")
//             {
//             }
//             column(Loan_In_Default; "Loan In Default")
//             {
//             }
//             column(AmountInArrears; "Amount In Arrears")
//             {
//             }

//             column(DOCNAME; DOCNAME)
//             {
//             }
//             column(CName; CompanyInfo.Name)
//             {
//             }
//             column(Caddress; CompanyInfo.Address)
//             {
//             }
//             column(CmobileNo; CompanyInfo."Phone No.")
//             {
//             }
//             column(clogo; CompanyInfo.Picture)
//             {
//             }
//             column(Cwebsite; CompanyInfo."Home Page")
//             {
//             }
//             column(Email; CompanyInfo."E-Mail")
//             {
//             }


//             dataitem("Loans Register"; "Loans Register")
//             {
//                 DataItemLink = "Loan  No." = field("Loan In Default");
//                 column(LoanNo; "Loan  No.")
//                 {
//                 }
//                 column(OutstandingBalance; "Outstanding Balance")
//                 {
//                 }
//                 column(ClientName; "Client Name")
//                 {
//                 }
//                 column(ApprovedAmount; "Approved Amount")
//                 {
//                 }
//                 column(IssuedDate; "Issued Date")
//                 {
//                 }
//                 column(InstalmentPeriod; "Instalment Period")
//                 {
//                 }
//                 column(LoanProductType; "Loan Product Type Name")
//                 {
//                 }
//                 column(OutstandingInterest; "Oustanding Interest")
//                 {
//                 }

//                 trigger OnAfterGetRecord()
//                 begin
//                     // Fetch Document No for filtering
//                     defaultNotices.RESET();
//                     defaultNotices.SETRANGE("Loan In Default", "Loan  No.");
//                     defaultNotices.SETRANGE("Document No", "Default Notices Register"."Document No");
//                     IF defaultNotices.FINDFIRST THEN BEGIN
//                         VarArrearsAmount := defaultNotices."Amount In Arrears";
//                     END ELSE BEGIN
//                         VarArrearsAmount := 0;
//                     END;

//                     Message('Working with Document No: %1 for Loan No: %2, Amount in Arrears: %3',
//                         "Default Notices Register"."Document No", "Loan  No.", VarArrearsAmount);
//                 END;
//             }
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
//         CompanyInfo.Get;
//         CompanyInfo.CalcFields(Picture);
//         DOCNAME := 'FIRST DEMAND NOTICE';
//         Lofficer := UserId;
//     end;

//     var
//         DOCNAME: Text[30];
//         CompanyInfo: Record "Company Information";
//         Lofficer: Text;
//         defaultNotices: Record "Default Notices Register";
//         VarArrearsAmount: Decimal;

// }
// */