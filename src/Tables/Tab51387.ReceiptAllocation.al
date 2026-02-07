#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51387 "Receipt Allocation"
{

    DrillDownPageId = "Receipt Allocation-BOSA";
    LookupPageId = "Receipt Allocation-BOSA";

    fields
    {
        field(1; "Document No"; Code[20])
        {
            NotBlank = true;
        }
        field(2; "Member No"; Code[20])
        {
            NotBlank = true;
            TableRelation = Customer."No.";
        }
        field(3; "Transaction Type"; enum TransactionTypesEnum)
        {

            trigger OnValidate()
            begin
                "Loan No." := '';
                Amount := 0;
                // if "Transaction Type" = "transaction type"::"FOSA Account" then
                //     "Global Dimension 1 Code" := 'FOSA';

                if ("Transaction Type" <> "transaction type"::" ") then begin
                    "Account Type" := "account type"::Customer
                end else
                    "Account Type" := "account type"::Vendor;

                /*
                IF "Account Type"="Account Type"::Customer THEN
                  BEGIN
                      IF ObjMember.GET("Member No") THEN
                        BEGIN
                          IF ObjMember.Status<>ObjMember.Status::Active THEN
                            BEGIN
                              ERROR('Member Account is not Active,Current Status is %1',ObjMember.Status);
                              END;
                          END;
                
                END;*/

            end;
        }
        field(4; "Loan No."; Code[20])
        {
            TableRelation = "Loans Register"."Loan  No." where("Client Code" = field("Member No"));
            //"Outstanding Balance" = filter(<> 0));

            trigger OnValidate()
            begin

                if Loans.Get("Loan No.") and ("Transaction Type" = "transaction type"::"Loan Repayment") then begin
                    Loans.CalcFields(Loans."Outstanding Balance");
                    if Loans."Outstanding Balance" > 0 then begin
                        Amount := Loans."Loan Principle Repayment";
                        if Loans."Outstanding Balance" < Loans."Loan Principle Repayment" then
                            Amount := Loans."Outstanding Balance";
                        "Amount Balance" := Loans."Outstanding Balance";
                        "Interest Amount" := Loans."Loan Interest Repayment";
                    end;
                    if "Transaction Type" = "transaction type"::"Interest Paid" then begin
                        Amount := Loans."Loan Interest Repayment";
                        if ((SFactory.FnGetInterestDueTodate(Loans) - Loans."Interest Paid") < Loans."Loan Interest Repayment") or ((SFactory.FnGetInterestDueTodate(Loans) - Loans."Interest Paid") > Loans."Loan Interest Repayment") then
                            Amount := SFactory.FnGetInterestDueTodate(Loans) - Loans."Interest Paid";
                    end;

                end;



                "Total Amount" := Amount + "Interest Amount";
            end;
        }
        field(5; Amount; Decimal)
        {

            trigger OnValidate()
            begin
                if (("Transaction Type" = "transaction type"::"Interest Paid") or ("Transaction Type" = "transaction type"::Loan) or ("Transaction Type" = "transaction type"::"Loan Repayment")) then begin
                    if "Loan No." = '' then
                        Error('You must specify loan no. for loan transactions.');
                end;

                if Loans.Get("Loan No.") then begin
                    Loans.CalcFields(Loans."Outstanding Balance");
                    if Loans.Posted = true then begin

                        // if Amount > Loans."Outstanding Balance" then
                        //     Error('Principle Repayment cannot be more than the loan oustanding balance,Currrent Balance is %1', Loans."Outstanding Balance");
                    end;
                end;

                "Total Amount" := Amount + "Interest Amount";



                GenSetup.Get();


                // if Loans.Get("Loan No.") then begin
                //     Loans.CalcFields(Loans."Outstanding Balance");
                //     if Loans.Posted = true then begin
                //         if Loans."Loan Under Debt Collection" = true then begin
                //             Message('Loan is Under Debt Collection!');
                //             if Confirm('Charge Debt Collection Fee?', false) = true then begin
                //                 TestField("Cummulative Total Payment Loan");

                //                 ObjReceiptAll.Init;
                //                 ObjReceiptAll."Document No" := "Document No";
                //                 ObjReceiptAll.Amount := "Cummulative Total Payment Loan" * Loans."Loan Debt Collector Interest %";
                //                 ObjReceiptAll."Total Amount" := "Cummulative Total Payment Loan" * Loans."Loan Debt Collector Interest %";
                //                 ObjReceiptAll."Mpesa Account Type" := ObjReceiptAll."mpesa account type"::Customer;
                //                 ObjReceiptAll."Mpesa Account No" := Loans."Loan Debt Collector";
                //                 ObjReceiptAll."Loan No." := "Loan No.";
                //                 ObjReceiptAll."Member No" := "Member No";
                //                 ObjReceiptAll.Insert;
                //             end;
                //         end;
                //     end;
                // end;



            end;
        }
        field(6; "Interest Amount"; Decimal)
        {

            trigger OnValidate()
            begin
                if ("Transaction Type" = "transaction type"::"Registration Fee") then begin
                    if "Loan No." = '' then
                        Error('You must specify loan no. for loan transactions.');
                end;
                /*
                IF Loans.GET("Loan No.") THEN BEGIN
                Loans.CALCFIELDS(Loans."Oustanding Interest");
                IF "Interest Amount" > (Loans."Oustanding Interest"+SFactory.FnGetInterestDueFiltered(Loans,'..'+FORMAT(TODAY))) THEN
                ERROR('Interest Repayment cannot be more than the loan oustanding balance.');
                END;
                */

                "Total Amount" := Amount + "Interest Amount" + "Loan Insurance";

            end;
        }
        field(7; "Total Amount"; Decimal)
        {
            Editable = false;
        }
        field(8; "Amount Balance"; Decimal)
        {
        }
        field(9; "Interest Balance"; Decimal)
        {
        }
        field(10; "Loan ID"; Code[10])
        {
        }
        field(11; "Prepayment Date"; Date)
        {
        }
        field(50000; "Loan Insurance"; Decimal)
        {
            BlankZero = true;

            trigger OnValidate()
            begin

                //Loans.GET();
                CalcFields("Applied Amount");

                if "Applied Amount" > 1 then
                    //Loans.SETRANGE(Loans."Client Code","Member No");
                   "Loan Insurance" := "Applied Amount" * 0.01;
            end;
        }
        field(50001; "Applied Amount"; Decimal)
        {
            CalcFormula = lookup("Loans Register"."Approved Amount" where("Loan  No." = field("Loan No.")));
            FieldClass = FlowField;
        }
        field(50002; Insurance; Decimal)
        {
        }
        field(50003; "Un Allocated Amount"; Decimal)
        {
        }
        field(51516150; "Global Dimension 1 Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(51516151; "Global Dimension 2 Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(51516152; "Cash Clearing Charge"; Decimal)
        {
        }
        field(51516153; "Loan Outstanding Balance"; Decimal)
        {
        }
        field(51516154; "Mpesa Account Type"; Option)
        {
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Member,Investor';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Member,Investor;
        }
        field(51516155; "Mpesa Account No"; Code[20])
        {
            TableRelation = if ("Mpesa Account Type" = filter(Member)) Customer."No."
            else
            if ("Mpesa Account Type" = filter(Vendor)) Vendor."No."
            else
            if ("Mpesa Account Type" = filter("G/L Account")) "G/L Account"."No.";
        }
        field(51516156; "Cummulative Total Payment Loan"; Decimal)
        {
        }
        field(51516157; "Loan Product Name"; Code[80])
        {
        }
        field(51516158; "Total Allocation"; Decimal)
        {
            CalcFormula = sum("Receipt Allocation".Amount where("Document No" = field("Document No")));
            FieldClass = FlowField;
        }
        field(51516160; "Account No"; Code[100])
        {
            TableRelation = if ("Account Type" = const("G/L Account")) "G/L Account" where("Account Type" = const(Posting),
                                                                                          Blocked = const(false))
            else
            if ("Account Type" = const(Customer)) Customer
            else
            if ("Account Type" = const(Vendor)) Vendor where("BOSA Account No" = field("Member No"), Status = filter(<> Closed | Deceased), Blocked = filter(<> All | Payment));

            trigger OnValidate()
            begin

                if "Account Type" = "account type"::Vendor then begin
                    if ObjAccount.Get("Account No") then begin
                        if ObjAccount.Status <> ObjAccount.Status::Active then begin
                            Error('Account is not Active,Current Status is %1', ObjAccount.Status);
                        end;
                    end;

                end;
            end;
        }
        field(51516161; "Account Type"; enum "Gen. Journal Account Type")
        {
            Caption = 'Account Type';
            // OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Employee,Member,Investor';
            // OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee,Member,Investor;

            trigger OnValidate()
            begin
                // if "Account Type" = "account type"::Vendor then begin
                //     "Transaction Type" := "transaction type"::"FOSA Account";
                // end;
            end;
        }
        field(51516162; "Loan PayOff Amount"; Decimal)
        {
        }
        field(51516163; Description; Text[100])
        {
        }


    }

    keys
    {
        key(Key1; "Document No", "Transaction Type", Amount, "Account Type", "Account No", "Member No", "Loan No.")
        {
            Clustered = true;
        }
        key(Key2; "Loan No.")
        {
        }
        key(Key3; "Account No")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Loans: Record "Loans Register";
        Cust: Record Customer;
        PTEN: Text;
        DataSheet: Record "Data Sheet Main";
        Customer: Record Customer;
        LoansR: Record "Loans Register";
        GenSetup: Record "Sacco General Set-Up";
        ReceiptH: Record "Receipts & Payments";
        SFactory: Codeunit "SWIZZSFT Factory";
        ObjLoans: Record "Loans Register";
        ObjProductCharges: Record "Loan Product Charges";
        VarEndYear: Date;
        VarInsuranceMonths: Integer;
        VarInsuranceAmount: Decimal;
        VarTransactionType: Option " ","Registration Fee","Share Capital","Interest Paid",Repayment,"Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account","Loan Insurance Charged","Loan Insurance Paid";
        VarAccountType: Enum "Gen. Journal Account Type";
        VarBalAccountType: Enum "Gen. Journal Account Type";
        VarBalAccountNo: Code[20];
        ObjSurestep: Codeunit "SWIZZSFT Factory";
        ObjLoanType: Record "Loan Products Setup";
        ObjReceiptAll: Record "Receipt Allocation";
        ObjAccount: Record Vendor;
        ObjMember: Record Customer;


}

