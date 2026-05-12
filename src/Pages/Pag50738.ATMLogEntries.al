#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50738 "ATM Log Entries"
{
    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "ATM Log Entries";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No"; Rec."Entry No")
                {
                    ApplicationArea = Basic;
                }
                field("Date Time"; Rec."Date Time")
                {
                    ApplicationArea = Basic;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field("ATM No"; Rec."ATM No")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Location"; Rec."ATM Location")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Type"; ReC."Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field("Return Code"; Rec."Return Code")
                {
                    ApplicationArea = Basic;
                }
                field("Trace ID"; Rec."Trace ID")
                {
                    ApplicationArea = Basic;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = Basic;
                }
                field("Card No."; Rec."Card No.")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Amount"; Rec."ATM Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Withdrawal Location"; Rec."Withdrawal Location")
                {
                    ApplicationArea = Basic;
                }
                field("Reference No"; Rec."Reference No")
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

