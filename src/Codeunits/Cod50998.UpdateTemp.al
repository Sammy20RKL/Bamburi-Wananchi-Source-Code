#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 50998 UpdateTemp
{

    trigger OnRun()
    begin
        UpdateValues(0);
    end;

    var
        CheckoffLinesDistributed2: Record 51654;
        TempCheckoff: Record 51948;
        GenJournalLine: Record "Gen. Journal Line";

    local procedure UpdateValues(amount: Decimal)
    begin
        CheckoffLinesDistributed2.Reset;
        CheckoffLinesDistributed2.SetRange("Receipt Header No", 'CHECKOFF0005');
        //CheckoffLinesDistributed2.SETRANGE("Member No.",'KS00021');
        if CheckoffLinesDistributed2.Find('-') then begin
            repeat
                amount := 0;
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Document No.", CheckoffLinesDistributed2."Receipt Header No");
                GenJournalLine.SetRange("Account No.", CheckoffLinesDistributed2."Member No.");
                if GenJournalLine.Find('-') then begin

                    repeat
                        if (GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::"Loan Repayment") or
                         (GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::"Interest Paid") then begin
                            amount := amount + GenJournalLine.Amount;
                        end;
                    until GenJournalLine.Next = 0;
                    TempCheckoff.Init;
                    TempCheckoff.MemNO := CheckoffLinesDistributed2."Member No.";
                    TempCheckoff.JournalAmount := -amount;
                    TempCheckoff.CheckoffAmount :=
                    CheckoffLinesDistributed2."Principal Loan"
                    + CheckoffLinesDistributed2."Vision Loan"
                    + CheckoffLinesDistributed2."Mjengo Loan"
                    + CheckoffLinesDistributed2."Car Loan"
                    + CheckoffLinesDistributed2."Elimu Loan"
                    + CheckoffLinesDistributed2."Karibu Loan"
                    + CheckoffLinesDistributed2."KHL Loan"
                    + CheckoffLinesDistributed2."Sukuma Mwezi Loan"
                    + CheckoffLinesDistributed2."Motor Vehicle Insurance"
                    + CheckoffLinesDistributed2."Mali Mali Loan"
                    + CheckoffLinesDistributed2."Emergency 1 Loan"
                    + CheckoffLinesDistributed2."Emergency 2 Loan"
                    + CheckoffLinesDistributed2."Instant Loan"
                    + CheckoffLinesDistributed2."Instant2 Loan";
                    TempCheckoff.Insert;
                end;

            until CheckoffLinesDistributed2.Next = 0;
        end;
        Message('done');
    end;
}

