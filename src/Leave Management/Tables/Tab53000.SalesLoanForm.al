table 53021 "Sales Loan Form"
{
    Caption = 'Sales Loan Form';
    DataClassification = ToBeClassified;
    DataPerCompany = false;

    fields
    {
        field(1; "Document No"; Code[20])
        {
        }
        field(2; "Transaction Date"; Date)
        {
        }
        field(3; "Account No"; Code[150])
        {
        }
        field(4; Description; Text[300])
        {
        }
        field(5; Amount; Decimal)
        {
        }
        field(6; Posted; Boolean)
        {
        }

        field(8; "Transaction Time"; Time)
        {
        }

        field(10; "Document Date"; Date)
        {
        }
        field(11; "Date Posted"; Date)
        {
        }



        field(19; Telephone; Text[100])
        {
        }
        field(20; "Account Name"; Text[300])
        {
        }
        // field(21; "Needs Manual Posting"; Boolean)
        // {
        // }
        field(22; "Member Application No."; Code[200])
        {
        }

        // field(26; Reversed; Boolean)
        // {
        // }
        // field(27; "Paybill Account No"; Code[50])
        // {
        // }
        field(28; Used; Boolean) { }
    }

    keys
    {
        key(Key1; "Document No", "Member Application No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnModify()
    begin
        if Rec.Posted then begin
            Error('Record is posted and cannot be edited');
        end;
    end;

    trigger OnRename()

    begin
        if Rec.Posted then begin
            Error('Record is posted and cannot be edited');
        end;

    end;


    //ERROR('You are permitted to edit this transaction');

}
