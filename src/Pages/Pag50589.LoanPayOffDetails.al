#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50589 "Loan PayOff Details"
{
    PageType = ListPart;
    SourceTable = "Loans PayOff Details";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = Basic;
                }
                field(Source; Rec.Source)
                {
                    ApplicationArea = Basic;
                }
                field("Loan to PayOff"; Rec."Loan to PayOff")
                {
                    ApplicationArea = Basic;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Type"; Rec."Loan Type")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Outstanding"; Rec."Loan Outstanding")
                {
                    ApplicationArea = Basic;
                }
                field("Commision on PayOff"; Rec."Commision on PayOff")
                {
                    ApplicationArea = Basic;
                }
                field("Total PayOff"; Rec."Total PayOff")
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

