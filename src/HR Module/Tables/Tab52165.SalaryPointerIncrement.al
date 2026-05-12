table 52165 "Salary Pointer Increment"
{
    Caption = 'Salary Pointer Increment';
    DataClassification = CustomerContent;
    // LookupPageId = "Salary Increment Details";
    // DrillDownPageId = "Salary Increment Details";

    fields
    {
        field(1; "Employee No."; Code[50])
        {
            Caption = 'Employee No.';
            TableRelation = "HR Employees"."No.";
        }
        field(2; "Payroll Period"; Date)
        {
            Caption = 'Payroll Period';
            TableRelation = "Payroll Period"."Starting Date";
        }
        field(3; "Increment Date"; Date)
        {
            Caption = 'Increment Date';
            trigger OnValidate()
            begin
                if "Increment Date" <> 0D then begin
                    "Increment Year" := Date2DMY("Increment Date", 3);
                    "Next Increment Date" := DMY2Date(1, Date2DMY("Payroll Period", 2), (Date2DMY("Payroll Period", 3) + 1));
                end;
            end;
        }
        field(4; "Increment Year"; Integer)
        {
            Caption = 'Increment Year';
        }
        field(5; "Previous Scale"; Code[10])
        {
            Caption = 'Previous Scale';
            TableRelation = "Salary Scale".Scale;
        }
        field(6; "Previous Pointer"; Code[10])
        {
            Caption = 'Previous Pointer';
            TableRelation = "Salary Pointer"."Salary Pointer";
        }
        field(7; "Present Scale"; Code[10])
        {
            Caption = 'Present Scale';
            TableRelation = "Salary Scale".Scale;
        }
        field(8; "Present Pointer"; Code[10])
        {
            Caption = 'Present Pointer';
            TableRelation = "Salary Pointer"."Salary Pointer";
        }
        field(9; "Next Increment Date"; Date)
        {
            Caption = 'Next Increment Date';
        }
        field(10; "Processed By"; Code[50])
        {
            Caption = 'Processed By';
        }
    }
    keys
    {
        key(PK; "Employee No.", "Payroll Period")
        {
            Clustered = true;
        }
    }
}


