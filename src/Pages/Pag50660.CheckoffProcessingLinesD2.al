#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50660 "Checkoff Processing Lines-D2"
{
    DelayedInsert = false;
    DeleteAllowed = true;
    Editable = true;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "Checkoff Lines-Distributed2";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                    StyleExpr = CoveragePercentStyle;
                }
                field("Staff/Payroll No"; Rec."Staff/Payroll No")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Variance; Rec.Variance)
                {
                    ApplicationArea = Basic;
                }
                field("Employer Code"; Rec."Employer Code")
                {
                    ApplicationArea = Basic;
                }
                field("Receipt Header No"; Rec."Receipt Header No")
                {
                    ApplicationArea = Basic;
                }
                field("Jiokoe Savings"; Rec."Jiokoe Savings")
                {
                    ApplicationArea = Basic;
                }
                field("Unallocated Fund"; Rec."Unallocated Fund")
                {
                    ApplicationArea = Basic;
                }
                field("Deposit contribution"; Rec."Deposit contribution")
                {
                    ApplicationArea = Basic;
                }
                field("Share Capital"; Rec."Share Capital")
                {
                    ApplicationArea = Basic;
                }
                field("Entrance Fees"; Rec."Entrance Fees")
                {
                    ApplicationArea = Basic;
                }
                field("Principal Loan"; Rec."Principal Loan")
                {
                    ApplicationArea = Basic;
                }
                field("Emergency 1 Loan"; Rec."Emergency 1 Loan")
                {
                    ApplicationArea = Basic;
                }
                field("Emergency 2 Loan"; Rec."Emergency 2 Loan")
                {
                    ApplicationArea = Basic;
                }
                field("Instant Loan"; Rec."Instant Loan")
                {
                    ApplicationArea = Basic;
                }
                field("Instant2 Loan"; Rec."Instant2 Loan")
                {
                    ApplicationArea = Basic;
                }
                field("Elimu Loan"; Rec."Elimu Loan")
                {
                    ApplicationArea = Basic;
                }
                field("Mjengo Loan"; Rec."Mjengo Loan")
                {
                    ApplicationArea = Basic;
                }
                field("Vision Loan"; Rec."Vision Loan")
                {
                    ApplicationArea = Basic;
                }
                field("KHL Loan"; Rec."KHL Loan")
                {
                    ApplicationArea = Basic;
                }
                field("Car Loan"; Rec."Car Loan")
                {
                    ApplicationArea = Basic;
                }
                field("Sukuma Mwezi Loan"; Rec."Sukuma Mwezi Loan")
                {
                    ApplicationArea = Basic;
                }
                field("Karibu Loan"; Rec."Karibu Loan")
                {
                    ApplicationArea = Basic;
                }
                field("Mali Mali Loan"; Rec."Mali Mali Loan")
                {
                    ApplicationArea = Basic;
                }
                field("Motor Vehicle Insurance"; Rec."Motor Vehicle Insurance")
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

    var
        CoveragePercentStyle: Text;

    local procedure SetStyles()
    begin
        CoveragePercentStyle := 'Strong';
        if Rec.Name = '' then
            CoveragePercentStyle := 'Unfavorable';
        if Rec.Name <> '' then
            CoveragePercentStyle := 'Favorable';
    end;
}

