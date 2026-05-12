#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51000 "Payment Header"//by bc b4
{

    fields
    {
        field(10; "No."; Code[20])
        {
            Editable = false;
        }
        field(11; "Document Type"; Option)
        {
            Editable = false;
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund,Receipt';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund,Receipt;
        }
        field(12; "Document Date"; Date)
        {
            Editable = false;
        }
        field(13; "Posting Date"; Date)
        {
        }
        field(14; "Currency Code"; Code[10])
        {
            TableRelation = Currency;
        }
        field(15; "Currency Factor"; Decimal)
        {
        }
        field(16; Payee; Text[100])
        {
        }
        field(17; "On Behalf Of"; Text[100])
        {
        }
        field(18; "Payment Mode"; Option)
        {
            Editable = false;
            OptionCaption = ' ,Cash,Cheque,EFT,Letter of Credit,Mpesa,Custom 4,Custom 5';
            OptionMembers = " ",Cash,Cheque,EFT,"Letter of Credit","Mpesa","Custom 4","Custom 5";
        }
        field(19; Amount; Decimal)
        {
            CalcFormula = sum("Payment Line New".Amount where("Document No" = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(20; "Amount(LCY)"; Decimal)
        {
            CalcFormula = sum("Payment Line New"."Amount(LCY)" where("Document No" = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(21; "VAT Amount"; Decimal)
        {
            CalcFormula = sum("Payment Line New"."VAT Amount" where("Document No" = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(22; "VAT Amount(LCY)"; Decimal)
        {
            CalcFormula = sum("Payment Line New"."VAT Amount(LCY)" where("Document No" = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        // field(24; "Withholding Tax Code"; Code[20])
        // {
        //     TableRelation = if ("Account Type" = const(Vendor)) "Tariff Codes".Code where(Type = const("W/Tax"))
        //     else if ("Account Type" = const("G/L Account")) "Tariff Codes".Code where(Type = const("W/Tax"));

        //     trigger OnValidate()
        //     begin
        //         CalculateTax();
        //         ObjFundsTaxCodes.Reset;
        //         ObjFundsTaxCodes.SetRange(ObjFundsTaxCodes.Type, ObjFundsTaxCodes.Type::"W/Tax");
        //         if ObjFundsTaxCodes.Find('-') then begin
        //             "W/Tax Rate" := ObjFundsTaxCodes.Percentage;
        //             //"Withholding Tax Amount":=ROUND("W/Tax Rate"*0.01*"Net Amount",0.01,'=');
        //             "Withholding Tax Amount" := ROUND("W/Tax Rate" * 0.01 * Amount, 0.01, '=');
        //         end;
        //         Validate("Withholding Tax Amount");
        //     end;
        // }
        field(23; "WithHolding Tax Amount"; Decimal)
        {
            CalcFormula = sum("Payment Line New"."Withholding Tax Amount" where("Document No" = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(24; "WithHolding Tax Amount(LCY)"; Decimal)
        {
            CalcFormula = sum("Payment Line New"."W/TAX Amount(LCY)" where("Document No" = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(25; "Net Amount"; Decimal)
        {
            CalcFormula = sum("Payment Line New"."Net Amount" where("Document No" = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(26; "Net Amount(LCY)"; Decimal)
        {
            CalcFormula = sum("Payment Line New"."Net Amount(LCY)" where("Document No" = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(27; "Bank Account"; Code[20])
        {
            TableRelation = "Bank Account"."No.";
            trigger OnValidate()
            begin
                BankAccount.Reset;
                BankAccount.SetRange(BankAccount."No.", "Bank Account");
                if BankAccount.FindFirst then begin
                    "Bank Account Name" := BankAccount.Name;
                end;
            end;
        }
        field(28; "Bank Account Name"; Text[50])
        {
            Editable = false;
        }
        field(29; "Bank Account Balance"; Decimal)
        {
            CalcFormula = sum("Bank Account Ledger Entry".Amount where("Bank Account No." = field("Bank Account")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(30; "Cheque Type"; Option)
        {
            OptionCaption = 'Computer Cheque,Manual Cheque';
            OptionMembers = "Computer Cheque","Manual Cheque";
        }
        field(31; "Cheque No"; Code[25])
        {
        }
        field(32; "Payment Description"; Text[50])
        {
        }
        field(33; "Global Dimension 1 Code"; Code[10])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1),
                                                          "Dimension Value Type" = const(Standard));
        }
        field(34; "Global Dimension 2 Code"; Code[10])
        {
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2),
                                                          "Dimension Value Type" = const(Standard));
        }
        field(35; "Shortcut Dimension 3 Code"; Code[10])
        {
        }
        field(36; "Shortcut Dimension 4 Code"; Code[10])
        {
        }
        field(37; "Shortcut Dimension 5 Code"; Code[10])
        {
        }
        field(38; "Shortcut Dimension 6 Code"; Code[10])
        {
        }
        field(39; "Shortcut Dimension 7 Code"; Code[10])
        {
        }
        field(40; "Shortcut Dimension 8 Code"; Code[10])
        {
        }
        field(41; Status; Option)
        {
            Editable = false;
            OptionCaption = 'New,Pending Approval,Approved,Rejected,Posted,Cancelled';
            OptionMembers = New,"Pending Approval",Approved,Rejected,Posted,Cancelled;
        }
        field(42; Posted; Boolean)
        {
            Editable = false;
        }
        field(43; "Posted By"; Code[50])
        {
            Editable = false;
            TableRelation = "User Setup"."User ID";
        }
        field(44; "Date Posted"; Date)
        {
            Editable = false;
        }
        field(45; "Time Posted"; Time)
        {
            Editable = false;
        }
        field(46; Cashier; Code[100])
        {
            Editable = false;
            TableRelation = "User Setup"."User ID";
        }
        field(47; "No. Series"; Code[30])
        {
        }
        field(48; "Responsibility Center"; Code[50])
        {
            TableRelation = "Responsibility Center".Code;
        }
        field(49; "Retention Amount"; Decimal)
        {
            Editable = false;
        }
        field(50; "Retention Amount(LCY)"; Decimal)
        {
            Editable = false;
        }
        field(51; "User ID"; Code[70])
        {
        }
        field(52; "Payment Type"; Option)
        {
            Editable = false;
            OptionCaption = 'Normal,Petty Cash,Express,Cash Purchase,Mobile';
            OptionMembers = Normal,"Petty Cash",Express,"Cash Purchase",Mobile;
        }
        field(51516430; "Investor Payment"; Boolean)
        {
        }
        field(51516431; "Expense Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(51516432; "Total Payment Amount"; Decimal)
        {
            CalcFormula = sum("Payment Line New".Amount where("Document No" = field("No.")));
            Description = 'Stores the amount of the payment voucher';
            Editable = false;
            FieldClass = FlowField;
        }
        field(51516433; "Paying Type"; Option)
        {
            OptionCaption = ' ,Vendor,Bank';
            OptionMembers = " ",Vendor,Bank;
        }
        field(51516434; "Payments Type"; Option)
        {
            Editable = false;
            OptionCaption = 'Normal,Petty Cash,Delegates';
            OptionMembers = Normal,"Petty Cash",Delegates;
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
            if "Payment Type" = "payment type"::Normal then begin   //Cheque Payments
                Setup.Get;
                Setup.TestField(Setup."Payment Voucher Nos");
                // NoSeriesMgt.InitSeries(Setup."Payment Voucher Nos", xRec."No. Series", 0D, "No.", "No. Series");
            end;
            if "Payment Type" = "payment type"::"Cash Purchase" then begin       //Cash Payments
                Setup.Get;
                Setup.TestField(Setup."Cash Voucher Nos");
                //NoSeriesMgt.InitSeries(Setup."Cash Voucher Nos", xRec."No. Series", 0D, "No.", "No. Series");
            end;
            if "Payment Type" = "payment type"::"Petty Cash" then begin      //PettyCash Payments
                Setup.Get;
                Setup.TestField(Setup."PettyCash Nos");
                // NoSeriesMgt.InitSeries(Setup."PettyCash Nos", xRec."No. Series", 0D, "No.", "No. Series");
            end;
            if "Payment Type" = "payment type"::Mobile then begin        //Mobile Payments
                Setup.Get;
                Setup.TestField(Setup."Mobile Payment Nos");
                // NoSeriesMgt.InitSeries(Setup."Mobile Payment Nos", xRec."No. Series", 0D, "No.", "No. Series");
            end;

        end;
        "Document Type" := "document type"::Payment;
        "Document Date" := Today;
        "User ID" := UserId;
        Cashier := UserId;
    end;

    var
        Setup: Record "Funds General Setup";
        NoSeriesMgt: Codeunit "No. Series";
        BankAccount: Record "Bank Account";
}

