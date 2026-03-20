table 59056 "Bamburi CheckoffLines"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Receipt Header No"; Code[20]) { }
        field(2; "Receipt Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(3; "Entry No"; Code[20]) { Editable = false; }
        field(4; "Staff/Payroll No"; Code[20]) { }
        field(5; "Member No"; Code[50]) { TableRelation = Customer."No." where("Customer Type" = filter(BOSA | STAFF)); }
        field(6; "Member Found"; Boolean) { }
        field(7; "Name"; Code[50]) { Editable = false; }
        field(8; "ID No."; Code[20]) { Editable = false; }
        field(9; Posted; Boolean) { }
        field(10; "Share Capital"; Decimal) { }
        field(11; "Deposit Contribution"; Decimal) { }
        field(12; "Benevolent"; Decimal) { }
        field(13; "Insurance"; Decimal) { }
        field(14; Registration; Decimal) { }
        field(15; Holiday; Decimal) { }
        field(45; "Welfare Contribution"; Decimal) { }

        field(16; "Emergency Loan Amount"; Decimal) { }
        field(17; "Emergency Loan  Principle"; Decimal) { }
        field(18; "Emergency Loan Interest"; Decimal) { }
        field(19; "Kivukio Loan Amount"; Decimal) { }
        field(20; "Kivukio Loan Principle"; Decimal) { }
        field(21; "Kivukio Loan Interest"; Decimal) { }
        field(22; "New Product Loan Amount"; Decimal) { }
        field(23; "New Product Loan Principle"; Decimal) { }
        field(24; "New Product Loan Interest"; Decimal) { }
        field(25; "Normal Loan 1 Amount"; Decimal) { }
        field(26; "Normal Loan 1 Principle"; Decimal) { }
        field(27; "Normal Loan 1 Interest"; Decimal) { }
        field(28; "School Fees Amount"; Decimal) { }
        field(29; "School Fees Principle"; Decimal) { }
        field(30; "School Fees Interest"; Decimal) { }
        field(31; "Normal Loan 2 Amount"; Decimal) { }
        field(32; "Normal Loan 2 Principle"; Decimal) { }
        field(33; "Normal Loan 2 Interest"; Decimal) { }
        field(34; "Normal Loan 3 Amount"; Decimal) { }
        field(35; "Normal Loan 3 Principle"; Decimal) { }
        field(36; "Normal Loan 3 Interest"; Decimal) { }
        field(37; "Normal loan 4 Amount"; Decimal) { }
        field(38; "Normal loan 4 Principle"; Decimal) { }
        field(39; "Normal loan 4 Interest"; Decimal) { }
        field(40; "Instant Loan Amount"; Decimal) { }
        field(41; "Instant Loan Principle"; Decimal) { }
        field(42; "Instant Loan Interest"; Decimal) { }
        field(46; "HALLO HALLO Loan Amount"; Decimal) { }
        field(47; "HALLO HALLO Loan Principle"; Decimal) { }
        field(48; "HALLO HALLO Loan Interest"; Decimal) { }
        field(49; "Mwokozi Loan Amount"; Decimal) { }
        field(50; "Mwokozi Loan Principle"; Decimal) { }
        field(51; "Mwokozi Loan Interest"; Decimal) { }
        field(54; "Mbuyu Loan Amount"; Decimal) { }
        field(55; "Mbuyu Loan Principle"; Decimal) { }
        field(56; "Mbuyu Loan Interest"; Decimal) { }
        field(57; "T-Shirt"; Decimal) { }
        field(58; "Other Products"; Decimal) { }


        field(52; "Total Loans"; Decimal)
        {
            Caption = 'Total Loans';
            Editable = false;
        }

        field(53; "Grand Total"; Decimal)
        {
            Caption = 'Grand Total';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Receipt Header No", "Receipt Line No", "Staff/Payroll No")
        {
            Clustered = true;
        }
        key(Key2; "Receipt Line No")
        {
        }
        key(Key3; "Staff/Payroll No")
        {
        }
    }

    fieldgroups
    {

    }

    procedure CalcTotals()
    begin
        "Total Loans" := "Emergency Loan Amount" + "Kivukio Loan Amount" + "Mwokozi Loan Amount" +
                         "School Fees Amount" + "New Product Loan Amount" + "Normal Loan 1 Amount" +
                         "Normal Loan 2 Amount" +
                         "Instant Loan Amount" + "HALLO HALLO Loan Amount" + "Mbuyu Loan Amount";

        "Grand Total" := "Share Capital" + "Deposit Contribution" + "Benevolent" +
                         "Insurance" + "Registration" + "Holiday" + "T-Shirt" + "Other Products" + "Total Loans";
    end;

    var
        myInt: Integer;

    trigger OnInsert()
    begin
        // DO NOT auto-generate Entry No here - let XMLport handle it
        // DO NOT call CalcTotals() here - it will overwrite imported values
    end;

    trigger OnModify()
    begin
        // Only recalculate if user is manually editing (not during import)
        if not SkipCalcTotals then
            CalcTotals();
    end;

    trigger OnDelete()
    begin
    end;

    trigger OnRename()
    begin
    end;

    procedure SetSkipCalcTotals(Skip: Boolean)
    begin
        SkipCalcTotals := Skip;
    end;

    var
        SkipCalcTotals: Boolean;
}