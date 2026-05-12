#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50318 "Payroll PAYE Setup."
{
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Payroll PAYE Setup.";

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
                field("PAYE Tier"; Rec."PAYE Tier")
                {
                    ApplicationArea = Basic;
                }
                field(Rate; Rec.Rate)
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

