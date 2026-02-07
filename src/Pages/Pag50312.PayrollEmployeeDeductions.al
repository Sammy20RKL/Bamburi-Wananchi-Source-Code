#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50312 "Payroll Employee Deductions."
{
    PageType = List;
    SourceTable = "Payroll Employee Transactions.";
    SourceTableView = where("Transaction Type" = const(Deduction));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Transaction Code"; Rec."Transaction Code")
                {
                    ApplicationArea = Basic;
                    TableRelation = "Payroll Transaction Code."."Transaction Code" where("Transaction Type" = const(Deduction));
                }
                field("Transaction Name"; Rec."Transaction Name")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Number"; Rec."Loan Number")
                {
                    ApplicationArea = Basic;
                }
                field("Original Deduction Amount"; Rec."Original Deduction Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Interest Charged"; Rec."Interest Charged")
                {
                    ApplicationArea = Basic;
                    Editable = TRUE;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                    Editable = TRUE;//
                }
                field("Amount(LCY)"; Rec."Amount(LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Amtzd Loan Repay Amt"; Rec."Amtzd Loan Repay Amt")
                {
                    ApplicationArea = Basic;
                }
                field(Balance; Rec.Balance)
                {
                    ApplicationArea = Basic;
                }
                field("Balance(LCY)"; Rec."Balance(LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Period Month"; Rec."Period Month")
                {
                    ApplicationArea = Basic;
                }
                field("Period Year"; Rec."Period Year")
                {
                    ApplicationArea = Basic;
                }
                field("Payroll Period"; Rec."Payroll Period")
                {
                    ApplicationArea = Basic;
                }
                field("Original Amount"; Rec."Original Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Interest"; Rec."Outstanding Interest")
                {
                    ApplicationArea = Basic;
                }
                field("Sacco Membership No."; Rec."Sacco Membership No.")
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

