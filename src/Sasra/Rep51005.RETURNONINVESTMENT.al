#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51005 "RETURN ON INVESTMENT"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/RETURN ON INVESTMENT.rdlc';
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
            column(name; Company.Name)
            {
            }
            column(CoreCapital; CoreCapitalOld)
            {
            }
            column(TotalAssets; TotalAssets)
            {
            }
            column(TotalDeposits; TotalDeposits)
            {
            }
            column(Nonearningassets; Nonearningassets)
            {
            }
            column(FinancialAssets; FinancialAssets)
            {
            }
            column(SubsidiaryandRelated; SubsidiaryandRelated)
            {
            }
            column(Equityinvestment; Equityinvestment)
            {
            }
            column(Otherinvestments; Otherinvestments)
            {
            }
            column(LandBuilding; LandBuilding)
            {
            }
            column(OtherassetsLandBuilding; OtherassetsLandBuilding)
            {
            }
            column(LandBuildingstoAssetsRatio; LandBuildingstoAssetsRatio)
            {
            }
            column(MaxLandBuildingtoAssetrequirement; MaxLandBuildingtoAssetrequirement)
            {
            }
            column(Excessdeficiency2; Excessdeficiency2)
            {
            }
            column(FinancialinvestmentstoCorecapital; FinancialinvestmentstoCorecapital)
            {
            }
            column(MaximumfinancialinvestmentstoCorecapital; MaximumfinancialinvestmentstoCorecapital)
            {
            }
            column(ExcessCoreCapital; ExcessCoreCapital)
            {
            }
            column(EquityinvestmentstoCoreCapitalRatio; EquityinvestmentstoCoreCapitalRatio)
            {
            }
            column(MaxfinancialinvestmentstoTotalDepositsliablitiesRatio; MaxfinancialinvestmentstoTotalDepositsliablitiesRatio)
            {
            }
            column(ExcessEquity; ExcessEquity)
            {
            }
            column(SubsidiaryrelatedentityinvestmenttoCoreCapitalRatio; SubsidiaryrelatedentityinvestmenttoCoreCapitalRatio)
            {
            }
            column(MaximumSubsidiaryinvestmenttoTotalassetsRatio; MaximumSubsidiaryinvestmenttoTotalassetsRatio)
            {
            }
            column(ExcessSubsidiary; ExcessSubsidiary)
            {
            }
            column(OtherinvestmentstoCoreCapitalRatio; OtherinvestmentstoCoreCapitalRatio)
            {
            }
            column(MaximumOtherinvestmentstoCoreCapital; MaximumOtherinvestmentstoCoreCapital)
            {
            }
            column(ExcessOtherInvestment; ExcessOtherInvestment)
            {
            }
            column(MaxLandBuildingtoAssetrequirementNew; MaxLandBuildingtoAssetrequirementNew)
            {
            }
            column(LandBuildingEquipmentNew; LandBuildingEquipmentNew)
            {
            }
            column(Excessdeficiency3; Excessdeficiency3)
            {
            }

            trigger OnAfterGetRecord()
            begin

                // CoreCapital
                CoreCapital := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Form2E(investment)", '%1', GLAccount."form2e(investment)"::Core_Capital);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', AsAt);
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            CoreCapitalOld += GLEntry.Amount * -1;
                        end
                    until GLAccount.Next = 0;
                    //Message('Corecapital is %1', CoreCapitalOld);

                end;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Capital adequecy", '%1', GLAccount."capital adequecy"::NetSurplusaftertax);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', AsAt);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            NetSurplusaftertax += (GLEntry.Amount * 50 / 100) * -1;
                        end;
                    until GLAccount.Next = 0;

                end;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Capital adequecy", '%1', GLAccount."capital adequecy"::InvestmentsinSubsidiary);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', AsAt);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            InvestmentsinSubsidiary += GLEntry.Amount;
                        end;

                    until GLAccount.Next = 0;

                end;
                CoreCapital := CoreCapitalOld + NetSurplusaftertax - InvestmentsinSubsidiary;
                //non earning assets

                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Form2E(investment)New", '%1', GLAccount."form2e(investment)new"::Nonearningassets);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', AsAt);
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            Nonearningassets += GLEntry.Amount;
                        end
                    until GLAccount.Next = 0;

                end;

                //land
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Form2E(investment)Land", '%1', GLAccount."form2e(investment)land"::LandBuilding);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', AsAt);
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LandBuilding += GLEntry.Amount;
                        end
                    until GLAccount.Next = 0;

                end;

                //TotalAssets
                TotalAssets := 0;
                GLAccount.Reset;
                GLAccount.SetRange(GLAccount."No.", '199999');//14300
                GLAccount.SetFilter(GLAccount."Date Filter", '<=%1', AsAt);
                if GLAccount.FindSet then begin
                    GLAccount.CalcFields(GLAccount."Net Change");
                    TotalAssets := TotalAssets + GLAccount."Net Change";
                end;
                //MESSAGE(FORMAT(TotalAssets));

                //deposits
                TotalDeposits := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Form2E(investment)", '%1', GLAccount."form2e(investment)"::totaldeposits);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', AsAt);
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            TotalDeposits += GLEntry.Amount * -1;
                        end
                    until GLAccount.Next = 0;

                end;

                //subsidiarty
                SubsidiaryandRelated := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Form2E(investment)", '%1', GLAccount."form2e(investment)"::subsidiaryandrelatedentities);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', AsAt);
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            SubsidiaryandRelated += GLEntry.Amount;
                        end
                    until GLAccount.Next = 0;

                end;


                //equity
                Equityinvestment := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Form2E(investment)", '%1', GLAccount."form2e(investment)"::Equityinvestment);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', AsAt);
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            Equityinvestment += GLEntry.Amount;
                        end
                    until GLAccount.Next = 0;

                end;
                Otherinvestments := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Form2E(investment)", '%1', GLAccount."form2e(investment)"::Otherinvestments);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', AsAt);
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            Otherinvestments += GLEntry.Amount;
                        end
                    until GLAccount.Next = 0;

                end;

                //other asssets
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Form2E(investment)", '%1', GLAccount."form2e(investment)"::otherassets);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', AsAt);
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            OtherassetsLandBuilding += GLEntry.Amount;
                        end
                    until GLAccount.Next = 0;

                end;
                //MESSAGE('%1',CoreCapital);
                FinancialAssets := Equityinvestment + SubsidiaryandRelated + Otherinvestments;
                if (OtherassetsLandBuilding > 0) and (TotalAssets > 0) then
                    LandBuildingEquipmentNew := OtherassetsLandBuilding / TotalAssets;
                if (LandBuilding > 0) and (TotalAssets > 0) then
                    LandBuildingstoAssetsRatio := LandBuilding / TotalAssets;
                //MESSAGE(FORMAT(LandBuildingstoAssetsRatio));
                MaxLandBuildingtoAssetrequirement := 0.1;
                MaxLandBuildingtoAssetrequirementNew := 0.05;

                Excessdeficiency2 := LandBuildingEquipmentNew - MaxLandBuildingtoAssetrequirement;

                Excessdeficiency3 := LandBuildingstoAssetsRatio - MaxLandBuildingtoAssetrequirementNew;
                if (FinancialAssets > 0) and (CoreCapital > 0) then
                    FinancialinvestmentstoCorecapital := FinancialAssets / CoreCapitalOld;
                MaximumfinancialinvestmentstoCorecapital := 0.4;
                ExcessCoreCapital := FinancialinvestmentstoCorecapital - MaximumfinancialinvestmentstoCorecapital;
                if (Equityinvestment > 0) and (CoreCapital > 0) then
                    EquityinvestmentstoCoreCapitalRatio := Equityinvestment / CoreCapitalOld;
                MaxfinancialinvestmentstoTotalDepositsliablitiesRatio := 0.2;
                ExcessEquity := EquityinvestmentstoCoreCapitalRatio - MaxfinancialinvestmentstoTotalDepositsliablitiesRatio;
                if (SubsidiaryandRelated > 0) and (CoreCapital > 0) then
                    SubsidiaryrelatedentityinvestmenttoCoreCapitalRatio := SubsidiaryandRelated / CoreCapitalOld;
                MaximumSubsidiaryinvestmenttoTotalassetsRatio := 0.5;
                ExcessSubsidiary := SubsidiaryrelatedentityinvestmenttoCoreCapitalRatio - MaximumSubsidiaryinvestmenttoTotalassetsRatio;
                if (SubsidiaryandRelated > 0) and (CoreCapital > 0) then
                    OtherinvestmentstoCoreCapitalRatio := Otherinvestments / CoreCapitalOld;
                MaximumOtherinvestmentstoCoreCapital := 0.3;
                ExcessOtherInvestment := OtherinvestmentstoCoreCapitalRatio - MaximumOtherinvestmentstoCoreCapital;
                //MESSAGE('%1|%2|%3',Equityinvestment,CoreCapital,EquityinvestmentstoCoreCapitalRatio);
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
        Date := CalcDate('-CY', AsAt);
        DateFilter := Format(Date) + '..' + Format(AsAt);
        DateFilter11 := Format(Date) + '..' + Format(AsAt);
        FinancialYear := Date2dmy(AsAt, 3);
    end;

    var
        AsAt: Date;
        StartDate: Date;
        CoreCapitalOld: Decimal;
        InvestmentsinSubsidiary: Decimal;
        Date: Date;
        DateFilter11: Text;
        FinancialYear: Integer;
        CurrentYearFilter: Text;
        NetSurplusaftertax: Decimal;
        CoreCapital: Decimal;
