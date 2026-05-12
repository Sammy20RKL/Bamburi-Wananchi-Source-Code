#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50090 "Imported Bank Statement"
{
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Imported Bank Statement..";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Reference No"; Rec."Reference No")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field(Bank; Rec.Bank)
                {
                    ApplicationArea = Basic;
                }
                field(Receipted; Rec.Receipted)
                {
                    ApplicationArea = Basic;
                }
                field(ReceiptNo; Rec.ReceiptNo)
                {
                    ApplicationArea = Basic;
                }
                field("Receipting Date"; Rec."Receipting Date")
                {
                    ApplicationArea = Basic;
                }
                field(Reconciled; Rec.Reconciled)
                {
                    ApplicationArea = Basic;
                }
                field("Reconciliation Doc No"; Rec."Reconciliation Doc No")
                {
                    ApplicationArea = Basic;
                }
                field("Reconciliation Date"; Rec."Reconciliation Date")
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

