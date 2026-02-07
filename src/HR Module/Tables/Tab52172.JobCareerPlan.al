table 52172 "Job Career Plan"
{
    Caption = 'Job Career Plan';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Job ID"; Code[50])
        {
            Caption = 'Job ID';
            DataClassification = CustomerContent;
            TableRelation = "Company Job";
        }
        field(2; "Plan Job ID"; Code[50])
        {
            Caption = 'Plan Job ID';
            DataClassification = CustomerContent;
            TableRelation = "Company Job";
        }
        field(3; Description; Text[250])
        {
            Caption = 'Description';
            FieldClass = FlowField;
            CalcFormula = lookup("Company Job"."Job Description" where("Job ID" = field("Plan Job ID")));
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Job ID", "Plan Job ID")
        {
            Clustered = true;
        }
    }
}






