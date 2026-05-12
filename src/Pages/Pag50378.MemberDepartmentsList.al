#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50378 "Member Departments List"
{
    PageType = Card;
    SourceTable = "Member Departments";

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field(Department; Rec.Department)
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

