pageextension 50626 "purchasejournallinesext" extends "Purchase Journal"
{
    layout
    {
        addafter("Credit Amount")
        {
            field("Debit Amounts"; Rec."Debit Amount")
            {
                ApplicationArea = Basic;
            }
            field("Credit Amounts"; Rec."Credit Amount")
            {
                ApplicationArea = Basic;
            }
            field("Transaction Type"; Rec."Transaction Type")
            {
                ApplicationArea = Basic;
            }
            field("Loan No"; Rec."Loan No")
            {
                ApplicationArea = Basic;
            }
            field("Loan Product Type"; Rec."Loan Product Type")
            {
                ApplicationArea = Basic;
            }
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = Basic;
            }


        }
        modify("External Document No.")
        {
            Visible = false;
        }
        modify("Document Type")
        {
            Visible = false;
        }
        modify("Currency Code")
        {
            Visible = false;
        }
        modify("Gen. Posting Type")
        {
            Visible = false;
        }
        modify("Gen. Bus. Posting Group")
        {
            Visible = false;
        }
        modify("Gen. Prod. Posting Group")
        {
            Visible = false;
        }
        modify("Bal. Gen. Posting Type")
        {
            Visible = false;
        }
        modify("Bal. Gen. Bus. Posting Group")
        {
            Visible = false;
        }
        modify("Bal. Gen. Prod. Posting Group")
        {
            Visible = false;
        }
        modify(Comment)
        {
            Visible = false;
        }
        modify("VAT Reporting Date")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 1 Code")
        {
            Caption = 'Activity';
        }
        modify("Shortcut Dimension 2 Code")
        {
            Caption = 'Branch';
        }
        modify(Correction)
        {
            Visible = false;
        }
        modify("Amount (LCY)")
        {
            Visible = false;
        }
    }

}
