#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50180 "HR Job Requirements"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PromotedActionCategories = 'New,Process,Report,Functions';
    SourceTable = "HR Jobss";

    layout
    {
        area(content)
        {
            group("Job Specification")
            {
                Caption = 'Job Details';
                field("Job ID"; Rec."Job ID")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;
                    Importance = Promoted;
                }
                field("Job Description"; Rec."Job Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;
                    Importance = Promoted;
                }
            }
            group("JobSRequirements")
            {
            }
        }
        area(factboxes)
        {
            systempart(Control1102755008; Outlook)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Job Requirements")
            {
                ApplicationArea = Basic;
                Image = PrintReport;
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                begin
                    HRJobReq.Reset;
                    HRJobReq.SetRange(HRJobReq."Job ID", Rec."Job ID");
                    if HRJobReq.Find('-') then begin
                        Report.Run(55591, true, true, HRJobReq);
                    end;
                end;
            }
        }
    }

    var
        HRJobReq: Record "HR Jobss";
}

