table 52123 "Earnings"
{
    // DrillDownPageID = "Earnings";
    // LookupPageID = "Earnings";
    DataClassification = CustomerContent;
    Caption = 'Earnings';
    fields
    {
        field(1; "Code"; Code[20])
        {
            NotBlank = true;
            Caption = 'Code';
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(3; "Pay Type"; Option)
        {
            OptionCaption = 'Recurring,Non-recurring';
            OptionMembers = Recurring,"Non-recurring";
            Caption = 'Pay Type';
        }
        field(4; "Start Date"; Date)
        {
            Caption = 'Start Date';
        }
        field(5; "End Date"; Date)
        {
            Caption = 'End Date';
        }
        field(6; Taxable; Boolean)
        {
            Caption = 'Taxable';
        }
        field(7; "Calculation Method"; Option)
        {
            Caption = 'Calculation Method';
            OptionCaption = 'Flat amount,% of Basic pay,% of Gross pay,% of Insurance Amount,% of Taxable income,% of Basic after tax,Based on Hourly Rate,Based on Daily Rate,Formula,% of Annual Basic,% of Other Earnings,% of Mortgage Amount,Based on Salary Scale,Based on Travel Rates,% of NHIF Amount,% of Other Deductions';
            OptionMembers = "Flat amount","% of Basic pay","% of Gross pay","% of Insurance Amount","% of Taxable income","% of Basic after tax","Based on Hourly Rate","Based on Daily Rate",Formula,"% of Annual Basic","% of Other Earnings","% of Mortgage Amount","Based on Salary Scale","Based on Travel Rates","% of NHIF Amount","% of Other Deductions";
        }
        field(8; "Flat Amount"; Decimal)
        {
            Caption = 'Flat Amount';
        }
        field(9; Percentage; Decimal)
        {
            Caption = 'Percentage';
        }
        field(10; "Account No."; Code[20])
        {
            TableRelation = if ("Account Type" = const("G/L Account")) "G/L Account" where("Account Type" = const(Posting),
                                                                                          Blocked = const(false))
            else
            if ("Account Type" = const(Customer)) Customer
            else
            if ("Account Type" = const(Vendor)) Vendor
            else
            if ("Account Type" = const("Bank Account")) "Bank Account"
            else
            if ("Account Type" = const("Fixed Asset")) "Fixed Asset"
            else
            if ("Account Type" = const("IC Partner")) "IC Partner"
            else
            if ("Account Type" = const(Employee)) Employee;
            Caption = 'Account No.';
        }
        field(11; "Total Amount"; Decimal)
        {
            // CalcFormula = sum("Assignment Matrix".Amount where(Type = const(Earning),
            //                                                       Code = field(Code),
            //                                                       "Posting Group Filter" = field("Posting Group Filter"),
            //                                                       "Payroll Period" = field("Pay Period Filter"),
            //                                                       "Employee No" = field("Employee Filter"),
            //                                                       "Department Code" = field("Department Filter"),
            //                                                       "Employee Type" = field("Employee Type Filter")));
            // Editable = false;
            // FieldClass = FlowField;
            Caption = 'Total Amount';
        }
        field(12; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
        }
        field(13; "Posting Group Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            // TableRelation = "Employee HR Posting Group";
            Caption = 'Posting Group Filter';
        }
        field(14; "Pay Period Filter"; Date)
        {
            ClosingDates = false;
            FieldClass = FlowFilter;
            TableRelation = "Payroll Period";
            Caption = 'Pay Period Filter';
        }
        field(15; Quarters; Boolean)
        {
            Caption = 'Quarters';
        }
        field(16; "Non-Cash Benefit"; Boolean)
        {
            Caption = 'Non-Cash Benefit';
        }
        field(17; "Minimum Limit"; Decimal)
        {
            Caption = 'Minimum Limit';
        }
        field(18; "Maximum Limit"; Decimal)
        {
            Caption = 'Maximum Limit';
        }
        field(19; "Reduces Tax"; Boolean)
        {
            Caption = 'Reduces Tax';
        }
        field(20; "Overtime Workday Factor"; Decimal)
        {
            Caption = 'Overtime Workday Factor';
        }
        field(21; "Employee Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Payroll Period";
            Caption = 'Employee Filter';
        }
        field(22; Counter; Integer)
        {
            CalcFormula = count("Assignment Matrix" where("Payroll Period" = field("Pay Period Filter"),
                                                             "Employee No" = field("Employee Filter"),
                                                             Code = field(Code),
                                                             "Employee Type" = field("Employee Type Filter")));
            FieldClass = FlowField;
            Caption = 'Counter';
        }
        field(23; NoOfUnits; Decimal)
        {
            CalcFormula = sum("Assignment Matrix"."No. of Units" where(Code = field(Code),
                                                                          "Payroll Period" = field("Pay Period Filter"),
                                                                          "Employee No" = field("Employee Filter"),
                                                                          "Employee Type" = field("Employee Type Filter")));
            FieldClass = FlowField;
            Caption = 'NoOfUnits';
        }
        field(24; "Low Interest Benefit"; Boolean)
        {
            Caption = 'Low Interest Benefit';
        }
        field(25; "Show Balance"; Boolean)
        {
            Caption = 'Show Balance';
        }
        field(26; CoinageRounding; Boolean)
        {
            Caption = 'CoinageRounding';
        }
        field(27; OverDrawn; Boolean)
        {
            Caption = 'OverDrawn';
        }
        field(28; "Opening Balance"; Decimal)
        {
            CalcFormula = sum("Assignment Matrix"."Opening Balance" where(Type = const(Earning),
                                                                             Code = field(Code),
                                                                             "Employee No" = field("Employee Filter"),
                                                                             "Employee Type" = field("Employee Type Filter")));
            FieldClass = FlowField;
            Caption = 'Opening Balance';
        }
        field(29; OverTime; Boolean)
        {
            Caption = 'OverTime';
        }
        field(30; "Department Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
            Caption = 'Department Filter';
        }
        field(31; Months; Decimal)
        {
            Description = 'Used to cater for taxation based on annual bracket eg 1,12 months (the default is 1month) FOR NEPAL';
            Caption = 'Months';
        }
        field(32; "Show on Report"; Boolean)
        {
            Caption = 'Show on Report';
        }
        field(33; "Time Sheet"; Boolean)
        {
            Caption = 'Time Sheet';
        }
        field(34; "Total Days"; Decimal)
        {
            Caption = 'Total Days';
        }
        field(35; "Total Hrs"; Decimal)
        {
            Caption = 'Total Hrs';
        }
        field(36; Weekend; Boolean)
        {
            Caption = 'Weekend';
        }
        field(37; Weekday; Boolean)
        {
            Caption = 'Weekday';
        }
        field(38; "Basic Salary Code"; Boolean)
        {
            Caption = 'Basic Salary Code';
        }
        field(39; "Default Enterprise"; Code[20])
        {
            Caption = 'Default Enterprise';
        }
        field(40; "Default Activity"; Code[20])
        {
            Caption = 'Default Activity';
        }
        field(41; Prorate; Boolean)
        {
            Caption = 'Prorate';
        }
        field(42; "Earning Type"; Option)
        {
            OptionCaption = 'Normal Earning,Owner Occupier,Home Savings,Low Interest,Tax Relief,Insurance Relief,NHIF Relief,Housing Levy Relief';
            OptionMembers = "Normal Earning","Owner Occupier","Home Savings","Low Interest","Tax Relief","Insurance Relief","NHIF Relief","Housing Levy Relief";
            Caption = 'Earning Type';
        }
        field(43; "Applies to All"; Boolean)
        {
            Caption = 'Applies to All';
        }
        field(44; "Show on Master Roll"; Boolean)
        {
            Caption = 'Show on Master Roll';
        }
        field(45; "House Allowance Code"; Boolean)
        {
            Caption = 'House Allowance Code';
        }
        field(46; "Responsibility Allowance Code"; Boolean)
        {
            Caption = 'Responsibility Allowance Code';
        }
        field(47; "Commuter Allowance Code"; Boolean)
        {
            Caption = 'Commuter Allowance Code';
        }
        field(48; Block; Boolean)
        {
            Caption = 'Block';
        }
        field(49; "Basic Pay Arrears"; Boolean)
        {
            Caption = 'Basic Pay Arrears';
        }
        field(50; "Pensionable Pay"; Boolean)
        {
            Description = 'Used to define the monthly Pension Earned';
            Caption = 'Pensionable Pay';
        }
        field(51; "Per Diem"; Boolean)
        {
            Caption = 'Per Diem';
        }
        field(52; "Part Time"; Boolean)
        {
            Caption = 'Part Time';
        }
        field(53; "Leave Allowance"; Boolean)
        {
            Caption = 'Leave Allowance';
        }
        field(54; Formula; Code[50])
        {
            Caption = 'Formula';
        }
        field(55; "Supension Earnings Percentage"; Decimal)
        {
            Caption = 'Supension Earnings Percentage';
        }
        field(56; "Requires Employee Request"; Boolean)
        {
            Caption = 'Requires Employee Request';
        }
        field(57; "Casual Code"; Boolean)
        {
            Caption = 'Casual Code';
        }
        field(58; Gratuity; Boolean)
        {
            Caption = 'Gratuity';
        }
        field(59; "Yearly Bonus"; Boolean)
        {
            Caption = 'Yearly Bonus';
        }
        field(60; "Acting Allowance"; Boolean)
        {
            Caption = 'Acting Allowance';
        }
        field(61; "Special Duty"; Boolean)
        {
            Caption = 'Special Duty';
        }
        field(62; "Salary Arrears Code"; Boolean)
        {
            Caption = 'Salary Arrears Code';
        }
        field(63; "% of Other Earnings"; Integer)
        {
            // CalcFormula = count("Other Earnings" where("Main Earning" = field(Code)));
            Editable = false;
            FieldClass = FlowField;
            Caption = '% of Other Earnings';
        }
        field(64; "Sacco Earning"; Boolean)
        {
            Caption = 'Sacco Earning';
        }
        field(65; "Account Type"; Enum "Gen. Journal Account Type")
        {
            Caption = 'Account Type';
        }
        field(66; "Employee Type Filter"; Option)
        {
            FieldClass = FlowFilter;
            OptionCaption = 'Permanent,Partime,Locum,Casual,Contract,Trustee';
            OptionMembers = Permanent,Partime,Locum,Casual,Contract,Trustee;
            Caption = 'Employee Type Filter';
        }
        field(67; BoardSittingAllowance; Boolean)
        {
            Caption = 'BoardSittingAllowance';
        }
        field(68; "Overtime Non Working Factor"; Decimal)
        {
            Caption = 'Overtime Non Working Factor';
        }
        field(69; "Travel Allowance"; Boolean)
        {
            Caption = 'Travel Allowance';
        }
        field(70; "Tax Free Amount"; Decimal)
        {
            Caption = 'Tax Free Amount';
        }
        field(71; "Exclude Gross Pay Deduction"; Boolean)
        {
            Caption = 'Exclude Gross Pay Deduction';
        }
        field(74; "Paye Allocation"; Boolean)
        {
            Caption = 'Paye Allocation';
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
        key(Key2; "Show on Report")
        {
        }
        key(Key3; OverTime)
        {
        }
        key(Key4; "Time Sheet")
        {
        }
        key(Key5; "Earning Type")
        {
        }
        key(Key6; "House Allowance Code")
        {
        }
        key(Key7; "Responsibility Allowance Code")
        {
        }
        key(Key8; "Commuter Allowance Code")
        {
        }
        key(Key9; Description)
        {
        }
    }

    fieldgroups
    {
    }
}





