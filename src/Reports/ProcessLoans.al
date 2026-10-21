// namespace PolyTechERPSourceCode.PolyTechERPSourceCode;

report 51598 "Process Loan Monthly Interest"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            CalcFields = "Outstanding Balance";
            RequestFilterFields = "Date filter", "Issued Date", "Loan  No.", "Client Code";
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
            column(Loans__Loan__No__; "Loan  No.")
            {
            }
            column(Loans__Application_Date_; "Application Date")
            {
            }
            column(Loans__Loan_Product_Type_; "Loan Product Type")
            {
            }
            column(Loans__Client_Code_; "Client Code")
            {
            }
            column(Loans__Client_Name_; "Client Name")
            {
            }
            column(Loans__Outstanding_Balance_; "Outstanding Balance")
            {
            }
            column(Loan_Application_FormCaption; Loan_Application_FormCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Loans__Loan__No__Caption; FieldCaption("Loan  No."))
            {
            }
            column(Loans__Application_Date_Caption; FieldCaption("Application Date"))
            {
            }
            column(Loans__Loan_Product_Type_Caption; FieldCaption("Loan Product Type"))
            {
            }
            column(Loans__Client_Code_Caption; FieldCaption("Client Code"))
            {
            }
            column(Loans__Client_Name_Caption; FieldCaption("Client Name"))
            {
            }
            column(Loans__Outstanding_Balance_Caption; FieldCaption("Outstanding Balance"))
            {
            }
            trigger OnAfterGetRecord()
            var
                MaturityDate: Date;
                InterestAlreadyPosted: Boolean;
            begin
                DocNo := Format(PostDate);

                loanapp.Reset;
                loanapp.SetRange(loanapp."Loan  No.", "Loans Register"."Loan  No.");
                loanapp.SetCurrentKey("Client Code", "Application Date");
                loanapp.Ascending(false);

                if loanapp.Find('-') then begin
                    repeat
                        loanapp.CalcFields(loanapp."Outstanding Balance", loanapp."Oustanding Interest");

                        if loanapp."Outstanding Balance" > 0 then begin

                            CustLedgEntry.Reset;
                            CustLedgEntry.SetRange("Customer No.", loanapp."Client Code");
                            CustLedgEntry.SetRange("Loan No", loanapp."Loan  No.");
                            CustLedgEntry.SetRange("Transaction Type", CustLedgEntry."Transaction Type"::"Interest Due");
                            CustLedgEntry.SetRange("Posting Date", PeriodStartDate, PeriodEndDate);
                            AlreadyCharged := CustLedgEntry.FindFirst;

                            if not AlreadyCharged then begin

                                Cust.Reset;
                                Cust.SetRange(Cust."No.", "Loans Register"."Client Code");
                                Cust.SetFilter(Cust."Don't Charge Interest", '%1', false);

                                if Cust.FindSet then begin
                                    repeat


                                        RepaySchedule.Reset;
                                        RepaySchedule.SetRange("Loan No.", loanapp."Loan  No.");
                                        if not RepaySchedule.FindFirst then begin
                                            SFactory.FnGenerateRepaymentSchedule(loanapp."Loan  No.");
                                            RepaySchedule.Reset;
                                            RepaySchedule.SetRange("Loan No.", loanapp."Loan  No.");
                                        end;

                                        ScheduleExists := RepaySchedule.FindFirst;
                                        if ScheduleExists then begin
                                            FirstScheduleDate := RepaySchedule."Repayment Date";
                                            RepaySchedule.FindLast;
                                            LastScheduleDate := RepaySchedule."Repayment Date";
                                        end;



                                        ChargeThisLoan := true;
                                        UseScheduleAmount := false;

                                        if not ScheduleExists then begin
                                            ChargeThisLoan := false;
                                        end else if PeriodEndDate < FirstScheduleDate then begin
                                            ChargeThisLoan := false;
                                            // end else if PeriodStartDate > LastScheduleDate then begin
                                            //     UseScheduleAmount := false;
                                        end else begin
                                            RepaySchedule.Reset;
                                            RepaySchedule.SetRange("Loan No.", loanapp."Loan  No.");
                                            RepaySchedule.SetRange("Repayment Date", PeriodStartDate, PeriodEndDate);
                                            if RepaySchedule.FindFirst then
                                                UseScheduleAmount := true
                                            else
                                                ChargeThisLoan := false;
                                        end;

                                        if ChargeThisLoan then begin

                                            LineNo := LineNo + 10000;
                                            GenJournalLine.Init;
                                            GenJournalLine."Journal Template Name" := 'General';
                                            GenJournalLine."Journal Batch Name" := 'INT DUE';
                                            GenJournalLine."Line No." := LineNo;
                                            GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                                            GenJournalLine."Account No." := loanapp."Client Code";
                                            GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Due";
                                            GenJournalLine.Validate(GenJournalLine."Account No.");
                                            GenJournalLine."Document No." := DocNo;
                                            GenJournalLine."Posting Date" := PostDate;
                                            GenJournalLine.Description := 'INT Charged' + ' ' + Format(PostDate);

                                            if LoanType.Get(loanapp."Loan Product Type") then begin

                                                if UseScheduleAmount then begin
                                                    GenJournalLine.Amount := ROUND(RepaySchedule."Monthly Interest", 0.01, '=');
                                                end else begin
                                                    if loanapp."Repayment Method" = loanapp."repayment method"::"Straight Line" then
                                                        GenJournalLine.Amount := ROUND(loanapp."Approved Amount" * (loanapp.Interest / 100), 0.01, '=')
                                                    else
                                                        GenJournalLine.Amount := ROUND(loanapp."Outstanding Balance" * (loanapp.Interest / 100), 0.01, '=');
                                                end;

                                                GenJournalLine.Validate(GenJournalLine.Amount);
                                                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                                GenJournalLine."Bal. Account No." := LoanType."Loan Interest Account";
                                                GenJournalLine."Loan Product Type" := LoanType.Code;
                                                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                            end;


                                            if loanapp.Source = loanapp.Source::BOSA then begin
                                                GenJournalLine."Shortcut Dimension 1 Code" := Cust."Global Dimension 1 Code";
                                                GenJournalLine."Shortcut Dimension 2 Code" := Cust."Global Dimension 2 Code";
                                            end;
                                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                            GenJournalLine."Loan No" := loanapp."Loan  No.";

                                            if GenJournalLine.Amount <> 0 then
                                                GenJournalLine.Insert;
                                        end;
                                    until cust.Next = 0;
                                end;
                            end;
                        end;
                    until loanapp.Next = 0;
                end;
            end;

            trigger OnPostDataItem()
            var
                LinesCreated: Integer;
            begin

                // -----------------------------------------------------
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", 'General');
                GenJournalLine.SetRange("Journal Batch Name", 'INT DUE');
                LinesCreated := GenJournalLine.Count;

                if LinesCreated > 0 then begin
                    Message('%1 journal line(s) created for the period %2 to %3.', LinesCreated, PeriodStartDate, PeriodEndDate);
                    if GenJournalLine.Find('-') then
                        page.Run(Page::"General Journal", GenJournalLine);
                end else
                    Message('No loans qualified for interest charging in the period %1 to %2. Check: already charged.', PeriodStartDate, PeriodEndDate);
            end;

            trigger OnPreDataItem()
            begin

                //delete journal line
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", 'General');
                GenJournalLine.SetRange("Journal Batch Name", 'INT DUE');
                GenJournalLine.DeleteAll;
                //end of deletion

                GenBatches.Reset;
                GenBatches.SetRange(GenBatches."Journal Template Name", 'General');
                GenBatches.SetRange(GenBatches.Name, 'INT DUE');
                if GenBatches.Find('-') = false then begin
                    GenBatches.Init;
                    GenBatches."Journal Template Name" := 'General';
                    GenBatches.Name := 'INT DUE';
                    GenBatches.Description := 'Interest Due';
                    GenBatches.Insert;
                end;

                // Exclude INST and HALL loan products
                "Loans Register".SetFilter("Loan Product Type", '<>INST<>HALL');

                // Only loans disbursed on/after the entered cutoff (e.g. June onward, open-ended)
                if DisbFromDate <> 0D then
                    "Loans Register".SetFilter("Loan Disbursement Date", '>=%1', DisbFromDate);

                if AsAtPDate = 0D then
                    AsAtPDate := Today;

                DocNo := 'INT DUE';
                PDate := AsAtPDate;

                StartDate := CalcDate('-1M', CalcDate('1D', AsAtPDate));
                IntDays := (AsAtPDate - StartDate) + 1;

                if Baldate = 0D then
                    Error('PLEASE INSERT THE END DATE OF THE PREVIOUS MONTH');

                if CUTOFFDATE = 0D then
                    Error('PLEASE INSERT THE CUT OFF DATE');


                if ChargeFromDate = 0D then
                    Error('PLEASE INSERT THE CHARGE FROM DATE');

                if ChargeToDate = 0D then
                    Error('PLEASE INSERT THE CHARGE TO DATE');

                if ChargeFromDate > ChargeToDate then
                    Error('CHARGE FROM DATE CANNOT BE AFTER CHARGE TO DATE');

                PeriodStartDate := ChargeFromDate;
                PeriodEndDate := ChargeToDate;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(Posting_Date; PostDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Posting_Date';
                }
                field(Balance_Date; Baldate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Balance_Date(End Day of the Month)';
                }
                field(Cut_OffDate; CUTOFFDATE)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cut_OffDate(Last Day You wish to Compute Interest)';
                }
                field(Disbursement_From_Date; DisbFromDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Disbursement From Date (Optional)';
                }
                field(Charge_From_Date; ChargeFromDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Charge Interest From';
                }
                field(Charge_To_Date; ChargeToDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Charge Interest To';
                }

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
        //Accounting periods
        AccountingPeriod.SetRange(AccountingPeriod.Closed, false);
        if AccountingPeriod.Find('-') then begin
            FiscalYearStartDate := AccountingPeriod."Interest Calcuation Date";
            PostDate := (FiscalYearStartDate);
            DocNo := AccountingPeriod.Name + '  ' + Format(PostDate);
        end;
        //Accounting periods
    end;

    var
        DisbFromDate: Date;
        IntDays: Integer;
        AsAt: Date;
        MinBal: Boolean;
        AccruedInt: Decimal;
        RIntDays: Integer;
        Bal: Decimal;
        DFilter: Text[50];
        "PrepaidRem.": Record "Prepaid Remitance";
        PrepBal: Decimal;
        CBalance: Decimal;
        cusld: Record "Detailed Cust. Ledg. Entry";
        IntD: Decimal;
        Baldate: Date;
        BaldateTXT: Text[30];
        CUTOFFDATE: Date;
        IntRate: Decimal;
        MidMonthFactor: Decimal;
        StartDate: Date;
        LoansB: Record "Loans Register";
        AsAtPDate: Date;
        GenBatches: Record "Gen. Journal Batch";
        PDate: Date;
        LoanType: Record "Loan Products Setup";
        PostDate: Date;
        Cust: Record Customer;

        LineNo: Integer;
        DocNo: Code[20];
        GenJournalLine: Record "Gen. Journal Line";
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        EndDate: Date;
        DontCharge: Boolean;
        Temp: Record "Funds User Setup";
        JBatch: Code[10];
        Jtemplate: Code[10];
        CustLedger: Record "ReceiptsProcessing_L-Checkoff";
        AccountingPeriod: Record "Interest Due Period";
        FiscalYearStartDate: Date;
        "ExtDocNo.": Text[30];
        Loan_Application_FormCaptionLbl: label 'Loan Application Form';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        loanapp: Record "Loans Register";
        SDATE: Text[30];

        CustLedgEntry: Record "Cust. Ledger Entry";
        RepaySchedule: Record "Loan Repayment Schedule";
        PeriodStartDate: Date;
        PeriodEndDate: Date;
        AlreadyCharged: Boolean;
        ScheduleFound: Boolean;

        SFactory: Codeunit "Swizzsoft Factory";
        ScheduleExists: Boolean;
        FirstScheduleDate: Date;
        LastScheduleDate: Date;
        ChargeThisLoan: Boolean;
        UseScheduleAmount: Boolean;

        ChargeFromDate: Date;
        ChargeToDate: Date;
}