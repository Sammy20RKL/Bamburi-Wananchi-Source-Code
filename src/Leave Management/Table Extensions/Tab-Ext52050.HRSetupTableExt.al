tableextension 52050 "HRSetupTableExt" extends "Human Resources Setup"
{
    fields
    {
        field(52000; "Corporation Tax"; Decimal)
        {
            DataClassification = SystemMetadata;
            Caption = 'Corporation Tax';
        }
        field(52001; "Housing Earned Limit"; Decimal)
        {
            DataClassification = SystemMetadata;
            Caption = 'Housing Earned Limit';
        }
        field(52002; "Pension Limit Percentage"; Decimal)
        {
            DataClassification = SystemMetadata;
            Caption = 'Pension Limit Percentage';
        }
        field(52003; "Pension Limit Amount"; Decimal)
        {
            DataClassification = SystemMetadata;
            Caption = 'Pension Limit Amount';
        }
        field(52004; "Round Down"; Boolean)
        {
            DataClassification = SystemMetadata;
            Caption = 'Round Down';
        }
        field(52005; "Working Hours"; Decimal)
        {
            DataClassification = SystemMetadata;
            Caption = 'Working Hours';
        }
        field(52006; "Payroll Rounding Precision"; Decimal)
        {
            DataClassification = SystemMetadata;
            Caption = 'Payroll Rounding Precision';
        }
        field(52007; "Payroll Rounding Type"; Option)
        {
            DataClassification = SystemMetadata;
            OptionMembers = Nearest,Up,Down;
            Caption = 'Payroll Rounding Type';
        }
        field(52008; "Company overtime hours"; Decimal)
        {
            DataClassification = SystemMetadata;
            Caption = 'Company overtime hours';
        }
        field(52009; "Loan Product Type Nos."; Code[10])
        {
            DataClassification = SystemMetadata;
            TableRelation = "No. Series".Code;
            Caption = 'Loan Product Type Nos.';
        }
        field(52010; "Tax Relief Amount"; Decimal)
        {
            DataClassification = SystemMetadata;
            Caption = 'Tax Relief Amount';
        }
        field(52011; "General Payslip Message"; Text[100])
        {
            DataClassification = SystemMetadata;
            Caption = 'General Payslip Message';
        }
        field(52012; "Applicants Nos."; Code[10])
        {
            DataClassification = SystemMetadata;
            TableRelation = "No. Series".Code;
            Caption = 'Applicants Nos.';
        }
        field(52013; "Leave Application Nos."; Code[10])
        {
            DataClassification = SystemMetadata;
            TableRelation = "No. Series".Code;
            Caption = 'Leave Application Nos.';
        }
        field(52014; "Recruitment Needs Nos."; Code[10])
        {
            DataClassification = SystemMetadata;
            TableRelation = "No. Series".Code;
            Caption = 'Recruitment Needs Nos.';
        }
        field(52015; "Disciplinary Cases Nos."; Code[10])
        {
            DataClassification = SystemMetadata;
            TableRelation = "No. Series".Code;
            Caption = 'Disciplinary Cases Nos.';
        }
        field(52016; "Transport Request Nos"; Code[10])
        {
            DataClassification = SystemMetadata;
            TableRelation = "No. Series";
            Caption = 'Transport Request Nos';
        }
        field(52017; "Cover Selection Nos"; Code[10])
        {
            DataClassification = SystemMetadata;
            TableRelation = "No. Series";
            Caption = 'Cover Selection Nos';
        }
        field(52018; "Qualification Days (Leave)"; Decimal)
        {
            DataClassification = SystemMetadata;
            Caption = 'Qualification Days (Leave)';
        }
        field(52019; "Leave Allowance Code"; Code[10])
        {
            DataClassification = SystemMetadata;
            //TableRelation = Earnings;
            Caption = 'Leave Allowance Code';
        }
        field(52020; "Training Request Nos"; Code[10])
        {
            DataClassification = SystemMetadata;
            TableRelation = "No. Series";
            Caption = 'Training Request Nos';
        }
        field(52021; "Leave Recall Nos"; Code[10])
        {
            DataClassification = SystemMetadata;
            TableRelation = "No. Series";
            Caption = 'Leave Recall Nos';
        }
        field(52022; "Medical Claim Nos"; Code[10])
        {
            DataClassification = SystemMetadata;
            TableRelation = "No. Series";
            Caption = 'Medical Claim Nos';
        }
        field(52023; "Account No (Training)"; Code[20])
        {
            DataClassification = SystemMetadata;
            TableRelation = "G/L Account";
            Caption = 'Account No (Training)';
        }
        field(52024; "Training Evaluation Nos"; Code[10])
        {
            DataClassification = SystemMetadata;
            TableRelation = "No. Series";
            Caption = 'Training Evaluation Nos';
        }
        field(52025; "Appraisal Nos"; Code[10])
        {
            DataClassification = SystemMetadata;
            TableRelation = "No. Series";
            Caption = 'Appraisal Nos';
        }
        field(52026; "Leave Plan Nos"; Code[10])
        {
            DataClassification = SystemMetadata;
            TableRelation = "No. Series";
            Caption = 'Leave Plan Nos';
        }
        field(52027; "Incidences Nos"; Code[10])
        {
            DataClassification = SystemMetadata;
            Caption = 'Incidences Nos';
            TableRelation = "No. Series";
        }
        field(52028; "Owner Occupied Interest Limit"; Decimal)
        {
            DataClassification = SystemMetadata;
            Caption = 'Owner Occupied Interest Limit';
        }
        field(52029; "Employee Absentism Nos"; Code[20])
        {
            DataClassification = SystemMetadata;
            TableRelation = "No. Series";
            Caption = 'Employee Absentism Nos';
        }
        field(52030; "User Incident Nos"; Code[20])
        {
            DataClassification = SystemMetadata;
            TableRelation = "No. Series";
            Caption = 'User Incident Nos';
        }
        field(52031; "Resource Request Nos"; Code[20])
        {
            DataClassification = SystemMetadata;
            TableRelation = "No. Series";
            Caption = 'Resource Request Nos';
        }
        field(52032; "Appraisal Objective Nos"; Code[10])
        {
            DataClassification = SystemMetadata;
            TableRelation = "No. Series";
            Caption = 'Appraisal Objective Nos';
        }
        field(52033; "Human Resource Emails"; Text[100])
        {
            DataClassification = SystemMetadata;
            Caption = 'Human Resource Emails';
        }
        field(52034; "Retirement Age"; Decimal)
        {
            DataClassification = SystemMetadata;
            Caption = 'Retirement Age';
        }
        field(52035; "Probation Period"; DateFormula)
        {
            DataClassification = SystemMetadata;
            Caption = 'Probation Period';
        }
        field(52036; "Company NHIF No"; Code[20])
        {
            DataClassification = SystemMetadata;
            Caption = 'Company NHIF No';
        }
        field(52037; "Company NSSF No"; Code[20])
        {
            DataClassification = SystemMetadata;
            Caption = 'Company NSSF No';
        }
        field(52038; "Payroll Journal Template"; Code[20])
        {
            DataClassification = SystemMetadata;
            TableRelation = "Gen. Journal Template";
            Caption = 'Payroll Journal Template';
        }
        field(52039; "Payroll Journal Batch"; Code[20])
        {
            DataClassification = SystemMetadata;
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Payroll Journal Template"));
            Caption = 'Payroll Journal Batch';
        }
        field(52040; "Leave Adjustment Nos"; Code[20])
        {
            DataClassification = SystemMetadata;
            TableRelation = "No. Series";
            Caption = 'Leave Adjustment Nos';
        }
        field(52041; "Assignment Nos"; Code[20])
        {
            DataClassification = SystemMetadata;
            TableRelation = "No. Series";
            Caption = 'Assignment Nos';
        }
        field(52042; "Dependant Maximum Age"; DateFormula)
        {
            DataClassification = SystemMetadata;
            Caption = 'Dependant Maximum Age';
        }
        field(52043; "Vehicle Maintenance Nos"; Code[30])
        {
            DataClassification = SystemMetadata;
            TableRelation = "No. Series";
            Caption = 'Vehicle Maintenance Nos';
        }
        field(52044; "Disabililty Tax Exp. Amt"; Decimal)
        {
            DataClassification = SystemMetadata;
            Caption = 'Disabililty Tax Exp. Amt';
        }
        field(52045; "Payroll Req Nos"; Code[20])
        {
            DataClassification = SystemMetadata;
            TableRelation = "No. Series";
            Caption = 'Payroll Req Nos';
        }
        field(52046; "Reference Letter Text"; BLOB)
        {
            DataClassification = SystemMetadata;
            SubType = Memo;
            Caption = 'Reference Letter Text';
        }
        field(52047; "Acting Nos"; Code[30])
        {
            DataClassification = SystemMetadata;
            TableRelation = "No. Series";
            Caption = 'Acting Nos';
        }
        field(52048; "Transfer Nos"; Code[30])
        {
            DataClassification = SystemMetadata;
            TableRelation = "No. Series";
            Caption = 'Transfer Nos';
        }
        field(52049; "Payroll Change Nos"; Code[20])
        {
            DataClassification = SystemMetadata;
            TableRelation = "No. Series";
            Caption = 'Payroll Change Nos';
        }
        field(52050; "Loan App No"; Code[20])
        {
            DataClassification = SystemMetadata;
            TableRelation = "No. Series";
            Caption = 'Loan App No';
        }
        field(52051; "Shortlisting Criteria"; Code[20])
        {
            DataClassification = SystemMetadata;
            TableRelation = "No. Series";
            Caption = 'Shortlisting Criteria';
        }
        field(52052; "Leave Allowance"; Decimal)
        {
            DataClassification = SystemMetadata;
            Caption = 'Leave Allowance';
        }
        field(52053; "Contract Nos"; Code[20])
        {
            DataClassification = SystemMetadata;
            TableRelation = "No. Series";
            Caption = 'Contract Nos';
        }
        field(52054; "Payroll Import Nos"; Code[20])
        {
            DataClassification = SystemMetadata;
            TableRelation = "No. Series";
            Caption = 'Payroll Import Nos';
        }
        field(52055; "Employee Change Nos"; Code[20])
        {
            DataClassification = SystemMetadata;
            TableRelation = "No. Series";
            Caption = 'Employee Change Nos';
        }
        field(52056; "Payroll Journal No."; Code[20])
        {
            DataClassification = SystemMetadata;
            TableRelation = "No. Series";
            Caption = 'Payroll Journal No.';
        }
        field(52057; "Training Needs Nos"; Code[10])
        {
            DataClassification = SystemMetadata;
            TableRelation = "No. Series";
            Caption = 'Training Needs Nos';
        }
        field(52058; "Loan Interest Nos"; Code[10])
        {
            DataClassification = SystemMetadata;
            TableRelation = "No. Series";
            Caption = 'Loan Interest Nos';
        }
        field(52059; "Loan Interest Template"; Code[10])
        {
            DataClassification = SystemMetadata;
            TableRelation = "Gen. Journal Template";
            Caption = 'Loan Interest Template';
        }
        field(52060; "Trustee Nos"; Code[10])
        {
            DataClassification = SystemMetadata;
            TableRelation = "No. Series";
            Caption = 'Trustee Nos';
        }
        field(52061; "Secondary PAYE %"; Decimal)
        {
            DataClassification = SystemMetadata;
            Caption = 'Secondary PAYE %';
        }
        field(52062; "Trustee Reversal Nos"; Code[10])
        {
            DataClassification = SystemMetadata;
            TableRelation = "No. Series";
            Caption = 'Trustee Reversal Nos';
        }
        field(52063; "Trustee Reversal Template"; Code[10])
        {
            DataClassification = SystemMetadata;
            TableRelation = "Gen. Journal Template";
            Caption = 'Trustee Reversal Template';
        }
        field(52064; "Imprest Deduction Nos"; Code[10])
        {
            DataClassification = SystemMetadata;
            TableRelation = "No. Series";
            Caption = 'Imprest Deduction Nos';
        }
        field(52065; "Imprest Due Days"; Integer)
        {
            DataClassification = SystemMetadata;
            Caption = 'Imprest Due Days';
        }
        field(52066; "Default Base Calendar"; Code[10])
        {
            DataClassification = SystemMetadata;
            TableRelation = "Base Calendar".Code;
            Caption = 'Default Base Calendar';
        }
        field(52067; "Transport Request Nos."; Code[10])
        {
            DataClassification = SystemMetadata;
            TableRelation = "No. Series";
            Caption = 'Transport Request Nos.';
        }
        field(52068; "Net pay ratio to Earnings"; Decimal)
        {
            DataClassification = SystemMetadata;
            Description = 'Ratio that defines 1/3 rule for net pay';
            Caption = 'Net pay ratio to Earnings';
        }
        field(52069; "Enforce a third rule"; Boolean)
        {
            DataClassification = SystemMetadata;
            Caption = 'Enforce a third rule';
        }
        field(52070; "Training Needs Request Nos."; Code[10])
        {
            DataClassification = SystemMetadata;
            TableRelation = "No. Series";
            Caption = 'Training Needs Request Nos.';
        }
        field(52071; "Payroll Approval Nos"; Code[10])
        {
            DataClassification = SystemMetadata;
            TableRelation = "No. Series";
            Caption = 'Payroll Approval Nos';
        }
        field(52072; "Training Budget Item Nos"; Code[10])
        {
            DataClassification = SystemMetadata;
            TableRelation = "No. Series";
            Caption = 'Training Budget Item Nos';
        }
        field(52073; "Minimum Employee Age"; Decimal)
        {
            DataClassification = SystemMetadata;
            Caption = 'Minimum Employee Age';
        }
        field(52074; "Education Institution Nos"; Code[10])
        {
            DataClassification = SystemMetadata;
            TableRelation = "No. Series";
            Caption = 'Education Institution Nos';
        }
        field(52075; "Employee Separation Nos"; Code[10])
        {
            DataClassification = SystemMetadata;
            TableRelation = "No. Series";
            Caption = 'Employee Separation Nos';
        }
        field(52076; "Job Application Nos"; Code[10])
        {
            DataClassification = SystemMetadata;
            TableRelation = "No. Series";
            Caption = 'Job Application Nos';
        }
        field(52077; "Working Hours Start Time"; Time)
        {
            Caption = 'Working Hours Start Time';
            DataClassification = SystemMetadata;
            trigger OnValidate()
            begin
                if "Working Hours End Time" <> 0T then
                    "Working Hours" := "Working Hours End Time" - "Working Hours Start Time"
            end;
        }
        field(52078; "Working Hours End Time"; Time)
        {
            Caption = 'Working Hours End Time';
            DataClassification = SystemMetadata;

            trigger OnValidate()
            begin
                if "Working Hours Start Time" <> 0T then
                    "Working Hours" := "Working Hours End Time" - "Working Hours Start Time"
            end;
        }
        field(52079; "Loans Cut-Off Day"; Integer)
        {
            Caption = 'Loans Cut-Off Day (i.e. 5 if 5th)';
            DataClassification = CustomerContent;
        }
        field(52080; "CEO Email"; Text[50])
        {
            Caption = 'CEO Email';
            DataClassification = CustomerContent;
        }
        field(52081; "Prevent PayrollRun on Approval"; Boolean)
        {
            Caption = 'Prevent Payroll Run on Approval';
            DataClassification = SystemMetadata;
        }
        field(52082; "Secondary PAYE %-Staff"; Decimal)
        {
            Caption = 'Secondary PAYE %-Staff';
            DataClassification = SystemMetadata;
        }
        field(52083; "Staff Req Nos."; Code[20])
        {
            Caption = 'Staff Req Nos.';
            DataClassification = SystemMetadata;
            TableRelation = "No. Series".Code;
        }
        field(52084; "Compute Leave Liability"; Boolean)
        {
            Caption = 'Compute Leave Liability';
            DataClassification = SystemMetadata;
        }
        field(52085; "Effect Anniversary Increment"; Boolean)
        {
            Caption = 'Effect Anniversary Increment';
            DataClassification = SystemMetadata;
        }
        field(52086; "Payroll TimeSheet No."; Code[200])
        {
            Caption = 'Payroll TimeSheet No.';
            DataClassification = SystemMetadata;
            TableRelation = "No. Series".Code;
        }
        field(52092; "Bank Charges Account"; Code[20])
        {
            DataClassification = SystemMetadata;
            TableRelation = "G/L Account"."No.";
        }
    }
}





