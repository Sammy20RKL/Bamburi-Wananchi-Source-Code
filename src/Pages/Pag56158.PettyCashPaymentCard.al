#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 56158 "PettyCash Payment Card"
{
    PageType = Card;
    SourceTable = "Payments Header";

    RefreshOnActivate = true;
    Caption = 'Petty Cash Application';
    SourceTableView = where("Payment Type" = const("Petty Cash"),
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
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
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
                    Editable = false;
                }
                // field(Posted; Posted)
                // {
                //     ApplicationArea = Basic;
                // }
                // field("Posted By"; "Posted By")
                // {
                //     ApplicationArea = Basic;
                // }
                // field("Date Posted"; "Date Posted")
                // {
                //     ApplicationArea = Basic;
                // }
                // field("Time Posted"; "Time Posted")
                // {
                //     ApplicationArea = Basic;
                // }
                field(Cashier; Rec.Cashier)
                {
                    ApplicationArea = Basic;
                }
            }
            part(Control35; "PettyCash Payment Line")
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
                            Report.RunModal(Report::"PettyCash Voucher", true, false, PHeader);
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
                var
                    Text001: label 'This request is already pending approval';
                begin
                    rec.CalcFields(Amount);
                    if Rec.Status <> Rec.Status::New then
                        Error(Text001);

                    if Confirm('Send  Approval request?', false) = true then begin
                        SrestepApprovalsCodeUnit.SendPaymentVoucherRequestForApproval(rec."No.", Rec);

                    end;

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

            action(Refresh)
            {

                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Refresh;
                trigger OnAction()
                begin
                    CurrPage.Update();
                end;
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
                        Report.RunModal(Report::"PettyCash Voucher", true, false, PHeader);
                    end;
                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Payment Mode" := Rec."payment mode"::Cash;
        Rec."Payment Type" := Rec."payment type"::"Petty Cash";
    end;

    var
        FundsUser: Record "Funds User Setup";
        FundsManager: Codeunit "Funds Management";
        SrestepApprovalsCodeUnit: Codeunit SurestepApprovalsCodeUnit;
        JTemplate: Code[20];
        JBatch: Code[20];
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Staff Advance","Staff Advance Accounting";
        TableID: Integer;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        PHeader: Record "Payments Header";
        X: page "Accountant Role Center";

    local procedure CheckRequiredItems()
    begin
        // Rec.TestField(Status, Rec.Status::Approved);
        Rec.TestField("Posting Date");
        Rec.TestField(Payee);
        Rec.TestField("Paying Bank Account");
        Rec.TestField("Payment Description");
        Rec.TestField("Global Dimension 1 Code");
        Rec.TestField("Global Dimension 2 Code");
    end;
}

