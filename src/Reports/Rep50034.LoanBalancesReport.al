Report 50034 "Loan Balances Report"
{
    ApplicationArea = All;
    Caption = 'Polytech Sacco Loans Book Report';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './Layouts/LoanBalancesReport.rdlc';
    dataset
    {
        dataitem(LoansRegister; "Loans Register")
        {
            DataItemTableView = sorting("Loan  No.") order(ascending) where(Posted = const(true));
            RequestFilterFields = Source, "Loan Product Type", "Client Code", "Branch Code", "Outstanding Balance", "Issued Date", "Date filter";

            column(EntryNo; EntryNo)
            {
            }
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
            column(ClientCode; MemberNo)
            {
            }
            column(ClientName; MemberName)
            {
            }
            column(LoanProductTypeName; LoanProductType)
            {
            }
            column(Loan__No_; LoanNo)
            {
            }

            column(Installments; Installements)
            {
            }
            column(IssuedDate; "Issued Date")
            {
            }
            column(ApprovedAmount; IssuedAmount)
            {
            }
            column(PrincipalPaid; "Principal Paid")
            {
            }
            column(Outstanding_Balance; OutstandingBalance)
            {
            }
            column(InterestPaid; "Interest Paid" * -1)
            {
            }
            column(Oustanding_Interest; OutstandingInterest)
            {
            }
            trigger OnPreDataItem()
            begin
                MemberNo := '';
                MemberName := '';
                LoanProductType := '';
                LoanNo := '';
                Installements := 0;
                IssuedAmount := 0;
                OutstandingBalance := 0;
                OutstandingInterest := 0;
                EntryNo := 0;
            end;

            trigger OnAfterGetRecord();
            begin
                //........................Setrange for date filter used
                LoansTable.SetFilter(LoansTable."Date filter", DateFilterUsed);
                if LoansTable.get(LoansRegister."Loan  No.") then begin
                    LoansTable.SetAutoCalcFields(LoansTable."Outstanding Balance", LoansTable."Oustanding Interest");
                    MemberNo := LoansTable."Client Code";
                    MemberName := LoansTable."Client Name";
                    LoanProductType := LoansTable."Loan Product Type";
                    LoanNo := LoansTable."Loan  No.";
                    Installements := LoansTable.Installments;
                    IssuedAmount := LoansTable."Approved Amount";
                    OutstandingBalance := LoansTable."Outstanding Balance";
                    OutstandingInterest := LoansTable."Oustanding Interest";
                    EntryNo := EntryNo + 1;
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
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }

    trigger OnInitReport()
    begin

    end;

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        DateFilterUsed := LoansRegister.GetFilter(LoansRegister."Date filter");
        LoansRegister.SetFilter(LoansRegister."Loan Disbursement Date", DateFilterUsed);
    end;

    var
        EntryNo: Integer;
        LoansTable: Record "Loans Register";
        DateFilterUsed: Text;
        CompanyInfo: Record "Company Information";
        LoanRegister: Record "Loans Register";
        OutstandingBal: Decimal;
        OutstandingInt: Decimal;
        IssuedDateUsed: Text;
        MemberNo: code[100];
        MemberName: text;
        LoanProductType: Code[100];
        LoanNo: code[100];
        Installements: Integer;
        IssuedAmount: Decimal;
        OutstandingBalance: Decimal;
        OutstandingInterest: Decimal;

}
