#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 56050 "General Cue"
{
    PageType = CardPart;
    SourceTable = "Members Cues";

    layout
    {
        area(content)
        {
            cuegroup(ApprovalRequestCue)
            {
                Caption = 'Approval Requests';
                field("Requests Sent for Approval"; Rec."Requests Sent for Approval")
                {
                    ApplicationArea = Basic;
                    DrillDownPageID = "Approval Entries";
                }
                field("Requests to Approve"; Rec."Requests to Approve")
                {
                    ApplicationArea = Basic;
                    DrillDownPageID = "Requests to Approve";
                }
            }
            cuegroup(ApprovalRequestCue2)
            {
                Caption = 'Approval Requests2';
                Visible = false;
                field("Requests Sent for Approval2"; Rec."Requests Sent for Approval")
                {
                    ApplicationArea = Basic;
                    DrillDownPageID = "Approval Entries";
                }
                field("Requests to Approve2"; Rec."Requests to Approve")
                {
                    ApplicationArea = Basic;
                    DrillDownPageID = "Requests to Approve";
                }
            }

        }
    }

    actions
    {
    }
    trigger OnOpenPage()
    begin
        if not Rec.Get(UserId) then begin
            Rec.Init;
            Rec."User ID" := UserId;
            Rec.Insert;
        end;
    end;
}

