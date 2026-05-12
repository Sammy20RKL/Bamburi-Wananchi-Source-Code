#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50096 "Expense Transfer Lines"
{
    PageType = ListPart;
    SourceTable = "Funds Transfer Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = Basic;
                    Caption = 'Expense Type';
                }
                field("Receiving Bank Account"; Rec."Receiving Bank Account")
                {
                    ApplicationArea = Basic;
                    Caption = 'Expense Account No.';
                    Editable = false;
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Expense Name';
                }
                field("Bank Balance"; Rec."Bank Balance")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Amount to Receive"; Rec."Amount to Receive")
                {
                    ApplicationArea = Basic;
                    Caption = 'Amount Expensed';
                }
                field("External Doc No."; Rec."External Doc No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Rcpt No.';
                }
            }
        }
    }

    actions
    {
    }
}

