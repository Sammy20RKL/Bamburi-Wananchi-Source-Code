#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51335 "prPeriod Transactions."
{
    // version Payroll ManagementV1.0(Surestep Systems)

    DrillDownPageID = "Payroll Period Transaction.";
    LookupPageID = "Payroll Period Transaction.";

    fields
    {
        //periods.validate(employeecode)
        //period.modify;
        field(1; "Employee Code"; Code[100])
        {
            TableRelation = "Payroll Employee."."No.";
            trigger OnValidate()
            var
                PrEmp: Record "Payroll Employee.";
            begin
                PrEmp.Reset();
                PrEmp.SetRange("No.", "Employee Code");
                if PrEmp.FindFirst() then begin
                    "Payroll Category" := PrEmp."Payroll Categories";
                end;
            end;

        }
        field(2; "Transaction Code"; Text[30])
        {
            TableRelation = "Payroll Transaction Code."."Transaction Code";
        }
        field(3; "Group Text"; Text[30])
        {
            Description = 'e.g Statutory, Deductions, Tax Calculation etc';
        }
        field(4; "Transaction Name"; Text[200])
        {
        }
        field(5; Amount; Decimal)
        {
        }
        field(6; Balance; Decimal)
        {
        }
        field(7; "Original Amount"; Decimal)
        {
        }
        field(8; "Group Order"; Integer)
        {
        }
        field(9; "Sub Group Order"; Integer)
        {
        }
        field(10; "Period Month"; Integer)
        {
        }
        field(11; "Period Year"; Integer)
        {
        }
        field(12; "Period Filter"; Date)
        {
            FieldClass = FlowFilter;
            TableRelation = "Payroll Calender."."Date Opened";
        }
        field(13; "Payroll Period"; Date)
        {
            TableRelation = "Payroll Calender."."Date Opened";
        }
        field(14; Membership; Code[50])
        {
        }
        field(15; "Reference No"; Text[40])
        {
        }
        field(16; "Department Code"; Code[20])
        {
        }
        field(17; Lumpsumitems; Boolean)
        {
        }
        field(18; TravelAllowance; Code[20])
        {
        }
        field(19; "GL Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(20; "Company Deduction"; Boolean)
        {
            Description = 'Dennis- Added to filter out the company deductions esp: the Pensions';
        }
        field(21; "Emp Amount"; Decimal)
        {
            Description = 'Dennis- Added to take care of the balances that need a combiantion btwn employee and employer';
        }
        field(22; "Emp Balance"; Decimal)
        {
            Description = 'Dennis- Added to take care of the balances that need a combiantion btwn employee and employer';
        }
        field(23; "Journal Account Code"; Code[20])
        {
        }
        field(24; "Journal Account Type"; Option)
        {
            OptionMembers = " ","G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Staff,"None",Member;
        }
        field(25; "Post As"; Option)
        {
            OptionMembers = " ",Debit,Credit;
        }
        field(26; "Loan Number"; Code[30])
        {
        }
        // field(27; "coop parameters"; Option)
        // {
        //     Description = 'to be able to report the different coop contributions -Dennis';
        //     // OptionMembers = "None",Shares,Loan,"Share Capital",Likizo,"Loan Interest","Emergency Loan","Emergency Loan Interest",Welfare,Pension,NSSF,Overtime,"Insurance Contribution"
        //     // ,"Loan Application Fee Paid","Loan Insurance Paid";

        // }
        field(27; "coop parameters"; Option)
        {
            Description = 'to be able to report the different coop contributions -Fes';
            OptionMembers = "none",shares,loan,"Loan Interest","Emergency loan","Emergency Loan Interest","School Fees loan","School Fees Loan Interest",Welfare,Pension,NSSF,Overtime,NHIF,"Insurance Contribution","Share Capital",Likizo,"Housing Levy","Holiday Savings";
        }
        field(28; "Payroll Code"; Code[20])
        {
            TableRelation = "Payroll Type.";
        }
        field(29; "Payment Mode"; Option)
        {
            Description = 'Bank Transfer,Cheque,Cash,SACCO';
            OptionMembers = " ","Bank Transfer",Cheque,Cash,SACCO;
        }
        field(30; "Fosa Account No."; Code[50])
        {
            CalcFormula = Lookup("Payroll Employee."."Bank Account No" WHERE("No." = FIELD("Employee Code")));
            FieldClass = FlowField;
        }
        field(31; Organization; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Employee Contribution(vol)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Zamara No"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Policy No"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(36; "ALLOWANCE NEW"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(37; "Payroll Category"; Enum PayrollCategories)
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(Key1; "Employee Code", "Transaction Code", "Period Month", "Period Year", Membership, "Reference No", "Loan Number")
        {
            SumIndexFields = Amount;
        }
        key(Key2; "Employee Code", "Period Month", "Period Year", "Group Order", "Sub Group Order", Membership, "Reference No")
        {
            SumIndexFields = Amount;
        }
        key(Key3; "Group Order", "Transaction Code", "Period Month", "Period Year", Membership, "Reference No", "Department Code")
        {
            SumIndexFields = Amount;
        }
        key(Key4; Membership)
        {
        }
        key(Key5; "Transaction Code", "Payroll Period", Membership, "Reference No")
        {
            SumIndexFields = Amount;
        }
        key(Key6; "Payroll Period", "Group Order", "Sub Group Order")
        {
            SumIndexFields = Amount;
        }
        key(Key7; "Employee Code", "Department Code")
        {
            SumIndexFields = Amount;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var


    begin
        if "Employee Code" <> '' then begin
            Validate("Employee Code");
        end;


    end;
}

