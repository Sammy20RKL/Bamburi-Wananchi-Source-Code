#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
table 50549 "BOSA Transaction Fees"
{

    fields
    {
        field(1; "Code"; Code[100])
        {
        }
        field(2; Description; Code[100])
        {
        }
        field(3; "Lower Limit"; Decimal)
        {
        }
        field(4; "Upper Limit"; Decimal)
        {
        }
        field(5; "Charge Amount"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

