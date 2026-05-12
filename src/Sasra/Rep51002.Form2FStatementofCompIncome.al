#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51002 "Form2F Statement of CompIncome"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Form2F Statement of CompIncome.rdlc';
    UsageCategory = ReportsandAnalysis;

    dataset
    {
#pragma warning disable AL0275
        dataitem(Company; "Company Information")
#pragma warning restore AL0275
        {
            column(ReportForNavId_1; 1)
            {
            }
            column(AsAt; AsAt)
            {
            }
            column(Date; Date)
            {
            }
            column(FinancialYear; FinancialYear)
            {
            }
            column(Name; Company.Name)
            {
            }
            column(InterestonLoanPortfolio; InterestonLoanPortfolio)
            {
            }
            column(FeesCommissiononLoanPortfolio; FeesCommissiononLoanPortfolio)
            {
            }
            column(GovernmentSecurities; GovernmentSecurities)
            {
            }
            column(InvestmentinCompaniesshares; InvestmentinCompaniesshares)
            {
            }
            column(EquityInvestmentsinsubsidiaries; EquityInvestmentsinsubsidiaries)
            {
            }
            column(Derivatives; Derivatives)
            {
            }
            column(CollectiveinvestmentSchemes; CollectiveinvestmentSchemes)
            {
            }
            column(CommercialPapers; CommercialPapers)
            {
            }
            column(PlacementinBanks; PlacementinBanks)
            {
            }
            column(nterestExpenseonDeposits; nterestExpenseonDeposits)
            {
            }
            column(CostofExternalBorrowings; CostofExternalBorrowings)
            {
            }
            column(DividendExpenses; DividendExpenses)
            {
            }
            column(OtherFinancialExpense; OtherFinancialExpense)
            {
            }
            column(FeesCommissionExpense; FeesCommissionExpense)
            {
            }
            column(OtherExpense; OtherExpense)
            {
            }
            column(ProvisionforLoanLosses; ProvisionforLoanLosses)
            {
            }
            column(ValueofLoansRecovered; ValueofLoansRecovered)
            {
            }
            column(PersonnelExpenses; PersonnelExpenses)
            {
            }
            column(GovernanceExpenses; GovernanceExpenses)
            {
            }
            column(MarketingExpenses; MarketingExpenses)
            {
            }
            column(DepreciationandAmortizationCharges; DepreciationandAmortizationCharges)
            {
            }
            column(AdministrativeExpenses; AdministrativeExpenses)
            {
            }
            column(NonOperatingIncome; NonOperatingIncome)
            {
            }
            column(NonOperatingExpense; NonOperatingExpense)
            {
            }
            column(Taxes; Taxes)
            {
            }
            column(Donations; Donations)
            {
            }
            column(FinancialIncomefromLoansPortfolio; FinancialIncomefromLoansPortfolio)
            {
            }
            column(FinancialExpense; FinancialExpense)
            {
            }
            column(NetFinancialIncomeLoss; NetFinancialIncomeLoss)
            {
            }
            column(NetNonOperatingIncomeExpense; NetNonOperatingIncomeExpense)
            {
            }
            column(FinancialIncomefromInvestments; FinancialIncomefromInvestments)
            {
            }
            column(AllowanceforLoanLoss; AllowanceforLoanLoss)
            {
            }
            column(OperatingExpenses; OperatingExpenses)
            {
            }
            column(NetOperatingIncome; NetOperatingIncome)
            {
            }
            column(NetIncomeBeforeTaxesandDonations; NetIncomeBeforeTaxesandDonations)
            {
            }
            column(NetIncomeAfterTaxesbeforeDonations; NetIncomeAfterTaxesbeforeDonations)
            {
            }
            column(NetIncomeAfterTaxesandDonations; NetIncomeAfterTaxesandDonations)
            {
            }
            column(FinancialIncome; FinancialIncome)
            {
            }

            trigger OnAfterGetRecord()
            begin

                InterestonLoanPortfolio := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Form2F(Statement of C Income)", '%1', GLAccount."form2f(statement of c income)"::InterestonLoanPortfolio);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", DateFilter);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            InterestonLoanPortfolio += -1 * GLEntry.Amount;
                        end;

                    until GLAccount.Next = 0;
                end;
                //fees and commision on loan portfolio
                FeesCommissiononLoanPortfolio := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Form2F(Statement of C Income)", '%1', GLAccount."form2f(statement of c income)"::FeesCommissiononLoanPortfolio);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", DateFilter);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            FeesCommissiononLoanPortfolio += -1 * GLEntry.Amount;
                        end;

                    until GLAccount.Next = 0;
                end;
                //gov securities
                GovernmentSecurities := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Form2F(Statement of C Income)", '%1', GLAccount."form2f(statement of c income)"::GovernmentSecurities);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", DateFilter);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            GovernmentSecurities += GLEntry.Amount;
                        end;

                    until GLAccount.Next = 0;
                end;
                //investment incompany shares
                InvestmentinCompaniesshares := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Form2F(Statement of C Income)", '%1', GLAccount."form2f(statement of c income)"::InvestmentinCompaniesshares);
                if GLAccount.FindSet then begin

                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", DateFilter);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            InvestmentinCompaniesshares += -1 * GLEntry.Amount;
                        end;

                    until GLAccount.Next = 0;
                end;
                //nterestExpenseonDeposits
                nterestExpenseonDeposits := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Form2F(Statement of C Income)", '%1', GLAccount."form2f(statement of c income)"::nterestExpenseonDeposits);
                if GLAccount.FindSet then begin
                    repeat

                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", DateFilter);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            nterestExpenseonDeposits += GLEntry.Amount;
                        end;

                    until GLAccount.Next = 0;
                end;

                //dividend expenses
                DividendExpenses := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Form2F(Statement of C Income)", '%1', GLAccount."form2f(statement of c income)"::DividendExpenses);
                if GLAccount.FindSet then begin
                    repeat

                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", DateFilter);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            DividendExpenses += GLEntry.Amount;
                        end;

                    until GLAccount.Next = 0;
                end;

                //Other Financial Expense
                OtherFinancialExpense := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Form2F1(Statement of C Income)", '%1', GLAccount."Form2F1(Statement of C Income)"::OtherFinancialExpense);
                if GLAccount.FindSet then begin
                    repeat

                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", DateFilter);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            OtherFinancialExpense += GLEntry.Amount;
                        end;

                    until GLAccount.Next = 0;
                end;

                //Fees & Commission Expense
                FeesCommissionExpense := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Form2F(Statement of C Income)", '%1', GLAccount."form2f(statement of c income)"::FeesCommissionExpense);
                if GLAccount.FindSet then begin
                    repeat

                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", DateFilter);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            FeesCommissionExpense += GLEntry.Amount;
                        end;

                    until GLAccount.Next = 0;
                end;

                //Other Expense
                OtherExpense := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Form2F(Statement of C Income)", '%1', GLAccount."form2f(statement of c income)"::OtherExpense);
                if GLAccount.FindSet then begin
                    repeat

                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", DateFilter);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            OtherExpense += GLEntry.Amount;
                        end;

                    until GLAccount.Next = 0;
                end;

                //Provision for Loan Losses
                ProvisionforLoanLosses := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Form2F(Statement of C Income)", '%1', GLAccount."form2f(statement of c income)"::ProvisionforLoanLosses);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", DateFilter);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            ProvisionforLoanLosses += GLEntry.Amount;
                        end;

                    until GLAccount.Next = 0;
                end;
                //Personnel Expenses
                PersonnelExpenses := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Form2F1(Statement of C Income)", '%1', GLAccount."form2f1(statement of c income)"::PersonnelExpenses);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", DateFilter);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            PersonnelExpenses += GLEntry.Amount;
                        end;

                    until GLAccount.Next = 0;
                end;
                //Governance Expenses
                GovernanceExpenses := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Form2F1(Statement of C Income)", '%1', GLAccount."form2f1(statement of c income)"::GovernanceExpenses);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", DateFilter);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            GovernanceExpenses += GLEntry.Amount;
                        end;

                    until GLAccount.Next = 0;
                end;

                //Marketing Expenses
                MarketingExpenses := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Form2F1(Statement of C Income)", '%1', GLAccount."form2f1(statement of c income)"::MarketingExpenses);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", DateFilter);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            MarketingExpenses += GLEntry.Amount;
                        end;

                    until GLAccount.Next = 0;
                end;
                //DepreciationandAmortizationCharges
                DepreciationandAmortizationCharges := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Form2F1(Statement of C Income)", '%1', GLAccount."form2f1(statement of c income)"::DepreciationandAmortizationCharges);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", DateFilter);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            DepreciationandAmortizationCharges += GLEntry.Amount;
                        end;

                    until GLAccount.Next = 0;
                end;
                //AdministrativeExpenses
                AdministrativeExpenses := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Form2F1(Statement of C Income)", '%1', GLAccount."form2f1(statement of c income)"::AdministrativeExpenses);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", DateFilter);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            AdministrativeExpenses += GLEntry.Amount;
                        end;

                    until GLAccount.Next = 0;
                end;

                //taxes
                // Taxes := 0;
                // Taxes := 0.15 * InvestmentinCompaniesshares;

                /*  GLAccount.RESET;
                 GLAccount.SETFILTER(GLAccount."Form2F1(Statement of C Income)",'%1',GLAccount."Form2F1(Statement of C Income)"::Taxes);
                 IF GLAccount.FINDSET THEN BEGIN
                  REPEAT
                    GLEntry.RESET;
                    GLEntry.SETRANGE(GLEntry."G/L Account No.",GLAccount."No.");
                    GLEntry.SETFILTER(GLEntry."Posting Date",DateFilter);
                    IF GLEntry.FINDSET THEN BEGIN
                      GLEntry.CALCSUMS(Amount);
                      Taxes+=GLEntry.Amount;
                      END;
                
                  UNTIL GLAccount.NEXT = 0;
                  END;*/

                //nonoperating incomes
                Taxes := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Form2F1(Statement of C Income)", '%1', GLAccount."form2f1(statement of c income)"::NonOperatingIncome);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", DateFilter);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            NonOperatingIncome += -1 * GLEntry.Amount;
                        end;

                    until GLAccount.Next = 0;
                end;
                //nonoperating expense
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Form2F1(Statement of C Income)", '%1', GLAccount."form2f1(statement of c income)"::NonOperatingExpense);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", DateFilter);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            NonOperatingExpense += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                end;

                MemberDeposits := 0;

                SaccoGen.Get();
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.StatementOfFP2, '%1', GLAccount.StatementOfFP2::Nonwithdrawabledeposits);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', AsAt);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            MemberDeposits += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                end;

                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.StatementOfFP2, '%1', GLAccount.StatementOfFP2::ShareCapital);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', AsAt);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            Sharecapital += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                end;
                Taxpaid := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Form2F1(Statement of C Income)", '%1', GLAccount."Form2F1(Statement of C Income)"::NonOperatingExpense);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', AsAt);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            Taxpaid += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                end;

                SaccoGen.Get();
                nterestExpenseonDeposits := -((MemberDeposits * SaccoGen."Interest on Deposits (%)") * 0.01);//"Interest On Current Shares") * 0.01);
                DividendExpenses := -((Sharecapital * SaccoGen."Share Interest (%)") * 0.01);// "Interest on Share Capital(%)") * 0.01);

                NetFinancialIncomeLoss := 0;
                FinancialIncome := 0;
                NetOperatingIncome := 0;
                FinancialExpense := 0;
                OperatingExpenses := 0;
                NetNonOperatingIncomeExpense := 0;
                Taxes := 0;
                FinancialIncomefromLoansPortfolio := 0;
                FinancialIncomefromInvestments := InvestmentinCompaniesshares + EquityInvestmentsinsubsidiaries + PlacementinBanks + Derivatives + CollectiveinvestmentSchemes + GovernmentSecurities + CommercialPapers;
                FinancialIncomefromLoansPortfolio := InterestonLoanPortfolio + FeesCommissiononLoanPortfolio;
                FinancialExpense := (DividendExpenses + nterestExpenseonDeposits + OtherFinancialExpense + OtherExpense + FeesCommissionExpense + CostofExternalBorrowings);
                NetNonOperatingIncomeExpense := NonOperatingIncome - NonOperatingExpense;
                FinancialIncome := FinancialIncomefromLoansPortfolio + FinancialIncomefromInvestments;
                NetFinancialIncomeLoss := FinancialIncome - FinancialExpense;
                AllowanceforLoanLoss := ProvisionforLoanLosses + ValueofLoansRecovered;
                OperatingExpenses := GovernanceExpenses + PersonnelExpenses + MarketingExpenses + AdministrativeExpenses + DepreciationandAmortizationCharges;// + OtherFinancialExpense;
                NetOperatingIncome := NetFinancialIncomeLoss - AllowanceforLoanLoss - OperatingExpenses;
                NetIncomeBeforeTaxesandDonations := NetOperatingIncome + NetNonOperatingIncomeExpense;
                Taxes := (-((InvestmentinCompaniesshares * 0.50) * 0.30));
                Taxes := Taxes + Taxpaid;
                NetIncomeAfterTaxesbeforeDonations := NetIncomeBeforeTaxesandDonations + Taxes;
                NetIncomeAfterTaxesandDonations := NetIncomeAfterTaxesbeforeDonations - Donations;

            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(AsAt; AsAt)
                {
                    ApplicationArea = Basic;
                    Caption = 'AsAt';
                }
            }
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
        /*DateFilter:='..'+FORMAT(AsAt);
        Date:=CALCDATE('-CY',TODAY);
        
        DateFilter11:=FORMAT(Date)+'..'+FORMAT(AsAt);
        FinancialYear:=DATE2DMY(Date,3);*/

        Date := CalcDate('-CY', AsAt);
        DateFilter := Format(Date) + '..' + Format(AsAt);
        DateFilter11 := Format(Date) + '..' + Format(AsAt);
        FinancialYear := Date2dmy(AsAt, 3);

    end;

    var
        MemberDeposits: Decimal;
        Sharecapital: Decimal;
        FinancialIncome: Decimal;
        Taxpaid: Decimal;
        AsAt: Date;
        DateFilter: Text;
        Date: Date;
        DateFilter11: Text;
        FinancialYear: Integer;
        InterestonLoanPortfolio: Decimal;
        MemberLedgerEntry: Record "Cust. Ledger Entry";
        FeesCommissiononLoanPortfolio: Decimal;
