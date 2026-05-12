table 59059 "Loan Update"
{


    fields
    {
        field(1; "Loan No"; Code[50])
        {
        }
        field(2; "OLD No"; Code[50])
        {
        }


        field(5; "Client No"; Code[50])
        {
            TableRelation = "Customer"."No.";
        }
        field(6; "Client Name"; Text[70])
        {
        }
        field(7; "Loan Type"; Code[50])
        {
            TableRelation = "Loan Products Setup".Code;
        }
        field(8; "Amount Applied"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(9; "Amount Approved"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(10; "Approved Date"; DateTime)
        {
            DataClassification = CustomerContent;
        }
        field(11; "Outstanding Balance"; Decimal)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Loan No")
        {
            Clustered = true;
        }
    }
}