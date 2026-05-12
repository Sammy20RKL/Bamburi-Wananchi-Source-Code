#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50480 "Relationship list"
{
    PageType = List;
    SourceTable = "Relationship Types";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("code"; Rec.code)
                {
                    ApplicationArea = Basic;
                }
                field(Describution; Rec.Describution)
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

