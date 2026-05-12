#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50213 "HR Drivers Card"
{
    PageType = Card;
    SourceTable = 51192;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Driver Name"; Rec."Driver Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Promoted;
                }
                field("Driver License Number"; Rec."Driver License Number")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Last License Renewal"; Rec."Last License Renewal")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Renewal Interval"; Rec."Renewal Interval")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Renewal Interval Value"; Rec."Renewal Interval Value")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Next License Renewal"; Rec."Next License Renewal")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Year Of Experience"; Rec."Year Of Experience")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field(Grade; Rec.Grade)
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field(Active; Rec.Active)
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1102755013; Outlook)
            {
            }
            systempart(Control1102755014; Notes)
            {
            }
        }
    }

    actions
    {
    }
}

