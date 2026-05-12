#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51113 "Payment Line"//used before by BC. shifted to NAV for Sitting Allowance Member Board
{

    fields
    {
        field(1; No; Code[20])
        {
        }
        field(2; "Member No"; Code[20])
        {
            NotBlank = true;
            TableRelation = Customer."No.";
        }
        field(3; "Interest Amount"; Decimal)
        {

            trigger OnValidate()
            begin
                if Loans.Get("Loan No.") then begin
                    Loans.CalcFields(Loans."Oustanding Interest");
                    if "Interest Amount" > Loans."Oustanding Interest" then
                        Error('Interest Repayment cannot be more than the loan oustanding balance.');
                end;


                "Total Amount" := Amount + "Interest Amount";

            end;
        }
        field(6; "Interest Balance"; Decimal)
        {
        }
        field(7; "Total Amount"; Decimal)
        {
            Editable = false;
        }
        field(8; "Amount Balance"; Decimal)
        {
        }
        field(10; "Line No"; Integer)
        {
            AutoIncrement = true;
            MinValue = 1000;
        }
        field(11; "Document No"; Code[20])
        {
            Editable = false;
            NotBlank = true;
            TableRelation = "Payments Header"."No.";
        }
        field(12; "Document Type"; Option)
        {
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund,Receipt';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund,Receipt;
        }
        field(13; "Currency Code"; Code[10])
        {
            TableRelation = Currency;
        }
        field(14; "Currency Factor"; Decimal)
        {
        }
        field(15; "Payment Type"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Funds Transaction Types"."Transaction Code" where("Transaction Type" = const(Payment));

            trigger OnValidate()
            begin
                FundsTypes.Reset;
                FundsTypes.SetRange(FundsTypes."Transaction Code", "Payment Type");
                if FundsTypes.FindFirst then begin
                    "Default Grouping" := FundsTypes."Default Grouping";
                    "Account Type" := FundsTypes."Account Type";
                    "Account No." := FundsTypes."Account No";
                    "Transaction Type Description" := FundsTypes."Transaction Description";
                    "Payment Description" := FundsTypes."Transaction Description";
                    if FundsTypes."VAT Chargeable" then
                        "VAT Code" := FundsTypes."VAT Code";
                    if FundsTypes."Withholding Tax Chargeable" then
                        "W/TAX Code" := FundsTypes."Withholding Tax Code";
                end;
                PHeader.Reset;
                PHeader.SetRange(PHeader."No.", "Document No");
                if PHeader.FindFirst then begin
                    "Global Dimension 1 Code" := PHeader."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := PHeader."Global Dimension 2 Code";
                    "Shortcut Dimension 3 Code" := PHeader."Shortcut Dimension 3 Code";
                    "Shortcut Dimension 4 Code" := PHeader."Shortcut Dimension 4 Code";
                    "Shortcut Dimension 5 Code" := PHeader."Shortcut Dimension 5 Code";
                    "Shortcut Dimension 6 Code" := PHeader."Shortcut Dimension 6 Code";
                    "Shortcut Dimension 7 Code" := PHeader."Shortcut Dimension 7 Code";
                    "Shortcut Dimension 8 Code" := PHeader."Shortcut Dimension 8 Code";

                    "Responsibility Center" := PHeader."Responsibility Center";
                    //"Pay Mode":=
                    "Currency Code" := PHeader."Currency Code";
                    "Currency Factor" := PHeader."Currency Factor";
                    //"Document Type":=
                end;

                Validate("Account Type");
            end;
        }
        field(16; "Account Type"; Enum "Gen. Journal Account Type")
        {
            Caption = 'Account Type';

            trigger OnValidate()
            begin
                Validate("Account No.");
            end;
        }
        field(17; "Account No."; Code[20])
        {
            Caption = 'Account No.';
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
            if ("Account Type" = const("IC Partner")) "IC Partner";

            trigger OnValidate()
            begin
                if "Account Type" = "account type"::"G/L Account" then begin
                    "G/L Account".Reset;
                    "G/L Account".SetRange("G/L Account"."No.", "Account No.");
                    if "G/L Account".FindFirst then begin
                        "Account Name" := "G/L Account".Name;
                    end;
                end;
                if "Account Type" = "account type"::Customer then begin
                    Customer.Reset;
                    Customer.SetRange(Customer."No.", "Account No.");
                    if Customer.FindFirst then begin
                        "Account Name" := Customer.Name;
                    end;
                end;
                if "Account Type" = "account type"::Vendor then begin
                    Vendor.Reset;
                    Vendor.SetRange(Vendor."No.", "Account No.");
                    if Vendor.FindFirst then begin
                        "Account Name" := Vendor.Name;
                    end;
                end;
                //    if "Account Type"="account type":: Investor then begin
                //       Investor.Reset;
                //       Investor.SetRange(Investor.Code,"Account No.");
                //       if Investor.FindFirst then begin
                //         "Account Name":=Investor.Description;
                //       end;
                //    end;

                if "Account No." = '' then
                    "Account Name" := '';
                if "Account Type" = "account type"::Customer then begin
                    Cust.Reset;
                    Cust.SetRange(Cust."No.", "Account No.");
                    if Cust.FindFirst then begin
                        "Account Name" := Cust.Name;
                    end;
                end;

                if "Account No." = '' then
                    "Account Name" := '';
            end;
        }
        field(18; "Account Name"; Text[50])
        {
            Editable = false;
        }
        field(19; "Transaction Type Description"; Text[50])
        {
        }
        field(20; "Payment Description"; Text[50])
        {
        }
        field(21; Amount; Decimal)
        {

            trigger OnValidate()
            begin

                if "Currency Code" <> '' then begin
                    "Amount(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", Amount, "Currency Factor"));
                end else begin
                    "Amount(LCY)" := Amount;
                end;

                Validate("VAT Code");
                Validate("W/TAX Code");
            end;
        }
        field(22; "Amount(LCY)"; Decimal)
        {
            Editable = false;
        }
        field(23; "VAT Code"; Code[20])
        {
            TableRelation = "Funds Tax Codes"."Tax Code" where(Type = const(VAT));

            trigger OnValidate()
            begin
                FundsTaxCodes.Reset;
                FundsTaxCodes.SetRange(FundsTaxCodes."Tax Code", "VAT Code");
                if FundsTaxCodes.FindFirst then begin
                    "VAT Amount" := Amount * (FundsTaxCodes.Percentage / 100);
                end;
                Validate("VAT Amount");
            end;
        }
        field(24; "VAT Amount"; Decimal)
        {
            Editable = false;

            trigger OnValidate()
            begin
                "Net Amount" := Amount - "VAT Amount";
                if "Currency Code" <> '' then begin
                    "VAT Amount(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", "VAT Amount", "Currency Factor"));
                    "Net Amount(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", "Net Amount", "Currency Factor"));
                end else begin
                    "VAT Amount(LCY)" := "VAT Amount";
                    "Net Amount(LCY)" := "Net Amount";
                end;
            end;
        }
        field(25; "VAT Amount(LCY)"; Decimal)
        {
            Editable = false;
        }
        field(26; "W/TAX Code"; Code[20])
        {
            TableRelation = "Funds Tax Codes"."Tax Code" where(Type = const("W/Tax"));
            //editable = false;

            trigger OnValidate()
            begin
                FundsTaxCodes.Reset;
                FundsTaxCodes.SetRange(FundsTaxCodes."Tax Code", "W/TAX Code");
                if FundsTaxCodes.FindFirst then begin
                    "W/TAX Amount" := Amount * (FundsTaxCodes.Percentage / 100);
                    "Account No." := "Member Type";
                    "Account Name" := "Board Member Name";
                end;
                Validate("W/TAX Amount");
            end;
        }
        field(27; "W/TAX Amount"; Decimal)
        {
            Editable = false;
            trigger OnValidate()
            begin
                "Net Amount" := Amount - "W/TAX Amount";
                if "Currency Code" <> '' then begin
                    "W/TAX Amount(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", "W/TAX Amount", "Currency Factor"));
                    "Net Amount(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", "Net Amount", "Currency Factor"));
                end else begin
                    "W/TAX Amount(LCY)" := "W/TAX Amount";
                    "Net Amount(LCY)" := "Net Amount";
                end;
            end;
        }
        field(28; "W/TAX Amount(LCY)"; Decimal)
        {
            Editable = false;
        }
        field(29; "Retention Code"; Code[20])
        {
            TableRelation = "Funds Tax Codes"."Tax Code" where(Type = const(Retention));
        }
        field(30; "Retention Amount"; Decimal)
        {
            Editable = false;
        }
        field(31; "Retention Amount(LCY)"; Decimal)
        {
            Editable = false;
        }
        field(32; "Net Amount"; Decimal)
        {
            Editable = false;
        }
        field(33; "Net Amount(LCY)"; Decimal)
        {
            Editable = false;
        }
        field(34; Committed; Boolean)
        {
        }
        field(35; "Vote Book"; Code[20])
        {
        }
        field(36; "Gen. Bus. Posting Group"; Code[20])
        {
        }
        field(37; "Gen. Prod. Posting Group"; Code[20])
        {
        }
        field(38; "VAT Bus. Posting Group"; Code[20])
        {
        }
        field(39; "VAT Prod. Posting Group"; Code[20])
        {
        }
        field(40; "Global Dimension 1 Code"; Code[10])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(41; "Global Dimension 2 Code"; Code[10])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(42; "Shortcut Dimension 3 Code"; Code[10])
        {
        }
        field(43; "Shortcut Dimension 4 Code"; Code[10])
        {
        }
        field(44; "Shortcut Dimension 5 Code"; Code[10])
        {
        }
        field(45; "Shortcut Dimension 6 Code"; Code[10])
        {
        }
        field(46; "Shortcut Dimension 7 Code"; Code[10])
        {
        }
        field(47; "Shortcut Dimension 8 Code"; Code[10])
        {
        }
        field(48; "Applies-to Doc. Type"; Option)
        {
            Caption = 'Applies-to Doc. Type';
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        }
        field(49; "Applies-to Doc. No."; Code[20])
        {
            Caption = 'Applies-to Doc. No.';

            trigger OnLookup()
            var
                VendLedgEntry: Record "Vendor Ledger Entry";
                PayToVendorNo: Code[20];
                OK: Boolean;
                Text000: label 'You must specify %1 or %2.';
            begin
            end;
        }
        field(50; "Applies-to ID"; Code[50])
        {
            Caption = 'Applies-to ID';

            trigger OnValidate()
            var
                TempVendLedgEntry: Record "Vendor Ledger Entry";
            begin
            end;
        }
        field(51; "VAT Withheld"; Code[20])
        {
        }
        field(52; "VAT Withheld Amount"; Decimal)
        {
            Editable = false;
        }
        field(53; "VAT Withheld Amount(LCY)"; Decimal)
        {
            Editable = false;
        }
        field(54; Status; Option)
        {
            Editable = false;
            OptionCaption = 'New,Pending Approval,Approved,Rejected,Posted';
            OptionMembers = New,"Pending Approval",Approved,Rejected,Posted;
        }
        field(55; Posted; Boolean)
        {
            Editable = false;
        }
        field(56; "Posted By"; Code[50])
        {
            Editable = false;
            TableRelation = "User Setup"."User ID";
        }
        field(57; "Date Posted"; Date)
        {
            Editable = false;
        }
        field(58; "Time Posted"; Time)
        {
            Editable = false;
        }
        field(59; "Default Grouping"; Code[50])
        {
            Editable = false;
        }
        field(60; "Responsibility Center"; Code[50])
        {
            Editable = false;
        }
        field(61; "Posting Date"; Date)
        {
        }
        field(62; Date; Date)
        {
        }
        field(50000; Names; Text[30])
        {
        }
        field(50004; "ID No."; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Loan No."; Code[20])
        {
            TableRelation = if ("Transaction Type" = const(Loan)) "Loans Register"."Loan  No." where("Client Code" = field("Account No."));
        }
        field(50002; "Transaction Type"; Option)
        {
            OptionCaption = ' ,Registration Fee,Loan,Repayment,Withdrawal,Interest Due,Interest Paid,Benevolent Fund,Deposit Contribution,Penalty Charged,Application Fee,Appraisal Fee,Investment,Unallocated Funds,Shares Capital,Loan Adjustment,Dividend,Withholding Tax,Administration Fee,Insurance Contribution,Prepayment,Withdrawable Deposits,Xmas Contribution,Penalty Paid,Dev Shares,Co-op Shares,Welfare Contribution 2,Loan Penalty,Loan Guard,Lukenya,Konza,Juja,Housing Water,Housing Title,Housing Main,M Pesa Charge ,Insurance Charge,Insurance Paid';
            OptionMembers = " ","Registration Fee",Loan,Repayment,Withdrawal,"Interest Due","Interest Paid","Benevolent Fund","Deposit Contribution","Penalty Charged","Application Fee","Appraisal Fee",Investment,"Unallocated Funds","Shares Capital","Loan Adjustment",Dividend,"Withholding Tax","Administration Fee","Insurance Contribution",Prepayment,"Withdrawable Deposits","Xmas Contribution","Penalty Paid","Dev Shares","Co-op Shares","Welfare Contribution 2","Loan Penalty","Loan Guard",Lukenya,Konza,Juja,"Housing Water","Housing Title","Housing Main","M Pesa Charge ","Insurance Charge","Insurance Paid";
        }
        field(50003; "Refund Charge"; Decimal)
        {
        }
        field(51516430; "Investor Interest Code"; Code[20])
        {
            //  TableRelation = if ("Account Type"=const(Investor)) "Investor Amounts"."Interest Code" where ("Investor No"=field("Account No."));
        }
        field(51516431; "Investment Date"; Date)
        {
            // TableRelation = if ("Account Type"=const(Investor)) "Investor Amounts"."Investment Date" where ("Investor No"=field("Account No."),
            //                                                                                                 "Interest Code"=field("Investor Interest Code"));

            trigger OnValidate()
            begin
                InvestorAmounts.Reset;
                InvestorAmounts.SetRange(InvestorAmounts."Investor No", "Account No.");
                InvestorAmounts.SetRange(InvestorAmounts."Interest Code", "Investor Interest Code");
                InvestorAmounts.SetRange(InvestorAmounts."Investment Date", "Investment Date");
                if InvestorAmounts.FindFirst then begin
                    InterestCodes.Reset;
                    InterestCodes.SetRange(InterestCodes.Code, InvestorAmounts."Interest Code");
                    if InterestCodes.FindFirst then begin
                        Amount := (InvestorAmounts.Amount) * (InterestCodes.Percentage / 100);
                        Validate(Amount);
                    end;
                end;
            end;
        }
        field(51516432; "Withholding Tax Code"; Code[20])
        {
            TableRelation = if ("Account Type" = const(Vendor)) "Tariff Codes"."Tax Code" where(Type = const("W/Tax"));

            trigger OnValidate()
            begin
                //CalculateTax();
            end;
        }
        field(50005; "Member Type"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No." where("Member Type" = filter(Board));

            trigger OnValidate()
            begin
                // Paymentline.RESET;
                // //Paymentline.SETRANGE(Paymentline.No,Paymentline."Document No");
                // Paymentline.SETRANGE(Paymentline."Member Type",Member."No.");
                // IF Paymentline.FIND('-') THEN BEGIN
                //  Paymentline."Board Member Name":=Member.Name;
                // Paymentline.MODIFY;
                // END;


                if Cust.Get("Member Type") then begin
                    "Board Member Name" := Cust.Name;
                    "ID No." := Cust."ID No.";
                end;

            end;
        }
        field(50006; "Board Member Name"; Text[100])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                // IF Paymentline.GET(Paymentline."Member Type") THEN
                //  "Board Member Name":=
            end;
        }
        field(50007; "Board Net Amount"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Amount Borad" := "Board Net Amount" / 0.65;
                Validate("Amount Borad");
            end;
        }
        field(50008; "Amount Borad"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Amount Borad" := "Board Net Amount" / 0.65;
            end;
        }
    }

    keys
    {
        key(Key1; "Line No", "Document No", "Payment Type")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Document Type" := "document type"::Payment;
    end;

    var
        FundsTypes: Record "Funds Transaction Types";
        PHeader: Record "Payments Header";
        "G/L Account": Record "G/L Account";
        Customer: Record Customer;
        Vendor: Record Vendor;
        Investor: Record "Profitability Set up-Micro";
        FundsTaxCodes: Record "Funds Tax Codes";
        CurrExchRate: Record "Currency Exchange Rate";
        Loans: Record "Loans Register";
        Cust: Record Customer;
        InvestorAmounts: Record "Investor Amounts";
        InterestCodes: Record "Interest Rates";
}

