#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
table 50548 "Insurance companies"
{
    DrillDownPageID = "Posted Authorisation List";
    LookupPageID = "Posted Authorisation List";

    fields
    {
        field(1; "Insurer code"; Code[10])
        {
        }
        field(2; "Insurer Name"; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "Insurer code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

