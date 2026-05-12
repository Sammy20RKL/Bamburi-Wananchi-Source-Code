#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50982 "House Change Request"
{
    CardPageID = "House Change Request Change";
    Editable = false;
    PageType = List;
    SourceTable = "House Group Change Request";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No"; Rec."Document No")
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
                field("House Group"; Rec."House Group")
                {
                    ApplicationArea = Basic;
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = Basic;
                }
                field("Destination Cell"; Rec."Destination Cell")
                {
                    ApplicationArea = Basic;
                }
                field("House Group Name"; Rec."House Group Name")
                {
                    ApplicationArea = Basic;
                }
                field("Reason For Changing Groups"; Rec."Reason For Changing Groups")
                {
                    ApplicationArea = Basic;
                }
                field("Date Group Changed"; Rec."Date Group Changed")
                {
                    ApplicationArea = Basic;
                }
                field("Changed By"; Rec."Changed By")
                {
                    ApplicationArea = Basic;
                }
                field("Deposits on Date of Change"; Rec."Deposits on Date of Change")
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

