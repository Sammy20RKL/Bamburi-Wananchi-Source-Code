codeunit 52010 "Loan Products Chart Mgt."
{
    var
        ColDescriptions: List of [Text[249]];

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
            'Outstanding Balance', 0, Enum::"Business Chart Type"::Pie);
        BusChartBuf.AddIntegerMeasure(
            'Active Loans', 0, Enum::"Business Chart Type"::Pie);

        Clear(ColDescriptions);
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
                        ColDescriptions.Add(LoanProduct."Product Description");

                        ColIndex += 1;
                    end;
                end;
            until LoanProduct.Next() = 0;
    end;

    procedure DrillDown(var BusChartBuf: Record "Business Chart Buffer")
    var
        ProductDesc: Text[249];
    begin
        ProductDesc := GetProductDescByColIndex(BusChartBuf."Drill-Down X Index");
        if ProductDesc = '' then
            exit;
        DrillDownByName(ProductDesc);
    end;

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

    local procedure GetProductDescByColIndex(ColIndex: Integer): Text[249]
    begin
        // ColDescriptions is populated once per UpdateData call — no re-scan needed
        if (ColIndex < 0) or (ColIndex >= ColDescriptions.Count()) then
            exit('');
        exit(ColDescriptions.Get(ColIndex + 1));
    end;
}
