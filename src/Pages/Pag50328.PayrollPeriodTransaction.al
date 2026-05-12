#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50328 "Payroll Period Transaction."
{
    // DeleteAllowed = true;
    // Editable = false;
    InsertAllowed = false;
    // ModifyAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "prPeriod Transactions.";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Transaction Code"; Rec."Transaction Code")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Code"; Rec."Employee Code")
                {
                    ApplicationArea = Basic;
                }
                field("Group Text"; Rec."Group Text")
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
                field("Group Order"; Rec."Group Order")
                {
                    ApplicationArea = Basic;
                }
                field("Sub Group Order"; Rec."Sub Group Order")
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
                field("Period Filter"; Rec."Period Filter")
                {
                    ApplicationArea = Basic;
                }
                field("Payroll Period"; Rec."Payroll Period")
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
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = Basic;
                }
                field(Lumpsumitems; Rec.Lumpsumitems)
                {
                    ApplicationArea = Basic;
                }
                field(TravelAllowance; Rec.TravelAllowance)
                {
                    ApplicationArea = Basic;
                }
                field("GL Account"; Rec."GL Account")
                {
                    ApplicationArea = Basic;
                }
                field("Company Deduction"; Rec."Company Deduction")
                {
                    ApplicationArea = Basic;
                }
                field("Emp Amount"; Rec."Emp Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Emp Balance"; Rec."Emp Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Journal Account Code"; Rec."Journal Account Code")
                {
                    ApplicationArea = Basic;
                }
                field("Journal Account Type"; Rec."Journal Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Post As"; Rec."Post As")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Number"; Rec."Loan Number")
                {
                    ApplicationArea = Basic;
                }
                field("coop parameters"; Rec."coop parameters")
                {
                    ApplicationArea = Basic;
                }
                field("Payroll Code"; Rec."Payroll Code")
                {
                    ApplicationArea = Basic;
                }
                field("Payment Mode"; Rec."Payment Mode")
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

