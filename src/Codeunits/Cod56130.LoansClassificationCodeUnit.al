codeunit 56130 "LoansClassificationCodeUnit"
{

    trigger OnRun()
    begin
        //FnClassifyLoan
    end;

    var
        LoansReg: Record "Loans Register";
        RepaymentSchedule: Record "Loan Repayment Schedule";
        MemberLedgerEntry: Record "Cust. Ledger Entry";
        LoanBalAsAtFilterDate: Decimal;
        ScheduleExpectedLoanBal: Decimal;
        ArreasPresent: Decimal;
        LoansRegTablw: Record "Loans Register";
        PrincipalRepaymentAmount: Decimal;
        RepaymentScheduleAmount: Decimal;


    procedure FnClassifyLoan(LoanNo: Code[30]; AsAt: Date)

    begin
        //..................Check if Loan expected date of completion is attained,if yes loan is loss

        LoansRegTablw.Reset;
        LoansRegTablw.SetAutocalcFields(LoansRegTablw."Outstanding Balance");
        LoansRegTablw.SetRange(LoansRegTablw."Loan  No.", LoanNo);
        if LoansRegTablw.Find('-') then begin
            LoanBalAsAtFilterDate := GetLoanBalAsAtFilterDate(LoanNo, AsAt);
            IF LoanBalAsAtFilterDate > 0 then begin
                //Check repayment schedule to know the expected balance
                ScheduleExpectedLoanBal := 0;
                if LoansRegTablw."Expected Date of Completion" < AsAt then begin
                    ScheduleExpectedLoanBal := 0;
                end else begin
                    ScheduleExpectedLoanBal := GetExpectedBalAsPerSchedule(LoanNo, AsAt);
                end;

                //Determine if any areas
                ArreasPresent := 0;
                if LoanBalAsAtFilterDate > ScheduleExpectedLoanBal then begin
                    ArreasPresent := LoanBalAsAtFilterDate - ScheduleExpectedLoanBal;
                end
                else
                    if (LoanBalAsAtFilterDate <= ScheduleExpectedLoanBal) then begin
                        ArreasPresent := 0;
                    end;
                //if there are areas then,,determine the days in areas
                if ArreasPresent > 0 then begin
                    //--Function to Get Days In Arrears and modify;
                    FnUpdateLoanStatusWithArrears(LoanNo, ArreasPresent, AsAt);
                end
                else
                    if ArreasPresent <= 0 then begin
                        FnUpdateLoanStatusNonArrears(LoanNo);
                    end;
            end else
                if LoanBalAsAtFilterDate <= 0 then begin
                    LoansRegTablw."Amount in Arrears" := 0;
                    LoansRegTablw."No of Months in Arrears" := 0;
                    LoansRegTablw."Loans Category-SASRA" := LoansRegTablw."Loans Category-SASRA"::Perfoming;
                end;
        end;
    end;

    local procedure GetLoanBalAsAtFilterDate(LoanNos: Code[30]; FilterDate: Date): Decimal
    var
        TotalPayments: Decimal;
    begin
        TotalPayments := 0;
        MemberLedgerEntry.Reset;
        MemberLedgerEntry.SetFilter(MemberLedgerEntry."Transaction Type", '%1|%2', MemberLedgerEntry."transaction type"::Loan, MemberLedgerEntry."transaction type"::"Loan Repayment");
        MemberLedgerEntry.SetRange(MemberLedgerEntry."Loan No", LoanNos);
        MemberLedgerEntry.SetFilter(MemberLedgerEntry."Posting Date", '%1..%2', 0D, FilterDate);
        MemberLedgerEntry.SetRange(MemberLedgerEntry.Reversed, false);
        if MemberLedgerEntry.Find('-') then begin
            repeat
                TotalPayments += MemberLedgerEntry."Amount Posted";
            until MemberLedgerEntry.Next = 0;
        end;
        exit(TotalPayments);
    end;

    local procedure GetExpectedBalAsPerSchedule(LoanNos: Code[20]; DateFiltering: Date): Decimal
    var
        ScheduleExpectedBal: Decimal;
        ActualDate: Date;
        DateFormula: Text;
        i: Integer;
        PrincipalRepayment: Decimal;
        LoanBalance: Decimal;
    begin
        ScheduleExpectedBal := 0;
        DateFormula := '<-1M>';
        ActualDate := CalcDate(DateFormula, DateFiltering);
        RepaymentSchedule.Reset;
        RepaymentSchedule.SetRange(RepaymentSchedule."Loan No.", LoanNos);
        RepaymentSchedule.SetFilter(RepaymentSchedule."Repayment Date", '%1..%2', 0D, DateFiltering);
        if RepaymentSchedule.FindLast then begin
            repeat
                ScheduleExpectedBal := ROUND(RepaymentSchedule."Loan Balance" + RepaymentSchedule."Principal Repayment");

            until RepaymentSchedule.Next = 0;
        end;
        exit(ScheduleExpectedBal);
    end;



    local procedure FnUpdateLoanStatusNonArrears(LoanNo: Code[30])
    begin
        LoansReg.Reset;
        LoansReg.SetRange(LoansReg."Loan  No.", LoanNo);
        if LoansReg.Find('-') then begin
            LoansReg."Amount in Arrears" := 0;
            LoansReg."No of Months in Arrears" := 0;
            LoansReg."Loans Category-SASRA" := LoansReg."loans category-sasra"::Perfoming;
            LoansReg."Loans Category-SASRA" := LoansReg."Loans Category-SASRA"::Perfoming;
            LoansReg.Modify(true);
        end;
    end;

    local procedure FnUpdateLoanStatusWithArrears(LoanNo: Code[30]; AmountInArearsPassed: Decimal; Datefilter: Date)

    var
        DaysInArreas: Integer;

    begin
        DaysInArreas := 0;
        LoansReg.Reset;
        LoansReg.SetRange(LoansReg."Loan  No.", LoanNo);
        if LoansReg.Find('-') then begin
            if LoansReg."Repayment Start Date" >= Datefilter then begin
                LoansReg."Amount in Arrears" := 0
            end else begin
                LoansReg."Amount in Arrears" := AmountInArearsPassed;
            end;
            RepaymentScheduleAmount := 0;
            RepaymentScheduleAmount := GetRepayment(LoanNo, Datefilter);
            if RepaymentScheduleAmount <= 0 then
                RepaymentScheduleAmount := LoansReg."Loan Principle Repayment";
            //..................................................................................Repayment
            IF LoansRegTablw.Installments = 0 THEN begin
                LoansRegTablw.Installments := 12;
            end;
            LoansReg."No of Months in Arrears" := ROUND(LoansReg."Amount in Arrears" / RepaymentScheduleAmount, 1, '=');

            DaysInArreas := LoansReg."No of Months in Arrears" * 30;
            if (DaysInArreas <= 30) then begin
                LoansReg."Loans Category-SASRA" := LoansReg."Loans Category-SASRA"::Perfoming;
            end else
                if (DaysInArreas > 30) and (DaysInArreas <= 60) then begin
                    LoansReg."Loans Category-SASRA" := LoansReg."loans category-sasra"::Watch;
                end
                else
                    if (DaysInArreas > 60) and (DaysInArreas <= 180) then begin
                        LoansReg."Loans Category-SASRA" := LoansReg."loans category-sasra"::Substandard;
                    end else
                        if (DaysInArreas > 180) and (DaysInArreas <= 360) then begin
                            LoansReg."Loans Category-SASRA" := LoansReg."loans category-sasra"::Doubtful;
                        end else
                            if (LoansReg."No of Months in Arrears" > 360) then begin
                                LoansReg."Loans Category-SASRA" := LoansReg."loans category-sasra"::Loss;
                            end;
            LoansReg.Modify(true);
        end;
    end;

    local procedure GetRepayment(LoanNos: Code[20]; DateFiltering: Date): Decimal
    var
        RepaymentAmount: Decimal;
        ActualDate: Date;
        DateFormula: Text;
    begin
        RepaymentAmount := 0;
        DateFormula := '<-1M>';
        ActualDate := CalcDate(DateFormula, DateFiltering);
        RepaymentSchedule.Reset;
        RepaymentSchedule.SetRange(RepaymentSchedule."Loan No.", LoanNos);
        RepaymentSchedule.SetFilter(RepaymentSchedule."Repayment Date", '%1..%2', 0D, DateFiltering);
        if RepaymentSchedule.FindLast then begin
            repeat
                RepaymentAmount := ROUND(RepaymentSchedule."Principal Repayment");
            until RepaymentSchedule.Next = 0;
        end;
        exit(RepaymentAmount);
    end;

    local procedure IsLoanSupposedToBeCompleted(LoanNoss: Code[20]; datefilter: Date): Boolean
    begin
        LoansReg.Reset;
        LoansReg.SetRange(LoansReg."Loan  No.", LoanNoss);
        if LoansReg.Find('-') then begin
            if LoansReg."Expected Date of Completion" < datefilter then begin
                exit(true);
            end
            else
                if LoansReg."Expected Date of Completion" >= datefilter then begin
                    exit(false);
                end;
        end;
    end;

}

