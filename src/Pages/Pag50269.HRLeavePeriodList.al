#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50269 "HR Leave Period List"
{
    PageType = List;
    SourceTable = "HR Leave Periods";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Period Code"; Rec."Period Code")
                {
                    ApplicationArea = Basic;
                }
                field("Period Description"; Rec."Period Description")
                {
                    ApplicationArea = Basic;
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field("New Fiscal Year"; Rec."New Fiscal Year")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date Locked"; Rec."Date Locked")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1102755008; Outlook)
            {
            }
            systempart(Control1102755009; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("<Report 51516233>")
            {
                ApplicationArea = Basic;
                Caption = '&Create Year';
                Ellipsis = true;
                Image = CreateYear;
                Promoted = true;
                PromotedCategory = Process;
                // RunObject = Report 51516233;
            }
            action("C&lose Year")
            {
                ApplicationArea = Basic;
                Caption = 'C&lose Year';
                Image = CloseYear;
                Promoted = true;
                PromotedCategory = Process;
                // RunObject = Codeunit 55582;
            }
        }
    }
}

