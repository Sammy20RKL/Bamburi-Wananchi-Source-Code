#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50075 "Budgetary Control Setup"
{
    PageType = Card;
    SourceTable = "Budgetary Control Setup";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(Mandatory; Rec.Mandatory)
                {
                    ApplicationArea = Basic;
                }
                field("Allow OverExpenditure"; Rec."Allow OverExpenditure")
                {
                    ApplicationArea = Basic;
                }
                field("Actual Source"; Rec."Actual Source")
                {
                    ApplicationArea = Basic;
                }
                field("Budget Check Criteria"; Rec."Budget Check Criteria")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Budget)
            {
                Caption = 'Budget';
                field("Current Budget Code"; Rec."Current Budget Code")
                {
                    ApplicationArea = Basic;
                }
                field("Current Budget Start Date"; Rec."Current Budget Start Date")
                {
                    ApplicationArea = Basic;
                }
                field("Current Budget End Date"; Rec."Current Budget End Date")
                {
                    ApplicationArea = Basic;
                }
                field("Budget Dimension 1 Code"; Rec."Budget Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Budget Dimension 2 Code"; Rec."Budget Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Budget Dimension 3 Code"; Rec."Budget Dimension 3 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Budget Dimension 4 Code"; Rec."Budget Dimension 4 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Budget Dimension 5 Code"; Rec."Budget Dimension 5 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Budget Dimension 6 Code"; Rec."Budget Dimension 6 Code")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Actuals)
            {
                Caption = 'Actuals';
                field("Analysis View Code"; Rec."Analysis View Code")
                {
                    ApplicationArea = Basic;
                }
                field("Dimension 1 Code"; Rec."Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Dimension 2 Code"; Rec."Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Dimension 3 Code"; Rec."Dimension 3 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Dimension 4 Code"; Rec."Dimension 4 Code")
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

