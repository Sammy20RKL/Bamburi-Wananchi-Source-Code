#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50296 "Loan Monthly Expectation"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Loan Monthly Expectation.rdlc';
    Caption = 'Loans Collection Targets Report';

    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            //DataItemTableView = where(Posted = const(true));
            DataItemTableView = sorting("Client Code") order(ascending) where(Posted = const(true));
            RequestFilterFields = Source, "Loan Product Type", "Loan  No.", "Client Code", "Branch Code", "Date filter";
            column(ReportForNavId_1; 1)
            {
            }
            column(TotalExpectedRepayment; TotalExpectedRepayment)
            {
            }
            column(ClientCode_Loans; "Loans Register"."Client Code")
            {
            }
            column(ClientName_Loans; "Loans Register"."Client Name")
            {
            }
            column(OutstandingBalance_Loans; CurrentLoanBalance)
            {
            }
            column(LoanProductType_Loans; "Loans Register"."Loan Product Type")
            {
            }
            column(IssuedDate_Loans; "Loans Register"."Issued Date")
            {
            }
            column(LoanNo_Loans; "Loans Register"."Loan  No.")
            {
            }
            column(Entry; NextCount)
            {
            }
            column(ArrearAmounts; LoanArrears)
            {
            }
            column(OutstandingInterest; InterestArrears)
            {
            }

            trigger OnAfterGetRecord()
            begin
                LoansReg.SetFilter(LoansReg."Date filter", DateFilter);
                LoansReg.SetFilter(LoansReg."Issued Date", DateFilter);
                if LoansReg.Get("Loans Register"."Loan  No.") then begin
                    LoansReg.SetAutocalcFields(LoansReg."Scheduled Principle Payments", LoansReg."Schedule Loan Amount Issued", LoansReg."Schedule Installments", LoansReg."Outstanding Balance", LoansReg."Oustanding Interest", LoansReg."Scheduled Interest Payments", LoansReg."Interest Paid");
                    //..........Expected Loan Balance
                    ExpectedLoanBal := 0;
                    ExpectedLoanBal := LoansReg."Schedule Loan Amount Issued" - LoansReg."Scheduled Principle Payments";
                    //...........Current Loan Balance
                    CurrentLoanBalance := 0;
                    CurrentLoanBalance := LoansReg."Outstanding Balance";
                    //...........Calculate Loan Arrears(Principle Arrears)
                    LoanArrears := 0;
                    PrepaidAmounts := 0;
                    LoanArrears := CurrentLoanBalance - ExpectedLoanBal;
                    if LoanArrears < 0 then begin
                        LoanArrears := 0;
                        PrepaidAmounts := (LoanArrears) * -1;
                    end else
                        if LoanArrears > 0 then begin
                            LoanArrears := LoanArrears;
                            PrepaidAmounts := 0;
                        end;
                    //...........................Interest Arrears
                    if LoansReg.Source = LoansReg.Source::BOSA then begin
                        InterestArrears := 0;
                        InterestArrears := LoansReg."Oustanding Interest";
                        if InterestArrears < 0 then begin
                            InterestArrears := 0;
                        end;
                    end else
                        if LoansReg.Source = LoansReg.Source::FOSA then begin
                            InterestArrears := 0;
                            if (LoansReg."Loan Product Type" <> 'OKOA') AND (LoansReg."Loan Product Type" <> 'OVERDRAFT') THEN begin
                                InterestArrears := LoansReg."Oustanding Interest";
                                if InterestArrears < 0 then begin
                                    InterestArrears := 0;
                                end;
                            end ELSE begin
                                if loansreg."Issued Date" < 20230807D then begin
                                    InterestArrears := LoansReg."Oustanding Interest";
                                end else
                                    if loansreg."Issued Date" >= 20230807D then begin
                                        InterestArrears := (LoansReg."Scheduled Interest Payments") - (LoansReg."Interest Paid");
                                    end;
                                if InterestArrears < 0 then begin
                                    InterestArrears := 0;
                                end;
                            end;
                        end else
                            if LoansReg.Source = LoansReg.Source::MICRO then begin
                                InterestArrears := 0;
                                if loansreg."Issued Date" < 20230807D then begin
                                    InterestArrears := LoansReg."Oustanding Interest";
                                end else
                                    if loansreg."Issued Date" >= 20230807D then begin
                                        InterestArrears := (LoansReg."Scheduled Interest Payments") - (LoansReg."Interest Paid");
                                    end;
                                if InterestArrears < 0 then begin
                                    InterestArrears := 0;
                                end;
                            end;
                    //.........................Expected Pay
                    TotalExpectedRepayment := 0;
                    TotalExpectedRepayment := InterestArrears + LoanArrears;
                    //..........................................
                    if (CurrentLoanBalance <= 0) then begin
                        CurrReport.Skip;
                    end;
                    if LoansReg."Issued Date" > AsAt then CurrReport.Skip;
                    NextCount := NextCount + 1;
                end;
            end;

            trigger OnPreDataItem()
            begin
                PrepaidAmounts := 0;
                ExpectedLoanBal := 0;
                NoOfMonthsInArrears := 0;
                LoanArrears := 0;
                CurrentLoanBalance := 0;
                DaysInArrears := 0;
                NextCount := 0;
                InterestArrears := 0;
                TotalExpectedRepayment := 0;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
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

        DateFilter := "Loans Register".GetFilter("Loans Register"."Date filter");
        if DateFilter = '' then begin
            DateFilter := '..' + Format(Today);
        end;
        if CopyStr(DateFilter, 1, 2) <> '..' then begin
            Error('The Date filter used Must have a period,e.g %1', '..' + Format(DateFilter));
        end;

        AsAt := 0D;
        Evaluate(AsAt, CopyStr(DateFilter, 3, 100));//Assign As At
    end;

    var
        LoansReg: Record "Loans Register";
        DateFilter: Text;
        ExpectedLoanBal: Decimal;
        CurrentLoanBalance: Decimal;
        LoanArrears: Decimal;
        NoOfMonthsInArrears: Decimal;
        DaysInArrears: Decimal;
        LoanBalanceDisplay: Decimal;
        InterestArrears: Decimal;
        DaysInArrearsDisplay: Integer;
        AmountInArrearsDisplay: Decimal;
        TotalExpectedRepayment: Decimal;
        InterestInArrearsDisplay: Decimal;
        LoanCategoryDisplay: Text;
        PerformingDisplay: Decimal;
        WatchDisplay: Decimal;
        StandardDisplay: Decimal;
        DoubtfulDisplay: Decimal;
        LossDisplay: Decimal;
        NextCount: Integer;
        PrepaidAmounts: Decimal;
        AsAt: Date;
        Day: Integer;
        Month: Integer;
        Year: Integer;
}

