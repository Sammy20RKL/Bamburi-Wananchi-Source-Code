table 52096 "Key Job responsibilities"
{
    DataClassification = CustomerContent;
    Caption = 'Key Job responsibilities';
    fields
    {
        field(1; "Line No"; Integer)
        {
            Caption = 'Line No';
        }
        field(2; Code; Code[10])
        {
            Caption = 'Code';
        }
        field(3; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(4; "No. of Contacts"; Integer)
        {
            Caption = 'No. of Contacts';
        }
    }

    keys
    {
        key(Key1; Code, "Line No")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;
}





