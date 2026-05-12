#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
table 50287 "Temp Loans Balances"
{

    fields
    {
        field(1; "Member No"; Code[20])
        {
        }
        field(2; "Loan No"; Code[30])
        {
        }
        field(3; "Outstanding Balance"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Member No", "Loan No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

