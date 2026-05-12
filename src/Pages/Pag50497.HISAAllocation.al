#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50497 "HISA Allocation"
{
    PageType = List;
    SourceTable = "HISA Allocation";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field("Loan No."; Rec."Loan No.")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Interest Amount"; Rec."Interest Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Amount Balance"; Rec."Amount Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Interest Balance"; Rec."Interest Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Share Mode of Payment"; Rec."Share Mode of Payment")
                {
                    ApplicationArea = Basic;
                }
                field("Total Allocation"; Rec."Total Allocation")
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

