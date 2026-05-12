table 52016 "Leave Relievers"
{
    DataClassification = CustomerContent;
    Caption = 'Leave Relievers';
    fields
    {
        field(1; "Leave Code"; Code[20])
        {
            Caption = 'Leave Code';
        }
        field(2; "Staff No"; Code[20])
        {
            TableRelation = "HR Employees"."No.";// where(Status = const(Active), "Employee Type" = filter(<> "Board Member"));
            Caption = 'Staff No';

            trigger OnValidate()
            begin
                LeaveApp.Get("Leave Code");
                if "Staff No" = LeaveApp."Employee No" then
                    Error('You can not be your own reliever!');

                if Employee.Get("Staff No") then
                    "Staff Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
            end;
        }
        field(3; "Staff Name"; Text[100])
        {
            Editable = false;
            Caption = 'Staff Name';
        }
    }

    keys
    {
        key(Key1; "Leave Code", "Staff No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Employee: Record "HR Employees";
        LeaveApp: Record "Leave Application";
}





