#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 50813 "Job-Jnl.-B.Post+Print"
{
    TableNo = "Job Journal Line";

    trigger OnRun()
    begin
        JobJnlBatch.Copy(Rec);
        Code;
        Rec.Copy(JobJnlBatch);
    end;

    var
        Text000: label 'Do you want to post the journals and print the posting report?';
        Text001: label 'The journals were successfully posted.';
        Text002: label 'It was not possible to post all of the journals. ';
        Text003: label 'The journals that were not successfully posted are now marked.';
        JobJnlBatch: Record "Job Journal Batch";
        JobJnlTemplate: Record "Job Journal Template";
        JobJnlLine: Record "Job Journal Line";
        JobReg: Record "Job Register";
        JobJnlPostbatch: Codeunit "Job Jnl.-Post Batch";
        JnlWithErrors: Boolean;

    local procedure "Code"()
    begin
        with JobJnlBatch do begin
            JobJnlTemplate.Get("Journal Template Name");
            JobJnlTemplate.TestField("Posting Report ID");

            if not Confirm(Text000) then
                exit;

            Find('-');
            repeat
                JobJnlLine."Journal Template Name" := "Journal Template Name";
                JobJnlLine."Journal Batch Name" := Name;
                JobJnlLine."Line No." := 1;
                Clear(JobJnlPostbatch);
                if JobJnlPostbatch.Run(JobJnlLine) then begin
                    Mark(false);
                    if JobReg.Get(JobJnlLine."Line No.") then begin
                        JobReg.SetRecfilter;
                        Report.Run(JobJnlTemplate."Posting Report ID", false, false, JobReg);
                    end;
                end else begin
                    Mark(true);
                    JnlWithErrors := true;
                end;
            until Next = 0;

            if not JnlWithErrors then
                Message(Text001)
            else
                Message(
                  Text002 +
                  Text003);

            if not Find('=><') then begin
                Reset;
                Name := '';
            end;
        end;
    end;
}

