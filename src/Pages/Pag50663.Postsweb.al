#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50663 "Posts_web"
{
    PageType = List;
    SourceTable = Posts_Web;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Entry; Rec.Entry)
                {
                    ApplicationArea = Basic;
                }
                field(Title; Rec.Title)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(DateEntered; Rec.DateEntered)
                {
                    ApplicationArea = Basic;
                }
                field(DateModified; Rec.DateModified)
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

