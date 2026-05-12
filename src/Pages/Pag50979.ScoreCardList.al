#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50979 "Score Card List"
{
    CardPageID = "Score Card";
    PageType = List;
    SourceTable = "Score Card Header";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic;
                    TableRelation = "Score Card Header"."Member No";
                }
                field("Registration Date"; Rec."Registration Date")
                {
                    ApplicationArea = Basic;
                }
                field("Date Approved"; Rec."Date Approved")
                {
                    ApplicationArea = Basic;
                }
                field("Captured By"; Rec."Captured By")
                {
                    ApplicationArea = Basic;
                }
                field("Last Modified By"; Rec."Last Modified By")
                {
                    ApplicationArea = Basic;
                }
                field("Last Modified Date"; Rec."Last Modified Date")
                {
                    ApplicationArea = Basic;
                }
                field("Total Score"; Rec."Total Score")
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

