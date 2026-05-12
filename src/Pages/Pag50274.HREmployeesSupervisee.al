#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50274 "HR Employees Supervisee"
{
    PageType = List;
    SourceTable = "HR Employees Supervisees";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Supervisor No."; Rec."Supervisor No.")
                {
                    ApplicationArea = Basic;
                }
                field("Supervisee No."; Rec."Supervisee No.")
                {
                    ApplicationArea = Basic;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = Basic;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = Basic;
                }
                field("Key Experience"; Rec."Key Experience")
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
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = Basic;
                }
                field("Number of Supervisees"; Rec."Number of Supervisees")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1102755011; Outlook)
            {
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        /*HREmployeeSupervisees.RESET;
        HREmployeeSupervisees.SETRANGE(HREmployeeSupervisees."Supervisor No.","Supervisor No.");
        IF HREmployeeSupervisees.GET THEN
        SETRANGE("Supervisor No.",HREmployeeSupervisees."Supervisor No.")
        ELSE
        //user id may not be the creator of the doc
        SETRANGE("Supervisor No.","Supervisor No.");
         */

    end;
}

