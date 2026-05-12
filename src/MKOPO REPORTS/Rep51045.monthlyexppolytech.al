// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Report 51045 "monthly exp polytech"
// {
//     RDLCLayout = './Layouts/monthlyexppolytech.rdl';
//     DefaultLayout = RDLC;

//     dataset
//     {
//         dataitem(Customer; Customer)
//         {
//             RequestFilterFields = "No.";
//             column(Name; Customer.Name)
//             {
//             }
//             column(No; Customer."No.")
//             {
//             }
//             column(ShareCapital; ShareCapital)
//             {
//             }
//             column(DevP; DevP)
//             {
//             }
//             column(Devint; Devint)
//             {
//             }
//             column(montlycon; montlycon)
//             {
//             }
//             column(Devint1; Devint1)
//             {
//             }
//             column(DevP1; DevP1)
//             {
//             }
//             column(EMERGENCYp; EMERGENCYp)
//             {
//             }
//             column(EMERGENCYINTEREST; EMERGENCYi)
//             {
//             }
//             column(SUPEREMERGENCYPRINCIPAL; SUPEREMERGENCYp)
//             {
//             }
//             column(SUPEREMERGENCYINTEREST; SUPEREMERGENCYi)
//             {
//             }
//             column(QUICKLOANPRINCIPAL; QUICKLOANp)
//             {
//             }
//             column(QUICKLOANINTEREST; QUICKLOANi)
//             {
//             }
//             column(SUPERQUICKPRINCIPAL; SUPERQUICKp)
//             {
//             }
//             column(SUPERQUICKINTEREST; SUPERQUICKi)
//             {
//             }
//             column(SCHOOLFEESPRINCIPAL; SCHOOLFEESp)
//             {
//             }
//             column(SCHOOLFEESINTEREST; SCHOOLFEESi)
//             {
//             }
//             column(SUPERSCHOOLFEESPRINCIPAL; SUPERSCHOOLFEESp)
//             {
//             }
//             column(SUPERSCHOOLFEESINTEREST; SUPERSCHOOLFEESi)
//             {
//             }
//             column(INVESTMENTLOANPRINCIPAL; INVESTMENTLOANp)
//             {
//             }
//             column(INVESTMENTLOANINTEREST; INVESTMENTLOANi)
//             {
//             }
//             column(CIName; CI.Name)
//             {
//             }
//             column(CIAddress; CI.Address)
//             {
//             }
//             column(CIPicture; CI.Picture)
//             {
//             }
//             column(PersonalNo_MemberRegister; Customer."Personal No")
//             {
//             }
//             column(NORMALLOANp; NORMALLOANp)
//             {
//             }
//             column(NORMALLOANi; NORMALLOANi)
//             {
//             }
//             column(NORMALLOAN1p; NORMALLOAN1p)
//             {
//             }
//             column(HolidayContribution_MemberRegister; Customer."Holiday Contribution")
//             {
//             }
//             column(DevelopmentLoanP; DevelopmentLoanP)
//             {
//             }
//             column(DevelopmentLoanInt; DevelopmentLoanInt)
//             {
//             }
//             column(MERCHANDISEPr; MERCHANDISEPr)
//             {
//             }
//             column(MERCHANDISEIn; MERCHANDISEIn)
//             {
//             }
//             trigger OnPreDataItem();
//             begin
//                 //ReportForNav.OnPreDataItem('Customer',Customer);
//             end;

