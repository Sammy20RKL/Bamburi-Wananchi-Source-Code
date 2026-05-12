#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50401 "Posted BOSA Receipts List"
{
    ApplicationArea = Basic;
    CardPageID = "Posted BOSA Receipt Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Receipts & Payments";
    SourceTableView = where(Posted = filter(true));
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Transaction No."; Rec."Transaction No.")
                {
                    ApplicationArea = Basic;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field("Cheque No."; Rec."Cheque No.")
                {
                    ApplicationArea = Basic;
                }
                field("Employer No."; Rec."Employer No.")
                {
                    ApplicationArea = Basic;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Cheque Date"; Rec."Cheque Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Posting Date';
                }
            }
        }
    }

    actions
    {
    }
}
