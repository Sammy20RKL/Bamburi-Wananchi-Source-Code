pageextension 50621 "General Ledger Entries Ext" extends "General Ledger Entries"
{
    layout
    {
        addbefore(Amount)
        {
            field("Debit Amounts"; Rec."Debit Amount")
            {
                ApplicationArea = Basic;
            }
            field("Credit Amounts"; Rec."Credit Amount")
            {
                ApplicationArea = Basic;
            }
            field(RunningBalanceE; CalcRunningAccBalance.GetGLAccBalance(Rec))
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Running Balance';
                ToolTip = 'Specifies the running balance.';
            }
            field("Reverse"; Rec.Reversed)
            {
                Caption = 'Reversed';
                ApplicationArea = Basic;
            }
            field("ExternalDocument No."; Rec."External Document No.")
            {
                Caption = 'External Document No:';
                ApplicationArea = Basic;
            }
            field("UserID"; Rec."User ID")
            {
                Caption = 'User ID';
                ApplicationArea = Basic;
            }



        }
        addafter("Posting Date")
        {

        }
        modify("External Document No.")
        {
            Visible = false;
        }
        modify("Document Type")
        {
            Visible = false;
        }
        modify("Gen. Posting Type")
        {
            Visible = false;
        }
        modify("Gen. Bus. Posting Group")
        {
            Visible = false;
        }
        modify("Gen. Prod. Posting Group")
        {
            Visible = false;
        }
        modify("VAT Reporting Date")
        {
            Visible = false;
        }
        modify(IncomingDocAttachFactBox)
        {
            Visible = false;
        }
        modify(GLEntriesPart)
        {
            Visible = false;
        }
        modify(Control1900383207)
        {
            Visible = false;
        }
        modify(Control1905767507)
        {
            Visible = false;
        }
    }
    var
        RunningBal: Decimal;
        CalcRunningAccBalance: Codeunit "System General Setup";

    trigger OnAfterGetRecord()
    var
        GLEntryTable: Record "G/L Entry";
    begin
        // RunningBal := 0;
        // GLEntryTable.Reset();
        // GLEntryTable.SetRange(GLEntryTable."G/L Account No.", "G/L Account No.");
        // if GLEntryTable.Find('-') then begin
        //     RunningBal := FnGetSumLessTheGLEntryNo(GLEntryTable."Entry No.", GLEntryTable."G/L Account No.")
        // end;
    end;

    local procedure FnGetSumLessTheGLEntryNo(EntryNo: Integer; GLAccountNo: Code[20]): Decimal
    var
        GLEntryTable: Record "G/L Entry";
        TotalSum: Decimal;
    begin
        TotalSum := 0;
        GLEntryTable.Reset();
        GLEntryTable.SetRange(GLEntryTable."G/L Account No.", GLAccountNo);
        GLEntryTable.SetFilter(GLEntryTable."Entry No.", '<%1', EntryNo);
        if GLEntryTable.Find('-') then begin
            repeat
                TotalSum += GLEntryTable.Amount;
            until GLEntryTable.Next = 0;
        end;
        exit(GLEntryTable.Amount);
    end;
}
