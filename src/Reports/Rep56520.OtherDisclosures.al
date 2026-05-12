#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 56520 "Other Disclosures.."
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Other Disclosures...rdlc';

    dataset
    {
        dataitem(Company; "Company Information")
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
            column(Grossnonperformingloan; Grossnonperformingloan)
            {
            }
            column(GrossnonperformingloanLast; GrossnonperformingloanLast)
            {
            }
            column(Interestinsuspense; Interestinsuspense)
            {
            }
            column(InterestinsuspenseLast; InterestinsuspenseLast)
            {
            }
            column(Totalnonperformingloan; Totalnonperformingloan)
            {
            }
            column(TotalnonperformingloanLast; TotalnonperformingloanLast)
            {
            }
            column(Directors; Directors)
            {
            }
            column(DirectorsLast; DirectorsLast)
            {
            }
            column(Employees; Employees)
            {
            }
            column(EmployeesLast; EmployeesLast)
            {
            }
            column(Totalinsiderloans; Totalinsiderloans)
            {
            }
            column(TotalinsiderloansLast; TotalinsiderloansLast)
            {
            }
            column(Allowanceforloanloss; Allowanceforloanloss)
            {
            }
            column(Netnonperformingloans; Netnonperformingloans)
            {
            }
            column(AllowanceforloanlossLast; AllowanceforloanlossLast)
            {
            }
            column(NetnonperformingloansLast; NetnonperformingloansLast)
            {
            }
            column(othercontigentliabilities; othercontigentliabilities)
            {
            }
            column(Guaranteesandcommitments; Guaranteesandcommitments)
            {
            }
            column(totalcontingentliabilities; totalcontingentliabilities)
            {
            }
            column(Corecapital; Corecapital)
            {
            }
            column(CorecapitaltoTotalassetratio; CorecapitaltoTotalassetratio)
            {
            }
            column(liquidityRatio; liquidityRatio)
            {
            }
            column(CorecapitalLast; CorecapitalLast)
            {
            }
            column(CorecapitaltoTotalassetratioNew; CorecapitaltoTotalassetratioNew)
            {
            }
            column(CorecapitaltoTotalassetratioNewLast; CorecapitaltoTotalassetratioNewLast)
            {
            }
            column(Excess1; Excess1)
            {
            }
            column(Excess11; Excess11)
            {
            }
            column(Depositsliabilitiesratio; Depositsliabilitiesratio)
            {
            }
            column(DepositsliabilitiesratioLast; DepositsliabilitiesratioLast)
            {
            }
            column(CorecapitalDepositsliabilities; CorecapitalDepositsliabilities)
            {
            }
            column(CorecapitalDepositsliabilitiesLast; CorecapitalDepositsliabilitiesLast)
            {
            }
            column(xcessdeficiency; xcessdeficiency)
            {
            }
            column(xcessdeficiencyLast; xcessdeficiencyLast)
            {
            }
            column(Ratio2; Ratio2)
            {
            }
            column(Ratio; Ratio)
            {
            }
            column(ExcessLiquidity; ExcessLiquidity)
            {
            }
            column(ExcessLiquidityLast; ExcessLiquidityLast)
            {
            }

            trigger OnAfterGetRecord()
            begin
                //gross non performing loan
                LoansRegister.Reset;
                LoansRegister.SetFilter(LoansRegister."Loans Category", '%1|%2|%3', LoansRegister."loans category"::Substandard, LoansRegister."loans category"::Doubtful, LoansRegister."loans category"::Loss);
                LoansRegister.SetFilter(LoansRegister."Date filter", DateFilterCurrent);
                LoansRegister.SetFilter(LoansRegister."Outstanding Balance", '>%1', 0);
                LoansRegister.SetAutocalcFields("Outstanding Balance");
                if LoansRegister.FindSet then begin
                    repeat
                        Grossnonperformingloan += LoansRegister."Outstanding Balance";
                    until LoansRegister.Next = 0;
                end;
                GrossnonperformingloanLast := 0;
                LoansRegister.Reset;
                LoansRegister.SetFilter(LoansRegister."Loans Category", '%1|%2|%3', LoansRegister."loans category"::Substandard, LoansRegister."loans category"::Doubtful, LoansRegister."loans category"::Loss);
                LoansRegister.SetFilter(LoansRegister."Date filter", LastYearFilter);
                LoansRegister.SetFilter(LoansRegister."Outstanding Balance", '>%1', 0);
                LoansRegister.SetAutocalcFields("Outstanding Balance");
                if LoansRegister.FindSet then begin
                    repeat
                        GrossnonperformingloanLast += LoansRegister."Outstanding Balance";
                    until LoansRegister.Next = 0;
                end;
                //interest in suspense

                LoansRegister.Reset;
                LoansRegister.SetFilter(LoansRegister."Loans Category", '%1|%2|%3', LoansRegister."loans category"::Substandard, LoansRegister."loans category"::Doubtful, LoansRegister."loans category"::Loss);
                LoansRegister.SetFilter(LoansRegister."Date filter", DateFilterCurrent);
                LoansRegister.SetFilter(LoansRegister."Oustanding Interest", '>%1', 0);
                LoansRegister.SetAutocalcFields("Oustanding Interest");
                if LoansRegister.FindSet then begin
                    repeat
                        Interestinsuspense += LoansRegister."Oustanding Interest";
                    until LoansRegister.Next = 0;
                end;
                InterestinsuspenseLast := 0;
                LoansRegister.Reset;
                LoansRegister.SetFilter(LoansRegister."Loans Category", '%1|%2|%3', LoansRegister."loans category"::Substandard, LoansRegister."loans category"::Doubtful, LoansRegister."loans category"::Loss);
                LoansRegister.SetFilter(LoansRegister."Date filter", LastYearFilter);
                LoansRegister.SetFilter(LoansRegister."Oustanding Interest", '>%1', 0);
                LoansRegister.SetAutocalcFields("Oustanding Interest");
                if LoansRegister.FindSet then begin
                    repeat
                        InterestinsuspenseLast += LoansRegister."Oustanding Interest";
                    until LoansRegister.Next = 0;
                end;

                //insider loans

                LoansRegister.Reset;
                LoansRegister.SetFilter(LoansRegister."Date filter", DateFilterCurrent);
                LoansRegister.SetFilter(LoansRegister."Outstanding Balance", '>%1', 0);
                LoansRegister.SetRange(LoansRegister."Insider-Employee", true);
                LoansRegister.SetAutocalcFields("Outstanding Balance");
                if LoansRegister.FindSet then begin
                    repeat
                        Employees += LoansRegister."Outstanding Balance";
                    until LoansRegister.Next = 0;
                end;

                LoansRegister.Reset;
                LoansRegister.SetFilter(LoansRegister."Date filter", LastYearFilter);
                LoansRegister.SetFilter(LoansRegister."Outstanding Balance", '>%1', 0);
                LoansRegister.SetRange(LoansRegister."Insider-Employee", true);
                LoansRegister.SetAutocalcFields("Outstanding Balance");
                if LoansRegister.FindSet then begin
                    repeat
                        EmployeesLast += LoansRegister."Outstanding Balance";
                    until LoansRegister.Next = 0;
                end;

                LoansRegister.Reset;
                LoansRegister.SetFilter(LoansRegister."Date filter", DateFilterCurrent);
                LoansRegister.SetFilter(LoansRegister."Outstanding Balance", '>%1', 0);
                LoansRegister.SetRange(LoansRegister."Insider-board", true);
                LoansRegister.SetAutocalcFields("Outstanding Balance");
                if LoansRegister.FindSet then begin
                    repeat
                        Directors += LoansRegister."Outstanding Balance";
                    until LoansRegister.Next = 0;
                end;

                LoansRegister.Reset;
                LoansRegister.SetFilter(LoansRegister."Date filter", LastYearFilter);
                LoansRegister.SetFilter(LoansRegister."Outstanding Balance", '>%1', 0);
                LoansRegister.SetRange(LoansRegister."Insider-board", true);
                LoansRegister.SetAutocalcFields("Outstanding Balance");
                if LoansRegister.FindSet then begin
                    repeat
                        DirectorsLast += LoansRegister."Outstanding Balance";
                    until LoansRegister.Next = 0;
                end;

                //allowance for loan loss

                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Form 2H other disc", '%1', GLAccount."form 2h other disc"::AllowanceForLoanLoss);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", DateFilterCurrent);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            Allowanceforloanloss += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;

                end;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Form 2H other disc", '%1', GLAccount."form 2h other disc"::AllowanceForLoanLoss);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", LastYearFilter);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            AllowanceforloanlossLast += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;

                end;
                Totalnonperformingloan := Grossnonperformingloan - Interestinsuspense;
                TotalnonperformingloanLast := GrossnonperformingloanLast - InterestinsuspenseLast;
                Totalinsiderloans := Employees + Directors;
                TotalinsiderloansLast := EmployeesLast + DirectorsLast;
                Netnonperformingloans := Totalnonperformingloan - Allowanceforloanloss;
                NetnonperformingloansLast := TotalnonperformingloanLast - AllowanceforloanlossLast;
                //curent year surplus
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Capital adequecy", '%1', GLAccount."capital adequecy"::NetSurplusaftertax);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", CurrentYearFilter);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            NetSurplusaftertax += GLEntry.Amount * 0.5;
                        end;

                    until GLAccount.Next = 0;

                end;

                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Capital adequecy", '%1', GLAccount."capital adequecy"::NetSurplusaftertax);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", LastYearFilter);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            NetSurplusaftertaxLast += GLEntry.Amount * 0.5;
                        end;

                    until GLAccount.Next = 0;

                end;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Form 2H other disc", '%1', GLAccount."form 2h other disc"::Core_Cpital);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", DateFilterCurrent);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            ShareCapital += GLEntry.Amount * -1;
                        end;

                    until GLAccount.Next = 0;

                end;

                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Form 2H other disc", '%1', GLAccount."form 2h other disc"::Core_Cpital);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", LastYearFilter);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            ShareCapitalLast += GLEntry.Amount * -1;
                        end;

                    until GLAccount.Next = 0;

                end;

                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Form 2H other disc", '%1', GLAccount."form 2h other disc"::CoreCapitalDeduction);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", DateFilterCurrent);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            CoreCapitalDeduction += GLEntry.Amount;
                        end;

                    until GLAccount.Next = 0;

                end;

                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Form 2H other disc", '%1', GLAccount."form 2h other disc"::CoreCapitalDeduction);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", LastYearFilter);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            CoreCapitalDeductionLast += GLEntry.Amount;
                        end;

                    until GLAccount.Next = 0;

                end;

                Corecapital := ShareCapital + NetSurplusaftertax - CoreCapitalDeduction;
                CorecapitalLast := ShareCapitalLast + NetSurplusaftertaxLast - CoreCapitalDeductionLast;
                //total assets as per the balance sheet

                GLAccount.Reset;
                GLAccount.SetRange(GLAccount."No.", '199999');
                GLAccount.SetFilter(GLAccount."Date Filter", DateFilterCurrent);
                GLAccount.SetAutocalcFields("Balance at Date");
                if GLAccount.FindSet then begin
                    repeat
                        totalassetsPBSheet += GLAccount."Balance at Date";
                    until GLAccount.Next = 0;
                end;

                GLAccount.Reset;
                GLAccount.SetRange(GLAccount."No.", '199999');
                GLAccount.SetFilter(GLAccount."Date Filter", LastYearFilter);
                GLAccount.SetAutocalcFields("Balance at Date");
                if GLAccount.FindSet then begin
                    repeat
                        totalassetsPBSheetLast += GLAccount."Balance at Date";
                    until GLAccount.Next = 0;
                end;

                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Capital adequecy", '%1', GLAccount."capital adequecy"::TotalDepositsLiabilities);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", DateFilterCurrent);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            TotalDepositsLiabilities += GLEntry.Amount * -1;
                        end;

                    until GLAccount.Next = 0;

                end;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Capital adequecy", '%1', GLAccount."capital adequecy"::TotalDepositsLiabilities);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", LastYearFilter);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            TotalDepositsLiabilitiesLast += GLEntry.Amount * -1;
                        end;

                    until GLAccount.Next = 0;

                end;
                CorecapitaltoTotalassetratioNew := Corecapital / totalassetsPBSheet;
                CorecapitaltoTotalassetratioNewLast := CorecapitalLast / totalassetsPBSheetLast;
                Maximumstatutoryratio := 0.08;
                Excess1 := (CorecapitaltoTotalassetratioNew - Maximumstatutoryratio);
                Excess11 := (CorecapitaltoTotalassetratioNewLast - Maximumstatutoryratio);

                CorecapitalDepositsliabilities := Corecapital / TotalDepositsLiabilities;
                CorecapitalDepositsliabilitiesLast := CorecapitalLast / TotalDepositsLiabilitiesLast;
                xcessdeficiency := (CorecapitalDepositsliabilities - 0.05);
                xcessdeficiencyLast := (CorecapitalDepositsliabilitiesLast - 0.08);


                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Form 2H other disc", '%1', GLAccount."form 2h other disc"::Liquidity);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", DateFilterCurrent);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            CashLiquidity += GLEntry.Amount;
                        end;

                    until GLAccount.Next = 0;

                end;

                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Form 2H other disc", '%1', GLAccount."form 2h other disc"::Liquidity);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", LastYearFilter);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            CashLiquidityLat += GLEntry.Amount;
                        end;

                    until GLAccount.Next = 0;

                end;

                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Form 2H other disc", '%1', GLAccount."form 2h other disc"::Otherliablilities);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", DateFilterCurrent);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            Otherliabilities += GLEntry.Amount;
                        end;

                    until GLAccount.Next = 0;

                end;

                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Form 2H other disc", '%1', GLAccount."form 2h other disc"::Otherliablilities);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", LastYearFilter);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            OtherliabilitiesLast += GLEntry.Amount;
                        end;

                    until GLAccount.Next = 0;

                end;

                Ratio := CashLiquidity / Otherliabilities;
                Ratio2 := CashLiquidityLat / OtherliabilitiesLast;
                ExcessLiquidityLast := (Ratio2) - (10 / 100);
                ExcessLiquidity := Ratio - (10 / 100);
                //MESSAGE('%1',CashLiquidityLat);

                // //CORE CAPITAL
                // GLAccount.RESET;
                // GLAccount.SETFILTER(GLAccount."Capital adequecy",'%1',GLAccount."Capital adequecy"::ShareCapital);
                // IF GLAccount.FINDSET THEN BEGIN
                //  REPEAT
                //    ShareCapitalValue:=0;
                //    GLEntry.RESET;
                //    GLEntry.SETRANGE(GLEntry."G/L Account No.",GLAccount."No.");
                //    GLEntry.SETFILTER(GLEntry."Posting Date",DateFilterCurrent);
                //    IF GLEntry.FINDSET THEN BEGIN
                //      GLEntry.CALCSUMS(Amount);
                //      ShareCapitalValue:=GLEntry.Amount;
                //      END;
                //      ShareCapital:=ShareCapital+ShareCapitalValue;
                //
                //   UNTIL GLAccount.NEXT = 0;
                //
                // END;
                //
                // //statutory reserve
                // GLAccount.RESET;
                // GLAccount.SETFILTER(GLAccount."Capital adequecy",'%1',GLAccount."Capital adequecy"::StatutoryReserve);
                // IF GLAccount.FINDSET THEN BEGIN
                //  REPEAT
                //    ShareCapitalValue:=0;
                //    GLEntry.RESET;
                //    GLEntry.SETRANGE(GLEntry."G/L Account No.",GLAccount."No.");
                //    GLEntry.SETFILTER(GLEntry."Posting Date",DateFilterCurrent);
                //    IF GLEntry.FINDSET THEN BEGIN
                //      GLEntry.CALCSUMS(Amount);
                //      StatutoryReserve+=GLEntry.Amount;
                //      END;
                //
                //   UNTIL GLAccount.NEXT = 0;
                //
                // END;
                // //retained earnings
                // GLAccount.RESET;
                // GLAccount.SETFILTER(GLAccount."Capital adequecy",'%1',GLAccount."Capital adequecy"::RetainedEarnings);
                // IF GLAccount.FINDSET THEN BEGIN
                //  REPEAT
                //    ShareCapitalValue:=0;
                //    GLEntry.RESET;
                //    GLEntry.SETRANGE(GLEntry."G/L Account No.",GLAccount."No.");
                //    GLEntry.SETFILTER(GLEntry."Posting Date",DateFilterCurrent);
                //    IF GLEntry.FINDSET THEN BEGIN
                //      GLEntry.CALCSUMS(Amount);
                //      retainedEarnins+=GLEntry.Amount;
                //      END;
                //
                //   UNTIL GLAccount.NEXT = 0;
                //
                // END;
                // //curent year surplus
                // GLAccount.RESET;
                // GLAccount.SETFILTER(GLAccount."Capital adequecy",'%1',GLAccount."Capital adequecy"::NetSurplusaftertax);
                // IF GLAccount.FINDSET THEN BEGIN
                //  REPEAT
                //    ShareCapitalValue:=0;
                //    GLEntry.RESET;
                //    GLEntry.SETRANGE(GLEntry."G/L Account No.",GLAccount."No.");
                //    GLEntry.SETFILTER(GLEntry."Posting Date",CurrentYearFilter);
                //    IF GLEntry.FINDSET THEN BEGIN
                //      GLEntry.CALCSUMS(Amount);
                //      NetSurplusaftertax+=GLEntry.Amount;
                //      END;
                //
                //   UNTIL GLAccount.NEXT = 0;
                //
                // END;
                //
                // //Loans and Advances
                // LoansRegister.RESET;
                // LoansRegister.SETFILTER(LoansRegister."Date filter",DateFilterCurrent);
                // LoansRegister.SETAUTOCALCFIELDS("Outstanding Balance");
                // IF LoansRegister.FINDSET THEN BEGIN
                //   REPEAT
                //     LoansandAdvances+=LoansRegister."Outstanding Balance";
                //     UNTIL LoansRegister.NEXT = 0;
                //
                // END;
                //
                // //total assets as per the balance sheet
                //
                // GLAccount.RESET;
                // GLAccount.SETRANGE(GLAccount."No.",'199999');
                // GLAccount.SETFILTER(GLAccount."Date Filter",DateFilterCurrent);
                // GLAccount.SETAUTOCALCFIELDS(Balance);
                // IF GLAccount.FINDSET THEN BEGIN
                //
                //  REPEAT
                //    totalassetsPBSheet+=GLAccount.Balance;
                //    UNTIL GLAccount.NEXT = 0;
                //
                //  END;
                //  //Cash (Local + Foreign Currency)
                //  GLAccount.RESET;
                // GLAccount.SETFILTER(GLAccount."Capital adequecy",'%1',GLAccount."Capital adequecy"::Cash);
                // IF GLAccount.FINDSET THEN BEGIN
                //  REPEAT
                //    GLEntry.RESET;
                //    GLEntry.SETRANGE(GLEntry."G/L Account No.",GLAccount."No.");
                //    GLEntry.SETFILTER(GLEntry."Posting Date",DateFilterCurrent);
                //    IF GLEntry.FINDSET THEN BEGIN
                //      GLEntry.CALCSUMS(Amount);
                //      Cash+=GLEntry.Amount;
                //      END;
                //
                //   UNTIL GLAccount.NEXT = 0;
                //
                // END;
                //
                // //INVESTMENT IN SUBSIDIARY
                // InvestmentsinSubsidiary:=0;
                // GLAccount.RESET;
                // GLAccount.SETFILTER(GLAccount."Capital adequecy",'%1',GLAccount."Capital adequecy"::InvestmentsinSubsidiary);
                // IF GLAccount.FINDSET THEN BEGIN
                //  REPEAT
                //    GLEntry.RESET;
                //    GLEntry.SETRANGE(GLEntry."G/L Account No.",GLAccount."No.");
                //    GLEntry.SETFILTER(GLEntry."Posting Date",DateFilterCurrent);
                //    IF GLEntry.FINDSET THEN BEGIN
                //      GLEntry.CALCSUMS(Amount);
                //      InvestmentsinSubsidiary+=GLEntry.Amount;
                //      END;
                //
                //   UNTIL GLAccount.NEXT = 0;
                //
                // END;
                // //Other reserves
                // Otherreserves:=0;
                // GLAccount.RESET;
                // GLAccount.SETFILTER(GLAccount."Capital adequecy",'%1',GLAccount."Capital adequecy"::Otherreserves);
                // IF GLAccount.FINDSET THEN BEGIN
                //  REPEAT
                //    GLEntry.RESET;
                //    GLEntry.SETRANGE(GLEntry."G/L Account No.",GLAccount."No.");
                //    GLEntry.SETFILTER(GLEntry."Posting Date",DateFilterCurrent);
                //    IF GLEntry.FINDSET THEN BEGIN
                //      GLEntry.CALCSUMS(Amount);
                //      Otherreserves+=GLEntry.Amount;
                //      END;
                //
                //   UNTIL GLAccount.NEXT = 0;
                //
                // END;
                //
                // //gov securities
                // GovernmentSecurities:=0;
                // GLAccount.RESET;
                // GLAccount.SETFILTER(GLAccount."Capital adequecy",'%1',GLAccount."Capital adequecy"::GovernmentSecurities);
                // IF GLAccount.FINDSET THEN BEGIN
                //  REPEAT
                //    GLEntry.RESET;
                //    GLEntry.SETRANGE(GLEntry."G/L Account No.",GLAccount."No.");
                //    GLEntry.SETFILTER(GLEntry."Posting Date",DateFilterCurrent);
                //    IF GLEntry.FINDSET THEN BEGIN
                //      GLEntry.CALCSUMS(Amount);
                //      GovernmentSecurities+=GLEntry.Amount;
                //      END;
                //
                //   UNTIL GLAccount.NEXT = 0;
                //
                // END;
                //
                // //balances at other institutions
                // DepositsandBalancesatOtherInstitutions:=0;
                // GLAccount.RESET;
                // GLAccount.SETFILTER(GLAccount."Capital adequecy",'%1',GLAccount."Capital adequecy"::DepositsandBalancesatOtherInstitutions);
                // IF GLAccount.FINDSET THEN BEGIN
                //  REPEAT
                //    GLEntry.RESET;
                //    GLEntry.SETRANGE(GLEntry."G/L Account No.",GLAccount."No.");
                //    GLEntry.SETFILTER(GLEntry."Posting Date",DateFilterCurrent);
                //    IF GLEntry.FINDSET THEN BEGIN
                //      GLEntry.CALCSUMS(Amount);
                //      DepositsandBalancesatOtherInstitutions+=GLEntry.Amount;
                //      END;
                //
                //   UNTIL GLAccount.NEXT = 0;
                //
                // END;
                //
                // //other assets
                // Otherassets:=0;
                // GLAccount.RESET;
                // GLAccount.SETFILTER(GLAccount."Capital adequecy",'%1',GLAccount."Capital adequecy"::Otherassets);
                // IF GLAccount.FINDSET THEN BEGIN
                //  REPEAT
                //    GLEntry.RESET;
                //    GLEntry.SETRANGE(GLEntry."G/L Account No.",GLAccount."No.");
                //    GLEntry.SETFILTER(GLEntry."Posting Date",DateFilterCurrent);
                //    IF GLEntry.FINDSET THEN BEGIN
                //      GLEntry.CALCSUMS(Amount);
                //      Otherassets+=GLEntry.Amount;
                //      END;
                //
                //   UNTIL GLAccount.NEXT = 0;
                //
                // END;
                //
                // //property and equipment
                // PropertyandEquipment:=0;
                // GLAccount.RESET;
                // GLAccount.SETFILTER(GLAccount."Capital adequecy",'%1',GLAccount."Capital adequecy"::PropertyandEquipment);
                // IF GLAccount.FINDSET THEN BEGIN
                //  REPEAT
                //    GLEntry.RESET;
                //    GLEntry.SETRANGE(GLEntry."G/L Account No.",GLAccount."No.");
                //    GLEntry.SETFILTER(GLEntry."Posting Date",DateFilterCurrent);
                //    IF GLEntry.FINDSET THEN BEGIN
                //      GLEntry.CALCSUMS(Amount);
                //      PropertyandEquipment+=GLEntry.Amount;
                //      END;
                //
                //   UNTIL GLAccount.NEXT = 0;
                //
                // END;
                // //deposit liabilities
                // TotalDepositsLiabilities:=0;
                // GLAccount.RESET;
                // GLAccount.SETFILTER(GLAccount."Capital adequecy",'%1',GLAccount."Capital adequecy"::"TotalDepositsLiabilities ");
                // IF GLAccount.FINDSET THEN BEGIN
                //  REPEAT
                //    GLEntry.RESET;
                //    GLEntry.SETRANGE(GLEntry."G/L Account No.",GLAccount."No.");
                //    GLEntry.SETFILTER(GLEntry."Posting Date",DateFilterCurrent);
                //    IF GLEntry.FINDSET THEN BEGIN
                //      GLEntry.CALCSUMS(Amount);
                //      TotalDepositsLiabilities+=GLEntry.Amount;
                //      END;
                //
                //   UNTIL GLAccount.NEXT = 0;
                //
                // END;
                //
                // GLAccount.RESET;
                // GLAccount.SETFILTER(GLAccount."Form 2H other disc",'%1',GLAccount."Form 2H other disc"::totalassetsPBSheet);
                // IF GLAccount.FINDSET THEN BEGIN
                //  REPEAT
                //    GLEntry.RESET;
                //    GLEntry.SETRANGE(GLEntry."G/L Account No.",GLAccount."No.");
                //    GLEntry.SETFILTER(GLEntry."Posting Date",DateFilterCurrent);
                //    IF GLEntry.FINDSET THEN BEGIN
                //      GLEntry.CALCSUMS(Amount);
                //      BalancesheetAssets+=GLEntry.Amount;
                //      END;
                //
                //   UNTIL GLAccount.NEXT = 0;
                //
                // END;
                //
                // //deposit liabilities
                // GLAccount.RESET;
                // GLAccount.SETFILTER(GLAccount."Form 2H other disc",'%1',GLAccount."Form 2H other disc"::"Deposits liabilities");
                // IF GLAccount.FINDSET THEN BEGIN
                //  REPEAT
                //    GLEntry.RESET;
                //    GLEntry.SETRANGE(GLEntry."G/L Account No.",GLAccount."No.");
                //    GLEntry.SETFILTER(GLEntry."Posting Date",DateFilterCurrent);
                //    IF GLEntry.FINDSET THEN BEGIN
                //      GLEntry.CALCSUMS(Amount);
                //      Depositsliabilitiesratio+=GLEntry.Amount*-1;
                //      END;
                //
                //   UNTIL GLAccount.NEXT = 0;
                //
                // END;
                //
                // TOTALOnBalanceSheet:=Cash+GovernmentSecurities+DepositsandBalancesatOtherInstitutions+LoansandAdvances+InvestmentsinSubsidiary+Otherassets+PropertyandEquipment;
                // Sub_Total:=ShareCapital+CapitalGrants+retainedEarnins+NetSurplusaftertax+StatutoryReserve+Otherreserves;
                // TotalDeductions:=InvestmentsinSubsidiary+OtherDeductions;
                // Corecapital:=(Sub_Total-TotalDeductions)*-1;
                //
                // //corecapital last year
                // GLAccount.RESET;
                // GLAccount.SETFILTER(GLAccount."Capital adequecy",'%1',GLAccount."Capital adequecy"::ShareCapital);
                // IF GLAccount.FINDSET THEN BEGIN
                //  REPEAT
                //    ShareCapitalLast:=0;
                //    GLEntry.RESET;
                //    GLEntry.SETRANGE(GLEntry."G/L Account No.",GLAccount."No.");
                //    GLEntry.SETFILTER(GLEntry."Posting Date",LastYearFilter);
                //    IF GLEntry.FINDSET THEN BEGIN
                //      GLEntry.CALCSUMS(Amount);
                //      ShareCapitalLast+=GLEntry.Amount;
                //      END;
                //     // ShareCapital:=ShareCapital+ShareCapitalValue;
                //
                //   UNTIL GLAccount.NEXT = 0;
                //
                // END;
                //
                // //statutory reserve
                // GLAccount.RESET;
                // GLAccount.SETFILTER(GLAccount."Capital adequecy",'%1',GLAccount."Capital adequecy"::StatutoryReserve);
                // IF GLAccount.FINDSET THEN BEGIN
                //  REPEAT
                //      GLEntry.RESET;
                //    GLEntry.SETRANGE(GLEntry."G/L Account No.",GLAccount."No.");
                //    GLEntry.SETFILTER(GLEntry."Posting Date",LastYearFilter);
                //    IF GLEntry.FINDSET THEN BEGIN
                //      GLEntry.CALCSUMS(Amount);
                //      StatutoryReserveLast+=GLEntry.Amount;
                //      END;
                //
                //   UNTIL GLAccount.NEXT = 0;
                //
                // END;
                // //retained earnings
                // GLAccount.RESET;
                // GLAccount.SETFILTER(GLAccount."Capital adequecy",'%1',GLAccount."Capital adequecy"::RetainedEarnings);
                // IF GLAccount.FINDSET THEN BEGIN
                //  REPEAT
                //    ShareCapitalValue:=0;
                //    GLEntry.RESET;
                //    GLEntry.SETRANGE(GLEntry."G/L Account No.",GLAccount."No.");
                //    GLEntry.SETFILTER(GLEntry."Posting Date",LastYearFilter);
                //    IF GLEntry.FINDSET THEN BEGIN
                //      GLEntry.CALCSUMS(Amount);
                //      retainedEarninsLast+=GLEntry.Amount;
                //      END;
                //
                //   UNTIL GLAccount.NEXT = 0;
                //
                // END;
                // //curent year surplus
                // GLAccount.RESET;
                // GLAccount.SETFILTER(GLAccount."Capital adequecy",'%1',GLAccount."Capital adequecy"::NetSurplusaftertax);
                // IF GLAccount.FINDSET THEN BEGIN
                //  REPEAT
                //    GLEntry.RESET;
                //    GLEntry.SETRANGE(GLEntry."G/L Account No.",GLAccount."No.");
                //    GLEntry.SETFILTER(GLEntry."Posting Date",LastYearFilter);
                //    IF GLEntry.FINDSET THEN BEGIN
                //      GLEntry.CALCSUMS(Amount);
                //      NetSurplusaftertaxLast+=GLEntry.Amount;
                //      END;
                //
                //   UNTIL GLAccount.NEXT = 0;
                //
                // END;
                //
                // //Loans and Advances
                // LoansRegister.RESET;
                // LoansRegister.SETFILTER(LoansRegister."Date filter",LastYearFilter);
                // LoansRegister.SETAUTOCALCFIELDS("Outstanding Balance");
                // IF LoansRegister.FINDSET THEN BEGIN
                //   REPEAT
                //     LoansandAdvanceslast+=LoansRegister."Outstanding Balance";
                //     UNTIL LoansRegister.NEXT = 0;
                //
                // END;
                //
                // //total assets as per the balance sheet
                //
                // GLAccount.RESET;
                // GLAccount.SETRANGE(GLAccount."No.",'19999');
                // GLAccount.SETFILTER(GLAccount."Date Filter",LastYearFilter);
                // GLAccount.SETAUTOCALCFIELDS(Balance);
                // IF GLAccount.FINDSET THEN BEGIN
                //
                //  REPEAT
                //    totalassetsPBSheetLast+=GLAccount.Balance;
                //    UNTIL GLAccount.NEXT = 0;
                //
                //  END;
                //  //Cash (Local + Foreign Currency)
                //  GLAccount.RESET;
                // GLAccount.SETFILTER(GLAccount."Capital adequecy",'%1',GLAccount."Capital adequecy"::Cash);
                // IF GLAccount.FINDSET THEN BEGIN
                //  REPEAT
                //    GLEntry.RESET;
                //    GLEntry.SETRANGE(GLEntry."G/L Account No.",GLAccount."No.");
                //    GLEntry.SETFILTER(GLEntry."Posting Date",LastYearFilter);
                //    IF GLEntry.FINDSET THEN BEGIN
                //      GLEntry.CALCSUMS(Amount);
                //      CashLast+=GLEntry.Amount;
                //      END;
                //
                //   UNTIL GLAccount.NEXT = 0;
                //
                // END;
                //
                // //INVESTMENT IN SUBSIDIARY
                // InvestmentsinSubsidiary:=0;
                // GLAccount.RESET;
                // GLAccount.SETFILTER(GLAccount."Capital adequecy",'%1',GLAccount."Capital adequecy"::InvestmentsinSubsidiary);
                // IF GLAccount.FINDSET THEN BEGIN
                //  REPEAT
                //    GLEntry.RESET;
                //    GLEntry.SETRANGE(GLEntry."G/L Account No.",GLAccount."No.");
                //    GLEntry.SETFILTER(GLEntry."Posting Date",LastYearFilter);
                //    IF GLEntry.FINDSET THEN BEGIN
                //      GLEntry.CALCSUMS(Amount);
                //      InvestmentsinSubsidiaryLast+=GLEntry.Amount;
                //      END;
                //
                //   UNTIL GLAccount.NEXT = 0;
                //
                // END;
                // //Other reserves
                // Otherreserves:=0;
                // GLAccount.RESET;
                // GLAccount.SETFILTER(GLAccount."Capital adequecy",'%1',GLAccount."Capital adequecy"::Otherreserves);
                // IF GLAccount.FINDSET THEN BEGIN
                //  REPEAT
                //    GLEntry.RESET;
                //    GLEntry.SETRANGE(GLEntry."G/L Account No.",GLAccount."No.");
                //    GLEntry.SETFILTER(GLEntry."Posting Date",LastYearFilter);
                //    IF GLEntry.FINDSET THEN BEGIN
                //      GLEntry.CALCSUMS(Amount);
                //      OtherreservesLast+=GLEntry.Amount;
                //      END;
                //
                //   UNTIL GLAccount.NEXT = 0;
                //
                // END;
                //
                // //gov securities
                // GovernmentSecuritiesLast:=0;
                // GLAccount.RESET;
                // GLAccount.SETFILTER(GLAccount."Capital adequecy",'%1',GLAccount."Capital adequecy"::GovernmentSecurities);
                // IF GLAccount.FINDSET THEN BEGIN
                //  REPEAT
                //    GLEntry.RESET;
                //    GLEntry.SETRANGE(GLEntry."G/L Account No.",GLAccount."No.");
                //    GLEntry.SETFILTER(GLEntry."Posting Date",LastYearFilter);
                //    IF GLEntry.FINDSET THEN BEGIN
                //      GLEntry.CALCSUMS(Amount);
                //      GovernmentSecuritiesLast+=GLEntry.Amount;
                //      END;
                //
                //   UNTIL GLAccount.NEXT = 0;
                //
                // END;
                //
                // //balances at other institutions
                // DepositsandBalancesatOtherInstitutions:=0;
                // GLAccount.RESET;
                // GLAccount.SETFILTER(GLAccount."Capital adequecy",'%1',GLAccount."Capital adequecy"::DepositsandBalancesatOtherInstitutions);
                // IF GLAccount.FINDSET THEN BEGIN
                //  REPEAT
                //    GLEntry.RESET;
                //    GLEntry.SETRANGE(GLEntry."G/L Account No.",GLAccount."No.");
                //    GLEntry.SETFILTER(GLEntry."Posting Date",LastYearFilter);
                //    IF GLEntry.FINDSET THEN BEGIN
                //      GLEntry.CALCSUMS(Amount);
                //      DepositsandBalancesatOtherInstitutionsLast+=GLEntry.Amount;
                //      END;
                //
                //   UNTIL GLAccount.NEXT = 0;
                //
                // END;
                //
                // //other assets
                // Otherassets:=0;
                // GLAccount.RESET;
                // GLAccount.SETFILTER(GLAccount."Capital adequecy",'%1',GLAccount."Capital adequecy"::Otherassets);
                // IF GLAccount.FINDSET THEN BEGIN
                //  REPEAT
                //    GLEntry.RESET;
                //    GLEntry.SETRANGE(GLEntry."G/L Account No.",GLAccount."No.");
                //    GLEntry.SETFILTER(GLEntry."Posting Date",LastYearFilter);
                //    IF GLEntry.FINDSET THEN BEGIN
                //      GLEntry.CALCSUMS(Amount);
                //      OtherassetsLast+=GLEntry.Amount;
                //      END;
                //
                //   UNTIL GLAccount.NEXT = 0;
                //
                // END;
                //
                // //property and equipment
                // PropertyandEquipment:=0;
                // GLAccount.RESET;
                // GLAccount.SETFILTER(GLAccount."Capital adequecy",'%1',GLAccount."Capital adequecy"::PropertyandEquipment);
                // IF GLAccount.FINDSET THEN BEGIN
                //  REPEAT
                //    GLEntry.RESET;
                //    GLEntry.SETRANGE(GLEntry."G/L Account No.",GLAccount."No.");
                //    GLEntry.SETFILTER(GLEntry."Posting Date",LastYearFilter);
                //    IF GLEntry.FINDSET THEN BEGIN
                //      GLEntry.CALCSUMS(Amount);
                //      PropertyandEquipmentLast+=GLEntry.Amount;
                //      END;
                //
                //   UNTIL GLAccount.NEXT = 0;
                //
                // END;
                // //deposit liabilities
                // TotalDepositsLiabilities:=0;
                // GLAccount.RESET;
                // GLAccount.SETFILTER(GLAccount."Capital adequecy",'%1',GLAccount."Capital adequecy"::"TotalDepositsLiabilities ");
                // IF GLAccount.FINDSET THEN BEGIN
                //  REPEAT
                //    GLEntry.RESET;
                //    GLEntry.SETRANGE(GLEntry."G/L Account No.",GLAccount."No.");
                //    GLEntry.SETFILTER(GLEntry."Posting Date",LastYearFilter);
                //    IF GLEntry.FINDSET THEN BEGIN
                //      GLEntry.CALCSUMS(Amount);
                //      TotalDepositsLiabilitiesLast+=GLEntry.Amount;
                //      END;
                //
                //   UNTIL GLAccount.NEXT = 0;
                //
                // END;
                // GLAccount.RESET;
                // GLAccount.SETFILTER(GLAccount."Form 2H other disc",'%1',GLAccount."Form 2H other disc"::totalassetsPBSheet);
                // IF GLAccount.FINDSET THEN BEGIN
                //  REPEAT
                //    GLEntry.RESET;
                //    GLEntry.SETRANGE(GLEntry."G/L Account No.",GLAccount."No.");
                //    GLEntry.SETFILTER(GLEntry."Posting Date",LastYearFilter);
                //    IF GLEntry.FINDSET THEN BEGIN
                //      GLEntry.CALCSUMS(Amount);
                //     BalancesheetAssetsLast+=GLEntry.Amount;
                //      END;
                //
                //   UNTIL GLAccount.NEXT = 0;
                //
                // END;
                // //deposit liabilities
                // GLAccount.RESET;
                // GLAccount.SETFILTER(GLAccount."Form 2H other disc",'%1',GLAccount."Form 2H other disc"::totalassetsPBSheet);
                // IF GLAccount.FINDSET THEN BEGIN
                //  REPEAT
                //    GLEntry.RESET;
                //    GLEntry.SETRANGE(GLEntry."G/L Account No.",GLAccount."No.");
                //    GLEntry.SETFILTER(GLEntry."Posting Date",LastYearFilter);
                //    IF GLEntry.FINDSET THEN BEGIN
                //      GLEntry.CALCSUMS(Amount);
                //      DepositsliabilitiesratioLast+=GLEntry.Amount;
                //      END;
                //
                //   UNTIL GLAccount.NEXT = 0;
                //
                // END;
                //
                // TOTALOnBalanceSheetLast:=CashLast+GovernmentSecuritiesLast+DepositsandBalancesatOtherInstitutionsLast+LoansandAdvanceslast+InvestmentsinSubsidiaryLast+OtherassetsLast+PropertyandEquipmentLast;
                // Sub_TotalLast:=ShareCapitalLast+CapitalGrantsLast+retainedEarninsLast+NetSurplusaftertaxLast+StatutoryReserveLast+OtherreservesLast;
                // TotalDeductionsLast:=InvestmentsinSubsidiaryLast+OtherDeductionsLast;
                // CorecapitalLast:=(Sub_TotalLast-TotalDeductionsLast)*-1;
                // CorecapitaltoTotalassetratioNew:=Corecapital/BalancesheetAssets;
                // CorecapitaltoTotalassetratioNewLast:=CorecapitalLast/BalancesheetAssetsLast;
                // Maximumstatutoryratio:=0.08;
                // Excess1:=(CorecapitaltoTotalassetratioNew-Maximumstatutoryratio)/100;
                // Excess11:=(CorecapitaltoTotalassetratioNewLast-Maximumstatutoryratio)/100;
                //
                // CorecapitalDepositsliabilities:=Corecapital/Depositsliabilitiesratio;
                // CorecapitalDepositsliabilitiesLast:=CorecapitalLast/DepositsliabilitiesratioLast;
                // xcessdeficiency:=(CorecapitalDepositsliabilities-0.05)/100;
                // xcessdeficiencyLast:=(CorecapitalDepositsliabilitiesLast-0.08)/100;
                // //liquidity ratio
                //  LocalNotes:=0;
                // GLAccount.RESET;
                // GLAccount.SETFILTER(GLAccount.Liquidity,'%1',GLAccount.Liquidity::LocalNotes);
                // IF GLAccount.FINDSET THEN BEGIN
                //  REPEAT
                //
                //    GLEntry.RESET;
                //    GLEntry.SETRANGE(GLEntry."G/L Account No.",GLAccount."No.");
                //    GLEntry.SETFILTER(GLEntry."Posting Date",CurrentYearFilter);
                //    IF GLEntry.FINDSET THEN BEGIN
                //      GLEntry.CALCSUMS(Amount);
                //      LocalNotes+=GLEntry.Amount;
                //      END;
                //
                //   UNTIL GLAccount.NEXT = 0;
                //
                // END;
                // GLAccount.RESET;
                // GLAccount.SETFILTER(GLAccount.Liquidity,'%1',GLAccount.Liquidity::LocalNotes);
                // IF GLAccount.FINDSET THEN BEGIN
                //  REPEAT
                //
                //    GLEntry.RESET;
                //    GLEntry.SETRANGE(GLEntry."G/L Account No.",GLAccount."No.");
                //    GLEntry.SETFILTER(GLEntry."Posting Date",LastYearFilter);
                //    IF GLEntry.FINDSET THEN BEGIN
                //      GLEntry.CALCSUMS(Amount);
                //      LocalNotesLast+=GLEntry.Amount;
                //      END;
                //
                //   UNTIL GLAccount.NEXT = 0;
                //
                // END;
                // BalanceswithCommercialBanks:=0;
                // GLAccount.RESET;
                // GLAccount.SETFILTER(GLAccount.Liquidity,'%1',GLAccount.Liquidity::BankBalances);
                // IF GLAccount.FINDSET THEN BEGIN
                //  REPEAT
                //
                //    GLEntry.RESET;
                //    GLEntry.SETRANGE(GLEntry."G/L Account No.",GLAccount."No.");
                //    GLEntry.SETFILTER(GLEntry."Posting Date",CurrentYearFilter);
                //    IF GLEntry.FINDSET THEN BEGIN
                //      GLEntry.CALCSUMS(Amount);
                //     BalanceswithCommercialBanks+=GLEntry.Amount;
                //      END;
                //
                //   UNTIL GLAccount.NEXT = 0;
                //
                // END;
                // BalanceswithCommercialBanks:=0;
                // GLAccount.RESET;
                // GLAccount.SETFILTER(GLAccount.Liquidity,'%1',GLAccount.Liquidity::BankBalances);
                // IF GLAccount.FINDSET THEN BEGIN
                //  REPEAT
                //
                //    GLEntry.RESET;
                //    GLEntry.SETRANGE(GLEntry."G/L Account No.",GLAccount."No.");
                //    GLEntry.SETFILTER(GLEntry."Posting Date",LastYearFilter);
                //    IF GLEntry.FINDSET THEN BEGIN
                //      GLEntry.CALCSUMS(Amount);
                //     BalanceswithCommercialBanksLast+=GLEntry.Amount;
                //      END;
                //
                //   UNTIL GLAccount.NEXT = 0;
                //
                // END;
                // //gov securities
                // TreasuryBills:=0;
                // TreasuryBonds:=0;
                // GLAccount.RESET;
                // GLAccount.SETFILTER(GLAccount.Liquidity,'%1',GLAccount.Liquidity::GovSecurities);
                // IF GLAccount.FINDSET THEN BEGIN
                //  REPEAT
                //
                //    GLEntry.RESET;
                //    GLEntry.SETRANGE(GLEntry."G/L Account No.",GLAccount."No.");
                //    GLEntry.SETFILTER(GLEntry."Posting Date",CurrentYearFilter);
                //    IF GLEntry.FINDSET THEN BEGIN
                //      GLEntry.CALCSUMS(Amount);
                //     TreasuryBills+=GLEntry.Amount;
                //      END;
                //
                //   UNTIL GLAccount.NEXT = 0;
                //
                // END;
                // TreasuryBills:=0;
                // TreasuryBonds:=0;
                // GLAccount.RESET;
                // GLAccount.SETFILTER(GLAccount.Liquidity,'%1',GLAccount.Liquidity::GovSecurities);
                // IF GLAccount.FINDSET THEN BEGIN
                //  REPEAT
                //
                //    GLEntry.RESET;
                //    GLEntry.SETRANGE(GLEntry."G/L Account No.",GLAccount."No.");
                //    GLEntry.SETFILTER(GLEntry."Posting Date",LastYearFilter);
                //    IF GLEntry.FINDSET THEN BEGIN
                //      GLEntry.CALCSUMS(Amount);
                //     TreasuryBillsLast+=GLEntry.Amount;
                //      END;
                //
                //   UNTIL GLAccount.NEXT = 0;
                //
                // END;
                // //balances with other financial institution
                // GLAccount.RESET;
                // GLAccount.SETFILTER(GLAccount.Liquidity,'%1',GLAccount.Liquidity::balanceswithotherfinancialinsti);
                // IF GLAccount.FINDSET THEN BEGIN
                //  REPEAT
                //
                //    GLEntry.RESET;
                //    GLEntry.SETRANGE(GLEntry."G/L Account No.",GLAccount."No.");
                //    GLEntry.SETFILTER(GLEntry."Posting Date",CurrentYearFilter);
                //    IF GLEntry.FINDSET THEN BEGIN
                //      GLEntry.CALCSUMS(Amount);
                //     BalanceswithotherFinancialInstitutions+=GLEntry.Amount;
                //      END;
                //
                //   UNTIL GLAccount.NEXT = 0;
                //
                // END;//20199
                // GLAccount.RESET;
                // GLAccount.SETFILTER(GLAccount.Liquidity,'%1',GLAccount.Liquidity::balanceswithotherfinancialinsti);
                // IF GLAccount.FINDSET THEN BEGIN
                //  REPEAT
                //
                //    GLEntry.RESET;
                //    GLEntry.SETRANGE(GLEntry."G/L Account No.",GLAccount."No.");
                //    GLEntry.SETFILTER(GLEntry."Posting Date",LastYearFilter);
                //    IF GLEntry.FINDSET THEN BEGIN
                //      GLEntry.CALCSUMS(Amount);
                //     BalanceswithotherFinancialInstitutionsLast+=GLEntry.Amount;
                //      END;
                //
                //   UNTIL GLAccount.NEXT = 0;
                //
                // END;//20199
                //
                // //total liabilities
                // // GLAccount.RESET;
                // // GLAccount.SETRANGE(GLAccount."No.",'20199');
                // // IF GLAccount.FINDFIRST THEN BEGIN
                // //  GLAccount.CALCFIELDS(Balance);
                // //  TotalOtherliabilitiesNew:=GLAccount.Balance;
                // // // MESSAGE('%1',TotalOtherliabilities);
                // //  END;
                // GLAccount.RESET;
                // GLAccount.SETFILTER(GLAccount.Liquidity,'%1',GLAccount.Liquidity::TotalOtherliabilitiesNew);
                // IF GLAccount.FINDSET THEN BEGIN
                //  REPEAT
                //
                //    GLEntry.RESET;
                //    GLEntry.SETRANGE(GLEntry."G/L Account No.",GLAccount."No.");
                //    GLEntry.SETFILTER(GLEntry."Posting Date",CurrentYearFilter);
                //    IF GLEntry.FINDSET THEN BEGIN
                //      GLEntry.CALCSUMS(Amount);
                //     TotalOtherliabilitiesNew+=GLEntry.Amount;
                //    // MESSAGE('%1',TotalOtherliabilitiesNew);
                //      END;
                //
                //   UNTIL GLAccount.NEXT = 0;
                //
                // END;//20199
                // GLAccount.RESET;
                // GLAccount.SETFILTER(GLAccount.Liquidity,'%1',GLAccount.Liquidity::TotalOtherliabilitiesNew);
                // IF GLAccount.FINDSET THEN BEGIN
                //  REPEAT
                //
                //    GLEntry.RESET;
                //    GLEntry.SETRANGE(GLEntry."G/L Account No.",GLAccount."No.");
                //    GLEntry.SETFILTER(GLEntry."Posting Date",LastYearFilter);
                //    IF GLEntry.FINDSET THEN BEGIN
                //      GLEntry.CALCSUMS(Amount);
                //     TotalOtherliabilitiesNewLast+=GLEntry.Amount*-1;
                //      END;
                //
                //   UNTIL GLAccount.NEXT = 0;
                //
                // END;//20199
                //
                //
                // NETLIQUIDASSETS:=
                // LocalNotes+ForeignNotes+BalancesduetoFinanciaInstitutions+BalancesDuetootherSaccosocieties+BalanceswithCommercialBanks+BalanceswithotherFinancialInstitutions+BalanceswithotherSaccoSocieties+TreasuryBills+TreasuryBonds+TimeDeposits
                // +OverdraftsandMatured;
                // NETLIQUIDASSETSLst:=
                // LocalNotesLast+ForeignNotes+BalancesduetoFinanciaInstitutionsLast+BalancesDuetootherSaccosocieties+BalanceswithCommercialBanksLast+BalanceswithotherFinancialInstitutionsLast+BalanceswithotherSaccoSocieties+TreasuryBillsLast+TreasuryBonds
                // +TimeDeposits+OverdraftsandMatured;
                // // TotalOtherliabilities:=MaturedLiabilities+LiabilitiesMaturingwithin91Days;
                // Ratio:=NETLIQUIDASSETS/TotalOtherliabilitiesNew;
                // Ratio2:=NETLIQUIDASSETSLst/TotalOtherliabilitiesNewLast;
                // ExcessLiquidityLast:=(Ratio2)-(10/100);
                // ExcessLiquidity:=Ratio-(10/100);
            end;

            trigger OnPreDataItem()
            begin
                DateFilter := '..' + Format(AsAt);
                Date := CalcDate('-CY', Today);
                LastYear := CalcDate('-CY-1Y', Today);
                EndLastYear := CalcDate('-CY-1D', Today);
                LastYearFilter := '..' + Format(EndLastYear);
                suplusfilter := Format(LastYear) + '..' + Format(EndLastYear);
                //DateFilterCurrent:=FORMAT(Date)+'..'+FORMAT(AsAt);
                DateFilterCurrent := '..' + Format(AsAt);
                FinancialYear := Date2dmy(Date, 3);
                CurrentYearFilter := Format(Date) + '..' + Format(AsAt);
                //MESSAGE('%1',LastYearFilter);
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

    var
        DateFilter: Text;
        Date: Date;
        DateFilterCurrent: Text;
        FinancialYear: Integer;
        NETLIQUIDASSETS: Decimal;
        Maximumstatutoryratio: Decimal;
        TimeDeposits: Decimal;
        Otherliabilities: Decimal;
        OtherliabilitiesLast: Decimal;
        ExcessLiquidity: Decimal;
        BalanceswithotherFinancialInstitutionsLast: Decimal;
        NETLIQUIDASSETSLst: Decimal;
        Ratio: Decimal;
        ExcessLiquidityLast: Decimal;
        Ratio2: Decimal;
        BalanceswithotherSaccoSocieties: Decimal;
        BalancesduetoFinanciaInstitutions: Decimal;
        BalancesduetoFinanciaInstitutionsLast: Decimal;
        BalancesDuetootherSaccosocieties: Decimal;
        OverdraftsandMatured: Decimal;
        ForeignNotes: Decimal;
        TreasuryBillsLast: Decimal;
        CoreCapitalDeduction: Decimal;
        CoreCapitalDeductionLast: Decimal;
        BalanceswithCommercialBanksLast: Decimal;
        LocalNotesLast: Decimal;
        LocalNotes: Decimal;
        AsAt: Date;
        BalanceswithCommercialBanks: Decimal;
        BalanceswithotherFinancialInstitutions: Decimal;
        TotalOtherliabilitiesNew: Decimal;
        TotalOtherliabilitiesNewLast: Decimal;
        TreasuryBonds: Decimal;
        TreasuryBills: Decimal;
        LastYear: Date;
        CorecapitaltoTotalassetratioNew: Decimal;
        CorecapitaltoTotalassetratioNewLast: Decimal;
        Excess1: Decimal;
        xcessdeficiency: Decimal;
        xcessdeficiencyLast: Decimal;
        Excess11: Decimal;
        CorecapitalDepositsliabilities: Decimal;
        CorecapitalDepositsliabilitiesLast: Decimal;
        Depositsliabilitiesratio: Decimal;
        DepositsliabilitiesratioLast: Decimal;
        EndLastYear: Date;
        LastYearFilter: Text;
        suplusfilter: Text;
        GovernmentSecuritiesLast: Decimal;
        Grossnonperformingloan: Decimal;
        DepositsandBalancesatOtherInstitutionsLast: Decimal;
        CorecapitalLast: Decimal;
        TOTALOnBalanceSheetLast: Decimal;
        Sub_TotalLast: Decimal;
        BalancesheetAssetsLast: Decimal;
        CapitalGrants: Decimal;
        PropertyandEquipmentLast: Decimal;
        OtherassetsLast: Decimal;
        TotalDeductionsLast: Decimal;
        BalancesheetAssets: Decimal;
        LoansRegister: Record "Loans Register";
        GrossnonperformingloanLast: Decimal;
        Interestinsuspense: Decimal;
        InterestinsuspenseLast: Decimal;
        CapitalGrantsLast: Decimal;
        InvestmentsinSubsidiaryLast: Decimal;
        TotalDepositsLiabilitiesLast: Decimal;
        OtherDeductionsLast: Decimal;
        Totalnonperformingloan: Decimal;
        OtherDeductions: Decimal;
        TotalnonperformingloanLast: Decimal;
        Directors: Decimal;
        DirectorsLast: Decimal;
        Employees: Decimal;
        ShareCapitalLast: Decimal;
        StatutoryReserveLast: Decimal;
        EmployeesLast: Decimal;
        Totalinsiderloans: Decimal;
        TotalinsiderloansLast: Decimal;
        Allowanceforloanloss: Decimal;
        AllowanceforloanlossLast: Decimal;
        NetSurplusaftertaxLast: Decimal;
        LoansandAdvanceslast: Decimal;
        totalassetsPBSheetLast: Decimal;
        Netnonperformingloans: Decimal;
        retainedEarninsLast: Decimal;
        OtherreservesLast: Decimal;
        NetnonperformingloansLast: Decimal;
        GLAccount: Record "G/L Account";
        GLEntry: Record "G/L Entry";
        othercontigentliabilities: Decimal;
        Guaranteesandcommitments: Decimal;
        totalcontingentliabilities: Decimal;
        CashLast: Decimal;
        Corecapital: Decimal;
        CorecapitaltoTotalassetratio: Decimal;
        liquidityRatio: Decimal;
        ShareCapitalValue: Decimal;
        ShareCapital: Decimal;
        StatutoryReserve: Decimal;
        retainedEarnins: Decimal;
        NetSurplusaftertax: Decimal;
        LoansandAdvances: Decimal;
        totalassetsPBSheet: Decimal;
        GovernmentSecurities: Decimal;
        Cash: Decimal;
        InvestmentsinSubsidiary: Decimal;
        Otherreserves: Decimal;
        DepositsandBalancesatOtherInstitutions: Decimal;
        Otherassets: Decimal;
        PropertyandEquipment: Decimal;
        TotalDepositsLiabilities: Decimal;
        Sub_Total: Decimal;
        TOTALOnBalanceSheet: Decimal;
        TotalDeductions: Decimal;
        CurrentYearFilter: Text;
        CashLiquidity: Decimal;
        CashLiquidityLat: Decimal;
}

