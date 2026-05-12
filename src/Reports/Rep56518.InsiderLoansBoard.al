#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 56518 "Insider Loans Board"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Insider Loans Board.rdlc';

    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            DataItemTableView = where("Outstanding Balance" = filter(> 0), "Insider-board" = filter(true));
            column(ReportForNavId_1; 1)
            {
            }
            column(CompanyName; CompanyInformation.Name)
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
            column(Insiderboard_LoansRegister; "Loans Register"."Insider-board")
            {
            }
            column(InsiderEmployee_LoansRegister; "Loans Register"."Insider-Employee")
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
            column(ClientCode_LoansRegister; "Loans Register"."Client Code")
            {
            }
            column(RequestedAmount_LoansRegister; "Loans Register"."Requested Amount")
            {
            }
            column(ApprovedAmount_LoansRegister; "Loans Register"."Approved Amount")
            {
            }
            column(ClientName_LoansRegister; "Loans Register"."Client Name")
            {
            }
            column(IssuedDate_LoansRegister; "Loans Register"."Issued Date")
            {
            }
            column(Installments_LoansRegister; "Loans Register".Installments)
            {
            }
            column(LoanProductTypeName_LoansRegister; "Loans Register"."Loan Product Type Name")
            {
            }
            column(OutstandingBalance_LoansRegister; "Loans Register"."Outstanding Balance")
            {
            }
            column(CurrentShares_LoansRegister; "Loans Register"."Current Shares")
            {
            }
            column(RepaymentStartDate_LoansRegister; "Loans Register"."Repayment Start Date")
            {
            }
            column(LoanDisbursementDate_LoansRegister; "Loans Register"."Loan Disbursement Date")
            {
            }

            trigger OnAfterGetRecord()
            begin
                POSITIONHELD := 'Board';
                MemberRegister.Reset;
                MemberRegister.SetRange(MemberRegister."No.", "Loans Register"."Client Code");
                MemberRegister.SetAutocalcFields("Current Shares");
                if MemberRegister.Find('-') then begin
                    AMOUNTOFBOSADEPOSITS := MemberRegister."Current Shares";
                end;

                // qwe:='';
                // T:=TRUE;
                // F:=FALSE;
                // AMOUNT:=0;
                // AMOUNTGRANTED:=0;
                // MEMBERNUMBER:='';
                // LoanNo1:='';
                // EmplNme1:='';
                // SN:=SN+1;
                // LoanApp.RESET;
                // LoanApp.SETRANGE(LoanApp."Loan  No.","Loan  No.");
                // LoanApp.SETRANGE(LoanApp."Client Code","Loans Register"."Client Code");
                // LoanApp.SETAUTOCALCFIELDS("Current Shares","Outstanding Balance");
                // IF LoanApp.FIND('-') THEN BEGIN
                // //IF ("Loans Register"."insider-Employee" =TRUE) OR  ("Loans Register"."Insider-Board" =TRUE) THEN BEGIN
                // IF "Loans Register"."Insider-Board" =TRUE  THEN  BEGIN
                // IF  (LoanApp."Issued Date" >=MStartDate) AND  (LoanApp."Issued Date"<=MEndDate) THEN
                // // IF  "Loans Register"."Issued Date" >=MStartDate THEN
                //  EmplNme:=LoanApp."Client Name";
                //  MEMBERNUMBER:=LoanApp."Client Code";
                //  POSITIONHELD:='Employee';
                //  AMOUNT:=LoanApp."Requested Amount";
                //  AMOUNTGRANTED:=LoanApp."Approved Amount";
                //  AMOUNTOFBOSADEPOSITS:=(LoanApp."Current Shares");
                //  DATEAPPROVED:=LoanApp."Issued Date";
                //  REPAYMENTCOMMENCEMENT:=LoanApp."Repayment Start Date";
                //  REPAYMENTPERIOD:=LoanApp."Instalment Period";
                //  LOANTYPENAME:=LoanApp."Loan Product Type Name";
                //
                // // LoanNo:="Loans Register"."Loan  No.";
                //  IF  LoanApp."Issued Date" < MStartDate THEN
                //    EmplNme1:=LoanApp."Client Name";
                //   LoanNo1:=LoanApp."Loan  No.";
                //   MEMBERNUMBER:=LoanApp."Client Code";
                //  POSITIONHELD:='Employee';
                //  AMOUNT:=LoanApp."Requested Amount";
                //  AMOUNTGRANTED:=LoanApp."Approved Amount";
                //  AMOUNTOFBOSADEPOSITS:=(LoanApp."Current Shares");
                //  DATEAPPROVED:=LoanApp."Issued Date";
                //  REPAYMENTCOMMENCEMENT:=LoanApp."Repayment Start Date";
                //  REPAYMENTPERIOD:=LoanApp."Instalment Period";
                //  LOANTYPENAME:=LoanApp."Loan Product Type Name";
                //  //PERFORMANCE:=LoanApp."Loans Category-SASRA";
                //  OUTSTANDINGAMOUNT:=LoanApp."Outstanding Balance";
                //    END ;
                // // // END ELSE BEGIN
                // // IF LoanApp."Insider-Board" =TRUE  THEN  BEGIN
                // // IF  (LoanApp."Issued Date" >=MStartDate) AND  (LoanApp."Issued Date"<=MEndDate) THEN
                // // // IF  "Loans Register"."Issued Date" >=MStartDate THEN
                // //     EmplNmeboard:=LoanApp."Client Name";
                // //     LoanNo2:=LoanApp."Loan  No.";
                // //  IF  LoanApp."Issued Date" < MStartDate THEN
                // //    EmplNme1board:=LoanApp."Client Name";
                // //  LoanNo3:=LoanApp."Loan  No.";
                // //   //END ;}
                // //  END;
                //
                //  END ELSE CurrReport.SKIP;
                // // LoanApp.RESET;
                // // LoanApp.SETRANGE(LoanApp."Loan  No.","Loan  No.");
                // // LoanApp.SETRANGE(LoanApp."insider-Employee",TRUE);
                // // //LoanApp.SETFILTER(LoanApp."Issued Date",NEWLoanFilter);
                // // IF   LoanApp.FIND('-') THEN BEGIN
                // //  // REPEAT
                // //  EmplNme:=LoanApp."Client Name";
                // //  LoanNo:=LoanApp."Loan  No.";
                // //  MESSAGE('%1|%2',EmplNme,LoanNo);
                // // // UNTIL LoanApp.NEXT = 0;
                // //
                // //  END ;
                //
                // // LoanApp.RESET;
                // // LoanApp.SETRANGE(LoanApp."Loan  No.");
                // //
                // // LoanApp.SETFILTER(LoanApp."Issued Date",OldLoanFilter);
                // // IF   LoanApp.FINDFIRST THEN BEGIN
                // //  REPEAT
                // // //  EmplNme1:=LoanApp."Client Name";
                // // //  MESSAGE('%1',EmplNme1);
                // //  UNTIL LoanApp.NEXT = 0;
                // //
                // //  END
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

    trigger OnPreReport()
    begin
        // StartDate:=CALCDATE('-CY',AsAt);
        // MStartDate:=CALCDATE('-CM',AsAt);
        // MEndDate:=CALCDATE('CM',AsAt);
        // NEWLoanFilter:=FORMAT(MStartDate)+'..'+FORMAT(MEndDate);
        // //MESSAGE('%1',NEWLoanFilter);
        // OldLoanFilter:='..'+FORMAT(MStartDate);
        CompanyInformation.Get;
    end;

    var
        StartDate: Date;
        MStartDate: Date;
        MEndDate: Date;
        NEWLoanFilter: Text;
        OldLoanFilter: Text;
        AsAt: Date;
        LoanApp: Record "Loans Register";
        EmplNme: Text;
        EmplNme1: Text[50];
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
        MemberRegister: Record Customer;
        CompanyInformation: Record "Company Information";
}

