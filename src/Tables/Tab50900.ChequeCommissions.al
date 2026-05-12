#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
table 50900 "Cheque Commissions"
{

    fields
    {
        field(1; "Minimum Amount(Local)"; Decimal)
        {
        }
        field(2; "Maximum Amount(Local)"; Decimal)
        {
        }
        field(3; "Charge(Local)"; Decimal)
        {
        }
        field(4; "Minimum Amount(Upcountry)"; Decimal)
        {
        }
        field(5; "Maximum Amount(Upcountry)"; Decimal)
        {
        }
        field(6; "Charge(Upcountry)"; Decimal)
        {
        }
        field(7; "Use Percentage(Local)"; Boolean)
        {
        }
        field(8; "Use Percentage(Upcountry)"; Boolean)
        {
        }
        field(9; "% Amount(Local)"; Decimal)
        {
        }
        field(10; "% Amount(Upcountry)"; Decimal)
        {
        }
        field(11; "Minimum Amount(Inhouse)"; Decimal)
        {
        }
        field(12; "Maximum Amount(Inhouse)"; Decimal)
        {
        }
        field(13; "Charge(Inhousel)"; Decimal)
        {
        }
        field(14; "Use Percentage(Inhouse)"; Boolean)
        {
        }
        field(15; "% Amount (Inhouse)"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Minimum Amount(Local)")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

