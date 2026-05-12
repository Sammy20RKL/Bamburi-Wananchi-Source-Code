#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50247 "HR Calendar List"
{
    PageType = List;
    SourceTable = "HR Calendar List";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                Editable = true;
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic;
                }
                field(Day; Rec.Day)
                {
                    ApplicationArea = Basic;
                }
                field("Non Working"; Rec."Non Working")
                {
                    ApplicationArea = Basic;
                }
                field(Reason; Rec.Reason)
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

