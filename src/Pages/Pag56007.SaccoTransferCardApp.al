#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 56007 "Sacco Transfer Card(App)"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Sacco Transfers";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(No; Rec.No)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = Basic;
                    Editable = TransactionDateEditable;
                }
                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic;
                    Editable = RemarkEditable;
                }
                field("Source Account Type"; Rec."Source Account Type")
                {
                    ApplicationArea = Basic;
                    Editable = SourceAccountTypeEditable;
                }
                field("Source Account No"; Rec."Source Account No")
                {
                    ApplicationArea = Basic;
                    Editable = SourceAccountNoEditbale;
                }
                field("Source Account Name"; Rec."Source Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Source Transaction Type"; Rec."Source Transaction Type")
                {
                    ApplicationArea = Basic;
                    Editable = SourceAccountTypeEditable;
                }
                field("Source Loan No"; Rec."Source Loan No")
                {
                    ApplicationArea = Basic;
                    Editable = SourceLoanNoEditable;
                }
                field("Schedule Total"; Rec."Schedule Total")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(Approved; Rec.Approved)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            part(Control1102760014; "Sacco Transfer Schedule")
            {
                SubPageLink = "No." = field(No);
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Posting)
            {
                Caption = 'Posting';
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approval;
                    Promoted = true;
                    PromotedCategory = process;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                    end;
                }
                action("Send A&pproval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = process;

                    trigger OnAction()
                    var
                        Approvals: Codeunit SwizzsoftApprovalsCodeUnit;
                    begin
                        if Confirm('Send Approval Request ?', false) = false then begin
                            exit;
                        end else begin
                            // Approvals.SendInternalTransfersRequestForApproval(rec.No, Rec);
                            CurrPage.Close();
                        end;
                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = process;

                    trigger OnAction()
                    var
                        Approvals: Codeunit SwizzsoftApprovalsCodeUnit;
                    begin
                        if Confirm('Cancel Approval Request ?', false) = false then begin
                            exit;
                        end else begin
                            // Approvals.CancelInternalTransfersRequestForApproval(rec.No, Rec);
                            CurrPage.Close();
                        end;
                    end;
                }
                action(Post)
                {
                    ApplicationArea = Basic;
                    Caption = 'Post';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Rec.TestField(Status, Rec.Status::Approved);
                        //............................................................................
                        Rec.CalcFields("Schedule Total");
                        if (Vend.Get(Rec."Source Account No")) and (Rec."Source Account Type" = Rec."source account type"::Fosa) then begin
                            Vend.CalcFields(Vend.Balance);
                            if (Vend.Balance - Rec."Schedule Total") < 0 then begin
                                if UserId in ['POLYTECHSACCO\EWAMBUA'] then
                                    Message('Note that you will be overdrawing the account') else
                                    Error('The Account balance will fall below zero !');
                            end;
                        end;
                        //............................................................................
                        if FundsUSer.Get(UserId) then begin
                            Jtemplate := FundsUSer."Payment Journal Template";
                            Jbatch := FundsUSer."Payment Journal Batch";
                        end else begin
                            Error('Funds user setup setting does not exist');
                        end;
                        if Rec.Posted = true then
                            Error('This Shedule is already posted');
                        Rec.TestField(Remarks);

                        if Confirm('Are you sure you want to transfer schedule?', false) = false then begin
                            exit;
                        end else begin
                            // DELETE ANY LINE ITEM THAT MAY BE PRESENT
                            GenJournalLine.Reset;
                            GenJournalLine.SetRange(GenJournalLine."Journal Template Name", Jtemplate);
                            GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", Jbatch);
                            GenJournalLine.DeleteAll;

                            // UPDATE Source Account
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := Jtemplate;
                            GenJournalLine."Journal Batch Name" := Jbatch;
                            GenJournalLine."Document No." := Rec.No;
                            GenJournalLine."Line No." := GenJournalLine."Line No." + 10000;
                            if Rec."Source Account Type" = Rec."source account type"::Customer then begin
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                                GenJournalLine."Transaction Type" := Rec."Source Transaction Type";
                                GenJournalLine."Account No." := Rec."Source Account No";
                                GenJournalLine."Loan No" := Rec."Source Loan No";
                            end else
                                if Rec."Source Account Type" = Rec."source account type"::MEMBER then begin
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                                    GenJournalLine."Transaction Type" := Rec."Source Transaction Type";
                                    GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                                    GenJournalLine."Shortcut Dimension 2 Code" := BTRANS."Global Dimension 2 Code";
                                    GenJournalLine."Account No." := Rec."Source Account No";
                                    GenJournalLine."Loan No" := Rec."Source Loan No";
                                end else

                                    if Rec."Source Account Type" = Rec."source account type"::Fosa then begin
                                        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                        GenJournalLine."Shortcut Dimension 1 Code" := 'fOSA';
                                        GenJournalLine."Shortcut Dimension 2 Code" := BTRANS."Global Dimension 2 Code";
                                        // GenJournalLine."FOSA Transaction Type" := GenJournalLine."fosa transaction type"::InternalTransfers;
                                        GenJournalLine."Account No." := Rec."Source Account No";
                                    end else
                                        if Rec."Source Account Type" = Rec."source account type"::"G/L ACCOUNT" then begin
                                            GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                                            GenJournalLine."Transaction Type" := Rec."Source Transaction Type";
                                            GenJournalLine."Shortcut Dimension 2 Code" := '01';
                                            GenJournalLine."Account No." := Rec."Source Account No";
                                        end else
                                            if Rec."Source Account Type" = Rec."source account type"::Bank then begin
                                                GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
                                                GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                                                GenJournalLine."Shortcut Dimension 2 Code" := BTRANS."Global Dimension 2 Code";
                                                GenJournalLine."Account No." := Rec."Source Account No";
                                            end;
                            GenJournalLine."Posting Date" := Today;
                            GenJournalLine.Description := Rec.Remarks + ' ' + Rec."Source Account Name";
                            Rec.CalcFields("Schedule Total");
                            GenJournalLine.Amount := Rec."Schedule Total";
                            //GenJournalLine.VALIDATE(GenJournalLine.Amount);
                            GenJournalLine.Insert;




                            BSched.Reset;
                            BSched.SetRange(BSched."No.", Rec.No);
                            if BSched.Find('-') then begin
                                repeat

                                    GenJournalLine.Init;

                                    GenJournalLine."Journal Template Name" := Jtemplate;
                                    GenJournalLine."Journal Batch Name" := Jbatch;
                                    GenJournalLine."Document No." := Rec.No;
                                    GenJournalLine."Line No." := GenJournalLine."Line No." + 10000;

                                    if BSched."Destination Account Type" = BSched."destination account type"::MEMBER then begin
                                        GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                                        GenJournalLine."Transaction Type" := BSched."Destination Type";
                                        GenJournalLine."Account No." := BSched."Destination Account No.";
                                        GenJournalLine."Shortcut Dimension 2 Code" := BSched."Global Dimension 2 Code";
                                    end else

                                        if BSched."Destination Account Type" = BSched."destination account type"::FOSA then begin
                                            GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                            GenJournalLine."Transaction Type" := BSched."Destination Type";
                                            // GenJournalLine."FOSA Transaction Type" := GenJournalLine."fosa transaction type"::InternalTransfers;
                                            GenJournalLine."Account No." := BSched."Destination Account No.";
                                            GenJournalLine."Shortcut Dimension 2 Code" := BSched."Global Dimension 2 Code";
                                        end else
                                            if BSched."Destination Account Type" = BSched."destination account type"::"G/L ACCOUNT" then begin
                                                GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                                                GenJournalLine."Account No." := BSched."Destination Account No.";
                                                GenJournalLine."Shortcut Dimension 2 Code" := '01';

                                            end else
                                                if BSched."Destination Account Type" = BSched."destination account type"::BANK then begin
                                                    GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
                                                    GenJournalLine."Account No." := BSched."Destination Account No.";
                                                    GenJournalLine."Shortcut Dimension 2 Code" := BSched."Global Dimension 2 Code";
                                                end;
                                    GenJournalLine."Loan No" := BSched."Destination Loan";
                                    GenJournalLine.Validate(GenJournalLine."Loan No");
                                    //GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                                    GenJournalLine."Posting Date" := Today;
                                    GenJournalLine.Description := Rec.Remarks;
                                    GenJournalLine.Amount := -BSched.Amount;
                                    //GenJournalLine.VALIDATE(GenJournalLine.Amount);
                                    GenJournalLine.Insert;
                                //End Audit Entries
                                until BSched.Next = 0;
                            end;
                            //Post
                            GenJournalLine.Reset;
                            GenJournalLine.SetRange("Journal Template Name", Jtemplate);
                            GenJournalLine.SetRange("Journal Batch Name", Jbatch);
                            if GenJournalLine.Find('-') then begin
                                Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
                            end;
                            //Post
                            Rec.Posted := true;
                            Rec.Modify;
                        end;
                    end;
                }
                action(Print)
                {
                    ApplicationArea = Basic;
                    Caption = 'Print';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        BTRANS.Reset;
                        BTRANS.SetRange(BTRANS.No, Rec.No);
                        if BTRANS.Find('-') then begin
                            Report.Run(51516902, true, true, BTRANS);
                        end;
                    end;
                }
                action("Page Vendor Statement")
                {
                    ApplicationArea = Basic;
                    Caption = 'Statement';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        Vend.Reset;
                        Vend.SetRange(Vend."No.", Rec."Source Account No");
                        if Vend.Find('-') then
                            Report.Run(51516890, true, false, Vend);

                    end;
                }
            }
            action("Members Statistics")
            {
                ApplicationArea = Basic;
                Image = Statistics;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Members Statistics";
                RunPageLink = "No." = field("Source Account No");
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        AddRecordRestriction();
    end;

    trigger OnAfterGetRecord()
    begin
        AddRecordRestriction();
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        Error('Not Allowed!');
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Source Account Type" := Rec."source account type"::Fosa;
    end;

    trigger OnOpenPage()
    begin
        Rec."Source Account Type" := Rec."source account type"::Fosa;
        AddRecordRestriction();
    end;

    var
        users: Record User;
        GenJournalLine: Record "Gen. Journal Line";
        DefaultBatch: Record "Gen. Journal Batch";
        BSched: Record "Sacco Transfers Schedule";
        BTRANS: Record "Sacco Transfers";
        DActivity: Code[20];
        DBranch: Code[20];
        UsersID: Record User;
        FundsUSer: Record "Funds User Setup";
        Jtemplate: Code[10];
        Jbatch: Code[10];
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers;
        SourceAccountNoEditbale: Boolean;
        SourceAccountNameEditable: Boolean;
        SourceAccountTypeEditable: Boolean;
        SourceTransactionType: Boolean;
        SourceLoanNoEditable: Boolean;
        RemarkEditable: Boolean;
        TransactionDateEditable: Boolean;
        Vend: Record Vendor;
        // Audit: Record "Audit Entries";
        EntryNos: Integer;

    local procedure AddRecordRestriction()
    begin
        if Rec.Status = Rec.Status::Open then begin
            SourceAccountNoEditbale := true;
            SourceAccountNameEditable := true;
            SourceAccountTypeEditable := true;
            SourceLoanNoEditable := true;
            SourceTransactionType := true;
            TransactionDateEditable := true;
            RemarkEditable := true
        end else
            if Rec.Status = Rec.Status::pending then begin
                SourceAccountNoEditbale := false;
                SourceAccountNameEditable := false;
                SourceAccountTypeEditable := false;
                SourceLoanNoEditable := false;
                SourceTransactionType := false;
                TransactionDateEditable := false;
                RemarkEditable := false
            end else
                if Rec.Status = Rec.Status::Approved then begin
                    SourceAccountNoEditbale := false;
                    SourceAccountNameEditable := false;
                    SourceAccountTypeEditable := false;
                    SourceLoanNoEditable := false;
                    SourceTransactionType := false;
                    TransactionDateEditable := false;
                    RemarkEditable := false;
                end;
    end;
}

