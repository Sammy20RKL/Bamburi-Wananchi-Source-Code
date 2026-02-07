table 52127 "Assignment Matrix"
{
    DataCaptionFields = "Employee No", Description;
    // DrillDownPageID = "Payments_Deduction";
    // LookupPageID = "Payments_Deduction";
    DataClassification = CustomerContent;
    Caption = 'Assignment Matrix';
    fields
    {
        field(1; "Employee No"; Code[30])
        {
            NotBlank = true;
            TableRelation = Employee;
            Caption = 'Employee No';

            trigger OnValidate()
            begin
                if Employee.Get("Employee No") then begin
                    "Posting Group Filter" := Employee."Posting Group";
                    "Department Code" := Employee."Global Dimension 1 Code";
                    "Salary Grade" := CopyStr(Employee."Salary Scale", 1, MaxStrLen("Salary Grade"));
                    "Salary Pointer" := CopyStr(Employee."Present Pointer", 1, MaxStrLen("Salary Pointer"));
                    if Employee."Posting Group" = '' then;
                    //ERROR(Error000,Employee."First Name",Employee."Last Name");
                    if Employee.Status <> Employee.Status::Active then;
                    //ERROR(Error001,Employee."First Name",Employee."Last Name");
                    if Employee."Employee Type" <> Employee."Employee Type"::"Board Member" then begin
                        if EmpContract.Get(Employee."Nature of Employment") then
                            "Employee Type" := EmpContract."Employee Type";
                    end else
                        "Employee Type" := Employee."Employee Type";
                    "Global Dimension 1 Code" := Employee."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := Employee."Global Dimension 2 Code";
                    Area := Employee.Area;
                end;
            end;
        }
        field(2; Type; Enum "Payroll Transaction Type")
        {
            NotBlank = false;
            Caption = 'Type';
        }
        field(3; "Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = if (Type = const(Earning)) Earnings
            else
            if (Type = const(Deduction)) Deductions
            else
            if (Type = const(Loan)) "Payroll Loan Application"."Loan No" where("Employee No" = field("Employee No"));
            Caption = 'Code';

            trigger OnValidate()
            var
                Formula: Code[250];
            begin
                GetPayPeriod();
                "Payroll Period" := PayStartDate;
                "Pay Period" := PayPeriodText;

                GetSetup();
                GetEmployee();

                // ----------------Allowances Calculation------------------
                if Type = Type::Earning then begin
                    if Payments.Get(Code) then begin
                        // Check If Blocked

                        if Payments.Block = true then
                            Error(Error002, Payments.Code, Payments.Description);
                        "Time Sheet" := Payments."Time Sheet";
                        Description := Payments.Description;
                        Frequency := Payments."Pay Type";
                        // "Currency Code" := Employee."Currency Code";

                        if Payments."Earning Type" = Payments."Earning Type"::"Tax Relief" then
                            "Tax Relief" := true;

                        "Non-Cash Benefit" := Payments."Non-Cash Benefit";
                        Quarters := Payments.Quarters;

                        //Paydeduct:=Payments."End Date";
                        Taxable := Payments.Taxable;
                        "Tax Deductible" := Payments."Reduces Tax";
                        Gratuity := Payments.Gratuity;
                        if Payments."Pay Type" = Payments."Pay Type"::Recurring then
                            "Next Period Entry" := true;
                        "Basic Salary Code" := Payments."Basic Salary Code";
                        "Basic Pay Arrears" := Payments."Basic Pay Arrears";
                        "House Allowance Code" := Payments."House Allowance Code";
                        "Commuter Allowance Code" := Payments."Commuter Allowance Code";
                        "Salary Arrears Code" := Payments."Salary Arrears Code";
                        "Exclude Gross Pay Deduction" := Payments."Exclude Gross Pay Deduction";

                        if Payments."Earning Type" = Payments."Earning Type"::"Normal Earning" then
                            "Normal Earnings" := true;
                    end else
                        "Normal Earnings" := false;


                    case Payments."Calculation Method" of
                        Payments."Calculation Method"::"Flat amount":
                            Amount := Payments."Flat Amount";

                        // % Of Basic Pay
                        Payments."Calculation Method"::"% of Basic pay":
                            begin
                                Employee.SetRange("Pay Period Filter", "Payroll Period");
                                Employee.CalcFields("Basic Pay", "Basic Arrears");
                                /*//Leave Allowance
                                if Payments."Leave Allwance"=true then
                                  begin
                                    Amount:=(Payments.Percentage*(Employee."Basic Pay"*12));
                                  end else*/
                                //Gratuity
                                /*if Payments.Gratuity = true then begin
                                    //Amount:=Payments.Percentage/100*(PayrollMgt.GetMonthWorked(Employee."No."));
                                    //Amount:=Payments.Percentage/100*(Employee."Basic Pay"*12);
                                end else*/
                                Payments.TestField(Percentage);
                                Amount := Payments.Percentage / 100 * (Employee."Basic Pay" - Employee."Basic Arrears");
                                Amount := PayrollRounding(Amount);
                            end;

                        // % Of Basic after Tax
                        Payments."Calculation Method"::"% of Basic after tax":

                            if HRSetup."Company overtime hours" <> 0 then
                                Amount := PayrollRounding(Amount);

                        // Based on Hourly Rate
                        Payments."Calculation Method"::"Based on Hourly Rate":
                            ;
                        /*
Amount:="No. of Units"*Employee."Driving Licence"*Payments."Overtime Factor";
if Payments."Overtime Factor"<>0 then
Amount:="No. of Units"*Employee."Driving Licence"*Payments."Overtime Factor";
Amount:=PayrollRounding(Amount);
*/

                        // Based on Daily Rate
                        Payments."Calculation Method"::"Based on Daily Rate":
                            ;
                        /*
Amount:=Employee."Driving Licence"*Employee."days worked";
Amount:=PayrollRounding(Amount);
*/

                        // % Of Insurance Amount
                        Payments."Calculation Method"::"% of Insurance Amount":
                            begin
                                Employee.SetRange("Pay Period Filter", "Payroll Period");
                                Employee.CalcFields("Insurance Premium");
                                if "Ext Insurance Amount" <> 0 then
                                    Amount := Abs((Payments.Percentage / 100) * ("Ext Insurance Amount"))
                                else
                                    Amount := Abs((Payments.Percentage / 100) * (Employee."Insurance Premium"));
                                Amount := PayrollRounding(Amount);
                            end;

                        // % Of Insurance Amount
                        Payments."Calculation Method"::"% of NHIF Amount":
                            begin
                                Employee.SetRange("Pay Period Filter", "Payroll Period");
                                Employee.CalcFields("NHIF Amount");
                                Amount := Abs((Payments.Percentage / 100) * (Employee."NHIF Amount"));
                                Amount := PayrollRounding(Amount);
                            end;

                        // % F Gross Pay
                        Payments."Calculation Method"::"% of Gross pay":
                            begin
                                Employee.SetRange("Pay Period Filter", "Payroll Period");
                                Employee.CalcFields("Basic Pay", "Total Allowances");
                                Amount := ((Payments.Percentage / 100) * (Employee."Total Allowances"));
                                Amount := PayrollRounding(Amount);
                            end;

                        // % of Taxable Income
                        Payments."Calculation Method"::"% of Taxable income":
                            begin
                                Employee.SetRange("Pay Period Filter", "Payroll Period");
                                Employee.CalcFields("Taxable Allowance");
                                Amount := ((Payments.Percentage / 100) * (Employee."Taxable Allowance"));
                                Amount := PayrollRounding(Amount);
                            end;


                        //Formula
                        Payments."Calculation Method"::Formula:
                            begin
                                Employee.SetRange("Pay Period Filter", "Payroll Period");
                                // Formula := PayrollMgt.GetPureFormula("Employee No", "Payroll Period", Payments.Formula);
                                // Amount := PayrollMgt.GetResult(Formula);
                            end;

                        //% of Other Earnings
                        Payments."Calculation Method"::"% of Other Earnings":
                            begin
                                TotalOtherEarnings := 0;
                                if Employee.Get("Employee No") then;
                                // if Employee.Get("Employee No") then begin
                                //     Employee.SetRange("Pay Period Filter", "Payroll Period");
                                //     OtherEarnings.Reset();
                                //     OtherEarnings.SetRange("Main Earning", Payments.Code);
                                //     if OtherEarnings.Find('-') then
                                //         repeat
                                //             AssgnMatrix.Reset();
                                //             AssgnMatrix.SetRange(AssgnMatrix.Code, OtherEarnings."Earning Code");
                                //             AssgnMatrix.SetRange(AssgnMatrix."Payroll Period", "Payroll Period");
                                //             AssgnMatrix.SetRange(AssgnMatrix.Type, AssgnMatrix.Type::Earning);
                                //             AssgnMatrix.SetRange(AssgnMatrix."Employee No", "Employee No");
                                //             if AssgnMatrix.Find('-') then
                                //                 TotalOtherEarnings += Abs(AssgnMatrix.Amount);
                                //         until OtherEarnings.Next() = 0;
                                //     Payments.TestField(Percentage);
                                //     Amount := ((TotalOtherEarnings / 100) * Payments.Percentage);
                                //     Amount := PayrollRounding(Amount);
                                // end;
                            end;

                        //% of Other Deductions
                        Payments."Calculation Method"::"% of Other Deductions":
                            begin
                                TotalDeductionLines := 0;
                                // if Employee.Get("Employee No") then begin
                                //     Employee.SetRange("Pay Period Filter", "Payroll Period");
                                //     OtherDeductionLines.Reset();
                                //     OtherDeductionLines.SetRange("Main Code", Payments.Code);
                                //     if OtherDeductionLines.FindSet() then
                                //         repeat
                                //             AssgnMatrix.Reset();
                                //             AssgnMatrix.SetRange(AssgnMatrix.Code, OtherDeductionLines."Deduction Code");
                                //             AssgnMatrix.SetRange(AssgnMatrix."Payroll Period", "Payroll Period");
                                //             AssgnMatrix.SetRange(AssgnMatrix.Type, AssgnMatrix.Type::Deduction);
                                //             AssgnMatrix.SetRange(AssgnMatrix."Employee No", "Employee No");
                                //             if AssgnMatrix.FindSet() then
                                //                 TotalDeductionLines += Abs(AssgnMatrix.Amount);
                                //         until OtherDeductionLines.Next() = 0;
                                //     Payments.TestField(Percentage);
                                //     Amount := ((TotalDeductionLines / 100) * Payments.Percentage);
                                //     Amount := PayrollRounding(Amount);
                                // end;

                            end;

                        Payments."Calculation Method"::"Based on Salary Scale":
                            begin
                                SalaryScale.Reset();
                                // SalaryScale.SetRange(Scale, HRManagement.GetEmployeeJobGroup("Employee No"));
                                if SalaryScale.FindFirst() then begin
                                    SalaryScaleAllowance.Reset();
                                    SalaryScaleAllowance.SetRange("Salary Scale", SalaryScale.Scale);
                                    SalaryScaleAllowance.SetRange("Earning Code", "Code");
                                    if SalaryScaleAllowance.FindFirst() then begin
                                        Amount := SalaryScaleAllowance.Amount;
                                        Amount := PayrollRounding(Amount);
                                    end;
                                end;
                            end;

                        Payments."Calculation Method"::"% of Annual Basic":
                            begin
                                Employee.SetRange("Pay Period Filter", "Payroll Period");
                                Employee.CalcFields("Basic Pay");
                                Amount := ((Payments.Percentage / 100) * (Employee."Basic Pay" * 12));
                                Amount := PayrollRounding(Amount);
                            end else
                                    if Payments."Leave Allowance" = true then begin
                                        Employee.Reset();
                                        Employee.SetRange("No.", "Employee No");
                                        if Employee.Find('-') then begin
                                            if Employee."Employment Type" = Employee."Employment Type"::Permanent then
                                                Amount := ((Employee."Basic Pay" * 12) * (Payments.Percentage / 100));
                                        end else
                                            if Employee."Employment Type" = Employee."Employment Type"::Contract then
                                                Amount := 0;//((Employee."Basic Pay" * PayrollMgt.GetMonthWorked("Employee No")) * (Payments.Percentage / 100));
                                    end;
                    end;

                    if Payments."Reduces Tax" then
                        Amount := PayrollRounding(Amount);

                end;

                //------------------Deductions-------------------

                if Type = Type::Deduction then begin
                    if Deductions.Get(Code) then begin
                        if Deductions.Block = true then
                            Error(Error003, Deductions.Code, Deductions.Description);
                        Description := Deductions.Description;
                        "G/L Account" := Deductions."Account No.";
                        "Tax Deductible" := Deductions."Tax deductible";
                        Retirement := Deductions."Pension Scheme";
                        Shares := Deductions.Shares;
                        Paye := Deductions."PAYE Code";
                        "Secondary PAYE" := Deductions."Secondary PAYE";
                        "Insurance Code" := Deductions."Insurance Code";
                        "Main Deduction Code" := Deductions."Main Deduction Code";
                        Voluntary := Deductions.Voluntary;
                        Frequency := Deductions.Type;
                        NHIF := Deductions.NHIF;
                        "Housing Levy" := Deductions."Housing Levy";
                        //Added for Sacco Deductions
                        "Sacco Deduction" := Deductions."Sacco Deduction";

                        if Deductions.Type = Deductions.Type::Recurring then
                            "Next Period Entry" := true;
                        if Deductions."Calculation Method" = Deductions."Calculation Method"::"Flat Amount" then
                            if not Deductions.Imprest then begin
                                Amount := Deductions."Flat Amount";
                                "Employer Amount" := Deductions."Flat Amount Employer";
                            end;

                        if Deductions."Calculation Method" = Deductions."Calculation Method"::"% of Basic Pay" then
                            if Employee.Get("Employee No") then begin
                                Employee.SetRange("Pay Period Filter", "Payroll Period");
                                Employee.CalcFields("Basic Pay");
                                Amount := Deductions.Percentage / 100 * Employee."Basic Pay";
                                Amount := PayrollRounding(Amount);
                                // CheckIfRatesInclusive("Employee No", "Payroll Period", Code, Amount);
                                "Employer Amount" := Deductions."Percentage Employer" / 100 * Employee."Basic Pay";
                                "Employer Amount" := PayrollRounding("Employer Amount");
                                // CheckIfRatesInclusive("Employee No", "Payroll Period", Code, "Employer Amount");
                            end;

                        if Deductions."Calculation Method" = Deductions."Calculation Method"::"% of Gross Pay" then
                            if Employee.Get("Employee No") then begin
                                Employee.SetRange("Pay Period Filter", "Payroll Period");
                                Employee.CalcFields("Basic Pay", "Total Allowances", "Gross Excludable Allowances");
                                Amount := Deductions.Percentage / 100 * (Employee."Total Allowances" - Employee."Gross Excludable Allowances");
                                Amount := PayrollRounding(Amount);
                                // CheckIfRatesInclusive("Employee No", "Payroll Period", Code, Amount);
                                "Employer Amount" := Deductions."Percentage Employer" / 100 * (Employee."Total Allowances" - Employee."Gross Excludable Allowances");
                                "Employer Amount" := PayrollRounding("Employer Amount");
                                // CheckIfRatesInclusive("Employee No", "Payroll Period", Code, "Employer Amount");
                            end;

                        if Deductions.CoinageRounding = true then begin
                            Retirement := Deductions.CoinageRounding;
                            if Deductions."Calculation Method" = Deductions."Calculation Method"::"% of Basic Pay" then
                                "Employer Amount" := Deductions.Percentage / 100 * Employee."Basic Pay"
                            else
                                "Employer Amount" := Deductions."Flat Amount";
                            "Employer Amount" := PayrollRounding("Employer Amount");
                        end;

                        Amount := PayrollRounding(Amount);
                        "Employer Amount" := PayrollRounding("Employer Amount");
                    end;

                    // Deduction Based on Basic Pay and House Allowance
                    if Deductions."Calculation Method" = Deductions."Calculation Method"::"% of Basic Pay+Hse Allowance" then
                        if Employee.Get("Employee No") then
                            if Employee.Get("Employee No") then begin
                                Employee.SetRange("Pay Period Filter", "Payroll Period");
                                Employee.CalcFields("Basic Pay", "House Allowance");
                                Amount := Deductions.Percentage / 100 * (Employee."Basic Pay" + Employee."House Allowance");
                                Amount := PayrollRounding(Amount);
                                // CheckIfRatesInclusive("Employee No", "Payroll Period", Code, Amount);
                                "Employer Amount" := Deductions."Percentage Employer" / 100 * (Employee."Basic Pay" + Employee."House Allowance");
                                "Employer Amount" := PayrollRounding("Employer Amount");
                                // CheckIfRatesInclusive("Employee No", "Payroll Period", Code, "Employer Amount");
                            end;

                    //% of Other Earnings
                    if Deductions."Calculation Method" = Deductions."Calculation Method"::"% of Other Earnings" then begin
                        TotalOtherDeductions := 0;
                        if Employee.Get("Employee No") then;
                        //     if Employee.Get("Employee No") then begin
                        //         Employee.SetRange("Pay Period Filter", "Payroll Period");
                        //         OtherDeductions.Reset();
                        //         OtherDeductions.SetRange("Main Deduction", Deductions.Code);
                        //         if OtherDeductions.Find('-') then
                        //             repeat
                        //                 AssgnMatrix.Reset();
                        //                 AssgnMatrix.SetRange(AssgnMatrix.Code, OtherDeductions."Earning Code");
                        //                 AssgnMatrix.SetRange(AssgnMatrix."Payroll Period", "Payroll Period");
                        //                 AssgnMatrix.SetRange(AssgnMatrix.Type, AssgnMatrix.Type::Earning);
                        //                 AssgnMatrix.SetRange(AssgnMatrix."Employee No", "Employee No");
                        //                 if AssgnMatrix.Find('-') then
                        //                     TotalOtherDeductions += Abs(AssgnMatrix.Amount);
                        //             until OtherDeductions.Next() = 0;
                        //         Deductions.TestField(Percentage);
                        //         Amount := ((TotalOtherDeductions / 100) * Deductions.Percentage);
                        //         Amount := PayrollRounding(Amount);
                        //         "Employer Amount" := Deductions."Percentage Employer" / 100 * TotalOtherDeductions;
                        //         "Employer Amount" := PayrollRounding("Employer Amount");
                        //         CheckIfRatesInclusive("Employee No", "Payroll Period", Code, "Employer Amount");
                        //     end;
                    end;

                    //% of Other Deductions
                    if Deductions."Calculation Method" = Deductions."Calculation Method"::"% of Other Deductions" then begin
                        TotalDeductionLines := 0;
                        //     if Employee.Get("Employee No") then begin
                        //         Employee.SetRange("Pay Period Filter", "Payroll Period");
                        //         OtherDeductionLines.Reset();
                        //         OtherDeductionLines.SetRange("Main Code", Deductions.Code);
                        //         if OtherDeductionLines.FindSet() then
                        //             repeat
                        //                 AssgnMatrix.Reset();
                        //                 AssgnMatrix.SetRange(AssgnMatrix.Code, OtherDeductionLines."Deduction Code");
                        //                 AssgnMatrix.SetRange(AssgnMatrix."Payroll Period", "Payroll Period");
                        //                 AssgnMatrix.SetRange(AssgnMatrix.Type, AssgnMatrix.Type::Deduction);
                        //                 AssgnMatrix.SetRange(AssgnMatrix."Employee No", "Employee No");
                        //                 if AssgnMatrix.FindSet() then
                        //                     TotalDeductionLines += Abs(AssgnMatrix.Amount);
                        //             until OtherDeductionLines.Next() = 0;
                        //         Deductions.TestField(Percentage);
                        //         Amount := ((TotalDeductionLines / 100) * Deductions.Percentage);
                        //         Amount := PayrollRounding(Amount);
                        //         "Employer Amount" := Deductions."Percentage Employer" / 100 * TotalDeductionLines;
                        //         "Employer Amount" := PayrollRounding("Employer Amount");
                        //         CheckIfRatesInclusive("Employee No", "Payroll Period", Code, "Employer Amount");
                        //     end;
                    end;

                    // Deduction Based on Basic Pay + House Allowance + Commuter Allowance + Salary arrears
                    if Deductions."Calculation Method" = Deductions."Calculation Method"::"% of Basic Pay+Hse Allowance + Comm Allowance + Sal Arrears" then
                        if Employee.Get("Employee No") then
                            if Employee.Get("Employee No") then begin
                                Employee.SetRange("Pay Period Filter", "Payroll Period");
                                Employee.CalcFields("Basic Pay", "House Allowance", "Commuter Allowance", "Salary Arrears");
                                Amount := Deductions.Percentage / 100 * (Employee."Basic Pay" + Employee."House Allowance" + Employee."Commuter Allowance" + Employee."Salary Arrears");
                                Amount := PayrollRounding(Amount);
                                // CheckIfRatesInclusive("Employee No", "Payroll Period", Code, Amount);
                                "Employer Amount" := Deductions."Percentage Employer" / 100 * (Employee."Basic Pay" + Employee."House Allowance" + Employee."Commuter Allowance" + Employee."Salary Arrears");
                                "Employer Amount" := PayrollRounding("Employer Amount");
                                // CheckIfRatesInclusive("Employee No", "Payroll Period", Code, "Employer Amount");
                            end;

                    if Type = Type::Deduction then
                        Amount := -Amount;

                    if Deductions."Calculation Method" = Deductions."Calculation Method"::"Based on Table" then begin
                        GetPayPeriod();
                        Employee.Reset();
                        Employee.SetRange("No.", "Employee No");
                        Employee.SetRange("Pay Period Filter", "Payroll Period");
                        Employee.CalcFields("Total Allowances", "Basic Pay", "Total Non-Recurring Allowances");

                        // Amount := -(GetBracket(Deductions, (Employee."Total Allowances" - Employee."Total Non-Recurring Allowances"), "Employee Tier I", "Employee Tier II"));
                        // if Deductions."Pension Scheme" then
                        // "Employer Amount" := (GetBracket(Deductions, (Employee."Total Allowances" - Employee."Total Non-Recurring Allowances"), "Employee Tier I", "Employee Tier II"));
                    end;

                    /* if Deductions."Calculation Method"=Deductions."Calculation Method"::Formula then begin
                        Employee.SetRange("Pay Period Filter","Payroll Period");
                        Formula:=PayrollMgt.GetPureFormula("Employee No","Payroll Period",Deductions.);
                        Amount:=PayrollMgt.GetResult(Formula);
                     end;
                     */
                end;

                if (Type = Type::Loan) then begin
                    LoanApp.Reset();
                    LoanApp.SetRange("Loan No", Code);
                    LoanApp.SetRange("Employee No", "Employee No");
                    if LoanApp.Find('-') then begin
                        if LoanProductType.Get("Loan Product Type") then
                            Description := LoanProductType.Description;
                        Amount := -LoanApp.Repayment;
                        Validate(Amount);

                    end;
                end;

                Validate(Amount);

            end;
        }
        field(5; "Effective Start Date"; Date)
        {
            TableRelation = "Payroll Period"."Starting Date";
            Caption = 'Effective Start Date';
        }
        field(6; "Effective End Date"; Date)
        {
            TableRelation = "Payroll Period"."Starting Date";
            Caption = 'Effective End Date';
        }
        field(7; "Payroll Period"; Date)
        {
            NotBlank = false;
            TableRelation = if ("Employee Type" = filter(Permanent | Partime | Locum)) "Payroll Period"."Starting Date";
            // else
            // if ("Employee Type" = const(Casual)) "Payroll Period Casuals"."Starting Date"
            // else
            // if ("Employee Type" = const(Trustee)) "Payroll Period Trustees"."Starting Date";
            //This property is currently not supported
            //TestTableRelation = true;
            ValidateTableRelation = true;
            Caption = 'Payroll Period';

            trigger OnValidate()
            begin

                if PayPeriod.Get("Payroll Period") then
                    "Pay Period" := PayPeriod.Name;
            end;
        }
        field(8; Amount; Decimal)
        {
            DecimalPlaces = 2 : 2;
            Caption = 'Amount';

            trigger OnValidate()
            begin
                //*********** Earnings********************//
                if (Type = Type::Earning) then
                    if Amount < 0 then
                        Error(Error005);

                //********* Deductions ***************//
                if (Type = Type::Deduction) then begin
                    /* if xRec.Amount = 0 then begin
                        if not PayrollMgt.CheckOneThirdRule(Rec, "Employee No", "Payroll Period", NetPayAmt, Abs(Amount)) then
                            Message(OneThirdError, Code, "Employee No", NetPayAmt);
                    end else begin
                        if not PayrollMgt.CheckOneThirdRule(Rec, "Employee No", "Payroll Period", NetPayAmt, Abs(Amount)) then
                            Message(OneThirdError, Code, "Employee No", NetPayAmt);
                    end; */

                    if Amount > 0 then
                        Amount := -Amount;
                    if Voluntary then
                        "Employee Voluntary" := -Amount;

                    if "Manual Entry" then
                        if Employee.Get("Employee No") then begin
                            Employee.SetRange("Pay Period Filter", "Payroll Period");
                            Employee.CalcFields("Total Allowances", "Total Deductions");

                            if ((Employee."Total Allowances" + Employee."Total Deductions") + Amount) < 0 then
                                Message(NegativePayErr, "Employee No", Employee."Total Allowances", Employee."Total Deductions", Description);

                        end;

                    if not "Manual Entry" then
                        if Employee.Get("Employee No") then begin
                            Employee.SetRange("Pay Period Filter", "Payroll Period");
                            Employee.CalcFields("Total Allowances", "Total Deductions");
                            if ((Employee."Total Allowances" + Employee."Total Deductions")) < 0 then
                                Message(NegativePayErr, "Employee No", Employee."Total Allowances", Employee."Total Deductions", Description);
                        end;
                end;
                TestField(Closed, false);
                //Added
                /*
                if "Loan Repay"=true then
                begin
                 if Loan.Get(Rec.Code,Rec."Employee No") then begin
                  Loan.CalcFields(Loan."Initial Amount");
                  "Period Repayment":=Abs(Amount)+"Interest Amount";
                  "Initial Amount":=Loan."Effective Start Date";
                  "Outstanding Amount":=Loan."Effective Start Date"-Loan."Initial Amount";
                 end;
                end;
                */
                Amount := PayrollRounding(Amount);

                /*
                if "Basic Salary Code"=true then
                  begin
                    ValidateBPay(Code);
                  end;
                */

            end;
        }
        field(9; Description; Text[150])
        {
            Caption = 'Description';

            trigger OnValidate()
            begin
                TestField(Closed, false);
            end;
        }
        field(10; Taxable; Boolean)
        {
            Caption = 'Taxable';

            trigger OnValidate()
            begin
                TestField(Closed, false);
            end;
        }
        field(11; "Tax Deductible"; Boolean)
        {
            Caption = 'Tax Deductible';

            trigger OnValidate()
            begin
                TestField(Closed, false);
            end;
        }
        field(12; Frequency; Option)
        {
            OptionMembers = Recurring,"Non-recurring";
            Caption = 'Frequency';

            trigger OnValidate()
            begin

                if Frequency = Frequency::Recurring then
                    "Next Period Entry" := true
                else
                    "Next Period Entry" := false;
                Modify();
            end;
        }
        field(13; "Pay Period"; Text[30])
        {
            Caption = 'Pay Period';
        }
        field(14; "G/L Account"; Code[20])
        {
            TableRelation = "G/L Account";
            Caption = 'G/L Account';
        }
        field(15; "Basic Pay"; Decimal)
        {
            Caption = 'Basic Pay';
        }
        field(16; "Employer Amount"; Decimal)
        {
            DecimalPlaces = 2 : 2;
            Caption = 'Employer Amount';

            trigger OnValidate()
            begin
                TestField(Closed, false);
            end;
        }
        field(17; "Department Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
            Caption = 'Department Code';
        }
        field(18; "Next Period Entry"; Boolean)
        {
            Caption = 'Next Period Entry';
        }
        field(19; "Posting Group Filter"; Code[20])
        {
            // TableRelation = "Employee HR Posting Group";
            Caption = 'Posting Group Filter';

            trigger OnValidate()
            begin
                TestField(Closed, false);
            end;
        }
        field(20; "Initial Amount"; Decimal)
        {
            Caption = 'Initial Amount';
        }
        field(21; "Outstanding Amount"; Decimal)
        {
            Caption = 'Outstanding Amount';
        }
        field(22; "Loan Repay"; Boolean)
        {
            Caption = 'Loan Repay';

            trigger OnValidate()
            begin
                TestField(Closed, false);
            end;
        }
        field(23; Closed; Boolean)
        {
            Editable = true;
            Caption = 'Closed';
        }
        field(24; "Salary Grade"; Code[20])
        {
            Caption = 'Salary Grade';
        }
        field(25; "Tax Relief"; Boolean)
        {
            Caption = 'Tax Relief';
        }
        field(26; "Interest Amount"; Decimal)
        {
            Caption = 'Interest Amount';

            trigger OnValidate()
            begin
                TestField(Closed, false);
            end;
        }
        field(27; "Period Repayment"; Decimal)
        {
            Caption = 'Period Repayment';

            trigger OnValidate()
            begin
                TestField(Closed, false);
            end;
        }
        field(28; "Non-Cash Benefit"; Boolean)
        {
            Caption = 'Non-Cash Benefit';

            trigger OnValidate()
            begin
                TestField(Closed, false);
            end;
        }
        field(29; Quarters; Boolean)
        {
            Caption = 'Quarters';
        }
        field(30; "No. of Units"; Decimal)
        {
            Caption = 'No. of Units';

            trigger OnValidate()
            begin
                /*
                   HRSetup.Get();
                if Type=Type::Payment then begin
                if Payments.Get(Code) then
                begin
                if Payments."Calculation Method"=Payments."Calculation Method"::"% of Basic after tax" then begin
                if Empl.Get("Employee No") then
                if HRSetup."Company overtime hours"<>0 then
                Amount:=(Empl."Hourly Rate" *"No. of Units"* Payments."Overtime Factor");///HRSetup."Company overtime hours"
                end;

                if Payments."Calculation Method"=Payments."Calculation Method"::"Based on Hourly Rate" then begin
                if Empl.Get("Employee No") then
                Amount:="No. of Units"* Empl."Daily Rate";
                if Payments."Overtime Factor"<>0 then
                Amount:="No. of Units"* Empl."Daily Rate" *Payments."Overtime Factor"

                end;

                if Payments."Calculation Method"=Payments."Calculation Method"::"Flat amount" then begin
                if Empl.Get("Employee No") then
                Amount:="No. of Units"*Payments."Total Amount";
                end;


              end;
              end;

             //*****Deductions
                if Type=Type::Deduction then begin
                if Deductions.Get(Code) then
                begin
                if Deductions."Calculation Method"=Deductions."Calculation Method"::"Based on Hourly Rate" then begin
                if Empl.Get("Employee No") then
                Amount:=-"No. of Units"* Empl."Hourly Rate"
                end;

                if Deductions."Calculation Method"=Deductions."Calculation Method"::"Based on Daily Rate " then begin
                if Empl.Get("Employee No") then
                Amount:=-"No. of Units"* Empl."Daily Rate"
                end;

                if Deductions."Calculation Method"=Deductions."Calculation Method"::"Flat Amount" then begin
                if Empl.Get("Employee No") then
                Amount:=-"No. of Units"*Deductions."Flat Amount";
                end;

              end;
              end;
              TestField(Closed,false);
             */

            end;
        }
        field(31; Section; Code[20])
        {
            Caption = 'Section';
        }
        field(33; Retirement; Boolean)
        {
            Caption = 'Retirement';

            trigger OnValidate()
            begin
                TestField(Closed, false);
            end;
        }
        field(34; CFPay; Boolean)
        {
            Caption = 'CFPay';

            trigger OnValidate()
            begin
                TestField(Closed, false);
            end;
        }
        field(35; BFPay; Boolean)
        {
            Caption = 'BFPay';

            trigger OnValidate()
            begin
                TestField(Closed, false);
            end;
        }
        field(36; "Opening Balance"; Decimal)
        {
            Caption = 'Opening Balance';

            trigger OnValidate()
            begin

                if (Type = Type::Deduction) then
                    if "Opening Balance" > 0 then
                        "Opening Balance" := -"Opening Balance";
                TestField(Closed, false);
            end;
        }
        field(37; DebitAcct; Code[20])
        {
            Caption = 'DebitAcct';
        }
        field(38; CreditAcct; Code[20])
        {
            Caption = 'CreditAcct';
        }
        field(39; Shares; Boolean)
        {
            Caption = 'Shares';
        }
        field(40; "Show on Report"; Boolean)
        {
            Caption = 'Show on Report';
        }
        field(41; "Earning/Deduction Type"; Option)
        {
            OptionMembers = Recurring,"Non-recurring";
            Caption = 'Earning/Deduction Type';
        }
        field(42; "Time Sheet"; Boolean)
        {
            Caption = 'Time Sheet';
        }
        field(43; "Basic Salary Code"; Boolean)
        {
            Caption = 'Basic Salary Code';
        }
        field(44; "Payroll Group"; Code[30])
        {
            TableRelation = Company;
            Caption = 'Payroll Group';
        }
        field(45; Paye; Boolean)
        {
            Caption = 'Paye';
        }
        field(46; "Taxable amount"; Decimal)
        {
            Caption = 'Taxable amount';
        }
        field(47; "Less Pension Contribution"; Decimal)
        {
            Caption = 'Less Pension Contribution';
        }
        field(48; "Monthly Personal Relief"; Decimal)
        {
            Caption = 'Monthly Personal Relief';
        }
        field(49; "Normal Earnings"; Boolean)
        {
            Editable = false;
            Caption = 'Normal Earnings';
        }
        field(50; "Mortgage Relief"; Decimal)
        {
            Caption = 'Mortgage Relief';
        }
        field(51; "Monthly Self Cummulative"; Decimal)
        {
            Caption = 'Monthly Self Cummulative';
        }
        field(52; "Company Monthly Contribution"; Decimal)
        {
            Caption = 'Company Monthly Contribution';
        }
        field(53; "Company Cummulative"; Decimal)
        {
            Caption = 'Company Cummulative';
        }
        field(54; "Main Deduction Code"; Code[20])
        {
            Caption = 'Main Deduction Code';
        }
        field(55; "Opening Balance Company"; Decimal)
        {
            Caption = 'Opening Balance Company';
        }
        field(56; "Insurance Code"; Boolean)
        {
            Caption = 'Insurance Code';
        }
        field(57; "Reference No"; Code[50])
        {
            Caption = 'Reference No';
        }
        field(58; "Manual Entry"; Boolean)
        {
            Caption = 'Manual Entry';
        }
        field(59; "Salary Pointer"; Code[20])
        {
            Caption = 'Salary Pointer';
        }
        field(60; "Employee Voluntary"; Decimal)
        {
            Caption = 'Employee Voluntary';

            trigger OnValidate()
            begin
                //Amount:=-(ABS(Amount)+"Employee Voluntary");
            end;
        }
        field(61; "Employer Voluntary"; Decimal)
        {
            Caption = 'Employer Voluntary';
        }
        field(62; "Loan Product Type"; Code[20])
        {
            TableRelation = if ("Loan Type" = const(Staff)) "Loan Product Type-Payroll".Code;
            Caption = 'Loan Product Type';
        }
        field(63; "June Paye"; Decimal)
        {
            Caption = 'June Paye';
        }
        field(64; "June Taxable Amount"; Decimal)
        {
            Caption = 'June Taxable Amount';
        }
        field(65; "June Paye Diff"; Decimal)
        {
            Caption = 'June Paye Diff';
        }
        field(66; "Gratuity PAYE"; Decimal)
        {
            Caption = 'Gratuity PAYE';

            trigger OnValidate()
            begin
                if Paye = true then
                    Modify();
            end;
        }
        field(67; "Basic Pay Arrears"; Boolean)
        {
            Caption = 'Basic Pay Arrears';
        }
        field(68; Voluntary; Boolean)
        {
            Caption = 'Voluntary';
        }
        field(69; "Loan Interest"; Decimal)
        {
            Caption = 'Loan Interest';

            trigger OnValidate()
            begin

                if (Type = Type::Deduction) then
                    if "Loan Interest" > 0 then
                        "Loan Interest" := -"Loan Interest";
            end;
        }
        field(70; "Top Up Share"; Decimal)
        {
            Caption = 'Top Up Share';
        }
        field(71; "Insurance No"; Code[20])
        {
            Caption = 'Insurance No';
        }
        field(72; "Employee Tier I"; Decimal)
        {
            Caption = 'Employee Tier I';
        }
        field(73; "Employee Tier II"; Decimal)
        {
            Caption = 'Employee Tier II';
        }
        field(74; "Employer Tier I"; Decimal)
        {
            Caption = 'Employer Tier I';
        }
        field(75; "Employer Tier II"; Decimal)
        {
            Caption = 'Employer Tier II';
        }
        field(76; "House Allowance Code"; Boolean)
        {
            Caption = 'House Allowance Code';
        }
        field(77; "Pay Mode"; Code[20])
        {
            // TableRelation = "Employee Pay Modes";
            Caption = 'Pay Mode';
        }
        field(78; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(79; "No of Days"; Integer)
        {
            Caption = 'No of Days';
        }
        field(80; Prorated; Boolean)
        {
            Caption = 'Prorated';
        }
        field(81; "House No."; Code[20])
        {
            Caption = 'House No.';
        }
        field(82; "Reason For Chage"; Text[250])
        {
            Caption = 'Reason For Chage';
        }
        field(83; "Employee Type"; Option)
        {
            OptionCaption = 'Permanent,Partime,Locum,Casual,Contract,Trustee';
            OptionMembers = Permanent,Partime,Locum,Casual,Contract,Trustee;
            Caption = 'Employee Type';
        }
        field(84; Tenure; DateFormula)
        {
            Caption = 'Tenure';

            trigger OnValidate()
            begin
                if Format(Tenure) <> '' then begin
                    "Effective End Date" := CalcDate(Tenure, "Effective Start Date");
                    "Effective End Date" := CalcDate('-1M', "Effective End Date");
                end;
            end;
        }
        field(85; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
            Caption = 'Global Dimension 1 Code';

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Global Dimension 1 Code");
            end;
        }
        field(86; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
            Caption = 'Global Dimension 2 Code';

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Global Dimension 2 Code");
            end;
        }
        field(87; "Area"; Code[80])
        {
            Caption = 'Area';
        }
        field(88; "Commuter Allowance Code"; Boolean)
        {
            Caption = 'Commuter Allowance Code';
        }
        field(89; "Salary Arrears Code"; Boolean)
        {
            Caption = 'Salary Arrears Code';
        }
        field(90; "Sacco Deduction"; Boolean)
        {
            Caption = 'Sacco Deduction';
        }
        field(91; "Ext Insurance Amount"; Decimal)
        {
            Caption = 'Ext Insurance Amount';

            trigger OnValidate()
            begin
                if "Ext Insurance Amount" <> 0 then
                    Validate(Code);
            end;
        }
        field(92; "Secondary PAYE"; Boolean)
        {
            Caption = 'Secondary PAYE';
        }
        field(93; Imprest; Boolean)
        {
            Caption = 'Imprest';
        }
        field(94; Gratuity; Boolean)
        {
            Caption = 'Gratuity';
        }
        field(96; "Mortgage Interest"; Decimal)
        {
            Caption = 'Mortgage Interest';
        }
        field(97; "Loan Type"; Option)
        {
            Caption = 'Loan Type';
            OptionCaption = 'Staff,Sacco';
            OptionMembers = "Staff","Sacco";
        }
        field(98; "Loan No."; Code[50])
        {
            Caption = 'Loan No.';
            TableRelation = if ("Loan Type" = const(Staff)) "Payroll Loan Application"."Loan No" where("Employee No" = field("Employee No"), Posted = const(true));
        }
        field(102; NHIF; Boolean)
        {
            Caption = 'NHIF';
        }
        field(103; "Exclude Gross Pay Deduction"; Boolean)
        {
            Caption = 'Exclude Gross Pay Deduction';
        }
        field(104; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            tableRelation = Currency.Code;

            trigger OnValidate()
            begin
                Validate(Amount);
            end;
        }
        field(105; "Amount (FCY)"; Decimal)
        {
            Caption = 'Amount (FCY)';

            trigger OnValidate()
            begin
                if "Amount (FCY)" <> 0 then
                    //Convert FCY to LCY
                    if "Currency Code" = '' then
                        Amount := "Amount (FCY)"
                    else
                        if CurrencyRec.Get("Currency Code") then
                            Amount :=
                              CurrencyExchangeRate.ExchangeAmtFCYToLCY(
                                Today(), "Currency Code",
                                "Amount (FCY)", CurrencyExchangeRate.ExchangeRate(Today(), "Currency Code"));
            end;
        }
        field(106; "Housing Levy"; Boolean)
        {
            Caption = 'Housing Levy';
        }
        field(107; SHIF; Boolean)
        {
            Caption = 'SHIF';
        }
    }

    keys
    {
        key(Key1; "Employee No", Type, "Code", "Payroll Period", "Reference No")
        {
            Clustered = true;
            SumIndexFields = "Employer Amount", "Interest Amount", "Period Repayment", "No. of Units", "Opening Balance", Amount;
        }
        key(Key2; "Employee No", Taxable, "Tax Deductible", Retirement, "Non-Cash Benefit", "Tax Relief")
        {
            SumIndexFields = "Employer Amount", "Interest Amount", "Period Repayment", "No. of Units", "Opening Balance", Amount;
        }
        key(Key3; Type, "Code", "Posting Group Filter")
        {
            SumIndexFields = "Employer Amount", "Interest Amount", "Period Repayment", "No. of Units", "Opening Balance", Amount;
        }
        key(Key4; "Non-Cash Benefit")
        {
            SumIndexFields = "Employer Amount", "Interest Amount", "Period Repayment", "No. of Units", "Opening Balance", Amount;
        }
        key(Key5; Type, "Pay Mode")
        {
            SumIndexFields = "Employer Amount", "Interest Amount", "Period Repayment", "No. of Units", "Opening Balance", Amount;
        }
        key(Key6; "Non-Cash Benefit", Taxable)
        {
            SumIndexFields = "Employer Amount", "Interest Amount", "Period Repayment", "No. of Units", "Opening Balance", Amount;
        }
        key(Key7; Type, Retirement)
        {
            SumIndexFields = "Employer Amount", "Interest Amount", "Period Repayment", "No. of Units", "Opening Balance", Amount;
        }
        key(Key8; "Department Code", "Payroll Period", "Code")
        {
            SumIndexFields = "Employer Amount", "Interest Amount", "Period Repayment", "No. of Units", "Opening Balance", Amount;
        }
        key(Key9; "Employee No", Shares)
        {
            SumIndexFields = "Employer Amount", "Interest Amount", "Period Repayment", "No. of Units", "Opening Balance", Amount;
        }
        key(Key10; Closed, "Code", Type, "Employee No")
        {
            SumIndexFields = "Employer Amount", "Interest Amount", "Period Repayment", "No. of Units", "Opening Balance", Amount;
        }
        key(Key11; "Show on Report")
        {
            SumIndexFields = "Employer Amount", "Interest Amount", "Period Repayment", "No. of Units", "Opening Balance", Amount;
        }
        key(Key12; "Employee No", "Code", "Payroll Period", "Next Period Entry")
        {
            SumIndexFields = "Employer Amount", "Interest Amount", "Period Repayment", "No. of Units", "Opening Balance", Amount;
        }
        key(Key13; "Opening Balance")
        {
        }
        key(Key14; "Department Code", "Payroll Period", Type, "Code")
        {
            SumIndexFields = "Employer Amount", "Interest Amount", "Period Repayment", "No. of Units", "Opening Balance", Amount;
        }
        key(Key15; "Basic Salary Code", "Basic Pay Arrears")
        {
            SumIndexFields = "Employer Amount", "Interest Amount", "Period Repayment", "No. of Units", "Opening Balance", Amount;
        }
        key(Key16; Paye)
        {
            SumIndexFields = "Employer Amount", "Interest Amount", "Period Repayment", "No. of Units", "Opening Balance", Amount, "Taxable amount";
        }
        key(Key17; "Employee No", "Payroll Period", Type, "Non-Cash Benefit", "Normal Earnings")
        {
            SumIndexFields = "Employer Amount", "Interest Amount", "No. of Units", "Opening Balance", Amount, "Taxable amount";
        }
        key(Key18; "Posting Group Filter")
        {
            SumIndexFields = "Employer Amount", "Interest Amount", "Period Repayment", "No. of Units", "Opening Balance", Amount, "Taxable amount";
        }
        key(Key19; "Payroll Period", Type, "Code")
        {
            SumIndexFields = Amount, "Loan Interest", "Top Up Share";
        }
        key(Key20; Type, "Employee No", "Payroll Period", "Insurance Code")
        {
            SumIndexFields = Amount;
        }
        key(Key21; "Employee No", Type, "Code", "Payroll Period", "Posting Group Filter", "Department Code", "Payroll Group")
        {
            SumIndexFields = Amount, "Loan Interest", "Employer Amount";
        }
        key(Key22; "House Allowance Code")
        {
            SumIndexFields = Amount;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        TestField(Closed, false);
    end;

    trigger OnModify()
    begin
        TestField(Closed, false);
    end;

    trigger OnRename()
    begin
        TestField(Closed, false);
    end;

    var
        AssgnMatrix: Record "Assignment Matrix";
        CurrencyRec: Record Currency;
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        Deductions: Record Deductions;
        Payments: Record Earnings;
        Employee: Record "Employee";
        EmpContract: Record "Employment Contract";
        HRSetup: Record "Human Resources Setup";
        LoanProductType: Record "Loan Product Type-Payroll";
        // OtherDeductions: Record "Other Deductions";
        // OtherEarnings: Record "Other Earnings";
        // OtherDeductionLines: Record "Other Deduction Line";
        LoanApp: Record "Payroll Loan Application";
        PayPeriod: Record "Payroll Period";
        // TrusteePayPeriod: Record "Payroll Period Trustees";
        SalaryScale: Record "Salary Scale";
        SalaryScaleAllowance: Record "Salary Scale Allowance";
        DimMgt: Codeunit DimensionManagement;
        HRManagement: Codeunit "HR Management";
        // PayrollMgt: Codeunit Payroll;
        PayStartDate: Date;
        InterestDiff: Decimal;
        TotalOtherDeductions: Decimal;
        TotalOtherEarnings: Decimal;
        TotalDeductionLines: Decimal;
        Error002: Label 'Earning %1 %2 is Blocked';
        Error003: Label 'Deduction %1 %2 is Blocked';
        Error005: Label 'Earning must not be negative';
        NegativePayErr: Label 'Assigning %4 deduction for Employee %1 will result in a negative pay, Total allowances=%2 Total deductions=%3';
        PayPeriodText: Text[30];


    procedure CreateLIBenefit(var Employee: Code[10]; var BenefitCode: Code[10]; var ReducedBalance: Decimal)
    var
        PaymentDeduction: Record "Assignment Matrix";
        allowances: Record Earnings;
    begin
        PaymentDeduction.Init();
        PaymentDeduction."Employee No" := Employee;
        PaymentDeduction.Code := BenefitCode;
        PaymentDeduction.Type := PaymentDeduction.Type::Earning;
        PaymentDeduction."Payroll Period" := PayStartDate;
        PaymentDeduction.Amount := ReducedBalance * InterestDiff;
        PaymentDeduction."Non-Cash Benefit" := true;
        PaymentDeduction.Taxable := true;
        //PaymentDeduction."Next Period Entry":=TRUE;
        if allowances.Get(BenefitCode) then
            PaymentDeduction.Description := allowances.Description;
        PaymentDeduction.Insert();
    end;

    procedure GetEmployee()
    begin
        if Employee.Get("Employee No") then;
    end;

    procedure GetPayPeriod()
    begin
        case "Employee Type" of
            "Employee Type"::Trustee:
                begin
                    // TrusteePayPeriod.SetRange("Close Pay", false);
                    // if TrusteePayPeriod.FindFirst() then begin
                    //     PayStartDate := TrusteePayPeriod."Starting Date";
                    //     PayPeriodText := TrusteePayPeriod.Name;
                    // end;
                end;
            else begin
                PayPeriod.SetRange("Close Pay", false);
                if PayPeriod.Find('-') then begin
                    PayStartDate := PayPeriod."Starting Date";
                    PayPeriodText := PayPeriod.Name;
                end;
            end;
        end;
    end;

    procedure GetSetup()
    begin
        HRSetup.Get();
    end;

    procedure PayrollRounding(var Amount: Decimal) PayrollRounding: Decimal
    var
        HRsetup: Record "Human Resources Setup";
    begin

        HRsetup.Get();
        if HRsetup."Payroll Rounding Precision" = 0 then
            Error('You must specify the rounding precision under HR setup');

        case HRsetup."Payroll Rounding Type" of
            HRsetup."Payroll Rounding Type"::Nearest:
                PayrollRounding := Round(Amount, HRsetup."Payroll Rounding Precision", '=');
            HRsetup."Payroll Rounding Type"::Up:
                PayrollRounding := Round(Amount, HRsetup."Payroll Rounding Precision", '>');
            HRsetup."Payroll Rounding Type"::Down:
                PayrollRounding := Round(Amount, HRsetup."Payroll Rounding Precision", '<');
        end;

        //Convert FCY to LCY
        if "Currency Code" = '' then
            Amount := "Amount (FCY)"
        else
            if CurrencyRec.Get("Currency Code") then
                Amount :=
                  CurrencyExchangeRate.ExchangeAmtFCYToLCY(
                    Today(), "Currency Code",
                    "Amount (FCY)", CurrencyExchangeRate.ExchangeRate(Today(), "Currency Code"));
    end;

    procedure ValidateBPay(EDCode: Code[20])
    var
        Deds: Record Deductions;
        Earns: Record Earnings;
    begin
        begin
            Earns.Reset();
            Earns.SetRange("Calculation Method", Earns."Calculation Method"::"% of Basic pay");
            if Earns.Find('-') then
                repeat
                    //Assign.VALIDATE(Code);
                    Validate(Code);
                until Earns.Next() = 0;

            Deds.Reset();
            Deds.SetRange("Calculation Method", Deds."Calculation Method"::"% of Basic Pay");
            if Deds.Find('-') then
                repeat
                    //Assign.VALIDATE(Code);
                    Validate(Code);
                until Deds.Next() = 0;
        end;
    end;

    local procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        //DimMgt.SaveDefaultDim(DATABASE::Employee,"No.",FieldNumber,ShortcutDimCode);
        Modify();
    end;
}





