#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51947 Attachments
{

    fields
    {
        field(1; Entry; Integer)
        {
            AutoIncrement = true;
        }
        field(2; Loan; Code[20])
        {
        }
        field(3; LocaLAttacmentLink; Text[70])
        {
        }
        field(4; PublicLink; Text[70])
        {
        }
        field(5; Type; Code[70])
        {
        }
        field(6; Name; Text[70])
        {
        }
        field(7; DateUploaded; Date)
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

