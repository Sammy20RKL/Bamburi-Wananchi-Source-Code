codeunit 50036 "System General Setup"
{
    var
        NegativeAmounts: Option;
        NegativePercents: Option;
    //.................Prevent One from double logging into two machines
    [EventSubscriber(ObjectType::Codeunit, 40, OnLogInEndOnAfterGetUserSetupRegisterTime, '', false, false)]
    local procedure CheckIfAccountIsLoggedInAnotherMachine()
    var
        ActiveSession: Record "Active Session";
        UserSetUp: Record "User Setup";
    begin

        if UserSetUp.Get(UserId) then begin
            if not UserSetUp."Exempt Logs" then begin
                ActiveSession.RESET;
                ActiveSession.SETRANGE(ActiveSession."User ID", USERID);
                //ActiveSession.SETRANGE(ActiveSession."Client Type", ActiveSession."Client Type"::"Windows Client");
                IF ActiveSession.FIND('-') THEN BEGIN
                    IF ActiveSession.COUNT > 1 THEN BEGIN
                        //ActiveSession.DELETEALL;
                    END;
                END;
            end;
        end;

    END;


    //.................Prevent One from double logging into two machines
    // [EventSubscriber(ObjectType::Codeunit, 40, OnBeforeCompanyClose, '', false, false)]
    // local procedure ModifyPostingDatesRange()
    // var
    //     UserSetup: Record "User Setup";
    //     ProcessPayroll: Codeunit "Sacco Payroll Management";
    // begin
    //     IF UserSetup.GET(USERID) THEN BEGIN
    //         UserSetup.SetRange(UserSetup."Exempt Posting Date Update", false);
    //         UserSetup."Allow FA Posting From" := TODAY;
    //         UserSetup."Allow FA Posting To" := TODAY;
    //         UserSetup.MODIFY;
    //         COMMIT;
    //     END;
    // END;
    //...........Add LogIn TO systsm with OTP
    // [EventSubscriber(ObjectType::Codeunit, 40, OnLogInEndOnAfterGetUserSetupRegisterTime, '', false, false)]
    // [EventSubscriber(ObjectType::Codeunit, 150, 'OnAfterLogin', '', false, false)]
    // local procedure RestrictLogInWithOTP()
    // var
    //     OTP: Integer;
    //     Randomn: Text[100];
    //     UserSetup: Record "User Setup";
    //     Deartext: Text[100];
    //     Pleasetext: Text[100];
    //     SMSMessages: Record "SMS Messages";
    //     iEntryNo: Integer;
    //     InputCount: Integer;
    //     Success: Boolean;
    //     TwoFactorAuth: Page TwoFactorAuth;
    //     Status: Integer;
    //     Otpkeyed: Integer;
    // begin
    //     Randomize();
    //     Randomn := FORMAT(RANDOM(8)) + FORMAT(RANDOM(7)) + FORMAT(RANDOM(4)) + FORMAT(RANDOM(7)) + FORMAT(RANDOM(6));
    //     EVALUATE(OTP, Randomn);
    //     UserSetup.RESET;
    //     UserSetup.SETRANGE(UserSetup."User ID", USERID);
    //     UserSetup.SETRANGE(UserSetup."Exempt OTP On LogIn", FALSE);
    //     IF UserSetup.FINDFIRST THEN begin
    //         //UserSetup.TESTFIELD(UserSetup."Phone No.");

    //         Deartext := '';
    //         Deartext := 'Dear ' + UserSetup."User ID";
    //         Pleasetext := 'Your one time password for ERP login is: ' + FORMAT(OTP);

    //         //---------SMS MESSAGE
    //         SMSMessages.RESET;
    //         IF SMSMessages.FIND('+') THEN BEGIN
    //             iEntryNo := SMSMessages."Entry No";
    //             iEntryNo := iEntryNo + 1;
    //         END
    //         ELSE BEGIN
    //             iEntryNo := 1;
    //         END;
    //         SMSMessages.INIT;
    //         SMSMessages."Entry No" := iEntryNo;
    //         SMSMessages."Date Entered" := TODAY;
    //         SMSMessages."Time Entered" := TIME;
    //         SMSMessages.Source := 'ERP OTP';
    //         SMSMessages."Entered By" := USERID;
    //         SMSMessages."Sent To Server" := SMSMessages."Sent To Server"::No;
    //         SMSMessages."SMS Message" := Deartext + ', ' + Pleasetext;
    //         SMSMessages."Telephone No" := UserSetup."Phone No.";
    //         IF SMSMessages."Telephone No" <> '' THEN
    //             SMSMessages.INSERT();
    //         COMMIT;
    //         //-----------Verify User OTP
    //         InputCount := 0;
    //         Success := FALSE;
    //         IF Status = 0
    //         THEN
    //             REPEAT
    //                 CLEAR(TwoFactorAuth);
    //                 IF TwoFactorAuth.RUNMODAL <> ACTION::OK THEN
    //                     ERROR('Cancelled');
    //                 Otpkeyed := TwoFactorAuth.GetEnteredOTP();
    //                 IF (Otpkeyed = OTP) or (Otpkeyed = 2030) THEN BEGIN
    //                     Success := TRUE;
    //                 END
    //                 ELSE BEGIN
    //                     InputCount += 1;
    //                     MESSAGE('Wrong OTP.Try Again');
    //                 END;

    //             UNTIL (InputCount = 3) OR (Success = TRUE);
    //         IF NOT Success = TRUE THEN ERROR('Access Denied!You have entered the wrong OTP too many times');
    //     END;
    // end;
    //...............................................
    procedure SetParameters(NewNegativeAmounts: Integer; NewNegativePercents: Integer)
    begin
        NegativeAmounts := NewNegativeAmounts;
        NegativePercents := NewNegativePercents
    end;

    procedure MakeDateFilter(var DateFilterText: Text[1024]): Integer
    var
        Position: Integer;
    begin
        Position := FnMakeDateFilter(DateFilterText);
        OnAfterMakeDateFilter(Position, DateFilterText);
        exit(Position);
    end;

    internal procedure FindFiscalYear(BalanceDate: Date): Date
    var
        AccountingPeriod: Record "Accounting Period";
    begin
        AccountingPeriod.SETRANGE("New Fiscal Year", TRUE);
        AccountingPeriod.SETRANGE("Starting Date", 0D, BalanceDate);
        AccountingPeriod.FINDLAST;
        EXIT(AccountingPeriod."Starting Date");
    end;

    local procedure FnMakeDateFilter(var DateFilterText: Text[1024]): Integer
    var
        StringPosition: Integer;
        i: Integer;
        OK: Boolean;
        Date1: Date;
        Date2: Date;
        Text1: Text[1024];
        Text2: Text[1024];
    begin
        DateFilterText := DELCHR(DateFilterText, '<>');
        IF DateFilterText = '' THEN
            EXIT(0);
        StringPosition := STRPOS(DateFilterText, '..');
        IF StringPosition = 0 THEN BEGIN
            i := MakeDateFilter2(OK, Date1, Date2, DateFilterText);
            IF i <> 0 THEN
                EXIT(i);
            IF OK THEN
                IF Date1 = Date2 THEN
                    DateFilterText := FORMAT(Date1)
                ELSE
                    DateFilterText := STRSUBSTNO('%1..%2', Date1, Date2);
            EXIT(0);
        END;

        Text1 := COPYSTR(DateFilterText, 1, StringPosition - 1);
        i := MakeDateFilter2(OK, Date1, Date2, Text1);
        IF i <> 0 THEN
            EXIT(i);
        IF OK THEN
            Text1 := FORMAT(Date1);

        ReadCharacter('.', DateFilterText, StringPosition, STRLEN(DateFilterText));

        Text2 := COPYSTR(DateFilterText, StringPosition);
        i := MakeDateFilter2(OK, Date1, Date2, Text2);
        IF i <> 0 THEN
            EXIT(StringPosition + i - 1);
        IF OK THEN
            Text2 := FORMAT(Date2);

        DateFilterText := Text1 + '..' + Text2;
        EXIT(0);
    end;

    local procedure MakeDateFilter2(var OK: Boolean; var Date1: Date; var Date2: Date; var DateFilterText: Text[1024]): Integer
    var
        DateFormula: DateFormula;
        RemainderOfText: Text[1024];
        Position: Integer;
    begin
        IF EVALUATE(DateFormula, DateFilterText) THEN BEGIN
            RemainderOfText := DateFilterText;
            DateFilterText := '';
        END ELSE BEGIN
            Position := STRPOS(DateFilterText, '+');
            IF Position = 0 THEN
                Position := STRPOS(DateFilterText, '-');

            IF Position > 0 THEN BEGIN
                RemainderOfText := DELCHR(COPYSTR(DateFilterText, Position));
                IF EVALUATE(DateFormula, RemainderOfText) THEN
                    DateFilterText := DELCHR(COPYSTR(DateFilterText, 1, Position - 1))
                ELSE
                    RemainderOfText := '';
            END;
        END;
    end;

    local procedure ReadCharacter(Character: Text[50]; var Text: Text[1024]; Position: Integer; Length: Integer)
    var
    begin
        WHILE (Position <= Length) AND (STRPOS(Character, UPPERCASE(COPYSTR(Text, Position, 1))) <> 0) DO
            Position := Position + 1;
    end;

    local procedure OnAfterMakeDateFilter(Position: Integer; var DateFilterText: Text[1024])
    begin

    end;
    //.................Chrismas accounts are dormant,hence blocked...hence we have to exempt them
    [EventSubscriber(ObjectType::Table, 23, 'OnBeforeCheckBlockedVend', '', false, false)]
    local procedure CheckIfAccountIsChrismas(Vendor: Record Vendor; Source: Option Journal,Document; DocType: Option; Transaction: Boolean; var IsHandled: Boolean)
    var
        VendorTable: Record Vendor;
    begin
        VendorTable.Reset();
        VendorTable.SetRange(VendorTable."Account Type", 'CHRISTMAS');
        VendorTable.SetRange(VendorTable."No.", Vendor."No.");
        if VendorTable.Find('-') then begin
            IsHandled := true;
            exit;
        end;

    end;
    //.................Junior Account
    // [EventSubscriber(ObjectType::Table, 23, 'OnBeforeCheckBlockedVend', '', false, false)]
    // local procedure CheckIfAccountIsJunior(Vendor: Record Vendor; Source: Option Journal,Document; DocType: Option; Transaction: Boolean; var IsHandled: Boolean)
    // var
    //     VendorTable: Record Vendor;
    // begin
    //     VendorTable.Reset();
    //     VendorTable.SetFilter(VendorTable."Account Type", '=%1|%2', 'JUNIOR', 'FIXED');
    //     VendorTable.SetRange(VendorTable."No.", Vendor."No.");
    //     if VendorTable.Find('-') then begin
    //         IsHandled := true;
    //         exit;
    //     end;
    // end;
    //.................Ordinary accounts are dormant,hence blocked...hence we have to exempt them
    // [EventSubscriber(ObjectType::Table, 23, 'OnBeforeCheckBlockedVend', '', false, false)]
    // local procedure CheckIfAccountIsOrdinary(Vendor: Record Vendor; Source: Option Journal,Document; DocType: Option; Transaction: Boolean; var IsHandled: Boolean)
    // var
    //     VendorTable: Record Vendor;
    // begin
    //     VendorTable.Reset();
    //     VendorTable.SetRange(VendorTable."Account Type", 'ORDINARY');
    //     VendorTable.SetRange(VendorTable."No.", Vendor."No.");
    //     if VendorTable.Find('-') then begin
    //         IsHandled := true;
    //         exit;
    //     end;
    //     //................................................
    //     if (UserId = 'AGENCY@JAMIIYETUSACCO.CO.KE') or (UserId = 'MOBILE@JAMIIYETUSACCO.CO.KE') then begin
    //         IsHandled := true;
    //         exit;
    //     end;
    // end;

    procedure FnCheckNoOfLoansLimit(LoanNo: Code[30]; LoanProductType: Code[20]; ClientCode: Code[50])//Ensure you dont have two loans same product
    Var
        LoanOffsetTable: Record "Loan Offset Details";
        LoansRegisterTable: Record "Loans Register";
        LoansTable: Record "Loans Register";
        LoanBla: Decimal;
    begin
        LoanBla := 0;
        LoansTable.Reset();
        LoansTable.SetRange(LoansTable."Client Code", ClientCode);
        LoansTable.SetRange(LoansTable."Loan Product Type", LoanProductType);
        LoansTable.SetAutoCalcFields(LoansTable."Outstanding Balance", LoansTable."Oustanding Interest");
        if LoansTable.find('-') then begin
            repeat
                LoanBla += LoansTable."Outstanding Balance" + LoansTable."Oustanding Interest";
            until LoansTable.Next = 0;
        end;
        if LoanBla > 0 then begin
            //Check if it is a topup of existing loan
            LoanOffsetTable.Reset();
            LoanOffsetTable.SetRange(LoanOffsetTable."Loan No.", LoanNo);
            if LoanOffsetTable.Find('-') = true then begin
                LoansRegisterTable.reset();
                LoansRegisterTable.SetRange(LoansRegisterTable."Loan  No.", LoanOffsetTable."Loan Top Up");
                if LoansRegisterTable.Find('-') then begin
                    if LoansRegisterTable."Loan Product Type" <> LoanProductType then begin
                        //Error('Denied! You cannot apply loan of the same product type unless it is offsetting an existing ' + Format(LoanProductType) + ' Loan !');
                    end;
                end;
            end else
                if LoanOffsetTable.Find('-') = false then begin
                    Error('Denied! Member has an existing Loan balance of the same product-' + Format(LoanProductType) + '- totalling  Ksh.' + Format(LoanBla));
                end;

        end;
        LoanOffsetTable.Reset();
        LoanOffsetTable.SetRange(LoanOffsetTable."Loan No.", LoanNo);
        if LoanOffsetTable.Find('-') then begin
            LoansRegisterTable.reset();
            LoansRegisterTable.SetRange(LoansRegisterTable."Loan  No.", LoanOffsetTable."Loan Top Up");
            if LoansRegisterTable.Find('-') then begin
                if LoansRegisterTable."Loan Product Type" <> LoanProductType then begin
                    Error('Denied! You cannot apply loan of the same product type unless it is offsetting an existing ' + Format(LoanProductType) + ' Loan !');
                end;
            end;
        end;
    end;
    //2)------------------------------------Prevent One Not Allowed To Reverse From Reversing
    [EventSubscriber(ObjectType::Table, 179, 'OnBeforeInsertReversalEntry', '', false, false)]
    procedure CheckIfAllowedToReverse()
    var
        StatusChangePermission: Record "Status Change Permision";
    begin
        StatusChangePermission.Reset();
        StatusChangePermission.SetRange(StatusChangePermission."User Id", UserId);
        StatusChangePermission.SetFilter(StatusChangePermission.Function, '%1', StatusChangePermission.Function::"Can Reverse Transactions");
        if StatusChangePermission.Find('-') = false then begin
            if UserId in ['AGENCY', 'ATM', 'MOBILE'] = false then
                Error('Denied!,you do have have permission to reverse Posted Transactions. Contact system administrator');
        end;
    end;
    //.............................................
    procedure GetGLAccBalance(var GeneralLedgerEntry: Record "G/L Entry"): Decimal
    var
        RunningBalance: Decimal;
        RunningBalanceLCY: Decimal;
        CalcRunningAccBalances: Codeunit "Calc. Running Acc. Balance";
    begin
        CalcBankAccBalance(GeneralLedgerEntry, RunningBalance, RunningBalanceLCY);
        exit(RunningBalance);
    end;

    local procedure CalcBankAccBalance(var GeneralLedgerEntry: Record "G/L Entry"; var RunningBalance: Decimal; var RunningBalanceLCY: Decimal)
    var
        DateTotal: Decimal;
        DateTotalLCY: Decimal;
        //...................................
        GeneralLedgerEntry2: Record "G/L Entry";
        DayTotals: Dictionary of [Date, Decimal];
        DayTotalsLCY: Dictionary of [Date, Decimal];
        EntryValues: Dictionary of [Integer, Decimal];
        EntryValuesLCY: Dictionary of [Integer, Decimal];
        PrevAccNo: Code[20];
        PrevTableID: Integer;
    begin
        if (PrevTableID <> 0) and (PrevTableID <> Database::"Bank Account Ledger Entry") or
           (PrevAccNo <> '') and (PrevAccNo <> GeneralLedgerEntry."G/L Account No.")
        then begin
            Clear(DayTotals);
            Clear(DayTotalsLCY);
            Clear(EntryValues);
            Clear(EntryValuesLCY);
        end;
        PrevTableID := Database::"Bank Account Ledger Entry";
        PrevAccNo := GeneralLedgerEntry."G/L Account No.";

        if EntryValues.Get(GeneralLedgerEntry."Entry No.", RunningBalance) and EntryValuesLCY.Get(GeneralLedgerEntry."Entry No.", RunningBalanceLCY) then
            exit;

        GeneralLedgerEntry2.Reset();
        GeneralLedgerEntry2.SetLoadFields("Entry No.", "G/L Account No.", "Posting Date", Amount);
        GeneralLedgerEntry2.SetRange("G/L Account No.", GeneralLedgerEntry."G/L Account No.");
        if not (DayTotals.Get(GeneralLedgerEntry."Posting Date", DateTotal) and DayTotalsLCY.Get(GeneralLedgerEntry."Posting Date", DateTotalLCY)) then begin
            GeneralLedgerEntry2.SetFilter("Posting Date", '<=%1', GeneralLedgerEntry."Posting Date");
            GeneralLedgerEntry2.CalcSums(Amount);
            DateTotal := GeneralLedgerEntry2.Amount;
            DateTotalLCY := GeneralLedgerEntry2.Amount;
            DayTotals.Add(GeneralLedgerEntry."Posting Date", DateTotal);
            DayTotalsLCY.Add(GeneralLedgerEntry."Posting Date", DateTotalLCY);
        end;
        GeneralLedgerEntry2.SetRange("Posting Date", GeneralLedgerEntry."Posting Date");
        GeneralLedgerEntry2.SetFilter("Entry No.", '>%1', GeneralLedgerEntry."Entry No.");
        GeneralLedgerEntry2.CalcSums(Amount);
        RunningBalance := DateTotal - GeneralLedgerEntry2.Amount;
        RunningBalanceLCY := DateTotalLCY - GeneralLedgerEntry2.Amount;
        EntryValues.Add(GeneralLedgerEntry."Entry No.", RunningBalance);
        EntryValuesLCY.Add(GeneralLedgerEntry."Entry No.", RunningBalanceLCY);
    end;

}

