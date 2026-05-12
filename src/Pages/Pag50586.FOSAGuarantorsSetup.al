#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50586 "FOSA Guarantors Setup"
{
    PageType = List;
    SourceTable = "FOSA Guarantors Setup";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Minimum Amount"; Rec."Minimum Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Maximum Amount"; Rec."Maximum Amount")
                {
                    ApplicationArea = Basic;
                }
                field("No of Guarantors"; Rec."No of Guarantors")
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

