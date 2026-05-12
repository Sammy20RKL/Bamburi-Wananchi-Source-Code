#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50346 "Cheque Trans Verification"
{
    CardPageID = "Cheque Transactions Card.";
    Editable = false;
    PageType = List;
    SourceTable = "Cheque Issue Lines-Family";
    SourceTableView = where(Status = const(Pending));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Chq Receipt No"; Rec."Chq Receipt No")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque Serial No"; Rec."Cheque Serial No")
                {
                    ApplicationArea = Basic;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = Basic;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Date _Refference No."; Rec."Date _Refference No.")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Code"; Rec."Transaction Code")
                {
                    ApplicationArea = Basic;
                }
                field("Branch Code"; Rec."Branch Code")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("Cheque No"; Rec."Cheque No")
                {
                    ApplicationArea = Basic;
                }
                field(FrontImage; Rec.FrontImage)
                {
                    ApplicationArea = Basic;
                }
                field(FrontGrayImage; Rec.FrontGrayImage)
                {
                    ApplicationArea = Basic;
                }
                field(BackImages; Rec.BackImages)
                {
                    ApplicationArea = Basic;
                }
                field("Account Balance"; Rec."Account Balance")
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

