#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50273 "HR Employee Course of Study"
{
    PageType = List;
    SourceTable = "HR Employee Course of Study";

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
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Years of Study"; Rec."Years of Study")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1102755006; Outlook)
            {
            }
            systempart(Control1102755007; Notes)
            {
            }
        }
    }

    actions
    {
        area(creation)
        {
            group(ActionGroup1102755009)
            {
            }
        }
    }
}

