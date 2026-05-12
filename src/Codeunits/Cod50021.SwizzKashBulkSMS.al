#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 50021 SwizzKashBulkSMS
{

    trigger OnRun()
    begin
    end;

    var
        SMSMessages: Record "SMS Messages";
        SMSCharges: Record "SMS Charges";
        SMSCharge: Decimal;
        ExDuty: Decimal;
        Vendor: Record Vendor;
        GenJournalLine: Record "Gen. Journal Line";
        GenBatches: Record "Gen. Journal Batch";
        LineNo: Integer;
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        ExDutyGLAcc: label '201421';
        UserSetUp: Record "User Setup";


    procedure PollPendingSMS() MessageDetails: Text[500]
    begin
        begin
            SMSMessages.Reset;
            SMSMessages.SetRange(SMSMessages."Sent To Server", SMSMessages."sent to server"::No);
            // SMSMessages.SetRange(SMSMessages.Source, 'MOBILETRAN');
            // SMSMessages.SETFILTER(SMSMessages.Source, '%1|%2', 'MOBILETRAN', 'PAYBILL');
            SMSMessages.SetRange(SMSMessages."Date Entered", Today);
            if SMSMessages.Find('-') then begin

                if (SMSMessages."Telephone No" = '') or (SMSMessages."Telephone No" = '+') or (SMSMessages."SMS Message" = '') then begin
                    SMSMessages."Sent To Server" := SMSMessages."sent to server"::Failed;
                    SMSMessages."Entry No." := 'FAILED';
                    SMSMessages.Modify;
                end else if ((SMSMessages.Source) = 'ERP OTP') then begin
                    SMSMessages."Sent To Server" := SMSMessages."sent to server"::Failed;
                    SMSMessages."Entry No." := 'FAILED';
                    SMSMessages.Modify;
                end else begin
                    MessageDetails := '{ "Phonenumber":"' + SMSMessages."Telephone No" + '","Message":"' + SMSMessages."SMS Message" + '","EntryNo":"' + Format(SMSMessages."Entry No") + '" }';
                end;
            end;
        end;
        FnReorderLevel();
    end;


    procedure ConfirmSent(TelephoneNo: Text[50]; Status: Integer) result: Boolean;
    begin

        SMSMessages.Reset;
        SMSMessages.SetRange(SMSMessages."Sent To Server", SMSMessages."sent to server"::No);
        // SMSMessages.SETRANGE(SMSMessages.Source, 'MOBILETRAN');
        // SMSMessages.SETRANGE(SMSMessages."Telephone No", TelephoneNo);
        SMSMessages.SetRange(SMSMessages."Entry No", Status);
        if SMSMessages.FindFirst then begin
            SMSMessages."Sent To Server" := SMSMessages."sent to server"::Yes;
            SMSMessages."Date Sent to Server" := Today;
            SMSMessages."Time Sent To Server" := Today;
            SMSMessages."Entry No." := 'SUCCESS';
            SMSMessages.Modify;
            result := true;
        end
    end;


    procedure ChargeSMS()
    begin

        SMSMessages.Reset;
        SMSMessages.SetRange(SMSMessages."Sent To Server", SMSMessages."sent to server"::Yes);
        SMSMessages.SetRange(SMSMessages."Entry No.", 'SUCCESS');
        SMSMessages.SetFilter(SMSMessages."Telephone No", '<>%1', '');
        SMSMessages.SetFilter(SMSMessages."Telephone No", '<>%1', '+254');
        SMSMessages.SetRange(SMSMessages.Charged, false);
        if SMSMessages.Find('-') then
            repeat
            begin

                SMSCharges.Reset;
                SMSCharges.SetFilter(SMSCharges.Source, SMSMessages.Source);
                if SMSCharges.Find('-') then begin
                    SMSCharges.TestField(SMSCharges."Charge Account");
                    SMSCharge := SMSCharges.Amount;
                    ExDuty := (10 / 100) * SMSCharge;
                end;
                Vendor.Reset;
                Vendor.SetRange(Vendor."No.", SMSMessages."Account No");
                if Vendor.Find('-') then begin
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                    GenJournalLine.SetRange("Journal Batch Name", 'SMSCHARGE');
                    GenJournalLine.DeleteAll;
                    //end of deletion

                    GenBatches.Reset;
                    GenBatches.SetRange(GenBatches."Journal Template Name", 'GENERAL');
                    GenBatches.SetRange(GenBatches.Name, 'SMSCHARGE');

                    if GenBatches.Find('-') = false then begin
                        GenBatches.Init;
                        GenBatches."Journal Template Name" := 'GENERAL';
                        GenBatches.Name := 'SMSCHARGE';
                        GenBatches.Description := 'SMS Charges';
                        GenBatches.Validate(GenBatches."Journal Template Name");
                        GenBatches.Validate(GenBatches.Name);
                        GenBatches.Insert;
                    end;

                    //DR Member Account
                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'SMSCHARGE';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                    GenJournalLine."Account No." := Vendor."No.";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := Format(SMSMessages."Entry No");
                    GenJournalLine."External Document No." := SMSMessages.Source;
                    GenJournalLine."Posting Date" := Today;
                    GenJournalLine.Description := 'SMS Charges';
                    GenJournalLine.Amount := SMSCharges.Amount;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;

                    //Cr SMS Charges Acc
                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'SMSCHARGE';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                    GenJournalLine."Account No." := SMSCharges."Charge Account";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := Format(SMSMessages."Entry No");
                    GenJournalLine."External Document No." := SMSMessages.Source;
                    GenJournalLine."Posting Date" := Today;
                    GenJournalLine."Source No." := Vendor."No.";
                    GenJournalLine.Description := 'SMS Charge';
                    GenJournalLine.Amount := -SMSCharges.Amount;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;

                    //DR Excise Duty
                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'SMSCHARGE';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                    GenJournalLine."Account No." := Vendor."No.";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                    GenJournalLine."Bal. Account No." := ExDutyGLAcc;
                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                    GenJournalLine."Document No." := Format(SMSMessages."Entry No");
                    GenJournalLine."External Document No." := SMSMessages.Source;
                    GenJournalLine."Posting Date" := Today;
                    GenJournalLine.Description := 'Excise duty-SMS Notification';
                    GenJournalLine."Source No." := Vendor."No.";
                    GenJournalLine.Amount := ExDuty;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;
                    //Post
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                    GenJournalLine.SetRange("Journal Batch Name", 'SMSCHARGE');
                    if GenJournalLine.Find('-') then begin
                        repeat
                            GLPosting.Run(GenJournalLine);
                        until GenJournalLine.Next = 0;
                    end;

                end;
            end;

            SMSMessages.Charged := true;
            SMSMessages.Modify;
            Commit;
            until SMSMessages.Next = 0;
    end;

    procedure FnReorderLevel()
    var
        GLAccount: Record "G/L Account";
        GeneralSetUp: Record "Sacco General Set-Up";
        SwizzsoftFactory: Codeunit "SWIZZSFT Factory";
        msg: Text;
        ReorderTable: Record "Reorder Alerts";
    begin
        GLAccount.Reset;
        GLAccount.SetRange(GLAccount."No.", '6-01-1-0016-00');
        GLAccount.SetAutocalcFields(GLAccount.Balance);
        if GLAccount.Find('-') then begin
            GeneralSetUp.Get();
            if (GLAccount.Balance < 500001) and (GeneralSetUp."Last Reoder Date" <> Today) then begin
                //................Check table on who should receive message alerts
                ReorderTable.Reset;
                if ReorderTable.Find('-') then begin
                    repeat
                        msg := 'Dear ' + Format(ReorderTable."First Name") + ',the float is ' + Format(GLAccount.Balance) + '. Kindly replenish.';
                        SwizzsoftFactory.FnSendSMS('REORDER', msg, '', ReorderTable."Phone No");
                    until ReorderTable.Next = 0;
                end;
                GeneralSetUp."Last Reoder Date" := Today;
                GeneralSetUp.Modify;
            end else
                if (GLAccount.Balance < 300001) and (GeneralSetUp."Last Reminder Reorder Date" <> Today) then begin
                    //................Check table on who should receive message alerts
                    ReorderTable.Reset;
                    if ReorderTable.Find('-') then begin
                        repeat
                            msg := 'Dear ' + Format(ReorderTable."First Name") + ',the float is ' + Format(GLAccount.Balance) + '. Kindly replenish.';
                            SwizzsoftFactory.FnSendSMS('REORDER', msg, '', ReorderTable."Phone No");
                        until ReorderTable.Next = 0;
                    end;
                    GeneralSetUp."Last Reminder Reorder Date" := Today;
                    GeneralSetUp.Modify;
                end else
                    //.........................................................................
                    if (GLAccount.Balance < 0) and (GeneralSetUp."Negative Reminder Time" = Time) then begin
                        //................Check table on who should receive message alerts
                        ReorderTable.Reset;
                        if ReorderTable.Find('-') then begin
                            repeat
                                msg := 'Dear ' + Format(ReorderTable."First Name") + ',your float GL Account is overdrawn by '
                                + Format(GLAccount.Balance) + '. Kindly post the cheque as soon as possible.';
                                SwizzsoftFactory.FnSendSMS('REORDER', msg, '', ReorderTable."Phone No");
                            until ReorderTable.Next = 0;
                        end;
                        GeneralSetUp."Negative Reminder Time" := Time;
                        GeneralSetUp.Modify;
                    end;
            //.........................................................................
        end;
        // ..............................................Update Posting Range
        UserSetUp.Reset;
        UserSetUp.SetFilter(UserSetUp."User ID", '%1|%2|%3', 'MOBILE', 'ATM', 'AGENCY');
        if UserSetUp.Find('-') then begin
            repeat
                UserSetUp."Allow Posting From" := CalcDate('-7D', Today);
                UserSetUp."Allow Posting To" := Today;
                UserSetUp.Modify();
            until UserSetUp.Next = 0;
        end;

    end;

}