#pragma warning disable AL0275
        GLAccount: Record "G/L Account";
#pragma warning restore AL0275
#pragma warning disable AL0275
        GLEntry: Record "G/L Entry";
#pragma warning restore AL0275
        GovernmentSecurities: Decimal;
        InvestmentinCompaniesshares: Decimal;
        EquityInvestmentsinsubsidiaries: Decimal;
        Derivatives: Decimal;
        CollectiveinvestmentSchemes: Decimal;
        CommercialPapers: Decimal;
        PlacementinBanks: Decimal;
        nterestExpenseonDeposits: Decimal;
        CostofExternalBorrowings: Decimal;
        DividendExpenses: Decimal;
        OtherFinancialExpense: Decimal;
        FeesCommissionExpense: Decimal;
        OtherExpense: Decimal;
        ProvisionforLoanLosses: Decimal;
        ValueofLoansRecovered: Decimal;
        PersonnelExpenses: Decimal;
        GovernanceExpenses: Decimal;
        MarketingExpenses: Decimal;
        DepreciationandAmortizationCharges: Decimal;
        AdministrativeExpenses: Decimal;
        NonOperatingIncome: Decimal;
        NonOperatingExpense: Decimal;
        Donations: Decimal;
        Taxes: Decimal;
        FinancialIncomefromLoansPortfolio: Decimal;
        FinancialExpense: Decimal;
        NetFinancialIncomeLoss: Decimal;
        NetNonOperatingIncomeExpense: Decimal;
        FinancialIncomefromInvestments: Decimal;
        AllowanceforLoanLoss: Decimal;
        OperatingExpenses: Decimal;
        NetOperatingIncome: Decimal;
        NetIncomeBeforeTaxesandDonations: Decimal;
        NetIncomeAfterTaxesbeforeDonations: Decimal;
        NetIncomeAfterTaxesandDonations: Decimal;

        SaccoGen: Record "Sacco General Set-Up";
}

