#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 56451 "Loan Reschedule list"
{
    CardPageID = "Loan Reschedulin card";
    Caption = 'Loan Rescheduling Card';
    PageType = List;
    SourceTable = "Loan Rescheduling";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Loan No"; Rec."Loan No")
                {
                    ApplicationArea = Basic;
                }
                field(Rescheduled; Rec.Rescheduled)
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

