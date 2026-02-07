// namespace KRBERPSourceCode.KRBERPSourceCode;

page 57015 "Online Loan Applications"
{
    ApplicationArea = All;
    Caption = 'Online Loan Applications';
    PageType = List;
    CardPageId = "Online Loan Application Card";
    SourceTable = "Online Loan Application";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Application No"; Rec."Application No")
                {
                }
                field("BOSA No"; Rec."BOSA No")
                {
                }
                field("Loan No"; Rec."Loan No")
                {
                }
                field("Loan Amount"; Rec."Loan Amount")
                {
                }
                field("Application Date"; Rec."Application Date")
                {
                }
                field(Posted; Rec.Posted)
                {
                }
            }
        }
    }
}
