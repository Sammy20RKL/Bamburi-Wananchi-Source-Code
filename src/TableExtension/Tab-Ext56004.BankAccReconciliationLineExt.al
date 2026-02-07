#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
tableextension 56004 BankAccReconciliationLineExt extends "Bank Acc. Reconciliation Line"
{

    fields
    {
        field(1000; "Posting Exch. Entry No."; Integer)
        {
            Caption = 'Posting Exch. Entry No.';
            Editable = false;
            TableRelation = "Data Exch.";
        }
        field(100001; "Posting Exch. Line No."; Integer)
        {
            Caption = 'Posting Exch. Line No.';
            Editable = false;
        }
        field(50000; Reconciled; Boolean)
        {

            trigger OnValidate()
            var
            begin

            end;
        }
        field(50004; "Open Type"; Option)
        {
            OptionCaption = ' ,Unpresented Cheques List,Uncredited Cheques List';
            OptionMembers = " ",Unpresented,Uncredited;
        }
        field(50005; "Bank Ledger Entry Line No"; Integer)
        {
        }
        field(50006; "Bank Statement Entry Line No"; Integer)
        {
        }
    }

    keys
    {

    }

    fieldgroups
    {
    }

    var
        Text000: label 'You cannot rename a %1.';
        Text001: label 'Delete application?';
        Text002: label 'Update canceled.';
        BankAccLedgEntry: Record "Bank Account Ledger Entry";
        CheckLedgEntry: Record "Check Ledger Entry";
        BankAccRecon: Record "Bank Acc. Reconciliation";
        BankAccSetStmtNo: Codeunit "Bank Acc. Entry Set Recon.-No.";
        CheckSetStmtNo: Codeunit "Check Entry Set Recon.-No.";
        DimMgt: Codeunit DimensionManagement;
        AmountWithinToleranceRangeTok: label '>=%1&<=%2', Comment = 'Do not translate.';
        AmountOustideToleranceRangeTok: label '<%1|>%2', Comment = 'Do not translate.';
}