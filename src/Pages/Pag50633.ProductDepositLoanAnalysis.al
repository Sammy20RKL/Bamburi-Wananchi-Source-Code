#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50633 "Product Deposit>Loan Analysis"
{
    PageType = List;
    SourceTable = "Product Deposit>Loan Analysis";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Product Code"; Rec."Product Code")
                {
                    ApplicationArea = Basic;
                }
                field("Deposit Multiplier"; Rec."Deposit Multiplier")
                {
                    ApplicationArea = Basic;
                }
                field("Minimum Deposit"; Rec."Minimum Deposit")
                {
                    ApplicationArea = Basic;
                }
                field("Minimum Share Capital"; Rec."Minimum Share Capital")
                {
                    ApplicationArea = Basic;
                }
                field("Minimum No of Membership Month"; Rec."Minimum No of Membership Month")
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

