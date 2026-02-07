#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51069 "Loan Rescheduling"
{

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    SaccoSetup.Get;
                    NoSeriesMgt.TestManual(SaccoSetup."Reschedule No.s");
                    "No. Series" := '';
                end
            end;
        }
        field(2; "Member No"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No." where("Outstanding Balance" = filter(> 0));
        }
        field(3; "Loan No"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Loans Register"."Loan  No." where("Client Code" = field("Member No"),
                                                                "Outstanding Balance" = filter(> 0));

            trigger OnValidate()
            begin
                if Loans.Get("Loan No") then begin
                    Loans.CalcFields(Loans."Outstanding Balance");
                    "Previous Disbursement Date" := Loans."Loan Disbursement Date";
                    "Principle Amount" := Loans."Approved Amount";
                    //"Outstanding Balance":=Loans."Outstanding Balance";
                    "Loan Product Type" := Loans."Loan Product Type";
                    RepayMethod := Loans."Repayment Method";
                    Interests := Loans.Interest;
                end;
            end;
        }
        field(4; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Previous Disbursement Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Principle Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Outstanding Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Repayment Start Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Loan Completion Date" := CalcDate(Format(Installments) + 'M', "Repayment Start Date");
            end;
        }
        field(9; "Loan Completion Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(10; Installments; Integer)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //Interests:=Installments;
            end;
        }
        field(11; Interests; Integer)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if LoanType.Get("Loan Product Type") then begin
                    //IF "Loan Product Type"='SCHOOL' THEN BEGIN
                    Interests := LoanType."Interest rate";
                end;
            end;
        }
        field(12; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Rescheduled By"; Code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Captured By"; Code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Capture Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(16; Rescheduled; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Repayment Frequency"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Daily,Weekly,Monthly,Quaterly';
            OptionMembers = Daily,Weekly,Monthly,Quaterly;
        }
        field(18; "Loan Product Type"; Code[30])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if LoanType.Get("Loan Product Type") then begin
                    //IF "Loan Product Type"='SCHOOL' THEN BEGIN
                    Interests := LoanType."Interest rate";
                end;
                //END;
            end;
        }
        field(19; RepayMethod; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Amortised,Reducing Balance,Straight Line,Constants';
            OptionMembers = Amortised,"Reducing Balance","Straight Line",Constants;
        }
        field(20; "Loan Disbursement Date"; Date)
        {

            trigger OnValidate()
            begin
                if "Loan Disbursement Date" > Today then
                    Error('You cannot Post on Future Date....Check Issue Date');


                GenSetUp.Get;

                currYear := Date2dmy(Today, 3);
                StartDate := 0D;
                EndDate := 0D;
                Month := Date2dmy("Loan Disbursement Date", 2);
                DAY := Date2dmy("Loan Disbursement Date", 1);

                StartDate := Dmy2date(1, Month, currYear); // StartDate will be the date of the first day of the month

                if Month = 12 then begin
                    Month := 0;
                    currYear := currYear + 1;

                end;


                EndDate := Dmy2date(1, Month + 1, currYear) - 1;

                if DAY <= 15 then begin
                    "Repayment Start Date" := CalcDate('CM', "Loan Disbursement Date");
                end else begin
                    "Repayment Start Date" := CalcDate('CM', CalcDate('CM+1M', "Loan Disbursement Date"));
                end;
                Validate("Repayment Start Date");
                DateFilter := '..' + Format("Loan Disbursement Date");
                Loans.Reset;
                Loans.SetRange(Loans."Loan  No.", "Loan No");
                Loans.SetFilter(Loans."Date filter", DateFilter);
                if Loans.Find('-') then begin
                    Loans.CalcFields("Outstanding Balance");
                    Message(Format(Loans."Outstanding Balance"));
                    "Outstanding Balance" := Loans."Outstanding Balance";
                    Modify;
                end;

            end;
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
            SaccoSetup.Get;
            SaccoSetup.TestField(SaccoSetup."Reschedule No.s");
            //  NoSeriesMgt.InitSeries(SaccoSetup."Reschedule No.s", xRec."No. Series", 0D, "No.", "No. Series");

        end;
        "Captured By" := UpperCase(UserId);
        "Capture Date" := Today;
        "Repayment Frequency" := "repayment frequency"::Monthly;
    end;

    var
        SaccoSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit "No. Series";
        Loans: Record "Loans Register";
        LoanType: Record "Loan Products Setup";
        DAY: Integer;
        CurrExchRate: Record "Currency Exchange Rate";
        RepaySched: Record "Loan Repayment Schedule";
        currYear: Integer;
        StartDate: Date;
        EndDate: Date;
        Month: Integer;
        GLSetup: Record "General Ledger Setup";
        Users: Record User;
        GenSetUp: Record "Sacco General Set-Up";
        DateFilter: Text;
}

