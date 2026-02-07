table 52106 "Company Job Prof Membership"
{
    DataClassification = CustomerContent;
    Caption = 'Company Job Prof Membership';
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
        field(3; Name; Code[500])
        {
            // TableRelation = "Professional Memberships";
            // Caption = 'Name';

            // trigger OnValidate()
            // var
            //     ProfMemb: Record "Professional Memberships";
            // begin
            //     if ProfMemb.Get(Name) then
            //         Description := ProfMemb.Description;
            // end;
        }
        field(4; Description; Code[500])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; "Job ID", Name, "Line No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}





