#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51515 "Cheque Issue Lines-Family"
{
    DrillDownPageID = 50589;
    LookupPageID = 50589;

    fields
    {
        field(1; "Chq Receipt No"; Code[20])
        {
        }
        field(2; "Cheque Serial No"; Code[20])
        {
        }
        field(3; "Account No."; Code[20])
        {
            TableRelation = Vendor."No.";
        }
        field(4; "Date _Refference No."; Code[20])
        {
        }
        field(5; "Transaction Code"; Code[20])
        {
        }
        field(6; "Branch Code"; Code[20])
        {
        }
        field(7; Currency; Code[10])
        {
        }
        field(8; Amount; Decimal)
        {
        }
        field(9; "Date-1"; Date)
        {
        }
        field(10; "Date-2"; Date)
        {
        }
        field(11; "Family Routing No."; Code[10])
        {
        }
        field(12; Fillers; Code[10])
        {
        }
        field(13; "Transaction Refference"; Code[10])
        {
        }
        field(14; "Account Name"; Text[150])
        {
        }
        field(15; "Un pay Code"; Code[10])
        {
            TableRelation = Vendor."No.";

            trigger OnValidate()
            begin
                /*IF RetCode.GET("Un pay Code") THEN BEGIN
                Interpretation:=RetCode."Code Interpretation";
                "Un Pay Charge Amount":=RetCode.Charges;
                "Unpay Date":=TODAY;
                END ELSE
                Interpretation:='';
                 */

            end;
        }
        field(16; Interpretation; Text[150])
        {
        }
        field(17; "Family Account No."; Code[20])
        {
        }
        field(18; "Un Pay Charge Amount"; Decimal)
        {
        }
        field(19; "Unpay Date"; Date)
        {
        }
        field(20; Status; Option)
        {
            OptionCaption = 'Pending,Approved,Cancelled,stopped';
            OptionMembers = Pending,Approved,Cancelled,stopped;
        }
        field(21; "Cheque No"; Code[50])
        {
        }
        field(22; "Header No"; Code[50])
        {
        }
        field(23; "Account Balance"; Decimal)
        {
            FieldClass = Normal;
        }
        field(24; FrontImage; Blob)
        {
            SubType = Bitmap;
        }
        field(25; FrontGrayImage; Blob)
        {
            SubType = Bitmap;
        }
        field(26; BackImages; Blob)
        {
            SubType = Bitmap;
        }
        field(27; "Verification Status"; Option)
        {
            OptionCaption = 'Not Verified,Verified';
            OptionMembers = "Not Verified",Verified;
        }
        field(28; Processed; Boolean)
        {
        }
        field(29; "Transaction Date"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "Chq Receipt No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        RetCode: Record "Cheque Receipts";
}

