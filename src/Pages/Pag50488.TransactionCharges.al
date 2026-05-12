#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50488 "Transaction Charges"
{
    PageType = ListPart;
    SourceTable = "Transaction Charges";

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
                field("Charge Code"; Rec."Charge Code")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Code"; Rec."Transaction Code")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Charge Amount"; Rec."Charge Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Percentage of Amount"; Rec."Percentage of Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Use Percentage"; Rec."Use Percentage")
                {
                    ApplicationArea = Basic;
                }
                field("G/L Account"; Rec."G/L Account")
                {
                    ApplicationArea = Basic;
                }
                field("Minimum Amount"; Rec."Minimum Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Maximum Amount"; Rec."Maximum Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Due Amount"; Rec."Due Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Due to Account"; Rec."Due to Account")
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

