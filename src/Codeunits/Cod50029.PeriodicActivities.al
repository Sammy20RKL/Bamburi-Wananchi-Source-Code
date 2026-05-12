#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 50029 "Periodic Activities"
{

    trigger OnRun()
    var
        DailyLoansInterestBuffer: Record "File Types SetUp";
    begin
        //GenerateDailyInterest(DailyLoansInterestBuffer);
        //FnCheckForMissingBalAccounts('LNB46220');
    end;

    var
        LoanNo: Code[20];
        BDate: Date;
        BalDate: Date;
        ProdFact: Record "Loan Products Setup";
        InterestAmount: Decimal;
        iEntryNo: Integer;
        Temp: Record "Funds User Setup";
        CreditAccounts: Record Customer;
        GenerationDate: Date;
        LoansRegisterTable: Record "Loans Register";
        ProductCode: Code[10];
        FoundProductInterestAccount: Code[10];


    procedure GenerateLoanMonthlyInterest(var LoanNo: Code[20]; BDate: Date)
    var
        Loans: Record "Loans Register";
        LoanType: Record 51381;
        Gnljnline: Record "Gen. Journal Line";
        LineNo: Integer;
        DocNo: Code[20];
        PDate: Date;
        "Document No.": Code[20];
        InterestHeader: Record 51296;
        LoansInterest: Record 51295;
        LoanAmount: Decimal;
        CustMember: Record Vendor;
        CurrDate: Date;
        FirstMonthDate: Date;
        CurrMonth: Date;
        MidDate: Date;
        EndDate: Date;
        LastMonthDate: Date;
        FirstDay: Date;
        FirstDate: Date;
        IntCharged: Decimal;
        Principle: Decimal;
        DailyLoansInterest: Record 51297;
        GeneralSetUp: Record 51398;
        Memb: Record 51364;
        SuspendedInterestAccounts: Record 51298;
        BalDate: Date;
    begin
        ///***************************************************************************///
        if not InterestHeader.Get('INTEREST') then begin
            InterestHeader.Init;
            InterestHeader."No." := 'INTEREST';
            InterestHeader.Status := InterestHeader.Status::Approved;
            InterestHeader.Insert;
        end;

        //BalDate:=CALCDATE('-CM',BDate);
        //BalDate:=(TODAY
        //MESSAGE('fgyug %1',BalDate);
        BalDate := BDate;
        Loans.Reset;
        Loans.SetRange("Loan  No.", LoanNo);
        Loans.SetFilter("Interest Calculation Method", '<>%1', Loans."interest calculation method"::"Flat Rate");
        Loans.SetFilter("Date filter", '..%1', BalDate);
        Loans.SetFilter("Outstanding Balance", '>0');
        if Loans.Find('-') then begin
            //MESSAGE('loan %1',LoanNo);
            repeat
                InterestAmount := ROUND(GetInterestAmount(Loans."Loan  No.", BDate, false), 0.01, '>');
                LoansInterest.Reset;
                LoansInterest.SetRange(No, 'INTEREST');
                LoansInterest.SetRange("Loan No.", Loans."Loan  No.");
                LoansInterest.SetRange("Interest Date", BDate);
                LoansInterest.SetRange(Reversed, false);
                if LoansInterest.FindFirst then begin
                    //MESSAGE('loan 2 %1',Loans."Loan  No.");
                    if LoansInterest.Posted then
                        InterestAmount := 0
                    else
                        LoansInterest.Delete;
                end;



                if InterestAmount > 0 then begin
                    Loans.CalcFields(Loans."Outstanding Balance", Loans."Oustanding Interest");

                    LoansInterest.Init;
                    LoansInterest.No := 'INTEREST';
                    LoansInterest."Auto Interest" := true;
                    LoansInterest."Loan No." := Loans."Loan  No.";
                    LoansInterest."Account Type" := LoansInterest."account type"::Member;
                    LoansInterest."Account No" := Loans."Client Code";
                    //MESSAGE('client %1',Loans."Client Code");
                    //LoansInterest."Interest Date":=BDate;
                    LoansInterest."Interest Date" := BalDate;
                    LoansInterest."Issued Date" := Loans."Loan Disbursement Date";
                    LoansInterest."Repayment Amount" := Loans.Repayment;
                    LoansInterest."Repayment Bill" := 0;
                    LoansInterest."Interest Amount" := InterestAmount;
                    LoansInterest."Interest Bill" := InterestAmount;
                    LoansInterest.Description := 'Interest Due' + ' ' + CopyStr(Format(BDate, 0, '<Month Text>'), 1, 3) + ' ' + Format(Date2dmy(BDate, 3));
                    LoansInterest."Shortcut Dimension 1 Code" := Loans."Global Dimension 1 Code";
                    LoansInterest."Shortcut Dimension 2 Code" := Loans."Branch Code";
                    LoansInterest."Monthly Repayment" := Loans.Repayment;
                    LoansInterest."Loan Product type" := Loans."Loan Product Type";
                    //Loans.CALCFIELDS("Current Loans Category-SASRA");
                    if LoanType.Get(Loans."Loan Product Type") then begin

                        if (Loans."Loans Category-SASRA" <> Loans."loans category-sasra"::Loss) then begin

                            LoanType.TestField(LoanType."Loan Interest Account");
                            LoansInterest."Bal. Account No." := LoanType."Loan Interest Account";
                            LoansInterest."Bill Account" := LoansInterest."Bal. Account No.";
                        end
                        else begin

                            SuspendedInterestAccounts.Reset;
                            SuspendedInterestAccounts.SetRange("Loan No.", Loans."Loan  No.");
                            SuspendedInterestAccounts.SetRange("Interest Date", BDate);
                            if SuspendedInterestAccounts.FindFirst then
                                SuspendedInterestAccounts.Delete;


                            //LoanType.TESTFIELD(LoanType."Suspend Interest Account [G/L]");
                            //LoansInterest."Bal. Account No.":=LoanType."Suspend Interest Account [G/L]";
                            LoansInterest."Bill Account" := LoansInterest."Bal. Account No.";
                            //Insert Entries to buffer
                            iEntryNo := SuspendedInterestAccounts.Count;
                            iEntryNo := iEntryNo + 1;
                            SuspendedInterestAccounts.Init;
                            SuspendedInterestAccounts."Entry No." := iEntryNo;
                            SuspendedInterestAccounts."Loan No." := Loans."Loan  No.";
                            SuspendedInterestAccounts."Loan Product type" := LoanType.Code;
                            SuspendedInterestAccounts."Loans Category-SASRA" := Loans."Loans Category-SASRA";
                            SuspendedInterestAccounts."Interest Amount" := InterestAmount;
                            SuspendedInterestAccounts."Interest Date" := BDate;
                            SuspendedInterestAccounts."Issued Date" := Loans."Loan Disbursement Date";
                            SuspendedInterestAccounts.Insert(true);


                        end;
                    end;

                    if CustMember.Get(Loans."Client Code") then begin
                        LoansInterest.Status := CustMember.Status;
                        LoansInterest.Blocked := CustMember.Blocked;
                    end;

                    LoansInterest."Outstanding Balance" := Loans."Outstanding Balance";
                    LoansInterest."Outstanding Interest" := Loans."Oustanding Interest";
                    LoansInterest.Insert;

                end;
            until Loans.Next = 0;

        end;
    end;

    procedure GenerateLoanMonthlyInterest2(VAR LoanNo: Code[20]; BDate: Date)
    var
        InterestHeader: Record "Interest Header";
        Loans: Record "Loans register";
        LoansInterest: Record "Loans Interest";
        SuspendedInterestAccounts: Record "Suspended Interest Accounts";
        CustMember: Record Customer;
        LoanType: Record "Loan Products Setup";
    begin
        ///***************************************************************************///
        IF NOT InterestHeader.GET('INTEREST') THEN BEGIN
            InterestHeader.INIT;
            InterestHeader."No." := 'INTEREST';
            InterestHeader.Status := InterestHeader.Status::Approved;
            InterestHeader.INSERT;
        END;

        //BalDate:=CALCDATE('-CM',BDate);
        //BalDate:=(TODAY
        //MESSAGE('fgyug %1',BalDate);
        BalDate := BDate;
        Loans.RESET;
        Loans.SETRANGE("Loan  No.", LoanNo);
        Loans.SETFILTER("Interest Calculation Method", '<>%1', Loans."Interest Calculation Method"::"Flat Rate");
        Loans.SETFILTER("Date filter", '..%1', BalDate);
        Loans.SETFILTER("Outstanding Balance", '>0');
        IF Loans.FIND('-') THEN BEGIN
            //MESSAGE('loan %1',LoanNo);
            REPEAT
                InterestAmount := ROUND(GetInterestAmount(Loans."Loan  No.", BDate, FALSE), 0.01, '>');
                LoansInterest.RESET;
                LoansInterest.SETRANGE(No, 'INTEREST');
                LoansInterest.SETRANGE("Loan No.", Loans."Loan  No.");
                LoansInterest.SETRANGE("Interest Date", BDate);
                LoansInterest.SETRANGE(Reversed, FALSE);
                IF LoansInterest.FINDFIRST THEN BEGIN
                    //MESSAGE('loan 2 %1',Loans."Loan  No.");
                    IF LoansInterest.Posted THEN
                        InterestAmount := 0
                    ELSE
                        LoansInterest.Delete();
                END;



                IF InterestAmount > 0 THEN BEGIN
                    Loans.CALCFIELDS(Loans."Outstanding Balance", Loans."Oustanding Interest");

                    LoansInterest.INIT;
                    LoansInterest.No := 'INTEREST';
                    LoansInterest."Auto Interest" := TRUE;
                    LoansInterest."Loan No." := Loans."Loan  No.";
                    LoansInterest."Account Type" := LoansInterest."Account Type"::Member;
                    LoansInterest."Account No" := Loans."Client Code";
                    //MESSAGE('client %1',Loans."Client Code");
                    //LoansInterest."Interest Date":=BDate;
                    LoansInterest."Interest Date" := BalDate;
                    LoansInterest."Issued Date" := Loans."Loan Disbursement Date";
                    LoansInterest."Repayment Amount" := Loans.Repayment;
                    LoansInterest."Repayment Bill" := 0;
                    LoansInterest."Interest Amount" := InterestAmount;
                    LoansInterest."Interest Bill" := InterestAmount;
                    LoansInterest.Description := 'Interest Due' + ' ' + COPYSTR(FORMAT(BDate, 0, '<Month Text>'), 1, 3) + ' ' + FORMAT(DATE2DMY(BDate, 3));
                    LoansInterest."Shortcut Dimension 1 Code" := Loans."Global Dimension 1 Code";
                    LoansInterest."Shortcut Dimension 2 Code" := Loans."Branch Code";
                    LoansInterest."Monthly Repayment" := Loans.Repayment;
                    LoansInterest."Loan Product type" := Loans."Loan Product Type";
                    //Loans.CALCFIELDS("Current Loans Category-SASRA");
                    IF LoanType.GET(Loans."Loan Product Type") THEN BEGIN

                        IF (Loans."Loans Category-SASRA" <> Loans."Loans Category-SASRA"::Loss) THEN BEGIN

                            LoanType.TESTFIELD(LoanType."Loan Interest Account");
                            LoansInterest."Bal. Account No." := LoanType."Loan Interest Account";
                            LoansInterest."Bill Account" := LoansInterest."Bal. Account No.";
                        END
                        ELSE BEGIN

                            SuspendedInterestAccounts.RESET;
                            SuspendedInterestAccounts.SETRANGE("Loan No.", Loans."Loan  No.");
                            SuspendedInterestAccounts.SETRANGE("Interest Date", BDate);
                            IF SuspendedInterestAccounts.FINDFIRST THEN
                                SuspendedInterestAccounts.DELETE;


                            //LoanType.TESTFIELD(LoanType."Suspend Interest Account [G/L]");
                            //LoansInterest."Bal. Account No.":=LoanType."Suspend Interest Account [G/L]";
                            LoansInterest."Bill Account" := LoansInterest."Bal. Account No.";
                            //Insert Entries to buffer
                            iEntryNo := SuspendedInterestAccounts.COUNT;
                            iEntryNo := iEntryNo + 1;
                            SuspendedInterestAccounts.INIT;
                            SuspendedInterestAccounts."Entry No." := iEntryNo;
                            SuspendedInterestAccounts."Loan No." := Loans."Loan  No.";
                            SuspendedInterestAccounts."Loan Product type" := LoanType.Code;
                            SuspendedInterestAccounts."Loans Category-SASRA" := Loans."Loans Category-SASRA";
                            SuspendedInterestAccounts."Interest Amount" := InterestAmount;
                            SuspendedInterestAccounts."Interest Date" := BDate;
                            SuspendedInterestAccounts."Issued Date" := Loans."Loan Disbursement Date";
                            SuspendedInterestAccounts.INSERT(TRUE);


                        END;
                    END;

                    IF CustMember.GET(Loans."Client Code") THEN BEGIN
                        LoansInterest.Status := CustMember.Status;
                        LoansInterest.Blocked := CustMember.Blocked;
                    END;

                    LoansInterest."Outstanding Balance" := Loans."Outstanding Balance";
                    LoansInterest."Outstanding Interest" := Loans."Oustanding Interest";
                    LoansInterest.INSERT;

                END;
            UNTIL Loans.NEXT = 0;

        END;

    end;

    procedure GetInterestAmount(LoanNo: Code[20]; IntDate: Date; CheckExistingBill: Boolean): Decimal
    var
        LoanRec: Record "Loans Register";
        CLedger: Record "Cust. Ledger Entry";
        RSchedule: Record "Loan Repayment Schedule";
        LastDate: Date;
        IntAmount: Decimal;
        LoanBalance: Decimal;
        BalDate: Date;
        SFactory: Codeunit "Swizzsoft Factory";
    begin
        BalDate := CalcDate('+CM', Today);
        //BalDate:=CALCDATE('CM',BalDate);
        //MESSAGE('bdate %1',BalDate);
        LoanRec.Get(LoanNo);
        if ProdFact.Get(LoanRec."Loan Product Type") then
            //MESSAGE('code %1',LoanRec."Loan Product Type");
            LoanRec.Reset;
        LoanRec.SetRange("Loan  No.", LoanNo);
        LoanRec.SetFilter("Date filter", '..%1', BalDate);
        LoanRec.SetFilter("Outstanding Balance", '<=0');
        if LoanRec.FindFirst then
            exit(0);

        if CheckExistingBill then begin
            CLedger.Reset();
            CLedger.SetRange("Loan No", LoanNo);
            CLedger.SetRange("Transaction Type", CLedger."transaction type"::"Interest Due");
            CLedger.SetFilter("Posting Date", '%1..%2', CalcDate('-CM', IntDate), CalcDate('CM', IntDate));
            CLedger.SetFilter("Posting Date", '%1..%2', 20180806D, CalcDate('CM', IntDate));
            CLedger.SetFilter(Amount, '>0');
            CLedger.SetRange(Reversed, false);
            if CLedger.FindFirst then
                exit(0);
        end;

        RSchedule.Reset;
        RSchedule.SetRange("Loan No.", LoanRec."Loan  No.");
        RSchedule.SetFilter("Principal Repayment", '>0');
        if not RSchedule.FindFirst then
            // LoansProcess.GenerateRepaymentSchedule(LoanRec);
            SFactory.FnGenerateRepaymentSchedule(LoanRec."Loan  No.");

        LoanBalance := 0;
        IntAmount := 0;

        LoanRec.Reset;
        LoanRec.SetRange("Loan  No.", LoanNo);
        LoanRec.SetFilter("Date filter", '..%1', BalDate);
        if LoanRec.FindFirst then begin
            LoanRec.CalcFields("Outstanding Balance");
            LoanBalance := LoanRec."Outstanding Balance";

            if LoanBalance < 0 then
                LoanBalance := 0;


            if (LoanRec."Loan Product Type" = '15') or (LoanRec."Loan Product Type" = '16') then
                IntAmount := ROUND(LoanRec."Approved Amount" * LoanRec.Interest / 1200, 1, '>')
            else
                IntAmount := ROUND(LoanBalance * LoanRec.Interest / 1200, 1, '>');
            //MESSAGE('int amount %1',IntAmount);

        end;

        if IntAmount < 0 then
            IntAmount := 0;



        exit(IntAmount);
    end;


    procedure GenerateDailyInterest(DailyLoansInterestBuffer: Record 51297)
    var
        Loans: Record "Loans Register";
        LoanType: Record 51381;
        DailyLoansBuffer: Record 51297;
        DateDiff: Integer;
        MontDays: Integer;
    begin
        with DailyLoansInterestBuffer do begin
            //Initiate Variables
            DateDiff := 0;
            Loans.SetRange(Loans.Posted, true);
            //Loans.SETRANGE(Loans."Compute Interest Due on Postin",Loans."Compute Interest Due on Postin"::"Pro-rata");
            if Loans.Find('-') then begin
                LoanType.Get(Loans."Loan Product Type");
                repeat
                    DateDiff := 1;//TODAY-Loans."Application Date" ELSE
                                  //DateDiff:=TODAY-Loans."Disbursement Date";
                    MontDays := (CalcDate('CM', Today)) - (CalcDate('-CM', Today));
                    DailyLoansBuffer.Init;
                    DailyLoansBuffer."Loan No." := Loans."Loan  No.";
                    DailyLoansBuffer."Interest Date" := Today;//CALCDATE('-1d',TODAY);
                                                              //DailyLoansBuffer."Account No":=Loans."Loan Account";
                    DailyLoansBuffer."Account Type" := DailyLoansBuffer."account type"::Member;
                    DailyLoansBuffer."Loan Product type" := Loans."Loan Product Type";
                    DailyLoansBuffer."User ID" := UserId;
                    //Compute Interest
                    if Loans."Interest Calculation Method" = Loans."interest calculation method"::"Flat Rate" then begin
                        if Format(LoanType."Grace Period") <> '' then
                            //BEGIN
                            if CalcDate(LoanType."Grace Period", Loans."Loan Disbursement Date") >= Today then
                                DailyLoansBuffer."Interest Amount" := (Loans."Approved Amount" * (1 / MontDays) * Loans.Interest / 1200)
                            else
                                DailyLoansBuffer."Interest Amount" := 0;
                    end else begin
                        if Format(LoanType."Grace Period") <> '' then begin
                            if CalcDate(LoanType."Grace Period", Loans."Loan Disbursement Date") >= Today then
                                DailyLoansBuffer."Interest Amount" := (Loans."Approved Amount" * (1 / MontDays) * Loans.Interest / 1200)
                            else
                                DailyLoansBuffer."Interest Amount" := 0;
                        end else begin
                            DailyLoansBuffer."Interest Amount" := (Loans."Approved Amount" * (1 / MontDays) * Loans.Interest / 1200)
                        end;
                    end;
                    //end of interest computations
                    if Format(LoanType."Grace Period") <> '' then begin
                        if CalcDate(LoanType."Grace Period", Loans."Loan Disbursement Date") >= Today then
                            DailyLoansBuffer."Repayment Amount" := Loans."Loan Principle Repayment" * (1 / MontDays) else
                            DailyLoansBuffer."Repayment Amount" := 0;
                    end else begin
                        DailyLoansBuffer."Repayment Amount" := Loans."Loan Principle Repayment" * (1 / MontDays)
                    end;
                    DailyLoansBuffer."Monthly Repayment" := DailyLoansBuffer."Repayment Amount" + DailyLoansBuffer."Interest Amount";
                    if DailyLoansBuffer."Monthly Repayment" <> 0 then
                        DailyLoansBuffer.Insert;
                until Loans.Next = 0;
            end;
        end;
    end;


    procedure PostLoanInterest(InterestBufferBillAndAccrue: Record "Interest Header")
    var
        PeriodicActivities: Codeunit "Periodic Activities";
        members: Record 51364;
        GenBatches: Record "Gen. Journal Batch";
        PDate: Date;
        LoanType: Record 51381;
        PostDate: Date;
        LineNo: Integer;
        DocNo: Code[20];
        GenJournalLine: Record "Gen. Journal Line";
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        EndDate: Date;
        DontCharge: Boolean;
        JBatch: Code[10];
        Jtemplate: Code[10];
        CustLedger: Record 51391;
        AccountingPeriod: Record 51391;
        FiscalYearStartDate: Date;
        "ExtDocNo.": Text[30];
        InterestDue: Decimal;
        LoansInterest: Record 51295;
        DailyLoansInterestBuffer: Record 51297;
    begin
        //............................................................
        // Message('here');
        //....Check for missing bal accounts and update interestbuffer
        Temp.Get(UserId);
        if Temp.Get(UserId) then begin
            Jtemplate := Temp."FundsTransfer Template Name";
            JBatch := Temp."FundsTransfer Batch Name";
        end;

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", Jtemplate);
        GenJournalLine.SetRange("Journal Batch Name", JBatch);
        if GenJournalLine.Find('-') then begin
            GenJournalLine.DeleteAll;
        end;
        //............................................................
        with InterestBufferBillAndAccrue do begin

            GenerationDate := FnGetLastInterestRunningDate();

            if "No." <> 'INTEREST' then
                // ERROR('Invalid Interest Posting');


                Temp.Get(UserId);
            //ERROR('user %1',USERID);//Swizzsoft
            if Temp.Get(UserId) then begin
                Jtemplate := Temp."FundsTransfer Template Name";
                //ERROR('template %1',Jtemplate);//PAYMENTS
                JBatch := Temp."FundsTransfer Batch Name";
                //ERROR('batch %1',JBatch);//muthui
            end;
            if Jtemplate = '' then
                Error('Interest Template for user ' + Format(UserId) + 'is not Setup');

            if JBatch = '' then
                Error('Interest Batch for user ' + Format(UserId) + 'is not Setup');


            "Document No." := 'INTEREST';

            LoansInterest.Reset;
            LoansInterest.SetRange(LoansInterest.No, "No.");
            LoansInterest.SetRange(Posted, false);
            LoansInterest.SetRange(LoansInterest."Interest Date", GenerationDate);
            LoansInterest.SetFilter("Interest Amount", '>0');
            if LoansInterest.Find('-') then begin
                repeat

                    if CreditAccounts.Get(LoansInterest."Account No") then begin

                        if LoansInterest."Interest Amount" > 0 then begin
                            LineNo := LineNo + 1000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := Jtemplate;
                            GenJournalLine."Journal Batch Name" := JBatch;
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Posting Date" := LoansInterest."Interest Date";
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                            GenJournalLine."Account No." := LoansInterest."Account No";
                            GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Due";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            // GenJournalLine."Document No." := LoansInterest."Loan No.";
                            GenJournalLine."Document No." := 'Interest - ' + FORMAT(LoansInterest."Interest Date", 0, '<Month,3> <Year4>');
                            GenJournalLine."Shortcut Dimension 1 Code" := LoansInterest."Shortcut Dimension 1 Code";
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            //                    GenJournalLine."Shortcut Dimension 2 Code":=LoansInterest."Shortcut Dimension 2 Code";
                            //                    GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                            GenJournalLine.Amount := LoansInterest."Interest Amount";
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine.Description := LoansInterest.Description;
                            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                            if LoansInterest."Bal. Account No." <> '' then begin
                                GenJournalLine."Bal. Account No." := LoansInterest."Bal. Account No.";
                            end else
                                if LoansInterest."Bal. Account No." = '' then begin
                                    GenJournalLine."Bal. Account No." := FnCheckForMissingBalAccounts(LoansInterest."Loan No.");//2030
                                end;
                            GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                            GenJournalLine."Loan No" := LoansInterest."Loan No.";
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;

                        end;


                        LoansInterest.Transferred := true;
                        LoansInterest.Posted := true;
                        LoansInterest.Modify;



                    end;
                until LoansInterest.Next = 0;
            end;
            //.......................
        end;

        //.....................................................................
        //............................POST
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", Jtemplate);
        GenJournalLine.SetRange("Journal Batch Name", JBatch);
        GenJournalLine.SetRange(GenJournalLine."Posting Date", GenerationDate);
        GenJournalLine.SetRange(GenJournalLine."Transaction Type", GenJournalLine."transaction type"::"Interest Due");
        if GenJournalLine.Find('-') then begin
            repeat
                Codeunit.Run(Codeunit::"Gen. Jnl.-Post Line", GenJournalLine);
            until GenJournalLine.Next = 0;
        end;
        //......................................................................

        InterestBufferBillAndAccrue.Posted := true;
        InterestBufferBillAndAccrue."Posted By" := UserId;
        InterestBufferBillAndAccrue."Posting Date" := Today;
        InterestBufferBillAndAccrue.Modify;
    end;

    local procedure GenerateLoansSchedule()
    begin
    end;

    local procedure FnGetLastInterestRunningDate(): Date
    var
        LoansInterestTable: Record 51295;
        SetDate: Date;
    begin
        LoansInterestTable.Reset;
        LoansInterestTable.SetRange(LoansInterestTable.No, 'INTEREST');
        LoansInterestTable.SetRange(LoansInterestTable.Posted, false);
        if LoansInterestTable.FindLast then begin
            SetDate := LoansInterestTable."Interest Date";
        end;
        exit(SetDate);
    end;


    procedure FnCheckForMissingBalAccounts(LoanNo: Code[20]): Code[30]
    begin
        //LoansInterest."Loan No."
        if LoansRegisterTable.Get(LoanNo) then begin
            ProductCode := (Format(LoansRegisterTable."Loan Product Type"));
            ProdFact.Reset;
            ProdFact.SetRange(ProdFact.Code, ProductCode);
            if ProdFact.Find('-') then begin
                FoundProductInterestAccount := (Format(ProdFact."Loan Interest Account"));
            end;
        end;
        exit(FoundProductInterestAccount);
    end;
}

