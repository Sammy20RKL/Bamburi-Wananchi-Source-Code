tableextension 52011 "Gen Journal HR Ext" extends "Gen. Journal Line"
{
    fields
    {

        field(52000; "Employee Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Employee Code';
        }
        field(52001; "Period Reference"; Date)
        {
            DataClassification = CustomerContent;
            TableRelation = "Accounting Period"."Starting Date";
            Caption = 'Period Reference';

            trigger OnValidate()
            begin
            end;
        }
        field(52002; "Emp Payroll Period"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Emp Payroll Period';
        }
        field(52003; "Emp Payroll Code"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Emp Payroll Code';
        }
        field(52004; "Payroll Loan Transaction Type"; Enum PayrollLoanTransactionTypes)
        {
            Caption = 'Loan Transaction Type';
            DataClassification = CustomerContent;
        }
        field(52005; "Payroll Loan No."; Code[50])
        {
            Caption = 'Loan No';
            DataClassification = CustomerContent;
        }
    }
}





