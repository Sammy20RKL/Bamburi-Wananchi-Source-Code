tableextension 52009 "CustLedgerEntryTableExtension" extends "Cust. Ledger Entry"
{
    fields
    {
        field(52000; "Period Reference"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Period Reference';
            Editable = false;
        }
        field(52001; "Payroll Loan Transaction Type"; Enum PayrollLoanTransactionTypes)
        {
            Caption = 'Loan Transaction Type';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(52002; "Payroll Loan No."; Code[50])
        {
            Caption = 'Loan No. (Customer)';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(52003; "Extra Payment"; Boolean)
        {
            Caption = 'Extra Payment';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(52004; "Transaction Priority"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Transaction Priority';
            Editable = false;
        }
    }
}





