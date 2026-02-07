page 52026 "User Setup List"
{
    ApplicationArea = All;
    Caption = 'User Setup - Detailed';
    PageType = List;
    CardPageId = "User Setup Card";
    SourceTable = "User Setup";
    UsageCategory = Lists;
    Editable = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the ID of the user who posted the entry, to be used, for example, in the change log.';
                }
                field("Approver ID"; Rec."Approver ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the user ID of the person who must approve records that are made by the user in the User ID field before the record can be released.';
                }
                field("Allow FA Posting To"; Rec."Allow FA Posting To")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Allow FA Posting To field.';
                }
                field("Allow FA Posting From"; Rec."Allow FA Posting From")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Allow FA Posting From field.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field';
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Approval Status field.';
                }
                field("Approval Administrator"; Rec."Approval Administrator")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the user who has rights to unblock approval workflows, for example, by delegating approval requests to new substitute approvers and deleting overdue approval requests.';
                }

            }
        }
    }
}






