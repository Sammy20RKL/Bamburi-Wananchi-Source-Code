#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 56292 "Loan Recovery Rprt"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Loan Recovery Rprt.rdlc';

    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            DataItemTableView = where("Outstanding Balance" = filter(> 0));
            RequestFilterFields = "Loan  No.", "Loan Disbursement Date";
            column(ReportForNavId_1; 1)
            {
            }
            column(LoanNo_LoansRegister; "Loans Register"."Loan  No.")
            {
            }
            column(LoanProductType_LoansRegister; "Loans Register"."Loan Product Type")
            {
            }
            column(ClientCode_LoansRegister; "Loans Register"."Client Code")
            {
            }
            column(ApprovedAmount_LoansRegister; "Loans Register"."Approved Amount")
            {
            }
            column(ClientName_LoansRegister; "Loans Register"."Client Name")
            {
            }
            column(LoanStatus_LoansRegister; "Loans Register"."Loan Status")
            {
            }
            column(IssuedDate_LoansRegister; "Loans Register"."Issued Date")
            {
            }
            column(Installments_LoansRegister; "Loans Register".Installments)
            {
            }
            column(LoanProductTypeName_LoansRegister; "Loans Register"."Loan Product Type Name")
            {
            }
            column(PostingDate_LoansRegister; "Loans Register"."Posting Date")
            {
            }
            column(OutstandingBalance_LoansRegister; "Loans Register"."Outstanding Balance")
            {
            }
            column(SharesBalance_LoansRegister; "Loans Register"."Shares Balance")
            {
            }
            column(CurrentShares_LoansRegister; "Loans Register"."Current Shares")
            {
            }
            column(No; runningno)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(Company_Name; Company.Name)
            {
            }
            column(Company_Address; Company.Address)
            {
            }
            column(Company_Address_2; Company."Address 2")
            {
            }
            column(Company_Phone_No; Company."Phone No.")
            {
            }
            column(Company_Fax_No; Company."Fax No.")
            {
            }
            column(Company_Letter_Head; Company."Address 2")
            {
            }
            column(Company_Picture; Company.Picture)
            {
            }
            column(Company_Email; Company."E-Mail")
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(USERID; UserId)
            {
            }
            column(LoansCategory_LoansRegister; "Loans Register"."Loans Category")
            {
            }
            column(AmountPaid; AmountPaid)
            {
            }
            column(CapturedBy_LoansRegister; "Loans Register"."Captured By")
            {
            }
            dataitem(Customer; Customer)
            {
                DataItemLink = "No." = field("Client Code");
                column(ReportForNavId_16; 16)
                {
                }
                column(CurrentShares_MemberRegister; Customer."Current Shares")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                runningno := runningno + 1;
                AmountPaid := 0;
                AmountPaid := "Loans Register"."Approved Amount" - "Loans Register"."Outstanding Balance";
            end;

            trigger OnPreDataItem()
            begin
                Company.Get();
                if CompanyInfo.Get then begin
                    CompanyInfo.CalcFields(Picture);//, Letter_Head);
                end
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
        runningno: Integer;
        Company: Record "Company Information";
        CompanyInfo: Record "Company Information";
        AmountPaid: Decimal;
}

