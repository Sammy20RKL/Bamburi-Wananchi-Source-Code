Report 50209 BankReconiliationsummary
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Bank Account Reconcialition Summary';

    RDLCLayout = './Layouts/BankRecsummary.rdlc';

    dataset
    {
        dataitem("Bank Account Statement"; "Bank Account Statement")
        {
            column(Statement_No_; "Statement No.")
            {

            }
            column(Bank_Account_No_; "Bank Account No.")
            {

            }
            column(Statement_Date; "Statement Date") { }
            column(Balance_Last_Statement; "Balance Last Statement") { }
            column(Statement_Ending_Balance; "Statement Ending Balance") { }
        }
    }


}