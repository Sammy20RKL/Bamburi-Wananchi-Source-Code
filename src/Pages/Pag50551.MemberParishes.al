#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50551 "Member Parishes"
{
    PageType = Card;
    SourceTable = "Member's Parishes";

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
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Share Class"; Rec."Share Class")
                {
                    ApplicationArea = Basic;
                }
                field("No of Members"; Rec."No of Members")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Male Members"; Rec."Male Members")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Female Members"; Rec."Female Members")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

