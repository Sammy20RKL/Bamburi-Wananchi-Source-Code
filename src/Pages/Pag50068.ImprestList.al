#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50068 "Imprest List"
{
    Caption = 'Staff Travel  List';
    // CardPageID = "Imprest Request";
    Editable = false;
    PageType = List;
    SourceTable = "Imprest Header";
    SourceTableView = where(Posted = const(false));

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(Payee; Rec.Payee)
                {
                    ApplicationArea = Basic;
                }
                field("Total Net Amount"; Rec."Total Net Amount")
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
            action("Print/Preview")
            {
                ApplicationArea = Basic;
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    ImprestHeader.Reset;
                    ImprestHeader.SetRange(ImprestHeader."No.", Rec."No.");
                    Report.Run(51516130, true, false, ImprestHeader);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SetRange(Cashier, UserId);
    end;

    var
        ImprestHeader: Record "Imprest Header";
}

