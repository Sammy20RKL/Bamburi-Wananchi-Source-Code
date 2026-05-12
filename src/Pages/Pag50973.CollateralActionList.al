#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50973 "Collateral Action List"
{
    CardPageID = "Collateral Action Card";
    PageType = List;
    SourceTable = "Loan Collateral Register";

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
                field("Registered Owner"; Rec."Registered Owner")
                {
                    ApplicationArea = Basic;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic;
                }
                field("Collateral Type"; Rec."Collateral Type")
                {
                    ApplicationArea = Basic;
                }
                field("Asset Value"; Rec."Asset Value")
                {
                    ApplicationArea = Basic;
                }
                field("Depreciation Completion Date"; Rec."Depreciation Completion Date")
                {
                    ApplicationArea = Basic;
                }
                field("Asset Depreciation Amount"; Rec."Asset Depreciation Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Asset Value @Loan Completion"; Rec."Asset Value @Loan Completion")
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

