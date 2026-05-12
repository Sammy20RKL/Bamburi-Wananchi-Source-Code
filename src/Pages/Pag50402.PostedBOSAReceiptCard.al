#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50402 "Posted BOSA Receipt Card"
{
    DeleteAllowed = true;
    Editable = true;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Receipts & Payments";
    SourceTableView = where(Posted = filter(true));

    layout
    {
        area(content)
        {
            group(Transaction)
            {
                Caption = 'Transaction';
                field("Transaction No."; Rec."Transaction No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = Basic;
                }
                field(Source; Rec.Source)
                {
                    ApplicationArea = Basic;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Receipt Mode"; Rec."Receipt Mode")
                {
                    ApplicationArea = Basic;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic;
                }
                field("Allocated Amount"; Rec."Allocated Amount")
                {
                    ApplicationArea = Basic;
                    DrillDownPageID = "Receipt Allocation(Posted)";
                    Importance = Promoted;
                    LookupPageID = "Receipt Allocation(Posted)";
                }
                field("Un allocated Amount"; Rec."Un allocated Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Employer No."; Rec."Employer No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Teller Till / Bank  No.';
                }
                field("Cheque No."; Rec."Cheque No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cheque / Slip  No.';
                }
                field("Cheque Date"; Rec."Cheque Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cheque / Slip  Date';
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Transaction Time"; Rec."Transaction Time")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
            }
            // part("Receipt Allocation"; "Posted Receipt Allocation-BOSA")
            // {
            //     ApplicationArea = all;
            //     SubPageLink = "Member No" = field("Account No."), "Transaction No." = field("Transaction No.");
            // }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Suggest)
            {
                Caption = 'Suggest';
                action("Cash/Cheque Clearance")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cash/Cheque Clearance';
                    visible = false;

                    trigger OnAction()
                    begin
                        Cheque := false;
                        //SuggestBOSAEntries();
                    end;
                }
                separator(Action1102760032)
                {
                }
                action("Suggest Payments")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                    Caption = 'Suggest Monthy Repayments';

                    trigger OnAction()
                    begin

                        Rec.TestField(Posted, false);
                        Rec.TestField("Account No.");
                        Rec.TestField(Amount);
                        //Cust.CALCFIELDS(Cust."Registration Fee Paid");

                        ReceiptAllocations.Reset;
                        ReceiptAllocations.SetRange(ReceiptAllocations."Document No", Rec."Transaction No.");
                        ReceiptAllocations.DeleteAll;


                        if Rec."Account Type" = Rec."account type"::Customer then begin

                            BosaSetUp.Get();
                            RunBal := Rec.Amount;

                            if RunBal > 0 then begin

                                if Cust.Get(Rec."Account No.") then begin
                                    Cust.CalcFields(Cust."Registration Fee Paid");
                                    if Cust."Registration Fee Paid" = 0 then begin
                                        if Cust."Registration Date" > 20140103D then begin
                                            ReceiptAllocations.Init;
                                            ReceiptAllocations."Document No" := Rec."Transaction No.";
                                            ReceiptAllocations."Member No" := Rec."Account No.";
                                            ReceiptAllocations."Transaction Type" := ReceiptAllocations."transaction type"::"Registration Fee";
                                            ReceiptAllocations."Loan No." := '';
                                            ReceiptAllocations.Amount := BosaSetUp."Registration Fee";
                                            //ReceiptAllocations."Interest Amount":=Loans."Interest Due";
                                            ReceiptAllocations."Total Amount" := ReceiptAllocations.Amount;
                                            ReceiptAllocations."Global Dimension 1 Code" := 'BOSA';
                                            ReceiptAllocations."Global Dimension 2 Code" := 'NAIROBI';
                                            ReceiptAllocations.Insert;
                                            RunBal := RunBal - ReceiptAllocations.Amount;
                                        end;
                                    end;
                                end;
                                //********** Mpesa Charges
                                if Rec."Receipt Mode" = Rec."receipt mode"::Mpesa then begin
                                    ReceiptAllocations.Init;
                                    ReceiptAllocations."Document No" := Rec."Transaction No.";
                                    ReceiptAllocations."Member No" := Rec."Account No.";
                                    ReceiptAllocations."Transaction Type" := ReceiptAllocations."transaction type"::" ";
                                    ReceiptAllocations."Loan No." := '';

                                    // M Pesa Tarriff

                                    if Rec.Amount <= 2499 then
                                        ReceiptAllocations."Total Amount" := 55
                                    else
                                        if Rec.Amount <= 4999 then
                                            ReceiptAllocations."Total Amount" := 75
                                        else
                                            if Rec.Amount <= 9999 then
                                                ReceiptAllocations."Total Amount" := 105
                                            else
                                                if Rec.Amount <= 19999 then
                                                    ReceiptAllocations."Total Amount" := 130
                                                else
                                                    if Rec.Amount <= 34999 then
                                                        ReceiptAllocations."Total Amount" := 185
                                                    else
                                                        if Rec.Amount <= 49999 then
                                                            ReceiptAllocations."Total Amount" := 220
                                                        else
                                                            if Rec.Amount <= 70000 then
                                                                ReceiptAllocations."Total Amount" := 240
                                                            else
                                                                if Rec.Amount > 70000 then
                                                                    Error('Sorry the Maximum M - Pesa transaction Amount is Ksha. 70,000');


                                    ReceiptAllocations.Amount := ReceiptAllocations."Total Amount";
                                    ReceiptAllocations."Global Dimension 1 Code" := 'BOSA';
                                    ReceiptAllocations."Global Dimension 2 Code" := 'NAIROBI';
                                    ReceiptAllocations.Insert;
                                end;
                                //********** END Mpesa Charges

                                if RunBal > 0 then begin
                                    //Loan Repayments
                                    Loans.Reset;
                                    Loans.SetCurrentkey(Loans.Source, Loans."Client Code");
                                    Loans.SetRange(Loans."Client Code", Rec."Account No.");
                                    Loans.SetRange(Loans.Source, Loans.Source::BOSA);
                                    if Loans.Find('-') then begin
                                        repeat

                                            //Insurance Charge
                                            Loans.CalcFields(Loans."Outstanding Balance", Loans."Interest Due", Loans."Loans Insurance", Loans."Oustanding Interest");
                                            if (Loans."Outstanding Balance" > 0) and (Loans."Approved Amount" > 100000) and
                                            (Loans."Loans Insurance" > 0) then begin



                                                ReceiptAllocations.Init;
                                                ReceiptAllocations."Document No" := Rec."Transaction No.";
                                                ReceiptAllocations."Member No" := Rec."Account No.";
                                                // ReceiptAllocations."Transaction Type" := ReceiptAllocations."transaction type"::"Loan Insurance Paid";
                                                ReceiptAllocations."Loan No." := Loans."Loan  No.";
                                                ReceiptAllocations."Loan ID" := Loans."Loan Product Type";
                                                ReceiptAllocations.Amount := Loans."Loans Insurance";
                                                //MESSAGE('ReceiptAllocations.Amount is %1',ReceiptAllocations.Amount);
                                                ReceiptAllocations."Amount Balance" := Loans."Outstanding Balance";
                                                ReceiptAllocations."Total Amount" := ReceiptAllocations.Amount;
                                                ReceiptAllocations."Global Dimension 1 Code" := 'BOSA';
                                                ReceiptAllocations."Global Dimension 2 Code" := 'NAIROBI';
                                                ReceiptAllocations.Insert;
                                            end;


                                            if (Loans."Outstanding Balance") > 0 then begin
                                                LOustanding := 0;
                                                ReceiptAllocations.Init;
                                                ReceiptAllocations."Document No" := Rec."Transaction No.";
                                                ReceiptAllocations."Member No" := Rec."Account No.";
                                                ReceiptAllocations."Transaction Type" := ReceiptAllocations."transaction type"::"Interest Paid";
                                                ReceiptAllocations."Loan No." := Loans."Loan  No.";
                                                ReceiptAllocations."Loan ID" := Loans."Loan Product Type";
                                                //ReceiptAllocations.Amount:=Loans.Repayment-Loans."Loans Insurance"-Loans."Oustanding Interest";
                                                ReceiptAllocations.Amount := Loans."Loan Principle Repayment";
                                                ReceiptAllocations."Amount Balance" := Loans."Outstanding Balance";
                                                ReceiptAllocations."Total Amount" := ReceiptAllocations.Amount + ReceiptAllocations."Interest Amount";
                                                ReceiptAllocations."Global Dimension 1 Code" := 'BOSA';
                                                ReceiptAllocations."Global Dimension 2 Code" := 'NAIROBI';
                                                ReceiptAllocations.Insert;
                                            end;

                                            if (Loans."Oustanding Interest" > 0) then begin
                                                ReceiptAllocations.Init;
                                                ReceiptAllocations."Document No" := Rec."Transaction No.";
                                                ReceiptAllocations."Member No" := Rec."Account No.";
                                                //  ReceiptAllocations."Transaction Type" := ReceiptAllocations."transaction type"::"Insurance Contribution";
                                                ReceiptAllocations."Loan No." := Loans."Loan  No.";
                                                ReceiptAllocations.Amount := Loans."Oustanding Interest";
                                                //ReceiptAllocations.Amount:=Loans."Loan Interest Repayment";
                                                //ReceiptAllocations.Amount:=Loans."Interest Due";
                                                ReceiptAllocations."Total Amount" := ReceiptAllocations.Amount + ReceiptAllocations."Interest Amount";
                                                ReceiptAllocations."Global Dimension 1 Code" := 'BOSA';
                                                ReceiptAllocations."Global Dimension 2 Code" := 'NAIROBI';
                                                ReceiptAllocations.Insert;
                                            end;

                                            RunBal := RunBal - ReceiptAllocations.Amount;
                                            Message('RunBal is %1', RunBal);

                                        until Loans.Next = 0;
                                    end;
                                end;
                            end;
                            BosaSetUp.Get();
                            ReceiptAllocations.Init;
                            ReceiptAllocations."Document No" := Rec."Transaction No.";
                            ReceiptAllocations."Member No" := Rec."Account No.";
                            ReceiptAllocations."Transaction Type" := ReceiptAllocations."transaction type"::"Benevolent Fund";
                            ReceiptAllocations."Loan No." := ' ';
                            ReceiptAllocations.Amount := BosaSetUp."Welfare Contribution";
                            ReceiptAllocations."Total Amount" := ReceiptAllocations.Amount;
                            ReceiptAllocations."Global Dimension 1 Code" := 'BOSA';
                            ReceiptAllocations."Global Dimension 2 Code" := 'NAIROBI';
                            ReceiptAllocations.Insert;

                            //Deposits Contribution
                            if Cust.Get(Rec."Account No.") then begin
                                if Cust."Monthly Contribution" > 0 then begin
                                    ReceiptAllocations.Init;
                                    ReceiptAllocations."Document No" := Rec."Transaction No.";
                                    ReceiptAllocations."Member No" := Rec."Account No.";
                                    ReceiptAllocations."Transaction Type" := ReceiptAllocations."transaction type"::Loan;
                                    ReceiptAllocations."Loan No." := '';
                                    ReceiptAllocations.Amount := ROUND(Cust."Monthly Contribution", 0.01);
                                    ;
                                    ReceiptAllocations."Total Amount" := ReceiptAllocations.Amount;
                                    ReceiptAllocations."Global Dimension 1 Code" := 'BOSA';
                                    ReceiptAllocations."Global Dimension 2 Code" := 'NAIROBI';
                                    ReceiptAllocations.Insert;
                                end;
                            end;

                            //Shares Contribution
                            if Cust.Get(Rec."Account No.") then begin
                                Cust.CalcFields(Cust."Shares Retained");

                                if Cust."Shares Retained" < 5000 then begin
                                    BosaSetUp.Get();
                                    if BosaSetUp."Monthly Share Contributions" > 0 then begin
                                        //IF CONFIRM('This member has reached a maximum share contribution of Kshs. 5,000/=. Do you want to post this transaction as shares contribution?',TRUE)=TRUE THEN
                                        //IF CONFIRM(Text001,TRUE) THEN BEGIN
                                        // ReceiptAllocations.Init;
                                        // ReceiptAllocations."Document No" := "Transaction No.";
                                        // ReceiptAllocations."Member No" := "Account No.";
                                        // ReceiptAllocations."Transaction Type" := ReceiptAllocations."transaction type"::"Recovery Account";
                                        // ReceiptAllocations."Loan No." := '';
                                        // ReceiptAllocations.Amount := ROUND(BosaSetUp."Monthly Share Contributions", 0.01);
                                        // ReceiptAllocations."Total Amount" := ReceiptAllocations.Amount;
                                        // ReceiptAllocations."Global Dimension 1 Code" := 'BOSA';
                                        // ReceiptAllocations."Global Dimension 2 Code" := 'NAIROBI';
                                        // ReceiptAllocations.Insert;
                                    end;
                                end;
                            end;
                        end;

                        if Rec."Account Type" = Rec."account type"::Vendor then begin
                            if Rec."Receipt Mode" = Rec."receipt mode"::Mpesa then begin
                                ReceiptAllocations.Init;
                                ReceiptAllocations."Document No" := Rec."Transaction No.";
                                ReceiptAllocations."Member No" := Rec."Account No.";

                                ReceiptAllocations."Transaction Type" := ReceiptAllocations."transaction type"::" ";
                                ReceiptAllocations."Total Amount" := Rec.Amount;
                                ReceiptAllocations."Loan No." := '';


                                // M Pesa Tarriff
                                MpesaCharge := 0;
                                if Rec.Amount <= 2499 then
                                    ReceiptAllocations."Total Amount" := 55
                                else
                                    if Rec.Amount <= 4999 then
                                        ReceiptAllocations."Total Amount" := 75
                                    else
                                        if Rec.Amount <= 9999 then
                                            ReceiptAllocations."Total Amount" := 105
                                        else
                                            if Rec.Amount <= 19999 then
                                                ReceiptAllocations."Total Amount" := 130
                                            else
                                                if Rec.Amount <= 34999 then
                                                    ReceiptAllocations."Total Amount" := 185
                                                else
                                                    if Rec.Amount <= 49999 then
                                                        ReceiptAllocations."Total Amount" := 220
                                                    else
                                                        if Rec.Amount <= 70000 then
                                                            ReceiptAllocations."Total Amount" := 240
                                                        else
                                                            if Rec.Amount > 70000 then
                                                                Error('Sorry the Maximum M - Pesa transaction Amount is Ksha. 70,000');
                                MpesaCharge := ReceiptAllocations."Total Amount";
                                ReceiptAllocations.Amount := ReceiptAllocations."Total Amount";

                                //ReceiptAllocations."Total Amount":=Amount;
                                ReceiptAllocations."Global Dimension 1 Code" := 'BOSA';
                                ReceiptAllocations."Global Dimension 2 Code" := 'NAIROBI';
                                ReceiptAllocations.Insert;
                            end;

                            //********** END Mpesa Charges


                            ReceiptAllocations.Init;
                            ReceiptAllocations."Document No" := Rec."Transaction No.";
                            ReceiptAllocations."Member No" := Rec."Account No.";
                            ReceiptAllocations."Transaction Type" := ReceiptAllocations."transaction type"::" ";
                            ;
                            ;
                            ;
                            ;
                            ;
                            //GenJournalLine.Description:= 'BT'+'-'+Remarks+'-'+FORMAT("Mode of Payment")+'-'+"Cheque No.";
                            ReceiptAllocations."Loan No." := ' ';
                            ReceiptAllocations."Total Amount" := Rec.Amount;
                            ReceiptAllocations."Global Dimension 1 Code" := 'FOSA';
                            ReceiptAllocations."Global Dimension 2 Code" := 'NAIROBI';
                            ReceiptAllocations.Amount := ReceiptAllocations."Total Amount";
                            ReceiptAllocations.Insert;



                        end;
                        //VALIDATE("Allocated Amount");
                        Rec.CalcFields("Allocated Amount");
                        Rec."Un allocated Amount" := (Rec.Amount - Rec."Allocated Amount");
                        Rec.Modify;
                    end;
                }
            }
        }
        area(processing)
        {
            action("Reprint Frecipt")
            {
                ApplicationArea = Basic;
                Caption = 'Reprint Receipt';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec.TestField(Posted);

                    BOSARcpt.Reset;
                    BOSARcpt.SetRange(BOSARcpt."Transaction No.", Rec."Transaction No.");
                    if BOSARcpt.Find('-') then
                        Report.Run(50247, true, true, BOSARcpt)
                end;
            }
        }
    }

    var
        Text001: label 'This member has reached a maximum share contribution of Kshs. 5,000/=. Do you want to post this transaction as shares contribution?';
        GenJournalLine: Record "Gen. Journal Line";
        InterestPaid: Decimal;
        PaymentAmount: Decimal;
        RunBal: Decimal;
        Recover: Boolean;
        Cheque: Boolean;
        ReceiptAllocations: Record "Receipt Allocation";
        Loans: Record "Loans Register";
        Commision: Decimal;
        LOustanding: Decimal;
        TotalCommision: Decimal;
        TotalOustanding: Decimal;
        Cust: Record Customer;
        BOSABank: Code[20];
        LineNo: Integer;
        BOSARcpt: Record "Receipts & Payments";
        TellerTill: Record "Bank Account";
        CurrentTellerAmount: Decimal;
        TransType: Text[30];
        RCPintdue: Decimal;
        BosaSetUp: Record "Sacco General Set-Up";
        MpesaCharge: Decimal;
        CustPostingGrp: Record "Customer Posting Group";
        MpesaAc: Code[30];
        GenSetup: Record "Sacco General Set-Up";

    local procedure AllocatedAmountOnDeactivate()
    begin
        CurrPage.Update := true;
    end;
}
