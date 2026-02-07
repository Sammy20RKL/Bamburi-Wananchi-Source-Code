#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50959 "Cheque Clearing Buffer"
{
    PageType = List;
    SourceTable = 51441;
    SourceTableView = where(Posted = filter(true));
    // Type = filter("Cheque Deposit"));

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                Editable = false;
                field(No; Rec.No)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Expected Maturity Date"; Rec."Expected Maturity Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Cashier; Rec.Cashier)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Amount Discounted"; Rec."Amount Discounted")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Cheque Type"; Rec."Cheque Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Cheque No"; Rec."Cheque No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Cheque Date"; Rec."Cheque Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Clear Cheque"; Rec."Clear Cheque")
                {
                    ApplicationArea = Basic;
                }
                field("Bounce Cheque"; Rec."Bounce Cheque")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    var
        GenJournalLine: Record "Gen. Journal Line";
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        Account: Record Vendor;
        AccountType: Record 51436;
        LineNo: Integer;
        ChequeType: Record 51446;
        DimensionV: Record "Dimension Value";
        ChargeAmount: Decimal;
        DiscountingAmount: Decimal;
        Loans: Record 51371;
        DActivity: Code[20];
        DBranch: Code[20];
        UsersID: Record User;
        Vend: Record Vendor;
        LoanType: Record 51381;
        BOSABank: Code[20];
        ReceiptAllocations: Record "Receipt Allocation";
        StatusPermissions: Record 51452;


    procedure PostBOSAEntries()
    var
        ReceiptAllocation: Record "Receipt Allocation";
    begin
        //BOSA Cash Book Entry
        if Rec."Account No" = '502-00-000300-00' then
            BOSABank := '13865'
        else if Rec."Account No" = '502-00-000303-00' then
            BOSABank := '070006';


        LineNo := LineNo + 10000;

        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := 'PURCHASES';
        GenJournalLine."Journal Batch Name" := 'FTRANS';
        GenJournalLine."Document No." := Rec.No;
        GenJournalLine."External Document No." := Rec."Cheque No";
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
        GenJournalLine."Account No." := BOSABank;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := Rec."Transaction Date";
        GenJournalLine.Description := Rec.Payee;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := Rec.Amount;
        GenJournalLine.Validate(GenJournalLine.Amount);
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;

        ReceiptAllocations.Reset;
        ReceiptAllocations.SetRange(ReceiptAllocations."Document No", Rec.No);
        if ReceiptAllocations.Find('-') then begin
            repeat

                LineNo := LineNo + 10000;

                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := 'PURCHASES';
                GenJournalLine."Journal Batch Name" := 'FTRANS';
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Document No." := Rec.No;
                GenJournalLine."External Document No." := Rec."Cheque No";
                GenJournalLine."Posting Date" := Rec."Transaction Date";
                if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Interest Paid" then begin
                    GenJournalLine."Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                    if Rec."Account No" = '502-00-000303-00' then
                        GenJournalLine."Account No." := '080023'
                    else
                        GenJournalLine."Account No." := '045003';
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine.Description := Rec.Payee;
                end else begin
                    GenJournalLine."Account Type" := GenJournalLine."bal. account type"::Customer;
                    GenJournalLine."Account No." := ReceiptAllocations."Member No";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine.Description := Format(ReceiptAllocations."Transaction Type");
                end;
                GenJournalLine.Amount := ReceiptAllocations.Amount;
                GenJournalLine.Validate(GenJournalLine.Amount);
                if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Deposit Contribution" then
                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Benevolent Fund"
                else if ReceiptAllocations."Transaction Type" = ReceiptAllocations."Transaction Type"::"Share Capital" then
                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Loan
                else if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Benevolent Fund" then
                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Insurance Paid"
                else if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Registration Fee" then
                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid"
                else if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Loan Repayment" then
                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Registration Fee";
                GenJournalLine."Loan No" := ReceiptAllocations."Loan No.";
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;

                if (ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Registration Fee") and
                   (ReceiptAllocations."Interest Amount" > 0) then begin
                    LineNo := LineNo + 10000;

                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'PURCHASES';
                    GenJournalLine."Journal Batch Name" := 'FTRANS';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Document No." := Rec.No;
                    GenJournalLine."External Document No." := Rec."Cheque No";
                    GenJournalLine."Posting Date" := Rec."Transaction Date";
                    GenJournalLine."Account Type" := GenJournalLine."bal. account type"::Customer;
                    GenJournalLine."Account No." := ReceiptAllocations."Member No";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine.Description := 'Interest Paid';
                    GenJournalLine.Amount := ReceiptAllocations."Interest Amount";
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Insurance Contribution";
                    GenJournalLine."Loan No" := ReceiptAllocations."Loan No.";
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;

                end;

            until ReceiptAllocations.Next = 0;
        end;
    end;
}

