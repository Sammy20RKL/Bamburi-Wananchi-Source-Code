#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50320 "Payroll NSSF Setup."
{
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Payroll NSSF Setup.";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Tier Code"; Rec."Tier Code")
                {
                    ApplicationArea = Basic;
                }
                field(Earnings; Rec.Earnings)
                {
                    ApplicationArea = Basic;
                }
                field("Pensionable Earnings"; Rec."Pensionable Earnings")
                {
                    ApplicationArea = Basic;
                }
                field("Tier 1 earnings"; Rec."Tier 1 earnings")
                {
                    ApplicationArea = Basic;
                }
                field("Tier 1 Employee Deduction"; Rec."Tier 1 Employee Deduction")
                {
                    ApplicationArea = Basic;
                }
                field("Tier 1 Employer Contribution"; Rec."Tier 1 Employer Contribution")
                {
                    ApplicationArea = Basic;
                }
                field("Tier 2 earnings"; Rec."Tier 2 earnings")
                {
                    ApplicationArea = Basic;
                }
                field("Tier 2 Employee Deduction"; Rec."Tier 2 Employee Deduction")
                {
                    ApplicationArea = Basic;
                }
                field("Tier 2 Employer Contribution"; Rec."Tier 2 Employer Contribution")
                {
                    ApplicationArea = Basic;
                }
                field("Lower Limit"; Rec."Lower Limit")
                {
                    ApplicationArea = Basic;
                }
                field("Upper Limit"; Rec."Upper Limit")
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

