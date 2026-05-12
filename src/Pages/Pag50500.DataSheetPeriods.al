#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50500 "Data Sheet Periods"
{
    PageType = List;
    SourceTable = "Data Periods";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Period Code"; Rec."Period Code")
                {
                    ApplicationArea = Basic;
                }
                field("Begin Date"; Rec."Begin Date")
                {
                    ApplicationArea = Basic;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = Basic;
                }
                field(Month; Rec.Month)
                {
                    ApplicationArea = Basic;
                }
                field("Payroll Month"; Rec."Payroll Month")
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

