table 53018 "Leave Planner Lines"
{
    Caption = 'Leave Planner Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(2; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            DataClassification = CustomerContent;
            TableRelation = "HR Employees"."No.";
            trigger OnValidate()
            begin
                Employee.Get("Employee No.");
                "Employee Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
            end;
        }
        field(3; "Leave Type"; Code[20])
        {
            Caption = 'Leave Type';
            DataClassification = CustomerContent;
            TableRelation = "Leave Type".Code;

            trigger OnValidate()
            begin
                Employee.Get("Employee No.");

                LeaveTypes.Get("Leave Type");

                if LeaveTypes.Gender = LeaveTypes.Gender::Female then
                    if Employee."Gender." = Employee."Gender."::Male then
                        Error('%1 can only be assigned to %2 Employeeloyees', LeaveTypes.Description, LeaveTypes.Gender);

                if LeaveTypes.Gender = LeaveTypes.Gender::Male then
                    if Employee."Gender." = Employee."Gender."::Female then
                        Error('%1 can only be assigned to %2 employees', LeaveTypes.Description, LeaveTypes.Gender);
            end;
        }
        field(4; "Employee Name"; Text[100])
        {
            Caption = 'Employee Name';
            DataClassification = CustomerContent;
            Editable = false;

        }
        field(5; "No. of Days"; Decimal)
        {
            Caption = 'No. of Days';
            DataClassification = CustomerContent;
        }
        field(6; "Start Date"; Date)
        {
            Caption = 'Start Date';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                BaseCalendar: Record "Base Calendar Change";
                CompanyInfo: Record "Company Information";
                BaseCalender: Record Date;
                HRmgt: Codeunit "HR Management";
                NextWorkingDate: Date;
                NoOfWorkingDays: Decimal;
                Description, Dsptn : Text[50];
            begin
                CompanyInfo.Get();
                CompanyInfo.TestField("Base Calendar Code");

                if "No. of Days" <> 0 then
                    if "Start Date" <> 0D then begin
                        NextWorkingDate := "Start Date";

                        repeat
                            if not HRmgt.CheckNonWorkingDay(CompanyInfo."Base Calendar Code", NextWorkingDate, Description) then
                                NoOfWorkingDays := NoOfWorkingDays + 1;

                            if LeaveTypes.Get("Leave Type") then begin
                                if LeaveTypes."Inclusive of Holidays" then begin
                                    BaseCalendar.Reset();
                                    BaseCalendar.SetRange(BaseCalendar."Base Calendar Code", CompanyInfo."Base Calendar Code");
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
                        until NoOfWorkingDays = "No. of Days";
                        "End Date" := NextWorkingDate - 1;
                        "Resumption Date" := NextWorkingDate;
                    end;

                //check if the date that the person is supposed to report back is a working day or not
                //get base calendar to use
                HumanResSetup.Reset();
                HumanResSetup.Get();
                HumanResSetup.TestField(HumanResSetup."Default Base Calendar");
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
            end;
        }
        field(7; "End Date"; Date)
        {
            Caption = 'End Date';
            DataClassification = CustomerContent;
        }
        field(8; "Resumption Date"; Date)
        {
            Caption = 'Resumption Date';
            DataClassification = CustomerContent;
        }
        field(9; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
    }
    keys
    {
        key(PK; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }

    var
        Employee: Record "HR Employees";
        HumanResSetup: Record "Human Resources Setup";
        LeaveTypes: Record "Leave Type";
        NonWorkingDay: Boolean;
}





