table 56116 "Bosa Customer Group Members"
{
    Caption = 'Bosa Member App Group Members';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Bosa Group Customer List";
    LookupPageId = "Bosa Group Customer List";

    fields
    {
        field(1; "ID Number/Passport Number"; Code[30])
        {
            Caption = 'ID Number/Passport Number';
        }
        field(2; "Name"; Text[100])
        {
            Caption = 'Name ';
        }
        field(3; "Date of Birth"; Date)
        {
            Caption = 'Date of Birth';
        }
        field(4; Nationality; Code[60])
        {
            Caption = 'Nationality';
        }
        field(5; "Mobile Phone Number"; Code[15])
        {
            Caption = 'Mobile Phone Number';
        }
        field(6; E_Mail; Text[50])
        {
            Caption = 'E_Mail';
        }
        field(7; Ocupation; Text[100])
        {
            Caption = 'Ocupation';
        }
        field(8; Employer; Text[100])
        {
            Caption = 'Employer';
        }
        field(9; Occupation; Text[50])
        {
            Caption = 'Occupation';
        }
        field(10; "Specimen Signature"; Media)
        {
            Caption = 'Specimen Signature';
        }
        field(11; "Specimen Passport"; Media)
        {
            Caption = 'Specimen Passport';
        }
        field(12; "Account No"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Membership Applications"."No.";
        }
        field(13; "Entry No"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;

        }
    }
    keys
    {
        key(PK; "Account No", "Entry No")
        {
            Clustered = true;
        }

    }
}
