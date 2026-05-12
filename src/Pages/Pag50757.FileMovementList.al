#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50757 "File Movement List"
{
    // CardPageID = "File Movement Header";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = List;
    SourceTable = "File Movement Header";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field("File Number"; Rec."File Number")
                {
                    ApplicationArea = Basic;
                }
                field("File Name"; Rec."File Name")
                {
                    ApplicationArea = Basic;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = Basic;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Date Requested"; Rec."Date Requested")
                {
                    ApplicationArea = Basic;
                }
                field("Requested By"; Rec."Requested By")
                {
                    ApplicationArea = Basic;
                }
                field("Date Retrieved"; Rec."Date Retrieved")
                {
                    ApplicationArea = Basic;
                }
                field("Responsiblity Center"; Rec."Responsiblity Center")
                {
                    ApplicationArea = Basic;
                }
                field("Expected Return Date"; Rec."Expected Return Date")
                {
                    ApplicationArea = Basic;
                }
                field("Duration Requested"; Rec."Duration Requested")
                {
                    ApplicationArea = Basic;
                }
                field("Date Returned"; Rec."Date Returned")
                {
                    ApplicationArea = Basic;
                }
                field("File Location"; Rec."File Location")
                {
                    ApplicationArea = Basic;
                }
                field("Current File Location"; Rec."Current File Location")
                {
                    ApplicationArea = Basic;
                }
                field("Retrieved By"; Rec."Retrieved By")
                {
                    ApplicationArea = Basic;
                }
                field("Returned By"; Rec."Returned By")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("Issuing File Location"; Rec."Issuing File Location")
                {
                    ApplicationArea = Basic;
                }
                field("No. Series"; Rec."No. Series")
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

