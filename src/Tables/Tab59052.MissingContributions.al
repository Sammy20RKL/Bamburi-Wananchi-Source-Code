table 59052 "Missing Contributions"
{
    Caption = 'Missing Contributions';
    DataClassification = ToBeClassified;
    DataPerCompany = false;

    fields
    {
        field(1; "Entry No"; Integer)
        {
            Caption = 'Entry No';
        }
        field(2; "Loan Number"; Code[50])
        {
            Caption = 'Loan Number';
            TableRelation = "Loans Register"."Loan  No.";
        }
        field(3; "Batch No"; Code[50])
        {
            Caption = 'Batch No';
        }
        field(4; "Member Number"; Code[50])
        {
            Caption = 'Member Number';
            TableRelation = Customer."No.";
        }
        field(5; "Member Name"; Code[100])
        {
            Caption = 'Member Name';
        }
        field(6; AmountPosted; Decimal)
        {
            Caption = 'AmountPosted';
        }
        field(7; "Month Missing"; Date)
        {
            Caption = 'Month Missing';
        }
        field(8; Description; Code[100])
        {
            Caption = 'Description';
        }
        field(9; "Month Name"; Code[50])
        {
            Caption = 'Month Missing Name';
        }
    }
    keys
    {
        key(PK; "Entry No")
        {
            Clustered = true;
        }
    }
}
