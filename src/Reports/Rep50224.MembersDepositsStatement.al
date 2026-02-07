#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50224 "Members Deposits Statement"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/MemberDepositsStatement.rdl';
    ApplicationArea = all;


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
                    // Initialize Balances
                    DepositsBF := 0;
                    OpeningBal := 0;
                    ClosingBal := 0;

                    // **Step 1: Compute Opening Balance (Before AsAt)**
                    Deposits.Reset();
                    Deposits.SetRange("Customer No.", Customer."No.");
                    Deposits.SetFilter("Transaction Type", 'Deposit Contribution');
                    Deposits.SetRange(Reversed, false);
                    Deposits.SetFilter("Posting Date", '..' + Format(AsAt)); // Transactions before AsAt

                    if Deposits.FindSet() then
                        repeat
                            // Assign Credit and Debit Amounts based on Amount Posted
                            AssignCreditDebitAmounts(Deposits."Amount Posted", Deposits."Credit Amount", Deposits."Debit Amount");

                            // Compute net balance
                            DepositsBF += Deposits."Credit Amount" - Deposits."Debit Amount";
                        until Deposits.Next() = 0;

                    // Store Opening Balance
                    OpeningBal := DepositsBF;
                    ClosingBal := OpeningBal; // Start with Opening Balance

                    // **Step 2: Fetch Only Transactions from AsAt to Today**
                    Deposits.Reset();
                    Deposits.SetRange("Customer No.", Customer."No.");
                    Deposits.SetFilter("Transaction Type", 'Deposit Contribution');
                    Deposits.SetRange(Reversed, false);
                    Deposits.SetRange("Posting Date", AsAt, Today); // Only transactions from AsAt onwards
                end;
            }

            trigger OnAfterGetRecord()
            begin
                SaccoEmp.Reset;
                SaccoEmp.SetRange(SaccoEmp.Code, Customer."Employer Code");
                if SaccoEmp.Find('-') then
                    EmployerName := SaccoEmp.Description;
            end;

            trigger OnPreDataItem()
            begin
                /*
                IF Customer.GETFILTER(Customer."Date Filter") <> '' THEN
                DateFilterBF:='..'+ FORMAT(CALCDATE('-1D',Customer.GETRANGEMIN(Customer."Date Filter")));
                */

                // if Customer.GetFilter(Customer."Date Filter") <> '' then
                //     DateFilterBF := '..' + Format(CalcDate('-1D', Customer.GetRangeMin(Customer."Date Filter")));
                // //DateFilterBF:='..'+ FORMAT(Customer.GETRANGEMIN(Customer."Date Filter"));

            end;
        }
    }


    requestpage
    {

        layout
        {
            area(content)
            { field(From; AsAt) { } }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    var
    // RegenerateOldLoansData: Codeunit "Regenerate Schedule for loans";
    begin
        Company.Get();
        Company.CalcFields(Company.Picture);
        //..........................................................

        // Set AsAt to the beginning of the current year if not provided
        if AsAt = 0D then
            AsAt := DMY2Date(1, 1, Date2DMY(Today, 3));

        DateFilter := '..' + Format(AsAt);

        // if not Evaluate(DateBD, DateFilter) then
        //     Error('Invalid date format');


    end;

    // **Helper Function to Assign Credit and Debit Amounts**
    local procedure AssignCreditDebitAmounts(AmountPosted: Decimal; var CreditAmount: Decimal; var DebitAmount: Decimal)
    begin
        if AmountPosted < 0 then
            CreditAmount := AmountPosted * -1
        else if AmountPosted > 0 then
            DebitAmount := AmountPosted;
    end;

    var
        OpenBalance: Decimal;
        CLosingBalance: Decimal;
        DepositsBF: Decimal;

        AsAt: Date;
        DateFilter: Text;
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
        HolidayBF: Decimal;
        BankCodeHoliday: Code[50];
        ClosingBalHoliday: Decimal;
        OpeningBalHoliday: Decimal;
        BankCodeFOSAShares: Code[50];
        ClosingBalanceFOSAShares: Decimal;
        OpenBalanceFOSAShares: Decimal;
        OpenBalancesPepeaShares: Decimal;
        ClosingBalancePepeaShares: Decimal;
        BankCodePepeaShares: Code[50];
        OpenBalancesVanShares: Decimal;
        ClosingBalanceVanShares: Decimal;
        BankCodeVanShares: Code[50];
        ApprovedAmount_Interest: Decimal;
        LonRepaymentSchedule: Record "Loan Repayment Schedule";


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

