#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 50086 "Product Type Loan"
{

    fields
    {
        field(1;"Product Type";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2;Name;Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3;"interest Rate";Code[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Product Type")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

