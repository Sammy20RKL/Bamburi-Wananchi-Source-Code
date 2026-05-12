#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 57202 "Guarantors Loan Details"
{
    Editable = false;
    PageType = ListPart;
    SourceTable = "Guarantors Member Loans";

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
                field("Loan Type"; Rec."Loan Type")
                {
                    ApplicationArea = Basic;
                }
                field("Loan No."; Rec."Loan No.")
                {
                    ApplicationArea = Basic;
                }
                field("Amount Allocated"; Rec."Amount Allocated")
                {
                    ApplicationArea = Basic;
                }
                field("Approved Loan Amount"; Rec."Approved Loan Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Instalments"; Rec."Loan Instalments")
                {
                    ApplicationArea = Basic;
                }
                field("Monthly Repayment"; Rec."Monthly Repayment")
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Interest"; Rec."Outstanding Interest")
                {
                    ApplicationArea = Basic;
                }
                field("Interest Rate"; Rec."Interest Rate")
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

