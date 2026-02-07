table 52005 "Employee Off/Holiday"
{
    DrillDownPageID = "Leave Recall List";
    LookupPageID = "Leave Recall List";
    // DataClassification = CustomerContent;
    Caption = 'Leave Recall';

    fields
    {
        field(1; "Employee No"; Code[20])
        {
            TableRelation = Employee;
            Caption = 'Employee No';

            trigger OnValidate()
            begin
                if Emp.Get("Employee No") then
                    "Employee Name" := Emp."First Name" + '' + Emp."Middle Name" + '' + Emp."Last Name";
            end;
        }
        field(3; Date; Date)
        {
            Caption = 'Date';
        }
        field(4; Approved; Boolean)
        {
            Caption = 'Approved';
        }
        field(5; "Leave Application"; Code[20])
        {
            TableRelation = "Leave Application"."Application No" where(Status = const(Released));
            Caption = 'Leave Application';

            trigger OnValidate()
            begin
                /*GeneralOptions.Get();
                 if LeaveApplication.Get("Leave Application") then
                 begin
                   NoOfDaysOff:=0;
                     "Leave Ending Date":=LeaveApplication."End Date";
                     "Employee No":=LeaveApplication."Employee No";
                     "Employee Name":=LeaveApplication."Employee Name";
                   if LeaveApplication."End Date"<>0D then
                   begin
                   NextDate:="Recall Date";
                   repeat
                   if not CalendarMgmt.CheckDateStatus(GeneralOptions."Base Calendar Code",NextDate,Description) then
                   NoOfDaysOff:=NoOfDaysOff+1;
                
                   NextDate:=CalcDate('1D',NextDate);
                   until NextDate=LeaveApplication."End Date";
                   end;
                
                 end;
                
                  "No. of Off Days":=NoOfDaysOff;
                */

                // Set flag to prevent recursive validation
                SkipRecallDateValidation := true;

                LeaveApplication.Reset();
                LeaveApplication.SetRange(LeaveApplication."Application No", "Leave Application");
                if LeaveApplication.FindFirst() then begin
                    "Employee No" := LeaveApplication."Employee No";
                    "Employee Name" := LeaveApplication."Employee Name";

                    // Get dates directly from Leave Application Type table
                    LeaveApplicationType.Reset();
                    LeaveApplicationType.SetRange("Leave Code", "Leave Application");
                    if LeaveApplicationType.FindFirst() then begin
                        //   if LeaveApplicationType."Start Date" <> 0D then
                        "Leave Start Date" := LeaveApplicationType."Start Date";
                        //  if LeaveApplicationType."End Date" <> 0D then
                        "Leave Ending Date" := LeaveApplicationType."End Date";
                    end;

                end;

                // Reset flag
                SkipRecallDateValidation := false;
            end;
        }
        field(6; "Recall Date"; Date)
        {
            Caption = 'Recall Date';

            trigger OnValidate()
            begin
                // Only validate Leave Application if we're not in a recursive call
                if not SkipRecallDateValidation then
                    Validate("Leave Application");
            end;
        }
        field(7; "No. of Off Days"; Decimal)
        {
            Caption = 'No. of Off Days';
        }
        field(8; "Leave Ending Date"; Date)
        {
            Caption = 'Leave Ending Date';

        }
        field(9; "Maturity Date"; Date)
        {
            Caption = 'Maturity Date';
        }
        field(10; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
        }
        field(11; "Employee Name"; Text[150])
        {
            Caption = 'Employee Name';
        }
        field(12; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(13; Status; Option)
        {
            OptionCaption = 'Open,Released,Pending Approval,Pending Prepayment';
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment";
            Caption = 'Status';
        }
        field(14; "Fiscal Start Date"; Date)
        {
            Caption = 'Fiscal Start Date';
        }
        field(15; "Recalled By"; Code[20])
        {
            TableRelation = Employee;
            Caption = 'Recalled By';

            trigger OnValidate()
            begin
                if Emp.Get("Recalled By") then
                    Name := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
            end;
        }
        field(16; Name; Text[150])
        {
            Editable = false;
            Caption = 'Name';
        }
        field(17; "Reason for Recall"; Text[130])
        {
            Caption = 'Reason for Recall';
        }
        field(18; Completed; Boolean)
        {
            Caption = 'Completed';
        }
        field(20; "Recalled From"; Date)
        {
            Caption = 'Recalled From';

            trigger OnValidate()
            begin
                if "Recalled From" < "Recall Date" then Error(Error000);
                if "Recalled From" < "Leave Start Date" then Error(Error001);
                if "Recalled From" > "Leave Ending Date" then Error(Error001);
            end;
        }
        field(21; "Recalled To"; Date)
        {
            Caption = 'Recalled To';

            trigger OnValidate()
            begin
                if "Recalled To" <> 0D then
                    if "Recalled To" < "Recall Date" then
                        Error(Error003);
                if "Recalled To" > "Leave Ending Date" then
                    Error(Error002);


                GeneralOptions.Get();
                NonworkingDaysRecall := 0;
                //"No. of Off Days" := ("Recalled To" - "Recalled From");
                if "Recalled To" <> 0D then
                    if "Recalled From" <> 0D then begin
                        d := "Recalled From";
                        repeat
                            if HrMgt.CheckNonWorkingDay(GeneralOptions."Base Calendar Code", d, Description) then
                                NonworkingDaysRecall := NonworkingDaysRecall + 1;
                            // MESSAGE('%1', NonworkingDaysRecall);
                            if LeaveTypes.Get() then begin
                                if not LeaveTypes."Inclusive of Holidays" then begin
                                    BaseCalendar.Reset();
                                    BaseCalendar.SetRange(BaseCalendar."Base Calendar Code", GeneralOptions."Base Calendar Code");
                                    BaseCalendar.SetRange(BaseCalendar.Date, d);
                                    BaseCalendar.SetRange(BaseCalendar.Nonworking, true);
                                    BaseCalendar.SetRange(BaseCalendar."Recurring System", BaseCalendar."Recurring System"::"Annual Recurring");
                                    if BaseCalendar.Find('-') then
                                        NonworkingDaysRecall := NonworkingDaysRecall + 1;
                                    //MESSAGE('%1', NonworkingDaysRecall);

                                end;

                                if not LeaveTypes."Inclusive of Saturday" then begin
                                    BaseCalender.Reset();
                                    BaseCalender.SetRange(BaseCalender."Period Type", BaseCalender."Period Type"::Date);
                                    BaseCalender.SetRange(BaseCalender."Period Start", d);
                                    BaseCalender.SetRange(BaseCalender."Period No.", 6);

                                    if BaseCalender.Find('-') then
                                        NonworkingDaysRecall := NonworkingDaysRecall + 1;
                                    //MESSAGE('%1', NonworkingDaysRecall);
                                end;


                                if not LeaveTypes."Inclusive of Sunday" then begin
                                    BaseCalender.Reset();
                                    BaseCalender.SetRange(BaseCalender."Period Type", BaseCalender."Period Type"::Date);
                                    BaseCalender.SetRange(BaseCalender."Period Start", d);
                                    BaseCalender.SetRange(BaseCalender."Period No.", 7);

                                    if BaseCalender.Find('-') then
                                        NonworkingDaysRecall := NonworkingDaysRecall + 1;
                                end;


                                // IF LeaveTypes."Off/Holidays Days Leave" THEN
                                //     ;

                            end;

                            d := CalcDate('1D', d);
                        until d = "Recalled To";
                        "No. of Off Days" := ("Recalled To" - "Recalled From");
                        "No. of Off Days" := "No. of Off Days" - NonworkingDaysRecall + 1;


                    end;
                // if ("Recalled To" = "Recalled From") then
                //     "No. of Off Days" := 1
                // else begin
                //     GeneralOptions.Get;
                //     //IF  "Recalled To">"Recall Date" THEN
                //     //ERROR('Recall end date is greater than recall start date');
                //     if LeaveApplication.Get("Leave Application") then begin
                //         NoOfDaysOff := 1;
                //         "Leave Ending Date" := LeaveApplication."End Date";
                //         if LeaveApplication."End Date" <> 0D then begin
                //             NextDate := "Recalled From";
                //             repeat
                //                 /*    if not CalendarMgmt.CheckDateStatus(GeneralOptions."Base Calendar Code", NextDate, Description) then
                //                        NoOfDaysOff := NoOfDaysOff + 1; */
                //                 NextDate := CalcDate('1D', NextDate);
                //             //  UNTIL NextDate=LeaveApplication."End Date";
                //             until NextDate = "Recalled To"; //By Isaac
                //         end;
                //     end;
                //     "No. of Off Days" := NoOfDaysOff;
                // end;
            end;
        }
        field(22; "Department Name"; Text[50])
        {
            Caption = 'Department Name';
        }
        field(23; "Contract No."; Integer)
        {
            Caption = 'Contract No.';
        }
        field(24; "Leave Start Date"; Date)
        {
            Caption = 'Leave Start Date';

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
    }

    trigger OnInsert()
    begin

        if "No." = '' then begin
            HRSetup.Get();
            HRSetup.TestField("Leave Recall Nos", HRSetup."Leave Recall Nos");
            //  NoSeriesMgt.InitSeries(HRSetup."Leave Recall Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        Date := Today;
        "Recall Date" := Today;
    end;

    var
        BaseCalendar: Record "Base Calendar Change";
        GeneralOptions: Record "Company Information";
        BaseCalender: Record "Date";
        Emp: Record Employee;
        HRSetup: Record "Human Resources Setup";
        LeaveApplication: Record "Leave Application";
        LeaveApplicationType: Record "Leave Application Type";
        LeaveTypes: Record "Leave Type";
        HRmgt: Codeunit "HR Management";
        //  NoSeriesMgt: Codeunit NoSeriesManagement;
        d: Date;
        NonworkingDaysRecall: Decimal;
        SkipRecallDateValidation: Boolean; // Added flag to prevent recursive validation
        Error000: Label 'You cannot Recall Someone earlier than Today';
        Error001: Label 'Recall start date must be later than leave start date and earlier than leave end date';
        Error002: Label 'Recall end date must be later than leave start date and earlier than leave end date';
        Error003: Label 'Recall end date must be later than recall start date';
        Description: Text[30];
}