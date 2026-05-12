table 52009 "Employee Category"
{
    Caption = 'Employee Category';
    DataClassification = SystemMetadata;
    LookupPageId = "Employee Categories";
    DrillDownPageId = "Employee Categories";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}
