#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50966 "Politically Exposed Persons"
{
    PageType = List;
    SourceTable = "Politically Exposed Persons";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field("County Code"; Rec."County Code")
                {
                    ApplicationArea = Basic;
                }
                field("County Name"; Rec."County Name")
                {
                    ApplicationArea = Basic;
                }
                field("ID/Passport No"; Rec."ID/Passport No")
                {
                    ApplicationArea = Basic;
                }
                field("Position Runing For"; Rec."Position Runing For")
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

