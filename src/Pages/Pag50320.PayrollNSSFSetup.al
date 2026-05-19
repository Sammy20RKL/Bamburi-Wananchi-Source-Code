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
                    Editable = false;
                }
                field("Earning Tier Limit"; Rec."Earning Tier Limit")
                {
                    ApplicationArea = Basic;
                }
                field("Lower Limit"; Rec."Lower Limit") { }
                field("Upper Limit"; Rec."Upper Limit") { }
                field("% Tier Contribution"; Rec."% Tier Contribution")
                {
                    ApplicationArea = Basic;
                }
                field("Maximum Employee Contribution"; Rec."Maximum Employee Contribution")
                {
                    ApplicationArea = Basic;
                }
                field("Maximum Employer Contribution"; Rec."Maximum Employer Contribution") { }
                field("Maximum Tier Contribution"; Rec."Maximum Tier Contribution") { }
                field("maximum Monthly NSSF Contributions"; Rec."maximum Monthly NSSF Contributions") { }
            }
        }
    }

    actions
    {
    }
}

