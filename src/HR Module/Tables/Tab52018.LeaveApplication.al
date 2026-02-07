table 52018 "Leave Application"
{
    DataClassification = CustomerContent;
    Caption = 'Leave Application';
    fields
    {
        field(1; "Employee No"; Code[20])
        {
            NotBlank = false;
            TableRelation = "HR Employees"."No.";
            Caption = 'Employee No';

            trigger OnValidate()
            begin


                if EmployeeRec.Get("Employee No") then begin
                    "Employee Name" := EmployeeRec.FullName();
                    "Date of Joining Company" := EmployeeRec."Date Of Join";
                    "Shortcut Dimension 1 Code" := EmployeeRec."Global Dimension 1 Code";
                    "Shortcut Dimension 2 Code" := EmployeeRec."Global Dimension 2 Code";
                    "Mobile No" := EmployeeRec."Phone No.";
                    "Email Adress" := LowerCase(employeerec."Company E-Mail");// Convert to lower case

                end;


            end;
        }
        field(2; "Application No"; Code[20])
        {
            NotBlank = false;
            Caption = 'Application No';

            trigger OnValidate()
            begin
                "Application Date" := Today;
                if "Application No" <> xRec."Application No" then begin
                    HumanResSetup.Get();
                    // NoSeriesMgt.TestManual(HumanResSetup."Leave Application Nos.");
                    "No. series" := '';
                end;
            end;
        }
        field(3; "Leave Code"; Code[20])
        {
            TableRelation = "Leave Type".Code where(Status = const(Active));
            Caption = 'Leave Type';

            trigger OnValidate()
            var
                LeaveApplication: Record "Leave Application";
                OpenPendingLeaveErr: Label 'You have an open/pending %1 leave application %2. Kindly process that one before creating a new one';
                LeavePeriods: Record "Leave Period";
            // HRMgt: Codeunit "HR Management";
            begin
                "Leave Entitlment" := 0;

                if xRec.Status <> Status::Open then
                    Error('You cannot change a document an approved document');


                if EmployeeRec.Get("Employee No") then begin
                    LeaveTypes.Get("Leave Code");

                    if LeaveTypes.Gender = LeaveTypes.Gender::Female then
                        if EmployeeRec."Gender." = EmployeeRec."Gender."::Male then
                            Error('%1 can only be assigned to %2 employees', LeaveTypes.Description, LeaveTypes.Gender);

                    if LeaveTypes.Gender = LeaveTypes.Gender::Male then
                        if EmployeeRec."Gender." = EmployeeRec."Gender."::Female then
                            Error('%1 can only be assigned to %2 employees', LeaveTypes.Description, LeaveTypes.Gender);

                    "Date of Joining Company" := EmployeeRec."Date Of Join";

                    // /////addedd//////
                    // HRMgt.GetCurrentLeavePeriodRecord(LeavePeriods);
                    // EmployeeRec.SetRange("Leave Type Filter", "Leave Code");
                    // EmployeeRec.SetRange("Leave Period Filter", LeavePeriods."Leave Period Code");
                    // /////////////////


                    "Leave Earned to Date" := HRManagement.GetLeaveDaysEarnedToDate(employeerec, "Leave Code");

                    // if GuiAllowed then

                    //HRmgt.GetLeaveEntitlement(EmployeeRec, LeaveTypes, "Leave Entitlment", "Leave Earned to Date");
                end;
            end;
        }
        field(4; "Days Applied"; Decimal)
        {
            Caption = 'Days Applied';

            trigger OnValidate()
            var
                LeaveEarnedToDateErr: Label 'You can not apply for more days than %1 No. of days earned to date';
            begin
                if xRec.Status <> Status::Open then
                    Error('You cannot change a document an approved document');

                if "Days Applied" < 1 then
                    Error(Error009);

                TestField("Leave Code");
                CalcFields("Leave Balance");

                if GuiAllowed then begin
                    if "Days Applied" > "Leave Earned to Date" then
                        Message(LeaveEarnedToDateErr, "Leave Earned to Date");

                    if "Days Applied" > "Leave Balance" then
                        Message(Error008);
                end;

                Validate("Start Date");
                Validate("Leave Code");
                CalcFields("Leave Balance");
                "Annual Leave Entitlement Bal" := "Leave Balance";

                if LeaveTypes.Get("Leave Code") then
                    if LeaveTypes."Annual Leave" then
                        "Annual Leave Entitlement Bal" := "Leave Balance" + -"Days Applied"
                    else
                        "Annual Leave Entitlement Bal" := "Leave Balance";
            end;
        }
        field(5; "Start Date"; Date)
        {
            Caption = 'Start Date';

            trigger OnValidate()
            var
                BaseCalenderCode: Code[10];
            begin
                LeaveLedger.Reset();
                LeaveLedger.SetRange("Staff No.", "Employee No");
                LeaveLedger.SetRange("Leave Entry Type", LeaveLedger."Leave Entry Type"::Negative);
                LeaveLedger.SetRange(Closed, false);
                if LeaveLedger.FindLast() then
                    if (LeaveLedger."Leave End Date" > "Start Date") and (LeaveLedger."Leave Start Date" < "Start Date") then
                        Error('You have a running %1 leave ending on %2', LeaveLedger."Leave Type", LeaveLedger."Leave End Date");

                if xRec.Status <> Status::Open then
                    Error('You cannot change a document an approved document');

                HumanResSetup.Get();
                HumanResSetup.TestField(HumanResSetup."Default Base Calendar");

                //Get employee base calendar
                EmployeeRec.Get("Employee No");
                if EmployeeRec."Base Calendar" <> '' then
                    BaseCalenderCode := EmployeeRec."Base Calendar"
                else
                    BaseCalenderCode := HumanResSetup."Default Base Calendar";

                NoOfWorkingDays := 0;
                if "Days Applied" <> 0 then
                    if "Start Date" <> 0D then begin
                        NextWorkingDate := "Start Date";
                        repeat
                            if not HRmgt.CheckNonWorkingDay(BaseCalenderCode, NextWorkingDate, Description) then
                                NoOfWorkingDays := NoOfWorkingDays + 1;

                            if LeaveTypes.Get("Leave Code") then begin
                                if LeaveTypes."Inclusive of Holidays" then begin
                                    BaseCalendar.Reset();
                                    BaseCalendar.SetRange(BaseCalendar."Base Calendar Code", BaseCalenderCode);
                                    BaseCalendar.SetRange(BaseCalendar.Date, NextWorkingDate);
                                    BaseCalendar.SetRange(BaseCalendar.Nonworking, true);
                                    BaseCalendar.SetRange(BaseCalendar."Recurring System", BaseCalendar."Recurring System"::"Annual Recurring");
                                    if BaseCalendar.Find('-') then
                                        NoOfWorkingDays := NoOfWorkingDays + 1;
                                end;

                                if LeaveTypes."Inclusive of Saturday" then begin
                                    BaseCalender.Reset();
                                    BaseCalender.SetRange(BaseCalender."Period Type", BaseCalender."Period Type"::Date);
                                    BaseCalender.SetRange(BaseCalender."Period Start", NextWorkingDate);
                                    BaseCalender.SetRange(BaseCalender."Period No.", 6);

                                    if BaseCalender.Find('-') then
                                        NoOfWorkingDays := NoOfWorkingDays + 1;
                                end;


                                if LeaveTypes."Inclusive of Sunday" then begin
                                    BaseCalender.Reset();
                                    BaseCalender.SetRange(BaseCalender."Period Type", BaseCalender."Period Type"::Date);
                                    BaseCalender.SetRange(BaseCalender."Period Start", NextWorkingDate);
                                    BaseCalender.SetRange(BaseCalender."Period No.", 7);
                                    if BaseCalender.Find('-') then
                                        NoOfWorkingDays := NoOfWorkingDays + 1;
                                end;


                                if LeaveTypes."Off/Holidays Days Leave" then;

                            end;

                            NextWorkingDate := CalcDate('1D', NextWorkingDate);
                        until NoOfWorkingDays = "Days Applied";
                        "End Date" := NextWorkingDate - 1;
                        "Resumption Date" := NextWorkingDate;
                    end;

                //check if the date that the person is supposed to report back is a working day or not
                //get base calendar to use
                NonWorkingDay := false;
                if "Start Date" <> 0D then
                    while NonWorkingDay = false
                      do begin
                        NonWorkingDay := HRmgt.CheckNonWorkingDay(HumanResSetup."Default Base Calendar", "Resumption Date", Dsptn);
                        if NonWorkingDay then begin
                            NonWorkingDay := false;
                            "Resumption Date" := CalcDate('1D', "Resumption Date");
                        end
                        else
                            NonWorkingDay := true;
                    end;

                //New Joining Employees

                /* if "Date of Joining Company" > "Fiscal Start Date" then begin

                    if "Date of Joining Company" <> 0D then begin
                        NoofMonthsWorked := 0;
                        Nextmonth := "Date of Joining Company";
                        repeat
                            Nextmonth := CalcDate('1M', Nextmonth);
                            NoofMonthsWorked := NoofMonthsWorked + 1;
                        until Nextmonth >= "Start Date";
                        NoofMonthsWorked := NoofMonthsWorked - 1;
                        "No. of Months Worked" := NoofMonthsWorked;

                        if LeaveTypes.Get("Leave Code") then
                            "Leave Earned to Date" := Round(((LeaveTypes.Days / 12) * NoofMonthsWorked), 1, '<');
                        //"Leave Entitlment" := "Leave Earned to Date";
                        Validate("Leave Code");
                    end;
                end; */
            end;
        }
        field(6; "End Date"; Date)
        {
            Caption = 'End Date';

            trigger OnValidate()
            begin
                if xRec.Status <> Status::Open then
                    Error('You cannot change a document an approved document');

                Validate("Start Date");
                Validate("Leave Code");
            end;
        }
        field(7; "Application Date"; Date)
        {
            Editable = false;
            Caption = 'Application Date';

            trigger OnValidate()
            begin
                if "Leave Code" <> '' then
                    Validate("Leave Code");
            end;
        }
        field(8; "Approved Days"; Decimal)
        {
            Caption = 'Approved Days';

            trigger OnValidate()
            begin
                days := "Approved Days";
            end;
        }
        field(9; "Approved Start Date"; Date)
        {
            Caption = 'Approved Start Date';
        }
        field(10; "Verified By Manager"; Boolean)
        {
            Caption = 'Verified By Manager';

            trigger OnValidate()
            begin
                "Verification Date" := Today;
            end;
        }
        field(11; "Verification Date"; Date)
        {
            Caption = 'Verification Date';
        }
        field(12; "Leave Status"; Option)
        {
            OptionCaption = 'Being Processed,Approved,Rejected,Canceled';
            OptionMembers = "Being Processed",Approved,Rejected,Canceled;
            Caption = 'Leave Status';

            trigger OnValidate()
            begin

                if ("Leave Status" = "Leave Status"::Approved)/* AND (xRec."Leave Status" <> "Leave Status"::Approved)*/ then begin
                    "Approval Date" := Today;
                    "Leave Balance" := "Leave Balance" - "Approved Days";
                    "Balance brought forward" := "Balance brought forward";
                end
                else
                    if ("Leave Status" <> "Leave Status"::Approved) and (xRec."Leave Status" = "Leave Status"::Approved) then
                        "Approval Date" := Today;
            end;
        }
        field(13; "Approved End Date"; Date)
        {
            Caption = 'Approved End Date';
        }
        field(14; "Approval Date"; Date)
        {
            Caption = 'Approval Date';
        }
        field(15; Comments; Text[250])
        {
            Caption = 'Comments';
        }
        field(16; Taken; Boolean)
        {
            Caption = 'Taken';
        }
        field(17; "Acrued Days"; Decimal)
        {
            Caption = 'Acrued Days';
        }
        field(18; "Over used Days"; Decimal)
        {
            Caption = 'Over used Days';
        }
        field(19; "Leave Allowance Payable"; Boolean)
        {
            Caption = 'Leave Allowance Payable';

            trigger OnValidate()
            var
                EmpRec: Record "HR Employees";
                CurrLeavePeriod: Code[20];
            begin
                if "Leave Allowance Payable" then begin
                    TestField("Days Applied");
                    TestField("Leave Code");
                    TotalQualifiedDays := 0;

                    if LeaveTypes.Get("Leave Code") then
                        if not LeaveTypes."Annual Leave" then
                            error('Leave Allowance is only applicable for Annual Leave applications');

                    HumanResSetup.Get();
                    if HumanResSetup."Qualification Days (Leave)" <= 0 then
                        Error('%1 must have a value', StrSubstNo(HumanResSetup.FieldCaption("Qualification Days (Leave)")));

                    HRmgt.CheckIfLeaveAllowanceExists(Rec);

                    /* if emp.Get("Employee No") then begin
                        if emp."Employment Type" <> emp."Employment Type"::Permanent then
                            Error('Only Applicable to Permanent Employees');
                    end; */
                    CurrLeavePeriod := HRmgt.GetCurrentLeavePeriodCode();

                    EmpRec.SetRange("No.", "Employee No");
                    EmpRec.SetRange("Leave Period Filter", CurrLeavePeriod);
                    EmpRec.Setrange("Leave Type Filter", "Leave Code");
                    if EmpRec.FindFirst() then
                        EmpRec.Calcfields("Leave Days Taken", "Leave Balance Brought Forward");

                    TotalQualifiedDays := ((EmpRec."Leave Days Taken" + "Days Applied") - EmpRec."Leave Balance Brought Forward");
                    if TotalQualifiedDays < HumanResSetup."Qualification Days (Leave)" then
                        Error('You can only be paid leave allowance if you have taken %1 or more Days.\Your total qualifying days taken = %2', HumanResSetup."Qualification Days (Leave)", TotalQualifiedDays);
                end;
            end;
        }
        field(20; Post; Boolean)
        {
            Caption = 'Post';
        }
        field(21; days; Decimal)
        {
            Caption = 'days';
        }
        field(23; "No. series"; Code[10])
        {
            Caption = 'No. series';
        }
        field(24; "Leave Balance"; Decimal)
        {
            CalcFormula = sum("HR Leave Ledger Entries Lv"."No. of days" where("Staff No." = field("Employee No"),
                                                                             "Leave Type" = field("Leave Code"),
                                                                             Closed = const(false)));
            FieldClass = FlowField;
            Caption = 'Leave Balance';

        }
        field(25; "Resumption Date"; Date)
        {
            Caption = 'Resumption Date';
        }
        field(26; "Employee Name"; Text[100])
        {
            Caption = 'Employee Name';
        }
        field(27; Status; Option)
        {
            Editable = true;
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment",Rejected;
            Caption = 'Status';

            trigger OnValidate()
            begin
                if Status = Status::Released then
                    "Approval Date" := Today;
            end;
        }
        field(28; "Leave Entitlment"; Decimal)
        {
            Caption = 'Leave Entitlment';
        }
        field(29; "Total Leave Days Taken"; Decimal)
        {
            CalcFormula = - sum("HR Leave Ledger Entries Lv"."No. of days" where("Staff No." = field("Employee No"),
                                                                              "Leave Type" = field("Leave Code"),
                                                                              Closed = const(false),
                                                                              "Leave Entry Type" = const(Negative)));
            FieldClass = FlowField;
            Caption = 'Total Leave Days Taken';
        }
        field(30; "Duties Taken Over By"; Code[20])
        {
            TableRelation = Employee;
            Caption = 'Duties Taken Over By';

            trigger OnValidate()
            begin
                if xRec.Status <> Status::Open then
                    Error('You cannot change a document an approved document');

                if EmployeeRec.Get("Employee No") then begin
                    EmployeeRec.SetRange("No.", "Duties Taken Over By");
                    if EmployeeRec.Find('-') then
                        if "Duties Taken Over By" = "Employee No" then
                            Error('You Cannot take duties over for yourself')
                        else
                            "Relieving Name" := EmployeeRec."First Name" + ' ' + EmployeeRec."Middle Name" + ' ' + EmployeeRec."Last Name";
                end;
            end;
        }
        field(31; Name; Text[50])
        {
            Caption = 'Name';
        }
        field(32; "Mobile No"; Code[30])
        {
            Caption = 'Mobile No';
        }
        field(33; "Balance brought forward"; Decimal)
        {
            CalcFormula = sum("HR Leave Ledger Entries Lv"."No. of days" where("Staff No." = field("Employee No"),
                                                                                         "Transaction Type" = filter("Leave B/F"),
                                                                                         "Leave Type" = field("Leave Code"),
                                                                                         Closed = const(false)));
            FieldClass = FlowField;
            Caption = 'Balance brought forward';
        }
        field(34; "Leave Earned to Date"; Decimal)
        {
            Caption = 'Leave Earned to Date';
            Editable = false;
        }
        field(35; "Maturity Date"; Date)
        {
            Caption = 'Maturity Date';
        }
        field(36; "Date of Joining Company"; Date)
        {
            Caption = 'Date of Joining Company';
        }
        field(37; "Fiscal Start Date"; Date)
        {
            Caption = 'Fiscal Start Date';
        }
        field(38; "No. of Months Worked"; Decimal)
        {
            Caption = 'No. of Months Worked';
        }
        field(39; "Annual Leave Entitlement Bal"; Decimal)
        {
            FieldClass = Normal;
            Caption = 'Annual Leave Entitlement Bal';
        }
        field(40; "Recalled Days"; Decimal)
        {
            CalcFormula = sum("Employee Off/Holiday"."No. of Off Days" where("Employee No" = field("Employee No")));
            FieldClass = FlowField;
            Caption = 'Recalled Days';
        }
        field(41; "Off Days"; Decimal)
        {
            // CalcFormula = sum("Holiday_Off Days"."No. of Days" where("Employee No." = field("Employee No"),
            //                                                           "Leave Type" = field("Leave Code"),
            //                                                           "Maturity Date" = field("Maturity Date")));
            // FieldClass = FlowField;
            Caption = 'Off Days';
        }
        field(43; "User ID"; Code[25])
        {
            Caption = 'User ID';
        }
        field(44; "No of Approvals"; Integer)
        {
            CalcFormula = count("Approval Entry" where("Table ID" = const(51404832),
                                                        "Document No." = field("Application No")));
            FieldClass = FlowField;
            Caption = 'No of Approvals';
        }
        field(45; "Days Absent"; Decimal)
        {
            CalcFormula = sum("Employee Absence".Quantity where("Employee No." = field("Employee No"),
                                                                 "Affects Leave" = filter(true)));
            FieldClass = FlowField;
            Caption = 'Days Absent';
        }
        field(46; "Contract No."; Integer)
        {
            Caption = 'Contract No.';
        }
        field(47; "Other Contact Name"; Text[50])
        {
            Caption = 'Other Contact Name';
        }
        field(48; "Other Contact Phone"; Text[30])
        {
            Caption = 'Other Contact Phone';
        }
        field(49; "Employee Type"; Option)
        {
            OptionCaption = 'Manager,Employee';
            OptionMembers = Manager,Employee;
            Caption = 'Employee Type';
        }
        field(50; LeaveAdjustments; Decimal)
        {
            Caption = 'LeaveAdjustments';
        }
        field(51; "Relieving Name"; Text[60])
        {
            Caption = 'Relieving Name';
        }
        field(52; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1),
                                                          Blocked = filter(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(53; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2),
                                                          Blocked = filter(false));

            trigger OnValidate()
            begin

                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(54; "Application Time"; Time)
        {
            Caption = 'Application Time';
        }
        field(55; "Leave Period"; Code[20])
        {
            TableRelation = "Leave Period";
            Caption = 'Leave Period';
        }
        field(56; "Employment Type"; Enum "Employment Type")
        {
            CalcFormula = lookup(Employee."Employment Type" where("No." = field("Employee No")));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Employment Type';
        }
        field(57; "Area"; Code[50])
        {
            CalcFormula = lookup(Employee.Area where("No." = field("Employee No")));
            FieldClass = FlowField;
            Caption = 'Area';
        }
        field(58; "Responsibility Center"; Code[50])
        {
            TableRelation = "Responsibility Center";
            Caption = 'Responsibility Center';
        }
        field(59; "Apply on behalf"; Boolean)
        {
            Caption = 'Apply on behalf';
        }
        field(60; "Email Adress"; Code[150])
        {
            Caption = 'Email Adress';
        }
        field(70; "Leave Allowance Paid"; Boolean)
        {
            Caption = 'Leave Allowance Paid';
        }
        field(71; "Posted By"; Code[50])
        {
            Editable = false;
            Caption = 'Posted By';
        }

        field(72; "Posted Date"; Date)
        {
            Editable = false;
            Caption = 'Posted Date';
        }
        field(73; "Leave Type"; Text[200])

        {
            TableRelation = "Leave Type".Description where(Status = const(Active));
            //CalcFormula = lookup("Leave Type".Description where("Code" = field("Application No")));
            CalcFormula = lookup("Leave Application Type"."Leave Type" where("Leave Code" = field("Application No")));//////////
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Application No")
        {
            Clustered = true;
        }
        key(Key2; "Employee No", "Leave Code", Status, "Maturity Date", "Contract No.")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Application No", "Application Date", "Employee No", "Employee Name")
        {
        }
    }

    trigger OnInsert()
    begin

        if "Application No" = '' then begin
            HRSetup.Get();
            HRSetup.TestField("Leave Application Nos.");
            // NoSeriesMgt.InitSeries(HRSetup."Leave Application Nos.", xRec."No. series", 0D, "Application No", "No. series");
        end;

        "Application Date" := Today;
        "Application Time" := Time;
        "User ID" := UserId;

        if GuiAllowed then begin
            UserSertup.Get("User ID");
            UserSertup.TestField("Employee No.");

            EmployeeRec.Get(UserSertup."Employee No.");
            "Employee No" := EmployeeRec."No.";
            "Employee Name" := EmployeeRec.FullName();
            "Mobile No" := EmployeeRec."Phone No.";
            "Shortcut Dimension 1 Code" := EmployeeRec."Global Dimension 1 Code";
            "Shortcut Dimension 2 Code" := EmployeeRec."Global Dimension 2 Code";
            "Responsibility Center" := EmployeeRec."Responsibility Center";
            // "Email Adress" := EmployeeRec."Company E-Mail";
        end else
            Validate("Employee No");

        FindMaturityDate();
        "Maturity Date" := MaturityDate;
        "Fiscal Start Date" := FiscalStart;
        CalcFields("Employment Type");
        "Leave Period" := HRmgt.GetCurrentLeavePeriodCode();
    end;

    trigger OnRename()
    begin

        if Post = true then
            Error(Error007);
    end;

    var
        BaseCalendar: Record "Base Calendar Change";
        BaseCalender: Record Date;
        EmployeeRec: Record "HR Employees";
        LeaveLedger: Record "HR Leave Ledger Entries";
        HRSetup: Record "Human Resources Setup";
        HumanResSetup: Record "Human Resources Setup";
        LeaveTypes: Record "Leave Type";
        UserSertup: Record "User Setup";
        DimMgt: Codeunit DimensionManagement;
        HRmgt: Codeunit "HR Management";
        //NoSeriesMgt: Codeunit NoSeriesManagement;
        NonWorkingDay: Boolean;
        FiscalStart: Date;
        MaturityDate: Date;
        NextWorkingDate: Date;
        TotalQualifiedDays: Decimal;
        NoOfWorkingDays: Integer;
        Error007: Label 'You cannot Rename the Record';
        Error008: Label 'The Number of Days applied is more than your Leave Days Balance ';
        Error009: Label 'You cannot take a Leave less than 1 Day';
        Description: Text[30];
        Dsptn: Text[30];
        HRManagement: Codeunit "HR Management";
        LeaveEarnedToDate: Decimal;


    procedure FindMaturityDate()
    var
        AccPeriod: Record "Payroll Period";
    begin
        AccPeriod.Reset();
        AccPeriod.SetRange("Starting Date", 0D, Today);
        AccPeriod.SetRange("New Fiscal Year", true);
        if AccPeriod.Find('+') then begin
            FiscalStart := AccPeriod."Starting Date";
            MaturityDate := CalcDate('1Y', AccPeriod."Starting Date") - 1;
        end;
    end;

    local procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        DimMgt.SaveDefaultDim(Database::"Leave Application", "Employee No", FieldNumber, ShortcutDimCode);
        Modify();
    end;


    // procedure GetLeaveEarnedToDate(LeaveTypeCode: Code[20])
    // var
    //     HRManagement: Codeunit "HR Management";
    //     LeaveEarnedToDate: Decimal;
    // begin
    //     LeaveEarnedToDate := HRManagement.GetLeaveDaysEarnedToDate(Rec, LeaveTypeCode);
    // end;
}


