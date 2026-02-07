#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 

report 50229 "Detailed Active Statement"
{
    RDLCLayout = './Layout/MemberDetailedActiveStatement.rdl';
    DefaultLayout = RDLC;
    Caption = 'Member Detailed Active Statement';

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.", "Loan Product Filter", "Outstanding Balance", "Date Filter";

            column(USERID; UserId) { }
            column(PayrollStaffNo_Members; Customer."Personal No") { }
            column(No_Members; Customer."No.") { }
            column(Name_Members; Customer.Name) { }
            column(EmployerName; Customer."Employer Name") { }
            column(Shares_Retained; Customer."Shares Retained") { }
            column(HolidaySavings_cj; Customer."Holiday Savings") { }
            column(IDNo_Members; Customer."ID No.") { }
            column(Company_Address; Company.Address) { }
            column(Company_Address_2; Company."Address 2") { }
            column(Company_Fax_No; Company."Phone No.") { }
            column(RegistrationDate_MemberRegister; Customer."Registration Date") { }
            column(PhoneNo_MemberRegister; Customer."Phone No.") { }
            column(CurrentShares_MemberRegister; Customer."Current Shares") { }
            column(Company_Email; Company."E-Mail") { }

            dataitem(ShareCapital; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No." = field("No."), "Posting Date" = field("Date Filter");
                DataItemTableView = sorting("Posting Date") where("Transaction Type" = filter("Share Capital"), Reversed = filter(false));

                column(PostingDate_ShareCapital; ShareCapital."Posting Date") { }
                column(DocumentNo_ShareCapital; ShareCapital."Document No.") { }
                column(Description_ShareCapital; ShareCapital.Description) { }
                column(DebitAmount_ShareCapital; ShareCapital."Debit Amount") { }
                column(CreditAmount_ShareCapital; ShareCapital."Credit Amount") { }
                column(TransactionType_ShareCapital; ShareCapital."Transaction Type") { }
                column(OpenBalanceShareCap; OpenBalanceShareCap) { }
                column(ClosingBalanceShareCap; ClosingBalanceShareCap) { }
                column(AmountPosted_ShareCapital; ShareCapital."Amount Posted") { }
                column(FinalClosingBalanceShare; FinalClosingBalanceShare) { }



                trigger OnAfterGetRecord()
                begin
                    // Increment counter for each processed record
                    RecordCounter += 1;

                    // Assign debit/credit values
                    if ShareCapital."Amount Posted" < 0 then
                        ShareCapital."Credit Amount" := (ShareCapital."Amount Posted" * -1)
                    else if ShareCapital."Amount Posted" > 0 then
                        ShareCapital."Debit Amount" := (ShareCapital."Amount Posted");

                    // Update Closing Balance
                    ClosingBalanceShareCap += ShareCapital."Credit Amount" - ShareCapital."Debit Amount";

                    // If this is the last record, store the final balance
                    // if RecordCounter = TotalRecords then begin
                    FinalClosingBalanceShare := ClosingBalanceShareCap;
                end;


            }


            //=(Sum(Fields!DebitAmount_Insurance.Value) - Sum(Fields!CreditAmount_Insurance.Value) + First(Fields!InsuranceBF.Value, "DataSet_Result")) * - 1
            dataitem(Insurance; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No." = field("No."), "Posting Date" = field("Date Filter");
                DataItemTableView = sorting("Posting Date") where("Transaction Type" = filter("Insurance Contribution"), Reversed = filter(false));

                column(PostingDate_Insurance; Insurance."Posting Date") { }
                column(DocumentNo_Insurance; Insurance."Document No.") { }
                column(Description_Insurance; Insurance.Description) { }
                column(TransactionType_Insurance; Insurance."Transaction Type") { }
                column(DebitAmount_Insurance; Insurance."Debit Amount") { }
                column(CreditAmount_Insurance; Insurance."Credit Amount") { }
                column(OpenBalanceInsurance; OpenBalanceInsurance) { }
                column(ClosingBalanceInsurance; ClosingBalanceInsurance) { }
                column(InsuranceBF; InsuranceBF) { }
                column(Insurance_AmountPosted; Insurance."Amount Posted") { }
                column(FinalClosingBalanceInsurance; FinalClosingBalanceInsurance) { }

                trigger OnAfterGetRecord()
                begin
                    // Assign Credit and Debit Amounts based on Amount Posted
                    AssignCreditDebitAmounts(Insurance."Amount Posted", Insurance."Credit Amount", Insurance."Debit Amount");

                    // Update Closing Balance dynamically after fetching each record
                    ClosingBalanceInsurance += Insurance."Credit Amount" - Insurance."Debit Amount";
                    // Assign final balance after last record is processed
                    FinalClosingBalanceInsurance := ClosingBalanceInsurance;

                end;

            }


            dataitem(Deposits; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No." = field("No."), "Posting Date" = field("Date Filter");
                DataItemTableView = sorting("Posting Date") where("Transaction Type" = filter("Deposit Contribution"), Reversed = filter(false));

                column(PostingDate_Deposits; Deposits."Posting Date") { }
                column(DocumentNo_Deposits; Deposits."Document No.") { }
                column(Description_Deposits; Deposits.Description) { }
                column(DebitAmount_Deposits; Deposits."Debit Amount") { }
                column(CreditAmount_Deposits; Deposits."Credit Amount") { }
                column(TransactionType_Deposits; Deposits."Transaction Type") { }
                column(OpenBalanceDeposits; OpenBalanceDeposits) { }
                column(ClosingBalanceDeposits; ClosingBalanceDeposits) { }
                column(FinalClosingBalanceDeposits; FinalClosingBalanceDeposits) { }


                trigger OnAfterGetRecord()
                begin
                    // Assign Credit and Debit Amounts based on Amount Posted
                    AssignCreditDebitAmounts(Deposits."Amount Posted", Deposits."Credit Amount", Deposits."Debit Amount");

                    // Update Closing Balance dynamically after fetching each record
                    ClosingBalanceDeposits += Deposits."Credit Amount" - Deposits."Debit Amount";

                    // Assign final balance after last record is processed
                    FinalClosingBalanceDeposits := ClosingBalanceDeposits; //+ (Deposits."Credit Amount" * -1);

                end;


            }

            dataitem(Dividend; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No." = field("No."), "Posting Date" = field("Date Filter");
                DataItemTableView = sorting("Posting Date") where("Transaction Type" = filter(Dividend), Reversed = filter(false));

                column(PostingDate_Dividend; Dividend."Posting Date") { }
                column(DocumentNo_Dividend; Dividend."Document No.") { }
                column(Description_Dividend; Dividend.Description) { }
                column(TransactionType_Dividend; Dividend."Transaction Type") { }
                column(DebitAmount_Dividend; Dividend."Debit Amount") { }
                column(CreditAmount_Dividend; Dividend."Credit Amount") { }
                column(ClosingBalanceDividend; ClosingBalanceDividend) { }
                column(FinalClosingBalanceDividends; FinalClosingBalanceDividends) { }
                column(DividendBF; DividendBF) { }

                trigger OnAfterGetRecord()
                begin
                    // Assign Credit and Debit Amounts based on Amount Posted
                    AssignCreditDebitAmounts(Dividend."Amount Posted", Dividend."Credit Amount", Dividend."Debit Amount");

                    // Update Closing Balance dynamically after fetching each record
                    ClosingBalanceDividend += Dividend."Credit Amount" - Dividend."Debit Amount";
                    // Assign final balance after last record is processed
                    FinalClosingBalanceDividends := ClosingBalanceDividend + Dividend."Credit Amount";

                end;


            }

            dataitem(Benefund; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No." = field("No."), "Posting Date" = field("Date Filter");
                DataItemTableView = sorting("Posting Date") where("Transaction Type" = filter("Benevolent Fund"), Reversed = filter(false));

                column(PostingDate_Benefund; Benefund."Posting Date") { }
                column(DocumentNo_Benefund; Benefund."Document No.") { }
                column(Description_Benefund; Benefund.Description) { }
                column(TransactionType_Benefund; Benefund."Transaction Type") { }
                column(DebitAmount_Benefund; Benefund."Debit Amount") { }
                column(CreditAmount_Benefund; Benefund."Credit Amount") { }
                column(ClosingBalanceBenefund; ClosingBalanceBenefund) { }
                column(BenefundBF; BenefundBF) { }

                trigger OnPreDataItem()
                begin
                    ClosingBalanceBenefund := BenefundBF;
                    OpenBalanceBenefund := BenefundBF;
                end;

                trigger OnAfterGetRecord()
                begin
                    ClosingBalanceBenefund := ClosingBalanceBenefund + (Benefund."Amount Posted" * -1);
                end;
            }
            dataitem(Holiday; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No." = field("No."), "Posting Date" = field("Date Filter");
                DataItemTableView = sorting("Posting Date") where("Transaction Type" = filter("Holiday Savings"), Reversed = filter(false));

                column(PostingDate_Holiday; Holiday."Posting Date") { }
                column(DocumentNo_Holiday; Holiday."Document No.") { }
                column(Description_Holiday; Holiday.Description) { }
                column(DebitAmount_Holiday; Holiday."Debit Amount") { }
                column(CreditAmount_Holiday; Holiday."Credit Amount") { }
                column(TransactionType_Holiday; Holiday."Transaction Type") { }
                column(ClosingBalanceH; ClosingBalanceH) { }
                column(OpeningBalanceH; OpeningBalanceH) { }
                column(DiffHoliday; DiffHoliday) { }
                column(FinalClosingBalanceHoliday; FinalClosingBalanceHoliday) { }


                trigger OnAfterGetRecord()
                begin
                    // Assign Credit and Debit Amounts based on Amount Posted
                    AssignCreditDebitAmounts(Holiday."Amount Posted", Holiday."Credit Amount", Holiday."Debit Amount");
                    TotalDrHoliday += Holiday."Debit Amount";
                    TotalCrHoliday += Holiday."Credit Amount";


                    DiffHoliday := TotalCrHoliday - TotalDrHoliday;
                    //Message('Total HolidayCredit %1 vs TotalDebit of %2', TotalCrHoliday, TotalDrHoliday);

                    // Update Closing Balance dynamically after fetching each record
                    ClosingBalanceH += Holiday."Credit Amount" - Holiday."Debit Amount";
                    // Assign final balance after last record is processed
                    FinalClosingBalanceHoliday := ClosingBalanceH + Holiday."Credit Amount";

                end;


            }

            dataitem(FOSAShares; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No." = field("No."), "Posting Date" = field("Date Filter");
                DataItemTableView = sorting("Posting Date") where("Transaction Type" = filter("FOSA Shares"), Reversed = filter(false));

                column(PostingDate_FOSAShares; FOSAShares."Posting Date") { }
                column(DocumentNo_FOSAShares; FOSAShares."Document No.") { }
                column(Description_FOSAShares; FOSAShares.Description) { }
                column(DebitAmount_FOSAShares; FOSAShares."Debit Amount") { }
                column(CreditAmount_FOSAShares; FOSAShares."Credit Amount") { }
                column(TransactionType_FOSAShares; FOSAShares."Transaction Type") { }
                column(ClosingBalanceFOSAShares; ClosingBalanceFOSAShares) { }
                column(FOSASharesBF; FOSASharesBF) { }

                trigger OnPreDataItem()
                begin
                    ClosingBalanceFOSAShares := FOSASharesBF;
                    OpenBalanceFOSAShares := FOSASharesBF;
                    // ReportForNav.OnPreDataItem('FOSAShares', FOSAShares);
                end;

                trigger OnAfterGetRecord()
                begin
                    ClosingBalanceFOSAShares := ClosingBalanceFOSAShares + (FOSAShares."Amount Posted" * -1);
                end;
            }
            dataitem(AdditionalShares; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No." = field("No."), "Posting Date" = field("Date Filter");
                DataItemTableView = sorting("Posting Date") where("Transaction Type" = filter("Unallocated Funds"), Reversed = filter(false));

                column(PostingDate_AdditionalShares; AdditionalShares."Posting Date") { }
                column(DocumentNo_AdditionalShares; AdditionalShares."Document No.") { }
                column(Description_AdditionalShares; AdditionalShares.Description) { }
                column(DebitAmount_AdditionalShares; AdditionalShares."Debit Amount") { }
                column(CreditAmount_AdditionalShares; AdditionalShares."Credit Amount") { }
                column(TransactionType_AdditionalShares; AdditionalShares."Transaction Type") { }
                column(ClosingBalanceAdditionalShares; ClosingBalanceAdditionalShares) { }
                column(AdditionalSharesBF; AdditionalSharesBF) { }

                trigger OnPreDataItem()
                begin
                    ClosingBalanceAdditionalShares := AdditionalSharesBF;
                    OpenBalanceAdditionalShares := AdditionalSharesBF;
                    if Customer.GetFilter(Customer."Date Filter") <> '' then
                        DateFilterBF := '..' + Format(CalcDate('-1D', Customer.GetRangeMin(Customer."Date Filter")));

                end;

                trigger OnAfterGetRecord()
                begin
                    ClosingBalanceAdditionalShares := ClosingBalanceAdditionalShares + AdditionalShares."Amount Posted" * -1;
                end;
            }

            dataitem(Loans; "Loans Register")
            {
                CalcFields = "Outstanding Balance";
                DataItemLink = "Client Code" = field("No."), "Loan Product Type" = field("Loan Product Filter"), "Date filter" = field("Date Filter");
                DataItemTableView = sorting("Loan  No.") where(Posted = const(true), "Loan  No." = filter(<> ''), "Outstanding Balance" = filter(> 0));//, "Outstanding Balance" = filter(> 0)
                //column(PostingDate_loan; Loan."Posting Date") { }

                column(LoanNumber; Loans."Loan  No.") { }//LoanNumber
                column(LoanProductType; Loans."Loan Product Type Name") { }//LoanName
                column(Requested_Amount; Loans."Requested Amount") { }
                column(InterestAmount; Loans.Interest) { }
                column(Installments; Loans.Installments) { }
                column(PrincipalAmount; Loans."Loan Principle Repayment") { }//LoanPrincipleRepayment
                column(ApprovedAmount_Loan; loans."Approved Amount") { }//ApprovedAmountcj
                column(Repayment; Loans.Repayment) { }//Repayment_Loans
                column(Mode_of_Disbursement; Loans."Mode of Disbursement") { }//ModeofDisbursement_Loans
                column(OutstandingBalance_Loans; Loans."Outstanding Balance") { }
                column(OustandingInterest_Loans; Loans."Oustanding Interest") { }
                // column(TotalRepayments; TotalRepayments) { }
                column(OutstandingBalance; OutstandingBalance) { }

                dataitem(Loan; "Cust. Ledger Entry")
                {
                    //DataItemLink = "Customer No." = FIELD("No."), "Loan No" = FIELD("Loan No"), "Posting Date" = FIELD("Date Filter");
                    DataItemLink = "Customer No." = field("Client Code"), "Loan No" = field("Loan  No."), "Posting Date" = field("Date Filter");//
                    DataItemTableView = sorting("Posting Date") where("Transaction Type" = FILTER(Loan | "Loan Repayment" | "Interest Due" | "Interest Paid"), Reversed = filter(false));

                    column(PostingDate_loan; Loan."Posting Date") { }
                    column(DocumentNo_loan; Loan."Document No.") { }
                    column(Description_loan; Loan.Description) { }
                    column(Loan_Description; Loan.Description) { }

                    column(DebitAmount_Loan; Loan."Debit Amount") { }
                    column(CreditAmount_Loan; Loan."Credit Amount") { }
                    column(Amount_Loan; Loan."Amount Posted") { }//Amount
                    column(openBalance_loan; OpenBalanceLoan) { }
                    column(CLosingBalance_loan; ClosingBalanceLoan) { }
                    column(TransactionType_loan; Loan."Transaction Type") { }
                    column(LoanNo; Loan."Loan No") { }
                    column(PrincipleBF_loans; PrincipleBF) { }
                    column(User_ID; loan."User ID") { }
                    trigger OnPreDataItem()
                    begin
                        RecordCounter := 0;
                        // Initialize Balances
                        ClosingBalanceLoan := 0;
                    end;

                    trigger OnAfterGetRecord()
                    begin
                        // Assign Credit and Debit Amounts based on Amount Posted
                        AssignCreditDebitAmounts(Loan."Amount Posted", Loan."Credit Amount", Loan."Debit Amount");

                        // Ensure ClosingBalanceLoan is updated correctly
                        ClosingBalanceLoan := ClosingBalanceLoan + (Loan."Credit Amount" - Loan."Debit Amount");

                        // Ensure Loan No. is properly checked
                        IF Loan."Loan No" = '' THEN BEGIN
                            // Handle empty Loan No. case if needed
                        END;

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


                trigger OnPreDataItem()
                begin
                    TotalRepayments := 0;
                    OutstandingBalance := Loans."Loan Principle Repayment";
                end;

                trigger OnAfterGetRecord()
                begin
                    OutstandingBalance := 0;
                    TotalRepayments := TotalRepayments + (Loans."Loan Principle Repayment" + Loans.Interest);
                    OutstandingBalance := Loans."Outstanding Balance";// - Loans."Oustanding Interest";
                end;
            }



        }
    }



    requestpage
    {

        layout
        {
            // area(content)
            // { field(From; AsAt) { } }
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
        UserId: Code[50];
        DepositsBF: Decimal;
        DateFilterBF: Text[150];
        OpenBalanceShareCap: Decimal;
        ClosingBalanceShareCap: Decimal;
        LastClosingBalance: Decimal;
        FinalClosingBalanceShare: Decimal;
        RecordCounter: Integer; // Counter for tracking records processed
        TotalRecords: Integer; // Total number of records
        LastCreditAmount: Decimal;
        OpenBalanceAdditionalShares: Decimal;
        ClosingBalanceAdditionalShares: Decimal;
        ShareCapBF: Decimal;
        AdditionalSharesBF: Decimal;
        Company: Record "Company Information";
        StartDate: Date;
        LoanNumber: Code[50];
        ClosingBalanceInsurance: Decimal;
        FinalClosingBalanceInsurance: Decimal;
        OpenBalanceInsurance: Decimal;
        InsuranceBF: Decimal;
        DateFilter: Text;
        AsAt: Date;
        DateBD: Date;

        ClosingBalanceDividend: Decimal;
        FinalClosingBalanceDividends: Decimal;
        OpenBalanceDividend: Decimal;
        DividendBF: Decimal;
        OpeningBalanceH: Decimal;
        ClosingBalanceBenefund: Decimal;
        OpenBalanceBenefund: Decimal;
        BenefundBF: Decimal;
        HolidaySharesBF: Decimal;
        ClosingBalanceH: Decimal;
        FinalClosingBalanceHoliday: Decimal;
        TotalDrHoliday: Decimal;
        TotalCrHoliday: Decimal;
        DiffHoliday: Decimal;
        ClosingBalanceFOSAShares: Decimal;
        OpenBalanceFOSAShares: Decimal;
        FOSASharesBF: Decimal;
        SharesBF: Decimal;
        OpenBalanceDeposits: Decimal;
        ClosingBalanceDeposits: Decimal;
        FinalClosingBalanceDeposits: Decimal;
        subtotaldeposit: Decimal;
        TotalRepayments: Decimal;
        OutstandingBalance: Decimal;
        ClosingBalanceLoan: Decimal;
        OpenBalanceLoan: Decimal;
        PrincipleBF: Decimal;
        ClosingBalance: Decimal;
        ClosingBalInt: Decimal;
        ClosingBal: Decimal;
        OpeningBal: Decimal;
        InterestPaid: Decimal;
        SumInterestPaid: Decimal;
        LoanInterest: Decimal;
        StartOfYear: Date;
}