#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 56181 "Receipt Header Card"
{
    DeleteAllowed = true;
    PageType = Card;
    SourceTable = "Receipt Header";

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
                field("Document Type"; Rec."Document Type")
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
                    Visible = false;
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Received From"; Rec."Received From")
                {
                    ApplicationArea = Basic;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic;
                }
                field("Total Amount(LCY)"; Rec."Total Amount(LCY)")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
            }
            part(Control23; "Receipt Line")
            {
                SubPageLink = "Document No" = field("No.");
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Post Receipt")
            {
                ApplicationArea = Basic;
                Caption = 'Post Receipt';
                Image = PostPrint;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.TestField("Global Dimension 1 Code");
                    Rec.TestField("Global Dimension 2 Code");
                    Rec.TestField("Received From");
                    Rec.TestField(Description);

                    if Rec.Posted then
                        Error('This receipt is already posted');

                    //TESTFIELD(Status,Status::Approved);
                    Rec.CalcFields("Total Amount", "Total Amount(LCY)");

                    ok := Confirm('Post Receipt No:' + Format(Rec."No.") + '. The account will be credited with KES:' + Format(Rec."Total Amount(LCY)") + ' Continue?');
                    if ok then begin
                        DocNo := Rec."No.";
                        if FundsUser.Get(UserId) then begin
                            FundsUser.TestField(FundsUser."Receipt Journal Template");
                            FundsUser.TestField(FundsUser."Receipt Journal Batch");
                            JTemplate := FundsUser."Receipt Journal Template";
                            JBatch := FundsUser."Receipt Journal Batch";
                            PostedEntry := FundsManager.PostPropertyReceipt(Rec, JTemplate, JBatch, Rec."Property Code", Rec."No.", '', Rec."Received From", Rec."Total Amount(LCY)");
                            if PostedEntry then begin
                                ReceiptHeader.Reset;
                                ReceiptHeader.SetRange(ReceiptHeader."No.", DocNo);
                                if ReceiptHeader.FindFirst then begin
                                    Report.RunModal(Report::"Receipt Header", true, false, ReceiptHeader);
                                end;
                            end;
                        end else begin
                            Error('User Account Not Setup');
                        end;
                    end;
                end;
            }
            action(Approvals)
            {
                ApplicationArea = Basic;
                Visible = false;
            }
            action(Print)
            {
                ApplicationArea = Basic;
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    ReceiptHeader.Reset;
                    ReceiptHeader.SetRange(ReceiptHeader."No.", Rec."No.");
                    if ReceiptHeader.FindFirst then begin
                        Report.RunModal(Report::"Receipt Header", true, false, ReceiptHeader);

                    end;
                end;
            }
        }
    }

    var
        FundsManager: Codeunit "Funds Management";
        JTemplate: Code[20];
        JBatch: Code[20];
        FundsUser: Record "Funds User Setup";
        ok: Boolean;
        ReceiptHeader: Record "Receipt Header";
        PostedEntry: Boolean;
        DocNo: Code[20];
}

