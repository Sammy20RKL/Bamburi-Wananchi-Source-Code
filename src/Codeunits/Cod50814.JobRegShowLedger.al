#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 50814 "Job-Reg.-Show Ledger"
{
    // TableNo = "Job Journal Line";
    TableNo = "G/L Register";

    trigger OnRun()
    begin
        JobLedgEntry.SetRange("Entry No.", Rec."From Entry No.", Rec."To Entry No.");
        Page.Run(Page::"Job Journal Batches", JobLedgEntry);
    end;

    var
        JobLedgEntry: Record "Job Ledger Entry";
}

