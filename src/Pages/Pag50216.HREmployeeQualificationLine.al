#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50216 "HR Employee Qualification Line"
{
    Caption = 'Employee Qualification Lines';
    PageType = List;
    SourceTable = "HR Employee Qualifications";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field("Qualification Type"; Rec."Qualification Type")
                {
                    ApplicationArea = Basic;
                }
                field("Qualification Code"; Rec."Qualification Code")
                {
                    ApplicationArea = Basic;
                }
                field("Qualification Description"; Rec."Qualification Description")
                {
                    ApplicationArea = Basic;
                }
                field("Course of Study"; Rec."Course of Study")
                {
                    ApplicationArea = Basic;
                }
                field("From Date"; Rec."From Date")
                {
                    ApplicationArea = Basic;
                }
                field("To Date"; Rec."To Date")
                {
                    ApplicationArea = Basic;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                }
                field("Institution/Company"; Rec."Institution/Company")
                {
                    ApplicationArea = Basic;
                }
                field("Course Grade"; Rec."Course Grade")
                {
                    ApplicationArea = Basic;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Q&ualification")
            {
                Caption = 'Q&ualification';
                action("Co&mments")
                {
                    ApplicationArea = Basic;
                    Caption = 'Co&mments';
                    RunObject = Page "Human Resource Comment Sheet";
                    RunPageLink = "Table Name" = const("Employee Qualification"),
                                  "No." = field("Employee No."),
                                  "Table Line No." = field("Line No.");
                }
                separator(Action1102755021)
                {
                }
                action("Q&ualification Overview")
                {
                    ApplicationArea = Basic;
                    Caption = 'Q&ualification Overview';
                    RunObject = Page "Qualification Overview";
                }
            }
        }
    }
}

