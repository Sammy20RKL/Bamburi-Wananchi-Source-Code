table 52095 "Company Job Industry"
{
    Caption = 'Company Job Industry';
    DataClassification = CustomerContent;

    fields
    {
        field(1; Code; Code[50])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[250])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }
}





