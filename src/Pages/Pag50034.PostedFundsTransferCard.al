#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50034 "Posted Funds Transfer Card"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Funds Transfer Header";

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
                field("Pay Mode"; Rec."Pay Mode")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field("Paying Bank Account"; Rec."Paying Bank Account")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Paying Bank Name"; Rec."Paying Bank Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Bank Balance"; Rec."Bank Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Account No."; Rec."Bank Account No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Amount to Transfer"; Rec."Amount to Transfer")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Amount to Transfer(LCY)"; Rec."Amount to Transfer(LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Total Line Amount"; Rec."Total Line Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Total Line Amount(LCY)"; Rec."Total Line Amount(LCY)")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Cheque/Doc. No"; Rec."Cheque/Doc. No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic;
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = Basic;
                }
                field("Time Created"; Rec."Time Created")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
            }
            part(Control24; "Funds Transfer Lines")
            {
                SubPageLink = "Document No" = field("No.");
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Post Transfer")
            {
                ApplicationArea = Basic;
                Image = Payment;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    CheckRequiredItems;
                    Rec.CalcFields("Total Line Amount");
                    Rec.TestField("Amount to Transfer", Rec."Total Line Amount");

                    if FundsUser.Get(UserId) then begin
                        FundsUser.TestField(FundsUser."FundsTransfer Template Name");
                        FundsUser.TestField(FundsUser."FundsTransfer Batch Name");
                        JTemplate := FundsUser."FundsTransfer Template Name";
                        JBatch := FundsUser."FundsTransfer Batch Name";
                        //Post Transfer
                        FundsManager.PostFundsTransfer(Rec, JTemplate, JBatch);
                    end else begin
                        Error('User Account Not Setup, Contact the System Administrator');
                    end
                end;
            }
            action(Print)
            {
                ApplicationArea = Basic;
                Caption = 'Reprint';
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    /*FHeader.RESET;
                    FHeader.SETRANGE(FHeader."No.","No.");
                    IF FHeader.FINDFIRST THEN BEGIN
                      REPORT.RUNMODAL(REPORT::"Funds Transfer Voucher",TRUE,FALSE,FHeader);
                    END;
                    */

                    FHeader.Reset;
                    FHeader.SetRange(FHeader."No.", Rec."No.");
                    if FHeader.FindFirst then
                        Report.Run(51516011, true, true, FHeader);

                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //"Pay Mode":="Pay Mode"::Cash;
        Rec."Transfer Type" := Rec."transfer type"::InterBank;
    end;

    var
        FundsManager: Codeunit "Funds Management";
        FundsUser: Record "Funds User Setup";
        JTemplate: Code[50];
        JBatch: Code[50];
        FHeader: Record 51056;
        FLine: Record 51005;

    local procedure CheckRequiredItems()
    begin
        Rec.TestField("Posting Date");
        Rec.TestField("Paying Bank Account");
        Rec.TestField("Amount to Transfer");
        if Rec."Pay Mode" = Rec."pay mode"::Cheque then
            Rec.TestField("Cheque/Doc. No");
        Rec.TestField(Description);
        //TESTFIELD("Transfer To");

        FLine.Reset;
        FLine.SetRange(FLine."Document No", Rec."No.");
        FLine.SetFilter(FLine."Amount to Receive", '<>%1', 0);
        if FLine.FindSet then begin
            repeat
                FLine.TestField(FLine."Receiving Bank Account");
            until FLine.Next = 0;
        end;
    end;
}

