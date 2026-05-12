#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51570 "Audit Entries"
{

    fields
    {
        field(1; "Entry No"; Integer)
        {
        }
        field(2; "Transaction Type"; Text[120])
        {
        }
        field(3; UsersId; Code[60])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(4; Amount; Decimal)
        {
        }
        field(5; Source; Code[60])
        {
        }
        field(6; Date; Date)
        {
        }
        field(7; Time; Time)
        {
        }
        field(8; "Loan Number"; Code[40])
        {
        }
        field(9; "Document Number"; Code[40])
        {
        }
        field(10; "Account Number"; Code[60])
        {
        }
        field(11; "ATM Card"; Code[40])
        {
        }
        field(12; "Sender ID"; Code[60])
        {
        }
        field(13; "Record ID"; Code[80])
        {
        }
    }

    keys
    {
        key(Key1; "Entry No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        Error(Error2);
    end;

    trigger OnModify()
    begin
        Error(Error1);
    end;

    var
        Error1: label 'Modification Not Allowed';
        Error2: label 'Deletion Not Allowed';
}

