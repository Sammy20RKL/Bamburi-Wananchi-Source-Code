#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51656 "Loan Other Charges"
{

    fields
    {
        field(1; "Loan No."; Code[20])
        {
            TableRelation = "Loans Register"."Loan  No.";
        }
        field(3; "Client Code"; Code[20])
        {
        }
        field(4; "Loan Type"; Code[20])
        {
        }
        field(24; Account; Code[30])
        {
            TableRelation = Vendor."No.";
        }
        field(25; "G/L Account"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Entry";
        }
        field(26; "Code"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Loan Charges".Code;

            trigger OnValidate()
            begin
                if Charges.Get(Code) then begin
                    Description := Charges.Description;
                    Amount := Charges.Amount;
                    "G/L Account" := Charges."G/L Account";
                end;
                ObjLoans.Reset;
                ObjLoans.SetRange(ObjLoans."Loan  No.", "Loan No.");
                if ObjLoans.FindSet then begin
                    "Loan Type" := ObjLoans."Loan Product Type";
                end;
            end;
        }
        field(27; Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(28; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(29; Entry; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Loan No.", "Client Code", Description)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // fieldgroup(DropDown;"Client Code","Loan Type",Field5,Field6,Field7,Field8,Field9,Field10,Field11,Field13)
        // {
        // }
    }

    var
        Loans: Record "Loans Register";
        Loantypes: Record "Loan Products Setup";
        Interest: Decimal;
        Cust: Record Customer;
        LoansTop: Record "Loans Register";
        GenSetUp: Record "Sacco General Set-Up";
        ObjRepaymentSchedule: Record "Loan Repayment Schedule";
        ApplicationDate: Date;
        ObjLoans: Record "Loans Register";
        ObjLoanType: Record "Loan Products Setup";
        MinAmountforOffset: Decimal;
        LoanBal: Decimal;
        Text00: label 'Amount cannot be greater than the loan oustanding balance for%1.';
        Text001: label 'Amount cannot be greater than the loan oustanding balance for %1';
        Charges: Record "Loan Charges";
}

