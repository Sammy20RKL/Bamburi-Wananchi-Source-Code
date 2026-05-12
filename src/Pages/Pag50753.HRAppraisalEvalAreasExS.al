#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50753 "HR Appraisal Eval Areas - ExS"
{
    Caption = 'HR Appraisal Evaluation Areas - External Sources';
    PageType = List;
    SourceTable = "HR Appraisal Eval Areas";
    SourceTableView = where("Categorize As" = const("External Sources"));

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                Editable = true;
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        Rec.TestField(Code);
                    end;
                }
                field("Categorize As"; Rec."Categorize As")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Sub Category"; Rec."Sub Category")
                {
                    ApplicationArea = Basic;
                }
                field("Include in Evaluation Form"; Rec."Include in Evaluation Form")
                {
                    ApplicationArea = Basic;
                }
                field("Appraisal Period"; Rec."Appraisal Period")
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
        Rec."Categorize As" := Rec."categorize as"::"External Sources";
        Rec."Include in Evaluation Form" := true;
    end;
}

