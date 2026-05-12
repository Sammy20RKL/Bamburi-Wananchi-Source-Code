#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
table 50547 "Overdraft Setup"
{

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
        }
        field(2; "Overdraft Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(3; "Overdraft Limt"; Decimal)
        {
        }
        field(4; "Overdraft Interest  Rate"; Decimal)
        {
        }
        field(5; "Overdraft Maximum prd"; DateFormula)
        {
        }
        field(6; "Control Account"; Code[10])
        {
            TableRelation = "G/L Account";
        }
        field(7; "Interest Receivable A/c"; Code[10])
        {
            TableRelation = "G/L Account";
        }
        field(8; "Interest Income A/c"; Code[10])
        {
            TableRelation = "G/L Account";
        }
        field(9; "Commission A/c"; Code[10])
        {
            TableRelation = "G/L Account";
        }
        field(10; "Overdarft Processing Fee"; Decimal)
        {
        }
        field(11; "Overdraft Commision Charged"; Decimal)
        {
        }
        field(12; "One Month Interest Rate"; Decimal)
        {
        }
        field(13; "More than Month Interest Rate"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

