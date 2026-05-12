#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51917 "Checkoff Code Buffer"
{

    fields
    {
        field(1; UserId; Code[50])
        {
        }
        field(2; EmployerCode; Code[100])
        {
        }
    }

    keys
    {
        key(Key1; UserId)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

