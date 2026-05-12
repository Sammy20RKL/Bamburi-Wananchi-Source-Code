table 50051 "BOSA Transfer Schedule"
{
    fields
    {
        field(1; "No."; Code[10])
        {
        }
        field(2; "Source Account No."; Code[20])
        {
            // TableRelation = if ("Source Type" = filter(Member)) Customer."No."
            // else
            // if ("Source Type" = filter(Vendor)) Vendor."No."
            // else
            // if ("Source Type" = filter(Bank)) "Bank Account"."No."
            // else
            // if ("Source Type" = filter("G/L ACCOUNT")) "G/L Account"."No.";

            trigger OnValidate()
            begin

                if "Source Type" = "source type"::Member then begin
                    memb.Reset;
                    if memb.Get("Source Account No.") then begin
                        "Source Account Name" := memb.Name;
                    end;
                end;

                if "Source Type" = "source type"::Bank then begin
                    Bank.Reset;
                    if Bank.Get("Source Account No.") then begin
                        "Source Account Name" := Bank.Name;
                    end;
                end;

                if "Source Type" = "source type"::Vendor then begin
                    Vend.Reset;
                    if Vend.Get("Source Account No.") then begin
                        "Source Account Name" := Vend.Name;
                    end;
                end;


                if "Source Type" = "source type"::"G/L ACCOUNT" then begin
                    "G/L".Reset;
                    if "G/L".Get("Source Account No.") then begin
                        "Source Account Name" := "G/L".Name;
                    end;
                end;
            end;
        }
        field(3; "Source Account Name"; Text[100])
        {
        }
        field(4; "Destination Account Type"; enum "Bosa Transfers SourceTypeEnum")
        {
            InitValue = true;
            trigger OnValidate()
            begin

            end;
        }
        field(5; "Destination Account No."; Code[20])
        {
            TableRelation = if ("Destination Account Type" = const(Vendor)) Vendor."No."
            else
            if ("Destination Account Type" = const(Bank)) "Bank Account"."No."
            else
            if ("Destination Account Type" = const("G/L ACCOUNT")) "G/L Account"."No."
            else
            if ("Destination Account Type" = const(Member)) Customer."No.";

            trigger OnValidate()
            begin
                if "Destination Account Type" = "destination account type"::Vendor then begin
                    Vend.Reset;
                    if Vend.Get("Destination Account No.") then
                        "Destination Account Name" := Vend.Name;
                end else
                    if "Destination Account Type" = "destination account type"::Member then begin
                        Cust.Reset;
                        if Cust.Get("Destination Account No.") then
                            "Destination Account Name" := Cust.Name;


                    end;

                if "Destination Account Type" = "destination account type"::"G/L ACCOUNT" then begin
                    "G/L".Reset;
                    if "G/L".Get("Destination Account No.") then begin
                        "Destination Account Name" := "G/L".Name;
                    end;
                end;

                if "Destination Account Type" = "destination account type"::BANK then begin
                    Bank.Reset;
                    if Bank.Get("Destination Account No.") then begin
                        "Destination Account Name" := Bank.Name;
                    end;
                end;
            end;
        }
        field(6; Amount; Decimal)
        {
        }
        field(7; "Source Type"; enum "Bosa Transfers SourceTypeEnum")
        {
        }
        field(8; "Destination Account Name"; Text[100])
        {
        }
        field(9; "Destination Bank No."; Code[20])
        {
        }
        field(10; "Destination Bank Name"; Text[30])
        {
        }
        field(11; "Transaction Type"; ENUM TransactionTypesEnum)
        {


            trigger OnValidate()
            begin
                if "Transaction Type" = "transaction type"::"Registration Fee" then
                    Description := 'Registration Fee' else

                    if "Transaction Type" = "transaction type"::Dividend then begin
                        Description := 'Dividends';
                        if Cust.get("Source Account No.") then begin
                            Cust.CalcFields(Cust."Dividend Amount");
                            "Transaction Amount" := Cust."Dividend Amount"

                        end
                    end
                    else
                        if "Transaction Type" = "transaction type"::Loan then
                            Description := 'Loan' else
                            if "Transaction Type" = "transaction type"::"Loan Repayment" then
                                Description := 'Loan Repayment' else
                                if "Transaction Type" = "transaction type"::Withdrawal then
                                    Description := 'Withdrawal' else
                                    if "Transaction Type" = "transaction type"::"Interest Due" then
                                        Description := 'Interest Due' else
                                        if "Transaction Type" = "transaction type"::"Interest Paid" then
                                            Description := 'Interest Paid' else
                                            if "Transaction Type" = "transaction type"::"Benevolent Fund" then
                                                Description := 'ABF Fund' else
                                                if "Transaction Type" = "transaction type"::"Deposit Contribution" then
                                                    Description := 'Shares Contribution';
                if Cust.get("Source Account No.") then begin
                    Cust.CalcFields(Cust."Current Shares");
                    "Transaction Amount" := Cust."Current Shares"
                end else
                    // if "Transaction Type" = "transaction type"::"Appraisal Fee" then
                    //     Description := 'Appraisal Fee' else
                    //     if "Transaction Type" = "transaction type"::"Application Fee" then
                    //         Description := 'Application Fee' else
                    if "Transaction Type" = "transaction type"::"Unallocated Funds" then
                        Description := 'Unallocated Funds';

            end;
        }
        field(12; Loan; Code[30])
        {
            TableRelation = if ("Source Type" = const(Member)) "Loans Register"."Loan  No." where("Client Code" = field("Source Account No."))
            else
            if ("Destination Account Type" = const(Member)) "Loans Register"."Loan  No." where("Client Code" = field("Destination Account No."));
        }
        field(13; "Destination Loan"; Code[30])
        {
            TableRelation = if ("Destination Account Type" = const(Member)) "Loans Register"."Loan  No." where("Client Code" = field("Destination Account No."))
            else
            if ("Destination Account Type" = const(Member)) "Loans Register"."Loan  No." where("Client Code" = field("Destination Account No."));
        }
        field(14; Description; Text[100])
        {
            trigger OnValidate()
            begin
                "Line Description" := Description;
            end;
        }
        field(15; "Destination Type"; Enum TransactionTypesEnum)
        {

        }
        field(16; "Charge Type"; Option)
        {
            OptionCaption = ' ,Milk,Salary,FDR,BOSA Transfer';
            OptionMembers = " ",Milk,Salary,FDR,"BOSA Transfer";

            trigger OnValidate()
            begin
                "Charge Amount" := 0;
                if "Charge Type" = "charge type"::" " then //BEGIN
                    "Charge Amount" := 0;

                if "Charge Type" = "charge type"::Milk then //BEGIN
                    "Charge Amount" := 100;

                if "Charge Type" = "charge type"::Salary then
                    "Charge Amount" := 100;
                if "Charge Type" = "charge type"::FDR then
                    "Charge Amount" := 200;
                if "Charge Type" = "charge type"::"BOSA Transfer" then
                    "Charge Amount" := 50;
            end;
        }
        field(17; "Charge Amount"; Decimal)
        {
        }

        field(18; "Branch Code"; Code[10])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(21; "Line Description"; Text[90])
        {
        }
        field(22; DocNo; Integer)
        {
            AutoIncrement = true;
        }
        field(24; "Transaction Amount"; Decimal)
        {

        }
    }

    keys
    {
        key(Key1; "No.", DocNo, "Source Account No.", "Destination Bank No.", "Transaction Type", Loan, "Destination Account No.", Amount, "Destination Loan")
        {
            Clustered = true;
            SumIndexFields = Amount;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if "Source Account No." <> '' then begin
            Bosa.Reset;
            if Bosa.Get("No.") then begin
                if (Bosa.Posted) or (Bosa.Approved) then
                    Error('Cannot delete approved or posted batch');
            end;
        end;
    end;

    trigger OnModify()
    begin
        if "Source Account No." <> '' then begin
            Bosa.Reset;
            if Bosa.Get("No.") then begin
                if (Bosa.Posted) or (Bosa.Approved) then
                    Error('Cannot modify approved or posted batch');
            end;
        end;
    end;

    trigger OnRename()
    begin
        Bosa.Reset;
        if Bosa.Get("No.") then begin
            if (Bosa.Posted) or (Bosa.Approved) then
                Error('Cannot rename approved or posted batch');
        end;
    end;

    var
        Cust: Record Customer;
        Vend: Record Vendor;
        Bank: Record "Bank Account";
        Bosa: Record "BOSA Transfers";
        "G/L": Record "G/L Account";
        memb: Record Customer;
}

