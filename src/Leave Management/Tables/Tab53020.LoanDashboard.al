table 53020 "Loan Product Dashboard"
{
    Caption = 'Loan Product Dashboard';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Product Code"; Code[20]) { }
        field(2; "Product Name"; Text[100]) { }
        field(3; "Outstanding Balance"; Decimal) { }
        field(4; "Active Loans"; Integer) { }
        field(5; "Last Updated"; DateTime) { }
    }

    keys
    {
        key(PK; "Product Code")
        {
            Clustered = true;
        }
    }
}