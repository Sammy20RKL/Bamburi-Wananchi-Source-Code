table 50601 "Member Provisioning Lines"
{

    fields
    {
        field(1; "Transaction No"; Code[20])
        {

        }
        field(2; "Loan No"; Code[20])
        {
            Caption = 'Loan No';
            TableRelation = "Loans Register"."Loan  No.";
        }
        field(3; "Member No"; Code[20])
        {
            TableRelation = Customer."No.";
            Caption = 'Member No';
            trigger OnValidate()
            var
                Customer: Record Customer;
            begin
                if "Member No" = '' then begin
                    "Member Name" := '';
                    exit;
                end;

                if Customer.Get("Member No") then begin
                    "Member Name" := Customer.Name;
                end else begin
                    "Member Name" := '';
                    Error('Customer %1 does not exist.', "Member No");
                end;
            end;
        }
        field(4; "Member Name"; Text[150])
        {
            Caption = 'Member Name';
        }
        field(5; "Loan Type"; Code[20])
        {
            Caption = 'Loan Type';
            TableRelation = "Loan Products Setup".Code;

            trigger OnValidate()
            var
                LoanProductsSetup: Record "Loan Products Setup";
            begin
                if "Loan Type" = '' then begin
                    "Loan Product Name" := '';
                    exit;
                end;

                if LoanProductsSetup.Get("Loan Type") then begin
                    "Loan Product Name" := LoanProductsSetup."Product Description";
                    "Interest Rate" := loanProductsSetup."Interest Rate";
                end else begin
                    "Loan Product Name" := '';
                    Error('Loan product %1 does not exist.', "Loan Type");
                end;
            end;
        }
        field(6; "Issue Date"; DateTime)
        {
            Caption = 'Issue Date';
        }
        field(7; "Approved Amount"; Decimal)
        {
            Caption = 'Approved Amount';
        }
        field(8; "Schedule Principal"; Decimal)
        {
            Caption = 'Schedule Principal';
        }
        field(9; "Principal Received"; Decimal)
        {
            Caption = 'Principal Received';
        }
        field(10; "Principal Arrears"; Decimal)
        {
            Caption = 'Principal Arrears';
        }
        field(11; "Outstanding Balance"; Decimal)
        {
            Caption = 'Outstanding Balance';
        }
        field(12; "To Date"; DateTime)
        {
            Caption = 'To Date';
        }
        field(13; "Repayment"; Decimal)
        {
            Caption = 'Repayment';
        }
        field(14; "Loans Category(PAR)"; Option)
        {
            OptionMembers = Current,"PAR 1-30","PAR 31-60","PAR 61-90","PAR 90+";
            OptionCaption = 'Current,PAR 1-30,PAR 31-60,PAR 61-90,PAR 90+';
        }
        field(15; "Installement Arrears"; Decimal)
        {
            Caption = 'Installement Arrears';
        }
        field(16; "Days in Arrears"; Decimal)
        {
            Caption = 'Days in Arrears';
        }
        field(17; "Installements"; Integer)
        {
            Caption = 'Installements';
        }
        field(18; "Maturity Date"; DateTime)
        {
            Caption = 'Maturity Date';
        }
        field(19; "Repayment Method"; Option)
        {
            Caption = 'Repayment Method';
            OptionMembers = Cash,Checkoff,"Standing Order",Mobile;
            OptionCaption = 'Cash,Checkoff,Standing Order,Mobile';
        }
        field(20; "Repayment Frequency"; Integer)
        {
            Caption = 'Repayment Frequency';
        }
        field(21; "Employer Code"; Code[20])
        {
            Caption = 'Employer Code';
        }
        field(22; "Employer Name"; Text[50])
        {
            Caption = 'Employer Name';
        }
        field(23; "Loan Product Name"; Text[50])
        {
            Caption = 'Loan Product Name';
        }
        field(24; "Interest Rate"; Decimal)
        {
            Caption = 'Interest Rate';
        }
        field(25; "Last Pay Date"; DateTime)
        {
            Caption = 'Last Pay Date';
        }
        field(26; "Account Manager Code"; Code[20])
        {
            Caption = 'Account Manager Code';
        }
        field(27; "Account Manager Name"; Text[60])
        {
            Caption = 'Account Manager Name';
        }
        field(28; "Branch Code"; Text[50])
        {
            Caption = 'Branch Code';
        }
        field(29; "Lending Methodology"; Integer)
        {
            Caption = 'Lending Methodology';
        }
        field(30; "Sector of Activity"; Integer)
        {
            Caption = 'Sector of Activity';
        }
        field(31; "Loan Size"; Option)
        {
            Caption = 'Loan Size';
            OptionMembers = "Below 10K","10K-50K","50K-100K","100K-500K","500K-1M","1M-3M","3M-5M","5M-10M","Above 10M";
            OptionCaption = 'Below 10K,10K-50K,50K-100K,100K-500K,500K-1M,1M-3M,3M-5M,5M-10M,Above 10M';
        }
        field(32; "Term of the Loan"; Option)
        {
            Caption = 'Term of the Loan';
            OptionMembers = "Below 12 Months","12-24 Months","24-36 Months","36-48 Months","Above 48 Months";
            OptionCaption = 'Below 12 Months,12-24 Months,24-36 Months,36-48 Months,Above 48 Months';
        }
    }

    keys
    {
        key(PK; "Transaction No", "Loan No")
        {
            Clustered = true;
        }
    }
}
