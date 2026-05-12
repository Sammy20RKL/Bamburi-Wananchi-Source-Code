#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 56145 "Posted Authorisation List"
{
    CardPageID = "Posted Authorisation Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Over Draft Authorisationx";
    SourceTableView = where(Posted = const(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Over Draft No"; Rec."Over Draft No")
                {
                    ApplicationArea = Basic;
                }
                field("Over Draft Payoff"; Rec."Over Draft Payoff")
                {
                    ApplicationArea = Basic;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Application date"; Rec."Application date")
                {
                    ApplicationArea = Basic;
                }
                field("Approved Date"; Rec."Approved Date")
                {
                    ApplicationArea = Basic;
                }
                field("Captured by"; Rec."Captured by")
                {
                    ApplicationArea = Basic;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Current Account No"; Rec."Current Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Overdraft"; Rec."Outstanding Overdraft")
                {
                    ApplicationArea = Basic;
                }
                field("Amount applied"; Rec."Amount applied")
                {
                    ApplicationArea = Basic;
                }
                field("Date Filter"; Rec."Date Filter")
                {
                    ApplicationArea = Basic;
                }
                field("ID Number"; Rec."ID Number")
                {
                    ApplicationArea = Basic;
                }
                field("Phone No"; Rec."Phone No")
                {
                    ApplicationArea = Basic;
                }
                field("Email Address"; Rec."Email Address")
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("Overdraft Status"; Rec."Overdraft Status")
                {
                    ApplicationArea = Basic;
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

