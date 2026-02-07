#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50003 Liquidity
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Liquidity.rdlc';
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
            column(Name; Company.Name)
            {
            }
            column(Date; Date)
            {
            }
            column(AsAt; AsAt)
            {
            }
            column(BeginDate; BeginDate)
            {
            }
            column(FinancialYear; FinancialYear)
            {
            }
            column(LocalNotes; LocalNotes)
            {
            }
            column(ForeignNotes; ForeignNotes)
            {
            }
            column(BalanceswithCommercialBanks; BalanceswithCommercialBanks)
            {
            }
            column(TimeDeposits; TimeDeposits)
            {
            }
            column(OverdraftsandMatured; OverdraftsandMatured)
            {
            }
            column(BalanceswithotherSaccoSocieties; BalanceswithotherSaccoSocieties)
            {
            }
            column(BalanceswithotherFinancialInstitutions; BalanceswithotherFinancialInstitutions)
            {
            }
            column(BalancesDuetootherSaccosocieties; BalancesDuetootherSaccosocieties)
            {
            }
            column(BalancesduetoFinanciaInstitutions; BalancesduetoFinanciaInstitutions)
            {
            }
            column(MaturedLoansandAdvances; MaturedLoansandAdvances)
            {
            }
            column(TreasuryBills; TreasuryBills)
            {
            }
            column(TreasuryBonds; TreasuryBonds)
            {
            }
            column(NETLIQUIDASSETS; NETLIQUIDASSETS)
            {
            }
            column(MaturedLiabilities; MaturedLiabilities)
            {
            }
            column(LiabilitiesMaturingwithin91Days; LiabilitiesMaturingwithin91Days)
            {
            }
            column(TotalOtherliabilities; TotalOtherliabilities)
            {
            }
            column(TotalOtherliabilitiesNew; TotalOtherliabilitiesNew)
            {
            }
            column(Ratio; Ratio)
            {
            }
            column(Minumholding; Minumholding)
            {
            }
            column(Excess; Excess)
            {
            }

            trigger OnAfterGetRecord()
            begin
                LocalNotes := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Liquidity, '%1', GLAccount.Liquidity::LocalNotes);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        //GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', AsAt);
                        GLEntry.SETFILTER(GLEntry."Posting Date", DateFilter);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LocalNotes += GLEntry.Amount;
                        end;

                    until GLAccount.Next = 0;


                end;
                BalanceswithCommercialBanks := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Liquidity, '%1', GLAccount.Liquidity::BankBalances);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', AsAt);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            BalanceswithCommercialBanks += GLEntry.Amount;
                        end;

                    until GLAccount.Next = 0;

                end;

                //gov securities
                TreasuryBills := 0;
                TreasuryBonds := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Liquidity, '%1', GLAccount.Liquidity::GovSecuritiesBankBalances);
                if GLAccount.FindSet then begin
                    repeat

                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', AsAt);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            TreasuryBills += GLEntry.Amount;
                        end;

                    until GLAccount.Next = 0;

                end;
                //balances with other financial institution
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Liquidity, '%1', GLAccount.Liquidity::balanceswithotherfinancialinsti);
                if GLAccount.FindSet then begin
                    repeat

                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', AsAt);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            BalanceswithotherFinancialInstitutions += GLEntry.Amount;
                        end;

                    until GLAccount.Next = 0;

                end;//20199

                //time deposits
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Liquidity, '%1', GLAccount.Liquidity::TimeDeposits);
                if GLAccount.FindSet then begin
                    repeat

                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', AsAt);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            TimeDeposits += GLEntry.Amount;
                        end;

                    until GLAccount.Next = 0;
                end;

                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.Liquidity, '%1', GLAccount.Liquidity::TotalOtherliabilitiesNew);
                if GLAccount.FindSet then begin
                    repeat

                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', AsAt);

                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            TotalOtherliabilitiesNew += GLEntry.Amount;
                        end;

                    until GLAccount.Next = 0;

                end;
                /* 
                                NETLIQUIDASSETS := LocalNotes + ForeignNotes + BalancesduetoFinanciaInstitutions + BalancesDuetootherSaccosocieties + BalanceswithCommercialBanks + BalanceswithotherFinancialInstitutions + BalanceswithotherSaccoSocieties + TreasuryBills + TreasuryBonds + TimeDeposits
                                  + OverdraftsandMatured;
                                TotalOtherliabilitiesNew := LiabilitiesMaturingwithin91Days + MaturedLiabilities;
                                TotalOtherliabilities := MaturedLiabilities + TotalOtherliabilitiesNew;
                                Ratio := (NETLIQUIDASSETS / TotalOtherliabilitiesNew);
                                Minumholding := 0.1;
                                Excess := Ratio - Minumholding; */
                NETLIQUIDASSETS := LocalNotes + ForeignNotes + BalanceswithCommercialBanks - TimeDeposits + BalanceswithotherFinancialInstitutions + BalanceswithotherSaccoSocieties - BalancesduetoFinanciaInstitutions - BalancesDuetootherSaccosocieties
+ OverdraftsandMatured;
                TotalOtherliabilities := MaturedLiabilities + LiabilitiesMaturingwithin91Days + TotalOtherliabilitiesNew;
                Ratio := (NETLIQUIDASSETS / TotalOtherliabilitiesNew);
                Minumholding := 0.1;
                Excess := Ratio - Minumholding;
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
                    Caption = 'As At';
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

        /*BeginDate:=CALCDATE('-CY',AsAt);
        FinancialYear:=DATE2DMY(BeginDate,3);
        DateFilter:='..'+FORMAT(AsAt);*/

        Date := CalcDate('-CY', AsAt);
        DateFilter := Format(Date) + '..' + Format(AsAt);
        DateFilter11 := Format(Date) + '..' + Format(AsAt);
        FinancialYear := Date2dmy(AsAt, 3);

    end;

    var
        AsAt: Date;
        Date: Date;
        DateFilter11: Text;
        FinancialYear: Integer;
        BeginDate: Date;
#pragma warning disable AL0275
        GLEntry: Record "G/L Entry";
#pragma warning restore AL0275
#pragma warning disable AL0275
        GLAccount: Record "G/L Account";
#pragma warning restore AL0275
        LocalNotes: Decimal;
        ForeignNotes: Decimal;
        BalanceswithCommercialBanks: Decimal;
        TimeDeposits: Decimal;
        DateFilter: Text;
        OverdraftsandMatured: Decimal;
        BalanceswithotherSaccoSocieties: Decimal;
        BalanceswithotherFinancialInstitutions: Decimal;
        BalancesDuetootherSaccosocieties: Decimal;
        BalancesduetoFinanciaInstitutions: Decimal;
        MaturedLoansandAdvances: Decimal;
        TreasuryBills: Decimal;
        TreasuryBonds: Decimal;
        NETLIQUIDASSETS: Decimal;
        MaturedLiabilities: Decimal;
        LiabilitiesMaturingwithin91Days: Decimal;
        TotalOtherliabilities: Decimal;
        TotalOtherliabilitiesNew: Decimal;
        Ratio: Decimal;
        Minumholding: Decimal;
        Excess: Decimal;
}

