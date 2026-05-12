page 52029 "SwizzKash Transactions Buffer"
{
    ApplicationArea = All;
    Caption = 'SwizzKash Transactions Buffer';
    PageType = List;
    SourceTable = "Swizzkash Buffer";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No"; Rec."Entry No")
                {
                    ToolTip = 'Specifies the value of the Entry No field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.', Comment = '%';
                }
                field("Account No"; Rec."Account No")
                {
                    ToolTip = 'Specifies the value of the Account No field.', Comment = '%';
                }
                field(Posted; Rec.Posted)
                {
                    ToolTip = 'Specifies the value of the Posted field.', Comment = '%';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.', Comment = '%';
                }
                field("Trace ID"; Rec."Trace ID")
                {
                    ToolTip = 'Specifies the value of the Trace ID field.', Comment = '%';
                }
                field("Trans Time"; Rec."Trans Time")
                {
                    ToolTip = 'Specifies the value of the Trans Time field.', Comment = '%';
                }
                field(TransDate; Rec.TransDate)
                {
                    ToolTip = 'Specifies the value of the TransDate field.', Comment = '%';
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ToolTip = 'Specifies the value of the Transaction Date field.', Comment = '%';
                }
                field("Transaction Time"; Rec."Transaction Time")
                {
                    ToolTip = 'Specifies the value of the Transaction Time field.', Comment = '%';
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ToolTip = 'Specifies the value of the Transaction Type field.', Comment = '%';
                }
                field("Transaction Description"; Rec."Transaction Description")
                {
                    ToolTip = 'Specifies the value of the Transaction Description field.', Comment = '%';
                }
                field("Transaction Type Charges"; Rec."Transaction Type Charges")
                {
                    ToolTip = 'Specifies the value of the Transaction Type Charges field.', Comment = '%';
                }
            }
        }
    }
}
