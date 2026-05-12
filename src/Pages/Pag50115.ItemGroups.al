#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50115 "Item Groups"
{
    PageType = List;
    SourceTable = "Item Groups";

    layout
    {
        area(content)
        {
            repeater(Control12)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Def. Gen. Prod. Posting Group"; Rec."Def. Gen. Prod. Posting Group")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Def. Inventory Posting Group"; Rec."Def. Inventory Posting Group")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Def. VAT Prod. Posting Group"; Rec."Def. VAT Prod. Posting Group")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Def. Costing Method"; Rec."Def. Costing Method")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control2; Links)
            {
                Visible = false;
            }
            systempart(Control1; Notes)
            {
                Visible = false;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("&Item Category Code")
            {
                ApplicationArea = Basic;
                Caption = '&Item Category Code';
                Image = ItemGroup;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Item Categories";
                // RunPageLink = Field51516000 = field(Code);
            }
        }
    }
}

