#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 56120 "SwizzKash Transactions"
{

    fields
    {
        field(1; "Account No"; Code[30])
        {
        }
        field(2; "Account Name"; Text[50])
        {
        }
        field(3; "Document No"; Code[30])
        {
        }
        field(4; "Document Date"; Date)
        {
        }
        field(5; "Transaction Time"; Time)
        {
        }
        field(6; "Transaction Type"; Option)
        {
            OptionCaption = ' ,Withdrawal,Deposit,Balance,Ministatement,Airtime,Loan balance,Loan Status,Share Deposit Balance,Transfer to Fosa,Transfer to Bosa,Utility Payment,Loan Application,Standing orders,Loan Repayment';
            OptionMembers = " ",Withdrawal,Deposit,Balance,Ministatement,Airtime,"Loan balance","Loan Status","Share Deposit Balance","Transfer to Fosa","Transfer to Bosa","Utility Payment","Loan Application","Standing orders","Loan Repayment";
        }
        field(7; "Telephone Number"; Code[30])
        {
        }
        field(8; Posted; Boolean)
        {
        }
        field(9; "Date Posted"; DateTime)
        {
        }
        field(10; "Account No2"; Text[30])
        {
        }
        field(11; "Loan No"; Code[30])
        {
            Editable = false;
        }
        field(12; Status; Option)
        {
            OptionCaption = 'Pending,Completed,Failed';
            OptionMembers = Pending,Completed,Failed;
        }
        field(13; Comments; Text[50])
        {
        }
        field(14; Amount; Decimal)
        {
        }
        field(15; Charge; Decimal)
        {
        }
        field(16; Description; Text[100])
        {
        }
        field(17; TraceId; Text[30])
        {
        }
        field(18; Entry; Integer)
        {
            AutoIncrement = true;
        }
        field(20; Client; Code[50])
        {
        }
        field(21; "Posting Date"; Date)
        {
        }
        field(22; "SMS Message"; Text[250])
        {
        }
        field(23; "APP Type"; Code[50])
        {
        }
        field(24; Remarks; Text[200])
        {
        }

        field(25; TransType; Integer)
        {
            Editable = false;
        }
        field(26; time; Time)
        {
            Editable = false;
        }
        field(31; "Outstanding Balance"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Loan No" = field("Loan No"),
                                                                  "Transaction Type" = filter(Loan | "Loan Repayment"),
                                                                  Reversed = const(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(32; "Outstanding Interest"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Loan No" = field("Loan No"),
                                                                  "Transaction Type" = filter("Interest Due" | "Interest Paid"),
                                                                  Reversed = const(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(33; "Loan Period"; Integer) { }
    }

    keys
    {
        key(Key1; Entry, "Document No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

