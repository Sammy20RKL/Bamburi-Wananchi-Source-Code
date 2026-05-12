#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50055 "Payment Types Card"
{
    PageType = Card;
    SourceTable = "Funds Transaction Types";
    SourceTableView = where("Transaction Type" = const(Payment));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Transaction Code"; Rec."Transaction Code")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Description"; Rec."Transaction Description")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Default Grouping"; Rec."Default Grouping")
                {
                    ApplicationArea = Basic;
                }
                field("Withholding Tax Chargeable"; Rec."Withholding Tax Chargeable")
                {
                    ApplicationArea = Basic;
                }
                field("Withholding Tax Code"; Rec."Withholding Tax Code")
                {
                    ApplicationArea = Basic;
                }
                field("VAT Chargeable"; Rec."VAT Chargeable")
                {
                    ApplicationArea = Basic;
                }
                field("VAT Code"; Rec."VAT Code")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Other Setup")
            {
                field("Meeting Transaction"; Rec."Meeting Transaction")
                {
                    ApplicationArea = Basic;
                }
                field("Meeting Type"; Rec."Meeting Type")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Transaction Type" := Rec."transaction type"::Payment;
    end;
}

