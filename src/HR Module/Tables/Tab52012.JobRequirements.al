table 52012 "Job Requirements"
{
    DataClassification = CustomerContent;
    Caption = 'Job Requirements';
    fields
    {
        field(1; "Job Id"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Company Job"."Job ID";
            Caption = 'Job Id';
        }
        field(2; "Qualification Type"; Option)
        {
            NotBlank = false;
            OptionCaption = ' ,Academic,Professional,Technical,Experience,Personal Attributes';
            OptionMembers = " ",Academic,Professional,Technical,Experience,"Personal Attributes";
            Caption = 'Qualification Type';
        }
        field(3; "Qualification Code"; Code[10])
        {
            Editable = true;
            NotBlank = true;
            Caption = 'Qualification Code';

            trigger OnValidate()
            begin
                QualificationSetUp.Reset();
                QualificationSetUp.SetRange(Code, "Qualification Code");
                if QualificationSetUp.Find('-') then
                    Qualification := QualificationSetUp.Description;
            end;
        }
        field(4; Qualification; Text[200])
        {
            NotBlank = false;
            Caption = 'Qualification';
        }
        field(5; "Job Requirements"; Text[250])
        {
            NotBlank = true;
            Caption = 'Job Requirements';
        }
        field(6; Priority; Option)
        {
            OptionCaption = ' ,High,Medium,Low';
            OptionMembers = " ",High,Medium,Low;
            Caption = 'Priority';
        }
        field(7; "Job Specification"; Option)
        {
            OptionCaption = ' ,Academic,Professional,Technical,Experience';
            OptionMembers = " ",Academic,Professional,Technical,Experience;
            Caption = 'Job Specification';
        }
        field(8; "Score ID"; Decimal)
        {
            Caption = 'Score ID';
        }
    }

    keys
    {
        key(Key1; "Job Id", "Qualification Type", "Qualification Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        QualificationSetUp: Record Qualification;
}





