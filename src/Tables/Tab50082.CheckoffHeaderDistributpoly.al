#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 50082 "CheckoffHeader-Distribut poly"
{

    fields
    {
        field(1; No; Code[20])
        {

            trigger OnValidate()
            begin

                if No <> xRec.No then begin
                    NoSetup.Get();
                    NoSeriesMgt.TestManual(NoSetup."Checkoff-Proc Distributed Nos");
                    "No. Series" := '';
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
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset";
        }
        field(23; "Account No"; Code[30])
        {
            TableRelation = if ("Account Type" = const("G/L Account")) "G/L Account"
            else if ("Account Type" = const(Customer)) Customer
            else if ("Account Type" = const(Vendor)) Vendor
            else if ("Account Type" = const("Bank Account")) "Bank Account"
            else if ("Account Type" = const("Fixed Asset")) "Fixed Asset";

            trigger OnValidate()
            begin
                if "Account Type" = "account type"::Customer then begin
                    CustDeb.Reset;
                    CustDeb.SetRange(CustDeb."No.", "Account No");
                    if CustDeb.Find('-') then begin
                        "Employer Name" := CustDeb.Name;
                        "Account No" := CustDeb."No.";
                    end;
                end;

                if "Account Type" = "account type"::"G/L Account" then begin
                    "GL Account".Reset;
                    "GL Account".SetRange("GL Account"."No.", "Account No");
                    if "GL Account".Find('-') then begin
                        "Account Name" := "GL Account".Name;
                    end;
                end;

                if "Account Type" = "account type"::"Bank Account" then begin
                    BANKACC.Reset;
                    BANKACC.SetRange(BANKACC."No.", "Account No");
                    if BANKACC.Find('-') then begin
                        "Account Name" := BANKACC.Name;

                    end;
                end;
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
            CalcFormula = sum("Checkoff Lines-Distributed".Amount where("Receipt Header No" = field(No)));
            FieldClass = FlowField;
        }
        field(27; "Total Count"; Integer)
        {
            CalcFormula = count("CheckoffLinesDistributed poly" where("Receipt Header No" = field(No)));
            FieldClass = FlowField;
        }
        field(28; "Account Name"; Code[50])
        {
        }
        field(29; "Employer Code"; Code[30])
        {
            TableRelation = "Sacco Employers".Code;
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
        field(33; "Interest Amount"; Decimal)
        {
            FieldClass = Normal;
        }
        field(34; "Employer No.(Old)"; Code[20])
        {
            TableRelation = if ("Account Type" = const(Customer)) Customer."Our Account No.";
        }
        field(35; "Dev Total Amount"; Decimal)
        {
            CalcFormula = sum("CheckoffLinesDistributed poly"."DEVELOPMENT LOAN Amount" where("Receipt Header No" = field(No)));
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                "Dev Total Amount" := 0;
                "ALL TOTAL AMOUNT" := "Dev Total Amount" + "Dev1 Total Amount" + "EMER TOTAL AMOUNT" + "SUPER EMER TOTAL AMOUNT" + "SUPER SCH TOTAL AMOUNT" + "SCH TOTAL AMOUNT" + "Norm 1 TOTAL AMOUNT" + "Norm Total Amount" + "INVEST TOTAL AMOUNT" + "QUICK TOTAL AMOUNT" +
                +"SUPER QUICK TOTAL AMOUNT" + "DEPOSIT TOTAL AMOUNT" + "SHARE TOTAL AMOUNT" + "BEVELONANT TOTAL AMOUNT" + "REG TOTAL AMOUNT" + "INSURANCE TOTAL AMOUNT" + Holiday + "Normal2 Total" + "Merch Amount Total";
            end;
        }
        field(36; "Dev1 Total Amount"; Decimal)
        {
            CalcFormula = sum("CheckoffLinesDistributed poly"."DEVELOPMENT LOAN 1 Amount" where("Receipt Header No" = field(No)));
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                "Dev1 Total Amount" := 0;
                "ALL TOTAL AMOUNT" := "Dev Total Amount" + "Dev1 Total Amount" + "EMER TOTAL AMOUNT" + "SUPER EMER TOTAL AMOUNT" + "SUPER SCH TOTAL AMOUNT" + "SCH TOTAL AMOUNT" + "Norm 1 TOTAL AMOUNT" + "Norm Total Amount" + "INVEST TOTAL AMOUNT" + "QUICK TOTAL AMOUNT" +
                +"SUPER QUICK TOTAL AMOUNT" + "DEPOSIT TOTAL AMOUNT" + "SHARE TOTAL AMOUNT" + "BEVELONANT TOTAL AMOUNT" + "REG TOTAL AMOUNT" + "INSURANCE TOTAL AMOUNT" + Holiday + "Normal2 Total" + "Merch Amount Total";
            end;
        }
        field(37; "Norm Total Amount"; Decimal)
        {
            CalcFormula = sum("CheckoffLinesDistributed poly"."Normal Loan Amount" where("Receipt Header No" = field(No)));
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                "Norm Total Amount" := 0;
                "ALL TOTAL AMOUNT" := "Dev Total Amount" + "Dev1 Total Amount" + "EMER TOTAL AMOUNT" + "SUPER EMER TOTAL AMOUNT" + "SUPER SCH TOTAL AMOUNT" + "SCH TOTAL AMOUNT" + "Norm 1 TOTAL AMOUNT" + "Norm Total Amount" + "INVEST TOTAL AMOUNT" + "QUICK TOTAL AMOUNT" +
                +"SUPER QUICK TOTAL AMOUNT" + "DEPOSIT TOTAL AMOUNT" + "SHARE TOTAL AMOUNT" + "BEVELONANT TOTAL AMOUNT" + "REG TOTAL AMOUNT" + "INSURANCE TOTAL AMOUNT" + Holiday + "Normal2 Total" + "Merch Amount Total";
            end;
        }
        field(38; "Norm 1 TOTAL AMOUNT"; Decimal)
        {
            CalcFormula = sum("CheckoffLinesDistributed poly"."Normal Loan 1 Amount" where("Receipt Header No" = field(No)));
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                "Norm 1 TOTAL AMOUNT" := 0;
                "ALL TOTAL AMOUNT" := "Dev Total Amount" + "Dev1 Total Amount" + "EMER TOTAL AMOUNT" + "SUPER EMER TOTAL AMOUNT" + "SUPER SCH TOTAL AMOUNT" + "SCH TOTAL AMOUNT" + "Norm 1 TOTAL AMOUNT" + "Norm Total Amount" + "INVEST TOTAL AMOUNT" + "QUICK TOTAL AMOUNT" +
                +"SUPER QUICK TOTAL AMOUNT" + "DEPOSIT TOTAL AMOUNT" + "SHARE TOTAL AMOUNT" + "BEVELONANT TOTAL AMOUNT" + "REG TOTAL AMOUNT" + "INSURANCE TOTAL AMOUNT" + Holiday + "Normal2 Total" + "Merch Amount Total";
            end;
        }
        field(39; "INVEST TOTAL AMOUNT"; Decimal)
        {
            CalcFormula = sum("CheckoffLinesDistributed poly"."Investment  Amount" where("Receipt Header No" = field(No)));
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                "INVEST TOTAL AMOUNT" := 0;
                "ALL TOTAL AMOUNT" := "Dev Total Amount" + "Dev1 Total Amount" + "EMER TOTAL AMOUNT" + "SUPER EMER TOTAL AMOUNT" + "SUPER SCH TOTAL AMOUNT" + "SCH TOTAL AMOUNT" + "Norm 1 TOTAL AMOUNT" + "Norm Total Amount" + "INVEST TOTAL AMOUNT" + "QUICK TOTAL AMOUNT" +
                +"SUPER QUICK TOTAL AMOUNT" + "DEPOSIT TOTAL AMOUNT" + "SHARE TOTAL AMOUNT" + "BEVELONANT TOTAL AMOUNT" + "REG TOTAL AMOUNT" + "INSURANCE TOTAL AMOUNT" + Holiday + "Normal2 Total" + "Merch Amount Total";
            end;
        }
        field(40; "SUPER SCH TOTAL AMOUNT"; Decimal)
        {
            CalcFormula = sum("CheckoffLinesDistributed poly"."Super School Fees Amount" where("Receipt Header No" = field(No)));
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                "SUPER SCH TOTAL AMOUNT" := 0;
                "ALL TOTAL AMOUNT" := "Dev Total Amount" + "Dev1 Total Amount" + "EMER TOTAL AMOUNT" + "SUPER EMER TOTAL AMOUNT" + "SUPER SCH TOTAL AMOUNT" + "SCH TOTAL AMOUNT" + "Norm 1 TOTAL AMOUNT" + "Norm Total Amount" + "INVEST TOTAL AMOUNT" + "QUICK TOTAL AMOUNT" +
               +"SUPER QUICK TOTAL AMOUNT" + "DEPOSIT TOTAL AMOUNT" + "SHARE TOTAL AMOUNT" + "BEVELONANT TOTAL AMOUNT" + "REG TOTAL AMOUNT" + "INSURANCE TOTAL AMOUNT" + Holiday + "Normal2 Total" + "Merch Amount Total";
            end;
        }
        field(41; "EMER TOTAL AMOUNT"; Decimal)
        {
            CalcFormula = sum("CheckoffLinesDistributed poly"."EMERGENCY LOAN Amount" where("Receipt Header No" = field(No)));
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                "EMER TOTAL AMOUNT" := 0;
                "ALL TOTAL AMOUNT" := "Dev Total Amount" + "Dev1 Total Amount" + "EMER TOTAL AMOUNT" + "SUPER EMER TOTAL AMOUNT" + "SUPER SCH TOTAL AMOUNT" + "SCH TOTAL AMOUNT" + "Norm 1 TOTAL AMOUNT" + "Norm Total Amount" + "INVEST TOTAL AMOUNT" + "QUICK TOTAL AMOUNT" +
                +"SUPER QUICK TOTAL AMOUNT" + "DEPOSIT TOTAL AMOUNT" + "SHARE TOTAL AMOUNT" + "BEVELONANT TOTAL AMOUNT" + "REG TOTAL AMOUNT" + "INSURANCE TOTAL AMOUNT" + Holiday + "Normal2 Total" + "Merch Amount Total";
            end;
        }
        field(42; "SCH TOTAL AMOUNT"; Decimal)
        {
            CalcFormula = sum("CheckoffLinesDistributed poly"."SCHOOL FEES LOAN Amount" where("Receipt Header No" = field(No)));
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                "SCH TOTAL AMOUNT" := 0;
                "ALL TOTAL AMOUNT" := "Dev Total Amount" + "Dev1 Total Amount" + "EMER TOTAL AMOUNT" + "SUPER EMER TOTAL AMOUNT" + "SUPER SCH TOTAL AMOUNT" + "SCH TOTAL AMOUNT" + "Norm 1 TOTAL AMOUNT" + "Norm Total Amount" + "INVEST TOTAL AMOUNT" + "QUICK TOTAL AMOUNT" +
                +"SUPER QUICK TOTAL AMOUNT" + "DEPOSIT TOTAL AMOUNT" + "SHARE TOTAL AMOUNT" + "BEVELONANT TOTAL AMOUNT" + "REG TOTAL AMOUNT" + "INSURANCE TOTAL AMOUNT" + Holiday + "Normal2 Total" + "Merch Amount Total";
            end;
        }
        field(43; "SUPER EMER TOTAL AMOUNT"; Decimal)
        {
            CalcFormula = sum("CheckoffLinesDistributed poly"."Super Emergency Amount" where("Receipt Header No" = field(No)));
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                "SUPER EMER TOTAL AMOUNT" := 0;
                "ALL TOTAL AMOUNT" := "Dev Total Amount" + "Dev1 Total Amount" + "EMER TOTAL AMOUNT" + "SUPER EMER TOTAL AMOUNT" + "SUPER SCH TOTAL AMOUNT" + "SCH TOTAL AMOUNT" + "Norm 1 TOTAL AMOUNT" + "Norm Total Amount" + "INVEST TOTAL AMOUNT" + "QUICK TOTAL AMOUNT" +
                +"SUPER QUICK TOTAL AMOUNT" + "DEPOSIT TOTAL AMOUNT" + "SHARE TOTAL AMOUNT" + "BEVELONANT TOTAL AMOUNT" + "REG TOTAL AMOUNT" + "INSURANCE TOTAL AMOUNT" + Holiday + "Normal2 Total" + "Merch Amount Total";
            end;
        }
        field(44; "SUPER QUICK TOTAL AMOUNT"; Decimal)
        {
            CalcFormula = sum("CheckoffLinesDistributed poly"."Super Quick Amount" where("Receipt Header No" = field(No)));
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                "SUPER QUICK TOTAL AMOUNT" := 0;
                "ALL TOTAL AMOUNT" := "Dev Total Amount" + "Dev1 Total Amount" + "EMER TOTAL AMOUNT" + "SUPER EMER TOTAL AMOUNT" + "SUPER SCH TOTAL AMOUNT" + "SCH TOTAL AMOUNT" + "Norm 1 TOTAL AMOUNT" + "Norm Total Amount" + "INVEST TOTAL AMOUNT" + "QUICK TOTAL AMOUNT" +
                +"SUPER QUICK TOTAL AMOUNT" + "DEPOSIT TOTAL AMOUNT" + "SHARE TOTAL AMOUNT" + "BEVELONANT TOTAL AMOUNT" + "REG TOTAL AMOUNT" + "INSURANCE TOTAL AMOUNT" + Holiday + "Normal2 Total" + "Merch Amount Total";
            end;
        }
        field(45; "QUICK TOTAL AMOUNT"; Decimal)
        {
            CalcFormula = sum("CheckoffLinesDistributed poly"."Quick Loan Amount" where("Receipt Header No" = field(No)));
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                "QUICK TOTAL AMOUNT" := 0;
                "ALL TOTAL AMOUNT" := "Dev Total Amount" + "Dev1 Total Amount" + "EMER TOTAL AMOUNT" + "SUPER EMER TOTAL AMOUNT" + "SUPER SCH TOTAL AMOUNT" + "SCH TOTAL AMOUNT" + "Norm 1 TOTAL AMOUNT" + "Norm Total Amount" + "INVEST TOTAL AMOUNT" + "QUICK TOTAL AMOUNT" +
                +"SUPER QUICK TOTAL AMOUNT" + "DEPOSIT TOTAL AMOUNT" + "SHARE TOTAL AMOUNT" + "BEVELONANT TOTAL AMOUNT" + "REG TOTAL AMOUNT" + "INSURANCE TOTAL AMOUNT" + Holiday + "Normal2 Total" + "Merch Amount Total";
            end;
        }
        field(46; "SHARE TOTAL AMOUNT"; Decimal)
        {
            CalcFormula = sum("CheckoffLinesDistributed poly"."Share Capital" where("Receipt Header No" = field(No)));
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                "SHARE TOTAL AMOUNT" := 0;
                "ALL TOTAL AMOUNT" := "Dev Total Amount" + "Dev1 Total Amount" + "EMER TOTAL AMOUNT" + "SUPER EMER TOTAL AMOUNT" + "SUPER SCH TOTAL AMOUNT" + "SCH TOTAL AMOUNT" + "Norm 1 TOTAL AMOUNT" + "Norm Total Amount" + "INVEST TOTAL AMOUNT" + "QUICK TOTAL AMOUNT" +
                +"SUPER QUICK TOTAL AMOUNT" + "DEPOSIT TOTAL AMOUNT" + "SHARE TOTAL AMOUNT" + "BEVELONANT TOTAL AMOUNT" + "REG TOTAL AMOUNT" + "INSURANCE TOTAL AMOUNT" + Holiday + "Normal2 Total" + "Merch Amount Total";
            end;
        }
        field(47; "DEPOSIT TOTAL AMOUNT"; Decimal)
        {
            CalcFormula = sum("CheckoffLinesDistributed poly"."Deposit Contribution" where("Receipt Header No" = field(No)));
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                "DEPOSIT TOTAL AMOUNT" := 0;
                "ALL TOTAL AMOUNT" := "Dev Total Amount" + "Dev1 Total Amount" + "EMER TOTAL AMOUNT" + "SUPER EMER TOTAL AMOUNT" + "SUPER SCH TOTAL AMOUNT" + "SCH TOTAL AMOUNT" + "Norm 1 TOTAL AMOUNT" + "Norm Total Amount" + "INVEST TOTAL AMOUNT" + "QUICK TOTAL AMOUNT" +
                +"SUPER QUICK TOTAL AMOUNT" + "DEPOSIT TOTAL AMOUNT" + "SHARE TOTAL AMOUNT" + "BEVELONANT TOTAL AMOUNT" + "REG TOTAL AMOUNT" + "INSURANCE TOTAL AMOUNT" + Holiday + "Normal2 Total" + "Merch Amount Total";
                Validate("ALL TOTAL AMOUNT");
            end;
        }
        field(48; "INSURANCE TOTAL AMOUNT"; Decimal)
        {
            CalcFormula = sum("CheckoffLinesDistributed poly"."Insurance Fee" where("Receipt Header No" = field(No)));
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                "ALL TOTAL AMOUNT" := "Dev Total Amount" + "Dev1 Total Amount" + "EMER TOTAL AMOUNT" + "SUPER EMER TOTAL AMOUNT" + "SUPER SCH TOTAL AMOUNT" + "SCH TOTAL AMOUNT" + "Norm 1 TOTAL AMOUNT" + "Norm Total Amount" + "INVEST TOTAL AMOUNT" + "QUICK TOTAL AMOUNT" +
                +"SUPER QUICK TOTAL AMOUNT" + "DEPOSIT TOTAL AMOUNT" + "SHARE TOTAL AMOUNT" + "BEVELONANT TOTAL AMOUNT" + "REG TOTAL AMOUNT" + "INSURANCE TOTAL AMOUNT" + Holiday + "Normal2 Total" + "Merch Amount Total";
            end;
        }
        field(49; "REG TOTAL AMOUNT"; Decimal)
        {
            CalcFormula = sum("CheckoffLinesDistributed poly"."Registration Fee" where("Receipt Header No" = field(No)));
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                "ALL TOTAL AMOUNT" := "Dev Total Amount" + "Dev1 Total Amount" + "EMER TOTAL AMOUNT" + "SUPER EMER TOTAL AMOUNT" + "SUPER SCH TOTAL AMOUNT" + "SCH TOTAL AMOUNT" + "Norm 1 TOTAL AMOUNT" + "Norm Total Amount" + "INVEST TOTAL AMOUNT" + "QUICK TOTAL AMOUNT" +
                +"SUPER QUICK TOTAL AMOUNT" + "DEPOSIT TOTAL AMOUNT" + "SHARE TOTAL AMOUNT" + "BEVELONANT TOTAL AMOUNT" + "REG TOTAL AMOUNT" + "INSURANCE TOTAL AMOUNT" + Holiday + "Normal2 Total" + "Merch Amount Total";
            end;
        }
        field(50; "BEVELONANT TOTAL AMOUNT"; Decimal)
        {
            CalcFormula = sum("CheckoffLinesDistributed poly"."Benevolent Fund" where("Receipt Header No" = field(No)));
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                "ALL TOTAL AMOUNT" := "Dev Total Amount" + "Dev1 Total Amount" + "EMER TOTAL AMOUNT" + "SUPER EMER TOTAL AMOUNT" + "SUPER SCH TOTAL AMOUNT" + "SCH TOTAL AMOUNT" + "Norm 1 TOTAL AMOUNT" + "Norm Total Amount" + "INVEST TOTAL AMOUNT" + "QUICK TOTAL AMOUNT" +
                +"SUPER QUICK TOTAL AMOUNT" + "DEPOSIT TOTAL AMOUNT" + "SHARE TOTAL AMOUNT" + "BEVELONANT TOTAL AMOUNT" + "REG TOTAL AMOUNT" + "INSURANCE TOTAL AMOUNT" + Holiday + "Normal2 Total" + "Merch Amount Total";
            end;
        }
        field(51; "ALL TOTAL AMOUNT"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin

                "ALL TOTAL AMOUNT" := 0;
                //"BEVELONANT TOTAL AMOUNT":=0;
                "ALL TOTAL AMOUNT" := "Dev Total Amount" + "Dev1 Total Amount" + "EMER TOTAL AMOUNT" + "SUPER EMER TOTAL AMOUNT" + "SUPER SCH TOTAL AMOUNT" + "SCH TOTAL AMOUNT" + "Norm 1 TOTAL AMOUNT" + "Norm Total Amount" + "INVEST TOTAL AMOUNT" + "QUICK TOTAL AMOUNT" +
                +"SUPER QUICK TOTAL AMOUNT" + "DEPOSIT TOTAL AMOUNT" + "SHARE TOTAL AMOUNT" + "BEVELONANT TOTAL AMOUNT" + "REG TOTAL AMOUNT" + "INSURANCE TOTAL AMOUNT" + Holiday + "Normal2 Total" + "Merch Amount Total";

                //
                // // "ALL TOTAL AMOUNT":=0;
                // // CHECKOFFREG.RESET;
                // // CHECKOFFREG.SETRANGE(CHECKOFFREG."Receipt Header No",No);
                // // IF CHECKOFFREG.FIND ('-') THEN
                // // BEGIN
                // // CHECKOFFREG.CALCSUMS("DEPOSIT TOTAL AMOUNT");
                // // "ALL TOTAL AMOUNT":=CHECKOFFREG."DEPOSIT TOTAL AMOUNT";
                // END;
            end;
        }
        field(52; Holiday; Decimal)
        {
            CalcFormula = sum("CheckoffLinesDistributed poly"."Holiday savings" where("Receipt Header No" = field(No)));
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                Holiday := 0;
                "ALL TOTAL AMOUNT" := "Dev Total Amount" + "Dev1 Total Amount" + "EMER TOTAL AMOUNT" + "SUPER EMER TOTAL AMOUNT" + "SUPER SCH TOTAL AMOUNT" + "SCH TOTAL AMOUNT" + "Norm 1 TOTAL AMOUNT" + "Norm Total Amount" + "INVEST TOTAL AMOUNT" + "QUICK TOTAL AMOUNT" +
                +"SUPER QUICK TOTAL AMOUNT" + "DEPOSIT TOTAL AMOUNT" + "SHARE TOTAL AMOUNT" + "BEVELONANT TOTAL AMOUNT" + "REG TOTAL AMOUNT" + "INSURANCE TOTAL AMOUNT" + Holiday + "Normal2 Total" + "Merch Amount Total";
            end;
        }
        field(53; "Normal2 Total"; Decimal)
        {
            CalcFormula = sum("CheckoffLinesDistributed poly"."Normal Amount 20" where("Receipt Header No" = field(No)));
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                "Normal2 Total" := 0;
                "ALL TOTAL AMOUNT" := "Dev Total Amount" + "Dev1 Total Amount" + "EMER TOTAL AMOUNT" + "SUPER EMER TOTAL AMOUNT" + "SUPER SCH TOTAL AMOUNT" + "SCH TOTAL AMOUNT" + "Norm 1 TOTAL AMOUNT" + "Norm Total Amount" + "INVEST TOTAL AMOUNT" + "QUICK TOTAL AMOUNT" +
                +"SUPER QUICK TOTAL AMOUNT" + "DEPOSIT TOTAL AMOUNT" + "SHARE TOTAL AMOUNT" + "BEVELONANT TOTAL AMOUNT" + "REG TOTAL AMOUNT" + "INSURANCE TOTAL AMOUNT" + Holiday + "Normal2 Total" + "Merch Amount Total";
            end;
        }
        field(54; "Merch Amount Total"; Decimal)
        {
            CalcFormula = sum("CheckoffLinesDistributed poly"."MERCHANDISE Amount" where("Receipt Header No" = field(No)));
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                //"BEVELONANT TOTAL AMOUNT":=0;

                "ALL TOTAL AMOUNT" := "Dev Total Amount" + "Dev1 Total Amount" + "EMER TOTAL AMOUNT" + "SUPER EMER TOTAL AMOUNT" + "SUPER SCH TOTAL AMOUNT" + "SCH TOTAL AMOUNT" + "Norm 1 TOTAL AMOUNT" + "Norm Total Amount" + "INVEST TOTAL AMOUNT" + "QUICK TOTAL AMOUNT" +
                +"SUPER QUICK TOTAL AMOUNT" + "DEPOSIT TOTAL AMOUNT" + "SHARE TOTAL AMOUNT" + "BEVELONANT TOTAL AMOUNT" + "REG TOTAL AMOUNT" + "INSURANCE TOTAL AMOUNT" + Holiday + "Normal2 Total" + "Merch Amount Total";
            end;
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

        if No = '' then begin
            NoSetup.Get();
            NoSetup.TestField(NoSetup."Checkoff-Proc Distributed Nos");
            // NoSeriesMgt.InitSeries(NoSetup."Checkoff-Proc Distributed Nos",xRec."No. Series",0D,No,"No. Series");
        end;

        "Date Entered" := Today;
        "Time Entered" := Time;
        "Entered By" := UpperCase(UserId);
    end;

    trigger OnModify()
    begin

        if Posted = true then
            Error('You cannot modify a Posted Check Off');
    end;

    trigger OnRename()
    begin
        if Posted = true then
            Error('You cannot rename a Posted Check Off');
    end;

    var
        NoSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit "No. Series";
        cust: Record Customer;
        "GL Account": Record "G/L Account";
        BANKACC: Record "Bank Account";
        CustDeb: Record Customer;
        CHECKOFFREG: Record "Funds Tax Codes";
}

