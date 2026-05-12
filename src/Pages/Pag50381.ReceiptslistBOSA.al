#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50381 "Receipts list-BOSA"
{
    // CardPageID = "Receipts Header-BOSA";
    Editable = false;
    PageType = List;
    SourceTable = "Receipts & Payments";
    SourceTableView = where(Posted = const(false));

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
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = Basic;
                }
                field("Receipt Mode"; Rec."Receipt Mode")
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

