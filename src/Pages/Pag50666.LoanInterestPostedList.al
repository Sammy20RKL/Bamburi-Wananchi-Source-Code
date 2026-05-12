#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50666 "Loan Interest Posted List"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Loans Interest";
    SourceTableView = where(Posted = const(true),
                            Transferred = const(true),
                            Reversed = const(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Interest Date"; Rec."Interest Date")
                {
                    ApplicationArea = Basic;
                }
                field("Interest Amount"; Rec."Interest Amount")
                {
                    ApplicationArea = Basic;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic;
                }
                field(Transferred; Rec.Transferred)
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                }
                field("Loan No."; Rec."No")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Product type"; Rec."Loan Product type")
                {
                    ApplicationArea = Basic;
                }
                field("Bal. Account Type"; Rec."Bal. Account Type")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("Issued Date"; Rec."Issued Date")
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Interest"; Rec."Outstanding Interest")
                {
                    ApplicationArea = Basic;
                }
                field(Reversed; Rec.Reversed)
                {
                    ApplicationArea = Basic;
                }
                field("Interest Rate"; Rec."Interest Rate")
                {
                    ApplicationArea = Basic;
                }
                field("Bosa No"; Rec."Bosa No")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Generate Monthly Interest")
            {
                ApplicationArea = Basic;
                Image = GetEntries;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                // RunObject = Report 51516579;
            }
            action("Option ")
            {
                ApplicationArea = Basic;
            }
            action("Post Loan Interest")
            {
                ApplicationArea = Basic;
                Image = Post;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                // RunObject = Report 51516580;
            }
        }
    }

    var
        Option: Option "Generate Only","Generate & Post";
}

