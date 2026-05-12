#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 50113 "Holiday Savings Codeunit"
{

    trigger OnRun()
    begin
        FnProcessHolidaySavings('2297', 20230101D, Today);
    end;

    var
        LineNo: Integer;
        SaccoGeneralSetUp: Record "Sacco General Set-Up";
        SFactory: Codeunit "Swizzsoft Factory.";
        GenJournalLine: Record "Gen. Journal Line";
        HolidayTable: Record 51070;
        swizzMobile: Codeunit SwizzKashMobile;


    procedure FnProcessHolidaySavings(MemberNo: Code[50]; StartDate: Date; PostingDate: Date)
    var
        Customer: Record Customer;
        MonthAmountSaved: Decimal;
        InterestEarned: Decimal;
        NewMonth: Date;
        MemberHolidaySaving: Decimal;
        Customer2: Record Customer;
    begin
        StartDate := CalcDate('-CM', StartDate);
        InterestEarned := 0;
        SaccoGeneralSetUp.Get();
        SaccoGeneralSetUp.TestField("HolidaySavings Payout Bank");
        Customer.Reset;
        Customer.SetAutocalcFields(Customer."Holiday Savings");
        Customer.SetRange(Customer."No.", MemberNo);
        if Customer.Find('-') then begin
            MemberHolidaySaving := 0;
            MemberHolidaySaving := (Customer."Holiday Savings");
            //.........................12
            Customer2.Reset;
            Customer2.SetRange(Customer2."No.", MemberNo);
            Customer2.SetAutocalcFields(Customer2."Holiday Savings");
            Customer2.SetFilter(Customer2."Date Filter", '%1..%2', StartDate, CalcDate('CM', StartDate));
            if Customer2.Find('-') then begin
                MonthAmountSaved := 0;
                MonthAmountSaved := Customer2."Holiday Savings";
                if MonthAmountSaved > 0 then begin
                    InterestEarned := (InterestEarned + (((SaccoGeneralSetUp."HolidaySavings(%)" / 100) * MonthAmountSaved)) * 12 / 12);
                end else if MonthAmountSaved <= 0 then begin
                    InterestEarned := 0;
                end;
            end;
            //.........................11
            NewMonth := 0D;
            NewMonth := CalcDate('1M', StartDate);
            Customer2.Reset;
            Customer2.SetRange(Customer2."No.", MemberNo);
            Customer2.SetAutocalcFields(Customer2."Holiday Savings");
            Customer2.SetFilter(Customer2."Date Filter", '%1..%2', NewMonth, CalcDate('CM', NewMonth));
            if Customer2.Find('-') then begin
                MonthAmountSaved := 0;
                MonthAmountSaved := Customer2."Holiday Savings";
                if MonthAmountSaved > 0 then begin
                    InterestEarned := (InterestEarned + (((SaccoGeneralSetUp."HolidaySavings(%)" / 100) * MonthAmountSaved)) * 11 / 12);
                end else if MonthAmountSaved <= 0 then begin
                    InterestEarned := 0 + InterestEarned;
                end;

            end;
            //.........................10
            NewMonth := 0D;
            NewMonth := CalcDate('2M', StartDate);
            Customer2.Reset;
            Customer2.SetRange(Customer2."No.", MemberNo);
            Customer2.SetAutocalcFields(Customer2."Holiday Savings");
            Customer2.SetFilter(Customer2."Date Filter", '%1..%2', NewMonth, CalcDate('CM', NewMonth));
            if Customer2.Find('-') then begin
                MonthAmountSaved := 0;
                MonthAmountSaved := Customer2."Holiday Savings";
                if MonthAmountSaved > 0 then begin
                    InterestEarned := (InterestEarned + (((SaccoGeneralSetUp."HolidaySavings(%)" / 100) * MonthAmountSaved)) * 10 / 12);
                end else if MonthAmountSaved <= 0 then begin
                    InterestEarned := 0 + InterestEarned;
                end;

            end;
            //.........................9
            NewMonth := 0D;
            NewMonth := CalcDate('3M', StartDate);
            Customer2.Reset;
            Customer2.SetRange(Customer2."No.", MemberNo);
            Customer2.SetAutocalcFields(Customer2."Holiday Savings");
            Customer2.SetFilter(Customer2."Date Filter", '%1..%2', NewMonth, CalcDate('CM', NewMonth));
            if Customer2.Find('-') then begin
                MonthAmountSaved := 0;
                MonthAmountSaved := Customer2."Holiday Savings";
                if MonthAmountSaved > 0 then begin
                    InterestEarned := (InterestEarned + (((SaccoGeneralSetUp."HolidaySavings(%)" / 100) * MonthAmountSaved)) * 9 / 12);
                end else if MonthAmountSaved <= 0 then begin
                    InterestEarned := 0 + InterestEarned;
                end;

            end;
            //.........................8
            NewMonth := 0D;
            NewMonth := CalcDate('4M', StartDate);
            Customer2.Reset;
            Customer2.SetRange(Customer2."No.", MemberNo);
            Customer2.SetAutocalcFields(Customer2."Holiday Savings");
            Customer2.SetFilter(Customer2."Date Filter", '%1..%2', NewMonth, CalcDate('CM', NewMonth));
            if Customer2.Find('-') then begin
                MonthAmountSaved := 0;
                MonthAmountSaved := Customer2."Holiday Savings";
                if MonthAmountSaved > 0 then begin
                    InterestEarned := (InterestEarned + (((SaccoGeneralSetUp."HolidaySavings(%)" / 100) * MonthAmountSaved)) * 8 / 12);
                end else if MonthAmountSaved <= 0 then begin
                    InterestEarned := 0 + InterestEarned;
                end;

            end;
            //.........................7
            NewMonth := 0D;
            NewMonth := CalcDate('5M', StartDate);
            Customer2.Reset;
            Customer2.SetRange(Customer2."No.", MemberNo);
            Customer2.SetAutocalcFields(Customer2."Holiday Savings");
            Customer2.SetFilter(Customer2."Date Filter", '%1..%2', NewMonth, CalcDate('CM', NewMonth));
            if Customer2.Find('-') then begin
                MonthAmountSaved := 0;
                MonthAmountSaved := Customer2."Holiday Savings";
                if MonthAmountSaved > 0 then begin
                    InterestEarned := (InterestEarned + (((SaccoGeneralSetUp."HolidaySavings(%)" / 100) * MonthAmountSaved)) * 7 / 12);
                end else if MonthAmountSaved <= 0 then begin
                    InterestEarned := 0 + InterestEarned;
                end;

            end;
            //.........................6
            NewMonth := 0D;
            NewMonth := CalcDate('6M', StartDate);
            Customer2.Reset;
            Customer2.SetRange(Customer2."No.", MemberNo);
            Customer2.SetAutocalcFields(Customer2."Holiday Savings");
            Customer2.SetFilter(Customer2."Date Filter", '%1..%2', NewMonth, CalcDate('CM', NewMonth));
            if Customer2.Find('-') then begin
                MonthAmountSaved := 0;
                MonthAmountSaved := Customer2."Holiday Savings";
                if MonthAmountSaved > 0 then begin
                    InterestEarned := (InterestEarned + (((SaccoGeneralSetUp."HolidaySavings(%)" / 100) * MonthAmountSaved)) * 6 / 12);
                end else if MonthAmountSaved <= 0 then begin
                    InterestEarned := 0 + InterestEarned;
                end;

            end;
            //.........................5
            NewMonth := 0D;
            NewMonth := CalcDate('7M', StartDate);
            Customer2.Reset;
            Customer2.SetRange(Customer2."No.", MemberNo);
            Customer2.SetAutocalcFields(Customer2."Holiday Savings");
            Customer2.SetFilter(Customer2."Date Filter", '%1..%2', NewMonth, CalcDate('CM', NewMonth));
            if Customer2.Find('-') then begin
                MonthAmountSaved := 0;
                MonthAmountSaved := Customer2."Holiday Savings";
                if MonthAmountSaved > 0 then begin
                    InterestEarned := (InterestEarned + (((SaccoGeneralSetUp."HolidaySavings(%)" / 100) * MonthAmountSaved)) * 5 / 12);
                end else if MonthAmountSaved <= 0 then begin
                    InterestEarned := 0 + InterestEarned;
                end;

            end;
            //.........................4
            NewMonth := 0D;
            NewMonth := CalcDate('8M', StartDate);
            Customer2.Reset;
            Customer2.SetRange(Customer2."No.", MemberNo);
            Customer2.SetAutocalcFields(Customer2."Holiday Savings");
            Customer2.SetFilter(Customer2."Date Filter", '%1..%2', NewMonth, CalcDate('CM', NewMonth));
            if Customer2.Find('-') then begin
                MonthAmountSaved := 0;
                MonthAmountSaved := Customer2."Holiday Savings";
                if MonthAmountSaved > 0 then begin
                    InterestEarned := (InterestEarned + (((SaccoGeneralSetUp."HolidaySavings(%)" / 100) * MonthAmountSaved)) * 4 / 12);
                end else if MonthAmountSaved <= 0 then begin
                    InterestEarned := 0 + InterestEarned;
                end;

            end;
            //.........................3
            NewMonth := 0D;
            NewMonth := CalcDate('9M', StartDate);
            Customer2.Reset;
            Customer2.SetRange(Customer2."No.", MemberNo);
            Customer2.SetAutocalcFields(Customer2."Holiday Savings");
            Customer2.SetFilter(Customer2."Date Filter", '%1..%2', NewMonth, CalcDate('CM', NewMonth));
            if Customer2.Find('-') then begin
                MonthAmountSaved := 0;
                MonthAmountSaved := Customer2."Holiday Savings";
                if MonthAmountSaved > 0 then begin
                    InterestEarned := (InterestEarned + (((SaccoGeneralSetUp."HolidaySavings(%)" / 100) * MonthAmountSaved)) * 3 / 12);
                end else if MonthAmountSaved <= 0 then begin
                    InterestEarned := 0 + InterestEarned;
                end;

            end;
            //.........................2
            NewMonth := 0D;
            NewMonth := CalcDate('10M', StartDate);
            Customer2.Reset;
            Customer2.SetRange(Customer2."No.", MemberNo);
            Customer2.SetAutocalcFields(Customer2."Holiday Savings");
            Customer2.SetFilter(Customer2."Date Filter", '%1..%2', NewMonth, CalcDate('CM', NewMonth));
            if Customer2.Find('-') then begin
                MonthAmountSaved := 0;
                MonthAmountSaved := Customer2."Holiday Savings";
                if MonthAmountSaved > 0 then begin
                    InterestEarned := (InterestEarned + (((SaccoGeneralSetUp."HolidaySavings(%)" / 100) * MonthAmountSaved)) * 2 / 12);
                end else if MonthAmountSaved <= 0 then begin
                    InterestEarned := 0 + InterestEarned;
                end;

            end;
            //.........................1
            NewMonth := 0D;
            NewMonth := CalcDate('11M', StartDate);
            Customer2.Reset;
            Customer2.SetRange(Customer2."No.", MemberNo);
            Customer2.SetAutocalcFields(Customer2."Holiday Savings");
            Customer2.SetFilter(Customer2."Date Filter", '%1..%2', NewMonth, CalcDate('CM', NewMonth));
            if Customer2.Find('-') then begin
                MonthAmountSaved := 0;
                MonthAmountSaved := Customer2."Holiday Savings";
                if MonthAmountSaved > 0 then begin
                    InterestEarned := (InterestEarned + (((SaccoGeneralSetUp."HolidaySavings(%)" / 100) * MonthAmountSaved)) * 1 / 12);
                end else if MonthAmountSaved <= 0 then begin
                    InterestEarned := 0 + InterestEarned;
                end;
            end;
            //.............................
            FnInsertHolidayJournalLines(MemberNo, InterestEarned, MemberHolidaySaving, PostingDate);
            FnINsertAmountsToTable(MemberNo, InterestEarned, MemberHolidaySaving, PostingDate);
        end;
    end;

    local procedure FnInsertHolidayJournalLines(MemberNo: Code[10]; InterestEarned: Decimal; MemberHolidaySaving: Decimal; PostingDate: Date)
    begin
        //....................................Insert Member Saved Amounts start
        //...Dr Member Holiday Account
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLine('GENERAL', 'HOLIDAY', (Format(Date2dmy(Today, 3)) + '-HOLID'), LineNo, GenJournalLine."transaction type"::"Holiday Savings",
        GenJournalLine."account type"::Customer, MemberNo, PostingDate, MemberHolidaySaving, 'BOSA', '',
        'Holiday Savings Transferred To Bank- ' + Format(PostingDate) + SaccoGeneralSetUp."HolidaySavings Payout Bank", '');
        //...Cr Bank Account Paying Out
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLine('GENERAL', 'HOLIDAY', (Format(Date2dmy(Today, 3)) + '-HOLID'), LineNo, GenJournalLine."transaction type"::"Holiday savings",
        GenJournalLine."account type"::"Bank Account", SaccoGeneralSetUp."HolidaySavings Payout Bank", PostingDate, MemberHolidaySaving * -1, 'BOSA', '',
        'Holiday Savings Paid Out To Member- ' + swizzMobile.GetMemberNameCustomer(MemberNo), '');
        //.....................................Insert Member Saved Amounts Stop
        //.....................................Insert Member Interest Earned Amounts Start
        //...Dr Provision Account for Holiday Savings
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLine('GENERAL', 'HOLIDAY', (Format(Date2dmy(Today, 3)) + '-HOLID'), LineNo, GenJournalLine."transaction type"::"Holiday savings",
        GenJournalLine."account type"::"G/L Account", '201216', PostingDate, InterestEarned, 'BOSA', '',
        'Holiday Savings Interest Earned- ' + swizzMobile.GetMemberNameCustomer(MemberNo), '');
        //...Cr Bank Account Paying Out
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLine('GENERAL', 'HOLIDAY', (Format(Date2dmy(Today, 3)) + '-HOLID'), LineNo, GenJournalLine."transaction type"::"Holiday savings",
        GenJournalLine."account type"::"Bank Account", SaccoGeneralSetUp."HolidaySavings Payout Bank", PostingDate, InterestEarned * -1, 'BOSA', '',
        'Holiday Savings Interest Earned Paid Out To Member- ' + Format(PostingDate), '');
        //....................................Insert Member Interest Earned Amounts stop
    end;

    local procedure FnINsertAmountsToTable(MemberNo: Code[10]; InterestEarned: Decimal; MemberHolidaySaving: Decimal; PostingDate: Date)
    begin
        HolidayTable.Init();
        HolidayTable."Member No" := MemberNo;
        HolidayTable.Year := (Format(Date2dmy(Today, 3)));
        HolidayTable."Holiday Savings Paid Out" := MemberHolidaySaving;
        HolidayTable."Holiday Interest Paid Out" := InterestEarned;
        HolidayTable."Total Paid Out" := (MemberHolidaySaving + InterestEarned);
        HolidayTable.Insert(true);
    end;
}

