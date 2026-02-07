#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 56117 "SwizzKash MPESA Trans"
{

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
        field(7; "Transaction Type"; Text[100])
        {
        }
        field(8; "Transaction Time"; Time)
        {
        }
        field(9; "Paybill Acc Balance"; Decimal)
        {
        }
        field(10; "Document Date"; Date)
        {
        }
        field(11; "Date Posted"; Date)
        {
        }
        field(12; "Time Posted"; Date)
        {
        }
        field(13; Changed; Boolean)
        {
        }
        field(14; "Date Changed"; Date)
        {
        }
        field(15; "Time Changed"; Time)
        {
        }
        field(16; "Changed By"; Code[30])
        {
        }
        field(17; "Approved By"; Code[30])
        {
        }
        field(18; "Key Word"; Text[30])
        {
        }
        field(19; Telephone; Text[100])
        {
        }
        field(20; "Account Name"; Text[300])
        {
        }
        field(21; "Needs Manual Posting"; Boolean)
        {
        }
        field(22; "Account Number"; Code[200])
        {
        }
        field(23; Remarks; Text[200])
        {
        }
        field(24; TransDate; DateTime)
        {
        }
        field(25; TraceId; code[30])
        {
        }
        field(26; Reversed; Boolean)
        {
        }
        field(27; "Paybill Account No"; Code[50])
        {
        }
    }

    keys
    {
        key(Key1; "Document No")
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

        "Changed By" := UserId;
        "Date Changed" := Today;
        "Time Changed" := Time;
        //ERROR('You are permitted to edit this transaction');
    end;
}

