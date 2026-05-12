#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51001 "Sacco Insiders"
{
    ApplicationArea = Basic;
    PageType = List;
    SourceTable = "Sacco Insiders";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(MemberNo; Rec.MemberNo)
                {
                    ApplicationArea = Basic;
                }
                field("Position in society"; Rec."Position in society")
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

