tableextension 50013 "Employee General Ext" extends Employee
{
    fields
    {
        field(50000; "User ID"; Code[50])
        {
            DataClassification = CustomerContent;
            TableRelation = "User Setup"."User ID";
            Caption = 'User ID';

            trigger OnValidate()
            var
                UserIDExistsErr: Label 'Employee with User ID %1 already exists';
            begin
                if "User ID" <> '' then begin
                    EmployeeRec.Reset();
                    EmployeeRec.SetRange("User ID", "User ID");
                    if EmployeeRec.FindFirst() then
                        Error(UserIDExistsErr, "User ID");
                end;
            end;
        }
        field(50001; "Responsibility Center"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Responsibility Center";
            Caption = 'Responsibility Center';
        }
        field(49999; "Gender."; Enum "Employee Gender HR")
        {

        }
    }

    var
        EmployeeRec: Record "HR Employees";
}



