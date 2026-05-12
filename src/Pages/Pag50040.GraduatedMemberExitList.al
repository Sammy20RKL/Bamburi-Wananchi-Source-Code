#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50040 "Graduated Member Exit  List"
{
    CardPageID = "Graduated Member Exit Card";
    PageType = List;
    SourceTable = "MWithdrawal Graduated Charges";

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
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Use Percentage"; Rec."Use Percentage")
                {
                    ApplicationArea = Basic;
                }
                field("Percentage of Amount"; Rec."Percentage of Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Charge Account"; Rec."Charge Account")
                {
                    ApplicationArea = Basic;
                }
                field("Notice Status"; Rec."Notice Status")
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

