table 53006 "Holiday_Off Days"
{
    DataClassification = CustomerContent;
    Caption = 'Holiday_Off Days';
    fields
    {
        field(1; Date; Date)
        {
            NotBlank = true;
            Caption = 'Date';

            trigger OnValidate()
            begin
                GeneralOptions.Get();

                // IF NOT CalendarMgmt.CheckDateStatus(GeneralOptions."Base Calendar Code",Date,Description) THEN
                // ERROR('You can only enter a holiday or weekend');
            end;
        }
        field(2; Description; Text[150])
        {
            Caption = 'Description';
        }
        field(3; "Employee No."; Code[20])
        {
            TableRelation = Employee;
            Caption = 'Employee No.';

            trigger OnValidate()
            begin
                if Emp.Get("Employee No.") then
                    "Employee Name" := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
            end;
        }
        field(4; "Employee Name"; Text[50])
        {
            Caption = 'Employee Name';
        }
        field(5; "Leave Type"; Code[20])
        {
            Caption = 'Leave Type';
        }
        field(6; "Maturity Date"; Date)
        {
            Caption = 'Maturity Date';
        }
        field(7; "No. of Days"; Decimal)
        {
            Caption = 'No. of Days';
        }
        field(8; "Reason for Off"; Text[250])
        {
            Caption = 'Reason for Off';
        }
        field(9; "Approved to Work"; Code[20])
        {
            TableRelation = Employee;
            Caption = 'Approved to Work';
        }
    }

    keys
    {
        key(Key1; Date)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        GeneralOptions: Record "Company Information";
        Emp: Record Employee;
}





