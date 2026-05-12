table 50551 "Loan Recovery List"
{
    // DrillDownPageID = UnknownPage51516389;
    // LookupPageID = UnknownPage51516389;

    fields
    {
        field(1; "Document No"; Code[20])
        {
            TableRelation = "Loan Recovery Header"."Document No";
        }
        field(2; "Loan No."; Code[20])
        {
            TableRelation = if (Source = const(FOSA)) "Loans Register"."Loan  No." where("Client Code" = field("BOSA Account No"), Source = field(Source))
            else
            "Loans Register"."Loan  No." where("Client Code" = field("Member No"), Source = field(Source), "Outstanding Balance" = filter(> 0));
            trigger OnValidate()
            begin
                Loans.Reset;
                Loans.SetRange(Loans."Loan  No.", "Loan No.");
                Loans.SetAutoCalcFields(Loans."Outstanding Balance", loans."Oustanding Interest");
                if loans.find('-') then begin
                    "Approved Loan Amount" := Loans."Approved Amount";
                    "Loan Instalments" := Loans.Installments;
                    "Interest Rate" := Loans.Interest;
                    "Loan Type" := Loans."Loan Product Type";
                    "Outstanding Balance" := Loans."Outstanding Balance";
                    "Outstanding Interest" := Loans."Oustanding Interest";
                    "Amount In Arrears" := FnGetLoanArrears("Loan No.");
                end;
            end;
        }
        field(3; "Member No"; Code[20])
        {
            TableRelation = if (Source = const(BOSA)) Customer."No." where("Customer Posting Group" = const('MEMBER'))
            else
            if (Source = const(FOSA)) Vendor."No."
            else
            if (Source = const(MICRO)) Customer."No." where("Customer Posting Group" = const('MICRO'));
            trigger OnValidate()
            var
                Cust: Record Customer;
                Vendor: Record Vendor;
            begin
                if Source = Source::BOSA then begin
                    Cust.Reset();
                    cust.SetRange(cust."No.", "Member No");
                    if cust.find('-') then begin
                        "Member Name" := cust.Name;
                        "ID. NO" := cust."ID No.";
                        "BOSA Account No" := "Member No";
                    end;
                end else
                    if Source = Source::FOSA then begin
                        Vendor.Reset();
                        Vendor.SetRange(Vendor."No.", "Member No");
                        if Vendor.find('-') then begin
                            "Member Name" := Vendor.Name;
                            "ID. NO" := Vendor."ID No.";
                            "BOSA Account No" := Vendor."BOSA Account No";
                        end;
                    end else
                        if Source = Source::MICRO then begin
                            Cust.Reset();
                            cust.SetRange(cust."No.", "Member No");
                            if cust.find('-') then begin
                                "Member Name" := cust.Name;
                                "ID. NO" := cust."ID No.";
                                "BOSA Account No" := "Member No";
                            end;
                        end else begin
                            Error('Loan Source is required');
                        end;
            end;

        }
        field(4; "Loan Type"; Code[20])
        {
        }
        field(5; "Approved Loan Amount"; Decimal)
        {
        }
        field(6; "Loan Instalments"; Decimal)
        {
        }
        field(7; "Monthly Repayment"; Decimal)
        {
        }
        field(8; "Outstanding Balance"; Decimal)
        {
        }
        field(9; "Outstanding Interest"; Decimal)
        {
        }
        field(10; "Interest Rate"; Decimal)
        {
        }
        field(11; "ID. NO"; Code[20])
        {
        }
        field(13; Posted; Boolean)
        {
        }
        field(14; "Posting Date"; Date)
        {
        }
        field(19; "Amount In Arrears"; Decimal)
        {
        }
        field(26; "Member Name"; Code[50])
        {
        }
        field(27; "Total Amount To Recover"; Decimal)
        {

        }
        field(28; "Principal Amount To Recover"; Decimal)
        {

        }
        field(29; "Interest Amount To Recover"; Decimal)
        {

        }
        field(30; Source; enum LoanSourcesEnum)
        {
            InitValue = BOSA;

        }
        field(31; "BOSA Account No"; Code[50])
        {
            TableRelation = Customer."No.";
        }
    }

    keys
    {
        key(Key1; "Document No", "Member No", "Loan No.")
        {
            Clustered = true;
        }
        key(Key2; "Approved Loan Amount")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Member No", "Loan Type", "Approved Loan Amount", "Loan Instalments", "Monthly Repayment", "Outstanding Balance", "Outstanding Interest", "Interest Rate", "ID. NO", Posted)
        {
        }
    }

    var
        Loans: Record "Loans Register";
        Loantypes: Record "Loan Products Setup";
        Interest: Decimal;
        Cust: Record Customer;
        GenSetUp: Record "Sacco General Set-Up";

    local procedure FnGetLoanArrears(LoanNo: Code[20]): Decimal
    var
        SasraClassificationCodeUnit: Codeunit "Loan Classification-SASRA";
        loansreg: Record "Loans Register";
    begin
        SasraClassificationCodeUnit.ClassifyLoansSASRA(LoanNo, '..' + Format(Today));
        loansreg.Reset();
        loansreg.SetRange(loansreg."Loan  No.", LoanNo);
        if loansreg.Find('-') then begin
            exit(loansreg."Amount in Arrears");
        end;
        exit(0);
    end;
}

