#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 56632 "Users Trail"
{
    ApplicationArea = Basic;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Audit Entries";
    UsageCategory = Lists;
    SourceTableView = sorting(Date) order(descending) where("Transaction Type" = filter(<> 'FOSA Account Viewing'));

    // SourceTableView = sorting("Vendor No.", "Posting Date") order(descending);
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No"; Rec."Entry No")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field(UsersId; Rec.UsersId)
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field(Source; Rec.Source)
                {
                    ApplicationArea = Basic;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic;
                }
                field(Time; Rec.Time)
                {
                    ApplicationArea = Basic;
                }
                field("Loan Number"; Rec."Loan Number")
                {
                    ApplicationArea = Basic;
                }
                field("Document Number"; Rec."Document Number")
                {
                    ApplicationArea = Basic;
                }
                field("Account Number"; Rec."Account Number")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Card"; Rec."ATM Card")
                {
                    ApplicationArea = Basic;
                }
                field("Record ID"; Rec."Record ID")
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
            group(Loan)
            {
                Caption = 'Loan';
                Image = AnalysisView;
                action("Audit Trail Report")
                {
                    ApplicationArea = Basic;
                    Enabled = true;
                    Image = Archive;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Report "User Trail Report";
                }
            }
        }
    }
}

