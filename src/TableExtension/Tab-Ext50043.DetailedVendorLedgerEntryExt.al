tableextension 50043 "DetailedVendorLedgerEntryExt" extends "Detailed Vendor Ledg. Entry"
{

    fields
    {
        field(50000; "Transaction Type Fosa"; Option)
        {
            Description = 'added to handle Fosa Shares';
            OptionCaption = ' ,Pepea Shares,School Fees Shares';
            OptionMembers = " ","Pepea Shares","School Fees Shares";
        }
        field(51516003; "Overdraft codes"; Option)
        {
            OptionCaption = ' ,Overdraft Granted,Overdraft Paid,Interest Accrued,Interest paid';
            OptionMembers = " ","Overdraft Granted","Overdraft Paid","Interest Accrued","Interest paid";
        }
        field(51516832; "Transaction Type"; Option)
        {
            OptionCaption = ' ,Registration Fee,Loan,Repayment,Withdrawal,Interest Due,Interest Paid,Benevolent Fund,Deposit Contribution,Penalty Charged,Application Fee,Appraisal Fee,Investment,Unallocated Funds,Shares Capital,Loan Adjustment,Dividend,Withholding Tax,Administration Fee,Insurance Contribution,Prepayment,Withdrawable Deposits,Xmas Contribution,Penalty Paid,Dev Shares,Co-op Shares,Welfare Contribution 2,Loan Penalty,Loan Guard,Lukenya,Konza,Juja,Housing Water,Housing Title,Housing Main,M Pesa Charge ,Insurance Charge,Insurance Paid,FOSA Account,Partial Disbursement,Loan Due,FOSA Shares,Loan Form Fee,PassBook Fee,Normal shares,SchFee Shares,Pepea Shares';
            OptionMembers = " ","Registration Fee",Loan,Repayment,Withdrawal,"Interest Due","Interest Paid","Benevolent Fund","Deposit Contribution","Penalty Charged","Application Fee","Appraisal Fee",Investment,"Unallocated Funds","Shares Capital","Loan Adjustment",Dividend,"Withholding Tax","Administration Fee","Insurance Contribution",Prepayment,"Withdrawable Deposits","Xmas Contribution","Penalty Paid","Dev Shares","Co-op Shares","Welfare Contribution 2","Loan Penalty","Loan Guard",Lukenya,Konza,Juja,"Housing Water","Housing Title","Housing Main","M Pesa Charge ","Insurance Charge","Insurance Paid","FOSA Account","Partial Disbursement","Loan Due","FOSA Shares","Loan Form Fee","PassBook Fee","Normal shares","SchFee Shares","Pepea Shares";
        }
        field(51516833; "Overdraft No"; Code[100])
        {
        }
        field(51516834; "Amount Posted"; Decimal)
        {
        }
        field(1004; Reversed; Boolean)
        {
        }
        field(1005; Descriptions; Text[250])
        {
            Caption = 'Description';//0101-001-68954
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = lookup("Vendor Ledger Entry".Description where("Document No." = field("Document No."), Amount = field(Amount), "Posting Date" = field("Posting Date"), "User ID" = field("User ID")));
        }
    }

    keys
    {

    }

    fieldgroups
    {

    }

    trigger OnInsert()
    var
        GenJnlPostPreview: Codeunit "Gen. Jnl.-Post Preview";
    begin
        "Amount Posted" := Amount;

        SetLedgerEntryAmount;
        // GenJnlPostPreview.SaveDtldVendLedgEntry(Rec);
    end;


    procedure UpdateDebitCredit(Correction: Boolean)
    begin
        if ((Amount > 0) or ("Amount (LCY)" > 0)) and not Correction or
           ((Amount < 0) or ("Amount (LCY)" < 0)) and Correction
        then begin
            "Debit Amount" := Amount;
            "Credit Amount" := 0;
            "Debit Amount (LCY)" := "Amount (LCY)";
            "Credit Amount (LCY)" := 0;
        end else begin
            "Debit Amount" := 0;
            "Credit Amount" := -Amount;
            "Debit Amount (LCY)" := 0;
            "Credit Amount (LCY)" := -"Amount (LCY)";
        end;
    end;


    procedure SetZeroTransNo(TransactionNo: Integer)
    var
        DtldVendLedgEntry: Record "Detailed Vendor Ledg. Entry";
        ApplicationNo: Integer;
    begin
        DtldVendLedgEntry.SetCurrentkey("Transaction No.");
        DtldVendLedgEntry.SetRange("Transaction No.", TransactionNo);
        if DtldVendLedgEntry.FindSet(true) then begin
            ApplicationNo := DtldVendLedgEntry."Entry No.";
            repeat
                DtldVendLedgEntry."Transaction No." := 0;
                DtldVendLedgEntry."Application No." := ApplicationNo;
                DtldVendLedgEntry.Modify;
            until DtldVendLedgEntry.Next = 0;
        end;
    end;

    local procedure SetLedgerEntryAmount()
    begin
        "Ledger Entry Amount" :=
          not (("Entry Type" = "entry type"::Application) or ("Entry Type" = "entry type"::"Appln. Rounding"));
    end;


    procedure GetUnrealizedGainLossAmount(EntryNo: Integer): Decimal
    begin
        SetCurrentkey("Vendor Ledger Entry No.", "Entry Type");
        SetRange("Vendor Ledger Entry No.", EntryNo);
        SetRange("Entry Type", "entry type"::"Unrealized Loss", "entry type"::"Unrealized Gain");
        CalcSums("Amount (LCY)");
        exit("Amount (LCY)");
    end;
}

