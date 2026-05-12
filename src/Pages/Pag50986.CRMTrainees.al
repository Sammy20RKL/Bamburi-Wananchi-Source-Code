#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50986 "CRM Trainees"
{
    PageType = List;
    SourceTable = 51930;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic;
                }
                field("Member ID No"; Rec."Member ID No")
                {
                    ApplicationArea = Basic;
                }
                field("Member Phone No"; Rec."Member Phone No")
                {
                    ApplicationArea = Basic;
                }
                field("Member House Group"; Rec."Member House Group")
                {
                    ApplicationArea = Basic;
                }
                field("Member House Group Name"; Rec."Member House Group Name")
                {
                    ApplicationArea = Basic;
                }
                field(Attended; Rec.Attended)
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

