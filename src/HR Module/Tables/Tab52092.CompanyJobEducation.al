table 52092 "Company Job Education"
{
    Caption = 'Company Job Education';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Job ID"; Code[50])
        {
            Caption = 'Job ID';
        }
        field(2; "Line No"; Integer)
        {
            Caption = 'Line No';
        }
        field(3; "Field of Study"; Code[50])
        {
            Caption = 'Field of Study';
            // TableRelation = "Field of Study".Code;

            trigger OnValidate()
            begin
                // if FieldOfStudy.Get("Field of Study") then
                //     "Field Name" := FieldOfStudy.Description;
            end;
        }
        field(4; "Field Name"; Text[100])
        {
            Caption = 'Field Name';
        }
        field(5; "Education Level"; Enum "Education Level")
        {
            Caption = 'Education Level';
        }
        field(6; Score; Decimal)
        {
            Caption = 'Score';
        }
        field(7; "Qualification Code"; Code[50])
        {
            // TableRelation = Qualification.Code where("Field of Study" = field("Field of Study"), "Education Level" = field("Education Level"));
            Caption = 'Qualification Code';

            trigger OnValidate()
            begin
                if Qualifications.Get("Qualification Code") then
                    "Qualification Name" := Qualifications.Description;
            end;
        }
        field(8; "Qualification Name"; Text[100])
        {
            Caption = 'Qualification Name';
        }
        field(9; "Proficiency Level"; Enum "Proficiency Level")
        {
            Caption = 'Proficiency Level';
        }
        field(11; "Section/Level"; Integer)
        {
            Caption = 'Section/Level';
        }
        field(12; "Qualification Code Prof"; Code[50])
        {
            TableRelation = Qualification.Code;
            Caption = 'Qualification Code Prof';

            trigger OnValidate()
            begin
                if Qualifications.Get("Qualification Code Prof") then
                    "Qualification Name" := Qualifications.Description;
            end;
        }
    }

    keys
    {
        key(PK; "Job ID", "Line No")
        {
            Clustered = true;
        }
    }

    var
        // FieldOfStudy: Record "Field of Study";
        Qualifications: Record Qualification;
}





