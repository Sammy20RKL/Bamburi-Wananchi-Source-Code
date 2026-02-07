#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 57301 "CheckoffLinesDistributed Nav"
{

    fields
    {
        field(1; "Staff/Payroll No"; Code[20])
        {
        }
        field(2; Amount; Decimal)
        {
            Enabled = true;
        }
        field(3; "No Repayment"; Boolean)
        {
            Enabled = false;
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
            TableRelation = "Loans Register"."Loan  No." where("Client Code" = field("Member No."),
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
        field(18; "Loan Type"; Code[30])
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
        field(22; "Trans Type"; Code[20])
        {
        }
        field(23; "Transaction Type"; Option)
        {
            OptionCaption = ' ,Registration Fee,Share Capital,Interest Paid,Loan Repayment,Deposit Contribution,Insurance Contribution,Benevolent Fund,Loan,Unallocated Funds,Dividend,FOSA Account,Loan Insurance Charged,Loan Insurance Paid,Recovery Account,FOSA Shares,Additional Shares,Interest Due,Capital Reserve';
            OptionMembers = " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account","Loan Insurance Charged","Loan Insurance Paid","Recovery Account","FOSA Shares","Additional Shares","Interest Due","Capital Reserve";
        }
        field(24; "Special Code"; Code[50])
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
            TableRelation = "CheckoffHeader-Distribut Nav".No;
        }
        field(34; Source; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,BOSA,FOSA,MICRO';
            OptionMembers = " ",BOSA,FOSA,MICRO;
        }
        field(35; "Advice Number"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(36; "DEVELOPMENT LOAN Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Polytech';
        }
        field(37; "DEVELOPMENT LOAN Principal"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Polytech';
        }
        field(38; "DEVELOPMENT LOAN Int"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Polytech';
        }
        field(39; "ONDOA MSOTO LOAN Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(40; "ONDOA MSOTO LOAN Principal"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(41; "ONDOA MSOTO LOAN Int"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(42; "MOTORBIKE LOAN Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(43; "MOTORBIKE LOAN Principal"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(44; "MOTORBIKE LOAN Int"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(45; "ASSET FINANCING Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(46; "ASSET FINANCING Princilal"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(47; "ASSET FINANCING Int"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(48; "Investment loan Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(49; "Investment loan Principal"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50; "Investment loan Int"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(51; "EMERGENCY LOAN Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Polytech';
        }
        field(52; "EMERGENCY LOAN Principal"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Polytech';
        }
        field(53; "EMERGENCY LOAN Int"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Polytech';
        }
        field(54; "SCHOOL FEES LOAN Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Polytech';
        }
        field(55; "SCHOOL FEES LOAN Principal"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Polytech';
        }
        field(56; "SCHOOL FEES LOAN Int"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Polytech';
        }
        field(57; "INSTANT LOAN Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(58; "INSTANT LOAN Principal"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(59; "INSTANT LOAN Int"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(60; "SALARY ADVANCE Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(61; "SALARY ADVANCE Principal"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(62; "SALARY ADVANCE Int"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(63; "Salary Advance PLUS Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(64; "Salary Advance PLUS Principal"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(65; "Salary Advance PLUS Int"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(66; "STB SALARY ADVANCE Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(67; "STB SALARY ADVANCE Principal"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(68; "STB SALARY ADVANCE Int"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(69; "Other loans Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(70; "Other loans Principal"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(71; "Other loans int"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(72; "ONDOA MSOTO 1 Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(73; "ONDOA MSOTO 1 Principal"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(74; "ONDOA MSOTO 1 int"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(75; "Home APPLIANCE Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(76; "Home APPLIANCE Principal"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(77; "Home APPLIANCE Int"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(78; "STB LOAN Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(79; "STB LOAN Principal"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(80; "STB LOAN Int"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(81; "STB Loan 2 Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(82; "STB Loan 2 Principal"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(83; "STB Loan 2 Int"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(84; "Deposit Contribution"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(85; "Share Capital"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(86; "Welfare contribution"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(87; "Not Found Ln Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(88; Id; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(89; "Header No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(90; "Utility Type"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(91; "Super Emergency Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'polytech';
        }
        field(92; "Super Emergency Principal"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'polytech';
        }
        field(93; "Super Emergency Int"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'polytech';
        }
        field(94; "Super Quick Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'polytech';
        }
        field(95; "Super Quick Principal"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'polytech';
        }
        field(96; "Super Quick Int"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'polytech';
        }
        field(97; "Quick Loan Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'polytech';
        }
        field(98; "Quick Loan Principal"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'polytech';
        }
        field(99; "Quick Loan Int"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'polytech';
        }
        field(100; "Super School Fees Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'polytech';
        }
        field(101; "Super School Fees Principal"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'polytech';
        }
        field(102; "Super School Fees Int"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'polytech';
        }
        field(103; "Investment  Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'polytech';
        }
        field(104; "Investment  Principal"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'polytech';
        }
        field(105; "Investment  Int"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'polytech';
        }
        field(106; "Insurance Fee"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(107; "Benevolent Fund"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(108; "Registration Fee"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(109; "DEVELOPMENT LOAN No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(110; "EMERGENCY LOAN No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(111; "SCHOOL FEES LOAN No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(112; "Super Emergency Loan No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(113; "Super Quick Loan No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(114; "Quick Loan No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(116; "Super School Fees Loan No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(117; "Investment Loan No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(118; "Normal Loan Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(119; "Normal Loan Principal"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(120; "Normal Loan Int"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(121; "Normal Loan 1 Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(122; "Normal Loan 1 Principal"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(123; "NORMAL LOAN NO"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(124; "NORMAL LOAN 1 NO"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(125; "DEVELOPMENT LOAN 1 Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Polytech';
        }
        field(126; "DEVELOPMENT LOAN 1 Principal"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Polytech';
        }
        field(127; "DEVELOPMENT LOAN 1  Int"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Polytech';
        }
        field(128; "DEVELOPMENT LOAN 1  No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(335; "Dev Total Amount"; Decimal)
        {
            CalcFormula = sum("CheckoffLinesDistributed poly"."DEVELOPMENT LOAN Amount" where("Receipt Header No" = field("Receipt Header No")));
            FieldClass = FlowField;
        }
        field(336; "Dev1 Total Amount"; Decimal)
        {
            CalcFormula = sum("CheckoffLinesDistributed poly"."DEVELOPMENT LOAN 1 Amount" where("Receipt Header No" = field("Receipt Header No")));
            FieldClass = FlowField;
        }
        field(337; "Norm Total Amount"; Decimal)
        {
            CalcFormula = sum("CheckoffLinesDistributed poly"."Normal Loan Amount" where("Receipt Header No" = field("Receipt Header No")));
            FieldClass = FlowField;
        }
        field(338; "Norm 1 TOTAL AMOUNT"; Decimal)
        {
            CalcFormula = sum("CheckoffLinesDistributed poly"."Normal Loan 1 Amount" where("Receipt Header No" = field("Receipt Header No")));
            Enabled = false;
            FieldClass = FlowField;
        }
        field(339; "INVEST TOTAL AMOUNT"; Decimal)
        {
            CalcFormula = sum("CheckoffLinesDistributed poly"."Investment loan Amount" where("Receipt Header No" = field("Receipt Header No")));
            FieldClass = FlowField;
        }
        field(340; "SUPER SCH TOTAL AMOUNT"; Decimal)
        {
            CalcFormula = sum("CheckoffLinesDistributed poly"."Super School Fees Amount" where("Receipt Header No" = field("Receipt Header No")));
            FieldClass = FlowField;
        }
        field(341; "EMER TOTAL AMOUNT"; Decimal)
        {
            CalcFormula = sum("CheckoffLinesDistributed poly"."EMERGENCY LOAN Amount" where("Receipt Header No" = field("Receipt Header No")));
            FieldClass = FlowField;
        }
        field(342; "SCH TOTAL AMOUNT"; Decimal)
        {
            CalcFormula = sum("CheckoffLinesDistributed poly"."SCHOOL FEES LOAN Amount" where("Receipt Header No" = field("Receipt Header No")));
            FieldClass = FlowField;
        }
        field(343; "SUPER EMER TOTAL AMOUNT"; Decimal)
        {
            CalcFormula = sum("CheckoffLinesDistributed poly"."Super Emergency Amount" where("Receipt Header No" = field("Receipt Header No")));
            FieldClass = FlowField;
        }
        field(344; "SUPER QUICK TOTAL AMOUNT"; Decimal)
        {
            CalcFormula = sum("CheckoffLinesDistributed poly"."Super Quick Amount" where("Receipt Header No" = field("Receipt Header No")));
            FieldClass = FlowField;
        }
        field(345; "QUICK TOTAL AMOUNT"; Decimal)
        {
            CalcFormula = sum("CheckoffLinesDistributed poly"."Quick Loan Amount" where("Receipt Header No" = field("Receipt Header No")));
            FieldClass = FlowField;
        }
        field(346; "SHARE TOTAL AMOUNT"; Decimal)
        {
            CalcFormula = sum("CheckoffLinesDistributed poly"."Share Capital" where("Receipt Header No" = field("Receipt Header No")));
            FieldClass = FlowField;
        }
        field(347; "DEPOSIT TOTAL AMOUNT"; Decimal)
        {
            CalcFormula = sum("CheckoffLinesDistributed poly"."Deposit Contribution" where("Receipt Header No" = field("Receipt Header No")));
            FieldClass = FlowField;
        }
        field(348; "INSURANCE TOTAL AMOUNT"; Decimal)
        {
            CalcFormula = sum("CheckoffLinesDistributed poly"."Insurance Fee" where("Receipt Header No" = field("Receipt Header No")));
            FieldClass = FlowField;
        }
        field(349; "REG TOTAL AMOUNT"; Decimal)
        {
            CalcFormula = sum("CheckoffLinesDistributed poly"."Registration Fee" where("Receipt Header No" = field("Receipt Header No")));
            Enabled = false;
            FieldClass = FlowField;
        }
        field(350; "BEVELONANT TOTAL AMOUNT"; Decimal)
        {
            CalcFormula = sum("CheckoffLinesDistributed poly"."Benevolent Fund" where("Receipt Header No" = field("Receipt Header No")));
            FieldClass = FlowField;
        }
        field(351; "Holiday savings"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(352; "Normal Amount 20"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(353; "Normal Loan No.(20)"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(354; "Normal Pri (20)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(355; "Normal Int (20)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(356; "Normal TOTAL AMOUNT"; Decimal)
        {
            CalcFormula = sum("CheckoffLinesDistributed poly"."Normal Amount 20" where("Receipt Header No" = field("Receipt Header No")));
            FieldClass = FlowField;
        }
        field(357; "MERCHANDISE Loan No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(358; "MERCHANDISE Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(359; "MERCHANDISE Pri"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(360; "MERCHANDISE Int"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(361; "Merchandise Total Amount"; Decimal)
        {
            CalcFormula = sum("CheckoffLinesDistributed poly"."MERCHANDISE Amount" where("Receipt Header No" = field("Receipt Header No")));
            FieldClass = FlowField;
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

