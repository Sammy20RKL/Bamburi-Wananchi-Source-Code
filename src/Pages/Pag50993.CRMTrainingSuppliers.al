#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50993 "CRM Training Suppliers"
{
    PageType = ListPart;
    SourceTable = "CRM Training Suppliers";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Supplier Vendor No"; Rec."Supplier Vendor No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Trainer/Supplier No';
                }
                field("Supplier Name"; Rec."Supplier Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Narration; Rec.Narration)
                {
                    ApplicationArea = Basic;
                }
                field(Cost; Rec.Cost)
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

