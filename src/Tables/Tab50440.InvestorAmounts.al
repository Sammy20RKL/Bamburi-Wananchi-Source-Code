#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
table 50440 "Investor Amounts"
{

    fields
    {
        field(10; "Investor No"; Code[20])
        {
            Editable = false;
        }
        field(11; "Interest Code"; Code[20])
        {
            TableRelation = "Interest Rates".Code;
        }
        field(12; "Investment Date"; Date)
        {
        }
        field(13; Amount; Decimal)
        {

            trigger OnValidate()
            begin
                "Amount(LCY)" := Amount;
            end;
        }
        field(14; "Amount(LCY)"; Decimal)
        {
            Editable = false;
        }
        field(15; "Closure Date"; Date)
        {
            Editable = false;
        }
        field(16; Description; Text[100])
        {
            Editable = false;
        }
        field(17; "Interest Due"; Decimal)
        {
        }
        field(18; "Interest Paid"; Decimal)
        {
            Editable = false;
        }
        field(19; "Last Update Date"; Date)
        {
            Editable = false;
        }
        field(20; "Last Update Time"; Time)
        {
            Editable = false;
        }
        field(21; "Last Update User"; Code[50])
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Investor No", "Interest Code", "Investment Date")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

