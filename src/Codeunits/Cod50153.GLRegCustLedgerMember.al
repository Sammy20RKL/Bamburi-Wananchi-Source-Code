#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 50153 "G/L Reg.-Cust.Ledger-Member"
{
    TableNo = "G/L Register";

    trigger OnRun()
    begin
        CustLedgEntry.SetRange("Entry No.", Rec."From Entry No.", Rec."To Entry No.");
        Page.Run(Page::"HR Leave journal Template", CustLedgEntry);
    end;

    var
        CustLedgEntry: Record 51365;
}

