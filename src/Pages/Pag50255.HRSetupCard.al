#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50255 "HR Setup Card"
{
    PageType = Card;
    SourceTable = "HR Setup";

    layout
    {
        area(content)
        {
            group("Leave Period")
            {
                Caption = 'Leave Period';
                field("Leave Posting Period[FROM]"; Rec."Leave Posting Period[FROM]")
                {
                    ApplicationArea = Basic;
                }
                field("Leave Posting Period[TO]"; Rec."Leave Posting Period[TO]")
                {
                    ApplicationArea = Basic;
                }
                field("Leave Template"; Rec."Leave Template")
                {
                    ApplicationArea = Basic;
                }
                field("Leave Batch"; Rec."Leave Batch")
                {
                    ApplicationArea = Basic;
                }
            }
            group("HR Number Series")
            {
                Caption = 'HR Number Series';
                field("Employee Nos."; Rec."Employee Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("Training Application Nos."; Rec."Training Application Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("Leave Application Nos."; Rec."Leave Application Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("Disciplinary Cases Nos."; Rec."Disciplinary Cases Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("Transport Req Nos"; Rec."Transport Req Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Requisition Nos."; Rec."Employee Requisition Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("Job Application Nos"; Rec."Job Application Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Exit Interview Nos"; Rec."Exit Interview Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Appraisal Nos"; Rec."Appraisal Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Company Activities"; Rec."Company Activities")
                {
                    ApplicationArea = Basic;
                }
                field("Default Leave Posting Template"; Rec."Default Leave Posting Template")
                {
                    ApplicationArea = Basic;
                }
                field(s; Rec."Positive Leave Posting Batch")
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

