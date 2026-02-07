#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50007 "Cash Payment Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Payments Header";
    SourceTableView = where("Payment Type" = const("Cash Purchase"),
                            Posted = const(false));

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
                // field("VAT Amount"; Rec."VAT Amount")
                // {
                //     ApplicationArea = Basic;
                // }
                field("VAT Amount(LCY)"; Rec."VAT Amount(LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("WithHolding Tax Amount"; Rec."WithHolding Tax Amount")
                {
                    ApplicationArea = Basic;
                }
                field("WithHolding Tax Amount(LCY)"; Rec."WithHolding Tax Amount(LCY)")
                {
                    ApplicationArea = Basic;
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
            part(Control35; "Cash Payment Line")
            {
                SubPageLink = "Document No" = field("No.");
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Post Payment")
            {
                ApplicationArea = Basic;
                Image = Payment;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    CheckRequiredItems;
                    if FundsUser.Get(UserId) then begin
                        FundsUser.TestField(FundsUser."Payment Journal Template");
                        FundsUser.TestField(FundsUser."Payment Journal Batch");
                        JTemplate := FundsUser."Payment Journal Template";
                        JBatch := FundsUser."Payment Journal Batch";
                        FundsManager.PostPayment(Rec, JTemplate, JBatch);
                    end else begin
                        Error('User Account Not Setup, Contact the System Administrator');
                    end
                end;
            }
            action("Post and Print")
            {
                ApplicationArea = Basic;
                Image = PostPrint;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    CheckRequiredItems;
                    if FundsUser.Get(UserId) then begin
                        FundsUser.TestField(FundsUser."Payment Journal Template");
                        FundsUser.TestField(FundsUser."Payment Journal Batch");
                        JTemplate := FundsUser."Payment Journal Template";
                        JBatch := FundsUser."Payment Journal Batch";
                        FundsManager.PostPayment(Rec, JTemplate, JBatch);
                        Commit;
                        PHeader.Reset;
                        PHeader.SetRange(PHeader."No.", Rec."No.");
                        if PHeader.FindFirst then begin
                            Report.RunModal(Report::"Cash Voucher", true, false, PHeader);
                        end;
                    end else begin
                        Error('User Account Not Setup, Contact the System Administrator');
                    end
                end;
            }
            action("Send Approval Request")
            {
                ApplicationArea = Basic;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.TestField(Status, Rec.Status::New);

                    DocType := Doctype::"Payment Voucher";
                    Clear(TableID);
                    TableID := Database::"Payments Header";
                    // if ApprovalMgt.SendApproval(TableID,Rec."No.",DocType,Status) then;
                end;
            }
            action("Cancel Approval Request")
            {
                ApplicationArea = Basic;
            }
            action(Approvals)
            {
                ApplicationArea = Basic;
            }
            action(Print)
            {
                ApplicationArea = Basic;
                Image = Print;
                Promoted = true;

                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    PHeader.Reset;
                    PHeader.SetRange(PHeader."No.", Rec."No.");
                    if PHeader.FindFirst then begin
                        Report.RunModal(Report::"Cash Voucher", true, false, PHeader);
                    end;
                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Payment Mode" := Rec."payment mode"::Cash;
        Rec."Payment Type" := Rec."payment type"::"Cash Purchase";
    end;

    var
        FundsUser: Record "Funds User Setup";
        FundsManager: Codeunit "Funds Management";
        JTemplate: Code[20];
        JBatch: Code[20];
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Staff Advance","Staff Advance Accounting";
        TableID: Integer;
        // ApprovalMgt: Codeunit "Export F/O Consolidation";
        PHeader: Record "Payments Header";

    local procedure CheckRequiredItems()
    begin
        Rec.TestField(Status, Rec.Status::Approved);
        Rec.TestField("Posting Date");
        Rec.TestField(Payee);
        Rec.TestField("Paying Bank Account");
        Rec.TestField("Payment Description");
        Rec.TestField("Global Dimension 1 Code");
        Rec.TestField("Global Dimension 2 Code");
    end;
}

