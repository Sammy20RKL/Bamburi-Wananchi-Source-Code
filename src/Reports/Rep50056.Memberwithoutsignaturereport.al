Report 50056 "Memberwithoutsignaturereport"
{
    ApplicationArea = All;
    Caption = 'Members without signature report.';
    RDLCLayout = './Layout/Memberwithoutsignaturereport.rdlc';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = sorting("No.") order(descending);

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




            trigger OnAfterGetRecord();
            var
            begin

                If Signature.HasValue then
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
        Sharecapital: Decimal;
        Datefilter: Text[100];
        Cust: Record Customer;
        Gensetup: Record "Sacco General Set-Up";
}
