#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50992 "Case Details"
{
    PageType = ListPart;
    SourceTable = "Case Details";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Case No"; Rec."Case No")
                {
                    ApplicationArea = Basic;
                }
                field("Case Type"; Rec."Case Type")
                {
                    ApplicationArea = Basic;
                }
                field("Case Details"; Rec."Case Details")
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

