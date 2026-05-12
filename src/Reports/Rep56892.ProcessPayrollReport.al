report 56002 "Process Payroll"
{
    Caption = 'Process Payroll';
    ProcessingOnly = true;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(employees; "Payroll Employee.")
        {
            // RequestFilterFields = "Organization Code";
            column(ReportForNavId_6207; 6207)
            {
            }
            trigger OnAfterGetRecord()
            begin
            end;

            trigger OnPostDataItem()
            begin
                MESSAGE('Payroll processing completed successfully.');
            end;

            trigger OnPreDataItem()
            begin
                ContrInfo.Reset;
                objPeriod.RESET;
                objPeriod.SETRANGE(objPeriod.Closed, FALSE);
                IF objPeriod.FIND('-') THEN BEGIN
                    SelectedPeriod := objPeriod."Date Opened";
                    varPeriodMonth := objPeriod."Period Month";
                END;
                //For Multiple Payroll
                IF ContrInfo."Multiple Payroll" THEN BEGIN
                    PayrollType.RESET;
                    PayrollType.SETRANGE(PayrollType.EntryNo, Selection);
                    IF PayrollType.FIND('-') THEN BEGIN
                        PayrollCode := PayrollType."Payroll Code";
                    END;
                END;
                //Delete all Records from the prPeriod Transactions for Reprocessing
                objPeriod.RESET;
                objPeriod.SETRANGE(objPeriod.Closed, FALSE);
                IF objPeriod.FINDFIRST THEN BEGIN
                    //IF ContrInfo."Multiple Payroll" THEN BEGIN
                    ObjPayrollTransactions.RESET;
                    ObjPayrollTransactions.SETRANGE(ObjPayrollTransactions."Payroll Period", objPeriod."Date Opened");
                    IF ObjPayrollTransactions.FIND('-') THEN BEGIN
                        ObjPayrollTransactions.DELETEALL;
                    END;
                END;
                PayrollEmployerDed.RESET;
                PayrollEmployerDed.SETRANGE(PayrollEmployerDed."Payroll Period", SelectedPeriod);
                IF PayrollEmployerDed.FIND('-') THEN
                    PayrollEmployerDed.DELETEALL;
                HrEmployee.RESET;
                HrEmployee.SETRANGE(HrEmployee.Status, HrEmployee.Status::Active);
                IF HrEmployee.FIND('-') THEN BEGIN
                    ProgressWindow.OPEN('Processing Salary for Employee No. #1#######');
                    REPEAT
                        SLEEP(100);
                        IF NOT SalCard."Suspend Pay" THEN BEGIN
                            ProgressWindow.UPDATE(1, HrEmployee."No." + ':' + HrEmployee."Full Name");
                            IF SalCard.GET(HrEmployee."No.") THEN
                                ProcessPayroll.fnProcesspayroll(HrEmployee."No.", HrEmployee."Joining Date", SalCard."Basic Pay", SalCard."Pays PAYE"
                                , SalCard."Pays NSSF", SalCard."Pays NHIF", SelectedPeriod, SelectedPeriod, HrEmployee."Payroll No", '',
                                HrEmployee."Date of Leaving", TRUE, HrEmployee."Branch Code", PayrollCode);
                        END;
                    UNTIL HrEmployee.NEXT = 0;
                    ProgressWindow.CLOSE;
                END;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    var
        ProgressWindow: Dialog;
        ObjPayrollTransactions: Record "prPeriod Transactions.";
        PayrollEmployerDed: Record "Payroll Employer Deductions.";
        ProcessPayroll: Codeunit "Payroll Processing";
        HrEmployee: Record "Payroll Employee.";
        SalCard: Record "Payroll Employee.";
        objPeriod: Record "Payroll Calender.";
        periodName: Text[50];
        periodStartDate: Date;
        PayrollType: Record "Payroll Type.";
        periodEndDate: Date;
        SelectedPeriod: Date;
        varPeriodMonth: Integer;
        ContrInfo: Record "Control-Information.";
        PayrollCode: Code[10];
        Selection: Integer;
}
