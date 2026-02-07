#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51183 "HR Leave Application"
{
    // DrillDownPageID = "HR Leave Applications List";
    // LookupPageID = "HR Leave Applications List";

    fields
    {
        field(1; "Application Code"; Code[20])
        {
            Editable = false;
        }
        field(3; "Leave Type"; Code[30])
        {
            TableRelation = "HR Leave Types".Code;
            trigger OnValidate()
            begin
                PayrollEmp.RESET;
                PayrollEmp.SETRANGE(PayrollEmp."No.", "Employee No");
                PayrollEmp.SETFILTER(PayrollEmp."Leave Type Filter", "Leave Type");
                IF PayrollEmp.FIND('-') THEN BEGIN
                    "Available Days" := PayrollEmp."Leave Balance";
                END;
                HRLeaveTypes.RESET;
                HRLeaveTypes.SETRANGE(HRLeaveTypes.Code, "Leave Type");
                IF HRLeaveTypes.FIND('-') THEN BEGIN
                    PayrollEmp.RESET;
                    PayrollEmp.SETRANGE(PayrollEmp."No.", "Employee No");
                    PayrollEmp.SETRANGE(PayrollEmp.Gender, HRLeaveTypes.Gender);
                    IF PayrollEmp.FIND('-') THEN
                        EXIT
                    ELSE
                        IF HRLeaveTypes.Gender <> HRLeaveTypes.Gender::Both THEN
                            ERROR('This leave type is restricted to the ' + FORMAT(HRLeaveTypes.Gender) + ' gender');
                END;
            end;
        }
        field(4; "Days Applied"; Decimal)
        {

            trigger OnValidate()
            var
                Err001: Label 'Applied days must not be more than leave balance.';
            begin
                CALCFIELDS("Available Days", "Available Maternity Days", "Available Annual Days", "Available Paternity Days", "Available Sick Days", "Available Compassionate Days");
                if "Leave Type" = 'MATERNITY' then begin
                    if "Days Applied" > "Available Maternity Days" then
                        Error(Err001)
                end;
                if "Leave Type" = 'ANNUAL' then begin
                    if "Days Applied" > "Available Annual Days" then
                        Error(Err001)
                end;
                if "Leave Type" = 'PATERNITY' then begin
                    if "Days Applied" > "Available Paternity Days" then
                        Error(Err001)
                end;
                if "Leave Type" = 'COMPASSIONATE' then begin
                    if "Days Applied" > "Available Compassionate Days" then
                        Error(Err001)
                end;
                if "Leave Type" = 'SICK' then begin
                    if "Days Applied" > "Available Sick Days" then
                        Error(Err001)
                end;

                IF ("Days Applied" <> 0) AND ("Start Date" <> 0D) THEN BEGIN
                    VALIDATE("Start Date")
                END;
                "Approved days" := "Days Applied";
            end;
        }
        field(5; "Start Date"; Date)
        {
            trigger OnValidate()
            begin

                //new start date validation
                dates.RESET;
                dates.SETRANGE(dates."Period Start", "Start Date");
                dates.SETFILTER(dates."Period Type", '=%1', dates."Period Type"::Date);
                IF dates.FIND('-') THEN
                    IF ((dates."Period Name" = 'Sunday') OR (dates."Period Name" = 'Saturday')) THEN BEGIN
                        IF (dates."Period Name" = 'Sunday') THEN
                            ERROR('You can not start your leave on a Sunday')
                        ELSE
                            IF (dates."Period Name" = 'Saturday') THEN
                                ERROR('You can not start your leave on a Saturday')
                    END;
                BaseCalendar.RESET;
                BaseCalendar.SETFILTER(BaseCalendar."Base Calendar Code", GeneralOptions."Base Calendar");
                BaseCalendar.SETRANGE(BaseCalendar.Date, "Start Date");
                IF BaseCalendar.FIND('-') THEN BEGIN
                    REPEAT
                        IF BaseCalendar.Nonworking = TRUE THEN BEGIN
                            IF BaseCalendar.Description <> '' THEN
                                ERROR('You can not start your Leave on a Holiday - ''' + BaseCalendar.Description + '''')
                            ELSE
                                ERROR('You can not start your Leave on a Holiday');
                        END;
                    UNTIL BaseCalendar.NEXT = 0;
                END;

                // For Annual Holidays
                BaseCalendar.RESET;
                BaseCalendar.SETFILTER(BaseCalendar."Base Calendar Code", GeneralOptions."Base Calendar");
                BaseCalendar.SETRANGE(BaseCalendar."Recurring System", BaseCalendar."Recurring System"::"Annual Recurring");
                IF BaseCalendar.FIND('-') THEN BEGIN
                    REPEAT
                        IF "Start Date" = BaseCalendar.Date THEN BEGIN
                            IF BaseCalendar.Nonworking = TRUE THEN BEGIN
                                IF BaseCalendar.Description <> '' THEN
                                    ERROR('You can not start your Leave on a Holiday - ''' + BaseCalendar.Description + '''')
                                ELSE
                                    ERROR('You can not start your Leave on a Holiday');
                            END;
                        END;
                    UNTIL BaseCalendar.NEXT = 0;
                END;


                IF "Start Date" < "Application Date" THEN
                    ERROR('You cannot Start your leave before the application date');

                "Return Date" := DetermineLeaveReturnDate("Start Date", "Days Applied");
            end;
        }
        field(6; "Return Date"; Date)
        {
            Caption = 'Return Date';
            Editable = true;
            // trigger OnValidate()

            // begin
            //     Validate("Start Date");
            // end;
        }
        field(7; "Application Date"; Date)
        {
        }
        field(8; "Global Dimension 1 Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));

            trigger OnValidate();
            begin
                "Global Dimension 1 Name" := '';
                DimValue.RESET;
                DimValue.SETRANGE(DimValue.Code, "Global Dimension 1 Code");
                IF DimValue.FIND('-') THEN BEGIN
                    "Global Dimension 1 Name" := DimValue.Name;
                END;
            end;
        }
        field(9; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate();
            begin
                "Global Dimension 2 Name" := '';
                DimValue.RESET;
                DimValue.SETRANGE(DimValue.Code, "Global Dimension 2 Code");
                IF DimValue.FIND('-') THEN BEGIN
                    "Global Dimension 2 Name" := DimValue.Name;
                END;
            end;
        }
        field(19; "Global Dimension 1 Name"; Text[60])
        {
            Editable = false;
        }
        field(20; "Global Dimension 2 Name"; Text[60])
        {
            Editable = false;
        }
        field(32; Posted; Boolean)
        {
        }
        field(33; "Posted By"; Text[250])
        {
        }
        field(34; "Date Posted"; Date)
        {
        }
        field(35; "Time Posted"; Time)
        {
        }
        field(12; Status; Option)
        {
            OptionMembers = New,Escalated,Pending,Rejected,Approved,Posted;
        }
        field(15; "Applicant Comments"; Text[250])
        {
        }
        field(17; "No series"; Code[30])
        {
        }
        field(18; Gender; Option)
        {
            Editable = false;
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
        }
        field(28; Selected; Boolean)
        {
        }
        field(31; "Current Balance"; Decimal)
        {
        }
        field(36; "Department Code"; Code[20])
        {
            trigger OnValidate()
            begin
                IF PayrollEmp.GET(Department) THEN
                    Department := PayrollEmp."Department Name";
            end;
        }
        field(3900; "End Date"; Date)
        {
            Editable = false;
        }
        field(3901; "Total Taken"; Decimal)
        {
            DecimalPlaces = 2 : 2;
        }
        field(3921; "E-mail Address"; Text[60])
        {
            Editable = false;
            ExtendedDatatype = EMail;
        }
        field(3924; "Entry No"; Integer)
        {
        }
        field(3929; "Start Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(3936; "Cell Phone Number"; Text[50])
        {
            ExtendedDatatype = PhoneNo;
        }
        field(5981; "Alternative CellPhone No."; Integer)
        {
        }
        field(50000; "Employee Posting Group"; Code[20])
        {
        }
        field(50004; Address; Code[50])
        {
        }
        field(3937; "Request Leave Allowance"; Boolean)
        {
            trigger OnValidate()
            begin
                PayrollEmp.RESET;
                PayrollEmp.SETRANGE(PayrollEmp."No.", "Employee No");
                IF PayrollEmp.FIND('-') THEN BEGIN
                    IF PayrollEmp."Leave Allowance Claimed" = TRUE THEN
                        ERROR('Leave Allowance has been claimed');
                    Allowance := PayrollEmp."Leave Allowance Amount";
                    IF "Request Leave Allowance" = TRUE THEN BEGIN
                        "Leave Allowance Amount" := Allowance;
                    END
                    ELSE BEGIN
                        "Leave Allowance Amount" := 0;
                    END;

                END;
            end;
        }
        field(3939; Picture; BLOB)
        {
        }
        field(3940; Names; Text[100])
        {
        }
        field(3942; "Leave Allowance Entittlement"; Decimal)
        {
            CalcFormula = Lookup("HR Employees"."Leave Allowance Amount" WHERE("No." = FIELD("Applicant Staff No.")));
            FieldClass = FlowField;
        }
        field(3943; "Leave Allowance Amount"; Decimal)
        {
        }
        field(3945; "Details of Examination"; Text[200])
        {
        }
        field(3947; "Date of Exam"; Date)
        {
        }
        field(3949; Reliever; Code[50])
        {
            TableRelation = "HR Employees"."No.";
            trigger OnValidate()
            begin
                //DISPLAY RELEIVERS NAME
                IF Reliever = "Applicant Staff No." THEN
                    ERROR('Employee cannot relieve him/herself');
                IF PayrollEmp.GET(Reliever) THEN
                    "Reliever Name" := PayrollEmp."First Name" + ' ' + PayrollEmp."Middle Name";
                "Reliever Position" := PayrollEmp."Job Title";
                "Reliever Contact" := PayrollEmp."Cell Phone Number";
                "Reliever Email" := PayrollEmp."E-Mail";

            end;
        }
        field(3950; "Reliever Name"; Text[100])
        {
        }
        field(3952; Description; Text[30])
        {
        }
        field(3955; "Supervisor Email"; Text[50])
        {
        }
        field(3956; "Number of Previous Attempts"; Text[200])
        {
        }
        field(3958; "Job Tittle"; Text[50])
        {
        }
        field(3959; "User ID"; Code[50])
        {
        }
        field(3961; "Employee No"; Code[20])
        {
            TableRelation = "HR Employees"."No.";
            trigger OnValidate()
            begin
                PayrollEmp.Reset();
                PayrollEmp.GET("Employee No");
                "Cell Phone Number" := PayrollEmp."Cellular Phone Number";
                "E-mail Address" := PayrollEmp."E-Mail";
                "Supervisor Name" := PayrollEmp."Supervisor Name";
                Names := PayrollEmp.FullName();
                //Names := PayrollEmp."First Name" + ' ' + PayrollEmp."Middle Name";




                // UserSetup.RESET;
                // UserSetup.SETRANGE("Employee no", "Employee No");
                // IF UserSetup.FINDFIRST THEN
                //     "Responsibility Center" := UserSetup."Responsibility Center";

                PayrollEmp.RESET;
                PayrollEmp.SETRANGE(PayrollEmp."No.", "Employee No");
                IF PayrollEmp.FIND('-') THEN BEGIN
                    //PayrollEmp.TESTFIELD(PayrollEmp."Date Of Join");

                    Calendar.RESET;
                    Calendar.SETRANGE("Period Type", Calendar."Period Type"::Month);
                    Calendar.SETRANGE("Period Start", PayrollEmp."Date Of Join", TODAY);
                    empMonths := Calendar.COUNT;

                    //Minimum duration in months for Leave Applications
                    IF HRSetup.GET THEN BEGIN
                        HRSetup.TESTFIELD(HRSetup."Min. Leave App. Months");
                        IF empMonths < HRSetup."Min. Leave App. Months" THEN ERROR(Text002, HRSetup."Min. Leave App. Months");
                    END;

                    //Populate fields
                    //    "Employee No":=PayrollEmp."No.";
                    Gender := PayrollEmp.Gender;
                    "Application Date" := TODAY;
                    "User ID" := USERID;
                    "Job Tittle" := PayrollEmp."Job Title";
                    PayrollEmp.CALCFIELDS(PayrollEmp.Picture);
                    Picture := PayrollEmp.Picture;
                    // "Cell Phone Number" := PayrollEmp."Cellular Phone Number";
                    "E-mail Address" := PayrollEmp."E-Mail";

                    "Applicant Name" := PayrollEmp."First Name" + ' ' + PayrollEmp."Middle Name";
                    //"Responsibility Center":=PayrollEmp."Department Code";
                    //Approver details

                    Class := Class;
                END;

                VALIDATE("Leave Type");

            end;
        }
        field(3962; Supervisor; Code[50])
        {
            TableRelation = "HR Employees"."No.";
            trigger OnValidate()
            begin
                IF PayrollEmp.GET(Supervisor) THEN begin
                    Rec."Supervisor Name" := PayrollEmp."First Name" + ' ' + PayrollEmp."Middle Name";
                    Rec."Supervisor Email" := PayrollEmp."E-Mail";
                    Rec.SupervisorUserID := "User ID";
                    rec.Modify();
                end;
            end;
        }
        field(3963; SupervisorUserID; Code[100])
        {

        }
        field(3969; "Responsibility Center"; Code[20])
        {
            TableRelation = "Responsibility Center";
        }
        field(3970; "Approved days"; Integer)
        {

            // trigger OnValidate()
            // begin
            //     IF "Approved days" > "Days Applied" THEN
            //         ERROR(TEXT001);
            // end;
        }
        field(3971; Attachments; Integer)
        {
            CalcFormula = Count("Company Documents" WHERE("Doc No." = FIELD("Application Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(59; "Applicant User ID"; Code[50])
        {
        }
        field(61; "Applicant Staff No."; Code[20])
        {
            TableRelation = "HR Employees"."No." WHERE(Status = CONST(New)/* , "Contract Type" = filter('<>DIRECTOR') */);
            trigger OnValidate()
            begin
                IF HREmp.GET("Applicant Staff No.") THEN begin
                    Names := HREmp."First Name" + ' ' + HREmp."Middle Name";
                    "Job Tittle" := HREmp."Job Title";
                    Department := HREmp."Department Name";

                    //    "Employee No":=PayrollEmp."No.";
                    Gender := HREmp.Gender;
                    "Application Date" := TODAY;
                    "User ID" := USERID;

                    HREmp.CALCFIELDS(HREmp.Picture);
                    Picture := HREmp.Picture;
                    // "Cell Phone Number" := PayrollEmp."Cellular Phone Number";
                    "E-mail Address" := HREmp."E-Mail";

                    "Applicant Name" := HREmp."First Name" + ' ' + HREmp."Middle Name";
                    //"Responsibility Center":=PayrollEmp."Department Code";
                    //Approver details

                    Class := Class;
                end;

            end;
        }
        field(62; "Applicant Supervisor"; Code[50])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(3972; Emergency; Boolean)
        {
            Description = 'This is used to ensure one can apply annual leave which is emergency';
        }
        field(3973; "Approver Comments"; Text[200])
        {
        }
        field(3974; "Available Days"; Decimal)
        {
            CalcFormula = Sum("HR Leave Ledger Entries"."No. of days" WHERE("Staff No." = FIELD("Applicant Staff No.")));
            FieldClass = FlowField;
        }

        field(50001; "Leave Allowance Posted"; Boolean)
        {
            Editable = false;
        }
        field(50002; "Leave Allowance Date"; Date)
        {
            Editable = false;
        }

        field(3975; Reliever2; Code[50])
        {
            TableRelation = "Payroll Employee."."No.";
            trigger OnValidate()
            begin
                //DISPLAY RELEIVERS NAME
                IF Reliever2 = "Employee No" THEN
                    ERROR('Employee cannot relieve him/herself');

                IF PayrollEmp.GET(Reliever2) THEN
                    "Reliever Name2" := PayrollEmp."First Name";
                //"Job Tittle":=PayrollEmp."Job Title";

            end;
        }
        field(3976; "Reliever Name2"; Text[100])
        {
            Editable = false;
        }
        field(3977; "Date Of Exam 1"; Date)
        {
            trigger OnValidate()
            begin
                IF "Date Of Exam 1" < "Application Date" THEN
                    ERROR('You cannot Start your leave before the application date');

                IF "Date Of Exam 1" = "Date Of Exam 7" THEN
                    ERROR('Date already assigned');
                IF "Date Of Exam 1" = "Date Of Exam 3" THEN
                    ERROR('Date already assigned');

                IF "Date Of Exam 1" = "Date Of Exam 4" THEN
                    ERROR('Date already assigned');

                IF "Date Of Exam 1" = "Date Of Exam 5" THEN
                    ERROR('Date already assigned');

                IF "Date Of Exam 1" = "Date Of Exam 6" THEN
                    ERROR('Date already assigned');

                IF "Date Of Exam 1" = "Date Of Exam 2" THEN
                    ERROR('Date already assigned');
            end;
        }
        field(3978; "Date Of Exam 2"; Date)
        {

            trigger OnValidate()
            begin
                IF "Date Of Exam 2" < "Application Date" THEN
                    ERROR('You cannot Start your leave before the application date');

                IF "Date Of Exam 2" = "Date Of Exam 1" THEN
                    ERROR('Date already assigned');
                IF "Date Of Exam 2" = "Date Of Exam 3" THEN
                    ERROR('Date already assigned');

                IF "Date Of Exam 2" = "Date Of Exam 4" THEN
                    ERROR('Date already assigned');

                IF "Date Of Exam 2" = "Date Of Exam 5" THEN
                    ERROR('Date already assigned');

                IF "Date Of Exam 2" = "Date Of Exam 6" THEN
                    ERROR('Date already assigned');

                IF "Date Of Exam 2" = "Date Of Exam 7" THEN
                    ERROR('Date already assigned');
            end;
        }
        field(3979; "Date Of Exam 3"; Date)
        {
            trigger OnValidate()
            begin
                IF "Date Of Exam 3" < "Application Date" THEN
                    ERROR('You cannot Start your leave before the application date');

                IF "Date Of Exam 3" = "Date Of Exam 1" THEN
                    ERROR('Date already assigned');
                IF "Date Of Exam 3" = "Date Of Exam 2" THEN
                    ERROR('Date already assigned');

                IF "Date Of Exam 3" = "Date Of Exam 4" THEN
                    ERROR('Date already assigned');

                IF "Date Of Exam 3" = "Date Of Exam 5" THEN
                    ERROR('Date already assigned');

                IF "Date Of Exam 3" = "Date Of Exam 6" THEN
                    ERROR('Date already assigned');

                IF "Date Of Exam 3" = "Date Of Exam 7" THEN
                    ERROR('Date already assigned');
            end;
        }
        field(3980; "Date Of Exam 4"; Date)
        {
            trigger OnValidate()
            begin
                IF "Date Of Exam 4" < "Application Date" THEN
                    ERROR('You cannot Start your leave before the application date');

                IF "Date Of Exam 4" = "Date Of Exam 1" THEN
                    ERROR('Date already assigned');
                IF "Date Of Exam 4" = "Date Of Exam 3" THEN
                    ERROR('Date already assigned');

                IF "Date Of Exam 4" = "Date Of Exam 2" THEN
                    ERROR('Date already assigned');

                IF "Date Of Exam 4" = "Date Of Exam 5" THEN
                    ERROR('Date already assigned');

                IF "Date Of Exam 4" = "Date Of Exam 6" THEN
                    ERROR('Date already assigned');

                IF "Date Of Exam 4" = "Date Of Exam 7" THEN
                    ERROR('Date already assigned');
            end;
        }
        field(3981; "Date Of Exam 5"; Date)
        {
            trigger OnValidate()
            begin
                IF "Date Of Exam 5" < "Application Date" THEN
                    ERROR('You cannot Start your leave before the application date');

                IF "Date Of Exam 5" = "Date Of Exam 1" THEN
                    ERROR('Date already assigned');
                IF "Date Of Exam 5" = "Date Of Exam 3" THEN
                    ERROR('Date already assigned');

                IF "Date Of Exam 5" = "Date Of Exam 4" THEN
                    ERROR('Date already assigned');

                IF "Date Of Exam 5" = "Date Of Exam 2" THEN
                    ERROR('Date already assigned');

                IF "Date Of Exam 5" = "Date Of Exam 6" THEN
                    ERROR('Date already assigned');

                IF "Date Of Exam 5" = "Date Of Exam 7" THEN
                    ERROR('Date already assigned');
            end;
        }
        field(3982; "Date Of Exam 6"; Date)
        {
            trigger OnValidate()
            begin
                IF "Date Of Exam 6" < "Application Date" THEN
                    ERROR('You cannot Start your leave before the application date');

                IF "Date Of Exam 6" = "Date Of Exam 1" THEN
                    ERROR('Date already assigned');
                IF "Date Of Exam 6" = "Date Of Exam 3" THEN
                    ERROR('Date already assigned');

                IF "Date Of Exam 6" = "Date Of Exam 4" THEN
                    ERROR('Date already assigned');

                IF "Date Of Exam 6" = "Date Of Exam 5" THEN
                    ERROR('Date already assigned');

                IF "Date Of Exam 6" = "Date Of Exam 2" THEN
                    ERROR('Date already assigned');

                IF "Date Of Exam 6" = "Date Of Exam 7" THEN
                    ERROR('Date already assigned');
            end;
        }
        field(3983; "Date Of Exam 7"; Date)
        {

            trigger OnValidate()
            begin
                IF "Date Of Exam 7" < "Application Date" THEN
                    ERROR('You cannot Start your leave before the application date');

                IF "Date Of Exam 7" = "Date Of Exam 1" THEN
                    ERROR('Date already assigned');
                IF "Date Of Exam 7" = "Date Of Exam 3" THEN
                    ERROR('Date already assigned');

                IF "Date Of Exam 7" = "Date Of Exam 4" THEN
                    ERROR('Date already assigned');

                IF "Date Of Exam 7" = "Date Of Exam 5" THEN
                    ERROR('Date already assigned');

                IF "Date Of Exam 7" = "Date Of Exam 6" THEN
                    ERROR('Date already assigned');

                IF "Date Of Exam 7" = "Date Of Exam 2" THEN
                    ERROR('Date already assigned');
            end;
        }
        field(3984; "Employee Name"; Text[150])
        {
        }
        field(3985; "Address No."; Text[80])
        {
        }
        field(3986; "Outstanding Leave Balance"; Decimal)
        {
            CalcFormula = Sum("HR Leave Ledger Entries"."No. of days" WHERE("Staff No." = FIELD("Employee No"),
                                                                             "Posting Date" = FIELD("Date Filter"),
                                                                             "Leave Type" = CONST('ANNUAL')));
            FieldClass = FlowField;
        }
        field(3987; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(3988; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3989; "Date from exam 1"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3990; "Date to exam 1"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3991; "Date from exam 2"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3992; "Date to exam 2"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3993; "Date from exam 3"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3994; "Date to exam 3"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3995; "Date from exam 4"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3996; "Date to exam 4"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3997; "Date from exam 5"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3998; "Date to exam 5"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3999; "Date from exam 6"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4000; "Date to exam 6"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4001; "Date from exam 7"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4002; "Date to exam 7"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4003; "Reliever Position"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4004; "Reliever Contact"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4005; "Applicant Name"; Text[150])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payroll Employee."."No.";
        }
        field(4006; Class; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Director,Staff';
            OptionMembers = " ",Director,Staff;
        }
        field(4007; Supervisor2; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payroll Employee."."No.";

            trigger OnValidate()
            begin
                IF PayrollEmp.GET(Supervisor2) THEN
                    "Supervisor Name 2" := PayrollEmp."First Name" + ' ' + PayrollEmp."Middle Name";
            end;
        }
        field(4008; "Leave Planner no"; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Leave Planner Lines"."Line No." WHERE("Employee No" = FIELD("Applicant Staff No."));
            trigger OnValidate()
            begin
                HRLeavePlannerLines.RESET;
                HRLeavePlannerLines.SETRANGE(HRLeavePlannerLines."Line No.", "Leave Planner no");
                IF HRLeavePlannerLines.FIND('-') THEN BEGIN
                    "Start Date" := HRLeavePlannerLines."Start Date";
                    "End Date" := HRLeavePlannerLines."End Date";
                    "Days Applied" := HRLeavePlannerLines."Days Applied";
                    "Approved days" := HRLeavePlannerLines."Approved days";
                    "Leave planner code" := HRLeavePlannerLines."Application Code";
                    VALIDATE("Days Applied")
                END;
            end;
        }
        field(4009; "Leave planner start date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4010; "Leave planner end date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4011; "Leave planner code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        // field(4012; "Approval Level"; Integer)
        // {
        //     DataClassification = ToBeClassified;
        //     TableRelation = "Hr Approval Levels".Level;
        // }
        field(4013; Supervisor1; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payroll Employee."."No.";

            trigger OnValidate()
            begin

                IF PayrollEmp.GET(Supervisor1) THEN
                    "Supervisor Name 1" := PayrollEmp."First Name" + ' ' + PayrollEmp."Middle Name";

            end;
        }
        field(4014; "Supervisor Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4015; Department; Text[30])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF PayrollEmp.GET(Department) THEN
                    Department := PayrollEmp."Department Name";
                IF DimValue.GET(Department) THEN
                    Department := DimValue.Name;
            end;
        }
        field(4017; "Supervisor Name 1"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4019; "Supervisor Name 2"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4020; Quarter; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Quarter1,Quarter2,Quarter3,Quarter4;
        }
        field(4021; "Available Maternity Days"; Decimal)
        {
            CalcFormula = Sum("HR Leave Ledger Entries"."No. of days" WHERE("Leave Type" = CONST('MATERNITY'),
                                                                             "Staff No." = FIELD("Applicant Staff No.")));
            FieldClass = FlowField;
        }
        field(4022; "Available Annual Days"; Decimal)
        {
            CalcFormula = Sum("HR Leave Ledger Entries"."No. of days" WHERE("Leave Type" = CONST('ANNUAL'),
                                                                            "Leave Entry Type" = filter('Positive'),
                                                                             "Staff No." = FIELD("Applicant Staff No.")));
            FieldClass = FlowField;
        }
        field(4023; "Available Paternity Days"; Decimal)
        {
            CalcFormula = Sum("HR Leave Ledger Entries"."No. of days" WHERE("Leave Type" = CONST('PATERNITY'),
                                                                             "Staff No." = FIELD("Applicant Staff No.")));
            FieldClass = FlowField;
        }
        field(4024; "Available Compassionate Days"; Decimal)
        {
            CalcFormula = Sum("HR Leave Ledger Entries"."No. of days" WHERE("Leave Type" = CONST('COMPASSIONATE'),
                                                                             "Staff No." = FIELD("Applicant Staff No.")));
            FieldClass = FlowField;
        }
        field(4025; "Available Sick Days"; Decimal)
        {
            CalcFormula = Sum("HR Leave Ledger Entries"."No. of days" WHERE("Leave Type" = CONST('SICK'),
                                                                            "Leave Entry Type" = filter('Positive'),
                                                                             "Staff No." = FIELD("Applicant Staff No.")));
            FieldClass = FlowField;
        }
        field(4026; "Leave Balance"; Decimal)
        {
            CalcFormula = Sum("HR Leave Ledger Entries"."No. of days" WHERE("Staff No." = FIELD("Applicant Staff No."),
             "Leave Type" = FILTER('ANNUAL')));
            FieldClass = FlowField;
        }
        field(4027; "Total Leave Days"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("HR Leave Ledger Entries"."No. of days" WHERE("Staff No." = FIELD("Employee No"),
                                                                             //"Posting Date" = FIELD("Date Filter"),
                                                                             "Leave Entry Type" = filter('Positive'),
                                                                             "Leave Type" = FILTER('ANNUAL')));

        }
        field(2004; "Total Leave Taken"; Decimal)
        {
            CalcFormula = - Sum("HR Leave Ledger Entries"."No. of days" WHERE("Staff No." = FIELD("Employee No"),
                                                                             /* "Posting Date" = FIELD("Date Filter"), */
                                                                             "Leave Entry Type" = CONST(Negative),
                                                                             Closed = CONST(false),
                                                                             "Leave Type" = CONST('ANNUAL')));
            DecimalPlaces = 2 : 2;
            FieldClass = FlowField;
        }
        field(2005; "Escalated to supervisor"; Boolean)
        {

        }
        field(2006; "Reliever Email"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(2007; "Leave Calendar Code"; Code[20])
        {
            Dataclassification = ToBeClassified;
            // TableRelation = "HR Leave Calendar"."Calendar Code";

        }


    }

    keys
    {
        key(Key1; "Application Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //IF Status<>Status::New THEN ERROR('You cannot delete this leave application');
    end;

    trigger OnInsert()
    var
        //HRStaff: Codeunit "50014";
        User: Text;
    begin
        //No. Series
        IF "Application Code" = '' THEN BEGIN
            HRSetup.GET;
            HRSetup.TESTFIELD(HRSetup."Leave Application Nos.");
            // NoSeriesMgt.InitSeries(HRSetup."Leave Application Nos.", xRec."No series", 0D, "Application Code", "No series");
        END;


    END;


    var
        TEXT001: Label 'Days Approved cannot be more than applied days';
        Text002: Label 'You cannot apply for leave until your are over [%1] months old in the company';
        Text003: Label 'UserID [%1] does not exist in [%2]';
        Allowance: Decimal;
        HRSetup: Record "HR Setup";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        PayrollEmp: Record "HR Employees";
        HREmp: Record "HR Employees";
        varDaysApplied: Integer;
        HRLeaveTypes: Record "HR Leave Types";
        //BaseCalendarChange: Record "51516272";
        ReturnDateLoop: Boolean;
        mSubject: Text[250];
        ApplicantsEmail: Text[30];
        //SMTP: Codeunit "400";
        LeaveGjline: Record "HR Journal Line";
        "LineNo.": Integer;
        ApprovalComments: Record "Approval Comment Line";
        URL: Text[500];
        sDate: Record Date;

        HRLeavePeriods: Record "HR Leave Periods";
        HRJournalBatch: Record "HR Leave Journal Batch";
        HRLeaveEntries: Record "HR Leave Ledger Entries";
        intEntryNo: Integer;
        Calendar: Record Date;
        empMonths: Integer;
        HRLeaveApp: Record "HR Leave Application";
        mWeekDay: Integer;
        empGender: Option Female;
        mMinDays: Integer;
        dates: Record Date;
        BaseCalendar: Record "Base Calendar Change";
        GeneralOptions: Record "HR Setup";
        LeaveTypes: Record "HR Leave Types";
        // SalEmp: Record "51516317";
        UserSetup: Record "User Setup";
        HRLeavePlannerLines: Record "HR Leave Planner Lines";
        //SMSMessage: Record 51471;
        iEntryNo: Integer;
        DimValue: Record "Dimension Value";

    procedure DetermineIfIsNonWorking(var bcDate: Date; var ltype: Record "HR Leave Types") ItsNonWorking: Boolean
    var
        dates: Record Date;
    begin
        CLEAR(ItsNonWorking);

        //One off Hollidays like Good Friday
        BaseCalendar.RESET;
        BaseCalendar.SETFILTER(BaseCalendar."Base Calendar Code", GeneralOptions."Base Calendar");
        BaseCalendar.SETRANGE(BaseCalendar.Date, bcDate);
        IF BaseCalendar.FindFirst() THEN BEGIN
            IF BaseCalendar.Nonworking = TRUE THEN
                ItsNonWorking := TRUE;
        END;

        // // For Annual Holidays
        BaseCalendar.RESET;
        BaseCalendar.SETFILTER(BaseCalendar."Base Calendar Code", GeneralOptions."Base Calendar");
        BaseCalendar.SETRANGE(BaseCalendar."Recurring System", BaseCalendar."Recurring System"::"Annual Recurring");
        IF BaseCalendar.FindFirst() THEN BEGIN
            IF BaseCalendar.Nonworking = TRUE THEN
                ItsNonWorking := TRUE;
        END;

        IF ItsNonWorking = FALSE THEN BEGIN
            // Check if its a weekend
            dates.RESET;
            dates.SETRANGE(dates."Period Type", dates."Period Type"::Date);
            dates.SETRANGE(dates."Period Start", bcDate);
            IF dates.FIND('-') THEN BEGIN
                //if date is a sunday
                IF dates."Period Name" = 'Sunday' THEN BEGIN
                    //check if Leave includes sunday
                    IF ltype."Inclusive of Sunday" = FALSE THEN ItsNonWorking := TRUE;

                END ELSE IF dates."Period Name" = 'Saturday' THEN BEGIN
                    //check if Leave includes sato
                    IF ltype."Inclusive of Saturday" = FALSE THEN ItsNonWorking := TRUE;
                END;
            END;

        END;
        exit(ItsNonWorking);
    end;

    procedure DetermineIfIncludesNonWorking(var fLeaveCode: Code[10]): Boolean
    begin
        IF LeaveTypes.GET(fLeaveCode) THEN BEGIN
            IF LeaveTypes."Inclusive of Non Working Days" = TRUE THEN
                EXIT(TRUE);
        END;
    end;

    /* procedure DetermineLeaveReturnDate(var fBeginDate: Date; var fDays: Decimal) fReturnDate: Date
    var
        ltype: Record "HR Leave Types";
    begin
        ltype.RESET;
        IF ltype.GET("Leave Type") THEN BEGIN
        END;
        varDaysApplied := fDays;
        fReturnDate := fBeginDate;
        REPEAT
            IF DetermineIfIncludesNonWorking("Leave Type") = FALSE THEN BEGIN
                fReturnDate := CALCDATE('1D', fReturnDate);
                IF DetermineIfIsNonWorking(fReturnDate, ltype) THEN BEGIN
                    varDaysApplied := varDaysApplied + 1;
                END ELSE
                    varDaysApplied := varDaysApplied;
                varDaysApplied := varDaysApplied + 1
            END
            ELSE BEGIN
                fReturnDate := CALCDATE('1D', fReturnDate);
                varDaysApplied := varDaysApplied - 1;
            END;
        UNTIL varDaysApplied = 0;
        EXIT(fReturnDate);
    end; */
    procedure DetermineLeaveReturnDate(fBeginDate: Date; fDays: Decimal): Date
    var
        LeaveType: Record "HR Leave Types";
        CurrentDate: Date;
        RemainingDays: Decimal;
        IncludeNonWorking: Boolean;
    begin
        if not LeaveType.Get("Leave Type") then
            Error('Leave Type %1 not found.', "Leave Type");

        IncludeNonWorking := DetermineIfIncludesNonWorking("Leave Type");
        CurrentDate := fBeginDate;
        RemainingDays := fDays;

        while RemainingDays > 0 do begin
            CurrentDate := CalcDate('1D', CurrentDate);

            if IncludeNonWorking then begin
                RemainingDays -= 1;
            end else begin
                if not DetermineIfIsNonWorking(CurrentDate, LeaveType) then
                    RemainingDays -= 1;
            end;
        end;

        exit(CurrentDate);
    end;


    procedure DeterminethisLeaveEndDate(var fDate: Date) fEndDate: Date
    var
        ltype: Record "HR Leave Types";
    begin
        IF ltype.GET("Leave Type") THEN BEGIN
        END;
        ReturnDateLoop := TRUE;
        fEndDate := fDate;
        IF fEndDate <> 0D THEN BEGIN
            fEndDate := CALCDATE('1D', fEndDate);
            WHILE (ReturnDateLoop) DO BEGIN
                IF DetermineIfIsNonWorking(fEndDate, ltype) THEN
                    fEndDate := CALCDATE('-1D', fEndDate)
                ELSE
                    ReturnDateLoop := FALSE;
            END
        END;
        EXIT(fEndDate);
    end;

    procedure CreateLeaveLedgerEntries()
    begin
        IF Status = Status::Posted THEN
            ERROR('Leave Already posted');
        HRSetup.RESET;
        IF HRSetup.FIND('-') THEN BEGIN
            LeaveGjline.RESET;
            LeaveGjline.SETRANGE("Journal Template Name", HRSetup."Leave Template");
            LeaveGjline.SETRANGE("Journal Batch Name", HRSetup."Leave Batch");
            LeaveGjline.DELETEALL;
            //Dave
            HRSetup.TESTFIELD(HRSetup."Leave Template");
            HRSetup.TESTFIELD(HRSetup."Leave Batch");
            "LineNo." := 10000;
            LeaveGjline.INIT;
            LeaveGjline."Journal Template Name" := HRSetup."Leave Template";
            LeaveGjline."Journal Batch Name" := HRSetup."Leave Batch";
            LeaveGjline."Line No." := "LineNo.";
            LeaveGjline."Leave Period" := FORMAT(DATE2DMY(TODAY, 3));
            LeaveGjline."Leave Application No." := "Application Code";
            LeaveGjline."Document No." := "Application Code";
            LeaveGjline."Staff No." := "Applicant Staff No.";
            LeaveGjline.VALIDATE(LeaveGjline."Staff No.");
            LeaveGjline."Posting Date" := TODAY;
            LeaveGjline."Leave Entry Type" := LeaveGjline."Leave Entry Type"::Negative;
            //LeaveGjline."Leave Approval Date" := TODAY;
            LeaveGjline.Description := 'Leave Taken';
            LeaveGjline."Leave Type" := "Leave Type";

            HRSetup.TESTFIELD(HRSetup."Leave Posting Period[FROM]");
            HRSetup.TESTFIELD(HRSetup."Leave Posting Period[TO]");
            //------------------------------------------------------------
            LeaveGjline."Leave Period Start Date" := HRSetup."Leave Posting Period[FROM]";
            LeaveGjline."Leave Period End Date" := HRSetup."Leave Posting Period[TO]";
            LeaveGjline."No. of Days" := "Approved days" * -1;
            IF LeaveGjline."No. of Days" <> 0 THEN
                LeaveGjline.INSERT(TRUE);

            //Post Journal
            LeaveGjline.RESET;
            LeaveGjline.SETRANGE("Journal Template Name", HRSetup."Leave Template");
            LeaveGjline.SETRANGE("Journal Batch Name", HRSetup."Leave Batch");
            IF LeaveGjline.FIND('-') THEN BEGIN
                CODEUNIT.RUN(CODEUNIT::"HR Leave Jnl.-Post", LeaveGjline);
            END;
            Status := Status::Posted;
            "Posting Date" := TODAY;
            MODIFY;
        END;

    end;

    procedure NotifyApplicant()
    begin
        // PayrollEmp.GET("Employee No");
        // PayrollEmp.TESTFIELD(PayrollEmp."Company E-Mail");

        // //GET E-MAIL PARAMETERS FOR GENERAL E-MAILS
        // HREmailParameters.RESET;
        // HREmailParameters.SETRANGE(HREmailParameters."Associate With", HREmailParameters."Associate With"::"Interview Invitations");
        // IF HREmailParameters.FIND('-') THEN BEGIN


        //     PayrollEmp.TESTFIELD(PayrollEmp."Company E-Mail");
        //     SMTP.CreateMessage(HREmailParameters."Sender Name", HREmailParameters."Sender Address", PayrollEmp."Company E-Mail",
        //     HREmailParameters.Subject, 'Dear' + ' ' + PayrollEmp."First Name" + ' ' +
        //     HREmailParameters.Body + ' ' + "Application Code" + ' ' + HREmailParameters."Body 2", TRUE);
        //     SMTP.Send();


        //     MESSAGE('Leave applicant has been notified successfully');
        // END;
    end;



    procedure CalcEndDate(SDate: Date; LDays: Integer) LEndDate: Date
    var
        EndLeave: Boolean;
        DayCount: Integer;
        ltype: Record "HR Leave Types";
    begin
        ltype.RESET;
        IF ltype.GET("Leave Type") THEN BEGIN
        END;
        SDate := SDate - 1;
        EndLeave := FALSE;
        WHILE EndLeave = FALSE DO BEGIN
            IF NOT DetermineIfIsNonWorking(SDate, ltype) THEN
                DayCount := DayCount + 1;
            SDate := SDate + 1;
            IF DayCount > LDays THEN
                EndLeave := TRUE;
        END;
        LEndDate := SDate - 1;
        WHILE DetermineIfIsNonWorking(LEndDate, ltype) = TRUE DO BEGIN
            LEndDate := LEndDate + 1;
        END;
    end;

    procedure CalcReturnDate(EndDate: Date) RDate: Date
    var
        EndLeave: Boolean;
        DayCount: Integer;
        LEndDate: Date;
        ltype: Record "HR Leave Types";
    begin
        IF ltype.GET("Leave Type") THEN BEGIN
        END;
        RDate := EndDate + 1;
        WHILE DetermineIfIsNonWorking(RDate, ltype) = TRUE DO BEGIN
            RDate := RDate + 1;
        END;
    end;

    PROCEDURE CalculateReturnDate(VAR StartDate: Date; DaysApplied: Integer) ReturnDate: Date;
    VAR
        BaseCalendar: Record "Base Calendar Change";
        WorkingDaysCount: Integer;
    BEGIN
        WorkingDaysCount := 0;
        ReturnDate := StartDate;

        // Ensure base calendar is sorted by date
        IF BaseCalendar.FINDSET THEN BEGIN
            REPEAT
                IF BaseCalendar.Date >= StartDate THEN BEGIN
                    // Check if it's a working day
                    IF NOT BaseCalendar.Nonworking THEN BEGIN
                        WorkingDaysCount += 1;
                        IF WorkingDaysCount = DaysApplied THEN BEGIN
                            EXIT(BaseCalendar.Date); // Found the return date
                        END;
                    END;
                END;
            UNTIL BaseCalendar.NEXT = 0;
        END;

        ERROR('Unable to calculate return date. Check base calendar setup.');
    END;


    procedure GetDate(var Applied_Dayes: Integer; var Start_Date: Date)
    var
        DaysCount: Integer;
        NewDate: Date;
        Last_is_WotkingDay: Boolean;
    begin
    end;

    procedure ItsHolliday(var Start_Date: Date) holliday: Boolean
    var
        baseCal: Record "Base Calendar Change";
        days: Integer;
        Months: Integer;
        bool_Non_Working: Boolean;
    begin
        CLEAR(days);
        CLEAR(Months);
        CLEAR(bool_Non_Working);
        days := DATE2DMY(Start_Date, 1);
        Months := DATE2DMY(Start_Date, 2);
        baseCal.RESET;
        baseCal.SETFILTER(baseCal."Recurring System", '=%1', baseCal."Recurring System"::"Annual Recurring");
        IF baseCal.FIND('-') THEN BEGIN
            REPEAT
                IF ((Months = DATE2DMY(baseCal.Date, 1)) AND (days = DATE2DMY(baseCal.Date, 1))) THEN bool_Non_Working := TRUE;
            UNTIL ((((Months = DATE2DMY(baseCal.Date, 1)) AND (days = DATE2DMY(baseCal.Date, 1)))) OR (baseCal.NEXT = 0))
        END;
    end;

    procedure ItsSunday(var Start_Date: Date; var LeaveType: Integer)
    var
        leave_types: Record "HR Leave Types";
        dates: Record Date;
    begin
    end;

}

