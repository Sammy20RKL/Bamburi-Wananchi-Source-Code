table 59054 "User Activity Log"
{
    Caption = 'User Activity Log';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            DataClassification = SystemMetadata;
        }

        field(2; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = SystemMetadata;
        }

        field(3; "Activity Date"; Date)
        {
            Caption = 'Activity Date';
            DataClassification = SystemMetadata;
        }

        field(4; "Activity Time"; Time)
        {
            Caption = 'Activity Time';
            DataClassification = SystemMetadata;
        }

        field(5; "Activity Type"; Text[100])
        {
            Caption = 'Activity Type';
            DataClassification = CustomerContent;
        }

        field(6; "Table ID"; Integer)
        {
            Caption = 'Table ID';
            DataClassification = SystemMetadata;
        }

        field(7; "Document No."; Code[30])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }

        field(8; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }

        field(9; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }

        key(DateUser; "Activity Date", "User ID") { }
        key(User; "User ID") { }
    }
}
