#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51301 Update
{

    fields
    {
        field(1; NO; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Name; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "MEMBER NO"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; NO)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

