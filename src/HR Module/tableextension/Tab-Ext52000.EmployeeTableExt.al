tableextension 52000 "EmployeeTableExt" extends Employee
{
    fields
    {
        modify("Birth Date")
        {
            trigger OnAfterValidate()
            var
                DOBForm: DateFormula;
                DateofBirthError: Label 'This date cannot be greater than today.';
                MinimumAgeError: Label 'Date of birth must not be less than %1';
            begin
                if "Birth Date" <> 0D then begin
                    HumanResSetup.Get();
                    HumanResSetup.TestField("Retirement Age");
                    HumanResSetup.TestField("Minimum Employee Age");

                    //Validate minimum & maximum age
                    if "Birth Date" > Today then
                        Error(DateofBirthError);

                    Evaluate(DOBForm, Format(HumanResSetup."Minimum Employee Age") + 'Y');

                    if CalcDate(DOBForm, "Birth Date") > Today then
                        Error(MinimumAgeError, HumanResSetup."Minimum Employee Age");

                    //Validate Retirement Age
                    Evaluate(dateform, Format(HumanResSetup."Retirement Age") + 'Y');
                    "Retirement Date" := CalcDate(dateform, "Birth Date");
                    if "Employee Type" <> "Employee Type"::"Board Member" then;
                    /* if "Retirement Date" <= Today then
Error(EmployeeRetiredErr); */

                    "Date of Birth - Age" := HRDates.DetermineAge("Birth Date", Today);
                end;
            end;
        }
        modify("Social Security No.")
        {
            Caption = 'NSSF No.';
        }
        modify(Status)
        {
            trigger OnAfterValidate()
            begin
                if Status = Status::Inactive then
                    Message('Kindly specify Cause For Inactivity');
            end;
        }
        modify("No.")
        {
            trigger OnAfterValidate()
            begin
                if "Employee Type" = "Employee Type"::"Board Member" then begin
                    if "No." <> xRec."No." then begin
                        HumanResSetup.Get();
                        // NoSeriesMgt.TestManual(HumanResSetup."Trustee Nos");
                        "No. Series" := '';
                    end;
                end;
            end;
        }
        field(52000; "Date of Birth - Age"; Text[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
            Caption = 'Date of Birth - Age';
        }
        field(52001; "Nature of Employment"; Text[50])
        {
            DataClassification = CustomerContent;
            TableRelation = "Employment Contract".Code;
            Caption = 'Nature of Employment';

            trigger OnValidate()
            begin
                if EmpContract.Get("Nature of Employment") then
                    "Employee Type" := EmpContract."Employee Type"
            end;
        }
        field(52002; "Contract Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Start Date';

            trigger OnValidate()
            begin

                ContractPeriod := CalcDate("Contract Length", "Contract Start Date") - 1;
                "Contract End Date" := ContractPeriod;
            end;
        }
        field(52003; "Contract End Date"; Date)
        {
            DataClassification = CustomerContent;
            //Editable = false;
            Caption = 'Contract End Date';
        }
        field(52004; "Employment Date - Age"; Text[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
            Caption = 'Employment Date - Age';
        }
        field(52005; "First Language"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'First Language';
        }
        field(52006; "Second Language"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Second Language';
        }
        field(52007; "First Language Read"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'First Language Read';
        }
        field(52008; "First Language Write"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'First Language Write';
        }
        field(52009; "First Language Speak"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'First Language Speak';
        }
        field(52010; "Second Language Read"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Second Language Read';
        }
        field(52011; "Second Language Write"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Second Language Write';
        }
        field(52012; "Second Language Speak"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Second Language Speak';
        }
        field(52013; "Other Language"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Other Language';
        }
        field(52014; "Job Position"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Company Job";
            Caption = 'Job Position';

            trigger OnValidate()
            begin
                if Jobs.Get("Job Position") then
                    "Job Position Title" := Jobs."Job Description";
            end;
        }
        field(52015; "Job Position Title"; Text[250])
        {
            Caption = 'Job Position Title';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Company Job"."Job Description" where("Job ID" = field("Job Position")));
        }
        field(52016; "Leave Period Filter"; Code[20])
        {
            TableRelation = "Leave Period"."Leave Period Code";
            Caption = 'Leave Period Filter';
            FieldClass = FlowFilter;
        }
        field(52017; "Leave Type Filter"; Code[20])
        {
            Caption = 'Leave Type Filter';
            TableRelation = "Leave Type".Code;
            FieldClass = FlowFilter;
        }
        field(52018; Signature; MediaSet)
        {
            DataClassification = CustomerContent;
            Caption = 'Signature';
        }
        field(52019; Disabled; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = ' ,No,Yes';
            OptionMembers = " ",No,Yes;
            Caption = 'Disabled';
        }
        field(52021; "Pays NSSF?"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Pays NSSF?';
        }
        field(52022; "Pays tax?"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Pays tax?';
        }
        field(52023; "Basic Pay"; Decimal)
        {
            CalcFormula = sum("Assignment Matrix".Amount where(Type = const(Earning),
                                                                  "Employee No" = field("No."),
                                                                  "Payroll Period" = field("Pay Period Filter"),
                                                                  "Basic Salary Code" = const(true)));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Total Accumulated Basic Pay';
        }
        field(52024; "Employee Nature"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Employee Nature';
        }
        field(52025; "Position TO Succeed"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Position TO Succeed';
        }
        field(52026; "Total Allowances"; Decimal)
        {
            CalcFormula = sum("Assignment Matrix".Amount where(Type = const(Earning),
                                                                  "Employee No" = field("No."),
                                                                  "Payroll Period" = field("Pay Period Filter"),
                                                                  "Non-Cash Benefit" = const(false),
                                                                  Gratuity = const(false),
                                                                  "Normal Earnings" = const(true),
                                                                  "Insurance Code" = filter(false)));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Total Accumulated Earnings';
        }
        field(52027; "Taxable Allowance"; Decimal)
        {
            CalcFormula = sum("Assignment Matrix".Amount where(Taxable = const(true),
                                                                  "Employee No" = field("No."),
                                                                  "Payroll Period" = field("Pay Period Filter")));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Total Accumulated Taxable Allowance';
        }
        field(52028; "Total Deductions"; Decimal)
        {
            CalcFormula = sum("Assignment Matrix".Amount where(Type = filter(Deduction | Loan),
                                                                  "Employee No" = field("No."),
                                                                  "Payroll Period" = field("Pay Period Filter")));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Total Accumulated Deductions';
        }
        field(52029; "Employee's Bank"; Code[1000])
        {
            DataClassification = CustomerContent;
            TableRelation = Banks.Code;
            Caption = 'Employee''s Bank';

            trigger OnValidate()
            begin
                if Banks.Get("Employee's Bank") then
                    "Employee Bank Name" := Banks."Bank Name";
            end;
        }
        field(52030; "Bank Branch"; Code[1000])
        {
            DataClassification = CustomerContent;
            TableRelation = "Bank Branch"."Branch No" where("Bank No" = field("Employee's Bank"));
            Caption = 'Bank Branch';

            trigger OnValidate()
            begin
                if Branches.Get("Employee's Bank", "Bank Branch") then
                    "Employee Branch Name" := Branches."Branch Name";

                "Employee Bank Sort Code" := "Employee's Bank" + "Bank Branch";
            end;
        }
        field(52031; "Bank Account Number"; Code[1000])
        {
            DataClassification = CustomerContent;
            Caption = 'Bank Account Number';

            trigger OnValidate()
            begin

            end;
        }
        field(52032; "Posting Group"; Code[10])
        {
            DataClassification = CustomerContent;
            NotBlank = true;
            // TableRelation = "Employee HR Posting Group";
            Caption = 'Posting Group';

            trigger OnValidate()
            begin


            end;
        }
        field(52033; "Salary Scale"; Code[30])
        {
            DataClassification = CustomerContent;
            TableRelation = "Salary Scale".Scale;
            Caption = 'Salary Grade';

            trigger OnValidate()
            begin
                TestField("Date Of Join");

                if Scale.Get("Salary Scale") then
                    Halt := Scale."Maximum Pointer";

                "Previous Salary Scale" := xrec."Salary Scale";
            end;
        }
        field(52034; "Tax Deductible Amount"; Decimal)
        {
            CalcFormula = sum("Assignment Matrix".Amount where("Tax Deductible" = const(true),
                                                                  "Employee No" = field("No."),
                                                                  "Payroll Period" = field("Pay Period Filter"),
                                                                  "Non-Cash Benefit" = const(false)));
            FieldClass = FlowField;
            Caption = 'Tax Deductible Amount';
        }
        field(52035; "Pay Period Filter"; Date)
        {
            FieldClass = FlowFilter;
            TableRelation = if ("Employee Type" = filter(Permanent | Partime | Locum)) "Payroll Period";
            // else
            // if ("Employee Type" = filter(Casual)) "Payroll Period Casuals"
            // else
            // if ("Employee Type" = filter("Board Member")) "Payroll Period Trustees";
            Caption = 'Pay Period Filter';
        }
        field(52036; "SSF Employer to Date"; Decimal)
        {
            CalcFormula = sum("Assignment Matrix"."Employer Amount" where("Tax Deductible" = const(true),
                                                                             "Employee No" = field("No."),
                                                                             "Payroll Period" = field("Pay Period Filter")));
            FieldClass = FlowField;
            Caption = 'NSSF Employer to Date';
        }
        field(52037; "PIN Number"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'KRA PIN Number';
        }
        field(52038; "Cumm. PAYE"; Decimal)
        {
            CalcFormula = sum("Assignment Matrix".Amount where("Employee No" = field("No."),
                                                                  "Payroll Period" = field("Pay Period Filter"),
                                                                  Paye = const(true)));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Total Accumulated PAYE';
        }
        field(52039; "NHIF No"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'NHIF No';
        }
        field(52040; "Benefits-Non Cash"; Decimal)
        {
            CalcFormula = sum("Assignment Matrix".Amount where("Employee No" = field("No."),
                                                                  "Payroll Period" = field("Pay Period Filter"),
                                                                  "Non-Cash Benefit" = const(true),
                                                                  Type = const(Earning),
                                                                  Taxable = const(true)));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Benefits-Non Cash';
        }
        field(52041; "Pay Mode"; Code[20])
        {
            DataClassification = CustomerContent;
            // TableRelation = "Employee Pay Modes";
            Caption = 'Pay Mode';
        }
        field(52042; "Home Savings"; Decimal)
        {
            CalcFormula = sum("Assignment Matrix".Amount where("Employee No" = field("No."),
                                                                  "Payroll Period" = field("Pay Period Filter"),
                                                                  Type = const(Deduction),
                                                                  "Tax Deductible" = const(true),
                                                                  Retirement = const(false)));
            FieldClass = FlowField;
            Caption = 'Home Savings';
        }
        field(52043; "Retirement Contribution"; Decimal)
        {
            CalcFormula = sum("Assignment Matrix".Amount where("Employee No" = field("No."),
                                                                  "Payroll Period" = field("Pay Period Filter"),
                                                                  "Tax Deductible" = const(true),
                                                                  Retirement = const(true)));
            FieldClass = FlowField;
            Caption = 'Retirement Contribution';
        }
        field(52044; "Owner Occupier"; Decimal)
        {
            CalcFormula = sum("Assignment Matrix".Amount where("Employee No" = field("No."),
                                                                  "Payroll Period" = field("Pay Period Filter"),
                                                                  Type = const(Earning),
                                                                  "Tax Deductible" = const(true)));
            FieldClass = FlowField;
            Caption = 'Owner Occupier';
        }
        field(52045; "Total Savings"; Decimal)
        {
            CalcFormula = sum("Assignment Matrix".Amount where("Employee No" = field("No."),
                                                                  //   Type = const("Saving Scheme"),
                                                                  "Payroll Period" = field("Pay Period Filter")));
            FieldClass = FlowField;
            Caption = 'Total Savings';
        }
        field(52046; PensionNo; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'PensionNo';
        }
        field(52047; "Share Amount"; Decimal)
        {
            CalcFormula = sum("Assignment Matrix".Amount where("Employee No" = field("No."),
                                                                  Shares = const(true)));
            Caption = 'coop skg fund';
            FieldClass = FlowField;
        }
        field(52048; "Other deductions"; Decimal)
        {
            CalcFormula = sum("Assignment Matrix".Amount where("Employee No" = field("No."),
                                                                  "Payroll Period" = field("Pay Period Filter"),
                                                                  Paye = const(false)));
            FieldClass = FlowField;
            Caption = 'Other deductions';
        }
        field(52049; Interest; Decimal)
        {
            CalcFormula = sum("Assignment Matrix"."Interest Amount" where("Employee No" = field("No."),
                                                                             "Payroll Period" = field("Pay Period Filter"),
                                                                             Type = filter(Deduction)));
            FieldClass = FlowField;
            Caption = 'Interest';
        }
        field(52050; "Taxable Income"; Decimal)
        {
            CalcFormula = sum("Assignment Matrix".Amount where("Employee No" = field("No."),
                                                                  "Payroll Period" = field("Pay Period Filter"),
                                                                  Taxable = const(true)));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Taxable Income';
        }
        field(52051; "ID No."; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'ID No.';
            trigger OnValidate()
            begin
                if (strlen("ID No.") < 7) or (strlen("ID No.") > 10) then
                    Error('ID Number can not be less than 7 and more than 10 characters');
            end;
        }
        field(52052; Position; Code[30])
        {
            DataClassification = CustomerContent;
            TableRelation = "Company Job";
            Caption = 'Position';

            trigger OnValidate()
            begin

                if Jobs.Get(Position) then
                    "Job Title" := Jobs."Job Description";

                if ((xRec.Position <> '') and (Position <> xRec.Position)) then begin
                    Jobs.Reset();
                    Jobs.SetRange(Jobs."Job ID", Position);
                    if Jobs.Find('-') then
                        "Job Title" := Jobs."Job Description";

                end;

            end;
        }
        field(52053; "Full / Part Time"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Full Time, Part Time';
            OptionMembers = "Full Time"," Part Time";
            Caption = 'Full / Part Time';
        }
        field(52054; "Contract Type"; Code[30])
        {
            DataClassification = CustomerContent;
            TableRelation = "Employment Contract".Code;
            Caption = 'Contract Type';

            trigger OnValidate()
            begin
                /*
                if "Contract Type"="Contract Type"::"Long-Term" then
                  "Contract Length"> '6M' else
                  Error('The Period is too short for the Contract Type');
                
                if "Contract Type"="Contract Type"::"Short-Term" then
                  "Contract Length"<'7M' else
                  Error('The Period is Longer than the Contract Type');
                */

            end;
        }
        field(52055; "Type of Contract"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Employment Contract";
            Caption = 'Type of Contract';

            trigger OnValidate()
            begin

                if EmpContract.Get("Type of Contract") then
                    "Contract Length" := EmpContract.Tenure;
            end;
        }
        field(52056; "Notice Period"; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Notice Period';
        }
        field(52057; "Marital Status"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = ' ,Single,Married,Separated,Divorced,Widow(er),Other';
            OptionMembers = " ",Single,Married,Separated,Divorced,"Widow(er)",Other;
            Caption = 'Marital Status';
        }
        field(52058; "Ethnic Origin"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'African,Indian,White,Coloured';
            OptionMembers = African,Indian,White,Coloured;
            Caption = 'Ethnic Origin';
        }
        field(52059; "First Language (R/W/S)"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Language;
            Caption = 'First Language (R/W/S)';
        }
        field(52060; "Driving Licence"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Driving Licence';
        }
        field(52062; "Date Of Join"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Date Of Join';

            trigger OnValidate()
            var
                CurrentYear: Integer;
                JoinMonth: Integer;
            begin
                JoinMonth := 0;
                CurrentYear := 0;

                if "Date Of Join" <> 0D then begin
                    if "Date Of Join" > Today then
                        Error('Date of join can not be in the future');

                    if "End Of Probation Date" = 0D then begin
                        HumanResSetup.Get();
                        HumanResSetup.TestField("Probation Period");
                        "End Of Probation Date" := CalcDate(HumanResSetup."Probation Period", "Date Of Join") - 1;
                    end;

                    "Employment Date - Age" := HRDates.DetermineAge("Date Of Join", Today);

                    if "Incremental Month" = '' then begin
                        JoinMonth := Date2DMY("Date Of Join", 2);
                        Evaluate("Incremental Month", Format(JoinMonth));
                    end;

                    CurrentYear := Date2DMY(Today(), 3);

                    //Check employee who joins in current year - push increment to next year
                    if "Next Increment Date" = 0D then
                        if Date2DMY("Date Of Join", 3) = CurrentYear then
                            "Next Increment Date" := DMY2Date(1, Date2DMY("Date Of Join", 2), CurrentYear + 1)
                        else
                            //Else increment to this year
                            // if not Payroll.CheckIfIncrementEffectedInCurrentYear(Rec, CurrentYear) then
                            //     "Next Increment Date" := DMY2Date(1, Date2DMY("Date Of Join", 2), CurrentYear)
                            // else
                                "Next Increment Date" := DMY2Date(1, Date2DMY("Date Of Join", 2), (CurrentYear + 1));
                end;
                /*
                DateInt:=Date2DMY("Date Of Join",1);
                "Pro-Rata on Joining":=HumanResSetup."No. Of Days in Month"-DateInt+1;
                PayPeriod.Reset();
                PayPeriod.SetRange(PayPeriod."Starting Date",0D,"Date Of Join");
                PayPeriod.SetRange(PayPeriod."New Fiscal Year",true);
                if PayPeriod.Find('+') then
                begin
                FiscalStart:=PayPeriod."Starting Date";
                MaturityDate:=CalcDate('1Y',PayPeriod."Starting Date")-1;
                 Message('Maturity %1',MaturityDate)
                end;
                
                if ("Posting Group"='PERMANENT') or ("Posting Group"='DG') then begin
                //MESSAGE('Date of join %1',"Date Of Join") ;
                 Entitlement:=Round(((MaturityDate-"Date Of Join")/30),1)*2.5;
                
                EmpLeaves.Reset();
                EmpLeaves.SetRange(EmpLeaves."Employee No","No.");
                EmpLeaves.SetRange(EmpLeaves."Maturity Date",MaturityDate);
                if not EmpLeaves.Find('-') then begin
                  EmpLeaves."Employee No":="No.";
                  EmpLeaves."Leave Code":='ANNUAL';
                  EmpLeaves."Maturity Date":=MaturityDate;
                  EmpLeaves.Entitlement:=Entitlement;
                //IF NOT EmpLeaves.GET("No.",'ANNUAL',MaturityDate) THEN
                  EmpLeaves.Insert();
                end;
                
                end;
                  */

            end;
        }
        field(52063; "End Of Probation Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'End Of Probation Date';
        }
        field(52064; "Pension Scheme Join"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Pension Scheme Join';

            trigger OnValidate()
            begin
                /*  if ("Date Of Leaving" <> 0D) and ("Pension Scheme Join" <> 0D) then
                   "Time Pension Scheme":= Dates.DetermineAge("Pension Scheme Join","Date Of Leaving");

            */

            end;
        }
        field(52065; "Medical Scheme Join"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Medical Scheme Join';

            trigger OnValidate()
            begin
                /*  if  ("Date Of Leaving" <> 0D) and ("Medical Scheme Join" <> 0D) then
                   "Time Medical Scheme":= Dates.DetermineAge("Medical Scheme Join","Date Of Leaving");
                */

            end;
        }
        field(52066; "Date Of Leaving"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Date Of Leaving';

            trigger OnValidate()
            begin
                /* if ("Date Of Join" <> 0D) and ("Date Of Leaving" <> 0D) then
                  "Length Of Service":= Dates.DetermineAge("Date Of Join","Date Of Leaving");
                 if ("Pension Scheme Join" <> 0D) and ("Date Of Leaving" <> 0D) then
                  "Time Pension Scheme":= Dates.DetermineAge("Pension Scheme Join","Date Of Leaving");
                 if ("Medical Scheme Join" <> 0D) and ("Date Of Leaving" <> 0D) then
                  "Time Medical Scheme":= Dates.DetermineAge("Medical Scheme Join","Date Of Leaving");


                 if ("Date Of Leaving" <> 0D) and ("Date Of Leaving" <> xRec."Date Of Leaving") then begin
                    ExitInterviews.SetRange("Employee No.","No.");
                    OK:= ExitInterviews.Find('-');
                    if OK then begin
                      ExitInterviews."Date Of Leaving":= "Date Of Leaving";
                      ExitInterviews.Modify();
                    end;
                    Commit();
                 end;


                if ("Date Of Leaving" <> 0D) and ("Date Of Leaving" <> xRec."Date Of Leaving") then begin
                   CareerEvent.SetMessage('Left The Company');
                   CareerEvent.RunModal();
                   OK:= CareerEvent.ReturnResult;
                    if OK then begin
                       CareerHistory.Init();
                       if not CareerHistory.Find('-') then
                        CareerHistory."Line No.":=1
                      else begin
                        CareerHistory.Find('+');
                        CareerHistory."Line No.":=CareerHistory."Line No."+1;
                      end;

                       CareerHistory."Employee No.":= "No.";
                       CareerHistory."Date Of Event":= "Date Of Leaving";
                       CareerHistory."Career Event":= 'Left The Company';
                       CareerHistory."Employee First Name":= "Known As";
                       CareerHistory."Employee Last Name":= "Last Name";

                       CareerHistory.Insert();
                    end;
                end;
               */
                /*
                ExitInterviewTemplate.Reset();
                //TrainingEvalTemplate.SETRANGE(TrainingEvalTemplate."AIT/Evaluation",TrainingEvalTemplate."AIT/Evaluation"::AIT);
                if ExitInterviewTemplate.Find('-') then
                repeat
                ExitInterviewLines.Init();
                ExitInterviewLines."Employee No":="No.";
                ExitInterviewLines.Question:=ExitInterviewTemplate.Question;
                ExitInterviewLines."Line No":=ExitInterviewTemplate."Line No";
                ExitInterviewLines.Bold:=ExitInterviewTemplate.Bold;
                ExitInterviewLines."Answer Type":=ExitInterviewTemplate."Answer Type";
                if not ExitInterviewLines.Get(ExitInterviewLines."Line No",ExitInterviewLines."Employee No") then
                ExitInterviewLines.Insert()
                
                
                until ExitInterviewTemplate.Next()=0;
                */

            end;
        }
        field(52067; "Second Language (R/W/S)"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Language;
            Caption = 'Second Language (R/W/S)';
        }
        field(52068; "Additional Language"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Language;
            Caption = 'Additional Language';
        }
        field(52069; "Termination Category"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = ' ,Resignation,Non-Renewal Of Contract,Dismissal,Retirement,Death,Other';
            OptionMembers = " ",Resignation,"Non-Renewal Of Contract",Dismissal,Retirement,Death,Other;
            Caption = 'Termination Category';

            trigger OnValidate()
            var
                "Lrec Resource": Record Resource;
                OK: Boolean;
            begin
                if "Resource No." <> '' then begin
                    OK := "Lrec Resource".Get("Resource No.");
                    "Lrec Resource".Blocked := true;
                    "Lrec Resource".Modify();
                end;
            end;
        }
        field(52070; "Passport Number"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Passport Number';
        }
        field(52071; "HELB No"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'HELB No';
        }
        field(52072; "Co-Operative No"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Co-Operative No';
        }
        field(52073; "Succesion Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Succesion Date';
        }
        field(52074; "Send Alert to"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Send Alert to';
        }
        field(52075; Religion; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Religion';
        }
        field(52076; "Served Notice Period"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Served Notice Period';
        }
        field(52077; "Exit Interview Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Exit Interview Date';
        }
        field(52078; "Exit Interview Done by"; Code[50])
        {
            DataClassification = CustomerContent;
            TableRelation = "HR Employees"."No.";
            Caption = 'Exit Interview Done by';
        }
        field(52079; "Allow Re-Employment In Future"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Allow Re-Employment In Future';
        }
        field(52080; "Incremental Month"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Anniversary Month';
        }
        field(52081; "Present Pointer"; Code[30])
        {
            DataClassification = CustomerContent;
            TableRelation = "Salary Pointer"."Salary Pointer" where("Salary Scale" = field("Salary Scale"));
            Caption = 'Present Step';

            trigger OnValidate()
            begin
                TestField("Date Of Join");

                // Payroll.DefaultEarningsDeductionsAssignment(Rec);
                Previous := xRec."Present Pointer";
            end;
        }
        field(52082; Previous; Code[30])
        {
            DataClassification = CustomerContent;
            TableRelation = "Salary Pointer"."Salary Pointer" where("Salary Scale" = field("Previous Salary Scale"));
            Caption = 'Previous Step';
        }
        field(52083; Halt; Code[30])
        {
            DataClassification = CustomerContent;
            TableRelation = "Salary Pointer";
            Caption = 'Halt';
        }
        field(52084; "Insurance Premium"; Decimal)
        {
            CalcFormula = sum("Assignment Matrix".Amount where(Type = const(Deduction),
                                                                  "Employee No" = field("No."),
                                                                  "Payroll Period" = field("Pay Period Filter"),
                                                                  "Insurance Code" = const(true)));
            FieldClass = FlowField;
            Caption = 'Insurance Premium';
        }
        field(52085; "Pro-Rata Calculated"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Pro-Rata Calculated';
        }
        field(52086; "Basic Arrears"; Decimal)
        {
            CalcFormula = sum("Assignment Matrix".Amount where(Type = const(Earning),
                                                                  "Employee No" = field("No."),
                                                                  "Payroll Period" = field("Pay Period Filter"),
                                                                  "Basic Pay Arrears" = const(true)));
            FieldClass = FlowField;
            Caption = 'Basic Arrears';
        }
        field(52087; "Relief Amount"; Decimal)
        {
            CalcFormula = - sum("Assignment Matrix".Amount where("Employee No" = field("No."),
                                                                   "Payroll Period" = field("Pay Period Filter"),
                                                                   "Non-Cash Benefit" = const(true),
                                                                   Type = const(Earning),
                                                                   "Tax Deductible" = const(true),
                                                                   "Tax Relief" = const(true)));
            FieldClass = FlowField;
            Caption = 'Relief Amount';
        }
        field(52088; "Other Language Read"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Other Language Read';
        }
        field(52089; "Other Language Write"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Other Language Write';
        }
        field(52090; "Other Language Speak"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Other Language Speak';
        }
        field(52091; "Employee Job Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = '  ,Driver,Executive,Director';
            OptionMembers = "  ",Driver,Executive,Director;
            Caption = 'Employee Job Type';
        }
        field(52092; "Contract Number"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Number';
        }
        field(52093; "Loan Interest"; Decimal)
        {
            CalcFormula = sum("Assignment Matrix"."Loan Interest" where(Type = filter(Deduction | Loan),
                                                                           "Employee No" = field("No."),
                                                                           "Payroll Period" = field("Pay Period Filter")));
            FieldClass = FlowField;
            Caption = 'Loan Interest';
        }
        field(52094; "Blood Type"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Blood Type';
        }
        field(52095; Disability; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Disability';
        }
        field(52096; "County Code"; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'County Code';
        }
        field(52097; "Retirement Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Retirement Date';
        }
        field(52098; "Medical Member No"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Medical Member No';
        }
        field(52099; "Exit Ref No"; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Exit Ref No';
        }
        field(52100; "House Allowance"; Decimal)
        {
            CalcFormula = sum("Assignment Matrix".Amount where(Type = const(Earning),
                                                                  "Employee No" = field("No."),
                                                                  "Payroll Period" = field("Pay Period Filter"),
                                                                  "House Allowance Code" = const(true)));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Total Accumulated House Allowance';
        }
        field(52101; Company; Text[30])
        {
            DataClassification = CustomerContent;
            TableRelation = Company;
            Caption = 'Company';
        }
        field(52102; "Min Tax Rate"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Min Tax Rate';
        }
        field(52103; "Acting Position"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Acting Position';
        }
        field(52104; "Acting No"; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Acting No';
        }
        field(52105; "Acting Description"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Acting Description';
        }
        field(52106; "Relieved Employee"; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Relieved Employee';
        }
        field(52107; "Relieved Name"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Relieved Name';
        }
        field(52108; "Reason for Acting"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Reason for Acting';
        }
        field(52109; "Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Start Date';
        }
        field(52110; "End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'End Date';
        }
        field(52111; "Disability Certificate"; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Disability Certificate';
        }
        field(52112; Name; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Name';
        }
        field(52113; "Employment Status"; Enum "Employment Status")
        {
            DataClassification = CustomerContent;
            Caption = 'Employment Status';

            trigger OnValidate()
            begin
                /* HumanResSetup.Get();
                 HumanResSetup.TestField("Maximum Probation Period");
                  if "Employment Status"="Employment Status"::"Extended Probation" then
                  "End Of Probation Date":=CalcDate(HumanResSetup."Maximum Probation Period","Date Of Join");
                 */

            end;
        }
        field(52114; "Contract Length"; DateFormula)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Length';

            trigger OnValidate()
            begin
                Validate("Contract Start Date");


            end;
        }
        field(52115; "Payroll Suspenstion Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Payroll Suspenstion Date';
        }
        field(52116; "Payroll Reactivation Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Payroll Reactivation Date';
        }
        field(52117; "Employee Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Permanent,Partime,Locum,Casual,Contract,Board Member,Attachee,Intern';
            OptionMembers = Permanent,Partime,Locum,Casual,Contract,"Board Member",Attachee,Intern;
            Caption = 'Employee Type';
        }
        // field(52118; "Currency Code"; Code[10])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Currency Code';
        //     TableRelation = Currency.Code;
        // }
        field(52119; "Net Pay"; Decimal)
        {
            CalcFormula = sum("Assignment Matrix".Amount where("Employee No" = field("No."),
                                                                  "Payroll Period" = field("Pay Period Filter"),
                                                                  "Non-Cash Benefit" = const(false),
                                                                  Gratuity = const(false),
                                                                  "Tax Relief" = const(false)));
            FieldClass = FlowField;
            Caption = 'Net Pay';
        }
        field(52120; "Employment Type"; Enum "Employment Type")
        {
            DataClassification = CustomerContent;
            Caption = 'Employment Type';
        }
        field(52121; "Area"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Area';
        }
        field(52122; "Ethnic Community"; Code[30])
        {
            DataClassification = CustomerContent;
            // TableRelation = "Ethnic Communities";
            Caption = 'Ethnic Community';

            trigger OnValidate()
            begin
                // if Ethnic.Get("Ethnic Community") then
                //     "Ethnic Name" := Ethnic."Ethnic Name";
            end;
        }
        field(52123; "Ethnic Name"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Ethnic Name';
        }
        field(52124; "Home District"; Code[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Home District';
        }
        field(52125; "Employee Bank Name"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Employee Bank Name';
        }
        field(52126; "Employee Bank Sort Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Employee Bank Sort Code';
        }
        field(52127; "Employee Branch Name"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Employee Branch Name';
        }
        field(52128; "Insurance Relief"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Insurance Relief';
        }
        field(52129; "Commuter Allowance"; Decimal)
        {
            CalcFormula = sum("Assignment Matrix".Amount where(Type = const(Earning),
                                                                  "Employee No" = field("No."),
                                                                  "Payroll Period" = field("Pay Period Filter"),
                                                                  "Commuter Allowance Code" = const(true)));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Commuter Allowance';
        }
        field(52130; "Salary Arrears"; Decimal)
        {
            CalcFormula = sum("Assignment Matrix".Amount where(Type = const(Earning),
                                                                  "Employee No" = field("No."),
                                                                  "Payroll Period" = field("Pay Period Filter"),
                                                                  "Salary Arrears Code" = const(true)));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Salary Arrears';
        }
        field(52131; "Debtor Code"; Code[20])
        {
            DataClassification = CustomerContent;
            // TableRelation = Customer where("Customer Type" = filter("Imprest Advance"));
            Caption = 'Debtor Code';
        }
        field(52132; "Current Leave Period"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Leave Period"."Leave Period Code" where(Closed = const(true)));
            Caption = 'Current Leave Period';
            Editable = false;
        }
        field(52133; "Secondary Employee"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Secondary Employee';
        }
        field(52134; "Cumm. Secondary  PAYE"; Decimal)
        {
            CalcFormula = sum("Assignment Matrix".Amount where("Employee No" = field("No."),
                                                                  "Payroll Period" = field("Pay Period Filter"),
                                                                  "Secondary PAYE" = const(true)));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Total Accumulated Sec. PAYE';
        }
        field(52135; "Leave Balance"; Decimal)
        {
            FieldClass = FlowField;
            Editable = false;
            Description = 'With Flowfilters';
            CalcFormula = sum("HR Leave Ledger Entries New"."No. of days" where("Staff No." = field("No."),
                                                                            "Leave Period Code" = field("Leave Period Filter"),
                                                                            "Leave Type" = field("Leave Type Filter")));
            Caption = 'Leave Balance';
        }
        field(52136; "Gratuity Vendor No."; code[50])
        {
            TableRelation = Vendor;
            DataClassification = CustomerContent;
            Caption = 'Gratuity Vendor No.';
        }
        field(52137; "Secondary Job Position"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Company Job";
            Caption = 'Secondary Job Position';

            trigger OnValidate()
            begin

                if Jobs.Get("Secondary Job Position") then
                    "Secondary Job Position Title" := Jobs."Job Description";
            end;
        }
        field(52138; "Secondary Job Position Title"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Secondary Job Position Title';
            Editable = false;
        }
        field(52139; "Leave Days Taken"; Decimal)
        {
            FieldClass = FlowField;
            Editable = false;
            Description = 'With Flowfilters';
            CalcFormula = - sum("HR Leave Ledger Entries New"."No. of days" where("Staff No." = field("No."),
                                                                            "Leave Period Code" = field("Leave Period Filter"),
                                                                            "Leave Type" = field("Leave Type Filter"),
                                                                            "Leave Entry Type" = const(Negative)));
            Caption = 'Leave Days Taken';
        }
        field(52140; "Manager/Supervisor"; Code[20])
        {
            TableRelation = Employee."No." where(Status = const(Active));
            Caption = 'Manager/Supervisor';
            DataClassification = CustomerContent;
        }
        field(52141; "Previous Salary Scale"; Code[30])
        {
            DataClassification = CustomerContent;
            TableRelation = "Salary Scale".Scale;
            Caption = 'Previous Salary Grade';
        }
        field(52020; "Other Name"; Text[150])
        {
            Caption = 'Other Name';
            DataClassification = CustomerContent;
        }
        field(52061; "Leave Entitlement"; Decimal)
        {
            //CalcFormula = lookup("Leave Type".Days where(Code = field("Leave Type Filter")));
            CalcFormula = sum("HR Leave Ledger Entries New"."No. of days" where("Staff No." = field("No."),
                                                                            "Transaction Type" = filter("Leave Allocation"),
                                                                            "Leave Type" = field("Leave Type Filter"),
                                                                            "Leave Period Code" = field("Leave Period Filter")));
            Caption = 'Leave Entitlement';
            Editable = false;
            FieldClass = FlowField;
        }
        field(52142; "Leave Balance Brought Forward"; Decimal)
        {
            CalcFormula = sum("HR Leave Ledger Entries New"."No. of days" where("Staff No." = field("No."),
                                                                                         "Transaction Type" = filter("Leave B/F"),
                                                                                         "Leave Type" = field("Leave Type Filter"),
                                                                                         "Leave Period Code" = field("Leave Period Filter")));
            FieldClass = FlowField;
            Caption = 'Leave Balance Brought Forward';
            Editable = false;
        }
        field(52143; "Leave Recall Days"; Decimal)
        {
            CalcFormula = sum("HR Leave Ledger Entries New"."No. of days" where("Staff No." = field("No."),
                                                                                         "Transaction Type" = filter("Leave Recall"),
                                                                                         "Leave Type" = field("Leave Type Filter"),
                                                                                         "Leave Period Code" = field("Leave Period Filter")));
            FieldClass = FlowField;
            Caption = 'Leave Recall Days';
            Editable = false;
        }
        field(52144; "Days Absent"; Decimal)
        {
            CalcFormula = sum("Employee Absence".Quantity where("Employee No." = field("No."),
                                                                 "Affects Leave" = filter(true)));
            FieldClass = FlowField;
            Caption = 'Days Absent';
        }
        field(52145; "NHIF Amount"; Decimal)
        {
            CalcFormula = sum("Assignment Matrix".Amount where(Type = const(Deduction),
                                                                  "Employee No" = field("No."),
                                                                  "Payroll Period" = field("Pay Period Filter"),
                                                                  "NHIF" = const(true)));
            FieldClass = FlowField;
            Caption = 'NHIF Amount';
        }
        field(52146; "Allowances PAYE"; Decimal)
        {
            // CalcFormula = sum("Allowance Register Line"."PAYE Amount" where("Employee No." = field("No."),
            //                                                                 "Payroll Period" = field("Pay Period Filter"),
            //                                                                 Posted = const(true)));
            Caption = 'Allowances PAYE';
            Editable = false;
            FieldClass = FlowField;
        }
        field(52147; "Last Increment Date"; Date)
        {
            Caption = 'Last Increment Date';
            trigger OnValidate()
            begin
                if "Last Increment Date" <> 0D then
                    "Next Increment Date" := DMY2Date(1, Date2DMY("Date Of Join", 2), (Date2DMY(Today(), 3) + 1));
            end;
        }
        field(52148; "Next Increment Date"; Date)
        {
            Caption = 'Next Increment Date';
        }
        field(52149; "Gross Excludable Allowances"; Decimal)
        {
            CalcFormula = sum("Assignment Matrix".Amount where(Type = const(Earning),
                                                                  "Employee No" = field("No."),
                                                                  "Payroll Period" = field("Pay Period Filter"),
                                                                  "Non-Cash Benefit" = const(false),
                                                                  Gratuity = const(false),
                                                                  "Normal Earnings" = const(true),
                                                                  "Insurance Code" = filter(false),
                                                                  "Exclude Gross Pay Deduction" = const(true)));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Total Accumulated Earnings';
        }
        field(52150; "Last Date Increment"; Date)
        {
            CalcFormula = max("Salary Pointer Increment"."Increment Date" where("Employee No." = field("No.")));
            Caption = 'Last Date Increment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(52151; "Next Date Increment"; Date)
        {
            CalcFormula = max("Salary Pointer Increment"."Next Increment Date" where("Employee No." = field("No.")));
            Caption = 'Next Date Increment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(52152; "Leave Adjustment"; Decimal)
        {
            //CalcFormula = lookup("Leave Type".Days where(Code = field("Leave Type Filter")));
            CalcFormula = sum("HR Leave Ledger Entries New"."No. of days" where("Staff No." = field("No."),
                                                                            "Transaction Type" = filter("Leave Adjustment"),
                                                                            "Leave Type" = field("Leave Type Filter"),
                                                                            "Leave Period Code" = field("Leave Period Filter")));
            Caption = 'Leave Adjustment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(52153; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            DataClassification = CustomerContent;
            TableRelation = Vendor."No.";
        }
        field(52154; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = CustomerContent;
            TableRelation = Customer."No.";
        }
        field(52155; "Employee Category"; Code[20])
        {
            Caption = 'Employee Category';
            DataClassification = CustomerContent;
            // TableRelation = "Employee Category".Code;
        }
        field(52156; "Base Calendar"; Code[10])
        {
            Caption = 'Base Calendar';
            DataClassification = CustomerContent;
            TableRelation = "Base Calendar".Code;
        }
        field(52157; "Exempt from third rule"; Boolean)
        {
            Caption = 'Exempt from third rule';
        }
        field(52158; "Total Non-Recurring Allowances"; Decimal)
        {
            CalcFormula = sum("Assignment Matrix".Amount where(Type = const(Earning),
                                                                  "Employee No" = field("No."),
                                                                  "Payroll Period" = field("Pay Period Filter"),
                                                                  "Non-Cash Benefit" = const(false),
                                                                  Gratuity = const(false),
                                                                  "Normal Earnings" = const(true),
                                                                  "Insurance Code" = filter(false),
                                                                  Frequency = const("Non-Recurring")));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Total Non-Recurring Allowances';
        }
        field(52159; "Housing Levy Amount"; Decimal)
        {
            CalcFormula = sum("Assignment Matrix".Amount where(Type = const(Deduction),
                                                                  "Employee No" = field("No."),
                                                                  "Payroll Period" = field("Pay Period Filter"),
                                                                  "Housing Levy" = const(true)));
            FieldClass = FlowField;
            Caption = 'Housing Levy Amount';
        }
        field(52160; "Contract Extension"; Boolean)
        {
            Caption = 'Contract Extension';
        }
        field(52161; "Contract Renewal Date"; Date)
        {
            Caption = 'Contract Renewal Date';
        }
        field(52162; "Contract Renewal Period"; DateFormula)
        {
            Caption = 'Contract Renewal Period';
        }
        field(52163; "SHIF No."; Code[20])
        {
            Caption = 'SHIF No.';
        }
        field(52164; "SHIF Amount"; Decimal)
        {
            CalcFormula = sum("Assignment Matrix".Amount where(Type = const(Deduction),
                                                                  "Employee No" = field("No."),
                                                                  "Payroll Period" = field("Pay Period Filter"),
                                                                  "SHIF" = const(true)));
            FieldClass = FlowField;
            Caption = 'SHIF Amount';
        }
        field(52165; "Personal Email"; Code[80])
        {
            Caption = 'Personal Email';
        }
        field(52166; "Line Manager"; Code[20])
        {
            TableRelation = Employee."No." where(Status = const(Active));
            Caption = 'Line Manager';
            DataClassification = CustomerContent;
        }
        field(52167; "Approval Status"; Enum "Approval Status")
        {
            Caption = 'Approval Status';
            DataClassification = CustomerContent;
        }
        field(52168; "Home County"; Option)
        {
            OptionMembers = " ",Mombasa,Kwale,Kilifi,"Tana River",Lamu,"Taita-Taveta",Garissa,Wajir,Mandera,Marsabit,Isiolo,Meru,"Tharaka-Nithi",Embu,Kitui,Machakos,Makueni,Nyandarua,Nyeri,Kirinyaga,"Murang’a",Kiambu,Turkana,"West Pokot",Samburu,"Trans-Nzoia","Uasin Gishu","Elgeyo-Marakwet",Nandi,Baringo,Laikipia,Nakuru,Narok,Kajiado,Kericho,Bomet,Kakamega,Vihiga,Bungoma,Busia,Siaya,Kisumu,"Homa Bay",Migori,Kisii,Nyamira,Nairobi;
            Caption = 'Home County';
        }
        field(53020; "Work Location"; Code[100])
        {

            TableRelation = Location.Code;
        }
        field(53021; "Year Serviced"; DateFormula)
        {

        }
        field(53022; "Starting Period"; Date)
        {

        }
        field(53023; "Ending Period"; Date)
        {

        }
        field(53024; "Salary Advance Debtors"; Code[20])
        {
            DataClassification = CustomerContent;
            // TableRelation = Customer where("Customer Type" = filter("Staff Advance"));
            Caption = 'Salary Advance Debtors';

            trigger OnValidate()
            begin

            end;
        }
    }

    fieldgroups
    {
        addlast(DropDown; "Middle Name")
        {
        }
    }

    trigger OnInsert()
    begin

        if "Employee Type" = "Employee Type"::"Board Member" then begin

            if "No." = '' then begin
                HumanResSetup.Get();
                HumanResSetup.TestField("Trustee Nos");
                // NoSeriesMgt.InitSeries(HumanResSetup."Trustee Nos", xRec."No. Series", 0D, "No.", "No. Series");
            end;
        end;
    end;

    var
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        Branches: Record "Bank Branch";
        Banks: Record Banks;
        Jobs: Record "Company Job";
        EmpContract: Record "Employment Contract";
        // Ethnic: Record "Ethnic Communities";
        HumanResSetup: Record "Human Resources Setup";
        PayPeriod: Record "Payroll Period";
        Scale: Record "Salary Scale";
        HRDates: Codeunit "Dates Calculation";// Management";
        // Payroll: Codeunit Payroll;
        dateform: DateFormula;
        Begindate: Date;
        ContractPeriod: Date;

    procedure GetPayPeriod()
    begin

        PayPeriod.Reset();
        PayPeriod.SetRange(PayPeriod."Close Pay", false);
        if PayPeriod.Find('-') then
            //PayPeriodtext:=PayPeriod.Name;
            Begindate := PayPeriod."Starting Date";
        //MESSAGE('%1',Begindate);
    end;

    procedure EnforcePayrollPermissions() PageEditable: Boolean
    var
        UserSetup: Record "User Setup";
        NotAllowedToAccessEmployeesErr: Label 'You are not allowed to access employee information. Kindly contact your system administrator.';
        NotSetupAsUserErr: Label 'You are not set up as a user on User Setup. Kindly contact your system administrator.';
    begin
        if UserSetup.Get(UserId()) then begin
            if "Employee Type" <> "Employee Type"::"Board Member" then begin
                PageEditable := false;

                if not UserSetup."View HR Information" then
                    Error(NotAllowedToAccessEmployeesErr);

                if UserSetup."Edit HR Information" then
                    PageEditable := true
                else
                    PageEditable := false;
            end else
                PageEditable := true;
        end else
            Error(NotSetupAsUserErr);
    end;
}


