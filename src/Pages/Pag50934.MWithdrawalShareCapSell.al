#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50934 "M_Withdrawal Share Cap Sell"
{
    PageType = ListPart;
    SourceTable = "M_Withdrawal Share Cap Sell";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Buyer Member No"; Rec."Buyer Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Buyer Name"; Rec."Buyer Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Amount; Rec.Amount)
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

