#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50054 "Loan Defaulter 2nd Notice"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/LoanDefaulter_2ndNotice.rdl';

    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            RequestFilterFields = "Client Code", "Loan  No.", "Loans Category-SASRA";
            column(ReportForNavId_1102755000; 1102755000)
            {
            }
            column(OutstandingBalance_Loans; "Loans Register"."Outstanding Balance")
            {
            }
            column(LoanNo_Loans; "Loans Register"."Loan  No.")
            {
            }
            column(ClientName_Loans; "Loans Register"."Client Name")
            {
            }
            column(LoanProductType_LoansRegister; "Loans Register"."Loan Product Type")
            {
            }
            column(LoanProductTypeName_LoansRegister; "Loans Register"."Loan Product Type Name")
            {
            }
            column(LoansReg_AmountInArrears; "Loans Register"."Amount in Arrears")
            {
            }

            column(ClientCode_Loans; "Loans Register"."Client Code")
            {
            }

            column(LoanNo_LoansPrinciple; "Loans Register"."Approved Amount")
            {
            }
            column(LoanNo_LoanDate; "Loans Register"."Issued Date")
            {
            }
            column(LoanNo_LoanPeriod; "Loans Register"."Instalment Period")
            {
            }
            column(LoanNo_LoanPeriodInt; "Loans Register".Installments)
            {
            }
            column(recoverNoticedate; recoverNoticedate)
            {
            }

            //
            column(AmountInArrears; VarArrearsAmount) { }//AmountInArrears
            column(LoanOutstanding_Balance; "LoanOutstanding Balance") { }
            column(LoanOutstanding_Interest; InterestBf) { }
            column(LInstallments; LInstallments) { }
            column(RemainingPeriod; RemainingPeriod) { }
            column(PrincipleInArrears; PrincipleInArrears) { }


            column(ExpectedCompleteDate; ExpectedCompleteDate)
            {
            }
            column(ScheduleBalance; ScheduleBalance)
            {
            }

            dataitem("Members Register"; Customer)
            {
                DataItemLink = "No." = field("Client Code");
                column(ReportForNavId_1102755005; 1102755005)
                {
                }
                column(City_Members; "Members Register".City)
                {
                }
                column(Address2_Members; "Members Register"."Address 2")
                {
                }
                column(Address_Members; "Members Register".Address)
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
                column(loansOFFICER; Lofficer)
                {
                }

                // trigger OnAfterGetRecord()
                // begin
                //     // workString := CONVERTSTR(Customer.Name, ' ', ',');
                //     // DearM := SELECTSTR(1, workString);
                //     // //LastPDate := 0D;
                //     // Balance := 0;
                //     // SharesB := 0;
                // end;


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
            }
            trigger OnAfterGetRecord()
            var
                LoanGuar: Record "Loans Guarantee Details";
            begin

                RemainingPeriod := Round("Loans Register".Installments - ObjSwizzsoft.KnGetCurrentPeriodForLoan("Loan  No."));
                // Message('Loans Installments is %1,Arrears month %2', "Loans Register".Installments, ObjSwizzsoft.KnGetCurrentPeriodForLoan("Loan  No."));

                ObjLoans.Reset();
                ObjLoans.SetRange("Loan  No.", "Loans Register"."Loan  No.");
                if ObjLoans.FindLast() then begin
                    ObjLoans.CalcFields(ObjLoans."Outstanding Balance", "Oustanding Interest");
                    LInstallments := ObjLoans.Installments;
                    DisbursementDate := ObjLoans."Loan Disbursement Date";
                    ExpectedCompleteDate := ObjLoans."Expected Date of Completion";
                    //AmountInArrears := ROUND(ObjSwizzsoft.FnGetLoanInArrears("Loans Register"."Loan  No.", ObjLoans."Outstanding Balance"), 1, '=') + ObjLoans."Oustanding Interest";
                    "LoanOutstanding Balance" := ObjLoans."Outstanding Balance";
                    "LoanIssued" := ObjLoans."Approved Amount";
                    "LOutstanding Interest" := ObjLoans."Oustanding Interest";
                    "Loan Product Name" := ObjLoans."Loan Product Type Name";
                    //Message('Amount in Arrears is %1 + %2 = %3 disbursed on %4', "LOutstanding Interest", "LoanOutstanding Balance", AmountInArrears, DisbursementDate);
                end;
                recoverNoticedate := CALCDATE('1M', TODAY);

                LoanRepaymentSchedule.Reset();
                LoanRepaymentSchedule.SetRange("Loan No.", "Loans Register"."Loan  No.");
                LoanRepaymentSchedule.SetFilter("Repayment Date", '<=%1', Today);

                if LoanRepaymentSchedule.FindLast() then begin
                    ScheduleBalance := LoanRepaymentSchedule."Loan Balance";
                end;

                LoansREC.Reset();
                loansrec.SetRange("Loan  No.", "Loans Register"."Loan  No.");
                //LoansRec.SetFilter(LoansRec."Date filter", DateFilterBF);

                if LoansRec.Find('-') then begin
                    LoansRec.CalcFields(LoansRec."Outstanding Balance", LoansRec."Oustanding Interest");
                    //PrincipleBF := LoansR."Outstanding Balance";
                    InterestBF := LoansRec."Oustanding Interest";
                end;

                PrincipleInArrears := "Outstanding Balance" - ScheduleBalance;
                VarArrearsAmount := PrincipleInArrears + LoansRec."Oustanding Interest";


                // PrincipleInArrears := "Loans Register"."Approved Amount" - ScheduleBalance;
                // VarArrearsAmount := PrincipleInArrears + loansrec."Oustanding Interest";
                // // Message('Schedule balance is %1, Approved amount of %2', ScheduleBalance, "Loans Register"."Approved Amount");
                // Message('Arrears %1, Interest of %2', vararrearsamount, loansrec."Oustanding Interest");


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

        DOCNAME := 'SECOND DEMAND NOTICE';
        Lofficer := UserId;
    end;

    var
        DOCNAME: Text[30];
        CompanyInfo: Record "Company Information";
        Lofficer: Text;
        recoverNoticedate: Date;
        RemainingPeriod: Integer;
        Gname: Text;
        GNo: Code[20];
        ObjLoans: Record "Loans Register";
        "Loan Product Name": Text;
        "LOutstanding Interest": Decimal;
        LoanIssued: Decimal;
        "LoanOutstanding Balance": Decimal;
        AmountInArrears: Decimal;
        LInstallments: Integer;
        ExpectedCompleteDate: date;
        DisbursementDate: date;
        ObjSwizzsoft: Codeunit "Swizzsoft Factory.";

        Gnames: array[100] of Text[100];
        GNos: array[100] of Text[100];
        Index: Integer;

        AllGnames: Text;
        AllGNos: Text;
        LoanRepaymentSchedule: Record "Loan Repayment Schedule";
        ScheduleBalance: Decimal;
        LoansREC: Record "Loans Register";
        PrincipleInArrears: Decimal;
        VarArrearsAmount: Decimal;
        InterestBF: Decimal;

}

