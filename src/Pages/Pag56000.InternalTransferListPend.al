#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 56000 "Internal Transfer List(Pend)"
{
    CardPageID = "Sacco Transfer Card";
    Editable = false;
    PageType = List;
    ShowFilter = false;
    SourceTable = "Sacco Transfers";
    SourceTableView = where(Posted = filter(false));

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
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = Basic;
                }
                field("Schedule Total"; Rec."Schedule Total")
                {
                    ApplicationArea = Basic;
                }
                field(Approved; Rec.Approved)
                {
                    ApplicationArea = Basic;
                }
                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = Basic;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
                // field("Transaction Description"; Rec."Transaction Description")
                // {
                //     ApplicationArea = Basic;
                // }
                field("Source Account Type"; Rec."Source Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Source Account No."; Rec."Source Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Source Transaction Type"; Rec."Source Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field("Source Account Name"; Rec."Source Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Source Loan No"; Rec."Source Loan No")
                {
                    ApplicationArea = Basic;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic;
                }
                field(Debit; Rec.Debit)
                {
                    ApplicationArea = Basic;
                }
                field(Refund; Rec.Refund)
                {
                    ApplicationArea = Basic;
                }
                field("Guarantor Recovery"; Rec."Guarantor Recovery")
                {
                    ApplicationArea = Basic;
                }
                field("Payrol No."; Rec."Payrol No.")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Bosa Number"; Rec."Bosa Number")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("Savings Account Type"; Rec."Source Account Type")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        Rec.SetRange("Created By", UserId);
    end;
}

