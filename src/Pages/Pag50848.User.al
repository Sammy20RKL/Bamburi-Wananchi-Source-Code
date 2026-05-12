#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50848 User
{
    Editable = false;
    PageType = List;
    SourceTable = User;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("User Security ID"; Rec."User Security ID")
                {
                    ApplicationArea = Basic;
                }
                field("User Name"; Rec."User Name")
                {
                    ApplicationArea = Basic;
                }
                field("Full Name"; Rec."Full Name")
                {
                    ApplicationArea = Basic;
                }
                field(State; Rec.State)
                {
                    ApplicationArea = Basic;
                }
                // field("Branch Code"; Rec."Branch Code")
                // {
                //     ApplicationArea = Basic;
                // }
            }
        }
    }

    actions
    {
    }
}

