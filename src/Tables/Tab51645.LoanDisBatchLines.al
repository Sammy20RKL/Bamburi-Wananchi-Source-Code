#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51645 "Loan Dis Batch Lines"
{

    fields
    {
        field(1; "Batch No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Mode Of Disbursement"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Cheque,MPESA,EFT,RTGS';
            OptionMembers = Cheque,MPESA,EFT,RTGS;

            trigger OnValidate()
            begin
                // IF "Mode Of Disbursement"="Mode Of Disbursement"::EFT THEN
                //  "Bank Account":='BANK0005';
            end;
        }
        field(4; "Cheque No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Entry No"; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(7; "Bank Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account"."No.";

            trigger OnValidate()
            var
                BankAccount: Record "Bank Account";
                deductions: Decimal;
            begin
                if "Mode Of Disbursement" = "mode of disbursement"::EFT then begin
                    BankAccount.Reset;
                    BankAccount.SetRange("No.", "Bank Account");
                    if BankAccount.Find('-') then
                        "EFT Fees" := BankAccount."EFT Fees";
                end;
                if "Batch No." <> '' then begin
                    deductions := 0;
                    LoanApps.Reset;
                    LoanApps.SetRange(LoanApps."Batch No.", "Batch No.");
                    if LoanApps.FindFirst() then begin
                        LoanApps.CalcFields(LoanApps."Top Up Amount", LoanApps."Topup iNTEREST", LoanApps."Total TopUp Commission", LoanApps."Topup Commission");
                        if (LoanApps."Loan Product Type" = 'INSTANT') or (LoanApps."Loan Product Type" = 'KARIBU') or (LoanApps."Loan Product Type" = 'SUKUMA') then
                            InterestUpfront := LoanApps."Loan Interest Repayment";

                        if (LoanApps."Loan Product Type" = 'INSTANT') or (LoanApps."Loan Product Type" = 'KARIBU') then
                            InsuranceAmount := LoanApps.Insurance;
                        if LoanApps."Insurance Upfront" then
                            InsuranceAmount := LoanApps.Insurance;
                        if LoanApps."Top Up Amount" > 0 then begin
                            if LoanApps.Refinancing then
                                deductions := ROUND("EFT Fees" + InterestUpfront + InsuranceAmount + LoanApps."Boosted Amount" + LoanApps."Top Up Amount" + LoanApps."Boosting Commision" + LoanApps."Lumpsum Amount Charge" + LoanApps."Penalty Amount", 0.1, '=')
                            else
                                deductions := ROUND("EFT Fees" + InterestUpfront + LoanApps."Top Up Amount" + InsuranceAmount + LoanApps."Total TopUp Commission" + LoanApps."Boosted Amount" + LoanApps."Boosting Commision" + LoanApps."Lumpsum Amount Charge" + LoanApps."Penalty Amount", 0.1, '=');
                        end else begin
                            deductions := ROUND("EFT Fees" + InterestUpfront + InsuranceAmount + LoanApps."Topup Commission" + LoanApps."Boosted Amount" + LoanApps."Boosting Commision" + LoanApps."Lumpsum Amount Charge" + LoanApps."Penalty Amount", 0.1, '=');
                        end;
                    end;
                end;

                LoanDisburesmentBatching.Reset;
                LoanDisburesmentBatching.SetRange(LoanDisburesmentBatching."Batch No.", "Batch No.");
                if LoanDisburesmentBatching.Find('-') then begin
                    LoanDisburesmentBatching.CalcFields("Total Loan Amount");
                    "Available Amount" := LoanDisburesmentBatching."Total Loan Amount" - deductions;
                end;
            end;
        }
        field(8; "EFT Fees"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Amount to Disburse"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                newVal: Decimal;
            begin
                CalcFields("Total Lines");
                Unallocated := "Available Amount" - "Total Lines" - "Amount to Disburse";
                if Unallocated < 0 then
                    Error('Total amount allocated cannot be more than ' + Format("Available Amount"));
            end;
        }
        field(10; "Total Lines"; Decimal)
        {
            CalcFormula = sum("Loan Dis Batch Lines"."Amount to Disburse" where("Batch No." = field("Batch No.")));
            FieldClass = FlowField;
        }
        field(11; Unallocated; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Available Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Batch No.", "Entry No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        LoanDisburesmentBatching: Record "Loan Disburesment-Batching";
        LoanDisBatchLines: Record "Loan Dis Batch Lines";
        LoanDisBatchL: Record "Loan Dis Batch Lines";
        LoanApps: Record "Loans Register";
        DisbAmt: Decimal;
        InsuranceAmount: Decimal;
        InterestUpfront: Decimal;
}

