#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51006 "Imprest Header"
{
    DrillDownPageID = "Imprest Requisition Lookup";
    LookupPageID = "Imprest Requisition Lookup";

    fields
    {
        field(1; "No."; Code[20])
        {
            Description = 'Stores the reference of the payment voucher in the database';
            Editable = false;
        }
        field(2; Date; Date)
        {
            Description = 'Stores the date when the payment voucher was inserted into the system';

            trigger OnValidate()
            var
                ObjXImpH: Record "Imprest Header";
                CurOpenDocs: Integer;
            begin
                if ImpLinesExist then begin
                    Error('You first need to delete the existing imprest lines before changing the Currency Code');
                end;

                if "Currency Code" = xRec."Currency Code" then
                    UpdateCurrencyFactor;

                if "Currency Code" <> xRec."Currency Code" then begin
                    UpdateCurrencyFactor;
                    //RecreatePurchLines(FIELDCAPTION("Currency Code"));
                end else
                    if "Currency Code" <> '' then
                        UpdateCurrencyFactor;

                UpdateHeaderToLine;
            end;
        }
        field(3; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            Editable = false;
            MinValue = 0;
        }
        field(4; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            Editable = true;
            Enabled = true;
            TableRelation = Currency;

            trigger OnValidate()
            begin
                if ImpLinesExist then begin
                    Error('You first need to delete the existing imprest lines before changing the Currency Code'
                    );
                end;

                if "Currency Code" = xRec."Currency Code" then
                    UpdateCurrencyFactor;

                if "Currency Code" <> xRec."Currency Code" then begin
                    UpdateCurrencyFactor;
                    //RecreatePurchLines(FIELDCAPTION("Currency Code"));
                end else
                    if "Currency Code" <> '' then
                        UpdateCurrencyFactor;

                UpdateHeaderToLine;
            end;
        }
        field(9; Payee; Text[100])
        {
            Description = 'Stores the name of the person who received the money';
        }
        field(10; "On Behalf Of"; Text[100])
        {
            Description = 'Stores the name of the person on whose behalf the payment voucher was taken';
        }
        field(11; Cashier; Code[50])
        {
            Description = 'Stores the identifier of the cashier in the database';
        }
        field(16; Posted; Boolean)
        {
            Description = 'Stores whether the payment voucher is posted or not';
        }
        field(17; "Date Posted"; Date)
        {
            Description = 'Stores the date when the payment voucher was posted';
        }
        field(18; "Time Posted"; Time)
        {
            Description = 'Stores the time when the payment voucher was posted';
        }
        field(19; "Posted By"; Code[50])
        {
            Description = 'Stores the name of the person who posted the payment voucher';
        }
        field(20; "Total Payment Amount"; Decimal)
        {
            CalcFormula = sum("Imprest Lines".Amount where(No = field("No.")));
            Description = 'Stores the amount of the payment voucher';
            Editable = false;
            FieldClass = FlowField;
        }
        field(28; "Paying Bank Account"; Code[20])
        {
            Description = 'Stores the name of the paying bank account in the database';
            TableRelation = "Bank Account"."No.";

            trigger OnValidate()
            begin
                BankAcc.Reset;
                "Bank Name" := '';
                BankAcc.SetRange(BankAcc."No.", "Paying Bank Account");
                if BankAcc.Find('-') then begin
                    "Bank Name" := BankAcc.Name;
                    BankAcc.TestField("Global Dimension 1 Code");
                    BankAcc.TestField("Global Dimension 2 Code");
                    "Shortcut Dimension 2 Code" := BankAcc."Global Dimension 2 Code";
                    "Global Dimension 1 Code" := BankAcc."Global Dimension 1 Code";
                end;
            end;
        }
        field(30; "Global Dimension 1 Code"; Code[50])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            Description = 'Stores the reference to the first global dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

            trigger OnValidate()
            begin

            end;
        }
        field(35; Status; enum "Record Status")
        {
            Description = 'Stores the status of the record in the database';

            trigger OnValidate()
            var
                Commitments: Record "Committment Entries";
                Payline: Record "Imprest Lines";
            begin
                if Status = Status::Rejected then begin
                    Commitments.Reset;
                    Commitments.SetRange(Commitments."Document Type", Commitments."document type"::Imprest);
                    Commitments.SetRange(Commitments."Document No.", "No.");
                    Commitments.DeleteAll;

                    Payline.Reset;
                    Payline.SetRange(Payline.No, "No.");
                    if Payline.Find('-') then begin
                        repeat
                            Payline.Committed := false;
                            Payline.Modify;
                        until Payline.Next = 0;
                    end;
                end;
            end;
        }
        field(38; "Payment Type"; Option)
        {
            OptionMembers = Imprest;
        }
        field(56; "Shortcut Dimension 2 Code"; Code[50])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            Description = 'Stores the reference of the second global dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

            trigger OnValidate()
            begin
                DimVal.Reset;
                DimVal.SetRange(DimVal."Global Dimension No.", 2);
                DimVal.SetRange(DimVal.Code, "Shortcut Dimension 2 Code");
                if DimVal.Find('-') then
                    "Budget Center Name" := DimVal.Name;

                UpdateHeaderToLine;
                // ValidateShortcutDimCode(2,"Shortcut Dimension 2 Code");
            end;
        }
        field(57; "Function Name"; Text[100])
        {
            Description = 'Stores the name of the function in the database';
        }
        field(58; "Budget Center Name"; Text[100])
        {
            Description = 'Stores the name of the budget center in the database';
        }
        field(59; "Bank Name"; Text[100])
        {
            Description = 'Stores the description of the paying bank account in the database';
        }
        field(60; "No. Series"; Code[20])
        {
            Description = 'Stores the number series in the database';
        }
        field(61; Select; Boolean)
        {
            Description = 'Enables the user to select a particular record';
        }
        field(62; "Total VAT Amount"; Decimal)
        {
            CalcFormula = sum("Imprest Lines"."Amount LCY" where(No = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(63; "Total Witholding Tax Amount"; Decimal)
        {
            CalcFormula = sum("Imprest Lines"."Amount LCY" where(No = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(64; "Total Net Amount"; Decimal)
        {
            CalcFormula = sum("Imprest Lines".Amount where(No = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(65; "Current Status"; Code[20])
        {
            Description = 'Stores the current status of the payment voucher in the database';
        }
        field(66; "Cheque No."; Code[20])
        {
        }
        field(67; "Pay Mode"; Option)
        {
            OptionMembers = " ",Cash,Cheque,EFT,"Letter of Credit","Custom 3","Custom 4","Custom 5";
        }
        field(68; "Payment Release Date"; Date)
        {

            trigger OnValidate()
            begin

                //Changed to ensure Release date is not less than the Date entered
                if "Payment Release Date" < Date then
                    Error('The Payment Release Date cannot be lesser than the Document Date');
            end;
        }
        field(69; "No. Printed"; Integer)
        {
        }
        field(70; "VAT Base Amount"; Decimal)
        {
        }
        field(71; "Exchange Rate"; Decimal)
        {
        }
        field(72; "Currency Reciprical"; Decimal)
        {
        }
        field(73; "Current Source A/C Bal."; Decimal)
        {
        }
        field(74; "Cancellation Remarks"; Text[250])
        {
            Enabled = false;
        }
        field(75; "Register Number"; Integer)
        {
        }
        field(76; "From Entry No."; Integer)
        {
        }
        field(77; "To Entry No."; Integer)
        {
        }
        field(78; "Invoice Currency Code"; Code[10])
        {
            Caption = 'Invoice Currency Code';
            Editable = true;
            TableRelation = Currency;
        }
        field(79; "Total Net Amount LCY"; Decimal)
        {
            CalcFormula = sum("Imprest Lines"."Amount LCY" where(No = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(80; "Document Type"; Option)
        {
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","Payment voucher","Imprest Requisition";
        }
        field(81; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            Description = 'Stores the reference of the Third global dimension in the database';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));

            trigger OnValidate()
            begin
                DimVal.Reset;
                //DimVal.SETRANGE(DimVal."Global Dimension No.",2);
                DimVal.SetRange(DimVal.Code, "Shortcut Dimension 3 Code");
                if DimVal.Find('-') then
                    Dim3 := DimVal.Name;

                UpdateHeaderToLine;
            end;
        }
        field(82; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            Description = 'Stores the reference of the Third global dimension in the database';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4));

            trigger OnValidate()
            begin
                DimVal.Reset;
                //DimVal.SETRANGE(DimVal."Global Dimension No.",2);
                DimVal.SetRange(DimVal.Code, "Shortcut Dimension 4 Code");
                if DimVal.Find('-') then
                    Dim4 := DimVal.Name;

                UpdateHeaderToLine;
            end;
        }
        field(83; Dim3; Text[250])
        {
        }
        field(84; Dim4; Text[250])
        {
        }
        field(85; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center";

            trigger OnValidate()
            begin

            end;
        }
        field(86; "Account Type"; enum "Gen. Journal Account Type")
        {
            Caption = 'Account Type';
        }
        field(87; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            Editable = true;
            TableRelation = if ("Account Type" = const("G/L Account")) "G/L Account" where("Account Type" = const(Posting),
                                                                                          Blocked = const(false))
            else
            if ("Account Type" = const(Customer)) Customer
            else
            if ("Account Type" = const(Vendor)) Vendor
            else
            if ("Account Type" = const("Bank Account")) "Bank Account"
            else
            if ("Account Type" = const("Fixed Asset")) "Fixed Asset"
            else
            if ("Account Type" = const("IC Partner")) "IC Partner"
            else
            if ("Account Type" = const("Allocation Account")) "Allocation Account"
            else
            if ("Account Type" = const(Employee)) Employee;

            trigger OnValidate()
            begin
                Cust.Reset;
                Cust.SetRange(Cust."No.", "Account No.");
                if Cust.Find('-') then begin
                    Payee := Cust.Name;
                end;
                Vend.Reset;
                Vend.SetRange(Vend."No.", "Account No.");
                if Vend.Find('-') then begin
                    Payee := Vend.Name;
                end;
                GLAcc.Reset;
                GLAcc.SetRange(GLAcc."No.", "Account No.");
                if GLAcc.Find('-') then begin
                    Payee := GLAcc.Name;
                end;
            end;
        }
        field(88; "Surrender Status"; Option)
        {
            OptionMembers = " ",Full,Partial;
        }
        field(89; Purpose; Text[250])
        {
        }
        field(90; "Employee Job Group"; Code[10])
        {
            Editable = false;
            TableRelation = "Employee Statistics Group";
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                ShowDimensions
            end;
        }
        field(50000; Requisition; Code[20])
        {
            TableRelation = "Purchase Header"."No.";
        }
        field(50001; Reversed; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50002; "Reversal Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50003; "Reversal Time"; Time)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50004; "Reversed by"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50005; "Payee Bank Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Payee Bank Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Bank Account No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Branch Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Branch Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Validate("No of Days");
            end;
        }
        field(50011; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50012; "No of Days"; Integer)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "End Date" := 0D;

                if "No of Days" <> 0 then
                    "End Date" := CalcDate(Format("No of Days") + 'D', "Start Date");

                if "End Date" <> 0D then begin
                    GenLedgerSetup.Get;

                    // if GenLedgerSetup."Surrender Due Date" <> "0DF" then
                    //   "Surrender Due Date" := CalcDate(GenLedgerSetup."Surrender Due Date","End Date");

                    if "Surrender Due Date" <> 0D then begin
                        ImpLines.Reset;
                        ImpLines.SetRange(No, "No.");
                        if ImpLines.Find('-') then begin
                            ImpLines."Due Date" := "Surrender Due Date";
                            ImpLines.Modify;
                        end;
                    end;
                end;
            end;
        }
        field(50013; "Imprest Type"; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = ' ,Travel Imprest,General Imprest';
            OptionMembers = " ","Travel Imprest","General Imprest";
        }
        field(50014; "Surrender Due Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50015; Surrendered; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50016; Notified; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50017; Archived; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50018; "Shortcut Dimension 6 Code"; Code[20])
        {
            CaptionClass = '1,2,6';
            Caption = 'Shortcut Dimension 4 Code';
            DataClassification = ToBeClassified;
            Description = 'Stores the reference of the 6 global dimension in the database';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(6));

            trigger OnValidate()
            begin
                DimVal.Reset;
                //DimVal.SETRANGE(DimVal."Global Dimension No.",2);
                DimVal.SetRange(DimVal.Code, "Shortcut Dimension 6 Code");
                if DimVal.Find('-') then
                    "Dim 6" := DimVal.Name;

                ValidateShortcutDimCode(6, "Shortcut Dimension 6 Code");
            end;
        }
        field(50019; "Dim 6"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50020; "Email Address"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(50021; "Phone No."; Code[30])
        {
            DataClassification = ToBeClassified;
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
        fieldgroup(DropDown; "No.", Date, "Account No.", Payee, "Total Net Amount")
        {
        }
    }

    trigger OnDelete()
    begin
        if (Status <> Status::Open) then
            Error('You Cannot Delete this record its status is not Pending');
    end;

    trigger OnInsert()
    var
        ObjXImpH: Record "Imprest Header";
        CurOpenDocs: Integer;
        ObjFundSetp: Record "Funds General Setup";
    begin
        if "No." = '' then begin
            GenLedgerSetup.Get;
            if "Payment Type" = "payment type"::Imprest then begin
                GenLedgerSetup.TestField(GenLedgerSetup."Imprest Nos");
                //   NoSeriesMgt.InitSeries(GenLedgerSetup."Imprest Nos", xRec."No. Series", 0D, "No.", "No. Series");
            end
        end;


        Date := Today;
        Cashier := UserId;
        Validate(Cashier);

        "Account Type" := "account type"::Customer;
        if UserSetup.Get(UserId) then begin
            "Account No." := UserSetup."Imprest Account";
            Validate("Account No.");
            "Responsibility Center" := UserSetup."Branch";
        end;

        "Document Type" := "document type"::"Imprest Requisition";

        ObjXImpH.Reset;
        ObjXImpH.SetRange(ObjXImpH.Cashier, Cashier);
        ObjXImpH.SetRange(ObjXImpH.Status, ObjXImpH.Status::Open);
        if ObjXImpH.FindSet then begin
            repeat
                CurOpenDocs += 1;
            until ObjXImpH.Next = 0;
        end;

        ObjFundSetp.Get;
        if ObjFundSetp."Max Open Documents" <> 0 then
            if CurOpenDocs > ObjFundSetp."Max Open Documents" then
                Error('You have exceeded the maximum limit number of imprest documents %1', ObjFundSetp."Max Open Documents");
    end;

    trigger OnModify()
    begin
        if Status = Status::Open then
            UpdateHeaderToLine;
    end;

    var
        CStatus: Code[20];
        UserTemplate: Record "Funds General Setup";
        GLAcc: Record "G/L Account";
        Vend: Record Vendor;
        FA: Record "Fixed Asset";
        BankAcc: Record "Bank Account";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        GenLedgerSetup: Record "Funds General Setup";
        RecPayTypes: Record "Funds Transaction Types";
        EntryNo: Integer;
        SingleMonth: Boolean;
        DateFrom: Date;
        DateTo: Date;
        Budget: Decimal;
        CurrMonth: Code[10];
        CurrYR: Code[10];
        BudgDate: Text[30];
        BudgetDate: Date;
        YrBudget: Decimal;
        BudgetDateTo: Date;
        BudgetAvailable: Decimal;
        GenLedSetup: Record "General Ledger Setup";
        "Total Budget": Decimal;
        CommittedAmount: Decimal;
        MonthBudget: Decimal;
        Expenses: Decimal;
        Header: Text[250];
        "Date From": Text[30];
        "Date To": Text[30];
        LastDay: Date;
        TotAmt: Decimal;
        DimVal: Record "Dimension Value";
        RespCenter: Record "Responsibility Center";
        Text001: label 'Your identification is set up to process from %1 %2 only.';
        Pline: Record "Imprest Lines";
        CurrExchRate: Record "Currency Exchange Rate";
        ImpLines: Record "Imprest Lines";
        UserSetup: Record "User Setup";
        DImMgt: Codeunit DimensionManagement;
        Cust: Record Customer;
        ObjPayroll: Record "Payroll Employee.";
        "0DF": DateFormula;
        PayLine: Record "Imprest Lines";
        Temp: Record "Funds User Setup";
        GenJnlLine: Record "Gen. Journal Line";
        JTemplate: Code[10];
        JBatch: Code[10];
        LineNo: Integer;
        HasLines: Boolean;
        ObjCUFactory: Codeunit "Swizzsoft Factory";
        ObjRecBatches: Record "Gen. Journal Batch";
        CustLeja: Record "Cust. Ledger Entry";


    procedure UpdateHeaderToLine()
    var
        PayLine: Record "Imprest Lines";
    begin
        PayLine.Reset;
        PayLine.SetRange(PayLine.No, "No.");
        if PayLine.Find('-') then begin
            repeat
                PayLine."Imprest Holder" := "Account No.";
                PayLine."Global Dimension 1 Code" := "Global Dimension 1 Code";
                PayLine."Shortcut Dimension 2 Code" := "Shortcut Dimension 2 Code";
                PayLine."Shortcut Dimension 3 Code" := "Shortcut Dimension 3 Code";
                PayLine."Shortcut Dimension 4 Code" := "Shortcut Dimension 4 Code";
                PayLine."Shortcut Dimension 6 Code" := "Shortcut Dimension 6 Code";
                PayLine."Currency Code" := "Currency Code";
                PayLine."Currency Factor" := "Currency Factor";
                PayLine.Validate("Currency Factor");
                PayLine.Modify;
            until PayLine.Next = 0;
        end;
    end;

    local procedure UpdateCurrencyFactor()
    var
        CurrencyDate: Date;
    begin
        if "Currency Code" <> '' then begin
            CurrencyDate := Date;
            "Currency Factor" := CurrExchRate.ExchangeRate(CurrencyDate, "Currency Code");
        end else
            "Currency Factor" := 0;
    end;


    procedure ImpLinesExist(): Boolean
    begin
        ImpLines.Reset;
        ImpLines.SetRange(No, "No.");
        exit(ImpLines.FindFirst);
    end;


    procedure ShowDimensions()
    begin
        "Dimension Set ID" :=
          DImMgt.EditDimensionSet("Dimension Set ID", StrSubstNo('%1 %2', 'Imprest', "No."));
        //VerifyItemLineDim;
        DImMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Global Dimension 1 Code", "Shortcut Dimension 2 Code");
    end;


    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DImMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;


    procedure LookupShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DImMgt.LookupDimValueCode(FieldNumber, ShortcutDimCode);
        ValidateShortcutDimCode(FieldNumber, ShortcutDimCode);
    end;


    procedure ShowShortcutDimCode(var ShortcutDimCode: array[8] of Code[20])
    begin
        DImMgt.GetShortcutDimensions("Dimension Set ID", ShortcutDimCode);
    end;


    procedure PostImprest(ImpHeader: Record "Imprest Header")
    var
        BankLedgers: Record "Bank Account Ledger Entry";
    begin
        if Temp.Get(UserId) then begin
            GenJnlLine.Reset;
            GenJnlLine.SetRange(GenJnlLine."Journal Template Name", JTemplate);
            GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", JBatch);
            GenJnlLine.DeleteAll;
        end;

        //Enable Batch Auto Posting
        BankLedgers.Reset;
        BankLedgers.SetRange("Document No.", "No.");
        if not BankLedgers.FindFirst then begin
            PayLine.Reset;
            PayLine.SetRange(No, Rec."No.");
            if PayLine.Find('-') then begin
                repeat
                    LineNo := LineNo + 1000;
                    GenJnlLine.Init;
                    GenJnlLine."Journal Template Name" := JTemplate;
                    GenJnlLine."Journal Batch Name" := JBatch;
                    GenJnlLine."Line No." := LineNo;
                    GenJnlLine."Source Code" := 'PAYMENTJNL';
                    GenJnlLine."Posting Date" := "Payment Release Date";
                    GenJnlLine."Document No." := "No.";
                    GenJnlLine."External Document No." := "Cheque No.";
                    GenJnlLine."Account Type" := GenJnlLine."account type"::Customer;
                    GenJnlLine."Account No." := "Account No.";
                    GenJnlLine.Validate(GenJnlLine."Account No.");
                    GenJnlLine.Description := 'Travel Advance: ' + "Account No." + ':' + Payee;
                    GenJnlLine.Amount := PayLine.Amount;
                    GenJnlLine.Validate(GenJnlLine.Amount);
                    GenJnlLine."Bal. Account Type" := GenJnlLine."bal. account type"::"Bank Account";
                    GenJnlLine."Bal. Account No." := "Paying Bank Account";
                    GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                    GenJnlLine."Currency Code" := "Currency Code";
                    GenJnlLine.Validate("Currency Code");
                    GenJnlLine."Currency Factor" := "Currency Factor";
                    GenJnlLine.Validate("Currency Factor");
                    GenJnlLine."Shortcut Dimension 1 Code" := PayLine."Global Dimension 1 Code";
                    GenJnlLine."Shortcut Dimension 2 Code" := PayLine."Shortcut Dimension 2 Code";
                    if GenJnlLine.Amount <> 0 then
                        GenJnlLine.Insert;
                until PayLine.Next = 0;
            end;


            GenJnlLine.Reset;
            GenJnlLine.SetRange(GenJnlLine."Journal Template Name", JTemplate);
            GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", JBatch);
            if GenJnlLine.FindFirst then
                Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJnlLine);
        end;

        BankLedgers.Reset;
        BankLedgers.SetRange("Document No.", "No.");
        if BankLedgers.FindFirst then begin
            ImpHeader.Posted := true;
            ImpHeader."Date Posted" := Today;
            ImpHeader."Time Posted" := Time;
            ImpHeader."Posted By" := UserId;
            ImpHeader.Modify;
        end;
        Message('Successfully Posted');
    end;


    procedure CheckImprestRequiredItems(ImpHeader: Record "Imprest Header")
    begin
        ImpHeader.TestField("Payment Release Date");
        ImpHeader.TestField("Paying Bank Account");
        ImpHeader.TestField("Account No.");
        ImpHeader.TestField("Cheque No.");
        ImpHeader.TestField("Account Type", "account type"::Customer);
        ImpHeader.TestField(Status, Status::Approved);

        Temp.Get(UserId);
        JTemplate := Temp."Imprest Template";
        JBatch := Temp."Imprest  Batch";

        if JTemplate = '' then begin
            Error('Ensure the Imprest Template is set up in Cash Office Setup');
        end;

        if JBatch = '' then begin
            Error('Ensure the Imprest Batch is set up in the Cash Office Setup')
        end;

        if not LinesExists then
            Error('There are no Lines created for this Document');
    end;


    procedure LinesExists(): Boolean
    var
        PayLines: Record "Imprest Lines";
    begin
        HasLines := false;

        //Test Lines Spoke and Hub:
        PayLines.Reset;
        PayLines.SetRange(PayLines.No, "No.");
        if PayLines.Find('-') then begin
            repeat
                PayLines.TestField("Global Dimension 1 Code");
                PayLines.TestField("Shortcut Dimension 2 Code");
            until PayLines.Next = 0;
        end;

        PayLines.Reset;
        PayLines.SetRange(PayLines.No, "No.");
        if PayLines.Find('-') then begin
            HasLines := true;
            exit(HasLines);
        end;
    end;
}

