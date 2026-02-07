report 51582 CheckoffByCustomerBank
{
    ApplicationArea = All;
    Caption = 'CheckoffByCustomerBank';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './Layouts/CheckoffByCustomerBanks.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {

            //DataItemTableView = where(Status = filter(Active));
            //RequestFilterFields = "Bank Code";


            // column(AsAtDateFormatted; Format(ASAT, 0, '<Day,2>-<Month,3>-<Year4>')) { }
            column(AsAtDateFormatted; ASAT) { }
            column(CompanyName; CI.Name)
            {
            }
            column(CompanyAddress; CI.Address)
            {
            }
            column(CompanyPhone; CI."Phone No.")
            {
            }
            column(CompanyPic; CI.Picture)
            {
            }
            column(CompanyEmail; CI."E-Mail")
            {
            }
            column(BankAccountNo; "Bank Account No.")
            {
            }
            column(BankBranchCode; "Bank Branch Code")
            {
            }
            column(BankBranchName; "Bank Branch Name")
            {
            }
            column(BankAccountName; "Bank Account Name")
            {
            }
            column(BankCode; "Bank Code")
            {
            }

            column(Payroll_Staff_No; "Payroll/Staff No")
            { }

            column(BankName; BankName) { }
            // column(BankName; "Bank Name")
            // {
            // }
            column(Name; Name)
            {
            }
            column(No; "No.")
            {
            }

            column(TOTALREMMITANCE; TOTALREMMITANCE)
            {


            }

            column(CRAccountCode; CRAccountCode) { }
            column(CRAccountNumber; CRAccountNumber) { }


            trigger OnAfterGetRecord();
            begin

                // BankRec.Reset();
                // BankRec.SetRange("Bank Code", "Bank Code");
                // if BankRec.FindFirst() then
                //     BankName := BankRec."Bank Name"
                // else
                //     BankName := '';

                case BankSelection of
                    BankSelection::KCB:
                        BankName := 'KCB';
                    BankSelection::COOP:
                        BankName := 'COOP';
                    BankSelection::OTHERS:
                        BankName := 'OTHERS';
                end;


                // Set CR account fields based on selection
                case BankSelection of
                    BankSelection::KCB:
                        begin
                            CRAccountCode := '01330';
                            CRAccountNumber := '1319934188';
                        end;
                    BankSelection::COOP:
                        begin
                            CRAccountCode := '11011';
                            CRAccountNumber := '01100040130700';
                        end;
                    BankSelection::OTHERS:
                        begin
                            CRAccountCode := '11011';
                            CRAccountNumber := '01100040130700';
                        end;

                    else begin
                        Clear(CRAccountCode);
                        Clear(CRAccountNumber);
                    end;
                end;



                CI.Get();
                CI.CalcFields(Picture);
                ShareCapital := 0;
                Customer.CalcFields(Customer."Shares Retained");
                //MESSAGE (FORMAT(Customer."Shares Retained"));
                if Customer."Shares Retained" >= 20000 then begin
                    ShareCapital := 0
                end else
                    if Customer."Shares Retained" > 5000 then begin
                        ShareCapital := 417
                    end else
                        if Customer."Shares Retained" < 5000 then begin
                            ShareCapital := 1000
                        end;
                //MESSAGE(FORMAT(ASAT));
                BeginMonth_Date := CalcDate('<-CM +14D>', ASAT);
                // EndMonth_Date := CALCDATE('<-15D>', ASAT);
                //MESSAGE ('begg IS %1',BeginMonth_Date);
                montlycon := Customer."Monthly Contribution";
                "Welfare Contr" := Customer."Welfare Contr";
                Customer.SetFilter(Customer."Monthly Contribution", '>%1', 0);
                //development start==========================================================================================================================================
                DevP := 0;
                Devint := 0;
                TotalMRepay := 0;
                LoansRegister.Reset;
                LoansRegister.SetRange("Client Code", Customer."No.");
                LoansRegister.SetRange("Loan Product Type", '20');
                LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
                if LoansRegister.FindSet then begin
                    LoansRegister.CalcFields("Outstanding Balance", "Oustanding Interest", "Interest Due");
                    ///****************************************************************************************************
                    if LoansRegister."Expected Date of Completion" < ASAT then begin
                        LoanRepaymentSchedule.Reset;
                        LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
                        if LoanRepaymentSchedule.FindLast then begin
                            if LoanRepaymentSchedule."Principal Repayment" > LoansRegister."Outstanding Balance" then
                                DevP := LoansRegister."Outstanding Balance";
                            Devint := LoansRegister."Oustanding Interest";
                            if LoanRepaymentSchedule."Principal Repayment" < LoansRegister."Outstanding Balance" then
                                Devint := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
                            DevP := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');
                        end
                    end else
                        //****************************************************
                        if LoansRegister."Loan Disbursement Date" < BeginMonth_Date then begin
                            LoansRegister.CalcFields("Outstanding Balance", "Oustanding Interest", "Interest Due");
                            LoanRepaymentSchedule.Reset;
                            LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
                            LoanRepaymentSchedule.SetFilter(LoanRepaymentSchedule."Repayment Date", '%1..%2', ASAT, CalcDate('CM', ASAT));
                            if LoanRepaymentSchedule.Find('-') then begin
                                Devint := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
                                DevP := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');
                            end;
                        end;
                end;
                //development end=============================================================================================================================================
                //development 1 start==========================================================================================================================================
                DevP1 := 0;
                Devint1 := 0;
                TotalMRepay := 0;
                LoansRegister.Reset;
                LoansRegister.SetRange("Client Code", Customer."No.");
                LoansRegister.SetRange("Loan Product Type", '23');
                LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
                if LoansRegister.FindSet then begin
                    LoansRegister.CalcFields("Outstanding Balance", "Oustanding Interest", "Interest Due");
                    ///****************************************************************************************************
                    if LoansRegister."Expected Date of Completion" < ASAT then begin
                        LoanRepaymentSchedule.Reset;
                        LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
                        if LoanRepaymentSchedule.FindLast then begin
                            if LoanRepaymentSchedule."Principal Repayment" > LoansRegister."Outstanding Balance" then
                                DevP1 := LoansRegister."Outstanding Balance";
                            Devint1 := LoansRegister."Oustanding Interest";
                            if LoanRepaymentSchedule."Principal Repayment" < LoansRegister."Outstanding Balance" then
                                Devint1 := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
                            DevP1 := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');
                        end
                    end else
                        //****************************************************
                        if LoansRegister."Loan Disbursement Date" < BeginMonth_Date then begin
                            LoansRegister.CalcFields("Outstanding Balance", "Oustanding Interest", "Interest Due");
                            LoanRepaymentSchedule.Reset;
                            LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
                            LoanRepaymentSchedule.SetFilter(LoanRepaymentSchedule."Repayment Date", '%1..%2', ASAT, CalcDate('CM', ASAT));
                            if LoanRepaymentSchedule.Find('-') then begin
                                Devint1 := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
                                DevP1 := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');
                            end;
                        end;
                end;
                //development 1 end=============================================================================================================================================
                //EMERGENCY LOAN start==========================================================================================================================================
                EMERGENCYi := 0;
                EMERGENCYp := 0;
                TotalMRepay := 0;
                LoansRegister.Reset;
                LoansRegister.SetRange("Client Code", Customer."No.");
                LoansRegister.SetRange("Loan Product Type", '12');
                LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
                if LoansRegister.FindSet then begin
                    LoansRegister.CalcFields("Outstanding Balance", "Oustanding Interest", "Interest Due");
                    //************************************************************************************************************
                    if LoansRegister."Expected Date of Completion" < Today then begin
                        LoanRepaymentSchedule.Reset;
                        LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
                        if LoanRepaymentSchedule.FindLast then begin
                            if LoanRepaymentSchedule."Principal Repayment" > LoansRegister."Outstanding Balance" then
                                EMERGENCYp := LoansRegister."Outstanding Balance";
                            EMERGENCYi := LoansRegister."Oustanding Interest";
                            if LoanRepaymentSchedule."Principal Repayment" < LoansRegister."Outstanding Balance" then
                                EMERGENCYi := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
                            EMERGENCYp := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');
                        end
                    end else
                        if LoansRegister."Loan Disbursement Date" < BeginMonth_Date then begin
                            LoanRepaymentSchedule.Reset;
                            LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
                            LoanRepaymentSchedule.SetFilter(LoanRepaymentSchedule."Repayment Date", '%1..%2', ASAT, CalcDate('CM', ASAT));
                            if LoanRepaymentSchedule.Find('-') then begin
                                EMERGENCYi := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
                                EMERGENCYp := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');
                            end;
                        end;
                end;
                //EMERGENCY LOAN end=============================================================================================================================================
                //SUPER EMERGENCY LOAN start==========================================================================================================================================
                SUPEREMERGENCYi := 0;
                SUPEREMERGENCYp := 0;
                TotalMRepay := 0;
                LoansRegister.Reset;
                LoansRegister.SetRange("Client Code", Customer."No.");
                LoansRegister.SetRange("Loan Product Type", '13');
                LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
                if LoansRegister.FindSet then begin
                    LoansRegister.CalcFields("Outstanding Balance", "Oustanding Interest", "Interest Due");
                    ///****************************************************************************************************
                    if LoansRegister."Expected Date of Completion" < Today then begin
                        LoanRepaymentSchedule.Reset;
                        LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
                        if LoanRepaymentSchedule.FindLast then begin
                            if LoanRepaymentSchedule."Principal Repayment" > LoansRegister."Outstanding Balance" then
                                SUPEREMERGENCYp := LoansRegister."Outstanding Balance";
                            SUPEREMERGENCYi := LoansRegister."Oustanding Interest";
                            if LoanRepaymentSchedule."Principal Repayment" < LoansRegister."Outstanding Balance" then
                                SUPEREMERGENCYi := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
                            SUPEREMERGENCYp := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');
                        end
                    end else
                        //****************************************************
                        if LoansRegister."Loan Disbursement Date" < BeginMonth_Date then begin
                            LoanRepaymentSchedule.Reset;
                            LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
                            LoanRepaymentSchedule.SetFilter(LoanRepaymentSchedule."Repayment Date", '%1..%2', ASAT, CalcDate('CM', ASAT));
                            if LoanRepaymentSchedule.Find('-') then begin
                                SUPEREMERGENCYi := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
                                SUPEREMERGENCYp := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');
                            end;
                        end;
                end;
                //SUPER EMERGENCY LOAN end=============================================================================================================================================
                //QUICK LOAN start==========================================================================================================================================
                QUICKLOANp := 0;
                QUICKLOANi := 0;
                TotalMRepay := 0;
                LoansRegister.Reset;
                LoansRegister.SetRange("Client Code", Customer."No.");
                LoansRegister.SetRange("Loan Product Type", '15');
                LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
                if LoansRegister.FindSet then begin
                    ///******************************************************************
                    LoansRegister.CalcFields("Outstanding Balance", "Oustanding Interest", "Interest Due");
                    ///****************************************************************************************************
                    if LoansRegister."Expected Date of Completion" < ASAT then begin
                        LoanRepaymentSchedule.Reset;
                        LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
                        if LoanRepaymentSchedule.FindLast then begin
                            if LoanRepaymentSchedule."Principal Repayment" > LoansRegister."Outstanding Balance" then
                                QUICKLOANp := LoansRegister."Outstanding Balance";
                            QUICKLOANi := LoansRegister."Oustanding Interest";
                            if LoanRepaymentSchedule."Principal Repayment" < LoansRegister."Outstanding Balance" then
                                QUICKLOANi := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
                            QUICKLOANp := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');
                        end
                    end else
                        //****************************************************
                        if LoansRegister."Loan Disbursement Date" < BeginMonth_Date then begin
                            LoansRegister.CalcFields("Outstanding Balance", "Oustanding Interest", "Interest Due");
                            LoanRepaymentSchedule.Reset;
                            LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
                            LoanRepaymentSchedule.SetFilter(LoanRepaymentSchedule."Repayment Date", '%1..%2', ASAT, CalcDate('CM', ASAT));
                            if LoanRepaymentSchedule.Find('-') then begin
                                QUICKLOANi := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
                                QUICKLOANp := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');
                            end;
                        end;
                end;
                //QUICK LOAN end=============================================================================================================================================
                //SUPER QUICK start==========================================================================================================================================
                SUPERQUICKp := 0;
                SUPERQUICKi := 0;
                TotalMRepay := 0;
                LoansRegister.Reset;
                LoansRegister.SetRange("Client Code", Customer."No.");
                LoansRegister.SetRange("Loan Product Type", '16');
                LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
                if LoansRegister.FindSet then begin
                    LoansRegister.CalcFields("Outstanding Balance", "Oustanding Interest", "Interest Due");
                    ///****************************************************************************************************
                    if LoansRegister."Expected Date of Completion" <= ASAT then begin
                        LoanRepaymentSchedule.Reset;
                        LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
                        if LoanRepaymentSchedule.FindLast then begin
                            if LoanRepaymentSchedule."Principal Repayment" > LoansRegister."Outstanding Balance" then
                                SUPERQUICKp := LoansRegister."Outstanding Balance";
                            SUPERQUICKi := LoansRegister."Oustanding Interest";
                            if LoanRepaymentSchedule."Principal Repayment" < LoansRegister."Outstanding Balance" then
                                SUPERQUICKi := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
                            SUPERQUICKp := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');
                        end
                    end else
                        //****************************************************
                        if LoansRegister."Loan Disbursement Date" < BeginMonth_Date then begin
                            LoansRegister.CalcFields("Outstanding Balance", "Oustanding Interest", "Interest Due");
                            LoanRepaymentSchedule.Reset;
                            LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
                            LoanRepaymentSchedule.SetFilter(LoanRepaymentSchedule."Repayment Date", '%1..%2', ASAT, CalcDate('CM', ASAT));
                            if LoanRepaymentSchedule.Find('-') then begin
                                SUPERQUICKi := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
                                SUPERQUICKp := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');
                            end;
                        end;
                end;
                //SUPER QUICK end=============================================================================================================================================
                //SCHOOL FEES start==========================================================================================================================================
                SCHOOLFEESp := 0;
                SCHOOLFEESi := 0;
                TotalMRepay := 0;
                LoansRegister.Reset;
                LoansRegister.SetRange("Client Code", Customer."No.");
                LoansRegister.SetRange("Loan Product Type", '17');
                LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
                if LoansRegister.FindSet then begin
                    LoansRegister.CalcFields("Outstanding Balance", "Oustanding Interest", "Interest Due");
                    ///****************************************************************************************************
                    if LoansRegister."Expected Date of Completion" < ASAT then begin
                        LoanRepaymentSchedule.Reset;
                        LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
                        if LoanRepaymentSchedule.FindLast then begin
                            if LoanRepaymentSchedule."Principal Repayment" > LoansRegister."Outstanding Balance" then
                                SCHOOLFEESp := LoansRegister."Outstanding Balance";
                            SCHOOLFEESi := LoansRegister."Oustanding Interest";
                            if LoanRepaymentSchedule."Principal Repayment" < LoansRegister."Outstanding Balance" then
                                SCHOOLFEESi := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
                            SCHOOLFEESp := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');
                        end
                    end else
                        //****************************************************
                        if LoansRegister."Loan Disbursement Date" < BeginMonth_Date then begin
                            LoansRegister.CalcFields("Outstanding Balance", "Oustanding Interest", "Interest Due");
                            LoanRepaymentSchedule.Reset;
                            LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
                            LoanRepaymentSchedule.SetFilter(LoanRepaymentSchedule."Repayment Date", '%1..%2', ASAT, CalcDate('CM', ASAT));
                            if LoanRepaymentSchedule.Find('-') then begin
                                SCHOOLFEESi := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
                                SCHOOLFEESp := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');
                            end;
                        end;
                end;
                //SCHOOL FEES end=============================================================================================================================================
                //SUPER SCHOOL FEES start==========================================================================================================================================
                SUPERSCHOOLFEESp := 0;
                SUPERSCHOOLFEESi := 0;
                TotalMRepay := 0;
                LoansRegister.Reset;
                LoansRegister.SetRange("Client Code", Customer."No.");
                LoansRegister.SetRange("Loan Product Type", '18');
                LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
                if LoansRegister.FindSet then begin
                    LoansRegister.CalcFields("Outstanding Balance", "Oustanding Interest", "Interest Due");
                    ///****************************************************************************************************
                    if LoansRegister."Expected Date of Completion" < ASAT then begin
                        LoanRepaymentSchedule.Reset;
                        LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
                        if LoanRepaymentSchedule.FindLast then begin
                            if LoanRepaymentSchedule."Principal Repayment" > LoansRegister."Outstanding Balance" then
                                SUPERSCHOOLFEESp := LoansRegister."Outstanding Balance";
                            SUPERSCHOOLFEESi := LoansRegister."Oustanding Interest";
                            if LoanRepaymentSchedule."Principal Repayment" < LoansRegister."Outstanding Balance" then
                                SUPERSCHOOLFEESi := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
                            SUPERSCHOOLFEESp := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');
                        end
                    end else
                        //****************************************************
                        if LoansRegister."Loan Disbursement Date" < BeginMonth_Date then begin
                            LoansRegister.CalcFields("Outstanding Balance", "Oustanding Interest", "Interest Due");
                            LoanRepaymentSchedule.Reset;
                            LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
                            LoanRepaymentSchedule.SetFilter(LoanRepaymentSchedule."Repayment Date", '%1..%2', ASAT, CalcDate('CM', ASAT));
                            if LoanRepaymentSchedule.Find('-') then begin
                                SUPERSCHOOLFEESi := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
                                SUPERSCHOOLFEESp := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');
                            end;
                        end;
                end;
                //SUPER SCHOOL FEES end=============================================================================================================================================
                //INVESTMENT LOAN start==========================================================================================================================================
                INVESTMENTLOANp := 0;
                INVESTMENTLOANi := 0;
                TotalMRepay := 0;
                LoansRegister.Reset;
                LoansRegister.SetRange("Client Code", Customer."No.");
                LoansRegister.SetRange("Loan Product Type", '19');
                LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
                if LoansRegister.FindSet then begin
                    LoansRegister.CalcFields("Outstanding Balance", "Oustanding Interest", "Interest Due");
                    ///****************************************************************************************************
                    if LoansRegister."Expected Date of Completion" < ASAT then begin
                        LoanRepaymentSchedule.Reset;
                        LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
                        if LoanRepaymentSchedule.FindLast then begin
                            INVESTMENTLOANi := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
                            INVESTMENTLOANp := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');
                        end
                    end else
                        //****************************************************
                        if LoansRegister."Loan Disbursement Date" < BeginMonth_Date then begin
                            LoanRepaymentSchedule.Reset;
                            LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
                            LoanRepaymentSchedule.SetFilter(LoanRepaymentSchedule."Repayment Date", '%1..%2', ASAT, CalcDate('CM', ASAT));
                            if LoanRepaymentSchedule.Find('-') then begin
                                INVESTMENTLOANi := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
                                INVESTMENTLOANp := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');
                            end;
                        end;
                end;
                //INVESTMENT LOAN end=============================================================================================================================================
                //NORMAL LOAN start==========================================================================================================================================
                NORMALLOANp := 0;
                NORMALLOANi := 0;
                TotalMRepay := 0;
                LoansRegister.Reset;
                LoansRegister.SetRange("Client Code", Customer."No.");
                LoansRegister.SetRange("Loan Product Type", '21');
                LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
                if LoansRegister.FindSet then begin
                    LoansRegister.CalcFields("Outstanding Balance", "Oustanding Interest", "Interest Due");
                    ///****************************************************************************************************
                    if LoansRegister."Expected Date of Completion" < ASAT then begin
                        LoanRepaymentSchedule.Reset;
                        LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
                        if LoanRepaymentSchedule.FindLast then begin
                            NORMALLOANi := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
                            NORMALLOANp := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');
                        end
                    end else
                        //****************************************************
                        if LoansRegister."Loan Disbursement Date" < BeginMonth_Date then begin
                            LoansRegister.CalcFields("Outstanding Balance", "Oustanding Interest", "Interest Due");
                            LoanRepaymentSchedule.Reset;
                            LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
                            LoanRepaymentSchedule.SetFilter(LoanRepaymentSchedule."Repayment Date", '%1..%2', ASAT, CalcDate('CM', ASAT));
                            if LoanRepaymentSchedule.Find('-') then begin
                                NORMALLOANi := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
                                NORMALLOANp := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');
                            end;
                        end;
                end;
                //Development NORMAL 1 LOAN start==========================================================================================================================================
                DevelopmentLoanInt := 0;
                TotalMRepay := 0;
                DevelopmentLoanP := 0;
                LoansRegister.Reset;
                LoansRegister.SetRange("Client Code", Customer."No.");
                LoansRegister.SetRange("Loan Product Type", '25');
                LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
                if LoansRegister.FindSet then begin
                    LoansRegister.CalcFields("Outstanding Balance", "Oustanding Interest", "Interest Due");
                    ///****************************************************************************************************
                    if LoansRegister."Expected Date of Completion" < ASAT then begin
                        LoanRepaymentSchedule.Reset;
                        LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
                        if LoanRepaymentSchedule.FindLast then begin
                            DevelopmentLoanInt := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
                            DevelopmentLoanP := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');
                        end
                    end else
                        //****************************************************
                        if LoansRegister."Loan Disbursement Date" < BeginMonth_Date then begin
                            LoansRegister.CalcFields("Outstanding Balance", "Oustanding Interest", "Interest Due");
                            LoanRepaymentSchedule.Reset;
                            LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
                            LoanRepaymentSchedule.SetFilter(LoanRepaymentSchedule."Repayment Date", '%1..%2', ASAT, CalcDate('CM', ASAT));
                            if LoanRepaymentSchedule.Find('-') then begin
                                DevelopmentLoanInt := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
                                DevelopmentLoanP := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');
                            end;
                        end;
                end;
                //NORMAL 1 LOAN start==========================================================================================================================================
                NORMALLOAN1i := 0;
                TotalMRepay := 0;
                NORMALLOAN1p := 0;
                LoansRegister.Reset;
                LoansRegister.SetRange("Client Code", Customer."No.");
                LoansRegister.SetRange("Loan Product Type", '22');
                LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
                if LoansRegister.FindSet then begin
                    LoansRegister.CalcFields("Outstanding Balance", "Oustanding Interest", "Interest Due");
                    ///****************************************************************************************************
                    if LoansRegister."Expected Date of Completion" < ASAT then begin
                        LoanRepaymentSchedule.Reset;
                        LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
                        if LoanRepaymentSchedule.FindLast then begin
                            NORMALLOAN1i := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
                            NORMALLOAN1p := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');
                        end
                    end else
                        //****************************************************
                        if LoansRegister."Loan Disbursement Date" < BeginMonth_Date then begin
                            LoansRegister.CalcFields("Outstanding Balance", "Oustanding Interest", "Interest Due");
                            LoanRepaymentSchedule.Reset;
                            LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
                            LoanRepaymentSchedule.SetFilter(LoanRepaymentSchedule."Repayment Date", '%1..%2', ASAT, CalcDate('CM', ASAT));
                            if LoanRepaymentSchedule.Find('-') then begin
                                NORMALLOAN1i := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
                                NORMALLOAN1p := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');
                            end;
                        end;
                end;
                //....................................................................................MERCHANDISE
                MERCHANDISEPr := 0;
                LoansRegister.Reset;
                LoansRegister.SetRange("Client Code", Customer."No.");
                LoansRegister.SetRange("Loan Product Type", '26');
                // LoansRegister.SETRANGE(LoansRegister."Issued Date",ASAT);
                LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
                if LoansRegister.FindSet then begin
                    if LoansRegister."Loan Disbursement Date" < BeginMonth_Date then begin
                        LoansRegister.CalcFields("Outstanding Balance");
                        //MESSAGE(FORMAT(LoansRegister."Outstanding Balance"));
                        MERCHANDISEPr := MERCHANDISEPr + LoansRegister."Loan Principle Repayment";
                        //MESSAGE(FORMAT(DevelopmentLoanP));
                        //EMERGENCYlnb:=LoansRegister."Loan  No.";
                    end;
                end;
                MERCHANDISEIn := 0;
                TotalMRepay := 0;
                LoansRegister.Reset;
                LoansRegister.SetRange("Client Code", Customer."No.");
                LoansRegister.SetRange("Loan Product Type", '26');
                // LoansRegister.SETRANGE(LoansRegister."Issued Date",ASAT);
                LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
                if LoansRegister.FindSet then begin
                    if LoansRegister."Loan Disbursement Date" < BeginMonth_Date then begin
                        LoansRegister.CalcFields("Outstanding Balance");
                        LoansRegister.CalcFields("Interest Due");
                        LoansRegister.CalcFields("Oustanding Interest");
                        MERCHANDISEIn := DevelopmentLoanInt + LoansRegister."Outstanding Balance" / 12 * LoansRegister.Interest / 100;
                        //Amortise Loans
                        if LoansRegister."Repayment Method" = LoansRegister."repayment method"::Amortised then begin
                            TotalMRepay := ROUND((LoansRegister.Interest / 12 / 100) / (1 - Power((1 + (LoansRegister.Interest / 12 / 100)), -LoansRegister.Installments)) * LoansRegister."Requested Amount", 0.05, '>');
                            ///DevelopmentLoanP:=(LoansRegister.Interest/12/100) / (1 - POWER((1 + (LoansRegister.Interest/12/100)),- LoansRegister.Installments)) * LoansRegister."Outstanding Balance";
                            MERCHANDISEIn := ROUND(LoansRegister."Outstanding Balance" / 100 / 12 * LoansRegister.Interest);
                            //DevelopmentLoanP:=TotalMRepay-DevelopmentLoanInt;
                        end;
                    end;
                    //NORMALLOANi:=NORMALLOANi+LoansRegister."Interest Due";
                    //Devint:="Loans Register"."Outstanding Balance"*"Loans Register".Interest/100;
                end;
                //....................................................................................
                ////......................................loan
                LoansRegister.Reset;
                LoansRegister.SetRange("Client Code", Customer."No.");
                LoansRegister.SetRange("Loan Product Type", '25');
                // LoansRegister.SETRANGE(LoansRegister."Issued Date",ASAT);
                LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
                if LoansRegister.FindSet then begin
                    developmentLoan_No := LoansRegister."Loan  No.";
                    if LoansRegister."Loan  No." = '' then
                        CurrReport.Skip;
                end;
                ///.........
                LoansRegister.Reset;
                LoansRegister.SetRange("Client Code", Customer."No.");
                LoansRegister.SetRange("Loan Product Type", '22');
                // LoansRegister.SETRANGE(LoansRegister."Issued Date",ASAT);
                LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
                if LoansRegister.FindSet then begin
                    NORMALLOAN1LNO := LoansRegister."Loan  No.";
                    if LoansRegister."Loan  No." = '' then
                        CurrReport.Skip;
                end;
                ////.......................................
                LoansRegister.Reset;
                LoansRegister.SetRange("Client Code", Customer."No.");
                LoansRegister.SetRange("Loan Product Type", '21');
                // LoansRegister.SETRANGE(LoansRegister."Issued Date",ASAT);
                LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
                if LoansRegister.FindSet then begin
                    NORMALLOANLNO := LoansRegister."Loan  No.";
                    if LoansRegister."Loan  No." = '' then
                        CurrReport.Skip;
                end;
                ///..............................................
                LoansRegister.Reset;
                LoansRegister.SetRange("Client Code", Customer."No.");
                LoansRegister.SetRange("Loan Product Type", '19');
                // LoansRegister.SETRANGE(LoansRegister."Issued Date",ASAT);
                LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
                if LoansRegister.FindSet then begin
                    INVESTMENTLOANLNO := LoansRegister."Loan  No.";
                    if LoansRegister."Loan  No." = '' then
                        CurrReport.Skip;
                end;
                //.............................................
                LoansRegister.Reset;
                LoansRegister.SetRange("Client Code", Customer."No.");
                LoansRegister.SetRange("Loan Product Type", '18');
                // LoansRegister.SETRANGE(LoansRegister."Issued Date",ASAT);
                LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
                if LoansRegister.FindSet then begin
                    SUPERSCHOOLFEESLNO := LoansRegister."Loan  No.";
                    if LoansRegister."Loan  No." = '' then
                        CurrReport.Skip;
                end;
                //............................
                LoansRegister.Reset;
                LoansRegister.SetRange("Client Code", Customer."No.");
                LoansRegister.SetRange("Loan Product Type", '17');
                LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
                if LoansRegister.FindSet then begin
                    SCHOOLFEESLNNO := LoansRegister."Loan  No.";
                    if LoansRegister."Loan  No." = '' then
                        CurrReport.Skip;
                end;
                //..............
                LoansRegister.Reset;
                LoansRegister.SetRange("Client Code", Customer."No.");
                LoansRegister.SetRange("Loan Product Type", '16');
                LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
                if LoansRegister.FindSet then begin
                    SUPERQUICKLNO := LoansRegister."Loan  No.";
                    if LoansRegister."Loan  No." = '' then
                        CurrReport.Skip;
                end;
                //.......................
                LoansRegister.Reset;
                LoansRegister.SetRange("Client Code", Customer."No.");
                LoansRegister.SetRange("Loan Product Type", '15');
                LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
                if LoansRegister.FindSet then begin
                    QUICKLOANNO := LoansRegister."Loan  No.";
                    if LoansRegister."Loan  No." = '' then
                        CurrReport.Skip;
                end;
                //..............................
                LoansRegister.Reset;
                LoansRegister.SetRange("Client Code", Customer."No.");
                LoansRegister.SetRange("Loan Product Type", '13');
                LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
                if LoansRegister.FindSet then begin
                    SUPEREMERGENCYLNO := LoansRegister."Loan  No.";
                    if LoansRegister."Loan  No." = '' then
                        CurrReport.Skip;
                end;
                //////////////.............................
                LoansRegister.Reset;
                LoansRegister.SetRange("Client Code", Customer."No.");
                LoansRegister.SetRange("Loan Product Type", '12');
                LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
                if LoansRegister.FindSet then begin
                    EMERGENCYLNO := LoansRegister."Loan  No.";
                    if LoansRegister."Loan  No." = '' then
                        CurrReport.Skip;
                end;
                //..........................
                LoansRegister.Reset;
                LoansRegister.SetRange("Client Code", Customer."No.");
                LoansRegister.SetRange("Loan Product Type", '23');
                LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
                if LoansRegister.FindSet then begin
                    if LoansRegister."Loan  No." = '' then
                        CurrReport.Skip;
                    inDev1 := LoansRegister."Loan  No.";
                end;
                //.................LoansRegister.RESET;
                LoansRegister.SetRange("Client Code", Customer."No.");
                LoansRegister.SetRange("Loan Product Type", '20');
                LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
                if LoansRegister.FindSet then begin
                    lndev := LoansRegister."Loan  No.";
                    if LoansRegister."Loan  No." = '' then
                        CurrReport.Skip;
                end;
                LoansRegister.SetRange("Client Code", Customer."No.");
                LoansRegister.SetRange("Loan Product Type", '26');
                LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
                if LoansRegister.FindSet then begin
                    MERCHANDISE_No := LoansRegister."Loan  No.";
                    if LoansRegister."Loan  No." = '' then
                        CurrReport.Skip;
                end;
                TOTALREMMITANCE := 0;
                TOTALREMMITANCE := montlycon + "Welfare Contr" + ShareCapital + NORMALLOAN1i + NORMALLOANp + NORMALLOANi + NORMALLOAN1p + EMERGENCYp + EMERGENCYi + SUPEREMERGENCYp + SUPEREMERGENCYi + QUICKLOANp + QUICKLOANi + SUPERQUICKp + SUPERQUICKi + SCHOOLFEESp + SCHOOLFEESi + SUPERSCHOOLFEESp + SUPERSCHOOLFEESi +
                INVESTMENTLOANi + DevP + Devint + DevelopmentLoanP + DevelopmentLoanInt + MERCHANDISEPr + MERCHANDISEIn;
            end;



            trigger OnPreDataItem()
            begin
                case BankSelection of
                    BankSelection::KCB:
                        SetFilter("Bank Code", '01*'); // Bank codes starting with 01
                    BankSelection::COOP:
                        SetFilter("Bank Code", '11*'); // Bank codes starting with 11
                    BankSelection::OTHERS:
                        SetFilter("Bank Code", '<>01*&<>11*'); // Exclude both KCB and COOP
                end;
            end;






        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    // field(StartDate; StartDate)
                    // {
                    //     ApplicationArea = All;
                    //     Caption = 'Start Date';
                    // }
                    // field(EndDate; EndDate)
                    // {
                    //     ApplicationArea = All;
                    //     Caption = 'End Date';
                    // }

                    field(Date; ASAT)
                    {
                        ApplicationArea = Basic;
                        Caption = 'As At Date';
                    }
                    // field(BankName; BankName)
                    // {
                    //     ApplicationArea = All;
                    //     Caption = 'Bank Name';
                    //     TableRelation = "Banks";
                    // }

                    // field(BankCode; BankCode)
                    // {
                    //     ApplicationArea = All;
                    //     Caption = 'Bank Code';
                    //     TableRelation = "Banks";
                    // }

                    field(BankSelection; BankSelection)
                    {
                        ApplicationArea = All;
                        Caption = 'Bank Selection';
                    }


                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }


    var

        BankCode: Code[20];

        BankSelection: Option KCB,COOP,OTHERS;

        CRAccountCode: Code[20];
        CRAccountNumber: Code[20];



        EndMonth_Date: Date;
        BeginMonth_Date: Date;
        ASAT: Date;
        LoansRegister: Record "Loans Register";
        ShareCapital: Decimal;
        DevP: Decimal;
        DevLNO: Code[20];
        Devint: Decimal;
        montlycon: Decimal;
        lndev: Code[30];
        EMERGENCYp: Decimal;
        EMERGENCYi: Decimal;
        EMERGENCYLNO: Code[20];
        EMERGENCYlnb: Code[30];
        SUPEREMERGENCYLNO: Code[20];
        SUPEREMERGENCYp: Decimal;
        SUPEREMERGENCYi: Decimal;
        QUICKLOANNO: Code[20];
        QUICKLOANp: Decimal;
        QUICKLOANi: Decimal;
        SUPERQUICKLNO: Code[20];
        SUPERQUICKp: Decimal;
        SUPERQUICKi: Decimal;
        SCHOOLFEESLNNO: Code[20];
        SCHOOLFEESp: Decimal;
        SCHOOLFEESi: Decimal;
        SUPERSCHOOLFEESLNO: Code[20];
        SUPERSCHOOLFEESp: Decimal;
        SUPERSCHOOLFEESi: Decimal;
        INVESTMENTLOANLNO: Code[20];
        INVESTMENTLOANp: Decimal;
        INVESTMENTLOANi: Decimal;
        TOTALREMMITANCE: Decimal;
        CI: Record "Company Information";
        NORMALLOANLNO: Code[20];
        NORMALLOANp: Decimal;
        NORMALLOANi: Decimal;
        NORMALLOAN1LNO: Code[20];
        NORMALLOAN1p: Decimal;
        NORMALLOAN1i: Decimal;
        DevP1LNO: Code[20];
        DevP1: Decimal;
        Devint1: Decimal;
        inDev1: Code[50];
        LoanRepaymentSchedule: Record "Loan Repayment Schedule";
        DevelopmentLoanP: Decimal;
        DevelopmentLoanInt: Decimal;
        developmentLoan_No: Code[20];
        TotalMRepay: Decimal;
        MERCHANDISEPr: Decimal;
        MERCHANDISEIn: Decimal;
        MERCHANDISE_No: Code[20];

        BankRec: Record Banks;

        BankName: Text[150];

    // trigger OnPreReport()
    //begin
    //  if BankCode <> '' then
    //    Customer.SetRange("Bank Code", BankCode);
    //end;

}
