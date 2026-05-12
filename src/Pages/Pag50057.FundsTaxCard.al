#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50057 "Funds Tax Card"
{
    PageType = Card;
    SourceTable = "Funds Tax Codes";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Tax Code"; Rec."Tax Code")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic;
                }
                field(Percentage; Rec.Percentage)
                {
                    ApplicationArea = Basic;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                }
                field("Liability Account"; Rec."Liability Account")
                {
                    ApplicationArea = Basic;
                }
                field("Meeting Tax"; Rec."Meeting Tax")
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

