page 52007 "Leave Adjustment Lines"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Leave Bal Adjustment Lines";
    Caption = 'Leave Adjustment Lines';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Staff No."; Rec."Staff No.")
                {
                    ToolTip = 'Specifies the value of the Staff No. field';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Employee Name field';
                }
                field("Leave Period"; Rec."Leave Period")
                {
                    Editable = false;
                    TableRelation = "Leave Period";
                    ToolTip = 'Specifies the value of the Leave Period field';
                }
                field("Leave Code"; Rec."Leave Code")
                {
                    Caption = 'Leave Type';
                    ToolTip = 'Specifies the value of the Leave Type field';
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ToolTip = 'Specifies the value of the Transaction Type field';
                }
                field("Leave Adj Entry Type"; Rec."Leave Adj Entry Type")
                {
                    ToolTip = 'Specifies the value of the Leave Adj Entry Type field';
                }
                field(CurrentEntitlement; Rec.CurrentEntitlement)
                {
                    Caption = 'Current Entitlement';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Current Entitlement field';
                }
                field(CurrentBalFoward; Rec.CurrentBalFoward)
                {
                    Caption = 'Current Balance Brought';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Current Balance Brought field';
                }
                field("New Entitlement"; Rec."New Entitlement")
                {
                    Caption = 'Entitlement Adjustment';
                    ToolTip = 'Specifies the value of the Entitlement Adjustment field';
                }
                field("Maturity Date"; Rec."Maturity Date")
                {
                    ToolTip = 'Specifies the value of the Maturity Date field';
                }
                field("Employment Type"; Rec."Employment Type")
                {
                    ToolTip = 'Specifies the value of the Employment Type field';
                }
            }
        }
    }

    actions
    {
    }
}





