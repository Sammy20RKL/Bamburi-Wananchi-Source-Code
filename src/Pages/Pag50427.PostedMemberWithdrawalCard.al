#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50427 "Posted Member Withdrawal Card"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption';
    SourceTable = "Membership Exit";
    SourceTableView = where(Posted = filter(true));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                    Editable = MNoEditable;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Closing Date"; Rec."Closing Date")
                {
                    ApplicationArea = Basic;
                    Editable = ClosingDateEditable;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = Basic;
                }
                field("Date Approved"; Rec."Date Approved")
                {
                    ApplicationArea = Basic;
                }
                field("Expected Posting Date"; Rec."Expected Posting Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Closure Type"; Rec."Closure Type")
                {
                    ApplicationArea = Basic;
                    Editable = ClosureTypeEditable;
                }
                field("Sell Share Capital"; Rec."Sell Share Capital")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Total Loan"; Rec."Total Loan")
                {
                    ApplicationArea = Basic;
                    Caption = 'Total Loan BOSA';
                    Editable = false;
                }
                field("Total Interest"; Rec."Total Interest")
                {
                    ApplicationArea = Basic;
                    Caption = 'Total Interest Due BOSA';
                    Editable = false;
                }
                field("Total Loans FOSA"; Rec."Total Loans FOSA")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Total Oustanding Int FOSA"; Rec."Total Oustanding Int FOSA")
                {
                    ApplicationArea = Basic;
                    Caption = 'Total Interest Due FOSA';
                    Editable = false;
                }
                field("Member Deposits"; Rec."Member Deposits")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Shares Capital"; Rec."Share Capital")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Refundable Share Capital"; Rec."Refundable Share Capital")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Share Capital to Sell"; Rec."Share Capital to Sell")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Risk Fund"; Rec."Risk Fund")
                {
                    ApplicationArea = Basic;
                    Caption = 'Net Refund';
                    Editable = false;
                    Visible = false;
                }
                field("Risk Fund Arrears"; Rec."Risk Fund Arrears")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Risk Beneficiary"; Rec."Risk Beneficiary")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Mode Of Disbursement"; Rec."Mode Of Disbursement")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Paying Bank"; Rec."Paying Bank")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Cheque No."; Rec."Cheque No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("FOSA Account No."; Rec."FOSA Account No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Payee; Rec.Payee)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Function")
            {
                Caption = 'Function';
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approval;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        DocumentType := Documenttype::"Member Closure";
                        ApprovalEntries.SetRecordFilters(Database::"HR Leave Register", DocumentType, Rec."No.");
                        ApprovalEntries.Run;
                    end;
                }
                action("Print Cheque")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        /*
                        ClosureR.RESET;
                        ClosureR.SETRANGE(ClosureR."Member No.","Member No.");
                        IF ClosureR.FIND('-') THEN
                        REPORT.RUN(,TRUE,FALSE,ClosureR);
                        */

                    end;
                }
                action("Account closure Slip")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        cust.Reset;
                        cust.SetRange(cust."No.", Rec."Member No.");
                        if cust.Find('-') then
                            Report.Run(51516474, true, false, cust);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateControl();
    end;

    var
        Closure: Integer;
        Text001: label 'Not Approved';
        cust: Record Customer;
        UBFRefund: Decimal;
        Generalsetup: Record "Sacco General Set-Up";
        Totalavailable: Decimal;
        UnpaidDividends: Decimal;
        TotalOustanding: Decimal;
        Vend: Record Vendor;
        value2: Decimal;
        Gnljnline: Record "Gen. Journal Line";
        Totalrecovered: Decimal;
        Advice: Boolean;
        TotalDefaulterR: Decimal;
        AvailableShares: Decimal;
        Loans: Record "Loans Register";
        Value1: Decimal;
        Interest: Decimal;
        LineN: Integer;
        LRepayment: Decimal;
        Vendno: Code[20];
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batches,"Payment Voucher","Petty Cash",Requisition,Loan,Interbank,Imprest,Checkoff;
        MNoEditable: Boolean;
        ClosingDateEditable: Boolean;
        ClosureTypeEditable: Boolean;
        TotalFOSALoan: Decimal;
        TotalInsuarance: Decimal;
        DActivity: Code[30];
        DBranch: Code[30];
        LineNo: Integer;
        GenJournalLine: Record "Gen. Journal Line";
        "Remaining Amount": Decimal;
        LoansR: Record "Loans Register";
        "AMOUNTTO BE RECOVERED": Decimal;
        PrincipInt: Decimal;
        TotalLoansOut: Decimal;
        ClosureR: Record "Membership Exit";


    procedure UpdateControl()
    begin
        if Rec.Status = Rec.Status::Open then begin
            MNoEditable := true;
            ClosingDateEditable := false;
            ClosureTypeEditable := true;
        end;

        if Rec.Status = Rec.Status::Pending then begin
            MNoEditable := false;
            ClosingDateEditable := false;
            ClosureTypeEditable := false
        end;

        if Rec.Status = Rec.Status::Rejected then begin
            MNoEditable := false;
            ClosingDateEditable := false;
            ClosureTypeEditable := false;
        end;

        if Rec.Status = Rec.Status::Approved then begin
            MNoEditable := false;
            ClosingDateEditable := true;
            ClosureTypeEditable := false;
        end;
    end;
}

