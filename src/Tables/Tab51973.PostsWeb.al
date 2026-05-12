#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51973 "Posts_Web"
{

    fields
    {
        field(1; Entry; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(2; Title; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Description; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4; DateEntered; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; DateModified; Date)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; Entry)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        DateEntered := Today;
    end;

    trigger OnModify()
    begin
        DateModified := Today;
    end;
}

