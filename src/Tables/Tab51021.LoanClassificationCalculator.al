Table 51021 "Loan Classification Calculator"
{
    fields
    {
        field(1; "Loan No"; Code[50])
        {
            Editable = false;
        }
        field(2; "Principle In Arrears"; Decimal)
        {
        }
        field(3; "Interest In Arrears"; Decimal)
        {
        }
        field(4; "Amount In Arrears"; Decimal)
        {
        }
        field(5; "No of Days In Arrears"; Integer)
        {
        }
        field(6; "No of months In Arrears"; Integer)
        {
        }
        field(7; "SASRA Loan Category"; ENUM LoansCategorySASRA)
        {
        }
        field(8; "Client Code"; Code[50])
        {
        }
    }
}
