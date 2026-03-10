#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
table 50095 "Members Next Kin Details"
{

    fields
    {
        field(2; Name; Text[50])
        {
            NotBlank = true;

            trigger OnValidate()
            begin
                Name := UpperCase(Name);
            end;
        }
        field(3; Relationship; Text[30])
        {
            TableRelation = "Relationship Types".Describution;
        }
        field(4; Beneficiary; Boolean)
        {
        }
        field(5; "Date of Birth"; Date)
        {
        }
        field(6; Address; Text[150])
        {
        }
        field(7; Telephone; Code[20])
        {
        }
        field(8; Fax; Code[10])
        {
        }
        field(9; Email; Text[30])
        {
        }
        field(10; "Account No"; Code[20])
        {
            TableRelation = Customer."No.";
        }
        field(11; "ID No."; Code[20])
        {
        }
        field(12; "%Allocation"; Decimal)
        {
        }
        field(13; "New Upload"; Boolean)
        {
        }
        field(14; Type; Option)
        {

            OptionMembers = "Next of Kin","Benevolent Beneficiary";
        }
        field(15; "Maximun Allocation %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(Key1; "Account No", Name)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

