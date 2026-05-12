#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50626 "Receipt Allocation(Posted)"
{
    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    ShowFilter = false;
    SourceTable = "Receipt Allocation";

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field("Mpesa Account Type"; Rec."Mpesa Account Type")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Mpesa Account No"; Rec."Mpesa Account No")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field("Loan No."; Rec."Loan No.")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Cummulative Total Payment Loan"; Rec."Cummulative Total Payment Loan")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cummulative Total Payment Loan';
                }
                field("Cash Clearing Charge"; Rec."Cash Clearing Charge")
                {
                    ApplicationArea = Basic;
                }
                field("Interest Amount"; Rec."Interest Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Amount Balance"; Rec."Amount Balance")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Interest Balance"; Rec."Interest Balance")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Prepayment Date"; Rec."Prepayment Date")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Insurance"; Rec."Loan Insurance")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
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
        sto.Reset;
        sto.SetRange(sto."No.", Rec."Document No");
        if sto.Find('-') then begin
            if sto.Status = sto.Status::Approved then begin
                CurrPage.Editable := false;
            end else
                CurrPage.Editable := true;
        end;
    end;

    var
        sto: Record "Standing Orders";
        Loan: Record "Loans Register";
        ReceiptAllocation: Record "Receipt Allocation";
        ReceiptH: Record "Receipts & Payments";
}

