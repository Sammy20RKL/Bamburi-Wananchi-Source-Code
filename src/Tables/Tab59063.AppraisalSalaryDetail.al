table 59063 "Appraisal Salary Details"
{


    fields
    {
        field(1; "Loan No"; Code[20])
        {
            TableRelation = "Loans Register"."Loan  No.";

        }
        field(2; "Client Code"; Code[20])
        {
            TableRelation = Customer."No.";

        }
        field(3; "Code"; Code[20])
        {

        }
        field(4; "Description"; Text[30])
        {

        }
        field(5; "Type"; Option)
        {
            OptionMembers = " ",Deduction,Earning;
            OptionCaption = ' ,Deduction,Earning';
        }
        field(6; "Amount"; Decimal)
        {

        }
    }

    keys
    {
        key(PK; "Loan No", "Client Code", "Code")
        {
            Clustered = true;
        }
    }
}