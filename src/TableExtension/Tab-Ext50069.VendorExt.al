tableextension 50069 "VendorExt" extends Vendor
{
    fields
    {
        field(1000; "Creditor Type"; enum CreditorTypeExt)
        {
            Caption = 'Creditor Type';
            DataClassification = ToBeClassified;
        }

        field(1001; "Preferred Bank Account"; Code[10])
        {
            Caption = 'Preferred Bank Account';
            TableRelation = "Vendor Bank Account".Code where("Vendor No." = field("No."));
        }


        field(10004; "UPS Zone"; Code[2])
        {
            Caption = 'UPS Zone';
        }
        field(10016; "Federal ID No."; Text[30])
        {
            Caption = 'Federal ID No.';
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
        field(10020; "IRS 1099 Code"; Code[10])
        {
            Caption = 'IRS 1099 Code';
        }
        field(10021; "Balance on Date"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = - sum("Detailed Vendor Ledg. Entry"."Amount Posted" where("Vendor No." = field("No."),
                                                                           "Posting Date" = field(upperlimit("Date Filter")),
                                                                           "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                           "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                           "Currency Code" = field("Currency Filter")));
            Caption = 'Balance on Date';
            Editable = false;
            FieldClass = FlowField;
        }
        field(10022; "Balance on Date (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - sum("Detailed Vendor Ledg. Entry"."Amount Posted" where("Vendor No." = field("No."),
                                                                                   "Posting Date" = field(upperlimit("Date Filter")),
                                                                                   "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                   "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                   "Currency Code" = field("Currency Filter")));
            Caption = 'Balance on Date ($)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(10023; "RFC No."; Code[13])
        {
            Caption = 'RFC No.';

            trigger OnValidate()
            var
                Vendor: Record Vendor;
            begin
                case "Tax Identification Type" of
                //   "tax identification type"::"Legal Entity":
                //     ValidateRFCNo(12);
                //   "tax identification type"::"Natural Person":
                //     ValidateRFCNo(13);
                end;
                Vendor.Reset;
                Vendor.SetRange("RFC No.", "RFC No.");
                Vendor.SetFilter("No.", '<>%1', "No.");
                // if Vendor.FindFirst then
            end;
        }
        field(10024; "CURP No."; Code[18])
        {
            Caption = 'CURP No.';

            trigger OnValidate()
            begin

            end;
        }
        field(10025; "State Inscription"; Text[30])
        {
            Caption = 'State Inscription';
        }
        field(14020; "Tax Identification Type"; Option)
        {
            Caption = 'Tax Identification Type';
            OptionCaption = 'Legal Entity,Natural Person';
            OptionMembers = "Legal Entity","Natural Person";
        }
        field(68001; "Staff No"; Code[20])
        {
        }

        field(68915; "Company Code"; Code[80])
        {
            TableRelation = "Sacco Employers";
        }

        field(68973; "MPESA Mobile No"; Code[20])
        {
        }

        field(69944; "Authorised Over Draft"; Decimal)
        {
            CalcFormula = sum("Over Draft Authorisation"."Approved Amount" where("Account No." = field("No."),
                                                                                  Status = const(Approved),
                                                                                  Expired = const(false),
                                                                                  Liquidated = const(false),
                                                                                  "Effective/Start Date" = field("Date Filter"),
                                                                                  Posted = const(true)));
            FieldClass = FlowField;
        }
        field(69945; "Net Salary"; Decimal)
        {
        }
        field(69946; "FD Maturity Instructions"; Option)
        {
            OptionCaption = ' ,Transfer to Savings,Transfer Interest & Renew,Renew';
            OptionMembers = " ","Transfer to Savings","Transfer Interest & Renew",Renew;
        }
        field(69997; "ATM Card Approved by"; Code[50])
        {
        }
        field(69998; "Disabled ATM Card No"; Code[18])
        {
            Editable = false;
        }
        field(69949; "Reason For Disabling ATM Card"; Text[200])
        {
        }
        field(69950; "Disable ATM Card"; Boolean)
        {

            trigger OnValidate()
            var
                StatusPermissions: Record "Status Change Permision";
            begin
                if "Disable ATM Card" = true then begin

                    StatusPermissions.Reset;
                    StatusPermissions.SetRange(StatusPermissions."User Id", UserId);
                    // StatusPermissions.SetRange(StatusPermissions."Function", StatusPermissions."function"::"29");
                    if StatusPermissions.Find('-') = false then
                        Error('You do not have permissions to disable Atm cards');


                    if "ATM No." = '' then
                        Error('You cannot disable a blank ATM Card');

                    if "Reason For Disabling ATM Card" = '' then
                        Error('You must specify reason for disabling this atm');



                    "Disabled ATM Card No" := "ATM No.";
                    "ATM No." := '';
                    "ATM Prov. No" := '';
                    "Atm card ready" := false;
                    "Disabled By" := UserId;
                    Modify;
                end;
            end;
        }
        field(69951; "Disabled By"; Code[50])
        {
        }
        field(69952; "Transfer Type"; Option)
        {
            OptionCaption = ' ,Deposits,Share Capital,Jaza Jaza';
            OptionMembers = " ",Deposits,"Share Capital","Jaza Jaza";
        }
        field(69953; "ATM Alert Sent"; Boolean)
        {
        }
        field(69954; "Old Vendor No."; Code[10])
        {
        }
        field(69955; "Loan No"; Code[20])
        {
            // TableRelation = "Loans Register"."Loan  No." where("Account No" = field("No."),
            //                                                     Posted = const(true),
            //                                                     "Outstanding Balance" = filter(> 0));
            TableRelation = "Loans Register"."Loan  No." where("Account No" = field("No."),
                                                               "Compound Balance" = filter(<> 0));
        }
        field(69056; "Principle Amount"; Decimal)
        {
        }
        field(69057; "Interest Amount"; Decimal)
        {
        }
        field(69058; "Bankers Cheque Amount"; Decimal)
        {
        }
        field(69060; "Registered M-Sacco"; Boolean)
        {
        }
        field(69061; "Sms Notification"; Boolean)
        {
        }
        field(69062; "Reason for Enabling ATM Card"; Text[30])
        {
        }
        field(69063; "Enabled By"; Code[20])
        {
        }
        field(69064; "Date Enabled"; Date)
        {
        }
        field(69065; "Pepea Shares"; Decimal)
        {
            CalcFormula = - sum("Detailed Vendor Ledg. Entry"."Amount Posted" where("Vendor No." = field("No."),
                                                                                   "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                   "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                   "Currency Code" = field("Currency Filter"),
                                                                                   "Transaction Type" = filter("Pepea Shares")));
            FieldClass = FlowField;
        }
        field(69066; "Transaction Type Fosa"; Option)
        {
            OptionCaption = ' ,Pepea Shares,School Fees Shares';
            OptionMembers = " ","Pepea Shares","School Fees Shares";
        }
        field(69067; "School Fees Shares"; Decimal)
        {
            CalcFormula = sum("Detailed Vendor Ledg. Entry"."Amount Posted" where("Vendor No." = field("No."),
                                                                          "Transaction Type Fosa" = filter("School Fees Shares")));
            FieldClass = FlowField;
        }
        field(69068; "Pepea Share"; Decimal)
        {
            CalcFormula = sum("Detailed Vendor Ledg. Entry"."Amount Posted" where("Vendor No." = field("No."),
                                                                          "Transaction Type Fosa" = filter("Pepea Shares")));
            FieldClass = FlowField;
        }

        field(69072; "Grower No"; Code[20])
        {
        }
        field(69073; "Pastrol Cont"; Decimal)
        {
        }
        field(69074; "Paid RegFee"; Boolean)
        {
        }
        field(69075; "Piggy Amount"; Decimal)
        {
        }
        field(69076; "Junior Trip"; Decimal)
        {
        }
        field(69077; "Holiday Savings"; Decimal)
        {
        }
        field(69079; "Overdraft amount"; Decimal)
        {
        }
        field(69080; "Remaining balance"; Decimal)
        {
        }
        field(69081; "Outstanding Overdraft"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("BOSA Account No"),
                                                                  "Transaction Type" = filter(Loan | "Loan Repayment"),
                                                                  "Loan product Type" = const('OVERDRAFT'),
                                                                  "Posting Date" = field("Date filter"),
                                                                  Reversed = const(false)));
            FieldClass = FlowField;
        }
        field(51516062; "Do Not Include?"; Boolean)
        {
        }
        field(51516063; "Oustanding Overdraft interest"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("BOSA Account No"),
                                                                  "Transaction Type" = filter("Interest due" | "Interest Paid"),
                                                                  "Loan product Type" = const('OVERDRAFT'),
                                                                  "Posting Date" = field("Date filter"),
                                                                  Reversed = const(false)));
            FieldClass = FlowField;
        }

        field(6987901; "Outstanding okoa biashara"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("BOSA Account No"),
                                                                  "Transaction Type" = filter(Loan | "Loan Repayment"),
                                                                  "Loan product Type" = const('OKOA'),
                                                                  "Posting Date" = field("Date filter"),
                                                                  Reversed = const(false)));
            FieldClass = FlowField;
        }


        field(6907003; "Outstanding FOSA Interest"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("BOSA Account No"),
                                                                  "Transaction Type" = filter("Interest Due" | "Interest Paid"),
                                                                  "Posting Date" = field("Date filter"),
                                                                  Reversed = const(false)
                                                                  , "Global Dimension 1 Code" = const('FOSA')));
            FieldClass = FlowField;
        }
        // field(6907904; "Outstanding FOSA Loan"; Decimal)
        // {
        //     CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("BOSA Account No"),
        //                                                           "Transaction Type" = filter("Loan" | "Loan Repayment"),
        //                                                           "Posting Date" = field("Date filter"),
        //                                                           Reversed = const(false)
        //                                                           , "Global Dimension 1 Code" = const('FOSA')
        //                                                           ));
        //     FieldClass = FlowField;
        // }
        field(6907905; "Outstanding Overdraft Interest"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("BOSA Account No"),
                                                                  "Transaction Type" = filter("Interest Due" | "Interest Paid"),
                                                                  "Posting Date" = field("Date filter"),
                                                                  Reversed = const(false)
                                                                  , "Loan product Type" = const('OVERDRAFT')));
            FieldClass = FlowField;
        }
        field(690796; "Outstanding OKOA Interest"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("BOSA Account No"),
                                                                  "Transaction Type" = filter("Interest Due" | "Interest Paid"),
                                                                  "Posting Date" = field("Date filter"),
                                                                  Reversed = const(false)
                                                                  , "Loan product Type" = const('OKOA')));
            FieldClass = FlowField;
        }
        field(6907908; "Total Outstanding Overdraft"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("BOSA Account No"),
                                                                  "Transaction Type" = filter("Interest Due" | "Interest Paid" | "Loan" | "Loan Repayment"),
                                                                  "Posting Date" = field("Date filter"),
                                                                  Reversed = const(false)
                                                                  , "Loan product Type" = const('OVERDRAFT')));
            FieldClass = FlowField;
        }
        field(690709; "Total Outstanding Okoa"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("BOSA Account No"),
                                                                  "Transaction Type" = filter("Interest Due" | "Interest Paid" | "Loan" | "Loan Repayment"),
                                                                  "Posting Date" = field("Date filter"),
                                                                  Reversed = const(false)
                                                                  , "Loan product Type" = const('OKOA')));
            FieldClass = FlowField;
        }


    }


    trigger OnDelete()
    var
        ItemVendor: Record "Item Vendor";
        PurchPrice: Record "Purchase Price";
        PurchLineDiscount: Record "Purchase Line Discount";
        PurchPrepmtPct: Record "Purchase Prepayment %";
        CustomReportSelection: Record "Custom Report Selection";
    begin

        // Error('You cannot delete an existing FOSA Account');

        // MoveEntries.MoveVendorEntries(Rec);

        // CommentLine.SetRange("Table Name", CommentLine."table name"::Vendor);
        // CommentLine.SetRange("No.", "No.");
        // CommentLine.DeleteAll;

        // VendBankAcc.SetRange("Vendor No.", "No.");
        // VendBankAcc.DeleteAll;

        // OrderAddr.SetRange("Vendor No.", "No.");
        // OrderAddr.DeleteAll;

        // // ItemCrossReference.SetCurrentkey("Cross-Reference Type", "Cross-Reference Type No.");
        // // ItemCrossReference.SetRange("Cross-Reference Type", ItemCrossReference."cross-reference type"::Vendor);
        // // ItemCrossReference.SetRange("Cross-Reference Type No.", "No.");
        // // ItemCrossReference.DeleteAll;

        // PurchOrderLine.SetCurrentkey("Document Type", "Pay-to Vendor No.");
        // PurchOrderLine.SetFilter(
        //   "Document Type", '%1|%2',
        //   PurchOrderLine."document type"::Order,
        //   PurchOrderLine."document type"::"Return Order");
        // PurchOrderLine.SetRange("Pay-to Vendor No.", "No.");
        // if PurchOrderLine.FindFirst then
        //     Error(
        //       Text000,
        //       TableCaption, "No.",
        //       PurchOrderLine."Document Type");

        // PurchOrderLine.SetRange("Pay-to Vendor No.");
        // PurchOrderLine.SetRange("Buy-from Vendor No.", "No.");
        // if PurchOrderLine.FindFirst then
        //     Error(
        //       Text000,
        //       TableCaption, "No.");

        // UpdateContFromVend.OnDelete(Rec);

        // DimMgt.DeleteDefaultDim(Database::Vendor, "No.");

        // ServiceItem.SetRange("Vendor No.", "No.");
        // ServiceItem.ModifyAll("Vendor No.", '');

        // ItemVendor.SetRange("Vendor No.", "No.");
        // ItemVendor.DeleteAll(true);

        // PurchPrice.SetCurrentkey("Vendor No.");
        // PurchPrice.SetRange("Vendor No.", "No.");
        // PurchPrice.DeleteAll(true);

        // PurchLineDiscount.SetCurrentkey("Vendor No.");
        // PurchLineDiscount.SetRange("Vendor No.", "No.");
        // PurchLineDiscount.DeleteAll(true);

        // CustomReportSelection.SetRange("Source Type", Database::Vendor);
        // CustomReportSelection.SetRange("Source No.", "No.");
        // CustomReportSelection.DeleteAll;

        // PurchPrepmtPct.SetCurrentkey("Vendor No.");
        // PurchPrepmtPct.SetRange("Vendor No.", "No.");
        // PurchPrepmtPct.DeleteAll(true);

    end;

    trigger OnInsert()
    begin

        if "No." = '' then begin
            PurchSetup.Get;
            PurchSetup.TestField("Vendor Nos.");
            //NoSeriesMgt.InitSeries(PurchSetup."Vendor Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        if "Invoice Disc. Code" = '' then
            "Invoice Disc. Code" := "No.";

    end;

    trigger OnModify()
    begin
        "Last Date Modified" := Today;
        "Modified By" := UserId;

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
           ("Purchaser Code" <> xRec."Purchaser Code") or
           ("Country/Region Code" <> xRec."Country/Region Code") or
           ("Fax No." <> xRec."Fax No.") or
           ("Telex Answer Back" <> xRec."Telex Answer Back") or
           ("VAT Registration No." <> xRec."VAT Registration No.") or
           ("Post Code" <> xRec."Post Code") or
           (County <> xRec.County) or
           ("E-Mail" <> xRec."E-Mail") or
           ("Home Page" <> xRec."Home Page")
        then begin
            //MODIFY;
            //UpdateContFromVend.OnModify(Rec);
            //IF FIND THEN;
        end;
    end;

    trigger OnRename()
    begin
        "Last Date Modified" := Today;
        "Modified By" := UserId;
    end;

    var
        Text000: label 'You cannot delete %1 %2 because there is at least one outstanding Purchase %3 for this vendor.';
        Text002: label 'You have set %1 to %2. Do you want to update the %3 price list accordingly?';
        Text003: label 'Do you wish to create a contact for %1 %2?';
        PurchSetup: Record "Purchases & Payables Setup";
        CommentLine: Record "Comment Line";
        PurchOrderLine: Record "Purchase Line";
        PostCode: Record "Post Code";
        VendBankAcc: Record "Vendor Bank Account";
        OrderAddr: Record "Order Address";
        GenBusPostingGrp: Record "Gen. Business Posting Group";
        ItemCrossReference: Record "Item Reference";
        RMSetup: Record "Marketing Setup";
        ServiceItem: Record "Service Item";
        NoSeriesMgt: Codeunit "No. Series";
        MoveEntries: Codeunit MoveEntries;
        UpdateContFromVend: Codeunit "VendCont-Update";
        DimMgt: Codeunit DimensionManagement;
        InsertFromContact: Boolean;
        AccountTypes: Record "Account Types-Saving Products";
        FDType: Record "Fixed Deposit Type";
        ReplCharge: Decimal;
        Vends: Record Vendor;
        gnljnlLine: Record "Gen. Journal Line";
        FOSAAccount: Record Vendor;
        Member: Record Customer;
        Vend: Record Vendor;
        Loans: Record "Loans Register";
        StatusPermissions: Record "Status Change Permision";
        // interestCalc: Record "FD Interest Calculation Criter";
        Text004: label 'Contact %1 %2 is not related to vendor %3 %4.';
        Text005: label 'post';
        Text006: label 'create';
        Text007: label 'You cannot %1 this type of document when Vendor %2 is blocked with type %3';
        Text008: label 'The %1 %2 has been assigned to %3 %4.\The same %1 cannot be entered on more than one %3.';
        Text009: label 'Reconciling IC transactions may be difficult if you change IC Partner Code because this %1 has ledger entries in a fiscal year that has not yet been closed.\ Do you still want to change the IC Partner Code?';
        Text010: label 'You cannot change the contents of the %1 field because this %2 has one or more open ledger entries.';
        Text011: label 'Before you can use Online Map, you must fill in the Online Map Setup window.\See Setting Up Online Map in Help.';
        Text10000: label '%1 is not a valid RFC No.';
        Text10001: label '%1 is not a valid CURP No.';
        Text10002: label 'The RFC No. %1 is used by another company.';


    procedure AssistEdit(OldVend: Record Vendor): Boolean
    var
        Vend: Record Vendor;
    begin
        // Vend := Rec;
        // PurchSetup.Get;
        // PurchSetup.TestField("Vendor Nos.");
        // if NoSeriesMgt.SelectSeries(PurchSetup."Vendor Nos.", OldVend."No. Series", Vend."No. Series") then begin
        //     PurchSetup.Get;
        //     PurchSetup.TestField("Vendor Nos.");
        //     NoSeriesMgt.SetSeries(Vend."No.");
        //     Rec := Vend;
        //     exit(true);
        // end;
    end;

    local procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        DimMgt.SaveDefaultDim(Database::Vendor, "No.", FieldNumber, ShortcutDimCode);
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
        ContBusRel.SetRange("Link to Table", ContBusRel."link to table"::Vendor);
        ContBusRel.SetRange("No.", "No.");
        if not ContBusRel.FindFirst then begin
            if not Confirm(Text003, false, TableCaption, "No.") then
                exit;
            UpdateContFromVend.InsertNewContact(Rec, false);
            ContBusRel.FindFirst;
        end;
        Commit;

        Cont.SetCurrentkey("Company Name", "Company No.", Type, Name);
        Cont.SetRange("Company No.", ContBusRel."Contact No.");
        Page.Run(Page::"Contact List", Cont);
    end;


    procedure SetInsertFromContact(FromContact: Boolean)
    begin
        InsertFromContact := FromContact;
    end;


    procedure CheckBlockedVendOnDocs(Vend2: Record Vendor; Transaction: Boolean)
    begin
        if Vend2.Blocked = Vend2.Blocked::All then
            VendBlockedErrorMessage(Vend2, Transaction);
    end;


    procedure CheckBlockedVendOnJnls(Vend2: Record Vendor; DocType: Option " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund; Transaction: Boolean)
    begin
        if (Vend2.Blocked = Vend2.Blocked::All) or
   (Vend2.Blocked = Vend2.Blocked::Payment) and (DocType = Doctype::Payment)
then
            Vend2.VendBlockedErrorMessage(Vend2, Transaction);
    end;


    procedure CreateAndShowNewInvoice()
    var
        PurchaseHeader: Record "Purchase Header";
    begin
        PurchaseHeader."Document Type" := PurchaseHeader."document type"::Invoice;
        PurchaseHeader.SetRange("Buy-from Vendor No.", "No.");
        PurchaseHeader.Insert(true);
        Commit;
        // Page.RunModal(Page::"Mini Purchase Invoice",PurchaseHeader)
    end;


    procedure CreateAndShowNewCreditMemo()
    var
        PurchaseHeader: Record "Purchase Header";
    begin
        PurchaseHeader."Document Type" := PurchaseHeader."document type"::"Credit Memo";
        PurchaseHeader.SetRange("Buy-from Vendor No.", "No.");
        PurchaseHeader.Insert(true);
        Commit;
        //  Page.RunModal(Page::"Mini Purchase Credit Memo",PurchaseHeader)
    end;


    procedure VendBlockedErrorMessage(Vend2: Record Vendor; Transaction: Boolean)
    var
        "Action": Text[30];
    begin
        if Transaction then
            Action := Text005
        else
            Action := Text006;
        // For Divindends Export Comment this Error
        //ERROR(Text007,Action,Vend2."No.",Vend2.Blocked);
    end;


    procedure DisplayMap()
    var
        MapPoint: Record "Online Map Setup";
        MapMgt: Codeunit "Online Map Management";
    begin
        if MapPoint.FindFirst then
            MapMgt.MakeSelection(Database::Vendor, GetPosition)
        else
            Message(Text011);
    end;


    procedure CalcOverDueBalance() OverDueBalance: Decimal
    var
        [SecurityFiltering(Securityfilter::Filtered)]
        VendLedgEntryRemainAmtQuery: Query "Vend. Ledg. Entry Remain. Amt.";
    begin
        VendLedgEntryRemainAmtQuery.SetRange(Vendor_No, "No.");
        VendLedgEntryRemainAmtQuery.SetRange(IsOpen, true);
        VendLedgEntryRemainAmtQuery.SetFilter(Due_Date, '<%1', WorkDate);
        VendLedgEntryRemainAmtQuery.Open;

        if VendLedgEntryRemainAmtQuery.Read then
            OverDueBalance := VendLedgEntryRemainAmtQuery.Sum_Remaining_Amt_LCY;
    end;


    procedure ValidateRFCNo(Length: Integer)
    begin
        if StrLen("RFC No.") <> Length then
            Error(Text10000, "RFC No.");
    end;


    procedure GetInvoicedPrepmtAmountLCY(): Decimal
    var
        PurchLine: Record "Purchase Line";
    begin
        PurchLine.SetCurrentkey("Document Type", "Pay-to Vendor No.");
        PurchLine.SetRange("Document Type", PurchLine."document type"::Order);
        PurchLine.SetRange("Pay-to Vendor No.", "No.");
        PurchLine.CalcSums("Prepmt. Amount Inv. (LCY)", "Prepmt. VAT Amount Inv. (LCY)");
        exit(PurchLine."Prepmt. Amount Inv. (LCY)" + PurchLine."Prepmt. VAT Amount Inv. (LCY)");
    end;


    procedure GetTotalAmountLCY(): Decimal
    begin
        CalcFields(
          "Balance (LCY)", "Outstanding Orders (LCY)", "Amt. Rcd. Not Invoiced (LCY)", "Outstanding Invoices (LCY)");

        exit(
          "Balance (LCY)" + "Outstanding Orders (LCY)" +
          "Amt. Rcd. Not Invoiced (LCY)" + "Outstanding Invoices (LCY)" - GetInvoicedPrepmtAmountLCY);
    end;


}

