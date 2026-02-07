table 52094 "Company Job Experience"
{
    Caption = 'Company Job Experience';
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
        field(3; Industry; Code[50])
        {
            Caption = 'Industry';
            TableRelation = "Company Job Industry".Code;

            trigger OnValidate()
            begin
                if CompanyJobIndustry.Get(Industry) then
                    "Industry Name" := CompanyJobIndustry.Description;
            end;
        }
        field(4; "Industry Name"; Text[100])
        {
            Caption = 'Industry Name';
        }
        field(5; "Hierarchy Level"; Enum "Hierarchy Level")
        {
            Caption = 'Hierarchy Level';
        }
        field(6; "No. of Years"; Decimal)
        {
            Caption = 'No. of Years';
        }
        field(7; Score; Decimal)
        {
            Caption = 'Score';
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
        CompanyJobIndustry: Record "Company Job Industry";
}





