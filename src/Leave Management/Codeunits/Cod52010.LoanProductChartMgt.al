codeunit 52010 "Loan Products Chart Mgt."
{
    procedure UpdateData(var BusChartBuf: Record "Business Chart Buffer")
    var
        LoanProduct: Record "Loan Products Setup";
        LoansReg: Record "Loans Register";
        DescToColIndex: Dictionary of [Text[249], Integer];
        ColTotalApproved: List of [Decimal];
        ColLoanCount: List of [Integer];
        TotalApproved: Decimal;
        LoanCount: Integer;
        ColIndex: Integer;
        ExistingColIndex: Integer;
        UpdatedApproved: Decimal;
        UpdatedCount: Integer;
    begin
        BusChartBuf.Initialize();
        BusChartBuf.SetXAxis('Loan Product', BusChartBuf."Data Type"::String);
        BusChartBuf.AddDecimalMeasure(
            'Outstanding Balance', 0, Enum::"Business Chart Type"::Funnel);
        BusChartBuf.AddIntegerMeasure(
            'Active Loans', 0, Enum::"Business Chart Type"::Funnel);

        ColIndex := 0;
        LoanProduct.Reset();
        if LoanProduct.FindSet() then
            repeat
                LoansReg.Reset();
                LoansReg.SetRange("Loan Product Type", LoanProduct.Code);
                LoansReg.SetRange(Posted, true);
                LoansReg.CalcSums("Approved Amount");
                TotalApproved := LoansReg."Approved Amount";
                LoanCount := LoansReg.Count();

                if TotalApproved > 0 then begin
                    if DescToColIndex.Get(LoanProduct."Product Description", ExistingColIndex) then begin
                        // Description already has a column — merge totals into it
                        UpdatedApproved := ColTotalApproved.Get(ExistingColIndex + 1) + TotalApproved;
                        UpdatedCount := ColLoanCount.Get(ExistingColIndex + 1) + LoanCount;
                        ColTotalApproved.Set(ExistingColIndex + 1, UpdatedApproved);
                        ColLoanCount.Set(ExistingColIndex + 1, UpdatedCount);

                        BusChartBuf.SetValueByIndex(0, ExistingColIndex, UpdatedApproved);
                        BusChartBuf.SetValueByIndex(1, ExistingColIndex, UpdatedCount);
                    end else begin
                        // New description — new column
                        BusChartBuf.AddColumn(LoanProduct."Product Description");
                        BusChartBuf.SetValueByIndex(0, ColIndex, TotalApproved);
                        BusChartBuf.SetValueByIndex(1, ColIndex, LoanCount);

                        DescToColIndex.Add(LoanProduct."Product Description", ColIndex);
                        ColTotalApproved.Add(TotalApproved);
                        ColLoanCount.Add(LoanCount);

                        ColIndex += 1;
                    end;
                end;
            until LoanProduct.Next() = 0;
    end;
    // procedure UpdateData(var BusChartBuf: Record "Business Chart Buffer")
    // var
    //     LoanProduct: Record "Loan Products Setup";
    //     LoansReg: Record "Loans Register";
    //     TotalApproved: Decimal;
    //     LoanCount: Integer;
    //     ColIndex: Integer;
    // begin
    //     BusChartBuf.Initialize();
    //     BusChartBuf.SetXAxis('Loan Product', BusChartBuf."Data Type"::String);
    //     BusChartBuf.AddDecimalMeasure(
    //         'Outstanding Balance', 0, Enum::"Business Chart Type"::Funnel);
    //     BusChartBuf.AddIntegerMeasure(
    //         'Active Loans', 0, Enum::"Business Chart Type"::Funnel);

    // ColIndex := 0;
    // LoanProduct.Reset();
    // if LoanProduct.FindSet() then
    //     repeat
    //         // Use SIFT key — one fast SQL call, no loop
    //         LoansReg.Reset();
    //         LoansReg.SetRange("Loan Product Type", LoanProduct.Code);
    //         LoansReg.SetRange(Posted, true);
    //         LoansReg.CalcSums("Approved Amount");
    //         TotalApproved := LoansReg."Approved Amount";
    //         LoanCount := LoansReg.Count();

    //         if TotalApproved > 0 then begin
    //             BusChartBuf.AddColumn(LoanProduct."Product Description");
    //             BusChartBuf.SetValueByIndex(0, ColIndex, TotalApproved);
    //             BusChartBuf.SetValueByIndex(1, ColIndex, LoanCount);
    //             ColIndex += 1;
    //         end;
    //     until LoanProduct.Next() = 0;

    // end;

    procedure DrillDown(var BusChartBuf: Record "Business Chart Buffer")
    var
        LoansReg: Record "Loans Register";
        ProductCode: Code[20];
    begin
        ProductCode := GetProductCodeByColIndex(BusChartBuf."Drill-Down X Index");
        if ProductCode = '' then
            exit;
        LoansReg.Reset();
        LoansReg.SetRange("Loan Product Type", ProductCode);
        LoansReg.SetRange(Posted, true);
        Page.Run(Page::"Loans DrillDown List", LoansReg);
    end;

    // procedure DrillDownByName(ProductDescription: Text[249])
    // var
    //     LoanProduct: Record "Loan Products Setup";
    //     LoansReg: Record "Loans Register";
    // begin
    //     LoanProduct.Reset();
    //     LoanProduct.SetRange("Product Description", ProductDescription);
    //     if not LoanProduct.FindFirst() then
    //         exit;

    //     LoansReg.Reset();
    //     LoansReg.SetRange("Loan Product Type", LoanProduct.Code);
    //     LoansReg.SetRange(Posted, true);
    //     Page.Run(Page::"Loans DrillDown List", LoansReg);
    // end;
    procedure DrillDownByName(ProductDescription: Text[249])
    var
        LoanProduct: Record "Loan Products Setup";
        LoansReg: Record "Loans Register";
    begin
        LoanProduct.Reset();
        LoanProduct.SetRange("Product Description", ProductDescription);
        if not LoanProduct.FindSet() then
            exit;

        LoansReg.Reset();
        repeat
            LoansReg.SetRange("Loan Product Type", LoanProduct.Code);
            LoansReg.SetRange(Posted, true);
            if LoansReg.FindSet() then
                repeat
                    LoansReg.Mark(true);
                until LoansReg.Next() = 0;
        until LoanProduct.Next() = 0;

        LoansReg.Reset();
        LoansReg.MarkedOnly(true);
        Page.Run(Page::"Loans DrillDown List", LoansReg);
    end;

    local procedure GetProductCodeByColIndex(ColIndex: Integer): Code[20]
    var
        LoanProduct: Record "Loan Products Setup";
        LoansReg: Record "Loans Register";
        CurrentCol: Integer;
    begin
        CurrentCol := 0;
        LoanProduct.Reset();
        if LoanProduct.FindSet() then
            repeat
                // Must match UpdateData condition exactly
                LoansReg.Reset();
                LoansReg.SetRange("Loan Product Type", LoanProduct.Code);
                LoansReg.SetRange(Posted, true);
                LoansReg.CalcSums("Approved Amount");
                if LoansReg."Approved Amount" > 0 then begin
                    if CurrentCol = ColIndex then
                        exit(LoanProduct.Code);
                    CurrentCol += 1;
                end;
            until LoanProduct.Next() = 0;
        exit('');
    end;
}