#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50507 "BOSA Transfer Sched"
{
    PageType = ListPart;
    SourceTable = "BOSA TransferS Schedule";

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field("Source Type"; Rec."Source Type")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account Type';
                }
                field("Source Account No."; Rec."Source Account No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account to Debit(BOSA)';
                }
                field("Source Account Name"; Rec."Source Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field(Loan; Rec.Loan)
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Destination Account Type"; Rec."Destination Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Destination Account No."; Rec."Destination Account No.")
                {
                    ApplicationArea = Basic;
                }
                field("Destination Account Name"; Rec."Destination Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Destination Loan"; Rec."Destination Loan")
                {
                    ApplicationArea = Basic;
                }
                field("Destination Type"; Rec."Destination Type")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

