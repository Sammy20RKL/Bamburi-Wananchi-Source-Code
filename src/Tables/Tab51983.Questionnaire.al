#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51983 Questionnaire
{

    fields
    {
        field(1; Entry; Integer)
        {
        }
        field(2; ServedBy; Text[30])
        {
        }
        field(3; ReasonForVisit; Text[30])
        {
        }
        field(4; Member; Code[30])
        {
        }
        field(5; Time; Text[30])
        {
        }
        field(6; MostImpressedwith; Text[30])
        {
        }
        field(7; LeastImpressedWIth; Text[30])
        {
        }
        field(8; Suggestions; Text[1000])
        {
        }
        field(9; Accounts; Option)
        {
            OptionMembers = Excellent,Good,"Average",Poor;
        }
        field(10; Customercare; Option)
        {
            OptionMembers = Excellent,Good,"Average",Poor;
        }
        field(11; OfficeAtmosphere; Option)
        {
            OptionMembers = Excellent,Good,"Average",Poor;
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

