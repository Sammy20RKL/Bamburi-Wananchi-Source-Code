#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 56141 "Over draft"
{
    ApplicationArea = Basic;
    CardPageID = "Over draft Application Card-P";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Over Draft Register";
    SourceTableView = where(Posted = const(true));
    UsageCategory = Lists;

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
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("commission charged"; Rec."commission charged")
                {
                    ApplicationArea = Basic;
                }
                field("Interest Charged"; Rec."Interest Charged")
                {
                    ApplicationArea = Basic;
                }
                field("Overdraft Status"; Rec."Overdraft Status")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    local procedure PostOverdraft()
    begin
    end;
}

