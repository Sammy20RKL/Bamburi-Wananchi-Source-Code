#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50946 "Package Retrieval SubPage"
{
    Editable = false;
    PageType = ListPart;
    SourceTable = 51907;

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
                field("Package ID"; Rec."Package ID")
                {
                    ApplicationArea = Basic;
                }
                field("Package Description"; Rec."Package Description")
                {
                    ApplicationArea = Basic;
                }
                field("Retrieval Requested By"; Rec."Retrieval Requested By")
                {
                    ApplicationArea = Basic;
                }
                field("Retrieval Request Date"; Rec."Retrieval Request Date")
                {
                    ApplicationArea = Basic;
                }
                field("Retrieved By(Custodian 1)"; Rec."Retrieved By(Custodian 1)")
                {
                    ApplicationArea = Basic;
                }
                field("Retrieved By(Custodian 2)"; Rec."Retrieved By(Custodian 2)")
                {
                    ApplicationArea = Basic;
                }
                field("Retrieval Date"; Rec."Retrieval Date")
                {
                    ApplicationArea = Basic;
                }
                field("Reason for Retrieval"; Rec."Reason for Retrieval")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
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