#pragma warning disable AL0275
        GLAccount: Record "G/L Account";
#pragma warning restore AL0275
#pragma warning disable AL0275
        GLEntry: Record "G/L Entry";
#pragma warning restore AL0275
        DateFilter: Text;
        TotalAssets: Decimal;
        TotalDeposits: Decimal;
        Nonearningassets: Decimal;
        FinancialAssets: Decimal;
        SubsidiaryandRelated: Decimal;
        Equityinvestment: Decimal;
        Otherinvestments: Decimal;
        LandBuilding: Decimal;
        OtherassetsLandBuilding: Decimal;
        FinancialAssets1: Decimal;
        LandBuildingstoAssetsRatio: Decimal;
        MaxLandBuildingtoAssetrequirement: Decimal;
        Excessdeficiency2: Decimal;
        FinancialinvestmentstoCorecapital: Decimal;
        MaximumfinancialinvestmentstoCorecapital: Decimal;
        ExcessCoreCapital: Decimal;
        EquityinvestmentstoCoreCapitalRatio: Decimal;
        MaxfinancialinvestmentstoTotalDepositsliablitiesRatio: Decimal;
        ExcessEquity: Decimal;
        SubsidiaryrelatedentityinvestmenttoCoreCapitalRatio: Decimal;
        MaximumSubsidiaryinvestmenttoTotalassetsRatio: Decimal;
        ExcessSubsidiary: Decimal;
        OtherinvestmentstoCoreCapitalRatio: Decimal;
        MaximumOtherinvestmentstoCoreCapital: Decimal;
        ExcessOtherInvestment: Decimal;
        MaxLandBuildingtoAssetrequirementNew: Decimal;
        LandBuildingEquipmentNew: Decimal;
        Excessdeficiency3: Decimal;
}

