#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51655 "Checkoff Lines-DistributedBC"
{

    fields
    {
        field(1; "Staff/Payroll No"; Code[20])
        {
        }
        field(2; Amount; Decimal)
        {
        }
        field(3; "No Repayment"; Boolean)
        {
        }
        field(4; "Staff Not Found"; Boolean)
        {
        }
        field(5; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(6; "Transaction Date"; Date)
        {
        }
        field(7; "Entry No"; Integer)
        {
        }
        field(8; Generated; Boolean)
        {
        }
        field(9; "Payment No"; Integer)
        {
        }
        field(10; Posted; Boolean)
        {
        }
        field(11; "Multiple Receipts"; Boolean)
        {
        }
        field(12; Name; Text[200])
        {
        }
        field(13; "Early Remitances"; Boolean)
        {
        }
        field(14; "Early Remitance Amount"; Decimal)
        {
        }
        field(15; "Loan No."; Code[20])
        {
            TableRelation = "Loans Register"."Loan  No." where("Client Name" = field(Name),
                                                                "Outstanding Balance" = filter(<> 0));
        }
        field(16; "Member No."; Code[20])
        {
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                Cust.Reset;
                Cust.SetRange(Cust."No.", "Member No.");
                if Cust.Find('-') then begin
                    Name := Cust.Name;
                end;
            end;
        }
        field(17; Interest; Decimal)
        {
        }
        field(18; "Loan Type"; Code[20])
        {
        }
        field(19; DEPT; Code[10])
        {
        }
        field(20; "Expected Amount"; Decimal)
        {
        }
        field(21; "FOSA Account"; Code[20])
        {
        }
        field(22; "Utility Type"; Code[20])
        {
        }
        field(23; "Transaction Type"; Option)
        {
            OptionMembers = "Deposits Contribution","Insurance contribution";
        }
        field(24; Reference; Code[50])
        {
        }
        field(25; "Account type"; Code[10])
        {
        }
        field(26; Variance; Decimal)
        {
        }
        field(27; "Employer Code"; Code[10])
        {
        }
        field(28; GPersonalNo; Code[10])
        {
        }
        field(29; Gnames; Text[80])
        {
        }
        field(30; Gnumber; Code[10])
        {
        }
        field(31; Userid1; Code[25])
        {
        }
        field(32; "Loans Not found"; Boolean)
        {
        }
        field(33; "Receipt Header No"; Code[20])
        {
            TableRelation = "Checkoff Header-Distributed".No;
        }
        field(34; "Unallocated Fund"; Boolean)
        {
        }
        field(35; "Posting Date"; Date)
        {
        }
        field(36; "Document No"; Code[20])
        {
        }
        field(37; "Ledger Found"; Boolean)
        {
        }
        field(38; "Deposit contribution"; Decimal)
        {
        }
        field(39; "Share Capital"; Decimal)
        {
        }
        field(41; "Insurance Contribution"; Decimal)
        {
        }
        field(42; "Entrance Fees"; Decimal)
        {
        }
        field(43; "Principal Loan"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(44; "Principal Interest"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(45; "Principal Insurance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(46; "Emergency 1 Loan"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(47; "Emergency 1 Interest"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(48; "Emergency 1 Insurance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(49; "Emergency 2 Loan"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50; "Emergency 2 Interest"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(51; "Emergency 2 Insurance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(52; "Instant Loan"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(53; "Instant Loan Interest"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(54; "Instant Loan Insurance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(55; "Elimu Loan"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(56; "Elimu Loan Interest"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(57; "Elimu Loan Insurance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(58; "Mjengo Loan"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(59; "Mjengo Loan Interest"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(60; "Mjengo Loan Insurance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(61; "Vision Loan"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(62; "Vision Loan Interest"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(63; "Vision Loan Insurance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(64; "KHL Loan"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(65; "KHL Loan Interest"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(66; "KHL Loan Insurance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(67; "Car Loan"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(68; "Car Loan Interest"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(69; "Car Loan Insurance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(70; "Sukuma Mwezi Loan"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(71; "Sukuma Mwezi Loan Interest"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(72; "Sukuma mwezi Loan Insurance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(73; "Trustee Loan"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(74; "Truste Loan Interest"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(75; "Trustee Loan Insurance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(76; "IDL Loan"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(77; "IDL Loan Interest"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(78; "IDL Loan Insurance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(79; "Karibu Loan"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(80; "Karibu Loan Interest"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(81; "Karibu Loan Insurance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(82; "Kanisa Savings"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(83; "Member Name"; Text[60])
        {
            DataClassification = ToBeClassified;
        }
        field(84; "Total Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(85; "Mali Mal iLoan"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(86; "Dispora Loan"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Receipt Header No", "Entry No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Cust: Record Customer;
}

