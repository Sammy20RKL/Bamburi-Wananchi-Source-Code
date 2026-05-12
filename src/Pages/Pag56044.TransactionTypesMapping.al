Page 56044 "Transaction Types Mapping"
{
    ApplicationArea = All;
    Caption = 'Transaction Types Mapping';
    PageType = List;
    SourceTable = "Transaction Types Table";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Transaction Type"; Rec."Transaction Type")
                {

                }
                field("Posting Group Code"; Rec."Posting Group Code")
                {

                }
            }
        }
    }
}
