// Create a temporary table buffer for loan arrears selection
table 59051 "Loan Arrears Selection Buffer"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "Client Code"; Code[20])
        {
            Caption = 'Client Code';
            DataClassification = ToBeClassified;
        }
        field(3; "Loan No."; Code[20])
        {
            Caption = 'Loan No.';
            DataClassification = ToBeClassified;
        }
        field(4; "Source Loan No."; Code[20])
        {
            Caption = 'Source Loan No.';
            DataClassification = ToBeClassified;
        }
        field(5; "Loan Type"; Code[20])
        {
            Caption = 'Loan Type';
            DataClassification = ToBeClassified;
        }
        field(6; "Principal Amount"; Decimal)
        {
            Caption = 'Principal Amount';
            DataClassification = ToBeClassified;
        }
        field(7; "Interest Amount"; Decimal)
        {
            Caption = 'Interest Amount';
            DataClassification = ToBeClassified;
        }
        field(8; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
            DataClassification = ToBeClassified;
        }
        field(9; "Selected"; Boolean)
        {
            Caption = 'Selected';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}