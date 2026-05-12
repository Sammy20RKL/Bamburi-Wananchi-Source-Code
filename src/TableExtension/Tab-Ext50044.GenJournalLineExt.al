tableextension 50044 "GenJournalLineExt" extends "Gen. Journal Line"
{
    fields
    {
        field(10006; "Export File Name"; Text[30])
        {
            Caption = 'Export File Name';
            Editable = false;
        }
        field(10011; "Tax Jurisdiction Code"; Code[10])
        {
            Caption = 'Tax Jurisdiction Code';
            Editable = true;
            TableRelation = "Tax Jurisdiction";
        }
        field(10012; "Tax Type"; Option)
        {
            Caption = 'Tax Type';
            OptionCaption = 'Sales and Use Tax,Excise Tax,Sales Tax Only,Use Tax Only';
            OptionMembers = "Sales and Use Tax","Excise Tax","Sales Tax Only","Use Tax Only";
        }
        field(10015; "Tax Exemption No."; Text[30])
        {
            Caption = 'Tax Exemption No.';
        }
        field(10018; "STE Transaction ID"; Text[20])
        {
            Caption = 'STE Transaction ID';
            Editable = false;
        }
        field(10020; "IRS 1099 Code"; Code[10])
        {
            Caption = 'IRS 1099 Code';

            trigger OnValidate()
            begin
                if "IRS 1099 Code" <> '' then begin
                    if "Account Type" = "account type"::Vendor then
                        "IRS 1099 Amount" := Amount
                    else
                        "IRS 1099 Amount" := -Amount;
                end else
                    "IRS 1099 Amount" := 0;
            end;
        }
        field(10021; "IRS 1099 Amount"; Decimal)
        {
            Caption = 'IRS 1099 Amount';
        }
        field(10030; "Foreign Exchange Indicator"; Option)
        {
            Caption = 'Foreign Exchange Indicator';
            OptionCaption = ' ,FV,VF,FF';
            OptionMembers = " ",FV,VF,FF;
        }
        field(10031; "Foreign Exchange Ref.Indicator"; Option)
        {
            Caption = 'Foreign Exchange Ref.Indicator';
            OptionCaption = ' ,1,2,3';
            OptionMembers = " ","1","2","3";
        }
        field(10032; "Foreign Exchange Reference"; Code[20])
        {
            Caption = 'Foreign Exchange Reference';
        }
        field(10033; "Gateway Operator OFAC Scr.Inc"; Option)
        {
            Caption = 'Gateway Operator OFAC Scr.Inc';
            OptionCaption = ' ,0,1';
            OptionMembers = " ","0","1";
        }
        field(10034; "Secondary OFAC Scr.Indicator"; Option)
        {
            Caption = 'Secondary OFAC Scr.Indicator';
            OptionCaption = ' ,0,1';
            OptionMembers = " ","0","1";
        }
        field(10035; "Origin. DFI ID Qualifier"; Option)
        {
            Caption = 'Origin. DFI ID Qualifier';
            OptionCaption = ' ,01,02,03';
            OptionMembers = " ","01","02","03";
        }
        field(10036; "Receiv. DFI ID Qualifier"; Option)
        {
            Caption = 'Receiv. DFI ID Qualifier';
            OptionCaption = ' ,01,02,03';
            OptionMembers = " ","01","02","03";
        }
        field(10037; "Transaction Type Code"; Option)
        {
            Caption = 'Transaction Type Code';
            InitValue = BUS;
            OptionCaption = 'ANN,BUS,DEP,LOA,MIS,MOR,PEN,RLS,SAL,TAX';
            OptionMembers = ANN,BUS,DEP,LOA,MIS,MOR,PEN,RLS,SAL,TAX;
        }
        field(10038; "Transaction Code"; Code[3])
        {
            Caption = 'Transaction Code';
        }
        field(10039; "Company Entry Description"; Text[10])
        {
            Caption = 'Company Entry Description';
        }
        field(10040; "Payment Related Information 1"; Text[80])
        {
            Caption = 'Payment Related Information 1';
        }
        field(10041; "Payment Related Information 2"; Text[52])
        {
            Caption = 'Payment Related Information 2';
        }
        field(10045; "GST/HST"; Option)
        {
            Caption = 'GST/HST';
            OptionCaption = ' ,Acquisition,Self Assessment,Rebate,New Housing Rebates,Pension Rebate';
            OptionMembers = " ",Acquisition,"Self Assessment",Rebate,"New Housing Rebates","Pension Rebate";
        }
        field(10046; "Recovery Transaction Type"; Option)
        {
            OptionMembers = "",Normal,"Guarantor Recoverd","Guarantor Paid";
        }
        field(10047; "Recoverd Loan"; code[20]) { }
        field(51516220; "Transaction Type"; enum TransactionTypesEnum)
        {
            trigger OnValidate()
            begin
                if "Transaction Type" = "transaction type"::"Registration Fee" then
                    Description := 'Registration Fee';
                if "Transaction Type" = "transaction type"::Loan then
                    Description := 'Loan';
                if "Transaction Type" = "transaction type"::"Loan Repayment" then
                    Description := 'Loan Repayment';
                if "Transaction Type" = "transaction type"::Withdrawal then
                    Description := 'Withdrawal';
                if "Transaction Type" = "transaction type"::"Interest Due" then
                    Description := 'Interest Due';
                if "Transaction Type" = "transaction type"::"Interest Paid" then
                    Description := 'Interest Paid';
                if "Transaction Type" = "transaction type"::"Benevolent Fund" then
                    Description := 'ABF Fund';
                if "Transaction Type" = "transaction type"::"Deposit Contribution" then
                    Description := 'Deposits Contribution';
                if "Transaction Type" = "transaction type"::"Welfare Contribution" then
                    Description := 'Welfare Contribution';
                if "Transaction Type" = "transaction type"::"Bank Charges" then
                    Description := 'Bank Charges';
                // if "Transaction Type" = "transaction type"::"Application Fee" then
                //     Description := 'Application Fee';
                // if "Transaction Type" = "transaction type"::"Unallocated Funds" then
                //     Description := 'Unallocated Funds';
                if "Transaction Type" = "transaction type"::"Insurance Contribution" then
                    Description := 'Insurance Contribution';
                if "Transaction Type" = "transaction type"::"Other Products" then
                    Description := 'Other Products';
                if "Transaction Type" = "transaction type"::"Sales of T-Shirt" then
                    Description := 'Sales of T-Shirt';

            end;
        }
        field(51516221; "Loan No"; Code[20])
        {
            TableRelation = if ("Account Type" = const(Customer)) "Loans Register"."Loan  No." where("Client Code" = field("Account No."));

            trigger OnValidate()
            begin
                loansreg.Reset();
                loansreg.SetRange(loansreg."Loan  No.", "Loan No");
                if loansreg.find('-') then begin
                    "Loan Product Type" := loansreg."Loan Product Type";
                end;
            end;
        }
        field(51516222; "Loan Product Type"; Code[20])
        {

        }
        field(51516223; Interest; Decimal)
        {
        }
        field(51516224; Principal; Decimal)
        {
        }
        field(51516225; Status; Option)
        {
            OptionCaption = 'Pending,Verified,Approved,Canceled';
            OptionMembers = Pending,Verified,Approved,Canceled;
        }
        field(51516226; "User ID"; Code[25])
        {
        }
        field(51516227; Posted; Boolean)
        {
        }
        field(51516228; Charge; Code[20])
        {
            TableRelation = Resource."No.";

            trigger OnValidate()
            begin
                //IF Res.GET(Charge) THEN
                //Description:=Res.Name;
            end;
        }
        field(51516229; "Calculate VAT"; Boolean)
        {
        }
        field(51516230; "VAT Value Amount"; Decimal)
        {
        }
        field(51516231; Bank; Text[30])
        {
        }
        field(51516232; Branch; Text[30])
        {
        }
        field(51516233; "Invoice to Post"; Code[20])
        {
        }
        field(51516234; Found; Boolean)
        {
        }
        field(51516235; "Staff No."; Code[20])
        {
        }
        field(51516236; "Prepayment date"; Date)
        {
        }
        field(51516237; LN; Code[100])
        {
            CalcFormula = lookup("Loans Register"."Loan  No." where("Loan  No." = field("Loan No")));
            FieldClass = FlowField;
        }
        field(51516238; "Group Code"; Code[50])
        {
        }
        field(51516239; "Int Count"; Integer)
        {
            CalcFormula = count("Gen. Journal Line" where("Journal Template Name" = const('GENERAL'),
                                                           "Journal Batch Name" = const('INT DUE')));
            FieldClass = FlowField;
        }
        field(51516240; "Member Name"; Text[70])
        {
        }
        field(51516241; "Interest Due Amount"; Decimal)
        {
        }
        field(51516430; "Interest Code"; Code[50])
        {
            Description = 'Investment Management Field';
            Editable = false;
        }
        field(51516431; "Investor Interest"; Boolean)
        {
        }
        field(51516432; "Int on Dep SMS"; Boolean)
        {
        }
        field(51516433; "Dividend SMS"; Boolean)
        {
        }
        field(51516434; Text; Text[30])
        {
        }
        field(51516435; Blocked; Option)
        {
            CalcFormula = lookup(Vendor.Blocked where("No." = field("Account No.")));
            FieldClass = FlowField;
            OptionCaption = ' ,All,Payment';
            OptionMembers = " ",All,Payment;
        }
        field(51516436; "ATM SMS"; Boolean)
        {
        }
        field(51516437; "Trace ID"; Code[10])
        {
        }
        field(51516438; Description2; Text[70])
        {
        }
        field(51516439; "Transaction type Fosa"; Option)
        {
            Description = 'Added to handle Fosa Shares';
            OptionCaption = ' ,Pepea Shares,School Fees Shares';
            OptionMembers = " ","Pepea Shares","School Fees Shares";
        }
        field(51516440; "Overdraft NO"; Code[50])
        {
        }
        field(51516441; "Overdraft codes"; Option)
        {
            OptionCaption = ' ,Overdraft Granted,Overdraft Paid,Interest Accrued,Interest paid';
            OptionMembers = " ","Overdraft Granted","Overdraft Paid","Interest Accrued","Interest paid";
        }
        field(51516442; "Mobile Transaction Type"; enum VendorTransactionTypes)
        {
        }
    }

    keys
    {
        // key(Key30; "Journal Template Name", "Journal Batch Name", "Line No.")
        // {
        //     Clustered = true;
        //     MaintainSIFTIndex = false;
        //     SumIndexFields = "Balance (LCY)", Amount;
        // }
        // key(Key2; "Journal Template Name", "Journal Batch Name", "Posting Date", "Document No.")
        // {
        //     MaintainSQLIndex = false;
        // }
        // key(Key3; "Account Type", "Account No.", "Applies-to Doc. Type", "Applies-to Doc. No.")
        // {
        // }
        // key(Key4; "Document No.")
        // {
        //     MaintainSQLIndex = false;
        // }
        // key(Key5; "Incoming Document Entry No.")
        // {
        // }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //ERROR('You cannot delete');

        ApprovalsMgmt.OnCancelGeneralJournalLineApprovalRequest(Rec);

        CheckNoCardTransactEntryExist(Rec);

        TestField("Check Printed", false);

        ClearCustVendApplnEntry;
        ClearAppliedGenJnlLine;
        DeletePaymentFileErrors;
        ClearDataExchangeEntries(false);

        GenJnlAlloc.SetRange("Journal Template Name", "Journal Template Name");
        GenJnlAlloc.SetRange("Journal Batch Name", "Journal Batch Name");
        GenJnlAlloc.SetRange("Journal Line No.", "Line No.");
        GenJnlAlloc.DeleteAll;

        DeferralUtilities.DeferralCodeOnDelete(
          Deferraldoctype::"G/L",
          "Journal Template Name",
          "Journal Batch Name", 0, '', "Line No.");

        Validate("Incoming Document Entry No.", 0);
    end;

    trigger OnInsert()
    begin
        GenJnlAlloc.LockTable;
        LockTable;
        GenJnlTemplate.Get("Journal Template Name");
        GenJnlBatch.Get("Journal Template Name", "Journal Batch Name");
        "Posting No. Series" := GenJnlBatch."Posting No. Series";
        "Check Printed" := false;

        ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
        ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
    end;

    trigger OnModify()
    begin
        //ERROR('You cannot modify');

        TestField("Check Printed", false);
        if ("Applies-to ID" = '') and (xRec."Applies-to ID" <> '') then
            ClearCustVendApplnEntry;
    end;

    trigger OnRename()
    begin
        ApprovalsMgmt.RenameApprovalEntries(xRec.RecordId, RecordId);

        CheckNoCardTransactEntryExist(Rec);
        TestField("Check Printed", false);
    end;

    var
        Text000: label '%1 or %2 must be a G/L account or bank account.', Comment = '%1=Account Type,%2=Balance Account Type';
        Text001: label 'You must not specify %1 when %2 is %3.';
        Text002: label 'cannot be specified without %1';
        Text003: label 'The %1 in the %2 will be changed from %3 to %4.\Do you want to continue?';
        Text005: label 'The update has been interrupted to respect the warning.';
        Text006: label 'The %1 option can only be used internally in the system.';
        Text007: label '%1 or %2 must be a bank account.', Comment = '%1=Account Type,%2=Balance Account Type';
        Text008: label ' must be 0 when %1 is %2.';
        Text009: label 'USD';
        Text010: label '%1 must be %2 or %3.';
        Text011: label '%1 must be negative.';
        Text012: label '%1 must be positive.';
        Text013: label 'The %1 must not be more than %2.';
        Text017: label 'Credit card %1 has already been performed for this %2, but posting failed. You must complete posting of the document of type %2 with the number %3.';
        GenJnlTemplate: Record "Gen. Journal Template";
        GenJnlBatch: Record "Gen. Journal Batch";
        GenJnlLine: Record "Gen. Journal Line";
        GLAcc: Record "G/L Account";
        Cust: Record Customer;
        Vend: Record Vendor;
        ICPartner: Record "IC Partner";
        Currency: Record Currency;
        CurrExchRate: Record "Currency Exchange Rate";
        PaymentTerms: Record "Payment Terms";
        CustLedgEntry: Record "Cust. Ledger Entry";
        VendLedgEntry: Record "Vendor Ledger Entry";
        GenJnlAlloc: Record "Gen. Jnl. Allocation";
        VATPostingSetup: Record "VAT Posting Setup";
        BankAcc: Record "Bank Account";
        BankAcc2: Record "Bank Account";
        BankAcc3: Record "Bank Account";
        FA: Record "Fixed Asset";
        FASetup: Record "FA Setup";
        FADeprBook: Record "FA Depreciation Book";
        GenBusPostingGrp: Record "Gen. Business Posting Group";
        GenProdPostingGrp: Record "Gen. Product Posting Group";
        GLSetup: Record "General Ledger Setup";
        Job: Record Job;
        JobJnlLine: Record "Job Journal Line" temporary;
        TaxArea: Record "Tax Area";
        NoSeriesMgt: Codeunit "No. Series";
        CustCheckCreditLimit: Codeunit "Cust-Check Cr. Limit";
        SalesTaxCalculate: Codeunit "Sales Tax Calculate";
        GenJnlApply: Codeunit "Gen. Jnl.-Apply";
        GenJnlShowCTEntries: Codeunit "Gen. Jnl.-Show CT Entries";
        CustEntrySetApplID: Codeunit "Cust. Entry-SetAppl.ID";
        VendEntrySetApplID: Codeunit "Vend. Entry-SetAppl.ID";
        DimMgt: Codeunit DimensionManagement;
        PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
        DeferralUtilities: Codeunit "Deferral Utilities";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        Window: Dialog;
        DeferralDocType: Option Purchase,Sales,"G/L";
        FromCurrencyCode: Code[10];
        ToCurrencyCode: Code[10];
        CurrencyCode: Code[10];
        Text014: label 'The %1 %2 has a %3 %4.\Do you still want to use %1 %2 in this journal line?';
        TemplateFound: Boolean;
        Text015: label 'You are not allowed to apply and post an entry to an entry with an earlier posting date.\\Instead, post %1 %2 and then apply it to %3 %4.';
        CurrencyDate: Date;
        SourceCodeSetup: Record "Source Code Setup";
        Text016: label '%1 must be G/L Account or Bank Account.';
        HideValidationDialog: Boolean;
        Text018: label '%1 can only be set when %2 is set.';
        Text019: label '%1 cannot be changed when %2 is set.';
        GLSetupRead: Boolean;
        ExportAgainQst: label 'One or more of the selected lines have already been exported. Do you want to export them again?';
        NothingToExportErr: label 'There is nothing to export.';
        NotExistErr: label 'Document No. %1 does not exist or is already closed.';
        DocNoFilterErr: label 'The document numbers cannot be renumbered while there is an active filter on the Document No. field.';
        DueDateMsg: label 'This posting date will cause an overdue payment.';
        CalcPostDateMsg: label 'Processing payment journal lines #1##########';
        AccTypeNotSupportedErr: label 'You cannot specify a deferral code for this type of account.';
        Memb: Record Customer;
        VendRec: Record Vendor;
        loansreg: Record "Loans Register";


    procedure EmptyLine(): Boolean
    begin
        exit(
          ("Account No." = '') and (Amount = 0) and
          (("Bal. Account No." = '') or not "System-Created Entry"));
    end;


    procedure UpdateLineBalance()
    begin
        if ((Amount > 0) and (not Correction)) or
           ((Amount < 0) and Correction)
        then begin
            "Debit Amount" := Amount;
            "Credit Amount" := 0
        end else begin
            "Debit Amount" := 0;
            "Credit Amount" := -Amount;
        end;
        if "Currency Code" = '' then
            "Amount (LCY)" := Amount;
        case true of
            ("Account No." <> '') and ("Bal. Account No." <> ''):
                "Balance (LCY)" := 0;
            "Bal. Account No." <> '':
                "Balance (LCY)" := -"Amount (LCY)";
            else
                "Balance (LCY)" := "Amount (LCY)";
        end;

        Clear(GenJnlAlloc);
        GenJnlAlloc.UpdateAllocations(Rec);

        UpdateSalesPurchLCY;

        if ("Deferral Code" <> '') and (Amount <> xRec.Amount) and ((Amount <> 0) and (xRec.Amount <> 0)) then
            Validate("Deferral Code");
    end;


    procedure SetUpNewLine(LastGenJnlLine: Record "Gen. Journal Line"; Balance: Decimal; BottomLine: Boolean)
    begin
        GenJnlTemplate.Get("Journal Template Name");
        GenJnlBatch.Get("Journal Template Name", "Journal Batch Name");
        GenJnlLine.SetRange("Journal Template Name", "Journal Template Name");
        GenJnlLine.SetRange("Journal Batch Name", "Journal Batch Name");
        if GenJnlLine.FindFirst then begin
            "Posting Date" := LastGenJnlLine."Posting Date";
            "Document Date" := LastGenJnlLine."Posting Date";
            "Document No." := LastGenJnlLine."Document No.";
            if BottomLine and
               (Balance - LastGenJnlLine."Balance (LCY)" = 0) and
               not LastGenJnlLine.EmptyLine and (GenJnlTemplate.Type <> GenJnlTemplate.Type::"Sales Tax")
            then
                "Document No." := IncStr("Document No.");
        end else begin
            "Posting Date" := WorkDate;
            "Document Date" := WorkDate;
            if GenJnlBatch."No. Series" <> '' then begin
                Clear(NoSeriesMgt);
                // "Document No." := NoSeriesMgt.TryGetNextNo(GenJnlBatch."No. Series", "Posting Date");
            end;
        end;
        if GenJnlTemplate.Recurring then
            "Recurring Method" := LastGenJnlLine."Recurring Method";
        "Account Type" := LastGenJnlLine."Account Type";
        "Document Type" := LastGenJnlLine."Document Type";
        "Source Code" := GenJnlTemplate."Source Code";
        "Reason Code" := GenJnlBatch."Reason Code";
        "Posting No. Series" := GenJnlBatch."Posting No. Series";
        "Bal. Account Type" := GenJnlBatch."Bal. Account Type";
        if ("Account Type" in ["account type"::Customer, "account type"::Vendor, "account type"::"Fixed Asset"]) and
           ("Bal. Account Type" in ["bal. account type"::Customer, "bal. account type"::Vendor, "bal. account type"::"Fixed Asset"])
        then
            "Account Type" := "account type"::"G/L Account";
        Validate("Bal. Account No.", GenJnlBatch."Bal. Account No.");
        Description := '';
    end;


    procedure CheckDocNoOnLines()
    var
        GenJnlBatch: Record "Gen. Journal Batch";
        GenJnlLine: Record "Gen. Journal Line";
        LastDocNo: Code[20];
    begin
        GenJnlLine.CopyFilters(Rec);

        if not GenJnlLine.FindSet then
            exit;
        GenJnlBatch.Get(GenJnlLine."Journal Template Name", GenJnlLine."Journal Batch Name");
        if GenJnlBatch."No. Series" = '' then
            exit;

        Clear(NoSeriesMgt);
        repeat
            GenJnlLine.CheckDocNoBasedOnNoSeries(LastDocNo, GenJnlBatch."No. Series", NoSeriesMgt);
            LastDocNo := GenJnlLine."Document No.";
        until GenJnlLine.Next = 0;
    end;


    procedure CheckDocNoBasedOnNoSeries(LastDocNo: Code[20]; NoSeriesCode: Code[10]; var NoSeriesMgtInstance: Codeunit "No. Series")
    begin
        if (NoSeriesCode = '') or "Check Printed" then
            exit;

        if (LastDocNo = '') or ("Document No." <> LastDocNo) then
            if "Document No." <> NoSeriesMgtInstance.GetNextNo(NoSeriesCode, "Posting Date", false) then
                NoSeriesMgtInstance.TestManual(NoSeriesCode);  // allow use of manual document numbers.
    end;


    procedure RenumberDocumentNo()
    var
        GenJnlLine2: Record "Gen. Journal Line";
        DocNo: Code[20];
        FirstDocNo: Code[20];
        FirstTempDocNo: Code[20];
        LastTempDocNo: Code[20];
    begin
        GenJnlBatch.Get("Journal Template Name", "Journal Batch Name");
        if GenJnlBatch."No. Series" = '' then
            exit;
        if GetFilter("Document No.") <> '' then
            Error(DocNoFilterErr);
        Clear(NoSeriesMgt);
        //FirstDocNo := NoSeriesMgt.TryGetNextNo(GenJnlBatch."No. Series", "Posting Date");
        FirstTempDocNo := 'RENUMBERED-000000001';
        // step1 - renumber to non-existing document number
        DocNo := FirstTempDocNo;
        GenJnlLine2 := Rec;
        GenJnlLine2.Reset;
        RenumberDocNoOnLines(DocNo, GenJnlLine2);
        LastTempDocNo := DocNo;

        // step2 - renumber to real document number (within Filter)
        DocNo := FirstDocNo;
        GenJnlLine2.CopyFilters(Rec);
        GenJnlLine2 := Rec;
        RenumberDocNoOnLines(DocNo, GenJnlLine2);

        // step3 - renumber to real document number (outside filter)
        DocNo := IncStr(DocNo);
        GenJnlLine2.Reset;
        GenJnlLine2.SetRange("Document No.", FirstTempDocNo, LastTempDocNo);
        RenumberDocNoOnLines(DocNo, GenJnlLine2);

        Get("Journal Template Name", "Journal Batch Name", "Line No.");
    end;

    local procedure RenumberDocNoOnLines(var DocNo: Code[20]; var GenJnlLine2: Record "Gen. Journal Line")
    var
        LastGenJnlLine: Record "Gen. Journal Line";
        GenJnlLine3: Record "Gen. Journal Line";
        PrevDocNo: Code[20];
        FirstDocNo: Code[20];
        First: Boolean;
    begin
        FirstDocNo := DocNo;
        GenJnlLine2.SetCurrentkey("Journal Template Name", "Journal Batch Name", "Document No.");
        GenJnlLine2.SetRange("Journal Template Name", GenJnlLine2."Journal Template Name");
        GenJnlLine2.SetRange("Journal Batch Name", GenJnlLine2."Journal Batch Name");
        LastGenJnlLine.Init;
        First := true;
        if GenJnlLine2.FindSet then begin
            repeat
                if GenJnlLine2."Document No." = FirstDocNo then
                    exit;
                if not First and (GenJnlLine2."Document No." <> PrevDocNo) and not LastGenJnlLine.EmptyLine then
                    DocNo := IncStr(DocNo);
                PrevDocNo := GenJnlLine2."Document No.";
                if (GenJnlLine2."Applies-to ID" <> '') and (GenJnlLine2."Applies-to ID" = GenJnlLine2."Document No.") then
                    GenJnlLine2.RenumberAppliesToID(GenJnlLine2, GenJnlLine2."Document No.", DocNo);
                GenJnlLine2.RenumberAppliesToDocNo(GenJnlLine2, GenJnlLine2."Document No.", DocNo);
                GenJnlLine3.Get(GenJnlLine2."Journal Template Name", GenJnlLine2."Journal Batch Name", GenJnlLine2."Line No.");
                GenJnlLine3."Document No." := DocNo;
                GenJnlLine3.Modify;
                First := false;
                LastGenJnlLine := GenJnlLine2
            until GenJnlLine2.Next = 0
        end
    end;

    local procedure RenumberAppliesToID(GenJnlLine2: Record "Gen. Journal Line"; OriginalAppliesToID: Code[50]; NewAppliesToID: Code[50])
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
        CustLedgEntry2: Record "Cust. Ledger Entry";
        VendLedgEntry: Record "Vendor Ledger Entry";
        VendLedgEntry2: Record "Vendor Ledger Entry";
        AccType: Option;
        AccNo: Code[20];
    begin
        GetAccTypeAndNo(GenJnlLine2, AccType, AccNo);
        case AccType of
            "account type"::Customer:
                begin
                    CustLedgEntry.SetRange("Customer No.", AccNo);
                    CustLedgEntry.SetRange("Applies-to ID", OriginalAppliesToID);
                    if CustLedgEntry.FindSet then
                        repeat
                            CustLedgEntry2.Get(CustLedgEntry."Entry No.");
                            CustLedgEntry2."Applies-to ID" := NewAppliesToID;
                            Codeunit.Run(Codeunit::"Cust. Entry-Edit", CustLedgEntry2);
                        until CustLedgEntry.Next = 0;
                end;
            "account type"::Vendor:
                begin
                    VendLedgEntry.SetRange("Vendor No.", AccNo);
                    VendLedgEntry.SetRange("Applies-to ID", OriginalAppliesToID);
                    if VendLedgEntry.FindSet then
                        repeat
                            VendLedgEntry2.Get(VendLedgEntry."Entry No.");
                            VendLedgEntry2."Applies-to ID" := NewAppliesToID;
                            Codeunit.Run(Codeunit::"Vend. Entry-Edit", VendLedgEntry2);
                        until VendLedgEntry.Next = 0;
                end;
            else
                exit
        end;
        GenJnlLine2."Applies-to ID" := NewAppliesToID;
        GenJnlLine2.Modify;
    end;

    local procedure RenumberAppliesToDocNo(GenJnlLine2: Record "Gen. Journal Line"; OriginalAppliesToDocNo: Code[20]; NewAppliesToDocNo: Code[20])
    begin
        GenJnlLine2.Reset;
        GenJnlLine2.SetRange("Journal Template Name", GenJnlLine2."Journal Template Name");
        GenJnlLine2.SetRange("Journal Batch Name", GenJnlLine2."Journal Batch Name");
        GenJnlLine2.SetRange("Applies-to Doc. Type", GenJnlLine2."Document Type");
        GenJnlLine2.SetRange("Applies-to Doc. No.", OriginalAppliesToDocNo);
        GenJnlLine2.ModifyAll("Applies-to Doc. No.", NewAppliesToDocNo);
    end;

    local procedure CheckVATInAlloc()
    begin
        if "Gen. Posting Type" <> 0 then begin
            GenJnlAlloc.Reset;
            GenJnlAlloc.SetRange("Journal Template Name", "Journal Template Name");
            GenJnlAlloc.SetRange("Journal Batch Name", "Journal Batch Name");
            GenJnlAlloc.SetRange("Journal Line No.", "Line No.");
            if GenJnlAlloc.Find('-') then
                repeat
                    GenJnlAlloc.CheckVAT(Rec);
                until GenJnlAlloc.Next = 0;
        end;
    end;

    local procedure SetCurrencyCode(AccType2: Option "G/L Account",Customer,Vendor,"Bank Account"; AccNo2: Code[20]): Boolean
    begin
        "Currency Code" := '';
        if AccNo2 <> '' then
            if AccType2 = Acctype2::"Bank Account" then
                if BankAcc2.Get(AccNo2) then
                    "Currency Code" := BankAcc2."Currency Code";
        exit("Currency Code" <> '');
    end;

    local procedure GetCurrency()
    begin
        if "Additional-Currency Posting" =
           "additional-currency posting"::"Additional-Currency Amount Only"
        then begin
            if GLSetup."Additional Reporting Currency" = '' then
                ReadGLSetup;
            CurrencyCode := GLSetup."Additional Reporting Currency";
        end else
            CurrencyCode := "Currency Code";

        if CurrencyCode = '' then begin
            Clear(Currency);
            Currency.InitRoundingPrecision
        end else
            if CurrencyCode <> Currency.Code then begin
                Currency.Get(CurrencyCode);
                Currency.TestField("Amount Rounding Precision");
            end;
    end;


    procedure UpdateSource()
    var
        SourceExists1: Boolean;
        SourceExists2: Boolean;
    begin
        SourceExists1 := ("Account Type" <> "account type"::"G/L Account") and ("Account No." <> '');
        SourceExists2 := ("Bal. Account Type" <> "bal. account type"::"G/L Account") and ("Bal. Account No." <> '');
        case true of
            SourceExists1 and not SourceExists2:
                begin
                    "Source Type" := "Account Type";
                    "Source No." := "Account No.";
                end;
            SourceExists2 and not SourceExists1:
                begin
                    "Source Type" := "Bal. Account Type";
                    "Source No." := "Bal. Account No.";
                end;
            else begin
                "Source Type" := "source type"::" ";
                "Source No." := '';
            end;
        end;
    end;

    local procedure CheckGLAcc()
    begin
        GLAcc.CheckGLAcc;
        if GLAcc."Direct Posting" or ("Journal Template Name" = '') or "System-Created Entry" then
            exit;
        if "Posting Date" <> 0D then
            if "Posting Date" = ClosingDate("Posting Date") then
                exit;
        GLAcc.TestField("Direct Posting", true);
    end;


    procedure GetFAAddCurrExchRate()
    var
        DeprBook: Record "Depreciation Book";
        FANo: Code[20];
        UseFAAddCurrExchRate: Boolean;
    begin
        "FA Add.-Currency Factor" := 0;
        if ("FA Posting Type" <> "fa posting type"::" ") and
           ("Depreciation Book Code" <> '')
        then begin
            if "Account Type" = "account type"::"Fixed Asset" then
                FANo := "Account No.";
            if "Bal. Account Type" = "bal. account type"::"Fixed Asset" then
                FANo := "Bal. Account No.";
            if FANo <> '' then begin
                DeprBook.Get("Depreciation Book Code");
                case "FA Posting Type" of
                    "fa posting type"::"Acquisition Cost":
                        UseFAAddCurrExchRate := DeprBook."Add-Curr Exch Rate - Acq. Cost";
                    "fa posting type"::Depreciation:
                        UseFAAddCurrExchRate := DeprBook."Add.-Curr. Exch. Rate - Depr.";
                    "fa posting type"::"Write-Down":
                        UseFAAddCurrExchRate := DeprBook."Add-Curr Exch Rate -Write-Down";
                    "fa posting type"::Appreciation:
                        UseFAAddCurrExchRate := DeprBook."Add-Curr. Exch. Rate - Apprec.";
                    "fa posting type"::"Custom 1":
                        UseFAAddCurrExchRate := DeprBook."Add-Curr. Exch Rate - Custom 1";
                    "fa posting type"::"Custom 2":
                        UseFAAddCurrExchRate := DeprBook."Add-Curr. Exch Rate - Custom 2";
                    "fa posting type"::Disposal:
                        UseFAAddCurrExchRate := DeprBook."Add.-Curr. Exch. Rate - Disp.";
                    "fa posting type"::Maintenance:
                        UseFAAddCurrExchRate := DeprBook."Add.-Curr. Exch. Rate - Maint.";
                end;
                if UseFAAddCurrExchRate then begin
                    FADeprBook.Get(FANo, "Depreciation Book Code");
                    FADeprBook.TestField("FA Add.-Currency Factor");
                    "FA Add.-Currency Factor" := FADeprBook."FA Add.-Currency Factor";
                end;
            end;
        end;
    end;


    procedure GetShowCurrencyCode(CurrencyCode: Code[10]): Code[10]
    begin
        if CurrencyCode <> '' then
            exit(CurrencyCode);

        exit(Text009);
    end;


    procedure ClearCustVendApplnEntry()
    var
        TempCustLedgEntry: Record "Cust. Ledger Entry";
        TempVendLedgEntry: Record "Vendor Ledger Entry";
        CustEntryEdit: Codeunit "Cust. Entry-Edit";
        VendEntryEdit: Codeunit "Vend. Entry-Edit";
        AccType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset";
        AccNo: Code[20];
    begin
        GetAccTypeAndNo(Rec, AccType, AccNo);
        case AccType of
            Acctype::Customer:
                if xRec."Applies-to ID" <> '' then begin
                    if FindFirstCustLedgEntryWithAppliesToID(AccNo, xRec."Applies-to ID") then begin
                        ClearCustApplnEntryFields;
                        CustEntrySetApplID.SetApplId(CustLedgEntry, TempCustLedgEntry, '');
                    end
                end else
                    if xRec."Applies-to Doc. No." <> '' then
                        if FindFirstCustLedgEntryWithAppliesToDocNo(AccNo, xRec."Applies-to Doc. No.") then begin
                            ClearCustApplnEntryFields;
                            CustEntryEdit.Run(CustLedgEntry);
                        end;
            Acctype::Vendor:
                if xRec."Applies-to ID" <> '' then begin
                    if FindFirstVendLedgEntryWithAppliesToID(AccNo, xRec."Applies-to ID") then begin
                        ClearVendApplnEntryFields;
                        //VendEntrySetApplID.SetApplId(VendLedgEntry,TempVendLedgEntry,'');-Victor
                    end
                end else
                    if xRec."Applies-to Doc. No." <> '' then
                        if FindFirstVendLedgEntryWithAppliesToDocNo(AccNo, xRec."Applies-to Doc. No.") then begin
                            ClearVendApplnEntryFields;
                            VendEntryEdit.Run(VendLedgEntry);
                        end;
        end;
    end;

    local procedure ClearCustApplnEntryFields()
    begin
        CustLedgEntry."Accepted Pmt. Disc. Tolerance" := false;
        CustLedgEntry."Accepted Payment Tolerance" := 0;
        CustLedgEntry."Amount to Apply" := 0;
    end;

    local procedure ClearVendApplnEntryFields()
    begin
        VendLedgEntry."Accepted Pmt. Disc. Tolerance" := false;
        VendLedgEntry."Accepted Payment Tolerance" := 0;
        VendLedgEntry."Amount to Apply" := 0;
    end;


    procedure CheckFixedCurrency(): Boolean
    var
        CurrExchRate: Record "Currency Exchange Rate";
    begin
        CurrExchRate.SetRange("Currency Code", "Currency Code");
        CurrExchRate.SetRange("Starting Date", 0D, "Posting Date");

        if not CurrExchRate.FindLast then
            exit(false);

        if CurrExchRate."Relational Currency Code" = '' then
            exit(
              CurrExchRate."Fix Exchange Rate Amount" =
              CurrExchRate."fix exchange rate amount"::Both);

        if CurrExchRate."Fix Exchange Rate Amount" <>
           CurrExchRate."fix exchange rate amount"::Both
        then
            exit(false);

        CurrExchRate.SetRange("Currency Code", CurrExchRate."Relational Currency Code");
        if CurrExchRate.FindLast then
            exit(
              CurrExchRate."Fix Exchange Rate Amount" =
              CurrExchRate."fix exchange rate amount"::Both);

        exit(false);
    end;


    procedure CreateDim(Type1: Integer; No1: Code[20]; Type2: Integer; No2: Code[20]; Type3: Integer; No3: Code[20]; Type4: Integer; No4: Code[20]; Type5: Integer; No5: Code[20])
    var
        TableID: array[10] of Integer;
        No: array[10] of Code[20];
    begin
        TableID[1] := Type1;
        No[1] := No1;
        TableID[2] := Type2;
        No[2] := No2;
        TableID[3] := Type3;
        No[3] := No3;
        TableID[4] := Type4;
        No[4] := No4;
        TableID[5] := Type5;
        No[5] := No5;
        "Shortcut Dimension 1 Code" := '';
        "Shortcut Dimension 2 Code" := '';
        // "Dimension Set ID" :=
        //   DimMgt.GetDefaultDimID(
        //     TableID, No, "Source Code", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", 0, 0);
    end;


    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        TestField("Check Printed", false);
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;


    procedure LookupShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        TestField("Check Printed", false);
        DimMgt.LookupDimValueCode(FieldNumber, ShortcutDimCode);
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;


    procedure ShowShortcutDimCode(var ShortcutDimCode: array[8] of Code[20])
    begin
        DimMgt.GetShortcutDimensions("Dimension Set ID", ShortcutDimCode);
    end;


    // procedure ShowDimensions()
    // begin
    //     "Dimension Set ID" :=
    //       DimMgt.EditDimensionSet2(
    //         "Dimension Set ID", StrSubstNo('%1 %2 %3', "Journal Template Name", "Journal Batch Name", "Line No."),
    //         "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
    // end;


    procedure GetFAVATSetup()
    var
        LocalGlAcc: Record "G/L Account";
        FAPostingGr: Record "FA Posting Group";
        FABalAcc: Boolean;
    begin
        if CurrFieldNo = 0 then
            exit;
        if ("Account Type" <> "account type"::"Fixed Asset") and
           ("Bal. Account Type" <> "bal. account type"::"Fixed Asset")
        then
            exit;
        FABalAcc := ("Bal. Account Type" = "bal. account type"::"Fixed Asset");
        if not FABalAcc then begin
            ClearPostingGroups;
            "Tax Group Code" := '';
            Validate("VAT Prod. Posting Group");
        end;
        if FABalAcc then begin
            ClearBalancePostingGroups;
            "Bal. Tax Group Code" := '';
            Validate("Bal. VAT Prod. Posting Group");
        end;
        if not GenJnlBatch.Get("Journal Template Name", "Journal Batch Name") or
           GenJnlBatch."Copy VAT Setup to Jnl. Lines"
        then
            if (("FA Posting Type" = "fa posting type"::"Acquisition Cost") or
                ("FA Posting Type" = "fa posting type"::Disposal) or
                ("FA Posting Type" = "fa posting type"::Maintenance)) and
               ("Posting Group" <> '')
            then
                if FAPostingGr.Get("Posting Group") then begin
                    if "FA Posting Type" = "fa posting type"::"Acquisition Cost" then begin
                        FAPostingGr.TestField("Acquisition Cost Account");
                        LocalGlAcc.Get(FAPostingGr."Acquisition Cost Account");
                    end;
                    if "FA Posting Type" = "fa posting type"::Disposal then begin
                        FAPostingGr.TestField("Acq. Cost Acc. on Disposal");
                        LocalGlAcc.Get(FAPostingGr."Acq. Cost Acc. on Disposal");
                    end;
                    if "FA Posting Type" = "fa posting type"::Maintenance then begin
                        FAPostingGr.TestField("Maintenance Expense Account");
                        LocalGlAcc.Get(FAPostingGr."Maintenance Expense Account");
                    end;
                    LocalGlAcc.CheckGLAcc;
                    if not FABalAcc then begin
                        "Gen. Posting Type" := LocalGlAcc."Gen. Posting Type";
                        "Gen. Bus. Posting Group" := LocalGlAcc."Gen. Bus. Posting Group";
                        "Gen. Prod. Posting Group" := LocalGlAcc."Gen. Prod. Posting Group";
                        "VAT Bus. Posting Group" := LocalGlAcc."VAT Bus. Posting Group";
                        "VAT Prod. Posting Group" := LocalGlAcc."VAT Prod. Posting Group";
                        "Tax Group Code" := LocalGlAcc."Tax Group Code";
                        Validate("VAT Prod. Posting Group");
                    end else begin
                        ;
                        "Bal. Gen. Posting Type" := LocalGlAcc."Gen. Posting Type";
                        "Bal. Gen. Bus. Posting Group" := LocalGlAcc."Gen. Bus. Posting Group";
                        "Bal. Gen. Prod. Posting Group" := LocalGlAcc."Gen. Prod. Posting Group";
                        "Bal. VAT Bus. Posting Group" := LocalGlAcc."VAT Bus. Posting Group";
                        "Bal. VAT Prod. Posting Group" := LocalGlAcc."VAT Prod. Posting Group";
                        "Bal. Tax Group Code" := LocalGlAcc."Tax Group Code";
                        Validate("Bal. VAT Prod. Posting Group");
                    end;
                end;
    end;


    procedure GetTemplate()
    begin
        if not TemplateFound then
            GenJnlTemplate.Get("Journal Template Name");
        TemplateFound := true;
    end;

    local procedure UpdateSalesPurchLCY()
    begin
        "Sales/Purch. (LCY)" := 0;
        if (not "System-Created Entry") and ("Document Type" in ["document type"::Invoice, "document type"::"Credit Memo"]) then begin
            if ("Account Type" in ["account type"::Customer, "account type"::Vendor]) and ("Bal. Account No." <> '') then
                "Sales/Purch. (LCY)" := "Amount (LCY)" + "Bal. VAT Amount (LCY)";
            if ("Bal. Account Type" in ["bal. account type"::Customer, "bal. account type"::Vendor]) and ("Account No." <> '') then
                "Sales/Purch. (LCY)" := -("Amount (LCY)" - "VAT Amount (LCY)");
        end;
    end;


    procedure LookUpAppliesToDocCust(AccNo: Code[20])
    var
        ApplyCustEntries: Page "Apply Customer Entries";
    begin
        Clear(CustLedgEntry);
        CustLedgEntry.SetCurrentkey("Customer No.", Open, Positive, "Due Date");
        if AccNo <> '' then
            CustLedgEntry.SetRange("Customer No.", AccNo);
        CustLedgEntry.SetRange(Open, true);
        if "Applies-to Doc. No." <> '' then begin
            CustLedgEntry.SetRange("Document Type", "Applies-to Doc. Type");
            CustLedgEntry.SetRange("Document No.", "Applies-to Doc. No.");
            if CustLedgEntry.IsEmpty then begin
                CustLedgEntry.SetRange("Document Type");
                CustLedgEntry.SetRange("Document No.");
            end;
        end;
        if "Applies-to ID" <> '' then begin
            CustLedgEntry.SetRange("Applies-to ID", "Applies-to ID");
            if CustLedgEntry.IsEmpty then
                CustLedgEntry.SetRange("Applies-to ID");
        end;
        if "Applies-to Doc. Type" <> "applies-to doc. type"::" " then begin
            CustLedgEntry.SetRange("Document Type", "Applies-to Doc. Type");
            if CustLedgEntry.IsEmpty then
                CustLedgEntry.SetRange("Document Type");
        end;
        if Amount <> 0 then begin
            CustLedgEntry.SetRange(Positive, Amount < 0);
            if CustLedgEntry.IsEmpty then
                CustLedgEntry.SetRange(Positive);
        end;
        ApplyCustEntries.SetGenJnlLine(Rec, GenJnlLine.FieldNo("Applies-to Doc. No."));
        ApplyCustEntries.SetTableview(CustLedgEntry);
        ApplyCustEntries.SetRecord(CustLedgEntry);
        ApplyCustEntries.LookupMode(true);
        if ApplyCustEntries.RunModal = Action::LookupOK then begin
            ApplyCustEntries.GetRecord(CustLedgEntry);
            if AccNo = '' then begin
                AccNo := CustLedgEntry."Customer No.";
                if "Bal. Account Type" = "bal. account type"::Customer then
                    Validate("Bal. Account No.", AccNo)
                else
                    Validate("Account No.", AccNo);
            end;
            SetAmountWithCustLedgEntry;
            "Applies-to Doc. Type" := CustLedgEntry."Document Type";
            "Applies-to Doc. No." := CustLedgEntry."Document No.";
            "Applies-to ID" := '';
        end;
        GetCreditCard;
    end;


    procedure LookUpAppliesToDocVend(AccNo: Code[20])
    var
        ApplyVendEntries: Page "Apply Vendor Entries";
    begin
        Clear(VendLedgEntry);
        VendLedgEntry.SetCurrentkey("Vendor No.", Open, Positive, "Due Date");
        if AccNo <> '' then
            VendLedgEntry.SetRange("Vendor No.", AccNo);
        VendLedgEntry.SetRange(Open, true);
        if "Applies-to Doc. No." <> '' then begin
            VendLedgEntry.SetRange("Document Type", "Applies-to Doc. Type");
            VendLedgEntry.SetRange("Document No.", "Applies-to Doc. No.");
            if VendLedgEntry.IsEmpty then begin
                VendLedgEntry.SetRange("Document Type");
                VendLedgEntry.SetRange("Document No.");
            end;
        end;
        if "Applies-to ID" <> '' then begin
            VendLedgEntry.SetRange("Applies-to ID", "Applies-to ID");
            if VendLedgEntry.IsEmpty then
                VendLedgEntry.SetRange("Applies-to ID");
        end;
        if "Applies-to Doc. Type" <> "applies-to doc. type"::" " then begin
            VendLedgEntry.SetRange("Document Type", "Applies-to Doc. Type");
            if VendLedgEntry.IsEmpty then
                VendLedgEntry.SetRange("Document Type");
        end;
        if "Applies-to Doc. No." <> '' then begin
            VendLedgEntry.SetRange("Document No.", "Applies-to Doc. No.");
            if VendLedgEntry.IsEmpty then
                VendLedgEntry.SetRange("Document No.");
        end;
        if Amount <> 0 then begin
            VendLedgEntry.SetRange(Positive, Amount < 0);
            if VendLedgEntry.IsEmpty then;
            VendLedgEntry.SetRange(Positive);
        end;
        ApplyVendEntries.SetGenJnlLine(Rec, GenJnlLine.FieldNo("Applies-to Doc. No."));
        ApplyVendEntries.SetTableview(VendLedgEntry);
        ApplyVendEntries.SetRecord(VendLedgEntry);
        ApplyVendEntries.LookupMode(true);
        if ApplyVendEntries.RunModal = Action::LookupOK then begin
            ApplyVendEntries.GetRecord(VendLedgEntry);
            if AccNo = '' then begin
                AccNo := VendLedgEntry."Vendor No.";
                if "Bal. Account Type" = "bal. account type"::Vendor then
                    Validate("Bal. Account No.", AccNo)
                else
                    Validate("Account No.", AccNo);
            end;
            SetAmountWithVendLedgEntry;
            "Applies-to Doc. Type" := VendLedgEntry."Document Type";
            "Applies-to Doc. No." := VendLedgEntry."Document No.";
            "Applies-to ID" := '';
        end;
    end;


    procedure SetApplyToAmount()
    begin
        if "Account Type" = "account type"::Customer then begin
            CustLedgEntry.SetCurrentkey("Document No.");
            CustLedgEntry.SetRange("Document No.", "Applies-to Doc. No.");
            CustLedgEntry.SetRange("Customer No.", "Account No.");
            CustLedgEntry.SetRange(Open, true);
            if CustLedgEntry.Find('-') then
                if CustLedgEntry."Amount to Apply" = 0 then begin
                    CustLedgEntry.CalcFields("Remaining Amount");
                    CustLedgEntry."Amount to Apply" := CustLedgEntry."Remaining Amount";
                    Codeunit.Run(Codeunit::"Cust. Entry-Edit", CustLedgEntry);
                end;
        end else
            if "Account Type" = "account type"::Vendor then begin
                VendLedgEntry.SetCurrentkey("Document No.");
                VendLedgEntry.SetRange("Document No.", "Applies-to Doc. No.");
                VendLedgEntry.SetRange("Vendor No.", "Account No.");
                VendLedgEntry.SetRange(Open, true);
                if VendLedgEntry.Find('-') then
                    if VendLedgEntry."Amount to Apply" = 0 then begin
                        VendLedgEntry.CalcFields("Remaining Amount");
                        VendLedgEntry."Amount to Apply" := VendLedgEntry."Remaining Amount";
                        Codeunit.Run(Codeunit::"Vend. Entry-Edit", VendLedgEntry);
                    end;
            end;
    end;


    procedure ValidateApplyRequirements(TempGenJnlLine: Record "Gen. Journal Line" temporary)
    var
        ExchAccGLJnlLine: Codeunit "Exchange Acc. G/L Journal Line";
    begin
        if (TempGenJnlLine."Bal. Account Type" = TempGenJnlLine."bal. account type"::Customer) or
           (TempGenJnlLine."Bal. Account Type" = TempGenJnlLine."bal. account type"::Vendor)
        then
            ExchAccGLJnlLine.Run(TempGenJnlLine);

        if TempGenJnlLine."Account Type" = TempGenJnlLine."account type"::Customer then begin
            if TempGenJnlLine."Applies-to ID" <> '' then begin
                CustLedgEntry.SetCurrentkey("Customer No.", "Applies-to ID", Open);
                CustLedgEntry.SetRange("Customer No.", TempGenJnlLine."Account No.");
                CustLedgEntry.SetRange("Applies-to ID", TempGenJnlLine."Applies-to ID");
                CustLedgEntry.SetRange(Open, true);
                if CustLedgEntry.Find('-') then
                    repeat
                        if TempGenJnlLine."Posting Date" < CustLedgEntry."Posting Date" then
                            Error(
                              Text015, TempGenJnlLine."Document Type", TempGenJnlLine."Document No.",
                              CustLedgEntry."Document Type", CustLedgEntry."Document No.");
                    until CustLedgEntry.Next = 0;
            end else
                if TempGenJnlLine."Applies-to Doc. No." <> '' then begin
                    CustLedgEntry.SetCurrentkey("Document No.");
                    CustLedgEntry.SetRange("Document No.", TempGenJnlLine."Applies-to Doc. No.");
                    if TempGenJnlLine."Applies-to Doc. Type" <> TempGenJnlLine."applies-to doc. type"::" " then
                        CustLedgEntry.SetRange("Document Type", TempGenJnlLine."Applies-to Doc. Type");
                    CustLedgEntry.SetRange("Customer No.", TempGenJnlLine."Account No.");
                    CustLedgEntry.SetRange(Open, true);
                    if CustLedgEntry.Find('-') then
                        if TempGenJnlLine."Posting Date" < CustLedgEntry."Posting Date" then
                            Error(
                              Text015, TempGenJnlLine."Document Type", TempGenJnlLine."Document No.",
                              CustLedgEntry."Document Type", CustLedgEntry."Document No.");
                end;
        end else
            if TempGenJnlLine."Account Type" = TempGenJnlLine."account type"::Vendor then
                if TempGenJnlLine."Applies-to ID" <> '' then begin
                    VendLedgEntry.SetCurrentkey("Vendor No.", "Applies-to ID", Open);
                    VendLedgEntry.SetRange("Vendor No.", TempGenJnlLine."Account No.");
                    VendLedgEntry.SetRange("Applies-to ID", TempGenJnlLine."Applies-to ID");
                    VendLedgEntry.SetRange(Open, true);
                    repeat
                        if TempGenJnlLine."Posting Date" < VendLedgEntry."Posting Date" then
                            Error(
                              Text015, TempGenJnlLine."Document Type", TempGenJnlLine."Document No.",
                              VendLedgEntry."Document Type", VendLedgEntry."Document No.");
                    until VendLedgEntry.Next = 0;
                    if VendLedgEntry.Find('-') then
                      ;
                end else
                    if TempGenJnlLine."Applies-to Doc. No." <> '' then begin
                        VendLedgEntry.SetCurrentkey("Document No.");
                        VendLedgEntry.SetRange("Document No.", TempGenJnlLine."Applies-to Doc. No.");
                        if TempGenJnlLine."Applies-to Doc. Type" <> TempGenJnlLine."applies-to doc. type"::" " then
                            VendLedgEntry.SetRange("Document Type", TempGenJnlLine."Applies-to Doc. Type");
                        VendLedgEntry.SetRange("Vendor No.", TempGenJnlLine."Account No.");
                        VendLedgEntry.SetRange(Open, true);
                        if VendLedgEntry.Find('-') then
                            if TempGenJnlLine."Posting Date" < VendLedgEntry."Posting Date" then
                                Error(
                                  Text015, TempGenJnlLine."Document Type", TempGenJnlLine."Document No.",
                                  VendLedgEntry."Document Type", VendLedgEntry."Document No.");
                    end;
    end;

    local procedure UpdateCountryCodeAndVATRegNo(No: Code[20])
    begin
        if No = '' then begin
            "Country/Region Code" := '';
            "VAT Registration No." := '';
            exit;
        end;

        ReadGLSetup;
        case true of
            ("Account Type" = "account type"::Customer) or ("Bal. Account Type" = "bal. account type"::Customer):
                begin
                    Cust.Get(No);
                    "Country/Region Code" := Cust."Country/Region Code";
                    "VAT Registration No." := Cust."VAT Registration No.";
                end;
            ("Account Type" = "account type"::Vendor) or ("Bal. Account Type" = "bal. account type"::Vendor):
                begin
                    Vend.Get(No);
                    "Country/Region Code" := Vend."Country/Region Code";
                    "VAT Registration No." := Vend."VAT Registration No.";
                end;
        end;
    end;


    procedure JobTaskIsSet(): Boolean
    begin
        exit(("Job No." <> '') and ("Job Task No." <> '') and ("Account Type" = "account type"::"G/L Account"));
    end;


    procedure CreateTempJobJnlLine()
    var
        TmpJobJnlOverallCurrencyFactor: Decimal;
    begin
        TestField("Posting Date");
        Clear(JobJnlLine);
        JobJnlLine.DontCheckStdCost;
        JobJnlLine.Validate("Job No.", "Job No.");
        JobJnlLine.Validate("Job Task No.", "Job Task No.");
        if CurrFieldNo <> FieldNo("Posting Date") then
            JobJnlLine.Validate("Posting Date", "Posting Date")
        else
            JobJnlLine.Validate("Posting Date", xRec."Posting Date");
        JobJnlLine.Validate(Type, JobJnlLine.Type::"G/L Account");
        if "Job Currency Code" <> '' then begin
            if "Posting Date" = 0D then
                CurrencyDate := WorkDate
            else
                CurrencyDate := "Posting Date";

            if "Currency Code" = "Job Currency Code" then
                "Job Currency Factor" := "Currency Factor"
            else
                "Job Currency Factor" := CurrExchRate.ExchangeRate(CurrencyDate, "Job Currency Code");
            JobJnlLine.SetCurrencyFactor("Job Currency Factor");
        end;
        JobJnlLine.Validate("No.", "Account No.");
        JobJnlLine.Validate(Quantity, "Job Quantity");

        if "Currency Factor" = 0 then begin
            if "Job Currency Factor" = 0 then
                TmpJobJnlOverallCurrencyFactor := 1
            else
                TmpJobJnlOverallCurrencyFactor := "Job Currency Factor";
        end else begin
            if "Job Currency Factor" = 0 then
                TmpJobJnlOverallCurrencyFactor := 1 / "Currency Factor"
            else
                TmpJobJnlOverallCurrencyFactor := "Job Currency Factor" / "Currency Factor"
        end;

        if "Job Quantity" <> 0 then
            JobJnlLine.Validate("Unit Cost", ((Amount - "VAT Amount") * TmpJobJnlOverallCurrencyFactor) / "Job Quantity");

        if (xRec."Account No." = "Account No.") and (xRec."Job Task No." = "Job Task No.") and ("Job Unit Price" <> 0) then begin
            if JobJnlLine."Cost Factor" = 0 then
                JobJnlLine."Unit Price" := xRec."Job Unit Price";
            JobJnlLine."Line Amount" := xRec."Job Line Amount";
            JobJnlLine."Line Discount %" := xRec."Job Line Discount %";
            JobJnlLine."Line Discount Amount" := xRec."Job Line Discount Amount";
            JobJnlLine.Validate("Unit Price");
        end;
    end;


    procedure UpdatePricesFromJobJnlLine()
    begin
        "Job Unit Price" := JobJnlLine."Unit Price";
        "Job Total Price" := JobJnlLine."Total Price";
        "Job Line Amount" := JobJnlLine."Line Amount";
        "Job Line Discount Amount" := JobJnlLine."Line Discount Amount";
        "Job Unit Cost" := JobJnlLine."Unit Cost";
        "Job Total Cost" := JobJnlLine."Total Cost";
        "Job Line Discount %" := JobJnlLine."Line Discount %";

        "Job Unit Price (LCY)" := JobJnlLine."Unit Price (LCY)";
        "Job Total Price (LCY)" := JobJnlLine."Total Price (LCY)";
        "Job Line Amount (LCY)" := JobJnlLine."Line Amount (LCY)";
        "Job Line Disc. Amount (LCY)" := JobJnlLine."Line Discount Amount (LCY)";
        "Job Unit Cost (LCY)" := JobJnlLine."Unit Cost (LCY)";
        "Job Total Cost (LCY)" := JobJnlLine."Total Cost (LCY)";
    end;

    local procedure CheckNoCardTransactEntryExist(GenJnlLine: Record "Gen. Journal Line")
    var
        DOPaymentTransLogEntry: Record "DO Payment Trans. Log Entry";
        DOPaymentTransLogMgt: Codeunit "DO Payment Trans. Log Mgt.";
        DocumentType: Integer;
    begin
        case GenJnlLine."Document Type" of
            GenJnlLine."document type"::Payment:
                DocumentType := DOPaymentTransLogEntry."document type"::Payment;
            GenJnlLine."document type"::Refund:
                DocumentType := DOPaymentTransLogEntry."document type"::Refund;
        end;
        if DOPaymentTransLogEntry.FindFirst then
            if DOPaymentTransLogMgt.FindPostingNotFinishedEntry(DocumentType, GenJnlLine."Document No.", DOPaymentTransLogEntry) then
                Error(Text017, DOPaymentTransLogEntry."Transaction Type", GenJnlLine."Document Type", GenJnlLine."Document No.");
    end;

    local procedure GetCreditCard()
    var
        DOPaymentTransLogEntry: Record "DO Payment Trans. Log Entry";
    begin
        if "Applies-to Doc. No." = xRec."Applies-to Doc. No." then
            exit;
        if not (("Account Type" = "account type"::Customer) and
                ("Bal. Account Type" = "bal. account type"::"Bank Account"))
        then
            exit;

        if "Applies-to Doc. No." = '' then
            exit;

        if "Document Type" <> "document type"::Refund then
            exit;

        DOPaymentTransLogEntry.SetRange("Customer No.", "Account No.");
        DOPaymentTransLogEntry.SetRange("Transaction Type", DOPaymentTransLogEntry."transaction type"::Capture);
        DOPaymentTransLogEntry.SetRange("Document Type", DOPaymentTransLogEntry."document type"::Payment);
        DOPaymentTransLogEntry.SetRange("Document No.", "Applies-to Doc. No.");

        // if DOPaymentTransLogEntry.FindFirst then
        //     "Credit Card No." := DOPaymentTransLogEntry."Credit Card No."
        // else
        //     "Credit Card No." := '';
    end;


    procedure SetHideValidation(NewHideValidationDialog: Boolean)
    begin
        HideValidationDialog := NewHideValidationDialog;
    end;

    local procedure GetDefaultICPartnerGLAccNo(): Code[20]
    var
        GLAcc: Record "G/L Account";
        GLAccNo: Code[20];
    begin
        if "IC Partner Code" <> '' then begin
            if "Account Type" = "account type"::"G/L Account" then
                GLAccNo := "Account No."
            else
                GLAccNo := "Bal. Account No.";
            if GLAcc.Get(GLAccNo) then
                exit(GLAcc."Default IC Partner G/L Acc. No")
        end;
    end;


    procedure IsApplied(): Boolean
    begin
        if "Applies-to Doc. No." <> '' then
            exit(true);
        if "Applies-to ID" <> '' then
            exit(true);
        exit(false);
    end;


    procedure DataCaption(): Text[250]
    var
        GenJnlBatch: Record "Gen. Journal Batch";
    begin
        if GenJnlBatch.Get("Journal Template Name", "Journal Batch Name") then
            exit(GenJnlBatch.Name + '-' + GenJnlBatch.Description);
    end;

    local procedure ReadGLSetup()
    begin
        if not GLSetupRead then begin
            GLSetup.Get;
            GLSetupRead := true;
        end;
    end;


    procedure GetCustLedgerEntry()
    begin
        if ("Account Type" = "account type"::Customer) and ("Account No." = '') and
           ("Applies-to Doc. No." <> '') and (Amount = 0)
        then begin
            CustLedgEntry.Reset;
            CustLedgEntry.SetRange("Document No.", "Applies-to Doc. No.");
            CustLedgEntry.SetRange(Open, true);
            if not CustLedgEntry.FindFirst then
                Error(NotExistErr, "Applies-to Doc. No.");

            Validate("Account No.", CustLedgEntry."Customer No.");
            CustLedgEntry.CalcFields("Remaining Amount");

            if "Posting Date" <= CustLedgEntry."Pmt. Discount Date" then
                Amount := -(CustLedgEntry."Remaining Amount" - CustLedgEntry."Remaining Pmt. Disc. Possible")
            else
                Amount := -CustLedgEntry."Remaining Amount";

            if "Currency Code" <> CustLedgEntry."Currency Code" then begin
                FromCurrencyCode := GetShowCurrencyCode("Currency Code");
                ToCurrencyCode := GetShowCurrencyCode(CustLedgEntry."Currency Code");
                if not
                   Confirm(
                     Text003, true,
                     FieldCaption("Currency Code"), TableCaption, FromCurrencyCode,
                     ToCurrencyCode)
                then
                    Error(Text005);
                Validate("Currency Code", CustLedgEntry."Currency Code");
            end;

            "Document Type" := "document type"::Payment;
            "Applies-to Doc. Type" := CustLedgEntry."Document Type";
            "Applies-to Doc. No." := CustLedgEntry."Document No.";
            "Applies-to ID" := '';
            if ("Applies-to Doc. Type" = "applies-to doc. type"::Invoice) and
               ("Document Type" = "document type"::Payment)
            then
                "External Document No." := CustLedgEntry."External Document No.";
            "Bal. Account Type" := "bal. account type"::"G/L Account";

            GenJnlBatch.Get("Journal Template Name", "Journal Batch Name");
            if GenJnlBatch."Bal. Account No." <> '' then begin
                "Bal. Account Type" := GenJnlBatch."Bal. Account Type";
                Validate("Bal. Account No.", GenJnlBatch."Bal. Account No.");
            end else
                Validate(Amount);
        end;
    end;


    procedure GetVendLedgerEntry()
    begin
        if ("Account Type" = "account type"::Vendor) and ("Account No." = '') and
           ("Applies-to Doc. No." <> '') and (Amount = 0)
        then begin
            VendLedgEntry.Reset;
            VendLedgEntry.SetRange("Document No.", "Applies-to Doc. No.");
            VendLedgEntry.SetRange(Open, true);
            if not VendLedgEntry.FindFirst then
                Error(NotExistErr, "Applies-to Doc. No.");

            Validate("Account No.", VendLedgEntry."Vendor No.");
            VendLedgEntry.CalcFields("Remaining Amount");

            if "Posting Date" <= VendLedgEntry."Pmt. Discount Date" then
                Amount := -(CustLedgEntry."Remaining Amount" - VendLedgEntry."Remaining Pmt. Disc. Possible")
            else
                Amount := -VendLedgEntry."Remaining Amount";

            if "Currency Code" <> VendLedgEntry."Currency Code" then begin
                FromCurrencyCode := GetShowCurrencyCode("Currency Code");
                ToCurrencyCode := GetShowCurrencyCode(CustLedgEntry."Currency Code");
                if not
                   Confirm(
                     Text003,
                     true, FieldCaption("Currency Code"), TableCaption, FromCurrencyCode, ToCurrencyCode)
                then
                    Error(Text005);
                Validate("Currency Code", VendLedgEntry."Currency Code");
            end;

            "Document Type" := "document type"::Payment;
            "Applies-to Doc. Type" := VendLedgEntry."Document Type";
            "Applies-to Doc. No." := VendLedgEntry."Document No.";
            "Applies-to ID" := '';
            if ("Applies-to Doc. Type" = "applies-to doc. type"::Invoice) and
               ("Document Type" = "document type"::Payment)
            then
                "External Document No." := VendLedgEntry."External Document No.";
            "Bal. Account Type" := "bal. account type"::"G/L Account";

            GenJnlBatch.Get("Journal Template Name", "Journal Batch Name");
            if GenJnlBatch."Bal. Account No." <> '' then begin
                "Bal. Account Type" := GenJnlBatch."Bal. Account Type";
                Validate("Bal. Account No.", GenJnlBatch."Bal. Account No.");
            end else
                Validate(Amount);
        end;
    end;

    local procedure CustVendAccountNosModified(): Boolean
    begin
        exit(
          (("Bal. Account No." <> xRec."Bal. Account No.") and
           ("Bal. Account Type" in ["bal. account type"::Customer, "bal. account type"::Vendor])) or
          (("Account No." <> xRec."Account No.") and
           ("Account Type" in ["account type"::Customer, "account type"::Vendor])))
    end;

    local procedure CheckPaymentTolerance()
    begin
        if Amount <> 0 then
            if ("Bal. Account No." <> xRec."Bal. Account No.") or ("Account No." <> xRec."Account No.") then
                PaymentToleranceMgt.PmtTolGenJnl(Rec);
    end;


    procedure IncludeVATAmount(): Boolean
    begin
        exit(
          ("VAT Posting" = "vat posting"::"Manual VAT Entry") and
          ("VAT Calculation Type" <> "vat calculation type"::"Reverse Charge VAT"));
    end;


    procedure ConvertAmtFCYToLCYForSourceCurrency(Amount: Decimal): Decimal
    var
        Currency: Record Currency;
        CurrExchRate: Record "Currency Exchange Rate";
        CurrencyFactor: Decimal;
    begin
        if (Amount = 0) or ("Source Currency Code" = '') then
            exit(Amount);

        Currency.Get("Source Currency Code");
        CurrencyFactor := CurrExchRate.ExchangeRate("Posting Date", "Source Currency Code");
        exit(
          ROUND(
            CurrExchRate.ExchangeAmtFCYToLCY(
              "Posting Date", "Source Currency Code", Amount, CurrencyFactor),
            Currency."Amount Rounding Precision"));
    end;


    procedure MatchSingleLedgerEntry()
    begin
        Codeunit.Run(Codeunit::"Match General Journal Lines", Rec);
    end;


    procedure GetStyle(): Text
    begin
        if "Applied Automatically" then
            exit('Favorable')
    end;


    procedure GetOverdueDateInteractions(var OverdueWarningText: Text): Text
    var
        DueDate: Date;
    begin
        DueDate := GetAppliesToDocDueDate;
        OverdueWarningText := '';
        if (DueDate <> 0D) and (DueDate < "Posting Date") then begin
            OverdueWarningText := DueDateMsg;
            exit('Unfavorable');
        end;
        exit('');
    end;


    procedure ClearDataExchangeEntries(DeleteHeaderEntries: Boolean)
    var
        DataExchField: Record "Data Exch. Field";
        GenJournalLine: Record "Gen. Journal Line";
    begin
        DataExchField.DeleteRelatedRecords("Data Exch. Entry No.", "Data Exch. Line No.");

        GenJournalLine.SetRange("Journal Template Name", "Journal Template Name");
        GenJournalLine.SetRange("Journal Batch Name", "Journal Batch Name");
        GenJournalLine.SetRange("Data Exch. Entry No.", "Data Exch. Entry No.");
        GenJournalLine.SetFilter("Line No.", '<>%1', "Line No.");
        if GenJournalLine.IsEmpty or DeleteHeaderEntries then
            DataExchField.DeleteRelatedRecords("Data Exch. Entry No.", 0);
    end;


    procedure ClearAppliedGenJnlLine()
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        if "Applies-to Doc. No." = '' then
            exit;
        GenJournalLine.SetRange("Journal Template Name", "Journal Template Name");
        GenJournalLine.SetRange("Journal Batch Name", "Journal Batch Name");
        GenJournalLine.SetFilter("Line No.", '<>%1', "Line No.");
        GenJournalLine.SetRange("Document Type", "Applies-to Doc. Type");
        GenJournalLine.SetRange("Document No.", "Applies-to Doc. No.");
        GenJournalLine.ModifyAll("Applied Automatically", false);
        GenJournalLine.ModifyAll("Account Type", GenJournalLine."account type"::"G/L Account");
        GenJournalLine.ModifyAll("Account No.", '');
    end;


    procedure GetIncomingDocumentURL(): Text[1000]
    var
        IncomingDocument: Record "Incoming Document";
    begin
        if "Incoming Document Entry No." = 0 then
            exit('');

        IncomingDocument.Get("Incoming Document Entry No.");
        exit(IncomingDocument.GetURL);
    end;


    procedure InsertPaymentFileError(Text: Text)
    var
        PaymentJnlExportErrorText: Record "Payment Jnl. Export Error Text";
    begin
        PaymentJnlExportErrorText.CreateNew(Rec, Text, '', '');
    end;


    procedure InsertPaymentFileErrorWithDetails(ErrorText: Text; AddnlInfo: Text; ExtSupportInfo: Text)
    var
        PaymentJnlExportErrorText: Record "Payment Jnl. Export Error Text";
    begin
        PaymentJnlExportErrorText.CreateNew(Rec, ErrorText, AddnlInfo, ExtSupportInfo);
    end;


    procedure DeletePaymentFileBatchErrors()
    var
        PaymentJnlExportErrorText: Record "Payment Jnl. Export Error Text";
    begin
        PaymentJnlExportErrorText.DeleteJnlBatchErrors(Rec);
    end;


    procedure DeletePaymentFileErrors()
    var
        PaymentJnlExportErrorText: Record "Payment Jnl. Export Error Text";
    begin
        PaymentJnlExportErrorText.DeleteJnlLineErrors(Rec);
    end;


    procedure HasPaymentFileErrors(): Boolean
    var
        PaymentJnlExportErrorText: Record "Payment Jnl. Export Error Text";
    begin
        exit(PaymentJnlExportErrorText.JnlLineHasErrors(Rec));
    end;


    procedure HasPaymentFileErrorsInBatch(): Boolean
    var
        PaymentJnlExportErrorText: Record "Payment Jnl. Export Error Text";
    begin
        exit(PaymentJnlExportErrorText.JnlBatchHasErrors(Rec));
    end;

    local procedure UpdateDescription(Name: Text[70])
    begin
        if not IsAdHocDescription then
            Description := Name;
        //"Member Name" := Name;
    end;

    local procedure IsAdHocDescription(): Boolean
    var
        GLAccount: Record "G/L Account";
        Customer: Record Customer;
        Vendor: Record Vendor;
        BankAccount: Record "Bank Account";
        FixedAsset: Record "Fixed Asset";
        ICPartner: Record "IC Partner";
    begin
        if Description = '' then
            exit(false);
        if xRec."Account No." = '' then
            exit(true);

        case xRec."Account Type" of
            xRec."account type"::"G/L Account":
                exit(GLAccount.Get(xRec."Account No.") and (GLAccount.Name <> Description));
            xRec."account type"::Customer:
                exit(Customer.Get(xRec."Account No.") and (Customer.Name <> Description));
            xRec."account type"::Vendor:
                exit(Vendor.Get(xRec."Account No.") and (Vendor.Name <> Description));
            xRec."account type"::"Bank Account":
                exit(BankAccount.Get(xRec."Account No.") and (BankAccount.Name <> Description));
            xRec."account type"::"Fixed Asset":
                exit(FixedAsset.Get(xRec."Account No.") and (FixedAsset.Description <> Description));
            xRec."account type"::"IC Partner":
                exit(ICPartner.Get(xRec."Account No.") and (ICPartner.Name <> Description));
        end;
        exit(false);
    end;


    procedure GetAppliesToDocEntryNo(): Integer
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
        VendLedgEntry: Record "Vendor Ledger Entry";
        AccType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset";
        AccNo: Code[20];
    begin
        GetAccTypeAndNo(Rec, AccType, AccNo);
        case AccType of
            Acctype::Customer:
                begin
                    GetAppliesToDocCustLedgEntry(CustLedgEntry, AccNo);
                    exit(CustLedgEntry."Entry No.");
                end;
            Acctype::Vendor:
                begin
                    GetAppliesToDocVendLedgEntry(VendLedgEntry, AccNo);
                    exit(VendLedgEntry."Entry No.");
                end;
        end;
    end;


    procedure GetAppliesToDocDueDate(): Date
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
        VendLedgEntry: Record "Vendor Ledger Entry";
        AccType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset";
        AccNo: Code[20];
    begin
        GetAccTypeAndNo(Rec, AccType, AccNo);
        case AccType of
            Acctype::Customer:
                begin
                    GetAppliesToDocCustLedgEntry(CustLedgEntry, AccNo);
                    exit(CustLedgEntry."Due Date");
                end;
            Acctype::Vendor:
                begin
                    GetAppliesToDocVendLedgEntry(VendLedgEntry, AccNo);
                    exit(VendLedgEntry."Due Date");
                end;
        end;
    end;

    local procedure GetAppliesToDocCustLedgEntry(var CustLedgEntry: Record "Cust. Ledger Entry"; AccNo: Code[20])
    begin
        CustLedgEntry.SetRange("Customer No.", AccNo);
        CustLedgEntry.SetRange(Open, true);
        if "Applies-to Doc. No." <> '' then begin
            CustLedgEntry.SetRange("Document Type", "Applies-to Doc. Type");
            CustLedgEntry.SetRange("Document No.", "Applies-to Doc. No.");
            if CustLedgEntry.FindFirst then;
        end else
            if "Applies-to ID" <> '' then begin
                CustLedgEntry.SetRange("Applies-to ID", "Applies-to ID");
                if CustLedgEntry.FindFirst then;
            end;
    end;

    local procedure GetAppliesToDocVendLedgEntry(var VendLedgEntry: Record "Vendor Ledger Entry"; AccNo: Code[20])
    begin
        VendLedgEntry.SetRange("Vendor No.", AccNo);
        VendLedgEntry.SetRange(Open, true);
        if "Applies-to Doc. No." <> '' then begin
            VendLedgEntry.SetRange("Document Type", "Applies-to Doc. Type");
            VendLedgEntry.SetRange("Document No.", "Applies-to Doc. No.");
            if VendLedgEntry.FindFirst then;
        end else
            if "Applies-to ID" <> '' then begin
                VendLedgEntry.SetRange("Applies-to ID", "Applies-to ID");
                if VendLedgEntry.FindFirst then;
            end;
    end;

    local procedure SetJournalLineFieldsFromApplication()
    var
        AccType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset";
        AccNo: Code[20];
    begin
        "Exported to Payment File" := false;
        GetAccTypeAndNo(Rec, AccType, AccNo);
        case AccType of
            Acctype::Customer:
                if "Applies-to ID" <> '' then begin
                    if FindFirstCustLedgEntryWithAppliesToID(AccNo, "Applies-to ID") then begin
                        CustLedgEntry.SetRange("Exported to Payment File", true);
                        "Exported to Payment File" := CustLedgEntry.FindFirst;
                    end
                end else
                    if "Applies-to Doc. No." <> '' then
                        if FindFirstCustLedgEntryWithAppliesToDocNo(AccNo, "Applies-to Doc. No.") then begin
                            "Exported to Payment File" := CustLedgEntry."Exported to Payment File";
                            "Applies-to Ext. Doc. No." := CustLedgEntry."External Document No.";
                        end;
            Acctype::Vendor:
                if "Applies-to ID" <> '' then begin
                    if FindFirstVendLedgEntryWithAppliesToID(AccNo, "Applies-to ID") then begin
                        VendLedgEntry.SetRange("Exported to Payment File", true);
                        "Exported to Payment File" := VendLedgEntry.FindFirst;
                    end
                end else
                    if "Applies-to Doc. No." <> '' then
                        if FindFirstVendLedgEntryWithAppliesToDocNo(AccNo, "Applies-to Doc. No.") then begin
                            "Exported to Payment File" := VendLedgEntry."Exported to Payment File";
                            "Applies-to Ext. Doc. No." := VendLedgEntry."External Document No.";
                        end;
        end;
    end;

    local procedure GetAccTypeAndNo(GenJnlLine2: Record "Gen. Journal Line"; var AccType: Option; var AccNo: Code[20])
    begin
        if GenJnlLine2."Bal. Account Type" in
           [GenJnlLine2."bal. account type"::Customer, GenJnlLine2."bal. account type"::Vendor]
        then begin
            AccType := GenJnlLine2."Bal. Account Type";
            AccNo := GenJnlLine2."Bal. Account No.";
        end else begin
            AccType := GenJnlLine2."Account Type";
            AccNo := GenJnlLine2."Account No.";
        end;
    end;

    local procedure FindFirstCustLedgEntryWithAppliesToID(AccNo: Code[20]; AppliesToID: Code[50]): Boolean
    begin
        CustLedgEntry.Reset;
        CustLedgEntry.SetCurrentkey("Customer No.", "Applies-to ID", Open);
        CustLedgEntry.SetRange("Customer No.", AccNo);
        CustLedgEntry.SetRange("Applies-to ID", AppliesToID);
        CustLedgEntry.SetRange(Open, true);
        exit(CustLedgEntry.FindFirst)
    end;

    local procedure FindFirstCustLedgEntryWithAppliesToDocNo(AccNo: Code[20]; AppliestoDocNo: Code[20]): Boolean
    begin
        CustLedgEntry.Reset;
        CustLedgEntry.SetCurrentkey("Document No.");
        CustLedgEntry.SetRange("Document No.", AppliestoDocNo);
        CustLedgEntry.SetRange("Document Type", "Applies-to Doc. Type");
        CustLedgEntry.SetRange("Customer No.", AccNo);
        CustLedgEntry.SetRange(Open, true);
        exit(CustLedgEntry.FindFirst)
    end;

    local procedure FindFirstVendLedgEntryWithAppliesToID(AccNo: Code[20]; AppliesToID: Code[50]): Boolean
    begin
        VendLedgEntry.Reset;
        VendLedgEntry.SetCurrentkey("Vendor No.", "Applies-to ID", Open);
        VendLedgEntry.SetRange("Vendor No.", AccNo);
        VendLedgEntry.SetRange("Applies-to ID", AppliesToID);
        VendLedgEntry.SetRange(Open, true);
        exit(VendLedgEntry.FindFirst)
    end;

    local procedure FindFirstVendLedgEntryWithAppliesToDocNo(AccNo: Code[20]; AppliestoDocNo: Code[20]): Boolean
    begin
        VendLedgEntry.Reset;
        VendLedgEntry.SetCurrentkey("Document No.");
        VendLedgEntry.SetRange("Document No.", AppliestoDocNo);
        VendLedgEntry.SetRange("Document Type", "Applies-to Doc. Type");
        VendLedgEntry.SetRange("Vendor No.", AccNo);
        VendLedgEntry.SetRange(Open, true);
        exit(VendLedgEntry.FindFirst)
    end;

    local procedure ClearPostingGroups()
    begin
        "Gen. Posting Type" := "gen. posting type"::" ";
        "Gen. Bus. Posting Group" := '';
        "Gen. Prod. Posting Group" := '';
        "VAT Bus. Posting Group" := '';
        "VAT Prod. Posting Group" := '';
    end;

    local procedure ClearBalancePostingGroups()
    begin
        "Bal. Gen. Posting Type" := "bal. gen. posting type"::" ";
        "Bal. Gen. Bus. Posting Group" := '';
        "Bal. Gen. Prod. Posting Group" := '';
        "Bal. VAT Bus. Posting Group" := '';
        "Bal. VAT Prod. Posting Group" := '';
    end;

    local procedure CleanLine()
    begin
        UpdateLineBalance;
        UpdateSource;
        CreateDim(
          DimMgt.TypeToTableID1("Account Type"), "Account No.",
          DimMgt.TypeToTableID1("Bal. Account Type"), "Bal. Account No.",
          Database::Job, "Job No.",
          Database::"Salesperson/Purchaser", "Salespers./Purch. Code",
          Database::Campaign, "Campaign No.");
        if not ("Bal. Account Type" in ["bal. account type"::Customer, "bal. account type"::Vendor]) then
            "Recipient Bank Account" := '';
        if xRec."Account No." <> '' then begin
            ClearPostingGroups;
            "Tax Area Code" := '';
            "Tax Liable" := false;
            "Tax Group Code" := '';
            "Bill-to/Pay-to No." := '';
            "Ship-to/Order Address Code" := '';
            "Sell-to/Buy-from No." := '';
            UpdateCountryCodeAndVATRegNo('');
        end;
    end;

    local procedure ReplaceDescription(): Boolean
    begin
        if "Bal. Account No." = '' then
            exit(true);
        GenJnlBatch.Get("Journal Template Name", "Journal Batch Name");
        exit(GenJnlBatch."Bal. Account No." <> '');
    end;


    procedure IsExportedToPaymentFile(): Boolean
    begin
        exit(IsPaymentJournallLineExported or IsAppliedToVendorLedgerEntryExported);
    end;


    procedure IsPaymentJournallLineExported(): Boolean
    var
        GenJnlLine: Record "Gen. Journal Line";
        OldFilterGroup: Integer;
        HasExportedLines: Boolean;
    begin
        GenJnlLine.CopyFilters(Rec);
        OldFilterGroup := GenJnlLine.FilterGroup;
        GenJnlLine.FilterGroup := 10;
        GenJnlLine.SetRange("Exported to Payment File", true);
        HasExportedLines := not GenJnlLine.IsEmpty;
        GenJnlLine.SetRange("Exported to Payment File");
        GenJnlLine.FilterGroup := OldFilterGroup;
        exit(HasExportedLines);
    end;


    procedure IsAppliedToVendorLedgerEntryExported(): Boolean
    var
        GenJnlLine: Record "Gen. Journal Line";
        VendLedgerEntry: Record "Vendor Ledger Entry";
    begin
        GenJnlLine.CopyFilters(Rec);

        if GenJnlLine.FindSet then
            repeat
                if GenJnlLine.IsApplied then begin
                    VendLedgerEntry.SetRange("Vendor No.", GenJnlLine."Account No.");
                    if GenJnlLine."Applies-to Doc. No." <> '' then begin
                        VendLedgerEntry.SetRange("Document Type", GenJnlLine."Applies-to Doc. Type");
                        VendLedgerEntry.SetRange("Document No.", GenJnlLine."Applies-to Doc. No.");
                    end;
                    if GenJnlLine."Applies-to ID" <> '' then
                        VendLedgerEntry.SetRange("Applies-to ID", GenJnlLine."Applies-to ID");
                    VendLedgerEntry.SetRange("Exported to Payment File", true);
                    if not VendLedgerEntry.IsEmpty then
                        exit(true);
                end;

                VendLedgerEntry.Reset;
                VendLedgerEntry.SetRange("Vendor No.", GenJnlLine."Account No.");
                VendLedgerEntry.SetRange("Applies-to Doc. Type", GenJnlLine."Document Type");
                VendLedgerEntry.SetRange("Applies-to Doc. No.", GenJnlLine."Document No.");
                VendLedgerEntry.SetRange("Exported to Payment File", true);
                if not VendLedgerEntry.IsEmpty then
                    exit(true);
            until GenJnlLine.Next = 0;

        exit(false);
    end;

    local procedure ClearAppliedAutomatically()
    begin
        if CurrFieldNo <> 0 then
            "Applied Automatically" := false;
    end;


    procedure SetPostingDateAsDueDate(DueDate: Date; DateOffset: DateFormula): Boolean
    var
        NewPostingDate: Date;
    begin
        if DueDate = 0D then
            exit(false);

        NewPostingDate := CalcDate(DateOffset, DueDate);
        if NewPostingDate < WorkDate then begin
            Validate("Posting Date", WorkDate);
            exit(true);
        end;

        Validate("Posting Date", NewPostingDate);
        exit(false);
    end;


    procedure CalculatePostingDate()
    var
        GenJnlLine: Record "Gen. Journal Line";
        EmptyDateFormula: DateFormula;
    begin
        GenJnlLine.Copy(Rec);
        GenJnlLine.SetRange("Journal Template Name", "Journal Template Name");
        GenJnlLine.SetRange("Journal Batch Name", "Journal Batch Name");

        if GenJnlLine.FindSet then begin
            Window.Open(CalcPostDateMsg);
            repeat
                Evaluate(EmptyDateFormula, '<0D>');
                GenJnlLine.SetPostingDateAsDueDate(GenJnlLine.GetAppliesToDocDueDate, EmptyDateFormula);
                GenJnlLine.Modify(true);
                Window.Update(1, GenJnlLine."Document No.");
            until GenJnlLine.Next = 0;
            Window.Close;
        end;
    end;


    procedure ImportBankStatement()
    var
        ProcessGenJnlLines: Codeunit "Process Gen. Journal  Lines";
    begin
        ProcessGenJnlLines.ImportBankStatement(Rec);
    end;


    procedure ExportPaymentFile()
    begin
        if not FindSet then
            Error(NothingToExportErr);
        SetRange("Journal Template Name", "Journal Template Name");
        SetRange("Journal Batch Name", "Journal Batch Name");

        GenJnlBatch.Get("Journal Template Name", "Journal Batch Name");
        GenJnlBatch.TestField("Bal. Account Type", GenJnlBatch."bal. account type"::"Bank Account");
        GenJnlBatch.TestField("Bal. Account No.");

        CheckDocNoOnLines;
        if IsExportedToPaymentFile then
            if not Confirm(ExportAgainQst) then
                exit;
        BankAcc.Get(GenJnlBatch."Bal. Account No.");
        if BankAcc.GetPaymentExportCodeunitID > 0 then
            Codeunit.Run(BankAcc.GetPaymentExportCodeunitID, Rec)
        else
            Codeunit.Run(Codeunit::"Exp. Launcher Gen. Jnl.", Rec);
    end;


    procedure TotalExportedAmount(): Decimal
    var
        CreditTransferEntry: Record "Credit Transfer Entry";
    begin
        if not ("Account Type" in ["account type"::Customer, "account type"::Vendor]) then
            exit(0);
        GenJnlShowCTEntries.SetFiltersOnCreditTransferEntry(Rec, CreditTransferEntry);
        CreditTransferEntry.CalcSums("Transfer Amount");
        exit(CreditTransferEntry."Transfer Amount");
    end;


    procedure DrillDownExportedAmount()
    var
        CreditTransferEntry: Record "Credit Transfer Entry";
    begin
        if not ("Account Type" in ["account type"::Customer, "account type"::Vendor]) then
            exit;
        GenJnlShowCTEntries.SetFiltersOnCreditTransferEntry(Rec, CreditTransferEntry);
        Page.Run(Page::"Credit Transfer Reg. Entries", CreditTransferEntry);
    end;

    local procedure CopyDimensionsFromJobTaskLine()
    begin
        "Dimension Set ID" := JobJnlLine."Dimension Set ID";
        "Shortcut Dimension 1 Code" := JobJnlLine."Shortcut Dimension 1 Code";
        "Shortcut Dimension 2 Code" := JobJnlLine."Shortcut Dimension 2 Code";
    end;

    local procedure SetAmountWithCustLedgEntry()
    begin
        if "Currency Code" <> CustLedgEntry."Currency Code" then
            CheckModifyCurrencyCode(GenJnlLine."account type"::Customer, CustLedgEntry."Currency Code");
        if Amount = 0 then begin
            CustLedgEntry.CalcFields("Remaining Amount");
            SetAmountWithRemaining(
              PaymentToleranceMgt.CheckCalcPmtDiscGenJnlCust(Rec, CustLedgEntry, 0, false),
              CustLedgEntry."Amount to Apply", CustLedgEntry."Remaining Amount", CustLedgEntry."Remaining Pmt. Disc. Possible");
        end;
    end;

    local procedure SetAmountWithVendLedgEntry()
    begin
        if "Currency Code" <> VendLedgEntry."Currency Code" then
            CheckModifyCurrencyCode(GenJnlLine."account type"::Vendor, VendLedgEntry."Currency Code");
        if Amount = 0 then begin
            VendLedgEntry.CalcFields("Remaining Amount");
            SetAmountWithRemaining(
              PaymentToleranceMgt.CheckCalcPmtDiscGenJnlVend(Rec, VendLedgEntry, 0, false),
              VendLedgEntry."Amount to Apply", VendLedgEntry."Remaining Amount", VendLedgEntry."Remaining Pmt. Disc. Possible");
        end;
    end;


    procedure CheckModifyCurrencyCode(AccountType: Option; CustVendLedgEntryCurrencyCode: Code[10])
    begin
        if Amount = 0 then begin
            FromCurrencyCode := GetShowCurrencyCode("Currency Code");
            ToCurrencyCode := GetShowCurrencyCode(CustVendLedgEntryCurrencyCode);
            if not
               Confirm(
                 Text003, true, FieldCaption("Currency Code"), TableCaption, FromCurrencyCode, ToCurrencyCode)
            then
                Error(Text005);
            Validate("Currency Code", CustVendLedgEntryCurrencyCode);
        end else
            GenJnlApply.CheckAgainstApplnCurrency(
              "Currency Code", CustVendLedgEntryCurrencyCode, AccountType, true);
    end;

    local procedure SetAmountWithRemaining(CalcPmtDisc: Boolean; AmountToApply: Decimal; RemainingAmount: Decimal; RemainingPmtDiscPossible: Decimal)
    begin
        if AmountToApply <> 0 then
            if CalcPmtDisc and (Abs(AmountToApply) >= Abs(RemainingAmount - RemainingPmtDiscPossible)) then
                Amount := -(RemainingAmount - RemainingPmtDiscPossible)
            else
                Amount := -AmountToApply
        else
            if CalcPmtDisc then
                Amount := -(RemainingAmount - RemainingPmtDiscPossible)
            else
                Amount := -RemainingAmount;
        if "Bal. Account Type" in ["bal. account type"::Customer, "bal. account type"::Vendor] then
            Amount := -Amount;
        Validate(Amount);
    end;


    procedure IsOpenedFromBatch(): Boolean
    var
        GenJournalBatch: Record "Gen. Journal Batch";
        TemplateFilter: Text;
        BatchFilter: Text;
    begin
        BatchFilter := GetFilter("Journal Batch Name");
        if BatchFilter <> '' then begin
            TemplateFilter := GetFilter("Journal Template Name");
            if TemplateFilter <> '' then
                GenJournalBatch.SetFilter("Journal Template Name", TemplateFilter);
            GenJournalBatch.SetFilter(Name, BatchFilter);
            GenJournalBatch.FindFirst;
        end;

        exit((("Journal Batch Name" <> '') and ("Journal Template Name" = '')) or (BatchFilter <> ''));
    end;


    procedure GetDeferralAmount() DeferralAmount: Decimal
    begin
        if "VAT Base Amount" <> 0 then
            DeferralAmount := "VAT Base Amount"
        else
            DeferralAmount := Amount;
    end;


    procedure ShowDeferrals(PostingDate: Date; CurrencyCode: Code[30]): Boolean
    var
        DeferralUtilities: Codeunit "Deferral Utilities";
    begin
        exit(
          DeferralUtilities.OpenLineScheduleEdit(
            "Deferral Code", GetDeferralDocType, "Journal Template Name", "Journal Batch Name", 0, '', "Line No.",
            GetDeferralAmount, PostingDate, Description, CurrencyCode));
    end;


    procedure GetDeferralDocType(): Integer
    begin
        exit(Deferraldoctype::"G/L");
    end;


    procedure IsForPurchase(): Boolean
    begin
        if ("Account Type" = "account type"::Vendor) or ("Bal. Account Type" = "bal. account type"::Vendor) then
            exit(true);

        exit(false);
    end;


    procedure IsForSales(): Boolean
    begin
        if ("Account Type" = "account type"::Customer) or ("Bal. Account Type" = "bal. account type"::Customer) then
            exit(true);

        exit(false);
    end;


}
