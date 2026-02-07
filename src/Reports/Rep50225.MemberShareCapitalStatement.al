#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50225 "Member Share Capital Statement"
{
    ApplicationArea = All;
    RDLCLayout = './Layouts/MemberShares2Statement.rdl';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.", "Loan Product Filter", "Outstanding Balance", "Date Filter";

            column(Payroll_Staff_No; "Payroll/Staff No") { }
            column(Employer_Name; EmployerName) { }
            column(PayrollStaffNo_Members; "Payroll/Staff No") { }
            column(No_Members; "No.") { }
            column(MobilePhoneNo_MembersRegister; "Mobile Phone No") { }
            column(Name_Members; Name) { }
            column(Registration_Date; "Registration Date") { }
            column(EmployerCode_Members; "Employer Code") { }
            column(EmployerName; EmployerName) { }
            column(PageNo_Members; CurrReport.PageNo) { }
            column(Shares_Retained; "Shares Retained") { }
            column(ShareCapBF; ShareCapBF) { }
            column(IDNo_Members; "ID No.") { }
            column(GlobalDimension2Code_Members; "Global Dimension 2 Code") { }
            column(Company_Name; Company.Name) { }
            column(Company_Address; Company.Address) { }
            column(Company_Picture; Company.Picture) { }
            column(Company_Phone; Company."Phone No.") { }
            column(Company_SMS; Company."Phone No.") { }
            column(Company_Email; Company."E-Mail") { }

            dataitem(Share; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No." = field("No.");
                DataItemTableView = sorting("Posting Date") where("Transaction Type" = const("Share Capital"), Reversed = filter(false));

                column(OpeningBal; OpeningBal) { }
                column(ClosingBal; ClosingBal) { }
                column(TransactionType_Shares; Share."Transaction Type") { }
                column(Amount_Shares; Share."Amount Posted") { }
                column(Description_Shares; Share.Description) { }
                column(DocumentNo_Shares; Share."Document No.") { }
                column(PostingDate_Shares; Share."Posting Date") { }
                column(DebitAmount_Shares; Share."Debit Amount") { }
                column(CreditAmount_Shares; Share."Credit Amount") { }
                column(Deposits_Description; Share.Description) { }
                column(BalAccountNo_Shares; Share."Bal. Account No.") { }
                column(BankCodeDeposits; BankCodeDeposits) { }
                column(USER2; Share."User ID") { }

                trigger OnPreDataItem()
                begin
                    // Initialize Opening and Closing Balance
                    ShareCapBF := 0;
                    ClosingBal := ShareCapBF;
                    OpeningBal := ShareCapBF;

                    // **Step 1: Compute Opening Balance (Before AsAt)**
                    Share.Reset();
                    Share.SetRange("Customer No.", Customer."No.");
                    Share.SetRange(Reversed, false);
                    Share.SetFilter("Transaction Type", 'Share Capital');
                    Share.SetFilter("Posting Date", '..' + Format(AsAt)); // Transactions before AsAt

                    if Share.FindSet() then
                        repeat
                            // Assign Credit and Debit Amounts based on Amount Posted
                            AssignCreditDebitAmounts(Share."Amount Posted", Share."Credit Amount", Share."Debit Amount");

                            // Compute net balance
                            ShareCapBF += Share."Credit Amount" - Share."Debit Amount";
                        until Share.Next() = 0;

                    // Store Opening Balance
                    ClosingBal := ShareCapBF;
                    OpeningBal := ShareCapBF;

                    // **Step 2: Fetch Only Transactions from AsAt to Today**
                    Share.Reset();
                    Share.SetRange("Customer No.", Customer."No.");
                    Share.SetRange(Reversed, false);
                    Share.SetFilter("Transaction Type", 'Share Capital');
                    Share.SetRange("Posting Date", AsAt, Today); // Only transactions from AsAt onwards
                end;

                trigger OnAfterGetRecord()
                begin
                    // Assign Credit and Debit Amounts based on Amount Posted
                    AssignCreditDebitAmounts(Share."Amount Posted", Share."Credit Amount", Share."Debit Amount");

                    // Update Closing Balance dynamically
                    ClosingBal := ClosingBal - Share."Amount Posted";

                    // Retrieve Bank Code
                    BankCodeDeposits := GetBankCode(Share);
                end;

            }

            trigger OnAfterGetRecord()
            begin
                SaccoEmp.Reset();
                SaccoEmp.SetRange(SaccoEmp.Code, "Employer Code");
                if SaccoEmp.FindFirst() then
                    EmployerName := SaccoEmp.Description
                else
                    EmployerName := 'Unknown';

                // ShareCapBF := 0;
                // if GetFilter("Date Filter") <> '' then begin
                //     DateFilterBF := '..' + Format(CalcDate('-1D', GetRangeMin("Date Filter")));
                //     Cust.Reset;
                //     Cust.SetRange(Cust."No.", "No.");
                //     Cust.SetFilter(Cust."Date Filter", DateFilterBF);
                //     if Cust.FindFirst() then begin
                //         Cust.CalcFields(Cust."Shares Retained", Cust."Current Shares", Cust."Insurance Fund", Cust."Holiday Savings");
                //         ShareCapBF := Cust."Shares Retained";
                //     end;
                // end else
                //     Error('Date Filter Required');
            end;

            trigger OnPreDataItem()
            begin
                if GetFilter("Date Filter") <> '' then
                    DateFilterBF := '..' + Format(CalcDate('-1D', GetRangeMin("Date Filter")));
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
        actions { }
    }

    trigger OnPreReport()
    begin
        if not Company.Get() then
            Error('Company Information record is missing.');
        Company.CalcFields(Company.Picture);

        // Set AsAt to the beginning of the current year if not provided
        if AsAt = 0D then
            AsAt := DMY2Date(1, 1, Date2DMY(Today, 3));

        //DateFilter := '..' + Format(AsAt);
    end;

    local procedure GetBankCode(MembLedger: Record "Cust. Ledger Entry"): Text
    var
        BankLedger: Record "Bank Account Ledger Entry";
    begin
        BankLedger.Reset;
        BankLedger.SetRange("Posting Date", MembLedger."Posting Date");
        // BankLedger.SetRange("Document No.", MembLedger."Document No.");
        // BankLedger.SetRange("Transaction No.", MembLedger."Transaction No.");
        if BankLedger.FindFirst then
            exit(BankLedger."Bank Account No.");
        exit('BankCodeError');
    end;

    local procedure AssignCreditDebitAmounts(AmountPosted: Decimal; var CreditAmount: Decimal; var DebitAmount: Decimal)
    begin
        if AmountPosted < 0 then
            CreditAmount := AmountPosted * -1
        else if AmountPosted > 0 then
            DebitAmount := AmountPosted;
    end;

    var
        //Cust: Record "Cust. Ledger Entry";
        Cust: Record Customer;
        AsAt: Date;
        OpeningBal: Decimal;
        ClosingBal: Decimal;
        DateFilterBF: Text[150];
        ShareCapBF: Decimal;
        Company: Record "Company Information";
        SaccoEmp: Record "Sacco Employers";
        EmployerName: Text[100];
        BankCodeDeposits: Text;
        loans: Record "Loans Register";


}
