#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50529 "Cheque Receipt Lines"
{
    PageType = List;
    SourceTable = "Cheque Issue Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cheque Serial No"; Rec."Cheque Serial No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Un pay Code"; Rec."Un pay Code")
                {
                    ApplicationArea = Basic;
                }
                field(Interpretation; Rec.Interpretation)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Unpay Date"; Rec."Unpay Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Un Pay Charge Amount"; Rec."Un Pay Charge Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Family Account No."; Rec."Family Account No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Co-op Account No';
                    Editable = false;
                }
                field("Date _Refference No."; Rec."Date _Refference No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Transaction Code"; Rec."Transaction Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Branch Code"; Rec."Branch Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Currency; Rec.Currency)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date-1"; Rec."Date-1")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date-2"; Rec."Date-2")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Coop  Routing No."; Rec."Coop  Routing No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Fillers; Rec.Fillers)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Transaction Refference"; Rec."Transaction Refference")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

