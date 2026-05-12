#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50650 "Data Sheet List-DIST"
{
    // CardPageID = "Data Sheet Header-Dist";
    Editable = true;
    PageType = List;
    SourceTable = "Data Sheet Header-Dist";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field("Period Month"; Rec."Period Month")
                {
                    ApplicationArea = Basic;
                }
                field("Period Code"; Rec."Period Code")
                {
                    ApplicationArea = Basic;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic;
                }
                field("Total Schedule Amount"; Rec."Total Schedule Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Total Schedule Amount P"; Rec."Total Schedule Amount P")
                {
                    ApplicationArea = Basic;
                }
                field("Total Schedule Amount I"; Rec."Total Schedule Amount I")
                {
                    ApplicationArea = Basic;
                }
                field("Total Schedule Amount D"; Rec."Total Schedule Amount D")
                {
                    ApplicationArea = Basic;
                }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = Basic;
                }
                field("Employer Code"; Rec."Employer Code")
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

