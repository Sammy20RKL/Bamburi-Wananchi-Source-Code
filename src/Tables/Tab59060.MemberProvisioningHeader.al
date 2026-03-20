table 50600 "Member Provisioning Header"
{

    fields
    {
        field(1; "Transaction No"; Code[20])
        {
            Caption = 'Transaction No';
        }
        field(2; "Description"; Text[50])
        {
            Caption = 'Description';
        }
        field(3; "Period"; Integer)
        {
            Caption = 'Period';
        }
        field(4; "Start Date"; DateTime)
        {
            Caption = 'Start Date';
        }
        field(5; "End Date"; DateTime)
        {
            Caption = 'End Date';
        }
        field(6; "Branch Code"; Text[50])
        {
            TableRelation = "Dimension Value"."Code";
            Caption = 'Branch Code';
        }
        field(7; "No Series"; Code[20])
        {
            Caption = 'No Series';
        }
    }

    keys
    {
        key(PK; "Transaction No")
        {
            Clustered = true;
        }
    }

}