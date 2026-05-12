
Page 56173 "Share Capital Trading Posted"
{
    ApplicationArea = All;
    Caption = 'Share Capital Trading List Posted';
    PageType = List;
    SourceTable = SharecapitalTrading;
    CardPageId = "share Capital Card";
    UsageCategory = Administration;
    SourceTableView = where(Posted = const(true));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Name of Seller"; Rec."Name of Seller")
                {
                    ToolTip = 'Specifies the value of the Name of Seller field.';
                }
                field("Seller Share Balance"; Rec."Seller Share Balance")
                {
                    ToolTip = 'Specifies the value of the Share Balance field.';
                }
                field("Amount to Sell"; Rec."Amount to Sell")
                {
                    ToolTip = 'Specifies the value of the Amount to Sell field.';
                }
                field(Reason; Rec.Reason)
                {
                    ToolTip = 'Specifies the value of the Reason field.';
                }
                field("Selling price"; Rec."Selling price")
                {
                    ToolTip = 'Specifies the value of the Selling price field.';
                }
                field("Buyer No."; Rec."Buyer No.")
                {
                    ToolTip = 'Specifies the value of the Buyer No. field.';
                }
                field("Buyer Name"; Rec."Buyer Name")
                {
                    ToolTip = 'Specifies the value of the Buyer Name field.';
                }
                field("Buyer Shares Balance"; Rec."Buyer Shares Balance")
                {
                    ToolTip = 'Specifies the value of the Buyer Shares Amount field.';
                }
                field(cashier; Rec.cashier)
                {
                    ToolTip = 'Specifies the value of the cashier field.';
                }
            }
        }
    }
}
