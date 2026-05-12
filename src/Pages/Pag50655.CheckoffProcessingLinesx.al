#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50655 "Checkoff Processing Linesx"
{
    DelayedInsert = false;
    DeleteAllowed = true;
    Editable = true;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "Checkoff Lines-Distributedx";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Checkoff No"; Rec."Checkoff No")
                {
                    ApplicationArea = Basic;
                    StyleExpr = CoveragePercentStyle;
                }
                field("Staff/Payroll No"; Rec."Staff/Payroll No")
                {
                    ApplicationArea = Basic;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(TOTAL_DISTRIBUTED; Rec.TOTAL_DISTRIBUTED)
                {
                    ApplicationArea = Basic;
                    Caption = 'Total Amount';
                    Editable = false;
                }
                field("No Repayment"; Rec."No Repayment")
                {
                    ApplicationArea = Basic;
                }
                field("Staff Not Found"; Rec."Staff Not Found")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Date Filter"; Rec."Date Filter")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Car Loan"; Rec."Car Loan")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Development; Rec.Development)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Sambamba; Rec.Sambamba)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Emergency; Rec.Emergency)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("School Fees"; Rec."School Fees")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Benevolent; Rec.Benevolent)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Deposit Contribution"; Rec."Deposit Contribution")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Defaulter; Rec.Defaulter)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account Not Found"; Rec."Account Not Found")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Okoa Jahazi"; Rec."Okoa Jahazi")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Vuka Special"; Rec."Vuka Special")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("40 Years"; Rec."40 Years")
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
        //SetStyles();
    end;

    var
        CoveragePercentStyle: Text;

    local procedure SetStyles()
    begin
        /*CoveragePercentStyle:='Strong';
        IF "No Repayment" ='' THEN
           CoveragePercentStyle := 'Unfavorable';
        IF "No Repayment" <>'' THEN
            CoveragePercentStyle := 'Favorable';*/

    end;
}

