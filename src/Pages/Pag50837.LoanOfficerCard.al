#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50837 "Loan Officer Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = 51438;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = Basic;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Group Target"; Rec."Group Target")
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
                field("No. of Loans"; Rec."No. of Loans")
                {
                    ApplicationArea = Basic;
                }
                field("Exit Target"; Rec."Exit Target")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Branch; Rec.Branch)
                {
                    ApplicationArea = Basic;
                }
                field(Created; Rec.Created)
                {
                    ApplicationArea = Basic;
                }
                field("Staff Status"; Rec."Staff Status")
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
            separator(Action1000000022)
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
            separator(Action1000000020)
            {
            }
        }
    }


    procedure UpdateControls()
    begin
        /* IF Status=Status::Approved THEN BEGIN
         ReasonEditable:=FALSE;
         "Transfer TypeEditable":=FALSE;
         TranscodeEditable:=FALSE;
         DocumentNoEditable:=FALSE;
         FTransferLineEditable:=FALSE;
         END;

         IF Status=Status::Pending THEN BEGIN
          ReasonEditable :=TRUE;
         "Transfer TypeEditable":=TRUE;
         TranscodeEditable:=TRUE;
         DocumentNoEditable:=TRUE;
         FTransferLineEditable:=TRUE;
         END;

         IF Status=Status::Cancelled THEN BEGIN
         ReasonEditable:=FALSE;
         "Transfer TypeEditable":=FALSE;
         TranscodeEditable:=FALSE;
         DocumentNoEditable:=FALSE;
         FTransferLineEditable:=FALSE;
         END;
         */

    end;
}