//             trigger OnAfterGetRecord();
//             begin
//                 CI.Get();
//                 CI.CalcFields(Picture);
//                 ShareCapital := 0;
//                 Customer.CalcFields(Customer."Shares Retained");
//                 //MESSAGE (FORMAT(Customer."Shares Retained"));
//                 if Customer."Shares Retained" >= 20000 then begin
//                     ShareCapital := 0
//                 end else
//                     if Customer."Shares Retained" > 5000 then begin
//                         ShareCapital := 417
//                     end else
//                         if Customer."Shares Retained" < 5000 then begin
//                             ShareCapital := 1000
//                         end;
//                 //MESSAGE(FORMAT(ASAT));
//                 BeginMonth_Date := CalcDate('<-CM +14D>', ASAT);
//                 // EndMonth_Date := CALCDATE('<-15D>', ASAT);
//                 //MESSAGE ('begg IS %1',BeginMonth_Date);
//                 montlycon := Customer."Monthly Contribution";
//                 Customer.SetFilter(Customer."Monthly Contribution", '>%1', 0);
//                 //development start==========================================================================================================================================
//                 DevP := 0;
//                 Devint := 0;
//                 TotalMRepay := 0;
//                 LoansRegister.Reset;
//                 LoansRegister.SetRange("Client Code", Customer."No.");
//                 LoansRegister.SetRange("Loan Product Type", '20');
//                 LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
//                 if LoansRegister.FindSet then begin
//                     LoansRegister.CalcFields("Outstanding Balance", "Oustanding Interest", "Interest Due");
//                     ///****************************************************************************************************
//                     if LoansRegister."Expected Date of Completion" < ASAT then begin
//                         LoanRepaymentSchedule.Reset;
//                         LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
//                         if LoanRepaymentSchedule.FindLast then begin
//                             if LoanRepaymentSchedule."Principal Repayment" > LoansRegister."Outstanding Balance" then
//                                 DevP := LoansRegister."Outstanding Balance";
//                             Devint := LoansRegister."Oustanding Interest";
//                             if LoanRepaymentSchedule."Principal Repayment" < LoansRegister."Outstanding Balance" then
//                                 Devint := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
//                             DevP := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');
//                         end
//                     end else
//                         //****************************************************
//                         if LoansRegister."Loan Disbursement Date" < BeginMonth_Date then begin
//                             LoansRegister.CalcFields("Outstanding Balance", "Oustanding Interest", "Interest Due");
//                             LoanRepaymentSchedule.Reset;
//                             LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
//                             LoanRepaymentSchedule.SetFilter(LoanRepaymentSchedule."Repayment Date", '%1..%2', ASAT, CalcDate('CM', ASAT));
//                             if LoanRepaymentSchedule.Find('-') then begin
//                                 Devint := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
//                                 DevP := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');
//                             end;
//                         end;
//                 end;
//                 //development end=============================================================================================================================================
//                 //development 1 start==========================================================================================================================================
//                 DevP1 := 0;
//                 Devint1 := 0;
//                 TotalMRepay := 0;
//                 LoansRegister.Reset;
//                 LoansRegister.SetRange("Client Code", Customer."No.");
//                 LoansRegister.SetRange("Loan Product Type", '23');
//                 LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
//                 if LoansRegister.FindSet then begin
//                     LoansRegister.CalcFields("Outstanding Balance", "Oustanding Interest", "Interest Due");
//                     ///****************************************************************************************************
//                     if LoansRegister."Expected Date of Completion" < ASAT then begin
//                         LoanRepaymentSchedule.Reset;
//                         LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
//                         if LoanRepaymentSchedule.FindLast then begin
//                             if LoanRepaymentSchedule."Principal Repayment" > LoansRegister."Outstanding Balance" then
//                                 DevP1 := LoansRegister."Outstanding Balance";
//                             Devint1 := LoansRegister."Oustanding Interest";
//                             if LoanRepaymentSchedule."Principal Repayment" < LoansRegister."Outstanding Balance" then
//                                 Devint1 := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
//                             DevP1 := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');
//                         end
//                     end else
//                         //****************************************************
//                         if LoansRegister."Loan Disbursement Date" < BeginMonth_Date then begin
//                             LoansRegister.CalcFields("Outstanding Balance", "Oustanding Interest", "Interest Due");
//                             LoanRepaymentSchedule.Reset;
//                             LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
//                             LoanRepaymentSchedule.SetFilter(LoanRepaymentSchedule."Repayment Date", '%1..%2', ASAT, CalcDate('CM', ASAT));
//                             if LoanRepaymentSchedule.Find('-') then begin
//                                 Devint1 := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
//                                 DevP1 := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');
//                             end;
//                         end;
//                 end;
//                 //development 1 end=============================================================================================================================================
//                 //EMERGENCY LOAN start==========================================================================================================================================
//                 EMERGENCYi := 0;
//                 EMERGENCYp := 0;
//                 TotalMRepay := 0;
//                 LoansRegister.Reset;
//                 LoansRegister.SetRange("Client Code", Customer."No.");
//                 LoansRegister.SetRange("Loan Product Type", '12');
//                 LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
//                 if LoansRegister.FindSet then begin
//                     LoansRegister.CalcFields("Outstanding Balance", "Oustanding Interest", "Interest Due");
//                     //************************************************************************************************************
//                     if LoansRegister."Expected Date of Completion" < Today then begin
//                         LoanRepaymentSchedule.Reset;
//                         LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
//                         if LoanRepaymentSchedule.FindLast then begin
//                             if LoanRepaymentSchedule."Principal Repayment" > LoansRegister."Outstanding Balance" then
//                                 EMERGENCYp := LoansRegister."Outstanding Balance";
//                             EMERGENCYi := LoansRegister."Oustanding Interest";
//                             if LoanRepaymentSchedule."Principal Repayment" < LoansRegister."Outstanding Balance" then
//                                 EMERGENCYi := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
//                             EMERGENCYp := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');
//                         end
//                     end else
//                         if LoansRegister."Loan Disbursement Date" < BeginMonth_Date then begin
//                             LoanRepaymentSchedule.Reset;
//                             LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
//                             LoanRepaymentSchedule.SetFilter(LoanRepaymentSchedule."Repayment Date", '%1..%2', ASAT, CalcDate('CM', ASAT));
//                             if LoanRepaymentSchedule.Find('-') then begin
//                                 EMERGENCYi := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
//                                 EMERGENCYp := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');
//                             end;
//                         end;
//                 end;
//                 //EMERGENCY LOAN end=============================================================================================================================================
//                 //SUPER EMERGENCY LOAN start==========================================================================================================================================
//                 SUPEREMERGENCYi := 0;
//                 SUPEREMERGENCYp := 0;
//                 TotalMRepay := 0;
//                 LoansRegister.Reset;
//                 LoansRegister.SetRange("Client Code", Customer."No.");
//                 LoansRegister.SetRange("Loan Product Type", '13');
//                 LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
//                 if LoansRegister.FindSet then begin
//                     LoansRegister.CalcFields("Outstanding Balance", "Oustanding Interest", "Interest Due");
//                     ///****************************************************************************************************
//                     if LoansRegister."Expected Date of Completion" < Today then begin
//                         LoanRepaymentSchedule.Reset;
//                         LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
//                         if LoanRepaymentSchedule.FindLast then begin
//                             if LoanRepaymentSchedule."Principal Repayment" > LoansRegister."Outstanding Balance" then
//                                 SUPEREMERGENCYp := LoansRegister."Outstanding Balance";
//                             SUPEREMERGENCYi := LoansRegister."Oustanding Interest";
//                             if LoanRepaymentSchedule."Principal Repayment" < LoansRegister."Outstanding Balance" then
//                                 SUPEREMERGENCYi := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
//                             SUPEREMERGENCYp := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');
//                         end
//                     end else
//                         //****************************************************
//                         if LoansRegister."Loan Disbursement Date" < BeginMonth_Date then begin
//                             LoanRepaymentSchedule.Reset;
//                             LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
//                             LoanRepaymentSchedule.SetFilter(LoanRepaymentSchedule."Repayment Date", '%1..%2', ASAT, CalcDate('CM', ASAT));
//                             if LoanRepaymentSchedule.Find('-') then begin
//                                 SUPEREMERGENCYi := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
//                                 SUPEREMERGENCYp := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');
//                             end;
//                         end;
//                 end;
//                 //SUPER EMERGENCY LOAN end=============================================================================================================================================
//                 //QUICK LOAN start==========================================================================================================================================
//                 QUICKLOANp := 0;
//                 QUICKLOANi := 0;
//                 TotalMRepay := 0;
//                 LoansRegister.Reset;
//                 LoansRegister.SetRange("Client Code", Customer."No.");
//                 LoansRegister.SetRange("Loan Product Type", '15');
//                 LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
//                 if LoansRegister.FindSet then begin
//                     ///******************************************************************
//                     LoansRegister.CalcFields("Outstanding Balance", "Oustanding Interest", "Interest Due");
//                     ///****************************************************************************************************
//                     if LoansRegister."Expected Date of Completion" < ASAT then begin
//                         LoanRepaymentSchedule.Reset;
//                         LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
//                         if LoanRepaymentSchedule.FindLast then begin
//                             if LoanRepaymentSchedule."Principal Repayment" > LoansRegister."Outstanding Balance" then
//                                 QUICKLOANp := LoansRegister."Outstanding Balance";
//                             QUICKLOANi := LoansRegister."Oustanding Interest";
//                             if LoanRepaymentSchedule."Principal Repayment" < LoansRegister."Outstanding Balance" then
//                                 QUICKLOANi := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
//                             QUICKLOANp := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');
//                         end
//                     end else
//                         //****************************************************
//                         if LoansRegister."Loan Disbursement Date" < BeginMonth_Date then begin
//                             LoansRegister.CalcFields("Outstanding Balance", "Oustanding Interest", "Interest Due");
//                             LoanRepaymentSchedule.Reset;
//                             LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
//                             LoanRepaymentSchedule.SetFilter(LoanRepaymentSchedule."Repayment Date", '%1..%2', ASAT, CalcDate('CM', ASAT));
//                             if LoanRepaymentSchedule.Find('-') then begin
//                                 QUICKLOANi := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
//                                 QUICKLOANp := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');
//                             end;
//                         end;
//                 end;
//                 //QUICK LOAN end=============================================================================================================================================
//                 //SUPER QUICK start==========================================================================================================================================
//                 SUPERQUICKp := 0;
//                 SUPERQUICKi := 0;
//                 TotalMRepay := 0;
//                 LoansRegister.Reset;
//                 LoansRegister.SetRange("Client Code", Customer."No.");
//                 LoansRegister.SetRange("Loan Product Type", '16');
//                 LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
//                 if LoansRegister.FindSet then begin
//                     LoansRegister.CalcFields("Outstanding Balance", "Oustanding Interest", "Interest Due");
//                     ///****************************************************************************************************
//                     if LoansRegister."Expected Date of Completion" <= ASAT then begin
//                         LoanRepaymentSchedule.Reset;
//                         LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
//                         if LoanRepaymentSchedule.FindLast then begin
//                             if LoanRepaymentSchedule."Principal Repayment" > LoansRegister."Outstanding Balance" then
//                                 SUPERQUICKp := LoansRegister."Outstanding Balance";
//                             SUPERQUICKi := LoansRegister."Oustanding Interest";
//                             if LoanRepaymentSchedule."Principal Repayment" < LoansRegister."Outstanding Balance" then
//                                 SUPERQUICKi := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
//                             SUPERQUICKp := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');
//                         end
//                     end else
//                         //****************************************************
//                         if LoansRegister."Loan Disbursement Date" < BeginMonth_Date then begin
//                             LoansRegister.CalcFields("Outstanding Balance", "Oustanding Interest", "Interest Due");
//                             LoanRepaymentSchedule.Reset;
//                             LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
//                             LoanRepaymentSchedule.SetFilter(LoanRepaymentSchedule."Repayment Date", '%1..%2', ASAT, CalcDate('CM', ASAT));
//                             if LoanRepaymentSchedule.Find('-') then begin
//                                 SUPERQUICKi := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
//                                 SUPERQUICKp := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');
//                             end;
//                         end;
//                 end;
//                 //SUPER QUICK end=============================================================================================================================================
//                 //SCHOOL FEES start==========================================================================================================================================
//                 SCHOOLFEESp := 0;
//                 SCHOOLFEESi := 0;
//                 TotalMRepay := 0;
//                 LoansRegister.Reset;
//                 LoansRegister.SetRange("Client Code", Customer."No.");
//                 LoansRegister.SetRange("Loan Product Type", '17');
//                 LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
//                 if LoansRegister.FindSet then begin
//                     LoansRegister.CalcFields("Outstanding Balance", "Oustanding Interest", "Interest Due");
//                     ///****************************************************************************************************
//                     if LoansRegister."Expected Date of Completion" < ASAT then begin
//                         LoanRepaymentSchedule.Reset;
//                         LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
//                         if LoanRepaymentSchedule.FindLast then begin
//                             if LoanRepaymentSchedule."Principal Repayment" > LoansRegister."Outstanding Balance" then
//                                 SCHOOLFEESp := LoansRegister."Outstanding Balance";
//                             SCHOOLFEESi := LoansRegister."Oustanding Interest";
//                             if LoanRepaymentSchedule."Principal Repayment" < LoansRegister."Outstanding Balance" then
//                                 SCHOOLFEESi := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
//                             SCHOOLFEESp := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');
//                         end
//                     end else
//                         //****************************************************
//                         if LoansRegister."Loan Disbursement Date" < BeginMonth_Date then begin
//                             LoansRegister.CalcFields("Outstanding Balance", "Oustanding Interest", "Interest Due");
//                             LoanRepaymentSchedule.Reset;
//                             LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
//                             LoanRepaymentSchedule.SetFilter(LoanRepaymentSchedule."Repayment Date", '%1..%2', ASAT, CalcDate('CM', ASAT));
//                             if LoanRepaymentSchedule.Find('-') then begin
//                                 SCHOOLFEESi := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
//                                 SCHOOLFEESp := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');
//                             end;
//                         end;
//                 end;
//                 //SCHOOL FEES end=============================================================================================================================================
//                 //SUPER SCHOOL FEES start==========================================================================================================================================
//                 SUPERSCHOOLFEESp := 0;
//                 SUPERSCHOOLFEESi := 0;
//                 TotalMRepay := 0;
//                 LoansRegister.Reset;
//                 LoansRegister.SetRange("Client Code", Customer."No.");
//                 LoansRegister.SetRange("Loan Product Type", '18');
//                 LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
//                 if LoansRegister.FindSet then begin
//                     LoansRegister.CalcFields("Outstanding Balance", "Oustanding Interest", "Interest Due");
//                     ///****************************************************************************************************
//                     if LoansRegister."Expected Date of Completion" < ASAT then begin
//                         LoanRepaymentSchedule.Reset;
//                         LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
//                         if LoanRepaymentSchedule.FindLast then begin
//                             if LoanRepaymentSchedule."Principal Repayment" > LoansRegister."Outstanding Balance" then
//                                 SUPERSCHOOLFEESp := LoansRegister."Outstanding Balance";
//                             SUPERSCHOOLFEESi := LoansRegister."Oustanding Interest";
//                             if LoanRepaymentSchedule."Principal Repayment" < LoansRegister."Outstanding Balance" then
//                                 SUPERSCHOOLFEESi := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
//                             SUPERSCHOOLFEESp := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');
//                         end
//                     end else
//                         //****************************************************
//                         if LoansRegister."Loan Disbursement Date" < BeginMonth_Date then begin
//                             LoansRegister.CalcFields("Outstanding Balance", "Oustanding Interest", "Interest Due");
//                             LoanRepaymentSchedule.Reset;
//                             LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
//                             LoanRepaymentSchedule.SetFilter(LoanRepaymentSchedule."Repayment Date", '%1..%2', ASAT, CalcDate('CM', ASAT));
//                             if LoanRepaymentSchedule.Find('-') then begin
//                                 SUPERSCHOOLFEESi := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
//                                 SUPERSCHOOLFEESp := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');
//                             end;
//                         end;
//                 end;
//                 //SUPER SCHOOL FEES end=============================================================================================================================================
//                 //INVESTMENT LOAN start==========================================================================================================================================
//                 INVESTMENTLOANp := 0;
//                 INVESTMENTLOANi := 0;
//                 TotalMRepay := 0;
//                 LoansRegister.Reset;
//                 LoansRegister.SetRange("Client Code", Customer."No.");
//                 LoansRegister.SetRange("Loan Product Type", '19');
//                 LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
//                 if LoansRegister.FindSet then begin
//                     LoansRegister.CalcFields("Outstanding Balance", "Oustanding Interest", "Interest Due");
//                     ///****************************************************************************************************
//                     if LoansRegister."Expected Date of Completion" < ASAT then begin
//                         LoanRepaymentSchedule.Reset;
//                         LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
//                         if LoanRepaymentSchedule.FindLast then begin
//                             INVESTMENTLOANi := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
//                             INVESTMENTLOANp := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');
//                         end
//                     end else
//                         //****************************************************
//                         if LoansRegister."Loan Disbursement Date" < BeginMonth_Date then begin
//                             LoanRepaymentSchedule.Reset;
//                             LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
//                             LoanRepaymentSchedule.SetFilter(LoanRepaymentSchedule."Repayment Date", '%1..%2', ASAT, CalcDate('CM', ASAT));
//                             if LoanRepaymentSchedule.Find('-') then begin
//                                 INVESTMENTLOANi := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
//                                 INVESTMENTLOANp := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');
//                             end;
//                         end;
//                 end;
//                 //INVESTMENT LOAN end=============================================================================================================================================
//                 //NORMAL LOAN start==========================================================================================================================================
//                 NORMALLOANp := 0;
//                 NORMALLOANi := 0;
//                 TotalMRepay := 0;
//                 LoansRegister.Reset;
//                 LoansRegister.SetRange("Client Code", Customer."No.");
//                 LoansRegister.SetRange("Loan Product Type", '21');
//                 LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
//                 if LoansRegister.FindSet then begin
//                     LoansRegister.CalcFields("Outstanding Balance", "Oustanding Interest", "Interest Due");
//                     ///****************************************************************************************************
//                     if LoansRegister."Expected Date of Completion" < ASAT then begin
//                         LoanRepaymentSchedule.Reset;
//                         LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
//                         if LoanRepaymentSchedule.FindLast then begin
//                             NORMALLOANi := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
//                             NORMALLOANp := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');
//                         end
//                     end else
//                         //****************************************************
//                         if LoansRegister."Loan Disbursement Date" < BeginMonth_Date then begin
//                             LoansRegister.CalcFields("Outstanding Balance", "Oustanding Interest", "Interest Due");
//                             LoanRepaymentSchedule.Reset;
//                             LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
//                             LoanRepaymentSchedule.SetFilter(LoanRepaymentSchedule."Repayment Date", '%1..%2', ASAT, CalcDate('CM', ASAT));
//                             if LoanRepaymentSchedule.Find('-') then begin
//                                 NORMALLOANi := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
//                                 NORMALLOANp := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');
//                             end;
//                         end;
//                 end;
//                 //Development NORMAL 1 LOAN start==========================================================================================================================================
//                 DevelopmentLoanInt := 0;
//                 TotalMRepay := 0;
//                 DevelopmentLoanP := 0;
//                 LoansRegister.Reset;
//                 LoansRegister.SetRange("Client Code", Customer."No.");
//                 LoansRegister.SetRange("Loan Product Type", '25');
//                 LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
//                 if LoansRegister.FindSet then begin
//                     LoansRegister.CalcFields("Outstanding Balance", "Oustanding Interest", "Interest Due");
//                     ///****************************************************************************************************
//                     if LoansRegister."Expected Date of Completion" < ASAT then begin
//                         LoanRepaymentSchedule.Reset;
//                         LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
//                         if LoanRepaymentSchedule.FindLast then begin
//                             DevelopmentLoanInt := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
//                             DevelopmentLoanP := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');
//                         end
//                     end else
//                         //****************************************************
//                         if LoansRegister."Loan Disbursement Date" < BeginMonth_Date then begin
//                             LoansRegister.CalcFields("Outstanding Balance", "Oustanding Interest", "Interest Due");
//                             LoanRepaymentSchedule.Reset;
//                             LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
//                             LoanRepaymentSchedule.SetFilter(LoanRepaymentSchedule."Repayment Date", '%1..%2', ASAT, CalcDate('CM', ASAT));
//                             if LoanRepaymentSchedule.Find('-') then begin
//                                 DevelopmentLoanInt := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
//                                 DevelopmentLoanP := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');
//                             end;
//                         end;
//                 end;
//                 //NORMAL 1 LOAN start==========================================================================================================================================
//                 NORMALLOAN1i := 0;
//                 TotalMRepay := 0;
//                 NORMALLOAN1p := 0;
//                 LoansRegister.Reset;
//                 LoansRegister.SetRange("Client Code", Customer."No.");
//                 LoansRegister.SetRange("Loan Product Type", '22');
//                 LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
//                 if LoansRegister.FindSet then begin
//                     LoansRegister.CalcFields("Outstanding Balance", "Oustanding Interest", "Interest Due");
//                     ///****************************************************************************************************
//                     if LoansRegister."Expected Date of Completion" < ASAT then begin
//                         LoanRepaymentSchedule.Reset;
//                         LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
//                         if LoanRepaymentSchedule.FindLast then begin
//                             NORMALLOAN1i := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
//                             NORMALLOAN1p := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');
//                         end
//                     end else
//                         //****************************************************
//                         if LoansRegister."Loan Disbursement Date" < BeginMonth_Date then begin
//                             LoansRegister.CalcFields("Outstanding Balance", "Oustanding Interest", "Interest Due");
//                             LoanRepaymentSchedule.Reset;
//                             LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
//                             LoanRepaymentSchedule.SetFilter(LoanRepaymentSchedule."Repayment Date", '%1..%2', ASAT, CalcDate('CM', ASAT));
//                             if LoanRepaymentSchedule.Find('-') then begin
//                                 NORMALLOAN1i := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
//                                 NORMALLOAN1p := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');
//                             end;
//                         end;
//                 end;
//                 //....................................................................................MERCHANDISE
//                 MERCHANDISEPr := 0;
//                 LoansRegister.Reset;
//                 LoansRegister.SetRange("Client Code", Customer."No.");
//                 LoansRegister.SetRange("Loan Product Type", '26');
//                 // LoansRegister.SETRANGE(LoansRegister."Issued Date",ASAT);
//                 LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
//                 if LoansRegister.FindSet then begin
//                     if LoansRegister."Loan Disbursement Date" < BeginMonth_Date then begin
//                         LoansRegister.CalcFields("Outstanding Balance");
//                         //MESSAGE(FORMAT(LoansRegister."Outstanding Balance"));
//                         MERCHANDISEPr := MERCHANDISEPr + LoansRegister."Loan Principle Repayment";
//                         //MESSAGE(FORMAT(DevelopmentLoanP));
//                         //EMERGENCYlnb:=LoansRegister."Loan  No.";
//                     end;
//                 end;
//                 MERCHANDISEIn := 0;
//                 TotalMRepay := 0;
//                 LoansRegister.Reset;
//                 LoansRegister.SetRange("Client Code", Customer."No.");
//                 LoansRegister.SetRange("Loan Product Type", '26');
//                 // LoansRegister.SETRANGE(LoansRegister."Issued Date",ASAT);
//                 LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
//                 if LoansRegister.FindSet then begin
//                     if LoansRegister."Loan Disbursement Date" < BeginMonth_Date then begin
//                         LoansRegister.CalcFields("Outstanding Balance");
//                         LoansRegister.CalcFields("Interest Due");
//                         LoansRegister.CalcFields("Oustanding Interest");
//                         MERCHANDISEIn := DevelopmentLoanInt + LoansRegister."Outstanding Balance" / 12 * LoansRegister.Interest / 100;
//                         //Amortise Loans
//                         if LoansRegister."Repayment Method" = LoansRegister."repayment method"::Amortised then begin
//                             TotalMRepay := ROUND((LoansRegister.Interest / 12 / 100) / (1 - Power((1 + (LoansRegister.Interest / 12 / 100)), -LoansRegister.Installments)) * LoansRegister."Requested Amount", 0.05, '>');
//                             ///DevelopmentLoanP:=(LoansRegister.Interest/12/100) / (1 - POWER((1 + (LoansRegister.Interest/12/100)),- LoansRegister.Installments)) * LoansRegister."Outstanding Balance";
//                             MERCHANDISEIn := ROUND(LoansRegister."Outstanding Balance" / 100 / 12 * LoansRegister.Interest);
//                             //DevelopmentLoanP:=TotalMRepay-DevelopmentLoanInt;
//                         end;
//                     end;
//                     //NORMALLOANi:=NORMALLOANi+LoansRegister."Interest Due";
//                     //Devint:="Loans Register"."Outstanding Balance"*"Loans Register".Interest/100;
//                 end;
//                 //....................................................................................
//                 ////......................................loan
//                 LoansRegister.Reset;
//                 LoansRegister.SetRange("Client Code", Customer."No.");
//                 LoansRegister.SetRange("Loan Product Type", '25');
//                 // LoansRegister.SETRANGE(LoansRegister."Issued Date",ASAT);
//                 LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
//                 if LoansRegister.FindSet then begin
//                     developmentLoan_No := LoansRegister."Loan  No.";
//                     if LoansRegister."Loan  No." = '' then
//                         CurrReport.Skip;
//                 end;
//                 ///.........
//                 LoansRegister.Reset;
//                 LoansRegister.SetRange("Client Code", Customer."No.");
//                 LoansRegister.SetRange("Loan Product Type", '22');
//                 // LoansRegister.SETRANGE(LoansRegister."Issued Date",ASAT);
//                 LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
//                 if LoansRegister.FindSet then begin
//                     NORMALLOAN1LNO := LoansRegister."Loan  No.";
//                     if LoansRegister."Loan  No." = '' then
//                         CurrReport.Skip;
//                 end;
//                 ////.......................................
//                 LoansRegister.Reset;
//                 LoansRegister.SetRange("Client Code", Customer."No.");
//                 LoansRegister.SetRange("Loan Product Type", '21');
//                 // LoansRegister.SETRANGE(LoansRegister."Issued Date",ASAT);
//                 LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
//                 if LoansRegister.FindSet then begin
//                     NORMALLOANLNO := LoansRegister."Loan  No.";
//                     if LoansRegister."Loan  No." = '' then
//                         CurrReport.Skip;
//                 end;
//                 ///..............................................
//                 LoansRegister.Reset;
//                 LoansRegister.SetRange("Client Code", Customer."No.");
//                 LoansRegister.SetRange("Loan Product Type", '19');
//                 // LoansRegister.SETRANGE(LoansRegister."Issued Date",ASAT);
//                 LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
//                 if LoansRegister.FindSet then begin
//                     INVESTMENTLOANLNO := LoansRegister."Loan  No.";
//                     if LoansRegister."Loan  No." = '' then
//                         CurrReport.Skip;
//                 end;
//                 //.............................................
//                 LoansRegister.Reset;
//                 LoansRegister.SetRange("Client Code", Customer."No.");
//                 LoansRegister.SetRange("Loan Product Type", '18');
//                 // LoansRegister.SETRANGE(LoansRegister."Issued Date",ASAT);
//                 LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
//                 if LoansRegister.FindSet then begin
//                     SUPERSCHOOLFEESLNO := LoansRegister."Loan  No.";
//                     if LoansRegister."Loan  No." = '' then
//                         CurrReport.Skip;
//                 end;
//                 //............................
//                 LoansRegister.Reset;
//                 LoansRegister.SetRange("Client Code", Customer."No.");
//                 LoansRegister.SetRange("Loan Product Type", '17');
//                 LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
//                 if LoansRegister.FindSet then begin
//                     SCHOOLFEESLNNO := LoansRegister."Loan  No.";
//                     if LoansRegister."Loan  No." = '' then
//                         CurrReport.Skip;
//                 end;
//                 //..............
//                 LoansRegister.Reset;
//                 LoansRegister.SetRange("Client Code", Customer."No.");
//                 LoansRegister.SetRange("Loan Product Type", '16');
//                 LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
//                 if LoansRegister.FindSet then begin
//                     SUPERQUICKLNO := LoansRegister."Loan  No.";
//                     if LoansRegister."Loan  No." = '' then
//                         CurrReport.Skip;
//                 end;
//                 //.......................
//                 LoansRegister.Reset;
//                 LoansRegister.SetRange("Client Code", Customer."No.");
//                 LoansRegister.SetRange("Loan Product Type", '15');
//                 LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
//                 if LoansRegister.FindSet then begin
//                     QUICKLOANNO := LoansRegister."Loan  No.";
//                     if LoansRegister."Loan  No." = '' then
//                         CurrReport.Skip;
//                 end;
//                 //..............................
//                 LoansRegister.Reset;
//                 LoansRegister.SetRange("Client Code", Customer."No.");
//                 LoansRegister.SetRange("Loan Product Type", '13');
//                 LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
//                 if LoansRegister.FindSet then begin
//                     SUPEREMERGENCYLNO := LoansRegister."Loan  No.";
//                     if LoansRegister."Loan  No." = '' then
//                         CurrReport.Skip;
//                 end;
//                 //////////////.............................
//                 LoansRegister.Reset;
//                 LoansRegister.SetRange("Client Code", Customer."No.");
//                 LoansRegister.SetRange("Loan Product Type", '12');
//                 LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
//                 if LoansRegister.FindSet then begin
//                     EMERGENCYLNO := LoansRegister."Loan  No.";
//                     if LoansRegister."Loan  No." = '' then
//                         CurrReport.Skip;
//                 end;
//                 //..........................
//                 LoansRegister.Reset;
//                 LoansRegister.SetRange("Client Code", Customer."No.");
//                 LoansRegister.SetRange("Loan Product Type", '23');
//                 LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
//                 if LoansRegister.FindSet then begin
//                     if LoansRegister."Loan  No." = '' then
//                         CurrReport.Skip;
//                     inDev1 := LoansRegister."Loan  No.";
//                 end;
//                 //.................LoansRegister.RESET;
//                 LoansRegister.SetRange("Client Code", Customer."No.");
//                 LoansRegister.SetRange("Loan Product Type", '20');
//                 LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
//                 if LoansRegister.FindSet then begin
//                     lndev := LoansRegister."Loan  No.";
//                     if LoansRegister."Loan  No." = '' then
//                         CurrReport.Skip;
//                 end;
//                 LoansRegister.SetRange("Client Code", Customer."No.");
//                 LoansRegister.SetRange("Loan Product Type", '26');
//                 LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
//                 if LoansRegister.FindSet then begin
//                     MERCHANDISE_No := LoansRegister."Loan  No.";
//                     if LoansRegister."Loan  No." = '' then
//                         CurrReport.Skip;
//                 end;
//                 TOTALREMMITANCE := 0;
//                 TOTALREMMITANCE := montlycon + NORMALLOAN1i + NORMALLOANp + NORMALLOANi + NORMALLOAN1p + EMERGENCYp + EMERGENCYi + SUPEREMERGENCYp + SUPEREMERGENCYi + QUICKLOANp + QUICKLOANi + SUPERQUICKp + SUPERQUICKi + SCHOOLFEESp + SCHOOLFEESi + SUPERSCHOOLFEESp + SUPERSCHOOLFEESi +
//                 INVESTMENTLOANi + DevP + Devint + DevelopmentLoanP + DevelopmentLoanInt + MERCHANDISEPr + MERCHANDISEIn;
//             end;

