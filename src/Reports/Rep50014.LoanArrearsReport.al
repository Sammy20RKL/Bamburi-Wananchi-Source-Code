Report 50014 "Loan Arrears Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Loan Arrears Report.rdlc';

    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            DataItemTableView = where(Posted = const(true), "Amount in Arrears" = filter(> 0));
            RequestFilterFields = Source, "Loan Product Type", "Issued Date";
            column(Counting; Counting)
            {
            }
            column(Client_Name; "Client Name")
            {
            }
            column(ReportForNavId_1000000000; 1000000000)
            {
            }
            column(BranchCode_Loans; "Loans Register"."Branch Code")
            {
            }
            column(EmployerCode_Loans; "Loans Register"."Employer Code")
            {
            }
            column(LoanProductType_Loans; "Loans Register"."Loan Product Type")
            {
            }
            column(LoanNo_Loans; "Loans Register"."Loan  No.")
            {
            }
            column(ApplicationDate_Loans; "Loans Register"."Application Date")
            {
            }
            column(ClientCode_Loans; "Loans Register"."Client Code")
            {
            }
            column(GroupCode_Loans; "Loans Register"."Group Code")
            {
            }
            column(Source_Loans; "Loans Register".Source)
            {
            }
            column(RequestedAmount_Loans; "Loans Register"."Requested Amount")
            {
            }
            column(ApprovedAmount_Loans; "Loans Register"."Approved Amount")
            {
            }
            column(OustandingInterest_Loans; "Loans Register"."Oustanding Interest")
            {
            }
            column(OutstandingBalance_Loans; "Loans Register"."Outstanding Balance")
            {
            }
            column(IssuedDate_Loans; "Loans Register"."Issued Date")
            {
            }
            column(Amount_in_Arrears; "Amount in Arrears")
            {
            }
            column(No_of_Months_in_Arrears; "No of Months in Arrears")
            {
            }
            column(Principal_In_Arrears; "Principal In Arrears")
            {
            }
            column(Interest_In_Arrears; "Interest In Arrears")
            {
            }
            column(Month; Month)
            {
            }
            column(Name; CompanyInfo.Name)
            {
            }
            column(Address; CompanyInfo.Address)
            {
            }
            column(Picture; CompanyInfo.Picture)
            {
            }



            trigger OnAfterGetRecord()
            begin
                Counting := Counting + 1;
                ClientBranchCode := '';

            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.Get;
                CompanyInfo.CalcFields(CompanyInfo.Picture);
                Counting := 0;

            end;
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

    var
        Month: Integer;
        CompanyInfo: Record "Company Information";
        Counting: integer;
        ClientBranchCode: code[100];
}

