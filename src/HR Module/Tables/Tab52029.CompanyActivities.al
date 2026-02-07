table 52029 "Company Activities"
{
    DataClassification = CustomerContent;
    Caption = 'Company Activities';
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
        field(3; Day; Date)
        {
            Caption = 'Day';
        }
        field(4; Venue; Text[200])
        {
            Caption = 'Venue';
        }
        field(5; Responsibility; Code[20])
        {
            TableRelation = Employee."No." where(Status = const(Active));
            Caption = 'Responsibility';

            trigger OnValidate()
            begin
                if Employee.Get(Responsibility) then
                    Name := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
            end;
        }
        field(6; Costs; Decimal)
        {
            Caption = 'Costs';
        }
        field(7; "G/L Account No"; Code[20])
        {
            NotBlank = true;
            TableRelation = "G/L Account"."No.";
            Caption = 'G/L Account No';
        }
        field(8; "Bal. Account Type"; Option)
        {
            OptionCaption = 'G/L Account,Bank';
            OptionMembers = "G/L Account",Bank;
            Caption = 'Bal. Account Type';

            trigger OnValidate()
            begin
                //{
                //IF "Bal. Account Type" = "Bal. Account Type"::"G/L Account" THEN
                //GLAccts.GET(GLAccts."No.")
                //ELSE
                //Banks.GET(Banks."No.");
                //}
            end;
        }
        field(9; "Bal. Account No"; Code[20])
        {
            NotBlank = true;
            TableRelation = "G/L Account"."No.";
            Caption = 'Bal. Account No';
        }
        field(10; Post; Boolean)
        {
            Caption = 'Post';
        }
        field(11; Posted; Boolean)
        {
            Editable = true;
            Caption = 'Posted';
        }
        field(12; "Attachment No."; Integer)
        {
            Caption = 'Attachment No.';
        }
        field(13; "Language Code (Default)"; Code[10])
        {
            TableRelation = Language;
            Caption = 'Language Code (Default)';
        }
        field(14; Attachement; Option)
        {
            OptionMembers = No,Yes;
            Caption = 'Attachement';
        }
        field(15; Name; Text[50])
        {
            Caption = 'Name';
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
    }

    var
        Employee: Record "HR Employees";
}





