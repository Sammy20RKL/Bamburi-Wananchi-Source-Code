page 70739 "Dividends Header List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Dividends Header Card";
    SourceTable = "Dividends Header";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No"; Rec."No")
                {
                    ApplicationArea = All;
                }
                field("Description"; Rec."Description")
                {
                    ApplicationArea = All;

                }
                field("Year"; Rec."Year")
                {
                    ApplicationArea = All;
                }
                field("Posted"; Rec."Posted")
                {
                    ApplicationArea = All;
                }
                field("Deposits"; Rec."Deposits")
                {
                    ApplicationArea = All;
                }

                field("Earned Amount"; Rec."Earned Amount")
                {
                    ApplicationArea = All;
                }
                field("Withholding Tax(Share&Depo)"; Rec."Withholding Tax(Share&Depo)")
                {
                    ApplicationArea = All;
                    Caption = 'Withholding Tax';
                }
                field("Net Pay"; Rec."Net Pay")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            // action(ActionName)
            // {

            //     trigger OnAction()
            //     begin

            //     end;
            // }
        }

    }
}