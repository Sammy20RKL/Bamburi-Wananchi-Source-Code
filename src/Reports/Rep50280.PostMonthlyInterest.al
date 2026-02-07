#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50280 "Post Monthly Interest."
{
    // DefaultLayout = RDLC;
    // RDLCLayout = './Layouts/Post Monthly Interest..rdlc';
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
            begin
                PDate := "Loans Register".GetRangemax("Loans Register"."Date filter");
                SDATE := '..' + Format(PDate);
                DocNo := Format(PostDate);
                loanapp.Reset;
                loanapp.SetRange(loanapp."Loan  No.", "Loans Register"."Loan  No.");
                loanapp.SetFilter(loanapp."Date filter", SDATE);
                loanapp.SetCurrentKey("Client Code", "Application Date");
                loanapp.Ascending(false);
                if loanapp.Find('-') then begin
                    repeat
                        if (loanapp."Loan Product Type" <> '24') then begin
                            loanapp.CalcFields(loanapp."Outstanding Balance");
                            if loanapp."Outstanding Balance" > 0 then begin

                                Cust.Reset;
                                Cust.SetRange(Cust."No.", "Loans Register"."Client Code");
                                // Cust.SetFilter(Cust.Blocked, '%1', Cust.Blocked::" ");
                                Cust.SetFilter(Cust."Don't Charge Interest", '%1', false);
                                if Cust.FindSet then begin
                                    repeat
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

                                            if loanapp."Repayment Method" = loanapp."repayment method"::"Straight Line" then begin
                                                //Added by D.O to handle Member Receipting prior to Interest Accrual
                                                if (loanapp."Disbursement Status" = loanapp."disbursement status"::Partial) and ((loanapp."Initial Trunch") = Date2dmy(Today, 2)) and ((loanapp."Amount To Disburse") = Date2dmy(Today, 3)) then begin
                                                    GenJournalLine.Amount := loanapp."Total Charges and Commissions";
                                                    //MESSAGE('Interest arrears %1',GenJournalLine.Amount);
                                                end else
                                                    GenJournalLine.Amount := ROUND(loanapp."Approved Amount" * (loanapp.Interest / 1200), 1, '>')
                                            end else begin
                                                if (loanapp."Disbursement Status" = loanapp."disbursement status"::Partial) and ((loanapp."Initial Trunch") = Date2dmy(Today, 2)) and ((loanapp."Amount To Disburse") = Date2dmy(Today, 3)) then begin
                                                    GenJournalLine.Amount := loanapp."Total Charges and Commissions";
                                                    //MESSAGE('Interest arrears %1',GenJournalLine.Amount);
                                                end else
                                                    GenJournalLine.Amount := ROUND(loanapp."Outstanding Balance" * (loanapp.Interest / 1200), 1, '>');
                                            end;

                                            // GenJournalLine.Amount := ROUND(loanapp."Outstanding Balance" * (LoanType."Interest rate" / 1200), 1, '>'); //(loanapp."Outstanding Balance" + loanapp."Oustanding Interest")
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
                                    until cust.Next = 0;
                                end;
                            end;
                        end;

                    until loanapp.Next = 0;
                end;

            end;

            trigger OnPostDataItem()
            begin
                Message('Journals Created Successfully');
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", 'General');
                GenJournalLine.SetRange("Journal Batch Name", 'INT DUE');
                if GenJournalLine.Find('-') then
                    page.Run(Page::"General Journal", GenJournalLine);

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
                    //GenBatches.VALIDATE(GenBatches."Journal Template Name");
                    //GenBatches.VALIDATE(GenBatches.Name);
                    GenBatches.Insert;
                end;


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
        // PostDate: Date;
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
}

