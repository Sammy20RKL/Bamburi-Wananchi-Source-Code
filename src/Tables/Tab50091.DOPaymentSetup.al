#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
table 50091 "DO Payment Setup"
{
    Caption = 'Dynamics Online Payment Setup';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Authorization Required"; Boolean)
        {
            Caption = 'Authorization Required';
        }
        field(3; "Days Before Auth. Expiry"; Integer)
        {
            Caption = 'Days Before Auth. Expiry';
            MinValue = 0;
        }
        field(4; "Credit Card Nos."; Code[10])
        {
            Caption = 'Credit Card Nos.';
            TableRelation = "No. Series";
        }
        field(5; "Charge Type"; Option)
        {
            Caption = 'Charge Type';
            OptionCaption = 'Percent,Fixed';
            OptionMembers = Percent,"Fixed";

            trigger OnValidate()
            begin
                if not ("Charge Type" = "charge type"::Percent) then
                    "Max. Charge Amount (LCY)" := 0;
            end;
        }
        field(6; "Charge Value"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Charge Value';
            DecimalPlaces = 2 : 2;
            MinValue = 0;
        }
        field(7; "Max. Charge Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Max. Charge Amount ($)';
            DecimalPlaces = 2 : 2;
            MinValue = 0;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

