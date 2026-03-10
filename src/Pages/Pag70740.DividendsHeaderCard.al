#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006
page 70740 "Dividends Header Card"
{
    Caption = 'Dividend Header Card';
    PageType = Card;
    SourceTable = "Dividends Header";
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("No"; Rec."No")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        // Add No. Series assist edit logic here if needed
                    end;
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
                    Editable = false;
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
            part(DividendLinesFactBox; "Dividend Lines List")
            {

                ApplicationArea = Basic;
                Caption = 'Dividend Lines';
                Editable = IsEditable;
                SubPageLink = "No" = field("No");
            }
        }

    }


    actions
    {
        area(Navigation)
        {
        }


    }
    var
        IsEditable: Boolean;

    trigger OnAfterGetRecord()
    begin
        IsEditable := not Rec.Posted;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        IsEditable := not Rec.Posted;
    end;
}