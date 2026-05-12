#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50495 "Cheque Clearing Lines"
{
    Editable = true;
    PageType = ListPart;
    SourceTable = "Cheque Clearing Lines";

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                Editable = true;
                field("Transaction No"; Rec."Transaction No")
                {
                    ApplicationArea = Basic;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Cheque No"; Rec."Cheque No")
                {
                    ApplicationArea = Basic;
                }
                field("Expected Maturity Date"; Rec."Expected Maturity Date")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque Clearing Status"; Rec."Cheque Clearing Status")
                {
                    ApplicationArea = Basic;
                }
                field("Ledger Entry No"; Rec."Ledger Entry No")
                {
                    ApplicationArea = Basic;
                }
                field("Ledger Transaction No."; Rec."Ledger Transaction No.")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin

        //SETRANGE(USER,USERID);
    end;
}

