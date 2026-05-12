#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 50159 UpdateData
{

    trigger OnRun()
    begin
        UpdateGuarantors();
    end;

    var
        GuarantorInfoUpdateTemp: Record 51567;
        AllLoansGuaranteedInfo: Record 51566;
        LoansGuaranteeDetails: Record 51372;
        Amt: Decimal;
        SwizzsoftFactory: Codeunit "Swizzsoft Factory.";

    local procedure UpdateGuarantors()
    var
        AmtPaid: Decimal;
    begin

        LoansGuaranteeDetails.SetFilter("Loan No", '<>%1', '');
        if LoansGuaranteeDetails.Find('-') then begin
            repeat
                Amt := 0;
                AmtPaid := 0;
                AmtPaid := SwizzsoftFactory.FnGetLoanAmountPaid(LoansGuaranteeDetails."Loan No");
                LoansGuaranteeDetails.CalcFields("Total Loans Guaranteed", "Outstanding Balance");
                if LoansGuaranteeDetails."Total Loans Guaranteed" > 0 then begin
                    Amt := (LoansGuaranteeDetails."Original Amount" / LoansGuaranteeDetails."Total Loans Guaranteed") * (LoansGuaranteeDetails."Total Loans Guaranteed" - AmtPaid);
                    if Amt < 0 then Amt := 0;
                    LoansGuaranteeDetails."Amont Guaranteed" := Amt;
                    LoansGuaranteeDetails.Modify;
                end;
            until LoansGuaranteeDetails.Next = 0;
        end;

        Message('Done');
    end;
}

