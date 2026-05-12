#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50206 "HR Activity Participants SF"
{
    Caption = 'Activity Participants';
    PageType = List;
    SaveValues = true;
    SourceTable = "HR Activity Participants";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field(Notified; Rec.Notified)
                {
                    ApplicationArea = Basic;
                }
                field(Participant; Rec.Participant)
                {
                    ApplicationArea = Basic;
                }
                field(Contribution; Rec.Contribution)
                {
                    ApplicationArea = Basic;
                }
                field("Email Message"; Rec."Email Message")
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

