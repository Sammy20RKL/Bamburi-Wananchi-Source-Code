#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50344 Attachments
{
    PageType = List;
    SourceTable = 51947;

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
                field(Loan; Rec.Loan)
                {
                    ApplicationArea = Basic;
                }
                field(LocaLAttacmentLink; Rec.LocaLAttacmentLink)
                {
                    ApplicationArea = Basic;
                }
                field(PublicLink; Rec.PublicLink)
                {
                    ApplicationArea = Basic;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field(DateUploaded; Rec.DateUploaded)
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

