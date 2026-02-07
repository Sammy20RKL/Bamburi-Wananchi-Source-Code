table 52136 "Salary Pointer Details"
{
    DataClassification = CustomerContent;
    Caption = 'Salary Pointer Details';
    fields
    {
        field(1; "Employee No"; Code[20])
        {
            TableRelation = Employee;
            Caption = 'Employee No';
        }
        field(2; "Payroll Period"; Date)
        {
            Caption = 'Payroll Period';
        }
        field(3; Present; Code[10])
        {
            Caption = 'Present';
        }
        field(4; Previous; Code[10])
        {
            Caption = 'Previous';
        }
    }

    keys
    {
        key(Key1; "Employee No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}





