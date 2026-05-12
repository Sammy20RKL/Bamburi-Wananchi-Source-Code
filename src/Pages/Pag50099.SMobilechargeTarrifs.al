#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50099 "S-Mobile charge Tarrifs"
{
    PageType = ListPart;
    SourceTable = "S-Mobile Tarrifs";

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
                field(Minimum; Rec.Minimum)
                {
                    ApplicationArea = Basic;
                }
                field(Maximum; Rec.Maximum)
                {
                    ApplicationArea = Basic;
                }
                field("Charge Amount"; Rec."Charge Amount")
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

