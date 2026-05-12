#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50219 "HR Lookup Values Card"
{
    PageType = Card;
    SourceTable = "HR Lookup Values";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                }
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Supervisor Only"; Rec."Supervisor Only")
                {
                    ApplicationArea = Basic;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic;
                }
                field("Notice Period"; Rec."Notice Period")
                {
                    ApplicationArea = Basic;
                }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = Basic;
                }
                field("Contract Length"; Rec."Contract Length")
                {
                    ApplicationArea = Basic;
                }
                label(Control1102755023)
                {
                    ApplicationArea = Basic;
                    CaptionClass = Text19024457;
                }
                field(Score; Rec.Score)
                {
                    ApplicationArea = Basic;
                }
                field("Current Appraisal Period"; Rec."Current Appraisal Period")
                {
                    ApplicationArea = Basic;
                }
                field("Disciplinary Case Rating"; Rec."Disciplinary Case Rating")
                {
                    ApplicationArea = Basic;
                }
                field("Disciplinary Action"; Rec."Disciplinary Action")
                {
                    ApplicationArea = Basic;
                }
                field(From; Rec.From)
                {
                    ApplicationArea = Basic;
                }
                field("To"; Rec."To")
                {
                    ApplicationArea = Basic;
                }
                field("Basic Salary"; Rec."Basic Salary")
                {
                    ApplicationArea = Basic;
                }
                field("To be cleared by"; Rec."To be cleared by")
                {
                    ApplicationArea = Basic;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }

    var
        Text19024457: label 'Months';
}

