#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50207 "SASRA Loans Classification"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/SASRA Loans Classification.rdlc';
    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            DataItemTableView = sorting("Client Code") order(ascending) where(Posted = const(true));
            RequestFilterFields = Source, "Client Code", "Loan Product Type", "Loan  No.", "Issued Date", "Date filter";
            column(ReportForNavId_1120054000; 1120054000)
            {
            }
            column(PerformingDisplay; PerformingDisplay)
            {
            }
            column(InterestArrears; InterestArrears)
            {
            }
            column(Last_Pay_Date; "Last Pay Date")
            {
            }
            column(Expected_Date_of_Completion; "Expected Date of Completion")
            {
            }
            column(WatchDisplay; WatchDisplay)
            {
            }
            column(StandardDisplay; StandardDisplay)
            {
            }
            column(DoubtfulDisplay; DoubtfulDisplay)
            {
            }
            column(LossDisplay; LossDisplay)
            {
            }
            column(AmountInArrearsDisplay; AmountInArrearsDisplay)
            {
            }
            column(LoanProductType_LoansRegister; "Loans Register"."Loan Product Type Name")
            {
            }
            column(ClientCode_LoansRegister; "Loans Register"."Client Code")
            {
            }
            column(RequestedAmount_LoansRegister; "Loans Register"."Requested Amount")
            {
            }
            column(ApprovedAmount_LoansRegister; "Loans Register"."Amount To Disburse")// "Schedule Loan Amount Issued")
            {
            }
            column(OutstandingBalance_LoansRegister; "Loans Register"."Outstanding Balance")
            {
            }
            column(OustandingInterest_LoansRegister; "Loans Register"."Oustanding Interest")
            {
            }
            column(LoanNo_LoansRegister; "Loans Register"."Loan  No.")
            {
            }
            column(IssuedDate_LoansRegister; "Loans Register"."Issued Date")
            {
            }
            column(ClientName_LoansRegister; "Loans Register"."Client Name")
            {
            }
            column(NextCount; NextCount)
            {
            }

            trigger OnAfterGetRecord()
            begin
                LoansReg.Reset();
                LoansReg.SetRange(LoansReg."Loan  No.", "Loans Register"."Loan  No.");
                LoansReg.SetFilter(LoansReg."Date filter", DateFilter);
                LoansReg.SetFilter(LoansReg."Issued Date", '..' + Format(AsAt)); // Filter records based on AsAt date
                LoansReg.SetAutoCalcFields(
                    LoansReg."Scheduled Principle Payments",
                    LoansReg."Schedule Loan Amount Issued",
                    LoansReg."Schedule Installments",
                    LoansReg."Outstanding Balance",
                    LoansReg."Oustanding Interest",
                    LoansReg."Scheduled Interest Payments",
                    LoansReg."Interest Paid"
                );

                if not LoansReg.IsEmpty() then begin
                    repeat
                        LoansClassificationCodeUnit.FnClassifyLoan(LoansReg."Loan  No.", AsAt);
                    until LoansReg.Next = 0;
                end else begin
                    if LoansReg.Posted then begin
                        LoansReg."Loans Category-SASRA" := LoansReg."Loans Category-SASRA"::Perfoming;
                        LoansReg.Modify(true);
                    end;
                end;

                // Calculate Current Loan Balance
                CurrentLoanBalance := LoansReg."Outstanding Balance";

                // Calculate Loan Arrears using MaxValue function
                LoanArrears := MaxValue(LoansReg."Principal In Arrears", 0);

                // Calculate Interest Arrears
                if LoansReg.Source = LoansReg.Source::BOSA then begin
                    InterestArrears := MaxValue(LoansReg."Oustanding Interest", 0);

                    // Calculate Days in Arrears
                    DaysInArrears := ROUND((LoansReg."No of Months in Arrears" * 30), 1, '>');

                    // Determine Loan Classification
                    NoOfMonthsInArrears := LoansReg."No of Months in Arrears";

                    case LoansReg."Loans Category-SASRA" of
                        LoansReg."Loans Category-SASRA"::Perfoming:
                            PerformingDisplay := CurrentLoanBalance;
                        LoansReg."Loans Category-SASRA"::Watch:
                            WatchDisplay := CurrentLoanBalance;
                        LoansReg."Loans Category-SASRA"::Substandard:
                            StandardDisplay := CurrentLoanBalance;
                        LoansReg."Loans Category-SASRA"::Doubtful:
                            DoubtfulDisplay := CurrentLoanBalance;
                        LoansReg."Loans Category-SASRA"::Loss:
                            LossDisplay := CurrentLoanBalance;
                    end;

                    AmountInArrearsDisplay := LoanArrears;
                end
                else if (LoansReg."Expected Date of Completion" <> 0D) and (DateBD > LoansReg."Expected Date of Completion") then begin
                    LossDisplay := CurrentLoanBalance;
                    AmountInArrearsDisplay := LoanArrears;
                end;

                // Skip if all classification displays are zero
                if (PerformingDisplay = 0) and (WatchDisplay = 0) and (StandardDisplay = 0)
                    and (DoubtfulDisplay = 0) and (LossDisplay = 0) OR (LoansReg."Schedule Repayments" = 0) then begin
                    CurrReport.Skip;
                end;

                NextCount += 1;
            end;

            trigger OnPreDataItem()
            begin
                //DateFilter := '..' + Format(AsAt);

                // Apply Date Filter for Loan Disbursement
                "Loans Register".SetFilter("Loans Register"."Loan Disbursement Date", DateFilter);

                // Ensure only loans with scheduled repayments are considered
                "Loans Register".CalcFields("Loans Register"."Schedule Repayments");
                "Loans Register".SetFilter("Loans Register"."Schedule Repayments", '>%1', 0);

                // Initialize all variables to zero to prevent carrying over values from previous records
                ExpectedLoanBal := 0;
                NoOfMonthsInArrears := 0;
                LoanArrears := 0;
                CurrentLoanBalance := 0;
                DaysInArrears := 0;
                NextCount := 0;
                InterestArrears := 0;
                PerformingDisplay := 0;
                WatchDisplay := 0;
                StandardDisplay := 0;
                DoubtfulDisplay := 0;
                LossDisplay := 0;
                AmountInArrearsDisplay := 0;
            end;



        }
    }

    requestpage
    {

        layout
        {
            area(content)
            { field(AsAt; AsAt) { } }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    var
    // RegenerateOldLoansData: Codeunit "Regenerate Schedule for loans";
    begin
        //..........................................................
        if AsAt = 0D then
            AsAt := DMY2Date(1, 1, Date2DMY(Today, 3));

        DateFilter := '..' + Format(AsAt);

        // if not Evaluate(DateBD, DateFilter) then
        //     Error('Invalid date format');

    end;

    local procedure MaxValue(Value1: Decimal; Value2: Decimal): Decimal
    begin
        if Value1 > Value2 then
            exit(Value1)
        else
            exit(Value2);
    end;


    var
        LoansReg: Record "Loans Register";
        LoansClassificationCodeUnit: Codeunit LoansClassificationCodeUnit;
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
        InterestInArrearsDisplay: Decimal;
        LoanCategoryDisplay: Text;
        DateBD: Date;
        PerformingDisplay: Decimal;
        WatchDisplay: Decimal;
        StandardDisplay: Decimal;
        DoubtfulDisplay: Decimal;
        LossDisplay: Decimal;
        NextCount: Integer;
        AsAt: Date;
        Day: Integer;
        Month: Integer;
        Year: Integer;
}

