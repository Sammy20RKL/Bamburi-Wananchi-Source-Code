#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50319 "Payroll NHIF Setup."
{
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Payroll NHIF Setup.";
    SourceTableView = sorting("Lower Limit")
                      order(ascending);

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
                field("NHIF Tier"; Rec."NHIF Tier")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
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
