#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50222 "Member Account  Balances"
{
    ApplicationArea = All;
    RDLCLayout = './Layouts/MemberAccountbalances.rdl';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(member; "Customer")
        {
            RequestFilterFields = "No.", Name, "Date Filter";
            /* column(ReportForNavId_1102755077; 1102755077)
            {
            } */
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
            column(No_member; member."No.")
            {
            }
            column(Name_member; member.Name)
            {
            }


            column(CurrentShares_member; member."Current Shares")
            {
            }

            column(OutstandingBalance_member; Member."Outstanding Balance")
            {
            }
            column(Shares_capital; Member."Share Capital")
            {
            }

            column(Outstanding_Interest; Member."Outstanding Interest")
            {
            }
            column(LikizoContribution; Member."Likizo Contribution")
            {

            }
            /*
            column(Alpha_Savings; Member."Alpha Savings") { }
            column(Junior_Savings_One; "Junior Savings One") { }
            column(Junior_Savings_Two; "Junior Savings Two") { }
            column(Junior_Savings_Three; "Junior Savings Three") { } */


            column(ASAT; ASAT)
            {
            }

            trigger OnAfterGetRecord()
            begin

                CalcFields("Current Shares", "Share Capital", "Outstanding Balance", "Outstanding Interest"/* , "Alpha Savings", "Junior Savings One", "Likizo Contribution" */);
                LoansBal := "Outstanding Balance";
                CurrentShares := "Current Shares";
                SharesCap := "Share Capital";
                InterestBal := "Outstanding Interest";


            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {

            }
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
        CompanyInfo.Get();
        CompanyInfo.CalcFields(CompanyInfo.Picture);
    end;

    var
        CurrentShares: Decimal;
        SharesCap: Decimal;
        HousingShares: Decimal;
        LikizoShares: Decimal;
        CompanyInfo: Record "Company Information";

        LoansBal: Decimal;
        InterestBal: Decimal;
        Loans_RegisterCaptionLbl: label 'Loans Register';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Loan_TypeCaptionLbl: label 'Loan Type';
        Client_No_CaptionLbl: label 'Client No.';
        Outstanding_LoanCaptionLbl: label 'Outstanding Loan';
        PeriodCaptionLbl: label 'Period';
        Approved_DateCaptionLbl: label 'Approved Date';
        Loan_TypeCaption_Control1102760043Lbl: label 'Loan Type';
        Verified_By__________________________________________________CaptionLbl: label 'Verified By..................................................';
        Confirmed_By__________________________________________________CaptionLbl: label 'Confirmed By..................................................';
        Sign________________________CaptionLbl: label 'Sign........................';
        Sign________________________Caption_Control1102755003Lbl: label 'Sign........................';
        Date________________________CaptionLbl: label 'Date........................';
        Date________________________Caption_Control1102755005Lbl: label 'Date........................';
        NameCreditOff: label 'Name..............................................';
        NameCreditDate: label 'Date...............................................';
        NameCreditSign: label 'Signature.........................................';
        NameCreditMNG: label 'Name..............................................';
        NameCreditMNGDate: label 'Date...............................................';
        NameCreditMNGSign: label 'Signature...........................................';
        NameCEO: label 'Name................................................';
        NameCEOSign: label 'Signature...........................................';
        NameCEODate: label 'Date.................................................';
        CreditCom1: label 'Name................................................';
        CreditCom1Sign: label 'Signature...........................................';
        CreditCom1Date: label 'Date.................................................';
        CreditCom2: label 'Name................................................';
        CreditCom2Sign: label 'Signature...........................................';
        CreditCom2Date: label 'Date.................................................';
        CreditCom3: label 'Name................................................';
        CreditComDate3: label 'Date..................................................';
        CreditComSign3: label 'Signature............................................';
        From: Date;
        "To": Integer;
        DFilter: Text;
        ASAT: Date;
}

