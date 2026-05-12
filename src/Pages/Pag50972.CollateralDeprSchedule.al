#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50972 "Collateral Depr. Schedule"
{
    PageType = List;
    SourceTable = 51921;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Description"; Rec."Transaction Description")
                {
                    ApplicationArea = Basic;
                }
                field("Collateral Value"; Rec."Collateral Value")
                {
                    ApplicationArea = Basic;
                }
                field("Depreciation Amount"; Rec."Depreciation Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Collateral NBV"; Rec."Collateral NBV")
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

