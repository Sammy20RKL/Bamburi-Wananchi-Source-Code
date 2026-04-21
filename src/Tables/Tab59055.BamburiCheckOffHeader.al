table 59055 "Bamburi Checkoff Header"
{

    fields
    {
        field(1; No; Code[20])
        {

            trigger OnValidate()
            begin
                if No = '' then begin
                    NoSetup.Get();
                    NoSetup.TestField(NoSetup."Bosa Transaction Nos");
                    //   NoSeriesMgt.InitSeries(NoSetup."Bosa Transaction Nos", xRec."No. Series", 0D, No, "No. Series");
                end;
            end;
        }
        field(2; "No. Series"; Code[20])
        {
        }
        field(3; Posted; Boolean)
        {
            Editable = false;
        }
        field(6; "Posted By"; Code[60])
        {
            Editable = false;
        }
        field(7; "Date Entered"; Date)
        {
        }
        field(9; "Entered By"; Text[60])
        {
        }
        field(10; Remarks; Text[150])
        {
        }
        field(19; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(20; "Time Entered"; Time)
        {
        }
        field(21; "Posting date"; Date)
        {
        }
        field(22; "Account Type"; Option)
        {
            OptionMembers = "G/L Account",Vendor,"Bank Account","Fixed Asset";

            // OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset";
        }
        field(23; "Account No"; Code[30])
        {
            TableRelation = "G/L Account";

            trigger OnValidate()
            var
                GLAcc: Record "G/L Account";
            begin
                if GLAcc.Get("Account No") then
                    "Account Name" := GLAcc.Name
                else
                    "Account Name" := '';
            end;
        }

        field(24; "Document No"; Code[20])
        {
        }
        field(25; Amount; Decimal)
        {

            trigger OnValidate()
            begin
                /*
              IF Amount<>"Scheduled Amount" THEN
              ERROR('The Amount must be equal to the Scheduled Amount');
                  */

            end;
        }
        field(26; "Scheduled Amount"; Decimal)
        {
            //CalcFormula = sum("Polytech CheckoffLines". where("Receipt Header No" = field(No)));
            Editable = false;
            //FieldClass = FlowField;
        }
        field(27; "Total Count"; Integer)
        {
            CalcFormula = count("Bamburi CheckoffLines" where("Receipt Header No" = field(No)));
            FieldClass = FlowField;
        }
        field(28; "Account Name"; Code[50])
        {
        }
        field(29; "Employer Code"; Code[30])
        {
            TableRelation = "Sacco Employers".Code;
            trigger OnValidate()
            var
                saccoEmployers: Record "Sacco Employers";
            begin
                saccoEmployers.Reset;
                saccoEmployers.SetRange(saccoEmployers.Code, "Employer Code");
                if saccoEmployers.Find('-') then begin
                    "Employer Name" := saccoEmployers.Description;
                end;
            end;
        }
        field(30; "Un Allocated amount-surplus"; Decimal)
        {
        }
        field(31; "Employer Name"; Text[100])
        {
        }
        field(32; "Loan CutOff Date"; Date)
        {
        }
        field(33; "Total Welfare"; Decimal)
        {
            // Editable = false;
        }

    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if Posted = true then
            Error('You cannot delete a Posted Check Off');
    end;

    trigger OnInsert()
    begin
        UpdateTotalAmount();

        if No = '' then begin
            NoSetup.Get();
            NoSetup.TestField(NoSetup."Bosa Transaction Nos");
            No := NoSeries.GetNextNo(NoSetup."Bosa Transaction Nos");

        end;

        "Date Entered" := Today;
        "Time Entered" := Time;
        "Entered By" := UpperCase(UserId);
        "Account Type" := "Account Type"::"Bank Account";

    end;

    trigger OnModify()
    begin
        UpdateTotalAmount();
    end;

    trigger OnRename()
    begin
        if Posted = true then
            Error('You cannot rename a Posted Check Off');
    end;

    procedure UpdateTotalAmount()
    var
        Total: Decimal;
        BamburiCheckoffLines: Record "Bamburi CheckoffLines";
        totalWelfare: Decimal;
    begin
        Total := 0;
        totalWelfare := 0;
        "Scheduled Amount" := Total;

        BamburiCheckoffLines.Reset();
        BamburiCheckoffLines.SetRange("Receipt Header No", Rec.No);
        BamburiCheckoffLines.SetRange(posted, false);

        if BamburiCheckoffLines.FindSet() then
            repeat
                Total += BamburiCheckoffLines."Share Capital" +
            BamburiCheckoffLines."Deposit Contribution" +
            BamburiCheckoffLines.Benevolent +
            BamburiCheckoffLines."Other Products" +
            BamburiCheckoffLines.Registration +
            BamburiCheckoffLines."T-Shirt" +
            BamburiCheckoffLines."Emergency Loan Amount" +
            BamburiCheckoffLines."Kivukio Loan Amount" +
            BamburiCheckoffLines."Mwokozi Loan Amount" +
            BamburiCheckoffLines."School Fees Amount" +
            BamburiCheckoffLines."Normal Loan 1 Amount" +
            BamburiCheckoffLines."Normal Loan 2 Amount" +
            BamburiCheckoffLines."Mbuyu Loan Amount" +
            BamburiCheckoffLines."HALLO HALLO Loan Amount";
            // BamburiCheckoffLines."Instant Loan Amount" ;
            // BamburiCheckoffLines."Total Loans";
            // BamburiCheckoffLines."Welfare Contribution";

            // totalWelfare += BamburiCheckoffLines."Welfare Contribution";
            until BamburiCheckoffLines.Next() = 0;
        "Scheduled Amount" := ROUND(Total, 1, '>');
        // "Scheduled Amount" := Total;
        "Total Welfare" := totalWelfare;
        // Rec.Modify(true);
    end;


    var
        NoSetup: Record "Sacco No. Series";
        NoSeries: Codeunit "No. Series";
        cust: Record Customer;
        "GL Account": Record "G/L Account";
        BANKACC: Record "Bank Account";
}

