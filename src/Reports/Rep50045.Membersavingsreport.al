Report 50045 "Member savings report"
{
    ApplicationArea = All;

    RDLCLayout = './Layout/MemberSavingReport.rdlc';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = sorting("No.") order(descending);
            RequestFilterFields = "No.", Status, "Date Filter";
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
            column(Monthly_Contribution; "Monthly Contribution") { }
            column(Deposits; Deposits) { }

            trigger OnPreDataItem()
            begin
                Deposits := 0;
            end;

            trigger OnAfterGetRecord()
            begin
                // Reset Customer record to ensure a fresh search for each record
                Cust.Reset();
                Cust.SetRange("No.", "No."); // Ensure filtering by unique customer number
                Cust.SetFilter("Date Filter", Datefilter);

                // Use FindSet() to ensure iteration through matching records
                if Cust.FindSet() then
                    repeat
                        Cust.CalcFields("Current Shares"); // Calculate FlowField for each record
                        Deposits := Cust."Current Shares";
                    until Cust.Next() = 0; // Loop through records

                // Increment entry number for tracking
                EntryNo += 1;
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
        Deposits: Decimal;
        Datefilter: Text[100];
        Cust: Record Customer;
}
