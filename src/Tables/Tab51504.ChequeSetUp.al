#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51504 "Cheque Set Up"
{
    DrillDownPageID = 50533;
    LookupPageID = 50533;

    fields
    {
        field(1; "Cheque Code"; Code[30])
        {
        }
        field(2; "Number Of Leaf"; Code[20])
        {
        }
        field(3; Amount; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Cheque Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Cheque Code", "Number Of Leaf", Amount)
        {
        }
    }
}

