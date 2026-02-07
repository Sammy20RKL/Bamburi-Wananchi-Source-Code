report 51017 "My Payroll Payslip"
{

    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/MyPayrollPayslip.rdl';

    dataset
    {
        dataitem("Payroll Employee."; "Payroll Employee.")
        {
            RequestFilterFields = "No.";
            column(No; "No.")
            {
            }
            column(Surname; Surname)
            {
            }
            column(FirstName; "First Name")
            {
            }
            column(Lastname; "Middle Name")
            {
            }
            column(FullName; "Full Name")
            {
            }
            column(CName; CompanyInfo.Name)
            {
            }
            column(CAddress; CompanyInfo.Address)
            {
            }
            column(CPic; CompanyInfo.Picture)
            {
            }
            column(PeriodName; PeriodName)
            {
            }
            column(IncrementDate_PayrollEmployee; "Payroll Employee."."Next Increment Date")
            {
            }
            column(PINNo; "PIN No")
            {
            }
            column(JobGroup_PayrollEmployee; "Payroll Employee."."Job Group")
            {
            }
            column(JobDescription_PayrollEmployee; "Payroll Employee."."Job Description")
            {
            }
            column(GlobalDimension1_PayrollEmployee; "Payroll Employee."."Global Dimension 1")
            {
            }
            column(GlobalDimension2_PayrollEmployee; "Payroll Employee."."Global Dimension 2")
            {
            }
            column(NSSFNo; "NSSF No")
            {
            }
            column(BankCode_PayrollEmployee; "Payroll Employee."."Bank Code")
            {
            }
            column(NHIFNo; "NHIF No")
            {
            }
            column(BankName; "Bank Name")
            {
            }
            column(BranchName; "Branch Name")
            {
            }
            column(DateOfRetirement_PayrollEmployee; "Payroll Employee."."Date Of Retirement")
            {
            }
            column(Department; "Payroll Employee.".Department)
            {
            }
            column(UserId; UserId)
            {
            }
            column(BankAccNo; "Bank Account No")
            {
            }
            column(Departmentname; Departmentname)
            {
            }
            column(DepartmentCode_PayrollEmployee; "Payroll Employee."."Department Code")
            {
            }
            column(BANKN; BANKN)
            {
            }
            column(BranchN; BranchN)
            {
            }
            column(ACCn; ACCn)
            {
            }
            column(Designation; Designation)
            {

            }

            dataitem("prPeriod Transactions."; "prPeriod Transactions.")
            {
                DataItemLink = "Employee Code" = FIELD("No.");
                RequestFilterFields = "Payroll Period";
                column(Employee_Code; "Employee Code") { }
                column(TCode; "Transaction Code")
                {
                }
                column(TName; "Transaction Name")
                {
                }
                column(coop_parameters; "coop parameters")
                {

                }
                column(Grouping; "Group Order")
                {
                }
                column(TBalances; "Original Amount")
                {
                }
                column(SubGroupOrder; "prPeriod Transactions."."Sub Group Order")
                {
                }
                column(Amount; Amount)
                {
                }
                column(PeriodMonth_prPeriodTransactions; "Period Month")
                {
                }
                column(PeriodYear_prPeriodTransactions; "Period Year")
                {
                }
                column(NSSF; NSSF)
                {
                }
                column(Pens; Pens)
                {
                }
                column(TaxablePay; TaxablePay)
                {
                }
                column(Taxcharged; Taxcharged)
                {
                }
                column(prelief; prelief)
                {
                }
                column(NHIFR; NHIFR)
                {
                }
                column(insrel; insrel)
                {
                }
                column(paye; paye)
                {
                }
                column(Sloanamount; Loanamounnt)
                {

                }
                column(SloanBalance; LoanBalance)
                {

                }
                column(SharesAmount; SaccoSharesAmunt)
                {

                }
                column(LoanInterestAmont; LoanInterestAmont)
                {

                }
                column(BenevolentAmount; BenevolentAmount)
                {

                }
                column(LikizoContribution; LikizoContribution)
                {

                }
                column(ShareCapital; ShareCapital)
                {

                }
                column(Housing_Levy; "Housing Levy")
                {

                }
                column(TotalDeduction; TotalDeduction)
                {

                }


                trigger OnAfterGetRecord()
                begin
                    BANKN := '';
                    BranchN := '';
                    ACCn := '';

                    PayrollBankdeatails.Reset;
                    PayrollBankdeatails.SetRange("No.", "prPeriod Transactions."."Employee Code");
                    PayrollBankdeatails.SetRange("Payroll Period", "prPeriod Transactions."."Payroll Period");
                    if PayrollBankdeatails.FindFirst then begin
                        BANKN := PayrollBankdeatails."Bank Name";
                        BranchN := PayrollBankdeatails."Branch Name";
                        ACCn := PayrollBankdeatails."Bank Account No";
                    end;


                    NSSF := 0;
                    Pens := 0;
                    TaxablePay := 0;
                    Taxcharged := 0;
                    prelief := 0;
                    insrel := 0;
                    paye := 0;
                    Loanamounnt := 0;
                    LikizoContribution := 0;
                    LoanBalance := 0;
                    SaccoSharesAmunt := 0;
                    BenevolentAmount := 0;
                    LoanInterestAmont := 0;
                    "Housing Levy" := 0;

                    PayrollCalender.Reset;
                    PayrollCalender.SetRange(PayrollCalender."Date Opened", "Payroll Period");
                    if PayrollCalender.FindLast then begin
                        PeriodName := PayrollCalender."Period Name";//+'-'+ FORMAT(PayrollCalender."Period Year");
                    end;

                    //Payments


                    //Deductions

                    prPeriodTransactions2.Reset;
                    prPeriodTransactions2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
                    prPeriodTransactions2.SetRange("Payroll Period", "prPeriod Transactions."."Payroll Period");
                    prPeriodTransactions2.SetRange("Transaction Code", 'NSSF');
                    if prPeriodTransactions2.FindFirst then
                        NSSF := prPeriodTransactions2.Amount;

                    prPeriodTransactions2.Reset;
                    prPeriodTransactions2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
                    prPeriodTransactions2.SetRange("Payroll Period", "prPeriod Transactions."."Payroll Period");
                    prPeriodTransactions2.SetRange("Transaction Code", 'PNSRLF');
                    if prPeriodTransactions2.FindFirst then
                        Pens := prPeriodTransactions2.Amount;

                    prPeriodTransactions2.Reset;
                    prPeriodTransactions2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
                    prPeriodTransactions2.SetRange("Payroll Period", "prPeriod Transactions."."Payroll Period");
                    prPeriodTransactions2.SetRange("Transaction Code", 'TXBP');
                    if prPeriodTransactions2.FindFirst then
                        TaxablePay := prPeriodTransactions2.Amount;

                    prPeriodTransactions2.Reset;
                    prPeriodTransactions2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
                    prPeriodTransactions2.SetRange("Payroll Period", "prPeriod Transactions."."Payroll Period");
                    prPeriodTransactions2.SetRange("Transaction Code", 'D13');
                    if prPeriodTransactions2.FindFirst then
                        "Housing Levy" := prPeriodTransactions2.Amount;

                    prPeriodTransactions2.Reset;
                    prPeriodTransactions2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
                    prPeriodTransactions2.SetRange("Payroll Period", "prPeriod Transactions."."Payroll Period");
                    prPeriodTransactions2.SetRange("Transaction Code", 'TXCHRG');
                    if prPeriodTransactions2.FindFirst then
                        Taxcharged := prPeriodTransactions2.Amount;


                    prPeriodTransactions2.Reset;
                    prPeriodTransactions2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
                    prPeriodTransactions2.SetRange("Payroll Period", "prPeriod Transactions."."Payroll Period");
                    prPeriodTransactions2.SetRange("Transaction Code", 'PSNR');
                    if prPeriodTransactions2.FindFirst then
                        prelief := prPeriodTransactions2.Amount;

                    prPeriodTransactions2.Reset;
                    prPeriodTransactions2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
                    prPeriodTransactions2.SetRange("Payroll Period", "prPeriod Transactions."."Payroll Period");
                    prPeriodTransactions2.SetRange("Transaction Code", 'INSRD');
                    if prPeriodTransactions2.FindFirst then
                        insrel := prPeriodTransactions2.Amount;

                    prPeriodTransactions2.Reset;
                    prPeriodTransactions2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
                    prPeriodTransactions2.SetRange("Payroll Period", "prPeriod Transactions."."Payroll Period");
                    prPeriodTransactions2.SetRange("Transaction Code", 'PAYE');
                    if prPeriodTransactions2.FindFirst then
                        paye := prPeriodTransactions2.Amount;

                    prPeriodTransactions2.Reset;
                    prPeriodTransactions2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
                    prPeriodTransactions2.SetRange("Payroll Period", "prPeriod Transactions."."Payroll Period");
                    prPeriodTransactions2.SetRange("Transaction Code", 'NSNR');
                    if prPeriodTransactions2.FindFirst then
                        NHIFR := prPeriodTransactions2.Amount;

                    prPeriodTransactions2.Reset;
                    prPeriodTransactions2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
                    prPeriodTransactions2.SetRange("Payroll Period", "prPeriod Transactions."."Payroll Period");
                    //prPeriodTransactions2.SetRange("Transaction Code", 'NHIF');//LOAN APP FEE
                    prPeriodTransactions2.SetRange("coop parameters", "coop parameters"::NHIF);

                    if prPeriodTransactions2.FindFirst then
                        NHIF := prPeriodTransactions2.Amount;
                    //Sacco deductions
                    //Loan Deductions
                    prPeriodTransactions2.Reset;
                    prPeriodTransactions2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
                    prPeriodTransactions2.SetRange("Payroll Period", "prPeriod Transactions."."Payroll Period");
                    prPeriodTransactions2.SetRange("coop parameters", "coop parameters"::loan);
                    if prPeriodTransactions2.Findset then begin
                        repeat
                            Loanamounnt := Loanamounnt + prPeriodTransactions2.Amount;
                            LoanBalance := LoanBalance + prPeriodTransactions2.Balance;
                        until prPeriodTransactions2.Next = 0;
                    end;


                    //interest
                    prPeriodTransactions2.Reset;
                    prPeriodTransactions2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
                    prPeriodTransactions2.SetRange("Payroll Period", "prPeriod Transactions."."Payroll Period");
                    prPeriodTransactions2.SetRange("coop parameters", "coop parameters"::"Loan Interest");
                    if prPeriodTransactions2.Findset then begin
                        repeat
                            LoanInterestAmont := LoanInterestAmont + prPeriodTransactions2.Amount;
                        until prPeriodTransactions2.Next = 0;
                    end;
                    //Message('Loan Interest Amount of %1', LoanInterestAmont);

                    //Sharecapital Feee

                    prPeriodTransactions2.Reset;
                    prPeriodTransactions2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
                    prPeriodTransactions2.SetRange("Payroll Period", "prPeriod Transactions."."Payroll Period");
                    prPeriodTransactions2.SetRange("coop parameters", "coop parameters"::"Share Capital");
                    if prPeriodTransactions2.FindFirst then begin
                        repeat
                            ShareCapital := ShareCapital + prPeriodTransactions2.Amount;
                        until prPeriodTransactions2.Next = 0;
                    end;

                    //Sacco Shares
                    prPeriodTransactions2.Reset;
                    prPeriodTransactions2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
                    prPeriodTransactions2.SetRange("Payroll Period", "prPeriod Transactions."."Payroll Period");
                    prPeriodTransactions2.SetRange("coop parameters", "coop parameters"::shares);
                    if prPeriodTransactions2.FindFirst then
                        SaccoSharesAmunt := prPeriodTransactions2.Amount;

                    //Sacco Benevolent
                    prPeriodTransactions2.Reset;
                    prPeriodTransactions2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
                    prPeriodTransactions2.SetRange("Payroll Period", "prPeriod Transactions."."Payroll Period");
                    prPeriodTransactions2.SetRange("coop parameters", "coop parameters"::Welfare);
                    if prPeriodTransactions2.FindFirst then begin
                        BenevolentAmount := prPeriodTransactions2.Amount;
                    end;


                    TotalDeduction := (BenevolentAmount + SaccoSharesAmunt + ShareCapital +
                    LikizoContribution + LoanInterestAmont + Loanamounnt + "Housing Levy" + NSSF + paye + NHIF);



                    //Total Deductions
                    // prPeriodTransactions2.Reset;
                    // prPeriodTransactions2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
                    // prPeriodTransactions2.SetRange("Payroll Period", "prPeriod Transactions."."Payroll Period");
                    // if prPeriodTransactions2.FindFirst then
                    //     BenevolentAmount := prPeriodTransactions2.Amount;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                /*PayrollCalender.RESET;
                PayrollCalender.SETRANGE(PayrollCalender."Date Opened","Date Filter");
                IF PayrollCalender.FINDLAST THEN BEGIN
                  PeriodName:=PayrollCalender."Period Name";
                END;*/
                // if HREmployees.Get("Payroll Employee."."No.") then begin
                //     DimensionValue.Reset;
                //     DimensionValue.SetRange(Code, HREmployees."Department Code");
                //     DimensionValue.SetRange("Dimension Code", 'DEPARTMENT');
                //     if DimensionValue.FindFirst then
                //         Departmentname := DimensionValue.Name;
                // end;

            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                // field(Period; periods)
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Period:';
                //     TableRelation = "Payroll Calender."."Date Opened";
                //     Visible = true;
                // }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        IF UserSetup.GET(USERID) THEN BEGIN
            IF NOT UserSetup."Payroll User" THEN
                ERROR(PemissionDenied);
        END ELSE BEGIN
            ERROR(UserNotFound, USERID);
        END;


    end;

    trigger OnPreReport()
    var
        PayrollEmployeee: record "Payroll Employee.";
    begin

        CompanyInfo.Get;
        CompanyInfo.CalcFields(CompanyInfo.Picture);

        PayrollCalender.Reset;
        PayrollCalender.SetRange(PayrollCalender."Date Opened", "Payroll Period");
        if PayrollCalender.FindFirst then begin
            PeriodName := PayrollCalender."Period Name" + '-' + Format(Date2dmy(PayrollCalender."Date Opened", 3));
        end;
        //........................................................................................
        PayrollNo := "Payroll Employee.".GetFilter("Payroll Employee."."No.");
        TransactionPeriodFilter := "prPeriod Transactions.".GetFilter("prPeriod Transactions."."Payroll Period");
        if PayrollNo = '' then Error('Payroll No MUST Be provided');
        if "Payroll Period" = 0D then Error('Period MUST Be provided');
        if TransactionPeriodFilter = '' then Error('Payroll Period MUST Be provided under PRPeriodTransactions');
        PayrollEmployeee.Reset();
        PayrollEmployeee.SetRange(PayrollEmployeee."No.", PayrollNo);
        IF PayrollEmployeee.Find('-') THEN BEGIN
            IF PayrollEmployeee."User ID" <> UserId THEN Error('You can only view your Payslip Report');
        END;

    end;

    var
        //Beryl variables
        TransactionPeriodFilter: Text;
        TotalDeduction: Decimal;
        "AFFORDABLE HOUSING": Code[30];
        AIRTIMEALLOWANCE: Code[30];
        ARREARS: Code[30];
        BenevolentAmount: Decimal;
        BPAY: Code[30];
        LoanInterestAmont: Decimal;
        Loanamounnt: Decimal;
        LoanBalance: Decimal;
        SaccoSharesAmunt: Decimal;
        SaccoSharesTotal: Decimal;
        LikizoContribution: Decimal;
        ShareCapital: Decimal;
        GPAY: Code[30];
        "Housing Levy": Decimal;
        INSRD: Code[30];
        PayrollNo: Code[20];

        NHIF: Decimal;
        NPAY: Code[30];

        PAYEE: Code[30];
        PSLF: Code[30];
        PYAR: Code[30];
        "TOT-DED": Code[30];
        TXCHRG: Code[30];
        " VIW SHARES": Code[30];

        CompanyInfo: Record "Company Information";
        PayrollCalender: Record "Payroll Calender.";
        "Payroll Period": Date;
        PeriodName: Text;
        PayrollEmp: Record "Payroll Employee.";
        UserNotFound: Label 'User Setup %1 not found.';
        PemissionDenied: Label 'User Account is not Setup for Payroll Use. Contact System Administrator.';
        UserSetup: Record "User Setup";
        Departmentname: Text;
        DimensionValue: Record "Dimension Value";
        // HREmployees: Record "HR Employees";
        prPeriodTransactions2: Record "prPeriod Transactions.";
        NSSF: Decimal;
        Pens: Decimal;
        TaxablePay: Decimal;
        Taxcharged: Decimal;
        prelief: Decimal;
        insrel: Decimal;
        paye: Decimal;
        BANKN: Text;
        BranchN: Text;
        ACCn: Code[100];
        PayrollBankdeatails: Record "Payroll Bank deatails";
        NHIFR: Decimal;
    // periods: Date;
}

