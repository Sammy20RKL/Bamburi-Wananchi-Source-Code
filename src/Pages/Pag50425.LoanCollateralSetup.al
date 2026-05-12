#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50425 "Loan Collateral Setup"
{
    PageType = List;
    SourceTable = "Loan Collateral Set-up";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                }
                field("Security Description"; Rec."Security Description")
                {
                    ApplicationArea = Basic;
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = Basic;
                }
                field("Collateral Multiplier"; Rec."Collateral Multiplier")
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

