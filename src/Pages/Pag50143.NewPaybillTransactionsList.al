#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50143 "New Paybill Transactions List"
{
    // CardPageID = "New Paybill Card";
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
                field("Date Requested"; Rec."Date Requested")
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
                field("User ID"; Rec."User ID")
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

