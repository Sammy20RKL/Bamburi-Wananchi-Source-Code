table 52008 "Leave Entitlement Entry"
{
    Caption = 'Leave Entitlement Entry';
    DataClassification = CustomerContent;
    LookupPageId = "Leave Entitlement Entries";
    DrillDownPageId = "Leave Entitlement Entries";

    fields
    {
        field(1; "Leave Type Code"; Code[20])
        {
            Caption = 'Leave Type Code';
            TableRelation = "Leave Type".Code;
        }
        field(2; "Employee Category"; Code[20])
        {
            Caption = 'Employee Category';
            TableRelation = "Employee Category".Code;
        }
        field(3; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region".Code;
        }
        field(4; Days; Decimal)
        {
            Caption = 'Days';
        }
        field(5; "Days Earned per Month"; Decimal)
        {
            Caption = 'Days Earned per Month';
        }
    }
    keys
    {
        key(PK; "Leave Type Code", "Employee Category", "Country/Region Code")
        {
            Clustered = true;
        }
    }
}
