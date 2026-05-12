#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50109 "Purchase Quote Parameters"
{
    PageType = List;
    SourceTable = "Inward file Buffer-Family";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Field3; Rec.Field3)
                {
                    ApplicationArea = Basic;
                }
                field(Field4; Rec.Field4)
                {
                    ApplicationArea = Basic;
                }
                field(Field6; Rec.Field6)
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

