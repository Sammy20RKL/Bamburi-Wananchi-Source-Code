#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50739 "ATM Transactions Logs"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "ATM Transactions 2";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(ID; Rec.ID)
                {
                    ApplicationArea = Basic;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Processing Code"; Rec."Processing Code")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Amount"; Rec."Transaction Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Cardholder Billing"; Rec."Cardholder Billing")
                {
                    ApplicationArea = Basic;
                }
                field("Transmission Date Time"; Rec."Transmission Date Time")
                {
                    ApplicationArea = Basic;
                }
                field("Conversion Rate"; Rec."Conversion Rate")
                {
                    ApplicationArea = Basic;
                }
                field("System Trace Audit No"; Rec."System Trace Audit No")
                {
                    ApplicationArea = Basic;
                }
                field("Date Time - Local"; Rec."Date Time - Local")
                {
                    ApplicationArea = Basic;
                }
                field("Expiry Date"; Rec."Expiry Date")
                {
                    ApplicationArea = Basic;
                }
                field("POS Entry Mode"; Rec."POS Entry Mode")
                {
                    ApplicationArea = Basic;
                }
                field("Function Code"; Rec."Function Code")
                {
                    ApplicationArea = Basic;
                }
                field("POS Capture Code"; Rec."POS Capture Code")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Fee"; Rec."Transaction Fee")
                {
                    ApplicationArea = Basic;
                }
                field("Settlement Fee"; Rec."Settlement Fee")
                {
                    ApplicationArea = Basic;
                }
                field("Settlement Processing Fee"; Rec."Settlement Processing Fee")
                {
                    ApplicationArea = Basic;
                }
                field("Acquiring Institution ID Code"; Rec."Acquiring Institution ID Code")
                {
                    ApplicationArea = Basic;
                }
                field("Forwarding Institution ID Code"; Rec."Forwarding Institution ID Code")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction 2 Data"; Rec."Transaction 2 Data")
                {
                    ApplicationArea = Basic;
                }
                field("Retrieval Reference No"; Rec."Retrieval Reference No")
                {
                    ApplicationArea = Basic;
                }
                field("Authorisation ID Response"; Rec."Authorisation ID Response")
                {
                    ApplicationArea = Basic;
                }
                field("Response Code"; Rec."Response Code")
                {
                    ApplicationArea = Basic;
                }
                field("Card Acceptor Terminal ID"; Rec."Card Acceptor Terminal ID")
                {
                    ApplicationArea = Basic;
                }
                field("Card Acceptor ID Code"; Rec."Card Acceptor ID Code")
                {
                    ApplicationArea = Basic;
                }
                field("Card Acceptor Name/Location"; Rec."Card Acceptor Name/Location")
                {
                    ApplicationArea = Basic;
                }
                field("Additional Data - Private"; Rec."Additional Data - Private")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Currency Code"; Rec."Transaction Currency Code")
                {
                    ApplicationArea = Basic;
                }
                field("Settlement Currency Code"; Rec."Settlement Currency Code")
                {
                    ApplicationArea = Basic;
                }
                field("Cardholder Billing Cur Code"; Rec."Cardholder Billing Cur Code")
                {
                    ApplicationArea = Basic;
                }
                field("Response Indicator"; Rec."Response Indicator")
                {
                    ApplicationArea = Basic;
                }
                field("Service Indicator"; Rec."Service Indicator")
                {
                    ApplicationArea = Basic;
                }
                field("Replacement Amounts"; Rec."Replacement Amounts")
                {
                    ApplicationArea = Basic;
                }
                field("Receiving Institution ID Code"; Rec."Receiving Institution ID Code")
                {
                    ApplicationArea = Basic;
                }
                field("Account Identification 2"; Rec."Account Identification 2")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field("Bitmap - Hexadecimal"; Rec."Bitmap - Hexadecimal")
                {
                    ApplicationArea = Basic;
                }
                field("Bitmap - Binary"; Rec."Bitmap - Binary")
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

