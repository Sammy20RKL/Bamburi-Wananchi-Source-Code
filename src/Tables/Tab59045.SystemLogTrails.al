table 59045 "System Log Trails"
{

    fields
    {
        field(1; "Entry No"; Integer)
        {
            AutoIncrement = true;
            Editable = false;
        }
        field(2; "Session Type"; Enum "Audit Session Types")
        {
        }
        field(3; "User ID"; Code[100])
        {
            TableRelation = "User Setup"."User ID";
        }
        //---------------------------------------------------------User LogIn
        field(4; "Log In Time"; DateTime)
        {
            TableRelation = "User Setup"."User ID";
        }
        field(5; "Log In Computer Name"; Code[200])
        {
        }
        field(6; "Server Instance"; Text[50])
        {
        }
        field(22; "Session ID"; Integer)
        {
        }
        field(23; "Database Name"; Text[100])
        {
        }
        field(24; "Event Date/Time"; DateTime)
        {
        }
        //--------------------------------------------------------User LogOut
        field(7; "Log out Time"; DateTime)
        {
        }
        field(8; "Minutes Logged In"; Decimal)
        {
        }
        //--------------------------------------------------------Financial Transaction Posted
        field(9; "Transaction Type ID"; enum TransactionTypesEnum)
        {
        }
        field(10; "Transacting Branch ID"; Code[100])
        {
            CaptionClass = '1,2,2';
            Editable = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2),
                                                          "Dimension Value Type" = const(Standard));
        }
        field(25; "Account Type ID"; Enum "Gen. Journal Account Type")
        {
        }
        field(11; "Account ID"; Code[50])
        {
        }
        field(12; "Transaction ID"; Code[50])
        {
        }
        field(13; "Transaction Description"; text[250])
        {
        }
        field(14; "Transaction Date"; Date)
        {
        }
        field(15; "Transaction Time"; time)
        {
        }
        field(16; "Transaction Type"; Option)
        {
            OptionMembers = "",Debit,Credit;
        }
        field(17; "Transaction Amount"; Decimal)
        {
        }
        field(18; "Authorized By"; code[100])
        {
            TableRelation = "User Setup"."User ID";
        }
        //--------------------------------------------------------Record Approvals Sent/Cancelled/Approved/Rejected
        field(19; "Approval Action"; Option)
        {
            OptionMembers = "",Sent,Approved,Cancelled,Rejected,Delegated;
        }
        field(20; "Approval Action Description"; text[250])
        {

        }
        //--------------------------------------------------------Read Audit
        field(26; "Page Viewed"; text[2048])
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

    var

}

