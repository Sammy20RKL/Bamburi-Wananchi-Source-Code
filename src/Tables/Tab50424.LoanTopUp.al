#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
table 50424 "Loan Top Up."
{

    fields
    {
        field(1; "Document No"; Code[20])
        {

            trigger OnValidate()
            begin
                if "Document No" <> xRec."Document No" then begin
                    SalesSetup.Get;
                    NoSeriesMgt.TestManual(SalesSetup."Top Up Loan Nos");
                    "No. Series" := '';
                end;

            end;
        }
        field(2; "Member No"; Code[20])
        {
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                Cust.Reset;
                Cust.SetRange(Cust."No.", "Member No");
                if Cust.Find('-') then begin
                    "Member Name" := Cust.Name;
                end;
            end;
        }
        field(3; "Member Name"; Text[50])
        {
        }
        field(4; "Loan No"; Code[20])
        {
            TableRelation = "Loans Register"."Loan  No." where("Client Code" = field("Member No"),
                                                                Posted = const(true));

            trigger OnValidate()
            begin
                LoansRec.Reset;
                LoansRec.SetRange(LoansRec."Loan  No.", "Loan No");
                if LoansRec.Find('-') then begin
                    LoansRec.CalcFields(LoansRec."Outstanding Balance");
                    "Issue Date" := LoansRec."Application Date";
                    Validate("Issue Date");
                    "Approved Amount" := LoansRec."Approved Amount";
                    "Requested Amount" := LoansRec."Requested Amount";
                    "Outstanding Loan Amount" := LoansRec."Outstanding Balance";
                    Validate("Outstanding Loan Amount");
                    "Original Installments" := LoansRec.Installments;
                    "Disbursed Amount" := LoansRec."Amount Disbursed";
                end;
            end;
        }
        field(5; "Issue Date"; Date)
        {
        }
        field(6; "Approved Amount"; Decimal)
        {
        }
        field(7; "Requested Amount"; Decimal)
        {
        }
        field(8; Status; Option)
        {
            OptionCaption = 'Open,Pending,Approved';
            OptionMembers = Open,Pending,Approved;
        }
        field(10; "Topped-Up"; Boolean)
        {
        }
        field(11; "Topped-Up By"; Code[25])
        {
        }
        field(12; "Top Up Date"; Date)
        {
        }
        field(13; "No. Series"; Code[20])
        {
        }
        field(14; "Repayment Start Date"; Date)
        {
        }
        field(15; "Outstanding Loan Amount"; Decimal)
        {
        }
        field(16; "New Installments"; Integer)
        {
        }
        field(17; "Original Installments"; Integer)
        {
        }
        field(18; "Top Up Amount"; Decimal)
        {

            trigger OnValidate()
            begin
                "Original Top-Up" := "Top Up Amount";
                Modify;

            end;
        }
        field(19; "Disbursed Amount"; Decimal)
        {
        }
        field(20; "Balance After"; Decimal)
        {
        }
        field(21; "Cheque No."; Code[6])
        {
        }
        field(22; "Partial Top-Up"; Boolean)
        {
        }
        field(23; "Amount To Disburse"; Decimal)
        {

            trigger OnValidate()
            begin
                if "Amount To Disburse" > "Original Top-Up" then
                    Error(DisbError);
            end;
        }
        field(24; "Is Active"; Boolean)
        {
        }
        field(25; "Paying Bank Account"; Code[10])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(26; "Loan Insurance"; Decimal)
        {
        }
        field(27; Posted; Boolean)
        {
        }
        field(28; "Original Top-Up"; Decimal)
        {
        }
        field(29; Commision; Decimal)
        {
        }
        field(30; "Remaining Installments"; Integer)
        {

            trigger OnValidate()
            begin

            end;
        }
        field(31; "Posting Date"; Date)
        {
        }
        field(32; "Top Up Loan No"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Document No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        Error('Deletion is not allowed!');
    end;

    trigger OnInsert()
    var
        LoansRegister: Record "Loans Register";
    begin
        if "Document No" = '' then begin
            SalesSetup.Get;
            SalesSetup.TestField(SalesSetup."Top Up Loan Nos");
            // NoSeriesMgt.InitSeries(SalesSetup."Top Up Loan Nos", xRec."No. Series", 0D, "Document No", "No. Series");
        end;
        "Topped-Up By" := UserId;
        "Top Up Loan No" := "Document No";
        //.......................Create Loan Number In Loans Register
        LoansRegister.Init();
        LoansRegister."Loan  No." := "Document No";
        LoansRegister.Insert();
    end;

    var
        Cust: Record Customer;
        LoansRec: Record "Loans Register";
        SalesSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit "No. Series";
        DisbError: label 'Amount to disburse must not be more than Top Up Amount';
        Paid: Decimal;
        ChargeRefinanceFee: label 'Is the loan within shares?';

    local procedure getDisbursedAmount(ClientNo: Code[20]; LoanNo: Code[20]): Decimal
    var
        MembLedEntry: Record "Cust. Ledger Entry";
    begin
        MembLedEntry.Reset;
        MembLedEntry.SetRange(MembLedEntry."Customer No.", ClientNo);
        MembLedEntry.SetRange(MembLedEntry."Loan No", LoanNo);
        MembLedEntry.SetRange(MembLedEntry."Transaction Type", MembLedEntry."transaction type"::Loan);
        if MembLedEntry.FindSet then begin
            MembLedEntry.CalcSums(MembLedEntry."Amount Posted");
            exit(MembLedEntry.Amount);
        end;
    end;
}

