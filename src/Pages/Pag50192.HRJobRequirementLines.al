#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50192 "HR Job Requirement Lines"
{
    PageType = List;
    SourceTable = "HR Job Requirements";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field("Qualification Type"; Rec."Qualification Type")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Qualification Code"; Rec."Qualification Code")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Qualification Description"; Rec."Qualification Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Promoted;
                }
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = Basic;
                }
                field("Desired Score"; Rec."Desired Score")
                {
                    ApplicationArea = Basic;
                }
                field("Total (Stage)Desired Score"; Rec."Total (Stage)Desired Score")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Mandatory; Rec.Mandatory)
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

