#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50258 "Membership Closure Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/MembershipClosureReport.rdl';

    dataset
    {
        dataitem("Membership Closure"; "Membership Exist")
        {
            RequestFilterFields = "No.", "Closing Date";
            column(ReportForNavId_1000000000; 1000000000)
            {
            }
            column(COMP; COMPANYNAME)
            {
            }
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
            column(USERID; UserId)
            {
            }
            column(TODAY; Today)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(companyinfo_Picture; companyinfo.Picture)
            {
            }
            column(User_Name_Caption; User_Name_CaptionLbl)
            {
            }
            column(Print_Date_Caption; Print_Date_CaptionLbl)
            {
            }
            column(Page_No_Caption; Page_No_CaptionLbl)
            {
            }
            column(No; "Membership Closure"."No.")
            {
            }
            column(MembNo; "Membership Closure"."Member No.")
            {
            }
            column(MembName; "Membership Closure"."Member Name")
            {
            }
            column(ClosureType; "Membership Closure"."Closure Type")
            {
            }
            column(Payee; "Membership Closure"."Member Name")
            {
            }
            column(ClosureDATE; Format("Membership Closure"."Closing Date"))
            {
            }
            column(sTATUS; "Membership Closure".Status)
            {
            }
            column(Amountref; "Membership Closure"."Member Deposits" - ("Membership Closure"."Total Loan" + "Membership Closure"."Total Interest"))
            {
            }

            trigger OnPreDataItem()
            begin
                if companyinfo.Get then
                    companyinfo.CalcFields(companyinfo.Picture);
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
        User_Name_CaptionLbl: label 'User Name:';
        Print_Date_CaptionLbl: label 'Print Date:';
        Page_No_CaptionLbl: label 'Page No:';
        companyinfo: Record "Company Information";
}