//         }
//     }
//     requestpage
//     {
//         SaveValues = false;
//         layout
//         {
//             area(Content)
//             {
//                 field(Date; ASAT)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Date';
//                 }
//             }
//         }

//     }
//     var
//         EndMonth_Date: Date;
//         BeginMonth_Date: Date;
//         ASAT: Date;
//         LoansRegister: Record "Loans Register";
//         ShareCapital: Decimal;
//         DevP: Decimal;
//         DevLNO: Code[20];
//         Devint: Decimal;
//         montlycon: Decimal;
//         lndev: Code[30];
//         EMERGENCYp: Decimal;
//         EMERGENCYi: Decimal;
//         EMERGENCYLNO: Code[20];
//         EMERGENCYlnb: Code[30];
//         SUPEREMERGENCYLNO: Code[20];
//         SUPEREMERGENCYp: Decimal;
//         SUPEREMERGENCYi: Decimal;
//         QUICKLOANNO: Code[20];
//         QUICKLOANp: Decimal;
//         QUICKLOANi: Decimal;
//         SUPERQUICKLNO: Code[20];
//         SUPERQUICKp: Decimal;
//         SUPERQUICKi: Decimal;
//         SCHOOLFEESLNNO: Code[20];
//         SCHOOLFEESp: Decimal;
//         SCHOOLFEESi: Decimal;
//         SUPERSCHOOLFEESLNO: Code[20];
//         SUPERSCHOOLFEESp: Decimal;
//         SUPERSCHOOLFEESi: Decimal;
//         INVESTMENTLOANLNO: Code[20];
//         INVESTMENTLOANp: Decimal;
//         INVESTMENTLOANi: Decimal;
//         TOTALREMMITANCE: Decimal;
//         CI: Record "Company Information";
//         NORMALLOANLNO: Code[20];
//         NORMALLOANp: Decimal;
//         NORMALLOANi: Decimal;
//         NORMALLOAN1LNO: Code[20];
//         NORMALLOAN1p: Decimal;
//         NORMALLOAN1i: Decimal;
//         DevP1LNO: Code[20];
//         DevP1: Decimal;
//         Devint1: Decimal;
//         inDev1: Code[50];
//         LoanRepaymentSchedule: Record "Loan Repayment Schedule";
//         DevelopmentLoanP: Decimal;
//         DevelopmentLoanInt: Decimal;
//         developmentLoan_No: Code[20];
//         TotalMRepay: Decimal;
//         MERCHANDISEPr: Decimal;
//         MERCHANDISEIn: Decimal;
//         MERCHANDISE_No: Code[20];

