tableextension 51045 "BankAccountLedgerEntryExt" extends "Bank Account Ledger Entry"
{
    fields
    {
        field(50099; "Type"; Code[100])
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
        }
        field(50100; "Transaction Type"; Enum TransactionTypesEnum) { Caption = 'Transaction Type'; }
        field(50101; "Loan No"; Code[20]) { Caption = 'Loan No'; }
        field(50102; "Loan Product Type"; Code[20]) { Caption = 'Loan Product Type'; }
        field(50103; "Amount Posted"; Decimal) { Caption = 'Amount Posted'; }
        field(50104; "Transaction Date"; Date) { Caption = 'Transaction Date'; }
        field(50105; "Last Date Modified"; Date) { Caption = 'Last Date Modified'; }
        field(50106; "Created On"; DateTime) { Caption = 'Created On'; }
        field(50107; "Time Created"; Time) { Caption = 'Time Created'; }
        field(50108; "Pre-payment Date"; Date) { Caption = 'Pre-payment Date'; }
        field(50109; "Group Code"; Code[20]) { Caption = 'Group Code'; }
    }
}
