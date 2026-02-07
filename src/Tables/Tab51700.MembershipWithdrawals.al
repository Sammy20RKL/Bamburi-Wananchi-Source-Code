#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51700 "Membership Withdrawals"
{

    fields
    {
        field(1; "No."; Code[20])
        {

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    SalesSetup.Get;
                    NoSeriesMgt.TestManual(SalesSetup."Closure  Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Member No."; Code[20])
        {
            TableRelation = Customer;

            trigger OnValidate()
            begin
                IntTotal := 0;
                LoanTotal := 0;

                if Cust.Get("Member No.") then begin
                    "Member Name" := Cust.Name;
                    Cust.CalcFields(Cust."Current Savings");
                    "Member Deposits" := Cust."Current Savings";
                    "FOSA Account No." := Cust."FOSA Account";
                    //"BBF Amount":=0.5*39500;
                end;



                Loans.Reset;
                Loans.SetRange(Loans."Client Code", "Member No.");
                Loans.SetRange(Loans.Posted, true);
                //Loans.SETFILTER(Loans."Outstanding Balance",'>0');
                if Loans.Find('-') then begin
                    repeat
                        Loans.CalcFields(Loans."Outstanding Balance", Loans."Oustanding Interest");
                        IntTotal := IntTotal + Loans."Oustanding Interest";
                        LoanTotal := LoanTotal + Loans."Outstanding Balance";
                    until Loans.Next = 0;
                end;


                "Total Loan" := LoanTotal;
                "Total Interest" := IntTotal;
            end;
        }
        field(3; "Member Name"; Text[50])
        {
        }
        field(4; "Closing Date"; Date)
        {
        }
        field(5; Status; Option)
        {
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(6; Posted; Boolean)
        {
        }
        field(7; "Total Loan"; Decimal)
        {
        }
        field(8; "Total Interest"; Decimal)
        {
        }
        field(9; "Member Deposits"; Decimal)
        {
        }
        field(10; "No. Series"; Code[20])
        {
        }
        field(11; "Closure Type"; Option)
        {
            OptionCaption = 'Withdrawal - Normal,Withdrawal - Death,Withdrawal - Death(Defaulter),Termination';
            OptionMembers = "Withdrawal - Normal","Withdrawal - Death","Withdrawal - Death(Defaulter)",Termination;
        }
        field(12; "Mode Of Disbursement"; Option)
        {
            OptionCaption = 'FOSA Transfer,Cheque,EFT';
            OptionMembers = "FOSA Transfer",Cheque,EFT;
        }
        field(13; "Paying Bank"; Code[20])
        {
            TableRelation = "Bank Account"."No.";

            trigger OnValidate()
            begin
                if ("Mode Of Disbursement" = "mode of disbursement"::Cheque) or ("Mode Of Disbursement" = "mode of disbursement"::EFT) then begin
                    if "Paying Bank" = '' then
                        Error('You Must Specify the Paying bank');
                end;
            end;
        }
        field(14; "Cheque No."; Code[20])
        {
        }
        field(15; "FOSA Account No."; Code[20])
        {
        }
        field(16; Payee; Text[80])
        {
        }
        field(17; "Net Pay"; Decimal)
        {
        }
        field(18; "BBF Amount"; Decimal)
        {
        }
        field(19; "Amount to withhold"; Decimal)
        {

            trigger OnValidate()
            begin
                if "Amount to withhold" < 0 then
                    Error('Amount must not be less than zero');
            end;
        }
        field(20; "Effective Date"; Date)
        {

            trigger OnValidate()
            begin
                if "Closure Type" <> "closure type"::Termination then
                    Error('Option Only for Termination Withdrawal');
            end;
        }
        field(21; "Service Charge"; Decimal)
        {
        }
        field(22; "Withdrawable savings Scheme"; Decimal)
        {
        }
        field(23; "With Notice"; Boolean)
        {

            trigger OnValidate()
            begin
                generalsetup.Get();
                //MESSAGE('%1',generalsetup."Withdrawal Commision");
                if "With Notice" = false then begin
                    // Charges := generalsetup."Speed Charge (%)"
                end
                else
                    Charges := 0;
            end;
        }
        field(24; Charges; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
            SalesSetup.Get;
            SalesSetup.TestField(SalesSetup."Closure  Nos");
            //  NoSeriesMgt.InitSeries(SalesSetup."Closure  Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;
    end;

    var
        SalesSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit "No. Series";
        Cust: Record Customer;
        Loans: Record "Loans Register";
        MemLed: Record "Cust. Ledger Entry";
        IntTotal: Decimal;
        LoanTotal: Decimal;
        generalsetup: Record "Sacco General Set-Up";
        Charges: Decimal;
}

