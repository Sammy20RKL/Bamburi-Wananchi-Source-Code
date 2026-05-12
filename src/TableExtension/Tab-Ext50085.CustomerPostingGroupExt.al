tableextension 50085 "Customer Posting Group Ext" extends "Customer Posting Group"
{
    fields
    {
        field(22; "Account Type"; Code[100])
        {
            Caption = 'Account Type';
            DataClassification = ToBeClassified;
        }
    }
}