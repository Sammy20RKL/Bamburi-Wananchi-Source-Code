#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50318 "payroll Deductions Report."
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layout/payroll Deductions Report..rdlc';

    dataset
    {
        dataitem("prPeriod Transactions."; "prPeriod Transactions.")
        {
            DataItemTableView = sorting("Group Order", "Transaction Code", "Period Month", "Period Year", Membership, "Reference No", "Department Code") where("Group Text" = filter('DEDUCTIONS|STATUTORIES'));
            PrintOnlyIfDetail = false;
            RequestFilterFields = "Transaction Code", "Employee Code", "Payroll Period";
            column(ReportForNavId_7769; 7769)
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
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(prPeriod_Transactions__Group_Text_; "Group Text")
            {
            }
            column(prPeriod_Transactions_Amount; Amount)
            {
            }
            column(prPeriod_Transactions__Transaction_Name_; "Transaction Name")
            {
            }
            column(Allowances_ReportCaption; Allowances_ReportCaptionLbl)
            {
            }
            column(User_Name_Caption; User_Name_CaptionLbl)
            {
            }
            column(Print_Date_Caption; Print_Date_CaptionLbl)
            {
            }
            column(Period_Caption; Period_CaptionLbl)
            {
            }
            column(Page_No_Caption; Page_No_CaptionLbl)
            {
            }
            column(Transaction_Name_Caption; Transaction_Name_CaptionLbl)
            {
            }
            column(Period_Amount_Caption; Period_Amount_CaptionLbl)
            {
            }
            column(Prepared_by_______________________________________Date_________________Caption; Prepared_by_______________________________________Date_________________CaptionLbl)
            {
            }
            column(Checked_by________________________________________Date_________________Caption; Checked_by________________________________________Date_________________CaptionLbl)
            {
            }
            column(Authorized_by____________________________________Date_________________Caption; Authorized_by____________________________________Date_________________CaptionLbl)
            {
            }
            column(Approved_by______________________________________Date_________________Caption; Approved_by______________________________________Date_________________CaptionLbl)
            {
            }
            column(prPeriod_Transactions_Employee_Code; "Employee Code")
            {
            }
            column(prPeriod_Transactions_Transaction_Code; "Transaction Code")
            {
            }
            column(prPeriod_Transactions_Period_Month; "Period Month")
            {
            }
            column(prPeriod_Transactions_Period_Year; "Period Year")
            {
            }
            column(prPeriod_Transactions_Membership; Membership)
            {
            }
            column(prPeriod_Transactions_Reference_No; "Reference No")
            {
            }
            column(prPeriod_Transactions_Group_Order; "Group Order")
            {
            }
            column(prPeriod_Transactions_Department_Code; "Department Code")
            {
            }
            column(Employee_Code; "Employee Code")
            {
            }
            column(Employee_Name; EmployeeName)
            {
            }
            column(SN; SN)
            {
            }
            dataitem("Payroll Employee."; "Payroll Employee.")
            {
                DataItemLink = "No." = field("Employee Code");
                column(ReportForNavId_2; 2)
                {
                }
                column(NationalIDNo_PayrollEmployee; "Payroll Employee."."National ID No")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin


                HR.Reset;
                HR.SetRange(HR."No.", "prPeriod Transactions."."Employee Code");
                if HR.Find('-') then begin
                    EmployeeName := HR."Full Name";
                end;



                HR.Get("prPeriod Transactions."."Employee Code");
                if "Employee Posting Group" <> '' then
                    if "Employee Posting Group" <> HR."Posting Group" then CurrReport.Skip;



                "prPeriod Transactions.".SetRange("Payroll Period", SelectedPeriod);
                //"prPeriod Transactions".SETFILTER("Group Order",'=7|8');
                //"prPeriod Transactions".SETFILTER("prPeriod Transactions"."Sub Group Order",'=2');

                if (Amount <= 0) or ("prPeriod Transactions."."Transaction Code" = 'TOT-DED') //or ("prPeriod Transactions."."Group Order" = 1) 
                then begin

                    CurrReport.Skip;
                end;



                /*"prPeriod Transactions".SETRANGE("Payroll Period",SelectedPeriod);
                //"prPeriod Transactions".SETFILTER("Group Order",'=1|3');
                //"prPeriod Transactions".SETFILTER("prPeriod Transactions"."Sub Group Order",'=2');
                IF Amount<=0 THEN
                  CurrReport.SKIP;
                TotalsAllowances:=TotalsAllowances+"prPeriod Transactions".Amount;
                
                PrevMonth:=0;
                PeriodTrans2.RESET;
                PeriodTrans2.SETRANGE(PeriodTrans2."Period Year","prPeriod Transactions"."Period Year");
                IF "prPeriod Transactions"."Period Month"=1 THEN BEGIN
                PeriodTrans2.SETRANGE(PeriodTrans2."Period Month",12);
                PeriodTrans2.SETRANGE(PeriodTrans2."Period Year","prPeriod Transactions"."Period Year"-1);
                END ELSE BEGIN
                PeriodTrans2.SETRANGE(PeriodTrans2."Period Month","prPeriod Transactions"."Period Month"-1);
                END;
                //PeriodTrans2.SETFILTER(PeriodTrans2."Group Order",'=7|=8');
                PeriodTrans2.SETRANGE(PeriodTrans2."Transaction Code","prPeriod Transactions"."Transaction Code");
                PeriodTrans2.SETRANGE(PeriodTrans2."Employee Code","prPeriod Transactions"."Employee Code");
                IF PeriodTrans2.FIND('-') THEN
                PrevMonth:=PeriodTrans2.Amount;
                    */
                //SN:=0;
                SN += 1;

            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FieldNo("Period Year");
                SN := 0;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(ORGANIZATION; "Employee Posting Group")
                {
                    ApplicationArea = Basic;
                    TableRelation = "Payroll Posting Groups.";
                }
                field(DateFilter; DateFilter)
                {
                    ApplicationArea = Basic;
                    Caption = 'Date Filter';
                    TableRelation = "Payroll Calender.";
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
        if UserSetup.Get(UserId) then begin
            if UserSetup."Payroll User" = false then Error('You dont have permissions for payroll, Contact your system administrator! ')
        end;
    end;

    trigger OnPreReport()
    begin
        //SelectedPeriod:="prPeriod Transactions".GETRANGEMIN("Payroll Period");


        SelectedPeriod := DateFilter;

        objPeriod.Reset;
        objPeriod.SetRange(objPeriod."Date Opened", SelectedPeriod);
        if objPeriod.Find('-') then begin
            PeriodName := objPeriod."Period Name";
        end;


        if CompanyInfo.Get() then
            CompanyInfo.CalcFields(CompanyInfo.Picture);
    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        TotalFor: label 'Total for ';
        PeriodTrans: Record "Data Sheet Main";
        GroupOrder: label '3';
        objPeriod: Record "Payroll Calender.";
        SelectedPeriod: Date;
        PeriodName: Text[30];
        CompanyInfo: Record "Company Information";
        TotalsAllowances: Decimal;
        Dept: Boolean;
        PrevMonth: Decimal;
        PeriodTrans2: Record "Relationship Types";
        Allowances_ReportCaptionLbl: label 'Deductions Report';
        User_Name_CaptionLbl: label 'User Name:';
        Print_Date_CaptionLbl: label 'Print Date:';
        Period_CaptionLbl: label 'Period:';
        Page_No_CaptionLbl: label 'Page No:';
        Transaction_Name_CaptionLbl: label 'Transaction Name:';
        Period_Amount_CaptionLbl: label 'Period Amount:';
        Prepared_by_______________________________________Date_________________CaptionLbl: label 'Prepared by……………………………………………………..              Date……………………………………………';
        Checked_by________________________________________Date_________________CaptionLbl: label 'Checked by…………………………………………………..                   Date……………………………………………';
        Authorized_by____________________________________Date_________________CaptionLbl: label 'Authorized by……………………………………………………..            Date……………………………………………';
        Approved_by______________________________________Date_________________CaptionLbl: label 'Approved by……………………………………………………..              Date……………………………………………';
        DateFilter: Date;
        EmployeeName: Text[100];
        HR: Record "Payroll Employee.";
        UserSetup: Record "User Setup";
        "Employee Posting Group": Code[20];
        HREmployee: Record "Payroll Employee.";
        SN: Integer;
}

