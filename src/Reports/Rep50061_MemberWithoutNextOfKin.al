/* Report 50057 "MemberWithoutNextOfKin"
{
    ApplicationArea = All;
    Caption = 'Members Without Next report.';
    RDLCLayout = './Layouts/MemberWithoutNextOfKin.rdl';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(Customer; "Member Register")
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
            column(Mobile_Phone_No; "Mobile Phone No") { }




            trigger OnAfterGetRecord();
            var
            begin
                EntryNo := EntryNo + 1;
                NextOfKin.Reset();
                NextOfKin.SetRange(NextOfKin."Account No", "No.");
                if NextOfKin.Find('-') then
                    if NextOfKin.IsEmpty = false then begin
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
        Datefilter := Customer.GetFilter("Date Filter");
    end;

    var
        CompanyInfo: Record "Company Information";
        EntryNo: Integer;
        Sharecapital: Decimal;
        Datefilter: Text[100];
        Gensetup: Record "Sacco General Set-Up";
    //NextOfKin: Record "Accounts Next Of Kin Details";
}
 */