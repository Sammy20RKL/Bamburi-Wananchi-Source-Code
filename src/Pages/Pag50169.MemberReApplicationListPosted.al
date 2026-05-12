Page 50169 "MemberRe-ApplicationListPosted"
{
    ApplicationArea = All;
    Caption = 'Member Re-Application List Posted';
    PageType = List;
    SourceTable = "Member Reapplication";
    SourceTableView = sorting("No.") order(ascending) where(Reactivated = const(true));
    UsageCategory = Lists;
    InsertAllowed = false;
    CardPageId = "Member Re-Application Page";

    Editable = false;


    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                }
                field("Member No."; Rec."Member No.")
                {
                }
                field("Member Name"; Rec."Member Name")
                {
                }
                field("Reason for Re-Application"; Rec."Reason for Re-Application")
                {
                }
                field("Reason for Exit"; Rec."Reason for Exit")
                {
                }
                field("Re-Application By"; Rec."Re-Application By")
                {
                }
                field("Re-Application On"; Rec."Re-Application On")
                {
                }
                field("Re-Application status"; Rec."Re-Application status")
                {
                }
                field("Status on Exit"; Rec."Status on Exit")
                {
                }
                field("Exit Date"; Rec."Exit Date")
                {
                }
                field("Exited By"; Rec."Exited By")
                {
                }
            }
        }
    }
}