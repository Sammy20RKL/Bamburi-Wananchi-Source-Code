#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50644 "CheckOff Distributions Master"
{
    PageType = List;
    SourceTable = "Checkoff Processing Details(B)";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Check Off No"; Rec."Check Off No")
                {
                    ApplicationArea = Basic;
                }
                field("Check Off Advice No"; Rec."Check Off Advice No")
                {
                    ApplicationArea = Basic;
                }
                field("Check Off Date"; Rec."Check Off Date")
                {
                    ApplicationArea = Basic;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Type"; Rec."Transaction Type")
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
                field(Amount; Rec.Amount)
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
            }
        }
    }

    actions
    {
    }
}

