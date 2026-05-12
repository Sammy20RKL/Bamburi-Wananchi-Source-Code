#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50322 "Payroll General Setup."
{
    PageType = Card;
    SourceTable = "Payroll General Setup.";

    layout
    {
        area(content)
        {
            group(Relief)
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
            }
            group(NHIF)
            {
                field("NHIF Based on"; Rec."NHIF Based on")
                {
                    ApplicationArea = Basic;
                }
                field("SHIF deduction %"; Rec."SHIF deduction %")
                {
                    ApplicationArea = basic;
                }
            }
            group(NSSF)
            {
                field("NSSF Employee"; Rec."NSSF Employee")
                {
                    ApplicationArea = Basic;
                }
                field("NSSF Employer Factor"; Rec."NSSF Employer Factor")
                {
                    ApplicationArea = Basic;
                }
                field("NSSF Based on"; Rec."NSSF Based on")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Pension)
            {
                field("Max Pension Contribution"; Rec."Max Pension Contribution")
                {
                    ApplicationArea = Basic;
                }
                field("Tax On Excess Pension"; Rec."Tax On Excess Pension")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Staff Loan")
            {
                field("Loan Market Rate"; Rec."Loan Market Rate")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Corporate Rate"; Rec."Loan Corporate Rate")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Mortgage)
            {
                field("Housing Levy (%)"; Rec."Housing Levy (%)")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Owner Occupier Interest")
            {
                field("OOI Deduction"; Rec."OOI Deduction")
                {
                    ApplicationArea = Basic;
                }
                field("OOI December"; Rec."OOI December")
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


