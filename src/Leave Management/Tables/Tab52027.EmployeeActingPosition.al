table 52027 "Employee Acting Position"
{
    DataClassification = CustomerContent;
    Caption = 'Employee Acting Position';
    fields
    {
        field(1; No; Code[20])
        {
            Caption = 'No';
        }
        field(2; Position; Code[30])
        {
            TableRelation = "Company Job"."Job ID";
            Caption = 'Position';

            trigger OnValidate()
            begin

                Jobs.Reset();
                Jobs.SetRange("Job ID", Position);
                if Jobs.Find('-') then
                    "Job Description" := Jobs."Job Description";
            end;
        }
        field(3; "Relieved Employee"; Code[30])
        {
            TableRelation = Employee."No." where("Job Position" = field(Position));
            Caption = 'Relieved Employee';

            trigger OnValidate()
            begin
                Employee.Reset();
                Employee.SetRange("No.", "Relieved Employee");
                if Employee.Find('-') then begin
                    "Relieved Name" := (Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name");
                    Employee.TestField("Salary Scale");
                    //  Employee.TestField("Present Pointer");
                    "New Scale" := Employee."Salary Scale";
                    //  "New Pointer" := Employee."Present Pointer";
                end;
            end;
        }
        field(4; "Relieved Name"; Text[60])
        {
            Caption = 'Relieved Name';
        }
        field(5; "Start Date"; Date)
        {
            Caption = 'Start Date';

            trigger OnValidate()
            var
                DateForm: Text;
            begin
                DateForm := '<60D>';
                if "Start Date" <> 0D then
                    "Maturity Date" := CalcDate('60D', "Start Date");
            end;
        }
        field(6; "End Date"; Date)
        {
            Caption = 'End Date';
        }
        field(8; Name; Text[30])
        {
            Caption = 'Name';
        }
        field(9; Status; Option)
        {
            OptionCaption = 'New,Pending Approval,Approved,Rejected';
            OptionMembers = New,"Pending Approval",Approved,Rejected;
            Caption = 'Status';
        }
        field(10; "No Series"; Code[30])
        {
            Caption = 'No Series';
        }
        field(11; Reason; Text[200])
        {
            Caption = 'Reason';
        }
        field(12; Processed; Boolean)
        {
            Caption = 'Processed';
        }
        field(13; "Job Description"; Text[60])
        {
            Caption = 'Job Description';
        }
        field(14; "Acting Employee No."; Code[30])
        {
            TableRelation = "HR Employees"."No.";
            Caption = 'Employee No.';

            trigger OnValidate()
            begin
                Employee.Get("Acting Employee No.");
                Name := Employee.FullName();
                "Current Scale" := Employee."Salary Scale";
                // "Current Pointer" := Employee."Present Pointer";
                "Current Position" := Employee."Job Position";
                "Current Position Name" := Employee."Job Position Title";

                case "Document Type" of
                    "Document Type"::Acting:
                        begin
                            Acting.Reset();
                            Acting.SetRange("Acting Employee No.", "Acting Employee No.");
                            Acting.SetRange(Status, Acting.Status::Approved);
                            Acting.SetFilter("End Date", '=%1|>%2', 0D, Today);
                            if Acting.FindFirst() then
                                Error('This Employee is already on an acting capacity');

                            // Earnings.Reset();
                            //Earnings.SetRange("Acting Allowance", true);
                            //  if not Earnings.FindFirst() then
                            //    Error('Please set up an Acting Allowance Code in Earnings Setup page');

                            //"Acting Amount" := PayrollManagement.GetActingAllowance(Rec, "Difference Amount", "Steps Higher Amount");
                        end;
                end;
            end;
        }
        field(15; "Document Type"; Option)
        {
            OptionCaption = ' ,Acting,Promotion,Demotion';
            OptionMembers = " ",Acting,Promotion,Demotion;
            Caption = 'Action Type';
        }
        field(16; "Requested By"; Code[30])
        {
            Caption = 'Requested By';
        }
        field(17; "Request Name"; Text[60])
        {
            Caption = 'Request Name';
        }
        field(18; "Request Date"; Date)
        {
            Caption = 'Request Date';
        }
        field(19; "Desired Position"; Code[30])
        {
            TableRelation = "Company Job";
            Caption = 'Desired Position';

            trigger OnValidate()
            begin
                Jobs.Reset();
                Jobs.SetRange("Job ID", "Desired Position");
                if Jobs.Find('-') then
                    "Position Name" := Jobs."Job Description";
            end;
        }
        field(20; "Position Name"; Text[60])
        {
            Caption = 'Position Name';
            Editable = false;
        }
        field(21; "Basic Pay"; Decimal)
        {
            Caption = 'Basic Pay';
        }
        field(22; "Acting Amount"; Decimal)
        {
            Caption = 'Acting Amount';
        }
        field(23; Qualified; Boolean)
        {
            Caption = 'Qualified';

            trigger OnValidate()
            begin
                // PayPeriod.Reset();
                // PayPeriod.SetRange(Closed, false);
                // if PayPeriod.FindFirst() then begin
                //     AssignMatrix.Reset();
                //     AssignMatrix.SetRange("Payroll Period", PayPeriod."Starting Date");
                //     AssignMatrix.SetRange("Employee No", "Acting Employee No.");
                //     AssignMatrix.SetRange("Basic Salary Code", true);
                //     if AssignMatrix.Find('-') then
                //         "Basic Pay" := AssignMatrix.Amount;
                // end;
                // if Qualified = true then begin
                //     Earnings.Reset();
                //     Earnings.SetRange("Acting Allowance", true);
                //     if Earnings.FindFirst() then
                //         "Acting Amount" := ((Earnings.Percentage / 100) * ("Basic Pay"));
                // end else begin
                //     Earnings.Reset();
                //     Earnings.SetRange("Special Duty", true);
                //     if Earnings.FindFirst() then
                //         "Acting Amount" := ((Earnings.Percentage / 100) * ("Basic Pay"));
                // end;
            end;
        }
        field(24; "Current Scale"; Code[10])
        {
            TableRelation = "Salary Scale";
            Caption = 'Current Scale';
        }
        field(25; "Current Pointer"; Code[10])
        {
            //  TableRelation = "Salary Pointer";
            Caption = 'Current Pointer';
        }
        field(26; "Current Benefits"; Decimal)
        {
            // CalcFormula = sum("Scale Benefits".Amount where("Salary Scale" = field("Current Scale"),
            //                                                  "Salary Pointer" = field("Current Pointer"),
            //                                                  "Basic Salary Code" = const(true)));
            // FieldClass = FlowField;
            // Caption = 'Current Benefits';
        }
        field(27; "New Scale"; Code[10])
        {
            TableRelation = "Salary Scale";
            Caption = 'New Scale';
        }
        field(28; "New Pointer"; Code[10])
        {
            //  TableRelation = "Salary Pointer"."Salary Pointer";
            Caption = 'New Pointer';
        }
        field(29; "New Benefits"; Decimal)
        {
            // CalcFormula = sum("Scale Benefits".Amount where("Salary Scale" = field("New Scale"),
            //                                                  "Salary Pointer" = field("New Pointer"),
            //                                                  "Basic Salary Code" = const(true)));
            // FieldClass = FlowField;
            Caption = 'New Benefits';

            trigger OnValidate()
            begin
                Employee."Salary Scale" := "New Scale";
                //   Employee."Basic Pay" := "New Benefits";
                Employee."Job Position Title" := "Desired Position";
            end;
        }
        field(30; "User ID"; Code[30])
        {
            Caption = 'User ID';
        }
        field(31; "Current Position"; Code[30])
        {
            TableRelation = "Company Job";
            Caption = 'Current Position';
            Editable = false;

            trigger OnValidate()
            begin
                Jobs.Reset();
                Jobs.SetRange("Job ID", "Current Position");
                if Jobs.Find('-') then
                    "Current Position Name" := Jobs."Job Description";
            end;
        }
        field(32; "Current Position Name"; Text[60])
        {
            Caption = 'Current Position Name';
            Editable = false;
        }
        field(33; "Difference Amount"; Decimal)
        {
            Caption = 'Difference Amount';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(34; "Steps Higher Amount"; Decimal)
        {
            Caption = 'Steps Higher Amount';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(35; "Maturity Date"; Date)
        {
            Caption = 'Maturity Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        if No = '' then begin
            HRSetup.Get();
            HRSetup.TestField("Acting Nos");
            //NoSeriesMgt.InitSeries(HRSetup."Acting Nos", xRec."No Series", 0D, No, "No Series");
        end;

        "Request Date" := Today;

        "User ID" := UserId;

        UserSetup.Reset();
        UserSetup.SetRange("User ID", "User ID");
        if UserSetup.Find('-') then begin
            Employee.Reset();
            //   Employee.SetRange("User ID", "User ID");
            if Employee.Find('-') then begin
                "Requested By" := Employee."No.";
                "Request Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
            end;
        end;
    end;

    var
        //AssignMatrix: Record "Assignment Matrix";
        Jobs: Record "Company Job";
        // Earnings: Record Earnings;
        Employee: Record "HR Employees";
        Acting: Record "Employee Acting Position";
        HRSetup: Record "Human Resources Setup";
        PayPeriod: Record "Payroll Period";
        UserSetup: Record "User Setup";
    // NoSeriesMgt: Codeunit NoSeriesManagement;
    // PayrollManagement: Codeunit "Payroll";
}





