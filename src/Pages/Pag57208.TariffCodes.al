// namespace PolyTechERPSourceCode.PolyTechERPSourceCode;

page 57208 "Tariff Codes"
{
    ApplicationArea = All;
    Caption = 'Tariff Codes';
    PageType = List;
    SourceTable = "Tariff Codes";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Tax Code"; Rec."Tax Code")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Percentage; Rec.Percentage)
                {
                }
                field("Account No."; Rec."Account No.")
                {
                }
                field("Account Type"; Rec."Account Type")
                {
                }
                field("Type"; Rec."Type")
                {
                }
            }
        }
    }
}
