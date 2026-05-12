#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50742 "HR 360 Appraisals List - TS"
{
    CardPageID = "HR 360 Appraisal Card";
    PageType = List;
    PromotedActionCategories = 'New,Process,Reports,Functions,Appraisal';
    SourceTable = "HR Appraisal Header";
    SourceTableView = where("Appraisal Stage" = const("Target Setting"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Appraisal No"; Rec."Appraisal No")
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
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = Basic;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = Basic;
                }
                field("Appraisal Type"; Rec."Appraisal Type")
                {
                    ApplicationArea = Basic;
                }
                field("Appraisal Period"; Rec."Appraisal Period")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("Appraisal Stage"; Rec."Appraisal Stage")
                {
                    ApplicationArea = Basic;
                }
                field(Sent; Rec.Sent)
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control26; Outlook)
            {
            }
            systempart(Control27; Notes)
            {
            }
            systempart(Control28; MyNotes)
            {
            }
            systempart(Control29; Links)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Appraisal)
            {
                Caption = 'Appraisal';
                action(SendSupervisor)
                {
                    ApplicationArea = Basic;
                    Caption = 'Send to Supervisor';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    begin
                        Rec.TestField("Appraisal Stage", Rec."appraisal stage"::"Target Setting");
                        Rec.TestField("Employee No");

                        if Confirm('Send to supervisor?', false) = false then exit;

                        Rec."Appraisal Stage" := Rec."appraisal stage"::"Target Approval";
                        Rec.Modify;
                        Message('Appraisal sent to supervisor');
                    end;
                }
            }
        }
    }
}

