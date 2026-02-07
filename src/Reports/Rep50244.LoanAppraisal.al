#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50244 "Loan Appraisal"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Loan_Appraisal.rdl';
    UsageCategory = ReportsandAnalysis;

    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            DataItemTableView = sorting("Loan  No.");
            RequestFilterFields = "Loan  No.";
            column(ReportForNavId_4645; 4645)
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
            column(COMPANYNAME; Company.name)
            {
            }
            column(CompanyPic; Company.Picture)
            {

            }
            column(Company_Address; Company.Address)
            {
            }
            column(Company__Phone_No__; Company."Phone No.")
            {
            }
            column(Company__E_Mail_; Company."E-Mail")
            {
            }
            column(Loans__Application_Date_; "Application Date")
            {
            }
            column(valuation_LoansRegister; "Loans Register"."Valuation Cost")
            {
            }
            column(PREMATURE; PREMATURE)
            {
            }
            column(legalfee_LoansRegister; "Loans Register"."Legal Cost")
            {
            }
            column(Basic_Pay; "Basic Pay")
            {
            }
            column(Deboost_Amount; "Deboost Amount")
            {

            }
            column(Deboost_Commision; "Deboost Commision")
            {
            }
            column(Psalary; Psalary)
            {
            }
            column(JazaDeposits; LoanInsurance)
            {
            }
            column(Total_Allowances; "Total Allowances")
            {
            }
            column(GrossPay_LoansRegister; "Loans Register"."Gross Pay")
            {
            }
            column(TotalDeductionsH_LoansRegister; "Loans Register"."Total DeductionsH")
            {
            }
            column(UtilizableAmount_LoansRegister; "Loans Register"."Utilizable Amount")
            {
            }
            column(NetUtilizableAmount_LoansRegister; "Loans Register"."Net Utilizable")
            {
            }
            column(NettakeHome_LoansRegister; "Loans Register"."Net take Home")
            {
            }

            column(Other_Statutory_Deductions; "Other Deductions")
            {
            }
            column(Net_Utilizable_Amount; "Net Utilizable")
            {
            }
            // column(DepositReinstatement;"Deposit Reinstatement")
            // {
            // }
            column(TotalLoanBal; TotalLoanBal)
            {
            }
            column(Upfronts; Upfronts)
            {
            }
            column(Remarks; Remarks) { }
            column(Netdisbursed; Netdisbursed)
            {
            }
            /*  column(AmountBoosted_LoansRegister; "Loans Register"."Boosting Shares")
             {
             } */
            column(TotalBridgeAmount; TotalBridgeAmount)
            {
            }
            column(CommissiononBoosting_LoansRegister; "Loans Register"."Boosting Commision")
            {
            }
            column(AmountRemainingAfterTopup; (LOANBALANCE - BRIGEDAMOUNT))
            {

            }
            column(LoanInsurance; LoanInsurance)
            {
            }
            column(LoanProcessingFee; LoanProcessingFee)
            {
            }
            column(Date___________________Caption; Date___________________CaptionLbl)
            {
            }
            column(StatDeductions; StatDeductions)
            {
            }
            column(TotLoans; TotLoans)
            {
            }
            column(PrincipleRepayment; "Loans Register"."Loan Principle Repayment")
            {
            }
            column(InterestRepayment; "Loans Register"."Loan Interest Repayment")
            {
            }
            column(Interest_LoansRegister; "Loans Register".Interest)
            {
            }
            column(Loans__Loan__No__; "Loan  No.")
            {
            }
            column(Loans__Loan_Product_Type_; "Loan Product Type")
            {
            }
            column(Loans_Loans__Client_Code_; "Loans Register"."Client Code")
            {
            }
            column(LoansApprovedAmount; "Loans Register"."Approved Amount")
            {
            }
            column(Cust_Name; Cust.Name)
            {
            }
            column(Client_Name; "Client Name") { }
            column(Loans__Requested_Amount_; "Requested Amount")
            {
            }
            column(Repayment_LoansRegister; "Loans Register".Repayment)
            {
            }
            column(Loans__Staff_No_; "Staff No")
            {
            }
            column(NetSalary; NetSalary)
            {
            }
            column(Approved_Amounts; "Approved Amount")
            {
            }
            column(Reccom_Amount; Recomm)
            {
            }
            column(LOANBALANCE; "Existing Loan")
            {
            }
            column(Loans_Installments; Installments)
            {
            }
            column(Loans__No__Of_Guarantors_; "No. Of Guarantors")
            {
            }
            column(Cshares_3; Cshares * 3)
            {
            }
            column(Cshares_3__LOANBALANCE_BRIDGEBAL_LOANBALANCEFOSASEC; (Cshares * 3) - LOANBALANCE + BRIDGEBAL - LOANBALANCEFOSASEC)
            {
            }
            column(Cshares; Cshares)
            {
            }
            column(LAppraisalFee; LAppraisalFee) { }
            column(LOANBALANCE_BRIDGEBAL; TotalLoanBal - BRIDGEBAL)
            {
            }
            column(Loans__Transport_Allowance_; "Transport Allowance")
            {
            }
            column(Loans__Employer_Code_; "Employer Code")
            {
            }
            column(Loans__Loan_Product_Type_Name_; "Loan Product Type Name")
            {
            }
            column(Loans__Loan__No___Control1102760138; "Loan  No.")
            {
            }
            column(Loans__Application_Date__Control1102760139; "Application Date")
            {
            }
            column(Loans__Loan_Product_Type__Control1102760140; "Loan Product Type")
            {
            }
            column(Loans_Loans__Client_Code__Control1102760141; "Loans Register"."Client Code")
            {
            }
            column(Cust_Name_Control1102760142; Cust.Name)
            {
            }
            column(Loans__Staff_No__Control1102760144; Cust."Payroll/Staff No")// "Staff No")
            {
            }
            column(Loans__Staff_No__; Cust."Payroll/Staff No")// "Staff No")
            {
            }
            column(Loans_Installments_Control1102760145; Installments)
            {
            }
            column(Loans__No__Of_Guarantors__Control1102760146; "No. Of Guarantors")
            {
            }
            column(Loans__Requested_Amount__Control1102760143; "Requested Amount")
            {
            }
            column(Loans_Repayment; Repayment)
            {
            }
            column(Loans__Employer_Code__Control1102755075; "Employer Code")
            {
            }
            column(MAXAvailable; MAXAvailable)
            {
            }
            column(Cshares_Control1102760156; Cshares)
            {
            }
            column(BRIDGEBAL; BRIDGEBAL)
            {
            }
            column(LOANBALANCE_BRIDGEBAL_Control1102755006; LOANBALANCE - BRIDGEBAL)
            {
            }
            column(DEpMultiplier; DEpMultiplier)
            {
            }
            column(DefaultInfo; DefaultInfo)
            {
            }
            column(RecomRemark; RecomRemark)
            {
            }
            column(Recomm; Recomm)
            {
            }
            column(BasicEarnings; BasicEarnings)
            {
            }
            column(GShares; GShares)
            {
            }
            column(GShares_TGuaranteedAmount; GShares - TGuaranteedAmount)
            {
            }
            column(Msalary; Msalary)
            {
            }
            column(MAXAvailable_Control1102755031; MAXAvailable)
            {
            }
            column(Recomm_TOTALBRIDGED; Recomm - TOTALBRIDGED)
            {
            }
            column(GuarantorQualification; GuarantorQualification)
            {
            }
            column(Requested_Amount__MAXAvailable; "Requested Amount" - MAXAvailable)
            {
            }
            column(Requested_Amount__Msalary; "Requested Amount" - Msalary)
            {
            }
            column(Requested_Amount__GShares; "Requested Amount" - GShares)
            {
            }
            column(Loan_Appraisal_AnalysisCaption; Loan_Appraisal_AnalysisCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Loan_Application_DetailsCaption; Loan_Application_DetailsCaptionLbl)
            {
            }
            column(Loans__Application_Date_Caption; FieldCaption("Application Date"))
            {
            }
            column(Loans__Loan__No__Caption; FieldCaption("Loan  No."))
            {
            }
            column(Loan_TypeCaption; Loan_TypeCaptionLbl)
            {
            }
            column(MemberCaption; MemberCaptionLbl)
            {
            }
            column(Amount_AppliedCaption; Amount_AppliedCaptionLbl)
            {
            }
            column(Loans__Staff_No_Caption; FieldCaption("Staff No"))
            {
            }
            column(Loans_InstallmentsCaption; FieldCaption(Installments))
            {
            }
            column(Deposits__3Caption; Deposits__3CaptionLbl)
            {
            }
            column(Eligibility_DetailsCaption; Eligibility_DetailsCaptionLbl)
            {
            }
            column(Maxim__Amount_Avail__for_the_LoanCaption; Maxim__Amount_Avail__for_the_LoanCaptionLbl)
            {
            }
            column(Outstanding_LoanCaption; Outstanding_LoanCaptionLbl)
            {
            }
            column(Member_DepositsCaption; Member_DepositsCaptionLbl)
            {
            }
            column(Loans__No__Of_Guarantors_Caption; FieldCaption("No. Of Guarantors"))
            {
            }
            column(Loans__Transport_Allowance_Caption; FieldCaption("Transport Allowance"))
            {
            }
            column(Loans__Employer_Code_Caption; FieldCaption("Employer Code"))
            {
            }
            column(Loans__No__Of_Guarantors__Control1102760146Caption; FieldCaption("No. Of Guarantors"))
            {
            }
            column(Loans_Installments_Control1102760145Caption; FieldCaption(Installments))
            {
            }
            column(Loans__Staff_No__Control1102760144Caption; Cust."Payroll/Staff No")// FieldCaption("Staff No"))
            {
            }
            column(Amount_AppliedCaption_Control1102760132; Amount_AppliedCaption_Control1102760132Lbl)
            {
            }
            column(MemberCaption_Control1102760133; MemberCaption_Control1102760133Lbl)
            {
            }
            column(Loan_TypeCaption_Control1102760134; Loan_TypeCaption_Control1102760134Lbl)
            {
            }
            column(Loans__Application_Date__Control1102760139Caption; FieldCaption("Application Date"))
            {
            }
            column(Loans__Loan__No___Control1102760138Caption; FieldCaption("Loan  No."))
            {
            }
            column(Loan_Application_DetailsCaption_Control1102760151; Loan_Application_DetailsCaption_Control1102760151Lbl)
            {
            }
            column(RepaymentCaption; RepaymentCaptionLbl)
            {
            }
            column(Loans__Employer_Code__Control1102755075Caption; FieldCaption("Employer Code"))
            {
            }
            column(Maxim__Amount_Avail__for_the_LoanCaption_Control1102760150; Maxim__Amount_Avail__for_the_LoanCaption_Control1102760150Lbl)
            {
            }
            column(Total_Outstand__Loan_BalanceCaption; Total_Outstand__Loan_BalanceCaptionLbl)
            {
            }
            column(Deposits___MulitiplierCaption; Deposits___MulitiplierCaptionLbl)
            {
            }
            column(Member_DepositsCaption_Control1102760148; Member_DepositsCaption_Control1102760148Lbl)
            {
            }
            column(Deposits_AnalysisCaption; Deposits_AnalysisCaptionLbl)
            {
            }
            column(Bridged_AmountCaption; Bridged_AmountCaptionLbl)
            {
            }
            column(Out__Balance_After_Top_upCaption; Out__Balance_After_Top_upCaptionLbl)
            {
            }
            column(Recommended_AmountCaption; Recommended_AmountCaptionLbl)
            {
            }
            column(Net_Loan_Disbursement_Caption; Net_Loan_Disbursement_CaptionLbl)
            {
            }
            column(V3__Qualification_as_per_GuarantorsCaption; V3__Qualification_as_per_GuarantorsCaptionLbl)
            {
            }
            column(Defaulter_Info_Caption; Defaulter_Info_CaptionLbl)
            {
            }
            column(V2__Qualification_as_per_SalaryCaption; V2__Qualification_as_per_SalaryCaptionLbl)
            {
            }
            column(V1__Qualification_as_per_SharesCaption; V1__Qualification_as_per_SharesCaptionLbl)
            {
            }
            column(QUALIFICATIONCaption; QUALIFICATIONCaptionLbl)
            {
            }
            column(Insufficient_Deposits_to_cover_the_loan_applied__RiskCaption; Insufficient_Deposits_to_cover_the_loan_applied__RiskCaptionLbl)
            {
            }
            column(WARNING_Caption; WARNING_CaptionLbl)
            {
            }
            column(Salary_is_Insufficient_to_cover_the_loan_applied__RiskCaption; Salary_is_Insufficient_to_cover_the_loan_applied__RiskCaptionLbl)
            {
            }
            column(WARNING_Caption_Control1000000140; WARNING_Caption_Control1000000140Lbl)
            {
            }
            column(WARNING_Caption_Control1000000141; WARNING_Caption_Control1000000141Lbl)
            {
            }
            column(Guarantors_do_not_sufficiently_cover_the_loan__RiskCaption; Guarantors_do_not_sufficiently_cover_the_loan__RiskCaptionLbl)
            {
            }
            column(WARNING_Caption_Control1000000020; WARNING_Caption_Control1000000020Lbl)
            {
            }
            column(Shares_Deposits_BoostedCaption; Shares_Deposits_BoostedCaptionLbl)
            {
            }
            column(DepX; DepX)
            {
            }
            column(TwoThird; TwoThirds)
            {
            }
            column(LPrincipal; LPrincipal)
            {
            }
            column(LInterest; LInterest)
            {
            }
            column(LNumber; LNumber)
            {
            }
            column(TotalLoanDeductions; TotalLoanDeductions)
            {
            }
            // column(MinDepositAsPerTier_Loans;"Min Deposit As Per Tier")
            // {
            // }
            column(TotalRepayments; TotalRepayments)
            {
            }
            column(Totalinterest; Totalinterest)
            {
            }
            column(Band; Band)
            {
            }
            column(NtTakeHome; NtTakeHome)
            {
            }
            column(ATHIRD; ATHIRD)
            {
            }
            column(BridgedRepayment; BridgedRepayment)
            {
            }
            column(BRIGEDAMOUNT; BRIGEDAMOUNT)
            {
            }
            column(LoanAppraisal; LoanAppraisal)
            {
            }
            column(CollCharge; CollCharge)
            {
            }
            column(CollateralGuarantee; CollateralGuarantee)
            {
            }
            column(ProcessingFee; ProcessingFee)
            {
            }
            column(DisbursementFee; DisbursementFee)
            {
            }
            column(InsuranceFee; InsuranceFee)
            {
            }
            column(TopUpFee; BridgeLevy)
            {
            }
            dataitem("Loan Appraisal Salary Details"; "Loan Appraisal Salary Details")
            {
                DataItemLink = "Client Code" = field("Client Code"), "Loan No" = field("Loan  No.");
                DataItemTableView = sorting("Loan No", "Client Code", Code);
                PrintOnlyIfDetail = false;
                column(ReportForNavId_3518; 3518)
                {
                }
                column(Appraisal_Salary_Details__Client_Code_; "Client Code")
                {
                }
                column(Appraisal_Salary_Details_Code; Code)
                {
                }
                column(Appraisal_Salary_Details_Description; Description)
                {
                }
                column(Appraisal_Salary_Details_Type; Type)
                {
                }
                column(Appraisal_Salary_Details_Amount; Amount)
                {
                }
                column(Earnings; Earnings)
                {
                }
                column(Deductions; Deductions)
                {
                }
                column(Earnings_Deductions___Earnings__1_3; (Earnings - Deductions) - (Earnings) * 1 / 3)
                {
                }
                column(Earnings__1_3; (Earnings) * 1 / 3)
                {
                }
                column(Net_Salary; NetSalary)
                {
                }
                column(Msalary_Control1102755030; Msalary)
                {
                }
                column(Appraisal_Salary_Details__Client_Code_Caption; FieldCaption("Client Code"))
                {
                }
                column(Appraisal_Salary_Details_CodeCaption; FieldCaption(Code))
                {
                }
                column(Appraisal_Salary_Details_DescriptionCaption; FieldCaption(Description))
                {
                }
                column(Appraisal_Salary_Details_TypeCaption; FieldCaption(Type))
                {
                }
                column(Appraisal_Salary_Details_AmountCaption; FieldCaption(Amount))
                {
                }
                column(Salary_Details_AnalysisCaption; Salary_Details_AnalysisCaptionLbl)
                {
                }
                column(Total_EarningsCaption; Total_EarningsCaptionLbl)
                {
                }
                column(Total_DeductionsCaption; Total_DeductionsCaptionLbl)
                {
                }
                column(Net_SalaryCaption; Net_SalaryCaptionLbl)
                {
                }
                column(Qualification_as_per_SalaryCaption; Qualification_as_per_SalaryCaptionLbl)
                {
                }
                column(V1_3_of_Gross_PayCaption; V1_3_of_Gross_PayCaptionLbl)
                {
                }
                column(GuarOutstanding; GuarOutstanding)
                {
                }
                column(OTHERDEDUCTIONS; OTHERDEDUCTIONS)
                {
                }

            }
            dataitem("Loans Guarantee Details"; "Loans Guarantee Details")
            {
                DataItemLink = "Loan No" = field("Loan  No.");
                DataItemTableView = sorting("Loan No", "Member No") where("Amont Guaranteed" = filter(<> 0));
                PrintOnlyIfDetail = false;
                column(ReportForNavId_5140; 5140)
                {
                }
                column(Amont_Guarant; "Loan No")
                {
                }
                column(Name; Name)
                {
                }
                column(AmontGuaranteed_LoansGuaranteeDetails; "Loans Guarantee Details"."Amont Guaranteed")
                {
                }
                column(Guarantor_Memb_No; "Loans Guarantee Details"."Member No")
                {
                }
                column(G_Shares; "Loans Guarantee Details".Shares)
                {
                }
                column(AvailableG; AvailableG)
                {
                }
                column(MaxDepositQualification; MaxDepositQualification)
                {

                }
                column(AmountofFreeShares; AmountofFreeShares)
                {
                }
                column(Loan_Guarant; "Loan No")
                {
                }
                column(Guarantor_Outstanding; "Guarantor Outstanding")
                {
                }
                column(Employer_code; "Employer Code")
                {
                }
                column(Staff_Payroll_No_; "Staff/Payroll No.") { }
                column(NoOfLoansGuaranteed_LoansGuaranteeDetails; "Loans Guarantee Details"."No Of Loans Guaranteed")
                {
                }
                column(Substituted_LoansGuaranteeDetails; "Loans Guarantee Details".Substituted)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    AmountofFreeShares := 0;
                    if CustRecord.Get("Loans Guarantee Details"."Member No") then begin
                        //CustRecord.CALCFIELDS(CustRecord."Current Savings",CustRecord."Principal Balance");
                        CustRecord.CalcFields(CustRecord."Current Shares");
                        TShares := TShares + CustRecord."Current Savings";
                        TLoans := TLoans + CustRecord."Principal Balance";
                        AvailableG := CustRecord."Current Shares" * 4;
                    end;
                    LoanG.Reset;
                    LoanG.SetRange(LoanG."Member No", "Member No");
                    if LoanG.Find('-') then begin
                        repeat
                            LoanG.CalcFields(LoanG."Outstanding Balance", LoanG."Guarantor Outstanding");
                            if LoanG."Outstanding Balance" > 0 then begin
                                GuaranteedAmount := GuaranteedAmount + LoanG."Amont Guaranteed";
                                GuarOutstanding := LoanG."Guarantor Outstanding";
                            end;
                        until LoanG.Next = 0;
                    end;
                    TGuaranteedAmount := TGuaranteedAmount + GuaranteedAmount;
                    AmountofFreeShares := AvailableG - LoanG."Amont Guaranteed";
                    if "Member No" = '' then CurrReport.Skip();
                end;
            }
            dataitem("Loan Offset Details"; "Loan Offset Details")
            {
                DataItemLink = "Loan No." = field("Loan  No.");
                PrintOnlyIfDetail = false;
                column(ReportForNavId_4717; 4717)
                {
                }
                column(Loan_No_; "Loan No.") { }
                column(Loans_Top_up__Principle_Top_Up_; "Principle Top Up")
                {
                }
                column(Loans_Top_up__Loan_Type_; "Loan Type")
                {
                }
                column(Loans_Top_up__Client_Code_; "Client Code")
                {
                }
                column(Loans_Top_up__Loan_No__; "Loan Top Up")
                {
                }
                column(Loans_Top_up__Total_Top_Up_; "Total Top Up")
                {
                }
                column(Loans_Top_up__Interest_Top_Up_; "Interest Top Up")
                {
                }
                column(Loan_Type; "Loan Offset Details"."Loan Type")
                {
                }
                column(Loans_Top_up_Commision; Commision)
                {
                }
                column(Loans_Top_up__Principle_Top_Up__Control1102760116; "Principle Top Up")
                {
                }
                column(BrTopUpCom; BrTopUpCom)
                {
                }
                column(TOTALBRIDGED; TOTALBRIDGED)
                {
                }
                column(Loans_Top_up__Total_Top_Up__Control1102755050; "Total Top Up")
                {
                }
                column(Loans_Top_up_Commision_Control1102755053; Commision)
                {
                }
                column(Loans_Top_up__Interest_Top_Up__Control1102755055; "Interest Top Up")
                {
                }
                column(Total_TopupsCaption; Total_TopupsCaptionLbl)
                {
                }
                column(Bridged_LoansCaption; Bridged_LoansCaptionLbl)
                {
                }
                column(Loan_No_Caption; Loan_No_CaptionLbl)
                {
                }
                column(Loans_Top_up_CommisionCaption; FieldCaption(Commision))
                {
                }
                column(Principal_Top_UpCaption; Principal_Top_UpCaptionLbl)
                {
                }
                column(Loans_Top_up__Interest_Top_Up_Caption; FieldCaption("Interest Top Up"))
                {
                }
                column(Client_CodeCaption; Client_CodeCaptionLbl)
                {
                }
                column(Loan_TypeCaption_Control1102755059; Loan_TypeCaption_Control1102755059Lbl)
                {
                }
                column(TotalsCaption; TotalsCaptionLbl)
                {
                }
                column(Total_Amount_BridgedCaption; Total_Amount_BridgedCaptionLbl)
                {
                }
                column(Bridging_total_higher_than_the_qualifing_amountCaption; Bridging_total_higher_than_the_qualifing_amountCaptionLbl)
                {
                }
                column(WARNING_Caption_Control1102755044; WARNING_Caption_Control1102755044Lbl)
                {
                }
                column(Loans_Top_up_Loan_Top_Up; "Loan Top Up")
                {
                }
                column(WarnBridged; WarnBridged)
                {
                }
                column(WarnSalary; WarnSalary)
                {
                }
                column(WarnDeposits; WarnDeposits)
                {
                }
                column(WarnGuarantor; WarnGuarantor)
                {
                }
                column(WarnShare; WarnShare)
                {
                }
                column(LoanDefaultInfo; DefaultInfo)
                {
                }
                column(Riskamount; Riskamount)
                {
                }
                column(RiskDeposits; RiskDeposits)
                {
                }
                column(RiskGshares; RiskGshares)
                {
                }
                column(TotalTopUp; TotalTopUp)
                {
                }

                trigger OnAfterGetRecord()
                begin

                    TotalTopUp := ROUND((TotalTopUp + "Principle Top Up"), 0.05, '>');
                    TotalIntPayable := TotalIntPayable + "Monthly Repayment";
                    GTotals := GTotals + ("Principle Top Up" + "Monthly Repayment");
                    if "Loans Register".Get("Loan Offset Details"."Loan No.") then begin
                        if LoanType.Get("Loans Register"."Loan Product Type") then begin
                        end;
                    end;

                    TOTALBRIDGED := TOTALBRIDGED + "Loan Offset Details"."Total Top Up";

                    if TOTALBRIDGED > Recomm then
                        WarnBridged := UpperCase('WARNING: Bridging Total is Higher than the Qualifing Amount.')
                    else
                        WarnBridged := '';
                end;

                trigger OnPreDataItem()
                begin
                    BrTopUpCom := 0;
                    TOTALBRIDGED := 0;
                end;
            }
            dataitem("Loan Collateral Details"; "Loan Collateral Details")
            {
                DataItemLink = "Loan No" = field("Loan  No.");
                column(ReportForNavId_14; 14)
                {
                }
                column(Code_LoanCollateralDetails; "Loan Collateral Details".Code)
                {
                }
                column(Type_LoanCollateralDetails; "Loan Collateral Details".Type)
                {
                }
                column(SecurityDetails_LoanCollateralDetails; "Loan Collateral Details"."Security Details")
                {
                }
                column(Value_LoanCollateralDetails; "Loan Collateral Details".Value)
                {
                }
                column(GuaranteeValue_LoanCollateralDetails; "Loan Collateral Details"."Guarantee Value")
                {
                }
                column(Booster; Booster)
                {
                }
                column(Name_LoanCollateralDetails; "Loan Collateral Details".Name)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin

                Cshares := 0;
                MAXAvailable := 0;
                LOANBALANCE := 0;
                TotalTopUp := 0;
                Ptopup := 0;
                TotalIntPayable := 0;
                GTotals := 0;
                AmountGuaranteed := 0;
                TotLoans := 0;
                CollCharge := 0;
                // LoanProcessingFee := 0;
                // LoanInsurance := 0;
                // DisbursementFee := 0;
                TotalSec := 0;
                TShares := 0;
                TLoans := 0;
                Earnings := 0;
                Deductions := 0;
                NetSalary := 0;
                LoanPrincipal := 0;
                loanInterest := 0;
                Psalary := 0;
                TotalLoanBal := 0;
                TotalBand := 0;
                CollateralGuarantee := 0;
                TotalRepay := 0;


                LoanType.Get("Loans Register"."Loan Product Type");

                //  Deposits analysis
                if Cust.Get("Loans Register"."Client Code") then begin
                    Cust.CalcFields(Cust."Current Shares");
                    Cshares := Cust."Current Shares" * 1;

                    DEpMultiplier := (Cshares * LoanType."Deposits Multiplier") + DeboosterAmount;

                    TotalRepayments := 0;

                    BridgedRepayment := 0;
                    TotalRepayments := 0;
                    //Outtasnding Balances
                    LoanApp.Reset;
                    LoanApp.SetRange(LoanApp."Client Code", "Client Code");
                    LoanApp.SetRange(LoanApp.Source, LoanApp.Source::" ");
                    LoanApp.SetFilter("Loan Product Type", '<>24&<>21'); // exclude 24 and 21
                    LoanApp.SetRange(LoanApp.Posted, true);
                    if LoanApp.Find('-') then begin
                        repeat
                            LoanApp.CalcFields("Outstanding Balance");
                            if LoanApp."Outstanding Balance" > 0 then begin
                                LOANBALANCE := LOANBALANCE + LoanApp."Outstanding Balance";
                                TotalRepayments := TotalRepayments + LoanApp.Repayment;
                            end;
                        until LoanApp.Next() = 0;
                    end;
                    //end;

                    TopUpFee := 0;
                    LoanTopUp.Reset;
                    LoanTopUp.SetRange(LoanTopUp."Loan No.", "Loans Register"."Loan  No.");
                    LoanTopUp.SetRange(LoanTopUp."Client Code", "Loans Register"."Client Code");
                    if LoanTopUp.Find('-') then begin
                        repeat
                            BRIGEDAMOUNT := ROUND(BRIGEDAMOUNT + LoanTopUp."Principle Top Up" + LoanTopUp."Interest Top Up", 0.01, '>');
                            TotalBridgeAmount := ROUND(TotalBridgeAmount + LoanTopUp."Total Top Up", 0.01, '>');

                            TopUpFee := ROUND(GenSetUp."Loan Top Up Commision(%)" * (BRIGEDAMOUNT) / 100, 1, '>');
                            if TotalBridgeAmount < LoanTopUp."LoanArrears" then begin
                                //TopUpFee += Round(10, 0.01, '>');
                                LoanTopUp."Partial Bridged" := true;
                            end
                        until LoanTopUp.Next = 0;
                    end;

                    LoanTopUp.Reset;
                    LoanTopUp.SetRange(LoanTopUp."Loan No.", "Loans Register"."Loan  No.");
                    LoanTopUp.SetRange(LoanTopUp."Client Code", "Loans Register"."Client Code");
                    if LoanTopUp.Find('-') then begin

                        repeat

                            if LoanTopUp."Partial Bridged" = false then begin

                                BridgedRepayment := ROUND(BridgedRepayment + LoanTopUp."Monthly Repayment", 0.01, '>');
                                FinalInst := FinalInst + LoanTopUp."Finale Instalment";
                            end;
                        until LoanTopUp.Next = 0;
                    end;

                    TotalLoanBal := (LOANBALANCE + "Loans Register"."Approved Amount") - BRIGEDAMOUNT;

                    LBalance := LOANBALANCE - BRIGEDAMOUNT;


                    //**Guarantors Loan Balances
                    "Loans Guarantee Details".Reset;
                    "Loans Guarantee Details".SetRange("Loans Guarantee Details"."Member No", "Client Code");
                    if "Loans Guarantee Details".Find('-') then begin
                        CalcFields("Outstanding Balance");
                        GuarOutstanding := "Outstanding Balance";
                    end;


                    //.............................................................................................................................
                    salary := "Loans Register"."Net Utilizable";
                    if salary < 0 then salary := 0;

                    Psalary := (salary * 100 * Installments) / (100 + Installments);

                    if (salary > Repayment) or (salary = Repayment) then
                        Msalary := ROUND(Psalary, 100, '<')
                    else
                        Msalary := ROUND(Psalary, 100, '<');
                    // End Qualification As Per Salary

                    //collateral
                    Collateral.RESET;
                    Collateral.SETRANGE(Collateral."Loan No", "Loan  No.");
                    IF Collateral.FIND('-') THEN BEGIN
                        REPEAT
                            CollCharge += Collateral."Guarantee Value";
                        UNTIL Collateral.NEXT = 0;
                        // "Net Loan Disbursed" := CollCharge;
                        MODIFY;
                    END;


                    //Total amount guaranteed
                    //AmountofFreeShares := 0;
                    AvailableG := 0;
                    LoanG.Reset;
                    LoanG.SetRange(LoanG."Loan No", "Loan  No.");
                    if LoanG.Find('-') then begin
                        repeat

                            GShares1 := LoanG.Shares;
                            GShares := GShares + LoanG."Amont Guaranteed";
                        until LoanG.Next = 0;
                    end;
                    // AvailableG := GShares1 * 4;
                    // AmountofFreeShares := AvailableG - LoanG."Amont Guaranteed";

                    CollateralGuarantee := CollCharge + GShares;
                    DepX := (DEpMultiplier) - (LBalance - FinalInst);
                    StatDeductions := StatDeductions + "Loans Register".Repayment;
                    if (Psalary >= Repayment) and (Psalary > "Requested Amount") then
                        Msalary := "Requested Amount"
                    else
                        Msalary := Psalary;
                end;
                if "Deboost Loan Applied" = false then begin
                    if (Depx < "Loans Register"."Requested Amount") and ("Loans Register"."Requested Amount" <= CollateralGuarantee) then
                        Recomm := CollateralGuarantee else
                        If (Depx >= "Loans Register"."Requested Amount") and ("Loans Register"."Requested Amount" <= CollateralGuarantee) then
                            Recomm := ROUND(Msalary, 100, '<');
                    if (Recomm > "Loans Register"."Requested Amount") then
                        Recomm := ROUND("Loans Register"."Requested Amount", 100, '<');
                    if Recomm < 0 then begin
                        Recomm := ROUND(Recomm, 100, '<');
                    end;
                end else
                    DepX := "Requested Amount";
                Recomm := "Requested Amount";


                //Recomm:=ROUND(DepX,100,'<');

                Riskamount := "Loans Register"."Requested Amount" - MAXAvailable;

                // Adjust DepX if it's larger than the Requested Amount
                if DepX > "Loans Register"."Requested Amount" then
                    DepX := "Loans Register"."Requested Amount";

                // Start with DepX as the default recommendation
                Recomm := ROUND(DepX, 100, '<');

                // Compare with Psalary and update Recomm if Psalary is smaller
                //----But first, check if they did use the Salary to Appraise
                if Psalary <> 0 then begin
                    if Psalary < Recomm then
                        Recomm := ROUND(Psalary, 100, '<');
                end;

                //----- Compare with GShares and update Recomm if GShares is smaller
                //-----But first, add GShares together with Collateral value..   FESTUS
                GShares := GShares + CollCharge;
                if GShares < Recomm then
                    Recomm := ROUND(GShares, 100, '<');

                //----Update the recommended Amount for the shamba and merchandise loans.... Festus Clean
                if ("Loans Register"."Loan Product Type" = '23') or ("Loans Register"."Loan Product Type" = '21') then begin
                    Recomm := "Loans Register"."Requested Amount";
                end;

                //----- Update the Loans Register with the calculated recommendation... Festus Clean
                "Loans Register"."Recommended Amount" := Recomm;
                "Loans Register"."Approved Amount" := Recomm;
                "Loans Register".Modify;

                // Display the recommendation
                if Recomm > 0 then begin
                    LoanGuar.RESET;
                    LoanGuar.SETRANGE(LoanGuar."Loan No", "Loans Register"."Loan  No.");
                    IF LoanGuar.FIND('-') THEN BEGIN
                        REPEAT
                            Cust.RESET;
                            Cust.SETRANGE(Cust."No.", LoanGuar."Member No");
                            IF Cust.FIND('-') THEN BEGIN
                                SMSMessages.RESET;
                                IF SMSMessages.FIND('+') THEN BEGIN
                                    iEntryNo := SMSMessages."Entry No";
                                    iEntryNo := iEntryNo + 1;
                                END
                                ELSE BEGIN
                                    iEntryNo := 1;
                                END;
                                SMSMessages.INIT;
                                SMSMessages."Entry No" := iEntryNo;
                                SMSMessages."Account No" := LoanGuar."Member No";
                                SMSMessages."Date Entered" := TODAY;
                                SMSMessages."Time Entered" := TIME;
                                SMSMessages.Source := 'LOAN GUARANTORSHIP';
                                SMSMessages."Entered By" := USERID;
                                SMSMessages."Sent To Server" := SMSMessages."Sent To Server"::No;
                                IF LoanApp.GET(LoanGuar."Loan No") THEN SMSMessages."SMS Message" := 'You are about to guarantee an amount of ' + FORMAT(LoanGuar."Amont Guaranteed") + ' to ' + "Loans Register"."Client Name" + '  ' + 'Loan Type ' + "Loans Register"."Loan Product Type Name" + ' at Polytech Sacco Ltd. Call 0719421588 for any consultations.';
                                ;
                                SMSMessages."Telephone No" := Cust."Phone No.";
                                // SMSMessages.INSERT;
                            END;
                        UNTIL LoanGuar.NEXT = 0;
                    END;
                end;


                //*************************Charges*********************************//
                ProccessingFee := 0;
                DisbursementFee := 0;
                InsuranceFee := 0;
                LegalFee := 0;
                LoanInsurance := 0;
                ValuationFee := 0;
                PREMATURE := 0;
                //**********added************
                LegalFee := "Loans Register"."Legal Cost";
                ValuationFee := "Loans Register"."Valuation Cost";
                TotalFee := LegalFee + ValuationFee;
                //****************end********************

                IF BRIGEDAMOUNT > 0 THEN BEGIN
                    IF ObjProductType.GET("Loans Register"."Loan Product Type") THEN BEGIN

                        TopUpFee := ROUND(GenSetUp."Loan Top Up Commision(%)" * (BRIGEDAMOUNT) / 100, 1, '>');
                    END;
                END;

                IF BRIGEDAMOUNT = LoanTopUp.LoanArrears THEN BEGIN
                    IF ObjProductType.GET("Loans Register"."Loan Product Type") THEN BEGIN

                        TopUpFee := ROUND(GenSetUp."Loan Top Up Commision(%)" * (BRIGEDAMOUNT) / 100, 1, '>');
                    END;
                END ELSE IF BRIGEDAMOUNT < LoanTopUp.LoanArrears THEN BEGIN

                    TopUpFee := ROUND(GenSetUp."Loan Top Up Commision(%)" * (BRIGEDAMOUNT) / 100, 1, '>');
                End;

                LoanTopUp.RESET;
                LoanTopUp.SETRANGE(LoanTopUp."Loan No.", "Loan  No.");
                IF LoanTopUp.FIND('-') THEN BEGIN
                    repeat
                        TopUpFee += LoanTopUp.Commision;
                    UNTIL LoanTopUp.NEXT = 0;
                END;


                Booster := 0;
                if LoanAp.Get("Loans Register"."Loan  No.") then begin

                    MaxDepositQualification := DEpMultiplier - (LOANBALANCE - BRIGEDAMOUNT);
                end;
                //End Update Amount for Deboosting**********************

                //Identify Defaulters
                LoanApp.Reset;
                LoanApp.SetRange(LoanApp."Client Code", "Client Code");
                LoanApp.SetRange(LoanApp.Posted, true);
                if LoanApp.Find('-') then begin
                    repeat
                        // LoanApp.CalcFields(LoanApp."Outstanding Balance",LoanApp."Total Repayments",LoanApp."Total Interest",LoanApp."Topup Commission");

                        if LoanApp."Outstanding Balance" > 0 then begin
                            if (LoanApp."Loans Category-SASRA" = LoanApp."Loans Category-SASRA"::Substandard) or
                            (LoanApp."Loans Category-SASRA" = LoanApp."Loans Category-SASRA"::Doubtful) or (LoanApp."Loans Category-SASRA" = LoanApp."Loans Category-SASRA"::Loss)
                            then begin
                                DefaultInfo := 'The member is a defaulter' + '. ' + 'Loan No' + ' ' + LoanApp."Loan  No." + ' ' + 'is in loan category' + ' ' +
                                Format(LoanApp."Loans Category-SASRA");
                            end;
                        end;
                    until LoanApp.Next = 0;
                end;
                //End Identify Defaulters


                //Compute monthly Repayments based on repay method

                TotalMRepay := 0;
                LPrincipal := 0;
                LInterest := 0;
                LoanAmount := 0;
                InterestRate := Interest;
                LoanAmount := "Approved Amount";
                RepayPeriod := Installments;
                LBalance := "Approved Amount";

                if "Repayment Method" = "repayment method"::Amortised then begin
                    TestField(Interest);
                    TestField(Installments);

                    TotalMRepay := ROUND((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -RepayPeriod)) * LoanAmount, 1, '>');
                    LInterest := ROUND(LBalance / 100 / 12 * InterestRate, 0.05, '>');

                    LPrincipal := TotalMRepay - LInterest;
                    Repayment := TotalMRepay;
                    "Loan Principle Repayment" := LPrincipal;
                    "Loan Interest Repayment" := LInterest;

                end;
                if "Repayment Method" = "repayment method"::"Straight Line" then begin
                    TestField(Installments);
                    LPrincipal := ROUND(LoanAmount / RepayPeriod, 1, '>');
                    LInterest := ROUND((InterestRate / 100) * LoanAmount, 1, '>');
                    Repayment := LPrincipal + LInterest;
                    "Loan Principle Repayment" := LPrincipal;
                    "Loan Interest Repayment" := LInterest;
                end;
                //END;

                //IF "Loan Product Type"<>'BBL' THEN BEGIN
                if "Repayment Method" = "repayment method"::"Reducing Balance" then begin
                    TestField(Installments);
                    LPrincipal := ROUND(LoanAmount / RepayPeriod, 1, '>');

                    LInterest := ROUND((InterestRate / 100) / 12 * LoanAmount, 1, '>');
                    Repayment := LPrincipal + LInterest;
                    "Loan Principle Repayment" := LPrincipal;
                    "Loan Interest Repayment" := LInterest;

                end;
                //END;
                //end of uncommenting


                "Loans Guarantee Details".Reset;
                "Loans Guarantee Details".SetRange("Loans Guarantee Details"."Loan No", "Loans Register"."Loan  No.");
                if "Loans Guarantee Details".Find('-') then begin
                    "Loans Guarantee Details".CalcSums("Loans Guarantee Details"."Amont Guaranteed");
                    TGAmount := "Loans Guarantee Details"."Amont Guaranteed";
                end;

                LoanApp.Reset;
                LoanApp.SetRange(LoanApp."Loan  No.", "Loan  No.");
                if LoanApp.Find('-') then begin
                    LoanApp.CalcFields(LoanApp."Topup Commission");
                end;


                GenSetUp.Get();
                if LoanType.Get("Loan Product Type") then begin
                    //JazaLevy:=ROUND("Jaza Deposits"*0.15,1,'>');
                    BridgeLevy := ROUND(LoanApp."Topup Commission", 1, '>');

                    if LoanApp."Top Up Amount" > 0 then begin
                        if BridgeLevy < 500 then begin
                            BridgeLevy := 5 / 100 * LOANBALANCE;
                        end else begin
                            BridgeLevy := ROUND(5 / 100 * LOANBALANCE, 1, '>');
                        end;
                    end;

                    if Netdisbursed < 0 then
                        Message('Net Disbursed cannot be 0 or Negative');

                    if MAXAvailable < 0 then
                        WarnDeposits := UpperCase('WARNING: Insufficient Deposits to cover the loan applied: Risk %1')
                    else
                        WarnDeposits := '';
                    if MAXAvailable < 0 then
                        RiskDeposits := "Loans Register"."Requested Amount" - MAXAvailable;


                    if Msalary < "Loans Register"."Requested Amount" then
                        Riskamount := "Loans Register"."Requested Amount" - Msalary;



                    if GShares < "Loans Register"."Requested Amount" then
                        WarnGuarantor := UpperCase('WARNING: Guarantors do not sufficiently cover the loan: Risk')
                    else
                        WarnGuarantor := '';
                    if GShares < "Loans Register"."Requested Amount" then
                        RiskGshares := "Loans Register"."Requested Amount" - GShares;
                    //MESSAGE('WARNING: Insufficient Deposits to cover the loan applied: Risk %1',Riskamount)
                    //END;



                    //LoanProcessingFee := 0;
                    Modify;



                    //LOAN Charges

                    LoanProcessingFee := ROUND(SFactory.FnGetChargeFee("Loans Register"."Loan Product Type", "Loans Register"."Approved Amount", 'LPF'), 1, '=');
                    LAppraisalFee := ROUND(SFactory.FnGetChargeFee("Loans Register"."Loan Product Type", "Loans Register"."Approved Amount", 'LAP'), 1, '=');
                    // LoanInsurance := ROUND(SFactory.FnGetChargeFee("Loans Register"."Loan Product Type", "Loans Register"."Approved Amount", 'LAP'), 1, '=');

                    Upfronts := LoanProcessingFee + LAppraisalFee + LegalFee + DisbursementFee + "Deboost Commision" + "Deboost Amount" + ValuationFee + TopUpFee + TopUpComm + BRIGEDAMOUNT;
                    Netdisbursed := ROUND(("Approved Amount" - Upfronts), 1, '=');
                    if Netdisbursed < 0 then
                        Netdisbursed := 0;
                    DisbursementFee := SFactory.FnGetChargeFee("Loans Register"."Loan Product Type", Netdisbursed, 'DISBURSEMENT');
                    //Message('Upfronts of %1, NetDisbursed of %2, DisbursementFee of %3', Upfronts, Netdisbursed, DisbursementFee);
                    //Message('Process %1, Insurance %2', LoanProcessingFee, LoanInsurance);
                    LoanDeductionCharges := Upfronts;
                    Modify;

                    if "Approved Amount" > 0 then begin
                        Upfronts := LoanProcessingFee
                                     + LAppraisalFee
                                     + "Deboost Commision"
                                     + "Deboost Amount"
                                     + LegalFee
                                     + DisbursementFee
                                     + ValuationFee
                                     + TopUpFee
                                     + TopUpComm
                                     + BRIGEDAMOUNT;
                        Netdisbursed := ROUND(("Approved Amount" - Upfronts), 1, '=');
                        "Loan Processing Fee" := LoanProcessingFee;
                        "Loan Dirbusement Fee" := DisbursementFee;
                        "Loan Insurance" := LoanInsurance;
                        "Loan Appraisal Fee" := LAppraisalFee;
                        // "Net Amount" := Netdisbursed;
                        Appraised := true;
                        Modify;
                    end


                end;
            end;

            trigger OnPreDataItem()
            begin

                CompanyInfo.Get();
                CompanyInfo.CalcFields(CompanyInfo.Picture);
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

    trigger OnPreReport()
    begin
        Company.Get();
        Company.CalcFields(Company.Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        CollateralGuarantee: Decimal;
        LegalFee: Decimal;
        TotalFee: Decimal;
        ValuationFee: Decimal;
        AvailableG: Decimal;
        AmountofFreeShares: Decimal;
        CustRec: Record Customer;
        Ptopup: Decimal;
        GenSetUp: Record "Sacco General Set-Up";
        Cust: Record Customer;
        PREMATURE: Decimal;
        CustRecord: Record Customer;
        TShares: Decimal;
        TLoans: Decimal;
        LoanApp: Record "Loans Register";
        LoanShareRatio: Decimal;
        Eligibility: Decimal;
        TotalSec: Decimal;
        saccded: Decimal;
        saccded2: Decimal;
        grosspay: Decimal;
        Tdeduct: Decimal;
        Cshares: Decimal;
        "Cshares*3": Decimal;
        "Cshares*4": Decimal;
        QUALIFY_SHARES: Decimal;
        salary: Decimal;
        LoanG: Record "Loans Guarantee Details";
        GShares: Decimal;
        Recomm: Decimal;
        GShares1: Decimal;
        NETTAKEHOME: Decimal;
        Msalary: Decimal;
        RecPeriod: Integer;
        FOSARecomm: Decimal;
        FOSARecoPRD: Integer;
        "Asset Value": Decimal;
        InterestRate: Decimal;
        RepayPeriod: Decimal;
        LBalance: Decimal;
        TotalMRepay: Decimal;
        LInterest: Decimal;
        LPrincipal: Decimal;
        SecuredSal: Decimal;
        Linterest1: Integer;
        LOANBALANCE: Decimal;
        BRIDGEDLOANS: Record "Loan Offset Details";
        BRIDGEBAL: Decimal;
        LOANBALANCEFOSASEC: Decimal;
        TotalTopUp: Decimal;
        TotalIntPayable: Decimal;
        GTotals: Decimal;
        TempVal: Decimal;
        TempVal2: Decimal;
        "TempCshares*4": Decimal;
        "TempCshares*3": Decimal;
        InstallP: Decimal;
        RecomRemark: Text[150];
        InstallRecom: Decimal;
        TopUpComm: Decimal;
        TotalTopupComm: Decimal;
        LoanTopUp: Record "Loan Offset Details";
        "Interest Payable": Decimal;
        LoanType: Record "Loan Products Setup";
        "general set-up": Record "Sacco General Set-Up";
        Days: Integer;
        EndMonthInt: Decimal;
        BRIDGEBAL2: Decimal;
        DefaultInfo: Text[80];
        TOTALBRIDGED: Decimal;
        DEpMultiplier: Decimal;
        Mutlply: Decimal;
        MAXAvailable: Decimal;
        SalDetails: Record "Loan Appraisal Salary Details";
        Earnings: Decimal;
        Deductions: Decimal;
        BrTopUpCom: Decimal;
        LoanAmount: Decimal;
#pragma warning disable AL0275
        Company: Record "Company Information";
#pragma warning restore AL0275
        CompanyAddress: Code[20];
        CompanyEmail: Text[30];
        CompanyTel: Code[20];
        CurrentAsset: Decimal;
        CurrentLiability: Decimal;
        FixedAsset: Decimal;
        Equity: Decimal;
        Sales: Decimal;
        SalesOnCredit: Decimal;
        AppraiseDeposits: Boolean;
        AppraiseShares: Boolean;
        AppraiseSalary: Boolean;
        AppraiseGuarantors: Boolean;
        AppraiseBusiness: Boolean;
        TLoan: Decimal;
        LoanBal: Decimal;
        GuaranteedAmount: Decimal;
        RunBal: Decimal;
        TGuaranteedAmount: Decimal;
        GuarantorQualification: Boolean;
        Loan_Appraisal_AnalysisCaptionLbl: label 'Loan Appraisal Analysis';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Loan_Application_DetailsCaptionLbl: label 'Loan Application Details';
        Loan_TypeCaptionLbl: label 'Loan Type';
        MemberCaptionLbl: label 'Member';
        Amount_AppliedCaptionLbl: label 'Amount Applied';
        Deposits__3CaptionLbl: label 'Deposits* 3';
        Eligibility_DetailsCaptionLbl: label 'Eligibility Details';
        Maxim__Amount_Avail__for_the_LoanCaptionLbl: label 'Maxim. Amount Avail. for the Loan';
        Outstanding_LoanCaptionLbl: label 'Outstanding Loan';
        Member_DepositsCaptionLbl: label 'Member Deposits';
        Amount_AppliedCaption_Control1102760132Lbl: label 'Amount Applied';
        MemberCaption_Control1102760133Lbl: label 'Member';
        Loan_TypeCaption_Control1102760134Lbl: label 'Loan Type';
        Loan_Application_DetailsCaption_Control1102760151Lbl: label 'Loan Application Details';
        RepaymentCaptionLbl: label 'Repayment';
        Maxim__Amount_Avail__for_the_LoanCaption_Control1102760150Lbl: label 'Maxim. Amount Avail. for the Loan';
        Total_Outstand__Loan_BalanceCaptionLbl: label 'Total Outstand. Loan Balance';
        Deposits___MulitiplierCaptionLbl: label 'Deposits * Mulitiplier';
        Member_DepositsCaption_Control1102760148Lbl: label 'Member Deposits';
        Deposits_AnalysisCaptionLbl: label 'Deposits Analysis';
        Bridged_AmountCaptionLbl: label 'Bridged Amount';
        Out__Balance_After_Top_upCaptionLbl: label 'Out. Balance After Top-up';
        Recommended_AmountCaptionLbl: label 'Recommended Amount';
        Net_Loan_Disbursement_CaptionLbl: label 'Net Loan Disbursement:';
        V3__Qualification_as_per_GuarantorsCaptionLbl: label '3. Qualification as per Guarantors';
        Defaulter_Info_CaptionLbl: label 'Defaulter Info:';
        V2__Qualification_as_per_SalaryCaptionLbl: label '2. Qualification as per Salary';
        V1__Qualification_as_per_SharesCaptionLbl: label '1. Qualification as per Shares';
        QUALIFICATIONCaptionLbl: label 'QUALIFICATION';
        Insufficient_Deposits_to_cover_the_loan_applied__RiskCaptionLbl: label 'Insufficient Deposits to cover the loan applied: Risk';
        WARNING_CaptionLbl: label 'WARNING:';
        Salary_is_Insufficient_to_cover_the_loan_applied__RiskCaptionLbl: label 'Salary is Insufficient to cover the loan applied: Risk';
        WARNING_Caption_Control1000000140Lbl: label 'WARNING:';
        WARNING_Caption_Control1000000141Lbl: label 'WARNING:';
        Guarantors_do_not_sufficiently_cover_the_loan__RiskCaptionLbl: label 'Guarantors do not sufficiently cover the loan: Risk';
        WARNING_Caption_Control1000000020Lbl: label 'WARNING:';
        Shares_Deposits_BoostedCaptionLbl: label 'Shares/Deposits Boosted';
        I_Certify_that_the_foregoing_details_and_member_information_is_true_statement_of_the_account_maintained_CaptionLbl: label 'I Certify that the foregoing details and member information is true statement of the account maintained.';
        Loans_Asst__Officer______________________CaptionLbl: label 'Loans Asst. Officer:_____________________';
        Signature__________________CaptionLbl: label 'Signature:_________________';
        Date___________________CaptionLbl: label 'Date:__________________';
        General_Manger______________________CaptionLbl: label 'General Manger:_____________________';
        Signature__________________Caption_Control1102760039Lbl: label 'Signature:_________________';
        Date___________________Caption_Control1102760040Lbl: label 'Date:__________________';
        Signature__________________Caption_Control1102755017Lbl: label 'Signature:_________________';
        Date___________________Caption_Control1102755018Lbl: label 'Date:__________________';
        Loans_Officer______________________CaptionLbl: label 'Loans Officer:_____________________';
        Chairman_Signature______________________CaptionLbl: label 'Chairman Signature:_____________________';
        Secretary_s_Signature__________________CaptionLbl: label 'Secretary''s Signature:_________________';
        Members_Signature______________________CaptionLbl: label 'Members Signature:_____________________';
        Credit_Committe_Minute_No______________________CaptionLbl: label 'Credit Committe Minute No._____________________';
        Date___________________Caption_Control1102755074Lbl: label 'Date:__________________';
        Comment______________________________________________________________________________________CaptionLbl: label 'Comment :____________________________________________________________________________________';
        Amount_Approved______________________CaptionLbl: label 'Amount Approved:_____________________';
        Signatory_1__________________CaptionLbl: label 'Signatory 1:_________________';
        Signatory_2__________________CaptionLbl: label 'Signatory 2:_________________';
        Signatory_3__________________CaptionLbl: label 'Signatory 3:_________________';
        FOSA_SIGNATORIES_CaptionLbl: label 'FOSA SIGNATORIES:';
        Comment________________________________________________________________________________Caption_Control1102755070Lbl: label 'Comment :____________________________________________________________________________________';
        FINANCE_CaptionLbl: label 'FINANCE:';
        Disbursed_By__________________CaptionLbl: label 'Disbursed By:_________________';
        Signature__________________Caption_Control1102755081Lbl: label 'Signature:_________________';
        Date___________________Caption_Control1102755082Lbl: label 'Date:__________________';
        Salary_Details_AnalysisCaptionLbl: label 'Salary Details Analysis';
        Total_EarningsCaptionLbl: label 'Total Earnings';
        Total_DeductionsCaptionLbl: label 'Total Deductions';
        Net_SalaryCaptionLbl: label 'Net Salary';
        Qualification_as_per_SalaryCaptionLbl: label 'Qualification as per Salary';
        V1_3_of_Gross_PayCaptionLbl: label '1/3 of Gross Pay';
        Amount_GuaranteedCaptionLbl: label 'Amount Guaranteed';
        Loan_GuarantorsCaptionLbl: label 'Loan Guarantors';
        RatioCaptionLbl: label 'Ratio';
        Total_Amount_GuaranteedCaptionLbl: label 'Total Amount Guaranteed';
        Total_TopupsCaptionLbl: label 'Total Topups';
        Bridged_LoansCaptionLbl: label 'Bridged Loans';
        Loan_No_CaptionLbl: label 'Loan No.';
        Principal_Top_UpCaptionLbl: label 'Principal Top Up';
        Client_CodeCaptionLbl: label 'Client Code';
        Loan_TypeCaption_Control1102755059Lbl: label 'Loan Type';
        TotalsCaptionLbl: label 'Totals';
        Total_Amount_BridgedCaptionLbl: label 'Total Amount Bridged';
        Bridging_total_higher_than_the_qualifing_amountCaptionLbl: label 'Bridging total higher than the qualifing amount';
        WARNING_Caption_Control1102755044Lbl: label 'WARNING:';
        TotalLoanBalance: Decimal;
        TGAmount: Decimal;
        NetSalary: Decimal;
        Riskamount: Decimal;
        WarnBridged: Text;
        WarnSalary: Text;
        WarnDeposits: Text;
        WarnGuarantor: Text;
        WarnShare: Text;
        RiskGshares: Decimal;
        RiskDeposits: Decimal;
        BasicEarnings: Decimal;
        DepX: Decimal;
        LoanPrincipal: Decimal;
        loanInterest: Decimal;
        AmountGuaranteed: Decimal;
        StatDeductions: Decimal;
        GuarOutstanding: Decimal;
        TwoThirds: Decimal;
        Bridged_AmountCaption: Integer;
        LNumber: Code[20];
        TotalLoanDeductions: Decimal;
        TotalRepayments: Decimal;
        Totalinterest: Decimal;
        Band: Decimal;
        TotalOutstanding: Decimal;
        BANDING: Record "Deposit Tier Setup";
        NtTakeHome: Decimal;
        ATHIRD: Decimal;
        Psalary: Decimal;
        LoanApss: Record "Loans Register";
        TotalLoanBal: Decimal;
        TotalBand: Decimal;
        LoanAp: Record "Loans Register";
        TotalRepay: Decimal;
        TotalInt: Decimal;
        LastFieldNo: Integer;
        TotLoans: Decimal;
        JazaLevy: Decimal;
        BridgeLevy: Decimal;
        Upfronts: Decimal;
        Netdisbursed: Decimal;
        TotalLRepayments: Decimal;
        BridgedRepayment: Decimal;
        OutstandingLrepay: Decimal;
        Loantop: Record "Loan Offset Details";
        BRIGEDAMOUNT: Decimal;
        TOTALBRIGEDAMOUNT: Decimal;
        FinalInst: Decimal;
        NonRec: Decimal;
        OTHERDEDUCTIONS: Decimal;
        StartDate: Date;
        DateFilter: Text[100];
        FromDate: Date;
        ToDate: Date;
        FromDateS: Text[100];
        ToDateS: Text[100];
        DivTotal: Decimal;
        CDeposits: Decimal;
        CustDiv: Record Customer;
        DivProg: Record "Dividends Progression";
        CDiv: Decimal;
        BDate: Date;
        CustR: Record Customer;
        LoanInsurance: Decimal;
        LoanProcessingFee: Decimal;
        ProductCharges: Record "Loan Product Charges";
        LoanAppraisal: Decimal;
        Collateral: Record "Loan Collateral Details";
        CollCharge: Decimal;
        Otherded: Decimal;
        ProccessingFee: Decimal;
        DisbursementFee: Decimal;
        InsuranceFee: Decimal;
        TopUpFee: Decimal;
        ObjProductType: Record "Loan Products Setup";
        DiscountFee: Decimal;
        MaxDepositQualification: Decimal;
        DeboosterAmount: Decimal;
        TotalBridgeAmount: Decimal;
        TopCommision: Decimal;
        SFactory: Codeunit "SWIZZSFT Factory";
        Booster: Decimal;
        Prembal: Decimal;
        LoanGuar: Record "Loans Guarantee Details";
        SMSMessages: Record "SMS Messages";
        iEntryNo: Integer;
        /////-----------Nav
        ExciseDutyShareBoostComm: Decimal;
        ObjSecurities: Record "Loan Collateral Details";
        ObjProductCharge: Record "Loan Product Charges";
        LInsurance: Decimal;
        ShareCap: Decimal;
        Multiplier: Decimal;
        CAPTION_TOP_UP_FEE: Text[50];
        CAPTION_TOP_UP_TOTAL: Text[50];
        CAPTION_TOP_UP_GENERAL: Text[50];
        KHLBalance: Decimal;
        TrusteeBalance: Decimal;
        MotorBalance: Decimal;
        LPFcharge: Decimal;
        LAppraisalFee: Decimal;
        LAppraisalFeeAccount: Code[20];
        TscInt: Decimal;
        AccruedInt: Decimal;
        ProcessingFee: Decimal;
        LoanFormFee: Decimal;
        DepositsMultiplier: Decimal;
        ObjLoans: Record "Loans Register";
        VarTotalCollateralValue: Decimal;
        VarTotalLoansnotSecuredbyCollateral: Decimal;
        EmergencyUpfront: Decimal;
        interestUpfront: Decimal;
        repayAmount: Decimal;
        Secuirty: Decimal;
        RemainigDep: Decimal;
        PrincipalAmountGlobal: Decimal;
        TotalGuaranteed: Decimal;
        BoostedAmount2: Decimal;
        ShareBoostComm: Decimal;
        currentshare: Decimal;
        SMSFEE: Decimal;
        HisaARREAR: Decimal;
        ShareBoostCommHISA: Decimal;
        BoostedAmountHISA: Decimal;
        Loans: Record "Loans Register";
        ShareBoostCommHISAFOSA: Decimal;
        LoanTransferFee: Decimal;
        RemainingDays: Integer;
        SaccoInt: Decimal;
        CAPTION_TOP_UP_HEADER: Text[50];
        CAPTION_TOP_UP_AMOUNT: Text[50];
        CAPTION_TOP_UP_INTEREST: Text;
        CollateralSum: Decimal;

    local procedure FnReccommendAmount(RequestedAmount: Decimal; QShares: Decimal; QGuarantors: Decimal; QSalary: Decimal; QSecurities: Decimal) RecommendedAmount: Decimal
    var
        LnApp: Record "Loans Register";
    begin
        RecommendedAmount := RequestedAmount;

        // Compare with Psalary and update Recomm if Psalary is smaller
        //But first, check if they did use the Salary to Appraise
        if QSalary <> 0 then begin
            if QSalary < RecommendedAmount then
                RecommendedAmount := ROUND(QSalary, 100, '<');
        end;

        // Compare with QGuarantors and update RecommendedAmount if QGuarantors is smaller
        //But first, add QGuarantors together with Collateral value..   FESTUS
        QGuarantors := QGuarantors + CollCharge;
        if QGuarantors < RecommendedAmount then
            RecommendedAmount := ROUND(QGuarantors, 100, '<');



        if LoanType.Get("Loans Register"."Loan Product Type") then begin
            //MESSAGE('loan type %1',"Loans Register"."Loan Product Type");
            if LoanType."Appraise Deposits" then begin
                if RecommendedAmount > QShares then begin
                    RecommendedAmount := QShares;
                end;
            end;
            //normal loan
            if LoanType.Get("Loans Register"."Loan Product Type") then begin
                //MESSAGE('loan type %1',"Loans Register"."Loan Product Type");
                if ("Loans Register"."Loan Product Type" = '23') or ("Loans Register"."Loan Product Type" = '21') then begin
                    //MESSAGE('appraise %1',LoanType."Appraise Deposits");
                    //IF RecommendedAmount > QShares THEN BEGIN
                    RecommendedAmount := "Loans Register"."Requested Amount";
                    //MESSAGE('RecommendedAmount %1',RecommendedAmount);
                    //END;
                end;
            end;
            if ((LoanType."Appraise Deposits") and (LoanType."Appraise Securities")) then begin

                if RecommendedAmount > QShares then
                    RecommendedAmount := QShares;
                if RecommendedAmount > QSecurities then
                    RecommendedAmount := QSecurities;
            end;


            if ((LoanType."Appraise Guarantors") and (LoanType."Appraise Deposits")) then begin
                if "Loans Register"."Loan Product Type" <> '19' then begin
                    if RecommendedAmount > QShares then
                        RecommendedAmount := QShares;
                    if RecommendedAmount > (QGuarantors + QSecurities) then
                        RecommendedAmount := QGuarantors + QSecurities;
                end;
                if RecommendedAmount > QShares then
                    RecommendedAmount := QShares;
                if RecommendedAmount > (QGuarantors + QSecurities) then
                    RecommendedAmount := QGuarantors + QSecurities;

            end;

            // if ((LoanType."Appraise Guarantors") and (LoanType."Appraise Deposits") and (LoanType."Appraise Securities")) then begin
            //        IF RecommendedAmount > QSalary THEN
            //          RecommendedAmount:=QSalary;
            if RequestedAmount > QShares then
                RequestedAmount := QShares;
            if RequestedAmount > QGuarantors then
                RecommendedAmount := QGuarantors;
            if RequestedAmount > QSecurities then
                RecommendedAmount := QSecurities + QGuarantors;

            if RecommendedAmount > QShares then
                RecommendedAmount := QShares;
            if RecommendedAmount > (QGuarantors + QSecurities) then
                RecommendedAmount := QGuarantors + QSecurities;
            // end;

        end;

        if RecommendedAmount > RequestedAmount then
            RecommendedAmount := RequestedAmount;
        if ("Loans Register"."Is Top Up") then
            RecommendedAmount := "Loans Register"."Requested Amount";

        Message('....amount rec is %1', RecommendedAmount);
        if RecommendedAmount < 0 then
            RecommendedAmount := 0;
        exit(RecommendedAmount);
    end;

    local procedure FnRecommendShareBooster(TotalDeposits: Decimal; RequestedAmount: Decimal): Decimal
    begin
        exit(RequestedAmount - TotalDeposits);
    end;

    local procedure FnReturnRetirementDate(MemberNo: Code[50]): Date
    var
        ObjMembers: Record Customer;
    begin
        GenSetUp.Get();
        ObjMembers.Reset;
        ObjMembers.SetRange(ObjMembers."No.", MemberNo);
        if ObjMembers.Find('-') then
            exit(CalcDate(GenSetUp."Retirement Age", ObjMembers."Date of Birth"));
    end;

    local procedure FnWarningMessages()
    begin
        if Netdisbursed < 0 then
            Message('Net Disbursed cannot be 0 or Negative');

        if MAXAvailable < 0 then
            WarnDeposits := UpperCase('WARNING: Insufficient Deposits to cover the loan applied: Risk %1')
        else
            WarnDeposits := '';

        if MAXAvailable < 0 then
            RiskDeposits := "Loans Register"."Requested Amount" - MAXAvailable;

        if Msalary < "Loans Register"."Requested Amount" then
            WarnSalary := UpperCase('WARNING: Salary is Insufficient to cover the loan applied: Risk')
        else
            WarnSalary := '';

        if Msalary < "Loans Register"."Requested Amount" then
            Riskamount := "Loans Register"."Requested Amount" - Msalary;

        if GShares < "Loans Register"."Requested Amount" then
            WarnGuarantor := UpperCase('WARNING: Guarantors do not sufficiently cover the loan: Risk')
        else
            WarnGuarantor := '';

        if GShares < "Loans Register"."Requested Amount" then
            RiskGshares := "Loans Register"."Requested Amount" - GShares;
        //MESSAGE('WARNING: Insufficient Deposits to cover the loan applied: Risk %1',Riskamount)
        //
        /*IF ("Loans Register"."Expected Date of Completion" > FnReturnRetirementDate("Loans Register"."Client Code")) THEN
          MESSAGE('The Member retirement date will come earlier than the Expected Date of Completion (%1).The Member is due to retire on %2: Risk',"Loans Register"."Expected Date of Completion",FnReturnRetirementDate("Loans Register"."Client Code"));
        */

    end;

    local procedure FnEditRepaymentPrincipleAndInterestAmounts()
    begin
        TotalMRepay := 0;
        LPrincipal := 0;
        LInterest := 0;
        InterestRate := "Loans Register".Interest;
        LoanAmount := "Loans Register"."Approved Amount";
        RepayPeriod := "Loans Register".Installments;
        LBalance := "Loans Register"."Approved Amount";


        if "Loans Register"."Repayment Method" = "Loans Register"."repayment method"::"Straight Line" then begin
            "Loans Register".TestField(Installments);
            LPrincipal := ROUND(LoanAmount / RepayPeriod, 1, '=');
            LInterest := ROUND((InterestRate / 12 / 100) * LoanAmount, 1, '=');
            //IF "Loans Register"."Loan Product Type"='KARIBU' THEN
            // LInterest:=ROUND((InterestRate/12/100)*LoanAmount,1,'=');
            "Loans Register"."Loan Principle Repayment" := LPrincipal;
            "Loans Register"."Loan Interest Repayment" := LInterest;
            "Loans Register".Repayment := LPrincipal + LInterest;
            if LoanType.Get("Loans Register"."Loan Product Type") then begin
                if ("Loans Register"."Loan Product Type" = 'SUKUMA') or
                   ("Loans Register"."Loan Product Type" = 'INSTANT') or
                   ("Loans Register"."Loan Product Type" = 'KARIBU') then begin
                    "Loans Register".Repayment := "Loans Register"."Approved Amount";
                    "Loans Register"."Loan Principle Repayment" := "Loans Register"."Approved Amount";
                end;
                if "Loans Register"."Loan Product Type" = 'SUKUMA' then
                    "Loans Register"."Loan Interest Repayment" := SFactory.FnGetChargeFee("Loans Register"."Loan Product Type", "Loans Register"."Approved Amount", 'INT');
                "Loans Register".Modify;
            end;
        end;
        //Monthly Interest Formula PR(T+1)/200T
        if "Loans Register"."Repayment Method" = "Loans Register"."repayment method"::"Reducing Balance" then begin
            "Loans Register".TestField(Interest);
            "Loans Register".TestField(Installments);
            LPrincipal := ROUND(LoanAmount / RepayPeriod, 1, '=');
            LInterest := ROUND(Recomm * "Loans Register".Interest / 12 * (RepayPeriod + 1) / (200 * RepayPeriod), 1, '=');//ROUND((InterestRate/12/100)*LBalance,1,'=');
            if ("Loans Register"."Loan Product Type" = 'SUKUMA') or
            ("Loans Register"."Loan Product Type" = 'INSTANT') or
            ("Loans Register"."Loan Product Type" = 'KARIBU') then begin
                Message('Monthly Interest Repayment=%1, Monthly Principal Repayment=%2, ****Total Monthly Repayment=%3***', LInterest, LPrincipal, LPrincipal + LInterest);
            end else
                Message('Monthly Interest Repayment=%1, Monthly Principal Repayment=%2, ****Total Monthly Repayment=%3***', LInterest, LPrincipal, LPrincipal);
            "Loans Register".Repayment := LPrincipal + LInterest;
            "Loans Register"."Loan Principle Repayment" := LPrincipal;
            "Loans Register"."Loan Interest Repayment" := LInterest;
            if ("Loans Register"."Loan Product Type" = 'SUKUMA') or
               ("Loans Register"."Loan Product Type" = 'INSTANT') or
               ("Loans Register"."Loan Product Type" = 'KARIBU') then begin
                "Loans Register".Repayment := "Loans Register"."Approved Amount";
                "Loans Register"."Loan Principle Repayment" := "Loans Register"."Approved Amount" - LInterest * "Loans Register".Installments;//Remove interest subtraction-if unpleasant result
                "Loans Register"."Loan Interest Repayment" := LInterest * "Loans Register".Installments;
            end;
            if "Loans Register"."Loan Product Type" = 'SUKUMA' then
                "Loans Register"."Loan Interest Repayment" := SFactory.FnGetChargeFee("Loans Register"."Loan Product Type", "Loans Register"."Approved Amount", 'INT');
            "Loans Register".Modify;
        end;


        if "Loans Register"."Repayment Method" = "Loans Register"."repayment method"::Amortised then begin
            TotalMRepay := ROUND((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -RepayPeriod)) * LoanAmount, 1, '=');
            LInterest := ROUND(LBalance / 100 / 12 * InterestRate, 1, '=');
            LPrincipal := TotalMRepay - LInterest;
            "Loans Register"."Loan Principle Repayment" := LPrincipal;
            "Loans Register"."Loan Interest Repayment" := LInterest;
            "Loans Register"."Approved Repayment" := TotalMRepay;

            ObjProductCharge.Reset;
            ObjProductCharge.SetRange(ObjProductCharge."Product Code", "Loans Register"."Loan Product Type");
            ObjProductCharge.SetRange(ObjProductCharge."Loan Charge Type", ObjProductCharge."loan charge type"::"Loan Insurance");
            if ObjProductCharge.FindSet then begin
                LInsurance := "Loans Register"."Approved Amount" * (ObjProductCharge.Percentage / 100);
            end;

            if LoanType.Get("Loans Register"."Loan Product Type") then begin
                if ("Loans Register"."Loan Product Type" = 'SUKUMA') or
                  ("Loans Register"."Loan Product Type" = 'INSTANT') or
                  ("Loans Register"."Loan Product Type" = 'KARIBU') then begin
                    "Loans Register".Repayment := "Loans Register"."Approved Amount";
                    "Loans Register"."Loan Principle Repayment" := "Loans Register"."Approved Amount";
                end else
                    "Loans Register".Repayment := LPrincipal + LInterest + LInsurance;
                if "Loans Register"."Loan Product Type" = 'SUKUMA' then
                    "Loans Register"."Loan Interest Repayment" := SFactory.FnGetChargeFee("Loans Register"."Loan Product Type", "Loans Register"."Approved Amount", 'INT');
                "Loans Register".Modify;
            end;
        end;
    end;
}

