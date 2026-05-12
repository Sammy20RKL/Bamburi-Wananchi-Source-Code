table 59043 PayrollDepartments
{
    DataClassification = ToBeClassified;
    DrillDownPageId = PayrollDepartment;
    LookupPageId = PayrollDepartment;

    fields
    {
        field(1; code; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; Department; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; code)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}