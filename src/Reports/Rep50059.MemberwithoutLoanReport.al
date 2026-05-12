Report 50059 MemberwithoutLoanReport
{
    ApplicationArea = All;
    Caption = 'Members without loan report.';
    RDLCLayout = './Layout/MemberwithoutLoanReport.rdlc';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = sorting("No.") order(descending);
            RequestFilterFields = "No.", "Date Filter";
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
            column(No; "No.") { }
            column(Name; Name) { }
            column(ID_No_; "ID No.") { }
            column(EntryNo; EntryNo) { }
            column(Phone_No_; "Phone No.") { }

            column(OutstandingBalance; OutstandingBalance) { }
            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                OutstandingBalance := 0;
            end;

            trigger OnAfterGetRecord();
            var
            begin
                Cust.SetFilter(Cust."Date Filter", Datefilter);
                if cust.get(Customer."No.") then begin
                    cust.SetAutoCalcFields(Cust."Outstanding Balance");
                    OutstandingBalance := cust."Outstanding Balance";
                end;
                if OutstandingBalance > 0 then
                    CurrReport.Skip();
                EntryNo := EntryNo + 1;
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
    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        Datefilter := Customer.GetFilter("Date Filter");
        CompanyInfo.CalcFields(CompanyInfo.Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        EntryNo: Integer;
        OutstandingBalance: Decimal;
        Datefilter: Text[100];
        Cust: Record Customer;
        Gensetup: Record "Sacco General Set-Up";
}
