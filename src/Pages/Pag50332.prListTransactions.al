#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50332 "prList Transactions"
{
    PageType = List;
    SourceTable = "prEmployee Transactions";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee Code"; Rec."Employee Code")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Code"; Rec."Transaction Code")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Name"; Rec."Transaction Name")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field(Balance; Rec.Balance)
                {
                    ApplicationArea = Basic;
                }
                field("Original Amount"; Rec."Original Amount")
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
                field("#of Repayments"; Rec."#of Repayments")
                {
                    ApplicationArea = Basic;
                }
                field(Membership; Rec.Membership)
                {
                    ApplicationArea = Basic;
                }
                field("Reference No"; Rec."Reference No")
                {
                    ApplicationArea = Basic;
                }
                field(integera; Rec.integera)
                {
                    ApplicationArea = Basic;
                }
                field("Employer Amount"; Rec."Employer Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Employer Balance"; Rec."Employer Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Stop for Next Period"; Rec."Stop for Next Period")
                {
                    ApplicationArea = Basic;
                }
                field("Amortized Loan Total Repay Amt"; Rec."Amortized Loan Total Repay Amt")
                {
                    ApplicationArea = Basic;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = Basic;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Number"; Rec."Loan Number")
                {
                    ApplicationArea = Basic;
                }
                field("Payroll Code"; Rec."Payroll Code")
                {
                    ApplicationArea = Basic;
                }
                field("No of Units"; Rec."No of Units")
                {
                    ApplicationArea = Basic;
                }
                field(Suspended; Rec.Suspended)
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Account No"; Rec."Loan Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Emp Count"; Rec."Emp Count")
                {
                    ApplicationArea = Basic;
                }
                field("PV Filter"; Rec."PV Filter")
                {
                    ApplicationArea = Basic;
                }
                field("Emp Status"; Rec."Emp Status")
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

