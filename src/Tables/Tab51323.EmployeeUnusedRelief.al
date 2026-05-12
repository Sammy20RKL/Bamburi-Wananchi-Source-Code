#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51323 "Employee Unused Relief."
{

    fields
    {
        field(10; "Employee No."; Code[20])
        {
        }
        field(11; "Unused Relief"; Decimal)
        {
        }
        field(12; "Unused Relief(LCY)"; Decimal)
        {
        }
        field(13; "Period Month"; Integer)
        {
        }
        field(14; "Period Year"; Integer)
        {
        }
        field(15; "Payroll Period"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "Employee No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

table 59053 "Employee Unused Relief Buffer"
{
    fields
    {
        field(10; "Employee No."; Code[20]) { }
        field(13; "Period Month"; Integer) { }
        field(14; "Period Year"; Integer) { }
        field(11; "Unused Relief"; Decimal) { }
        field(12; "Unused Relief(LCY)"; Decimal) { }
        field(15; "Payroll Period"; Date) { }
    }

    keys
    {
        key(PK; "Employee No.", "Period Month", "Period Year") { Clustered = true; }
    }
}
