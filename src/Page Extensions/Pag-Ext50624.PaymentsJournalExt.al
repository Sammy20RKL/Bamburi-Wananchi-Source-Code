pageextension 50624 "PaymentsJournalExt" extends "Payment Journal"
{
    layout
    {
        addafter("Recipient Bank Account")
        {
            field("Check Is Printed"; Rec."Check Printed")
            {
                ApplicationArea = Basic;
            }

        }
        modify(JournalErrorsFactBox)
        {
            Visible = false;
        }
        modify(JournalLineDetails)
        {
            Visible = false;
        }
        modify(IncomingDocAttachFactBox)
        {
            Visible = false;
        }
        modify("Payment File Errors")
        {
            Visible = false;
        }
        modify(Control1900919607)
        {
            Visible = false;
        }
        modify(WorkflowStatusBatch)
        {
            Visible = false;
        }
        modify(WorkflowStatusLine)
        {
            Visible = false;
        }
    }
}
