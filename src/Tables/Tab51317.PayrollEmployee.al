#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51317 "Payroll Employee."
{
    // version Payroll ManagementV1.0(Surestep Systems)
    DrillDownPageId = "Payroll Employee List.";
    LookupPageId = "Payroll Employee List.";

    fields
    {
        field(6; "Exit Staff"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Date Exited"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Zamara No"; Code[50])
        {
            DataClassification = ToBeClassified;

            // trigger OnValidate()
            // begin
            //     pen.Reset;
            //     pen.SetRange(pen."Employee Code", empl."No.");
            //     if pen.Find('-') then begin

            //         pen."Schedule Unique Identifier" := "Zamara No";

            //     end;

            // end;
        }
        field(9; "Next Increment Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "No."; Code[50])
        {
            Editable = true;
            NotBlank = true;
        }
        field(11; Surname; Text[30])
        {
        }
        field(12; "First Name"; Text[30])
        {
        }
        field(13; "Middle Name"; Text[30])
        {
        }
        field(14; "Joining Date"; Date)
        {
        }
        field(15; "Currency Code"; Code[20])
        {
            TableRelation = Currency.Code;
        }
        field(16; "Currency Factor"; Decimal)
        {
        }
        field(17; "Global Dimension 1"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          "Dimension Value Type" = CONST(Standard));
        }
        field(18; "Global Dimension 2"; Code[20])
        {
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          "Dimension Value Type" = CONST(Standard));
        }
        field(19; "Shortcut Dimension 3"; Code[20])
        {
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
        }
        field(20; "Shortcut Dimension 4"; Code[20])
        {
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
        }
        field(21; "Shortcut Dimension 5"; Code[20])
        {
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));
        }
        field(22; "Shortcut Dimension 6"; Code[20])
        {
            CaptionClass = '1,2,6';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6));
        }
        field(23; "Shortcut Dimension 7"; Code[20])
        {
            CaptionClass = '1,2,7';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7));
        }
        field(24; "Shortcut Dimension 8"; Code[20])
        {
            CaptionClass = '1,2,8';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8));
        }
        field(25; "Basic Pay"; Decimal)
        {

            trigger OnValidate()
            begin
                if "Currency Code" = '' then
                    "Basic Pay(LCY)" := "Basic Pay"
                else
                    "Basic Pay(LCY)" := Round(CurrExchRate.ExchangeAmtFCYToLCY(Today, "Currency Code", "Basic Pay", "Currency Factor"));
                PayrollEmployeededucation.Reset;

                PayrollEmployeededucation.SetRange(PayrollEmployeededucation."Transaction Code", 'PSLF');
                if PayrollEmployeededucation.Find('-') then begin
                    if scad.Get("No.") then
                        PayrollEmployeededucation.Amount := ("Basic Pay" / 100) * scad."Basic Pay";
                    PayrollEmployeededucation.Modify;
                end;
            end;
        }
        field(26; "Basic Pay(LCY)"; Decimal)
        {
        }
        field(27; "Cummulative Basic Pay"; Decimal)
        {
            CalcFormula = Sum("prPeriod Transactions.".Amount WHERE("Transaction Code" = FILTER('BPAY'),
                                                                     "Employee Code" = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(28; "Cummulative Gross Pay"; Decimal)
        {
            CalcFormula = Sum("prPeriod Transactions.".Amount WHERE("Transaction Code" = FILTER('GPAY'),
                                                                     "Employee Code" = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(29; "Cummulative Allowances"; Decimal)
        {
            CalcFormula = Sum("prPeriod Transactions.".Amount WHERE("Transaction Code" = FILTER('AIRTIMEALLOWANCE' | 'COMMUTERALLOWANCE' | 'ENTERTAINMENT' | 'EXTRANEOUS ALLOWANCE' | 'MEDICAL ALLOWANCE' | 'HOUSE ALLOWANCE'),
                                                                     "Employee Code" = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(30; "Cummulative Deductions"; Decimal)
        {
            CalcFormula = Sum("prPeriod Transactions.".Amount WHERE("Transaction Code" = FILTER('TOT-DED'),
                                                                     "Employee Code" = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(31; "Cummulative Net Pay"; Decimal)
        {
            CalcFormula = Sum("prPeriod Transactions.".Amount WHERE("Transaction Code" = FILTER('NPAY'),
                                                                     "Employee Code" = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(32; "Cummulative PAYE"; Decimal)
        {
            CalcFormula = Sum("prPeriod Transactions.".Amount WHERE("Transaction Code" = FILTER('PAYE'),
                                                                     "Employee Code" = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(33; "Cummulative NSSF"; Decimal)
        {
            CalcFormula = Sum("prPeriod Transactions.".Amount WHERE("Transaction Code" = FILTER('NSSF'),
                                                                     "Employee Code" = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(34; "Cummulative Pension"; Decimal)
        {
            CalcFormula = Sum("prPeriod Transactions.".Amount WHERE("Transaction Code" = FILTER('D022'),
                                                                     "Employee Code" = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(35; "Cummulative HELB"; Decimal)
        {
            CalcFormula = Sum("prPeriod Transactions.".Amount WHERE("Transaction Code" = FILTER('HELB'),
                                                                     "Employee Code" = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(36; "Cummulative NHIF"; Decimal)
        {
            CalcFormula = Sum("prPeriod Transactions.".Amount WHERE("Transaction Code" = FILTER('NHIF'),
                                                                     "Employee Code" = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(37; "Cummulative Employer Pension"; Decimal)
        {
        }
        field(38; "Cummulative TopUp"; Decimal)
        {
        }
        field(39; "Cummulative Basic Pay(LCY)"; Decimal)
        {
            Editable = false;
        }
        field(40; "Cummulative Gross Pay(LCY)"; Decimal)
        {
            Editable = false;
        }
        field(41; "Cummulative Allowances(LCY)"; Decimal)
        {
            Editable = false;
        }
        field(42; "Cummulative Deductions(LCY)"; Decimal)
        {
            Editable = false;
        }
        field(43; "Cummulative Net Pay(LCY)"; Decimal)
        {
            Editable = false;
        }
        field(44; "Cummulative PAYE(LCY)"; Decimal)
        {
        }
        field(45; "Cummulative NSSF(LCY)"; Decimal)
        {
        }
        field(46; "Cummulative Pension(LCY)"; Decimal)
        {
        }
        field(47; "Cummulative HELB(LCY)"; Decimal)
        {
        }
        field(48; "Cummulative NHIF(LCY)"; Decimal)
        {
        }
        field(49; "Cumm Employer Pension(LCY)"; Decimal)
        {
        }
        field(50; "Cummulative TopUp(LCY)"; Decimal)
        {
        }
        field(51; "Non Taxable"; Decimal)
        {

            trigger OnValidate()
            begin
                if "Currency Code" = '' then
                    "Non Taxable(LCY)" := "Non Taxable"
                else
                    "Non Taxable(LCY)" := Round(CurrExchRate.ExchangeAmtFCYToLCY(Today, "Currency Code", "Non Taxable", "Currency Factor"));
            end;
        }
        field(52; "Non Taxable(LCY)"; Decimal)
        {
        }
        field(53; "Posting Group"; Code[20])
        {
            TableRelation = "Payroll Posting Groups."."Posting Code";
        }
        field(54; "Payment Mode"; Option)
        {
            OptionCaption = 'Bank Transfer,Cheque';
            OptionMembers = "Bank Transfer",Cheque;
        }
        field(55; "Pays PAYE"; Boolean)
        {
        }
        field(56; "Pays NSSF"; Boolean)
        {
        }
        field(57; "Pays NHIF"; Boolean)
        {
        }
        field(58; "Bank Code"; Code[20])
        {
            TableRelation = Banks;

            trigger OnValidate()
            begin
                BankCodes.Reset;
                BankCodes.SetRange(BankCodes."Bank Code", "Bank Code");
                if BankCodes.FindFirst then begin
                    BankCodes.TestField(BankCodes."Bank Name");
                    "Bank Name" := BankCodes."Bank Name";
                    // "Branch Name" := BankCodes."Branch Code";
                    // "Bank Location" := BankCodes.Location;
                end;
            end;
        }
        field(59; "Bank Name"; Text[100])
        {
        }
        field(60; "Branch Code"; Code[20])
        {
            //TableRelation = Banks."Branch Code";
            // trigger OnValidate()
            // begin
            //     BankBranches.Reset;
            //     BankBranches.SetRange(BankBranches."Bank Code", "Bank Code");
            //     BankBranches.SetRange(BankBranches."Branch Code", "Branch Code");
            //     if BankBranches.FindFirst then begin
            //         BankBranches.TestField(BankBranches."Branch Code");
            //         "Branch Name" := BankBranches."Branch Code";
            //     end;
            // end;
        }
        field(61; "Branch Name"; Text[100])
        {
        }
        field(62; "Bank Account No"; Code[50])
        {
            NotBlank = true;
        }
        field(63; "Suspend Pay"; Boolean)
        {
        }
        field(64; "Suspend Date"; Date)
        {
        }
        field(65; "Suspend Reason"; Code[40])
        {
            TableRelation = "suspend pay reason";
        }
        field(66; "Hourly Rate"; Decimal)
        {
        }
        field(67; Gratuity; Boolean)
        {
        }
        field(68; "Gratuity Percentage"; Decimal)
        {
        }
        field(69; "Gratuity Provision"; Decimal)
        {

            trigger OnValidate()
            begin
                if "Currency Code" = '' then
                    "Gratuity Provision(LCY)" := "Gratuity Provision"
                else
                    "Gratuity Provision(LCY)" := Round(CurrExchRate.ExchangeAmtFCYToLCY(Today, "Currency Code", "Gratuity Provision", "Currency Factor"));
            end;
        }
        field(70; "Gratuity Provision(LCY)"; Decimal)
        {
        }
        field(71; "Cummulative Gratuity"; Decimal)
        {
        }
        field(72; "Cummulative Gratuity(LCY)"; Decimal)
        {
        }
        field(73; "Days Absent"; Decimal)
        {
        }
        field(74; "Payslip Message"; Text[100])
        {
        }
        field(75; "Paid per Hour"; Boolean)
        {
        }
        field(76; "Full Name"; Text[90])
        {
        }
        field(77; Status; Option)
        {
            OptionCaption = 'Active,Inactive';
            OptionMembers = Active,Inactive;
        }
        field(78; "Date of Leaving"; Date)
        {
        }
        field(79; GetsPayeRelief; Boolean)
        {
        }
        field(80; GetsPayeBenefit; Boolean)
        {
        }
        field(81; Secondary; Boolean)
        {
        }
        field(82; PayeBenefitPercent; Decimal)
        {
        }
        field(83; "NSSF No"; Code[20])
        {
        }
        field(84; "NHIF No"; Code[20])
        {
        }
        field(85; "PIN No"; Code[20])
        {
        }
        field(86; Company; Option)
        {
            OptionCaption = ',HQ,NAIROBI';
            OptionMembers = ,HQ,NAIROBI;
        }
        field(87; "Current Month Filter"; Date)
        {
            FieldClass = FlowFilter;
            TableRelation = "Payroll Calender."."Date Opened";
        }
        field(88; "National ID No"; Code[20])
        {

            trigger OnValidate()
            begin
                /*IF "National ID No"<>'' THEN BEGIN
                empl.RESET;
                empl.SETRANGE(empl."National ID No","National ID No");
                IF empl.FIND('-') THEN
                  ERROR('This National Id Number is already in the system');
                END;*/

            end;
        }
        field(89; "Employee Email"; Text[100])
        {
        }
        field(90; Department; Text[30])
        {

        }
        field(91; "Job Group"; Code[25])
        {
            //TableRelation = "Job Grades".Code;

        }
        field(92; Category; Option)
        {
            OptionCaption = ' ,Permanent,Contract,Sales Representatives,Intern,Probation';
            OptionMembers = " ",Permanent,Contract,"Sales Representatives",Intern,Probation,Secondment;
        }
        field(93; "Sacco Membership No."; Code[20])
        {
        }
        field(94; "Insurance Premium"; Decimal)
        {
        }
        field(95; "Payroll No"; Code[20])
        {
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                if ObjCust.Get("Payroll No") then begin
                    "Full Name" := ObjCust.Name;
                    "Employee Email" := ObjCust."E-Mail";
                    "National ID No" := ObjCust."ID No.";
                    "PIN No" := ObjCust.Pin;
                    "No." := ObjCust."Payroll/Staff No";

                end;
            end;
        }
        field(96; "Period Filter"; Date)
        {
            FieldClass = FlowFilter;
            TableRelation = "Payroll Calender."."Date Opened";
        }
        field(97; "Selected Period"; Date)
        {
        }
        field(98; "Is Management"; Boolean)
        {
        }
        field(100; "Job Description"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(102; "Bank Location"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(103; "Work Station"; Code[20])
        {
            // CaptionClass = '1,2,2';
            // DataClassification = ToBeClassified;
            // TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
            //                                               "Dimension Value Type" = CONST(Standard));
        }
        field(105; "Date Of Retirement"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = FALSE;
        }
        field(104; "Date of Birth"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            Var
                CurrentDate: date;
                SaccoGen: Record "Sacco General Set-Up";

            begin
                if "Date of Birth" > Today then
                    Error('Date of birth cannot be greater than today');
                Age := Dates.DetermineAge("Date of Birth", Today);
                if SaccoGen.Get() then
                    "Date Of Retirement" := CalcDate(SaccoGen."Retirement Age", "Date of Birth");

            end;
        }
        field(106; Age; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(107; "Living with disability"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(108; "Payroll Period"; Date)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payroll Calender."."Date Opened";
        }
        field(109; "Last Increment Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(110; Organization; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',MSEA,KYEOP';
            OptionMembers = ,MSEA,KYEOP;
        }
        field(111; NITA; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(112; "Gets Relief"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(113; Gender; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Male,Female';
            OptionMembers = ,Male,Female;
        }
        field(114; "Department Code"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = PayrollDepartments;
            trigger OnValidate()

            begin
                PayrollDepartments.Reset();
                PayrollDepartments.SetRange(PayrollDepartments.code, "Department Code");
                if PayrollDepartments.FindFirst()
                then begin
                    Department := PayrollDepartments.Department;
                end;

            end;
        }
        field(115; "Job scale"; Code[10])
        {
            DataClassification = ToBeClassified;
            // TableRelation = Scales.Scales;
            //ValidateTableRelation = false;

            // trigger OnValidate()
            // begin
            //     MSEASalaryScales.Reset;
            //     // MSEASalaryScales.SetRange(MSEASalaryScales.Grade, "Job Group");
            //     MSEASalaryScales.SetRange(MSEASalaryScales.Scale, "Job scale");
            //     if MSEASalaryScales.FindFirst then begin
            //         "Basic Pay" := MSEASalaryScales."Basic Pay";

            //     end;
            //     Modify;

            //     PayrollEmployeededucation.Reset;

            //     PayrollEmployeededucation.SetRange(PayrollEmployeededucation."Transaction Code", 'PSLF');
            //     if PayrollEmployeededucation.Find('-') then begin
            //         if scad.Get("No.") then
            //             PayrollEmployeededucation.Amount := 1000;//("Basic Pay"/100)*scad."Basic Pay";
            //         PayrollEmployeededucation.Modify;
            //     end;


            // end;
        }
        field(116; "New Scale"; Integer)
        {
            // DataClassification = ToBeClassified;
            // TableRelation = "MSEA Salary Scales";
        }
        field(117; "Next Scale"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(118; "Designation"; Text[100])
        {
            DataClassification = ToBeClassified;
            //TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('DESIGNATIONS'));
        }
        field(119; "Payroll Categories"; Enum PayrollCategories)
        {
            DataClassification = ToBeClassified;
        }
        field(120; "Exited Staff"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(121; "Voluntary Deposit Contribution"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(122; "Last Payroll Period"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(123; "Pay Bonus"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(124; "Bonus Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(125; "Pays Pension"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(126; "Development Loans"; Decimal)
        {
            CalcFormula = Sum("prPeriod Transactions.".Amount WHERE("Transaction Code" = FILTER('DL'),
                                                                     "Employee Code" = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(127; "Emergency Loans"; Decimal)
        {
            CalcFormula = Sum("prPeriod Transactions.".Amount WHERE("Transaction Code" = FILTER('EL'),
                                                                     "Employee Code" = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(128; "User ID"; Code[22])
        {
            TableRelation = "User Setup"."User ID";
        }

    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Full Name")
        {
        }
    }

    // trigger OnDelete()
    // begin

    //     Error('Not Allowed To Delete Records!.');
    // end;

    var
        PayrollDepartments: Record PayrollDepartments;
        ObjCust: Record Customer;
        CurrExchRate: Record "Currency Exchange Rate";
        BankCodes: Record Banks;
        BankBranches: Record Banks;
        // HREmp: Record "HR Employees";
        empl: Record "Payroll Employee.";
        // hrset: Record "HR Setup";
        Dates: Codeunit "Dates Calculation";
        // MSEASalaryScales: Record "MSEA Salary Scales";
        prperiod: Record "prPeriod Transactions.";
        // pen: Record "Pension Test";
        PrTrans2: Record "Payroll Employee Transactions.";
        PayrollEmployee: Record "Payroll Employee.";
        PayrollEmployeededucation: Record "Payroll Employee Transactions.";
        scad: Record "Payroll Employee.";
}
