#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 50031 ManageLoanDefaulters
{

    trigger OnRun()
    begin
        //ERROR('HERE');
    end;

    var
        ExpectedLoanBal: Decimal;
        ActualLoanBal: Decimal;
        AmountDisbursed: Decimal;
        LastLoanPayDate: Date;
        cust: Record 51364;
        SMSMessage: Record 51471;
        iEntryNo: Integer;
        LoanGuar: Record 51372;
        DefaultedLoanNo: Code[30];


    procedure FnClassifyLoanDefaulterAction(LoanNo: Code[30])
    var
        LoansRegister: Record 51371;
    begin

        ActualLoanBal := 0;
        ExpectedLoanBal := 0;
        AmountDisbursed := 0;
        LastLoanPayDate := 20150101D;
        LoansRegister.Reset;
        LoansRegister.SetRange(LoansRegister."Loan  No.", LoanNo);
        LoansRegister.SetAutocalcFields(LoansRegister."Outstanding Balance", LoansRegister."Oustanding Interest");
        if LoansRegister.Find('-') then begin
            //.............Check the repayment schedule to see the as at date outstanding balance of the loan
            ExpectedLoanBal := FnGetExpectedLoanBalance(LoansRegister."Loan  No.");
            ActualLoanBal := LoansRegister."Outstanding Balance" + LoansRegister."Oustanding Interest";
            AmountDisbursed := LoansRegister."Approved Amount";
            DefaultedLoanNo := LoanNo;
            if ActualLoanBal > ExpectedLoanBal then begin
                LastLoanPayDate := FnGetLastPaymentDate(LoansRegister."Client Code");
                //    IF LastLoanPayDate=0D THEN BEGIN
                //      ERROR(FORMAT(LoansRegister."Client Code"));
                //      END;
                if (CalcDate('3M', LastLoanPayDate) < Today) then begin
                    //Member has not been paying for the last 3 months

                    FnSend3rdSMSMessage(LoansRegister."Client Code", ActualLoanBal, LoansRegister."Loan Product Type Name", DefaultedLoanNo, AmountDisbursed);

                    exit;
                end else if (CalcDate('2M', LastLoanPayDate) < Today) then begin
                    //Member has not been paying for the last 2 months
                    FnSend2ndSMSMessage(LoansRegister."Client Code", ActualLoanBal, LoansRegister."Loan Product Type Name", DefaultedLoanNo, AmountDisbursed);
                    exit;
                end
                else if (CalcDate('1M', LastLoanPayDate) < Today) then begin
                    //Member has not been paying for the last 1 months
                    FnSend1stSMSMessage(LoansRegister."Client Code", ActualLoanBal, LoansRegister."Loan Product Type Name", DefaultedLoanNo, AmountDisbursed);

                    exit;
                end
                else begin
                    //Mmember is still paying a little by little for the last NO.OF DAYS
                    FnSendReminderSMSMessage(LoansRegister."Client Code", ActualLoanBal, LoansRegister."Loan Product Type Name", DefaultedLoanNo, AmountDisbursed);

                end;
            end
            else begin

            end;
        end;
    end;

    local procedure FnGetExpectedLoanBalance(LoanNo: Code[20]): Decimal
    var
        RepaymentScheduleTable: Record 51375;
        LoanBalExpected: Decimal;
    begin
        LoanBalExpected := 0;
        RepaymentScheduleTable.Reset;
        RepaymentScheduleTable.SetRange(RepaymentScheduleTable."Loan No.", LoanNo);
        RepaymentScheduleTable.SetFilter(RepaymentScheduleTable."Repayment Date", '%1..%2', 0D, Today);
        if RepaymentScheduleTable.FindLast then begin
            LoanBalExpected := ROUND(RepaymentScheduleTable."Loan Balance");
        end;
        exit(LoanBalExpected);
    end;

    local procedure FnGetLastPaymentDate(CustomerNo: Code[20]): Date
    var
        MemberLedgerEntry: Record 51365;
        LastPayDate: Date;
    begin
        LastPayDate := 20150101D;
        MemberLedgerEntry.Reset;
        MemberLedgerEntry.SetRange(MemberLedgerEntry."Customer No.", CustomerNo);
        MemberLedgerEntry.SetFilter(MemberLedgerEntry."Posting Date", '%1..%2', 0D, Today);
        MemberLedgerEntry.SetFilter(MemberLedgerEntry."Transaction Type", '%1|%2', MemberLedgerEntry."transaction type"::"Loan Repayment", MemberLedgerEntry."transaction type"::"Interest Paid");
        if MemberLedgerEntry.FindLast then begin
            LastPayDate := (MemberLedgerEntry."Posting Date");
            if LastPayDate <> 0D then begin
                LastPayDate := LastPayDate;
            end else if LastPayDate = 0D then begin
                LastPayDate := 20150101D;
            end;
        end;
        exit(LastPayDate);
    end;


    procedure FnSend2ndSMSMessage(ClientCode: Code[30]; DefaultedAmount: Decimal; DefaultedProductName: Code[40]; DefaultedLoanNos: Code[30]; AmountDisbursed: Decimal)
    begin
        cust.Reset;
        cust.SetRange(cust."No.", ClientCode);
        if cust.Find('-') then begin
            SMSMessage.Reset;
            if SMSMessage.Find('+') then begin
                iEntryNo := SMSMessage."Entry No";
                iEntryNo := iEntryNo + 1;
            end
            else begin
                iEntryNo := 1;
            end;

            SMSMessage.Reset;
            SMSMessage.Init;
            SMSMessage."Entry No" := iEntryNo;
            SMSMessage."Account No" := cust."No.";
            SMSMessage."Date Entered" := Today;
            SMSMessage."Time Entered" := Time;
            SMSMessage.Source := 'LOAN DEF2';
            SMSMessage."Entered By" := UserId;
            SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
            SMSMessage."SMS Message" := 'Defaulter Second Notice: Dear ,' + cust.Name + ' you are in default of your '
            + DefaultedProductName + ' of Outstanding balance KSHs.' + Format(ROUND(DefaultedAmount, 1, '=')) +
                                      ' at BAMBURI WANANCHI SACCO LTD. Your Guarantors will be notified.';
            //SMSMessage."Telephone No":=cust."Mobile Phone No";
            SMSMessage."Telephone No" := '0719421588';
            SMSMessage.Insert;
        end;
        //.........................Attach Guarantors...........................
        LoanGuar.Reset;
        LoanGuar.SetRange(LoanGuar."Loan No", DefaultedLoanNo);
        LoanGuar.SetFilter(LoanGuar."Member No", '<>%1', ClientCode);
        if LoanGuar.Find('-') then begin

            repeat

                SMSMessage.Reset;
                if SMSMessage.Find('+') then begin
                    iEntryNo := SMSMessage."Entry No";
                    iEntryNo := iEntryNo + 1;
                end
                else begin
                    iEntryNo := 1;
                end;

                SMSMessage.Reset;
                SMSMessage.Init;
                SMSMessage."Entry No" := iEntryNo;
                SMSMessage."Account No" := LoanGuar."Member No";
                SMSMessage."Date Entered" := Today;
                SMSMessage."Time Entered" := Time;
                SMSMessage.Source := 'LOAN DEF2';
                SMSMessage."Entered By" := UserId;
                SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
                SMSMessage."SMS Message" := 'Dear ' + LoanGuar.Name + ' This is to notify you that '
                + Format(FnReturnLoaneeName(LoanGuar."Loan No")) + ' has defaulted a loan you had guaranteed with your deposits of Ksh. ' + Format(LoanGuar."Original Amount") + ' of Your deposit at BAMBURI WANANCHI SACCO LTD. ';
                cust.Reset;
                cust.SetRange(cust."No.", LoanGuar."Member No");
                if cust.Find('-') then begin
                    //SMSMessage."Telephone No":=cust."Mobile Phone No";
                    SMSMessage."Telephone No" := '0719421588';
                    SMSMessage.Insert;


                end;
            //MESSAGE ('g name is %1',LoanGuar.Name)
            until LoanGuar.Next = 0;
        end;
    end;


    procedure FnSend1stSMSMessage(ClientCode: Code[30]; DefaultedAmount: Decimal; DefaultedProductName: Code[40]; DefaultedLoanNos: Code[30]; AmountDisbursed: Decimal)
    begin
        cust.Reset;
        cust.SetRange(cust."No.", ClientCode);
        if cust.Find('-') then begin
            SMSMessage.Reset;
            if SMSMessage.Find('+') then begin
                iEntryNo := SMSMessage."Entry No";
                iEntryNo := iEntryNo + 1;
            end
            else begin
                iEntryNo := 1;
            end;

            SMSMessage.Reset;
            SMSMessage.Init;
            SMSMessage."Entry No" := iEntryNo;
            SMSMessage."Account No" := cust."No.";
            SMSMessage."Date Entered" := Today;
            SMSMessage."Time Entered" := Time;
            SMSMessage.Source := 'LOAN DEF1';
            SMSMessage."Entered By" := UserId;
            SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
            SMSMessage."SMS Message" := 'Defaulter First Notice: Dear ,' + cust.Name + ' you are in default of your '
            + DefaultedProductName + ' of Outstanding balance KSHs.' + Format(ROUND(DefaultedAmount, 1, '=')) +
                                      ' at BAMBURI WANANCHI SACCO LTD.';
            //SMSMessage."Telephone No":=cust."Mobile Phone No";
            SMSMessage."Telephone No" := '0719421588';
            SMSMessage.Insert;
        end;
    end;


    procedure FnSendReminderSMSMessage(ClientCode: Code[30]; DefaultedAmount: Decimal; DefaultedProductName: Code[40]; DefaultedLoanNos: Code[30]; AmountDisbursed: Decimal)
    begin
        cust.Reset;
        cust.SetRange(cust."No.", ClientCode);
        if cust.Find('-') then begin
            SMSMessage.Reset;
            if SMSMessage.Find('+') then begin
                iEntryNo := SMSMessage."Entry No";
                iEntryNo := iEntryNo + 1;
            end
            else begin
                iEntryNo := 1;
            end;

            SMSMessage.Reset;
            SMSMessage.Init;
            SMSMessage."Entry No" := iEntryNo;
            SMSMessage."Account No" := cust."No.";
            SMSMessage."Date Entered" := Today;
            SMSMessage."Time Entered" := Time;
            SMSMessage.Source := 'DUEPAYMENT';
            SMSMessage."Entered By" := UserId;
            SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
            SMSMessage."SMS Message" := 'Repayment Due: Dear ,' + cust.Name + ' your loan '
            + DefaultedProductName + 'has an overdue of KSHs.' + Format(ROUND(DefaultedAmount, 1, '=')) +
                                      ' at BAMBURI WANANCHI SACCO LTD.Kindly make arrangements to clear.';
            //SMSMessage."Telephone No":=cust."Mobile Phone No";
            SMSMessage."Telephone No" := '0719421588';
            SMSMessage.Insert;
        end;
    end;


    procedure FnSend3rdSMSMessage(ClientCode: Code[30]; DefaultedAmount: Decimal; DefaultedProductName: Code[40]; DefaultedLoanNos: Code[30]; AmountDisbursed: Decimal)
    begin
        cust.Reset;
        cust.SetRange(cust."No.", ClientCode);
        if cust.Find('-') then begin
            SMSMessage.Reset;
            if SMSMessage.Find('+') then begin
                iEntryNo := SMSMessage."Entry No";
                iEntryNo := iEntryNo + 1;
            end
            else begin
                iEntryNo := 1;
            end;

            SMSMessage.Reset;
            SMSMessage.Init;
            SMSMessage."Entry No" := iEntryNo;
            SMSMessage."Account No" := cust."No.";
            SMSMessage."Date Entered" := Today;
            SMSMessage."Time Entered" := Time;
            SMSMessage.Source := 'LOAN DEF3';
            SMSMessage."Entered By" := UserId;
            SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
            SMSMessage."SMS Message" := 'Defaulter Third Notice: Dear ,' + cust.Name + ' you are in default of your '
            + DefaultedProductName + ' of Outstanding balance KSHs.' + Format(ROUND(DefaultedAmount, 1, '=')) +
                                      ' at BAMBURI WANANCHI SACCO LTD.The arears will be deducted from your deposits.';
            // SMSMessage."Telephone No":=cust."Mobile Phone No";
            SMSMessage."Telephone No" := '0719421588';
            SMSMessage.Insert;
        end;
        //.........................Attach Guarantors...........................
        LoanGuar.Reset;
        LoanGuar.SetRange(LoanGuar."Loan No", DefaultedLoanNo);
        LoanGuar.SetFilter(LoanGuar."Member No", '<>%1', ClientCode);
        if LoanGuar.Find('-') then begin

            repeat

                SMSMessage.Reset;
                if SMSMessage.Find('+') then begin
                    iEntryNo := SMSMessage."Entry No";
                    iEntryNo := iEntryNo + 1;
                end
                else begin
                    iEntryNo := 1;
                end;
                SMSMessage.Reset;
                SMSMessage.Init;
                SMSMessage."Entry No" := iEntryNo;
                SMSMessage."Account No" := LoanGuar."Member No";
                SMSMessage."Date Entered" := Today;
                SMSMessage."Time Entered" := Time;
                SMSMessage.Source := 'LOAN DEF3';
                SMSMessage."Entered By" := UserId;
                SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
                SMSMessage."SMS Message" := 'Dear ' + LoanGuar.Name + ' We would like to inform you that We will recover '
                + Format(FnReturnLoaneeName(LoanGuar."Loan No")) + ' Loan dependent on what you had guaranteed from your deposits to pay off the outstanding of ksh ' + Format(LoanGuar."Original Amount") + ' at BAMBURI WANANCHI SACCO LTD. ';
                cust.Reset;
                cust.SetRange(cust."No.", LoanGuar."Member No");
                if cust.Find('-') then begin
                    //SMSMessage."Telephone No":=cust."Mobile Phone No";
                    SMSMessage."Telephone No" := '0719421588';
                    SMSMessage.Insert;


                end;
            //MESSAGE ('g name is %1',LoanGuar.Name)
            until LoanGuar.Next = 0;
        end;
    end;

    local procedure FnReturnLoaneeName(LoanNo: Code[30]): Text[100]
    var
        LoansRegister: Record 51371;
    begin
        LoansRegister.Reset;
        LoansRegister.SetRange(LoansRegister."Loan  No.", LoanNo);
        if LoansRegister.FindLast then begin
            exit(LoansRegister."Client Name");
        end;
    end;
}

