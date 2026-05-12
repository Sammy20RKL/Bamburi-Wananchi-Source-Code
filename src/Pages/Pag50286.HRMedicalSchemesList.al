#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50286 "HR Medical Schemes List"
{
    CardPageID = "HR Medical Schemes Card";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "HR Medical Schemes";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Scheme No"; Rec."Scheme No")
                {
                    ApplicationArea = Basic;
                }
                field("Medical Insurer"; Rec."Medical Insurer")
                {
                    ApplicationArea = Basic;
                }
                field("Scheme Name"; Rec."Scheme Name")
                {
                    ApplicationArea = Basic;
                }
                field("In-patient limit"; Rec."In-patient limit")
                {
                    ApplicationArea = Basic;
                }
                field("Out-patient limit"; Rec."Out-patient limit")
                {
                    ApplicationArea = Basic;
                }
                field("Area Covered"; Rec."Area Covered")
                {
                    ApplicationArea = Basic;
                }
                field("Dependants Included"; Rec."Dependants Included")
                {
                    ApplicationArea = Basic;
                }
                field(Comments; Rec.Comments)
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

