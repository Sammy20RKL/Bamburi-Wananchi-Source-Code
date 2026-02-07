report 51581 "Deposit Refund Report"
{
    ApplicationArea = All;
    Caption = 'Deposit Refund Report';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './Layout/DepositRefund.rdlc';

    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            DataItemTableView = sorting("Entry No.");  // Filter will be set in OnPreReport

            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyAddress; CompanyInfo.Address)
            {
            }
            column(CompanyPhone; CompanyInfo."Phone No.")
            {
            }
            column(CompanyPic; CompanyInfo.Picture)
            {
            }
            column(CompanyEmail; CompanyInfo."E-Mail")
            {
            }


            column(EntryNo; "Entry No.") { }
            column(PostingDate; "Posting Date") { }
            column(DocumentNo; "Document No.") { }
            column(Description; Description) { }
            column(DebitAmount; "Debit Amount") { }
            column(CreditAmount; "Credit Amount") { }
            column(SourceNo; "Source No.") { }
            column(MemberName; MemberName) { }
            column(RefundAmount; RefundAmount) { }
            column(PaidAmount; PaidAmount) { }
            column(BalanceAmount; RefundAmount - PaidAmount) { }
            column(RefundStatus; RefundStatus) { }

            trigger OnAfterGetRecord()
            var
                RefundGLEntry: Record "G/L Entry";
                PaymentGLEntry: Record "G/L Entry";
                PaymentBalancingEntry: Record "G/L Entry";
                Customer: Record Customer;
            begin
                // Initialize variables
                MemberName := '';
                RefundAmount := "Debit Amount";  // Debit from Member Deposits Account
                PaidAmount := 0;
                RefundStatus := 'Pending';

                // Get member name
                if Customer.Get("Source No.") then
                    MemberName := Customer.Name;

                // Find the balancing entry in the Deposit Refunds Account
                // Must have same document no, posting date, and matching amount (credit = our debit)
                RefundGLEntry.Reset();
                RefundGLEntry.SetRange("Document No.", "Document No.");
                RefundGLEntry.SetRange("Posting Date", "Posting Date");
                RefundGLEntry.SetRange("G/L Account No.", DepositRefundsAccountNo);
                RefundGLEntry.SetRange("Credit Amount", "Debit Amount");  // Amount must match exactly

                if not RefundGLEntry.FindFirst() then
                    CurrReport.Skip();  // Skip if not a refund transaction

                // Now look for payment entries (Deposit Refunds Account DR, Current Account CR)
                // These will have different document numbers but same source/customer
                PaymentGLEntry.Reset();
                PaymentGLEntry.SetRange("G/L Account No.", DepositRefundsAccountNo);
                PaymentGLEntry.SetFilter("Debit Amount", '>0');
                PaymentGLEntry.SetRange("Source No.", "Source No.");  // Same member/customer

                if "Source No." <> '' then begin  // Only if we have a valid source number
                    if PaymentGLEntry.FindSet() then begin
                        repeat
                            // For each debit to Deposit Refunds account for this member,
                            // Check if there's a matching credit to Current Account with same document no
                            PaymentBalancingEntry.Reset();
                            PaymentBalancingEntry.SetRange("Document No.", PaymentGLEntry."Document No.");
                            PaymentBalancingEntry.SetRange("Posting Date", PaymentGLEntry."Posting Date");
                            PaymentBalancingEntry.SetRange("G/L Account No.", CurrentAccountNo);
                            PaymentBalancingEntry.SetRange("Credit Amount", PaymentGLEntry."Debit Amount");

                            if not PaymentBalancingEntry.IsEmpty() then begin
                                // Valid payment found
                                PaidAmount += PaymentGLEntry."Debit Amount";
                            end;
                        until PaymentGLEntry.Next() = 0;
                    end;
                end;

                // Set the status based on payment amount
                if PaidAmount = 0 then
                    RefundStatus := 'Pending'
                else if PaidAmount < RefundAmount then
                    RefundStatus := 'Partially Paid'
                else
                    RefundStatus := 'Fully Paid';

                // Update totals
                TotalRefundAmount += RefundAmount;
                TotalPaidAmount += PaidAmount;
                CountRefunds += 1;
            end;
        }

        dataitem(Totals; "Integer")
        {
            DataItemTableView = where(Number = const(1));

            column(TotalRefundAmount; TotalRefundAmount) { }
            column(TotalPaidAmount; TotalPaidAmount) { }
            column(TotalBalanceAmount; TotalRefundAmount - TotalPaidAmount) { }
            column(CountRefunds; CountRefunds) { }
            column(StartDateText; Format(StartDate)) { }
            column(EndDateText; Format(EndDate)) { }
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    field(StartDate; StartDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Start Date';
                    }
                    field(EndDate; EndDate)
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';
                    }
                    field(MemberDepositsAccountNoField; MemberDepositsAccountNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Member Deposits G/L Account No.';
                        TableRelation = "G/L Account";
                    }
                    field(DepositRefundsAccountNoField; DepositRefundsAccountNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Deposit Refunds G/L Account No.';
                        TableRelation = "G/L Account";
                    }
                    field(CurrentAccountNoField; CurrentAccountNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Current G/L Account No.';
                        TableRelation = "G/L Account";
                    }
                    field(MemberNoFilter; MemberNoFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Member No. Filter';
                        TableRelation = Customer;
                    }
                }
            }
        }
    }

    var
        CompanyInfo: Record "Company Information";
        StartDate: Date;
        EndDate: Date;
        MemberDepositsAccountNo: Code[20];
        DepositRefundsAccountNo: Code[20];
        CurrentAccountNo: Code[20];
        MemberNoFilter: Code[20];
        MemberName: Text[100];
        RefundAmount: Decimal;
        PaidAmount: Decimal;
        RefundStatus: Text[20];
        TotalRefundAmount: Decimal;
        TotalPaidAmount: Decimal;
        CountRefunds: Integer;

    trigger OnPreReport()
    begin

        CompanyInfo.Get();
        //Datefilter := Customer.GetFilter("Date Filter");
        CompanyInfo.CalcFields(CompanyInfo.Picture);

        if MemberDepositsAccountNo = '' then
            Error('Please specify the Member Deposits G/L Account No.');

        if DepositRefundsAccountNo = '' then
            Error('Please specify the Deposit Refunds G/L Account No.');

        if CurrentAccountNo = '' then
            Error('Please specify the Current G/L Account No.');

        // Set the filter to find all debits from Member Deposits Account
        "G/L Entry".SetRange("G/L Account No.", MemberDepositsAccountNo);
        "G/L Entry".SetFilter("Debit Amount", '>0');

        // Filter by date if specified
        if (StartDate <> 0D) and (EndDate <> 0D) then
            "G/L Entry".SetRange("Posting Date", StartDate, EndDate);

        // Filter by member if specified
        if MemberNoFilter <> '' then
            "G/L Entry".SetRange("Source No.", MemberNoFilter);

        // Reset totals
        TotalRefundAmount := 0;
        TotalPaidAmount := 0;
        CountRefunds := 0;
    end;
}