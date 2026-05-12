#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51981 PortalUps
{

    fields
    {
        field(1; LaonNo; Code[20])
        {
        }
        field(2; RequestedAmount; Decimal)
        {
        }
        field(3; TotalGuaranteed; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; LaonNo)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

