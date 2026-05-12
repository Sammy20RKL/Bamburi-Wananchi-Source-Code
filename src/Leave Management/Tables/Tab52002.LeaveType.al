table 52002 "Leave Type"
{
    DataClassification = CustomerContent;
    Caption = 'Leave Type';
    fields
    {
        field(1; "Code"; Code[20])
        {
            NotBlank = true;
            Caption = 'Code';
        }
        field(2; Description; Text[200])
        {
            Caption = 'Description';
        }
        field(3; Days; Decimal)
        {
            Caption = 'Days';
        }
        field(4; "Earn Days"; Boolean)
        {
            Caption = 'Earn Days';
        }
        field(5; "Unlimited Days"; Boolean)
        {
            Caption = 'Unlimited Days';
        }
        field(6; Gender; Enum "Employee Gender HR")
        {
            Caption = 'Gender';
        }
        field(7; Balance; Option)
        {
            OptionCaption = 'Ignore,Carry Forward,Convert to Cash';
            OptionMembers = Ignore,"Carry Forward","Convert to Cash";
            Caption = 'Balance';
        }
        field(8; "Inclusive of Holidays"; Boolean)
        {
            Caption = 'Inclusive of Holidays';
        }
        field(9; "Inclusive of Saturday"; Boolean)
        {
            Caption = 'Inclusive of Saturday';
        }
        field(10; "Inclusive of Sunday"; Boolean)
        {
            Caption = 'Inclusive of Sunday';
        }
        field(11; "Off/Holidays Days Leave"; Boolean)
        {
            Caption = 'Off/Holidays Days Leave';
        }
        field(12; "Max Carry Forward Days"; Decimal)
        {
            Caption = 'Max Carry Forward Days';

            trigger OnValidate()
            begin
                if Balance <> Balance::"Carry Forward" then
                    "Max Carry Forward Days" := 0;
            end;
        }
        field(13; "Days Earned per Month"; Decimal)
        {
            Caption = 'Days Earned per Month';
        }
        field(14; "Annual Leave"; Boolean)
        {
            Caption = 'Annual Leave';
        }
        field(15; Status; Option)
        {
            OptionCaption = 'Active,Inactive';
            OptionMembers = Active,Inactive;
            Caption = 'Status';
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Code, Description)
        {
        }
    }
}





