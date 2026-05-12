#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 56006 "Posted Internal Transfers"
{
    // CardPageID = "Posted Sacco Transfer Card";
    PageType = List;
    SourceTable = "Sacco Transfers";
    SourceTableView = where(Posted = filter(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = Basic;
                }
                field("Schedule Total"; Rec."Schedule Total")
                {
                    ApplicationArea = Basic;
                }
                field(Approved; Rec.Approved)
                {
                    ApplicationArea = Basic;
                }
                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = Basic;
                }
                field("Source Account No."; Rec."Source Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Source Transaction Type"; Rec."Source Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field("Source Account Name"; Rec."Source Account Name")
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
    var
        p: Page 760;
}

