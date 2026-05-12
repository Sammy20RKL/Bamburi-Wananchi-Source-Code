#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50250 "Account Closure Slip"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/AccountClosureSlip.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.";
            column(ReportForNavId_7301; 7301)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(USERID; UserId)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(Company_Name; Companyinfo.Name)
            {
            }
            column(Company_Picture; Companyinfo.Picture)
            {
            }
            column(COMPANYPIC; Companyinfo.Picture)
            {
            }
            column(Company_Address; Companyinfo.Address)
            {
            }
            column(Company_Phone; Companyinfo."Phone No.")
            {
            }
            column(Members__No__; "No.")
            {
            }
            column(Members_Name; Name)
            {
            }
            column(Members__ID_No__; "ID No.")
            {
            }
            column(Members__Payroll_Staff_No_; "Payroll/Staff No")
            {
            }
            column(Members__Outstanding_Balance_; "Outstanding Balance")
            {
            }
            column(TranferFee; TranferFee)
            {
            }
            column(CompanyinfoPicture; Companyinfo.Picture)
            {
            }
            column(Current_Shares___1; "Current Shares")
            {
            }
            column(Insurance_Fund___1; InsFund)
            {
            }
            column(Members__Accrued_Interest_; "Accrued Interest")
            {
            }
            column(OutstandingInterest_Members; Customer."Outstanding Interest")
            {
            }
            column(Members__Current_Shares_; "Current Shares")
            {
            }
            column(UnpaidDividends; UnpaidDividends)
            {
            }
            column(Members__Insurance_Fund_; "Insurance Fund")
            {
            }
            column(NetPayable; NetPayable)
            {
            }
            column(Members__Current_Investment_Total_; "Current Investment Total")
            {
            }
            column(Members__Dividend_Amount_; "Dividend Amount")
            {
            }
            column(FWithdrawal; FWithdrawal)
            {
            }
            column(Members_Members__Batch_No__; Customer."Batch No.")
            {
            }
            column(Members_Members_Status; Customer.Status)
            {
            }
            column(EFT; EFT)
            {
            }
            column(FOSAInterest; FOSAInterest)
            {
            }
            column(Members__FOSA_Outstanding_Balance_; "FOSA Outstanding Balance")
            {
            }
            column(Members_Members__Shares_Retained_; Customer."Shares Retained")
            {
            }
            column(FExpenses; FExpenses)
            {
            }
            column(InsFund__1; InsFund * -1)
            {
            }
            column(CICLoan; CICLoan)
            {
            }
            column(CICLoan___Current_Shares___1__UnpaidDividends___Insurance_Fund___1__FExpenses; CICLoan + ("Current Shares") + UnpaidDividends + FExpenses)
            {
            }
            column(Outstanding_Balance___Accrued_Interest___FOSA_Outstanding_Balance__FOSAInterest_FWithdrawal__InsFund__1_; "Outstanding Balance" + "Accrued Interest" + "FOSA Outstanding Balance" + FOSAInterest + FWithdrawal + (InsFund * -1))
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(ACCOUNT_CLOSURE_SLIPCaption; ACCOUNT_CLOSURE_SLIPCaptionLbl)
            {
            }
            column(P_O_BOX_75629___00200__NAIROBICaption; P_O_BOX_75629___00200__NAIROBICaptionLbl)
            {
            }
            column(Member_No_Caption; Member_No_CaptionLbl)
            {
            }
            column(Members_NameCaption; FieldCaption(Name))
            {
            }
            column(Members__ID_No__Caption; FieldCaption("ID No."))
            {
            }
            column(Members__Payroll_Staff_No_Caption; FieldCaption("Payroll/Staff No"))
            {
            }
            column(Current_Oustanding_LoanCaption; Current_Oustanding_LoanCaptionLbl)
            {
            }
            column(Deposit_ContributionCaption; Deposit_ContributionCaptionLbl)
            {
            }
            column(Other_DeductionsCaption; Other_DeductionsCaptionLbl)
            {
            }
            column(Insurance_Fund_Caption; Insurance_Fund_CaptionLbl)
            {
            }
            column(Members__Accrued_Interest_Caption; FieldCaption("Accrued Interest"))
            {
            }
            column(ADD__Unpaid_DividendsCaption; ADD__Unpaid_DividendsCaptionLbl)
            {
            }
            column(LESS_Caption; LESS_CaptionLbl)
            {
            }
            column(ADD_Caption; ADD_CaptionLbl)
            {
            }
            column(Net_RefundCaption; Net_RefundCaptionLbl)
            {
            }
            column(Withdrawal_FeesCaption; Withdrawal_FeesCaptionLbl)
            {
            }
            column(Batch_No_Caption; Batch_No_CaptionLbl)
            {
            }
            //    column(DataItem1000000004;Prepared_By___________________________________Lbl)
            //    {
            //    }
            //    column(DataItem1000000005;Certified_By____________________________Lbl)
            //    {
            //    }
            //    column(DataItem1000000007;Signature_Date______________________________________________Lbl)
            //    {
            //    }
            //    column(DataItem1000000008;Signature_Date_____________________________________________________________________________________________________000Lbl)
            //    {
            //    }
            column(Member_StatusCaption; Member_StatusCaptionLbl)
            {
            }
            column(FOSA_Accrued_InterestCaption; FOSA_Accrued_InterestCaptionLbl)
            {
            }
            column(FOSA_Current_Oustanding_LoanCaption; FOSA_Current_Oustanding_LoanCaptionLbl)
            {
            }
            column(Funeral_ExpensesCaption; Funeral_ExpensesCaptionLbl)
            {
            }
            column(Under_Excess_InsuranceCaption; Under_Excess_InsuranceCaptionLbl)
            {
            }
            column(Insurance__CIC_Caption; Insurance__CIC_CaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(TotalCaption_Control1102760055; TotalCaption_Control1102760055Lbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                WithdrawalFee := 0;
                NetPayable := 0;
                FWithdrawal := 0;
                FExpenses := 0;
                CICLoan := 0;
                InsFund := 0;
                UnpaidDividends := 0;

                if Cust.Get('RB-' + Cust."Payroll/Staff No") then begin
                    Cust.CalcFields(Cust."Balance (LCY)");
                    UnpaidDividends := Cust."Balance (LCY)"
                end;

                // GETTING WITHDRAWAL FEE

                //IF (0.1*("Current Shares")) >1000 THEN BEGIN
                "Withdrawal Fee" := 0;
                //END ELSE BEGIN
                //"Withdrawal Fee":=0.1*("Current Shares");
                //FWithdrawal:="Withdrawal Fee";
                //END;


                //MESSAGE('FWithdrawal is %1', FWithdrawal);

                CalcFields("Current Shares", "Outstanding Balance", "Outstanding Interest");

                InsFund := "Insurance Fund";

                FOSAInterest := Customer."FOSA Oustanding Interest";

                if FOSAInterest < 0 then
                    FOSAInterest := 0;

                if Status = Status::Deceased then begin
                    FExpenses := 0;
                    CICLoan := "Outstanding Balance" + "FOSA Outstanding Balance";
                    NetRefund := (FExpenses + ("Current Shares")) -
                                ("Outstanding Interest" + FOSAInterest);
                end else begin
                    NetRefund := (("Current Shares" + UnpaidDividends) -
                                (+"Outstanding Balance" + "Outstanding Interest"));
                    //MESSAGE(FORMAT("Outstanding Interest"));

                    InsFund := 0;

                    if "Withdrawal Application Date" <> 0D then begin
                        if CalcDate('3M', "Withdrawal Application Date") > Today then begin
                            if NetRefund > 0 then
                                WithdrawalFee := ROUND(NetRefund * 0.1, 1);
                        end;
                    end;

                end;

                TranferFee := 0;
                Generalsetup.Get();
                Closure.Reset;
                Closure.SetRange(Closure."Member No.", Customer."No.");
                if Closure.Find('-') then begin
                    // if Closure."Mode Of Disbursement"=Closure."mode of disbursement"::EFT then
                    //TranferFee:=Generalsetup."Loan Trasfer Fee-Cheque"
                    //  TranferFee:=Closure."EFT Charge"
                    EFT := Closure."EFT Charge";
                    FWithdrawal := Closure."Ledger Fee";

                    // else
                    // if Closure."Mode Of Disbursement"=Closure."mode of disbursement"::Vendor then
                    // TranferFee:=Generalsetup."Loan Trasfer Fee-EFT"
                    // else
                    // if Closure."Mode Of Disbursement"=Closure."mode of disbursement"::Cheque then
                    // TranferFee:=Generalsetup."Loan Trasfer Fee-EFT";
                    // EFT:=Closure."EFT Charge";
                end;

                if Status = Status::Deceased then begin
                    NetPayable := NetRefund
                end else
                    NetPayable := NetRefund - FWithdrawal - TranferFee - EFT;//-withdrawalfee
                Closure."Net Pay" := NetPayable + Closure."EFT Charge";
                Closure.MODIFY;
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FieldNo("No.");

                Companyinfo.Get();
                Companyinfo.CalcFields(Companyinfo.Picture);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        WithdrawalFee: Decimal;
        NetRefund: Decimal;
        FWithdrawal: Decimal;
        NetPayable: Decimal;
        FOSAInterest: Decimal;
        FExpenses: Decimal;
        CICLoan: Decimal;
        InsFund: Decimal;
        UnpaidDividends: Decimal;
        Cust: Record Customer;
        CurrReport_PAGENOCaptionLbl: label 'Page';
        ACCOUNT_CLOSURE_SLIPCaptionLbl: label 'ACCOUNT CLOSURE SLIP';
        P_O_BOX_75629___00200__NAIROBICaptionLbl: label 'P.O BOX 75629 - 00200, NAIROBI';
        Member_No_CaptionLbl: label 'Member No.';
        Current_Oustanding_LoanCaptionLbl: label 'Current Oustanding Loan';

        Deposit_ContributionCaptionLbl: label 'Deposit Contribution';
        Other_DeductionsCaptionLbl: label 'Other Deductions';
        Insurance_Fund_CaptionLbl: label 'Insurance Fund ';
        ADD__Unpaid_DividendsCaptionLbl: label 'ADD: Unpaid Dividends';
        LESS_CaptionLbl: label 'LESS:';
        ADD_CaptionLbl: label 'ADD:';
        Net_RefundCaptionLbl: label 'Net Refund';
        Withdrawal_FeesCaptionLbl: label 'Withdrawal Fees';
        Batch_No_CaptionLbl: label 'Batch No.';
        Prepared_By____________________________________________________________________________________________________Lbl: label 'Prepared By: ....................................................................................................................................................................';
        Certified_By___________________________________________________________________________________________________Lbl: label 'Certified By: ....................................................................................................................................................................';
        Signature_Date_____________________________________________________________________________________________________Lbl: label 'Signature/Date: ....................................................................................................................................................................';
        Signature_Date______________________________________________________________________________________________000Lbl: label 'Signature/Date: ....................................................................................................................................................................';
        Member_StatusCaptionLbl: label 'Member Status';
        FOSA_Accrued_InterestCaptionLbl: label 'FOSA Accrued Interest';
        FOSA_Current_Oustanding_LoanCaptionLbl: label 'FOSA Current Oustanding Loan';
        Funeral_ExpensesCaptionLbl: label 'Funeral Expenses';
        Under_Excess_InsuranceCaptionLbl: label 'Under/Excess Insurance';
        Insurance__CIC_CaptionLbl: label 'Insurance (CIC)';
        TotalCaptionLbl: label 'Total';
        TotalCaption_Control1102760055Lbl: label 'Total';
        LastFieldNo: Integer;
#pragma warning disable AL0275
        Companyinfo: Record "Company Information";
#pragma warning restore AL0275
        TranferFee: Decimal;
        Closure: Record "Membership Exist";
        Generalsetup: Record "Sacco General Set-Up";
        EFT: Decimal;
}

