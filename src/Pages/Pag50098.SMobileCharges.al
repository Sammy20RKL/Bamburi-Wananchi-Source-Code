#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50098 "S-Mobile Charges"
{
    PageType = List;
    SourceTable = "S-Mobile Charges";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = Basic;
                }
                field(Source; Rec.Source)
                {
                    ApplicationArea = Basic;
                }
                field(Tiered; Rec.Tiered)
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

