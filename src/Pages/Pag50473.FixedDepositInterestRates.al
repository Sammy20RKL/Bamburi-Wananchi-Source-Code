#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50473 "Fixed Deposit Interest Rates"
{
    PageType = ListPart;
    SourceTable = "FD Interest Calculation Crite";

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field("Minimum Amount"; Rec."Minimum Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Maximum Amount"; Rec."Maximum Amount")
                {
                    ApplicationArea = Basic;
                }
                field(Duration; Rec.Duration)
                {
                    ApplicationArea = Basic;
                }
                field("Interest Rate"; Rec."Interest Rate")
                {
                    ApplicationArea = Basic;
                }
                field("On Call Interest Rate"; Rec."On Call Interest Rate")
                {
                    ApplicationArea = Basic;
                }
                field("No of Months"; Rec."No of Months")
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

