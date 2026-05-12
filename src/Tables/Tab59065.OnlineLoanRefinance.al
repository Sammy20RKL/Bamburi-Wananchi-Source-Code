#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 59065 "Online Loan Offset Details"
{

    fields
    {

        field(1; "Loan No."; Code[20])
        {

        }
        field(2; "Loan Top Up"; Code[20])
        {


        }
        field(3; "Client Code"; Code[20])
        {
        }
        field(4; "Loan Type"; Code[30])
        {
        }
        field(5; "Principle Top Up"; Decimal)
        {

        }
        field(6; "Interest Top Up"; Decimal)
        {

        }
        field(7; "Total Top Up"; Decimal)
        {
        }
        field(8; "Monthly Repayment"; Decimal)
        {
        }
        field(9; "Interest Paid"; Decimal)
        {
        }
        field(10; "Outstanding Balance"; Decimal)
        {
            FieldClass = Normal;
        }
        field(11; "Interest Rate"; Decimal)
        {

        }
        field(12; "ID. NO"; Code[20])
        {
        }
        field(13; Commision; Decimal)
        {

        }
        field(14; "Partial Bridged"; Boolean)
        {

        }
        field(15; "Remaining Installments"; Decimal)
        {
        }
        field(16; "Finale Instalment"; Decimal)
        {
        }
        field(17; "Penalty Charged"; Decimal)
        {

        }
        field(18; "Staff No"; Code[20])
        {
        }
        field(19; "Commissioning Balance"; Decimal)
        {

        }
        field(20; "Interest Due at Clearance"; Decimal)
        {
        }
        field(21; "Loan Age"; Integer)
        {
        }
        field(22; "BOSA No"; Code[50])
        {
        }
        field(23; "50% of Initial Loan"; Decimal)
        {
        }
        field(24; "FOSA Account"; Code[30])
        {
            TableRelation = Vendor."No." where("BOSA Account No" = field("Client Code"));
        }
        field(25; "Loan Offset From FOSA"; Boolean)
        {
        }
        field(26; "Loan Offset From FOSA Date"; Date)
        {
        }
        field(27; "Loan Offset From FOSA By"; Code[30])
        {
        }
        field(28; "Additional Top Up Commission"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(29; "Loan Product Type Name"; Text[100])
        {

        }


        field(30; Submitted; Boolean)
        {

        }

        field(31; Validated; Boolean)
        {

        }
    }

    keys
    {
        key(Key1; "Loan No.", "Client Code", "Loan Top Up")
        {
            Clustered = true;
            SumIndexFields = "Total Top Up", "Principle Top Up";
        }
        key(Key2; "Principle Top Up")
        {
        }
    }

}

