#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 50805 "HR Leave Jnl.-Check Linee"
{
    TableNo = "HR Journal Line";

    trigger OnRun()
    var
        TempJnlLineDim: Record "Journal Line Dimension" temporary;
    begin
        GLSetup.Get;

        // if "Shortcut Dimension 1 Code" <> '' then begin
        //     TempJnlLineDim."Table ID" := Database::"HR Journal Line";
        //     TempJnlLineDim."Journal Template Name" := "Journal Template Name";
        //     TempJnlLineDim."Journal Batch Name" := "Journal Batch Name";
        //     TempJnlLineDim."Journal Line No." := "Line No.";
        //     TempJnlLineDim."Dimension Code" := GLSetup."Global Dimension 1 Code";
        //     TempJnlLineDim."Dimension Value Code" := "Shortcut Dimension 1 Code";
        //     TempJnlLineDim.Insert;
        // end;
        // if "Shortcut Dimension 2 Code" <> '' then begin
        //     TempJnlLineDim."Table ID" := Database::"HR Journal Line";
        //     TempJnlLineDim."Journal Template Name" := "Journal Template Name";
        //     TempJnlLineDim."Journal Batch Name" := "Journal Batch Name";
        //     TempJnlLineDim."Journal Line No." := "Line No.";
        //     TempJnlLineDim."Dimension Code" := GLSetup."Global Dimension 2 Code";
        //     TempJnlLineDim."Dimension Value Code" := "Shortcut Dimension 2 Code";
        //     TempJnlLineDim.Insert;
        // end;

        RunCheck(Rec, TempJnlLineDim);
    end;

    var
        Text000: label 'The combination of dimensions used in %1 %2, %3, %4 is blocked. %5';
        Text001: label 'A dimension used in %1 %2, %3, %4 has caused an error. %5';
        GLSetup: Record "General Ledger Setup";
        FASetup: Record "HR Setup";
        DimMgt: Codeunit DimensionManagement;
        CallNo: Integer;
        Text002: label 'The Posting Date Must be within the open leave periods';
        Text003: label 'The Posting Date Must be within the allowed Setup date';
        LeaveEntries: Record "HR Leave Ledger Entries";
        Text004: label 'The Allocation of Leave days has been done for the period';


    procedure ValidatePostingDate(var InsuranceJnlLine: Record "HR Journal Line")
    begin
        if InsuranceJnlLine."Leave Entry Type" = InsuranceJnlLine."leave entry type"::Negative then begin
            InsuranceJnlLine.TestField(InsuranceJnlLine."Leave Period");
        end;
        InsuranceJnlLine.TestField(InsuranceJnlLine."Document No.");
        InsuranceJnlLine.TestField(InsuranceJnlLine."Posting Date");
        InsuranceJnlLine.TestField(InsuranceJnlLine."Staff No.");
        if (InsuranceJnlLine."Posting Date" < InsuranceJnlLine."Leave Period Start Date") or
           (InsuranceJnlLine."Posting Date" > InsuranceJnlLine."Leave Period End Date") then
            FASetup.Get();
        // if (FASetup."Leave Posting Period[FROM]"<>0D) and (FASetup."Leave Posting Period[TO]"<>0D) then begin
        //   if ("Posting Date"<FASetup."Leave Posting Period[FROM]") or
        //      ("Posting Date">FASetup."Leave Posting Period[TO]")  then
        //      Error(Format(Text003));
        // end;
        /*
             LeaveEntries.RESET;
             LeaveEntries.SETRANGE(LeaveEntries."Leave Type","Leave Type Code");
            IF LeaveEntries.FIND('-') THEN BEGIN
         IF LeaveEntries."Leave Transaction Type"=LeaveEntries."Leave Transaction Type"::"Leave Allocation" THEN BEGIN
         IF (LeaveEntries."Posting Date"<"Leave Period Start Date") OR
             (LeaveEntries."Posting Date">"Leave Period End Date")  THEN
             ERROR(FORMAT(Text004));
                     END;
           END;
        */

    end;


    procedure RunCheck(var InsuranceJnlLine: Record "HR Journal Line"; var JnlLineDim: Record "Journal Line Dimension")
    var
        TableID: array[10] of Integer;
        No: array[10] of Code[20];
    begin
        if InsuranceJnlLine."Leave Entry Type" = InsuranceJnlLine."leave entry type"::Negative then begin
            InsuranceJnlLine.TestField(InsuranceJnlLine."Leave Application No.");
        end;
        InsuranceJnlLine.TestField(InsuranceJnlLine."Document No.");
        InsuranceJnlLine.TestField(InsuranceJnlLine."Posting Date");
        InsuranceJnlLine.TestField(InsuranceJnlLine."Staff No.");
        CallNo := 1;
        TableID[1] := Database::"HR Journal Line";
        No[1] := InsuranceJnlLine."Leave Application No.";
        ValidatePostingDate(InsuranceJnlLine);

    end;

    local procedure JTCalculateCommonFilters()
    begin
    end;
}

