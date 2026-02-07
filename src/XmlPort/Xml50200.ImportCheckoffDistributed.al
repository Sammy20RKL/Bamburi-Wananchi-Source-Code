#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 50200 "Import Checkoff Distributed"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("CheckoffLinesDistributed Nav"; "CheckoffLinesDistributed Nav")
            {
                XmlName = 'Paybill';
                fieldelement(Headerno; "CheckoffLinesDistributed Nav"."Receipt Header No")
                {
                }
                fieldelement(entryno; "CheckoffLinesDistributed Nav"."Entry No")
                {
                    FieldValidate = yes;
                }
                fieldelement(Personal_no; "CheckoffLinesDistributed Nav"."Staff/Payroll No")
                {
                }
                fieldelement(SHARECAPITAL; "CheckoffLinesDistributed Nav"."Share Capital")
                {
                }
                fieldelement(DEPOSITCONTRIBUTION; "CheckoffLinesDistributed Nav"."Deposit Contribution")
                {
                }
                fieldelement(BENEVOLENT; "CheckoffLinesDistributed Nav"."Benevolent Fund")
                {
                }
                fieldelement(INSURANCE; "CheckoffLinesDistributed Nav"."Insurance Fee")
                {
                }
                fieldelement(REGISTRATION; "CheckoffLinesDistributed Nav"."Registration Fee")
                {
                }
                fieldelement(holiday; "CheckoffLinesDistributed Nav"."Holiday savings")
                {
                }
                fieldelement(EMERGENCYLOAN_AMOUNT; "CheckoffLinesDistributed Nav"."EMERGENCY LOAN Amount")
                {
                }
                fieldelement(EMERGENCYLOAN_PR; "CheckoffLinesDistributed Nav"."EMERGENCY LOAN Principal")
                {
                }
                fieldelement(EMERGENCYLOAN_INT; "CheckoffLinesDistributed Nav"."EMERGENCY LOAN Int")
                {
                }
                fieldelement(SUPEPEMERGENCYLOAN_AMOUNT; "CheckoffLinesDistributed Nav"."Super Emergency Amount")
                {
                }
                fieldelement(SUPEPEMERGENCYLOAN_PR; "CheckoffLinesDistributed Nav"."Super Emergency Principal")
                {
                }
                fieldelement(SUPEPEMERGENCYLOAN_INT; "CheckoffLinesDistributed Nav"."Super Emergency Int")
                {
                }
                fieldelement(QUICKLOAN_AMOUNT; "CheckoffLinesDistributed Nav"."Quick Loan Amount")
                {
                }
                fieldelement(QUICKLOAN_PR; "CheckoffLinesDistributed Nav"."Quick Loan Principal")
                {
                }
                fieldelement(QUICKLOAN_INT; "CheckoffLinesDistributed Nav"."Quick Loan Int")
                {
                }
                fieldelement(SUPERQUICK_AMOUNT; "CheckoffLinesDistributed Nav"."Super Quick Amount")
                {
                }
                fieldelement(SUPERQUICK_PR; "CheckoffLinesDistributed Nav"."Super Quick Principal")
                {
                }
                fieldelement(SUPERQUICK_INT; "CheckoffLinesDistributed Nav"."Super Quick Int")
                {
                }
                fieldelement(SCHOOLFEES_AMOUNT; "CheckoffLinesDistributed Nav"."SCHOOL FEES LOAN Amount")
                {
                }
                fieldelement(SCHOOLFEES_PR; "CheckoffLinesDistributed Nav"."SCHOOL FEES LOAN Principal")
                {
                }
                fieldelement(SCHOOLFEES_INT; "CheckoffLinesDistributed Nav"."SCHOOL FEES LOAN Int")
                {
                }
                fieldelement(SUPERSCHOOLFEES_AMOUNT; "CheckoffLinesDistributed Nav"."Super School Fees Amount")
                {
                }
                fieldelement(SUPERSCHOOLFEES_PR; "CheckoffLinesDistributed Nav"."Super School Fees Principal")
                {
                }
                fieldelement(SUPERSCHOOLFEES_INT; "CheckoffLinesDistributed Nav"."Super School Fees Int")
                {
                }
                fieldelement(INVESTMENTLOAN_AMOUNT; "CheckoffLinesDistributed Nav"."Investment  Amount")
                {
                }
                fieldelement(INVESTMENTLOAN_PR; "CheckoffLinesDistributed Nav"."Investment  Principal")
                {
                }
                fieldelement(INVESTMENTLOAN_INT; "CheckoffLinesDistributed Nav"."Investment  Int")
                {
                }
                fieldelement(NormalAmount20; "CheckoffLinesDistributed Nav"."Normal Amount 20")
                {
                }
                fieldelement(NormalPri20; "CheckoffLinesDistributed Nav"."Normal Pri (20)")
                {
                }
                fieldelement(Normalint20; "CheckoffLinesDistributed Nav"."Normal Int (20)")
                {
                }
                fieldelement(NORMALLOAN_AMOUNT; "CheckoffLinesDistributed Nav"."Normal Loan Amount")
                {
                }
                fieldelement(NORMALLOAN_PR; "CheckoffLinesDistributed Nav"."Normal Loan Principal")
                {
                }
                fieldelement(NORMALLOAN_INT; "CheckoffLinesDistributed Nav"."Normal Loan Int")
                {
                }
                fieldelement(NORMALLOAN1_AMOUNT; "CheckoffLinesDistributed Nav"."Normal Loan 1 Amount")
                {
                }
                fieldelement(NORMALLOAN1_PR; "CheckoffLinesDistributed Nav"."Normal Loan 1 Principal")
                {
                }
                fieldelement(DEVELOPMENtLOAN1Amount; "CheckoffLinesDistributed Nav"."DEVELOPMENT LOAN 1 Amount")
                {
                }
                fieldelement(DEVELOPMENLOAN1Principal; "CheckoffLinesDistributed Nav"."DEVELOPMENT LOAN 1 Principal")
                {
                }
                fieldelement(DEVELOPMENLOAN1Int; "CheckoffLinesDistributed Nav"."DEVELOPMENT LOAN 1  Int")
                {
                }
                fieldelement(DEVELOPMENTLOAN_AMOUNT; "CheckoffLinesDistributed Nav"."DEVELOPMENT LOAN Amount")
                {
                }
                fieldelement(DEVELOPMENTLOAN_PR; "CheckoffLinesDistributed Nav"."DEVELOPMENT LOAN Principal")
                {
                }
                fieldelement(DEVELOPMENTLOANINT; "CheckoffLinesDistributed Nav"."DEVELOPMENT LOAN Int")
                {
                }
                fieldelement(MecharndiseLoanAmount; "CheckoffLinesDistributed Nav"."MERCHANDISE Amount")
                {
                }
                fieldelement(MechandisePrAmount; "CheckoffLinesDistributed Nav"."MERCHANDISE Pri")
                {
                }
                fieldelement(MechandiseIntAmount; "CheckoffLinesDistributed Nav"."MERCHANDISE Int")
                {
                }
                fieldelement(Welfare; "CheckoffLinesDistributed Nav"."Welfare contribution")
                {
                }

                trigger OnAfterInsertRecord()
                var
                    MembershipExist: Record "Membership Exit";
                    MemberRegister: Record Customer;
                begin
                    MembershipExist.Reset;
                    MembershipExist.SetRange(MembershipExist."Member No.", MemberRegister."No.");
                    if MembershipExist.Find('-') then
                        currXMLport.Skip;
                end;
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
}

