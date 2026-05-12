table 50518 "Member Reapplication"
{
    Caption = 'Member Reapplication';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Member Re-Application List";
    LookupPageId = "Member Re-Application List";


    fields
    {
        field(1; "No."; Code[50])
        {
            Caption = 'No.';
            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    SalesSetup.Get;
                    NoSeries.TestManual(SalesSetup."Member Re-Application No.s");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Member No."; Code[50])
        {
            Caption = 'Member No.';
            TableRelation = Customer."No." where("Customer Type" = const(Member), Status = const(Withdrawal));
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if cust.get("Member No.") then
                    "Member Name" := cust.Name;
                "Status on Exit" := cust.Status;
                cust.CalcFields("Share Capital");
                "Share Capital" := Cust."Share Capital";

            end;
        }
        field(3; "Member Name"; Text[100])
        {
            Caption = 'Member Name';
        }
        field(4; "Reason for Re-Application"; Text[100])
        {
            Caption = 'Reason for Re-Application';
        }
        field(5; "Reason for Exit"; Text[100])
        {
            Caption = 'Reason for Exit';
        }
        field(6; "Re-Application By"; Code[50])
        {
            Caption = 'Re-Application By';
        }
        field(7; "Re-Application On"; Date)
        {
            Caption = 'Re-Application On';
        }
        field(8; "Re-Application status"; Enum "Account Status")
        {
            Caption = 'Re-Application status';
        }
        field(9; "Status on Exit"; Enum "Account Status")
        {
            Caption = 'Status on Exit';
        }
        field(10; "Exit Date"; Date)
        {
            Caption = 'Exit Date';
        }
        field(11; "Exited By"; Code[50])
        {
            Caption = 'Exited By';
            DataClassification = ToBeClassified;
        }
        field(12; "No. Series"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(13; Status; Option)
        {
            OptionCaption = 'Open,Pending,Approved';
            OptionMembers = Open,Pending,Approved;
        }
        field(14; Reactivated; Boolean) { }
        field(15; "Share Capital"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        myInt: Integer;
    begin
        if "No." = '' then begin
            SalesSetup.Get;
            SalesSetup.TestField(SalesSetup."Member Re-Application No.s");
            "No." := NoSeries.GetNextNo(SalesSetup."Member Re-Application No.s");
            // NoSeriesMgt.InitSeries(SalesSetup."Member Re-Application No.s", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        "Re-Application On" := Today;
        "Re-Application By" := UpperCase(UserId);
    end;

    var
        cust: Record Customer;
        SalesSetup: Record "Sacco No. Series";
        NoSeries: Codeunit "No. Series";

}
