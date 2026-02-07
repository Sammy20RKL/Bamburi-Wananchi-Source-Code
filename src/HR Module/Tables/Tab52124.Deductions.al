table 52124 "Deductions"
{
    // DrillDownPageID = "Deductions";
    // LookupPageID = "Deductions";
    DataClassification = SystemMetadata;
    Caption = 'Deductions';
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
        field(3; Type; Option)
        {
            OptionMembers = Recurring,"Non-recurring";
            Caption = 'Type';
        }
        field(6; "Tax deductible"; Boolean)
        {
            Caption = 'Tax deductible';
        }
        field(7; Advance; Boolean)
        {
            Caption = 'Advance';
        }
        field(8; "Start date"; Date)
        {
            Caption = 'Start date';
        }
        field(9; "End Date"; Date)
        {
            Caption = 'End Date';
        }
        field(10; Percentage; Decimal)
        {
            Caption = 'Percentage';
        }
        field(11; "Calculation Method"; Option)
        {
            OptionMembers = "Flat Amount","% of Basic Pay","Based on Table","Based on Hourly Rate","Based on Daily Rate ","% of Gross Pay","% of Basic Pay+Hse Allowance",Formula,"% of Basic Pay+Hse Allowance + Comm Allowance + Sal Arrears","% of Other Earnings","Based on Monthly Contributions","% of Other Deductions";
            Caption = 'Calculation Method';
        }
        field(12; "Account No."; Code[20])
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
        field(13; "Flat Amount"; Decimal)
        {
            Caption = 'Flat Amount';
        }
        field(14; "Total Amount"; Decimal)
        {
            CalcFormula = sum("Assignment Matrix".Amount where(Type = const(Deduction),
                                                                  Code = field(Code),
                                                                  "Posting Group Filter" = field("Posting Group Filter"),
                                                                  "Payroll Period" = field("Pay Period Filter"),
                                                                  "Employee No" = field("Employee Filter"),
                                                                  "Department Code" = field("Department Filter"),
                                                                  "Reference No" = field("Reference Filter"),
                                                                  "Payroll Group" = field("Company Filter"),
                                                                  "Employee Type" = field("Employee Type Filter")));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Total Amount';
        }
        field(15; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
        }
        field(16; "Posting Group Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            // TableRelation = "Employee HR Posting Group";
            Caption = 'Posting Group Filter';
        }
        field(17; Loan; Boolean)
        {
            Caption = 'Loan';
        }
        field(18; "Maximum Amount"; Decimal)
        {
            Caption = 'Maximum Amount';
        }
        field(19; "Grace period"; DateFormula)
        {
            Caption = 'Grace period';
        }
        field(20; "Repayment Period"; DateFormula)
        {
            Caption = 'Repayment Period';
        }
        field(21; "Pay Period Filter"; Date)
        {
            FieldClass = FlowFilter;
            TableRelation = "Payroll Period";
            Caption = 'Pay Period Filter';
        }
        field(26; "Pension Scheme"; Boolean)
        {
            Caption = 'Pension Scheme';
        }
        field(27; "Deduction Table"; Code[20])
        {
            // TableRelation = "Bracket Tables";
            Caption = 'Deduction Table';
        }
        field(28; "Account No. Employer"; Code[20])
        {
            TableRelation = if ("Account Type Employer" = const("G/L Account")) "G/L Account" where("Account Type" = const(Posting),
                                                                                                   Blocked = const(false))
            else
            if ("Account Type Employer" = const(Customer)) Customer
            else
            if ("Account Type Employer" = const(Vendor)) Vendor
            else
            if ("Account Type Employer" = const("Bank Account")) "Bank Account"
            else
            if ("Account Type Employer" = const("Fixed Asset")) "Fixed Asset"
            else
            if ("Account Type Employer" = const("IC Partner")) "IC Partner"
            else
            if ("Account Type Employer" = const(Employee)) Employee;
            Caption = 'Account No. Employer';
        }
        field(29; "Percentage Employer"; Decimal)
        {
            Caption = 'Percentage Employer';
        }
        field(30; "Minimum Amount"; Decimal)
        {
            Caption = 'Minimum Amount';
        }
        field(31; "Flat Amount Employer"; Decimal)
        {
            Caption = 'Flat Amount Employer';
        }
        field(32; "Total Amount Employer"; Decimal)
        {
            CalcFormula = sum("Assignment Matrix"."Employer Amount" where(Type = const(Deduction),
                                                                             Code = field(Code),
                                                                             "Payroll Period" = field("Pay Period Filter"),
                                                                             "Posting Group Filter" = field("Posting Group Filter"),
                                                                             "Department Code" = field("Department Filter"),
                                                                             "Employee No" = field("Employee Filter"),
                                                                             "Payroll Group" = field("Company Filter"),
                                                                             "Employee Type" = field("Employee Type Filter")));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Total Amount Employer';
        }
        field(33; "Loan Type"; Option)
        {
            OptionMembers = " ","Low Interest Benefit","Fringe Benefit";
            Caption = 'Loan Type';
        }
        field(34; "Show Balance"; Boolean)
        {
            Caption = 'Show Balance';
        }
        field(35; CoinageRounding; Boolean)
        {
            Caption = 'CoinageRounding';
        }
        field(36; "Employee Filter"; Code[30])
        {
            FieldClass = FlowFilter;
            TableRelation = Employee;
            Caption = 'Employee Filter';
        }
        field(37; "Opening Balance"; Decimal)
        {
            CalcFormula = sum("Assignment Matrix"."Opening Balance" where(Type = const(Deduction),
                                                                             Code = field(Code),
                                                                             "Employee No" = field("Employee Filter"),
                                                                             "Employee Type" = field("Employee Type Filter")));
            FieldClass = FlowField;
            Caption = 'Opening Balance';
        }
        field(38; "Department Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
            Caption = 'Department Filter';
        }
        field(39; "Balance Mode"; Option)
        {
            FieldClass = FlowFilter;
            OptionCaption = 'Increasing, Decreasing';
            OptionMembers = Increasing," Decreasing";
            Caption = 'Balance Mode';
        }
        field(40; "Main Loan Code"; Code[20])
        {
            Caption = 'Main Loan Code';
        }
        field(41; Shares; Boolean)
        {
            Caption = 'Shares';
        }
        field(42; "Show on report"; Boolean)
        {
            Caption = 'Show on report';
        }
        field(43; "Non-Interest Loan"; Boolean)
        {
            Caption = 'Non-Interest Loan';
        }
        field(44; "Exclude when on Leave"; Boolean)
        {
            Caption = 'Exclude when on Leave';
        }
        field(45; "Co-operative"; Boolean)
        {
            Caption = 'Co-operative';
        }
        field(46; "Total Shares"; Decimal)
        {
            CalcFormula = sum("Assignment Matrix".Amount where(Type = const(Deduction),
                                                                  Code = field(Code),
                                                                  "Employee No" = field("Employee Filter"),
                                                                  Shares = const(true),
                                                                  "Employee Type" = field("Employee Type Filter")));
            FieldClass = FlowField;
            Caption = 'Total Shares';
        }
        field(47; Rate; Decimal)
        {
            Caption = 'Rate';
        }
        field(48; "PAYE Code"; Boolean)
        {
            Caption = 'PAYE Code';

            trigger OnValidate()
            begin
                CheckPAYE(Code);
            end;
        }
        field(49; "Total Days"; Decimal)
        {
            Caption = 'Total Days';
        }
        field(50; "Housing Earned Limit"; Decimal)
        {
            Caption = 'Housing Earned Limit';
        }
        field(51; "Pension Limit Percentage"; Decimal)
        {
            Caption = 'Pension Limit Percentage';
        }
        field(52; "Pension Limit Amount"; Decimal)
        {
            Caption = 'Pension Limit Amount';
        }
        field(53; "Applies to All"; Boolean)
        {
            Caption = 'Applies to All';
        }
        field(54; "Show on Master Roll"; Boolean)
        {
            Caption = 'Show on Master Roll';
        }
        field(55; "Pension Scheme Code"; Boolean)
        {
            Caption = 'Provident Deduction';
        }
        field(56; "Main Deduction Code"; Code[20])
        {
            Caption = 'Main Deduction Code';
        }
        field(57; "Insurance Code"; Boolean)
        {
            Caption = 'Insurance Code';
        }
        field(58; Block; Boolean)
        {
            Caption = 'Block';
        }
        field(59; "Institution Code"; Code[20])
        {
            // TableRelation = Institutions;
            Caption = 'Institution Code';
        }
        field(60; "Reference Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            Caption = 'Reference Filter';
        }
        field(61; "Show on Payslip Information"; Boolean)
        {
            Caption = 'Show on Payslip Information';
        }
        field(62; "Voluntary Percentage"; Decimal)
        {
            Caption = 'Voluntary Percentage';
        }
        field(63; "Owner Occupied Interest"; Boolean)
        {
            Caption = 'Owner Occupied Interest';
        }
        field(64; Voluntary; Boolean)
        {
            Caption = 'Voluntary';
        }
        field(65; "Voluntary Amount"; Decimal)
        {
            CalcFormula = sum("Assignment Matrix".Amount where(Code = field("Voluntary Code"),
                                                                  "Payroll Period" = field("Pay Period Filter"),
                                                                  "Employee No" = field("Employee Filter"),
                                                                  Type = const(Deduction),
                                                                  "Employee Type" = field("Employee Type Filter")));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Voluntary Amount';
        }
        field(66; "Voluntary Code"; Code[20])
        {
            TableRelation = Deductions where(Voluntary = const(true));
            Caption = 'Voluntary Code';
        }
        field(67; "Loan Interest"; Decimal)
        {
            CalcFormula = sum("Assignment Matrix"."Loan Interest" where(Type = const(Deduction),
                                                                           Code = field(Code),
                                                                           "Posting Group Filter" = field("Posting Group Filter"),
                                                                           "Payroll Period" = field("Pay Period Filter"),
                                                                           "Employee No" = field("Employee Filter"),
                                                                           "Department Code" = field("Department Filter"),
                                                                           "Reference No" = field("Reference Filter"),
                                                                           "Payroll Group" = field("Company Filter"),
                                                                           "Employee Type" = field("Employee Type Filter")));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Loan Interest';
        }
        field(68; "Share Top Up"; Decimal)
        {
            CalcFormula = sum("Assignment Matrix"."Top Up Share" where(Type = const(Deduction),
                                                                          Code = field(Code),
                                                                          "Posting Group Filter" = field("Posting Group Filter"),
                                                                          "Payroll Period" = field("Pay Period Filter"),
                                                                          "Employee No" = field("Employee Filter"),
                                                                          "Department Code" = field("Department Filter"),
                                                                          "Reference No" = field("Reference Filter"),
                                                                          "Employee Type" = field("Employee Type Filter")));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Share Top Up';
        }
        field(69; "Company Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = Company;
            Caption = 'Company Filter';
        }
        field(70; "Customer Entry"; Boolean)
        {
            Caption = 'Customer Entry';
        }
        field(71; "Sacco Deduction"; Boolean)
        {
            Caption = 'Sacco Deduction';
        }
        field(72; "Balance Type"; Option)
        {
            OptionCaption = 'Increasing,Decreasing';
            OptionMembers = Increasing,Decreasing;
            Caption = 'Balance Type';
        }
        field(73; "Exclude Employer Balance"; Boolean)
        {
            Caption = 'Exclude Employer Balance';
        }
        field(74; Statutories; Boolean)
        {
            Caption = 'Statutories';
        }
        field(75; "Secondary PAYE"; Boolean)
        {
            Caption = 'Secondary PAYE';
        }
        field(76; "Account Type"; Enum "Gen. Journal Account Type")
        {
            Caption = 'Account Type';
        }
        field(77; "Account Type Employer"; Enum "Gen. Journal Account Type")
        {
            Caption = 'Account Type Employer';
        }
        field(78; Imprest; Boolean)
        {
            Caption = 'Imprest';
        }
        field(79; "Employee Type Filter"; Option)
        {
            FieldClass = FlowFilter;
            OptionCaption = 'Permanent,Partime,Locum,Casual,Contract,Trustee';
            OptionMembers = Permanent,Partime,Locum,Casual,Contract,Trustee;
            Caption = 'Employee Type Filter';
        }
        field(80; "NSSF"; Boolean)
        {
            Caption = 'NSSF';
        }
        field(81; "Exempt from a third rule"; Boolean)
        {
            Caption = 'Exempt from a third rule';
        }
        field(82; HELB; Boolean)
        {
            Caption = 'HELB';
        }
        field(83; NITA; Boolean)
        {
            Caption = 'NITA';
        }
        field(87; NHIF; Boolean)
        {
            Caption = 'NHIF';
        }
        field(88; "Check Probation End Date"; Boolean)
        {
            Caption = 'Check Probation End Date';
        }
        field(89; "Employer Contibution Taxed"; Boolean)
        {
            Caption = 'Employer Contibution Taxed';
        }
        field(90; "Housing Levy"; Boolean)
        {
            Caption = 'Housing Levy';
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
        key(Key2; "Show on report")
        {
        }
        key(Key3; "Exclude when on Leave")
        {
        }
        key(Key4; "Co-operative")
        {
        }
        key(Key5; Rate)
        {
        }
        key(Key6; Shares)
        {
        }
        key(Key7; Loan)
        {
        }
        key(Key8; "Pension Scheme Code")
        {
        }
        key(Key9; "Institution Code")
        {
        }
        key(Key10; Description)
        {
        }
    }

    fieldgroups
    {
    }

    var
        Text000: Label 'You cannot have more than one PAYE Code, %1  %2 is already defined as PAYE';

    procedure CheckPAYE(PAYECode: Code[20])
    var
        DeductionsRec: Record Deductions;
    begin
        DeductionsRec.Reset();
        DeductionsRec.SetFilter(Code, '<>%1', PAYECode);
        DeductionsRec.SetRange("PAYE Code", true);
        if DeductionsRec.Find('-') then
            Error(Text000, DeductionsRec.Code, DeductionsRec.Description);
    end;
}





