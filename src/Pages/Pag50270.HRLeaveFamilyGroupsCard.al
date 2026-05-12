#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50270 "HR Leave Family Groups Card"
{
    PageType = Card;
    SourceTable = "HR Leave Family Groups";

    layout
    {
        area(content)
        {
            group(Group)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic;
                }
                field("Max Employees On Leave"; Rec."Max Employees On Leave")
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

