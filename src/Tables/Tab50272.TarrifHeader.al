#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
table 50272 "Tarrif Header"
{

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; Description; Text[30])
        {
        }
        field(3; "Transaction Type"; Option)
        {
            OptionCaption = 'Deposit,Withdrawal';
            OptionMembers = Deposit,Withdrawal;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

