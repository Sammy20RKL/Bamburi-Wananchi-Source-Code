table 56066 Advertisements
{
    DataClassification = CustomerContent;
    Caption = 'Advertisements List';

    fields
    {
        field(1; No; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Code';
            Editable = false;
            trigger OnValidate()
            begin
                if "No" <> xRec."No" then begin
                    SaccoSetup.Get;
                    NoSeries.TestManual(SaccoSetup."Advertisement No.");
                    "No. Series" := '';
                end;

            end;
        }
        field(2; Name; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Name';
        }
        field(3; Description; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(4; Price; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Price';
        }
        field(5; Picture; Media)
        {
            DataClassification = CustomerContent;
            Caption = 'Picture';
        }
        field(6; Active; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Active';
        }
        field(7; "Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Start Date';
        }
        field(8; "End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'End Date';
        }
        field(9; "Stock Qty"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Stock Qty';
        }
        field(10; Category; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Category';
        }
        field(11; "Created Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Created Date';
        }
        field(12; "Created By"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Created By';
        }
        field(13; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(PK; No)
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        "Created Date" := Today;
        "Created By" := UserId;

        if "No" = '' then begin
            SaccoSetup.Get;
            SaccoSetup.TestField(SaccoSetup."Advertisement No.");
            //"No. Series" := xRec."No. Series";
            "No" := NoSeries.GetNextNo(SaccoSetup."Advertisement No.")
        end;
    end;

    var

        SaccoSetup: Record "Sacco No. Series";
        NoSeries: Codeunit "No. Series";
    // NoSerial: Codeunit "No. Series";
}

