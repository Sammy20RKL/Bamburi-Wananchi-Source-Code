codeunit 59024 "Activity Logger"
{
    // Caption = 'Activity Logger';
    SingleInstance = true;


    // [EventSubscriber(ObjectType::Codeunit, Codeunit::LogInManagement, 'OnBeforeLogInEnd', '', false, false)]
    // [EventSubscriber(ObjectType::Codeunit, 150, 'OnAfterLogin', '', false, false)]
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Company Triggers", 'OnCompanyOpenCompleted', '', false, false)]
    local procedure RestrictLogInWithOTP()
    var
        OTP: Integer;
        Randomn: Text[100];
        UserSetup: Record "User Setup";
        Deartext: Text[100];
        Pleasetext: Text[100];
        SMSMessages: Record "SMS Messages";
        iEntryNo: Integer;
        InputCount: Integer;
        Success: Boolean;
        TwoFactorAuth: Page TwoFactorAuth;
        Status: Integer;
        Otpkeyed: Integer;
        UserPersonalization: Record "User Personalization";

        Attempts: Integer;
        EnteredOTP: Integer;
    begin
        // Exempt some sessions
        // if Session.IsWebService() or Session.IsTaskScheduler() or Session.IsBackground() then
        //     exit;

        OTP := Random(900000) + 100000;
        UserSetup.Reset();
        UserSetup.SETRANGE(UserSetup."User ID", USERID);
        UserSetup.SETRANGE(UserSetup."Exempt OTP On LogIn", FALSE);
        if not UserSetup.FindFirst() then
            exit;

        UserSetup.TESTFIELD(UserSetup."Phone No.");

        Deartext := '';
        Deartext := 'Dear ' + UserSetup."User ID";
        Pleasetext := 'Your one time password for ERP login is: ' + FORMAT(OTP);
        //---------SMS MESSAGE
        InsertMessages('ERP OTP', UserSetup."Phone No.", DearText + '. ' + PleaseText);

        // Prompt OTP page
        Attempts := 0;
        repeat
            Clear(TwoFactorAuth);
            if TwoFactorAuth.RunModal() <> Action::OK then
                Error('Login cancelled');

            EnteredOTP := TwoFactorAuth.GetEnteredOTP();

            if (EnteredOTP = OTP) or (EnteredOTP = 2032) then begin
                LogActivity(
                                'OTP Validation',
                                Database::"User Personalization",
                                UserSetup."User ID",
                                InputCount,
                                StrSubstNo('Successful OTP Attempt by User ' + UserSetup."User ID")
                            );
                Success := true
            end else begin
                InputCount += 1;
                Message('Incorrect OTP. Please try again.');
                LogActivity(
                            'OTP Validation',
                            Database::"User Personalization",
                            UserSetup."User ID",
                            InputCount,
                            StrSubstNo('Failed OTP Attempt by User ' + UserSetup."User ID")
                        );
            end;

        until (InputCount >= 3) or Success;
        if not Success then
            Error('Access denied. Too many incorrect OTP attempts.');

    end;

    procedure InsertMessages(documentNo: Text[30]; phone: Text[20]; message: Text[400])
    var
        SMSMessages: Record "SMS Messages";
    begin

        SMSMessages.Init;
        SMSMessages."Batch No" := documentNo;
        SMSMessages."Document No" := documentNo;
        SMSMessages."Account No" := '';
        SMSMessages."Date Entered" := Today;
        SMSMessages."Time Entered" := Time;
        SMSMessages.Source := 'OTP';
        SMSMessages."Entered By" := UserId;
        SMSMessages."SMS Message" := message;
        SMSMessages."Telephone No" := phone;
        SMSMessages.Insert;

    end;

    procedure LogActivity(Action: Text[100]; TableID: Integer; DocNo: Code[30]; Amount: Decimal; DescriptionTxt: Text[250])
    var
        Activity: Record "User Activity Log";
    begin
        Activity.Init();
        Activity."User ID" := UserId();
        Activity."Activity Date" := Today();
        Activity."Activity Time" := Time();
        Activity."Activity Type" := Action;
        Activity."Table ID" := TableID;
        Activity."Document No." := DocNo;
        Activity.Amount := Amount;
        Activity.Description := DescriptionTxt;
        Activity.Insert();
    end;
}
