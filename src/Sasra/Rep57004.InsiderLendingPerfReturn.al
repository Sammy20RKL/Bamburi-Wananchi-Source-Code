#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 57004 "Insider Lending & Perf Return"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Insider Lending & Perf Return.rdlc';
    UsageCategory = ReportsandAnalysis;

    dataset
    {
#pragma warning disable AL0275
        dataitem(Company; "Company Information")
#pragma warning restore AL0275
        {
            column(ReportForNavId_1120054004; 1120054004)
            {
            }
            column(name; Company.Name)
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
        }

        dataitem("Members Register"; Customer)
        {
            Requestfilterfields = "No.";

            dataitem("Loans Register"; "Loans Register")
            {
                CalcFields = "Outstanding Balance";
                DataItemLink = "Client Code" = field("No.");
                DataItemTableView = where("Outstanding Balance" = filter(> 0), "Insider-board" = filter(true), "Loan Product Type" = filter(<> 'MAKEOVER'));
                column(ReportForNavId_1; 1)
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

                column(insiderEmployee_LoansRegister; "Loans Register".NSSF)
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
                column(LoansCategory_LoansRegister; "Loans Register"."Loans Category-SASRA")
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
                column(InstalmentPeriod_LoansRegister; "Loans Register"."Instalment Period")
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
                column(BoardPosition; BoardPosition)
                {
                }
                column(CurrentShares; CurrentShares)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    qwe := '';
                    NATUREOFSECURITY := '';
                    LoanApp.Reset;
                    LoanApp.SetRange(LoanApp."Loan  No.", "Loans Register"."Loan  No.");
                    if LoanApp.Find('-') then begin
                        AMOUNT := LoanApp."Approved Amount";
                    end;

                    LoanApp.Reset;
                    LoanApp.SetRange(LoanApp."Loan  No.", "Loans Register"."Loan  No.");
                    LoanApp.SetFilter(LoanApp."Date filter", '<=%1', AsAt);
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


                    Insiders.Reset;
                    Insiders.SetRange(Insiders.MemberNo, "Loans Register"."Client Code");
                    if Insiders.FindFirst then begin
                        BoardPosition := Insiders."Position in society";
                    end;
                    CurrentShares := 0;
                    MembersR.Reset;
                    MembersR.SetRange(MembersR."No.", "Loans Register"."Client Code");
                    if MembersR.FindFirst then begin
                        MembersR.CalcFields(MembersR."Current Shares");
                        CurrentShares := MembersR."Current Shares";
                    end;
                end;

                trigger OnPreDataItem()
                begin
                    "Loans Register".SetFilter("Loans Register"."Issued Date", '<%1', MStartDate);
                end;
            }
            dataitem(Lregister; "Loans Register")
            {
                CalcFields = "Outstanding Balance";
                DataItemLink = "Client Code" = field("No.");
                DataItemTableView = where("Outstanding Balance" = filter(> 0), "Insider-Employee" = filter(true), "Loan Product Type" = filter(<> 'MAKEOVER'));
                column(ReportForNavId_1120054042; 1120054042)
                {
                }
                column(LEmplNme; EmplNme)
                {
                }
                column(LEmplNme1; EmplNme1)
                {
                }
                column(LLoanNo_LoansRegister; "Loans Register"."Loan  No.")
                {
                }
                column(Lqwe; qwe)
                {
                }
                column(LEmplNmeboard; EmplNmeboard)
                {
                }
                column(LEmplNme1board; EmplNme1board)
                {
                }
                column(LLoanNo; LoanNo)
                {
                }
                column(LLoanNo1; LoanNo1)
                {
                }
                column(LLoanNo2; LoanNo2)
                {
                }
                column(LLoanNo3; LoanNo3)
                {
                }

                column(LinsiderEmployee_LoansRegister; "Loans Register".NSSF)
                {
                }
                column(Lt; T)
                {
                }
                column(LMEMBERNUMBER; MEMBERNUMBER)
                {
                }
                column(LPOSITIONHELD; POSITIONHELD)
                {
                }
                column(LAMOUNTGRANTED; AMOUNTGRANTED)
                {
                }
                column(LDATEAPPROVED; DATEAPPROVED)
                {
                }
                column(LAMOUNTrequested; AMOUNT)
                {
                }
                column(LAMOUNTOFBOSADEPOSITS; AMOUNTOFBOSADEPOSITS)
                {
                }
                column(LNATUREOFSECURITY; NATUREOFSECURITYS)
                {
                }
                column(LREPAYMENTCOMMENCEMENT; REPAYMENTCOMMENCEMENT)
                {
                }
                column(LREPAYMENTPERIOD; REPAYMENTPERIOD)
                {
                }
                column(LLOANTYPENAME; LOANTYPENAME)
                {
                }
                column(LOUTSTANDINGAMOUNT; OUTSTANDINGAMOUNT)
                {
                }
                column(LPERFORMANCE; PERFORMANCE)
                {
                }
                column(LLoansCategorySASRA_LoansRegister; "Loans Register"."Loans Category-SASRA")
                {
                }
                column(LLoansCategory_LoansRegister; "Loans Register"."Loans Category-SASRA")
                {
                }
                column(LSN; SN)
                {
                }
                column(LMemberName_LoansRegister; "Loans Register"."Client Name")
                {
                }
                column(LClientCode_LoansRegister; "Loans Register"."Client Code")
                {
                }
                column(LLoanProductType_LoansRegister; "Loans Register"."Loan Product Type")
                {
                }
                column(LInstallments_LoansRegister; "Loans Register".Installments)
                {
                }
                column(LRepaymentStartDate_LoansRegister; "Loans Register"."Repayment Start Date")
                {
                }
                column(LInstalmentPeriod_LoansRegister; "Loans Register"."Instalment Period")
                {
                }
                column(LRequestedAmount_LoansRegister; "Loans Register"."Requested Amount")
                {
                }
                column(LIssuedDate_LoansRegister; "Loans Register"."Issued Date")
                {
                }
                column(LLoanAmount_LoansRegister; "Loans Register"."Loan Amount")
                {
                }
                column(LApprovedAmount_LoansRegister; "Loans Register"."Approved Amount")
                {
                }
                column(LOutstandingBalance_LoansRegister; "Loans Register"."Outstanding Balance")
                {
                }
                column(LLoanProductTypeName_LoansRegister; "Loans Register"."Loan Product Type Name")
                {
                }
                column(CurrentSharess; CurrentSharess)
                {
                }
                column(BoardPositions; BoardPositions)
                {
                }
                column(ApprovedAmount; ApprovedAmount)
                {
                }
                column(IssuedDate; IssuedDate)
                {
                }
                column(RepaymentStartDate; RepaymentStartDate)
                {
                }
                column(Period; Period)
                {
                }
                column(LoanName; LoanName)
                {
                }
                column(MemberName; MemberName)
                {
                }
                column(clientcode; clientcode)
                {
                }

                trigger OnAfterGetRecord()
                begin

                    qwe := '';
                    NATUREOFSECURITYS := '';
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
                    LoanApp.SetFilter(LoanApp."Date filter", '<=%1', AsAt);
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
                            NATUREOFSECURITYS := 'Deposits'
                        else
                            NATUREOFSECURITYS := 'Guarantors'
                        // IF (LoansGuaranteeDetails.LoanCount > 1)  AND (LoansGuaranteeDetails."Self Guarantee"= FALSE) THEN BEGIN
                        //      NATUREOFSECURITY:='Guarantors'
                        //  END ELSE IF (LoansGuaranteeDetails.LoanCount > 1) AND (LoansGuaranteeDetails."Self Guarantee" = TRUE) THEN BEGIN
                        //      NATUREOFSECURITY:='Guarantors/deposits'
                        // END;
                    end;
                    LoanCollateralDetails.Reset;
                    LoanCollateralDetails.SetRange(LoanCollateralDetails."Loan No", "Loans Register"."Loan  No.");
                    if LoanCollateralDetails.FindFirst then begin
                        NATUREOFSECURITYS := 'Collateral'
                    end;
                    if NATUREOFSECURITYS = '' then begin
                        NATUREOFSECURITYS := 'Deposits';
                    end;


                    Insiderss.Reset;
                    Insiderss.SetRange(Insiderss.MemberNo, Lregister."Client Code");
                    if Insiderss.FindFirst then begin
                        BoardPositions := Insiderss."Position in society";
                    end;
                    CurrentSharess := 0;
                    MembersRs.Reset;
                    MembersRs.SetRange(MembersRs."No.", Lregister."Client Code");
                    if MembersRs.FindFirst then begin
                        MembersRs.CalcFields(MembersRs."Current Shares");
                        CurrentSharess := MembersRs."Current Shares";
                    end;
                    ApprovedAmount := 0;
                    ApprovedAmount := Lregister."Approved Amount";
                    IssuedDate := Lregister."Issued Date";
                    RepaymentStartDate := Lregister."Repayment Start Date";
                    Period := Lregister.Installments;
                    LoanName := Lregister."Loan Product Type";
                    MemberName := Lregister."Client Name";
                    clientcode := Lregister."Client Code";
                end;

                trigger OnPreDataItem()
                begin
                    //Lregister.RESET;
                    Lregister.SetFilter(Lregister."Loan Disbursement Date", '>=%1', MStartDate);
                    //MESSAGE('Issued%1Start%2',Lregister."Issued Date",MStartDate);
                end;
            }
            trigger OnPreDataItem()
            begin
                StartDate := CalcDate('-CY', AsAt);
                MStartDate := CalcDate('-CM', AsAt);
                MEndDate := CalcDate('CM', AsAt);
                NEWLoanFilter := Format(MStartDate) + '..' + Format(MEndDate);
                OldLoanFilter := '..' + Format(MStartDate);
                //MESSAGE('Here%1',MStartDate);
            end;
        }

    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(AsAt; AsAt)
                {
                    ApplicationArea = Basic;
                    Caption = 'AsAt....';
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

    var
        StartDate: Date;
        LoanCount: Integer;
        MStartDate: Date;
        MEndDate: Date;
        NEWLoanFilter: Text;
        OldLoanFilter: Text;
        AsAt: Date;
        LoanApp: Record "Loans Register";
        EmplNme: Text;
        EmplNme1: Text[50];
        MembersRegister: Record Customer;
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
        "Insider-Board": Boolean;
        LoansGuaranteeDetails: Record "Loans Guarantee Details";
        LoanCollateralDetails: Record "Loan Collateral Details";
        Insiders: Record "Sacco Insiders";
        BoardPosition: Option ,Board,Staff;
        MembersR: Record Customer;
        CurrentShares: Decimal;
        Insiderss: Record "Sacco Insiders";
        BoardPositions: Option ,Board,Staff;
        MembersRs: Record Customer;
        CurrentSharess: Decimal;
        NATUREOFSECURITYS: Text;
        ApprovedAmount: Decimal;
        IssuedDate: Date;
        RepaymentStartDate: Date;
        Period: Integer;
        LoanName: Code[10];
        MemberName: Text[50];
        clientcode: Code[10];
}

