tableextension 52010 "Customer HR Ext" extends Customer
{
    fields
    {
        field(52000; "Payroll Loan No. Filter"; Code[50])
        {
            TableRelation = "Payroll Loan Application" where("Debtors Code" = field("No."));
            FieldClass = FlowFilter;
            Caption = 'Payroll Loan No. Filter';
        }
        field(52001; "Payroll Loan Trans Type Filter"; Enum PayrollLoanTransactionTypes)
        {
            FieldClass = FlowFilter;
            Caption = 'Payroll Loan Trans Type Filter';
        }
    }
}





