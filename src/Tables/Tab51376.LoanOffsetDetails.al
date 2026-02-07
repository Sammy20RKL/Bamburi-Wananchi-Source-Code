#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51376 "Loan Offset Details"
{
    DrillDownPageID = "Loan Offset Detail List";
    LookupPageID = "Loan Offset Detail List";

    fields
    {
        field(1; "Loan No."; Code[20])
        {
            TableRelation = "Loans Register"."Loan  No.";

            trigger OnValidate()
            begin
                //Commision:=ROUND(GenSetUp."Loan Top Up Commision(%)"*(ObjLoans."Requested Amount"-Loans."Outstanding Balance")/100,1,'>');//ADDED BY NTHALE
            end;
        }
        field(2; "Loan Top Up"; Code[20])
        {
            TableRelation = "Loans Register"."Loan  No." where("Client Code" = field("Client Code"),
                                                                Posted = const(true),
                                                                "Outstanding Balance" = filter(> 0));

            trigger OnValidate()
            var
                Amtt: Decimal;
            begin
                if Confirm('Are you sure you want to offset this loan?', true) = true then begin

                    "Loan Type" := '';
                    "Principle Top Up" := 0;
                    "Interest Top Up" := 0;
                    "Total Top Up" := 0;

                    ObjRepaymentSchedule.Reset;
                    ObjRepaymentSchedule.SetRange("Loan No.", "Loan Top Up");
                    ObjRepaymentSchedule.SetFilter("Repayment Date", '>%1', Today);
                    if ObjRepaymentSchedule.Find('-') then
                        "Remaining Installments" := ObjRepaymentSchedule.Count;

                    ObjRepaymentSchedule.Reset;
                    ObjRepaymentSchedule.SetRange("Loan No.", "Loan Top Up");
                    ObjRepaymentSchedule.SetFilter("Repayment Date", '<=%1', Today);
                    if ObjRepaymentSchedule.Find('-') then
                        "Loan Age" := ObjRepaymentSchedule.Count;

                    Loans.Reset;
                    Loans.SetRange(Loans."Loan  No.", "Loan No.");
                    if Loans.Find('-') then begin
                        ApplicationDate := Loans."Application Date";
                        RequstedAmount := Loans."Requested Amount";
                    end;

                    Loans.Reset;
                    Loans.SetRange(Loans."Loan  No.", "Loan Top Up");
                    if Loans.Find('-') then begin
                        Loans.CalcFields(Loans."Outstanding Balance", Loans."Interest Due", Loans."Oustanding Interest");
                        "Interest Rate" := Loans.Interest;
                        "Interest Due at Clearance" := ((0.01 * Loans."Approved Amount" + 0.01 * Loans."Outstanding Balance") * Loans.Interest / 12 * ("Loan Age")) / 2 - "Interest Paid";
                        "Principle Top Up" := Loans."Outstanding Balance";
                        "Interest Top Up" := Loans."Oustanding Interest";

                        // Festus -- Swizzsoft
                        Commision := calculateCommission("Loan Top Up", "Principle Top Up", "Interest Top Up");
                        "Total Top Up" := "Principle Top Up" + "Interest Top Up" + Commision;
                        "Outstanding Balance" := Loans."Outstanding Balance";
                        "Monthly Repayment" := Loans.Repayment;
                    end;
                    Loans.Bridged := true;
                    Loans.Modify
                end;
            end;
        }
        field(3; "Client Code"; Code[20])
        {
        }
        field(4; "Loan Type"; Code[30])
        {
        }
        field(5; "Principle Top Up"; Decimal)
        {

            trigger OnValidate()
            begin

                // Festus -- Swizzsoft
                Commision := calculateCommission("Loan Top Up", "Principle Top Up", "Interest Top Up");
                "Total Top Up" := "Principle Top Up" + "Interest Top Up" + Commision;

            end;
        }
        field(6; "Interest Top Up"; Decimal)
        {

            trigger OnValidate()
            begin
                // Festus -- Swizzsoft
                Commision := calculateCommission("Loan Top Up", "Principle Top Up", "Interest Top Up");
                "Total Top Up" := "Principle Top Up" + "Interest Top Up" + Commision;
            end;
        }
        field(7; "Total Top Up"; Decimal)
        {
        }
        field(8; "Monthly Repayment"; Decimal)
        {
        }
        field(9; "Interest Paid"; Decimal)
        {
            CalcFormula = - sum("Member Ledger Entry".Amount where("Customer No." = field("Client Code"),
                                                                   "Loan No" = field("Loan Top Up"),
                                                                   "Transaction Type" = filter("Interest Paid")));
            FieldClass = FlowField;
        }
        field(10; "Outstanding Balance"; Decimal)
        {
            FieldClass = Normal;
        }
        field(11; "Interest Rate"; Decimal)
        {
            CalcFormula = sum("Loans Register".Interest where("Loan  No." = field("Loan Top Up"),
                                                               "Client Code" = field("Client Code")));
            FieldClass = FlowField;
        }
        field(12; "ID. NO"; Code[20])
        {
        }
        field(13; Commision; Decimal)
        {

            // trigger OnValidate()
            // begin
            //     // "Total Top Up":="Principle Top Up" +"Interest Top Up";
            //     Commision := 0;
            //     GenSetUp.Get;

            //     // Commision:=("Principle Top Up")*GenSetUp."Loan Top Up Commision(%)"/100;
            //     Commision := ROUND(((("Total Top Up" - LoanApp."Requested Amount")) * GenSetUp."Loan Top Up Commision(%)" / 100), 1, '=');
            // end;
        }
        field(14; "Partial Bridged"; Boolean)
        {

            trigger OnValidate()
            begin

                LoansTop.Reset;
                LoansTop.SetRange(LoansTop."Loan  No.", "Loan Top Up");
                if LoansTop.Find('-') then begin
                    if "Partial Bridged" = true then
                        LoansTop."partially Bridged" := true;
                    LoansTop.Modify;
                end;
            end;
        }
        field(15; "Remaining Installments"; Decimal)
        {
        }
        field(16; "Finale Instalment"; Decimal)
        {
        }
        field(17; "Penalty Charged"; Decimal)
        {

            trigger OnValidate()
            begin
                //0.1*"Principle Top Up";
            end;
        }
        field(18; "Staff No"; Code[20])
        {
        }
        field(19; "Commissioning Balance"; Decimal)
        {

            trigger OnValidate()
            begin
                // GenSetUp.GET();
                // //Commision:=ROUND(("Commissioning Balance")*(GenSetUp."Top up Commission"/100),1,'>');
                // Commision:=ROUND(GenSetUp."Loan Top Up Commision(%)"*(ObjLoans."Recommended Amount"-Loans."Outstanding Balance")/100,1,'>');//ADDED BY NTHALE
                // "Total Top Up":="Principle Top Up" +"Interest Top Up";
            end;
        }
        field(20; "Interest Due at Clearance"; Decimal)
        {
        }
        field(21; "Loan Age"; Integer)
        {
        }
        field(22; "BOSA No"; Code[50])
        {
        }
        field(23; "50% of Initial Loan"; Decimal)
        {
        }
        field(24; "FOSA Account"; Code[30])
        {
            TableRelation = Vendor."No." where("BOSA Account No" = field("Client Code"));
        }
        field(25; "Loan Offset From FOSA"; Boolean)
        {
        }
        field(26; "Loan Offset From FOSA Date"; Date)
        {
        }
        field(27; "Loan Offset From FOSA By"; Code[30])
        {
        }
        field(28; "Additional Top Up Commission"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(29; "Arrear Recovery Status"; Option)
        {
            OptionMembers = None,Pending,Confirmed;
            OptionCaption = 'None,Pending,Confirmed';
            DataClassification = ToBeClassified;
        }

        field(30; "LoanArrears"; Decimal)
        {

        }

        field(31; "Selected For Offset"; Boolean)
        {

        }
    }

    keys
    {
        key(Key1; "Loan No.", "Client Code", "Loan Top Up")
        {
            Clustered = true;
            SumIndexFields = "Total Top Up", "Principle Top Up";
        }
        key(Key2; "Principle Top Up")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Client Code", "Loan Type", "Principle Top Up", "Interest Top Up", "Total Top Up", "Monthly Repayment", "Interest Paid", "Outstanding Balance", "Interest Rate", Commision)
        {
        }
    }

    var
        Loans: Record "Loans Register";
        Loantypes: Record "Loan Products Setup";
        Interest: Decimal;
        Cust: Record Customer;
        LoansTop: Record "Loans Register";
        GenSetUp: Record "Sacco General Set-Up";
        ObjRepaymentSchedule: Record "Loan Repayment Schedule";
        ApplicationDate: Date;
        ObjLoans: Record "Loans Register";
        ObjLoanType: Record "Loan Products Setup";
        MinAmountforOffset: Decimal;
        LoanBal: Decimal;
        Text00: label 'Amount cannot be greater than the loan oustanding balance for%1.';
        Text001: label 'Amount cannot be greater than the loan oustanding balance for %1';
        LoanApp: Record "Loans Register";
        Loanbalance: Decimal;
        Commision1: Decimal;
        RequstedAmount: Decimal;

    procedure calculateCommission(loanNumber: Code[20]; principalOffset: Decimal; interestOffset: Decimal) commissionCharged: Decimal
    var
        commissionPercentage: Integer;
        isArrears: Boolean;
    begin
        commissionPercentage := 5;
        isArrears := false;
        commissionCharged := 0;

        //confirm if the loan is in Arrears
        ObjLoans.Reset();
        ObjLoans.SetRange(ObjLoans."Loan  No.", loanNumber);
        if ObjLoans.Find('-') then begin
            if ObjLoans."Amount in Arrears" < 0 then begin
                if Confirm('This loan has an arrears of ' + Format(ObjLoans."Amount in Arrears") + ', Do you want to Allow the commission to be 10%', true) = true then begin
                    isArrears := true;
                end;
            end;
        end;
        if isArrears = true then commissionPercentage := 10;

        //Calculate the commissionHere
        commissionCharged := ROUND(commissionPercentage / 100 * (principalOffset + interestOffset), 1, '>');

        exit(commissionCharged);
    end;
}

