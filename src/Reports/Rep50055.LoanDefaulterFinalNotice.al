#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50055 "Loan Defaulter Final Notice"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/LoanDefaulterFinalNotice.rdl';

    dataset
    {
        dataitem("LoansRec"; "Loans Register")
        {
            RequestFilterFields = "Client Code", "Loan  No.", "Loans Category-SASRA";
            column(ReportForNavId_1102755000; 1102755000)
            {
            }
            column(OutstandingBalance_Loans; LoansRec."Outstanding Balance")
            {
            }
            column(LoanNo_Loans; LoansRec."Loan  No.")
            {
            }
            column(ClientName_Loans; LoansRec."Client Name")
            {
            }
            column(ClientCode_Loans; LoansRec."Client Code")
            {
            }
            column(OutstandingBalance_LoansRec; "LoansRec"."Outstanding Balance")
            {
            }
            column(OustandingInterest_LoansRec; "LoansRec"."Oustanding Interest")
            {
            }
            column(CurrentShares_LoansRec; CurrentShares_LoansRec)
            {
            }
            column(ApprovedAmount_LoansRec; "LoansRec"."Approved Amount")
            {
            }
            column(Penaltycharge_on_offset; Penaltcharge)
            {
            }
            column(AmouuntToRecover; AmouuntToRecover)
            {
            }
            column(PrincipleInArrears; PrincipleInArrears)
            { }

            column(AmountInArrears_DefaultNoticesRegister; AmountInArrears_DefaultNoticesRegister)
            { }
            column(LoanNo; LoanNo)
            {
            }
            column(DOCNAME; DOCNAME)
            {
            }
            column(CName; CompanyInfo.Name)
            {
            }
            column(Caddress; CompanyInfo.Address)
            {
            }
            column(CmobileNo; CompanyInfo."Phone No.")
            {
            }
            column(clogo; CompanyInfo.Picture)
            {
            }
            column(Cwebsite; CompanyInfo."Home Page")
            {
            }
            column(Email; CompanyInfo."E-Mail")
            {
            }
            dataitem(Customer; Customer)
            {
                DataItemLink = "No." = field("Client Code");
                column(ReportForNavId_1102755005; 1102755005)
                {
                }
                column(Name_Members; Customer.Name)
                {
                }
                column(No_Members; Customer."No.")
                {
                }
                column(City_Members; Customer.City)
                {
                }
                column(Address2_Members; Customer."Address 2")
                {
                }
                column(Address_Members; Customer.Address)
                {
                }

                trigger OnPreDataItem()
                begin
                    CalcFields(Customer."Current Shares", Customer."Shares Retained");
                    CurrentShares_LoansRec := Customer."Current Shares";

                end;
            }
            dataitem("Loans Register"; "Loans Register")
            {
                DataItemLink = "Loan  No." = field("Loan  No.");
                column(ReportForNavId_1102755011; 1102755011)
                {
                }
                dataitem("Loans Guarantee Details"; "Loans Guarantee Details")
                {
                    DataItemLink = "Loan No" = field("Loan  No.");
                    column(ReportForNavId_1102755009; 1102755009)
                    {
                    }
                    column(MemberNo_LoanGuarantors; "Loans Guarantee Details"."Member No")
                    {
                    }
                    column(Name_LoanGuarantors; "Loans Guarantee Details".Name)
                    {
                    }
                    column(ApprovedAmount_Loans; LoansRec."Approved Amount")
                    {
                    }
                    column(OutstandingInterest_Loans; LoansRec."Oustanding Interest")
                    {
                    }
                    column(OutstandingInt; Loansrec."Oustanding Interest")
                    {
                    }
                    column(CurrentSavings_Members; Customer."Current Savings")
                    {
                    }
                    column(Amont_Guaranteed; "Amont Guaranteed") { }

                    column(Loan_Officer; Lofficer)
                    {
                    }
                    /*   dataitem("Default Notices Register"; "Default Notices Register")
                      {
                          column(Outstanding_Interest; "Outstanding Interest")
                          {
                          }

                      } */
                }
            }

            // trigger OnAfterGetRecord()
            // begin
            //     //Penaltcharge := 0.05 * ("LoansRec"."Current Shares" + "LoansRec"."Share Purchase");
            //     //AmouuntToRecover := ("Outstanding Balance" + "Oustanding Interest" + Penaltcharge) - "Current Shares";

            //     AmountInArrears_DefaultNoticesRegister := Round("Outstanding Balance" + "Oustanding Interest");
            //     if "Current Shares" > AmountInArrears_DefaultNoticesRegister then
            //         AmountInArrears_DefaultNoticesRegister := 0
            //     else
            //         AmouuntToRecover := AmountInArrears_DefaultNoticesRegister - -"LoansRec"."Current Shares";
            //     OutstandingInt := "Oustanding Interest";
            //     LoanNo := "Loan  No.";

            // end;

            // trigger OnPreDataItem()
            // begin
            //     CalcFields("Outstanding Balance", "Oustanding Interest", "Current Shares");

            // end;
            trigger OnAfterGetRecord()
            begin
                LoanRepaymentSchedule.Reset();
                LoanRepaymentSchedule.SetRange("Loan No.", LoansRec."Loan  No.");
                LoanRepaymentSchedule.SetFilter("Repayment Date", '<=%1', Today);

                if LoanRepaymentSchedule.FindLast() then begin
                    ScheduleBalance := LoanRepaymentSchedule."Loan Balance";
                end;

                LoansR.Reset();
                loansR.SetRange("Loan  No.", "Loans Register"."Loan  No.");
                //LoansRec.SetFilter(LoansRec."Date filter", DateFilterBF);

                if LoansR.Find('-') then begin
                    LoansR.CalcFields(LoansR."Outstanding Balance", LoansR."Oustanding Interest");
                    //PrincipleBF := LoansR."Outstanding Balance";
                    InterestBF := LoansRec."Oustanding Interest";
                end;

                // Message('Demand notices InterestBf %1| Loan No is %2|Current Shares %3', InterestBf, LoansRec."Loan  No.", CurrentShares_LoansRec);

                PrincipleInArrears := LoansRec."Outstanding Balance" - ScheduleBalance;
                VarArrearsAmount := PrincipleInArrears + loansrec."Oustanding Interest";
                // Message('Schedule balance is %1, Approved amount of %2', ScheduleBalance, LoansRec."Approved Amount");
                // Message('Arrears %1, Interest of %2', vararrearsamount, loansrec."Oustanding Interest");

                // Calculate total arrears (Outstanding Balance + Outstanding Interest)
                AmountInArrears_DefaultNoticesRegister := VarArrearsAmount;

                // Ensure amount is correctly reduced if current shares cover the arrears
                if "Current Shares" >= AmountInArrears_DefaultNoticesRegister then
                    AmouuntToRecover := 0
                else
                    AmouuntToRecover := AmountInArrears_DefaultNoticesRegister - "Current Shares"; // Removed redundant negative sign (- -)

                // Assign values to variables
                OutstandingInt := LoansR."Oustanding Interest";
                LoanNo := "Loan  No.";
            end;

            trigger OnPreDataItem()
            begin
                // Ensure calculated fields are retrieved
                // CalcFields("Outstanding Balance", "Oustanding Interest", "Current Shares");
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
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);

        DOCNAME := 'FINAL DEFAULTER NOTICE';
        Lofficer := UserId;
    end;

    var
        CurrentShares_LoansRec: decimal;
        Balance: Decimal;
        SenderName: Text[150];
        DearM: Text[60];
        BalanceType: Text[100];
        SharesB: Decimal;
        LastPDate: Date;
        LoansR: Record "Loans Register";
        SharesAlllocated: Decimal;
        ABFAllocated: Decimal;
        LBalance: Decimal;
        PersonalNo: Code[50];
        GAddress: Text[250];
        Cust: Record Customer;
        Vend: Record Vendor;
        OutstandingBalLoan: Decimal;
        AmouuntToRecover: Decimal;
        OutstandingInt: Decimal;
        LoanNo: Code[30];
        DOCNAME: Text[30];
        CompanyInfo: Record "Company Information";
        Penaltcharge: Decimal;
        Lofficer: Text;
        AmountInArrears_DefaultNoticesRegister: Decimal;
        LoanRepaymentSchedule: Record "Loan Repayment Schedule";
        ScheduleBalance: Decimal;
        PrincipleInArrears: Decimal;
        VarArrearsAmount: Decimal;
        InterestBF: Decimal;
}

