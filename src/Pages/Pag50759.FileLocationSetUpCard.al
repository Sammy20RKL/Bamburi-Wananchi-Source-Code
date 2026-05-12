#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50759 "File Location SetUp Card"
{
    PageType = Card;
    SourceTable = "File Locations Setup";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Location; Rec.Location)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Custodian Code"; Rec."Custodian Code")
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

