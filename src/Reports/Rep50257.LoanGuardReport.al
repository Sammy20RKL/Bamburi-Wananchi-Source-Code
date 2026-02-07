#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50257 "Loan Guard Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Loan Guard Report.rdlc';

    dataset
    {
        dataitem(Loans; "Loans Register")
        {
            DataItemTableView = sorting("Staff No") order(ascending) where(Posted = const(true), "Outstanding Balance" = filter('>0'), "Loan Product Type" = filter('<>15&<>16&<>17&<>24'));          // RequestFilterFields = "Date filter", "Issued Date";
            column(ReportForNavId_4645; 4645)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(USERID; UserId)
            {
            }
            column(LoanType; LoanType)
            {
            }
            column(RFilters; RFilters)
            {
            }
            column(Loans__Loan__No__; "Loan  No.")
            {
            }
            column(Loans__Client_Code_; "Client Code")
            {
            }
            column(Loans__Client_Name_; "Client Name")
            {
            }
            column(Loans__Requested_Amount_; "Requested Amount")
            {
            }
            column(Loans__Approved_Amount_; "Approved Amount")
            {
            }
            column(Loans_Installments; Installments)
            {
            }
            column(Loans__Loan_Status_; "Loan Status")
            {
            }
            column(Loans_Loans__Outstanding_Balance_; Loans."Outstanding Balance")
            {
            }
            column(Loans__Application_Date_; "Application Date")
            {
            }
            column(Loans__Issued_Date_; "Issued Date")
            {
            }
            column(Loans__Oustanding_Interest_; "Oustanding Interest")
            {
            }
            column(Loans_Loans__Loan_Product_Type_; Loans."Loan Product Type")
            {
            }
            column(Loans__Last_Pay_Date_; "Last Pay Date")
            {
            }
            column(Loans__Top_Up_Amount_; "Top Up Amount")
            {
            }
            column(Loans__Approved_Amount__Control1102760017; "Approved Amount")
            {
            }
            column(Loans__Requested_Amount__Control1102760038; "Requested Amount")
            {
            }
            column(LCount; LCount)
            {
            }
            column(Loans_Loans__Outstanding_Balance__Control1102760040; Loans."Outstanding Balance")
            {
            }
            column(Loans__Oustanding_Interest__Control1102760041; "Oustanding Interest")
            {
            }
            column(Loans__Top_Up_Amount__Control1000000001; "Top Up Amount")
            {
            }
            column(RPeriod; RPeriod)
            {
            }
            column(currentBalance; currentBalance)
            {
            }
            column(StartDate; StartDate)
            {
            }
            column(EndDate; EndDate)
            {
            }
            column(DateRangeText; DateRangeText)
            {
            }
            column(Loans_RegisterCaption; Loans_RegisterCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Loan_TypeCaption; Loan_TypeCaptionLbl)
            {
            }
            column(Loans__Loan__No__Caption; FieldCaption("Loan  No."))
            {
            }
            column(Client_No_Caption; Client_No_CaptionLbl)
            {
            }
            column(Loans__Client_Name_Caption; FieldCaption("Client Name"))
            {
            }
            column(Loans__Requested_Amount_Caption; FieldCaption("Requested Amount"))
            {
            }
            column(Loans__Approved_Amount_Caption; FieldCaption("Approved Amount"))
            {
            }
            column(Loans__Loan_Status_Caption; FieldCaption("Loan Status"))
            {
            }
            column(Outstanding_LoanCaption; Outstanding_LoanCaptionLbl)
            {
            }
            column(PeriodCaption; PeriodCaptionLbl)
            {
            }
            column(Loans__Application_Date_Caption; FieldCaption("Application Date"))
            {
            }
            column(Approved_DateCaption; Approved_DateCaptionLbl)
            {
            }
            column(Loans__Oustanding_Interest_Caption; FieldCaption("Oustanding Interest"))
            {
            }
            column(Loan_TypeCaption_Control1102760043; Loan_TypeCaption_Control1102760043Lbl)
            {
            }
            column(Loans__Last_Pay_Date_Caption; FieldCaption("Last Pay Date"))
            {
            }
            column(Loans__Top_Up_Amount_Caption; FieldCaption("Top Up Amount"))
            {
            }
            column(Verified_By__________________________________________________Caption; Verified_By__________________________________________________CaptionLbl)
            {
            }
            column(Confirmed_By__________________________________________________Caption; Confirmed_By__________________________________________________CaptionLbl)
            {
            }
            column(Sign________________________Caption; Sign________________________CaptionLbl)
            {
            }
            column(Sign________________________Caption_Control1102755003; Sign________________________Caption_Control1102755003Lbl)
            {
            }
            column(Date________________________Caption; Date________________________CaptionLbl)
            {
            }
            column(Date________________________Caption_Control1102755005; Date________________________Caption_Control1102755005Lbl)
            {
            }
            column(Idno; IDno)
            {
            }
            column(Dob; Dob)
            {
            }

            trigger OnAfterGetRecord()
            begin
                // Check if record falls within date range (if specified)
                if not IsRecordInDateRange() then
                    CurrReport.Skip();

                // Assign CompanyCode
                CompanyCode := '';
                if cust.Get(Loans."BOSA No") then
                    CompanyCode := cust."Employer Code";

                // Get DOB and ID No. only if Source is BOSA
                if Loans.Source = Loans.Source::BOSA then begin
                    if cust.Get(Loans."Client Code") then begin
                        Dob := cust."Date of Birth";
                        IDno := cust."ID No.";
                    end;
                end;

                // Calculate current balance and repayment period
                RPeriod := 0;
                currentBalance := 0;

                // Avoid using LoanRec unless necessary – it's used only to loop once per Loan No.
                Loans.CalcFields("Outstanding Balance");
                currentBalance := Loans."Outstanding Balance";

                if currentBalance > 0 then
                    RPeriod := Installments - GetRepayment("Loan  No.", GetAsAtDate());

                LCount += 1;
            end;

            trigger OnPreDataItem()
            var
                LoanProdTypeFilter: Text;
                BranchFilter: Text;
            begin
                LCount := 0;
                RFilters := '';

                // Build date range text for display
                BuildDateRangeText();

                LoanType := LowerCase(Loans."Loan Product Type Name");
                if StrLen(LoanType) > 0 then
                    LoanType := UpperCase(CopyStr(LoanType, 1, 1)) + CopyStr(LoanType, 2);

                // Handle Branch Code Filter
                BranchFilter := Loans.GetFilter("Branch Code");
                if BranchFilter <> '' then begin
                    DValue.Reset();
                    DValue.SetRange("Global Dimension No.", 2);
                    DValue.SetRange(Code, BranchFilter);
                    if DValue.FindFirst() then
                        RFilters := 'Branch: ' + DValue.Name
                    else
                        RFilters := 'Branch: ' + BranchFilter; // fallback if dimension name not found
                end;

                // Add date range to filters if specified
                if DateRangeText <> '' then begin
                    if RFilters <> '' then
                        RFilters := RFilters + ' | ' + DateRangeText
                    else
                        RFilters := DateRangeText;
                end;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group("Date Range")
                {
                    Caption = 'Date Range (Optional)';
                    field(StartDateField; StartDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Start Date';
                        ToolTip = 'Specify the start date for filtering. Leave blank to include all records from the beginning.';
                    }
                    field(EndDateField; EndDate)
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';
                        ToolTip = 'Specify the end date for filtering. Leave blank to include all records up to today.';
                    }
                    // field(DateFilterFieldInfo; DateFilterField)
                    // {
                    //     ApplicationArea = All;
                    //     Caption = 'Filter Based On';
                    //     ToolTip = 'Select which date field to use for filtering.';
                    // }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            // Set default values if needed
            DateFilterField := DateFilterField::"Issued Date";
        end;
    }

    labels
    {
    }

    local procedure GetRepayment(LoanNos: Code[20]; DateFiltering: Date): Decimal
    var
        RepaymentInstallments: Decimal;
    begin
        RepaymentInstallments := 0;
        RepaymentSchedule.Reset();
        RepaymentSchedule.SetRange("Loan No.", LoanNos);
        RepaymentSchedule.SetRange("Repayment Date", 0D, DateFiltering);

        if RepaymentSchedule.FindSet() then begin
            repeat
                // Adjust logic if Repayment Code is numeric
                RepaymentInstallments += 1;
            until RepaymentSchedule.Next() = 0;
        end;

        exit(RepaymentInstallments);
    end;

    local procedure IsRecordInDateRange(): Boolean
    var
        DateToCheck: Date;
    begin
        // If no date filters are specified, include all records
        if (StartDate = 0D) and (EndDate = 0D) then
            exit(true);

        // // Determine which date field to check
        // case DateFilterField of
        //     DateFilterField::"Application Date":
        //         DateToCheck := Loans."Application Date";
        //     DateFilterField::"Issued Date":
        //         DateToCheck := Loans."Issued Date";
        //     DateFilterField::"Posting Date":
        //         DateToCheck := Loans."Posting Date";
        // end;

        DateToCheck := Loans."Issued Date";

        if (StartDate <> 0D) and (DateToCheck < StartDate) then
            exit(false);

        if (EndDate <> 0D) and (DateToCheck > EndDate) then
            exit(false);

        exit(true);
    end;

    local procedure BuildDateRangeText()
    begin
        DateRangeText := '';

        if (StartDate <> 0D) or (EndDate <> 0D) then begin
            DateRangeText := 'Date Range (' + Format(DateFilterField) + '): ';

            if StartDate <> 0D then
                DateRangeText := DateRangeText + Format(StartDate)
            else
                DateRangeText := DateRangeText + 'Beginning';

            DateRangeText := DateRangeText + ' to ';

            if EndDate <> 0D then
                DateRangeText := DateRangeText + Format(EndDate)
            else
                DateRangeText := DateRangeText + 'End';
        end;
    end;

    local procedure GetAsAtDate(): Date
    begin
        if EndDate <> 0D then
            exit(EndDate)
        else
            exit(Today);
    end;

    var
        RPeriod: Decimal;
        currentBalance: Decimal;
        AsAt: Date;
        ExpextedRepayment: Decimal;
        RepaymentSchedule: Record "Loan Repayment Schedule";
        BatchL: Code[100];
        Batches: Record "Loan Disburesment-Batching";
        ApprovalSetup: Record "Approval Setup";
        LocationFilter: Code[20];
        TotalApproved: Decimal;
        cust: Record Customer;
        BOSABal: Decimal;
        SuperBal: Decimal;
        LoanRec: Record "Loans Register";
        Deposits: Decimal;
        CompanyCode: Code[20];
        LoanType: Text[50];
        LoanProdType: Record "Loan Products Setup";
        LCount: Integer;
        RFilters: Text[250];
        DValue: Record "Dimension Value";
        VALREPAY: Record "Cust. Ledger Entry";

        // New variables for date filtering
        StartDate: Date;
        EndDate: Date;
        DateFilterField: Option "Application Date","Issued Date","Posting Date";
        DateRangeText: Text[100];

        // Labels
        Loans_RegisterCaptionLbl: label 'Loans Register';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Loan_TypeCaptionLbl: label 'Loan Type';
        Client_No_CaptionLbl: label 'Client No.';
        Outstanding_LoanCaptionLbl: label 'Outstanding Loan';
        PeriodCaptionLbl: label 'Period';
        Approved_DateCaptionLbl: label 'Approved Date';
        Loan_TypeCaption_Control1102760043Lbl: label 'Loan Type';
        Verified_By__________________________________________________CaptionLbl: label 'Verified By..................................................';
        Confirmed_By__________________________________________________CaptionLbl: label 'Confirmed By..................................................';
        Sign________________________CaptionLbl: label 'Sign........................';
        Sign________________________Caption_Control1102755003Lbl: label 'Sign........................';
        Date________________________CaptionLbl: label 'Date........................';
        Date________________________Caption_Control1102755005Lbl: label 'Date........................';
        IDno: Code[50];
        Dob: Date;
        vend: Record Vendor;
}