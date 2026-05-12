#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50035 "Posted Funds Transfer Lines"
{
    PageType = List;
    SourceTable = "Funds Transfer Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Receiving Bank Account"; Rec."Receiving Bank Account")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Balance"; Rec."Bank Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Balance(LCY)"; Rec."Bank Balance(LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Account No."; Rec."Bank Account No.")
                {
                    ApplicationArea = Basic;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = Basic;
                }
                field("Currency Factor"; Rec."Currency Factor")
                {
                    ApplicationArea = Basic;
                }
                field("Amount to Receive"; Rec."Amount to Receive")
                {
                    ApplicationArea = Basic;
                }
                field("Amount to Receive (LCY)"; Rec."Amount to Receive (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("External Doc No."; Rec."External Doc No.")
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

