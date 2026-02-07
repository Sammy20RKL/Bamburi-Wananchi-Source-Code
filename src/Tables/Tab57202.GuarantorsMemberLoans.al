table 57202 "Guarantors Member Loans"
{
    DrillDownPageID = "Loan Offset Detail List";
    LookupPageID = "Loan Offset Detail List";

    fields
    {
        field(1; "Document No"; Code[20])
        {
            TableRelation = "Guarantors Recovery Header"."Document No";
        }
        field(2; "Loan No."; Code[20])
        {

            trigger OnValidate()
            begin
                if Loans.Get("Loan No.") then begin
                    Loans.CalcFields(Loans."Outstanding Balance", Loans."Oustanding Interest");
                    "Loan Type" := Loans."Loan Product Type";
                    "Approved Loan Amount" := Loans."Approved Amount";
                    "Loan Instalments" := Loans.Installments;
                    "Monthly Repayment" := Loans.Repayment;
                    "Outstanding Balance" := Loans."Outstanding Balance";
                    "Outstanding Interest" := Loans."Oustanding Interest";
                end;
            end;
        }
        field(3; "Member No"; Code[20])
        {

            trigger OnValidate()
            begin
                if Cust.Get("Member No") then begin
                    "Member Name" := Cust.Name;
                    "ID. NO" := Cust."ID No.";
                    "Staff No" := Cust."Personal No";
                end;
            end;
        }
        field(4; "Loan Type"; Code[20])
        {
        }
        field(5; "Approved Loan Amount"; Decimal)
        {
        }
        field(6; "Loan Instalments"; Decimal)
        {
        }
        field(7; "Monthly Repayment"; Decimal)
        {
        }
        field(8; "Outstanding Balance"; Decimal)
        {
        }
        field(9; "Outstanding Interest"; Decimal)
        {
        }
        field(10; "Interest Rate"; Decimal)
        {
        }
        field(11; "ID. NO"; Code[20])
        {
        }
        field(12; "Staff No"; Code[20])
        {
        }
        field(13; Posted; Boolean)
        {
        }
        field(14; "Posting Date"; Date)
        {
        }
        field(15; "Amount Allocated"; Decimal)
        {
        }
        field(16; "Member Name"; Code[60])
        {
        }
    }

    keys
    {
        key(Key1; "Document No", "Member No", "Loan No.")
        {
            Clustered = true;
            SumIndexFields = "Monthly Repayment", "Approved Loan Amount";
        }
        key(Key2; "Approved Loan Amount")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Member No", "Loan Type", "Approved Loan Amount", "Loan Instalments", "Monthly Repayment", "Outstanding Balance", "Outstanding Interest", "Interest Rate", "ID. NO", Posted)
        {
        }
    }

    var
        Loans: Record "Loans Register";
        Loantypes: Record "Loan Products Setup";
        Interest: Decimal;
        Cust: Record Customer;
        LoansTop: Record "Loans Register";
        GenSetUp: Record "Sacco General Set-Up";
}
