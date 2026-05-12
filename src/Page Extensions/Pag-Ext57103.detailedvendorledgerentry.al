pageextension 57103 "detailedvendorledgerentry" extends "Detailed Vendor Ledg. Entries"
{
    layout
    {
        addafter(Amount)
        {
            field("Amount Posted"; Rec."Amount Posted")
            {
                ApplicationArea = Basic;
            }
            field("Transaction Type"; Rec."Transaction Type")
            {
                ApplicationArea = Basic;
            }
            field(Descriptions; Rec.Descriptions)
            {
                ApplicationArea = Basic;
            }
            field("Running Balance"; GetVendorRunningBalance(Rec))
            {
                ApplicationArea = All;
                Caption = 'Running Balance';
                ToolTip = 'Shows the running vendor balance up to this entry.';
            }
            field(Reversed; IsReversed())
            {
                ApplicationArea = All;
                Caption = 'Is Reversed';
                Editable = false;
            }
        }

        modify("Entry Type")
        {
            Visible = false;
        }
        modify("Currency Code")
        {
            Visible = false;
        }
        modify("Initial Entry Due Date")
        {
            Visible = false;
        }
        modify("Document Type")
        {
            Visible = false;
        }
        modify("Amount (LCY)")
        {
            Visible = false;
        }

    }
    local procedure IsReversed(): Boolean
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

    local procedure GetVendorRunningBalance(var VendLedgEntry: Record "Detailed Vendor Ledg. Entry"): Decimal
    var
        VendLedgEntry2: Record "Detailed Vendor Ledg. Entry";
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

        // Calculate balance up to this entry
        VendLedgEntry2.Reset();
        VendLedgEntry2.SetRange("Vendor No.", VendLedgEntry."Vendor No.");
        VendLedgEntry2.SetFilter("Posting Date", '<=%1', VendLedgEntry."Posting Date");
        // VendLedgEntry2.SetFilter(Reversed, false);
        VendLedgEntry2.CalcSums("Amount (LCY)");
        DateTotal := VendLedgEntry2."Amount (LCY)";

        VendLedgEntry2.SetRange("Posting Date", VendLedgEntry."Posting Date");
        VendLedgEntry2.SetFilter("Entry No.", '>%1', VendLedgEntry."Entry No.");
        VendLedgEntry2.CalcSums("Amount (LCY)");

        RunningBalance := DateTotal - VendLedgEntry2."Amount (LCY)";

        VendorBalanceCache.Add(VendLedgEntry."Entry No.", RunningBalance);

        exit(RunningBalance);
    end;

    var
        CalcRunningAccBalance: Codeunit "System General Setup";
        VendorBalanceCache: Dictionary of [Integer, Decimal]; // Entry No. → Balance
        PrevVendorNo: Code[20];
}


