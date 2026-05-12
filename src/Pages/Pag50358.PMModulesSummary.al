#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50358 "PM Modules Summary"
{
    PageType = List;
    SourceTable = "PM Modules";

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
                field("Module Name"; Rec."Module Name")
                {
                    ApplicationArea = Basic;
                }
                field(New; Rec.New)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(WIP; Rec.WIP)
                {
                    ApplicationArea = Basic;
                    Style = Standard;
                    StyleExpr = true;
                }
                field(Resolved; Rec.Resolved)
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field(Rejected; Rec.Rejected)
                {
                    ApplicationArea = Basic;
                    Style = Attention;
                    StyleExpr = true;
                }
                field("Total Items"; Rec."Total Items")
                {
                    ApplicationArea = Basic;
                    Style = Strong;
                    StyleExpr = true;
                }
            }
        }
    }

    actions
    {
    }
}

