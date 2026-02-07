Report 50046 "MemberwithoutMinshapitalreport"
{
    ApplicationArea = All;
    Caption = 'Members without minimum share capital report.';
    RDLCLayout = './Layout/MemberwithoutMinshapitalreport.rdlc';
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

            column(Sharecapital; Sharecapital) { }
            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                Sharecapital := 0;
                EntryNo := 0;
            end;

            trigger OnAfterGetRecord();
            var
            begin
                // Reset Customer record to ensure a fresh search for each record
                Cust.Reset();
                Cust.SetRange("No.", "No."); // Ensure filtering by unique customer number
                Cust.SetFilter("Date Filter", Datefilter);

                // Use FindSet() to ensure iteration through matching records
                if Cust.FindSet() then
                    repeat
                        Cust.CalcFields("Share Capital"); // Calculate FlowField for each record
                        ShareCapital := Cust."Share Capital";
                    until Cust.Next() = 0; // Loop through records

                Gensetup.Get();
                // SetAutoCalcFields("Share Capital");
                // Sharecapital := "Current Shares";
                If Sharecapital > Gensetup."Retained Shares" then
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
