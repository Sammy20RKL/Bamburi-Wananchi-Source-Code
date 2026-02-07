#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
codeunit 56019 "SureAccountCharges"
{

    trigger OnRun()
    begin
    end;

    var
        vend: Record Vendor;
        Memb: Record Customer;
        GenJournalLine: Record "Gen. Journal Line";
        GenSetup: Record "Sacco General Set-Up";
        LineNum: Integer;


    procedure FnCheckIfPaid(AccountNo: Code[30]) Paid: Boolean
    begin
        Paid := false;
        vend.Reset;
        vend.SetRange(vend."No.", AccountNo);
        vend.SetRange(vend."Paid RegFee", true);
        if vend.Find('-') then begin
            Paid := true;
        end else
            Paid := false;
    end;


    procedure FnAccountOpen(journal: Code[30]; batch: Code[30]; lineNo: Integer; AccountNo: Code[30]; Amount: Decimal; globdim1: Code[30]; globdim2: Code[30]; DocNo: Code[20])
    begin
        GenSetup.Get;

        lineNo := lineNo + 10000;
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := journal;
        GenJournalLine."Journal Batch Name" := batch;
        GenJournalLine."Document No." := DocNo;
        GenJournalLine."Line No." := lineNo;
        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
        GenJournalLine."Account No." := AccountNo;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := Today;
        GenJournalLine.Description := 'Form Fee';
        GenJournalLine.Amount := GenSetup."Form Fee";
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
        GenJournalLine."Bal. Account No." := GenSetup."Form Fee Account";
        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
        GenJournalLine."Shortcut Dimension 1 Code" := globdim1;
        GenJournalLine."Shortcut Dimension 2 Code" := globdim2;
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;

        lineNo := lineNo + 10000;

        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := journal;
        GenJournalLine."Journal Batch Name" := batch;
        GenJournalLine."Document No." := DocNo;
        GenJournalLine."Line No." := lineNo;
        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
        GenJournalLine."Account No." := AccountNo;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := Today;
        GenJournalLine.Description := 'PassCard Fee';
        GenJournalLine.Amount := GenSetup."Passcard Fee";
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
        GenJournalLine."Bal. Account No." := GenSetup."Membership Form Acct";
        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
        GenJournalLine."Shortcut Dimension 1 Code" := globdim1;
        GenJournalLine."Shortcut Dimension 2 Code" := globdim2;
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;

        lineNo := lineNo + 10000;
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := journal;
        GenJournalLine."Journal Batch Name" := batch;
        GenJournalLine."Document No." := DocNo;
        GenJournalLine."Line No." := lineNo;
        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
        GenJournalLine."Account No." := AccountNo;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := Today;
        GenJournalLine.Description := 'Form Ex Duty';
        GenJournalLine.Amount := (GenSetup."Form Fee") * (GenSetup."Excise Duty(%)" / 100);
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
        GenJournalLine."Bal. Account No." := GenSetup."Excise Duty Account";
        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
        GenJournalLine."Shortcut Dimension 1 Code" := globdim1;
        GenJournalLine."Shortcut Dimension 2 Code" := globdim2;
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;

        lineNo := lineNo + 10000;

        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := journal;
        GenJournalLine."Journal Batch Name" := batch;
        GenJournalLine."Document No." := DocNo;
        GenJournalLine."Line No." := lineNo;
        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
        GenJournalLine."Account No." := AccountNo;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := Today;
        GenJournalLine.Description := 'PassCard Ex Duty';
        GenJournalLine.Amount := (GenSetup."Passcard Fee") * (GenSetup."Excise Duty(%)" / 100);
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
        GenJournalLine."Bal. Account No." := GenSetup."Excise Duty Account";
        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
        GenJournalLine."Shortcut Dimension 1 Code" := globdim1;
        GenJournalLine."Shortcut Dimension 2 Code" := globdim2;
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;

        Memb.Reset;
        Memb.SetRange(Memb."FOSA Account", AccountNo);
        if Memb.Find('-') then
            lineNo := lineNo + 10000;

        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := journal;
        GenJournalLine."Journal Batch Name" := batch;
        GenJournalLine."Document No." := DocNo;
        GenJournalLine."Line No." := lineNo;
        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
        GenJournalLine."Account No." := AccountNo;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := Today;
        GenJournalLine.Description := 'Share Capital';
        // GenJournalLine.Amount := GenSetup."share Capital";
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Shortcut Dimension 1 Code" := globdim1;
        GenJournalLine."Shortcut Dimension 2 Code" := globdim2;
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;

        lineNo := lineNo + 10000;

        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := journal;
        GenJournalLine."Journal Batch Name" := batch;
        GenJournalLine."Document No." := DocNo;
        GenJournalLine."Line No." := lineNo;
        GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
        GenJournalLine."Account No." := Memb."No.";
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := Today;
        GenJournalLine.Description := 'Share Capital';
        // GenJournalLine.Amount := (GenSetup."share Capital") * -1;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::"Share Capital";
        GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
        GenJournalLine."Shortcut Dimension 2 Code" := Memb."Global Dimension 2 Code";
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;
        vend.Reset;
        vend.SetRange(vend."No.", AccountNo);
        if vend.Find('-') then begin
            vend."Paid RegFee" := true;
            vend.Modify;
        end;
        // FnGetLineNo(lineNo);
    end;

    local procedure FnGetLineNo(LineNumber: Integer)
    begin
        LineNum := LineNumber;
    end;


    procedure FnReturnLineNo() LineNumb: Integer
    begin
        LineNumb := LineNum;
    end;


    procedure FnCeepReg(journal: Code[30]; batch: Code[30]; lineNo: Integer; AccountNo: Code[30]; Amount: Decimal; globdim1: Code[30]; globdim2: Code[30]; DocNo: Code[30]; ExDoc: Code[30])
    begin



        Memb.Reset;
        Memb.SetRange(Memb."FOSA Account", AccountNo);
        Memb.SetRange(Memb."Customer Type", Memb."customer type"::MicroFinance);
        if Memb.Find('-') then begin
            GenSetup.Get;

            lineNo := lineNo + 10000;
            GenJournalLine.Init;
            GenJournalLine."Journal Template Name" := 'PAYMENTS';
            GenJournalLine."Journal Batch Name" := 'LOANS';
            GenJournalLine."Document No." := DocNo;
            GenJournalLine."External Document No." := ExDoc;
            GenJournalLine."Line No." := lineNo;
            GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
            GenJournalLine."Account No." := AccountNo;
            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine."Posting Date" := Today;
            GenJournalLine.Description := 'Ceep Reg Fee';
            GenJournalLine.Amount := GenSetup."Ceep Reg Fee";
            GenJournalLine.Validate(GenJournalLine.Amount);
            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
            GenJournalLine."Bal. Account No." := GenSetup."Ceep Reg Acct";
            GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
            GenJournalLine."Shortcut Dimension 1 Code" := globdim1;
            GenJournalLine."Shortcut Dimension 2 Code" := globdim2;
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
            if GenJournalLine.Amount <> 0 then
                GenJournalLine.Insert;

            lineNo := lineNo + 10000;
            GenJournalLine.Init;
            GenJournalLine."Journal Template Name" := 'PAYMENTS';
            GenJournalLine."Journal Batch Name" := 'LOANS';
            GenJournalLine."Document No." := DocNo;
            GenJournalLine."External Document No." := ExDoc;
            GenJournalLine."Line No." := lineNo;
            GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
            GenJournalLine."Account No." := AccountNo;
            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine."Posting Date" := Today;
            GenJournalLine.Description := 'Ceep Ex Duty';
            GenJournalLine.Amount := GenSetup."Ceep Reg Fee" * (GenSetup."Excise Duty(%)" / 100);
            GenJournalLine.Validate(GenJournalLine.Amount);
            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
            GenJournalLine."Bal. Account No." := GenSetup."Excise Duty Account";
            GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
            GenJournalLine."Shortcut Dimension 1 Code" := globdim1;
            GenJournalLine."Shortcut Dimension 2 Code" := globdim2;
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
            if GenJournalLine.Amount <> 0 then
                GenJournalLine.Insert;

            FnGetCeepLineNo(lineNo);
            Memb."Ceep Reg Paid" := true;
            Memb.Modify;
        end;
    end;


    procedure FnCheckIfCeepPaid(AccountNo: Code[30]) CeepPaid: Boolean
    begin
        CeepPaid := false;
        Memb.Reset;
        Memb.SetRange(Memb."FOSA Account", AccountNo);
        Memb.SetRange(Memb."Customer Type", Memb."Customer Type");
        Memb.SetRange(Memb."Ceep Reg Paid", true);
        if Memb.Find('-') then begin
            CeepPaid := true;
        end else
            CeepPaid := false;
    end;

    local procedure FnGetCeepLineNo(LineNumber: Integer)
    begin
        LineNum := LineNumber;
    end;


    procedure FnReturnCeepLineNo() LineNumb: Integer
    begin
        LineNumb := LineNum;
    end;
}

