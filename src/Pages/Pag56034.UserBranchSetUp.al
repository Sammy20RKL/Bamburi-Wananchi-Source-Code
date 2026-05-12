#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 56034 "User Branch Set Up"
{
    ApplicationArea = Basic;
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "User Setup";
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field("User Name"; Rec."User ID")
                {
                    ApplicationArea = Basic;
                }
                field(Activity; Rec.Activity)
                {
                    ApplicationArea = Basic;
                }
                field(Branch; Rec.Branch)
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

