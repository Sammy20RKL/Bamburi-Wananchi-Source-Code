#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
table 50544 "Over Draft Register"
{
    DrillDownPageID = "Over draft";
    LookupPageID = "Over draft";

    fields
    {
        field(1; "Over Draft No"; Code[20])
        {

            trigger OnValidate()
            begin
                if "Over Draft No" <> xRec."Over Draft No" then begin
                    SaccoSetup.Get;
                    NoSeriesMgt.TestManual(SaccoSetup."Overdraft Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Over Draft Payoff"; Code[20])
        {
            TableRelation = "Over Draft Register" where(Posted = filter(true),
                                                         "Account No" = field("Account No"));

            trigger OnValidate()
            begin

                if Confirm('Are you Sure you Want to apply for overdraft?', true) = true then begin

                end;
            end;
        }
        field(3; "Account No"; Code[20])
        {
            TableRelation = Vendor."No.";

            trigger OnValidate()
            begin

                if Cust.Get("Account No") then begin
                    CalcFields("Outstanding Overdraft");
                    if "Outstanding Overdraft" > 0 then
                        Message('This account has an existing overdraft. Kindly clear it first');
                    //ERROR('This account has an existing overdraft. Kindly clear it first') ;
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

            trigger OnLookup()
            begin
                GenSetUp.Get;
                //
                currYear := Date2dmy(Today, 3);
                StartDate := 0D;
                EndDate := 0D;
                Month := Date2dmy("Approved Date", 2);
                DAY := Date2dmy("Approved Date", 1);


                StartDate := Dmy2date(1, Month, currYear); // StartDate will be the date of the first day of the month

                if Month = 12 then begin
                    Month := 0;
                    currYear := currYear + 1;

                end;


                EndDate := Dmy2date(1, Month + 1, currYear) - 1;
                "Overdraft Repayment Start Date" := StartDate;
                "Overdraft Repayment Completion" := CalcDate(Format("Overdraft period(Months)") + 'M', "Approved Date");
            end;
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
            CalcFormula = - sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" where("Vendor No." = field("Account No"),
                                                                                   "Overdraft codes" = filter("Overdraft Granted" | "Overdraft Paid")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(10; "Amount applied"; Decimal)
        {

            trigger OnValidate()
            begin
                GenSetUp.Get;
                if "Amount applied" > GenSetUp."Overdraft Limt" then begin
                    excees := GenSetUp."Overdraft Limt" - "Amount applied";
                    Error('Amount applied exceed limit ');
                end;
            end;
        }
        field(11; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(12; "ID Number"; Code[30])
        {
        }
        field(13; "Phone No"; Code[13])
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
            InitValue = Inactive;
            OptionCaption = ' ,Active,Inactive';
            OptionMembers = " ",Active,Inactive;
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
        field(25; Recovered; Boolean)
        {
        }
        field(26; "Recovered Amount"; Decimal)
        {
        }
        field(27; "Document Type"; Option)
        {
            OptionCaption = ',Overdraft,Recovery';
            OptionMembers = ,Overdraft,Recovery;
        }
        field(28; "Remaing Balance"; Decimal)
        {
        }
        field(29; "Oustanding Overdraft Interest"; Decimal)
        {
            CalcFormula = sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" where("Vendor No." = field("Account No"),
                                                                                  "Overdraft codes" = filter("Interest Accrued" | "Interest paid")));
            FieldClass = FlowField;
        }
        field(30; "Overdraft security"; Option)
        {
            OptionCaption = '  ,Motor Vehicle,Land,Salary';
            OptionMembers = "  ","Motor Vehicle",Land,Salary;
        }
        field(31; Type; Code[10])
        {
        }
        field(32; "Registration Number"; Code[10])
        {
        }
        field(33; "Current Value"; Decimal)
        {
        }
        field(34; Multpliers; Decimal)
        {

            trigger OnValidate()
            begin
                "Amount to secure Overdraft" := "Current Value" * Multpliers / 100;
            end;
        }
        field(35; "Amount to secure Overdraft"; Decimal)
        {
            Description = 'dratft';
            Editable = false;
        }
        field(36; insured; Boolean)
        {
        }
        field(37; "Insurance Company"; Text[30])
        {
            TableRelation = "Insurance companies";
        }
        field(38; "Overdraft period(Months)"; Integer)
        {

            trigger OnValidate()
            begin
                OverGenSetUp.Get();
                if not "Override Interest Rate" then begin
                    "Interest Rate" := OverGenSetUp."One Month Interest Rate";
                    if "Overdraft period(Months)" > 1 then
                        "Interest Rate" := OverGenSetUp."More than Month Interest Rate";
                end;
                "Monthly Overdraft Repayment" := ROUND(("Amount applied" / "Overdraft period(Months)"), 0.05, '>');
                "Monthly Interest Repayment" := ROUND((("Amount applied" * "Interest Rate" / 100) / "Overdraft period(Months)"), 0.05, '>');
                "Total Interest Charged" := ROUND(("Amount applied" * "Interest Rate" / 100), 0.05, '>');
                "Approved Date" := "Application date";
                "Overdraft Repayment Start Date" := CalcDate('+1M', "Approved Date");
                FnCalculateGrossOverDraft();
            end;
        }
        field(39; "Land deed No"; Code[10])
        {
        }
        field(40; "Land acrage"; Decimal)
        {
        }
        field(41; "Land location"; Code[10])
        {
            TableRelation = Location.Code;
        }
        field(42; "Basic salary"; Decimal)
        {
        }
        field(43; Employer; Code[10])
        {
            TableRelation = "Sacco Employers";
        }
        field(44; "Job Title"; Code[10])
        {
        }
        field(45; "Terms Of Employment"; Option)
        {
            OptionCaption = ' ,Permanent,contract,casual';
            OptionMembers = " ",Permanent,contract,casual;
        }
        field(46; "Overdraft Repayment Start Date"; Date)
        {
        }
        field(47; "Overdraft Repayment Completion"; Date)
        {
        }
        field(48; Installments; Integer)
        {
        }
        field(49; "commission charged"; Boolean)
        {
        }
        field(50; "Interest Rate"; Decimal)
        {

            trigger OnValidate()
            begin
                OverGenSetUp.Get();
                if not "Override Interest Rate" then begin
                    "Interest Rate" := OverGenSetUp."One Month Interest Rate";
                    if "Overdraft period(Months)" > 1 then
                        "Interest Rate" := OverGenSetUp."More than Month Interest Rate";
                end;
                "Monthly Overdraft Repayment" := ROUND(("Amount applied" / "Overdraft period(Months)"), 0.05, '>');
                "Monthly Interest Repayment" := ROUND((("Amount applied" * "Interest Rate" / 100) / "Overdraft period(Months)"), 0.05, '>');
                "Total Interest Charged" := ROUND(("Amount applied" * "Interest Rate" / 100), 0.05, '>');
                FnCalculateGrossOverDraft();
            end;
        }
        field(51; "Monthly Overdraft Repayment"; Decimal)
        {
        }
        field(52; "Monthly Interest Repayment"; Decimal)
        {
        }
        field(53; "Override Interest Rate"; Boolean)
        {

            trigger OnValidate()
            begin
                OverGenSetUp.Get();
                if not "Override Interest Rate" then begin
                    "Interest Rate" := OverGenSetUp."One Month Interest Rate";
                    if "Overdraft period(Months)" > 1 then
                        "Interest Rate" := OverGenSetUp."More than Month Interest Rate";
                end;
                "Monthly Overdraft Repayment" := ROUND(("Amount applied" / "Overdraft period(Months)"), 0.05, '>');
                "Monthly Interest Repayment" := ROUND((("Amount applied" * "Interest Rate" / 100) / "Overdraft period(Months)"), 0.05, '>');
                "Total Interest Charged" := ROUND(("Amount applied" * "Interest Rate" / 100), 0.05, '>');
                FnCalculateGrossOverDraft();
            end;
        }
        field(54; "Interest Charged"; Boolean)
        {

            trigger OnValidate()
            begin
                OverGenSetUp.Get();
                if not "Override Interest Rate" then begin
                    "Interest Rate" := OverGenSetUp."One Month Interest Rate";
                    if "Overdraft period(Months)" > 1 then
                        "Interest Rate" := OverGenSetUp."More than Month Interest Rate";
                end;
                "Monthly Overdraft Repayment" := ROUND(("Amount applied" / "Overdraft period(Months)"), 0.05, '>');
                "Monthly Interest Repayment" := ROUND((("Amount applied" * "Interest Rate" / 100) / "Overdraft period(Months)"), 0.05, '>');
                "Total Interest Charged" := ROUND(("Amount applied" * "Interest Rate" / 100), 0.05, '>');
                FnCalculateGrossOverDraft();
            end;
        }
        field(55; "Total Interest Charged"; Decimal)
        {
        }
        field(56; "Outstanding Draft Per OD"; Decimal)
        {
            CalcFormula = - sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" where("Vendor No." = field("Account No"),
                                                                                   "Overdraft codes" = filter("Overdraft Granted" | "Overdraft Paid"),
                                                                                   "Overdraft No" = field("Over Draft No")));
            FieldClass = FlowField;
        }
        field(57; "Running Overdraft"; Boolean)
        {
        }
        field(58; "Do not Charge Commision"; Boolean)
        {
        }
        field(59; "Net Overdraft"; Decimal)
        {

            trigger OnValidate()
            begin
                FnCalculateGrossOverDraft();
            end;
        }
        field(60; "Recovery Mode"; Option)
        {
            OptionCaption = ' ,Direct,Salary,Loan,Tea,Milk,Dividends,Bonus';
            OptionMembers = " ",Direct,Salary,Loan,Tea,Milk,Dividends,Bonus;
        }
    }

    keys
    {
        key(Key1; "Over Draft No", "Account No")
        {
            Clustered = true;
        }
        key(Key2; "Approved Date")
        {
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
            SaccoSetup.TestField(SaccoSetup."Overdraft Nos");
            //  NoSeriesMgt.InitSeries(SaccoSetup."Overdraft Nos", xRec."No. Series", 0D, "Over Draft No", "No. Series");
        end;
    end;

    var
        Loans: Record "Loans Register";
        Loantypes: Record "Loan Products Setup";
        Interest: Decimal;
        Cust: Record Vendor;
        LoansTop: Record "Loans Register";
        GenSetUp: Record "Overdraft Setup";
        vendor: Record Vendor;
        SaccoSetup: Record "Overdraft Setup";
        NoSeriesMgt: Codeunit "No. Series";
        excees: Decimal;
        OverGenSetUp: Record "Overdraft Setup";
        currYear: Integer;
        StartDate: Date;
        EndDate: Date;
        Month: Integer;
        DAY: Integer;
        ObjVendor: Record Vendor;

    local procedure FnCalculateGrossOverDraft()
    begin
        /*
        OverGenSetUp.GET();
        "Amount applied":=ROUND((100*("Net Overdraft"+OverGenSetUp."Overdraft Commision Charged"+FnGetZValue())/(100-"Interest Rate")),0.05,'>');
        OverGenSetUp.GET();
        IF NOT "Override Interest Rate" THEN BEGIN
        "Interest Rate":=OverGenSetUp."One Month Interest Rate";
        IF "Overdraft period(Months)" > 1 THEN
        "Interest Rate":=OverGenSetUp."More than Month Interest Rate";
        END;
        "Monthly Overdraft Repayment":=ROUND(("Amount applied"/"Overdraft period(Months)"),0.05,'>');
        "Monthly Interest Repayment":=ROUND((("Amount applied"*"Interest Rate"/100)/"Overdraft period(Months)"),0.05,'>');
        "Total Interest Charged":=ROUND(("Amount applied"*"Interest Rate"/100),0.05,'>');
        */

    end;

    local procedure FnGetZValue(): Decimal
    var
        AdjustmentAmount: Decimal;
    begin
        /*
        ObjVendor.RESET;
        ObjVendor.SETRANGE(ObjVendor."No.","Account No");
        IF ObjVendor.FIND('-')THEN BEGIN
          ObjVendor.CALCFIELDS(ObjVendor.Balance);
            AdjustmentAmount:=0;
            IF ((ObjVendor.Balance<1090)AND (ObjVendor.Balance>0)) THEN BEGIN
              AdjustmentAmount:=1090-ObjVendor.Balance;
            END;
            IF ObjVendor.Balance<0 THEN BEGIN
              AdjustmentAmount:=1090+ABS(ObjVendor.Balance);
            END;
        END;
        EXIT(AdjustmentAmount);
        */

    end;
}

