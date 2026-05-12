#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50051 "Members Dividend Statement"
{
    ApplicationArea = All;
    RDLCLayout = './Layouts/MemberDividendStatement.rdl';
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
            column(PayrollStaffNo_Members; "Payroll/Staff No")
            {
            }
            column(No_Members; "No.")
            {
            }
            column(MobilePhoneNo_MembersRegister; "Mobile Phone No")
            {
            }
            column(Name_Members; Name)
            {
            }
            column(Registration_Date; "Registration Date")
            {

            }
            column(EmployerCode_Members; "Employer Code")
            {
            }
            column(EmployerName; EmployerName)
            {
            }
            column(PageNo_Members; CurrReport.PageNo)
            {
            }
            column(Shares_Retained; "Shares Retained")
            {
            }
            column(ShareCapBF; ShareCapBF)
            {
            }
            column(IDNo_Members; "ID No.")
            {
            }
            column(GlobalDimension2Code_Members; "Global Dimension 2 Code")
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
            dataitem(Dividend; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No." = field("No."), "Posting Date" = field("Date Filter");
                DataItemTableView = sorting("Posting Date") where("Transaction Type" = const("Dividend"), Reversed = filter(false));
                column(OpeningBal; OpeningBal)
                {
                }
                column(ClosingBal; ClosingBal)
                {
                }
                column(TransactionType_Dividend; Dividend."Transaction Type")
                {
                }
                column(Amount_Dividend; Dividend.Amount)
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
                column(DebitAmount_Dividend; Dividend."Debit Amount")
                {
                }
                column(CreditAmount_Dividend; Dividend."Credit Amount")
                {
                }
                column(Dividend_Description; Dividend.Description)
                {
                }
                column(BalAccountNo_Dividend; Dividend."Bal. Account No.")
                {
                }
                column(BankCodeDeposits; BankCodeDividend)
                {
                }
                column(USER2; Dividend."User ID")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    BankCodeDeposits := GetBankCode(Dividends);

                    // Assign Credit and Debit Amounts based on Amount Posted
                    AssignCreditDebitAmounts(Dividend."Amount Posted", Dividend."Credit Amount", Dividend."Debit Amount");

                    // Update Closing Balance dynamically after fetching each record
                    ClosingBal += Dividend."Credit Amount" - Dividend."Debit Amount";
                end;


                trigger OnPreDataItem()
                begin
                    // Initialize Balances
                    DepositsBF := 0;
                    OpeningBal := 0;
                    ClosingBal := 0;

                    // **Step 1: Compute Opening Balance (Before AsAt)**
                    Dividend.Reset();
                    Dividend.SetRange("Customer No.", Customer."No.");
                    Dividend.SetFilter("Transaction Type", 'Dividend');
                    Dividend.SetRange(Reversed, false);
                    Dividend.SetFilter("Posting Date", '..' + Format(AsAt)); // Transactions before AsAt

                    if Dividend.FindSet() then
                        repeat
                            // Assign Credit and Debit Amounts based on Amount Posted
                            AssignCreditDebitAmounts(Dividend."Amount Posted", Dividend."Credit Amount", Dividend."Debit Amount");

                            // Compute net balance
                            DepositsBF += Dividend."Credit Amount" - Dividend."Debit Amount";
                        until Dividend.Next() = 0;

                    // Store Opening Balance
                    OpeningBal := DepositsBF;
                    ClosingBal := OpeningBal; // Start with Opening Balance

                    // **Step 2: Fetch Only Transactions from AsAt to Today**
                    Dividend.Reset();
                    Dividend.SetRange("Customer No.", Customer."No.");
                    Dividend.SetFilter("Transaction Type", 'Dividend');
                    Dividend.SetRange(Reversed, false);
                    Dividend.SetRange("Posting Date", AsAt, Today); // Only transactions from AsAt onwards
                end;
            }



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

    local procedure AssignCreditDebitAmounts(AmountPosted: Decimal; var CreditAmount: Decimal; var DebitAmount: Decimal)
    begin
        if AmountPosted < 0 then
            CreditAmount := AmountPosted * -1
        else if AmountPosted > 0 then
            DebitAmount := AmountPosted;
    end;

    var
        AsAt: Date;
        DateFilter: Text;
        BankCodeDeposits: Code[50];
        DepositsBF: Decimal;
        OpenBalance: Decimal;
        CLosingBalance: Decimal;
        OpenBalanceXmas: Decimal;
        CLosingBalanceXmas: Decimal;
        Cust: Record Customer;
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
        TbMembReg: Record Customer;
        MembLedgerEntry: Record "Cust. Ledger Entry";
        Dividends: Record "Cust. Ledger Entry";


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

