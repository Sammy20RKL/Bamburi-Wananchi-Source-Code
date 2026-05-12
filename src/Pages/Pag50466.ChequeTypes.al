#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50466 "Cheque Types"
{
    PageType = Card;
    SourceTable = "Cheque Types";

    layout
    {
        area(content)
        {
            repeater(Control14)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                }
                field("Clearing Days"; Rec."Clearing Days")
                {
                    ApplicationArea = Basic;
                }
                field("Clearing  Days"; Rec."Clearing  Days")
                {
                    ApplicationArea = Basic;
                }
                field("Use %"; Rec."Use %")
                {
                    ApplicationArea = Basic;
                }
                field("% Of Amount"; Rec."% Of Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Clearing Charges"; Rec."Clearing Charges")
                {
                    ApplicationArea = Basic;
                }
                field("Bounced Charges"; Rec."Bounced Charges")
                {
                    ApplicationArea = Basic;
                }
                field("Clearing Bank Account"; Rec."Clearing Bank Account")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = Basic;
                }
                field("Bounced Charges GL Account"; Rec."Bounced Charges GL Account")
                {
                    ApplicationArea = Basic;
                }
                field("Clearing Charges GL Account"; Rec."Clearing Charges GL Account")
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

