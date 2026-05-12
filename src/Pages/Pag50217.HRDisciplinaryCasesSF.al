#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50217 "HR Disciplinary Cases SF"
{
    PageType = List;
    SourceTable = "HR Disciplinary Cases";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Case Number"; Rec."Case Number")
                {
                    ApplicationArea = Basic;
                }
                field("Date of Complaint"; Rec."Date of Complaint")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field(Selected; Rec.Selected)
                {
                    ApplicationArea = Basic;
                }
                field("Type of Disciplinary Case"; Rec."Type of Disciplinary Case")
                {
                    ApplicationArea = Basic;
                }
                field("Case Description"; Rec."Case Description")
                {
                    ApplicationArea = Basic;
                }
                field("Case Discussion"; Rec."Case Discussion")
                {
                    ApplicationArea = Basic;
                }
                field("Mode of Lodging the Complaint"; Rec."Mode of Lodging the Complaint")
                {
                    ApplicationArea = Basic;
                }
                field(Accuser; Rec.Accuser)
                {
                    ApplicationArea = Basic;
                }
                field("Witness #1"; Rec."Witness #1")
                {
                    ApplicationArea = Basic;
                }
                field("Witness #2"; Rec."Witness #2")
                {
                    ApplicationArea = Basic;
                }
                field("Recommended Action"; Rec."Recommended Action")
                {
                    ApplicationArea = Basic;
                }
                field("Action Taken"; Rec."Action Taken")
                {
                    ApplicationArea = Basic;
                }
                field("Support Documents"; Rec."Support Documents")
                {
                    ApplicationArea = Basic;
                }
                field("Policy Guidlines In Effect"; Rec."Policy Guidlines In Effect")
                {
                    ApplicationArea = Basic;
                }
                field(Recomendations; Rec.Recomendations)
                {
                    ApplicationArea = Basic;
                }
                field("HR/Payroll Implications"; Rec."HR/Payroll Implications")
                {
                    ApplicationArea = Basic;
                }
                field("Disciplinary Remarks"; Rec."Disciplinary Remarks")
                {
                    ApplicationArea = Basic;
                }
                field(Comments; Rec.Comments)
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

