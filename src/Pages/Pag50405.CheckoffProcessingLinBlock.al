#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50405 "Checkoff Processing Lin(Block)"
{
    PageType = ListPart;
    SourceTable = "Checkoff Processing Lin(Block)";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Staff/Payroll No"; Rec."Staff/Payroll No")
                {
                    ApplicationArea = Basic;
                    StyleExpr = CoveragePercentStyle;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field("Employer Code"; Rec."Employer Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
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

    trigger OnModifyRecord(): Boolean
    begin
        SetStyles();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        SetStyles();
    end;

    var
        CoveragePercentStyle: Text;

    local procedure SetStyles()
    begin
        CoveragePercentStyle := 'Strong';
        if Rec."Member No" = '' then
            CoveragePercentStyle := 'Unfavorable';
        if Rec."Member No" <> '' then
            CoveragePercentStyle := 'Favorable';
    end;
}

