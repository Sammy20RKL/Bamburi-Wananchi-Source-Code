#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50051 "Funds User Setup"
{
    ApplicationArea = Basic;
    PageType = List;
    SourceTable = "Funds User Setup";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(UserID; Rec.UserID)
                {
                    ApplicationArea = Basic;
                }
                field("Receipt Journal Template"; Rec."Receipt Journal Template")
                {
                    ApplicationArea = Basic;
                }
                field("Receipt Journal Batch"; Rec."Receipt Journal Batch")
                {
                    ApplicationArea = Basic;
                }
                field("Payment Journal Template"; Rec."Payment Journal Template")
                {
                    ApplicationArea = Basic;
                }
                field("Payment Journal Batch"; Rec."Payment Journal Batch")
                {
                    ApplicationArea = Basic;
                }
                field("Petty Cash Template"; Rec."Petty Cash Template")
                {
                    ApplicationArea = Basic;
                }
                field("Petty Cash Batch"; Rec."Petty Cash Batch")
                {
                    ApplicationArea = Basic;
                }
                field("FundsTransfer Template Name"; Rec."FundsTransfer Template Name")
                {
                    ApplicationArea = Basic;
                }
                field("FundsTransfer Batch Name"; Rec."FundsTransfer Batch Name")
                {
                    ApplicationArea = Basic;
                }
                field("Default Receipts Bank"; Rec."Default Receipts Bank")
                {
                    ApplicationArea = Basic;
                }
                field("Default Payment Bank"; Rec."Default Payment Bank")
                {
                    ApplicationArea = Basic;
                }
                field("Default Petty Cash Bank"; Rec."Default Petty Cash Bank")
                {
                    ApplicationArea = Basic;
                }
                field("Max. Cash Collection"; Rec."Max. Cash Collection")
                {
                    ApplicationArea = Basic;
                }
                field("Max. Cheque Collection"; Rec."Max. Cheque Collection")
                {
                    ApplicationArea = Basic;
                }
                field("Max. Deposit Slip Collection"; Rec."Max. Deposit Slip Collection")
                {
                    ApplicationArea = Basic;
                }
                field("Supervisor ID"; Rec."Supervisor ID")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Pay In Journal Template"; Rec."Bank Pay In Journal Template")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Pay In Journal Batch"; Rec."Bank Pay In Journal Batch")
                {
                    ApplicationArea = Basic;
                }
                field("Imprest Template"; Rec."Imprest Template")
                {
                    ApplicationArea = Basic;
                }
                field("Imprest  Batch"; Rec."Imprest  Batch")
                {
                    ApplicationArea = Basic;
                }
                field("Claim Template"; Rec."Claim Template")
                {
                    ApplicationArea = Basic;
                }
                field("Claim  Batch"; Rec."Claim  Batch")
                {
                    ApplicationArea = Basic;
                }
                field("Advance Template"; Rec."Advance Template")
                {
                    ApplicationArea = Basic;
                }
                field("Advance  Batch"; Rec."Advance  Batch")
                {
                    ApplicationArea = Basic;
                }
                field("Advance Surr Template"; Rec."Advance Surr Template")
                {
                    ApplicationArea = Basic;
                }
                field("Advance Surr Batch"; Rec."Advance Surr Batch")
                {
                    ApplicationArea = Basic;
                }
                field("Dim Change Journal Template"; Rec."Dim Change Journal Template")
                {
                    ApplicationArea = Basic;
                }
                field("Dim Change Journal Batch"; Rec."Dim Change Journal Batch")
                {
                    ApplicationArea = Basic;
                }
                field("Journal Voucher Template"; Rec."Journal Voucher Template")
                {
                    ApplicationArea = Basic;
                }
                field("Journal Voucher Batch"; Rec."Journal Voucher Batch")
                {
                    ApplicationArea = Basic;
                }
                field("Payroll Template"; Rec."Payroll Template")
                {
                    ApplicationArea = Basic;
                }
                field("Payroll Batch"; Rec."Payroll Batch")
                {
                    ApplicationArea = Basic;
                }
                field("Checkoff Template"; Rec."Checkoff Template")
                {
                    ApplicationArea = Basic;
                }
                field("Checkoff Batch"; Rec."Checkoff Batch")
                {
                    ApplicationArea = Basic;
                }
                field("Salaries Template"; Rec."Salaries Template")
                {
                    ApplicationArea = Basic;
                }
                field("Salaries Batch"; Rec."Salaries Batch")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}
