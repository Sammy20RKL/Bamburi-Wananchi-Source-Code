pageextension 50629 "Apply Bank Acc. Ledger Entries" extends "Apply Bank Acc. Ledger Entries"
{
    layout
    {
        modify(CheckBalance)
        {
            Visible = false;
        }
        modify(Balance)
        {
            Caption = 'Current Bank Balance';
        }
        modify(BalanceToReconcile)
        {
            ToolTip = 'Specifies the balance of the bank account since the last posting';
        }
    }
}
