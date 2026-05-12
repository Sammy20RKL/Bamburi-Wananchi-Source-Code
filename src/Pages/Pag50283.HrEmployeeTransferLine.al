#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50283 "Hr Employee Transfer Line"
{
    PageType = ListPart;
    SourceTable = "HR Employee Transfer Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Request No"; Rec."Request No")
                {
                    ApplicationArea = Basic;
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = Basic;
                }
                field("Current Department"; Rec."Current Department")
                {
                    ApplicationArea = Basic;
                }
                field("Current Branch"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Current Branch';
                }
                field("New Department"; Rec."New Department")
                {
                    ApplicationArea = Basic;
                }
                field("New Branch"; Rec."New Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'New Branch';
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

