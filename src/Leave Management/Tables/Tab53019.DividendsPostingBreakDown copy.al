table 53019 "Dividends Posting Breakdown"
{
    Caption = 'Dividends Posting Breakdown';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Entry; Integer)
        {
            Caption = 'Entry';
        }
        field(2; "Member Number"; Code[20])
        {
            Caption = 'Member Number';
        }
        field(3; Name; Code[50])
        {
            Caption = 'Name';
        }
        field(4; "Payroll Number"; Code[20])
        {
            Caption = 'Payroll Number';
        }
        field(5; "Qualifying Shares"; Decimal)
        {
            Caption = 'Qualifying Shares';
        }
        field(6; "Qualifying Deposits"; Decimal)
        {
            Caption = 'Qualifying Deposits';
        }
        field(7; "Dividends On Shares"; Decimal)
        {
            Caption = 'Dividends On Shares';
        }
        field(8; "Interest on Deposits"; Decimal)
        {
            Caption = 'Interest on Deposits';
        }
        field(9; "Total Earnings"; Decimal)
        {
            Caption = 'Total Earnings';
        }
        field(10; "Withholding Tax"; Decimal)
        {
            Caption = 'Withholding Tax';
        }
        field(11; "Processing Fee"; Decimal)
        {
            Caption = 'Processing Fee';
        }
        field(12; "Loan Arrears Recovered"; Decimal)
        {
            Caption = 'Loan Arrears Recovered';
        }
        field(13; "Net Paid to Wallets"; Decimal)
        {
            Caption = 'Net Paid to Wallets';
        }
        field(14; "ShareCapitalization"; Decimal) { }
    }
    keys
    {
        key(PK; Entry)
        {
            Clustered = true;
        }
        key(key2; "Member Number") { }
    }
}
