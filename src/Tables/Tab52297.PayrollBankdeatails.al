table 52297 "Payroll Bank deatails"
{

    fields
    {
        field(10; "No."; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(58; "Bank Code"; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                BankCodes.Reset;
                BankCodes.SetRange(BankCodes."Bank Code", "Bank Code");
                if BankCodes.FindFirst then begin
                    BankCodes.TestField(BankCodes."Bank Name");
                    "Bank Name" := BankCodes."Bank Name";
                    "Branch Name" := BankCodes.Branch;
                    //"Bank Location" := BankCodes.Location;
                end;
            end;
        }
        field(59; "Bank Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(60; "Branch Code"; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                // BankBranches.Reset;
                // BankBranches.SetRange(BankBranches."Bank Code", "Bank Code");
                // BankBranches.SetRange(BankBranches."Branch Code", "Branch Code");
                // if BankBranches.FindFirst then begin
                //     BankBranches.TestField(BankBranches."Branch Code");
                //     "Branch Name" := BankBranches."Branch Code";
                // end;
            end;
        }
        field(61; "Branch Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(62; "Bank Account No"; Code[50])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(64; "Payroll Period"; Date)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payroll Calender."."Date Opened";
        }
        field(102; "Bank Location"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "No.", "Bank Code", "Bank Account No", "Payroll Period")
        {
        }
    }

    fieldgroups
    {
    }

    var
        CurrExchRate: Record "Currency Exchange Rate";
        BankCodes: Record Banks;
        BankBranches: Record Banks;
        empl: Record "Payroll Employee.";

        Dates: Codeunit "Dates Calculation";
    // MSEASalaryScales: Record "MSEA Salary Scales";
}

