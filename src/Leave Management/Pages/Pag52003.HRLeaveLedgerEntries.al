page 52003 "HR Leave Ledger Entries"
{
    ApplicationArea = All;
    DelayedInsert = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "HR Leave Ledger Entries Lv";
    Caption = 'HR Leave Ledger Entries';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field';
                }
                field("Leave Period"; Rec."Leave Period")
                {
                    ToolTip = 'Specifies the value of the Leave Period field';
                }
                field("Staff No."; Rec."Staff No.")
                {
                    ToolTip = 'Specifies the value of the Staff No. field';
                }
                field("Staff Name"; Rec."Staff Name")
                {
                    ToolTip = 'Specifies the value of the Staff Name field';
                }
                field("Leave Date"; Rec."Leave Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field';
                }
                field("Leave Type"; Rec."Leave Type")
                {
                    ToolTip = 'Specifies the value of the Leave Type field';
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ToolTip = 'Specifies the value of the Transaction Type field';
                }
                field("Leave Entry Type"; Rec."Leave Entry Type")
                {
                    ToolTip = 'Specifies the value of the Leave Entry Type field';
                }
                field("No. of days"; Rec."No. of days")
                {
                    ToolTip = 'Specifies the value of the No. of days field';
                }
                field("Leave Approval Date"; Rec."Leave Approval Date")
                {
                    ToolTip = 'Specifies the value of the Leave Approval Date field';
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field';
                }
                field("Leave Posting Description"; Rec."Leave Posting Description")
                {
                    ToolTip = 'Specifies the value of the Leave Posting Description field';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field';
                }
                field("Leave Application No."; Rec."Leave Application No.")
                {
                    ToolTip = 'Specifies the value of the Leave Application No. field';
                }
                field("Leave Period Code"; Rec."Leave Period Code")
                {
                    ToolTip = 'Specifies the value of the Leave Period Code field';
                }
                field(Closed; Rec.Closed)
                {
                    ToolTip = 'Specifies the value of the Closed field';
                }
            }
        }
    }

    actions
    {
    }
}





