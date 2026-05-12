#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
table 50097 "Over Draft Authorisation"
{
    // DrillDownPageID = UnknownPage52018498;
    // LookupPageID = UnknownPage52018498;

    fields
    {
        field(1; "No."; Code[20])
        {

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    NoSetup.Get();
                    NoSeriesMgt.TestManual(NoSetup."Overdraft App Nos.");
                    "No. Series" := '';
                end;
            end;

        }
        field(2; "Account No."; Code[20])
        {
            TableRelation = Vendor."No.";

            trigger OnValidate()
            begin


                if Account.Get("Account No.") then begin
                    "Account Name" := Account.Name;
                    "Account Type" := Account."Account Type";
                    if AccountTypes.Get("Account Type") then begin
                        if AccountTypes."Allow Over Draft" = false then
                            Error('Overdraft not allowed for this account type.');
                        AccountTypes.TestField(AccountTypes."Over Draft Interest Account");

                        "Overdraft Interest %" := AccountTypes."Over Draft Interest %";
                    end;
                end else begin
                    if Bank.Get("Account No.") then begin
                        "Account Name" := Bank.Name;
                    end;
                end;
            end;
        }
        field(3; "Cheque Book No."; Code[20])
        {
        }
        field(4; "Account Name"; Text[50])
        {
        }
        field(8; "Client No."; Code[20])
        {
            Caption = 'Client No.';
        }
        field(9; "Effective/Start Date"; Date)
        {

            trigger OnValidate()
            begin
                "Expiry Date" := CalcDate(Duration, "Effective/Start Date");
                Validate("Expiry Date");
            end;
        }
        field(10; "Expiry Date"; Date)
        {

            trigger OnValidate()
            begin

                AllowMultipleOD := false;

                if ("Effective/Start Date" <> 0D) and ("Expiry Date" <> 0D) then begin
                    if Account.Get("Account No.") then begin
                        if AccountTypes.Get("Account Type") then begin
                            AllowMultipleOD := AccountTypes."Allow Multiple Over Draft";
                        end;
                    end;


                    OverDraftAuth.Reset;
                    OverDraftAuth.SetCurrentkey(OverDraftAuth."Account No.", OverDraftAuth.Status, OverDraftAuth.Expired);
                    OverDraftAuth.SetRange(OverDraftAuth."Account No.", "Account No.");
                    OverDraftAuth.SetRange(OverDraftAuth.Status, OverDraftAuth.Status::Pending);
                    OverDraftAuth.SetRange(OverDraftAuth.Expired, false);
                    if OverDraftAuth.Find('-') then begin
                        repeat
                            if ("Effective/Start Date" >= OverDraftAuth."Effective/Start Date") and ("Effective/Start Date" <= OverDraftAuth."Expiry Date") then begin
                                if AllowMultipleOD = true then begin
                                    if Confirm('There is an already approved Over Draft within the specified period. - %1. Do you wish to issue another one?' +
                                       '', false, OverDraftAuth."No.") = false then
                                        Error('Process Terminated.');
                                end else
                                    Error('There is an already approved Over Draft within the specified period. - %1. Cancel an existing one if you' +
                                           ' want to issue another one.', OverDraftAuth."No.");

                            end;


                            if ("Expiry Date" >= OverDraftAuth."Effective/Start Date") and ("Expiry Date" <= OverDraftAuth."Expiry Date") then begin
                                if AllowMultipleOD = true then begin
                                    if Confirm('There is an already approved Over Draft within the specified period. - %1. Do you wish to issue another one?' +
                                       '', false, OverDraftAuth."No.") = false then
                                        Error('Process Terminated.');
                                end else
                                    Error('There is an already approved Over Draft within the specified period. - %1. Cancel an existing one if you' +
                                           ' want to issue another one.', OverDraftAuth."No.");

                            end;

                        until OverDraftAuth.Next = 0;
                    end;
                end;
            end;
        }
        field(11; Duration; DateFormula)
        {

            trigger OnValidate()
            begin
                TestField("Effective/Start Date");
                TestField(Duration);

                if "Effective/Start Date" < Today then
                    Error('Effective date cannot be in the past.');

                "Expiry Date" := CalcDate(Duration, "Effective/Start Date");
                Validate("Expiry Date");
            end;
        }
        field(14; Status; Option)
        {
            Editable = false;
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(15; Remarks; Text[50])
        {
        }
        field(16; "Approved Amount"; Decimal)
        {

            trigger OnValidate()
            begin



                if "Approved Amount" > "Requested Amount" then
                    Error('Approved Amount cannot be greater than the requeested amount.');

                if AccountTypes.Get("Account Type") then begin
                    "Overdraft Fee" := "Approved Amount" * AccountTypes."Over Draft Issue Charge %" * 0.01;
                end;
            end;
        }
        field(17; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(19; "Transacting Branch"; Code[20])
        {
            Editable = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(20; "Created By"; Code[20])
        {
            Editable = false;
        }
        field(21; "Approved By"; Code[20])
        {
            Editable = false;
        }
        field(22; "Canceled By"; Code[20])
        {
            Editable = false;
        }
        field(23; "Overdraft Interest %"; Decimal)
        {
        }
        field(26; Finished; Boolean)
        {
        }
        field(27; "Application Date"; Date)
        {
        }
        field(28; "Account Type"; Code[20])
        {
        }
        field(29; "Issue to"; Option)
        {
            OptionCaption = 'Account,Cashier';
            OptionMembers = Account,Cashier;
        }
        field(30; "Requested Amount"; Decimal)
        {

            trigger OnValidate()
            begin
                "Approved Amount" := "Requested Amount";
                Validate("Approved Amount");
            end;
        }
        field(31; Expired; Boolean)
        {
            Editable = false;
        }
        field(32; "Date Approved"; Date)
        {
        }
        field(33; "Overdraft Fee"; Decimal)
        {
        }
        field(34; Liquidated; Boolean)
        {
            Editable = false;
        }
        field(35; "Date Liquidated"; Date)
        {
            Editable = false;
        }
        field(36; "Liquidated By"; Code[20])
        {
            Editable = false;
        }
        field(37; "1st Approval"; Code[20])
        {
        }
        field(38; "1st Approval Date"; Date)
        {
        }
        field(39; Posted; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
            NoSetup.Get;
            NoSetup.TestField(NoSetup."Overdraft App Nos.");
            // NoSeriesMgt.InitSeries(NoSetup."Overdraft App Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;


        "Created By" := UpperCase(UserId);
    end;

    var
        NoSetup: Record "Sacco General Set-Up";
        NoSeriesMgt: Codeunit "No. Series";
        Account: Record Vendor;
        UsersID: Record User;
        BanksList: Record Banks;
        "Bank Name": Text[30];
        ChequeNo: Code[20];
        i: Integer;
        Bank: Record "Bank Account";
        AccountTypes: Record "Account Types-Saving Products";
        OverDraftAuth: Record "Over Draft Authorisation";
        AllowMultipleOD: Boolean;
}

