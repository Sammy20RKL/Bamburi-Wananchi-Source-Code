#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
table 50339 "Member Monthly Contributions"
{
    DrillDownPageID = "Member Monthly Contributions";
    LookupPageID = "Member Monthly Contributions";

    fields
    {
        field(1; "No."; Code[20])
        {
            TableRelation = Customer;
        }
        field(2; Type; Option)
        {
            OptionCaption = ' ,Registration Fee,Loan,Repayment,Withdrawal,Interest Due,Interest Paid,Benevolent Fund,Deposit Contribution,Penalty Charged,Application Fee,Appraisal Fee,Investment,Unallocated Funds,Shares Capital,Loan Adjustment,Dividend,Withholding Tax,Administration Fee,Insurance Contribution,Prepayment,Withdrawable Deposits,Holiday_Savers,Penalty Paid,Dev Shares,Fanikisha,Welfare Contribution 2,Loan Penalty,Loan Guard,Gpange,Junior,Juja,Housing Water,Housing Title,Housing Main,M Pesa Charge ,Insurance Charge,Insurance Paid,FOSA Account,Partial Disbursement';
            OptionMembers = " ","Registration Fee",Loan,Repayment,Withdrawal,"Interest Due","Interest Paid","Benevolent Fund","Deposit Contribution","Penalty Charged","Application Fee","Appraisal Fee",Investment,"Unallocated Funds","Shares Capital","Loan Adjustment",Dividend,"Withholding Tax","Administration Fee","Insurance Contribution",Prepayment,"Withdrawable Deposits",Holiday_Savers,"Penalty Paid","Dev Shares",Fanikisha,"Welfare Contribution 2","Loan Penalty","Loan Guard",Gpange,Junior,Juja,"Housing Water","Housing Title","Housing Main","M Pesa Charge ","Insurance Charge","Insurance Paid","FOSA Account","Partial Disbursement";

            trigger OnValidate()
            begin
                if Type = Type::"Registration Fee" then begin
                    Descripition := 'Registration Fee';
                    "Check Off Priority" := 1;
                end else
                    if Type = Type::Loan then begin
                        Descripition := 'Loan Repayment';

                    end else
                        if Type = Type::"Benevolent Fund" then begin
                            Descripition := 'BBF';
                        end else
                            if Type = Type::"Interest Due" then begin
                                Descripition := 'Interest Due';
                            end else
                                if Type = Type::"Interest Paid" then begin
                                    Descripition := 'Interest Paid';
                                end else
                                    if Type = Type::"FOSA Account" then begin
                                        Descripition := 'Interest Paid';
                                    end else
                                        if Type = Type::"Deposit Contribution" then begin
                                            Descripition := 'Deposit Contribution';
                                        end;
            end;
        }
        field(3; "Amount ON"; Decimal)
        {

            trigger OnValidate()
            begin
                "Last Advice Date" := Today;


                Customer.Reset;
                Customer.SetRange(Customer."No.", "No.");
                if Customer.Find('-') then begin
                    LoanApps.Reset;
                    LoanApps.SetRange(LoanApps."Loan  No.", "Loan No");
                    if LoanApps.Find('-') then begin
                        if LoanTypes.Get(LoanApps."Loan Product Type") then begin
                            //IF Customer.GET(LoanApps."Client Code") THEN BEGIN
                            //Loans."Staff No":=Customer."Payroll/Staff No";
                            if (Type = Type::Loan) or (Type = Type::Repayment) then begin
                                DataSheet.Reset;
                                DataSheet.SetRange(DataSheet."PF/Staff No", Customer."Payroll/Staff No");
                                //DataSheet.SETRANGE(DataSheet."Type of Deduction",'SLOAN');
                                DataSheet.SetRange(DataSheet."Remark/LoanNO", LoanApps."Loan  No.");
                                DataSheet.SetRange(DataSheet."ID NO.", Customer."ID No.");
                                if DataSheet.Find('-') then begin
                                    DataSheet.Delete;
                                end;
                                DataSheet.Reset;
                                DataSheet.SetRange(DataSheet."PF/Staff No", Customer."Payroll/Staff No");
                                //DataSheet.SETRANGE(DataSheet."Type of Deduction",'SLOAN');
                                DataSheet.SetRange(DataSheet."Remark/LoanNO", LoanApps."Loan  No.");
                                DataSheet.SetRange(DataSheet."ID NO.", Customer."ID No.");
                                if DataSheet.Find('-') then begin

                                    DataSheet."PF/Staff No" := Customer."Payroll/Staff No";
                                    DataSheet."Type of Deduction" := LoanTypes."Product Description";
                                    DataSheet."Remark/LoanNO" := LoanApps."Loan  No.";
                                    DataSheet.Name := Customer.Name;
                                    DataSheet."ID NO." := Customer."ID No.";
                                    DataSheet."Principal Amount" := LoanApps."Loan Principle Repayment";
                                    DataSheet."Interest Amount" := LoanApps."Loan Interest Repayment";
                                    DataSheet."Amount ON" := "Amount ON";
                                    //ROUND(LBalance / 100 / 12 * InterestRate,0.05,'>');
                                    DataSheet."REF." := '2026';
                                    //DataSheet."Batch No.":="Batch No.";
                                    CalcFields(Balance);
                                    DataSheet."New Balance" := Balance;
                                    Message('%1', Balance);
                                    Message('%1', Customer."Payroll/Staff No");

                                    DataSheet."Repayment Method" := Customer."Repayment Method";
                                    DataSheet.Date := Today;
                                    DataSheet."Amount OFF" := "Amount Off";
                                    //IF Customer.GET(LoanApps."Client Code") THEN BEGIN
                                    DataSheet.Employer := Customer."Employer Code";
                                    //END;
                                    //DataSheet."Sort Code":=PTEN;
                                    DataSheet.Modify();
                                end else begin
                                    DataSheet.Init;
                                    DataSheet."PF/Staff No" := Customer."Payroll/Staff No";
                                    DataSheet."Type of Deduction" := LoanTypes."Product Description";
                                    DataSheet."Remark/LoanNO" := LoanApps."Loan  No.";
                                    DataSheet.Name := Customer.Name;
                                    DataSheet."ID NO." := Customer."ID No.";
                                    DataSheet."Principal Amount" := LoanApps."Loan Principle Repayment";
                                    DataSheet."Interest Amount" := LoanApps."Loan Interest Repayment";
                                    DataSheet."Amount ON" := "Amount ON";
                                    //ROUND(LBalance / 100 / 12 * InterestRate,0.05,'>');
                                    DataSheet."REF." := '2026';
                                    //DataSheet."Batch No.":="Batch No.";
                                    DataSheet."New Balance" := Balance;
                                    Message('%1', Balance);
                                    Message('%1', Customer."Payroll/Staff No");

                                    DataSheet."New Balance" := Balance;

                                    DataSheet."Repayment Method" := Customer."Repayment Method";
                                    DataSheet.Date := Today;
                                    DataSheet."Amount OFF" := "Amount Off";
                                    //IF Customer.GET(LoanApps."Client Code") THEN BEGIN
                                    DataSheet.Employer := Customer."Employer Code";
                                    //DataSheet."Sort Code":=PTEN;
                                    DataSheet.Insert(true);
                                    DataSheet.Modify;
                                end;
                            end;
                            //END;
                            if (Type = Type::"Interest Paid") then begin
                                DataSheet.Reset;
                                DataSheet.SetRange(DataSheet."PF/Staff No", LoanApps."Staff No");
                                DataSheet.SetRange(DataSheet."Type of Deduction", 'SINTEREST');
                                DataSheet.SetRange(DataSheet."Remark/LoanNO", LoanApps."Loan  No.");
                                if DataSheet.Find('-') then begin
                                    DataSheet.Delete;
                                end;
                                DataSheet.Reset;
                                DataSheet.SetRange(DataSheet."PF/Staff No", LoanApps."Staff No");
                                DataSheet.SetRange(DataSheet."Type of Deduction", 'SINTEREST');
                                DataSheet.SetRange(DataSheet."Remark/LoanNO", LoanApps."Loan  No.");
                                if DataSheet.Find('-') then begin
                                    //DataSheet.INIT;
                                    DataSheet."PF/Staff No" := Customer."Payroll/Staff No";
                                    DataSheet."Type of Deduction" := 'SINTEREST';
                                    DataSheet."Remark/LoanNO" := LoanApps."Loan  No.";
                                    DataSheet.Name := Customer.Name;
                                    DataSheet."ID NO." := Customer."ID No.";
                                    DataSheet."Principal Amount" := LoanApps."Loan Principle Repayment";
                                    DataSheet."Interest Amount" := LoanApps."Loan Interest Repayment";
                                    DataSheet."Amount ON" := "Amount ON";
                                    //ROUND(LBalance / 100 / 12 * InterestRate,0.05,'>');
                                    DataSheet."REF." := '2026';
                                    //DataSheet."Batch No.":="Batch No.";
                                    DataSheet."New Balance" := Balance;
                                    DataSheet."Repayment Method" := Customer."Repayment Method";
                                    DataSheet.Date := Today;
                                    DataSheet."Amount OFF" := "Amount Off";
                                    //IF Customer.GET(LoanApps."Client Code") THEN BEGIN
                                    DataSheet.Employer := Customer."Employer Code";
                                    //DataSheet."Sort Code":=PTEN;
                                    DataSheet.Modify;
                                end else begin
                                    DataSheet.Init;
                                    DataSheet."PF/Staff No" := Customer."Payroll/Staff No";
                                    DataSheet."Type of Deduction" := 'SINTEREST';
                                    DataSheet."Remark/LoanNO" := LoanApps."Loan  No.";
                                    DataSheet.Name := Customer.Name;
                                    DataSheet."ID NO." := Customer."ID No.";
                                    DataSheet."Principal Amount" := LoanApps."Loan Principle Repayment";
                                    DataSheet."Interest Amount" := LoanApps."Loan Interest Repayment";
                                    DataSheet."Amount ON" := "Amount ON";
                                    DataSheet."Amount OFF" := "Amount Off";
                                    //ROUND(LBalance / 100 / 12 * InterestRate,0.05,'>');
                                    DataSheet."REF." := '2026';
                                    //DataSheet."Batch No.":="Batch No.";
                                    DataSheet."New Balance" := Balance;
                                    DataSheet."Repayment Method" := Customer."Repayment Method";
                                    DataSheet.Date := Today;
                                    //IF Customer.GET(LoanApps."Client Code") THEN BEGIN
                                    DataSheet.Employer := Customer."Employer Code";
                                    //DataSheet."Sort Code":=PTEN;
                                    DataSheet.Insert(true);
                                end;
                            end;
                        end;
                    end
                end;
                if Type = Type::"Deposit Contribution" then begin
                    //"Previous Share Contribution":=xRec."Monthly Contribution";


                    Customer.Reset;
                    Customer.SetRange(Customer."No.", "No.");
                    if Customer.Find('-') then begin
                        DataSheet.Reset;
                        DataSheet.SetRange(DataSheet."PF/Staff No", Customer."Payroll/Staff No");
                        DataSheet.SetRange(DataSheet."Type of Deduction", 'SSHARE');
                        DataSheet.SetRange(DataSheet."Remark/LoanNO", 'ADJ FORM');
                        if DataSheet.Find('-') then begin
                            DataSheet.Delete;
                        end;
                        DataSheet.Reset;
                        DataSheet.SetRange(DataSheet."PF/Staff No", Customer."Payroll/Staff No");
                        DataSheet.SetRange(DataSheet."Type of Deduction", 'SSHARE');
                        DataSheet.SetRange(DataSheet."Remark/LoanNO", 'ADJ FORM');
                        if DataSheet.Find('-') then begin
                            Customer.Advice := true;
                            //"Advice Type":="Advice Type"::Adjustment;

                            CalcFields(Balance);
                            //DataSheet.INIT;
                            DataSheet."PF/Staff No" := Customer."Payroll/Staff No";
                            DataSheet."Type of Deduction" := 'SSHARE';
                            DataSheet."Remark/LoanNO" := 'ADJ FORM';
                            DataSheet.Name := Customer.Name;
                            DataSheet."ID NO." := Customer."ID No.";
                            DataSheet."Amount ON" := "Amount ON";
                            DataSheet."REF." := '2026';
                            DataSheet."New Balance" := Balance;
                            DataSheet.Date := Today;
                            DataSheet."Amount OFF" := "Amount Off";
                            DataSheet.Employer := Customer."Employer Code";
                            DataSheet."Transaction Type" := DataSheet."transaction type"::ADJUSTMENT;
                            //DataSheet."Sort Code":=PTEN;
                            DataSheet.Modify;
                        end else begin
                            Customer.Advice := true;
                            //"Advice Type":="Advice Type"::Adjustment;

                            CalcFields(Balance);
                            DataSheet.Init;
                            DataSheet."PF/Staff No" := Customer."Payroll/Staff No";
                            DataSheet."Type of Deduction" := 'SSHARE';
                            DataSheet."Remark/LoanNO" := 'ADJ FORM';
                            DataSheet.Name := Customer.Name;
                            DataSheet."ID NO." := Customer."ID No.";
                            DataSheet."Amount ON" := "Amount ON";
                            DataSheet."REF." := '2026';
                            DataSheet."New Balance" := Balance;
                            DataSheet.Date := Today;
                            DataSheet."Amount OFF" := "Amount Off";
                            DataSheet.Employer := Customer."Employer Code";
                            DataSheet."Transaction Type" := DataSheet."transaction type"::"FRESH FEED";
                            //DataSheet."Sort Code":=PTEN;
                            DataSheet.Insert;
                        end;
                    end;
                end;

                if Type = Type::"FOSA Account" then begin
                    //"Previous Share Contribution":=xRec."Monthly Contribution";


                    Customer.Reset;
                    Customer.SetRange(Customer."No.", "No.");
                    if Customer.Find('-') then begin
                        DataSheet.Reset;
                        DataSheet.SetRange(DataSheet."PF/Staff No", Customer."Payroll/Staff No");
                        DataSheet.SetRange(DataSheet."Type of Deduction", 'WCONT');
                        DataSheet.SetRange(DataSheet."Remark/LoanNO", 'ADJ FORM');
                        if DataSheet.Find('-') then begin
                            DataSheet.Delete;
                        end;
                        DataSheet.Reset;
                        DataSheet.SetRange(DataSheet."PF/Staff No", Customer."Payroll/Staff No");
                        DataSheet.SetRange(DataSheet."Type of Deduction", 'WCONT');
                        DataSheet.SetRange(DataSheet."Remark/LoanNO", 'ADJ FORM');
                        if DataSheet.Find('-') then begin
                            Customer.Advice := true;
                            //"Advice Type":="Advice Type"::Adjustment;

                            CalcFields(Balance);
                            //DataSheet.INIT;
                            DataSheet."PF/Staff No" := Customer."Payroll/Staff No";
                            DataSheet."Type of Deduction" := 'WCONT';
                            DataSheet."Remark/LoanNO" := 'ADJ FORM';
                            DataSheet.Name := Customer.Name;
                            DataSheet."ID NO." := Customer."ID No.";
                            DataSheet."Amount ON" := "Amount ON";
                            DataSheet."REF." := '2026';
                            DataSheet."New Balance" := Balance;
                            DataSheet.Date := Today;
                            DataSheet."Amount OFF" := "Amount Off";
                            DataSheet.Employer := Customer."Employer Code";
                            DataSheet."Transaction Type" := DataSheet."transaction type"::ADJUSTMENT;
                            //DataSheet."Sort Code":=PTEN;
                            DataSheet.Modify;
                        end else begin
                            Customer.Advice := true;
                            //"Advice Type":="Advice Type"::Adjustment;

                            CalcFields(Balance);
                            DataSheet.Init;
                            DataSheet."PF/Staff No" := Customer."Payroll/Staff No";
                            DataSheet."Type of Deduction" := 'WCONT';
                            DataSheet."Remark/LoanNO" := 'ADJ FORM';
                            DataSheet.Name := Customer.Name;
                            DataSheet."ID NO." := Customer."ID No.";
                            DataSheet."Amount ON" := "Amount ON";
                            DataSheet."REF." := '2026';
                            DataSheet."New Balance" := Balance;
                            DataSheet.Date := Today;
                            DataSheet."Amount OFF" := "Amount Off";
                            DataSheet.Employer := Customer."Employer Code";
                            DataSheet."Transaction Type" := DataSheet."transaction type"::"FRESH FEED";
                            //DataSheet."Sort Code":=PTEN;
                            DataSheet.Insert;
                        end;
                    end;
                end;
                if Type = Type::"Benevolent Fund" then begin
                    //"Previous Share Contribution":=xRec."Monthly Contribution";


                    Customer.Reset;
                    Customer.SetRange(Customer."No.", "No.");
                    if Customer.Find('-') then begin
                        DataSheet.Reset;
                        DataSheet.SetRange(DataSheet."PF/Staff No", Customer."Payroll/Staff No");
                        DataSheet.SetRange(DataSheet."Type of Deduction", 'BBF');
                        DataSheet.SetRange(DataSheet."Remark/LoanNO", 'ADJ FORM');
                        if DataSheet.Find('-') then begin
                            DataSheet.Delete;
                        end;
                        DataSheet.Reset;
                        DataSheet.SetRange(DataSheet."PF/Staff No", Customer."Payroll/Staff No");
                        DataSheet.SetRange(DataSheet."Type of Deduction", 'BBF');
                        DataSheet.SetRange(DataSheet."Remark/LoanNO", 'ADJ FORM');
                        if DataSheet.Find('-') then begin
                            Customer.Advice := true;
                            //"Advice Type":="Advice Type"::Adjustment;

                            CalcFields(Balance);
                            //DataSheet.INIT;
                            DataSheet."PF/Staff No" := Customer."Payroll/Staff No";
                            DataSheet."Type of Deduction" := 'BBF';
                            DataSheet."Remark/LoanNO" := 'ADJ FORM';
                            DataSheet.Name := Customer.Name;
                            DataSheet."ID NO." := Customer."ID No.";
                            DataSheet."Amount ON" := "Amount ON";
                            DataSheet."REF." := '2026';
                            DataSheet."New Balance" := Balance;
                            DataSheet.Date := Today;
                            DataSheet."Amount OFF" := "Amount Off";
                            DataSheet.Employer := Customer."Employer Code";
                            DataSheet."Transaction Type" := DataSheet."transaction type"::ADJUSTMENT;
                            //DataSheet."Sort Code":=PTEN;
                            DataSheet.Modify;
                        end else begin
                            Customer.Advice := true;
                            //"Advice Type":="Advice Type"::Adjustment;

                            CalcFields(Balance);
                            DataSheet.Init;
                            DataSheet."PF/Staff No" := Customer."Payroll/Staff No";
                            DataSheet."Type of Deduction" := 'BBF';
                            DataSheet."Remark/LoanNO" := 'ADJ FORM';
                            DataSheet.Name := Customer.Name;
                            DataSheet."ID NO." := Customer."ID No.";
                            DataSheet."Amount ON" := "Amount ON";
                            DataSheet."REF." := '2026';
                            DataSheet."New Balance" := Balance;
                            DataSheet.Date := Today;
                            DataSheet."Amount OFF" := "Amount Off";
                            DataSheet.Employer := Customer."Employer Code";
                            DataSheet."Transaction Type" := DataSheet."transaction type"::"FRESH FEED";
                            //DataSheet."Sort Code":=PTEN;
                            DataSheet.Insert;
                        end;
                    end;
                end;
            end;
        }
        field(5; Descripition; Text[50])
        {
        }
        field(10; "Last Advice Date"; Date)
        {
            Editable = false;
        }
        field(11; "Check Off Priority"; Integer)
        {
        }
        field(12; "Type Code"; Code[10])
        {
        }
        field(13; Balance; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Transaction Type" = field(Type),
                                                                   "Customer No." = field("No.")));
            FieldClass = FlowField;
        }
        field(14; Staffno; Code[10])
        {

            trigger OnValidate()
            begin

                CustomerRecord.Reset;
                CustomerRecord.SetRange(CustomerRecord."Payroll/Staff No", Staffno);
                if CustomerRecord.Find('-') then begin
                    "No." := CustomerRecord."No.";
                    Validate("No.");
                end
            end;
        }
        field(15; "Loan No"; Code[20])
        {
            TableRelation = "Loans Register"."Loan  No." where("Client Code" = field("No."));
        }
        field(16; "Amount Off"; Decimal)
        {
        }
        field(17; "Balance 2"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "No.", Type)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Ledger: Integer;
        CustomerRecord: Record Customer;
        LoanTypes: Record "Loan Products Setup";
        Customer: Record Customer;
        LoanApps: Record "Loans Register";
        DataSheet: Record "Data Sheet Main";
}

