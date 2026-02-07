Report 56890 "Wallet Account Statement"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Wallet Account Statement.rdlc';
    Caption = 'Account Statement';

    dataset
    {
        dataitem(Vendor; Vendor)
        {
            DataItemTableView = sorting("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Global Dimension 2 Filter", "Date Filter";
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(DebitTotalAmounts; DebitTotalAmounts)
            {
            }
            column(CreditTotalAmounts; CreditTotalAmounts)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(Company_Name; Company.Name)
            {
            }
            column(Company_Address; Company.Address)
            {
            }
            column(Company_Address_2; Company."Address 2")
            {
            }
            column(Company_Phone_No; Company."Phone No.")
            {
            }
            column(Company_Fax_No; Company."Fax No.")
            {
            }
            column(Company_Picture; Company.Picture)
            {
            }
            column(Company_Email; Company."E-Mail")
            {
            }
            column(STRSUBSTNO_Text000_VendDateFilter_; StrSubstNo(Text000, VendDateFilter))
            {
            }
            column(VendFilter; VendFilter)
            {
            }
            column(Vendor_Name; Name)
            {
            }
            column(Vendor__No__; "No.")
            {
            }
            column(Vendor_Vendor__Account_Type_; Vendor."Account Type")
            {
            }
            column(BOSA_Account_No; "BOSA Account No")
            {
            }
            column(CompanyNamee; CompanyNamee)
            {
            }
            column(StartBalanceLCY__1; StartBalanceLCY * -1)
            {
                AutoFormatType = 1;
            }
            column(StartBalAdjLCY; StartBalAdjLCY)
            {
                AutoFormatType = 1;
            }
            column(VendBalanceLCY__1; VendBalanceLCY * -1)
            {
                AutoFormatType = 1;
            }
            column(StartBalanceLCY__1_Control29; StartBalanceLCY * -1)
            {
                AutoFormatType = 1;
            }
            column(StartBalanceLCY___StartBalAdjLCY____Vendor_Ledger_Entry___Amount__LCY_____Correction___ApplicationRounding___1; (StartBalanceLCY + StartBalAdjLCY + "Vendor Ledger Entry"."Amount (LCY)" + Correction + ApplicationRounding) * -1)
            {
                AutoFormatType = 1;
            }
            column(Account_StatementCaption; Account_StatementCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(All_amounts_are_in_LCYCaption; All_amounts_are_in_LCYCaptionLbl)
            {
            }
            column(VendBalanceLCY__1_Control40Caption; VendBalanceLCY__1_Control40CaptionLbl)
            {
            }

            column(Account_No_Caption; Account_No_CaptionLbl)
            {
            }
            column(NamesCaption; NamesCaptionLbl)
            {
            }
            column(Account_TypeCaption; Account_TypeCaptionLbl)
            {
            }

            column(Staff_No_Caption; Staff_No_CaptionLbl)
            {
            }
            column(Total_BalanceCaption; Total_BalanceCaptionLbl)
            {
            }
            column(Total_Balance_Before_PeriodCaption; Total_Balance_Before_PeriodCaptionLbl)
            {
            }
            column(Available_BalanceCaption; Available_BalanceCaptionLbl)
            {
            }
            column(Vendor_Date_Filter; "Date Filter")
            {
            }
            column(Vendor_Global_Dimension_1_Filter; "Global Dimension 1 Filter")
            {
            }
            column(Vendor_Global_Dimension_2_Filter; "Global Dimension 2 Filter")
            {
            }
            dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
            {
                DataItemLink = "Vendor No." = field("No."), "Posting Date" = field("Date Filter"), "Date Filter" = field("Date Filter");
                DataItemTableView = sorting("Vendor No.", "Posting Date") where("Document No." = filter('<>TEST1234&<>2787236759750480&<>TEST123&<>3056123134233403&<>9686061335769758&<>5499023325101804'));
                column(StartBalanceLCY___StartBalAdjLCY____Amount__LCY_____1; (StartBalanceLCY + StartBalAdjLCY + "Amount (LCY)") * -1)
                {
                    AutoFormatType = 1;
                }
                column(Vendor_Ledger_Entry__Posting_Date_; "Vendor Ledger Entry"."Posting Date")
                {
                }
                column(Vendor_Ledger_Entry__Document_No__; "Vendor Ledger Entry"."Document No.")
                {
                }
                column(Vendor_Ledger_Entry_Description; "Vendor Ledger Entry".Description)
                {
                }
                column(VendAmount__1; VendAmount * -1)
                {
                    AutoFormatExpression = VendCurrencyCode;
                    AutoFormatType = 1;
                }

                column(VendCurrencyCode; VendCurrencyCode)
                {
                }
                column(Vendor_Ledger_Entry__Debit_Amount_; "Vendor Ledger Entry"."Debit Amount")
                {
                }
                column(Vendor_Ledger_Entry__Credit_Amount_; "Vendor Ledger Entry"."Credit Amount")
                {
                }
                column(Vendor_Ledger_Entry__External_Document_No__; "Vendor Ledger Entry"."External Document No.")
                {
                }
                column(StartBalanceLCY___StartBalAdjLCY____Amount__LCY_____1_Control53; (StartBalanceLCY + StartBalAdjLCY + "Amount (LCY)") * -1)
                {
                    AutoFormatType = 1;
                }
                column(ContinuedCaption; ContinuedCaptionLbl)
                {
                }
                column(ContinuedCaption_Control46; ContinuedCaption_Control46Lbl)
                {
                }
                column(Vendor_Ledger_Entry_Entry_No_; "Vendor Ledger Entry"."Entry No.")
                {
                }
                column(Vendor_Ledger_Entry_Vendor_No_; "Vendor Ledger Entry"."Vendor No.")
                {
                }
                column(Vendor_Ledger_Entry_Global_Dimension_1_Code; "Vendor Ledger Entry"."Global Dimension 1 Code")
                {
                }
                column(Vendor_Ledger_Entry_Global_Dimension_2_Code; "Vendor Ledger Entry"."Global Dimension 2 Code")
                {
                }
                column(Vendor_Ledger_Entry_Date_Filter; "Vendor Ledger Entry"."Date Filter")
                {
                }
                column(TotalDebits; TotalDebits)
                {
                }
                column(TotalCredits; TotalCredits)
                {
                }
                column(Totals; Totals)
                {
                }
                dataitem("Detailed Vendor Ledg. Entry"; "Detailed Vendor Ledg. Entry")
                {
                    DataItemLink = "Vendor Ledger Entry No." = field("Entry No.");
                    DataItemTableView = sorting("Vendor Ledger Entry No.", "Entry Type", "Posting Date") where("Entry Type" = const("Correction of Remaining Amount"));
                    column(ReportForNavId_2149; 2149)
                    {
                    }
                    column(VendBalanceLCY__1_Control40; VendBalanceLCY * -1)
                    {
                        AutoFormatType = 1;
                    }
                    column(Reversed; isReverseBool)
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        isReverseBool := false;
                        isReverseBool := IsReversed("Detailed Vendor Ledg. Entry");
                        Correction := Correction + "Amount (LCY)";
                        VendBalanceLCY := VendBalanceLCY + "Amount (LCY)";
                    end;

                    trigger OnPreDataItem()
                    begin
                        SetFilter("Posting Date", VendDateFilter);
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    TotalDebits := 0;
                    TotalCredits := 0;

                    isReverseBool := false;
                    isReverseBool := IsReversed("Detailed Vendor Ledg. Entry");
                    CalcFields(Amount, "Remaining Amount", "Amount (LCY)", "Remaining Amt. (LCY)");

                    VendLedgEntryExists := true;
                    if PrintAmountsInLCY then begin
                        VendAmount := "Amount (LCY)";
                        VendRemainAmount := "Remaining Amt. (LCY)";
                        VendCurrencyCode := '';
                    end else begin
                        VendAmount := Amount;
                        VendRemainAmount := "Remaining Amount";
                        VendCurrencyCode := "Currency Code";
                    end;
                    VendBalanceLCY := VendBalanceLCY + "Amount (LCY)";
                    if ("Document Type" = "document type"::Payment) or ("Document Type" = "document type"::Refund) then
                        VendEntryDueDate := 0D
                    else
                        VendEntryDueDate := "Due Date";
                    TotalDebits := "Vendor Ledger Entry"."Debit Amount";
                    Vendor.Get("Vendor Ledger Entry"."Vendor No.");
                    Totals := Vendor."Balance (LCY)";
                end;

                trigger OnPreDataItem()
                begin
                    VendLedgEntryExists := false;
                    CurrReport.CreateTotals(VendAmount, "Amount (LCY)");
                end;
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = sorting(Number) where(Number = const(1));
                column(ReportForNavId_5444; 5444)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if not VendLedgEntryExists and ((StartBalanceLCY = 0) or ExcludeBalanceOnly) then begin
                        StartBalanceLCY := 0;
                        CurrReport.Skip;
                    end;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                //Totals:=0;
                //..................................Get Credit Totals
                DebitTotalAmounts := 0;
                CreditTotalAmounts := 0;
                if VendTable.get(Vendor."No.") then begin
                    Vendor.CalcFields(Vendor."Total Debits", Vendor."Total Credits");
                    DebitTotalAmounts := (Vendor."Total Debits") * -1;
                    CreditTotalAmounts := (Vendor."Total Credits") * -1;
                end;
                //...................................................
                StartBalanceLCY := 0;
                StartBalAdjLCY := 0;
                if VendDateFilter <> '' then begin
                    if GetRangeMin("Date Filter") <> 0D then begin
                        SetRange("Date Filter", 0D, GetRangeMin("Date Filter") - 1);
                        CalcFields("Net Change (LCY)");
                        StartBalanceLCY := -"Net Change (LCY)";
                    end;
                    SetFilter("Date Filter", VendDateFilter);
                    CalcFields("Net Change (LCY)");
                    StartBalAdjLCY := -"Net Change (LCY)";
                    VendorLedgerEntry.SetCurrentkey("Vendor No.", "Posting Date");
                    VendorLedgerEntry.SetRange("Vendor No.", Vendor."No.");
                    VendorLedgerEntry.SetFilter("Posting Date", VendDateFilter);
                    if VendorLedgerEntry.Find('-') then
                        repeat
                            VendorLedgerEntry.SetFilter("Date Filter", VendDateFilter);
                            VendorLedgerEntry.CalcFields("Amount (LCY)");
                            StartBalAdjLCY := StartBalAdjLCY - VendorLedgerEntry."Amount (LCY)";
                            "Detailed Vendor Ledg. Entry".SetCurrentkey("Vendor Ledger Entry No.", "Entry Type", "Posting Date");
                            "Detailed Vendor Ledg. Entry".SetRange("Vendor Ledger Entry No.", VendorLedgerEntry."Entry No.");
                            "Detailed Vendor Ledg. Entry".SetFilter("Entry Type", '%1|%2',
                              "Detailed Vendor Ledg. Entry"."entry type"::"Correction of Remaining Amount",
                              "Detailed Vendor Ledg. Entry"."entry type"::"Appln. Rounding");
                            "Detailed Vendor Ledg. Entry".SetFilter("Posting Date", VendDateFilter);
                            if "Detailed Vendor Ledg. Entry".Find('-') then
                                repeat
                                    StartBalAdjLCY := StartBalAdjLCY - "Detailed Vendor Ledg. Entry"."Amount (LCY)";
                                until "Detailed Vendor Ledg. Entry".Next = 0;
                            "Detailed Vendor Ledg. Entry".Reset;
                        until VendorLedgerEntry.Next = 0;
                end;
                CurrReport.PrintonlyIfDetail := ExcludeBalanceOnly or (StartBalanceLCY = 0);
                VendBalanceLCY := StartBalanceLCY + StartBalAdjLCY;
                MinBal := 0;
                if AccType.Get(Vendor."Account Type") then
                    MinBal := AccType."Minimum Balance";
            end;

            trigger OnPostDataItem()
            begin
            end;

            trigger OnPreDataItem()
            begin
                CurrReport.NewPagePerRecord := PrintOnlyOnePerPage;
                CurrReport.CreateTotals("Vendor Ledger Entry"."Amount (LCY)", StartBalanceLCY, Correction, ApplicationRounding);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        Company.Reset;
        Company.Get();
        Company.CalcFields(Company.Picture);
        VendFilter := Vendor.GetFilters;
        VendDateFilter := Vendor.GetFilter("Date Filter");

        with "Vendor Ledger Entry" do
            if PrintAmountsInLCY then begin
                AmountCaption := FieldCaption("Amount (LCY)");
                RemainingAmtCaption := FieldCaption("Remaining Amt. (LCY)");
            end else begin
                AmountCaption := FieldCaption(Amount);
                RemainingAmtCaption := FieldCaption("Remaining Amount");
            end;
    end;

    var
        isReverseBool: Boolean;
        Text000: label 'Period: %1';
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        VendFilter: Text[250];
        VendDateFilter: Text[30];
        VendAmount: Decimal;
        VendRemainAmount: Decimal;
        VendBalanceLCY: Decimal;
        VendEntryDueDate: Date;
        StartBalanceLCY: Decimal;
        VendTable: Record Vendor;
        StartBalAdjLCY: Decimal;
        Correction: Decimal;
        ApplicationRounding: Decimal;
        ExcludeBalanceOnly: Boolean;
        PrintAmountsInLCY: Boolean;
        DebitTotalAmounts: Decimal;
        CreditTotalAmounts: Decimal;
        PrintOnlyOnePerPage: Boolean;
        VendLedgEntryExists: Boolean;
        AmountCaption: Text[30];
        RemainingAmtCaption: Text[30];
        VendCurrencyCode: Code[10];
        Company: Record "Company Information";
        AccType: Record "Account Types-Saving Products";
        MinBal: Decimal;
        Account_StatementCaptionLbl: label 'Account Statement';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        All_amounts_are_in_LCYCaptionLbl: label 'All amounts are in Ksh';
        VendBalanceLCY__1_Control40CaptionLbl: label 'Balance (LCY)';
        Account_No_CaptionLbl: label 'Account No.';
        NamesCaptionLbl: label 'Names';
        Account_TypeCaptionLbl: label 'Account Type';
        Staff_No_CaptionLbl: label 'Staff No.';
        Adj__of_Opening_BalanceCaptionLbl: label 'Adj. of Opening Balance';
        Total_BalanceCaptionLbl: label 'Total Balance';
        Total_Balance_Before_PeriodCaptionLbl: label 'Total Balance Before Period';
        Available_BalanceCaptionLbl: label 'Available Balance';
        ContinuedCaptionLbl: label 'Continued';
        ContinuedCaption_Control46Lbl: label 'Continued';
        UsersID: Record User;
        TotalDebits: Decimal;
        TotalCredits: Decimal;
        Totals: Decimal;
        CompanyNamee: Code[50];
        Cust: Record Customer;
        Employer: Record "Sacco Employers";

    local procedure IsReversed(Rec: record "Detailed Vendor Ledg. Entry"): Boolean
    var
        SearchDVLE: Record "Detailed Vendor Ledg. Entry";
        VendLedgEntry: Record "Vendor Ledger Entry"; // the VLE table
        DVLE: Record "Detailed Vendor Ledg. Entry";
    begin
        // Work on the current record
        DVLE := Rec;

        // 1) Try: lookup Vendor Ledger Entry linked to this DVLE and use its Reversed field.
        //    Replace "Vendor Ledger Entry No." with the correct linking field if different in your DB.
        if DVLE."Vendor Ledger Entry No." <> 0 then begin
            if VendLedgEntry.Get(DVLE."Vendor Ledger Entry No.") then
                exit(VendLedgEntry.Reversed);
        end;


        // 3) Heuristic: look for same vendor with exact opposite amount (and posted after)
        SearchDVLE.Reset();
        SearchDVLE.SetRange("Vendor No.", DVLE."Vendor No.");
        // If your amount field is "Amount (LCY)" or "Amount", adapt the field name.
        SearchDVLE.SetRange("Amount", -DVLE."Amount");
        if SearchDVLE.FindFirst() then
            exit(true);

        exit(false);
    end;

}

