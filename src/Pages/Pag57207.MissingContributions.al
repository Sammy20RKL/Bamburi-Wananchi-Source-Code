namespace PolyTechERPSourceCode.PolyTechERPSourceCode;

page 57207 "Missing Contributions"
{
    ApplicationArea = All;
    Caption = 'Missing Contributions';
    // PageType = List;
    PageType = ListPart;
    SourceTable = "Missing Contributions";
    UsageCategory = Administration;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Loan Number"; Rec."Loan Number")
                {
                }
                field("Member Number"; Rec."Member Number")
                {
                }
                field("Member Name"; Rec."Member Name")
                {
                }
                field("Month Missing"; Rec."Month Missing")
                {
                }
                field(AmountPosted; Rec.AmountPosted)
                {
                }
                field(Description; Rec.Description)
                {
                }
            }
        }
    }
}
