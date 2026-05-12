#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 56176 "Posted Payment Card"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Payments Header";
    SourceTableView = where("Payment Type" = const(Normal),
                            Posted = const(true));

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
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Basic;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field("Payment Mode"; Rec."Payment Mode")
                {
                    ApplicationArea = Basic;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Account"; Rec."Paying Bank Account")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Account Name"; Rec."Bank Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Account Balance"; Rec."Bank Account Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque Type"; Rec."Cheque Type")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque No"; Rec."Cheque No")
                {
                    ApplicationArea = Basic;
                }
                field(Payee; Rec.Payee)
                {
                    ApplicationArea = Basic;
                }
                field("On Behalf Of"; Rec."On Behalf Of")
                {
                    ApplicationArea = Basic;
                }
                field("Payment Description"; Rec."Payment Description")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Amount(LCY)"; Rec."Amount(LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("VAT Amount"; Rec."VAT Amount")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("VAT Amount(LCY)"; Rec."VAT Amount(LCY)")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("WithHolding Tax Amount"; Rec."WithHolding Tax Amount")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("WithHolding Tax Amount(LCY)"; Rec."WithHolding Tax Amount(LCY)")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Net Amount"; Rec."Net Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Net Amount(LCY)"; Rec."Net Amount(LCY)")
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
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                }
                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = Basic;
                }
                field("Date Posted"; Rec."Date Posted")
                {
                    ApplicationArea = Basic;
                }
                field("Time Posted"; Rec."Time Posted")
                {
                    ApplicationArea = Basic;
                }
                field(Cashier; Rec.Cashier)
                {
                    ApplicationArea = Basic;
                }
            }
            part(Control35; "Posted Payment Line")
            {
                SubPageLink = "Document No" = field("No.");
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Print)
            {
                ApplicationArea = Basic;
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    PHeader.Reset;
                    PHeader.SetRange(PHeader."No.", Rec."No.");
                    if PHeader.FindFirst then begin
                        Report.RunModal(Report::"Payment Voucher", true, false, PHeader);
                    end;
                end;
            }
        }
    }

    var
        PHeader: Record "Payments Header";
}

