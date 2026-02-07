// namespace PolyTech.PolyTech;

// using Microsoft.Bank.BankAccount;
// using System.Security.User;
// using Microsoft.Inventory.Location;
// using Microsoft.Bank.Ledger;
// using Microsoft.Finance.GeneralLedger.Setup;
// using Microsoft.Foundation.Comment;
// using Microsoft.Foundation.Address;
// using Microsoft.Utilities;
// using Microsoft.CRM.BusinessRelation;
// using Microsoft.Foundation.NoSeries;
// using Microsoft.Finance.Dimension;
// using Microsoft.CRM.Contact;
// using Microsoft.Bank.Setup;
// using Microsoft.EServices.OnlineMap;
// using System.IO;
// using Microsoft.Bank.Reconciliation;

tableextension 50080 "BankAccountExt" extends "Bank Account"
{
    fields
    {
        field(1000; "Account Type"; Enum BankAccountTypesEnums)
        {
            Caption = 'Account Type';
            DataClassification = ToBeClassified;
        }


        field(10005; "E-Pay Export File Path"; Text[250])
        {
            Caption = 'E-Pay Export File Path';
        }
        field(10006; "Last E-Pay Export File Name"; Text[30])
        {
            Caption = 'Last E-Pay Export File Name';

            trigger OnValidate()
            begin
                // if ("Last E-Pay Export File Name" <> '') and not ValidateIncrementableText("Last E-Pay Export File Name") then
                //   Error(StrSubstNo(NonIncrementingTextErr,FieldCaption("Last E-Pay Export File Name")));
            end;
        }
        field(10007; "E-Pay Trans. Program Path"; Text[250])
        {
            Caption = 'E-Pay Trans. Program Path';
        }
        field(10008; "E-Pay Trans. Program Command"; Text[80])
        {
            Caption = 'E-Pay Trans. Program Command';
        }
        field(10009; "Last ACH File ID Modifier"; Code[1])
        {
            Caption = 'Last ACH File ID Modifier';
            Editable = false;
        }
        field(10010; "Last Remittance Advice No."; Code[20])
        {
            Caption = 'Last Remittance Advice No.';

            trigger OnValidate()
            begin
                // if ("Last Remittance Advice No." <> '') and not ValidateIncrementableText("Last Remittance Advice No.") then
                //   Error(StrSubstNo(NonIncrementingTextErr,FieldCaption("Last Remittance Advice No.")));
            end;
        }
        field(10011; "Export Format"; Option)
        {
            BlankZero = true;
            Caption = 'Export Format';
            OptionCaption = ',US,CA,MX';
            OptionMembers = ,US,CA,MX;
        }
        field(10012; "Last E-Pay File Creation No."; Integer)
        {
            Caption = 'Last E-Pay File Creation No.';
        }
        field(10013; "Client No."; Code[10])
        {
            Caption = 'Client No.';
            CharAllowed = '09';
        }
        field(10014; "Client Name"; Code[30])
        {
            Caption = 'Client Name';
            CharAllowed = 'AZ09az';
        }
        field(10015; "Input Qualifier"; Code[30])
        {
            Caption = 'Input Qualifier';
        }
        field(10017; "Bank Communication"; Option)
        {
            Caption = 'Bank Communication';
            OptionCaption = 'E English,F French,S Spanish';
            OptionMembers = "E English","F French","S Spanish";
        }
        field(10018; "Check Date Format"; Option)
        {
            Caption = 'Check Date Format';
            OptionCaption = ' ,MM DD YYYY,DD MM YYYY,YYYY MM DD';
            OptionMembers = " ","MM DD YYYY","DD MM YYYY","YYYY MM DD";
        }
        field(10019; "Check Date Separator"; Option)
        {
            Caption = 'Check Date Separator';
            OptionCaption = ' ,-,.,/';
            OptionMembers = " ","-",".","/";
        }
        field(27000; "Bank Code"; Code[3])
        {
            Caption = 'Bank Code';
            Numeric = true;
        }
        field(68000; "Cashier ID"; Code[50])
        {
            TableRelation = System.Security.User."User Setup"."User ID";
        }
        field(68001; "Delete Field"; Code[10])
        {
        }
        field(68002; "Maximum Teller Withholding"; Decimal)
        {
        }
        field(68003; "Max Withdrawal Limit"; Decimal)
        {
        }
        field(68004; "Max Deposit Limit"; Decimal)
        {
        }
        field(68005; "Bank Type1"; Option)
        {
            OptionMembers = Normal,"Petty Cash";
        }
        field(68006; "Bankings Balance"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Balance (LCY)';
            Editable = false;
        }
        field(68007; "Treasury Balance"; Decimal)
        {
            CalcFormula = sum(Microsoft.Bank.Ledger."Bank Account Ledger Entry"."Amount (LCY)" where("Bank Account No." = field("No."),
                                                                                "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                                "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                                Description = const('ISSUE TO TELLER'),
                                                                                Amount = filter(< 0)));
            FieldClass = FlowField;
        }
        field(68008; "Received From Treasury"; Decimal)
        {
            CalcFormula = sum(Microsoft.Bank.Ledger."Bank Account Ledger Entry"."Amount (LCY)" where("Bank Account No." = field("No."),
                                                                                "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                                "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                                Description = filter('ISSUE TO TELLER')));
            FieldClass = FlowField;
        }
        field(68009; CashierID; Code[50])
        {
            Caption = 'User ID';
            TableRelation = "User Setup"."User ID";


            trigger OnValidate()
            var
                UserMgt: Codeunit "User Management";
                BankAcc: Record "Bank Account";
            begin

                if CashierID <> '' then begin
                    BankAcc.Reset;
                    BankAcc.SetRange(BankAcc.CashierID, CashierID);
                    if BankAcc.Find('-') = true then
                        if CashierID <> 'MMHSACCO\SMUTUMA' then
                            Error('Cashier is already mapped to another till %1', BankAcc."No.");
                end;
            end;
        }
        field(51516100; "Bank Type"; Option)
        {
            OptionMembers = Normal,Cash,"Fixed Deposit",SMPA,"Chq Collection","Petty Cash";

            trigger OnValidate()
            begin

                TestNoEntriesExist(FieldCaption("Bank Type"));
            end;
        }
        field(51516101; "Pending Voucher Amount"; Decimal)
        {
        }
        field(51516102; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center";

            trigger OnValidate()
            var
                UserMgt: Codeunit "User Management";
            begin

                // if not UserMgt.CheckRespCenter(1,"Responsibility Center") then
                //   Error(
                //     Text005,
                //     RespCenter.TableCaption,UserMgt.GetPurchasesFilter);
            end;
        }
        field(51516103; "Bank Branch Name"; Text[250])
        {
        }
        field(51516104; "Credit Agreement?"; Boolean)
        {
        }
        field(51516105; "Maximum Credit Limit"; Decimal)
        {
        }
        field(51516106; "Cheque Clearing  Account"; Boolean)
        {
        }
        field(51516292; "doc attached"; Boolean)
        {
        }
        field(51516293; "Teller Balance"; Decimal)
        {
            CalcFormula = Sum("Bank Account Ledger Entry".Amount WHERE("Bank Account No." = FIELD("No."),
                                                                        "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                        "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter")));

            Editable = false;
            FieldClass = FlowField;
        }
        field(51516294; "EFT Fees"; Decimal) { }
    }

    keys
    {
    }

    fieldgroups
    {

    }

    trigger OnDelete()
    begin
        // Error('You cannot delete a bank account');
        // MoveEntries.MoveBankAccEntries(Rec);

        // CommentLine.SetRange("Table Name", CommentLine."table name"::"Bank Account");
        // CommentLine.SetRange("No.", "No.");
        // CommentLine.DeleteAll;

        // UpdateContFromBank.OnDelete(Rec);

        // DimMgt.DeleteDefaultDim(Database::"Bank Account", "No.");
    end;

    trigger OnInsert()
    begin
        if "No." = '' then begin
            GLSetup.Get;
            GLSetup.TestField("Bank Account Nos.");
            // NoSeriesMgt.InitSeries(GLSetup."Bank Account Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        if not InsertFromContact then
            UpdateContFromBank.OnInsert(Rec);

        DimMgt.UpdateDefaultDim(
          Database::"Bank Account", "No.",
          "Global Dimension 1 Code", "Global Dimension 2 Code");
    end;

    trigger OnModify()
    begin

        "Last Date Modified" := Today;

        if (Name <> xRec.Name) or
           ("Search Name" <> xRec."Search Name") or
           ("Name 2" <> xRec."Name 2") or
           (Address <> xRec.Address) or
           ("Address 2" <> xRec."Address 2") or
           (City <> xRec.City) or
           ("Phone No." <> xRec."Phone No.") or
           ("Telex No." <> xRec."Telex No.") or
           ("Territory Code" <> xRec."Territory Code") or
           ("Currency Code" <> xRec."Currency Code") or
           ("Language Code" <> xRec."Language Code") or
           ("Our Contact Code" <> xRec."Our Contact Code") or
           ("Country/Region Code" <> xRec."Country/Region Code") or
           ("Fax No." <> xRec."Fax No.") or
           ("Telex Answer Back" <> xRec."Telex Answer Back") or
           ("Post Code" <> xRec."Post Code") or
           (County <> xRec.County) or
           ("E-Mail" <> xRec."E-Mail") or
           ("Home Page" <> xRec."Home Page")
        then begin
            Modify;
            UpdateContFromBank.OnModify(Rec);
        end;
    end;

    trigger OnRename()
    begin
        "Last Date Modified" := Today;
    end;

    var
        Text000: label 'You cannot change %1 because there are one or more open ledger entries for this bank account.';
        Text003: label 'Do you wish to create a contact for %1 %2?';
        GLSetup: Record "General Ledger Setup";
        BankAcc: Record "Bank Account";
        BankAccLedgEntry: Record "Bank Account Ledger Entry";
        CommentLine: Record "Comment Line";
        PostCode: Record "Post Code";
        NoSeriesMgt: Codeunit "No. Series";
        MoveEntries: Codeunit MoveEntries;
        UpdateContFromBank: Codeunit "BankCont-Update";
        DimMgt: Codeunit DimensionManagement;
        InsertFromContact: Boolean;
        Text004: label 'Before you can use Online Map, you must fill in the Online Map Setup window.\See Setting Up Online Map in Help.';
        BankAccIdentifierIsEmptyErr: label 'You must specify either a %1 or an %2.';
        InvalidPercentageValueErr: label 'If %1 is %2, then the value must be between 0 and 99.', Comment = '%1 is "field caption and %2 is "Percentage"';
        InvalidValueErr: label 'The value must be positive.';
        AutoGenerateStmtNoQst: label 'The %1 on %2 number %3 is not specified. Do you want to use an auto-generated value?', Comment = '%1=FieldCaption,%2=TableCaption,%3=FieldValue';
        NonIncrementingTextErr: label 'The %1 value may contain both letters and numbers, and must contain an integer.', Comment = '%1=Field caption for a field of BankAccount that is undergoing input validation';
        UserMgt: Codeunit "User Setup Management";
        Text005: label 'Your identification is set up to process from %1 %2 only.';
        RespCenter: Record "Responsibility Center";


    procedure AssistEdit(OldBankAcc: Record "Bank Account"): Boolean
    begin
        // BankAcc := Rec;
        // GLSetup.Get;
        // GLSetup.TestField("Bank Account Nos.");
        // if NoSeriesMgt.SelectSeries(GLSetup."Bank Account Nos.", OldBankAcc."No. Series", BankAcc."No. Series") then begin
        //     GLSetup.Get;
        //     GLSetup.TestField("Bank Account Nos.");
        //     NoSeriesMgt.SetSeries(BankAcc."No.");
        //     Rec := BankAcc;
        //     exit(true);
        // end;
    end;


    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        DimMgt.SaveDefaultDim(Database::"Bank Account", "No.", FieldNumber, ShortcutDimCode);
        Modify;
    end;


    procedure ShowContact()
    var
        ContBusRel: Record "Contact Business Relation";
        Cont: Record Contact;
    begin
        if "No." = '' then
            exit;

        ContBusRel.SetCurrentkey("Link to Table", "No.");
        ContBusRel.SetRange("Link to Table", ContBusRel."link to table"::"Bank Account");
        ContBusRel.SetRange("No.", "No.");
        if not ContBusRel.FindFirst then begin
            if not Confirm(Text003, false, TableCaption, "No.") then
                exit;
            UpdateContFromBank.InsertNewContact(Rec, false);
            ContBusRel.FindFirst;
        end;
        Commit;

        Cont.SetCurrentkey("Company Name", "Company No.", Type, Name);
        Cont.SetRange("Company No.", ContBusRel."Contact No.");
        Page.Run(Page::"Contact List", Cont);
        exit;
    end;


    procedure SetInsertFromContact(FromContact: Boolean)
    begin
        InsertFromContact := FromContact;
    end;


    procedure GetPaymentExportCodeunitID(): Integer
    var
        BankExportImportSetup: Record "Bank Export/Import Setup";
    begin
        GetBankExportImportSetup(BankExportImportSetup);
        exit(BankExportImportSetup."Processing Codeunit ID");
    end;


    procedure GetPaymentExportXMLPortID(): Integer
    var
        BankExportImportSetup: Record "Bank Export/Import Setup";
    begin
        GetBankExportImportSetup(BankExportImportSetup);
        BankExportImportSetup.TestField("Processing XMLport ID");
        exit(BankExportImportSetup."Processing XMLport ID");
    end;


    procedure GetDDExportCodeunitID(): Integer
    var
        BankExportImportSetup: Record "Bank Export/Import Setup";
    begin
        GetDDExportImportSetup(BankExportImportSetup);
        BankExportImportSetup.TestField("Processing Codeunit ID");
        exit(BankExportImportSetup."Processing Codeunit ID");
    end;


    procedure GetDDExportXMLPortID(): Integer
    var
        BankExportImportSetup: Record "Bank Export/Import Setup";
    begin
        GetDDExportImportSetup(BankExportImportSetup);
        BankExportImportSetup.TestField("Processing XMLport ID");
        exit(BankExportImportSetup."Processing XMLport ID");
    end;


    procedure GetBankExportImportSetup(var BankExportImportSetup: Record "Bank Export/Import Setup")
    begin
        TestField("Payment Export Format");
        BankExportImportSetup.Get("Payment Export Format");
    end;


    procedure GetDDExportImportSetup(var BankExportImportSetup: Record "Bank Export/Import Setup")
    begin
        TestField("SEPA Direct Debit Exp. Format");
        BankExportImportSetup.Get("SEPA Direct Debit Exp. Format");
    end;


    procedure GetCreditTransferMessageNo(): Code[20]
    var
        NoSeriesManagement: Codeunit "No. Series";
    begin
        TestField("Credit Transfer Msg. Nos.");
        exit(NoSeriesManagement.GetNextNo("Credit Transfer Msg. Nos.", Today, true));
    end;


    procedure GetDirectDebitMessageNo(): Code[20]
    var
        NoSeriesManagement: Codeunit "No. Series";
    begin
        TestField("Direct Debit Msg. Nos.");
        exit(NoSeriesManagement.GetNextNo("Direct Debit Msg. Nos.", Today, true));
    end;


    procedure DisplayMap()
    var
        MapPoint: Record "Online Map Setup";
        MapMgt: Codeunit "Online Map Management";
    begin
        if MapPoint.FindFirst then
            MapMgt.MakeSelection(Database::"Bank Account", GetPosition)
        else
            Message(Text004);
    end;


    procedure GetDataExchDef(var DataExchDef: Record "Data Exch. Def")
    var
        BankExportImportSetup: Record "Bank Export/Import Setup";
    begin
        TestField("Bank Statement Import Format");

        BankExportImportSetup.Get("Bank Statement Import Format");
        BankExportImportSetup.TestField("Data Exch. Def. Code");

        DataExchDef.Get(BankExportImportSetup."Data Exch. Def. Code");
        DataExchDef.TestField(Type, DataExchDef.Type::"Bank Statement Import");
    end;


    procedure GetBankAccountNoWithCheck() AccountNo: Text
    begin
        AccountNo := GetBankAccountNo;
        if AccountNo = '' then
            Error(BankAccIdentifierIsEmptyErr, FieldCaption("Bank Account No."), FieldCaption(Iban));
    end;


    procedure GetBankAccountNo(): Text
    begin
        if Iban <> '' then
            exit(DelChr(Iban, '=<>'));

        if "Bank Account No." <> '' then
            exit("Bank Account No.");
    end;


    procedure IsInLocalCurrency(): Boolean
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
    begin
        if "Currency Code" = '' then
            exit(true);

        GeneralLedgerSetup.Get;
        exit("Currency Code" = GeneralLedgerSetup.GetCurrencyCode(''));
    end;


    procedure OpenBankReconciliationList()
    var
        BankAccReconciliation: Record "Bank Acc. Reconciliation";
        BankAccReconciliationList: Page "Bank Acc. Reconciliation List";
    begin
        BankAccReconciliation.SetRange("Bank Account No.", "No.");
        BankAccReconciliationList.SetTableview(BankAccReconciliation);
        BankAccReconciliationList.Run;
    end;


    procedure CheckLastStatementNo(): Boolean
    begin
        if "Last Statement No." <> '' then
            exit(true);

        if not Confirm(AutoGenerateStmtNoQst, true, FieldCaption("Last Statement No."), TableCaption, "No.") then
            exit(false);

        "Last Statement No." := '0';
        Modify(true);

        exit(true);
    end;


    procedure GetPosPayExportCodeunitID(): Integer
    var
        BankExportImportSetup: Record "Bank Export/Import Setup";
    begin
        TestField("Positive Pay Export Code");
        BankExportImportSetup.Get("Positive Pay Export Code");
        exit(BankExportImportSetup."Processing Codeunit ID");
    end;

    [TryFunction]
    procedure ValidateIncrementableText(ValidateText: Text)
    begin
        ValidateText := IncStr(ValidateText);
        if ValidateText = '' then
            Error('');
    end;


    procedure TestNoEntriesExist(CurrentFieldName: Text[100])
    var
        BankLedgEntry: Record "Bank Account Ledger Entry";
    begin
        //To prevent change of field
        BankLedgEntry.SetCurrentkey(BankLedgEntry."Bank Account No.");
        BankLedgEntry.SetRange("Bank Account No.", "No.");
        if BankLedgEntry.Find('-') then
            Error(
            Text000,
             CurrentFieldName);
    end;

    // trigger OnBeforeDelete()
    // var
    //     bankacount: Record "Bank Account";
    //     BankLedgEntry: record "Bank Account Ledger Entry";
    // begin
    //     bankacount.Reset();
    //     bankacount.SetRange(bankacount."No.", "No.");
    //     bankacount.SetAutoCalcFields(bankacount.Balance);
    //     if bankacount.Find('-') then begin
    //         if bankacount.Balance <> 0 then begin
    //             Error('cannot delete a bank with entries');
    //         end else
    //             if bankacount.Balance = 0 then begin
    //                 BankLedgEntry.SetCurrentkey(BankLedgEntry."Bank Account No.");
    //                 BankLedgEntry.SetRange("Bank Account No.", bankacount."No.");
    //                 if BankLedgEntry.Find('-') then begin
    //                     Error('cannot delete a bank with entries');
    //                 end;
    //             end;
    //     end;


    // end;
}
