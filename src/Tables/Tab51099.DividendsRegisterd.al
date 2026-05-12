#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51099 "Dividends Registerd"
{

    fields
    {
        field(1; "Member No"; Code[50])
        {
            TableRelation = Customer."No.";
        }
        field(2; "Dividend year"; Code[50])
        {
        }
        field(4; "Member Name"; Code[250])
        {
        }
        field(8; "Gross Dividend"; Decimal)
        {
        }
        field(9; "Withholding Tax"; Decimal)
        {
        }
        field(10; "Net Dividends"; Decimal)
        {
        }
        field(11; "Qualifying Share Capital"; Decimal)
        {
        }
        field(12; "Qualifying Deposits"; Decimal)
        {
        }
        field(13; "Interest on Shares Capital"; Decimal)
        {
        }
        field(14; "Interest on Deposits"; Decimal)
        {
        }
        field(15; Capitalize; Boolean)
        {
        }
        field(16; Posted; Boolean)
        {
        }
        field(17; "Posting Date"; Date)
        {
        }
        field(18; "Qualifying Holiday Savings"; Decimal)
        {
        }
        field(19; "Interest on Holiday Savings"; Decimal)
        {
        }
        field(20; "Outstanding Dividend Loan"; Decimal)
        {
        }
        field(21; "Outstanding Dividend  Interest"; Decimal)
        {
        }
        field(22; "Mode Of Disbursment"; Option)
        {
            Editable = true;
            OptionCaption = 'Transfer to Cash Office,Tranfer to Deposits,EFT,Transfer to Withdrawable Savings,Transfer to Shares,Clear Loan';
            OptionMembers = "Transfer to Cash Office","Tranfer to Deposits",EFT,"Transfer to Withdrawable Savings","Transfer to Shares","Clear Loan";
        }
        field(23; "Document No"; Code[10])
        {
        }
        field(24; "Banke Details"; Code[20])
        {
        }
        field(25; "Withdrawable acc"; Code[20])
        {
            CalcFormula = lookup(Vendor."No." where("BOSA Account No" = field("Member No"),
                                                     "Vendor Posting Group" = const('WITHDRAWABLE')));
            FieldClass = FlowField;
        }
        field(26; "Savings Account"; Code[20])
        {
            CalcFormula = lookup(Vendor."No." where("BOSA Account No" = field("Member No"),
                                                     "Vendor Posting Group" = const('CURRENT')));
            FieldClass = FlowField;
        }
        field(27; "Div Sim"; Decimal)
        {
            CalcFormula = sum("Member Ledger Entry"."Debit Amount" where("Customer No." = field("Member No"),
                                                                          "Transaction Type" = const(Dividend),
                                                                          Reversed = const(false),
                                                                          "Document No." = const('DIV2018'),
                                                                          Description = filter('Dividend Pay*')));
            FieldClass = FlowField;
        }
        field(28; grossdividend; Decimal)
        {
        }
        field(29; "Gross Interest On Deposits"; Decimal)
        {
        }
        field(30; "Net Interest On Deposits"; Decimal)
        {
        }
        field(31; "Recovered Insurance"; Decimal)
        {
            Editable = false;
        }
        field(32; "Recovered Interest"; Decimal)
        {
            Editable = false;
        }
        field(33; "Recovered Principal"; Decimal)
        {
            Editable = false;
        }
        field(34; "Employer Code"; Code[20])
        {
            Editable = false;
        }
        field(35; "Employer Name"; Text[100])
        {
            Editable = false;
        }
        field(36; "Eoy Deposits"; Decimal)
        {
            Editable = false;
        }
        field(37; "Eoy Share Capital"; Decimal)
        {
            Editable = false;
        }
        field(38; "Net Payable To Member"; Decimal)
        {
            Editable = false;
        }
        field(39; "Skip Arrears"; Boolean)
        {
        }
        field(40; Processed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(41; "Dont Pay"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(42; Pay; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(43; "Amount Payed"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(44; "Loan No."; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Loans Register"."Loan  No." where("Client Code" = field("Member No"));

            trigger OnValidate()
            begin
                LoanApp.Reset;
                LoanApp.SetRange(LoanApp."Loan  No.", "Loan No.");
                if LoanApp.Get("Loan No.") then
                    LoanApp.CalcFields(LoanApp."Oustanding Interest", LoanApp."Outstanding Balance");
                "Outstanding Bal" := LoanApp."Outstanding Balance";
                "outstandining Interest" := LoanApp."Oustanding Interest";
            end;
        }
        field(45; "Outstanding Bal"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(46; "outstandining Interest"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(47; "Pay Loan"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(48; "Pay to Loan"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(49; "Pay to Deposit"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50; TRANSFER; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51; "Payroll no"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(52; "Share Capital"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(53; "Amount To Loan"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(54; "Amount To interest"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(55; "Amount To Bank"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Member No", "Dividend year", "Payroll no")
        {
            Clustered = true;
        }
        key(Key2; "Payroll no")
        {
        }
    }

    fieldgroups
    {
    }

    var
        TransType: Option ,"Registration Fee",Loan,Repayment,"Interest Due","Interest Paid","Deposit Contribution","Shares Capital",Dividend,"Insurance Contribution","Demand Savings","Insurance Charge","Retained Shares","Demand Savings Withdrawal","Stock Due","Stock paid","Insurance Benefits","Demand Activation",ByLaws,"Dividend Advance","Rejoining Fee","Unallocated Funds","Life Assurance","STO Charges","T-Shirts",Umbrella;
        LoanApp: Record "Loans Register";


    procedure GetPostedDiv(TransactionType: Option ,"Registration Fee",Loan,Repayment,"Interest Due","Interest Paid","Deposit Contribution","Shares Capital",Dividend,"Insurance Contribution","Demand Savings","Insurance Charge","Retained Shares","Demand Savings Withdrawal","Stock Due","Stock paid","Insurance Benefits","Demand Activation",ByLaws,"Dividend Advance","Rejoining Fee","Unallocated Funds","Life Assurance","STO Charges","T-Shirts",Umbrella) ReturnValue: Decimal
    var
        MemLed: Record "Member Ledger Entry";
    begin
        ReturnValue := 0;
        MemLed.Reset;
        MemLed.SetRange("Customer No.", Rec."Member No");
        MemLed.SetRange("Transaction Type", TransactionType);
        MemLed.SetRange(Reversed, false);
        MemLed.SetRange("Document No.", 'DIV-' + Format(Date2dmy(CalcDate('-CY-1D', Today), 3)));
        MemLed.SetFilter(Amount, '<0');
        if MemLed.FindFirst then begin
            MemLed.CalcSums(Amount);
            ReturnValue := MemLed.Amount * -1;
        end;
    end;
}

