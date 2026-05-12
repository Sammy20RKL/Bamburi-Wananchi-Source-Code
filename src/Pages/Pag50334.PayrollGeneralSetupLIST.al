#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50334 "Payroll General Setup LIST."
{
    CardPageID = "Payroll General Setup.";
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Payroll General Setup.";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Tax Relief"; Rec."Tax Relief")
                {
                    ApplicationArea = Basic;
                }
                field("Insurance Relief"; Rec."Insurance Relief")
                {
                    ApplicationArea = Basic;
                }
                field("Max Relief"; Rec."Max Relief")
                {
                    ApplicationArea = Basic;
                }
                field("Mortgage Relief"; Rec."Mortgage Relief")
                {
                    ApplicationArea = Basic;
                }
                field("Max Pension Contribution"; Rec."Max Pension Contribution")
                {
                    ApplicationArea = Basic;
                }
                field("Tax On Excess Pension"; Rec."Tax On Excess Pension")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Market Rate"; Rec."Loan Market Rate")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Corporate Rate"; Rec."Loan Corporate Rate")
                {
                    ApplicationArea = Basic;
                }
                field("Taxable Pay (Normal)"; Rec."Taxable Pay (Normal)")
                {
                    ApplicationArea = Basic;
                }
                field("NHIF Based on"; Rec."NHIF Based on")
                {
                    ApplicationArea = Basic;
                }
                field("NSSF Based on"; Rec."NSSF Based on")
                {
                    ApplicationArea = Basic;
                }
                field("Housing Levy (%)"; Rec."Housing Levy (%)")
                {
                    ApplicationArea = Basic;
                }
                field("Minimum Gross Pay"; Rec."Minimum Gross Pay")
                {
                    ApplicationArea = Basic;//7000
                }
                field("NSSF Percentage %"; Rec."NSSF Percentage %")
                {
                    ApplicationArea = Basic;//6
                }
            }
        }
    }

    actions
    {
    }
}
