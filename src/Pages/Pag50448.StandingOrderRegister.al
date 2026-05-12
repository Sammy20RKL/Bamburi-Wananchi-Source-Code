#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50448 "Standing Order Register"
{
    Editable = false;
    PageType = Card;
    SourceTable = "Standing Order Register";

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field("Register No."; Rec."Register No.")
                {
                    ApplicationArea = Basic;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic;
                }
                field("Source Account No."; Rec."Source Account No.")
                {
                    ApplicationArea = Basic;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Destination Account Type"; Rec."Destination Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Destination Account No."; Rec."Destination Account No.")
                {
                    ApplicationArea = Basic;
                }
                field("Destination Account Name"; Rec."Destination Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Don't Allow Partial Deduction"; Rec."Don't Allow Partial Deduction")
                {
                    ApplicationArea = Basic;
                }
                field("Deduction Status"; Rec."Deduction Status")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Amount Deducted"; Rec."Amount Deducted")
                {
                    ApplicationArea = Basic;
                }
                field("Amount-""Amount Deducted"""; Rec.Amount - Rec."Amount Deducted")
                {
                    ApplicationArea = Basic;
                    Caption = 'Balance';
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic;
                }
                field(EFT; Rec.EFT)
                {
                    ApplicationArea = Basic;
                }
                field("Transfered to EFT"; Rec."Transfered to EFT")
                {
                    ApplicationArea = Basic;
                }
                field("Standing Order No."; Rec."Standing Order No.")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Statement)
            {
                ApplicationArea = Basic;
                Caption = 'Print';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //REPORT.RUN(,TRUE,TRUE)
                end;
            }
        }
    }
}

