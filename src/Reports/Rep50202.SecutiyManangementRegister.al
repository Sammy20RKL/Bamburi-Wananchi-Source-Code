Report 50202 "Secutiy Manangement Register"
{
    ApplicationArea = All;
    Caption = 'Secutiy Mananagement Register';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Loan Security Manangment Register.rdlc';

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
                column(AmontGuaranteed_LoansGuaranteeDetails; AmontGuaranteed_LoansGuaranteeDetails)//"Loans Guarantee Details"."Amont Guaranteed")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    if "Loans Guarantee Details"."Amont Guaranteed" < 0 then
                        AmontGuaranteed_LoansGuaranteeDetails := 0
                    else
                        AmontGuaranteed_LoansGuaranteeDetails := "Loans Guarantee Details"."Amont Guaranteed";
                end;

            }
            dataitem("Loan Collateral Details"; "Loan Collateral Details")
            {
                DataItemTableView = sorting("Loan No", "Security Details", Code) where(Value = filter(> 0));
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
    end;

    var

        Var1: Integer;
        datefiltered: Text;
        AmontGuaranteed_LoansGuaranteeDetails: Integer;

}

