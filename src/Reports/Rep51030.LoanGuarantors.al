#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51030 "Loan Guarantors"
{
    DefaultLayout = RDLC;
    ApplicationArea = all;
    RDLCLayout = './Layouts/LoanGuarantorsNew.rdl';

    dataset
    {
        dataitem(Members; Customer)
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.";

            column(ReportForNavId_1102755000; 1102755000)
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
            column(Company_Phone_No; Company."Phone No.")
            {
            }
            column(Company_SMS; Company."Phone No.")
            {
            }
            column(Company_Email; Company."E-Mail")
            {
            }
            column(Company_Fax_No; Company."Fax No.")
            {

            }
            column(Company_Address_2; company."Address 2")
            {

            }
            column(No_Members; Members."No.")
            {
            }
            column(Name_Members; Members.Name)
            {
            }
            column(CurrentShares_Members; Members."Current Shares")
            {
            }
            column(Status_Members; Members.Status)
            {
            }
            dataitem(Loans; "Loans Register")
            {
                DataItemLink = "Client Code" = field("No.");
                DataItemTableView = where("Outstanding Balance" = filter(> 0));
                column(ReportForNavId_1102755001; 1102755001)
                {
                }
                column(LoanNo_Loans; Loans."Loan  No.")
                {
                }
                column(ApplicationDate_Loans; Loans."Application Date")
                {
                }
                column(LoanProductType_Loans; Loans."Loan Product Type")
                {
                }
                column(RequestedAmount_Loans; Loans."Requested Amount")
                {
                }
                column(ApprovedAmount_Loans; Loans."Approved Amount")
                {
                }
                dataitem("Loan Guarantors"; "Loans Guarantee Details")
                {
                    DataItemLink = "Loan No" = field("Loan  No.");
                    column(ReportForNavId_1102755002; 1102755002)
                    {
                    }
                    column(MemberNo_LoanGuarantors; "Loan Guarantors"."Loanees  No")
                    {
                    }
                    column(LoanNo_LoanGuarantors; "Loan Guarantors"."Loan No")
                    {
                    }
                    column(Name_LoanGuarantors; "Loan Guarantors"."Loanees  Name")
                    {
                    }
                    column(LoanBalance_LoanGuarantors; "Loan Guarantors"."Loans Outstanding")
                    {
                    }
                    column(Shares_LoanGuarantors; "Loan Guarantors".Shares)
                    {
                    }
                    column(NoOfLoansGuaranteed_LoanGuarantors; "Loan Guarantors"."No Of Loans Guaranteed")
                    {
                    }
                    column(Substituted_LoanGuarantors; "Loan Guarantors".Substituted)
                    {
                    }
                    column(Date_LoanGuarantors; "Loan Guarantors".Date)
                    {
                    }
                    column(SharesRecovery_LoanGuarantors; "Loan Guarantors"."Shares Recovery")
                    {
                    }
                    column(NewUpload_LoanGuarantors; "Loan Guarantors"."New Upload")
                    {
                    }
                    column(AmontGuaranteed_LoanGuarantors; "Loan Guarantors"."Amont Guaranteed")
                    {
                    }
                    column(StaffPayrollNo_LoanGuarantors; "Loan Guarantors"."Staff/Payroll No.")
                    {
                    }
                    column(AccountNo_LoanGuarantors; "Loan Guarantors"."Account No.")
                    {
                    }
                    column(SelfGuarantee_LoanGuarantors; "Loan Guarantors"."Self Guarantee")
                    {
                    }
                    column(IDNo_LoanGuarantors; "Loan Guarantors"."ID No.")
                    {
                    }
                    column(OutstandingBalance_LoanGuarantors; "Loan Guarantors"."Outstanding Balance")
                    {
                    }
                    column(MemberGuaranteed_LoanGuarantors; "Loan Guarantors"."Transferable shares")
                    {
                    }
                }
                // //Loan.GET();
                // trigger OnAfterGetRecord()
                // var
                //     myInt: Integer;
                // begin


                //     CommittedShares := 0;
                //     GuarantorNo := '';

                //     Loansr.RESET;
                //     Loansr.SETRANGE(Loansr."Loan  No.", "Loan Guarantors"."Loan No");
                // IF Loansr.FIND('-') THEN BEGIN
                //     MemberNo := Loansr."Client Code";
                //     MemberName := Loansr."Client Name";
                //     EmployerCode := Loansr."Employer Code";
                //     ApprovedAmt := Loansr."Approved Amount";

                //     GuarantorNo := "Loans Guarantee Details"."Member No";


                //     ObjLoanGuar.RESET;
                //     ObjLoanGuar.SETRANGE(ObjLoanGuar."Loan No", "Loan No");
                //     ObjLoanGuar.SETRANGE(ObjLoanGuar."Member No", GuarantorNo);
                //     IF ObjLoanGuar.FINDSET THEN BEGIN
                //             REPEAT
                //                 //MESSAGE(GuarantorNo);
                //                 ObjLoanGuar.CALCFIELDS(ObjLoanGuar."Outstanding Balance");
                //                 IF ApprovedAmt > 0 THEN BEGIN
                //                     CommittedShares := (ObjLoanGuar."Outstanding Balance" / ApprovedAmt) * ObjLoanGuar."Amont Guaranteed";
                //                     //MESSAGE('Balance %1, Approved %2, Guaranteed %3 thus Committed = %4 for Member %5',ObjLoanGuar."Outstanding Balance",ApprovedAmt,ObjLoanGuar."Amont Guaranteed",CommittedShares,GuarantorNo);
                //                     //MODIFY;
                //                 END;
                //                 IF CommittedShares > 0 THEN BEGIN
                //                     ObjLoanGuar.RESET;
                //                     ObjLoanGuar.SETRANGE(ObjLoanGuar."Loan No", "Loan No");
                //                     ObjLoanGuar.SETRANGE(ObjLoanGuar."Member No", GuarantorNo);
                //                     IF ObjLoanGuar.FIND('-') THEN BEGIN
                //                         ObjLoanGuar."Committed Shares" := CommittedShares;
                //                         ObjLoanGuar.MODIFY;
                //                     END;
                //                 END;
                //             UNTIL ObjLoanGuar.NEXT = 0;
                //         END;
                //     END;
                // end;
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

    var
        company: Record "Company Information";
        ObjLoanGuar: Record "Loans Guarantee Details";
        CommittedShares: Decimal;
        GuarantorNo: Text;
        Loansr: Record "Loans Register";
        ApprovedAmt: Decimal;



    trigger OnPreReport()
    begin
        Company.get;
        Company.CalcFields(Picture);
    end;
}

