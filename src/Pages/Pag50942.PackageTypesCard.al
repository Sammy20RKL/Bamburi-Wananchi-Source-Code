#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50942 "Package Types Card"
{
    PageType = Card;
    SourceTable = "Package Types";

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
                field("Package Description"; Rec."Package Description")
                {
                    ApplicationArea = Basic;
                }
                field("Package Charge"; Rec."Package Charge")
                {
                    ApplicationArea = Basic;
                }
                field("Package Charge Account"; Rec."Package Charge Account")
                {
                    ApplicationArea = Basic;
                }
                field("Package Retrieval Fee"; Rec."Package Retrieval Fee")
                {
                    ApplicationArea = Basic;
                }
                field("Package Retrieval Fee Account"; Rec."Package Retrieval Fee Account")
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

