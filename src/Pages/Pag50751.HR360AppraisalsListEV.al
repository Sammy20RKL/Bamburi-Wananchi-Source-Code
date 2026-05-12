#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50751 "HR 360 Appraisals List - EV"
{
    CardPageID = "HR 360 Appraisal Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Reports,Functions,Appraisal';
    SourceTable = "HR Appraisal Header";
    SourceTableView = where("Appraisal Stage" = const("End Year Evalauation"));

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
                field(Department; Rec."Department")
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
            group(ActionGroup1000000005)
            {
                Caption = 'Functions';
                action(ReturnSupervisor)
                {
                    ApplicationArea = Basic;
                    Caption = 'Return to Supervisor';
                    Image = Return;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    begin
                        Rec.TestField("Appraisal Stage", Rec."appraisal stage"::"End Year Evalauation");

                        if Confirm('Return to supervisor?', false) = false then exit;

                        Rec."Appraisal Stage" := Rec."appraisal stage"::"Target Approval";
                        Rec.Modify;
                        Message('Appraisal returned to supervisor');
                    end;
                }
                action(ReturnAppraisee)
                {
                    ApplicationArea = Basic;
                    Caption = 'Return to Appraisee';
                    Image = ReopenCancelled;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    begin
                        Rec.TestField("Appraisal Stage");

                        if Confirm('Return to appraisee?', false) = false then exit;

                        Rec."Appraisal Stage" := Rec."appraisal stage"::"Target Setting";
                        Rec.Modify;
                        Message('Appraisal returned to appraisee');
                    end;
                }
            }
        }
    }
}

