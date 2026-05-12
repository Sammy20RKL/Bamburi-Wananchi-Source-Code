tableextension 50081 "detailedCustLedgExt" extends "Detailed Cust. Ledg. Entry"
{
    fields
    {
        field(1000; "Transaction Type"; Enum TransactionTypesEnum)
        {
            DataClassification = ToBeClassified;
        }
        field(1001; "Loan No"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(1002; "Loan Type"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(1003; "Amount Posted"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(1004; "Transaction Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(1005; "Created On"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(1009; "Time Created"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(1010; "Prepayment Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(1011; "Group Code"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(1008; "BLoan Officer No."; Code[100])
        {
            DataClassification = ToBeClassified;
        }
    }
    trigger OnInsert()
    begin
        "Amount Posted" := Amount;

    end;
}
