#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51982 Portal
{

    fields
    {
        field(1; Entry; Integer)
        {
        }
        field(2; Portalfeedback; Text[250])
        {
        }
        field(3; PortalNotifications; Text[250])
        {
        }
        field(4; DatePosted; Date)
        {
        }
        field(5; PostedBy; Text[30])
        {
        }
        field(6; No; Code[20])
        {
        }
        field(7; Reply; Text[250])
        {
        }
        field(8; LoanNo; Code[40])
        {
        }
        field(9; Guarantor; Code[30])
        {
        }
        field(10; Accepted; Integer)
        {
        }
        field(11; Rejected; Integer)
        {
        }
        field(12; Amount; Decimal)
        {
        }
        field(13; RequestedAmount; Decimal)
        {
        }
        field(14; Purpose; Code[20])
        {
        }
        field(15; LoanConsolidation; Boolean)
        {
        }
        field(16; LoanRefinaincing; Boolean)
        {
        }
        field(17; LoanBridging; Boolean)
        {
        }
        field(18; LoanDuration; Integer)
        {
        }
        field(19; LoanProducttype; Code[20])
        {
        }
        field(20; RemainingAmount; Decimal)
        {
        }
        field(21; AmountGuranteedTotal; Decimal)
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

