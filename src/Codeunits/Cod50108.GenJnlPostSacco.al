#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
codeunit 50108 "Gen. Jnl.-Post Sacco"
{
    TableNo = "Gen. Journal Line";

    trigger OnRun()
    begin
        GenJnlLine.Copy(Rec);
        Code;
        Rec.Copy(GenJnlLine);
    end;

    var
        Text000: label 'cannot be filtered when posting recurring journals';
        Text001: label 'Do you want to post the journal lines?';
        Text002: label 'There is nothing to post.';
        Text003: label 'The journal lines were successfully posted.';
        Text004: label 'The journal lines were successfully posted. You are now in the %1 journal.';
        GenJnlTemplate: Record "Gen. Journal Template";
        GenJnlLine: Record "Gen. Journal Line";
        GenJnlPostBatch: Codeunit "Gen. Jnl.-Post Batch";
        TempJnlBatchName: Code[10];

    local procedure "Code"()
    begin
        GenJnlTemplate.Get(GenJnlLine."Journal Template Name");
        GenJnlTemplate.TestField("Force Posting Report", false);
        if GenJnlTemplate.Recurring and (GenJnlLine.GetFilter("Posting Date") <> '') then
            GenJnlLine.FieldError("Posting Date", Text000);

        TempJnlBatchName := GenJnlLine."Journal Batch Name";
        GenJnlPostBatch.Run(GenJnlLine);

        if GenJnlLine."Line No." = 0 then
            Message(Text002)
        else
            if not GenJnlLine.Find('=><') or (TempJnlBatchName <> GenJnlLine."Journal Batch Name") then begin
                GenJnlLine.Reset;
                GenJnlLine.FilterGroup(2);
                GenJnlLine.SetRange("Journal Template Name", GenJnlLine."Journal Template Name");
                GenJnlLine.SetRange("Journal Batch Name", GenJnlLine."Journal Batch Name");
                GenJnlLine.FilterGroup(0);
                GenJnlLine."Line No." := 1;
            end;
    end;
}

