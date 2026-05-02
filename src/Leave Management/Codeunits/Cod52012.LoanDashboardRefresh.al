codeunit 52012 "Loan Dashboard Refresh"
{
    procedure RefreshData()
    var
        LoanProduct: Record "Loan Products Setup";
        LoansReg: Record "Loans Register";
        Dash: Record "Loan Product Dashboard";
        Outstanding: Decimal;
        LoanCount: Integer;
    begin
        Dash.DeleteAll();

        if LoanProduct.FindSet() then
            repeat
                Outstanding := 0;
                LoanCount := 0;

                LoansReg.Reset();
                LoansReg.SetRange("Loan Product Type", LoanProduct.Code);
                LoansReg.SetRange(Posted, true);

                if LoansReg.FindSet() then
                    repeat
                        LoansReg.CalcFields("Outstanding Balance");

                        if LoansReg."Outstanding Balance" > 0 then begin
                            Outstanding += LoansReg."Outstanding Balance";
                            LoanCount += 1;
                        end;
                    until LoansReg.Next() = 0;

                if Outstanding > 0 then begin
                    Dash.Init();
                    Dash."Product Code" := LoanProduct.Code;
                    Dash."Product Name" := LoanProduct."Product Description";
                    Dash."Outstanding Balance" := Outstanding;
                    Dash."Active Loans" := LoanCount;
                    Dash."Last Updated" := CurrentDateTime();
                    Dash.Insert();
                end;

            until LoanProduct.Next() = 0;
    end;
}