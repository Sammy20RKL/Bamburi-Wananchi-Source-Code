tableextension 52006 "EmployeeAbsenceTableExt" extends "Employee Absence"
{
    fields
    {
        modify("From Date")
        {
            trigger OnAfterValidate()
            var
                Absence: Record "Employee Absence";
            begin
                if ("From Date" <> 0D) and ("To Date" <> 0D) then begin
                    Absence.Reset();
                    Absence.SetRange("Employee No.", "Employee No.");
                    if Absence.FindFirst() then
                        repeat
                            if ("From Date" >= Absence."From Date") and ("From Date" <= Absence."To Date") then
                                Error('You have already registered absence for this employee between %1 and %2', Absence."From Date", Absence."To Date");
                            if ("From Date" >= Absence."From Date") and ("From Date" <= Absence."To Date") then
                                Error('You have already registered absence for this employee between %1 and %2', Absence."From Date", Absence."To Date");
                        until Absence.Next() = 0;
                end;
            end;
        }
        modify("To Date")
        {
            trigger OnAfterValidate()
            var
                BaseCalendar: Record "Base Calendar Change";
                GeneralOptions: Record "Company Information";
                BaseCalender: Record "Date";
                Absence: Record "Employee Absence";
                LeaveTypes: Record "Leave Type";
                HRmgt: Codeunit "HR Management";
                d: Date;
                NonworkingDaysAbsent: Decimal;
                Error000: Label 'You to date must be greater than from date';
                Description: Text[30];
            begin
                if ("From Date" <> 0D) and ("To Date" <> 0D) then begin
                    if "To Date" < "From Date" then
                        Error(Error000);
                    Absence.Reset();
                    Absence.SetRange("Employee No.", "Employee No.");
                    if Absence.FindFirst() then
                        repeat
                            if ("From Date" >= Absence."From Date") and ("From Date" <= Absence."To Date") then
                                Error('You have already registered absence for this employee between %1 and %2', Absence."From Date", Absence."To Date");
                            if ("From Date" >= Absence."From Date") and ("From Date" <= Absence."To Date") then
                                Error('You have already registered absence for this employee between %1 and %2', Absence."From Date", Absence."To Date");
                        until Absence.Next() = 0;
                end;

                GeneralOptions.Get();
                NonworkingDaysAbsent := 0;
                //"No. of Off Days" := ("Recalled To" - "Recalled From");
                if "To Date" <> 0D then
                    if "From Date" <> 0D then begin
                        d := "From Date";
                        repeat
                            if HrMgt.CheckNonWorkingDay(GeneralOptions."Base Calendar Code", d, Description) then
                                NonworkingDaysAbsent := NonworkingDaysAbsent + 1;
                            // MESSAGE('%1', NonworkingDaysRecall);
                            if LeaveTypes.Get() then begin
                                if not LeaveTypes."Inclusive of Holidays" then begin
                                    BaseCalendar.Reset();
                                    BaseCalendar.SetRange(BaseCalendar."Base Calendar Code", GeneralOptions."Base Calendar Code");
                                    BaseCalendar.SetRange(BaseCalendar.Date, d);
                                    BaseCalendar.SetRange(BaseCalendar.Nonworking, true);
                                    BaseCalendar.SetRange(BaseCalendar."Recurring System", BaseCalendar."Recurring System"::"Annual Recurring");
                                    if BaseCalendar.Find('-') then
                                        NonworkingDaysAbsent := NonworkingDaysAbsent + 1;

                                end;

                                if not LeaveTypes."Inclusive of Saturday" then begin
                                    BaseCalender.Reset();
                                    BaseCalender.SetRange(BaseCalender."Period Type", BaseCalender."Period Type"::Date);
                                    BaseCalender.SetRange(BaseCalender."Period Start", d);
                                    BaseCalender.SetRange(BaseCalender."Period No.", 6);

                                    if BaseCalender.Find('-') then
                                        NonworkingDaysAbsent := NonworkingDaysAbsent + 1;
                                end;


                                if not LeaveTypes."Inclusive of Sunday" then begin
                                    BaseCalender.Reset();
                                    BaseCalender.SetRange(BaseCalender."Period Type", BaseCalender."Period Type"::Date);
                                    BaseCalender.SetRange(BaseCalender."Period Start", d);
                                    BaseCalender.SetRange(BaseCalender."Period No.", 7);

                                    if BaseCalender.Find('-') then
                                        NonworkingDaysAbsent := NonworkingDaysAbsent + 1;
                                end;


                                if LeaveTypes."Off/Holidays Days Leave" then
                                    ;

                            end;

                            d := CalcDate('1D', d);
                        until d = "To Date";
                        Quantity := ("To Date" - "From Date");
                        Quantity := Quantity - NonworkingDaysAbsent + 1;

                    end;
            end;
        }
        modify("Cause of Absence Code")
        {
            trigger OnAfterValidate()
            var
                EmployeeAbsence: Record "Employee Absence";
                HRSetup: Record "Human Resources Setup";
            begin
                HRSetup.Get();
                "Unit of Measure Code" := HRSetup."Base Unit of Measure";
                EmployeeAbsence.Reset();
                EmployeeAbsence.SetRange(EmployeeAbsence."Cause of Absence Code", "Cause of Absence Code");
                if EmployeeAbsence.Find('-') then
                    Description := EmployeeAbsence.Description;

            end;
        }
        field(52000; "Company Leave"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Company Leave';
        }
        field(52001; Weight; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Weight';
        }
        field(52002; Approved; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Approved';
        }
        field(52003; "Transfered to Payroll"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Transfered to Payroll';
        }
        field(52004; "Maturity Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Maturity Date';
        }
        field(52005; "Affects Leave"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Affects Leave';
        }
    }
}





