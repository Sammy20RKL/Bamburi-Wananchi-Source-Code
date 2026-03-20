table 59062 "Monthly Advice"
{


    fields
    {
        field(1; "Entry No"; Integer)
        {
            Caption = 'Entry No';
        }
        field(2; "Staff No."; Text[50])
        {
            Caption = 'Staff No.';
        }
        field(3; "Loan Type"; Code[20])
        {
            Caption = 'Loan Type';
        }
        field(4; "Document Date"; DateTime)
        {
            Caption = 'Document Date';
        }
        field(5; "Posting Date"; DateTime)
        {
            Caption = 'Posting Date';
        }
        field(6; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(7; "Description"; Text[30])
        {
            Caption = 'Description';
        }
        field(8; "Share Capital"; Decimal)
        {
            Caption = 'Share Capital';
        }
        field(9; "Monthly Deposits Contribution"; Decimal)
        {
            Caption = 'Monthly Deposits Contribution';
        }
        field(10; "Registration Fees"; Decimal)
        {
            Caption = 'Registration Fees';
        }
        field(11; "Insurance"; Decimal)
        {
            Caption = 'Insurance';
        }
        field(12; "Monthly Deposit Contribution"; Decimal)
        {
            Caption = 'Monthly Deposit Contribution';
        }
        field(13; "Loan Principle"; Decimal)
        {
            Caption = 'Loan Principle';
        }
        field(14; "Loan Interest"; Decimal)
        {
            Caption = 'Loan Interest';
        }
        field(15; "Account No"; Code[20])
        {
            Caption = 'Account No';
        }
        field(16; "Account Name"; Text[80])
        {
            Caption = 'Account Name';
        }
        field(17; "Employer Code"; Code[20])
        {
            Caption = 'Employer Code';
        }
        field(18; "Period"; Code[20])
        {
            Caption = 'Period';
        }
        field(19; "Interest"; Decimal)
        {
            Caption = 'Interest';
        }
        field(20; "Loans"; Decimal)
        {
            Caption = 'Loans';
        }
        field(21; "Name"; Text[100])
        {
            Caption = 'Name';

        }
        field(22; "Xmas Contribution"; Decimal)
        {
            Caption = 'Xmas Contribution';
        }
        field(23; "Penalty BOSA"; Decimal)
        {
            Caption = 'Penalty BOSA';
        }
        field(24; "Total"; Decimal)
        {
            Caption = 'Total';
        }
        field(25; "Company Code"; Code[20])
        {
            Caption = 'Company Code';
            // TableRelation=Emplo
        }
        field(26; "Advice Date"; DateTime)
        {
            Caption = 'Advice Date';
        }
        field(27; "Member No."; Text[50])
        {
            Caption = 'Member No.';
            TableRelation = Customer."No.";
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