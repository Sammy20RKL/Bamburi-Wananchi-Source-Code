#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50181 "HR Job Responsibilities"
{
    Caption = 'HR Job Responsibilities';
    DeleteAllowed = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = Document;
    PromotedActionCategories = 'New,Process,Reports,Qualification';
    SourceTable = "HR Jobss";

    layout
    {
        area(content)
        {
            group(General)
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
                field("Position Reporting to"; Rec."Position Reporting to")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("Supervisor Name"; Rec."Supervisor Name")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("No of Posts"; Rec."No of Posts")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;
                }
                field("Occupied Positions"; Rec."Occupied Positions")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Vacant Positions"; Rec."Vacant Positions")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;
                }
                field("Employee Requisitions"; Rec."Employee Requisitions")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1102755013; Outlook)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Import Evaluation Areas")
            {
                ApplicationArea = Basic;
                Image = Import;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                begin

                    //DELETE RESPONSIBILITIES PREVIOUSLY IMPORTED
                    HRJobResponsibilities.Reset;
                    HRJobResponsibilities.SetRange(HRJobResponsibilities."Job ID", Rec."Job ID");
                    if HRJobResponsibilities.Find('-') then
                        HRJobResponsibilities.DeleteAll;

                    //IMPORT EVALUATION AREAS FOR THIS JOB
                    HRAppraisalEvaluationAreas.Reset;
                    HRAppraisalEvaluationAreas.SetRange(HRAppraisalEvaluationAreas."External Source Name", Rec."Job ID");
                    if HRAppraisalEvaluationAreas.Find('-') then
                        HRAppraisalEvaluationAreas.FindFirst;
                    begin
                        HRJobResponsibilities.Reset;
                        repeat
                            HRJobResponsibilities.Init;
                            HRJobResponsibilities."Job ID" := Rec."Job ID";
                            HRJobResponsibilities."Responsibility Code" := HRAppraisalEvaluationAreas."Assign To";
                            HRJobResponsibilities."Responsibility Description" := HRAppraisalEvaluationAreas.Code;
                            HRJobResponsibilities.Insert();
                        until HRAppraisalEvaluationAreas.Next = 0;
                    end;
                end;
            }
        }
    }

    var
        HRJobResponsibilities: Record "HR Job Responsiblities";
        HRAppraisalEvaluationAreas: Record "HR Appraisal Eval Areas";
}

