table 52006 "Salary Scale Allowance"
{
    Caption = 'Salary Scale Allowance';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Salary Scale"; Code[20])
        {
            Caption = 'Salary Scale';
            TableRelation = "Salary Scale";
        }
        field(2; "Earning Code"; Code[20])
        {
            Caption = 'Earning Code';
            TableRelation = Earnings.Code;
        }
        field(3; "Earning Description"; Text[100])
        {
            Caption = 'Earning Description';
            FieldClass = FlowField;
            CalcFormula = lookup(Earnings.Description where(Code = field("Earning Code")));
            Editable = false;
        }
        field(4; Amount; Decimal)
        {
            Caption = 'Amount';
        }
    }
    keys
    {
        key(PK; "Salary Scale", "Earning Code")
        {
            Clustered = true;
        }
    }
}






