#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51909 "Safe Custody Custodians"
{
    DrillDownPageID = 50943;
    LookupPageID = 50943;

    fields
    {
        field(1; "User ID"; Code[20])
        {
            TableRelation = User."User Name";

            trigger OnLookup()
            var
                UserManagement: Codeunit "Polytech User Management";
            begin
                UserManagement.LookupUserID("User ID");
            end;

            trigger OnValidate()
            var
                UserManagement: Codeunit "Polytech User Management";
            begin
                /*ObjUser.RESET;
                ObjUser.SETRANGE(ObjUser."User Security ID","User ID");
                IF ObjUser.FINDSET THEN BEGIN
                  "User Name":=ObjUser."User Name";
                  END;
                */

                UserManagement.ValidateUserID("User ID");

            end;
        }
        field(3; "Permision Type"; Option)
        {
            OptionCaption = 'Custodian';
            OptionMembers = Custodian;
        }
        field(4; "Custodian Of"; Option)
        {
            OptionCaption = ' ,Treasury,Safe Custody';
            OptionMembers = " ",Treasury,"Safe Custody";
        }
    }

    keys
    {
        key(Key1; "User ID", "Permision Type", "Custodian Of")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        ObjUser: Record User;
}

