#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50174 "HR Job Responsiblities Lines"
{
    CardPageID = "hr job responsibilities card";
    PageType = List;
    SourceTable = "HR Job Responsiblities";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Responsibility Code"; Rec."Responsibility Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Responsibility Description"; Rec."Responsibility Description")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

