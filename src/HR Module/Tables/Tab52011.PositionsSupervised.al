table 52011 "Positions Supervised"
{
    DataClassification = CustomerContent;
    Caption = 'Positions Supervised';
    fields
    {
        field(1; "Job ID"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Company Job"."Job ID";
            Caption = 'Job ID';
        }
        field(2; "Position Supervised"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Company Job"."Job ID";
            Caption = 'Position Supervised';

            trigger OnValidate()
            begin

                if Jobs.Get("Job ID") then
                    if "Position Supervised" = "Job ID" then
                        Error('You cannot Supervise the same position you are in');

                Jobs.SetRange("Job ID", "Position Supervised");
                if Jobs.Find('-') then
                    Description := Jobs."Job Description";
            end;
        }
        field(3; Description; Text[250])
        {
            Caption = 'Description';
        }
        field(4; Remarks; Text[250])
        {
            Caption = 'Remarks';
        }
    }

    keys
    {
        key(Key1; "Job ID", "Position Supervised")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Jobs: Record "Company Job";
}





