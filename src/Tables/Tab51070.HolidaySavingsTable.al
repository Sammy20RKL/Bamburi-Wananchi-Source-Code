#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51070 "Holiday Savings Table"
{

    fields
    {
        field(1; "Member No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Year; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Holiday Savings Paid Out"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Holiday Interest Paid Out"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Entry No"; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(6; "Member Name"; Text[100])
        {
            CalcFormula = lookup(Customer.Name where("No." = field("Member No")));
            FieldClass = FlowField;
            TableRelation = Customer.Name;
        }
        field(7; "Payroll No"; Code[100])
        {
            CalcFormula = lookup(Customer."Personal No" where("No." = field("Member No")));
            FieldClass = FlowField;
        }
        field(8; "Total Paid Out"; Decimal) { DataClassification = ToBeClassified; }
    }

    keys
    {
        key(Key1; "Member No", Year)
        {
            Clustered = true;
        }
        // key(Key2;'')
        // {
        //     Enabled = false;
        // }
    }

    fieldgroups
    {
    }
}

