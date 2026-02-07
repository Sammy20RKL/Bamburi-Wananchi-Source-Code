#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51045 "monthly exp Bamburi"
{
    RDLCLayout = './Layouts/monthlyexpbamburi.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.";
            DataItemTableView = sorting("No.") where(Status = const(Active));
            column(Name; Customer.Name)
            {
            }
            column(No; Customer."No.")
            {
            }
            column(ShareCapital; ShareCapital)
            {
            }
            column(DevP; DevP)
            {
            }
            column(Devint; Devint)
            {
            }
            column(montlycon; montlycon)
            {
            }
            column(Devint1; Devint1)
            {
            }
            column(DevP1; DevP1)
            {
            }
            column(EMERGENCYp; EMERGENCYp)
            {
            }
            column(EMERGENCYINTEREST; EMERGENCYi)
            {
            }
            column(SUPEREMERGENCYPRINCIPAL; SUPEREMERGENCYp)
            {
            }
            column(SUPEREMERGENCYINTEREST; SUPEREMERGENCYi)
            {
            }
            column(QUICKLOANPRINCIPAL; QUICKLOANp)
            {
            }
            column(QUICKLOANINTEREST; QUICKLOANi)
            {
            }
            column(SUPERQUICKPRINCIPAL; SUPERQUICKp)
            {
            }
            column(SUPERQUICKINTEREST; SUPERQUICKi)
            {
            }
            column(SCHOOLFEESPRINCIPAL; SCHOOLFEESp)
            {
            }
            column(SCHOOLFEESINTEREST; SCHOOLFEESi)
            {
            }
            column(SUPERSCHOOLFEESPRINCIPAL; SUPERSCHOOLFEESp)
            {
            }
            column(SUPERSCHOOLFEESINTEREST; SUPERSCHOOLFEESi)
            {
            }
            column(INVESTMENTLOANPRINCIPAL; INVESTMENTLOANp)
            {
            }
            column(INVESTMENTLOANINTEREST; INVESTMENTLOANi)
            {
            }
            column(CIName; CI.Name)
            {
            }
            column(CIAddress; CI.Address)
            {
            }
            column(CIPicture; CI.Picture)
            {
            }
            column(PersonalNo_MemberRegister; Customer."Personal No")
            {
            }
            column(NORMALLOANp; NORMALLOANp)
            {
            }
            column(NORMALLOANi; NORMALLOANi)
            {
            }
            column(NORMALLOAN1p; NORMALLOAN1p)
            {
            }
            column(HolidayContribution_MemberRegister; Customer."Holiday Contribution")
            {
            }
            column(Welfare_Contr; "Welfare Contr")
            {
            }
            column(DevelopmentLoanP; DevelopmentLoanP)
            {
            }
            column(DevelopmentLoanInt; DevelopmentLoanInt)
            {
            }
            column(MERCHANDISEPr; MERCHANDISEPr)
            {
            }
            column(MERCHANDISEIn; MERCHANDISEIn)
            {
            }
            trigger OnPreDataItem();
            begin
                //ReportForNav.OnPreDataItem('Customer',Customer);
            end;

            trigger OnAfterGetRecord();
            begin
                CI.Get();
                CI.CalcFields(Picture);

                ShareCapital := 0;
                // --- 1. Share Capital ---
                Customer.CalcFields("Shares Retained");
                if Customer."Shares Retained" >= 15000 then
                    ShareCapital := 0
                else if Customer."Shares Retained" >= 5000 then
                    ShareCapital := 417
                else
                    ShareCapital := 1000;

                BeginMonth_Date := CalcDate('<-CM +14D>', ASAT);

                montlycon := Customer."Monthly Contribution";
                "Welfare Contr" := Customer."Welfare Contr";

                // EMERGENCY
                CalculateLoanRepayment('12', EMERGENCYp, EMERGENCYi, Customer."No.", ASAT, BeginMonth_Date);

                // SUPER EMERGENCY LOAN                
                CalculateLoanRepayment('13', SUPEREMERGENCYp, SUPEREMERGENCYi, Customer."No.", ASAT, BeginMonth_Date);

                //QUICK LOAN	
                CalculateLoanRepayment('15', QUICKLOANp, QUICKLOANi, Customer."No.", ASAT, BeginMonth_Date);

                // SUPER QUICK start

                CalculateLoanRepayment('16', SUPERQUICKp, SUPERQUICKi, Customer."No.", ASAT, BeginMonth_Date);

                //SCHOOL FEES	
                CalculateLoanRepayment('17', SCHOOLFEESp, SCHOOLFEESi, Customer."No.", ASAT, BeginMonth_Date);

                //SUPER SCHOOL FEE
                CalculateLoanRepayment('18', SUPERSCHOOLFEESp, SUPERSCHOOLFEESi, Customer."No.", ASAT, BeginMonth_Date);

                // Investment loans
                CalculateLoanRepayment('19', INVESTMENTLOANp, INVESTMENTLOANi, Customer."No.", ASAT, BeginMonth_Date);

                // DEVELOPMENT
                CalculateLoanRepayment('20', DevP, Devint, Customer."No.", ASAT, BeginMonth_Date);

                // Normal loans
                CalculateLoanRepayment('21', NORMALLOANp, NORMALLOANi, Customer."No.", ASAT, BeginMonth_Date);

                // DEVELOPMENT 1
                CalculateLoanRepayment('23', DevP1, Devint1, Customer."No.", ASAT, BeginMonth_Date);

                //Development NORMAL 1 LOAN start==========================================================================================================================================
                CalculateLoanRepayment('25', DevelopmentLoanP, DevelopmentLoanInt, Customer."No.", ASAT, BeginMonth_Date);

                //NORMAL 1 LOAN start
                CalculateLoanRepayment('22', NORMALLOAN1p, NORMALLOAN1i, Customer."No.", ASAT, BeginMonth_Date);

                //MERCHANDISE
                CalculateLoanRepayment('26', MERCHANDISEPr, MERCHANDISEIn, Customer."No.", ASAT, BeginMonth_Date);


                //....................................................................................
                ////......................................loan
                LoansRegister.Reset;
                LoansRegister.SetRange("Client Code", Customer."No.");
                LoansRegister.SetRange("Loan Product Type", '25');
                LoansRegister.SetAutocalcFields(LoansRegister."Outstanding Balance", LoansRegister."Oustanding Interest");
                LoansRegister.SetRange(LoansRegister.Posted, true);
                // LoansRegister.SETRANGE(LoansRegister."Issued Date",ASAT);
                LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
                if LoansRegister.FindSet then begin
                    developmentLoan_No := LoansRegister."Loan  No.";
                    if LoansRegister."Loan  No." = '' then
                        CurrReport.Skip;
                end;
                ///.........
                LoansRegister.Reset;
                LoansRegister.SetRange("Client Code", Customer."No.");
                LoansRegister.SetRange("Loan Product Type", '22');
                // LoansRegister.SETRANGE(LoansRegister."Issued Date",ASAT);
                LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
                if LoansRegister.FindSet then begin
                    NORMALLOAN1LNO := LoansRegister."Loan  No.";
                    if LoansRegister."Loan  No." = '' then
                        CurrReport.Skip;
                end;
                ////.......................................
                LoansRegister.Reset;
                LoansRegister.SetRange("Client Code", Customer."No.");
                LoansRegister.SetRange("Loan Product Type", '21');
                // LoansRegister.SETRANGE(LoansRegister."Issued Date",ASAT);
                LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
                if LoansRegister.FindSet then begin
                    NORMALLOANLNO := LoansRegister."Loan  No.";
                    if LoansRegister."Loan  No." = '' then
                        CurrReport.Skip;
                end;
                ///..............................................
                LoansRegister.Reset;
                LoansRegister.SetRange("Client Code", Customer."No.");
                LoansRegister.SetRange("Loan Product Type", '19');
                // LoansRegister.SETRANGE(LoansRegister."Issued Date",ASAT);
                LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
                if LoansRegister.FindSet then begin
                    INVESTMENTLOANLNO := LoansRegister."Loan  No.";
                    if LoansRegister."Loan  No." = '' then
                        CurrReport.Skip;
                end;
                //.............................................
                LoansRegister.Reset;
                LoansRegister.SetRange("Client Code", Customer."No.");
                LoansRegister.SetRange("Loan Product Type", '18');
                // LoansRegister.SETRANGE(LoansRegister."Issued Date",ASAT);
                LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
                if LoansRegister.FindSet then begin
                    SUPERSCHOOLFEESLNO := LoansRegister."Loan  No.";
                    if LoansRegister."Loan  No." = '' then
                        CurrReport.Skip;
                end;
                //............................
                LoansRegister.Reset;
                LoansRegister.SetRange("Client Code", Customer."No.");
                LoansRegister.SetRange("Loan Product Type", '17');
                LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
                if LoansRegister.FindSet then begin
                    SCHOOLFEESLNNO := LoansRegister."Loan  No.";
                    if LoansRegister."Loan  No." = '' then
                        CurrReport.Skip;
                end;
                //..............
                LoansRegister.Reset;
                LoansRegister.SetRange("Client Code", Customer."No.");
                LoansRegister.SetRange("Loan Product Type", '16');
                LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
                if LoansRegister.FindSet then begin
                    SUPERQUICKLNO := LoansRegister."Loan  No.";
                    if LoansRegister."Loan  No." = '' then
                        CurrReport.Skip;
                end;
                //.......................
                LoansRegister.Reset;
                LoansRegister.SetRange("Client Code", Customer."No.");
                LoansRegister.SetRange("Loan Product Type", '15');
                LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
                if LoansRegister.FindSet then begin
                    QUICKLOANNO := LoansRegister."Loan  No.";
                    if LoansRegister."Loan  No." = '' then
                        CurrReport.Skip;
                end;
                //..............................
                LoansRegister.Reset;
                LoansRegister.SetRange("Client Code", Customer."No.");
                LoansRegister.SetRange("Loan Product Type", '13');
                LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
                if LoansRegister.FindSet then begin
                    SUPEREMERGENCYLNO := LoansRegister."Loan  No.";
                    if LoansRegister."Loan  No." = '' then
                        CurrReport.Skip;
                end;
                //////////////.............................
                LoansRegister.Reset;
                LoansRegister.SetRange("Client Code", Customer."No.");
                LoansRegister.SetRange("Loan Product Type", '12');
                LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
                if LoansRegister.FindSet then begin
                    EMERGENCYLNO := LoansRegister."Loan  No.";
                    if LoansRegister."Loan  No." = '' then
                        CurrReport.Skip;
                end;
                //..........................
                LoansRegister.Reset;
                LoansRegister.SetRange("Client Code", Customer."No.");
                LoansRegister.SetRange("Loan Product Type", '23');
                LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
                if LoansRegister.FindSet then begin
                    if LoansRegister."Loan  No." = '' then
                        CurrReport.Skip;
                    inDev1 := LoansRegister."Loan  No.";
                end;
                //.................LoansRegister.RESET;
                LoansRegister.SetRange("Client Code", Customer."No.");
                LoansRegister.SetRange("Loan Product Type", '20');
                LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
                if LoansRegister.FindSet then begin
                    lndev := LoansRegister."Loan  No.";
                    if LoansRegister."Loan  No." = '' then
                        CurrReport.Skip;
                end;
                LoansRegister.SetRange("Client Code", Customer."No.");
                LoansRegister.SetRange("Loan Product Type", '26');
                LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
                if LoansRegister.FindSet then begin
                    MERCHANDISE_No := LoansRegister."Loan  No.";
                    if LoansRegister."Loan  No." = '' then
                        CurrReport.Skip;
                end;
                TOTALREMMITANCE := 0;
                TOTALREMMITANCE := montlycon + "Welfare Contr" + ShareCapital + NORMALLOAN1i + NORMALLOANp + NORMALLOANi + NORMALLOAN1p + EMERGENCYp + EMERGENCYi + SUPEREMERGENCYp + SUPEREMERGENCYi + QUICKLOANp + QUICKLOANi + SUPERQUICKp + SUPERQUICKi + SCHOOLFEESp + SCHOOLFEESi + SUPERSCHOOLFEESp + SUPERSCHOOLFEESi +
                INVESTMENTLOANi + DevP + Devint + DevelopmentLoanP + DevelopmentLoanInt + MERCHANDISEPr + MERCHANDISEIn;
            end;

        }
    }
    requestpage
    {
        SaveValues = false;
        layout
        {
            area(Content)
            {
                field(Date; ASAT)
                {
                    ApplicationArea = Basic;
                    Caption = 'Date';
                }
            }
        }

    }
    var
        EndMonth_Date: Date;
        BeginMonth_Date: Date;
        ASAT: Date;
        LoansRegister: Record "Loans Register";
        ShareCapital: Decimal;
        DevP: Decimal;
        DevLNO: Code[20];
        Devint: Decimal;
        montlycon: Decimal;
        lndev: Code[30];
        EMERGENCYp: Decimal;
        EMERGENCYi: Decimal;
        EMERGENCYLNO: Code[20];
        EMERGENCYlnb: Code[30];
        SUPEREMERGENCYLNO: Code[20];
        SUPEREMERGENCYp: Decimal;
        SUPEREMERGENCYi: Decimal;
        QUICKLOANNO: Code[20];
        QUICKLOANp: Decimal;
        QUICKLOANi: Decimal;
        SUPERQUICKLNO: Code[20];
        SUPERQUICKp: Decimal;
        SUPERQUICKi: Decimal;
        SCHOOLFEESLNNO: Code[20];
        SCHOOLFEESp: Decimal;
        SCHOOLFEESi: Decimal;
        SUPERSCHOOLFEESLNO: Code[20];
        SUPERSCHOOLFEESp: Decimal;
        SUPERSCHOOLFEESi: Decimal;
        INVESTMENTLOANLNO: Code[20];
        INVESTMENTLOANp: Decimal;
        INVESTMENTLOANi: Decimal;
        TOTALREMMITANCE: Decimal;
        CI: Record "Company Information";
        NORMALLOANLNO: Code[20];
        NORMALLOANp: Decimal;
        NORMALLOANi: Decimal;
        NORMALLOAN1LNO: Code[20];
        NORMALLOAN1p: Decimal;
        NORMALLOAN1i: Decimal;
        DevP1LNO: Code[20];
        DevP1: Decimal;
        Devint1: Decimal;
        inDev1: Code[50];
        LoanRepaymentSchedule: Record "Loan Repayment Schedule";
        DevelopmentLoanP: Decimal;
        DevelopmentLoanInt: Decimal;
        developmentLoan_No: Code[20];
        TotalMRepay: Decimal;
        MERCHANDISEPr: Decimal;
        MERCHANDISEIn: Decimal;
        MERCHANDISE_No: Code[20];
        SwizzFactory: Codeunit "Swizzsoft Factory";

    // trigger OnInitReport();
    // begin
    //     ;
    //     ReportsForNavInit;
    // end;

    // trigger OnPreReport();
    // begin
    //     ;
    //     ReportsForNavPre;
    // end;

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    var
        ReportForNavTotalsCausedBy: Integer;
        ReportForNavInitialized: Boolean;
        ReportForNavShowOutput: Boolean;

    procedure CalculateLoanRepayment_OldNew(
                                    LoanProductType: Code[10];
                                    var Principal: Decimal;
                                    var Interest: Decimal;
                                    CustomerNo: Code[20];
                                    ASAT: Date;
                                    BeginMonthDate: Date
                                    )
    var
        LoansRegister: Record "Loans Register";
        LoanRepaymentSchedule: Record "Loan Repayment Schedule";
    begin
        Principal := 0;
        Interest := 0;

        LoansRegister.Reset;
        LoansRegister.SetRange("Client Code", CustomerNo);
        LoansRegister.SetRange("Loan Product Type", LoanProductType);
        LoansRegister.SetAutocalcFields(LoansRegister."Outstanding Balance", LoansRegister."Oustanding Interest");
        LoansRegister.SetRange(LoansRegister.Posted, true);
        LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
        LoansRegister.SetCurrentKey("Client Code", "Application Date");
        LoansRegister.Ascending(false); // Descending order by Application Date

        if LoansRegister.FindSet then begin
            LoansRegister.CalcFields("Outstanding Balance", "Oustanding Interest", "Interest Due");
            //SwizzFactory.FnGenerateRepaymentSchedule(LoansRegister."Loan  No.");

            if LoansRegister."Expected Date of Completion" <= ASAT then begin
                // Loan supposed to be fully paid – just clear balance + interest
                Principal := ROUND(LoansRegister."Outstanding Balance", 1, '>');
                Interest := ROUND(LoansRegister."Oustanding Interest", 1, '>');
                exit;
            end else if LoansRegister."Loan Disbursement Date" < BeginMonthDate then begin
                LoanRepaymentSchedule.Reset;
                LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
                LoanRepaymentSchedule.SetFilter("Repayment Date", '%1..%2', ASAT, CalcDate('CM', ASAT));
                if LoanRepaymentSchedule.Find('-') then begin
                    Interest := ROUND(LoansRegister."Oustanding Interest", 1, '>');
                    if LoanRepaymentSchedule."Principal Repayment" < LoansRegister."Outstanding Balance" then
                        Interest := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
                    if LoanRepaymentSchedule."Principal Repayment" > LoansRegister."Outstanding Balance" then
                        Principal := ROUND(LoansRegister."Outstanding Balance", 1, '>')
                    else
                        Principal := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');

                end;
            end else begin
                LoanRepaymentSchedule.Reset;
                LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
                LoanRepaymentSchedule.SetFilter(LoanRepaymentSchedule."Repayment Date", '%1..%2', ASAT, CalcDate('CM', ASAT));

                if LoanRepaymentSchedule.FindLast then begin
                    if LoanRepaymentSchedule."Principal Repayment" > LoansRegister."Outstanding Balance" then
                        Principal := ROUND(LoansRegister."Outstanding Balance", 1, '>')
                    else
                        Principal := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');

                    Interest := ROUND(LoansRegister."Oustanding Interest", 1, '>');
                    if LoanRepaymentSchedule."Principal Repayment" < LoansRegister."Outstanding Balance" then
                        Interest := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
                end;
            end;
        end;
    end;

    //New Calculations... look here 23/09/25 - Festus
    procedure CalculateLoanRepayment(
    LoanProductType: Code[10];
    var Principal: Decimal;
    var Interest: Decimal;
    CustomerNo: Code[20];
    ASAT: Date;
    BeginMonthDate: Date
)
    var
        LoansRegister: Record "Loans Register";
        LoanRepaymentSchedule: Record "Loan Repayment Schedule";
    begin
        Principal := 0;
        Interest := 0;

        LoansRegister.Reset;
        LoansRegister.SetRange("Client Code", CustomerNo);
        LoansRegister.SetRange("Loan Product Type", LoanProductType);
        LoansRegister.SetRange(Posted, true);
        LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
        LoansRegister.SetAutoCalcFields("Outstanding Balance", "Oustanding Interest");
        LoansRegister.SetCurrentKey("Client Code", "Application Date");
        LoansRegister.SetFilter("Repayment Start Date", '..%1', ASAT);
        LoansRegister.Ascending(false); // latest loans first

        if not LoansRegister.FindSet() then
            exit;

        LoansRegister.CalcFields("Outstanding Balance", "Oustanding Interest", "Interest Due");

        // 2. Otherwise, try to find schedule entries within this month
        LoanRepaymentSchedule.Reset;
        LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
        LoanRepaymentSchedule.SetRange("Repayment Date", BeginMonthDate, ASAT);
        LoanRepaymentSchedule.SetFilter(LoanRepaymentSchedule."Repayment Date", '%1..%2', ASAT, CalcDate('CM', ASAT));

        if LoanRepaymentSchedule.FindLast() then begin
            // --- Calculate Principal ---
            if LoanRepaymentSchedule."Principal Repayment" > LoansRegister."Outstanding Balance" then
                Principal := ROUND(LoansRegister."Outstanding Balance", 1, '>')
            else
                Principal := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');

            // --- Calculate Interest ---
            if LoanRepaymentSchedule."Principal Repayment" < LoansRegister."Outstanding Balance" then
                Interest := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>')
            else
                Interest := ROUND(LoansRegister."Oustanding Interest", 1, '>');
        end else begin
            // No schedule found → fallback to balances
            Principal := ROUND(LoansRegister."Outstanding Balance", 1, '>');
            Interest := ROUND(LoansRegister."Oustanding Interest", 1, '>');

            LoanRepaymentSchedule.Reset();
            LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
            // LoanRepaymentSchedule.SetRange("Repayment Date", BeginMonthDate, ASAT);
            if LoanRepaymentSchedule.FindLast() then begin
                // --- Calculate Principal ---
                if LoanRepaymentSchedule."Principal Repayment" > LoansRegister."Outstanding Balance" then
                    Principal := ROUND(LoansRegister."Outstanding Balance", 1, '>')
                else
                    Principal := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');

                // --- Calculate Interest ---
                if LoanRepaymentSchedule."Principal Repayment" < LoansRegister."Outstanding Balance" then
                    // Interest := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>')
                    Interest := ROUND(LoansRegister."Approved Amount" * (LoansRegister.Interest / 1200), 1, '>')
                else
                    Interest := ROUND(LoansRegister."Oustanding Interest", 1, '>');
            end;
        end;
    end;


}
