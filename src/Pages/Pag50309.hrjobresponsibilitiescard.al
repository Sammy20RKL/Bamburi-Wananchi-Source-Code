#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50309 "hr job responsibilities card"
{
    PageType = Card;
    SourceTable = "HR Job Responsiblities";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Job ID"; Rec."Job ID")
                {
                    ApplicationArea = Basic;
                }
                field("Responsibility Code"; Rec."Responsibility Code")
                {
                    ApplicationArea = Basic;
                }
                field("Responsibility Description"; Rec."Responsibility Description")
                {
                    ApplicationArea = Basic;
                }
                field(Remarks; Rec.Remarks)
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

