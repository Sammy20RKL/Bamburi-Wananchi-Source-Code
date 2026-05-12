#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50187 "HR Leave Types Card"
{
    PageType = Card;
    SourceTable = "HR Leave Types";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(Days; Rec.Days)
                {
                    ApplicationArea = Basic;
                }
                field("Acrue Days"; Rec."Acrue Days")
                {
                    ApplicationArea = Basic;
                }
                field("Unlimited Days"; Rec."Unlimited Days")
                {
                    ApplicationArea = Basic;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = Basic;
                }
                field(Balance; Rec.Balance)
                {
                    ApplicationArea = Basic;
                }
                field("Max Carry Forward Days"; Rec."Max Carry Forward Days")
                {
                    ApplicationArea = Basic;
                }
                field("Carry Forward Allowed"; Rec."Carry Forward Allowed")
                {
                    ApplicationArea = Basic;
                }
                field("Inclusive of Non Working Days"; Rec."Inclusive of Non Working Days")
                {
                    ApplicationArea = Basic;
                }
                field("Inclusive of Saturday"; Rec."Inclusive of Saturday")
                {
                    ApplicationArea = Basic;
                }
                field("Inclusive of Sunday"; Rec."Inclusive of Sunday")
                {
                    ApplicationArea = Basic;
                }
                field("Inclusive of Holidays"; Rec."Inclusive of Holidays")
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

