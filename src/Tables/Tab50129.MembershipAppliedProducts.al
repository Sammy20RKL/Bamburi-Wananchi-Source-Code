table 50129 "Membership Applied Products"
{
    DataClassification = ToBeClassified;
    Caption = 'Stores products applied by members during membership application process';
    fields
    {
        field(1; "Product Code"; Code[40])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Account Types-Saving Products".Code;
            Editable = true;

        }

        field(2; "Product Name"; Code[40])
        {
            DataClassification = ToBeClassified;

        }
        field(3; Description; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Earns Interest"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(5; "Interest Rate(%)"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(6; "Withdrawal Interval"; DateFormula)
        {
            DataClassification = ToBeClassified;

        }
        field(7; "Service Charges"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(8; "Dormancy Period(M)"; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(9; "Product Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",BOSA;
            OptionCaption = ' ,BOSA';

        }
        field(14; "Membership Applicaton No"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Membership Applications"."No.";
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
        field(15; "Entry No"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;

        }

    }

    keys
    {
        key(Key1; "Entry No", "Membership Applicaton No")
        {
            Clustered = true;
        }
    }
    //.......................................Variables start..............................................
    var
    // SaccoGeneralSetUp: Record "Sacco General Setup";
    // NoSeriesManagement: Codeunit NoSeriesManagement;
    //.......................................Variables start..............................................


    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin
        //Error('You cannot delete records stored in the database!');
    end;

    trigger OnRename()
    begin

    end;

}