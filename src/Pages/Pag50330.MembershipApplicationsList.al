page 50330 "Membership Applications List"
{
    ApplicationArea = Basic;
    CardPageID = "Membership Application Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    AnalysisModeEnabled = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Membership Applications";
    // SourceTableView = where("Approval Status" = filter(<> open));
    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Rec."Name")
                {
                    ApplicationArea = Basic;
                }
                field("Account Type"; Rec."Account Category")
                {
                    ApplicationArea = Basic;
                }
                // field("Account To Open"; Rec."Account To Open")
                // {
                //     ApplicationArea = Basic;
                // }
                field("Captured By"; Rec."Captured By")
                {
                    ApplicationArea = Basic;
                }
                // field("Membership Application Status"; Rec."Membership Application Status")
                // {
                //     ApplicationArea = Basic;
                //     caption = 'Status';
                //     Style = AttentionAccent;
                // }
            }
        }
    }

    actions
    {

    }
    trigger OnOpenPage()
    begin
        rec.setrange(rec."Captured By", UserId);
    end;

    var
}

