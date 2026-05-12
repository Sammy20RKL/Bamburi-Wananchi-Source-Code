table 52134 "Salary Pointer"
{
    DataClassification = CustomerContent;
    Caption = 'Salary Step';

    fields
    {
        field(1; "Salary Pointer"; Code[10])
        {
            NotBlank = true;
            Caption = 'Salary Step';
        }
        field(2; "Basic Pay int"; Integer)
        {
            Caption = 'Basic Pay int';
        }
        field(3; "Basic Pay"; Decimal)
        {
            Caption = 'Basic Pay';
        }
        field(4; "Salary Scale"; Code[10])
        {
            TableRelation = "Salary Scale";
            Caption = 'Salary Grade';
        }
        field(5; "No. of Employees"; Integer)
        {
            CalcFormula = count(Employee where("Salary Scale" = field("Salary Scale"), "Present Pointer" = field("Salary Pointer")));
            Caption = 'No. of Employees';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Salary Scale", "Salary Pointer")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}





