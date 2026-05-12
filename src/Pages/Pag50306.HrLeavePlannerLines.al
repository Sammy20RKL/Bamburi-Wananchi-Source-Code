#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50306 "Hr Leave Planner Lines"
{
    PageType = ListPart;
    SourceTable = "HR Leave Planner Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Leave Type"; Rec."Leave Type")
                {
                    ApplicationArea = Basic;
                }
                field("Days Applied"; Rec."Days Applied")
                {
                    ApplicationArea = Basic;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = Basic;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = Basic;
                }
                field("Return Date"; Rec."Return Date")
                {
                    ApplicationArea = Basic;
                }
                field("Applicant Comments"; Rec."Applicant Comments")
                {
                    ApplicationArea = Basic;
                }
                field("Request Leave Allowance"; Rec."Request Leave Allowance")
                {
                    ApplicationArea = Basic;
                }
                field(Reliever; Rec.Reliever)
                {
                    ApplicationArea = Basic;
                }
                field("Reliever Name"; Rec."Reliever Name")
                {
                    ApplicationArea = Basic;
                }
                field("Approved days"; Rec."Approved days")
                {
                    ApplicationArea = Basic;
                }
                field("Date of Exam"; Rec."Date of Exam")
                {
                    ApplicationArea = Basic;
                }
                field("Details of Examination"; Rec."Details of Examination")
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

