pageextension 50877 "BankAccountCardExt" extends "Bank Account Card"
{
    layout
    {
        addafter("Bank Acc. Posting Group")
        {
            field("Account Type"; Rec."Account Type")
            {
                ApplicationArea = Basic;
            }
            field(CashierID; Rec.CashierID)
            {
                ApplicationArea = Basic;
            }
        }
    }
    trigger OnDeleteRecord(): Boolean
    var
        bankacount: Record "Bank Account";
        BankLedgEntry: record "Bank Account Ledger Entry";
    begin
        bankacount.Reset();
        bankacount.SetRange(bankacount."No.", Rec."No.");
        bankacount.SetAutoCalcFields(bankacount.Balance);
        if bankacount.Find('-') then begin
            if bankacount.Balance <> 0 then begin
                Error('Prohibited! cannot delete a bank with entries');
            end else
                if bankacount.Balance = 0 then begin
                    BankLedgEntry.Reset();
                    BankLedgEntry.SetRange(BankLedgEntry."Bank Account No.", bankacount."No.");
                    if BankLedgEntry.Find('-') then begin
                        Error('Prohibited! cannot delete a bank with entries');
                    end;
                end;
        end;
    end;

    trigger OnOpenPage()
    begin
        AuditLog.FnReadingsMadeAudit(UserId, 'Accessed and read the bank accounts page no-' + Format(Rec."No.") + ' Name-' + Format(Rec.Name));
    end;

    trigger OnClosePage()
    begin
        AuditLog.FnReadingsMadeAudit(UserId, 'Closed bank accounts page no-' + Format(Rec."No.") + ' Name-' + Format(Rec.Name));
    end;

    var
        AuditLog: Codeunit "Audit Log Codeunit";
}