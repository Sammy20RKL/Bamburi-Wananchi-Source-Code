#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50205 "Loans Guarantor Details Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/LoansGuarantorDetailsReport.rdl';

    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            CalcFields = "Outstanding Balance";
            DataItemTableView = sorting("Issued Date") where(Posted = const(true), "Outstanding Balance" = filter(> 0));
            RequestFilterFields = "Client Code", "Loan  No.", "Branch Code", "Date filter";
            column(ReportForNavId_1; 1)
            {
            }
            column(LoanNo_LoansRegister; "Loans Register"."Loan  No.")
            {
            }
            column(ClientCode_LoansRegister; "Loans Register"."Client Code")
            {
            }
            column(OutstandingBalance_LoansRegister; "Loans Register"."Outstanding Balance")
            {
            }
            column(OustandingInterest_LoansRegister; "Loans Register"."Oustanding Interest")
            {
            }
            column(IssuedDate_LoansRegister; "Loans Register"."Issued Date")
            {
            }
            column(ApprovedAmount_LoansRegister; "Loans Register"."Approved Amount")
            {
            }
            column(Var1; Var1)
            {
            }
            column(ClientName_LoansRegister; "Loans Register"."Client Name")
            {
            }
            column(Company_Name; Company.Name)
            {
            }
            column(Company_Address; Company.Address)
            {
            }
            column(Company_Picture; Company.Picture)
            {
            }
            column(Company_Phone; Company."Phone No.")
            {
            }
            column(Company_SMS; Company."Phone No.")
            {
            }
            column(Company_Email; Company."E-Mail")
            {
            }
            dataitem("Loans Guarantee Details"; "Loans Guarantee Details")
            {
                DataItemLink = "Loan No" = field("Loan  No.");
                column(ReportForNavId_5; 5)
                {
                }
                column(MemberNo_LoansGuaranteeDetails; "Loans Guarantee Details"."Member No")
                {
                }
                column(Name_LoansGuaranteeDetails; "Loans Guarantee Details".Name)
                {
                }
                column(AmontGuaranteed_LoansGuaranteeDetails; "Loans Guarantee Details"."Amont Guaranteed")
                {
                }
            }
            dataitem("Loan Collateral Details"; "Loan Collateral Details")
            {
                DataItemLink = "Loan No" = field("Loan  No.");
                column(ReportForNavId_14; 14)
                {
                }
                column(LoanNo_LoanCollateralDetails; "Loan Collateral Details"."Loan No")
                {
                }
                column(Type_LoanCollateralDetails; "Loan Collateral Details".Type)
                {
                }
                column(Value_LoanCollateralDetails; "Loan Collateral Details".Value)
                {
                }
                column(Code_LoanCollateralDetails; "Loan Collateral Details".Code)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                "Loans Register".SetFilter("Loans Register"."Issued Date", datefiltered);
                Var1 := Var1 + 1;
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

    trigger OnPreReport()
    begin
        datefiltered := '';
        datefiltered := "Loans Register".GetFilter("Loans Register"."Date filter");
        Var1 := 0;
        Company.Get();
        Company.CalcFields(Company.Picture);
    end;

    var

        Var1: Integer;
        datefiltered: Text;
        Company: Record "Company Information";
}

