Report 50476 "PAYE Schedule"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/PAYESchedule.rdlc';

    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Payroll Employee"; "Payroll Employee.")
        {
            RequestFilterFields = "Period Filter", "No.";
            column(ReportForNavId_6207; 6207)
            {
            }
            column(USERID; UserId)
            {
            }
            column(TODAY; Today)
            {
            }
            column(PeriodName; PeriodName)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(companyinfo_Picture; companyinfo.Picture)
            {
            }
            column(prSalary_Card__prSalary_Card___Employee_Code_; "Payroll Employee"."No.")
            {
            }
            column(EmployeeName; EmployeeName)
            {
            }
            column(PinNumber; PinNumber)
            {
            }
            column(PayeAmount; PayeAmount)
            {
            }
            column(TaxablePay; TaxablePay)
            {
            }
            column(TotTaxablePay; TotTaxablePay)
            {
            }
            column(CompName; CompName)
            {
            }
            column(Addr1; Addr1)
            {
            }
            column(Addr2; Addr2)
            {
            }
            column(Email; Email)
            {
            }
            column(TotPayeAmount; TotPayeAmount)
            {
            }
            column(User_Name_Caption; User_Name_CaptionLbl)
            {
            }
            column(Print_Date_Caption; Print_Date_CaptionLbl)
            {
            }
            column(P_A_Y_E_ScheduleCaption; P_A_Y_E_ScheduleCaptionLbl)
            {
            }
            column(Period_Caption; Period_CaptionLbl)
            {
            }
            column(Page_No_Caption; Page_No_CaptionLbl)
            {
            }
            column(No_Caption; No_CaptionLbl)
            {
            }
            column(Employee_NameCaption; Employee_NameCaptionLbl)
            {
            }
            column(PIN_Number_Caption; PIN_Number_CaptionLbl)
            {
            }
            column(Paye_Amount_Caption; Paye_Amount_CaptionLbl)
            {
            }
            column(Taxable_Pay_Caption; Taxable_Pay_CaptionLbl)
            {
            }
            column(Prepared_by_______________________________________Date________________Caption; Prepared_by_______________________________________Date_________________CaptionLbl)
            {
            }
            column(Checked_by________________________________________Date_________________Caption; Checked_by________________________________________Date_________________CaptionLbl)
            {
            }
            column(Totals_Caption; Totals_CaptionLbl)
            {
            }
            column(Authorized_by____________________________________Date_________________Caption; Authorized_by____________________________________Date_________________CaptionLbl)
            {
            }
            column(Approved_by______________________________________Date_________________Caption; Approved_by______________________________________Date_________________CaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                PayeAmount := 0;
                TaxablePay := 0;

                objEmp.Reset;
                objEmp.SetRange(objEmp."No.", "No.");
                if objEmp.Find('-') then
                    EmployeeName := '';
                EmployeeName := objEmp."Full Name";

                PinNumber := objEmp."PIN No";




                PeriodTrans.Reset;
                PeriodTrans.SetRange(PeriodTrans."Employee Code", "No.");
                PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                if PeriodTrans.Find('-') then
                    repeat

                        if (PeriodTrans."Transaction Code" = 'TXBP') then begin
                            TaxablePay := PeriodTrans.Amount;
                        end;

                        if (PeriodTrans."Transaction Code" = 'PAYE') then begin

                            PayeAmount := PeriodTrans.Amount;

                        end;


                    until PeriodTrans.Next = 0;




                if PayeAmount <= 0 then
                    CurrReport.Skip;


                objEmp.Reset;
                objEmp.SetRange(objEmp."No.", "No.");
                if objEmp.Find('-') then begin
                    repeat
                        TotPayeAmount := TotPayeAmount + PayeAmount;
                        TotTaxablePay := TotTaxablePay + TaxablePay;
                    until objEmp.Next = 0;
                end;
            end;

            trigger OnPreDataItem()
            begin
                if companyinfo.Get() then
                    companyinfo.CalcFields(companyinfo.Picture);
                CompName := companyinfo.Name;
                Addr1 := companyinfo."Address 2";

                Addr2 := companyinfo.City;
                Email := companyinfo."E-Mail";
                TotPayeAmount := 0;
                TotTaxablePay := 0;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(periodfilter; PeriodFilter)
                {
                    ApplicationArea = Basic;
                    Caption = 'Period Filter';
                    TableRelation = "Payroll Calender."."Date Opened";
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
        objPeriod.Reset;
        objPeriod.SetRange(objPeriod.Closed, false);
        if objPeriod.Find('-') then;
        PeriodFilter := objPeriod."Date Opened";
    end;

    trigger OnPreReport()
    begin
        if UserSetup.Get(UserId) then begin
            if UserSetup."Payroll User" = false then Error('You dont have permissions for payroll, Contact your system administrator! ')
        end else begin
            Error('You have been setup in the user setup!');
        end;

        //PeriodFilter:="prSalary Card".GETFILTER("Period Filter");
        if PeriodFilter = 0D then Error('You must specify the period filter');

        SelectedPeriod := PeriodFilter;
        objPeriod.Reset;
        if objPeriod.Get(SelectedPeriod) then PeriodName := objPeriod."Period Name";


        if companyinfo.Get() then
            companyinfo.CalcFields(companyinfo.Picture);
    end;

    var
        UserSetup: Record "User Setup";
        PeriodTrans: Record "prPeriod Transactions.";
        PayeAmount: Decimal;
        TotPayeAmount: Decimal;
        TaxablePay: Decimal;
        TotTaxablePay: Decimal;
        EmployeeName: Text[150];
        PinNumber: Text[30];
        objPeriod: Record "Payroll Calender.";
        objEmp: Record "Payroll Employee.";
        SelectedPeriod: Date;
        PeriodName: Text[30];
        PeriodFilter: Date;
        companyinfo: Record "Company Information";
        User_Name_CaptionLbl: label 'User Name:';
        Print_Date_CaptionLbl: label 'Print Date:';
        P_A_Y_E_ScheduleCaptionLbl: label 'P.A.Y.E Schedule';
        Period_CaptionLbl: label 'Period:';
        Page_No_CaptionLbl: label 'Page No:';
        No_CaptionLbl: label 'No:';
        Employee_NameCaptionLbl: label 'Employee Name';
        PIN_Number_CaptionLbl: label 'PIN Number:';
        Paye_Amount_CaptionLbl: label 'Paye Amount:';
        Taxable_Pay_CaptionLbl: label 'Taxable Pay:';
        Prepared_by_______________________________________Date_________________CaptionLbl: label 'Prepared by……………………………………………………..                 Date……………………………………………';
        Checked_by________________________________________Date_________________CaptionLbl: label 'Checked by…………………………………………………..                   Date……………………………………………';
        Totals_CaptionLbl: label 'Totals:';
        Authorized_by____________________________________Date_________________CaptionLbl: label 'Authorized by……………………………………………………..              Date……………………………………………';
        Approved_by______________________________________Date_________________CaptionLbl: label 'Approved by……………………………………………………..                Date……………………………………………';
        CompName: Text[50];
        Addr1: Text[50];
        Addr2: Text[50];
        Email: Text[50];
}

