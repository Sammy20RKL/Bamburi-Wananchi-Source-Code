#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50201 "HR Company Activities Factbox"
{
    PageType = CardPart;
    SourceTable = "HR Company Activities";

    layout
    {
        area(content)
        {
            group(Control1102755018)
            {
                label(Control1102755019)
                {
                    ApplicationArea = Basic;
                    CaptionClass = Text1;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic;
                }
                field(Venue; Rec.Venue)
                {
                    ApplicationArea = Basic;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employee Responsible';
                }
                field("Email Message"; Rec."Email Message")
                {
                    ApplicationArea = Basic;
                }
                label(Control1102755020)
                {
                    ApplicationArea = Basic;
                    CaptionClass = Text2;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
                field(Costs; Rec.Costs)
                {
                    ApplicationArea = Basic;
                }
                field("Contribution Amount (If Any)"; Rec."Contribution Amount (If Any)")
                {
                    ApplicationArea = Basic;
                }
                field("G/L Account No"; Rec."G/L Account No")
                {
                    ApplicationArea = Basic;
                }
                field("G/L Account Name"; Rec."G/L Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Bal. Account Type"; Rec."Bal. Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Bal. Account No"; Rec."Bal. Account No")
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                }
                label(Control1102755012)
                {
                    ApplicationArea = Basic;
                    CaptionClass = Text3;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    var
        Text1: label 'Activity Description';
        Text2: label 'Activity Cost';
        Text3: label 'Activity Status';
}

