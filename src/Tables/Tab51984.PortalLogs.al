#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51984 "Portal Logs"
{

    fields
    {
        field(1; Entry; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Member No"; Code[30])
        {
        }
        field(3; Date; Date)
        {
        }
        field(4; Time; Time)
        {
        }
        field(5; "Login Status"; Option)
        {
            OptionCaption = ',Successfull,Failed';
            OptionMembers = ,Successfull,Failed;
        }
        field(6; "Member Name"; Text[50])
        {
        }
        field(7; "Accessed Page"; Text[250])
        {
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
}

