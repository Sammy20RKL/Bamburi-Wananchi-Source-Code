// namespace PolyTechERPSourceCode.PolyTechERPSourceCode;

codeunit 51023 "Paybill Processor"
{
    trigger OnRun()
    begin
        Message(' ' + fnProcessPaybill());
    end;

    var
        membersTable: Record Customer;
        vendorsTable: Record Vendor;
        paybillTransTable: Record "Polytech Paybill Transactions";
        swizzMobile: Codeunit SwizzKashMobile;
        msg: Text;
        GenJournalLine: Record "Gen. Journal Line";
        GenBatches: Record "Gen. Journal Batch";
        GLPosting: Codeunit "Gen. Jnl.-Post line";
        jnlBatchName: Text;
        jnlBatchTemplate: Text;
        TariffDetails: Record "Tariff Details";
        PaybillRecon: Code[30];
        LineNo: Integer;
        GenLedgerSetup: Record "General Ledger Setup";
        LoansRegister: Record "Loans Register";
        Charges: Record Charges;
        MobileCharges: Decimal;
        MobileChargesACC: Text[20];
        SwizzKASHCommACC: Code[20];
        SurePESACharge: Decimal;
        ExcDuty: Decimal;
        SwizzKashCharge: Decimal;
        exciseDutyAcc: Code[30];
        exciseDutyRate: Decimal;
        ASAT: Date;
        BeginMonth_Date: Date;
        emergencyLoan12Balance: Decimal;
        emergencyLoan12Interest: Decimal;
        emergencyLoan13Balance: Decimal;
        emergencyLoan13Interest: Decimal;
        quickLoanBalance: Decimal;
        quickLoanInterest: Decimal;
        superQuickLoanBalance: Decimal;
        superQuickLoanInterest: Decimal;
        schoolFeesLoanBalance: Decimal;
        schoolFeesLoanInterest: Decimal;
        superSchoolFeesLoanBalance: Decimal;
        superSchoolFeesLoanInterest: Decimal;
        investmentLoanBalance: Decimal;
        investmentLoanInterest: Decimal;
        normal20LoanBalance: Decimal;
        normal20LoanInterest: Decimal;
        normal21LoanBalance: Decimal;
        normal21LoanInterest: Decimal;
        normal22LoanBalance: Decimal;
        normal22LoanInterest: Decimal;
        development23LoanBalance: Decimal;
        development23LoanInterest: Decimal;
        development25LoanBalance: Decimal;
        development25LoanInterest: Decimal;
        merchandiseLoanBalance: Decimal;
        merchandiseLoanInterest: Decimal;

    procedure fnProcessPaybill() Result: Text;
    var
        memberNumber: Code[30];
        postingAmount: Decimal;
        thisAccNum: Code[150];
        thisKeyWord: Code[30];
        vendorTable: Record 23;
        thisDocNum: Code[30];
        thisAmount: Decimal;
        thisMemberNum: Code[130];
        strKeyWord: Text[10];
        paybillTransaction: Record "SwizzKash MPESA Trans";
    begin
        postingAmount := 0;
        memberNumber := '';

        paybillTransTable.Reset();
        paybillTransTable.SetRange(paybillTransTable.Posted, false);
        paybillTransTable.SetRange(paybillTransTable."Needs Manual Posting", false);
        paybillTransTable.SetFilter(paybillTransTable."Transaction Date", '>=%1', 20251122D);
        paybillTransTable.SetCurrentKey(TransDate);
        paybillTransTable.SetAscending(TransDate, true);

        // Process all matching transactions
        if paybillTransTable.FindSet() then begin
            // repeat
            // parse keyword and account (robust)
            thisAccNum := '';
            thisKeyWord := '';

            // check if account contains keyword and account separated by '#'
            IF STRPOS(paybillTransTable."Account No", '#') > 0 THEN BEGIN
                thisKeyWord := COPYSTR(paybillTransTable."Account No", 1, 3);
                thisAccNum := COPYSTR(paybillTransTable."Account No", 5, STRLEN(paybillTransTable."Account No") - 4);
            END ELSE BEGIN

                // check if account contains keyword and account
                strKeyWord := swizzMobile.CheckKeyword(paybillTransTable."Account No");
                IF NOT (strKeyWord = 'FALSE') THEN BEGIN
                    thisKeyWord := strKeyWord;
                    thisAccNum := COPYSTR(paybillTransTable."Account No", 4, STRLEN(paybillTransTable."Account No") - 3);
                END ELSE BEGIN
                    thisKeyWord := paybillTransTable."Key Word";
                    thisAccNum := paybillTransTable."Account No";
                END;

            END;
            //get the account number, memberNu, LoanNu, or WalletN
            thisDocNum := paybillTransTable."Document No";
            thisAmount := paybillTransTable.Amount;
            thisMemberNum := thisAccNum;
            // do the postings -> deductions

            //check if it was posted on the other table..
            if IsAlreadyPostedOnOtherTable(thisDocNum) then begin

                paybillTransTable."Date Posted" := TODAY;
                paybillTransTable.Posted := true;
                paybillTransTable.Remarks := 'Posted on STK Push table';
                paybillTransTable.Modify();
                Result := 'Transaction already posted on STK Table';
            end else begin
                CASE UPPERCASE(paybillTransTable."Key Word") OF
                    '100':
                        Result := PayBillToMWallet('PAYBILL', thisDocNum, thisAccNum, thisAmount, 'M-WALLET');
                    'BLN':
                        Result := PayBillToLoanAll('PAYBILL', thisDocNum, thisAccNum, thisMemberNum, thisAmount, 'Paybill to Loans');
                    'DEP':
                        Result := PayBillToBOSA('PAYBILL', thisDocNum, thisAccNum, thisMemberNum, thisAmount, thisKeyWord, 'PayBill to Deposit');
                    ELSE
                        //check if acc is from membersTable Table, either Id or Mem Number
                        memberNumber := '';
                        memberNumber := fnGetMemberNumber(thisAccNum);
                        if memberNumber <> '' then begin
                            Result := fnMemberPostings(memberNumber, thisAmount, thisDocNum);
                        end else
                            // check if acc is M-Wallet
                            IF STRLEN(thisAccNum) <= 20 THEN BEGIN
                                vendorTable.RESET;
                                vendorTable.SETRANGE("No.", thisAccNum);
                                IF vendorTable.FIND('-') THEN BEGIN
                                    Result := PayBillToMWallet('PAYBILL', thisDocNum, thisAccNum, thisAmount, 'M-WALLET');
                                END ELSE BEGIN
                                    paybillTransTable."Date Posted" := TODAY;
                                    paybillTransTable."Needs Manual Posting" := TRUE;
                                    paybillTransTable.Remarks := 'KEYWORDNOTFOUND';
                                    paybillTransTable.MODIFY;
                                    Result := paybillTransTable.Remarks;
                                END;
                            END ELSE BEGIN
                                paybillTransTable."Date Posted" := TODAY;
                                paybillTransTable."Needs Manual Posting" := TRUE;
                                paybillTransTable.Remarks := 'KEYWORDNOTFOUND';
                                paybillTransTable.MODIFY;
                                Result := paybillTransTable.Remarks;
                            END;

                END;
            end;
            // until paybillTransTable.Next() = 0;
        end else
            Result := 'No transactions';


    end;

    local procedure IsAlreadyPostedOnOtherTable(thisDocNum: Code[30]): Boolean
    var
        paybillTransaction: Record "SwizzKash MPESA Trans";
    begin
        paybillTransaction.RESET;
        paybillTransaction.SETRANGE("Document No", thisDocNum);
        if paybillTransaction.FIND('-') then begin
            // paybillTransaction.Posted := TRUE;
            // paybillTransaction.Remarks := 'Posted on STK Push table';
            // paybillTransaction.Modify();
            exit(true);
        end;
        exit(false);
    end;

    local procedure fnMemberPostings(memberNumber: Code[20]; thisAmount: Decimal; thisDocNum: Code[30]) Result: Text;
    var
        shareCapitalAmount: Decimal;
        depositAmount: Decimal;
        welfareAmount: Decimal;
        postingAmount: Decimal;
        documentno: Code[30];
        Member: Record Customer;
    begin
        shareCapitalAmount := 0;
        depositAmount := 0;
        welfareAmount := 0;
        postingAmount := thisAmount;
        jnlBatchName := 'PAYBILL';
        jnlBatchTemplate := 'GENERAL';
        documentno := thisDocNum;
        LineNo := 10000;

        GenLedgerSetup.RESET;
        GenLedgerSetup.GET;
        GenLedgerSetup.TESTFIELD(GenLedgerSetup."SwizzKash Charge");
        GenLedgerSetup.TESTFIELD(GenLedgerSetup."Paybill C2b Account");

        PaybillRecon := GenLedgerSetup."Paybill C2b Account";

        //prepare the GL
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", jnlBatchTemplate);
        GenJournalLine.SetRange("Journal Batch Name", jnlBatchName);
        GenJournalLine.DeleteAll();

        //Post Loans
        if postingAmount > 0 then
            postingAmount := FnPostLoansBal(memberNumber, postingAmount, thisDocNum);

        //credit Shares Capital
        shareCapitalAmount := fnGetShareCapitalDeductions(memberNumber);
        if postingAmount < shareCapitalAmount then shareCapitalAmount := postingAmount;

        LineNo := LineNo + 10000;
        CreateGenJournalLine(jnlBatchTemplate, jnlBatchName, LineNo,
        documentno, "Gen. Journal Account Type"::Customer,
        memberNumber, memberNumber, 'Paybill deposit to Shares ' + memberNumber,
        -1 * shareCapitalAmount, Today, TransactionTypesEnum::"Share Capital");


        postingAmount := postingAmount - shareCapitalAmount;
        //Post Deposits
        depositAmount := fnGetDepositsContribution(memberNumber);
        if postingAmount < depositAmount then depositAmount := postingAmount;

        LineNo := LineNo + 10000;
        CreateGenJournalLine(jnlBatchTemplate, jnlBatchName, LineNo,
        documentno, "Gen. Journal Account Type"::Customer,
        memberNumber, memberNumber, 'Paybill to deposit Shares ' + memberNumber,
        -1 * depositAmount, Today, TransactionTypesEnum::"Deposit Contribution");

        postingAmount := postingAmount - depositAmount;
        //Post Wlefare
        welfareAmount := fnGetWelfareContribution(memberNumber);
        if postingAmount < welfareAmount then welfareAmount := postingAmount;

        if postingAmount > 0 then begin
            LineNo := LineNo + 10000;
            CreateGenJournalLine(jnlBatchTemplate, jnlBatchName, LineNo,
            documentno, "Gen. Journal Account Type"::Customer,
            memberNumber, memberNumber, 'Paybill deposit to Welfare ' + memberNumber,
            -1 * welfareAmount, Today, TransactionTypesEnum::"Welfare Contribution");

            postingAmount := postingAmount - welfareAmount;
        end;

        //post any remaining amount to deposits
        if postingAmount > 0 then begin
            LineNo := LineNo + 10000;
            CreateGenJournalLine(jnlBatchTemplate, jnlBatchName, LineNo,
            documentno, "Gen. Journal Account Type"::Customer,
            memberNumber, memberNumber, 'Paybill to deposit Shares ' + memberNumber,
            -1 * postingAmount, Today, TransactionTypesEnum::"Deposit Contribution");
        end;
        //post to bank - debit Mpesa Account
        LineNo := LineNo + 10000;
        GenJournalLine.INIT;
        GenJournalLine."Journal Template Name" := jnlBatchTemplate;
        GenJournalLine."Journal Batch Name" := jnlBatchName;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := GenJournalLine."Account Type"::"Bank Account";
        GenJournalLine."Account No." := PaybillRecon;
        GenJournalLine.VALIDATE(GenJournalLine."Account No.");
        GenJournalLine."Document No." := documentno;
        GenJournalLine."External Document No." := memberNumber;
        GenJournalLine."Source No." := memberNumber;
        GenJournalLine."Posting Date" := TODAY;
        GenJournalLine.Description := 'Paybill Deposit ' + swizzMobile.GetMemberNameCustomer(memberNumber);
        GenJournalLine.Amount := thisAmount;
        GenJournalLine.VALIDATE(GenJournalLine.Amount);
        IF GenJournalLine.Amount <> 0 THEN
            GenJournalLine.Insert();

        //Post
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", jnlBatchTemplate);
        GenJournalLine.SetRange("Journal Batch Name", jnlBatchName);
        if GenJournalLine.Find('-') then begin
            repeat
                GLPosting.Run(GenJournalLine);

            until GenJournalLine.Next = 0;

            PaybillTransTable.Posted := TRUE;
            PaybillTransTable."Date Posted" := TODAY;
            PaybillTransTable.Description := 'Posted';
            PaybillTransTable.Modify();

            Member.Get(memberNumber);

            msg := 'Dear ' + Member.Name + ', Your paybill deposit of KES. ' + FORMAT(thisAmount) +
                              ' has been posted successfuly .Thank you for using POLYTECH Sacco Mobile.';
            swizzMobile.SMSMessage('PAYBILL', Member."No.", Member."Mobile Phone No", msg);

            Result := 'Transaction posted Succesfully';
        end;
    end;

    procedure fnGetMemberNumber(parameter: Code[30]) memberNumber: Code[30]
    begin
        memberNumber := '';

        // 1. Try match by ID No.
        membersTable.Reset();
        membersTable.SetRange("ID No.", parameter);
        if membersTable.FindFirst() then begin
            memberNumber := membersTable."No.";
            exit;
        end;

        // 2. Try match by Member No.
        membersTable.Reset();
        membersTable.SetRange("No.", parameter);
        if membersTable.FindFirst() then begin
            memberNumber := membersTable."No.";
            exit;
        end;
    end;

    local procedure FnPostLoansBal(memberNumber: Code[20]; parsedAmount: Decimal; thisDocNum: Code[30]) remainingAmount: Decimal
    var
        loanNumber: Code[50];
    begin
        ASAT := Today;
        BeginMonth_Date := CalcDate('<-CM +14D>', ASAT);

        //Emergency_Loan_12_
        ApplyLoanCode(parsedAmount, memberNumber, '12', thisDocNum);

        //Super_Emergency_Loan_13_
        ApplyLoanCode(parsedAmount, memberNumber, '13', thisDocNum);

        //Quick_Loan_
        ApplyLoanCode(parsedAmount, memberNumber, '15', thisDocNum);

        //Super_Quick_Loan_loan
        ApplyLoanCode(parsedAmount, memberNumber, '16', thisDocNum);

        //School_fees_loan
        ApplyLoanCode(parsedAmount, memberNumber, '17', thisDocNum);

        //Super_school_fees_
        ApplyLoanCode(parsedAmount, memberNumber, '18', thisDocNum);

        //Investment_Loan_
        ApplyLoanCode(parsedAmount, memberNumber, '19', thisDocNum);

        //Normal_loan_20_
        ApplyLoanCode(parsedAmount, memberNumber, '20', thisDocNum);

        //Normal_loan_21_
        ApplyLoanCode(parsedAmount, memberNumber, '21', thisDocNum);

        //Normal_loan_22_
        ApplyLoanCode(parsedAmount, memberNumber, '22', thisDocNum);

        //Development_Loan_23_
        ApplyLoanCode(parsedAmount, memberNumber, '23', thisDocNum);

        //Development_Loan_25_
        ApplyLoanCode(parsedAmount, memberNumber, '25', thisDocNum);

        //Merchandise_Loan_26_
        ApplyLoanCode(parsedAmount, memberNumber, '26', thisDocNum);

        remainingAmount := parsedAmount;
    end;

    local procedure ApplyLoanCode(var parsedAmount: Decimal; memberNumber: Code[20]; loanCode: Code[10]; thisDocNum: Code[30])
    var
        loanBal: Decimal;
        loanInterest: Decimal;
        loanNo: Code[50];
    begin

        CalculateLoanRepayment(loanCode, loanBal, loanInterest, memberNumber, ASAT, BeginMonth_Date);
        if (loanBal <= 0) and (loanInterest <= 0) then exit;

        loanNo := fnGetLoanNumber(memberNumber, ASAT, loanCode);

        if parsedAmount < loanInterest then loanInterest := parsedAmount;
        if loanInterest > 0 then begin
            loanInterest := FnPostInterestBal(memberNumber, loanInterest, ASAT, loanCode, loanNo, thisDocNum);
            parsedAmount := parsedAmount - loanInterest;
        end;

        if parsedAmount < loanBal then loanBal := parsedAmount;
        if loanBal > 0 then begin
            loanBal := FnPostPrincipleBal(memberNumber, loanBal, loanNo, thisDocNum);
            parsedAmount := parsedAmount - loanBal;
        end;
    end;

    LOCAL PROCEDURE GetExciseDutyAccount() response: Code[20];
    VAR
        SaccoGenSetUpTable: Record "Sacco General Set-Up";
    BEGIN
        SaccoGenSetUpTable.RESET;
        SaccoGenSetUpTable.GET;
        SaccoGenSetUpTable.TESTFIELD("Excise Duty Account");
        response := SaccoGenSetUpTable."Excise Duty Account";
        EXIT(response);
    END;

    LOCAL PROCEDURE GetExciseDutyRate() response: Decimal;
    VAR
        SaccoGenSetUpTable: Record "Sacco General Set-Up";
    BEGIN
        SaccoGenSetUpTable.RESET;
        SaccoGenSetUpTable.GET;
        SaccoGenSetUpTable.TESTFIELD("Excise Duty(%)");
        response := SaccoGenSetUpTable."Excise Duty(%)" / 100;
        EXIT(response);
    END;

    LOCAL PROCEDURE GetCharge(amount: Decimal; code: Text[20]) charge: Decimal;
    BEGIN
        TariffDetails.RESET;
        TariffDetails.SETRANGE(TariffDetails.Code, code);
        TariffDetails.SETFILTER(TariffDetails."Lower Limit", '<=%1', amount);
        TariffDetails.SETFILTER(TariffDetails."Upper Limit", '>=%1', amount);
        IF TariffDetails.FIND('-') THEN BEGIN
            charge := TariffDetails."Charge Amount";
        END
    END;

    local procedure CreateGenJournalLine(BATCHTEMPLATE: code[20]; BATCHNAME: code[20]; linenumber: integer;
        documentno: code[20]; accounttype: enum "Gen. Journal Account Type";
                                               accountno: code[20];
                                               externaldocno: code[20];
                                               transactiondescription: text[50];
                                               transactionamount: Decimal;
                                               transactiondate: Date;
                                               TransactionType: Enum TransactionTypesEnum)
    begin
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := BATCHTEMPLATE;
        GenJournalLine."Journal Batch Name" := BATCHNAME;
        GenJournalLine."Line No." := linenumber;
        GenJournalLine."Document No." := documentno;
        GenJournalLine."Account Type" := accounttype;// GenJournalLine."account type"::Vendor;
        GenJournalLine."Account No." := accountno;// Vendor."No.";
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."External Document No." := externaldocno;// Vendor."No.";
        GenJournalLine."Posting Date" := transactiondate;// Today;
        GenJournalLine.Description := transactiondescription;// 'Mobile Transfer';
        GenJournalLine."Transaction Type" := TransactionType;//  ."Mobile Transaction Type" := TransactionType;// GenJournalLine."Mobile Transaction Type"::MobileTransactions;
        GenJournalLine.Amount := transactionamount;
        GenJournalLine.Validate(GenJournalLine.Amount);
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;
    end;

    procedure fnGetShareCapitalDeductions(memberNumber: Code[30]) ShareCapital: Decimal
    begin
        ShareCapital := 0;

        membersTable.Reset();
        membersTable.SetRange(membersTable."No.", memberNumber);
        membersTable.CalcFields("Shares Retained");
        if membersTable.FindFirst() then begin
            if membersTable."Shares Retained" >= 15000 then
                ShareCapital := 0
            else if membersTable."Shares Retained" >= 5000 then
                ShareCapital := 417
            else
                ShareCapital := 1000;
        end;
    end;

    procedure fnGetDepositsContribution(memberNumber: Code[30]) depositsContr: Decimal
    begin
        depositsContr := 0;
        membersTable.Reset();
        membersTable.SetRange(membersTable."No.", memberNumber);
        if membersTable.FindFirst() then begin
            depositsContr := membersTable."Monthly Contribution";
        end;
    end;

    procedure fnGetWelfareContribution(memberNumber: Code[30]) welfareContr: Decimal
    begin
        welfareContr := 0;
        membersTable.Reset();
        membersTable.SetRange(membersTable."No.", memberNumber);
        if membersTable.FindFirst() then begin
            welfareContr := membersTable."Welfare Contr";
        end;
    end;

    local procedure fnGetLoanNumber(
     memberNumber: Code[30];
     LoanCutoffDate: Date;
     loanCode: Code[10]
 ) loanNumber: Code[50]
    var
        LoansLocal: Record "Loans Register";
    begin
        loanNumber := '';

        // ---------------------------
        // STEP 1: FIND LOAN WITH PRINCIPAL OUTSTANDING
        // ---------------------------
        PrepareLoanFilter(LoansLocal, memberNumber, loanCode, LoanCutoffDate);

        if LoansLocal.FindSet() then begin
            repeat
                LoansLocal.CalcFields("Outstanding Balance");

                if LoansLocal."Outstanding Balance" > 0 then begin
                    loanNumber := LoansLocal."Loan  No.";
                    exit(loanNumber);   // EARLY EXIT
                end;

            until LoansLocal.Next() = 0;
        end;


        // ---------------------------
        // STEP 2: FIND LOAN WITH INTEREST OUTSTANDING
        // ---------------------------
        PrepareLoanFilter(LoansLocal, memberNumber, loanCode, LoanCutoffDate);

        if LoansLocal.FindSet() then begin
            repeat
                LoansLocal.CalcFields("Oustanding Interest");

                if LoansLocal."Oustanding Interest" > 0 then begin
                    loanNumber := LoansLocal."Loan  No.";
                    exit(loanNumber);   // EARLY EXIT
                end;

            until LoansLocal.Next() = 0;
        end;

        exit(loanNumber);
    end;


    local procedure PrepareLoanFilter(
        var LoansLocal: Record "Loans Register";
        memberNumber: Code[30];
        loanCode: Code[10];
        LoanCutoffDate: Date)
    begin
        LoansLocal.Reset;
        LoansLocal.SetRange("Client Code", memberNumber);
        LoansLocal.SetRange("Loan Product Type", loanCode);
        LoansLocal.SetFilter("Date filter", '..%1', LoanCutoffDate);

        // Latest first
        LoansLocal.SetCurrentKey("Client Code", "Application Date");
        LoansLocal.Ascending(false);
    end;

    local procedure FnGetMemberBranch(MemberNo: Code[50]): Code[100]
    var
        MemberBranch: Code[100];
    begin
        membersTable.Reset;
        membersTable.SetRange(membersTable."No.", MemberNo);
        if membersTable.Find('-') then begin
            MemberBranch := membersTable."Global Dimension 2 Code";
        end;
        exit(MemberBranch);
    end;

    local procedure FnPostInterestBal(memberNumber: Code[30]; postingAmount: Decimal; LoanCutoffDate: Date; loanCode: Code[10]; loanNumber: Code[50]; thisDocNum: Code[30]) AmountToDeduct: Decimal;
    var
        LoansRegisterLocal: Record "Loans Register";
    begin
        AmountToDeduct := 0;
        if postingAmount <= 0 then
            exit;

        // Use a local LoansRegister variable to be defensive (optional since you have global)
        LoansRegisterLocal := LoansRegister;
        LoansRegisterLocal.Reset;
        LoansRegisterLocal.SetRange(LoansRegisterLocal."Client Code", memberNumber);
        LoansRegisterLocal.SetRange(LoansRegisterLocal."Loan Product Type", loanCode);
        LoansRegisterLocal.SetRange(LoansRegisterLocal."Loan  No.", loanNumber);
        if not LoansRegisterLocal.FINDFIRST() then
            exit;

        // Post even if outstanding Interest is 0
        AmountToDeduct := postingAmount;

        if AmountToDeduct = 0 then
            exit;

        // Create Gen Journal Line for interest
        LineNo := LineNo + 10000;
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := jnlBatchTemplate;
        GenJournalLine."Journal Batch Name" := jnlBatchName;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := GenJournalLine."Account Type"::Customer;
        GenJournalLine."Account No." := LoansRegisterLocal."Client Code";
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Document No." := thisDocNum;
        GenJournalLine."Posting Date" := Today;
        GenJournalLine.Description := STRSUBSTNO('%1 - Loan Interest Paid', LoansRegisterLocal."Loan Product Type");
        GenJournalLine.Amount := -1 * AmountToDeduct;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::"Interest Paid";
        GenJournalLine."Loan No" := LoansRegisterLocal."Loan  No.";
        GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
        GenJournalLine."Shortcut Dimension 2 Code" := FnGetMemberBranch(LoansRegisterLocal."Client Code");
        // Validate dimensions (will throw if invalid)
        // GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        // GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");

        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;

        exit(AmountToDeduct);
    end;

    local procedure FnPostPrincipleBal(memberNumber: Code[30]; principalToApply: Decimal; loanNumber: Code[50]; thisDocNum: Code[30]) amountApplied: Decimal
    var
        LoansRegisterLocal: Record "Loans Register";
        OutstandingBal: Decimal;
        ToApply: Decimal;
    begin
        amountApplied := 0;
        if principalToApply <= 0 then
            exit;

        LoansRegisterLocal := LoansRegister;
        LoansRegisterLocal.Reset;
        LoansRegisterLocal.SetRange(LoansRegisterLocal."Client Code", memberNumber);
        LoansRegisterLocal.SetRange(LoansRegisterLocal."Loan  No.", loanNumber);
        if not LoansRegisterLocal.FINDFIRST() then
            exit;

        LoansRegisterLocal.CalcFields("Outstanding Balance");
        OutstandingBal := LoansRegisterLocal."Outstanding Balance";
        if OutstandingBal <= 0 then
            exit;

        // Determine how much we can apply (cap at outstanding principal)
        if principalToApply < OutstandingBal then
            ToApply := principalToApply
        else
            ToApply := OutstandingBal;

        if ToApply <= 0 then
            exit;

        // Create Gen Journal Line for principal repayment
        LineNo := LineNo + 10000;
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := jnlBatchTemplate;
        GenJournalLine."Journal Batch Name" := jnlBatchName;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := GenJournalLine."Account Type"::Customer;
        GenJournalLine."Account No." := LoansRegisterLocal."Client Code";
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Document No." := thisDocNum;
        GenJournalLine."Posting Date" := Today;
        GenJournalLine.Description := STRSUBSTNO('%1 - Loan Repayment', LoansRegisterLocal."Loan Product Type");
        GenJournalLine.Amount := -1 * ToApply;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::"Loan Repayment";
        GenJournalLine."Loan No" := LoansRegisterLocal."Loan  No.";
        GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
        GenJournalLine."Shortcut Dimension 2 Code" := FnGetMemberBranch(LoansRegisterLocal."Client Code");
        // GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        // GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");

        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;

        // Return amount actually applied
        amountApplied := ToApply;
        exit(amountApplied);
    end;

    procedure CalculateLoanRepayment(
    LoanProductType: Code[10];
    var Principal: Decimal;
    var Interest: Decimal;
    CustomerNo: Code[20];
    ASAT: Date;
    BeginMonthDate: Date
)
    var
        LoanRepaymentSchedule: Record "Loan Repayment Schedule";
    begin
        Principal := 0;
        Interest := 0;

        LoansRegister.Reset;
        LoansRegister.SetRange("Client Code", CustomerNo);
        LoansRegister.SetRange("Loan Product Type", LoanProductType);
        LoansRegister.SetRange(Posted, true);
        LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
        LoansRegister.SetAutoCalcFields("Outstanding Balance", "Oustanding Interest");
        LoansRegister.SetCurrentKey("Client Code", "Application Date");
        LoansRegister.SetFilter("Repayment Start Date", '..%1', ASAT);
        LoansRegister.Ascending(false); // latest loans first

        if not LoansRegister.FindSet() then
            exit;

        LoansRegister.CalcFields("Outstanding Balance", "Oustanding Interest", "Interest Due");

        // 2. Otherwise, try to find schedule entries within this month
        LoanRepaymentSchedule.Reset;
        LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
        LoanRepaymentSchedule.SetRange("Repayment Date", BeginMonthDate, ASAT);
        LoanRepaymentSchedule.SetFilter(LoanRepaymentSchedule."Repayment Date", '%1..%2', ASAT, CalcDate('CM', ASAT));

        if LoanRepaymentSchedule.FindLast() then begin
            // --- Calculate Principal ---
            if LoanRepaymentSchedule."Principal Repayment" > LoansRegister."Outstanding Balance" then
                Principal := ROUND(LoansRegister."Outstanding Balance", 1, '>')
            else
                Principal := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');

            // --- Calculate Interest ---
            if LoanRepaymentSchedule."Principal Repayment" < LoansRegister."Outstanding Balance" then
                Interest := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>')
            else
                Interest := ROUND(LoansRegister."Oustanding Interest", 1, '>');
        end else begin
            // No schedule found → fallback to balances
            Principal := ROUND(LoansRegister."Outstanding Balance", 1, '>');
            Interest := ROUND(LoansRegister."Oustanding Interest", 1, '>');

            LoanRepaymentSchedule.Reset;
            LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
            if LoanRepaymentSchedule.FindLast() then begin
                // --- Calculate Principal ---
                if LoanRepaymentSchedule."Principal Repayment" > LoansRegister."Outstanding Balance" then
                    Principal := ROUND(LoansRegister."Outstanding Balance", 1, '>')
                else
                    Principal := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');

                // --- Calculate Interest ---
                if LoanRepaymentSchedule."Principal Repayment" < LoansRegister."Outstanding Balance" then
                    Interest := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>')
                else
                    Interest := ROUND(LoansRegister."Oustanding Interest", 1, '>');
            end;
        end;
    end;

    LOCAL PROCEDURE PayBillToMWallet(batch: Code[20]; docNo: Code[20]; accNo: Code[120]; Amount: Decimal; accountType: Code[30]) res: Code[10];
    VAR
        accNum: Text[20];
    // PaybillTransTable: Record "Polytech Paybill Transactions";
    BEGIN

        PaybillTransTable.RESET;
        PaybillTransTable.SETRANGE("Document No", docNo);
        PaybillTransTable.SETRANGE(Posted, FALSE);
        IF PaybillTransTable.FIND('-') THEN BEGIN

            GenLedgerSetup.RESET;
            GenLedgerSetup.GET;
            GenLedgerSetup.TESTFIELD(GenLedgerSetup."SwizzKash Charge");
            GenLedgerSetup.TESTFIELD(GenLedgerSetup."Paybill C2b Account");

            PaybillRecon := GenLedgerSetup."Paybill C2b Account";
            SurePESACharge := GetCharge(Amount, 'PAYBILL');
            SwizzKASHCommACC := GenLedgerSetup."SwizzKash Comm Acc";

            exciseDutyAcc := GetExciseDutyAccount();
            ExcDuty := GetExciseDutyRate() * (SurePESACharge);

            //begin of deletion
            GenJournalLine.RESET;
            GenJournalLine.SETRANGE("Journal Template Name", 'GENERAL');
            GenJournalLine.SETRANGE("Journal Batch Name", batch);
            GenJournalLine.DELETEALL;
            //end of deletion

            GenBatches.RESET;
            GenBatches.SETRANGE(GenBatches."Journal Template Name", 'GENERAL');
            GenBatches.SETRANGE(GenBatches.Name, batch);
            IF GenBatches.FIND('-') = FALSE THEN BEGIN
                GenBatches.INIT;
                GenBatches."Journal Template Name" := 'GENERAL';
                GenBatches.Name := batch;
                GenBatches.Description := 'Paybill Deposit';
                GenBatches.VALIDATE(GenBatches."Journal Template Name");
                GenBatches.VALIDATE(GenBatches.Name);
                GenBatches.INSERT;
            END;
            //General Jnr Batches



            vendorsTable.RESET;
            vendorsTable.SETRANGE(vendorsTable."No.", accNo);
            vendorsTable.SETRANGE(vendorsTable."Account Type", accountType);
            IF vendorsTable.FIND('-') THEN BEGIN

                //Dr MPESA PAybill ACC
                LineNo := LineNo + 10000;
                GenJournalLine.INIT;
                GenJournalLine."Journal Template Name" := 'GENERAL';
                GenJournalLine."Journal Batch Name" := batch;
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."Account Type"::"Bank Account";
                GenJournalLine."Account No." := PaybillRecon;
                GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                GenJournalLine."Document No." := docNo;
                GenJournalLine."External Document No." := vendorsTable."No.";
                GenJournalLine."Source No." := vendorsTable."No.";
                GenJournalLine."Posting Date" := TODAY;
                GenJournalLine.Description := 'Paybill Deposit ' + vendorsTable.Name;
                GenJournalLine.Amount := Amount;
                GenJournalLine.VALIDATE(GenJournalLine.Amount);
                IF GenJournalLine.Amount <> 0 THEN
                    GenJournalLine.INSERT;

                //Cr Customer
                LineNo := LineNo + 10000;
                GenJournalLine.INIT;
                GenJournalLine."Journal Template Name" := 'GENERAL';
                GenJournalLine."Journal Batch Name" := batch;
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."Account Type"::Vendor;
                GenJournalLine."Account No." := vendorsTable."No.";
                GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                GenJournalLine."Document No." := docNo;
                GenJournalLine."External Document No." := vendorsTable."No.";
                GenJournalLine."Posting Date" := TODAY;
                GenJournalLine."Mobile Transaction Type" := GenJournalLine."Mobile Transaction Type"::MobileTransactions;
                GenJournalLine.Description := 'Paybill Deposit ' + vendorsTable.Name;
                GenJournalLine.Amount := -1 * Amount;
                GenJournalLine.VALIDATE(GenJournalLine.Amount);
                IF GenJournalLine.Amount <> 0 THEN
                    GenJournalLine.INSERT;

                //Dr Customer charges
                LineNo := LineNo + 10000;
                GenJournalLine.INIT;
                GenJournalLine."Journal Template Name" := 'GENERAL';
                GenJournalLine."Journal Batch Name" := batch;
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."Account Type"::Vendor;
                GenJournalLine."Account No." := vendorsTable."No.";
                GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                GenJournalLine."Document No." := docNo;
                GenJournalLine."External Document No." := vendorsTable."No.";
                GenJournalLine."Posting Date" := TODAY;
                GenJournalLine."Mobile Transaction Type" := GenJournalLine."Mobile Transaction Type"::MobileTransactionCharges;
                GenJournalLine.Description := 'Paybill Deposit Charges ' + vendorsTable.Name;
                GenJournalLine.Amount := SurePESACharge;
                GenJournalLine.VALIDATE(GenJournalLine.Amount);
                IF GenJournalLine.Amount <> 0 THEN
                    GenJournalLine.INSERT;

                //DR Excise Duty
                LineNo := LineNo + 10000;
                GenJournalLine.INIT;
                GenJournalLine."Journal Template Name" := 'GENERAL';
                GenJournalLine."Journal Batch Name" := batch;
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."Account Type"::Vendor;
                GenJournalLine."Account No." := vendorsTable."No.";
                GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                GenJournalLine."Document No." := docNo;
                GenJournalLine."External Document No." := vendorsTable."No.";
                GenJournalLine."Posting Date" := TODAY;
                GenJournalLine."Mobile Transaction Type" := GenJournalLine."Mobile Transaction Type"::ExciseDuty;
                GenJournalLine.Description := 'Excise duty-Paybill Deposit ' + vendorsTable.Name;
                GenJournalLine.Amount := ExcDuty;
                GenJournalLine.VALIDATE(GenJournalLine.Amount);
                IF GenJournalLine.Amount <> 0 THEN
                    GenJournalLine.INSERT;


                //CR Excise Duty
                LineNo := LineNo + 10000;
                GenJournalLine.INIT;
                GenJournalLine."Journal Template Name" := 'GENERAL';
                GenJournalLine."Journal Batch Name" := batch;
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."Account Type"::"G/L Account";
                GenJournalLine."Account No." := exciseDutyAcc;//FORMAT(ExxcDuty);
                GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                GenJournalLine."Document No." := docNo;
                GenJournalLine."External Document No." := vendorsTable."No.";
                GenJournalLine."Posting Date" := TODAY;
                GenJournalLine.Description := 'Excise duty-Paybill deposit ' + vendorsTable.Name;
                GenJournalLine.Amount := ExcDuty * -1;
                GenJournalLine.VALIDATE(GenJournalLine.Amount);
                IF GenJournalLine.Amount <> 0 THEN
                    GenJournalLine.INSERT;

                //CR Swizzsoft Acc
                LineNo := LineNo + 10000;
                GenJournalLine.INIT;
                GenJournalLine."Journal Template Name" := 'GENERAL';
                GenJournalLine."Journal Batch Name" := batch;
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."Account Type"::"G/L Account";
                GenJournalLine."Account No." := SwizzKASHCommACC;
                GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                GenJournalLine."Document No." := docNo;
                GenJournalLine."Source No." := vendorsTable."No.";
                GenJournalLine."External Document No." := vendorsTable."No.";
                GenJournalLine."Posting Date" := TODAY;
                GenJournalLine.Description := 'Mobile Deposit Charges ' + vendorsTable.Name;
                GenJournalLine.Amount := -SurePESACharge;
                GenJournalLine.VALIDATE(GenJournalLine.Amount);
                IF GenJournalLine.Amount <> 0 THEN
                    GenJournalLine.INSERT;

                //Post
                GenJournalLine.RESET;
                GenJournalLine.SETRANGE("Journal Template Name", 'GENERAL');
                GenJournalLine.SETRANGE("Journal Batch Name", batch);
                IF GenJournalLine.FIND('-') THEN BEGIN
                    REPEAT
                        GLPosting.RUN(GenJournalLine);
                    UNTIL GenJournalLine.NEXT = 0;
                    PaybillTransTable.Posted := TRUE;
                    PaybillTransTable."Date Posted" := TODAY;
                    PaybillTransTable.Remarks := 'Posted';
                    PaybillTransTable.MODIFY;
                    res := 'TRUE';
                    msg := 'Dear ' + vendorsTable.Name + ', Your ACC: ' + vendorsTable."No." + ' has been credited with KES. ' + FORMAT(Amount) +
                                ' .Thank you, POLYTECH Sacco Mobile.';
                    swizzMobile.SMSMessage('PAYBILL', vendorsTable."No.", vendorsTable."Phone No.", msg);
                END ELSE BEGIN
                    PaybillTransTable."Date Posted" := TODAY;
                    PaybillTransTable."Needs Manual Posting" := TRUE;
                    PaybillTransTable.Remarks := 'Failed Posting';
                    PaybillTransTable.MODIFY;
                    res := 'FALSE';
                END;

            END ELSE BEGIN//vendorsTable
                PaybillTransTable."Date Posted" := TODAY;
                PaybillTransTable."Needs Manual Posting" := TRUE;
                PaybillTransTable.Remarks := 'Failed,FOSAACCNOTFOUND';
                PaybillTransTable.MODIFY;
                res := 'FALSE';
            END;//vendorsTable

        END;
    END;

    LOCAL PROCEDURE PayBillToLoanAll(batch: Code[20]; docNo: Code[20]; accNo: Code[120]; memberNo: Code[120]; amount: Decimal; type1: Code[30]) res: Code[10];
    VAR
        isPosted: Boolean;
        runningBalance: Decimal;
        objMember: Record Customer;
    BEGIN
        GenLedgerSetup.RESET;
        GenLedgerSetup.GET;
        GenLedgerSetup.TESTFIELD(GenLedgerSetup."SwizzKash Comm Acc");
        GenLedgerSetup.TESTFIELD(GenLedgerSetup."Paybill C2b Account");
        GenLedgerSetup.TESTFIELD(GenLedgerSetup."SwizzKash Charge");

        SwizzKASHCommACC := GenLedgerSetup."SwizzKash Comm Acc";
        SurePESACharge := GetCharge(amount, 'PAYBILL');
        PaybillRecon := GenLedgerSetup."Paybill C2b Account";

        exciseDutyAcc := GetExciseDutyAccount();
        ExcDuty := GetExciseDutyRate() * (SurePESACharge);

        GenJournalLine.RESET;
        GenJournalLine.SETRANGE("Journal Template Name", 'GENERAL');
        GenJournalLine.SETRANGE("Journal Batch Name", batch);
        GenJournalLine.DELETEALL;
        //end of deletion



        GenBatches.RESET;
        GenBatches.SETRANGE(GenBatches."Journal Template Name", 'GENERAL');
        GenBatches.SETRANGE(GenBatches.Name, batch);

        IF GenBatches.FIND('-') = FALSE THEN BEGIN
            GenBatches.INIT;
            GenBatches."Journal Template Name" := 'GENERAL';
            GenBatches.Name := batch;
            GenBatches.Description := 'Paybill Loan Repayment';
            GenBatches.VALIDATE(GenBatches."Journal Template Name");
            GenBatches.VALIDATE(GenBatches.Name);
            GenBatches.INSERT;
        END;//General Jnr Batches

        LoansRegister.RESET;
        LoansRegister.SETRANGE(LoansRegister."Loan  No.", accNo);
        // LoansRegister.SETRANGE(LoansRegister."Client Code", membersTable."No.");
        IF LoansRegister.FIND('-') THEN BEGIN

            objMember.Reset();
            objMember.SetRange(objMember."No.", LoansRegister."Client Code");
            if objMember.Find('-') then begin

                isPosted := FALSE;
                //MESSAGE('found %1',LoansRegister."Loan  No.");
                REPEAT

                    LoansRegister.CALCFIELDS(LoansRegister."Outstanding Balance", LoansRegister."Oustanding Interest");

                    //MESSAGE('outbal %1',LoansRegister."Outstanding Balance");

                    IF LoansRegister."Outstanding Balance" > 0 THEN BEGIN
                        isPosted := TRUE;// flag to exit loop when loan bal is found


                        //Dr MPESA PAybill ACC
                        LineNo := LineNo + 10000;
                        GenJournalLine.INIT;
                        GenJournalLine."Journal Template Name" := 'GENERAL';
                        GenJournalLine."Journal Batch Name" := batch;
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."Account Type"::"Bank Account";
                        GenJournalLine."Account No." := PaybillRecon;
                        GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                        GenJournalLine."Document No." := docNo;
                        GenJournalLine."External Document No." := docNo;
                        GenJournalLine."Posting Date" := TODAY;
                        GenJournalLine."Source No." := objMember."No.";
                        GenJournalLine.Description := 'Paybill Loan Repayment' + ' ' + objMember.Name;
                        GenJournalLine.Amount := amount;
                        GenJournalLine.VALIDATE(GenJournalLine.Amount);
                        IF GenJournalLine.Amount <> 0 THEN
                            GenJournalLine.INSERT;

                        IF LoansRegister."Oustanding Interest" > 0 THEN BEGIN
                            LineNo := LineNo + 10000;
                            GenJournalLine.INIT;
                            GenJournalLine."Journal Template Name" := 'GENERAL';
                            GenJournalLine."Journal Batch Name" := batch;
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."Account Type"::Customer;
                            GenJournalLine."Account No." := LoansRegister."Client Code";
                            GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                            GenJournalLine."Document No." := docNo;
                            GenJournalLine."External Document No." := LoansRegister."Client Code";
                            GenJournalLine."Posting Date" := TODAY;
                            GenJournalLine.Description := 'Loan Interest Payment ' + objMember.Name;
                            IF amount > LoansRegister."Oustanding Interest" THEN
                                GenJournalLine.Amount := -LoansRegister."Oustanding Interest"
                            ELSE
                                GenJournalLine.Amount := -amount;
                            GenJournalLine.VALIDATE(GenJournalLine.Amount);
                            GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::"Interest Paid";

                            IF GenJournalLine."Shortcut Dimension 1 Code" = '' THEN BEGIN
                                GenJournalLine."Shortcut Dimension 1 Code" := membersTable."Global Dimension 1 Code";
                                GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                            END;
                            GenJournalLine."Loan No" := LoansRegister."Loan  No.";
                            IF GenJournalLine.Amount <> 0 THEN
                                GenJournalLine.INSERT;

                            amount := amount + GenJournalLine.Amount;
                        END;

                        IF amount > 0 THEN BEGIN
                            LineNo := LineNo + 10000;
                            GenJournalLine.INIT;
                            GenJournalLine."Journal Template Name" := 'GENERAL';
                            GenJournalLine."Journal Batch Name" := batch;
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."Account Type"::Customer;
                            GenJournalLine."Account No." := LoansRegister."Client Code";
                            GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                            GenJournalLine."Document No." := docNo;
                            GenJournalLine."External Document No." := LoansRegister."Client Code";
                            GenJournalLine."Posting Date" := TODAY;
                            GenJournalLine.Description := 'Paybill Loan Repayment ' + objMember.Name;
                            GenJournalLine.Amount := -amount;
                            GenJournalLine.VALIDATE(GenJournalLine.Amount);
                            GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::"Loan Repayment";
                            IF GenJournalLine."Shortcut Dimension 1 Code" = '' THEN BEGIN
                                GenJournalLine."Shortcut Dimension 1 Code" := membersTable."Global Dimension 1 Code";
                                GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                            END;
                            GenJournalLine."Loan No" := LoansRegister."Loan  No.";
                            IF GenJournalLine.Amount <> 0 THEN
                                GenJournalLine.INSERT;
                        END;

                        //DR membersTable Acc
                        LineNo := LineNo + 10000;
                        GenJournalLine.INIT;
                        GenJournalLine."Journal Template Name" := 'GENERAL';
                        GenJournalLine."Journal Batch Name" := batch;
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."Account Type"::Customer;
                        GenJournalLine."Account No." := objMember."No.";
                        GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                        GenJournalLine."Document No." := docNo;
                        GenJournalLine."External Document No." := objMember."No.";
                        GenJournalLine."Posting Date" := TODAY;
                        GenJournalLine.Description := 'Paybill Loan Repayment ' + objMember.Name;
                        GenJournalLine.Amount := SurePESACharge + ExcDuty;
                        GenJournalLine.VALIDATE(GenJournalLine.Amount);
                        IF GenJournalLine.Amount <> 0 THEN
                            GenJournalLine.INSERT;


                        //Distribute overpayment to deposits
                        //            runningBalance:=0;
                        //            runningBalance:=amount+GenJournalLine.Amount;
                        //
                        //            IF runningBalance>0 THEN BEGIN
                        //              LineNo:=LineNo+10000;
                        //              GenJournalLine.INIT;
                        //              GenJournalLine."Journal Template Name":='GENERAL';
                        //              GenJournalLine."Journal Batch Name":=batch;
                        //              GenJournalLine."Line No.":=LineNo;
                        //              GenJournalLine."Account Type":=GenJournalLine."Account Type"::Customer;
                        //              GenJournalLine."Account No.":=membersTable."No.";
                        //              GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                        //              GenJournalLine."Document No.":=docNo;
                        //              GenJournalLine."External Document No.":=docNo;
                        //              GenJournalLine."Posting Date":=TODAY;
                        //              GenJournalLine."Transaction Type":= GenJournalLine."Transaction Type"::"Deposit Contribution";
                        //              GenJournalLine.Description:='Paybill to M-Wallet Loan Overpayment';
                        //              GenJournalLine.Amount:=-runningBalance;
                        //              GenJournalLine.VALIDATE(GenJournalLine.Amount);
                        //              IF GenJournalLine.Amount<>0 THEN
                        //              GenJournalLine.INSERT;
                        //            END;

                        //CR Excise Duty
                        LineNo := LineNo + 10000;
                        GenJournalLine.INIT;
                        GenJournalLine."Journal Template Name" := 'GENERAL';
                        GenJournalLine."Journal Batch Name" := batch;
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."Account Type"::"G/L Account";
                        GenJournalLine."Account No." := exciseDutyAcc;// FORMAT(ExxcDuty);
                        GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                        GenJournalLine."Document No." := docNo;
                        GenJournalLine."External Document No." := objMember."No.";
                        GenJournalLine."Posting Date" := TODAY;
                        GenJournalLine.Description := 'Excise duty-' + 'Paybill Loan Repayment ' + objMember.Name;
                        GenJournalLine.Amount := ExcDuty * -1;
                        GenJournalLine.VALIDATE(GenJournalLine.Amount);
                        IF GenJournalLine.Amount <> 0 THEN
                            GenJournalLine.INSERT;

                        //CR Swizzsoft Acc
                        LineNo := LineNo + 10000;
                        GenJournalLine.INIT;
                        GenJournalLine."Journal Template Name" := 'GENERAL';
                        GenJournalLine."Journal Batch Name" := batch;
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."Account Type"::"G/L Account";
                        //GenJournalLine."Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
                        GenJournalLine."Account No." := SwizzKASHCommACC;
                        GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                        GenJournalLine."Document No." := docNo;
                        GenJournalLine."External Document No." := objMember."No.";
                        GenJournalLine."Posting Date" := TODAY;
                        GenJournalLine."Mobile Transaction Type" := GenJournalLine."Mobile Transaction Type"::MobileTransactionCharges;
                        GenJournalLine.Description := 'Paybill Loan Repayment' + ' Charges ' + objMember.Name;
                        GenJournalLine.Amount := -SurePESACharge;
                        GenJournalLine.VALIDATE(GenJournalLine.Amount);
                        IF GenJournalLine.Amount <> 0 THEN
                            GenJournalLine.INSERT;

                        //Post
                        GenJournalLine.RESET;
                        GenJournalLine.SETRANGE("Journal Template Name", 'GENERAL');
                        GenJournalLine.SETRANGE("Journal Batch Name", batch);
                        IF GenJournalLine.FIND('-') THEN BEGIN
                            REPEAT
                                GLPosting.RUN(GenJournalLine);
                            UNTIL GenJournalLine.NEXT = 0;
                            PaybillTransTable.Posted := TRUE;
                            PaybillTransTable."Date Posted" := TODAY;
                            PaybillTransTable.Remarks := 'Posted';
                            PaybillTransTable.MODIFY;
                            res := 'TRUE';
                            isPosted := TRUE;
                            msg := 'Dear ' + objMember.Name + ', your payment of KES. ' + FORMAT(PaybillTransTable.Amount) +
                                      ' for loan: ' + LoansRegister."Loan  No." + '-' + LoansRegister."Loan Product Type Name"
                                  + ' has been received.Thank you, POLYTECH NON-WDT SACCO Mobile.';
                            swizzMobile.SMSMessage('PAYBILL', objMember."No.", objMember."Mobile Phone No", msg);

                        END ELSE BEGIN
                            PaybillTransTable."Date Posted" := TODAY;
                            PaybillTransTable."Needs Manual Posting" := TRUE;
                            PaybillTransTable.Remarks := 'Failed Posting';
                            PaybillTransTable.MODIFY;
                            res := 'FALSE';
                            isPosted := TRUE;
                        END;
                    END ELSE BEGIN
                        //MESSAGE('0 balance');
                        isPosted := FALSE;
                    END;//Outstanding Balance

                    IF isPosted = TRUE THEN BREAK;

                UNTIL (LoansRegister.NEXT = 0);

                IF isPosted = FALSE THEN BEGIN
                    PaybillTransTable."Date Posted" := TODAY;
                    PaybillTransTable."Needs Manual Posting" := TRUE;
                    PaybillTransTable.Remarks := 'NOOUTSTANDINGBALANCE';
                    PaybillTransTable.MODIFY;
                    res := 'FALSE';
                    isPosted := TRUE;
                END;
            end;

        END ELSE BEGIN
            PaybillTransTable."Date Posted" := TODAY;
            PaybillTransTable."Needs Manual Posting" := TRUE;
            PaybillTransTable.Remarks := 'LOANNOTFOUND';
            PaybillTransTable.MODIFY;
            res := 'FALSE';
        END;//Loan Register


    END;

    LOCAL PROCEDURE PayBillToBOSA(batch: Code[20]; docNo: Code[20]; accNo: Code[120]; memberNo: Code[120]; amount: Decimal; type: Code[30]; descr: Text[100]) res: Code[10];
    BEGIN
        //MESSAGE('in bosa, accno %1',accNo);
        PaybillTransTable.RESET;
        PaybillTransTable.SETRANGE("Document No", docNo);
        PaybillTransTable.SETRANGE(Posted, FALSE);
        IF PaybillTransTable.FIND('-') THEN BEGIN
            //MESSAGE('in bosa doc search');
            GenLedgerSetup.RESET;
            GenLedgerSetup.GET;
            GenLedgerSetup.TESTFIELD(GenLedgerSetup."SwizzKash Comm Acc");
            GenLedgerSetup.TESTFIELD(GenLedgerSetup."Paybill C2b Account");
            GenLedgerSetup.TESTFIELD(GenLedgerSetup."SwizzKash Charge");

            SwizzKASHCommACC := GenLedgerSetup."SwizzKash Comm Acc";
            SurePESACharge := GetCharge(amount, 'PAYBILL');
            PaybillRecon := GenLedgerSetup."Paybill C2b Account";


            exciseDutyAcc := GetExciseDutyAccount();
            ExcDuty := GetExciseDutyRate() * (SurePESACharge);

            GenJournalLine.RESET;
            GenJournalLine.SETRANGE("Journal Template Name", 'GENERAL');
            GenJournalLine.SETRANGE("Journal Batch Name", batch);
            GenJournalLine.DELETEALL;
            //end of deletion

            GenBatches.RESET;
            GenBatches.SETRANGE(GenBatches."Journal Template Name", 'GENERAL');
            GenBatches.SETRANGE(GenBatches.Name, batch);

            IF GenBatches.FIND('-') = FALSE THEN BEGIN
                GenBatches.INIT;
                GenBatches."Journal Template Name" := 'GENERAL';
                GenBatches.Name := batch;
                GenBatches.Description := descr;
                GenBatches.VALIDATE(GenBatches."Journal Template Name");
                GenBatches.VALIDATE(GenBatches.Name);
                GenBatches.INSERT;
            END;//General Jnr Batches
                //..........................................................................................................
            IF type = 'NON' THEN BEGIN
                //Dr MPESA PAybill ACC
                LineNo := LineNo + 10000;
                GenJournalLine.INIT;
                GenJournalLine."Journal Template Name" := 'GENERAL';
                GenJournalLine."Journal Batch Name" := batch;
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."Account Type"::"Bank Account";
                GenJournalLine."Account No." := PaybillRecon;
                GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                GenJournalLine."Document No." := docNo;
                GenJournalLine."External Document No." := docNo;
                GenJournalLine."Posting Date" := TODAY;
                GenJournalLine.Description := descr + ' ' + swizzMobile.GetMemberNameCustomer(accNo);
                GenJournalLine.Amount := amount;
                GenJournalLine.VALIDATE(GenJournalLine.Amount);
                IF GenJournalLine.Amount <> 0 THEN
                    GenJournalLine.INSERT;

                //Cr Customer
                LineNo := LineNo + 10000;
                GenJournalLine.INIT;
                GenJournalLine."Journal Template Name" := 'GENERAL';
                GenJournalLine."Journal Batch Name" := batch;
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."Account Type"::Customer;
                GenJournalLine."Account No." := accNo;
                GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                GenJournalLine."Document No." := docNo;
                GenJournalLine."External Document No." := accNo;
                GenJournalLine."Posting Date" := TODAY;
                GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::"Deposit Contribution";
                GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                GenJournalLine.Description := descr + ' ' + swizzMobile.GetMemberNameCustomer(accNo);
                GenJournalLine.Amount := (amount) * -1;
                GenJournalLine.VALIDATE(GenJournalLine.Amount);
                IF GenJournalLine.Amount <> 0 THEN
                    GenJournalLine.INSERT;

                GenJournalLine.RESET;
                GenJournalLine.SETRANGE("Journal Template Name", 'GENERAL');
                GenJournalLine.SETRANGE("Journal Batch Name", batch);
                IF GenJournalLine.FIND('-') THEN BEGIN
                    REPEAT
                        GLPosting.RUN(GenJournalLine);
                    UNTIL GenJournalLine.NEXT = 0;
                    PaybillTransTable.Posted := TRUE;
                    PaybillTransTable."Date Posted" := TODAY;
                    PaybillTransTable.Description := 'Posted';
                    PaybillTransTable.MODIFY;
                    res := 'TRUE';
                END
                ELSE BEGIN
                    PaybillTransTable."Date Posted" := TODAY;
                    PaybillTransTable."Needs Manual Posting" := TRUE;
                    PaybillTransTable.Description := 'Failed Posting';
                    PaybillTransTable.MODIFY;
                    res := 'FALSE';
                END;
                EXIT;
            END;
            //............................................................................................................
            membersTable.RESET;
            membersTable.SETRANGE("No.", accNo);
            IF membersTable.FIND('-') THEN BEGIN

                //Dr MPESA PAybill ACC
                LineNo := LineNo + 10000;
                GenJournalLine.INIT;
                GenJournalLine."Journal Template Name" := 'GENERAL';
                GenJournalLine."Journal Batch Name" := batch;
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."Account Type"::"Bank Account";
                GenJournalLine."Account No." := PaybillRecon;
                GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                GenJournalLine."Document No." := docNo;
                GenJournalLine."External Document No." := membersTable."No.";
                GenJournalLine."Posting Date" := TODAY;
                GenJournalLine.Description := descr + membersTable.Name;
                GenJournalLine.Amount := amount;
                GenJournalLine.VALIDATE(GenJournalLine.Amount);
                IF GenJournalLine.Amount <> 0 THEN
                    GenJournalLine.INSERT;

                //Cr Customer
                LineNo := LineNo + 10000;
                GenJournalLine.INIT;
                GenJournalLine."Journal Template Name" := 'GENERAL';
                GenJournalLine."Journal Batch Name" := batch;
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."Account Type"::Customer;
                GenJournalLine."Account No." := membersTable."No.";
                GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                GenJournalLine."Document No." := docNo;
                GenJournalLine."External Document No." := membersTable."No.";
                GenJournalLine."Posting Date" := TODAY;
                //MESSAGE('Test keyword type %1',PaybillTransTable."Key Word");
                CASE UPPERCASE(PaybillTransTable."Key Word") OF
                    'MSD':
                        GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::"Share Capital";
                    'SHC':
                        GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::"Share Capital";
                    'SHA':
                        GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::"Share Capital";
                    'JTS':
                        GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::"Share Capital";
                    'GSD':
                        GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::"Deposit Contribution";
                    'GPS':
                        GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::"Deposit Contribution";
                    'SHD':
                        GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::"Deposit Contribution";
                    'DEP':
                        GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::"Deposit Contribution";
                    'JTD':
                        GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::"Deposit Contribution";
                    'BVF':
                        GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::"Benevolent Fund";
                END;

                IF GenJournalLine."Shortcut Dimension 1 Code" = '' THEN BEGIN
                    GenJournalLine."Shortcut Dimension 1 Code" := membersTable."Global Dimension 1 Code";
                    GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                END;

                GenJournalLine.Description := descr;
                GenJournalLine.Amount := (amount - SurePESACharge - ExcDuty) * -1;
                GenJournalLine.VALIDATE(GenJournalLine.Amount);
                IF GenJournalLine.Amount <> 0 THEN
                    GenJournalLine.INSERT;

                //CR Excise Duty
                LineNo := LineNo + 10000;
                GenJournalLine.INIT;
                GenJournalLine."Journal Template Name" := 'GENERAL';
                GenJournalLine."Journal Batch Name" := batch;
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."Account Type"::"G/L Account";
                //GenJournalLine."Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
                GenJournalLine."Account No." := exciseDutyAcc;//FORMAT(ExxcDuty);
                GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                GenJournalLine."Document No." := docNo;
                GenJournalLine."External Document No." := membersTable."No.";
                GenJournalLine."Posting Date" := TODAY;
                GenJournalLine.Description := 'Excise duty-' + descr + ' ' + membersTable.Name;
                GenJournalLine.Amount := ExcDuty * -1;
                GenJournalLine.VALIDATE(GenJournalLine.Amount);
                IF GenJournalLine.Amount <> 0 THEN
                    GenJournalLine.INSERT;

                //CR Swizzsoft Acc
                LineNo := LineNo + 10000;
                GenJournalLine.INIT;
                GenJournalLine."Journal Template Name" := 'GENERAL';
                GenJournalLine."Journal Batch Name" := batch;
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."Account Type"::"G/L Account";
                GenJournalLine."Account No." := SwizzKASHCommACC;
                GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                GenJournalLine."Document No." := docNo;
                GenJournalLine."External Document No." := docNo;
                GenJournalLine."Posting Date" := TODAY;
                GenJournalLine.Description := descr + ' Charges'' ' + membersTable.Name;
                GenJournalLine.Amount := -SurePESACharge;
                GenJournalLine.VALIDATE(GenJournalLine.Amount);
                IF GenJournalLine.Amount <> 0 THEN
                    GenJournalLine.INSERT;

                //Post
                GenJournalLine.RESET;
                GenJournalLine.SETRANGE("Journal Template Name", 'GENERAL');
                GenJournalLine.SETRANGE("Journal Batch Name", batch);
                IF GenJournalLine.FIND('-') THEN BEGIN
                    REPEAT
                        GLPosting.RUN(GenJournalLine);
                    UNTIL GenJournalLine.NEXT = 0;
                    PaybillTransTable.Posted := TRUE;
                    PaybillTransTable."Date Posted" := TODAY;
                    PaybillTransTable.Remarks := 'Posted';
                    PaybillTransTable.MODIFY;
                    res := 'TRUE';
                    msg := 'Dear ' + membersTable.Name + ', Your ACC: ' + accNo + ' has been credited with KES. ' + FORMAT(amount) +
                              ' .Thank you for using POLYTECH Sacco Mobile.';
                    swizzMobile.SMSMessage('PAYBILL', membersTable."No.", membersTable."Mobile Phone No", msg);
                END ELSE BEGIN
                    PaybillTransTable."Date Posted" := TODAY;
                    PaybillTransTable."Needs Manual Posting" := TRUE;
                    PaybillTransTable.Remarks := 'Failed Posting';
                    PaybillTransTable.MODIFY;
                    res := 'FALSE';
                END;

            END ELSE BEGIN
                PaybillTransTable."Date Posted" := TODAY;
                PaybillTransTable."Needs Manual Posting" := TRUE;
                PaybillTransTable.Remarks := 'MEMBERNOTFOUND';
                PaybillTransTable.MODIFY;
                res := 'FALSE';
            END;//Member

        END;
    END;

}
