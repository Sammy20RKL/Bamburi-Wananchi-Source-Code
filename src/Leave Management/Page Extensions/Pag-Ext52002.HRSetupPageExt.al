pageextension 52002 "HRSetupPageExt" extends "Human Resources Setup"
{
    layout
    {
        modify("Automatically Create Resource")
        {
            Visible = false;
        }
        addbefore(Numbering)
        {
            group(General)
            {
                field("Human Resource Emails"; Rec."Human Resource Emails")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Human Resource Emails field';
                }
                field("Base Calendar Code"; Rec."Default Base Calendar")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Base Calendar Code field';
                    ShowMandatory = true;
                }
                field("Probation Period"; Rec."Probation Period")
                {
                    Caption = 'Probation Period (Months)';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Probation Period (Months) field';
                }
                field("Minimum Employee Age"; Rec."Minimum Employee Age")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Minimum Employee Age field.';
                }
                field("Retirement Age"; Rec."Retirement Age")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Retirement Age field';
                }
                field("Dependant Maximum Age"; Rec."Dependant Maximum Age")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Dependant Maximum Age field';
                }
                field("Working Hours Start Time"; Rec."Working Hours Start Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Working Hours Start Time field.';
                }
                field("Working Hours End Time"; Rec."Working Hours End Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Working Hours End Time field.';
                }
                field("Working Hours"; Rec."Working Hours")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Working Hours field';
                }
                field("Company NHIF No"; Rec."Company NHIF No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Company NHIF No field';
                }
                field("Company NSSF No"; Rec."Company NSSF No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Company NSSF No field';
                }
            }
        }

        addlast(Numbering)
        {
            group(EmployeeNos)
            {
                Caption = 'Employees';
                field("Employee Separation Nos"; Rec."Employee Separation Nos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Separation Nos field.';
                }
                field("Employee Absentism Nos"; Rec."Employee Absentism Nos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employee Absentism field';
                }
                field("Disciplinary Cases Nos."; Rec."Disciplinary Cases Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Disciplinary Cases Nos. field';
                }
                field("Contract Nos"; Rec."Contract Nos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contract Nos field';
                }
                field("Employee Change Nos"; Rec."Employee Change Nos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employee Change Nos field';
                }
                field("Acting Nos"; Rec."Acting Nos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Acting Nos field';
                }
                field("Transfer Nos"; Rec."Transfer Nos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transfer Nos field';
                }
                field("Trustee Nos";Rec."Trustee Nos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Trustee Nos field';
                }
            }
            group(LeaveNos)
            {
                Caption = 'Leave';
                field("Leave Application Nos."; Rec."Leave Application Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Leave Application Nos. field';
                }
                field("Leave Recall Nos"; Rec."Leave Recall Nos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Leave Recall Nos field';
                }
                field("Leave Adjustment Nos"; Rec."Leave Adjustment Nos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Leave Adjustment Nos field';
                }
                field("Leave Plan Nos"; Rec."Leave Plan Nos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Leave Plan Nos field';
                }
            }
            group(PayrollNos)
            {
                Caption = 'Payroll';
                field("Payroll Journal No."; Rec."Payroll Journal No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payroll Journal No. field';
                }
                field("Payroll Req Nos"; Rec."Payroll Req Nos")
                {
                    ApplicationArea = All;
                    ToolTip =
                     'Specifies the value of the Payroll Req Nos field';
                }
                field("Imprest Deduction Nos"; Rec."Imprest Deduction Nos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Imprest Deduction Nos field';
                }
                field("Payroll Approval Nos"; Rec."Payroll Approval Nos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payroll Approval Nos field';
                }
                field("Payroll Import Nos"; Rec."Payroll Import Nos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payroll Import Nos field';
                }
                field("Loan Product Type Nos."; Rec."Loan Product Type Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Loan Product Type Nos. field';
                }
                field("Loan App No"; Rec."Loan App No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Loan App No field';
                }
                field("Loan Interest Nos"; Rec."Loan Interest Nos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Loan Interest Nos field';
                }
                field("Payroll TimeSheet No."; Rec."Payroll TimeSheet No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Loan Interest Nos field';
                }
            }
            group(RecruitmentNos)
            {
                Caption = 'Recruitment';
                field("Recruitment Needs Nos."; Rec."Recruitment Needs Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Recruitment Needs Nos. field';
                }
                field("Applicants Nos."; Rec."Applicants Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Applicants Nos. field';
                }
                field("Job Application Nos"; Rec."Job Application Nos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employee Separation Nos field.';
                }
                field("Education Institution Nos"; Rec."Education Institution Nos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Education Institution Nos field.';
                }
            }
            group(TrainingNos)
            {
                Caption = 'Training';
                field("Training Evaluation Nos"; Rec."Training Evaluation Nos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Training Evaluation Nos field';
                }
                field("Training Request Nos"; Rec."Training Request Nos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Training Request Nos field';
                }
                field("Training Needs Nos"; Rec."Training Needs Nos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Training Needs Nos field';
                }
                field("Training Needs Request Nos."; Rec."Training Needs Request Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Training Needs Request Nos. field';
                }
                field("Training Budget Item Nos"; Rec."Training Budget Item Nos")
                {
                    ToolTip = 'Specifies the value of the Training Budget Item Nos field.';
                    ApplicationArea = All;
                }
            }
            field("Transport Request Nos."; Rec."Transport Request Nos.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Transport Request Nos. field';
            }
            field("Appraisal Nos"; Rec."Appraisal Nos")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Appraisal Nos field';
            }
            field("Appraisal Objective Nos"; Rec."Appraisal Objective Nos")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Appraisal Objective Nos field';
            }
            field("Vehicle Maintenance Nos"; Rec."Vehicle Maintenance Nos")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vehicle Maintenance Nos field';
            }
            field("User Incident Nos"; Rec."User Incident Nos")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the User Incident field';
            }
        }
        addafter(Numbering)
        {
            group("Leave Setups")
            {
                Caption = 'Leave Setups';
                field("Compute Leave Liability"; Rec."Compute Leave Liability")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Compute Leave Liability field.';
                }
                field("Qualification Days (Leave)"; Rec."Qualification Days (Leave)")
                {
                    Caption = 'Qualification Days (Leave Allowance)';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Qualification Days (Leave) field';
                }
            }
        }
        addafter("Leave Setups")
        {
            group(Payroll)
            {
                Caption = 'Payroll';
                field("Bank Charges Account"; Rec."Bank Charges Account")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the General Payslip Message field';

                }
                field("General Payslip Message"; Rec."General Payslip Message")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the General Payslip Message field';
                }
                group(Amounts)
                {
                    Caption = 'Amounts';
                    field("Tax Relief Amount"; Rec."Tax Relief Amount")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Tax Relief Amount field';
                    }
                    field("Pension Limit Amount"; Rec."Pension Limit Amount")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Pension Limit Amount field';
                    }
                    field("Owner Occupied Interest Limit"; Rec."Owner Occupied Interest Limit")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Owner Occupied Interest Limit field';
                    }
                    field("Disabililty Tax Exp. Amt"; Rec."Disabililty Tax Exp. Amt")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Disabililty Tax Exp. Amt field';
                    }
                    field("Secondary PAYE %"; Rec."Secondary PAYE %")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Secondary PAYE % field';
                    }
                }
                group(PayrollRounding)
                {
                    Caption = 'Payroll Rounding';
                    field("Payroll Rounding Type"; Rec."Payroll Rounding Type")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Payroll Rounding Type field';
                    }
                    field("Payroll Rounding Precision"; Rec."Payroll Rounding Precision")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Payroll Rounding Precision field';
                    }
                }
                group(PayrollPosting)
                {
                    Caption = 'Payroll Posting';
                    field("Payroll Journal Template"; Rec."Payroll Journal Template")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Payroll Journal Template field';
                    }
                    field("Payroll Journal Batch"; Rec."Payroll Journal Batch")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Payroll Journal Batch field';
                    }
                    field("Loan Interest Template"; Rec."Loan Interest Template")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Loan Interest Template field';
                    }
                }
                field("Loans Cut-Off Day"; Rec."Loans Cut-Off Day")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Loans Cut-Off Day field.';
                }
                field("Imprest Due Days"; Rec."Imprest Due Days")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Imprest Due Days field';
                }
                field("Effect Anniversary Increment"; Rec."Effect Anniversary Increment")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Effect Annual Increment field.';
                }
                field("Prevent PayrollRun on Approval"; Rec."Prevent PayrollRun on Approval")
                {
                    Caption = 'Prevent Payroll Run on Approval';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prevent Payroll Run on Approval field.';
                }
                field("Enforce a third rule"; Rec."Enforce a third rule")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Enforce a third rule field';
                }
                field("Net pay ratio to Earnings"; Rec."Net pay ratio to Earnings")
                {
                    Editable = Rec."Enforce a third rule";
                    Caption = 'Ratio for 1/3 rule';
                    ToolTip = 'Ratio for 1/3 rule';
                    ApplicationArea = All;
                }
            }
        }
        addafter(Payroll)
        {
            group(Notes)
            {
                Caption = 'Notes';
                Visible = false;

                field("Reference Notes"; RNotesText)
                {
                    MultiLine = true;
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the RNotesText field';

                    trigger OnValidate()
                    begin

                        Rec.CalcFields("Reference Letter Text");
                        Rec."Reference Letter Text".CreateInStream(Instr);
                        RNotes.Read(Instr);

                        if RNotesText <> Format(RNotes) then begin
                            Clear(Rec."Reference Letter Text");
                            Clear(RNotes);
                            RNotes.AddText(RNotesText);
                            Rec."Reference Letter Text".CreateOutStream(OutStr);
                            RNotes.Write(OutStr);
                        end;
                    end;
                }
            }
        }
    }

    var
        RNotes: BigText;
        Instr: InStream;
        OutStr: OutStream;
        RNotesText: Text;
}





