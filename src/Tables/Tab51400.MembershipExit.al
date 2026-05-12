#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51400 "Membership Exit"
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
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                GenSetup.Get();
                IntTotal := 0;
                LoanTotal := 0;
                "User ID" := UserId;
                "Mode Of Disbursement" := "mode of disbursement"::"Bank Account";
                //*********************Restrict No of Withdrawals******************************//
                Closure.Reset;
                Closure.SetRange(Closure."Member No.", "Member No.");
                Closure.SetRange(Closure.Posted, false);
                if Closure.Find('-') then begin
                    Error('The Member has another withdrawal application Closure No %1', Closure."No.");
                end;
                //*********************Restrict No of Withdrawals******************************//


                if Cust.Get("Member No.") then begin
                    Cust.CalcFields(Cust."Current Shares", Cust."Shares Retained");//
                    "Member Name" := Cust.Name;
                    "Member Deposits" := Cust."Current Shares";
                    "Unpaid Dividends" := Cust."Dividend Amount";
                    "Share Capital" := Cust."Shares Retained";
                    "Refundable Share Capital" := 0;
                    ///"Refundable Share Capital":=Cust."Shares Retained";

                    "Total Adds" := "Member Deposits" + "Unpaid Dividends";//+"Refundable Share Capital"
                                                                           //('Total Adds %1',"Total Adds");
                    "Member Guarantorship Liability" := SwizzsoftFactory.FnGetMemberLiability("Member No.");

                    Loans.Reset;
                    Loans.SetRange(Loans."Client Code", "Member No.");
                    Loans.SetRange(Loans.Posted, true);
                    Loans.SetRange(Loans.Source, Loans.Source::BOSA);
                    Loans.SetFilter(Loans."Outstanding Balance", '>0');
                    if Loans.Find('-') then begin
                        repeat
                            Loans.CalcFields(Loans."Outstanding Balance", Loans."Oustanding Interest");
                            // Get Interest For Member Loan
                            LoanInterest.Reset;
                            LoanInterest.SetRange("Loan No.", Loans."Loan  No.");
                            LoanInterest.SetRange(Posted, true);
                            LoanInterest.SetFilter("Interest Amount", '>0');
                            if LoanInterest.FindFirst then
                                IntTotal := IntTotal + Loans."Oustanding Interest";//IntTotal+LoanInterest."Outstanding Interest";
                                                                                   //MESSAGE('int amount %1',LoanInterest."Interest Amount");
                                                                                   //IntTotal:=IntTotal+Loans."Oustanding Interest";
                            LoanTotal := LoanTotal + Loans."Outstanding Balance";

                        until Loans.Next = 0;

                    end;
                end;
                GenSetup.Get;
                "Total Loan" := LoanTotal;
                "Total Interest" := IntTotal;
                "Ledger Fee" := GenSetup."Ledger Fee";
                //"Four Month Interest":="Total Interest"*GenSetup."Four Month Multiplier";

                //MESSAGE('total int %1',"Total Interest");
                "Total Lesses" := "Total Loan" + "Total Interest" + "Ledger Fee";
                "Net Payable to the Member" := "Total Adds" - "Total Lesses";
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
            OptionCaption = 'Withdrawal - Normal,Withdrawal - Death';
            OptionMembers = "Withdrawal - Normal","Withdrawal - Death";

            trigger OnValidate()
            begin


                if Cust.Get("Member No.") then begin
                    Cust.CalcFields(Cust."Current Shares", Cust."Shares Retained");//
                    "Member Name" := Cust.Name;
                    "Member Deposits" := Cust."Current Shares";
                    "Unpaid Dividends" := Cust."Dividend Amount";
                    "Share Capital" := Cust."Shares Retained";
                    if "Share Capital" < 20000 then begin
                        "Share Capital Deduction" := 20000 - "Share Capital";
                    end;
                    "Refundable Share Capital" := 0;
                    "Ledger Fee" := GenSetup."Ledger Fee";
                    if "Closure Type" = "closure type"::"Withdrawal - Death" then
                        "Refundable Share Capital" := Cust."Shares Retained";
                    "Member Guarantorship Liability" := SwizzsoftFactory.FnGetMemberLiability("Member No.");
                    "Total Adds" := "Member Deposits" + "Unpaid Dividends";//+"Refundable Share Capital";


                    Loans.Reset;
                    Loans.SetRange(Loans."Client Code", "Member No.");
                    Loans.SetRange(Loans.Posted, true);
                    Loans.SetRange(Loans.Source, Loans.Source::BOSA);
                    Loans.SetFilter(Loans."Outstanding Balance", '>0');
                    if Loans.Find('-') then begin
                        repeat
                            Loans.CalcFields(Loans."Outstanding Balance", Loans."Oustanding Interest");
                            IntTotal := IntTotal + Loans."Oustanding Interest";// IntTotal+Loans."Oustanding Interest";
                            LoanTotal := LoanTotal + Loans."Outstanding Balance";
                        until Loans.Next = 0;
                    end;
                end;

                "Total Loan" := LoanTotal;
                "Total Interest" := IntTotal;
                "Total Lesses" := "Total Loan" + "Total Interest" + "Ledger Fee" + "Share Capital Deduction";
                "Net Payable to the Member" := "Total Adds" - "Total Lesses";
                if "Closure Type" = "closure type"::"Withdrawal - Death" then begin
                    //"Total Loan":=0;
                    //"Total Interest":=0;
                    "Total Lesses" := 0;
                    "Net Payable to the Member" := "Total Adds";
                end;
            end;
        }
        field(12; "Mode Of Disbursement"; Option)
        {
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Employee,Member,Investor';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee,Member,Investor;
        }
        field(13; "Paying Bank"; Code[20])
        {
            TableRelation = if ("Mode Of Disbursement" = const("G/L Account")) "G/L Account"."No."
            else if ("Mode Of Disbursement" = const("Bank Account")) "Bank Account"."No.";

            trigger OnValidate()
            begin
                if ("Mode Of Disbursement" = "mode of disbursement"::"Bank Account") then begin
                    if "Paying Bank" = '' then
                        Error('You Must Specify the Paying bank');
                end;


                if "Net Payable to the Member" < 0 then
                    "Net Payable to the Member" := 0;
                Modify;
                Commit;
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
        field(18; "Risk Fund"; Decimal)
        {
        }
        field(19; "Risk Beneficiary"; Boolean)
        {
        }
        field(20; "Risk Refundable"; Decimal)
        {
        }
        field(21; "Total Adds"; Decimal)
        {
        }
        field(22; "Total Lesses"; Decimal)
        {
        }
        field(23; "Unpaid Dividends"; Decimal)
        {
        }
        field(24; "Total Loans FOSA"; Decimal)
        {
        }
        field(25; "Total Oustanding Int FOSA"; Decimal)
        {
        }
        field(26; "Net Payable to the Member"; Decimal)
        {
        }
        field(27; "Risk Fund Arrears"; Decimal)
        {
        }
        field(28; "Withdrawal Application Date"; Date)
        {

            trigger OnValidate()
            begin
                GenSetup.Get();
                if "Withdrawal Application Date" > Today then
                    Error(Text001);
                //IF "Withdrawal Application Date"<TODAY THEN
                // ERROR(Text002);
                /*
               IF "Withdrawal Application Date"=0D THEN
               "Withdrawal Application Date":=DATE;
                "Maturity Date":=CALCDATE('90D',"Withdrawal Application Date");
                IF "Withdrawal Application Date" <> 0D THEN
                 "Maturity Date":= "Withdrawal Application Date" + GenSetup."Memb.Withdrawl Maturity Period";
                IF "Expected Posting Date"=0D THEN
               "Application Date":=DATE;
                  "Expected Posting Date":=DATE;
               // IF "Posting Date"=0D THEN
                 "Posting Date":=DATE;
                // "Maturity Date":=DATE;
                */

            end;
        }
        field(29; "Reason For Withdrawal"; Option)
        {
            OptionCaption = 'Relocation,Financial Constraints,House/Group Challages,Join another Institution,Personal Reasons,Other';
            OptionMembers = Relocation,"Financial Constraints","House/Group Challages","Join another Institution","Personal Reasons",Other;
        }
        field(30; "Sell Share Capital to"; Code[20])
        {
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                // IF Cust.GET("Sell Share Capital to") THEN BEGIN
                //  "Sell Shares Member Name":=Cust.Name;
                //  END;
            end;
        }
        field(31; "Sell Shares Member Name"; Code[20])
        {
        }
        field(32; "Share Capital Transfer Fee"; Decimal)
        {
        }
        field(33; "Sell Share Capital"; Boolean)
        {

            trigger OnValidate()
            begin
                // GenSetup.GET();
                // "Share Capital Transfer Fee":=GenSetup."Share Capital Transfer Fee";
            end;
        }
        field(34; "Share Capital"; Decimal)
        {
        }
        field(35; "Share Capital to Sell"; Decimal)
        {
            CalcFormula = sum("M_Withdrawal Share Cap Sell".Amount where("Document No" = field("No.")));
            FieldClass = FlowField;
        }
        field(36; "Posting Date"; Date)
        {
        }
        field(37; "User ID"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(38; "Refundable Share Capital"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(39; "Application Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //"Maturity Date":=DATE;//CALCDATE('60D',"Application Date");
                //MESSAGE('test %1',"Maturity Date");
            end;
        }
        field(40; "Date Approved"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //"Expected Posting Date":=DATE;//CALCDATE('<60D>',"Date Approved");
            end;
        }
        field(41; "Expected Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(42; "Ten WIthdrawal"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(43; Overpayment; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(44; "Member Guarantorship Liability"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(45; "Maturity Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //"Maturity Date":=DATE;//CALCDATE('60D',"Application Date");
            end;
        }
        field(46; "Four Month Interest"; Decimal)
        {
            BlankZero = true;
            DataClassification = ToBeClassified;
        }
        field(47; "Ledger Fee"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(48; "Four Month Multiplier"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(49; "Share Capital Deduction"; Decimal)
        {
            DataClassification = ToBeClassified;
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
        MemLed: Record "Member Ledger Entry";
        IntTotal: Decimal;
        LoanTotal: Decimal;
        GenSetup: Record "Sacco General Set-Up";
        IntTotalFOSA: Decimal;
        LoanTotalFOSA: Decimal;
        Closure: Record "Membership Exit";
        Shares: Decimal;
        SwizzsoftFactory: Codeunit "Swizzsoft Factory.";
        LoanInterest: Record "Loans Interest";
        Text001: label 'Withdrawal Application Cannot Be In The Future.';
        Text002: label 'Withdrawal Application Cannot Be In The Past.';
        DATE: Date;
}

