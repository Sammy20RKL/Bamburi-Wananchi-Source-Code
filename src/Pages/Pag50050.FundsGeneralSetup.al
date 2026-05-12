#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50050 "Funds General Setup"
{
    ApplicationArea = Basic;
    DeleteAllowed = false;
    InsertAllowed = false;
    Editable = true;
    SourceTable = "Funds General Setup";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Cash Account"; Rec."Cash Account")
                {
                    ApplicationArea = Basic;
                }
                field("PettyCash Account"; Rec."PettyCash Account")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque Charge"; Rec."Cheque Charge")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque Charge Account"; Rec."Cheque Charge Account")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Numbering)
            {
                field("Payment Voucher Nos"; Rec."Payment Voucher Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Cash Voucher Nos"; Rec."Cash Voucher Nos")
                {
                    ApplicationArea = Basic;
                }
                field("PettyCash Nos"; Rec."PettyCash Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Mobile Payment Nos"; Rec."Mobile Payment Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Receipt Nos"; Rec."Receipt Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Funds Withdrawal Nos"; Rec."Funds Withdrawal Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Funds Transfer Nos"; Rec."Funds Transfer Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Imprest Nos"; Rec."Imprest Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Imprest Surrender Nos"; Rec."Imprest Surrender Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Claim Nos"; Rec."Claim Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Travel Advance Nos"; Rec."Travel Advance Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Travel Surrender Nos"; Rec."Travel Surrender Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Cashier Closure Nos"; Rec."Cashier Closure Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Allowance Doc Nos"; Rec."Allowance Doc Nos")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
    trigger OnInit()

    begin
        if Rec.IsEmpty() then
            Rec.Insert();
    end;
}

