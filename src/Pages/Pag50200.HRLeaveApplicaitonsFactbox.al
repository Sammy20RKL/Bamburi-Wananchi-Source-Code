#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50200 "HR Leave Applicaitons Factbox"
{
    PageType = CardPart;
    SourceTable = "HR Employees";

    layout
    {
        area(content)
        {
            label(Control1102755011)
            {
                ApplicationArea = Basic;
                CaptionClass = Text1;
                Style = StrongAccent;
                StyleExpr = true;
            }
            field("No."; Rec."No.")
            {
                ApplicationArea = Basic;
            }
            field("First Name"; Rec."First Name")
            {
                ApplicationArea = Basic;
            }
            field("Middle Name"; Rec."Middle Name")
            {
                ApplicationArea = Basic;
            }
            field("Last Name"; Rec."Last Name")
            {
                ApplicationArea = Basic;
            }
            field("Job Title"; Rec."Job Title")
            {
                ApplicationArea = Basic;
            }
            field(Status; Rec.Status)
            {
                ApplicationArea = Basic;
            }
            field("E-Mail"; Rec."E-Mail")
            {
                ApplicationArea = Basic;
            }
            label(Control1102755005)
            {
                ApplicationArea = Basic;
                Style = StrongAccent;
                StyleExpr = true;
            }
            label(Control1102755012)
            {
                ApplicationArea = Basic;
                CaptionClass = Text2;
                Style = StrongAccent;
                StyleExpr = true;
            }
            field("Total Leave Taken"; Rec."Total Leave Taken")
            {
                ApplicationArea = Basic;
            }
            field("Total (Leave Days)"; Rec."Total (Leave Days)")
            {
                ApplicationArea = Basic;
            }
            field("Reimbursed Leave Days"; Rec."Reimbursed Leave Days")
            {
                ApplicationArea = Basic;
            }
            field("Allocated Leave Days"; Rec."Allocated Leave Days")
            {
                ApplicationArea = Basic;
            }
            // field(Missing; Rec.Missing)
            // {
            //     ApplicationArea = Basic;
            //     Style = Favorable;
            //     StyleExpr = true;
            // }
            field("Compassionate Leave Acc."; Rec."Compassionate Leave Acc.")
            {
                ApplicationArea = Basic;
            }
            field("Maternity Leave Acc."; Rec."Maternity Leave Acc.")
            {
                ApplicationArea = Basic;
            }
            field("Paternity Leave Acc."; Rec."Paternity Leave Acc.")
            {
                ApplicationArea = Basic;
            }
            field("Sick Leave Acc."; Rec."Sick Leave Acc.")
            {
                ApplicationArea = Basic;
            }
            field("Study Leave Acc"; Rec."Study Leave Acc")
            {
                ApplicationArea = Basic;
            }
        }
    }

    actions
    {
    }

    var
        Text1: label 'Employee Details';
        Text2: label 'Employeee Leave Details';
    // Text3: ;
}

