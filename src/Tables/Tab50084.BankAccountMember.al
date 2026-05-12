#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 50084 "Bank Account Member"
{

    fields
    {
        field(1;"code";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2;"account no.";Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3;name;Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4;"branch code";Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5;"Bank Type";Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6;"Bank Name";Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(7;"Bank code";Code[10])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

