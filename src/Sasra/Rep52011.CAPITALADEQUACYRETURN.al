#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52011 "CAPITAL ADEQUACY RETURN"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/CAPITAL ADEQUACY RETURN.rdlc';
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
            column(FinancialYear; FinancialYear)
            {
            }
            column(AsAt; AsAt)
            {
            }
            column(Date; Date)
            {
            }
            column(ShareCapital; ShareCapital)
            {
            }
            column(StatutoryReserve; StatutoryReserve)
            {
            }
            column(Otherreserves; Otherreserves)
            {
            }
            column(retainedEarnins; retainedEarnins)
            {
            }
            column(NetSurplusaftertax; NetSurplusaftertax)
            {
            }
            column(LoansandAdvances; LoansandAdvances)
            {
            }
            column(totalassetsPBSheet; totalassetsPBSheet)
            {
            }
            column(Cash; Cash)
            {
            }
            column(PropertyandEquipment; PropertyandEquipment)
            {
            }
            column(GovernmentSecurities; GovernmentSecurities)
            {
            }
            column(DepositsandBalancesatOtherInstitutions; DepositsandBalancesatOtherInstitutions)
            {
            }
            column(Otherassets; Otherassets)
            {
            }
            column(CapitalGrants; CapitalGrants)
            {
            }
            column(InvestmentsinSubsidiary; InvestmentsinSubsidiary)
            {
            }
            column(OFFBALANCESHEETASSETS; OFFBALANCESHEETASSETS)
            {
            }
            column(TOTALOnBalanceSheet; TOTALOnBalanceSheet)
            {
            }
            column(Kuscoshares; Kuscoshares)
            {
            }
            column(OtherDeductions; OtherDeductions)
            {
            }
            column(Sub_Total; Sub_Total)
            {
            }
            column(TotalDeductions; TotalDeductions)
            {
            }
            column(CORECAPITAL; CORECAPITAL)
            {
            }
            column(RetainedearningsandDisclosedreserves; RetainedearningsandDisclosedreserves)
            {
            }
            column(TotalAssets; TotalAssets)
            {
            }
            column(TotalDepositsLiabilities; TotalDepositsLiabilities)
            {
            }
            column(CorecapitaltoAssetsRatio; CorecapitaltoAssetsRatio)
            {
            }
            column(MinimumCoreCapitaltoAssetsRatioRequirement; MinimumCoreCapitaltoAssetsRatioRequirement)
            {
            }
            column(Excess1; Excess1)
            {
            }
            column(RetainedearningsanddisclosedreservestoCorecapital; RetainedearningsanddisclosedreservestoCorecapital)
            {
            }
            column(MinimumRetainedearningsanddisclosed; MinimumRetainedearningsanddisclosed)
            {
            }
            column(Excess2; Excess2)
            {
            }
            column(Netsurplus; Netsurplus) { }
            column(CorecapitatoDepositsRatio; CorecapitatoDepositsRatio)
            {
            }
            column(MinimumCoreCapitaltoDeposits; MinimumCoreCapitaltoDeposits)
            {
            }
            column(Excess; Excess)
            {
            }
            column(investment; investment)
            {
            }
            column(DifferenceNew; DifferenceNew)
            {
            }

            trigger OnAfterGetRecord()
            begin

                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Capital adequecy", '%1', GLAccount."capital adequecy"::ShareCapital);
                if GLAccount.FindSet then begin
                    repeat
                        ShareCapitalValue := 0;
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', AsAt);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            ShareCapitalValue := GLEntry.Amount * -1;
                        end;
                        ShareCapital := ShareCapital + ShareCapitalValue + 396369;//control bal account 200107 Const

                    until GLAccount.Next = 0;

                end;

                // statutory reserve
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Capital adequecy", '%1', GLAccount."capital adequecy"::StatutoryReserve);
                if GLAccount.FindSet then begin
                    repeat
                        ShareCapitalValue := 0;
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', AsAt);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            StatutoryReserve += GLEntry.Amount * -1;
                        end;

                    until GLAccount.Next = 0;
                    //Message('Statutory Reserve of %1', StatutoryReserve);

                end;
                //retained earnings
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Capital adequecy", '%1', GLAccount."capital adequecy"::RetainedEarnings);
                if GLAccount.FindSet then begin
                    repeat
                        ShareCapitalValue := 0;
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', AsAt);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            retainedEarnins += GLEntry.Amount * -1;
                        end;

                    until GLAccount.Next = 0;

                end;

                //current year surplus
                NetSurplusaftertax := 0;
                GLAccount.Reset;
                GLAccount.SetRange(GLAccount."No.", '599999');//'599999'GLAccount."No."
                GLAccount.SetFilter(GLAccount."Date Filter", '<=%1', AsAt);
                if GLAccount.FindSet then begin
                    GLAccount.CalcFields(GLAccount."Net Change");
                    NetSurplusaftertax := (NetSurplusaftertax + GLAccount."Net Change");
                end;

                // GLEntry.RESET;
                // GLEntry.SETRANGE(GLEntry."G/L Account No.", GLAccount."No.");
                // GLEntry.SETFILTER(GLEntry."Posting Date", '<=%1', AsAt);
                // IF GLEntry.FINDSET THEN BEGIN
                //     GLEntry.CALCSUMS(Amount);
                //     NetSurplusaftertax += GLEntry.Amount * -1;
                // END;


                MESSAGE('NetSurplusaftertax %1', NetSurplusaftertax / 2);
                // GLAccount.RESET;
                // GLAccount.SETRANGE(GLAccount."No.",'202450');
                // GLAccount.SETFILTER(GLAccount."Date Filter",Datefilter);
                // GLAccount.SETAUTOCALCFIELDS(Balance);
                // IF GLAccount.FINDSET THEN BEGIN
                //
                //  REPEAT
                //    NetSurplusaftertax+=(GLAccount.Balance*50/100)*-1;
                //    UNTIL GLAccount.NEXT = 0;
                //
                //  END;

                //Loans and Advances
                LoansRegister.RESET;
                //LoansRegister.SETFILTER(LoansRegister."Date filter", Datefilter);
                LoansRegister.SETAUTOCALCFIELDS("Outstanding Balance");
                LoansRegister.SetFilter(LoansRegister."Outstanding Balance", '>%1', 0);
                IF LoansRegister.FINDSET THEN BEGIN
                    REPEAT
                        LoansandAdvances += LoansRegister."Outstanding Balance";
                    UNTIL LoansRegister.NEXT = 0;

                END;
                //Message('[LoanAdvances is %1]', LoansandAdvances);


                //allowance for loan loss
                AllowanceforLoanLoss := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.StatementOfFP, '%1', GLAccount.Statementoffp::AllowanceforLoanLoss);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', Asat);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            AllowanceforLoanLoss += -GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                    //Message('AllowanceforLoanLoss %1', AllowanceforLoanLoss);

                end;
                /* GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Capital adequecy", '%1', GLAccount."capital adequecy"::LoansandAdvances);
                if GLAccount.FindSet then begin
                    repeat
                        ShareCapitalValue := 0;
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        //GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', AsAt);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LoansandAdvances += GLEntry.Amount;
                        end;

                    until GLAccount.Next = 0;
                    Message('Loans and advances %1', LoansandAdvances);

                end;
                 */
                LoansandAdvances := LoansandAdvances - AllowanceforLoanLoss;
                //total assets as per the balance sheet
                totalassetsPBSheet := 0;
                GLAccount.Reset;
                GLAccount.SetRange(GLAccount."No.", '199999');//'14300'
                GLAccount.SetFilter(GLAccount."Date Filter", '<=%1', AsAt);
                if GLAccount.FindSet then begin
                    GLAccount.CalcFields(GLAccount."Net Change", GLAccount.Balance);//"Net Change"
                    totalassetsPBSheet := totalassetsPBSheet + GLAccount.Balance;
                    totalassetsPBSheet2 := totalassetspbsheet2 + glaccount."Net Change";
                end;
                //Message('totalassetsPBSheet is %1, with balance is %2', totalassetsPBSheet, totalassetsPBSheet2);
                GLAccount.Reset;
                GLAccount.SetRange(GLAccount."No.", '101066');

                if GLAccount.FindSet() then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', AsAt);

                        GLEntry.CalcSums(Amount);
                        Cash += GLEntry.Amount;
                    UNTIL GLAccount.Next() = 0;

                    Message('Cash -> %1', Cash);
                end;


                //INVESTMENT IN SUBSIDIARY
                InvestmentsinSubsidiary := 0;
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
                    //Message('InvestmentsinSubsidiary is %1', Investmentsinsubsidiary);

                end;


                //KUSCO SHARES
                Kuscoshares := 0;
                GLAccount.Reset;
                GLAccount.SetRange(GLAccount."No.", '100661');//Shares in Kusco ltd.
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', AsAt);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            Kuscoshares += GLEntry.Amount;
                        end;

                    until GLAccount.Next = 0;

                end;

                //Other reserves
                Otherreserves := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Capital adequecy", '%1', GLAccount."capital adequecy"::Otherreserves);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', AsAt);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            Otherreserves += GLEntry.Amount * -1;//
                        end;

                    until GLAccount.Next = 0;
                    //Message('Other reserves is %1', Otherreserves);

                end;

                //gov securities
                GovernmentSecurities := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Capital adequecy", '%1', GLAccount."capital adequecy"::GovernmentSecurities);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', AsAt);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            GovernmentSecurities += GLEntry.Amount;
                        end;

                    until GLAccount.Next = 0;
                    //Message('Government Securities %1', GovernmentSecurities);

                end;

                //balances at other institutions
                DepositsandBalancesatOtherInstitutions := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Capital adequecy", '%1', GLAccount."capital adequecy"::DepositsandBalancesatOtherInstitutions);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', AsAt);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            DepositsandBalancesatOtherInstitutions += GLEntry.Amount;
                        end;

                    until GLAccount.Next = 0;
                    //Message('DepositsandBalancesatOtherInstitutions %1', DepositsandBalancesatOtherInstitutions);

                end;

                //other assets
                Otherassets := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Capital adequecy", '%1', GLAccount."capital adequecy"::Otherassets);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', AsAt);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            Otherassets += GLEntry.Amount;
                        end;

                    until GLAccount.Next = 0;

                end;

                //property and equipment
                PropertyandEquipment := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Capital adequecy", '%1', GLAccount."capital adequecy"::"PropertyandEquipment");
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', AsAt);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            PropertyandEquipment += GLEntry.Amount;
                        end;

                    until GLAccount.Next = 0;

                end;
                //deposit liabilities
                TotalDepositsLiabilities := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Capital adequecy", '%1', GLAccount."capital adequecy"::TotalDepositsLiabilities);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', AsAt);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            TotalDepositsLiabilities += GLEntry.Amount * -1;
                        end;

                    until GLAccount.Next = 0;

                end;

                //investment
                //TotalDepositsLiabilities:=0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Capital adequecy", '%1', GLAccount."capital adequecy"::Investments);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', AsAt);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            investment += GLEntry.Amount;
                        end;

                    until GLAccount.Next = 0;
                    //Message('Investments is %1', Investment);

                end;

                //non withdrawal
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount.StatementOfFP2, '%1', GLAccount.Statementoffp2::Nonwithdrawabledeposits);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', Asat);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            Nonwithdrawabledeposits += -1 * GLEntry.Amount;
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
                    // Message('InvestmentinCompanies shares is %1', InvestmentinCompaniesshares);
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

                Taxes := 0;
                ProposedDividends := 0;
                ProposedHonoraria := 0;
                StatturyAdjustment := 0;
                Sub_Total := 0;
                RetainedearningsandDisclosedreserves := 0;
                Netsurplus := 0;
                Saccogen.Get();
                ProposedHonoraria := (((Nonwithdrawabledeposits * SaccoGen."Share Interest (%)") * 0.01) * (SaccoGen."Proposed Honoraria" * 0.01));
                ProposedDividends := ((Nonwithdrawabledeposits * SaccoGen."Share Interest (%)") * 0.01) + ((ShareCapital * SaccoGen."Share Interest (%)") * 0.01);
                NetSurplusaftertax := NetSurplusaftertax + ProposedDividends;
                Taxes := ((InvestmentinCompaniesshares * 0.50) * 0.30);
                Taxes := Taxes - Taxpaid;
                //NetSurplusaftertax := NetSurplusaftertax + Taxes;
                // Message('Net %1,plus taxes %2, total %3', NetSurplusaftertax, Taxes, NetSurplusaftertax);

                Netsurplus := -(NetSurplusaftertax * 0.50);
                //StatturyAdjustment := -(0.20 * NetSurplusaftertax);
                NetSurplusaftertax := -(NetSurplusaftertax + (StatturyAdjustment + ProposedHonoraria));
                //Otherreserves := NetSurplusaftertax;
                //Message('ProposedDividends is %1, Netsurplus of %2 ,StatturyAdjustment %3', ProposedDividends, Netsurplus, StatturyAdjustment);

                //StatutoryReserve := StatutoryReserve + StatturyAdjustment;
                TOTALOnBalanceSheet := Cash + GovernmentSecurities + DepositsandBalancesatOtherInstitutions + LoansandAdvances + InvestmentsinSubsidiary + Otherassets + PropertyandEquipment + investment;
                Sub_Total := ShareCapital + CapitalGrants + retainedEarnins + NetSurplus + StatutoryReserve + Otherreserves;
                TotalDeductions := /* InvestmentsinSubsidiary */GovernmentSecurities + OtherDeductions;

                Message('StatutoryAdjustment = %1->, Subtotal of -> %2, StatutoryReserve of %3', StatturyAdjustment, Sub_Total, StatutoryReserve);


                CORECAPITAL := Sub_Total - TotalDeductions;
                RetainedearningsandDisclosedreserves := Sub_Total - ShareCapital;
                totalassetsPBSheet := totalassetsPBSheet - AllowanceforLoanLoss;
                TotalAssets := totalassetsPBSheet + OFFBALANCESHEETASSETS;
                CorecapitaltoAssetsRatio := CORECAPITAL / TotalAssets;
                MinimumCoreCapitaltoAssetsRatioRequirement := 0.08;
                Excess1 := CorecapitaltoAssetsRatio - MinimumCoreCapitaltoAssetsRatioRequirement;
                RetainedearningsanddisclosedreservestoCorecapital := RetainedearningsandDisclosedreserves / CORECAPITAL;
                MinimumRetainedearningsanddisclosed := 0.5;
                Excess2 := RetainedearningsanddisclosedreservestoCorecapital - MinimumRetainedearningsanddisclosed;
                //CorecapitatoDepositsRatio := CORECAPITAL / TotalDepositsLiabilities;
                MinimumCoreCapitaltoDeposits := 0.05;
                Excess := CorecapitatoDepositsRatio - MinimumCoreCapitaltoDeposits;
                DifferenceNew := TOTALOnBalanceSheet - totalassetsPBSheet;

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
        /*FinancialYear:=DATE2DMY(AsAt,3);
        StartDate:=CALCDATE('-CY',AsAt);
        Datefilter:='..'+FORMAT(AsAt);
        CurrentYearFilter:=FORMAT(StartDate)+'..'+FORMAT(AsAt);
        */
        Date := CalcDate('-CY', AsAt);
        Datefilter := Format(Date) + '..' + Format(AsAt);
        DateFilter11 := Format(Date) + '..' + Format(AsAt);
        FinancialYear := Date2dmy(AsAt, 3);

    end;

    var
        Taxpaid: Decimal;
        FinancialYear: Integer;
        Netsurplus: Decimal;
        StatturyAdjustment: Decimal;
        ProposedHonoraria: Decimal;
        Taxes: Decimal;
        InvestmentinCompaniesshares: Decimal;
        ProposedDividends: Decimal;
        Saccogen: Record "Sacco General Set-Up";
        AsAt: Date;
        Datefilter: Text;
        DateFilter11: Text;
        StartDate: Date;
        ShareCapital: Decimal;
        Date: Date;
