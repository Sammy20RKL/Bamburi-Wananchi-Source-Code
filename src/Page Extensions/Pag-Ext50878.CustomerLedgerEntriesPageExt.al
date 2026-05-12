pageextension 50878 "CustomerLedgerEntriesPageExt" extends "Customer Ledger Entries"
{
    layout
    {

        addafter(Amount)
        {
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
            field("Amount Posted"; Rec."Amount Posted")
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
            field("Loan product Type"; Rec."Loan product Type")
            {
                ApplicationArea = Basic;
            }
            field("Time Created"; Rec."Time Created")
            {
                ApplicationArea = Basic;
            }
            field("UserID"; Rec."User ID")
            {
                ApplicationArea = Basic;
                Caption = 'Posted By';
            }

        }
        modify("Remaining Amount")
        {
            Visible = false;
        }
        modify("Currency Code")
        {
            Visible = false;
        }
        modify("Due Date")
        {
            Visible = false;
        }
        modify(Amount)
        {
            Visible = false;
        }
        modify("Pmt. Disc. Tolerance Date")
        {
            Visible = false;
        }
        modify("Pmt. Discount Date")
        {
            Visible = false;
        }
        modify("Max. Payment Tolerance")
        {
            Visible = false;
        }
        modify("Payment Method Code")
        {
            Visible = false;
        }
        modify(Open)
        {
            Visible = false;
        }
        modify("On Hold")
        {
            Visible = false;
        }
        modify("Message to Recipient")
        {
            Visible = false;
        }
        modify(RecipientBankAccount)
        {
            Visible = false;
        }
        modify("Document Type")
        {
            Visible = false;
        }
        modify("Original Amount")
        {
            Visible = false;
        }
        modify("Remaining Amt. (LCY)")
        {
            Visible = false;
        }

        modify("Sales (LCY)")
        {
            Visible = false;
        }
        modify("Remaining Pmt. Disc. Possible")
        {
            Visible = false;
        }
        modify("Exported to Payment File")
        {
            Visible = false;
        }
        modify("Original Pmt. Disc. Possible")
        {
            Visible = false;
        }
        modify("Amount (LCY)")
        {
            Visible = false;
        }
        modify(Control1903096107)
        {
            Visible = false;
        }
        modify(IncomingDocAttachFactBox)
        {
            Visible = false;
        }
        modify(Control38)
        {
            Visible = false;
        }
        modify(GLEntriesPart)
        {
            Visible = false;
        }

        modify(Control1900383207)
        {
            Visible = false;
        }
        modify(Control1905767507)
        {
            Visible = false;
        }
        modify("Entry No.")
        {
            Visible = false;
        }

    }

    actions
    {

        modify("Create Finance Charge Memo")
        {
            Visible = false;

        }
        modify(UnapplyEntries)
        {
            Visible = false;

        }
        modify(ShowDocumentAttachment)
        {
            Visible = false;

        }
        modify("Apply Entries")
        {
            Visible = false;

        }
        modify("Create Reminder")
        {
            Visible = false;

        }
        modify("Show Document")
        {
            Visible = false;
        }
    }
    trigger OnAfterGetRecord()
    begin
        CurrPage.Editable := false;
    end;
}


