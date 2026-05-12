tableextension 56013 CustLedgerEntryExt extends "Cust. Ledger Entry"
{

    fields
    {
        field(68000; "Transaction Type"; enum TransactionTypesEnum)
        {
            // Editable = true;
        }
        field(68001; "Loan No"; Code[20])
        {

            trigger OnValidate()
            begin
                Loans.Reset;
                Loans.SetRange(Loans."Loan  No.", "Loan No");
                if Loans.Find('-') then begin
                    if Loans.Source = Loans.Source::FOSA then begin
                        "FOSA Account No." := Loans."Client Code";
                        // Modify;
                    end;
                end;
            end;
        }
        field(68002; "Group Code"; Code[20])
        {
        }
        field(68003; Type; Option)
        {
            OptionCaption = ' ,Registration,PassBook,Loan Insurance,Loan Application Fee,Down Payment';
            OptionMembers = " ",Registration,PassBook,"Loan Insurance","Loan Application Fee","Down Payment";
        }
        field(68004; "Member Name"; Text[30])
        {
        }
        field(68005; "Loan Type"; Code[20])
        {
        }
        field(68006; "Prepayment Date"; Date)
        {
        }
        field(68007; Totals; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Document No." = filter('JUNE  15/06/14')));
            FieldClass = FlowField;
        }
        field(68009; "No Boosting"; Boolean)
        {
        }
        field(68010; "Posting Count"; Integer)
        {
        }
        field(68011; "Total Debits"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Transaction Type" = filter(Loan),
                                                                  "Loan Type" = field("Loan Type"),
                                                                  "Posting Date" = field("Posting Date")));
            FieldClass = FlowField;
        }
        field(68012; "Total Credits"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Transaction Type" = filter("Loan Repayment"),
                                                                  "Loan Type" = field("Loan Type"),
                                                                  "Posting Date" = field("Posting Date")));
            FieldClass = FlowField;
        }
        field(68013; "Group Account No"; Code[20])
        {
        }
        field(68014; "FOSA Account No."; Code[60])
        {
            TableRelation = Vendor."No.";
        }
        field(68015; "Loan Source"; ENUM Sources)
        {
            // CalcFormula = lookup("Loans Register".Source where("Loan  No." = field("Loan No")));
            FieldClass = FlowField;
        }
        field(68016; Loantype; Code[30])
        {
        }
        field(68017; "Payroll No"; Code[15])
        {
            CalcFormula = lookup(Customer."Payroll/Staff No" where("No." = field("Customer No.")));
            FieldClass = FlowField;
            Editable = false;
        }
        field(68018; "Customer ID No"; Code[50])
        {
        }
        field(68019; "Fosa ID Test"; Code[50])
        {
        }

        field(51516060; "Amount Posted"; Decimal)
        {

        }
        field(51516061; "Reversal Date"; Date)
        {
        }
        field(51516062; "Transaction Date"; Date)
        {
            Description = 'Actual Transaction Date(Workdate)';
            Editable = false;
        }
        field(51516064; "Created On"; DateTime)
        {
        }
        field(51516065; "Computer Name"; Text[30])
        {
        }
        field(51516066; "Time Created"; Time)
        {
        }


        field(7700; "BLoan Officer No."; Code[20])
        {
        }
        field(7701; "Loan Product Description"; Text[100])
        {
        }
        field(7702; Source; Option)
        {
            OptionCaption = 'BOSA,FOSA,Investment,MICRO';
            OptionMembers = BOSA,FOSA,Investment,MICRO;
            InitValue = "BOSA";
        }
        field(7703; "Staff/Payroll No."; Code[20])
        {
        }
        field(7704; "Last Date Modified"; Date)
        {
        }
        field(7705; "Loan product Type"; Code[20])
        {
        }
        field(7706; "Employer Code"; Code[50])
        {
        }
        field(7707; "Transaction Source"; Option)
        {
            OptionCaption = ',Salary Processing,Checkoff Processing,Cashier Receipt,BackOffice Receipt,Autorecovery,Funds Transfer';
            OptionMembers = ,"Salary Processing","Checkoff Processing","Cashier Receipt","BackOffice Receipt",Autorecovery,"Funds Transfer";
        }
    }
    keys
    {
        key(Key36; "Transaction Type")
        {
        }
        key(Key37; "Amount Posted")
        {
        }
        key(Key38; "Entry No.")
        {

        }
    }
    trigger OnInsert()
    begin
        CalcFields(Amount);
        if (amount <> 0) then begin
            "Amount Posted" := Amount;
        end;
    end;

    var
        Text000: label 'must have the same sign as %1';
        Text001: label 'must not be larger than %1';
        Loans: Record "Loans Register";
        MembersRegister: Record Customer;

}
