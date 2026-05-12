tableextension 50040 "UserSetUpExt" extends "User Setup"
{
    fields
    {
        field(100; "Staff Travel Account"; Code[20])
        {
            Caption = 'Staff Travel Account';
            DataClassification = ToBeClassified;
            TableRelation = Customer."No.";
        }
        field(200; "Issue Trunch"; Boolean) { }

        field(53900; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(53902; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(51516000; "Financial User"; Boolean)
        {
        }
        field(51516001; "Payroll User"; Boolean)
        {
        }
        field(51516003; "View Cashier Report"; Boolean)
        {
        }
        field(51516004; "Reversal Right"; Boolean)
        {
        }
        field(51516005; "UnLimited Posting"; Boolean)
        {
        }

        field(51516006; State; Option)
        {
            Caption = 'State';
            OptionCaption = 'Enabled,Disabled';
            OptionMembers = Enabled,Disabled;
        }
        field(51516007; "Expiry Date"; DateTime)
        {
            Caption = 'Expiry Date';
        }
        field(51516008; "Windows Security ID"; Text[119])
        {
            Caption = 'Windows Security ID';
        }
        field(51516009; "Change Password"; Boolean)
        {
            Caption = 'Change Password';
        }
        field(51516011; "Authentication Email"; Text[250])
        {
            Caption = 'Authentication Email';
        }
        field(51516012; "Contact Email"; Text[250])
        {
            Caption = 'Contact Email';
        }
        field(51516013; Branch; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(51516014; Activity; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(51516015; "Show Hiden"; Boolean)
        {
        }
        field(51516017; "Department Code"; Code[50])
        {
        }
        field(51516018; "Responsibility Center"; Code[50])
        {
        }
        field(51516019; "Post Leave Days Allocations"; Boolean)
        {
        }
        field(51516020; "User Can Process Dividends"; Boolean)
        {
        }
        field(51516021; "Exempt OTP On LogIn"; Boolean)
        {
        }
        field(51516022; "Exempt Posting Date Update"; Boolean)
        {

        }
        field(51516023; "Exempt Logs"; Boolean)
        {
        }
        field(51516024; "Can POST Loans"; Boolean)
        {
        }
        field(515156025; "Allow Process Payroll"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        // field(51516026; "Responsibility Centre"; code[20]) { }
        field(51516027; "Other Advance Staff Account"; code[20]) { }//"Imprest Account"
        // field(51516028; "Imprest Account"; code[20]) { }//"Imprest Account"
        field(51516029; "View Payroll"; Boolean) { }//"Imprest Account"
        field(51516030; "Approval Status Change"; Boolean) { }
        field(51516031; "Post Bank Rec"; Boolean) { }
        field(1008; "Role Centre"; code[100])
        {
            CalcFormula = Lookup("All Profile".Caption WHERE(Scope = const(Tenant)));
            FieldClass = FlowField;
            Editable = true;

            trigger OnValidate()
            var
                UserPersonalization: record "User Personalization";
            begin
                UserPersonalization.Reset();
                UserPersonalization.SetRange(UserPersonalization."User ID", "User ID");
                if UserPersonalization.Find('-') then begin
                    UserPersonalization.Role := "Role Centre";
                    UserPersonalization.Modify(true);
                    Message('User Profile for %1 successfully changed to %2', "User ID", "Role Centre");
                end;
            end;
        }
    }


    fieldgroups
    {
    }

    trigger OnDelete()
    var
        NotificationSetup: Record "Notification Setup";
    begin
        NotificationSetup.SetRange("User ID", "User ID");
        NotificationSetup.DeleteAll(true);
    end;

    var
        Text001: label 'The %1 Salesperson/Purchaser code is already assigned to another User ID %2.';
        Text003: label 'You cannot have both a %1 and %2. ';
        Text005: label 'You cannot have approval limits less than zero.';
}
