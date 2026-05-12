#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50641 "Accrued Interest Lines"
{
    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "Monthly Interest Acrual";

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
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Product"; Rec."Loan Product")
                {
                    ApplicationArea = Basic;
                }
                field("Loan No"; Rec."Loan No")
                {
                    ApplicationArea = Basic;
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Interest Rate"; Rec."Interest Rate")
                {
                    ApplicationArea = Basic;
                }
                field("Interest Accrued"; Rec."Interest Accrued")
                {
                    ApplicationArea = Basic;
                    Style = Attention;
                    StyleExpr = true;
                }
            }
        }
    }

    actions
    {
    }
}

