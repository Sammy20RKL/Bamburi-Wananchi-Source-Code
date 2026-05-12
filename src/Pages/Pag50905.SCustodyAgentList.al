#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50905 "SCustody Agent List"
{
    // CardPageID = "SCustody Agent Card";
    Editable = false;
    PageType = List;
    SourceTable = 51905;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Package ID"; Rec."Package ID")
                {
                    ApplicationArea = Basic;
                }
                field("Agent ID"; Rec."Agent ID")
                {
                    ApplicationArea = Basic;
                }
                field("Agent Member No"; Rec."Agent Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Agent Name"; Rec."Agent Name")
                {
                    ApplicationArea = Basic;
                }
                field("Is Owner"; Rec."Is Owner")
                {
                    ApplicationArea = Basic;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic;
                }
                field("Date Appointed"; Rec."Date Appointed")
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

