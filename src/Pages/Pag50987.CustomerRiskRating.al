#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50987 "Customer Risk Rating"
{
    PageType = List;
    SourceTable = "Customer Risk Rating";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Category; Rec.Category)
                {
                    ApplicationArea = Basic;
                }
                field("Sub Category"; Rec."Sub Category")
                {
                    ApplicationArea = Basic;
                }
                field("Inherent Risk Rating"; Rec."Inherent Risk Rating")
                {
                    ApplicationArea = Basic;
                }
                field("Risk Score"; Rec."Risk Score")
                {
                    ApplicationArea = Basic;
                }
                field("Min Relationship Length(Years)"; Rec."Min Relationship Length(Years)")
                {
                    ApplicationArea = Basic;
                }
                field("Max Relationship Length(Years)"; Rec."Max Relationship Length(Years)")
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