#pragma warning disable AL0275
        GLEntry: Record "G/L Entry";
#pragma warning restore AL0275
#pragma warning disable AL0275
        GLAccount: Record "G/L Account";
#pragma warning restore AL0275
        ShareCapitalValue: Decimal;
        StatutoryReserve: Decimal;
        investment: Decimal;
        Otherreserves: Decimal;
        retainedEarnins: Decimal;
        NetSurplusaftertax: Decimal;
        Nonwithdrawabledeposits: Decimal;
        CurrentYearFilter: Text;
        LoansandAdvances: Decimal;
        LoansRegister: Record "Loans Register";
        totalassetsPBSheet: Decimal;
        Cash: Decimal;
        PropertyandEquipment: Decimal;
        GovernmentSecurities: Decimal;
        DepositsandBalancesatOtherInstitutions: Decimal;
        Otherassets: Decimal;
        CapitalGrants: Decimal;
        InvestmentsinSubsidiary: Decimal;
        OFFBALANCESHEETASSETS: Decimal;
        TOTALOnBalanceSheet: Decimal;
        OtherDeductions: Decimal;
        Sub_Total: Decimal;
        TotalDeductions: Decimal;
        CORECAPITAL: Decimal;
        RetainedearningsandDisclosedreserves: Decimal;
        TotalAssets: Decimal;
        TotalDepositsLiabilities: Decimal;
        CorecapitaltoAssetsRatio: Decimal;
        MinimumCoreCapitaltoAssetsRatioRequirement: Decimal;
        Excess1: Decimal;
        RetainedearningsanddisclosedreservestoCorecapital: Decimal;
        MinimumRetainedearningsanddisclosed: Decimal;
        Excess2: Decimal;
        CorecapitatoDepositsRatio: Decimal;
        MinimumCoreCapitaltoDeposits: Decimal;
        Excess: Decimal;
        DifferenceNew: Decimal;
        Kuscoshares: Decimal;
        AllowanceforLoanLoss: Decimal;

        totalassetsPBSheet2: Decimal;
}

