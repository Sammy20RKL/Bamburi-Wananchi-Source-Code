#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50640 "Data Sheet Lines"
{
    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "Data Sheet Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Payroll No"; Rec."Payroll No")
                {
                    ApplicationArea = Basic;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field("Loan Type"; Rec."Loan Type")
                {
                    ApplicationArea = Basic;
                }
                field("Principal Amount"; Rec."Principal Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Interest"; Rec."Outstanding Interest")
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Expected Principal Balance"; Rec."Expected Principal Balance")
                {
                    ApplicationArea = Basic;
                    Caption = 'Expected Principal Balance(Post-ChkOff)';
                }
                field("Share Capital"; Rec."Share Capital")
                {
                    ApplicationArea = Basic;
                }
                field("Entrance Fees"; Rec."Entrance Fees")
                {
                    ApplicationArea = Basic;
                }
                field("Deposit Contribution"; Rec."Deposit Contribution")
                {
                    ApplicationArea = Basic;
                }
                field("Kanisa Savings"; Rec."Kanisa Savings")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
            }
        }
    }

    actions
    {
    }
}

