#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50483 "Checkoff Processing Lines-D"
{
    DelayedInsert = false;
    DeleteAllowed = true;
    Editable = true;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "Checkoff Lines-Distributed";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Staff/Payroll No"; Rec."Staff/Payroll No")
                {
                    ApplicationArea = Basic;
                    StyleExpr = CoveragePercentStyle;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Employer Code"; Rec."Employer Code")
                {
                    ApplicationArea = Basic;
                }
                field("Shares Capital"; Rec."Shares Capital")
                {
                    ApplicationArea = Basic;
                }
                field("Deposit contribution"; Rec."Deposit contribution")
                {
                    ApplicationArea = Basic;
                }
                field("DLoan No"; Rec."DLoan No")
                {
                    ApplicationArea = Basic;
                }
                field("Int DEVELOPMENT LOAN"; Rec."Int DEVELOPMENT LOAN")
                {
                    ApplicationArea = Basic;
                }
                field("DEVELOPMENT LOAN"; Rec."DEVELOPMENT LOAN")
                {
                    ApplicationArea = Basic;
                }
                field("Int INVESTMENT LOAN"; Rec."Int INVESTMENT LOAN")
                {
                    ApplicationArea = Basic;
                }
                field("INVESTMENT LOAN"; Rec."INVESTMENT LOAN")
                {
                    ApplicationArea = Basic;
                }
                field("Int SUPER SCHOOL FEES"; Rec."Int SUPER SCHOOL FEES")
                {
                    ApplicationArea = Basic;
                }
                field("SUPER SCHOOL FEES"; Rec."SUPER SCHOOL FEES")
                {
                    ApplicationArea = Basic;
                }
                field("Int SCHOOL FEES"; Rec."Int SCHOOL FEES")
                {
                    ApplicationArea = Basic;
                }
                field("SCHOOL FEES"; Rec."SCHOOL FEES")
                {
                    ApplicationArea = Basic;
                }
                field("Int SUPER QUICK"; Rec."Int SUPER QUICK")
                {
                    ApplicationArea = Basic;
                }
                field("SUPER QUICK"; Rec."SUPER QUICK")
                {
                    ApplicationArea = Basic;
                }
                field("Int QUICK LOAN"; Rec."Int QUICK LOAN")
                {
                    ApplicationArea = Basic;
                }
                field("QUICK LOAN"; Rec."QUICK LOAN")
                {
                    ApplicationArea = Basic;
                }
                field("Int EMERGENCY LOAN"; Rec."Int EMERGENCY LOAN")
                {
                    ApplicationArea = Basic;
                }
                field("EMERGENCY LOAN"; Rec."EMERGENCY LOAN")
                {
                    ApplicationArea = Basic;
                }
                field("ELoan No."; Rec."ELoan No.")
                {
                    ApplicationArea = Basic;
                }
                field(SLoanNo; Rec.SLoanNo)
                {
                    ApplicationArea = Basic;
                }
                field("QLoan No"; Rec."QLoan No")
                {
                    ApplicationArea = Basic;
                }
                field("House Loan"; Rec."House Loan")
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
        if Rec."Member No." = '' then
            CoveragePercentStyle := 'Unfavorable';
        if Rec."Member No." <> '' then
            CoveragePercentStyle := 'Favorable';
    end;
}

