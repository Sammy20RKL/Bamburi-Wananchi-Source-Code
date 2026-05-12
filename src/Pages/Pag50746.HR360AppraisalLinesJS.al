#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50746 "HR 360 Appraisal Lines - JS"
{
    Caption = 'HR Appraisal Lines - Job Specific';
    PageType = ListPart;
    SourceTable = "HR Appraisal Lines";
    SourceTableView = where("Categorize As" = const("Job Specific"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Sub Category"; Rec."Sub Category")
                {
                    ApplicationArea = Basic;
                }
                field("Perfomance Goals and Targets"; Rec."Perfomance Goals and Targets")
                {
                    ApplicationArea = Basic;
                }
                field("Min. Target Score"; Rec."Min. Target Score")
                {
                    ApplicationArea = Basic;
                }
                field("Max Target Score"; Rec."Max Target Score")
                {
                    ApplicationArea = Basic;
                }
                field("Self Rating"; Rec."Self Rating")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Comments"; Rec."Employee Comments")
                {
                    ApplicationArea = Basic;
                }
                field("Supervisor Rating"; Rec."Supervisor Rating")
                {
                    ApplicationArea = Basic;
                }
                field("Supervisor Comments"; Rec."Supervisor Comments")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Categorize As" := Rec."categorize as"::"Job Specific";
    end;
}

