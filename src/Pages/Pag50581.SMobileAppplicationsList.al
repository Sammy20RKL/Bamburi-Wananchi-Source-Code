#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50581 "S-Mobile Appplications List"
{
    CardPageID = "S-Mobile Applications Card";
    Editable = false;
    PageType = List;
    SourceTable = "SwizzKash Applications";
    SourceTableView = where(Status = filter(Application | Rejected));

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
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                }
                field(Telephone; Rec.Telephone)
                {
                    ApplicationArea = Basic;
                }
                field("ID No"; Rec."ID No")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("Date Applied"; Rec."Date Applied")
                {
                    ApplicationArea = Basic;
                }
                field("Time Applied"; Rec."Time Applied")
                {
                    ApplicationArea = Basic;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic;
                }
                field(Sent; Rec.Sent)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        StatusPermissions.Reset;
        StatusPermissions.SetRange(StatusPermissions."User ID", UserId);
        StatusPermissions.SetRange(StatusPermissions."Function", StatusPermissions."function"::SmobileApp);
        if StatusPermissions.Find('-') = false then
            Error('You do not have permissions for S-Mobile Application.');
    end;

    var
        StatusPermissions: Record "Status Change Permision";
}

