#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51297 "Daily Loans Interest Buffer"
{
    // DrillDownPageID = 50755;
    // LookupPageID = 50755;

    fields
    {
        field(1; No; Integer)
        {
            AutoIncrement = true;
            Editable = false;
        }
        field(2; "Loan No."; Code[50])
        {
            Editable = false;
            TableRelation = "Loans Register";
        }
        field(3; "Interest Date"; Date)
        {
        }
        field(4; "Account Type"; Option)
        {
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Savings,Credit,Member';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Savings,Credit,Member;
        }
        field(5; "Account No"; Code[20])
        {
            Editable = false;
        }
        field(6; "Loan Product type"; Code[10])
        {
            Editable = false;
            TableRelation = "Loan Products Setup";
        }
        field(7; "Interest Amount"; Decimal)
        {
        }
        field(8; "User ID"; Code[40])
        {
        }
        field(10; Transferred; Boolean)
        {
        }
        field(11; Posted; Boolean)
        {
        }
        field(12; "Repayment Amount"; Decimal)
        {
        }
        field(13; "Monthly Repayment"; Decimal)
        {
        }
        field(14; "Interest Matured"; Boolean)
        {
        }
        field(15; "Late Interest"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Loan No.", "Interest Date")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        NoSetup: Record "Purchases & Payables Setup";
    //NoSeriesMgt: Codeunit NoSeriesManagement;
}

