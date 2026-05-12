table 52010 "Salary Scale"
{
    DataClassification = CustomerContent;
    Caption = 'Salary Grade';

    fields
    {
        field(1; Scale; Code[10])
        {
            Caption = 'Grade';
        }
        field(2; "Minimum Pointer"; Code[10])
        {
            Caption = 'Minimum Step';
            ///  TableRelation = "Salary Pointer"."Salary Pointer" where("Salary Scale" = field(Scale));
        }
        field(3; "Maximum Pointer"; Code[10])
        {
            Caption = 'Maximum Step';
            //   TableRelation = "Salary Pointer"."Salary Pointer" where("Salary Scale" = field(Scale));
        }
        field(4; "Responsibility Allowance"; Decimal)
        {
            Caption = 'Responsibility Allowance';
        }
        field(5; "Commuter Allowance"; Decimal)
        {
            Caption = 'Commuter Allowance';
        }
        field(6; "In Patient Limit"; Decimal)
        {
            Caption = 'In Patient Limit';
        }
        field(7; "Out Patient Limit"; Decimal)
        {
            Caption = 'Out Patient Limit';
        }
        field(8; "Leave Days"; Decimal)
        {
            Caption = 'Leave Days';
        }
        field(9; "Per Diem"; Decimal)
        {
            Caption = 'Per Diem';
        }
        field(10; Location; Code[20])
        {
            Caption = 'Location';
        }
        field(11; "Max Imprest"; Integer)
        {
            Caption = 'Max Imprest';
        }
        field(12; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(13; "No. of Employees"; Integer)
        {
            CalcFormula = count(Employee where("Salary Scale" = field(Scale)));
            Caption = 'No. of Employees';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; Scale)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Scale, Description)
        {

        }
    }
}





