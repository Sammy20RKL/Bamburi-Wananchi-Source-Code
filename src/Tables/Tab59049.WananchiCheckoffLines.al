table 59049 "Polytech CheckoffLines"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Receipt Header No"; Code[20]) { }
        field(2; "Receipt Line No"; Integer) { AutoIncrement = true; }
        field(3; "Entry No"; Code[20]) { Editable = false; }
        field(4; "Staff/Payroll No"; Code[20]) { }
        field(5; "Member No"; Code[50]) { TableRelation = Customer."No." where("Customer Type" = filter(Member)); }
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









        field(16; "Emergency Loan 12 Amount"; Decimal) { }
        field(17; "Emergency Loan 12 Principle"; Decimal) { }
        field(18; "Emergency Loan 12 Interest"; Decimal) { }
        field(19; "Super Emergency Loan 13 Amount"; Decimal) { }
        field(20; "Super Emergency Loan 13 Principle"; Decimal) { }
        field(21; "Super Emergency Loan 13 Interest"; Decimal) { }
        field(22; "Quick Loan Amount"; Decimal) { }
        field(23; "Quick Loan Principle"; Decimal) { }
        field(24; "Quick Loan Interest"; Decimal) { }
        field(25; "Super Quick Amount"; Decimal) { }
        field(26; "Super Quick Principle"; Decimal) { }
        field(27; "Super Quick Interest"; Decimal) { }
        field(28; "School Fees Amount"; Decimal) { }
        field(29; "School Fees Principle"; Decimal) { }
        field(30; "School Fees Interest"; Decimal) { }
        field(31; "Super School Fees Amount"; Decimal) { }
        field(32; "Super School Fees Principle"; Decimal) { }
        field(33; "Super School Fees Interest"; Decimal) { }
        field(34; "Investment Loan Amount"; Decimal) { }
        field(35; "Investment Loan Principle"; Decimal) { }
        field(36; "Investment Loan Interest"; Decimal) { }
        field(37; "Normal loan 20 Amount"; Decimal) { }
        field(38; "Normal loan 20 Principle"; Decimal) { }
        field(39; "Normal loan 20 Interest"; Decimal) { }
        field(40; "Normal loan 21 Amount"; Decimal) { }
        field(41; "Normal loan 21 Principle"; Decimal) { }
        field(42; "Normal loan 21 Interest"; Decimal) { }
        field(43; "Normal loan 22 Amount"; Decimal) { }
        field(44; "Normal loan 22 Principle"; Decimal) { }
        field(45; "Normal loan 22 Interest"; Decimal) { }
        field(46; "Development Loan 23 Amount"; Decimal) { }
        field(47; "Development Loan 23 Principle"; Decimal) { }
        field(48; "Development Loan 23 Interest"; Decimal) { }
        field(49; "Development Loan 25 Amount"; Decimal) { }
        field(50; "Development Loan 25 Principle"; Decimal) { }
        field(51; "Development Loan 25 Interest"; Decimal) { }
        field(52; "Merchandise Loan 26 Amount"; Decimal) { }
        field(53; "Merchandise Loan 26 Principle"; Decimal) { }
        field(54; "Merchandise Loan 26 Interest"; Decimal) { }
        field(55; "Welfare Contribution"; Decimal) { }

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
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}