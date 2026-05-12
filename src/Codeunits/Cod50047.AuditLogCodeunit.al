codeunit 50047 "Audit Log Codeunit"
{
    trigger OnRun()
    begin
        //1)LogIn
        //2)LogOut
        //3)Financial Postings Made
    end;
    //.......OnLogInEndOnAfterGetUserSetupRegisterTime
    // [EventSubscriber(ObjectType::Codeunit, 150, 'OnAfterLogin', '', false, false)]
    // local procedure RegisterUserAsLoggedIn()
    // var
    //     LastEntryNo: Integer;
    //     cdm: Codeunit 4030;
    // begin

    //     Message('Logged In machine is %1', cdm.GetCurrentClientType());
    // end;
    //.......

    //1).........................................Log In Trails
    [EventSubscriber(ObjectType::Codeunit, 150, 'OnAfterLogin', '', false, false)]
    local procedure RegisterUserLoginLogout()
    var
        LastEntryNo: Integer;
    begin
        //Exclude Automation Services
        if UserSetUp.Get(UserId) then begin
            if not UserSetUp."Exempt Logs" then begin
                //Get Last Used entryNo
                AuditLog.Reset();
                if AuditLog.Find('+') then begin
                    LastEntryNo := AuditLog."Entry No";
                end;
                //Insert Login log
                AuditLog.Init();
                AuditLog.LockTable(true);
                AuditLog."Entry No" := LastEntryNo + 1;
                AuditLog."User ID" := UserId;
                AuditLog."Session Type" := AuditLog."Session Type"::LogIn;
                AuditLog."Log In Time" := CurrentDateTime;
                AuditLog."Event Date/Time" := CurrentDateTime;
                SessionTracker.Reset();
                SessionTracker.SetRange(SessionTracker."User ID", AuditLog."User ID");
                if SessionTracker.FindLast() then begin
                    AuditLog."Log In Computer Name" := SessionTracker."Client Computer Name";
                    AuditLog."Server Instance" := SessionTracker."Server Instance Name";
                    AuditLog."Session ID" := SessionTracker."Session ID";
                    AuditLog."Database Name" := SessionTracker."Database Name";
                end;
                AuditLog.Insert(true);
            end;
        end;
    end;
    //2).........................................Log Out Trails
    [EventSubscriber(ObjectType::Codeunit, 40, 'OnBeforeCompanyClose', '', true, true)]
    local procedure RegisterUserLogout()
    var
        LastEntryNo: Integer;
    begin
        //Exclude Automation Services
        if UserSetUp.Get(UserId) then begin
            if not UserSetUp."Exempt Logs" then begin
                //Get Last Used entryNo
                AuditLog.Reset();
                if AuditLog.Find('+') then begin
                    LastEntryNo := AuditLog."Entry No";
                end;
                //Insert Logout log
                AuditLog.Init();
                AuditLog.LockTable(true);
                AuditLog."Entry No" := LastEntryNo + 1;
                AuditLog."User ID" := UserId;
                AuditLog."Session Type" := AuditLog."Session Type"::LogOut;
                AuditLog."Log out Time" := CurrentDateTime;
                AuditLog."Event Date/Time" := CurrentDateTime;
                SessionTracker.Reset();
                SessionTracker.SetRange(SessionTracker."User ID", AuditLog."User ID");
                if SessionTracker.FindLast() then begin
                    AuditLog."Log In Computer Name" := SessionTracker."Client Computer Name";
                    AuditLog."Server Instance" := SessionTracker."Server Instance Name";
                    AuditLog."Session ID" := SessionTracker."Session ID";
                    AuditLog."Database Name" := SessionTracker."Database Name";
                end;
                //AuditLog.Insert(true);
            end;
        end;

    end;

    //3).........................................Financial Postings Made
    [EventSubscriber(ObjectType::Codeunit, 12, 'OnBeforePostGenJnlLine', '', false, false)]
    local procedure InsertAuditLogOnPostedEntries(var GenJournalLine: Record "Gen. Journal Line"; Balancing: Boolean)
    var
        LastEntryNo: Integer;
        HoldGen: code[50];
    begin
        if UserSetUp.Get(UserId) then begin
            if not UserSetUp."Exempt Logs" then begin
                with GenJournalLine do
                    case "Account Type" of
                        "Account Type"::Customer:
                            begin
                                AuditLog.Reset();
                                if AuditLog.Find('+') then begin
                                    LastEntryNo := AuditLog."Entry No";
                                end;
                                //Insert Logout log
                                AuditLog.Init();
                                AuditLog.LockTable(true);
                                AuditLog."Entry No" := GetMaxEntryNo() + 1;

                                //AuditLog."Entry No" := LastEntryNo + 1;
                                AuditLog."User ID" := UserId;
                                AuditLog."Session Type" := AuditLog."Session Type"::Insert;
                                AuditLog."Event Date/Time" := CurrentDateTime;
                                AuditLog."Transaction Type ID" := GenJournalLine."Transaction Type";
                                AuditLog."Account ID" := GenJournalLine."Account No.";
                                AuditLog."Transaction ID" := GenJournalLine."Document No.";
                                AuditLog."Transaction Description" := GenJournalLine.Description;
                                AuditLog."Transaction Date" := Today;
                                AuditLog."Account Type ID" := GenJournalLine."Account Type";
                                AuditLog."Transaction Time" := Time;
                                AuditLog."Authorized By" := SwizzsoftFactory.FnGetDocumentApprover(GenJournalLine."Document No.");
                                if GenJournalLine.Amount < 0 then begin
                                    AuditLog."Transaction Type" := AuditLog."Transaction Type"::Credit;
                                    AuditLog."Transaction Amount" := (GenJournalLine.Amount) * -1;
                                end else
                                    if GenJournalLine.Amount > 0 then begin
                                        AuditLog."Transaction Type" := AuditLog."Transaction Type"::Debit;
                                        AuditLog."Transaction Amount" := (GenJournalLine.Amount);
                                    end;
                                AuditLog."Transacting Branch ID" := SwizzsoftFactory.FnGetUserBranch();
                                SessionTracker.Reset();
                                SessionTracker.SetRange(SessionTracker."User ID", AuditLog."User ID");
                                if SessionTracker.FindLast() then begin
                                    AuditLog."Log In Computer Name" := SessionTracker."Client Computer Name";
                                    AuditLog."Server Instance" := SessionTracker."Server Instance Name";
                                    AuditLog."Session ID" := SessionTracker."Session ID";
                                    AuditLog."Database Name" := SessionTracker."Database Name";
                                end;
                                AuditLog.Insert(true);
                            end;
                        "Account Type"::Vendor:
                            begin
                                AuditLog.Reset();
                                if AuditLog.Find('+') then begin
                                    LastEntryNo := AuditLog."Entry No";
                                end;
                                //Insert Logout log
                                AuditLog.Init();
                                AuditLog.LockTable(true);
                                AuditLog."Entry No" := GetMaxEntryNo() + 1;

                                //AuditLog."Entry No" := LastEntryNo + 1;
                                AuditLog."User ID" := UserId;
                                AuditLog."Session Type" := AuditLog."Session Type"::Insert;
                                AuditLog."Event Date/Time" := CurrentDateTime;
                                AuditLog."Transaction Type ID" := GenJournalLine."Transaction Type";
                                AuditLog."Account ID" := GenJournalLine."Account No.";
                                AuditLog."Transaction ID" := GenJournalLine."Document No.";
                                AuditLog."Transaction Description" := GenJournalLine.Description;
                                AuditLog."Transaction Date" := Today;
                                AuditLog."Account Type ID" := GenJournalLine."Account Type";
                                AuditLog."Transaction Time" := Time;
                                AuditLog."Authorized By" := SwizzsoftFactory.FnGetDocumentApprover(GenJournalLine."Document No.");
                                if GenJournalLine.Amount < 0 then begin
                                    AuditLog."Transaction Type" := AuditLog."Transaction Type"::Credit;
                                    AuditLog."Transaction Amount" := (GenJournalLine.Amount) * -1;
                                end else
                                    if GenJournalLine.Amount > 0 then begin
                                        AuditLog."Transaction Type" := AuditLog."Transaction Type"::Debit;
                                        AuditLog."Transaction Amount" := (GenJournalLine.Amount);
                                    end;
                                AuditLog."Transacting Branch ID" := SwizzsoftFactory.FnGetUserBranch();
                                SessionTracker.Reset();
                                SessionTracker.SetRange(SessionTracker."User ID", AuditLog."User ID");
                                if SessionTracker.FindLast() then begin
                                    AuditLog."Log In Computer Name" := SessionTracker."Client Computer Name";
                                    AuditLog."Server Instance" := SessionTracker."Server Instance Name";
                                    AuditLog."Session ID" := SessionTracker."Session ID";
                                    AuditLog."Database Name" := SessionTracker."Database Name";
                                end;
                                AuditLog.Insert(true);
                            end;

                        "Account Type"::"Bank Account":
                            begin
                                AuditLog.Reset();
                                if AuditLog.Find('+') then begin
                                    LastEntryNo := AuditLog."Entry No";
                                end;
                                //Insert Logout log
                                AuditLog.Init();
                                AuditLog.LockTable(true);
                                AuditLog."Entry No" := GetMaxEntryNo() + 1;

                                //AuditLog."Entry No" := LastEntryNo + 1;
                                AuditLog."User ID" := UserId;
                                AuditLog."Session Type" := AuditLog."Session Type"::Insert;
                                AuditLog."Event Date/Time" := CurrentDateTime;
                                AuditLog."Transaction Type ID" := GenJournalLine."Transaction Type";
                                AuditLog."Account ID" := GenJournalLine."Account No.";
                                AuditLog."Transaction ID" := GenJournalLine."Document No.";
                                AuditLog."Transaction Description" := GenJournalLine.Description;
                                AuditLog."Transaction Date" := Today;
                                AuditLog."Account Type ID" := GenJournalLine."Account Type";
                                AuditLog."Transaction Time" := Time;
                                AuditLog."Authorized By" := SwizzsoftFactory.FnGetDocumentApprover(GenJournalLine."Document No.");
                                if GenJournalLine.Amount < 0 then begin
                                    AuditLog."Transaction Type" := AuditLog."Transaction Type"::Credit;
                                    AuditLog."Transaction Amount" := (GenJournalLine.Amount) * -1;
                                end else
                                    if GenJournalLine.Amount > 0 then begin
                                        AuditLog."Transaction Type" := AuditLog."Transaction Type"::Debit;
                                        AuditLog."Transaction Amount" := (GenJournalLine.Amount);
                                    end;
                                AuditLog."Transacting Branch ID" := SwizzsoftFactory.FnGetUserBranch();
                                SessionTracker.Reset();
                                SessionTracker.SetRange(SessionTracker."User ID", AuditLog."User ID");
                                if SessionTracker.FindLast() then begin
                                    AuditLog."Log In Computer Name" := SessionTracker."Client Computer Name";
                                    AuditLog."Server Instance" := SessionTracker."Server Instance Name";
                                    AuditLog."Session ID" := SessionTracker."Session ID";
                                    AuditLog."Database Name" := SessionTracker."Database Name";
                                end;
                                AuditLog.Insert(true);
                            end;

                        "Account Type"::"G/L Account":
                            begin
                                AuditLog.Reset();
                                if AuditLog.Find('+') then begin
                                    LastEntryNo := AuditLog."Entry No";
                                end;
                                //Insert Logout log
                                AuditLog.Init();
                                AuditLog.LockTable(true);
                                AuditLog."Entry No" := GetMaxEntryNo() + 1;

                                //AuditLog."Entry No" := LastEntryNo + 1;
                                AuditLog."User ID" := UserId;
                                AuditLog."Session Type" := AuditLog."Session Type"::Insert;
                                AuditLog."Event Date/Time" := CurrentDateTime;
                                AuditLog."Transaction Type ID" := GenJournalLine."Transaction Type";
                                AuditLog."Account ID" := GenJournalLine."Account No.";
                                AuditLog."Transaction ID" := GenJournalLine."Document No.";
                                AuditLog."Transaction Description" := GenJournalLine.Description;
                                AuditLog."Transaction Date" := Today;
                                AuditLog."Account Type ID" := GenJournalLine."Account Type";
                                AuditLog."Transaction Time" := Time;
                                AuditLog."Authorized By" := SwizzsoftFactory.FnGetDocumentApprover(GenJournalLine."Document No.");
                                if GenJournalLine.Amount < 0 then begin
                                    AuditLog."Transaction Type" := AuditLog."Transaction Type"::Credit;
                                    AuditLog."Transaction Amount" := (GenJournalLine.Amount) * -1;
                                end else
                                    if GenJournalLine.Amount > 0 then begin
                                        AuditLog."Transaction Type" := AuditLog."Transaction Type"::Debit;
                                        AuditLog."Transaction Amount" := (GenJournalLine.Amount);
                                    end;
                                AuditLog."Transacting Branch ID" := SwizzsoftFactory.FnGetUserBranch();
                                SessionTracker.Reset();
                                SessionTracker.SetRange(SessionTracker."User ID", AuditLog."User ID");
                                if SessionTracker.FindLast() then begin
                                    AuditLog."Log In Computer Name" := SessionTracker."Client Computer Name";
                                    AuditLog."Server Instance" := SessionTracker."Server Instance Name";
                                    AuditLog."Session ID" := SessionTracker."Session ID";
                                    AuditLog."Database Name" := SessionTracker."Database Name";
                                end;
                                AuditLog.Insert(true);
                            end;
                    end;
            end;
        end;

    end;

    //4).........................................Readings Made
    procedure FnReadingsMadeAudit(AccountLoggedIn: Code[50]; PageViewed: Text[2048]);
    var
        LastEntryNo: Integer;
    begin
        //Exclude Automation Services
        if UserSetUp.Get(AccountLoggedIn) then begin
            if not UserSetUp."Exempt Logs" then begin
                //Get Last Used entryNo
                AuditLog.Reset();
                if AuditLog.Find('+') then begin
                    LastEntryNo := AuditLog."Entry No";
                end;
                //Insert Logout log
                AuditLog.Init();
                AuditLog.LockTable(true);
                AuditLog."Entry No" := GetMaxEntryNo() + 1;

                //AuditLog."Entry No" := LastEntryNo + 1;
                AuditLog."User ID" := AccountLoggedIn;
                AuditLog."Session Type" := AuditLog."Session Type"::Read;
                AuditLog."Page Viewed" := CopyStr(PageViewed, 1, 2048);
                AuditLog."Event Date/Time" := CurrentDateTime;
                AuditLog."Transaction Date" := Today;
                AuditLog."Transaction Time" := Time;
                AuditLog."Transacting Branch ID" := SwizzsoftFactory.FnGetAccountUserBranch(UserId);
                SessionTracker.Reset();
                SessionTracker.SetRange(SessionTracker."User ID", AccountLoggedIn);
                if SessionTracker.FindLast() then begin
                    AuditLog."Log In Computer Name" := SessionTracker."Client Computer Name";
                    AuditLog."Server Instance" := SessionTracker."Server Instance Name";
                    AuditLog."Session ID" := SessionTracker."Session ID";
                    AuditLog."Database Name" := SessionTracker."Database Name";
                end;
                AuditLog.Insert(true);
            end;
        end;

    end;
    //----------------------------------------------------------------------
    procedure FnModificationMadeAudit(AccountLoggedIn: Code[50]; PageViewed: Text[2048]);
    var
        LastEntryNo: Integer;
    begin
        //Exclude Automation Services
        if UserSetUp.Get(AccountLoggedIn) then begin
            if not UserSetUp."Exempt Logs" then begin
                //Get Last Used entryNo
                AuditLog.Reset();
                if AuditLog.Find('+') then begin
                    LastEntryNo := AuditLog."Entry No";
                end;
                //Insert Logout log
                AuditLog.Init();
                AuditLog.LockTable(true);
                AuditLog."Entry No" := GetMaxEntryNo() + 1;
                //AuditLog."Entry No" := LastEntryNo + 1
                AuditLog."User ID" := AccountLoggedIn;
                AuditLog."Session Type" := AuditLog."Session Type"::Modify;
                AuditLog."Page Viewed" := CopyStr(PageViewed, 1, 2048);
                AuditLog."Event Date/Time" := CurrentDateTime;
                AuditLog."Transaction Date" := Today;
                AuditLog."Transaction Time" := Time;
                AuditLog."Transacting Branch ID" := SwizzsoftFactory.FnGetAccountUserBranch(UserId);
                SessionTracker.Reset();
                SessionTracker.SetRange(SessionTracker."User ID", AccountLoggedIn);
                if SessionTracker.FindLast() then begin
                    AuditLog."Log In Computer Name" := SessionTracker."Client Computer Name";
                    AuditLog."Server Instance" := SessionTracker."Server Instance Name";
                    AuditLog."Session ID" := SessionTracker."Session ID";
                    AuditLog."Database Name" := SessionTracker."Database Name";
                end;
                AuditLog.Insert(true);
            end;
        end;

    end;

    procedure GetMaxEntryNo(): Integer
    var
        AuditLog: Record "System Log Trails";
        MaxEntryNo: Integer;
    begin
        if AuditLog.FindLast() then
            MaxEntryNo := AuditLog."Entry No";
        exit(MaxEntryNo);
    end;


    var
        AuditLog: Record "System Log Trails";
        SessionTracker: record "Active Session";
        UserSetUp: Record "User Setup";
        SwizzsoftFactory: Codeunit "SWIZZSFT Factory";
}
