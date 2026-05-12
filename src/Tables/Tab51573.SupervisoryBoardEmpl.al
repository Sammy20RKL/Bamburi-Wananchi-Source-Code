#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51573 "Supervisory$Board$Empl"
{

    fields
    {
        field(1; "Member No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                MemberRegister.Reset;
                MemberRegister.SetRange(MemberRegister."No.", "Member No");
                if MemberRegister.Find('-') then begin
                    "Member Name" := MemberRegister.Name;
                end;
            end;
        }
        field(2; "Member Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Position held"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Employee,Board, Supervisory';
            OptionMembers = " ",Employee,Board," Supervisory";
        }
    }

    keys
    {
        key(Key1; "Member No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        MemberRegister: Record Customer;
}

