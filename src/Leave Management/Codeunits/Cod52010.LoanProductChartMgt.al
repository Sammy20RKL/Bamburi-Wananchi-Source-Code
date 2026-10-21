codeunit 52010 "Loan Products Chart Mgt."
{
    procedure GetChartDataJson(): Text
    var
        LoanProduct: Record "Loan Products Setup";
        LoansReg: Record "Loans Register";
        BalanceByDesc: Dictionary of [Text[30], Decimal];
        CountByDesc: Dictionary of [Text[30], Integer];
        Descriptions: List of [Text[30]];
        TotalApproved: Decimal;
        LoanCount: Integer;
        TotalBalance: Decimal;
        MaxBalance: Decimal;
        Desc: Text[30];
        JRoot: JsonObject;
        JItems: JsonArray;
        JItem: JsonObject;
        OutText: Text;
        i: Integer;
        j: Integer;
        TempDesc: Text[30];
    begin
        LoanProduct.Reset();
        if LoanProduct.FindSet() then
            repeat
                LoansReg.Reset();
                LoansReg.SetRange("Loan Product Type", LoanProduct.Code);
                LoansReg.SetRange(Posted, true);
                LoansReg.CalcSums("Approved Amount");
                TotalApproved := LoansReg."Approved Amount";
                LoanCount := LoansReg.Count();

                if TotalApproved > 0 then
                    if BalanceByDesc.ContainsKey(LoanProduct."Product Description") then begin
                        // Same description shared across product codes — merge into one bar
                        BalanceByDesc.Set(LoanProduct."Product Description", BalanceByDesc.Get(LoanProduct."Product Description") + TotalApproved);
                        CountByDesc.Set(LoanProduct."Product Description", CountByDesc.Get(LoanProduct."Product Description") + LoanCount);
                    end else begin
                        BalanceByDesc.Add(LoanProduct."Product Description", TotalApproved);
                        CountByDesc.Add(LoanProduct."Product Description", LoanCount);
                        Descriptions.Add(LoanProduct."Product Description");
                    end;
            until LoanProduct.Next() = 0;

        // Insertion sort, descending by balance — product lists are short.
        // AL's "and" does not short-circuit, so the bounds check must be its own statement,
        // never combined with the comparison in one "while ... and ..." condition.
        for i := 2 to Descriptions.Count() do begin
            j := i;
            while j > 1 do begin
                if BalanceByDesc.Get(Descriptions.Get(j)) <= BalanceByDesc.Get(Descriptions.Get(j - 1)) then
                    break;
                TempDesc := Descriptions.Get(j);
                Descriptions.Set(j, Descriptions.Get(j - 1));
                Descriptions.Set(j - 1, TempDesc);
                j -= 1;
            end;
        end;

        for i := 1 to Descriptions.Count() do
            TotalBalance += BalanceByDesc.Get(Descriptions.Get(i));
        if Descriptions.Count() > 0 then
            MaxBalance := BalanceByDesc.Get(Descriptions.Get(1));

        JRoot.Add('totalBalanceLabel', FormatShortAmount(TotalBalance));

        for i := 1 to Descriptions.Count() do begin
            Desc := Descriptions.Get(i);
            Clear(JItem);
            JItem.Add('label', Desc);
            JItem.Add('balance', BalanceByDesc.Get(Desc));
            JItem.Add('count', CountByDesc.Get(Desc));
            if MaxBalance > 0 then
                JItem.Add('pct', Round(BalanceByDesc.Get(Desc) / MaxBalance * 100, 0.1))
            else
                JItem.Add('pct', 0);
            JItem.Add('valueLabel', FormatShortAmount(BalanceByDesc.Get(Desc)) + ' · ' + Format(CountByDesc.Get(Desc)) + ' loans');
            JItems.Add(JItem);
        end;
        JRoot.Add('items', JItems);

        JRoot.WriteTo(OutText);
        exit(OutText);
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

    local procedure FormatShortAmount(Amount: Decimal): Text
    var
        AbsAmount: Decimal;
    begin
        AbsAmount := Abs(Amount);
        if AbsAmount >= 1000000 then
            exit('KES ' + Format(Round(Amount / 1000000, 0.1)) + 'M');
        if AbsAmount >= 1000 then
            exit('KES ' + Format(Round(Amount / 1000, 0.1)) + 'K');
        exit('KES ' + Format(Round(Amount, 1)));
    end;
}
