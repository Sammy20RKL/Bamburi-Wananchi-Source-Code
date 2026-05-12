#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
table 50439 "Interest Rates"
{

    fields
    {
        field(10; "Code"; Code[20])
        {
        }
        field(11; Description; Text[50])
        {
        }
        field(12; Percentage; Decimal)
        {
        }
        field(13; "GL Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(14; "Charge Amount"; Decimal)
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

