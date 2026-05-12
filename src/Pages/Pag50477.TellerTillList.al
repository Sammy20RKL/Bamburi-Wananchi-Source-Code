#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50477 "Teller Till List"
{
    CardPageID = "Teller Till Card";
    Editable = false;
    PageType = List;
    SourceTable = "Bank Account";
    SourceTableView = where("Account Type" = filter(Cashier));

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
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field(CashierID; Rec.CashierID)
                {
                    ApplicationArea = Basic;
                }
                field("Balance (LCY)"; Rec."Balance (LCY)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Running Balance';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Cashier Activity Report")
            {
                ApplicationArea = Basic;
                Caption = 'Activity Report(detailed)';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    TillNo.Reset;
                    TillNo.SetRange(TillNo."No.", Rec."No.");
                    if TillNo.Find('-') then
                        Report.Run(51516029, true, false, TillNo)
                end;
            }
            action("Cashier Activity Report 2")
            {
                ApplicationArea = Basic;
                Caption = 'Activity Report';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    TillNo.Reset;
                    TillNo.SetRange(TillNo."No.", Rec."No.");
                    if TillNo.Find('-') then
                        Report.Run(51516029, true, false, TillNo)
                end;
            }
        }
    }

    var
        TillNo: Record "Bank Account";
}

