#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006
report 51031 "Loans Guaranteed Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layout/Loans Guaranteed Report.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.", Name;

            column(COMPANYNAME; COMPANYNAME) { }
            column(Company_Name; Company.Name) { }
            column(Company_Address; Company.Address) { }
            column(Company_Address_2; Company."Address 2") { }
            column(Company_Phone_No; Company."Phone No.") { }
            column(Company_Fax_No; Company."Fax No.") { }
            column(Company_Picture; Company.Picture) { }
            column(Company_Email; Company."E-Mail") { }
            column(CurrReport_PAGENO; CurrReport.PageNo) { }
            column(USERID; UserId) { }
            column(No_Members; Customer."No.") { }
            column(Name_Members; Customer.Name) { }
            column(PhoneNo_Members; Customer."Phone No.") { }
            column(OutstandingBalance_Members; Customer."Outstanding Balance") { }

            dataitem("Loans Guarantee Details"; "Loans Guarantee Details")
            {
                DataItemLink = "Member No" = field("No.");
                DataItemTableView = where("Outstanding Balance" = filter(> 0), Substituted = filter(false));
                RequestFilterFields = "Member No", "Loan No";

                column(AmontGuaranteed_LoanGuarantors; "Amont Guaranteed") { }
                column(NoOfLoansGuaranteed_LoanGuarantors; "No Of Loans Guaranteed") { }
                column(Name_LoanGuarantors; Name) { }
                column(MemberNo_LoanGuarantors; "Member No") { }
                column(LoanNo_LoanGuarantors; "Loan No") { }
                column(LoanProduct_BOSALoansGuarantors; LoanProductName) { }
                column(OutstandingBalance_LoanGuarantors; "Outstanding Balance") { }
                column(OutstandingBAlSt; OutstandingBAlSt) { }
                column(OutStandingBal; OutStandingBal) { }
                column(TotalOutstandingBal; TotalOutstandingBal) { }
                column(FNo; FNo) { }
                column(AmountGuar; AmountGuar) { }
                column(LoaneesName_LoanGuarantors; "Loanees  Name") { }
                column(LoaneesNo_LoanGuarantors; "Loanees  No") { }
                column(SubNo; "Substituted Guarantor") { }
                column(SubName; "Share capital") { }
                column(OriginalAmount_LoansGuaranteeDetails; "Amont Guaranteed") { }// "Original Amount") { }
                column(CommittedShares; "Committed Shares") { }// CommittedShares) { }

                dataitem("Loans Register"; "Loans Register")
                {
                    DataItemLink = "Loan  No." = field("Loan No");
                    DataItemTableView = sorting("Loan  No.") order(ascending) where(Posted = const(true));

                    column(Client_Code; "Client Code") { }
                    column(Client_Name; "Client Name") { }
                    column(EmployerCode_Loans; "Employer Code") { }
                    column(OutstandingBalance_Loans; "Outstanding Balance") { }

                    trigger OnPreDataItem()
                    begin
                        OutStandingBal := 0;
                        TotalOutstandingBal := 0;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    guarantorMngt.UpdateCommittedSharesForLoan("Loan No");
                    // CalcLoanDetails();
                end;
            }

            trigger OnPreDataItem()
            begin
                Company.Get();
                Company.CalcFields(Picture);
            end;
        }
    }

    requestpage
    {
        layout { }
        actions { }
    }

    labels { }

    var
        guarantorMngt: Codeunit "Guarantor Management";
        AvailableSH: Decimal;
        MemberNo: Text;
        MemberName: Text;
        EmployerCode: Text;
        TotalOutstandingBal: Decimal;
        OutStandingBal: Decimal;
        FNo: Integer;
        AmountGuar: Decimal;
        OutstandingBAlSt: Decimal;
        Company: Record "Company Information";
        CommittedShares: Decimal;
        ObjLoanGuar: Record "Loans Guarantee Details";
        ApprovedAmt: Decimal;
        LoanProductName: Text[50];
        Loantypes: Record "Loan Products Setup";

    procedure CalcLoanDetails()
    var
        LoanReg: Record "Loans Register";
    begin
        OutstandingBAlSt := 0;
        LoanProductName := '';

        if LoanReg.Get("Loans Guarantee Details"."Loan No") then begin
            LoanReg.CalcFields("Outstanding Balance");
            OutstandingBAlSt := LoanReg."Outstanding Balance";
            MemberNo := LoanReg."Client Code";
            MemberName := LoanReg."Client Name";
            EmployerCode := LoanReg."Employer Code";
            ApprovedAmt := LoanReg."Approved Amount";

            LoanProductName := FormatLoanProduct(LoanReg."Loan Product Type Name");
        end;

        FNo += 1;
        AmountGuar += "Loans Guarantee Details"."Amont Guaranteed";

        ObjLoanGuar.Reset;
        ObjLoanGuar.SetRange("Loan No", "Loans Guarantee Details"."Loan No");
        ObjLoanGuar.SetRange("Member No", "Loans Guarantee Details"."Member No");
        ObjLoanGuar.SetRange("Loanees  No", "Loans Guarantee Details"."Loanees  No");

        if ObjLoanGuar.FindSet then begin
            repeat
                // Get product name
                if Loantypes.Get(ObjLoanGuar."Loan Product") then
                    LoanProductName := Loantypes."Product Description";

                // Calculate Outstanding Balance
                ObjLoanGuar.CalcFields("Outstanding Balance");

                // Calculate Committed Shares
                if ApprovedAmt > 0 then
                    CommittedShares := Round((ObjLoanGuar."Outstanding Balance" / ApprovedAmt) * ObjLoanGuar."Amont Guaranteed", 0.05, '>')
                else
                    CommittedShares := 0;

                // Update Committed Shares if applicable
                if ObjLoanGuar."Committed Shares" <> CommittedShares then begin
                    ObjLoanGuar."Committed Shares" := CommittedShares;
                    ObjLoanGuar.Modify;
                end;

            until ObjLoanGuar.Next = 0;
        end;
    end;

    procedure CalcCommittedShares(ApprovedAmt: Decimal; Outstanding: Decimal; Guaranteed: Decimal): Decimal
    begin
        if ApprovedAmt > 0 then
            exit(Round((Outstanding / ApprovedAmt) * Guaranteed, 1, '>'))
        else
            exit(0);
    end;

    procedure FormatLoanProduct(LoanProduct: Text): Text
    begin
        if StrLen(LoanProduct) > 0 then
            exit(UpperCase(CopyStr(LoanProduct, 1, 1)) + LowerCase(CopyStr(LoanProduct, 2)))
        else
            exit('');
    end;
}
