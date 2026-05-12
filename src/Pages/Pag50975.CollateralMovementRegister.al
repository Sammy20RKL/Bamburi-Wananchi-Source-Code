#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50975 "Collateral Movement Register"
{
    PageType = List;
    SourceTable = "Collateral Movement Register";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No"; Rec."Entry No")
                {
                    ApplicationArea = Basic;
                }
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = Basic;
                }
                field("Current Location"; Rec."Current Location")
                {
                    ApplicationArea = Basic;
                }
                field("Date Actioned"; Rec."Date Actioned")
                {
                    ApplicationArea = Basic;
                }
                field("Action By"; Rec."Action By")
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

