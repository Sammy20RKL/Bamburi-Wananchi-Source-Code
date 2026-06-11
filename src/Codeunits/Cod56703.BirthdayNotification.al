codeunit 56703 "Custom Notifications"
{
    trigger OnRun()
    begin
        Message('This is a custom notification from codeunit 50011.');
    end;

    var
        membersRegister: Record Customer;
        currentDate: Date;
        membersBirthDate: Date;
        smsMessage: Text[500];
        iEntryNo: Integer;
        mobilePhone: Code[20];

        BirthDay: Integer;
        BirthMonth: Integer;
        TodayDay: Integer;
        TodayMonth: Integer;


    //Birthday Notification, to any Active Customer whose birthday is today
    procedure SendBirthdayNotification()
    var
        CurrentDate: Date;
        MembersBirthDate: Date;
    begin
        CurrentDate := Today;

        membersRegister.Reset();
        membersRegister.SetRange(Status, membersRegister.Status::Active);

        if membersRegister.FindSet() then begin
            repeat
                MembersBirthDate := membersRegister."Date of Birth";

                mobilePhone := '';
                if membersRegister."Mobile Phone No" <> '' then
                    mobilePhone := membersRegister."Mobile Phone No"
                else if membersRegister."Phone No." <> '' then
                    mobilePhone := membersRegister."Phone No.";

                TodayDay := Date2DMY(CurrentDate, 1);
                TodayMonth := Date2DMY(CurrentDate, 2);

                BirthDay := Date2DMY(MembersBirthDate, 1);
                BirthMonth := Date2DMY(MembersBirthDate, 2);

                if (BirthDay = TodayDay) and (BirthMonth = TodayMonth) then begin
                    // Send SMS
                    smsMessage :=
                        'Happy Birthday ' + membersRegister.Name + '! ' +
                        'As you celebrate another year of growth and success, ' +
                        'we wish you good health, happiness, prosperity, and greater financial achievements ahead. ' +
                        'Thank you for being our valued member and for growing with us. ' +
                        'This is the perfect time to increase your savings, access loans easily, ' +
                        'repay wisely, and take advantage of our Loan Buy Off facility at competitive low interest rates designed to give you financial relief and stability.' +
                        '\Kind regards' +
                        '\Bamburi Wananchi SACCO' +
                        '\Cementing Your Future';


                    fnSMSMessage(membersRegister."No.", mobilePhone, smsMessage);

                end;

            until membersRegister.Next() = 0;
        end;
    end;


    procedure fnSMSMessage(documentNo: Text[30]; phone: Text[20]; message: Text)
    var
        smsmessagesTable: Record "SMS Messages";
    begin

        iEntryNo := 0;
        smsmessagesTable.RESET;
        IF smsmessagesTable.FIND('+') THEN iEntryNo := smsmessagesTable."Entry No";
        iEntryNo += 1;

        smsmessagesTable.Init;
        smsmessagesTable."Entry No" := iEntryNo;
        smsmessagesTable."Batch No" := documentNo;
        smsmessagesTable."Document No" := documentNo;
        smsmessagesTable."Account No" := documentNo;
        smsmessagesTable."Date Entered" := Today;
        smsmessagesTable."Time Entered" := Time;
        smsmessagesTable.Source := 'Custom Notifications';
        smsmessagesTable."Entered By" := UserId;
        smsmessagesTable."Sent To Server" := smsmessagesTable."sent to server"::No;
        smsmessagesTable."SMS Message" := message;
        smsmessagesTable."Telephone No" := phone;
        if smsmessagesTable."Telephone No" <> '' then
            smsmessagesTable.Insert;

    end;


}
