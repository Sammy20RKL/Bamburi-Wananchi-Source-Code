#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50028 "Posted Receipt Header Card"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Receipt Header";
    SourceTableView = where(Posted = const(true));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Code"; Rec."Bank Code")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Balance"; Rec."Bank Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque No"; Rec."Cheque No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cheque No.';
                }
                field("Currency Code"; Rec."Currency Code")
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
                field("Amount Received"; Rec."Amount Received")
                {
                    ApplicationArea = Basic;
                }
                field("Amount Received(LCY)"; Rec."Amount Received(LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Total Amount(LCY)"; Rec."Total Amount(LCY)")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Received From"; Rec."Received From")
                {
                    ApplicationArea = Basic;
                }
                field("On Behalf of"; Rec."On Behalf of")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic;
                }
            }
            part(Control23; "Posted Receipt Line")
            {
                SubPageLink = "Document No" = field("No.");
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Reprint Receipt")
            {
                ApplicationArea = Basic;
                Image = PrintVoucher;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    DocNo := Rec."No.";
                    ReceiptHeader.Reset;
                    ReceiptHeader.SetRange(ReceiptHeader."No.", DocNo);
                    if ReceiptHeader.FindFirst then begin
                        // Report.RunModal(Report::"Receipt Header", true, false, ReceiptHeader);
                    end;
                end;
            }
        }
    }

    var
        BillNoVisible: Boolean;
        AccNoVisible: Boolean;
        ok: Boolean;
        ReceiptLine: Record 51003;
        LineNo: Integer;
        FundsTransTypes: Record 51032;
        Amount: Decimal;
        "Amount(LCY)": Decimal;
        ReceiptLines: Record 51003;
        FundsManager: Codeunit "Funds Management";
        JTemplate: Code[20];
        JBatch: Code[20];
        FundsUser: Record "Funds User Setup";
        PostingVisible: Boolean;
        MoveVisible: Boolean;
        PageEditable: Boolean;
        ReverseVisible: Boolean;
        DocNo: Code[20];
        ReceiptHeader: Record 51002;

    local procedure CheckReceiptRequiredFields()
    begin
        Rec.CalcFields("Total Amount");

        Rec.TestField("Total Amount");
        Rec.TestField("Amount Received");
        Rec.TestField("Bank Code");
        Rec.TestField(Date);
        Rec.TestField("Posting Date");
        Rec.TestField(Description);
        Rec.TestField("Received From");
        Rec.TestField("Global Dimension 1 Code");
        Rec.TestField("Global Dimension 2 Code");

        if Rec."Amount Received" <> Rec."Total Amount" then
            Error('Amount Received must be Equal to the total Amount');
    end;

    local procedure CheckLines()
    begin
        ReceiptLines.Reset;
        ReceiptLines.SetRange(ReceiptLines."Document No", Rec."No.");
        if ReceiptLines.FindSet then begin
            repeat
                ReceiptLines.TestField(ReceiptLines."Account Code");
                ReceiptLines.TestField(ReceiptLines."Account Code");
                ReceiptLines.TestField(ReceiptLines.Amount);
            until ReceiptLines.Next = 0;
        end else begin
            Error('Empty Receipt Lines');
        end;
    end;
}

