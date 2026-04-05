#pragma warning disable AA0005,AL0835, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50227 "Member Loans Statement"
{
    DefaultLayout = RDLC;
    Caption = 'Member Loan Statement';
    RDLCLayout = './Layouts/Loan Statement.rdlc';

    dataset
    {
        dataitem("Members Register"; customer)
        {
            RequestFilterFields = "Date Filter", "No.", "Loan Product Filter";
            column(ReportForNavId_1102755000; 1102755000)
            {
            }
            column(USERID; UserId)
            {
            }
            column(PayrollStaffNo_Members; "Members Register"."Personal No")
            {
            }
            column(No_Members; "Members Register"."No.")
            {
            }
            column(Phone_No_; "Phone No.") { }
            column(Registration_Date; "Registration Date") { }
            column(Name_Members; "Members Register".Name)
            {
            }
            column(EmployerCode_Members; "Members Register"."Employer Code")
            {
            }
            column(EmployerName; EmployerName)
            {
            }
            column(PageNo_Members; CurrReport.PageNo)
            {
            }
            column(Shares_Retained; "Members Register"."Shares Retained")
            {
            }
            column(ShareCapBF; ShareCapBF)
            {
            }
            column(IDNo_Members; "Members Register"."ID No.")
            {
            }
            column(GlobalDimension2Code_Members; "Members Register"."Global Dimension 2 Code")
            {
            }
            column(Company_Name; Company.Name)
            {
            }
            column(Company_Address; Company.Address)
            {
            }
            column(Company_Address_2; Company."Address 2")
            {
            }
            column(Company_Phone_No; Company."Phone No.")
            {
            }
            column(Company_Fax_No; Company."Fax No.")
            {
            }
            column(Company_Picture; Company.Picture)
            {
            }
            column(Company_Email; Company."E-Mail")
            {
            }
            column(Company_Signature; Company."SGN Signature")
            {
            }
            dataitem(Loans; "Loans Register")
            {
                DataItemLink = "Client Code" = field("No."), "Date filter" = field("Date Filter"), "Loan Product Type" = field("Loan Product Filter");
                DataItemTableView = sorting("Loan  No.") where(Posted = const(true), Reversed = const(false));
                column(ReportForNavId_1102755024; 1102755024)
                {
                }
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
                column(OutstandingBalance_Loans; Loans."Outstanding Balance")
                {
                }
                column(OustandingInterest_Loans; Loans."Oustanding Interest")
                {
                }
                column(OutstandingI; OutstandingI)
                {
                }
                column(Totalrepayment; Totalrepayment)
                {
                }
                column(OutstandingP; OutstandingP)
                {
                }

                dataitem(loan; "Cust. Ledger Entry")
                {
                    DataItemLink = "Customer No." = field("Client Code"), "Loan No" = field("Loan  No."), "Posting Date" = field("Date filter");
                    DataItemTableView = sorting("Posting Date") where("Transaction Type" = filter(Loan | "Loan Repayment" | "Interest Due" | "Interest Paid"), "Loan No" = filter(<> ''), Reversed = filter(false));
                    column(ReportForNavId_1102755031; 1102755031)
                    {
                    }
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
                    column(Amount_Loan; loan.Amount)
                    {
                    }
                    column(openBalance_loan; OpenBalance)
                    {
                    }
                    column(CLosingBalance_loan; CLosingBalance)
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
                    column(Loan_Description; loan.Description)
                    {
                    }
                    column(User7; loan."User ID")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        if (loan."Loan No" = 'BLN_19847') AND (loan.Reversed = true) then CurrReport.Skip();
                        CLosingBalance := CLosingBalance + loan."Amount Posted";
                        if loan."Amount Posted" < 0 then begin
                            loan."Credit Amount" := (-1 * loan."Amount Posted");
                        end else
                            if loan."Amount Posted" > 0 then begin
                                loan."Debit Amount" := (loan."Amount Posted");
                            end;
                        if loan."Transaction Type" = loan."transaction type"::"Interest Paid" then begin
                            if loan."Amount Posted" < 0 then begin
                                InterestPaid := loan."Amount Posted";
                                SumInterestPaid := InterestPaid + SumInterestPaid;
                            end;
                        end;
                        if loan."Transaction Type" = loan."transaction type"::"Loan Repayment" then begin
                            if loan."Amount Posted" < 0 then begin
                                loan."Amount Posted" := loan."Amount Posted";
                            end;
                        end;

                    end;

                    trigger OnPreDataItem()
                    begin
                        CLosingBalance := PrincipleBF;
                        OpeningBal := PrincipleBF;

                    end;
                }

                trigger OnAfterGetRecord()
                begin

                    OutstandingI := 0;
                    OutstandingP := 0;

                    if LoansR6.Get(Loans."Loan  No.") then begin
                        LoansR6.CalcFields("Outstanding Balance", "Oustanding Interest");
                        OutstandingI := LoansR6."Oustanding Interest";
                        OutstandingP := LoansR6."Outstanding Balance";
                    end;


                    if LoanSetup.Get(Loans."Loan Product Type") then
                        LoanName := LoanSetup."Product Description";
                    if DateFilterBF <> '' then begin
                        LoansR.Reset;
                        LoansR.SetRange(LoansR."Loan  No.", "Loan  No.");
                        LoansR.SetFilter(LoansR."Date filter", DateFilterBF);
                        if LoansR.Find('-') then begin
                            LoansR.CalcFields(LoansR."Outstanding Balance");
                            PrincipleBF := LoansR."Outstanding Balance";
                        end;
                    end;


                    Rshedule.Reset;
                    Rshedule.SetRange(Rshedule."Loan No.", "Loan  No.");
                    if Rshedule.FindFirst then begin
                        Totalrepayment := Rshedule."Monthly Repayment";
                    end;
                end;

                trigger OnPreDataItem()
                begin

                    Loans.SetFilter(Loans."Date filter", "Members Register".GetFilter("Members Register"."Date Filter"));
                    if not IncludeClearedLoans then
                        Loans.SetFilter(Loans."Outstanding Balance", '>%1', 0);
                end;
            }
            trigger OnAfterGetRecord()
            begin
                SaccoEmp.Reset;
                SaccoEmp.SetRange(SaccoEmp.Code, "Members Register"."Employer Code");
                if SaccoEmp.Find('-') then
                    EmployerName := SaccoEmp.Description;

                SharesBF := 0;
                InsuranceBF := 0;
                ShareCapBF := 0;
                RiskBF := 0;
                HseBF := 0;
                Dep1BF := 0;
                Dep2BF := 0;
                if DateFilterBF <> '' then begin
                    Cust.Reset;
                    Cust.SetRange(Cust."No.", "No.");
                    Cust.SetFilter(Cust."Date Filter", DateFilterBF);
                    if Cust.Find('-') then begin
                        Cust.CalcFields(Cust."Shares Retained", Cust."Current Shares");
                        SharesBF := Cust."Current Shares";
                        ShareCapBF := Cust."Shares Retained";
                    end;
                end;
            end;

            trigger OnPreDataItem()
            begin
                if "Members Register".GetFilter("Members Register"."Date Filter") <> '' then
                    DateFilterBF := '..' + Format(CalcDate('-1D', "Members Register".GetRangeMin("Members Register"."Date Filter")));

                if (StartDate <> 0D) and (EndDate <> 0D) then
                    "Members Register".SetFilter("Date Filter", Format(StartDate) + '..' + Format(EndDate));
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(DateRange)
                {
                    Caption = 'Date Range';
                    field(StartDate; StartDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Start Date';
                        ToolTip = 'Select the start date for the report.';
                    }
                    field(EndDate; EndDate)
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';
                        ToolTip = 'Select the end date for the report.';
                    }
                    field(IncludeClearedLoans; IncludeClearedLoans)
                    {
                        ApplicationArea = All;
                        Caption = 'Include Cleared Loans';
                        ToolTip = 'Enable this to include loans with zero outstanding balance.';
                    }
                }
            }
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        Company.Get();
        Company.CalcFields(Company.Picture);
        Company.CalcFields(Company."SGN Signature");
    end;

    var
        IncludeClearedLoans: Boolean;
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
        OutstandingI: Decimal;
        OutstandingP: Decimal;
        LoansR6: Record "Loans Register";
        Rshedule: Record "Loan Repayment Schedule";
        Totalrepayment: Decimal;
        StartDate: Date;
        EndDate: Date;
}

