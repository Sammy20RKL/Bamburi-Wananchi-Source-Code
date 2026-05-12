Report 50040 "Member Welfare Contributions"
{
    ApplicationArea = All;

    RDLCLayout = './Layout/MemberWelfareReport.rdl';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = sorting("No.") order(descending);
            RequestFilterFields = "No.", Status, "Welfare Contribution";
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
            column(Personal_No; "Personal No") { }
            column(Name; Name) { }
            column(ID_No_; "ID No.") { }
            column(EntryNo; EntryNo) { }
            column(Monthly_Contribution; "Monthly Contribution") { }
            column(Welfare_Contribution; WelfareContribution) { }
            column(DateStart; "Start Date") { }
            column(DateEnd; "End Date") { }

            trigger OnPreDataItem()
            begin
                WelfareContribution := 0;
            end;

            trigger OnAfterGetRecord()
            begin
                // Step 1: Skip if Welfare Contr < 1
                if "Welfare Contr" < 1 then begin
                    CurrReport.Skip();
                    exit;
                end;

                // Step 2: Load the Welfare Contribution FlowField
                CalcFields("Welfare Contribution");

                // Step 3: Set value for report use
                WelfareContribution := "Welfare Contribution";

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
                field("Start Date"; "Start Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Start Date';
                }
                field("End Date"; "End Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'End Date';
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
        if "Start Date" = 0D then
            Error('Please enter the Start Date');
        if "End Date" = 0D then
            Error('Please enter the end Date Filter');
        dateFilterS := Format("Start Date") + '..' + Format("End Date");
        CompanyInfo.Get();
        Customer.SetFilter("Date Filter", dateFilterS);
        // Datefilter := Customer.GetFilter("Date Filter");
        CompanyInfo.CalcFields(CompanyInfo.Picture);

    end;

    var
        CompanyInfo: Record "Company Information";
        EntryNo: Integer;
        WelfareContribution: Decimal;
        Datefilter: Text[100];
        "End Date": Date;
        "Start Date": Date;
        Cust: Record Customer;
        dateFilterS: Text;
}
