#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 56598 InsiderN
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/InsiderN.rdlc';

    dataset
    {
        dataitem("Supervisory$Board$Empl"; "Supervisory$Board$Empl")
        {
            RequestFilterFields = "Member No";
            column(ReportForNavId_35; 35)
            {
            }
            column(Positioninsociety_SaccoInsiders; "Supervisory$Board$Empl"."Position held")
            {
            }
            dataitem(Customer; Customer)
            {
                DataItemLink = "No." = field("Member No");
                column(ReportForNavId_36; 36)
                {
                }
                column(CurrentShares_MembersRegister; Customer."Current Shares")
                {
                }
                dataitem("Loans Register"; "Loans Register")
                {
                    DataItemLink = "Client Code" = field("No.");
                    DataItemTableView = where("Outstanding Balance" = filter(> 0));
                    column(ReportForNavId_1; 1)
                    {
                    }
                    column(StartDate; StartDate)
                    {
                    }
                    column(MStartDate; MStartDate)
                    {
                    }
                    column(MEndDate; MEndDate)
                    {
                    }
                    column(AsAt; AsAt)
                    {
                    }
                    column(EmplNme; EmplNme)
                    {
                    }
                    column(EmplNme1; EmplNme1)
                    {
                    }
                    column(LoanNo_LoansRegister; "Loans Register"."Loan  No.")
                    {
                    }
                    column(qwe; qwe)
                    {
                    }
                    column(EmplNmeboard; EmplNmeboard)
                    {
                    }
                    column(EmplNme1board; EmplNme1board)
                    {
                    }
                    column(LoanNo; LoanNo)
                    {
                    }
                    column(LoanNo1; LoanNo1)
                    {
                    }
                    column(LoanNo2; LoanNo2)
                    {
                    }
                    column(LoanNo3; LoanNo3)
                    {
                    }
                    column(InsiderBoard_LoansRegister; "Loans Register"."Insider-board")
                    {
                    }
                    column(insiderEmployee_LoansRegister; "Loans Register"."Insider-Employee")
                    {
                    }
                    column(t; T)
                    {
                    }
                    column(MEMBERNUMBER; MEMBERNUMBER)
                    {
                    }
                    column(POSITIONHELD; POSITIONHELD)
                    {
                    }
                    column(AMOUNTGRANTED; AMOUNTGRANTED)
                    {
                    }
                    column(DATEAPPROVED; DATEAPPROVED)
                    {
                    }
                    column(AMOUNTrequested; AMOUNT)
                    {
                    }
                    column(AMOUNTOFBOSADEPOSITS; AMOUNTOFBOSADEPOSITS)
                    {
                    }
                    column(NATUREOFSECURITY; NATUREOFSECURITY)
                    {
                    }
                    column(REPAYMENTCOMMENCEMENT; REPAYMENTCOMMENCEMENT)
                    {
                    }
                    column(REPAYMENTPERIOD; REPAYMENTPERIOD)
                    {
                    }
                    column(LOANTYPENAME; LOANTYPENAME)
                    {
                    }
                    column(OUTSTANDINGAMOUNT; OUTSTANDINGAMOUNT)
                    {
                    }
                    column(PERFORMANCE; PERFORMANCE)
                    {
                    }
                    column(LoansCategorySASRA_LoansRegister; "Loans Register"."Loans Category-SASRA")
                    {
                    }
                    column(name; CompanyProperty.DisplayName)
                    {
                    }
                    column(LoansCategory_LoansRegister; "Loans Register"."Loans Category")
                    {
                    }
                    column(SN; SN)
                    {
                    }
                    column(MemberName_LoansRegister; "Loans Register"."Client Name")
                    {
                    }
                    column(ClientCode_LoansRegister; "Loans Register"."Client Code")
                    {
                    }
                    column(LoanProductType_LoansRegister; "Loans Register"."Loan Product Type")
                    {
                    }
                    column(Installments_LoansRegister; "Loans Register".Installments)
                    {
                    }
                    column(RepaymentStartDate_LoansRegister; "Loans Register"."Repayment Start Date")
                    {
                    }
                    column(InstalmentPeriod_LoansRegister; "Loans Register".Installments)
                    {
                    }
                    column(RequestedAmount_LoansRegister; "Loans Register"."Requested Amount")
                    {
                    }
                    column(IssuedDate_LoansRegister; "Loans Register"."Issued Date")
                    {
                    }
                    column(LoanAmount_LoansRegister; "Loans Register"."Loan Amount")
                    {
                    }
                    column(ApprovedAmount_LoansRegister; "Loans Register"."Approved Amount")
                    {
                    }
                    column(OutstandingBalance_LoansRegister; "Loans Register"."Outstanding Balance")
                    {
                    }
                    column(LoanProductTypeName_LoansRegister; "Loans Register"."Loan Product Type Name")
                    {
                    }
                    column(Remarks_LoansRegister; "Loans Register".Remarks)
                    {
                    }
                    column(SectionFlag; SectionFlag)
                    { }
                    trigger OnAfterGetRecord()
                    begin


                        // Any loan issued after the period end doesn't belong on this report at all
                        // if (SectionFlag = 'A') and ("Loans Register"."Issued Date" > MEndDate) then begin
                        //     CurrReport.Skip();
                        if "Loans Register"."Issued Date" > MEndDate then
                            CurrReport.Skip();

                        if "Loans Register"."Issued Date" >= MStartDate then
                            SectionFlag := 'A'
                        else
                            SectionFlag := 'B';



                        // ── STEP 2: Common field calculations (unchanged from original) ──
                        qwe := '';
                        NATUREOFSECURITY := '';
                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", "Loans Register"."Loan  No.");
                        if LoanApp.Find('-') then begin
                            if LoanApp."Loan Product Type" = 'D315' then begin
                                //AMOUNT:=LoanApp."Loan Disbursed Amount";
                                AMOUNT := "Loans Register"."Loan Amount";
                            end else
                                AMOUNT := LoanApp."Approved Amount";
                        end;

                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", "Loans Register"."Loan  No.");
                        LoanApp.SetFilter(LoanApp."Date filter", '<=%1', MEndDate);
                        LoanApp.SetAutocalcFields("Outstanding Balance");
                        if LoanApp.Find('-') then begin
                            OUTSTANDINGAMOUNT := LoanApp."Outstanding Balance";
                        end;

                        LoansGuaranteeDetails.Reset;
                        LoansGuaranteeDetails.SetRange(LoansGuaranteeDetails."Loan No", LoanApp."Loan  No.");
                        LoansGuaranteeDetails.SetRange(LoansGuaranteeDetails."Loanees  No", LoanApp."Client Code");
                        if LoansGuaranteeDetails.Find('-') then begin
                            LoansGuaranteeDetails.CalcFields(LoanCount);
                            LoanCount := LoansGuaranteeDetails.LoanCount;
                        end;

                        LoansGuaranteeDetails.Reset;
                        LoansGuaranteeDetails.SetRange(LoansGuaranteeDetails."Loan No", "Loans Register"."Loan  No.");
                        //LoansGuaranteeDetails.SETRANGE(LoansGuaranteeDetails."Loanees  No","Loans Register"."Client Code");
                        if LoansGuaranteeDetails.FindFirst then begin
                            LoansGuaranteeDetails.CalcFields(LoanCount);

                            if (LoansGuaranteeDetails.LoanCount = 1) and (LoansGuaranteeDetails."Self Guarantee" = true) then
                                NATUREOFSECURITY := 'Deposits'
                            else
                                NATUREOFSECURITY := 'Guarantors'
                            // IF (LoansGuaranteeDetails.LoanCount > 1)  AND (LoansGuaranteeDetails."Self Guarantee"= FALSE) THEN BEGIN
                            //      NATUREOFSECURITY:='Guarantors'
                            //  END ELSE IF (LoansGuaranteeDetails.LoanCount > 1) AND (LoansGuaranteeDetails."Self Guarantee" = TRUE) THEN BEGIN
                            //      NATUREOFSECURITY:='Guarantors/deposits'
                            // END;
                        end;
                        LoanCollateralDetails.Reset;
                        LoanCollateralDetails.SetRange(LoanCollateralDetails."Loan No", "Loans Register"."Loan  No.");
                        if LoanCollateralDetails.FindFirst then begin
                            NATUREOFSECURITY := 'Collateral'
                        end;
                        if NATUREOFSECURITY = '' then begin
                            NATUREOFSECURITY := 'Deposits';
                        end;

                        // ── STEP 3: Section-specific handling ──
                        if SectionFlag = 'A' then begin
                            // Section A: loans issued/approved within the selected period. Any type.
                            // No merging — every loan issued in-period prints as its own row.
                            SNA += 1;
                            SN := SNA;
                        end else begin
                            // Section B (loans issued before this period) is scoped to Normal loans only —
                            // any product whose name starts with "Normal" (Normal Loan 1, 2, 3, 4, ...).
                            // All of a member's Normal loans are folded into the earliest-dated one, which
                            // prints as a single combined row labelled just "Normal Loan".
                            IsNormalLoan := "Loans Register"."Loan Product Type Name".StartsWith('Normal');
                            if not IsNormalLoan then begin
                                CurrReport.Skip();
                                exit;
                            end;

                            IsPrimaryNormalLoan := true;
                            OtherNormalLoan.Reset();
                            OtherNormalLoan.SetRange("Client Code", "Loans Register"."Client Code");
                            OtherNormalLoan.SetRange("Issued Date", 0D, CalcDate('<-1D>', MStartDate));
                            if OtherNormalLoan.FindSet() then
                                repeat
                                    if (OtherNormalLoan."Loan  No." <> "Loans Register"."Loan  No.") and
                                       OtherNormalLoan."Loan Product Type Name".StartsWith('Normal') and
                                       (GetLoanOutstandingAsAt(OtherNormalLoan."Loan  No.", MEndDate) > 0)
                                    then
                                        if (OtherNormalLoan."Issued Date" < "Loans Register"."Issued Date") or
                                           ((OtherNormalLoan."Issued Date" = "Loans Register"."Issued Date") and
                                            (OtherNormalLoan."Loan  No." < "Loans Register"."Loan  No."))
                                        then
                                            IsPrimaryNormalLoan := false
                                        else begin
                                            "Loans Register"."Requested Amount" += OtherNormalLoan."Requested Amount";
                                            AMOUNT += GetLoanApprovedAmount(OtherNormalLoan);
                                            OUTSTANDINGAMOUNT += GetLoanOutstandingAsAt(OtherNormalLoan."Loan  No.", MEndDate);
                                        end;
                                until OtherNormalLoan.Next() = 0;

                            if not IsPrimaryNormalLoan then begin
                                CurrReport.Skip();
                                exit;
                            end;

                            "Loans Register"."Loan Product Type Name" := CopyStr('Normal Loan', 1, MaxStrLen("Loans Register"."Loan Product Type Name"));
                            SNB += 1;
                            SN := SNB;
                        end;
                    end;

                    trigger OnPreDataItem()
                    begin
                        "Loans Register".SetFilter("Loans Register"."Date filter", '<=%1', MEndDate);
                        //"Loans Register".SETFILTER("Loans Register"."Date filter",NEWLoanFilter);
                    end;
                }
            }
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(MStartDate; MStartDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Start Date';
                }
                field(MEndDate; MEndDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'End Date';
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        MStartDate := CalcDate('-CM', WorkDate());
        MEndDate := CalcDate('CM', WorkDate());
    end;

    trigger OnPreReport()
    begin
        if MStartDate = 0D then
            Error('Please enter a Start Date.');
        if MEndDate = 0D then
            Error('Please enter an End Date.');
        if MStartDate > MEndDate then
            Error('Start Date must not be after End Date.');

        StartDate := CalcDate('-CY', MStartDate);
        NEWLoanFilter := Format(MStartDate) + '..' + Format(MEndDate);
        //MESSAGE('%1',NEWLoanFilter);
        OldLoanFilter := '..' + Format(MStartDate);
        CompanyInformation.Get();
    end;

    local procedure GetLoanApprovedAmount(LoanRec: Record "Loans Register"): Decimal
    begin
        if LoanRec."Loan Product Type" = 'D315' then
            exit(LoanRec."Loan Amount");
        exit(LoanRec."Approved Amount");
    end;

    local procedure GetLoanOutstandingAsAt(LoanNo: Code[30]; AsAtDate: Date): Decimal
    var
        LoanRec: Record "Loans Register";
    begin
        LoanRec.Reset();
        LoanRec.SetRange("Loan  No.", LoanNo);
        LoanRec.SetFilter("Date filter", '<=%1', AsAtDate);
        LoanRec.SetAutoCalcFields("Outstanding Balance");
        if LoanRec.FindFirst() then
            exit(LoanRec."Outstanding Balance");
        exit(0);
    end;

    var
        StartDate: Date;
        LoansGuaranteeDetails: Record "Loans Guarantee Details";
        LoanCollateralDetails: Record "Loan Collateral Details";
        LoanCount: Integer;
        MStartDate: Date;
        MEndDate: Date;
        NEWLoanFilter: Text;
        OldLoanFilter: Text;
        AsAt: Date;
        LoanApp: Record "Loans Register";
        EmplNme: Text;
        EmplNme1: Text[50];
        // MembersRegister: Record UnknownRecord51516364;
        LoansRegister: Record "Loans Register";
        qwe: Text[50];
        EmplNmeboard: Text;
        EmplNme1board: Text;
        LoanNo: Code[20];
        LoanNo1: Code[20];
        LoanNo2: Code[20];
        LoanNo3: Code[20];
        T: Boolean;
        F: Boolean;
        MEMBERNUMBER: Code[30];
        POSITIONHELD: Text;
        LOANTYPENAME: Text;
        AMOUNT: Decimal;
        AMOUNTGRANTED: Decimal;
        DATEAPPROVED: Date;
        AMOUNTOFBOSADEPOSITS: Decimal;
        NATUREOFSECURITY: Text;
        REPAYMENTCOMMENCEMENT: Date;
        REPAYMENTPERIOD: DateFormula;
        OUTSTANDINGAMOUNT: Decimal;
        PERFORMANCE: Text;
        SN: Integer;
        SNA: Integer;
        SNB: Integer;
        "Insider-Board": Boolean;
        CompanyInformation: Record "Company Information";
        OtherNormalLoan: Record "Loans Register";
        IsNormalLoan: Boolean;
        IsPrimaryNormalLoan: Boolean;
        SectionFlag: Text[1];
    // LoansGuaranteeDetails: Record UnknownRecord51516372;
    // LoanCollateralDetails: Record UnknownRecord51516374;
}