Report 50058 MembershipApplicationReport2
{
    ApplicationArea = All;
    Caption = 'Member application report.';
    RDLCLayout = './Layout/MembershipApplicationReport.rdlc';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Membership Applications"; "Membership Applications")
        {
            DataItemTableView = sorting("No.") order(descending);
            RequestFilterFields = Status;
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

                ;
                EntryNo := EntryNo + 1;
                if MembApp.Find('-') then
                    if MembApp.IsEmpty = false then begin
                        CurrReport.Skip();
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
    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        Datefilter := Cust.GetFilter("Date Filter");
        CompanyInfo.CalcFields(CompanyInfo.Picture);

    end;

    var
        CompanyInfo: Record "Company Information";
        EntryNo: Integer;
        Sharecapital: Decimal;
        Datefilter: Text[100];
        Cust: Record Customer;
        Gensetup: Record "Sacco General Set-Up";
        MembApp: Record "Membership Applications";
}
