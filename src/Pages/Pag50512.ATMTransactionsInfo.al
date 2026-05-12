#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50512 "ATM Transactions Info"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "ATM Transactions";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Trace ID"; Rec."Trace ID")
                {
                    ApplicationArea = Basic;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Posting S"; Rec."Posting S")
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                }
                field("Unit ID"; Rec."Unit ID")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field("Trans Time"; Rec."Trans Time")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Time"; Rec."Transaction Time")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = Basic;
                }
                field(Source; Rec.Source)
                {
                    ApplicationArea = Basic;
                }
                field(Reversed; Rec.Reversed)
                {
                    ApplicationArea = Basic;
                }
                field("Reversed Posted"; Rec."Reversed Posted")
                {
                    ApplicationArea = Basic;
                }
                field("Reversal Trace ID"; Rec."Reversal Trace ID")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Description"; Rec."Transaction Description")
                {
                    ApplicationArea = Basic;
                }
                field("Withdrawal Location"; Rec."Withdrawal Location")
                {
                    ApplicationArea = Basic;
                }
                field("Entry No"; Rec."Entry No")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Type Charges"; Rec."Transaction Type Charges")
                {
                    ApplicationArea = Basic;
                }
                field("Card Acceptor Terminal ID"; Rec."Card Acceptor Terminal ID")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Card No"; Rec."ATM Card No")
                {
                    ApplicationArea = Basic;
                }
                field("Customer Names"; Rec."Customer Names")
                {
                    ApplicationArea = Basic;
                }
                field("Process Code"; Rec."Process Code")
                {
                    ApplicationArea = Basic;
                }
                field("Reference No"; Rec."Reference No")
                {
                    ApplicationArea = Basic;
                }
                field("Is Coop Bank"; Rec."Is Coop Bank")
                {
                    ApplicationArea = Basic;
                }
                field("POS Vendor"; Rec."POS Vendor")
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

