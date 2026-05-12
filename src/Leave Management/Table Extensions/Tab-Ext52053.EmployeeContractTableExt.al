tableextension 52053 "EmployeeContractTableExt" extends "Employment Contract"
{
    fields
    {
        field(52000; "Employee Type"; Option)
        {
            OptionCaption = 'Permanent,Partime,Locum,Casual,Contract,Trustees';
            OptionMembers = Permanent,Partime,Locum,Casual,Contract,Trustees;
            DataClassification = CustomerContent;
            Caption = 'Employee Type';
        }
        field(52001; "Annual Leave Days"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Annual Leave Days';
        }
        field(52002; "Period Leave Days"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Period Leave Days';
        }
        field(52003; "Allocate Periodically"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Allocate Periodically';
        }
        field(52004; "Tenure"; DateFormula)
        {
            DataClassification = CustomerContent;
            Caption = 'Tenure';
        }
    }
}