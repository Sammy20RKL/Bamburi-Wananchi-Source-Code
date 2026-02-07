#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51455 "Loan Defaulter Sms"
{
    WordLayout = './Layouts/LoanDefaulterSm.docx';
    DefaultLayout = Word;

    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            CalcFields = "Outstanding Balance", "Last Pay Date";
            DataItemTableView = sorting("Loan  No.") where("Outstanding Balance" = filter(> 0));
            RequestFilterFields = "Client Code", "Loan  No.", "Loan Product Type";

            // column(Company_Letter_Head; Company.Letter_Head)
            // {
            // }
            column(Loans__Loan__No__; "Loan  No.")
            {
            }
            column(Loans__Client_Name_; "Client Name")
            {
            }
            column(ClientCode_LoansRegister; "Loans Register"."Client Code")
            {
            }
            column(Loans_Loans__Outstanding_Balance_; "Loans Register"."Outstanding Balance")
            {
            }
            column(V2Month_; "2Month")
            {
            }
            column(V3Month_; "3Month")
            {
            }
            column(Over3Month; Over3Month)
            {
            }
            column(V1Month_; "1Month")
            {
            }
            column(V0Month_; "0Month")
            {
            }
            column(AmountinArrears_LoansRegister; "Loans Register"."Amount in Arrears")
            {
            }
            column(LoanProductType; "Loans Register"."Loan Product Type")
            {
            }
            column(AsAt; AsAt)
            {
            }
            column(Days; "No.ofMonthsinArrears")
            {
            }
            trigger OnPreDataItem();
            begin

                GrandTotal := 0;
                Company.Get();
                Company.CalcFields(Company.Picture);
                // ReportForNav.OnPreDataItem("Loans Register", "Loans Register");
            end;

            trigger OnAfterGetRecord();
            begin
                Over3Month := 0; // Inserted by ForNAV
                "3Month" := 0; // Inserted by ForNAV
                "2Month" := 0; // Inserted by ForNAV
                "1Month" := 0; // Inserted by ForNAV
                "0Month" := 0; // Inserted by ForNAV
                RepaymentPeriod := AsAt;
                //MESSAGE(FORMAT(AsAt));
                if "Loans Register"."Repayment Frequency" = "Loans Register"."repayment frequency"::Monthly then begin
                    if RepaymentPeriod = CalcDate('CM', RepaymentPeriod) then begin
                        LastMonth := RepaymentPeriod;
                    end else begin
                        LastMonth := CalcDate('-1M', RepaymentPeriod);
                    end;
                    LastMonth := CalcDate('CM', LastMonth);
                end;
                DateFilter := '..' + Format(AsAt);
                Loans.Reset;
                Loans.SetRange(Loans."Loan  No.", "Loans Register"."Loan  No.");
                Loans.SetFilter(Loans."Date filter", DateFilter);
                if Loans.Find('-') then begin
                    Loans.CalcFields(Loans."Outstanding Balance", Loans."Scheduled Principal to Date", Loans."Principal Paid", Loans."Schedule Repayments");
                    LBal := Loans."Outstanding Balance";
                    //MESSAGE('##Loan Balance %1',FORMAT(LBal));
                    ScheduledLoanBal := Loans."Scheduled Principal to Date";
                    //ScheduledLoanBal:=Loans."Schedule Repayments";
                    //MESSAGE(FORMAT(ScheduledLoanBal));
                    ExpectedBalance := ROUND(Loans."Approved Amount" - ScheduledLoanBal, 1, '>');
                    //MESSAGE('##Expected Balance %1',FORMAT(ExpectedBalance));
                    Arrears := LBal - ExpectedBalance;
                    //MESSAGE(FORMAT(Arrears));
                end;
                //MESSAGE('Principal=%1 Balance=%2 ExepectedBal=%3 Arrear=%4,ScheduledLoanBal=%5',"Loans Register"."Approved Amount",LBal,ExpectedBalance,Arrears,ScheduledLoanBal);
                // MESSAGE('%1',Loans."Scheduled Principal to Date");
                if ((Arrears < 0) or (Arrears = 0)) then begin
                    Arrears := 0
                end else
                    Arrears := Arrears;
                "Amount in Arrears" := Arrears;
                Modify;
                // IF Arrears<> 0 THEN BEGIN
                if Loans."Loan Principle Repayment" > 0 then
                    "No.ofMonthsinArrears" := ROUND((Arrears / Loans."Loan Principle Repayment") * 30, 1, '>');
                //MESSAGE('%1',"No.ofMonthsinArrears");
                if Loans."Loan Product Type" = 'FIXED ADV' then
                    "No.ofMonthsinArrears" := 0;
                if Loans."Loan Product Type" = 'MSADV' then begin
                    Numberofdays := AsAt - "Loans Register"."Loan Disbursement Date";
                    if Numberofdays <= 60 then
                        "No.ofMonthsinArrears" := 0;
                    Arrears := 0;
                    "Amount in Arrears" := Arrears;
                    Modify;
                end;
                //  //END;
                //  //"No.ofMonthsinArrears"*30;
                // // MESSAGE('%1 %2 %3',"No.ofMonthsinArrears",Arrears,Loans.Repayment);
                //  IF ("No.ofMonthsinArrears"=0)  THEN BEGIN
                //	"Loans Register"."Loans Category":="Loans Register"."Loans Category"::Perfoming
                //  END ELSE
                //  IF (("No.ofMonthsinArrears">0) AND ("No.ofMonthsinArrears"<=30))THEN BEGIN
                //	"Loans Register"."Loans Category":="Loans Register"."Loans Category"::Watch
                //  END ELSE
                //  IF ("No.ofMonthsinArrears">30) AND ("No.ofMonthsinArrears"<=180)THEN BEGIN
                //	"Loans Register"."Loans Category":="Loans Register"."Loans Category"::Substandard
                //  END ELSE
                //  IF ("No.ofMonthsinArrears">180) AND ("No.ofMonthsinArrears"<=360)THEN BEGIN
                //	 "Loans Register"."Loans Category":="Loans Register"."Loans Category"::Doubtful
                //  END ELSE
                if ("No.ofMonthsinArrears" > 360) then begin
                    "Loans Register"."Loans Category" := "Loans Register"."loans category"::Loss;
                    //.............................sms
                    GenSetUp.Get;
                    CompInfo.Get;
                    //Membereg.GET;
                    Membereg.Reset;
                    Membereg.SetRange(Membereg."No.", "Loans Register"."Client Code");
                    if Membereg.Find('-') then begin
                        //SMS MESSAGE
                        SMSMessage.Reset;
                        if SMSMessage.Find('+') then begin
                            iEntryNo := SMSMessage."Entry No";
                            iEntryNo := iEntryNo + 1;
                        end
                        else begin
                            iEntryNo := 1;
                        end;
                        SMSMessage.Init;
                        SMSMessage."Entry No" := iEntryNo;
                        SMSMessage."Batch No" := Loans."Client Name";
                        SMSMessage."Document No" := Loans."Client Name";
                        SMSMessage."Account No" := Loans."Client Code";
                        SMSMessage."Date Entered" := Today;
                        SMSMessage."Time Entered" := Time;
                        SMSMessage.Source := 'Loans';
                        SMSMessage."Entered By" := UserId;
                        SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
                        SMSMessage."SMS Message" := 'Dear  ' + "Client Name" + ' , your ' + "Loan Product Type Name" + ' of amount Kshs. ' + Format("Requested Amount")
                          + ' is in default.kindly arrange to pay. we have also notified your guarantors. ,' + ' ' + CompInfo.Name + ' ' + GenSetUp."Customer Care No";
                        SMSMessage."Telephone No" := Membereg."Phone No.";
                        if Membereg."Phone No." <> '' then
                            //SMSMessage."Telephone No":="Mobile Phone No";
                            //IF "Mobile Phone No"<>'' THEN
                            SMSMessage.Insert;
                    end;
                    LGuarantors.SetRange(LGuarantors."Loan No", "Loan  No.");
                    if LGuarantors.FindFirst then begin
                        repeat
                            if Cust.Get(LGuarantors."Member No") then
                                if Cust."Mobile Phone No" <> '' then
                                    //SMS MESSAGE
                                    SMSMessage.Reset;
                            if SMSMessage.Find('+') then begin
                                iEntryNo := SMSMessage."Entry No";
                                iEntryNo := iEntryNo + 1;
                            end
                            else begin
                                iEntryNo := 1;
                            end;
                            SMSMessage.Init;
                            SMSMessage."Entry No" := iEntryNo;
                            SMSMessage."Batch No" := "Batch No.";
                            SMSMessage."Document No" := "Loan  No.";
                            SMSMessage."Account No" := "Account No";
                            SMSMessage."Date Entered" := Today;
                            SMSMessage."Time Entered" := Time;
                            SMSMessage.Source := 'GUARANTORSHIP';
                            SMSMessage."Entered By" := UserId;
                            SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
                            SMSMessage."SMS Message" := ('You guaranteed M/No: ' + "Client Name" + ' a ' + "Loan Product Type Name" + ' of Kshs. ' + Format("Requested Amount")
                                  + ' with Kshs. ' + Format(LGuarantors."Original Amount") + ' of your shares and is not repaying their loan. If unpaid in 30 days, we shall recover from your deposits. ' + CompInfo.Name);
                            Cust.SetRange(Cust."No.", LGuarantors."Member No");
                            if Cust.Find('-') then begin
                                SMSMessage."Telephone No" := Cust."Mobile Phone No";
                            end;
                            if Cust."Mobile Phone No" <> '' then
                                SMSMessage.Insert;
                        until LGuarantors.Next = 0;
                    end;
                end;
                "No of Months in Arrears" := "No.ofMonthsinArrears";
                "Loans Register"."Loan Insurance Paid" := "No.ofMonthsinArrears";
                "Loans Register".Modify;
                if "Loans Register"."Loans Category" = "Loans Register"."loans category"::Perfoming then
                    "0Month" := "Loans Register"."Outstanding Balance"
                else
                    if "Loans Register"."Loans Category" = "Loans Register"."loans category"::Watch then
                        "1Month" := "Loans Register"."Outstanding Balance"
                    else
                        if "Loans Register"."Loans Category" = "Loans Register"."loans category"::Substandard then
                            "2Month" := "Loans Register"."Outstanding Balance"
                        else
                            if "Loans Register"."Loans Category" = "Loans Register"."loans category"::Doubtful then
                                "3Month" := "Loans Register"."Outstanding Balance"
                            else
                                if "Loans Register"."Loans Category" = "Loans Register"."loans category"::Loss then
                                    Over3Month := "Loans Register"."Outstanding Balance";
                GrandTotal := GrandTotal + "Loans Register"."Outstanding Balance";
                if ("1Month" + "2Month" + "3Month" + Over3Month) > 0 then
                    NoLoans := NoLoans + 1;
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
                field("As At"; AsAt)
                {
                    ApplicationArea = Basic;
                }
            }
        }

    }
    var
        "1Month": Decimal;
        "2Month": Decimal;
        "3Month": Decimal;
        Over3Month: Decimal;
        ShowLoan: Boolean;
        AsAt: Date;
        LastDueDate: Date;
        DFormula: DateFormula;
        "0MonthC": Integer;
        "1MonthC": Integer;
        "2MonthC": Integer;
        "3MonthC": Integer;
        Over3MonthC: Integer;
        NoLoans: Integer;
        PhoneNo: Text[30];
        Cust: Record Customer;
        "StaffNo.": Text[30];
        Deposits: Decimal;
        GrandTotal: Decimal;
        "0Month": Decimal;
        // LoanProduct: Record Record51516381;
        FirstMonthDate: Date;
        EndMonthDate: Date;
        Loans_Aging_Analysis__SASRA_CaptionLbl: label 'Loans Aging Analysis (SASRA)';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Loan_TypeCaptionLbl: label 'Loan Type';
        Staff_No_CaptionLbl: label 'Staff No.';
        Oustanding_BalanceCaptionLbl: label 'Oustanding Balance';
        PerformingCaptionLbl: label 'Performing';
        V1___30_Days_CaptionLbl: label '(1 - 30 Days)';
        V0_Days_CaptionLbl: label '(0 Days)';
        WatchCaptionLbl: label 'Watch';
        V31___180_Days_CaptionLbl: label '(31 - 180 Days)';
        SubstandardCaptionLbl: label 'Substandard';
        V181___360_Days_CaptionLbl: label '(181 - 360 Days)';
        DoubtfulCaptionLbl: label 'Doubtful';
        Over_360_DaysCaptionLbl: label 'Over 360 Days';
        LossCaptionLbl: label 'Loss';
        TotalsCaptionLbl: label 'Totals';
        CountCaptionLbl: label 'Count';
        Grand_TotalCaptionLbl: label 'Grand Total';
        "0Day": Decimal;
        "1Day": Decimal;
        "2Day": Decimal;
        "3Day": Decimal;
        Over3Day: Decimal;
        LSchedule: Record "Loan Repayment Schedule";
        RepaymentPeriod: Date;
        Loans: Record "Loans Register";
        LastMonth: Date;
        ScheduledLoanBal: Decimal;
        DateFilter: Text;
        LBal: Decimal;
        Arrears: Decimal;
        "No.ofMonthsinArrears": Integer;
        Company: Record "Company Information";
        SFactory: Codeunit "Swizzsoft Factory.";
        ExpectedBalance: Decimal;
        Numberofdays: Integer;
        GenSetUp: Record "Sacco General Set-Up";
        SMSMessage: Record "SMS Messages";
        iEntryNo: Integer;
        CompInfo: Record "Company Information";
        Membereg: Record Customer;
        LGuarantors: Record "Loans Guarantee Details";
        LoanGuar: Record "Loans Guarantee Details";


    // --> Reports ForNAV Autogenerated code - do not delete or modify

    // Reports ForNAV Autogenerated code - do not delete or modify -->
}
