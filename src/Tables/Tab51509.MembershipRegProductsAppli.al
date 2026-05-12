#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51509 "Membership Reg. Products Appli"
{
    DrillDownPageID = "Membership App Products";
    LookupPageID = "Membership App Products";

    fields
    {
        field(1; "Membership Applicaton No"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Membership Applications"."No.";
        }
        field(2; Names; Text[50])
        {
            NotBlank = true;
            TableRelation = "Membership Applications".Name;
        }
        field(3; Product; Code[20])
        {
            TableRelation = "Account Types-Saving Products".Code;

            trigger OnValidate()
            begin
                AccountTypes.Reset;
                AccountTypes.SetRange(AccountTypes.Code, Product);
                if AccountTypes.Find('-') then begin
                    "Product Source" := AccountTypes."Activity Code";
                    "Product Name" := AccountTypes.Description;
                    "Product Source" := AccountTypes."Activity Code";
                end;
            end;
        }
        field(4; "Product Source"; Option)
        {
            OptionCaption = 'BOSA,MWANANGU,JIOKOE';
            OptionMembers = BOSA,MWANANGU,JIOKOE;
        }
        field(5; "Product Name"; Text[50])
        {
        }
        field(10; "Applicant ID"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(11; "Applicant Name"; Text[100])
        {
            DataClassification = ToBeClassified;

        }
        field(12; "Applicant Gender"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "",Male,Female;
            OptionCaption = ' ,Male,Female';

        }
        field(13; "Applicant Age"; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(6; "Default Product"; Boolean)
        {
        }
        field(9; "Product Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",BOSA;
            OptionCaption = ' ,BOSA';

        }
    }

    keys
    {
        key(Key1; "Membership Applicaton No", Product)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        AccountTypes: Record "Account Types-Saving Products";
}

