#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50017 "Posted PettyCash Payment Line"
{
    PageType = List;
    SourceTable = "Payment Line New";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Payment Type"; Rec."Payment Type")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Type Description"; Rec."Transaction Name")
                {
                    ApplicationArea = Basic;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = Basic;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Payment Description"; Rec."Payment Description")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Amount(LCY)"; Rec."Amount(LCY)")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Net Amount"; Rec."Net Amount")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Net Amount(LCY)"; Rec."Net Amount(LCY)")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }
}

