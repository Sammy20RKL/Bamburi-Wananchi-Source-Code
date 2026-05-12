#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50943 "Safe Custody Custodians"
{
    PageType = List;
    SourceTable = "Safe Custody Custodians";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic;
                }
                field("Permision Type"; Rec."Permision Type")
                {
                    ApplicationArea = Basic;
                }
                field("Custodian Of"; Rec."Custodian Of")
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

