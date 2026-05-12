pageextension 50627 BankAccountLedgerEntries extends "Bank Account Ledger Entries"
{

    layout
    {
        addafter(Amount)
        {

            field("External Document No."; Rec."External Document No.")
            {
                ApplicationArea = Basic;
            }
            field("DebitAmount"; Rec."Debit Amount")
            {
                ApplicationArea = Basic;
                Caption = 'Debit Amount';
            }
            field("CreditAmount"; Rec."Credit Amount")
            {
                ApplicationArea = Basic;
                Caption = 'Credit Amount';
            }
            field("User"; Rec."User ID")
            {
                ApplicationArea = Basic;
                Caption = 'User ID';
            }

        }
        modify(GLEntriesPart)
        {
            Visible = false;
        }
        modify(Open)
        {
            Visible = false;
        }
        modify("Document Type")
        {
            Visible = false;
        }

    }
    actions
    {
        modify("Reverse Transaction")
        {
            Visible = false;
        }
    }
}
