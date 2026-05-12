#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51016 "Sacco Transfers"
{
    DrillDownPageId = "Sacco Transfer List";
    LookupPageId = "Sacco Transfer List";
    fields
    {
        field(1; No; Code[20])
        {

            trigger OnValidate()
            begin
                if No <> xRec.No then begin
                    NoSetup.Get(0);
                    NoSeries.TestManual(No);
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Transaction Date"; Date)
        {
        }
        field(3; "Schedule Total"; Decimal)
        {
            CalcFormula = sum("Sacco Transfers Schedule".Amount where("No." = field(No)));
            FieldClass = FlowField;
        }
        field(4; Approved; Boolean)
        {
        }
        field(5; "Approved By"; Code[10])
        {
        }
        field(6; Posted; Boolean)
        {
        }
        field(7; "No. Series"; Code[20])
        {
        }
        field(8; "Responsibility Center"; Code[10])
        {
        }
        field(9; Remarks; Code[30])
        {
        }
        field(10; "Source Account Type"; Option)
        {
            OptionCaption = 'Customer,Fosa,Bank,G/L ACCOUNT,MEMBER';
            OptionMembers = Customer,Fosa,Bank,"G/L ACCOUNT",MEMBER;
        }
        field(11; "Source Account No"; Code[20])
        {
            TableRelation = if ("Source Account Type" = filter(Fosa)) Vendor."No."
            else
            if ("Source Account Type" = filter(MEMBER)) customer."No."
            else
            if ("Source Account Type" = filter(Bank)) "Bank Account"."No."
            else
            if ("Source Account Type" = filter("G/L ACCOUNT")) "G/L Account"."No."
            else
            if ("Source Account Type" = filter(Customer)) Customer."No.";

            trigger OnValidate()
            begin
                /*IF "Source Account Type"="Source Account Type"::MEMBER THEN BEGIN
                  MESSAGE('01011100');
                memb.RESET;
                IF memb.GET("Source Account No") THEN BEGIN
                  MESSAGE('010111');
                  IF "Source Account No"<> memb."No." THEN ERROR('0101');
                
                  END;
                  END;*/

                if "Source Account Type" = "source account type"::Customer then begin
                    Cust.Reset;
                    if Cust.Get("Source Account No") then begin
                        "Source Account Name" := Cust.Name;
                        //"Source Transaction Type":="Source Transaction Type"::"FOSA Account";
                        //"Source Account No":=Cust."FOSA Account";
                        //VALIDATE("Source Account No");
                    end;
                end;

                if "Source Account Type" = "source account type"::Bank then begin
                    Bank.Reset;
                    if Bank.Get("Source Account No") then begin
                        "Source Account Name" := Bank.Name;
                        "Global Dimension 2 Code" := Bank."Global Dimension 2 Code";
                    end;
                end;

                if "Source Account Type" = "source account type"::Fosa then begin
                    Vend.Reset;
                    if Vend.Get("Source Account No") then begin
                        "Source Account Name" := Vend.Name;
                        "Global Dimension 2 Code" := Vend."Global Dimension 2 Code";
                    end;
                end;

                if "Source Account Type" = "source account type"::MEMBER then begin
                    memb.Reset;
                    if memb.Get("Source Account No") then begin
                        //IF "Source Account No"<> memb."No." THEN ERROR('0101');
                        "Source Account Name" := memb.Name;
                        "Global Dimension 2 Code" := memb."Global Dimension 2 Code";
                    end;
                end;


                if "Source Account Type" = "source account type"::"G/L ACCOUNT" then begin
                    "G/L".Reset;
                    if "G/L".Get("Source Account No") then begin
                        "Source Account Name" := "G/L".Name;
                    end;
                end;

            end;
        }
        field(12; "Source Transaction Type"; ENUM TransactionTypesEnum)
        {
        }
        field(13; "Source Account Name"; Text[50])
        {
        }
        field(14; "Source Loan No"; Code[20])
        {
            TableRelation = if ("Source Account Type" = filter(Fosa)) "Loans Register"."Loan  No." where("Account No" = field("Source Account No"))
            else
            if ("Source Account Type" = filter(MEMBER)) "Loans Register"."Loan  No." where("Bosa No" = field("Source Account No"));
            trigger OnValidate()
            var
                ObjLoans: Record "Loans Register";
            begin
                // ObjLoans.RESET;
                // ObjLoans.SETRANGE("Loan  No.", "Source Loan No");
                // IF ObjLoans.FIND('-') THEN BEGIN
                //     IF (("Source Transaction Type" = "Source Transaction Type"::"Loan Repayment") OR
                //       ("Source Transaction Type" = "Source Transaction Type"::"Interest Paid")) THEN BEGIN
                //         ObjLoans.CALCFIELDS("Outstanding Balance", "Oustanding Interest");
                //         IF (("Source Transaction Type" = "Source Transaction Type"::"Loan Repayment") AND (ObjLoans."Outstanding Balance" < 0)) THEN
                //             "Header Amount" := ABS(ObjLoans."Outstanding Balance");
                //         IF (("Source Transaction Type" = "Source Transaction Type"::"Interest Paid") AND (ObjLoans."Oustanding Interest" < 0)) THEN
                //             "Amount" := ABS(ObjLoans."Oustanding Interest");
                //     END;
                // END;
            end;
        }
        field(15; "Created By"; Code[60])
        {
        }
        field(16; Debit; Text[30])
        {
            Editable = false;
        }
        field(17; Refund; Boolean)
        {
        }
        field(18; "Guarantor Recovery"; Boolean)
        {
        }
        field(19; "Payrol No."; Code[30])
        {
        }
        field(20; "Global Dimension 1 Code"; Code[10])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1),
                                                          "Dimension Value Type" = const(Standard));
        }
        field(21; "Global Dimension 2 Code"; Code[10])
        {
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2),
                                                          "Dimension Value Type" = const(Standard));
        }
        field(22; "Bosa Number"; Code[30])
        {
        }
        field(51516061; Status; enum "Record Status")
        {

        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if Approved or Posted then
            Error('Cannot delete posted or approved batch');
    end;

    trigger OnInsert()
    begin
        if No = '' then begin
            NoSetup.Get;
            NoSetup.TestField(NoSetup."BOSA Transfer Nos");
            No := NoSeries.GetNextNo(NoSetup."BOSA Transfer Nos");

        end;
        "Transaction Date" := Today;
        "Created By" := UserId;
        Debit := 'Credit';
    end;

    trigger OnModify()
    begin
        if Posted then
            Error('Cannot modify a posted batch');
    end;

    trigger OnRename()
    begin
        if Posted then
            Error('Cannot rename a posted batch');
    end;

    var
        NoSetup: Record "Sacco No. Series";
        NoSeries: Codeunit "No. Series";
        Cust: Record Customer;
        Bank: Record "Bank Account";
        Vend: Record Vendor;
        memb: Record Customer;
        "G/L": Record "G/L Account";
}

