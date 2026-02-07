report 51015 "Dividend and Interest Register"
{
    UsageCategory = Tasks;
    RDLCLayout = './DividendsInterestRegister.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", Status;

            column(CompanyName; COMPANYNAME) { }
            column(ReportTitle; 'DIVIDEND AND INTEREST REGISTER') { }
            column(CustomerNo; Customer."No.") { }
            column(CustomerName; Customer.Name) { }
            column(CurrentShares; Customer."Current Shares") { }
            column(SharesRetained; "Shares Retained") { }

            // Share Capital Section
            column(ShareCapitalDesc; ShareCapitalDesc) { }
            column(ShareCapitalTotal; ShareCapitalTotal) { }
            column(ShareCapitalQualifying; ShareCapitalQualifying) { }
            column(ShareCapitalGross; ShareCapitalGross) { }

            // Summary Section
            column(DepositTotalAmount; DepositTotalAmount) { }
            column(DepositQualifyingAmount; DepositQualifyingAmount) { }
            column(DepositRate; DepositRate) { }
            column(DepositGrossEarned; DepositGrossEarned) { }
            column(DepositWTaxPercent; DepositWTaxPercent) { }
            column(DepositNetEarned; DepositNetEarned) { }

            column(ShareCapitalTotalAmt; ShareCapitalTotalAmt) { }
            column(ShareCapitalQualifyingAmt; ShareCapitalQualifyingAmt) { }
            column(ShareCapitalRatePercent; ShareCapitalRatePercent) { }
            column(ShareCapitalGrossAmt; ShareCapitalGrossAmt) { }
            column(ShareCapitalWTaxPercent; ShareCapitalWTaxPercent) { }
            column(ShareCapitalNetAmt; ShareCapitalNetAmt) { }

            column(GrandTotalGross; GrandTotalGross) { }
            column(GrandTotalWTax; GrandTotalWTax) { }
            column(GrandTotalNet; GrandTotalNet) { }

            dataitem("Dividends Progression"; "Dividends Progression")
            {
                DataItemLink = "Member No" = field("No.");
                DataItemTableView = sorting("Member No", Date);

                column(ProgressionDesc; ProgressionDesc) { }
                column(ProgressionTotal; "Gross Interest On Deposit") { }
                column(ProgressionQualifying; "Current Shares") { }
                column(ProgressionGross; "Gross Dividends") { }

                trigger OnAfterGetRecord()
                begin
                    ProgressionDesc := Format(Date, 0, '<Month Text> <Year4>');
                end;
            }

            trigger OnPreDataItem()
            begin
                Cust.Reset();
                Cust.ModifyAll(Cust."Net Dividend Payable", 0);
            end;

            trigger OnAfterGetRecord()
            var
                MonthDate: Date;
                MonthName: Text[30];
            begin
                // Initialize variables
                InitializeVariables();

                if "From Date" = 0D then
                    Error('You must specify start Date.');

                GenSetUp.Get();

                // Delete existing progression records
                DivProg.Reset();
                DivProg.SetRange("Member No", Customer."No.");
                if DivProg.FindFirst() then
                    DivProg.DeleteAll();

                // Calculate for 12 months
                CalculateMonthlyDividends();

                // Prepare Share Capital Section (December only)
                ShareCapitalDesc := 'December ' + Format(Date2DMY("From Date", 3));
                ShareCapitalTotal := ShareCapitalQualifying;
                ShareCapitalGross := TotalShareCapitalDiv;

                // Prepare Summary Section
                PrepareSummarySection();

                Customer."Net Dividend Payable" := DivTotal;
                Customer.Modify();

                TotalPay := DivTotal - WthTAxTotal;
            end;
        }
    }

    requestpage
    {
        SaveValues = false;

        layout
        {
            area(content)
            {
                field(FromDate; "From Date")
                {
                    ApplicationArea = All;
                    Caption = 'From Date';
                }
            }
        }
    }

    local procedure InitializeVariables()
    begin
        DivTotal := 0;
        WthTAxTotal := 0;
        TotalPay := 0;
        TotalShareCapitalDiv := 0;
        TotalDepositInterest := 0;
        ShareCapitalQualifying := 0;
        DepositQualifying := 0;

        DepositTotalAmount := 0;
        DepositQualifyingAmount := 0;
        DepositGrossEarned := 0;
        DepositNetEarned := 0;

        ShareCapitalTotalAmt := 0;
        ShareCapitalQualifyingAmt := 0;
        ShareCapitalGrossAmt := 0;
        ShareCapitalNetAmt := 0;

        GrandTotalGross := 0;
        GrandTotalWTax := 0;
        GrandTotalNet := 0;
    end;

    local procedure CalculateMonthlyDividends()
    var
        MonthCounter: Integer;
        FromDateCalc: Date;
        ToDateCalc: Date;
        DateFilterText: Text[100];
        FromDateText: Text[100];
        ToDateText: Text[100];
        CDiv: Decimal;
        CInterest: Decimal;
        MonthlyTotal: Decimal;
        MonthlyWTax: Decimal;
        TimeMultiplier: Decimal;
    begin
        for MonthCounter := 0 to 11 do begin
            // Calculate date range for this month
            if MonthCounter = 0 then begin
                FromDateCalc := "From Date";
                ToDateCalc := CalcDate('-1D', CalcDate('1M', "From Date"));
                TimeMultiplier := 11 / 12;
            end else begin
                FromDateCalc := CalcDate(Format(MonthCounter) + 'M', "From Date");
                ToDateCalc := CalcDate('-1D', CalcDate(Format(MonthCounter + 1) + 'M', "From Date"));
                TimeMultiplier := (11 - MonthCounter) / 12;
            end;

            Evaluate(FromDateText, Format(FromDateCalc));
            Evaluate(ToDateText, Format(ToDateCalc));
            DateFilterText := FromDateText + '..' + ToDateText;

            // Get customer data for this period
            Cust.Reset();
            Cust.SetCurrentKey("No.");
            Cust.SetRange("No.", Customer."No.");
            Cust.SetFilter("Date Filter", DateFilterText);

            if Cust.FindFirst() then begin
                Cust.CalcFields("Current Shares", "Shares Retained");

                if Cust."Current Shares" <> 0.01 then begin
                    // Calculate dividends on share capital
                    CDiv := (GenSetUp."Interest on Share Capital(%)" / 100) * Cust."Shares Retained";

                    // Calculate interest on deposits
                    if Cust."Current Shares" > 0 then
                        CInterest := (GenSetUp."Interest On Current Shares" / 100) * (Cust."Current Shares" * TimeMultiplier)
                    else
                        CInterest := 0;

                    MonthlyTotal := CDiv + CInterest;
                    MonthlyWTax := MonthlyTotal * (GenSetUp."Withholding Tax (%)" / 100);

                    // Accumulate totals
                    TotalShareCapitalDiv += CDiv;
                    TotalDepositInterest += CInterest;
                    DivTotal += MonthlyTotal;
                    WthTAxTotal += MonthlyWTax;

                    ShareCapitalQualifying := Cust."Shares Retained";
                    DepositQualifying += Cust."Current Shares";

                    // Insert progression record
                    DivProg.Init();
                    DivProg."Member No" := Customer."No.";
                    DivProg.Date := ToDateCalc;
                    DivProg."Gross Dividends" := MonthlyTotal;
                    DivProg."Gross Interest On Deposit" := Cust."Current Shares";
                    DivProg."Gross Interest On Sharecapital" := CDiv;
                    DivProg."Qualifying Share Capital" := Cust."Shares Retained";
                    DivProg."Witholding Tax" := MonthlyWTax;
                    DivProg."Net Dividends" := MonthlyTotal - MonthlyWTax;
                    DivProg."Qualifying Shares" := Cust."Current Shares";
                    DivProg.Shares := Cust."Current Shares";
                    DivProg."Share Capital" := Cust."Shares Retained";
                    DivProg."Current Shares" := Cust."Current Shares";
                    DivProg.Insert();
                end;
            end;
        end;
    end;

    local procedure PrepareSummarySection()
    var
        DepositWTax: Decimal;
        ShareCapitalWTax: Decimal;
    begin
        // Interest on Deposit Summary
        DepositTotalAmount := DepositQualifying;
        DepositQualifyingAmount := DepositQualifying;
        DepositRate := GenSetUp."Interest On Current Shares";
        DepositGrossEarned := TotalDepositInterest;
        DepositWTaxPercent := GenSetUp."Withholding Tax (%)";
        DepositWTax := DepositGrossEarned * (DepositWTaxPercent / 100);
        DepositNetEarned := DepositGrossEarned - DepositWTax;

        // Dividend on Share Capital Summary
        ShareCapitalTotalAmt := ShareCapitalQualifying;
        ShareCapitalQualifyingAmt := ShareCapitalQualifying;
        ShareCapitalRatePercent := GenSetUp."Interest on Share Capital(%)";
        ShareCapitalGrossAmt := TotalShareCapitalDiv;
        ShareCapitalWTaxPercent := GenSetUp."Withholding Tax (%)";
        ShareCapitalWTax := ShareCapitalGrossAmt * (ShareCapitalWTaxPercent / 100);
        ShareCapitalNetAmt := ShareCapitalGrossAmt - ShareCapitalWTax;

        // Grand Totals
        GrandTotalGross := DepositGrossEarned + ShareCapitalGrossAmt;
        GrandTotalWTax := DepositWTax + ShareCapitalWTax;
        GrandTotalNet := DepositNetEarned + ShareCapitalNetAmt;
    end;

    var
        Cust: Record Customer;
        GenSetUp: Record "Sacco General Set-Up";
        DivProg: Record "Dividends Progression";
        "From Date": Date;
        DivTotal: Decimal;
        WthTAxTotal: Decimal;
        TotalPay: Decimal;

        // Share Capital variables
        ShareCapitalDesc: Text[50];
        ShareCapitalTotal: Decimal;
        ShareCapitalQualifying: Decimal;
        ShareCapitalGross: Decimal;
        TotalShareCapitalDiv: Decimal;

        // Deposit variables
        TotalDepositInterest: Decimal;
        DepositQualifying: Decimal;
        ProgressionDesc: Text[50];

        // Summary variables
        DepositTotalAmount: Decimal;
        DepositQualifyingAmount: Decimal;
        DepositRate: Decimal;
        DepositGrossEarned: Decimal;
        DepositWTaxPercent: Decimal;
        DepositNetEarned: Decimal;

        ShareCapitalTotalAmt: Decimal;
        ShareCapitalQualifyingAmt: Decimal;
        ShareCapitalRatePercent: Decimal;
        ShareCapitalGrossAmt: Decimal;
        ShareCapitalWTaxPercent: Decimal;
        ShareCapitalNetAmt: Decimal;

        GrandTotalGross: Decimal;
        GrandTotalWTax: Decimal;
        GrandTotalNet: Decimal;
}