#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50491 "Salary Processing Lines"
{
    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "Salary Processing Lines";

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                Editable = true;
                field("BOSA No"; Rec."BOSA No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Number';
                    Visible = false;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Visible = false;
                }
                field("Staff No."; Rec."Staff No.")
                {
                    ApplicationArea = Basic;
                    StyleExpr = CoveragePercentStyle;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Image = Person;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Employer Code"; Rec."Employer Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Branch Reff."; Rec."Branch Reff.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Original Account No."; Rec."Original Account No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Account Not Found"; Rec."Account Not Found")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("BOSA Schedule"; Rec."BOSA Schedule")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Multiple Salary"; Rec."Multiple Salary")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Salary Header No."; Rec."Salary Header No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        SetStyles();
    end;

    trigger OnOpenPage()
    begin

        //SETRANGE(USER,USERID);
    end;

    var
        CoveragePercentStyle: Text;

    local procedure SetStyles()
    begin
        CoveragePercentStyle := 'Strong';
        if Rec."Account Name" = '' then
            CoveragePercentStyle := 'Unfavorable';
        if Rec."Account Name" <> '' then
            CoveragePercentStyle := 'Favorable';
    end;
}

