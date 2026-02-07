#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50220 "Member Detailed Statement old"
{
    ApplicationArea = All;
    RDLCLayout = './Layouts/MemberDetailedStatement.rdl';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.", "Loan Product Filter", "Outstanding Balance", "Date Filter";
            column(Payroll_Staff_No; "Payroll/Staff No")
            {
            }
            column(Employer_Name; "Employer Name")
            {
            }
            column(PayrollStaffNo_Members; Customer."Payroll/Staff No")
            {
            }
            column(No_Members; Customer."No.")
            {
            }
            column(MobilePhoneNo_MembersRegister; Customer."Mobile Phone No")
            {
            }
            column(Name_Members; Customer.Name)
            {
            }
            column(EmployerCode_Members; Customer."Employer Code")
            {
            }
            column(EmployerName; EmployerName)
            {
            }
            column(PageNo_Members; CurrReport.PageNo)
            {
            }
            column(Shares_Retained; Customer."Shares Retained")
            {
            }
            column(ShareCapBF; ShareCapBF)
            {
            }
            column(IDNo_Members; Customer."ID No.")
            {
            }
            column(Registration_Date; "Registration Date")
            {

            }
            column(GlobalDimension2Code_Members; Customer."Global Dimension 2 Code")
            {
            }
            column(Company_Name; Company.Name)
            {
            }
            column(Company_Address; Company.Address)
            {
            }
            column(Company_Picture; Company.Picture)
            {
            }
            column(Company_Phone; Company."Phone No.")
            {
            }
            column(Company_SMS; Company."Phone No.")
            {
            }
            column(Company_Email; Company."E-Mail")
            {
            }
            column(Outstanding_Balance; "Outstanding Balance") { }
            column(Outstanding_Interest; "Outstanding Interest") { }
            column(Current_Shares; "Current Shares") { }
            dataitem(Loans; "Loans Register")
            {
                DataItemLink = "Client Code" = field("No."), "Loan Product Type" = field("Loan Product Filter"), "Date filter" = field("Date Filter");
                DataItemTableView = sorting("Loan  No.") where(Posted = const(true), "Loan  No." = filter(<> ''));//, "Outstanding Balance" = filter(> 0));
                ;

                column(PrincipleBF; PrincipleBF)
                {
                }
                column(LoanNumber; Loans."Loan  No.")
                {
                }
                column(ProductType; LoanName)
                {
                }
                column(RequestedAmount; Loans."Requested Amount")
                {
                }
                column(Interest; Loans.Interest)
                {
                }
                column(Installments; Loans.Installments)
                {
                }
                column(LoanPrincipleRepayment; Loans."Loan Principle Repayment")
                {
                }
                column(ApprovedAmount_Loans; Loans."Approved Amount")
                {
                }
                column(LoanProductTypeName_Loans; Loans."Loan Product Type Name")
                {
                }
                column(Repayment_Loans; Loans.Repayment)
                {
                }
                column(ModeofDisbursement_Loans; Loans."Mode of Disbursement")
                {
                }
                dataitem(loan; "Cust. Ledger Entry")
                {
                    DataItemLink = "Customer No." = field("Client Code"), "Loan No" = field("Loan  No."), "Posting Date" = field("Date filter");
                    DataItemTableView = sorting("Posting Date") where("Transaction Type" = filter(Loan | "Loan Repayment" | "Interest Due" | "Interest Paid"), "Loan No" = filter(<> ''), Reversed = filter(false));
                    column(PostingDate_loan; loan."Posting Date")
                    {
                    }
                    column(DocumentNo_loan; loan."Document No.")
                    {
                    }
                    column(Description_loan; loan.Description)
                    {
                    }
                    column(DebitAmount_Loan; loan."Debit Amount")
                    {
                    }
                    column(CreditAmount_Loan; loan."Credit Amount")
                    {
                    }
                    column(Amount_Loan; loan."Amount to Apply") //Amount posted
                    {
                    }
                    column(openBalance_loan; OpenBalanceLoan)
                    {
                    }
                    column(CLosingBalance_loan; ClosingBalanceLoan * -1)
                    {
                    }
                    column(TransactionType_loan; loan."Transaction Type")
                    {
                    }
                    column(LoanNo; loan."Loan No")
                    {
                    }
                    column(PrincipleBF_loans; PrincipleBF)
                    {
                    }
                    column(LoanType_loan; loan."Loan Type")
                    {
                    }
                    column(Loan_Description; loan.Description)
                    {
                    }
                    column(BalAccountNo_loan; loan."Bal. Account No.")
                    {
                    }
                    column(BankCodeLoan; BankCodeLoan)
                    {
                    }
                    column(User7; loan."User ID")
                    {
                    }

                    trigger OnPreDataItem()
                    begin
                    end;

                    trigger OnAfterGetRecord()
                    begin
                        //ClosingBalanceLoan := ClosingBalanceLoan - loan."Amount Posted";
                        BankCodeLoan := GetBankCode(loan);
                        // Assign Credit and Debit Amounts based on Amount Posted
                        AssignCreditDebitAmounts(Loan."Amount Posted", Loan."Credit Amount", Loan."Debit Amount");

                        // Ensure ClosingBalanceLoan is updated correctly
                        ClosingBalanceLoan := ClosingBalanceLoan + Loan."Credit Amount" - Loan."Debit Amount";

                        // Track interest-related transactions
                        IF Loan."Transaction Type" = Loan."Transaction Type"::"Insurance Contribution" THEN BEGIN
                            InterestPaid := Loan."Credit Amount";
                            SumInterestPaid := InterestPaid + SumInterestPaid;
                        END;

                        IF Loan."Transaction Type" = Loan."Transaction Type"::"Interest Paid" THEN BEGIN
                            Loan."Credit Amount" := Loan."Credit Amount"; // Ensure logic is correct
                        END;
                    end;

                }


                trigger OnAfterGetRecord()
                begin
                    if LoanSetup.Get(Loans."Loan Product Type") then
                        LoanName := LoanSetup."Product Description";
                    if DateFilterBF <> '' then begin
                        LoansR.Reset;
                        LoansR.SetRange(LoansR."Loan  No.", "Loan  No.");
                        LoansR.SetFilter(LoansR."Date filter", DateFilterBF);
                        if LoansR.Find('-') then begin
                            LoansR.CalcFields(LoansR."Outstanding Balance");
                            LoansR.CalcFields(LoansR."Oustanding Interest");
                            PrincipleBF := LoansR."Outstanding Balance";
                            InterestBF := LoansR."Oustanding Interest";
                        end;
                    end;
                end;

                trigger OnPreDataItem()
                begin
                    //Loans.CALCFIELDS("Outstanding Balance");
                    //Loans.SETFILTER("Outstanding Balance",'<>%1',0);
                    Loans.SetFilter(Loans."Date filter", Customer.GetFilter(Customer."Date Filter"));
                end;
            }

            dataitem(Share; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No." = field("No."), "Posting Date" = field("Date Filter");
                DataItemTableView = sorting("Posting Date") where("Transaction Type" = const("Share Capital"), Reversed = filter(false));
                column(openBalances; OpenBalance)
                {
                }
                column(CLosingBalances; ClosingBalShares)
                {
                }
                column(Description_Shares; Share.Description)
                {
                }
                column(DocumentNo_Shares; Share."Document No.")
                {
                }
                column(PostingDate_Shares; Share."Posting Date")
                {
                }
                column(CreditAmount_Shares; Share."Credit Amount")
                {
                }
                column(DebitAmount_Shares; Share."Debit Amount")
                {
                }
                column(Amount_Shares; Share."Amount Posted")
                {
                }
                column(TransactionType_Shares; Share."Transaction Type")
                {
                }
                column(Shares_Description; Share.Description)
                {
                }
                column(BalAccountNo_Shares; Share."Bal. Account No.")
                {
                }
                column(BankCodeShares; BankCodeShares)
                {
                }
                column(USER1; Share."User ID")
                {
                }
                trigger OnPreDataItem()
                begin
                end;

                trigger OnAfterGetRecord()
                begin
                    // Skip blank records (No Amount Posted)
                    if Share."Amount Posted" <> 0 then begin
                        AssignCreditDebitAmounts(Share."Amount Posted", Share."Credit Amount", Share."Debit Amount");

                        // Correctly update Closing Balance
                        ClosingBalShares := ClosingBalShares + Share."Credit Amount" - Share."Debit Amount";

                        // Retrieve Bank Code
                        BankCodeDeposits := GetBankCode(Share);
                    end;
                end;

            }

            dataitem(HousingShares; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No." = field("No."), "Posting Date" = field("Date Filter");
                DataItemTableView = sorting("Transaction Type", "Loan No", "Posting Date") where("Transaction Type" = const("Benevolent Fund"), Reversed = filter(false)); //"Benevolent Fund" from Investment

                column(OpenBalancesHousingShares; OpenBalancesHousingShares)
                {
                }
                column(CLosingBalancesHousingShares; ClosingBalanceHousingShares)
                {
                }
                column(Description_HousingShares; HousingShares.Description)
                {
                }
                column(DocumentNo_HousingShares; HousingShares."Document No.")
                {
                }
                column(PostingDate_HousingShares; HousingShares."Posting Date")
                {
                }
                column(CreditAmount_HousingShares; HousingShares."Credit Amount")
                {
                }
                column(DebitAmount_HousingShares; HousingShares."Debit Amount")
                {
                }
                column(Amount_HousingShares; HousingShares."Amount Posted")
                {
                }
                column(TransactionType_HousingShares; HousingShares."Transaction Type")
                {
                }
                column(BalAccountNo_HousingShares; HousingShares."Bal. Account No.")
                {
                }
                column(BankCodeHousingShares; BankCodeHousingShares)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    ClosingBalanceHousingShares := ClosingBalanceHousingShares - HousingShares."Amount Posted";
                    BankCodeHousingShares := GetBankCode(HousingShares);
                    //............................................................
                    if HousingShares."Amount Posted" < 0 then begin
                        HousingShares."Credit Amount" := (HousingShares."Amount Posted" * -1);
                    end else
                        if HousingShares."Amount Posted" > 0 then begin
                            HousingShares."Debit Amount" := (HousingShares."Amount Posted");
                        end
                end;

                trigger OnPreDataItem()
                begin
                    // ClosingBalancePepeaShares := PepeaSharesBF;
                    // OpenBalancePepeaShares := PepeaSharesBF * -1;
                end;
            }

            dataitem(PepeaShares; "Cust. Ledger Entry")//
            {
                DataItemLink = "Customer No." = field("No."), "Posting Date" = field("Date Filter");
                DataItemTableView = sorting("Posting Date") where("Transaction Type" = const("Welfare Contribution"), Reversed = filter(false));

                column(OpenBalancesPepeaShares; OpenBalancesPepeaShares)
                {
                }
                column(CLosingBalancesPepeaShares; ClosingBalancePepeaShares)
                {
                }
                column(Description_PepeaShares; PepeaShares.Description)
                {
                }
                column(DocumentNo_PepeaShares; PepeaShares."Document No.")
                {
                }
                column(PostingDate_PepeaShares; PepeaShares."Posting Date")
                {
                }
                column(CreditAmount_PepeaShares; PepeaShares."Credit Amount")
                {
                }
                column(DebitAmount_PepeaShares; PepeaShares."Debit Amount")
                {
                }
                column(Amount_PepeaShares; PepeaShares.Amount)
                {
                }
                column(TransactionType_PepeaShares; PepeaShares."Transaction Type")
                {
                }
                column(BalAccountNo_PepeaShares; PepeaShares."Bal. Account No.")
                {
                }
                column(BankCodePepeaShares; BankCodePepeaShares)
                {
                }

                trigger OnPreDataItem()
                begin
                end;

                trigger OnAfterGetRecord()
                begin
                    // Skip blank records (No Amount Posted)
                    if PepeaShares."Amount Posted" <> 0 then begin
                        AssignCreditDebitAmounts(PepeaShares."Amount Posted", PepeaShares."Credit Amount", PepeaShares."Debit Amount");

                        // Correctly update Closing Balance
                        ClosingBalancePepeaShares := ClosingBalancePepeaShares + PepeaShares."Credit Amount" - PepeaShares."Debit Amount";

                        // Retrieve Bank Code
                        BankCodeDeposits := GetBankCode(PepeaShares);
                    end;
                end;
            }

            dataitem(Deposits; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No." = field("No."), "Posting Date" = field("Date Filter");
                DataItemTableView = sorting("Posting Date") where("Transaction Type" = const("Deposit Contribution"), Reversed = filter(false));
                column(OpeningBal; OpeningBal)
                {
                }
                column(ClosingBal; ClosingBal)
                {
                }
                column(TransactionType_Deposits; Deposits."Transaction Type")
                {
                }
                column(Amount_Deposits; Deposits."Amount Posted")
                {
                }
                column(Description_Deposits; Deposits.Description)
                {
                }
                column(DocumentNo_Deposits; Deposits."Document No.")
                {
                }
                column(PostingDate_Deposits; Deposits."Posting Date")
                {
                }
                column(DebitAmount_Deposits; Deposits."Debit Amount")
                {
                }
                column(CreditAmount_Deposits; Deposits."Credit Amount")
                {
                }
                column(Deposits_Description; Deposits.Description)
                {
                }
                column(BalAccountNo_Deposits; Deposits."Bal. Account No.")
                {
                }
                column(BankCodeDeposits; BankCodeDeposits)
                {
                }
                column(USER2; Deposits."User ID")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    BankCodeDeposits := GetBankCode(Deposits);

                    // Assign Credit and Debit Amounts based on Amount Posted
                    AssignCreditDebitAmounts(Deposits."Amount Posted", Deposits."Credit Amount", Deposits."Debit Amount");

                    // Update Closing Balance dynamically after fetching each record
                    ClosingBal += Deposits."Credit Amount" - Deposits."Debit Amount";
                end;


                trigger OnPreDataItem()
                begin
                end;
            }
            dataitem(Dividend; "Cust. Ledger Entry")//
            {
                DataItemLink = "Customer No." = field("No."), "Posting Date" = field("Date Filter");
                DataItemTableView = sorting("Transaction Type", "Loan No", "Posting Date") where("Transaction Type" = const(dividend), Reversed = filter(false));
                column(ReportForNavId_1102755055; 1102755055)
                {
                }
                column(OpenBalancesDividend; OpenBalanceDividend)
                {
                }
                column(CLosingBalancesDividend; ClosingBalanceDividend)
                {
                }
                column(Description_Dividend; Dividend.Description)
                {
                }
                column(DocumentNo_Dividend; Dividend."Document No.")
                {
                }
                column(PostingDate_Dividend; Dividend."Posting Date")
                {
                }
                column(CreditAmount_Dividend; Dividend."Credit Amount")
                {
                }
                column(DebitAmount_Dividend; Dividend."Debit Amount")
                {
                }
                column(Amount_Dividend; Dividend."Amount Posted")
                {
                }
                column(TransactionType_Dividend; Dividend."Transaction Type")
                {
                }
                column(BalAccountNo_Dividend; Dividend."Bal. Account No.")
                {
                }
                column(BankCodeDividend; BankCodeDividend)
                {
                }
                column(USER3; Dividend."User ID")
                {
                }

                // trigger OnAfterGetRecord()
                // begin
                //     ClosingBalanceDividend := ClosingBalanceDividend - Dividend."Amount Posted";
                //     BankCodeDividend := GetBankCode(Dividend);
                // end;

                // trigger OnPreDataItem()
                // begin
                //     ClosingBalanceDividend := DividendBF;
                //     OpenBalanceDividend := DividendBF * -1;
                // end;
                trigger OnPreDataItem()
                begin
                end;

                trigger OnAfterGetRecord()
                begin
                    BankCodeDividend := GetBankCode(Dividend);
                    // Assign Credit and Debit Amounts based on Amount Posted
                    AssignCreditDebitAmounts(Dividend."Amount Posted", Dividend."Credit Amount", Dividend."Debit Amount");

                    // Update Closing Balance dynamically after fetching each record
                    ClosingBalanceDividend += Dividend."Credit Amount" - Dividend."Debit Amount";
                end;

            }


            dataitem("Loans Guarantee Details"; "Loans Guarantee Details")
            {
                DataItemLink = "Member No" = field("No.");
                column(ReportForNavId_1000000042; 1000000042)
                {
                }
                column(LoanNumb; "Loans Guarantee Details"."Loan No")
                {
                }
                column(MembersNo; "Loans Guarantee Details"."Member No")
                {
                }
                column(Name; "Loans Guarantee Details".Name)
                {
                }
                column(LBalance; "Loans Guarantee Details"."Loans Outstanding")
                {
                }
                column(Shares; "Loans Guarantee Details".Shares)
                {
                }
                column(LoansGuaranteed; "Loans Guarantee Details"."No Of Loans Guaranteed")
                {
                }
                column(Substituted; "Loans Guarantee Details".Substituted)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                SaccoEmp.Reset;
                SaccoEmp.SetRange(SaccoEmp.Code, Customer."Employer Code");
                if SaccoEmp.Find('-') then
                    EmployerName := SaccoEmp.Description;

                HolidayBF := 0;
                SharesBF := 0;
                InsuranceBF := 0;
                ShareCapBF := 0;
                RiskBF := 0;
                HseBF := 0;
                Dep1BF := 0;
                Dep2BF := 0;
                if DateFilterBF <> '' then begin
                    Cust.Reset;
                    Cust.SetRange(Cust."Customer No.", "No.");

                    Cust.SetFilter(Cust."Date Filter", DateFilterBF);

                    if Cust.Find('-') then begin
                        // Cust.CalcFields(Cust.sha, Cust."Current Shares", Cust."Insurance Fund", Cust."Holiday Savings");
                        // SharesBF := Cust."Current Shares";
                        // ShareCapBF := Cust."Shares Retained";
                        // RiskBF := Cust."Insurance Fund";
                        // HolidayBF := Cust."Holiday Savings";
                    end;
                end;
            end;

            trigger OnPreDataItem()
            begin
                /*
                IF Customer.GETFILTER(Customer."Date Filter") <> '' THEN
                DateFilterBF:='..'+ FORMAT(CALCDATE('-1D',Customer.GETRANGEMIN(Customer."Date Filter")));
                */

                if Customer.GetFilter(Customer."Date Filter") <> '' then
                    DateFilterBF := '..' + Format(CalcDate('-1D', Customer.GetRangeMin(Customer."Date Filter")));
                //DateFilterBF:='..'+ FORMAT(Customer.GETRANGEMIN(Customer."Date Filter"));

            end;
        }
    }

    requestpage
    {

        // layout
        // {
        //     area(content)
        //     { field(From; AsAt) { } }
        // }


        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        Company.Get();
        Company.CalcFields(Company.Picture);

        // Set AsAt to the beginning of the current year if not provided
        if AsAt = 0D then
            AsAt := DMY2Date(1, 1, Date2DMY(Today, 3)); // Default to today if not set

        // Set DateFilter from start of the year to the given date (AsAt)
        DateFilter := '..' + Format(AsAt);
    end;

    var
        AsAt: Date;
        StartOfYear: Date;
        DepositsBF: Decimal;
        DateFilter: Text;
        OpenBalance: Decimal;
        CLosingBalance: Decimal;
        OpenBalanceXmas: Decimal;
        CLosingBalanceXmas: Decimal;
        Cust: Record "Cust. Ledger Entry";
        OpeningBal: Decimal;
        ClosingBal: Decimal;
        FirstRec: Boolean;
        PrevBal: Integer;
        BalBF: Decimal;
        LoansR: Record "Loans Register";
        DateFilterBF: Text[150];
        SharesBF: Decimal;
        InsuranceBF: Decimal;
        LoanBF: Decimal;
        PrincipleBF: Decimal;
        InterestBF: Decimal;
        ShowZeroBal: Boolean;
        ClosingBalSHCAP: Decimal;
        ShareCapBF: Decimal;
        OpeningBalShares: Decimal;
        ClosingBalShares: Decimal;
        RiskBF: Decimal;
        DividendBF: Decimal;
        Company: Record "Company Information";
        OpenBalanceHse: Decimal;
        CLosingBalanceHse: Decimal;
        OpenBalanceDep1: Decimal;
        CLosingBalanceDep1: Decimal;
        OpenBalanceDep2: Decimal;
        CLosingBalanceDep2: Decimal;
        HseBF: Decimal;
        Dep1BF: Decimal;
        Dep2BF: Decimal;
        OpeningBalInt: Decimal;
        ClosingBalInt: Decimal;
        InterestPaid: Decimal;
        SumInterestPaid: Decimal;
        OpenBalanceRisk: Decimal;
        CLosingBalanceRisk: Decimal;
        OpenBalanceDividend: Decimal;
        ClosingBalanceDividend: Decimal;
        OpenBalanceHoliday: Decimal;
        ClosingBalanceHoliday: Decimal;
        LoanSetup: Record "Loan Products Setup";
        LoanName: Text[50];
        SaccoEmp: Record "Sacco Employers";
        EmployerName: Text[100];
        OpenBalanceLoan: Decimal;
        ClosingBalanceLoan: Decimal;
        BankCodeShares: Text;
        BankCodeDeposits: Text;
        BankCodeDividend: Text;
        BankCodeRisk: Text;
        BankCodeInsurance: Text;
        BankCodeLoan: Text;
        BankCodeInterest: Text;
        LastLoanNo: code[20];
        LoanNoValue: Code[20];
        HolidayBF: Decimal;
        BankCodeHoliday: Code[50];
        ClosingBalHoliday: Decimal;
        OpeningBalHoliday: Decimal;
        BankCodeFOSAShares: Code[50];
        ClosingBalanceFOSAShares: Decimal;
        OpenBalanceFOSAShares: Decimal;
        OpenBalancesPepeaShares: Decimal;
        ClosingBalancePepeaShares: Decimal;
        PepeaSharesCapBF: Decimal;
        BankCodePepeaShares: Code[50];
        OpenBalancesHousingShares: Decimal;
        ClosingBalanceHousingShares: Decimal;
        BankCodeHousingShares: Code[50];
        ApprovedAmount_Interest: Decimal;
        LonRepaymentSchedule: Record "Loan Repayment Schedule";

        MembLedgerEntry: Record "Cust. Ledger Entry";
        TbMembReg: Record Customer;


    local procedure AssignCreditDebitAmounts(AmountPosted: Decimal; var CreditAmount: Decimal; var DebitAmount: Decimal)
    begin
        if AmountPosted < 0 then
            CreditAmount := AmountPosted * -1
        else if AmountPosted > 0 then
            DebitAmount := AmountPosted;
    end;

    local procedure GetBankCode(MembLedger: Record "Cust. Ledger Entry"): Text
    var
        BankLedger: Record "Bank Account Ledger Entry";
    begin
        BankLedger.Reset;
        BankLedger.SetRange("Posting Date", MembLedger."Posting Date");
        BankLedger.SetRange("Document No.", MembLedger."Document No.");
        if BankLedger.FindFirst then
            exit(BankLedger."Bank Account No.");
        exit('');
    end;
}

