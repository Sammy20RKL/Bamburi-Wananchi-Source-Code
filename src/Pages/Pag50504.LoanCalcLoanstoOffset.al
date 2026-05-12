#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50504 "Loan Calc. Loans to Offset"
{
    PageType = List;
    SourceTable = "Loan Calc. Loans to Offset";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Client Code"; Rec."Client Code")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Top Up"; Rec."Loan Top Up")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Type"; Rec."Loan Type")
                {
                    ApplicationArea = Basic;
                }
                field("Principle Top Up"; Rec."Principle Top Up")
                {
                    ApplicationArea = Basic;
                }
                field("Interest Top Up"; Rec."Interest Top Up")
                {
                    ApplicationArea = Basic;
                }
                field("Total Top Up"; Rec."Total Top Up")
                {
                    ApplicationArea = Basic;
                }
                field("Monthly Repayment"; Rec."Monthly Repayment")
                {
                    ApplicationArea = Basic;
                }
                field("Interest Paid"; Rec."Interest Paid")
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
                field("ID. NO"; Rec."ID. NO")
                {
                    ApplicationArea = Basic;
                }
                field(Commision; Rec.Commision)
                {
                    ApplicationArea = Basic;
                }
                field("Partial Bridged"; Rec."Partial Bridged")
                {
                    ApplicationArea = Basic;
                }
                field("Remaining Installments"; Rec."Remaining Installments")
                {
                    ApplicationArea = Basic;
                }
                field("Finale Instalment"; Rec."Finale Instalment")
                {
                    ApplicationArea = Basic;
                }
                field("Penalty Charged"; Rec."Penalty Charged")
                {
                    ApplicationArea = Basic;
                }
                field("Staff No"; Rec."Staff No")
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

