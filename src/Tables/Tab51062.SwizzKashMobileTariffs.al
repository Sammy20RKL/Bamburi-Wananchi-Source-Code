#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51062 "SwizzKash Mobile Tariffs"
{

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(3; "Charge amount"; Decimal)
        {
        }
        field(4; "Next Run date"; DateTime)
        {
            DataClassification = ToBeClassified;
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

