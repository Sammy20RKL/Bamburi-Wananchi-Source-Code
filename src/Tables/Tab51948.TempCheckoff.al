#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51948 TempCheckoff
{

    fields
    {
        field(1; MemNO; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; JournalAmount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(3; CheckoffAmount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; MemNO)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

