#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50313 "Payroll Employee Earnings."
{
    PageType = List;
    SourceTable = "Payroll Employee Transactions.";
    SourceTableView = where("Transaction Type" = const(Income));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Transaction Code"; Rec."Transaction Code")
                {
                    ApplicationArea = Basic;
                    TableRelation = "Payroll Transaction Code."."Transaction Code" where("Transaction Type" = const(Income));
                }
                field("Transaction Name"; Rec."Transaction Name")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Type"; Rec."Transaction Type")
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
            }
        }
    }

    actions
    {
    }
}

