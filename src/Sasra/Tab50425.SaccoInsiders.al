#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
table 50425 "Sacco Insiders"
{

    fields
    {
        field(1; MemberNo; Code[100])
        {
            TableRelation = Customer;
        }
        field(2; "Position in society"; Option)
        {
            OptionMembers = ,Board,Staff;
        }
    }

    keys
    {
        key(Key1; MemberNo)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

