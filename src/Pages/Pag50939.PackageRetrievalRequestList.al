#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50939 "Package Retrieval Request List"
{
    // CardPageID = "Package Retrieval Request Card";
    Editable = false;
    PageType = List;
    SourceTable = "Package Retrieval Register";

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
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Member Name"; Rec."Member Name")
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
                field("Requesting Agent Name"; Rec."Requesting Agent Name")
                {
                    ApplicationArea = Basic;
                }
                field("Requesting Agent ID/Passport"; Rec."Requesting Agent ID/Passport")
                {
                    ApplicationArea = Basic;
                }
                field("Retrieval Request Date"; Rec."Retrieval Request Date")
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
                field("Retrieved By(Custodian 1)"; Rec."Retrieved By(Custodian 1)")
                {
                    ApplicationArea = Basic;
                }
                field("Retrieved By(Custodian 2)"; Rec."Retrieved By(Custodian 2)")
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

