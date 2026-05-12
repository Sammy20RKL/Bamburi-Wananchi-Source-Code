#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
table 50907 "Sure Task Schedule"
{

    fields
    {
        field(1; Task; Option)
        {
            OptionCaption = ',StatementCharge';
            OptionMembers = ,StatementCharge;
        }
        field(2; "Next Task Date"; Date)
        {
        }
        field(3; frequency; DateFormula)
        {
        }
    }

    keys
    {
        key(Key1; Task)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

