#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50235 "HR Commitee Members"
{
    PageType = List;
    SourceTable = "HR Commitee Members";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic;
                }
                field(Role; Rec.Role)
                {
                    ApplicationArea = Basic;
                }
                field("Date Appointed"; Rec."Date Appointed")
                {
                    ApplicationArea = Basic;
                }
                field(Active; Rec.Active)
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

