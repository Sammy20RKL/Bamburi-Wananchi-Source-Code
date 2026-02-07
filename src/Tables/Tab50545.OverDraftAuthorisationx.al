#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
table 50545 "Over Draft Authorisationx"
{
    DrillDownPageID = "Cashier Transactions - Posted";
    LookupPageID = "Cashier Transactions - Posted";

    fields
    {
        field(1; "Over Draft No"; Code[20])
        {

            trigger OnValidate()
            begin
                if "Over Draft No" <> xRec."Over Draft No" then begin
                    SaccoSetup.Get;
                    NoSeriesMgt.TestManual(SaccoSetup."OVerdraft Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Over Draft Payoff"; Code[20])
        {
            TableRelation = "Over Draft Register"."Over Draft No" where(Posted = const(true));

            trigger OnValidate()
            begin

                if Confirm('Are you Sure you Want to apply for overdraft?', true) = true then begin

                end;
            end;
        }
        field(3; "Account No"; Code[20])
        {

            trigger OnValidate()
            begin
                if Cust.Get("Account No") then begin
                    "Account Name" := Cust.Name;
                    "Application date" := Today;
                    "Captured by" := UserId;
                    "Current Account No" := Cust."BOSA Account No";
                    "Email Address" := Cust."E-Mail (Personal)";
                    "Phone No" := Cust."Mobile Phone No";
                    "ID Number" := Cust."ID No.";
                end;
            end;
        }
        field(4; "Application date"; Date)
        {
        }
        field(5; "Approved Date"; Date)
        {
        }
        field(6; "Captured by"; Code[100])
        {
        }
        field(7; "Account Name"; Code[100])
        {
        }
        field(8; "Current Account No"; Code[20])
        {
        }
        field(9; "Outstanding Overdraft"; Decimal)
        {
            FieldClass = Normal;
        }
        field(10; "Amount applied"; Decimal)
        {

            trigger OnValidate()
            begin
                GenSetUp.Get;
                if "Amount applied" > GenSetUp."Overdraft Limit" then begin
                    excees := GenSetUp."Overdraft Limit" - "Amount applied";
                    Error('Amount applied exceed limit ');
                end else
                    Message('proceed ');
            end;
        }
        field(11; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(12; "ID Number"; Code[10])
        {
        }
        field(13; "Phone No"; Code[10])
        {
        }
        field(14; "Email Address"; Text[30])
        {
        }
        field(15; Posted; Boolean)
        {
        }
        field(16; Status; Option)
        {
            OptionCaption = 'Open,Pending,Approved';
            OptionMembers = Open,Pending,Approved;
        }
        field(17; "No. Series"; Code[10])
        {
        }
        field(18; "Overdraft Status"; Option)
        {
            OptionCaption = ',Active,Inactive';
            OptionMembers = ,Active,Inactive;
        }
        field(19; "Approved Amount"; Decimal)
        {
        }
        field(20; "Authorisation Requirement"; Text[100])
        {
        }
        field(21; "Supervisor Checked"; Boolean)
        {
        }
        field(22; "Date Posted"; Date)
        {
        }
        field(23; "Time Posted"; Time)
        {
        }
        field(24; "Posted By"; Code[50])
        {
        }
        field(25; "Entry NO"; Integer)
        {
        }
        field(26; "Authoriser Id"; Code[100])
        {
        }
        field(27; Recovered; Boolean)
        {
        }
        field(28; "Recovered Amount"; Decimal)
        {
        }
        field(29; "Document Type"; Option)
        {
            OptionCaption = ',Overdraft,Recovery';
            OptionMembers = ,Overdraft,Recovery;
        }
    }

    keys
    {
        key(Key1; "Account No", "Entry NO")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Account No", "Application date", "Approved Date", "Captured by", "Account Name", "Current Account No", "Outstanding Overdraft", "Amount applied", "Date Filter", "Phone No")
        {
        }
    }

    trigger OnInsert()
    begin
        if "Over Draft No" = '' then begin
            SaccoSetup.Get;
            SaccoSetup.TestField(SaccoSetup."OVerdraft Nos");
            // NoSeriesMgt.InitSeries(SaccoSetup."OVerdraft Nos", xRec."No. Series", 0D, "Over Draft No", "No. Series");
        end;
    end;

    var
        Loans: Record "Loans Register";
        Loantypes: Record "Loan Products Setup";
        Interest: Decimal;
        Cust: Record Vendor;
        LoansTop: Record "Loan Offset Details";
        GenSetUp: Record "Sacco General Set-Up";
        vendor: Record Vendor;
        SaccoSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit "No. Series";
        excees: Decimal;
}

