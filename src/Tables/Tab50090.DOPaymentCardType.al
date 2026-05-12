#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
table 50090 "DO Payment Card Type"
{
    Caption = 'Dynamics Online Payment Card Type';
    DrillDownPageID = "Workflow Webhook Entries";
    LookupPageID = "Workflow Webhook Entries";

    fields
    {
        field(1; "Sort Order"; Integer)
        {
            AutoIncrement = false;
            Caption = 'Sort Order';
        }
        field(2; Name; Code[20])
        {
            Caption = 'Name';
            NotBlank = true;
        }
        field(3; "Validation Rule"; Integer)
        {
            Caption = 'Validation Rule';
            NotBlank = true;
        }
        field(4; "Numeric Only"; Boolean)
        {
            Caption = 'Numeric Only';
            InitValue = true;
        }
        field(5; "Allow Spaces"; Boolean)
        {
            Caption = 'Allow Spaces';
            InitValue = true;
        }
        field(6; "Min. Length"; Integer)
        {
            Caption = 'Min. Length';
        }
        field(7; "Max. Length"; Integer)
        {
            Caption = 'Max. Length';
        }
    }

    keys
    {
        key(Key1; Name)
        {
            Clustered = true;
        }
        key(Key2; "Sort Order")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        DOPaymentCardType: Record "DO Payment Card Type";
    begin
        if "Sort Order" = 0 then begin
            DOPaymentCardType.SetCurrentkey("Sort Order");
            if DOPaymentCardType.FindLast then
                "Sort Order" := DOPaymentCardType."Sort Order" + 1
            else
                "Sort Order" := 1;
        end;
    end;


    procedure CreateDefaults()
    begin
        if not FindFirst then begin
            Init;
            "Sort Order" := 1;
            Name := 'VISA';
            "Validation Rule" := 1;
            "Numeric Only" := true;
            "Allow Spaces" := false;
            "Min. Length" := 16;
            "Max. Length" := 16;
            Insert;

            Init;
            "Sort Order" := 2;
            Name := 'MASTER CARD';
            "Validation Rule" := 1;
            "Numeric Only" := true;
            "Allow Spaces" := false;
            "Min. Length" := 16;
            "Max. Length" := 16;
            Insert;

            Init;
            "Sort Order" := 3;
            Name := 'AMERICAN EXPRESS';
            "Validation Rule" := 1;
            "Numeric Only" := true;
            "Allow Spaces" := false;
            "Min. Length" := 15;
            "Max. Length" := 15;
            Insert;

            Init;
            "Sort Order" := 4;
            Name := 'DISCOVER';
            "Validation Rule" := 1;
            "Numeric Only" := true;
            "Allow Spaces" := false;
            "Min. Length" := 16;
            "Max. Length" := 16;
            Insert;
        end;
    end;
}

