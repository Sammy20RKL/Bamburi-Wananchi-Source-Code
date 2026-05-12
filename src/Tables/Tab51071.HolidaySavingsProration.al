#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51071 "Holiday Savings Proration"
{

    fields
    {
        field(1; "Member No"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Year; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Earned Holiday Interest"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; Entry; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Member No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