//     // trigger OnInitReport();
//     // begin
//     //     ;
//     //     ReportsForNavInit;
//     // end;

//     // trigger OnPreReport();
//     // begin
//     //     ;
//     //     ReportsForNavPre;
//     // end;

//     // --> Reports ForNAV Autogenerated code - do not delete or modify
//     var
//         ReportForNavTotalsCausedBy: Integer;
//         ReportForNavInitialized: Boolean;
//         ReportForNavShowOutput: Boolean;

//     /*local procedure ReportsForNavInit()
// 	var
// 		id: Integer;
// 		FormatRegion: Text;
// 	begin
// 		Evaluate(id, CopyStr(CurrReport.ObjectId(false), StrPos(CurrReport.ObjectId(false), ' ') + 1));
// 		ReportForNav.OnInit(id);
// 	end;
// 	local procedure ReportsForNavPre() begin end;
// 	local procedure ReportForNavSetTotalsCausedBy(value : Integer) begin ReportForNavTotalsCausedBy := value; end;
// 	local procedure ReportForNavSetShowOutput(value : Boolean) begin ReportForNavShowOutput := value; end;
// 	local procedure ReportForNavInit(jsonObject : JsonObject) begin ReportForNav.Init(jsonObject, CurrReport.ObjectId); end;
// 	local procedure ReportForNavWriteDataItem(dataItemId: Text; rec : Variant) : Text
// 	var
// 		values: Text;
// 		jsonObject: JsonObject;
// 		currLanguage: Integer;
// 	begin
// 		if not ReportForNavInitialized then begin
// 			ReportForNavInit(jsonObject);
// 			ReportForNavInitialized := true;
// 		end;

// 		case (dataItemId) of
// 			'Customer':
// 				begin
// 					currLanguage := GlobalLanguage; GlobalLanguage := 1033; jsonObject.Add('DataItem$Customer$CurrentKey$Text',Customer.CurrentKey); GlobalLanguage := currLanguage;
// 				end;
// 		end;
// 		ReportForNav.AddDataItemValues(jsonObject,dataItemId,rec);
// 		jsonObject.WriteTo(values);
// 		exit(values);
// 	end;*/
//     // Reports ForNAV Autogenerated code - do not delete or modify -->
// }
