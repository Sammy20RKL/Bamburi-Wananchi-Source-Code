#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50836 "Loan Officer Details"
{
    CardPageID = "Loan Officer Card";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = 51438;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = Basic;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Savings Target"; Rec."Savings Target")
                {
                    ApplicationArea = Basic;
                }
                field("Member Target"; Rec."Member Target")
                {
                    ApplicationArea = Basic;
                }
                field("Disbursement Target"; Rec."Disbursement Target")
                {
                    ApplicationArea = Basic;
                }
                field("Payment Target"; Rec."Payment Target")
                {
                    ApplicationArea = Basic;
                }
                field("Exit Target"; Rec."Exit Target")
                {
                    ApplicationArea = Basic;
                }
                field("No. of Loans"; Rec."No. of Loans")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field(Created; Rec.Created)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            separator(Action1000000012)
            {
            }
            action(Approval)
            {
                ApplicationArea = Basic;
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    ///rereer
                end;
            }
            separator(Action1000000014)
            {
            }
        }
    }
}

