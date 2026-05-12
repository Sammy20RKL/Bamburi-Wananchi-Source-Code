#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50637 "Graduated Loan Interest"
{
    PageType = List;
    SourceTable = "Graduated Loan Int.";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Loan Code"; Rec."Loan Code")
                {
                    ApplicationArea = Basic;
                }
                field("Period From"; Rec."Period From")
                {
                    ApplicationArea = Basic;
                }
                field("Period To"; Rec."Period To")
                {
                    ApplicationArea = Basic;
                }
                field("Min Amount"; Rec."Min Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Max Amount"; Rec."Max Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Interest Rate"; Rec."Interest Rate")
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

