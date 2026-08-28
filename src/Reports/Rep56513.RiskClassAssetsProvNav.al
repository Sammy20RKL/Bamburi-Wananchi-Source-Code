#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 56513 "Risk Class Assets & Prov Nav"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layout/Risk Class Of Assets & Prov.rdlc';
    Caption = 'FORM 2D';

    dataset
    {
        dataitem(Company; "Company Information")
        {
            column(ReportForNavId_1; 1)
            {
            }
            column(COMPANYNAME; Company.Name)
            {
            }
            column(AsAt; AsAt)
            {
            }
            column(LoanCount; LoanCount)
            {
            }
            column(LoanCountSubstandard; LoanCountSubstandard)
            {
            }
            column(LoanCountDoubtful; LoanCountDoubtful)
            {
            }
            column(LoanCountWatch; LoanCountWatch)
            {
            }
            column(LoanCountLoss; LoanCountLoss)
            {
            }
            column(OutstandingLoanPer; OutstandingLoanPer)
            {
            }
            column(OutstandingLoanwatch; OutstandingLoanwatch)
            {
            }
            column(OutstandingLoandoubtful; OutstandingLoandoubtful)
            {
            }
            column(OutstandingLoanSub; OutstandingLoanSub)
            {
            }
            column(OutstandingLoanloss; OutstandingLoanloss)
            {
            }
            column(LoanCountResch; LoanCountResch)
            {
            }
            column(OutstandingLoanPerResc; OutstandingLoanPerResc)
            {
            }
            column(LoanCountWatchResc; LoanCountWatchResc)
            {
            }
            column(OutstandingLoanwatchResc; OutstandingLoanwatchResc)
            {
            }
            column(LoanCountDoubtfulResc; LoanCountDoubtfulResc)
            {
            }
            column(OutstandingLoandoubtfulResc; OutstandingLoandoubtfulResc)
            {
            }
            column(LoanCountSubstandardResc; LoanCountSubstandardResc)
            {
            }
            column(OutstandingLoanSubResc; OutstandingLoanSubResc)
            {
            }
            column(LoanCountLossRec; LoanCountLossRec)
            {
            }
            column(OutstandingLoanlossResc; OutstandingLoanlossResc)
            {
            }
            column(ClassifiedNonRescheduledper; ClassifiedNonRescheduledper)
            {
            }
            column(ClassifiedNonRescheduledDoubtful; ClassifiedNonRescheduledDoubtful)
            {
            }
            column(ClassifiedNonRescheduledLoss; ClassifiedNonRescheduledLoss)
            {
            }
            column(ClassifiedNonRescheduledsubstandard; ClassifiedNonRescheduledsubstandard)
            {
            }
            column(ClassifiedNonRescheduledWatch; ClassifiedNonRescheduledWatch)
            {
            }
            column(ClassifiedRescheduledLoss; ClassifiedRescheduledLoss)
            {
            }
            column(ClassifiedRescheduledPer; ClassifiedRescheduledPer)
            {
            }
            column(ClassifiedRescheduledSubstandard; ClassifiedRescheduledSubstandard)
            {
            }
            column(ClassifiedRescheduledWatch; ClassifiedRescheduledWatch)
            {
            }
            column(ClassifiedRescheduledDoubtful; ClassifiedRescheduledDoubtful)
            {
            }
            column(subtotal; subtotal)
            {
            }
            column(TotalClassffiedRecheduled; TotalClassffiedRecheduled)
            {
            }
            column(TotalClassffied; TotalClassffied)
            {
            }
            column(subtotalRescheduled; subtotalRescheduled)
            {
            }
            column(Subtotalcount; Subtotalcount)
            {
            }
            column(SubtotalcountResc; SubtotalcountResc)
            {
            }
            column(GRANDTOTAL; GRANDTOTAL)
            {
            }
            column(GRANDTOTALCOUNT; GRANDTOTALCOUNT)
            {
            }
            column(GRANDTOTALCLASSIF; GRANDTOTALCLASSIF)
            {
            }
            column(YearBeginDate; YearBeginDate)
            {
            }
            column(FinancialYear; FinancialYear)
            {
            }

            trigger OnAfterGetRecord()
            var
                CurrOutstandingBalance: Decimal;
            begin
                DateFilter := '..' + Format(AsAt);
                FinancialYear := Date2dmy(AsAt, 3);
                YearBeginDate := CalcDate('-CY', AsAt);

                // Reset all accumulators
                LoanCount := 0;
                OutstandingLoanPer := 0;
                LoanCountWatch := 0;
                OutstandingLoanwatch := 0;
                LoanCountDoubtful := 0;
                OutstandingLoandoubtful := 0;
                LoanCountSubstandard := 0;
                OutstandingLoanSub := 0;
                LoanCountLoss := 0;
                OutstandingLoanloss := 0;
                LoanCountResch := 0;
                OutstandingLoanPerResc := 0;
                LoanCountWatchResc := 0;
                OutstandingLoanwatchResc := 0;
                LoanCountDoubtfulResc := 0;
                OutstandingLoandoubtfulResc := 0;
                LoanCountSubstandardResc := 0;
                OutstandingLoanSubResc := 0;
                LoanCountLossRec := 0;
                OutstandingLoanlossResc := 0;

                // ---- SINGLE PASS over Loans Register (was 10 separate Find loops) ----
                LoansRegister.Reset();
                LoansRegister.SetFilter(LoansRegister."Date filter", DateFilter);
                LoansRegister.SetAutoCalcFields("Outstanding Balance");
                if LoansRegister.FindSet() then
                    repeat
                        CurrOutstandingBalance := LoansRegister."Outstanding Balance";

                        if not LoansRegister.Rescheduled then begin
                            // ---- NON-RESCHEDULED ----
                            case LoansRegister."Loans Category-SASRA" of
                                LoansRegister."Loans Category-SASRA"::Perfoming:
                                    begin
                                        // original: no Reversed filter applied
                                        LoanCount += 1;
                                        OutstandingLoanPer += CurrOutstandingBalance;
                                    end;
                                LoansRegister."Loans Category-SASRA"::Watch:
                                    begin
                                        // original: no Reversed filter applied
                                        LoanCountWatch += 1;
                                        OutstandingLoanwatch += CurrOutstandingBalance;
                                    end;
                                LoansRegister."Loans Category-SASRA"::Doubtful:
                                    if not LoansRegister.Reversed then begin
                                        LoanCountDoubtful += 1;
                                        OutstandingLoandoubtful += CurrOutstandingBalance;
                                    end;
                                LoansRegister."Loans Category-SASRA"::Substandard:
                                    // LoanCountSubstandard/OutstandingLoanSub (name/filter mismatch preserved as-is)
                                    if not LoansRegister.Reversed then begin
                                        LoanCountSubstandard += 1;
                                        OutstandingLoanSub += CurrOutstandingBalance;
                                    end;
                                LoansRegister."Loans Category-SASRA"::Loss:
                                    if (not LoansRegister.Reversed) and (LoansRegister."Loan  No." <> ' ') then begin
                                        LoanCountLoss += 1;
                                        OutstandingLoanloss += CurrOutstandingBalance;
                                    end;
                            end;
                        end else begin
                            // ---- RESCHEDULED ----
                            case LoansRegister."Loans Category-SASRA" of
                                LoansRegister."Loans Category-SASRA"::Perfoming:
                                    begin
                                        // original: no Reversed filter applied
                                        LoanCountResch += 1;
                                        OutstandingLoanPerResc += CurrOutstandingBalance;
                                    end;
                                LoansRegister."Loans Category-SASRA"::Watch:
                                    if not LoansRegister.Reversed then begin
                                        LoanCountWatchResc += 1;
                                        OutstandingLoanwatchResc += CurrOutstandingBalance;
                                    end;
                                LoansRegister."Loans Category-SASRA"::Doubtful:
                                    if not LoansRegister.Reversed then begin
                                        LoanCountDoubtfulResc += 1;
                                        OutstandingLoandoubtfulResc += CurrOutstandingBalance;
                                    end;
                                LoansRegister."Loans Category-SASRA"::Substandard:
                                    if not LoansRegister.Reversed then begin
                                        LoanCountSubstandardResc += 1;
                                        OutstandingLoanSubResc += CurrOutstandingBalance;
                                    end;
                                LoansRegister."Loans Category-SASRA"::Loss:
                                    // original also filtered Outstanding Balance <> 0 for this bucket
                                    if (not LoansRegister.Reversed) and (CurrOutstandingBalance <> 0) then begin
                                        LoanCountLossRec += 1;
                                        OutstandingLoanlossResc += CurrOutstandingBalance;
                                    end;
                            end;
                        end;
                    until LoansRegister.Next() = 0;
                // ---- END single pass ----

                ClassifiedNonRescheduledper := Round(OutstandingLoanPer * 1 / 100, 0.01, '<');
                ClassifiedNonRescheduledDoubtful := Round(OutstandingLoandoubtful * 50 / 100, 0.01, '<');
                ClassifiedNonRescheduledLoss := Round(OutstandingLoanloss * 100 / 100, 0.01, '<');
                ClassifiedNonRescheduledsubstandard := Round(OutstandingLoanSub * 25 / 100, 0.01, '<');
                ClassifiedNonRescheduledWatch := Round(OutstandingLoanwatch * 5 / 100, 0.01, '<');
                ClassifiedRescheduledLoss := Round(OutstandingLoanlossResc * 100 / 100, 0.01, '<');
                ClassifiedRescheduledPer := Round(OutstandingLoanPerResc * 1 / 100, 0.01, '<');
                ClassifiedRescheduledSubstandard := Round(OutstandingLoanSubResc * 25 / 100, 0.01, '<');
                ClassifiedRescheduledWatch := Round(OutstandingLoanwatchResc * 5 / 100, 0.01, '<');
                ClassifiedRescheduledDoubtful := Round(OutstandingLoandoubtfulResc * 50 / 100, 0.01, '<');

                subtotal := OutstandingLoandoubtful + OutstandingLoanloss + OutstandingLoanPer + OutstandingLoanSub + OutstandingLoanwatch;
                subtotalRescheduled := OutstandingLoandoubtfulResc + OutstandingLoanlossResc + OutstandingLoanPerResc + OutstandingLoanSubResc + OutstandingLoanwatchResc;
                TotalClassffied := ClassifiedNonRescheduledDoubtful + ClassifiedNonRescheduledLoss + ClassifiedNonRescheduledper + ClassifiedNonRescheduledsubstandard + ClassifiedNonRescheduledWatch;
                TotalClassffiedRecheduled := ClassifiedRescheduledDoubtful + ClassifiedRescheduledPer + ClassifiedRescheduledSubstandard + ClassifiedRescheduledWatch + ClassifiedRescheduledLoss;
                Subtotalcount := LoanCount + LoanCountDoubtful + LoanCountLoss + LoanCountSubstandard + LoanCountWatch;
                SubtotalcountResc := LoanCountDoubtfulResc + LoanCountLossRec + LoanCountResch + LoanCountSubstandardResc + LoanCountWatchResc;

                GRANDTOTAL := subtotal + subtotalRescheduled;
                GRANDTOTALCOUNT := Subtotalcount + SubtotalcountResc;
                GRANDTOTALCLASSIF := TotalClassffied + TotalClassffiedRecheduled;
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
        LoansRegister: Record "Loans Register";
        LoanCount: Integer;
        DateFilter: Text;
        AsAt: Date;
        LoanCountWatch: Integer;
        FinancialYear: Integer;
        YearBeginDate: Date;
        LoanCountDoubtful: Integer;
        LoanCountSubstandard: Integer;
        LoanCountLoss: Integer;
        OutstandingLoanPer: Decimal;
        OutstandingLoanwatch: Decimal;
        OutstandingLoanSub: Decimal;
        OutstandingLoanloss: Decimal;
        OutstandingLoandoubtful: Decimal;
        LoanCountResch: Integer;
        OutstandingLoanPerResc: Decimal;
        LoanCountWatchResc: Integer;
        OutstandingLoanwatchResc: Decimal;
        LoanCountDoubtfulResc: Integer;
        OutstandingLoandoubtfulResc: Decimal;
        LoanCountSubstandardResc: Integer;
        OutstandingLoanSubResc: Decimal;
        LoanCountLossRec: Integer;
        OutstandingLoanlossResc: Decimal;
        ClassifiedNonRescheduledper: Decimal;
        ClassifiedNonRescheduledWatch: Decimal;
        ClassifiedNonRescheduledDoubtful: Decimal;
        ClassifiedNonRescheduledsubstandard: Decimal;
        ClassifiedNonRescheduledLoss: Decimal;
        ClassifiedRescheduledPer: Decimal;
        ClassifiedRescheduledWatch: Decimal;
        ClassifiedRescheduledDoubtful: Decimal;
        ClassifiedRescheduledSubstandard: Decimal;
        ClassifiedRescheduledLoss: Decimal;
        subtotal: Decimal;
        subtotalRescheduled: Decimal;
        TotalClassffied: Decimal;
        TotalClassffiedRecheduled: Decimal;
        Subtotalcount: Integer;
        SubtotalcountResc: Integer;
        GRANDTOTALCLASSIF: Decimal;
        GRANDTOTAL: Decimal;
        GRANDTOTALCOUNT: Integer;
        // CUSurefactory: Codeunit UnknownCodeunit51516025;
        PrevMonthDate: Date;
}