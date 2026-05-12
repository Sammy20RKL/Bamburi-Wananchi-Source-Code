pageextension 57104 "vendorledgerentry" extends "Vendor Ledger Entries"
{
    layout
    {
        addafter(Amount)
        {
            field("CreditAmount"; Rec."Credit Amount")
            {
                ApplicationArea = Basic;
                Caption = 'Credit Amount';
            }
            field("DebitAmount"; Rec."Debit Amount")
            {
                ApplicationArea = Basic;
                Caption = 'Debit Amount';
            }
            field("Running Balance"; GetVendorRunningBalance(Rec))
            {
                ApplicationArea = All;
                Caption = 'Running Balance';
                ToolTip = 'Shows the running vendor balance up to this entry.';
            }
            field(ReversedN; Rec.Reversed)
            {
                ApplicationArea = Basic;
            }
            field("UserID"; Rec."User ID")
            {
                ApplicationArea = Basic;
                Caption = 'User ID';
            }
        }
        modify("Payment Method Code")
        {
            Visible = false;
        }
        modify("Currency Code")
        {
            Visible = false;
        }
        modify("Payment Reference")
        {
            Visible = false;
        }
        modify("Document Type")
        {
            Visible = false;
        }
        modify("Creditor No.")
        {
            Visible = false;
        }
        modify("Remaining Amount")
        {
            Visible = false;
        }
        modify("Remaining Amt. (LCY)")
        {
            Visible = false;
        }
        modify("Due Date")
        {
            Visible = false;
        }
        modify("Pmt. Disc. Tolerance Date")
        {
            Visible = false;
        }
        modify("Pmt. Discount Date")
        {
            Visible = false;
        }
        modify("Original Pmt. Disc. Possible")
        {
            Visible = false;
        }
        modify("Remaining Pmt. Disc. Possible")
        {
            Visible = false;
        }
        modify("Max. Payment Tolerance")
        {
            Visible = false;
        }
        modify(Open)
        {
            Visible = false;
        }
        modify("On Hold")
        {
            Visible = false;
        }
        modify("Exported to Payment File")
        {
            Visible = false;
        }
        modify(RecipientBankAcc)
        {
            Visible = false;
        }
        modify("Remit-to Code")
        {
            Visible = false;
        }

    }
    trigger OnOpenPage()
    begin
        CurrPage.Editable := false;
    end;

    local procedure GetVendorRunningBalance(var VendLedgEntry: Record "Vendor Ledger Entry"): Decimal
    var
        VendLedgEntry2: Record "Vendor Ledger Entry";
        RunningBalance: Decimal;
        DateTotal: Decimal;
    begin
        // Reset cache if vendor changes
        if PrevVendorNo <> VendLedgEntry."Vendor No." then begin
            Clear(VendorBalanceCache);
            PrevVendorNo := VendLedgEntry."Vendor No.";
        end;

        if VendorBalanceCache.Get(VendLedgEntry."Entry No.", RunningBalance) then
            exit(RunningBalance);

        // Calculate balance up to this entry (Remaining Amount)
        DateTotal := 0;
        VendLedgEntry2.Reset();
        VendLedgEntry2.SetRange("Vendor No.", VendLedgEntry."Vendor No.");
        VendLedgEntry2.SetFilter("Posting Date", '<=%1', VendLedgEntry."Posting Date");
        if VendLedgEntry2.FindSet() then
            repeat
                VendLedgEntry2.CalcFields("Remaining Amount");
                DateTotal += VendLedgEntry2."Remaining Amount";
            until VendLedgEntry2.Next() = 0;

        // Exclude later entries on same date with higher entry no.
        VendLedgEntry2.Reset();
        VendLedgEntry2.SetRange("Vendor No.", VendLedgEntry."Vendor No.");
        VendLedgEntry2.SetRange("Posting Date", VendLedgEntry."Posting Date");
        VendLedgEntry2.SetFilter("Entry No.", '>%1', VendLedgEntry."Entry No.");
        if VendLedgEntry2.FindSet() then
            repeat
                VendLedgEntry2.CalcFields("Remaining Amount");
                DateTotal -= VendLedgEntry2."Remaining Amount";
            until VendLedgEntry2.Next() = 0;

        RunningBalance := DateTotal;

        VendorBalanceCache.Add(VendLedgEntry."Entry No.", RunningBalance);

        exit(RunningBalance);
    end;

    var

        VendorBalanceCache: Dictionary of [Integer, Decimal]; // Entry No. → Balance
        PrevVendorNo: Code[20];
}


