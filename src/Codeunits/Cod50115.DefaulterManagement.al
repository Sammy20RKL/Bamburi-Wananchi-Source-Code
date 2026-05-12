#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 50115 "Defaulter Management"
{

    trigger OnRun()
    begin
        SMSOneMonthDefaulter();
    end;

    var
        MemberRegister: Record 51364;
        Loans: Record 51371;
        SMSMessages: Record 51471;
        FirstMonthDate: Date;
        EndMonthDate: Date;
        LSchedule: Record 51375;
        LastMonth: Date;
        ScheduledLoanBal: Decimal;
        DateFilter: Text;
        LBal: Decimal;
        Arrears: Decimal;
        SFactory: Codeunit "Swizzsoft Factory.";
        ExpectedBalance: Decimal;
        DaysInArrears: Integer;
        CurrentMonth: Integer;
        LastNotificationMonth: Integer;

    local procedure SMSOneMonthDefaulter()
    begin
        DateFilter := '..' + Format(Today);
        Loans.Reset;
        Loans.SetRange(Loans.Posted, true);
        Loans.SetFilter(Loans."Date filter", DateFilter);
        //Loans.SETFILTER(Loans."Loan  No.",'BLN0047');
        if Loans.Find('-') then begin
            repeat
                Loans.CalcFields(Loans."Outstanding Balance", Loans."Scheduled Principal to Date", Loans."Principal Paid", Loans."Schedule Repayments");
                LBal := Loans."Outstanding Balance";
                if LBal > 0 then begin
                    ScheduledLoanBal := Loans."Scheduled Principal to Date";
                    ExpectedBalance := ROUND(Loans."Approved Amount" - ScheduledLoanBal, 1, '>');
                    Arrears := LBal - ExpectedBalance;
                    if Arrears > 0 then begin
                        CurrentMonth := Date2dmy(Today, 2);
                        if Loans."Last Date Defaulter SMS" <> 0D then
                            LastNotificationMonth := Date2dmy(Loans."Last Date Defaulter SMS", 2);
                        if Loans."Loan Principle Repayment" > 0 then
                            DaysInArrears := ROUND((Arrears / Loans."Loan Principle Repayment") * 30, 1, '>');
                        if CurrentMonth <> LastNotificationMonth then begin
                            if (DaysInArrears <= 30) and (Arrears > 0) then begin
                                if MemberRegister.Get(Loans."Client Code") then begin
                                    SFactory.FnSendSMS('DEFAULTER', 'Dear ' + MemberRegister.Name + ' Your ' + Loans."Loan Product Type Name" + ' is in arrears of Ksh ' +
                                    Format(Arrears) + ' Please pay promptly to regularise your account ', MemberRegister."No.", MemberRegister."Phone No.");
                                    Loans."Last Date Defaulter SMS" := Today;
                                    Loans.Modify(true);
                                end;
                            end;
                        end;
                    end;
                end;
            until Loans.Next = 0;
            Message('Done');
        end;
    end;
}

