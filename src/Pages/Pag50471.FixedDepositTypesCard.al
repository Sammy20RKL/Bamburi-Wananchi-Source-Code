#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50471 "Fixed Deposit Types Card"
{
    PageType = Card;
    SourceTable = "Fixed Deposit Type";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(Duration; Rec.Duration)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("No. of Months"; Rec."No. of Months")
                {
                    ApplicationArea = Basic;
                }
            }
            part(Control1102755006; "Fixed Deposit Interest Rates")
            {
                Caption = 'Interest Computation';
                SubPageLink = Code = field(Code);
            }
        }
    }

    actions
    {
    }
}

