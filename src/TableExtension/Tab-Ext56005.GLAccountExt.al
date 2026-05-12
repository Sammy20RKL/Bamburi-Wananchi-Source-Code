#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
tableextension 56005 GLAccountExt extends "G/L Account"
{

    fields
    {
        field(10001; "GIFI Code"; Code[10])
        {
            Caption = 'GIFI Code';
        }
        field(27000; "SAT Account Code"; Code[20])
        {
            Caption = 'SAT Account Code';
        }
        field(50000; "Budget Controlled"; Boolean)
        {
        }
        field(50004; "Expense Code"; Code[10])
        {
            TableRelation = "Expense Code";

            trigger OnValidate()
            begin
                //Expense code only applicable if account type is posting and Budgetary control is applicable
                TestField("Account Type", "account type"::Posting);
                TestField("Budget Controlled", true);
            end;
        }
        field(50005; "Donor defined Account"; Boolean)
        {
            Description = 'Select if the Account is donor Defined';
        }
        field(54245; "Grant Expense"; Boolean)
        {
        }
        field(54246; Status; Option)
        {
            Editable = true;
            OptionMembers = New,"Pending Approval",Approved,Rejected;
        }
        field(54247; "Responsibility Center"; Code[20])
        {
        }
        field(54248; "Old No."; Code[20])
        {
        }
        field(54249; "Date Created"; Date)
        {
        }
        field(54250; "Created By"; Code[20])
        {
        }
        field(1003; "GL Account Balance"; Decimal)
        {
            CalcFormula = Sum("G/L Entry".Amount WHERE("G/L Account No." = FIELD("No."),
                                                        "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                        "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter")));
            Caption = 'Balance';
            Editable = false;
            FieldClass = FlowField;
        }

        field(54252; StatementOfFP; Option)
        {
            //OptionMembers = "  ",Cashinhand,InterestonMemberdeposits,Cashatbank,GrossLoanPortfolio,PropertyEquipment,AllowanceforLoanLoss,PrepaymentsSundryReceivables,Investmentincompanies,IntangibleAssets,"Other Assets";
            OptionMembers = "  ",Cashinhand,Cashatbank,GrossLoanPortfolio,PropertyEquipment,AllowanceforLoanLoss,PrepaymentsSundryReceivables,Investmentincompanies,"Other Assets",IntangibleAssets,ExternalBorrowings,Placement,EquityInvestments,DividendPayable,Nonwithdrawabledeposits,ShareCapital,PrioryarRetainedEarnings,StatutoryReserve,OtherReserves,RevaluationReserves,TaxPayable,OtherLiabilities;
        }
        field(54253; StatementOfFP2; Option)
        {
            OptionCaption = ' ,Nonwithdrawabledeposits,ShareCapital,PrioryarRetainedEarnings,StatutoryReserve,OtherReserves,RevaluationReserves,TaxPayable,OtherLiabilities';
            OptionMembers = " ",Nonwithdrawabledeposits,ShareCapital,PrioryarRetainedEarnings,StatutoryReserve,OtherReserves,RevaluationReserves,TaxPayable,OtherLiabilities;
            // OptionCaption = '  ,Nonwithdrawabledeposits,TaxPayable,DeferredTaxLiability,OtherLiabilities,ExternalBorrowings,ShareCapital,StatutoryReserve,OtherReserves,RevaluationReserves,PrioryarRetainedEarnings,CurrentYrSurplus';
            // OptionMembers = "  ",Nonwithdrawabledeposits,TaxPayable,DeferredTaxLiability,OtherLiabilities,ExternalBorrowings,ShareCapital,StatutoryReserve,OtherReserves,RevaluationReserves,PrioryarRetainedEarnings,CurrentYrSurplus;
        }
        field(54254; "Form2F(Statement of C Income)"; Option)
        {
            OptionCaption = ' ,InterestonLoanPortfolio,FeesCommissiononLoanPortfolio,GovernmentSecurities,InvestmentinCompaniesshares,nterestExpenseonDeposits,DividendExpenses,OtherFinancialExpense,FeesCommissionExpense,OtherExpense,ProvisionforLoanLosses';
            OptionMembers = " ",InterestonLoanPortfolio,FeesCommissiononLoanPortfolio,GovernmentSecurities,InvestmentinCompaniesshares,nterestExpenseonDeposits,DividendExpenses,OtherFinancialExpense,FeesCommissionExpense,OtherExpense,ProvisionforLoanLosses;
            //OptionMembers = " ",OtherOperatingincome,NetFeeandcommission,InterestExpenses,OtherInterestIncome,InterestonLoanPortfolio,FeesCommissiononLoanPortfolio,GovernmentSecurities,InvestmentinCompaniesshares,nterestExpenseonDeposits,DividendExpenses,OtherFinancialExpense,FeesCommissionExpense,OtherExpense,ProvisionforLoanLosses;
        }
        field(54255; "Form2F1(Statement of C Income)"; Option)
        {
            OptionCaption = ' ,PersonnelExpenses,GovernanceExpenses,MarketingExpenses,DepreciationandAmortizationCharges,AdministrativeExpenses,Taxes,NonOperatingIncome,NonOperatingExpense,Donations,PlacementinBanks,CostofExternalBorrowings,EquityInvestmentsinsubsidiaries,OtherFinancialExpense';
            OptionMembers = " ",,PersonnelExpenses,GovernanceExpenses,MarketingExpenses,DepreciationandAmortizationCharges,AdministrativeExpenses,Taxes,NonOperatingIncome,NonOperatingExpense,Donations,PlacementinBanks,CostofExternalBorrowings,EquityInvestmentsinsubsidiaries,OtherFinancialExpense;
            // OptionCaption = '  ,PersonnelExpenses,GovernanceExpenses,MarketingExpenses,DepreciationandAmortizationCharges,AdministrativeExpenses,Taxes,NonOperatingIncome,NonOperatingExpense,OtherFinancialExpense,ValueofLoansRecovered';
            // OptionMembers = "  ",PersonnelExpenses,GovernanceExpenses,MarketingExpenses,DepreciationandAmortizationCharges,AdministrativeExpenses,Taxes,NonOperatingIncome,NonOperatingExpense,OtherFinancialExpense,ValueofLoansRecovered;

        }
        field(54256; "Capital adequecy"; Option)
        {
            // OptionCaption = '  ,ShareCapital,StatutoryReserve,RetainedEarnings,LoansandAdvances,Cash,InvestmentsinSubsidiary,Otherreserves,GovernmentSecurities,DepositsandBalancesatOtherInstitutions,Otherassets,PropertyandEquipment,TotalDepositsLiabilities,Investments,NetSurplusaftertax';
            // OptionMembers = "  ",ShareCapital,StatutoryReserve,RetainedEarnings,LoansandAdvances,Cash,InvestmentsinSubsidiary,Otherreserves,GovernmentSecurities,DepositsandBalancesatOtherInstitutions,Otherassets,"PropertyandEquipment ",TotalDepositsLiabilities,Investments,NetSurplusaftertax;
            OptionCaption = ' ,ShareCapital,StatutoryReserve,RetainedEarnings,NetSurplusaftertax,LoansandAdvances,Cash,InvestmentsinSubsidiary,Otherreserves,GovernmentSecurities,DepositsandBalancesatOtherInstitutions,Otherassets,PropertyandEquipment,TotalDepositsLiabilities,Investments';
            OptionMembers = " ",ShareCapital,StatutoryReserve,RetainedEarnings,NetSurplusaftertax,LoansandAdvances,Cash,InvestmentsinSubsidiary,Otherreserves,GovernmentSecurities,DepositsandBalancesatOtherInstitutions,Otherassets,PropertyandEquipment,TotalDepositsLiabilities,Investments;
        }
        field(54257; Liquidity; Option)
        {

            OptionCaption = ' ,TotalOtherliabilitiesNew,TimeDeposits,balanceswithotherfinancialinsti,GovSecuritiesBankBalances,BankBalances,OverdraftsandMaturedLoans,LocalNotes';
            OptionMembers = " ",TotalOtherliabilitiesNew,TimeDeposits,balanceswithotherfinancialinsti,GovSecuritiesBankBalances,BankBalances,OverdraftsandMaturedLoans,LocalNotes;
            // OptionCaption = ' ,LocalNotes,BankBalances,GovSecurities,balanceswithotherfinancialinsti,TotalOtherliabilitiesNew,TimeDeposits';
            // OptionMembers = " ",LocalNotes,BankBalances,GovSecurities,balanceswithotherfinancialinsti,TotalOtherliabilitiesNew,TimeDeposits;
        }
        field(54258; "Form2E(investment)"; Option)
        {
            OptionCaption = '  ,Core_Capital,Nonearningassets,totaldeposits,subsidiaryandrelatedentities,Equityinvestment,Otherinvestments,otherassets';
            OptionMembers = " ",Core_Capital,Nonearningassets,totaldeposits,subsidiaryandrelatedentities,Equityinvestment,Otherinvestments,otherassets;
            // OptionCaption = '  ,Core_Capital,Equityinvestment,Otherinvestments,subsidiaryandrelatedentities,otherassets,totaldeposits';
            // OptionMembers = "  ",Core_Capital,Equityinvestment,Otherinvestments,subsidiaryandrelatedentities,otherassets,totaldeposits;
        }
        field(54259; "Form 2H other disc"; Option)
        {
            //OptionCaption = '  ,AllowanceForLoanLoss,Core_Capital,Deposits liabilities';
            //OptionMembers = "  ",AllowanceForLoanLoss,Core_Capital,"Deposits liabilities";
            OptionCaption = ' ,Core_Cpital,Liquidity,Depositliabilites,Otherliablilities,CoreCapitalDeduction,AllowanceForLoanLoss';
            OptionMembers = " ",,Core_Cpital,Liquidity,Depositliabilites,Otherliablilities,CoreCapitalDeduction,AllowanceForLoanLoss;
        }
        field(54260; "Form2E(investment)New"; Option)
        {
            OptionCaption = '  ,Nonearningassets';
            OptionMembers = "  ",Nonearningassets;
        }
        field(54261; "Form2E(investment)Land"; Option)
        {
            OptionCaption = ' ,LandBuilding';
            OptionMembers = " ",LandBuilding;
        }
        field(54262; ChangesInEquity; Option)
        {
            OptionCaption = ' ,ShareCapital,StatutoryReserve,GeneralReserve,RevaluationReserve,RetainedEarnings,honararia';
            OptionMembers = " ",ShareCapital,StatutoryReserve,GeneralReserve,RevaluationReserve,RetainedEarnings,honararia;
        }
        field(54263; Assets; Option)
        {
            OptionMembers = " ",CashAndEquivalents,ReceivablesAndPrepayements,LoansAndAdvances,FinancialAssets,propertyplantandEquipment,Intangiableassets;
            DataClassification = ToBeClassified;
        }
        field(54264; MkopoLiabilities; Option)
        {
            OptionMembers = " ",TradeandotherPayables,LoanLoss,MemberDeposits,dividendsandInterestPayable,Honoria,Taxpayable;
            DataClassification = ToBeClassified;
        }
        field(54265; FinancedBy; Option)
        {
            OptionMembers = " ",StatutoryReserves,RevenueReserves,Sharecapital;
        }
        field(54266; Financials; Option)
        {
            OptionMembers = " ",Revenue,InterestIncome,Expenses;
        }
        field(54267; PersonnelExRe; Option)
        {
            OptionMembers = " ","Personnel Expenses","Personnel Revenue";
        }

        //Income
        field(54268; Incomes; Option)
        {
            OptionMembers = " ",InterestOnLoans,InterestExpenses,OtherOperatingIncome,InvestmentIncome,GorvernanceExpenses,AdministrationExpenses,PersonelExpenses,OperatingExpenses,FinancialExpense,MarketingExpenses,DepreciationAmmortisation,IncomeTaxExpense;
            DataClassification = ToBeClassified;
        }


        field(54269; Others; option)
        {
            OptionMembers = " ",PriorYearAdjustments,ShortTermLiabilities;
        }

    }

    keys
    {
        key(Key10; "GIFI Code")
        {
        }
        key(Key11; "Account Category")
        {
        }
    }

    fieldgroups
    {

    }
    var
        Text000: label 'You cannot change %1 because there are one or more ledger entries associated with this account.';
        Text001: label 'You cannot change %1 because this account is part of one or more budgets.';
        GLSetup: Record "General Ledger Setup";
        CostAccSetup: Record "Cost Accounting Setup";
        DimMgt: Codeunit DimensionManagement;
        CostAccMgt: Codeunit "Cost Account Mgt";
        GLSetupRead: Boolean;
        Text002: label 'There is another %1: %2; which refers to the same %3, but with a different %4: %5.';
        NoAccountCategoryMatchErr: label 'There is no subcategory description for %1 that matches ''%2''.', Comment = '%1=account category value, %2=the user input.';
        GLEntry: Record "G/L Entry";
        Usersetup: Record "User Setup";
}