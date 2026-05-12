#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50570 "Cheque Receipt Line-Family"
{
    // CardPageID = "Cheque Truncation Card";
    Editable = true;
    PageType = List;
    SourceTable = "Cheque Issue Lines-Family";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cheque Serial No"; Rec."Cheque Serial No")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque No"; Rec."Cheque No")
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
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Account Balance"; Rec."Account Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Un pay Code"; Rec."Un pay Code")
                {
                    ApplicationArea = Basic;
                }
                field(Interpretation; Rec.Interpretation)
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("Un Pay Charge Amount"; Rec."Un Pay Charge Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Family Account No."; Rec."Family Account No.")
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
                field("Date-1"; Rec."Date-1")
                {
                    ApplicationArea = Basic;
                }
                field("Date-2"; Rec."Date-2")
                {
                    ApplicationArea = Basic;
                }
                field("Family Routing No."; Rec."Family Routing No.")
                {
                    ApplicationArea = Basic;
                }
                field(Fillers; Rec.Fillers)
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Refference"; Rec."Transaction Refference")
                {
                    ApplicationArea = Basic;
                }
                field("Unpay Date"; Rec."Unpay Date")
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
                field("Transaction Date"; Rec."Transaction Date")
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

