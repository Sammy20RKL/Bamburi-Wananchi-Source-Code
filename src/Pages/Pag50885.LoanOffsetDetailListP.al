#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50885 "Loan Offset Detail List-P"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 51376;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Loan No."; Rec."Loan No.")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("Loan Top Up"; Rec."Loan Top Up")
                {
                    ApplicationArea = Basic;
                }
                field("Client Code"; Rec."Client Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;
                }
                field("Loan Type"; Rec."Loan Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Principle Top Up"; Rec."Principle Top Up")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Age"; Rec."Loan Age")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Remaining Installments"; Rec."Remaining Installments")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Interest Top Up"; Rec."Interest Top Up")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Monthly Repayment"; Rec."Monthly Repayment")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Interest Paid"; Rec."Interest Paid")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Interest Rate"; Rec."Interest Rate")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Commision; Rec.Commision)
                {
                    ApplicationArea = Basic;
                    Caption = 'Levy';
                    Editable = false;
                }
                field("Interest Due at Clearance"; Rec."Interest Due at Clearance")
                {
                    ApplicationArea = Basic;
                    Caption = ' Interest Due';
                    Visible = false;
                }
                field("Total Top Up"; Rec."Total Top Up")
                {
                    ApplicationArea = Basic;
                    Caption = 'Total Recovery(P+I+Leavy)';
                    Editable = false;
                    Importance = Promoted;
                    Style = Attention;
                    StyleExpr = true;
                }
                field("Partial Bridged"; Rec."Partial Bridged")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Staff No"; Rec."Staff No")
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
}

