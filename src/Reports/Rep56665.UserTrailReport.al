#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 56665 "User Trail Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/User Trail Report.rdlc';
    UsageCategory = ReportsandAnalysis;

    dataset
    {
        dataitem(Audit; "Audit Entries")
        {
            RequestFilterFields = UsersId, Date;
            column(ReportForNavId_1120054000; 1120054000)
            {
            }
            column(Date_Audit; Audit.Date)
            {
            }
            column(Time_Audit; Audit.Time)
            {
            }
            column(UsersId_Audit; Audit.UsersId)
            {
            }
            column(TransactionType_Audit; Audit."Transaction Type")
            {
            }
            column(AccountNumber_Audit; Audit."Account Number")
            {
            }
            column(DocumentNumber_Audit; Audit."Document Number")
            {
            }
            column(LoanNumber_Audit; Audit."Loan Number")
            {
            }
            column(RecordID_Audit; Audit."Record ID")
            {
            }
            column(CompName; Company.Name)
            {
            }
            column(CompAddress; Company.Address)
            {
            }
            column(CompCity; Company.City)
            {
            }
            column(CompPicture; Company.Picture)
            {
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        Company.Get();
        Company.CalcFields(Picture);
    end;

    var
        Company: Record "Company Information";
}

