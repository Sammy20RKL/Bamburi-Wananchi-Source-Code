#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50160 "HR Leave journal Template"
{
    PageType = List;
    SourceTable = 51187;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Test Report ID"; Rec."Test Report ID")
                {
                    ApplicationArea = Basic;
                }
                field("Form ID"; Rec."Form ID")
                {
                    ApplicationArea = Basic;
                }
                field("Posting Report ID"; Rec."Posting Report ID")
                {
                    ApplicationArea = Basic;
                }
                field("Force Posting Report"; Rec."Force Posting Report")
                {
                    ApplicationArea = Basic;
                }
                field("Source Code"; Rec."Source Code")
                {
                    ApplicationArea = Basic;
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    ApplicationArea = Basic;
                }
                field("Test Report Name"; Rec."Test Report Name")
                {
                    ApplicationArea = Basic;
                }
                field("Form Name"; Rec."Form Name")
                {
                    ApplicationArea = Basic;
                }
                field("Posting Report Name"; Rec."Posting Report Name")
                {
                    ApplicationArea = Basic;
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = Basic;
                }
                field("Posting No. Series"; Rec."Posting No. Series")
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

