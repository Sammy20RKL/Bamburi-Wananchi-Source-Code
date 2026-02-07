// namespace PolyTechERPSourceCode.PolyTechERPSourceCode;

codeunit 51024 WelfareProcessing
{
    var
        customersTable: Record Customer;
        GenJournalLine: Record "Gen. Journal Line";
        swizzMobile: Codeunit SwizzKashMobile;
        welfareLiabilityGL: Code[20];
        welfareIncomeGL: Code[20];
        memberBranch: Code[20];

    procedure fnPostWelfare(memberNumber: Code[20]; jnlBatchTemplate: Code[20]; jnlBatchName: Code[20]; LineNo: Integer; documentNo: Code[20]; postingDate: Date; transAmount: Decimal; bankType: Enum "Gen. Journal Account Type"; bankAccount: Code[20])
    begin
        customersTable.Reset();
        customersTable.SetRange(customersTable."No.", memberNumber);
        if customersTable.Find('-') then begin
            memberBranch := customersTable."Global Dimension 2 Code";
        end;
        //Debit bank(+320)
        welfareIncomeGL := '301424';

        LineNo := LineNo + 10000;
        GenJournalLine.INIT;
        GenJournalLine."Journal Template Name" := jnlBatchTemplate;
        GenJournalLine."Journal Batch Name" := jnlBatchName;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := bankType;// GenJournalLine."Account Type"::"Bank Account";
        GenJournalLine."Account No." := bankAccount;
        GenJournalLine.VALIDATE(GenJournalLine."Account No.");
        GenJournalLine."Document No." := documentno;
        GenJournalLine."External Document No." := memberNumber;
        GenJournalLine."Source No." := memberNumber;
        GenJournalLine."Posting Date" := postingDate;
        GenJournalLine.Description := 'Welfare contribution for ' + swizzMobile.GetMemberNameCustomer(memberNumber);
        GenJournalLine.Amount := 320;
        GenJournalLine.VALIDATE(GenJournalLine.Amount);
        IF GenJournalLine.Amount <> 0 THEN
            GenJournalLine.Insert();

        //Credit member(-300)
        LineNo := LineNo + 10000;
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := jnlBatchTemplate;
        GenJournalLine."Journal Batch Name" := jnlBatchName;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := GenJournalLine."bal. account type"::Customer;
        GenJournalLine."Account No." := memberNumber;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Document No." := documentNo;
        GenJournalLine."Posting Date" := postingDate;
        GenJournalLine.Description := 'Welfare contribution for ' + swizzMobile.GetMemberNameCustomer(memberNumber);
        GenJournalLine.Amount := -300;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Welfare Contribution";
        GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
        GenJournalLine."Shortcut Dimension 2 Code" := memberBranch;
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert();


        //Credit income G/L (-20)
        LineNo := LineNo + 10000;
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := jnlBatchTemplate;
        GenJournalLine."Journal Batch Name" := jnlBatchName;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := GenJournalLine."bal. account type"::"G/L Account";
        GenJournalLine."Account No." := welfareIncomeGL;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Document No." := documentNo;
        GenJournalLine."Posting Date" := postingDate;
        GenJournalLine.Description := 'Welfare contribution Commision for ' + swizzMobile.GetMemberNameCustomer(memberNumber);
        GenJournalLine.Amount := -20;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."External Document No." := memberNumber;
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert();



    end;

}
