#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51298 "Suspended Interest Accounts"
{

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = false;
        }
        field(2; "Loan No."; Code[20])
        {
        }
        field(3; "Credit Account"; Code[30])
        {
        }
        field(5; "Loan Product"; Code[20])
        {
        }
        field(6; "Interest Date"; Date)
        {
        }
        field(7; "Interest Amount"; Decimal)
        {
        }
        field(8; "Loan Product type"; Code[10])
        {
            Editable = false;
            TableRelation = "Loan Products Setup";
        }
        field(9; "Issued Date"; Date)
        {
            Editable = false;
        }
        field(10; "Loans Category-SASRA"; Option)
        {
            CalcFormula = lookup("Loans Register"."Loans Category-SASRA" where("Loan  No." = field("Loan No.")));
            FieldClass = FlowField;
            OptionCaption = 'Perfoming,Watch,Substandard,Doubtful,Loss';
            OptionMembers = Perfoming,Watch,Substandard,Doubtful,Loss;
        }
        field(11; "Transferred to income Ac"; Boolean)
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Loan No.", "Interest Date")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

