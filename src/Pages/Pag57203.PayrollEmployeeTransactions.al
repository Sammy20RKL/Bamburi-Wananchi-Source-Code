// namespace PolyTechERPSourceCode.PolyTechERPSourceCode;

page 57203 "Payroll Employee Transactions"
{
    ApplicationArea = All;
    Caption = 'Payroll Employee Transactions';
    PageType = List;
    SourceTable = "Payroll Employee Transactions.";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Amount; Rec.Amount)
                {
                }
                field("Amount(LCY)"; Rec."Amount(LCY)")
                {
                }
                field("Amtzd Loan Repay Amt"; Rec."Amtzd Loan Repay Amt")
                {
                }
                field("Amtzd Loan Repay Amt(LCY)"; Rec."Amtzd Loan Repay Amt(LCY)")
                {
                }
                field(Appfee; Rec.Appfee)
                {
                }
                field(Balance; Rec.Balance)
                {
                }
                field("Balance(LCY)"; Rec."Balance(LCY)")
                {
                }
                field("Employer Amount"; Rec."Employer Amount")
                {
                }
                field("Employer Amount(LCY)"; Rec."Employer Amount(LCY)")
                {
                }
                field("Employer Balance"; Rec."Employer Balance")
                {
                }
                field("Employer Balance(LCY)"; Rec."Employer Balance(LCY)")
                {
                }
                field("End Date"; Rec."End Date")
                {
                }
                field("Entry No"; Rec."Entry No")
                {
                }
                field(Grants; Rec.Grants)
                {
                }
                field(InsuranceCharged; Rec.InsuranceCharged)
                {
                }
                field("Interest Charged"; Rec."Interest Charged")
                {
                }
                field("Interest Rate"; Rec."Interest Rate")
                {
                }
                field("IsCoop/LnRep"; Rec."IsCoop/LnRep")
                {
                }
                field("Loan Number"; Rec."Loan Number")
                {
                }
                field("Loan Repayment Amount"; Rec."Loan Repayment Amount")
                {
                }
                field("Member No"; Rec."Member No")
                {
                }
                field(Membership; Rec.Membership)
                {
                }
                field("No of Repayments"; Rec."No of Repayments")
                {
                }
                field("No of Units"; Rec."No of Units")
                {
                }
                field("No."; Rec."No.")
                {
                }
                field("Original Amount"; Rec."Original Amount")
                {
                }
                field("Original Deduction Amount"; Rec."Original Deduction Amount")
                {
                }
                field("Outstanding Interest"; Rec."Outstanding Interest")
                {
                }
                field("Payroll Code"; Rec."Payroll Code")
                {
                }
                field("Payroll Period"; Rec."Payroll Period")
                {
                }
                field("Period Month"; Rec."Period Month")
                {
                }
                field("Period Year"; Rec."Period Year")
                {
                }
                field("Policy No"; Rec."Policy No")
                {
                }
                field("Posting Group"; Rec."Posting Group")
                {
                }
                field("Reference No"; Rec."Reference No")
                {
                }
                field("Sacco Membership No."; Rec."Sacco Membership No.")
                {
                }
                field("Start Date"; Rec."Start Date")
                {
                }
                field("Stop for Next Period"; Rec."Stop for Next Period")
                {
                }
                field(Suspended; Rec.Suspended)
                {
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                }
                field(SystemId; Rec.SystemId)
                {
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                }
                field("Transaction Code"; Rec."Transaction Code")
                {
                }
                field("Transaction Name"; Rec."Transaction Name")
                {
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                }
                field("cummulative month"; Rec."cummulative month")
                {
                }
            }
        }
    }
}
