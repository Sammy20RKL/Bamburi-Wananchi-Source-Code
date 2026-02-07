codeunit 52001 "HR Management"
{
    procedure LeaveApplication(LeaveAppNo: Code[20])
    var
        Employee: Record "HR Employees";
        LeaveLedg: Record "HR Leave Ledger Entries Lv";
        LeaveApp: Record "Leave Application";
        leaveline: Record "Leave Application Type";
    begin
        LeaveApp.Get(LeaveAppNo);
        Employee.Get(LeaveApp."Employee No");
        Employee.SetRange("Leave Type Filter", LeaveApp."Leave Code");
        Employee.SetRange("Leave Period Filter", LeaveApp."Leave Period");
        Employee.CalcFields("Leave Balance Brought Forward");

        leaveline.Reset();
        leaveline.SetRange(leaveline."Leave Code", LeaveAppNo);
        if leaveline.Find('-') then
            repeat
                if leaveline."Leave Code" <> LeaveApp."Application No" then
                    Message('The Leave Code %1 does not match the one selected in the application %2', leaveline."Leave Code", LeaveApp."Leave Code");
                LeaveLedg.Init();
                LeaveLedg."Entry No." := LeaveLedg.GetNextEntryNo();
                LeaveLedg."Document No." := LeaveAppNo;
                LeaveLedg."Leave Type" := leaveline."Leave Type";
                LeaveLedg."Leave Start Date" := leaveline."Start Date";
                LeaveLedg."Leave End Date" := leaveline."End Date";
                LeaveLedg."Leave Return Date" := leaveline."Resumption Date";
                LeaveLedg."Leave Approval Date" := Today;
                LeaveLedg."Leave Date" := Today;
                LeaveLedg."Leave Period" := GetLeavePeriod(leaveline."Start Date");
                LeaveLedg."Leave Application No." := leaveline."Leave Code";
                LeaveLedg."Leave Posting Description" := 'Leave Application';

                LeaveLedg."Transaction Type" := LeaveLedg."Transaction Type"::"Leave Application";
                LeaveLedg."Leave Entry Type" := LeaveLedg."Leave Entry Type"::Negative;

                LeaveLedg."User ID" := LeaveApp."User ID";
                if LeaveLedg."Leave Entry Type" = LeaveLedg."Leave Entry Type"::Negative then
                    LeaveLedg."No. of days" := -leaveline."Days Applied"
                else
                    LeaveLedg."No. of days" := leaveline."Days Applied";
                LeaveLedg."Staff No." := leaveline."Employee No";
                LeaveLedg."Staff Name" := CopyStr(leaveline."Employee Name", 1, MaxStrLen(LeaveLedg."Staff Name"));
                LeaveLedg."Job ID" := Employee."Job Position";
                LeaveLedg."Job Group" := CopyStr(Employee."Salary Scale", 1, MaxStrLen(LeaveLedg."Job Group"));
                LeaveLedg."Contract Type" := CopyStr(Employee."Nature of Employment", 1, MaxStrLen(LeaveLedg."Contract Type"));
                LeaveLedg."Global Dimension 1 Code" := Employee."Global Dimension 1 Code";
                LeaveLedg."Global Dimension 2 Code" := Employee."Global Dimension 2 Code";
                LeaveLedg."Leave Period Code" := leaveline."Leave Period"; //Leav."Leave Period";
                if LeaveLedg."No. of days" <> 0 then
                    LeaveLedg.Insert();
            until leaveline.Next() = 0;
        Message('Status is %1', LeaveApp.Status);
    end;

    procedure NotifyLeaveReliever(ApplicationNo: Code[20])
    var
        CompanyInfo: Record "Company Information";
        Employee: Record "HR Employees";
        HRSetup: Record "Human Resources Setup";
        LeaveApp: Record "Leave Application";
        LeaveRelievers: Record "Leave Application Type";
        UserSetup: Record "User Setup";
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        i: Integer;
        ApplicantMsg: Label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear %1,<br><br></p><p style="font-family:Verdana,Arial;font-size:10pt"> Your leave application <Strong>%2</Strong> for <Strong>%3</Strong> has been Approved. You can proceed from <Strong>%4</Strong> to <Strong>%5</Strong> and you are to resume work on <Strong>%6</Strong>. Your duties will be taken over by <Strong>%7 - %8</Strong>.<br><br>Thank you.<br><br>Kind regards,<br><br><Strong>%9<Strong></p>', Comment = '%1 = Employee Name, %2 = Application No, %3 = Leave Type, %4 = Start Date, %5 = End Date, %6 = Resumption Date, %7 = Reliever Name, %8 = Reliever Position, %9 = Company Name';
        HODMsg: Label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear %1,<br><br></p><p style="font-family:Verdana,Arial;font-size:10pt"> This is to notify you that Employee <Strong>%2 - %3</Strong> will be going on leave from <Strong>%4</Strong> to <Strong>%5</Strong> and will be resuming work on <Strong>%6</Strong>. Their duties will be taken over by <Strong>%7</Strong>.<br><br>Thank you.<br><br>Kind regards,<br><br><Strong>%8</Strong></p>', Comment = '%1 = Employee Name, %2 = Employee No, %3 = Employee Name, %4 = Start Date, %5 = End Date, %6 = Resumption Date, %7 = Reliever Name, %8 = Reliever Position, %9 = Company Name';
        RelievingEmpMsg: Label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear %1,<br><br></p><p style="font-family:Verdana,Arial;font-size:10pt">This is to Notify you that <Strong>%2 - %3</Strong> is going on Leave from <Strong>%4</Strong>.  to <Strong>%5</Strong>. You will be taking over their duties from <Strong>%4</Strong>  to <Strong>%5</Strong>. <br><br>Thank you.<br><br>Kind Regards,<br><br><Strong>%6. </Strong></p>', Comment = '%1 = Employee Name, %2 = Employee No, %3 = Employee Name, %4 = Start Date, %5 = End Date, %6 = Company Name';
        SpaceLbl: Label '  ';
        Receipient: List of [Text];
        RecipientCC: List of [Text];
        FormattedApplicantBody: Text;
        FormattedHODBody: Text;
        FormattedRelieverBody: Text;
        Relievers: Text;
        SenderAddress: Text;
        SenderName: Text;
        Subject: Text;
        TimeNow: Text;
    begin
        HRSetup.Get();

        //Notify Relieving Employee
        if LeaveApp.Get(ApplicationNo) then begin
            LeaveRelievers.Reset();
            LeaveRelievers.SetRange("Leave Code", ApplicationNo);
            if LeaveRelievers.FindSet() then
                repeat
                    Employee.Reset();
                    if Employee.Get(LeaveRelievers."Staff No") then
                        if Employee."E-Mail" <> '' then begin
                            CompanyInfo.Get();
                            CompanyInfo.TestField(Name);
                            SenderAddress := CompanyInfo."E-Mail";
                            SenderName := CompanyInfo.Name;
                            Clear(Receipient);
                            Receipient.Add(Employee."E-Mail");
                            Subject := ('Relieving - ' + SpaceLbl + LeaveApp."Employee No" + SpaceLbl + LeaveApp."Employee Name");
                            TimeNow := Format(Time);
                            FormattedRelieverBody := StrSubstNo(RelievingEmpMsg, Employee."First Name", LeaveApp."Employee No", LeaveApp."Employee Name", LeaveApp."Start Date", LeaveApp."End Date", CompanyInfo.Name);
                            EmailMessage.Create(Receipient, Subject, FormattedRelieverBody, true, RecipientCC, RecipientCC);
                            Email.Send(EmailMessage);
                        end;
                until LeaveRelievers.Next() = 0;

        end;
        //Get Relievers
        if LeaveApp.Get(ApplicationNo) then begin
            LeaveRelievers.Reset();
            LeaveRelievers.SetRange("Leave Code", ApplicationNo);
            if LeaveRelievers.FindSet() then begin
                i := 1;
                repeat
                    if i = 1 then
                        Relievers := LeaveRelievers."Staff Name"
                    else
                        Relievers := Relievers + ', ' + LeaveRelievers."Staff Name";

                    i := i + 1;

                until LeaveRelievers.Next() = 0;
            end;
        end;

        //Notify Employee
        if LeaveApp.Get(ApplicationNo) then begin
            Employee.Reset();
            if Employee.Get(LeaveApp."Employee No") then
                if Employee."E-Mail" <> '' then begin
                    CompanyInfo.Get();
                    CompanyInfo.TestField(Name);
                    SenderAddress := CompanyInfo."E-Mail";
                    SenderName := CompanyInfo.Name;
                    Clear(Receipient);
                    Receipient.Add(Employee."E-Mail");
                    Subject := ('Leave Application - ' + SpaceLbl + LeaveApp."Application No");
                    TimeNow := Format(Time);
                    FormattedApplicantBody := StrSubstNo(ApplicantMsg, Employee."First Name", LeaveApp."Application No", GetLeaveName(LeaveApp."Leave Code"), LeaveApp."Start Date", LeaveApp."End Date", LeaveApp."Resumption Date", LeaveApp."Duties Taken Over By",
                                                Relievers, CompanyInfo.Name);
                    EmailMessage.Create(Receipient, Subject, FormattedApplicantBody, true, RecipientCC, RecipientCC);
                    Email.Send(EmailMessage);
                end;
        end;


        //Notify HOD
        if LeaveApp.Get(ApplicationNo) then begin
            UserSetup.Reset();
            UserSetup.SetRange("Global Dimension 1 Code", LeaveApp."Shortcut Dimension 1 Code");
            UserSetup.SetRange("Global Dimension 2 Code", LeaveApp."Shortcut Dimension 2 Code");
            UserSetup.SetRange("HOD User", true);
            if UserSetup.FindFirst() then
                if Employee.Get(UserSetup."Employee No.") then
                    if Employee."E-Mail" <> '' then begin
                        CompanyInfo.Get();
                        CompanyInfo.TestField(Name);
                        SenderAddress := CompanyInfo."E-Mail";
                        SenderName := CompanyInfo.Name;
                        Clear(Receipient);
                        Receipient.Add(Employee."E-Mail");
                        Subject := ('Employee - ' + SpaceLbl + LeaveApp."Employee No" + SpaceLbl + '-' + SpaceLbl + LeaveApp."Employee Name" + SpaceLbl + 'Leave');
                        TimeNow := Format(Time);
                        FormattedHODBody := StrSubstNo(HODMsg, Employee."First Name", LeaveApp."Employee No", LeaveApp."Employee Name", LeaveApp."Start Date", LeaveApp."End Date",
                                        LeaveApp."Resumption Date", Relievers, CompanyInfo.Name);
                        EmailMessage.Create(Receipient, Subject, FormattedHODBody, true);
                        Email.Send(EmailMessage);
                    end;
        end;
    end;

    procedure GetLeaveName(LeaveCode: Code[30]): Text[250]
    var
        LeaveType: Record "Leave Type";
    begin
        if LeaveType.Get(LeaveCode) then
            exit(LeaveType.Description);
        //MESSAGE(LeaveType.Description);
    end;

    procedure NotifyLeaveApplicantOnRejection(Leave: Record "Leave Application")
    var
        CompanyInfo: Record "Company Information";
        Employee: Record "HR Employees";
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        RecallMsg: Label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear %1,<br><br></p><p style="font-family:Verdana,Arial;font-size:10pt"> This is to inform you that your leave that was to run from <Strong>%2</Strong> to <Strong>%3</Strong> has been rejected. <br>Please refer to the rejection comments posted by your approver. <br>  <br><br> Thank you for your cooperation.<br><br>Kind regards,<br>Human Resource Department<br><Strong>%4<Strong></p>', Comment = '%1 = Employee Name, %2 = Start Date, %3 = End Date, %4 = Company Name';
        Receipient: List of [Text];
        FormattedBody: Text;
        Subject: Text;
        TimeNow: Text;
    begin
        Employee.Reset();
        if Employee.Get(Leave."Employee No") then begin
            Employee.TestField("E-Mail");
            Clear(Receipient);
            CompanyInfo.Get();
            CompanyInfo.TestField(Name);
            Receipient.Add(Employee."E-Mail");
            Subject := 'Leave Recall';
            TimeNow := Format(Time);
            FormattedBody := StrSubstNo(RecallMsg, (Employee."First Name" + ' ' + Employee."Last Name"),
                                        Format(Leave."Start Date", 0, '<Weekday Text> <Day> <Month Text> <Year4>'),
                                          Format(Leave."End Date", 0, '<Weekday Text> <Day> <Month Text> <Year4>'),
                                           CompanyInfo.Name);
            EmailMessage.Create(Receipient, Subject, FormattedBody, true);
            Email.Send(EmailMessage);
        end;
    end;

    procedure GetLeaveLiability(Employee: Record "HR Employees"; var LeaveEarnedToDate: Decimal): Decimal
    var
        BaseCalendar: Record "Base Calendar";
        CompanyInfo: Record "Company Information";
        EmpRec: Record "HR Employees";
        HRSetup: Record "Human Resources Setup";
        LeavePeriod: Record "Leave Period";
        LeaveTypes: Record "Leave Type";
        //PayrollMgt: Codeunit Payroll;
        CurrLeavePeriod: Code[20];
        PayrollPeriod: Date;
        EmpBasic: Decimal;
        LeaveLiability: Decimal;
        WorkingDays: Integer;
    begin
        HRSetup.Get();
        if HRSetup."Compute Leave Liability" then begin
            LeaveEarnedToDate := 0;
            LeaveLiability := 0;
            EmpBasic := 0;
            WorkingDays := 0;

            CompanyInfo.Get();
            CompanyInfo.TestField("Base Calendar Code");

            // PayrollPeriod := PayrollMgt.GetCurrentPayPeriodDate();

            LeavePeriod.SetRange(Closed, false);
            if not LeavePeriod.IsEmpty() then;

            BaseCalendar.Get(CompanyInfo."Base Calendar Code");

            /*BaseCalendarLines.Reset();
            BaseCalendarLines.SetRange("Base Calendar Code", BaseCalendar.Code);
            BaseCalendarLines.SetRange(Date, LeavePeriod."Start Date", LeavePeriod."End Date");
            BaseCalendarLines.SetRange(Nonworking, false);
            WorkingDays := BaseCalendarLines.Count;*/

            /* DateRec.Reset();
             DateRec.SetRange("Period Type", DateRec."Period Type"::Date);
             DateRec.SetRange("Period Start", LeavePeriod."Start Date");
             DateRec.SetRange("Period End", LeavePeriod."End Date");
             DateRec.SetFilter("Period No.", '%1..%2', 1, 5);
             WorkingDays := DateRec.Count();*/

            WorkingDays := 22;
            // EmpBasic := PayrollMgt.GetCurrentBasicPay(Employee."No.", PayrollPeriod);

            LeaveTypes.SetRange("Annual Leave", true);
            if LeaveTypes.FindFirst() then;

            LeaveEarnedToDate := GetLeaveDaysEarnedToDate(Employee, LeaveTypes.Code);

            CurrLeavePeriod := GetCurrentLeavePeriodCode();

            EmpRec.SetRange("No.", Employee."No.");
            EmpRec.SetRange("Leave Period Filter", CurrLeavePeriod);
            EmpRec.SetRange("Leave Type Filter", LeaveTypes.Code);
            EmpRec.CalcFields("Leave Days Taken");

            LeaveEarnedToDate := LeaveEarnedToDate - Abs(EmpRec."Leave Days Taken");

            if EmpBasic > 0 then
                LeaveLiability := (EmpBasic / WorkingDays) * LeaveEarnedToDate
            else
                LeaveLiability := 0;

            LeaveLiability := Round(LeaveLiability, 0.01, '=');
            exit(LeaveLiability);
        end else
            exit(0);
    end;

    procedure LeaveAdjustment("Code": Code[20])
    var
        Employee: Record "HR Employees";
        LeaveLedg: Record "HR Leave Ledger Entries Lv";
        LeaveAdjustHead: Record "Leave Bal Adjustment Header";
        LeaveAdjustLines: Record "Leave Bal Adjustment Lines";
    begin
        LeaveAdjustHead.Get(Code);
        LeaveAdjustLines.SetRange("Header No.", Code);
        if LeaveAdjustLines.FindSet() then begin
            repeat
                LeaveAdjustLines.TestField("Leave Period");
                LeaveAdjustLines.TestField("Leave Code");

                LeaveLedg.Init();
                LeaveLedg."Entry No." := LeaveLedg.GetNextEntryNo();
                LeaveLedg."Document No." := LeaveAdjustLines."Header No.";
                LeaveLedg."Staff No." := CopyStr(LeaveAdjustLines."Staff No.", 1, MaxStrLen(LeaveLedg."Staff No."));
                LeaveLedg."Leave Entry Type" := LeaveAdjustLines."Leave Adj Entry Type";
                LeaveLedg."Leave Period Code" := LeaveAdjustLines."Leave Period";
                if LeaveLedg."Leave Entry Type" = LeaveLedg."Leave Entry Type"::Negative then
                    LeaveLedg."No. of days" := -LeaveAdjustLines."New Entitlement"
                else
                    LeaveLedg."No. of days" := LeaveAdjustLines."New Entitlement";
                if Employee.Get(LeaveLedg."Staff No.") then begin
                    LeaveLedg."Job ID" := Employee."Job Position";
                    LeaveLedg."Job Group" := CopyStr(Employee."Salary Scale", 1, MaxStrLen(LeaveLedg."Job Group"));
                    LeaveLedg."Contract Type" := CopyStr(Employee."Nature of Employment", 1, MaxStrLen(LeaveLedg."Contract Type"));
                    LeaveLedg."Global Dimension 1 Code" := Employee."Global Dimension 1 Code";
                    LeaveLedg."Global Dimension 2 Code" := Employee."Global Dimension 2 Code";
                end;
                LeaveLedg."Staff Name" := CopyStr(LeaveAdjustLines."Employee Name", 1, MaxStrLen(LeaveLedg."Staff Name"));
                LeaveLedg."Leave Type" := CopyStr(LeaveAdjustLines."Leave Code", 1, MaxStrLen(LeaveLedg."Leave Type"));
                LeaveLedg."Leave Period" := GetLeavePeriod(Today());
                LeaveLedg."Leave Date" := Today();
                LeaveLedg."Leave Approval Date" := Today();
                LeaveLedg."No. of days" := LeaveAdjustLines."New Entitlement";
                LeaveLedg."Leave Posting Description" := 'Leave Adjustment';
                /*CASE LeaveAdjustHead."Transaction Type" OF
                  LeaveAdjustHead."Transaction Type"::"Leave Brought Forward":
                    BEGIN
                      LeaveLedg."Balance Brought Forward":=LeaveAdjustLines."New Entitlement";
                      LeaveLedg."Transaction Type":=LeaveLedg."Transaction Type"::"Leave B/F";
                    END;
                  LeaveAdjustHead."Transaction Type"::"Leave Adjustment":
                    LeaveLedg."Transaction Type":=LeaveLedg."Transaction Type"::"Leave Adjustment";
                  ELSE
                    LeaveLedg."Transaction Type":=LeaveLedg."Transaction Type"::"Leave Adjustment";
                END;*/
                LeaveLedg."Transaction Type" := LeaveAdjustLines."Transaction Type";
                LeaveLedg."User ID" := CopyStr(UserId(), 1, MaxStrLen(LeaveLedg."User ID"));
                LeaveLedg.Insert();
            until LeaveAdjustLines.Next() = 0;

            LeaveAdjustHead.Posted := true;
            LeaveAdjustHead."Posted By" := CopyStr(UserId(), 1, MaxStrLen(LeaveAdjustHead."Posted By"));
            LeaveAdjustHead."Posted Date" := Today();
            LeaveAdjustHead.Modify();
            Message('Leave adjustment posted successfully');
        end;

    end;

    procedure GetLeavePeriod(ApplicationDate: Date): Date
    var
        AccPeriod: Record "Accounting Period";
        PeriodStart: Date;

    begin

        AccPeriod.Reset();
        AccPeriod.SetFilter("Starting Date", '>=%1', CalcDate('<-CM>', ApplicationDate));
        if AccPeriod.FindFirst() then
            PeriodStart := AccPeriod."Starting Date";
        exit(PeriodStart);
    end;

    procedure CheckNonWorkingDay(CalendarCode: Code[10]; TargetDate: Date; var Description: Text[50]): Boolean
    var
        BaseCalChange: Record "Base Calendar Change";
    begin
        BaseCalChange.Reset();
        BaseCalChange.SetRange("Base Calendar Code", CalendarCode);
        if BaseCalChange.FindSet() then
            repeat


                case BaseCalChange."Recurring System" of
                    BaseCalChange."Recurring System"::" ":
                        if TargetDate = BaseCalChange.Date then begin
                            Description := BaseCalChange.Description;

                            exit(BaseCalChange.Nonworking);
                        end;
                    BaseCalChange."Recurring System"::"Weekly Recurring":
                        if Date2DWY(TargetDate, 1) = BaseCalChange.Day then begin
                            Description := BaseCalChange.Description;

                            exit(BaseCalChange.Nonworking);
                        end;
                    BaseCalChange."Recurring System"::"Annual Recurring":
                        if (Date2DMY(TargetDate, 2) = Date2DMY(BaseCalChange.Date, 2)) and
                           (Date2DMY(TargetDate, 1) = Date2DMY(BaseCalChange.Date, 1))
                        then begin
                            Description := BaseCalChange.Description;

                            exit(BaseCalChange.Nonworking);
                        end;
                end;
            until BaseCalChange.Next() = 0;
        Description := '';
    end;

    procedure CheckIfLeaveAllowanceExists(LeaveAppRec: Record "Leave Application")
    var
        LeaveAppRec2: Record "Leave Application";
        AllExistsErrorErr: Label 'You have already applied for leave allowance for the period %1', Comment = '%1 = Leave Period';
    begin
        LeaveAppRec2.Reset();
        LeaveAppRec2.SetRange("Employee No", LeaveAppRec."Employee No");
        //LeaveAppRec2.SetRange(Status, LeaveAppRec2.Status::Released);
        LeaveAppRec2.SetRange("Leave Period", LeaveAppRec."Leave Period");
        LeaveAppRec2.SetRange("Leave Allowance Payable", true);
        if not LeaveAppRec2.IsEmpty() then
            Error(AllExistsErrorErr, LeaveAppRec."Leave Period");
    end;

    procedure GetCurrentLeavePeriodCode(): Code[20]
    var
        LeavePeriods: Record "Leave Period";
    begin
        LeavePeriods.Reset();
        LeavePeriods.SetRange(closed, false);
        if LeavePeriods.FindFirst() then
            exit(LeavePeriods."Leave Period Code")
        else
            Error('Please define a new leave period');
    end;

    procedure LeaveRecall(LeaveRecNo: Code[20])
    var
        Employee: Record "HR Employees";
        EmpOff_Holiday: Record "Employee Off/Holiday";
        LeaveLedg: Record "HR Leave Ledger Entries Lv";
        LeaveApp: Record "Leave Application";
    begin
        LeaveLedg.Init();
        LeaveLedg."Entry No." := LeaveLedg.GetNextEntryNo();
        LeaveLedg."Document No." := LeaveRecNo;
        if EmpOff_Holiday.Get(LeaveRecNo) then begin
            LeaveLedg."Leave End Date" := EmpOff_Holiday."Recalled To";
            LeaveLedg."Leave Application No." := EmpOff_Holiday."Leave Application";
            LeaveLedg."Leave Start Date" := EmpOff_Holiday."Recalled From";
            LeaveLedg."Leave Return Date" := EmpOff_Holiday."Recalled From";
            LeaveLedg."Leave Approval Date" := Today;
            LeaveLedg."Leave Period" := EmpOff_Holiday."Recalled From";
            LeaveApp.Reset();
            LeaveApp.SetRange("Application No", EmpOff_Holiday."Leave Application");
            if LeaveApp.FindFirst() then begin
                LeaveLedg."Leave Type" := LeaveApp."Leave Code";
                LeaveLedg."Leave Period Code" := LeaveApp."Leave Period";
            end;
            LeaveLedg."Staff No." := EmpOff_Holiday."Employee No";
            if Employee.Get(LeaveLedg."Staff No.") then begin
                LeaveLedg."Job ID" := Employee."Job Position";
                LeaveLedg."Job Group" := CopyStr(Employee."Salary Scale", 1, MaxStrLen(LeaveLedg."Job Group"));
                LeaveLedg."Contract Type" := CopyStr(Employee."Nature of Employment", 1, MaxStrLen(LeaveLedg."Contract Type"));
                LeaveLedg."Global Dimension 1 Code" := Employee."Global Dimension 1 Code";
                LeaveLedg."Global Dimension 2 Code" := Employee."Global Dimension 2 Code";
            end;
            LeaveLedg."Staff Name" := CopyStr(EmpOff_Holiday."Employee Name", 1, MaxStrLen(LeaveLedg."Staff Name"));
            LeaveLedg."User ID" := CopyStr(UserId, 1, MaxStrLen(LeaveLedg."User ID"));
            LeaveLedg."Leave Entry Type" := LeaveLedg."Leave Entry Type"::Positive;
            LeaveLedg."Leave Type" := CopyStr(EmpOff_Holiday."No.", 1, MaxStrLen(LeaveLedg."Leave Type"));

            LeaveLedg."No. of days" := EmpOff_Holiday."No. of Off Days";
            LeaveLedg."Transaction Type" := LeaveLedg."Transaction Type"::"Leave Recall";
            LeaveLedg.Insert();
            // Message('Leave recall processed successfully');

            if Confirm('Do you want to notify the Employee via mail?') then
                NotifyLeaveRecallee(EmpOff_Holiday);
        end;
    end;

    procedure NotifyLeaveRecallee(LeaveRecallRec: Record "Employee Off/Holiday")
    var
        CompanyInfo: Record "Company Information";
        Employee: Record "HR Employees";
        HRSetup: Record "Human Resources Setup";
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        RecallMsg: Label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear %1,<br><br></p><p style="font-family:Verdana,Arial;font-size:10pt"> This is to inform you that we have decided to recall you from your leave that was to run from <Strong>%2</Strong> to <Strong>%3</Strong>. </br><br>The reason for recall is: <b>%4</b><br> You are therefore advised to report back to work from <Strong>%5</Strong> to <Strong>%6</Strong>. <br><br> Thank you for your cooperation.<br><br>Kind regards,<br><br><Strong>%7<Strong></p>', Comment = '%1 = Employee Name, %2 = Leave Start Date, %3 = Leave End Date, %4 = Reason for Recall, %5 = Recalled From, %6 = Recalled To, %7 = Company Name';
        Receipient: List of [Text];
        FormattedBody: Text;
        Subject: Text;
        TimeNow: Text;
    begin
        HRSetup.Get();
        HRSetup.TestField("Human Resource Emails");

        Employee.Reset();
        if Employee.Get(LeaveRecallRec."Employee No") then begin
            CompanyInfo.Get();
            CompanyInfo.TestField(Name);
            Receipient.Add(Employee."E-Mail");
            Subject := 'Leave Recall';
            TimeNow := Format(Time);
            FormattedBody := StrSubstNo(RecallMsg, Employee."First Name",
                                        Format(LeaveRecallRec."Leave Start Date", 0, '<Weekday Text> <Day> <Month Text> <Year4>'),
                                          Format(LeaveRecallRec."Leave Ending Date", 0, '<Weekday Text> <Day> <Month Text> <Year4>'),
                                            LeaveRecallRec."Reason for Recall",
                                              Format(LeaveRecallRec."Recalled From", 0, '<Weekday Text> <Day> <Month Text> <Year4>'),
                                                Format(LeaveRecallRec."Recalled To", 0, '<Weekday Text> <Day> <Month Text> <Year4>'), CompanyInfo.Name);
            EmailMessage.Create(Receipient, Subject, FormattedBody, true);
            Email.Send(EmailMessage);
        end;
    end;



    procedure GetLeaveDaysEarnedToDate(Employee: Record "HR Employees"; LeaveTypeCode: Code[20]) LeaveEarnedToDate: Decimal
    var
        LeavePeriods: Record "Leave Period";
        LeaveTypes: Record "Leave Type";
        NextMonth: Date;
        DaysEarnedOnLeaving: Decimal;
        DaysEarnedPerMonth: Decimal;
        LeaveEntitlement: Decimal;
        NoofMonthsWorked: Decimal;
        LeaveEntitlementRec: Record "Leave Entitlement Entry";
    begin
        /* if GuiAllowed then
            Employee.TestField("Date Of Join"); */
        //Employee TestField commented for error

        LeaveEarnedToDate := 0;
        //mjk
        GetCurrentLeavePeriodRecord(LeavePeriods);

        Employee.SetRange("Leave Type Filter", LeaveTypeCode);
        Employee.SetRange("Leave Period Filter", LeavePeriods."Leave Period Code");
        Employee.CalcFields("Leave Balance Brought Forward", "Leave Entitlement");

        LeaveTypes.Get(LeaveTypeCode);

        if LeaveTypes."Earn Days" = true then begin
            // LeaveEntitlementRec.Reset();
            // LeaveEntitlementRec.SetRange("Leave Type Code", LeaveTypeCode);
            // if LeaveEntitlementRec.FindFirst() then begin
            //     LeaveEntitlement := LeaveEntitlementRec.Days;
            //     LeaveEntitlementRec.TestField("Days Earned per Month");
            //     DaysEarnedPerMonth := LeaveEntitlementRec."Days Earned per Month";
            //     leaveEntitlementRec.TestField("Days Earned per Month");
            // end;

            GetLeaveEntitlement(Employee, LeaveTypes, LeaveEntitlement, DaysEarnedPerMonth);


            //Cater for employees joining in the middle of the year
            if Employee."Date Of Join" > LeavePeriods."Start Date" then begin
                NoofMonthsWorked := 0;
                Nextmonth := Employee."Date Of Join";
                repeat
                    Nextmonth := CalcDate('<1M>', Nextmonth);
                    NoofMonthsWorked := NoofMonthsWorked + 1;
                until Nextmonth >= Today();
                NoofMonthsWorked := NoofMonthsWorked - 1;

                LeaveEarnedToDate := DaysEarnedPerMonth * NoofMonthsWorked;
            end else begin
                //Normal employees
                NoofMonthsWorked := Date2DMY(Today(), 2);
                LeaveEarnedToDate := DaysEarnedPerMonth * NoofMonthsWorked;

                //Employees leaving in the middle of the month
                if Employee."Date Of Leaving" <> 0D then
                    if ((Date2DMY(Employee."Date Of Leaving", 2)) = (Date2DMY(Today(), 2))) and
                       ((Date2DMY(Employee."Date Of Leaving", 3)) = (Date2DMY(Today(), 3))) then begin
                        DaysEarnedOnLeaving := Round(((Date2DMY(Employee."Date Of Leaving", 1) - 1) * DaysEarnedPerMonth) / 22, 0.1, '=');
                        LeaveEarnedToDate := LeaveEarnedToDate - DaysEarnedPerMonth + DaysEarnedOnLeaving;
                    end;
            end;
        end else
            LeaveEarnedToDate := Employee."Leave Entitlement";

        LeaveEarnedToDate := LeaveEarnedToDate + Employee."Leave Balance Brought Forward";

        exit(LeaveEarnedToDate);
    end;

    procedure CloseLeavePeriod(var LeavePeriodRec: Record "Leave Period")
    var
        Employee: Record "HR Employees";
        PeriodClosedSuccessMsg: Label 'Leave period %1 has been closed successfully', Comment = '%1 = Leave Period Code';
    begin
        LeavePeriodRec.TestField(Closed, false);

        //Close Entries
        Employee.Reset();
        Employee.SetRange(Status, Employee.Status::Active);
        if Employee.FindSet() then
            repeat
                ClosePreviousLeaveEntries(Employee."No.", LeavePeriodRec."Leave Period Code");
            until Employee.Next() = 0;

        //Close Period
        LeavePeriodRec.Validate(Closed, true);
        LeavePeriodRec.Modify();

        if GuiAllowed() then
            Message(PeriodClosedSuccessMsg, LeavePeriodRec."Leave Period Code");

        /*         Commit();

                //Create Period
                if Confirm(CreateNewLeavePeriodMsg, false) then
                    Report.RunModal(Report::"Create Leave Period", true, false); */
    end;

    local procedure ClosePreviousLeaveEntries(EmpNo: Code[20]; PrevLeavePeriod: Code[20])
    var
        Employee: Record "HR Employees";
        LeaveLedger: Record "HR Leave Ledger Entries Lv";
        LeavePeriodRec: Record "Leave Period";
    begin
        Employee.Get(EmpNo);

        LeavePeriodRec.Get(PrevLeavePeriod);

        LeaveLedger.Reset();
        LeaveLedger.SetRange("Staff No.", EmpNo);
        LeaveLedger.SetRange("Leave Period Code", PrevLeavePeriod);
        LeaveLedger.SetRange(Closed, false);
        if LeaveLedger.FindSet() then
            repeat
                LeaveLedger.Validate(Closed, true);
                LeaveLedger.Modify();
            until LeaveLedger.Next() = 0;
    end;

    procedure AssignLeaveDays(var LeavePeriod: Record "Leave Period")
    var
        Employees: Record "Hr Employees";
        LeaveLedger: Record "HR Leave Ledger Entries Lv";
        LeavePeriods: Record "Leave Period";
        LeaveTypes: Record "Leave Type";
        CurrentLeavePeriod, PrevLeavePeriod : Code[20];
        DaysEarnedPerMonth, LeaveEntitlement : Decimal;
        EntryNo: Integer;
        NoLeavePeriodErr: Label 'Please define a current leave period';
    begin
        LeavePeriod.SetRange(Closed, false);
        if LeavePeriods.IsEmpty() then
            Error(NoLeavePeriodErr)
        else begin
            LeavePeriod.TestField("Start Date");
            LeavePeriod.TestField("End Date");
            CurrentLeavePeriod := LeavePeriod."Leave Period Code";
        end;

        if LeaveLedger.FindLast() then
            EntryNo := LeaveLedger."Entry No.";

        Employees.Reset();
        Employees.SetRange(Status, Employees.Status::Active);
        Employees.SetFilter("Employee Type", '<>%1', Employees."Employee Type"::"Board Member");
        if Employees.FindSet() then
            repeat
                LeaveTypes.Reset();
                LeaveTypes.SetRange(Status, LeaveTypes.Status::Active);
                LeaveTypes.SetFilter(Gender, '%1|%2', LeaveTypes.Gender::" ", Employees."Gender");
                if LeaveTypes.FindSet() then
                    repeat
                        if not IsLeaveAssigned(LeaveTypes.Code, Employees."No.", CurrentLeavePeriod) then begin
                            if GetPreviousLeavePeriod(CurrentLeavePeriod, PrevLeavePeriod) then begin
                                ClosePreviousLeaveEntries(Employees."No.", PrevLeavePeriod);
                                ProcessLeaveBalanceBroughtForward(PrevLeavePeriod, Employees, LeavePeriod);
                            end;

                            GetLeaveEntitlement(Employees, LeaveTypes, LeaveEntitlement, DaysEarnedPerMonth);
                            InitLeaveLedgerEntry(Employees, LeavePeriod, LeaveTypes, Enum::"Leave Transaction Type"::"Leave Allocation", LeaveEntitlement);
                        end;
                    until LeaveTypes.Next() = 0;
            until Employees.Next() = 0;
    end;

    local procedure IsLeaveAssigned(LeaveType: Code[20]; EmpNo: Code[20]; LeavePeriod: Code[20]) Assigned: Boolean
    var
        LeaveLedger: Record "HR Leave Ledger Entries Lv";
    begin
        LeaveLedger.Reset();
        LeaveLedger.SetRange("Staff No.", EmpNo);
        LeaveLedger.SetRange("Leave Period Code", LeavePeriod);
        LeaveLedger.SetRange("Leave Entry Type", LeaveLedger."Leave Entry Type"::Positive);
        LeaveLedger.SetRange("Transaction Type", LeaveLedger."Transaction Type"::"Leave Allocation");
        LeaveLedger.SetRange("Leave Type", LeaveType);
        if not LeaveLedger.IsEmpty() then
            Assigned := true
        else
            Assigned := false;
    end;

    local procedure GetPreviousLeavePeriod(CurrentLeavePeriod: Code[20]; var PrevLeavePeriod: Code[20]): Boolean
    var
        LeavePeriodRec, PrevLeavePeriodRec : Record "Leave Period";
    begin
        if LeavePeriodRec.Get(CurrentLeavePeriod) then begin
            PrevLeavePeriodRec.SetCurrentKey("End Date");
            PrevLeavePeriodRec.SetFilter("Leave Period Code", '<>%1', CurrentLeavePeriod);
            if PrevLeavePeriodRec.FindLast() then begin
                PrevLeavePeriod := PrevLeavePeriodRec."Leave Period Code";
                if PrevLeavePeriod <> '' then
                    exit(true)
                else
                    exit(false);
            end;
        end else
            exit(false);
    end;

    local procedure ProcessLeaveBalanceBroughtForward(PrevLeavePeriod: Code[20]; var Employee: Record "HR Employees"; var LeavePeriodRec: Record "Leave Period")
    var
        EmployeeCopy: Record "HR Employees";
        LeaveTypes: Record "Leave Type";
        BalBroughtForward: Decimal;
    begin
        //Leave Bal/F
        LeaveTypes.Reset();
        LeaveTypes.SetRange(Status, LeaveTypes.Status::Active);
        LeaveTypes.SetRange(Balance, LeaveTypes.Balance::"Carry Forward");
        if LeaveTypes.FindSet() then
            repeat
                LeaveTypes.Testfield("Max Carry Forward Days");

                EmployeeCopy.Copy(Employee);
                EmployeeCopy.SetRange("Leave Type Filter", LeaveTypes.Code);
                EmployeeCopy.SetRange("Leave Period Filter", PrevLeavePeriod);
                EmployeeCopy.CalcFields("Leave Balance");

                if EmployeeCopy."Leave Balance" > 0 then
                    if EmployeeCopy."Leave Balance" >= LeaveTypes."Max Carry Forward Days" then
                        BalBroughtForward := LeaveTypes."Max Carry Forward Days"
                    else
                        BalBroughtForward := EmployeeCopy."Leave Balance";

                if (BalBroughtForward > 0) and (not IsLeaveBFAssigned(LeaveTypes.Code, Employee."No.", LeavePeriodRec."Leave Period Code")) then
                    InitLeaveLedgerEntry(EmployeeCopy, LeavePeriodRec, LeaveTypes, Enum::"Leave Transaction Type"::"Leave B/F", BalBroughtForward);

            until LeaveTypes.Next() = 0;
    end;

    local procedure InitLeaveLedgerEntry(var Employee: Record "HR Employees"; var LeavePeriodRec: Record "Leave Period"; var LeaveType: Record "Leave Type"; LeaveTransactionType: Enum "Leave Transaction Type"; NoOfDays: Decimal)
    var
        LeaveLedger: Record "HR Leave Ledger Entries Lv";
    begin
        LeaveLedger.Init();
        LeaveLedger."Entry No." := InitNextEntryNo();
        LeaveLedger."Leave Period" := LeavePeriodRec."Start Date";
        LeaveLedger."Staff No." := Employee."No.";
        LeaveLedger."Staff Name" := CopyStr(Employee.FullName(), 1, MaxStrLen(LeaveLedger."Staff Name"));
        LeaveLedger."Leave Entry Type" := LeaveLedger."Leave Entry Type"::Positive;
        LeaveLedger."Document No." := StrSubstNo(LeavePeriodRec."Leave Period Code");
        LeaveLedger."Job ID" := Employee."Job Position";
        LeaveLedger."Job Group" := CopyStr(Employee."Salary Scale", 1, MaxStrLen(LeaveLedger."Job Group"));
        LeaveLedger."Leave Approval Date" := Today;
        LeaveLedger."Contract Type" := Format(Employee."Contract Type");
        LeaveLedger."No. of days" := NoOfDays;
        LeaveLedger."Leave Posting Description" := 'Assignment for Leave Period ' + LeavePeriodRec."Leave Period Code";
        LeaveLedger."Transaction Type" := LeaveTransactionType;
        LeaveLedger."User ID" := CopyStr(UserId(), 1, MaxStrLen(LeaveLedger."User ID"));
        LeaveLedger."Leave Type" := LeaveType.Code;
        LeaveLedger."Leave Period Code" := LeavePeriodRec."Leave Period Code";
        LeaveLedger."Leave Start Date" := LeavePeriodRec."Start Date";
        LeaveLedger."Leave End Date" := LeavePeriodRec."End Date";
        LeaveLedger."Global Dimension 1 Code" := Employee."Global Dimension 1 Code";
        LeaveLedger."Global Dimension 2 Code" := Employee."Global Dimension 2 Code";
        LeaveLedger.Entitlement := NoOfDays;
        LeaveLedger."Leave Date" := Today();
        LeaveLedger."Country/Region Code" := Employee."Country/Region Code";
        LeaveLedger.Insert();
    end;

    local procedure InitNextEntryNo() NextEntryNo: Integer
    var
        LeaveEntry: Record "HR Leave Ledger Entries Lv";
    begin
        LeaveEntry.LockTable();
        if LeaveEntry.FindLast() then
            NextEntryNo := LeaveEntry."Entry No." + 1
        else
            NextEntryNo := 1;
    end;

    local procedure IsLeaveBFAssigned(LeaveType: Code[20]; EmpNo: Code[20]; LeavePeriod: Code[20]) Assigned: Boolean
    var
        LeaveLedger: Record "HR Leave Ledger Entries Lv";
    begin
        LeaveLedger.Reset();
        LeaveLedger.SetRange("Staff No.", EmpNo);
        LeaveLedger.SetRange("Leave Period Code", LeavePeriod);
        LeaveLedger.SetRange("Leave Entry Type", LeaveLedger."Leave Entry Type"::Positive);
        LeaveLedger.SetRange("Transaction Type", LeaveLedger."Transaction Type"::"Leave B/F");
        LeaveLedger.SetRange("Leave Type", LeaveType);
        if not LeaveLedger.IsEmpty() then
            Assigned := true
        else
            Assigned := false;
    end;

    procedure CheckDocumentAttachmentExist(Leave: Record "Leave Application")
    var
        DocumentAttachment: Record "Document Attachment";
        DocumentAttachmentErr: Label 'Please attach handover notes or any other leave related documents ';
    begin
        DocumentAttachment.Reset();
        DocumentAttachment.SetRange("Table ID", Database::"Leave Application");
        DocumentAttachment.SetRange("No.", Leave."Application No");
        if DocumentAttachment.IsEmpty() then
            Error(DocumentAttachmentErr);
    end;


    procedure GetCurrentLeavePeriodRecord(var LeavePeriod: Record "Leave Period")
    begin
        LeavePeriod.SetRange(Closed, false);
        LeavePeriod.FindFirst();
    end;

    procedure GetLeaveEntitlement(Employee: Record "HR Employees"; LeaveTypeRec: Record "Leave Type"; var LeaveEntitlement: Decimal; var DaysEarnedPerMonth: Decimal)
    var
        LeaveEntitlementRec: Record "Leave Entitlement Entry";
        NoLeaveEntitlementDefinedErr: Label 'No Leave Entitlement defined for Leave Type: %1, Employee Category: %2, Country: %3', Comment = '%1 = Leave Type, %2 = Employee Category, %3 = Country';
    begin
        LeaveEntitlement := 0;
        DaysEarnedPerMonth := 0;

        Employee.TestField("Country/Region Code");

        LeaveEntitlementRec.Reset();
        LeaveEntitlementRec.SetRange("Leave Type Code", LeaveTypeRec.Code);
        LeaveEntitlementRec.SetRange("Employee Category", Employee."Employee Category");
        LeaveEntitlementRec.SetRange("Country/Region Code", Employee."Country/Region Code");
        if LeaveEntitlementRec.FindFirst() then begin
            LeaveEntitlement := LeaveEntitlementRec.Days;
            if LeaveTypeRec."Earn Days" = true then begin
                LeaveEntitlementRec.TestField("Days Earned per Month");
                DaysEarnedPerMonth := LeaveEntitlementRec."Days Earned per Month";
                // Message('days earned is %1', DaysEarnedPerMonth);

            end;


        end else
            Error(NoLeaveEntitlementDefinedErr, LeaveTypeRec.Code, Employee."Employee Category", Employee."Country/Region Code");
    end;

}


