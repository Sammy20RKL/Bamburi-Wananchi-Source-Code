#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50047 "P9 Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/P9Report.rdlc';

    dataset
    {
        dataitem("HR Employees"; "Payroll Employee.")
        {
            RequestFilterFields = "No.";
            column(CName; CompanyInfo.Name)
            {
            }
            column(CAddress; CompanyInfo.Address)
            {
            }
            column(CPic; CompanyInfo.Picture)
            {
            }
            column(TaxRegNo; CompanyInfo."Company P.I.N")
            {
            }
            column(No_HREmployees; "HR Employees"."No.")
            {
            }
            column(FirstName_HREmployees; "HR Employees"."First Name")
            {
            }
            column(MiddleName_HREmployees; "HR Employees".Surname)
            {
            }
            column(LastName_HREmployees; "HR Employees"."Full Name")
            {
            }
            column(PIN; PINNo)
            {
            }
            column(TotalH; TotalH)
            {
            }
            column(CompPINNo; CompPINNo)
            {
            }
            column(TotalL; TotalL)
            {
            }
            dataitem("Payroll Employee P9."; "Payroll Employee P9.")
            {
                DataItemLink = "Employee Code" = field("No.");
                // RequestFilterFields = "Period Year";
                column(ReportForNavId_1000000009; 1000000009)
                {
                }
                column(PensionAmt; PensionAmt)
                {
                }
                column(PenNSSF; PenNSSF)
                {
                }
                column(EmployeeCode_PayrollEmployeeP9; "Payroll Employee P9."."Employee Code")
                {
                }
                column(BasicPay_PayrollEmployeeP9; "Payroll Employee P9."."Basic Pay")
                {
                }
                column(Allowances_PayrollEmployeeP9; "Payroll Employee P9.".Allowances)
                {
                }
                column(Benefits_PayrollEmployeeP9; "Payroll Employee P9.".Benefits)
                {
                }
                column(ValueOfQuarters_PayrollEmployeeP9; "Payroll Employee P9."."Value Of Quarters")
                {
                }
                column(DefinedContribution_PayrollEmployeeP9; "Payroll Employee P9."."Defined Contribution")
                {
                }
                column(OwnerOccupierInterest_PayrollEmployeeP9; "Payroll Employee P9."."Owner Occupier Interest")
                {
                }
                column(GrossPay_PayrollEmployeeP9; "Payroll Employee P9."."Gross Pay")
                {
                }
                column(TaxablePay_PayrollEmployeeP9; "Payroll Employee P9."."Taxable Pay")
                {
                }
                column(TaxCharged_PayrollEmployeeP9; "Payroll Employee P9."."Tax Charged")
                {
                }
                column(InsuranceRelief_PayrollEmployeeP9; "Payroll Employee P9."."Insurance Relief")
                {
                }
                column(TaxRelief_PayrollEmployeeP9; "Payroll Employee P9."."Tax Relief")
                {
                }
                column(PAYE_PayrollEmployeeP9; "Payroll Employee P9.".PAYE)
                {
                }
                column(NSSF_PayrollEmployeeP9; "Payroll Employee P9.".NSSF)
                {
                }
                column(NHIF_PayrollEmployeeP9; "Payroll Employee P9.".NHIF)
                {
                }
                column(Deductions_PayrollEmployeeP9; "Payroll Employee P9.".Deductions)
                {
                }
                column(NetPay_PayrollEmployeeP9; "Payroll Employee P9."."Net Pay")
                {
                }
                column(PeriodMonth_PayrollEmployeeP9; "Payroll Employee P9."."Period Month")
                {
                }
                column(PeriodYear_PayrollEmployeeP9; "Payroll Employee P9."."Period Year")
                {
                }
                column(PayrollPeriod_PayrollEmployeeP9; "Payroll Employee P9."."Payroll Period")
                {
                }
                column(PeriodFilter_PayrollEmployeeP9; "Payroll Employee P9."."Period Filter")
                {
                }
                column(Pension_PayrollEmployeeP9; "Payroll Employee P9.".Pension)
                {
                }
                column(HELB_PayrollEmployeeP9; "Payroll Employee P9.".HELB)
                {
                }
                column(PayrollCode_PayrollEmployeeP9; "Payroll Employee P9."."Payroll Code")
                {
                }
                column(MonthText; MonthText)
                {
                }
                column(ColG; ColG)
                {
                }
                column(Grosspay_ColG; "Payroll Employee P9."."Gross Pay" - ColG)
                {
                }
                column(FixedContribution; FixedContribution)
                {
                }//InsuranceRelief_PayrollEmployeeP9
                column(Amount3; Amount3)
                {
                }
                column(Amount1; Amount1)
                {
                }
                column(Pension; "Payroll Employee P9.".Pension + 200)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //MESSAGE('%1',"Payroll Employee P9".Pension);
                    PensionAmt := 0;
                    NSSFAmt := 0;
                    PenNSSF := 0;
                    PensionAmt := "Payroll Employee P9.".Pension;
                    NSSFAmt := "Payroll Employee P9.".NSSF;
                    // PenNSSF := ROUND((("Payroll Employee P9."."Basic Pay" * 0.12) + 200), 1, '=');
                    // if PenNSSF = 0 then
                    PenNSSF := NSSFAmt;//+ 200;
                    //-----------------------------Provident Fund missing----------------------
                    ObjPayrollMonthlyTransactions.Reset;
                    ObjPayrollMonthlyTransactions.SetRange(ObjPayrollMonthlyTransactions."Payroll Code", "Payroll Employee P9."."Employee Code");
                    ObjPayrollMonthlyTransactions.SetRange(ObjPayrollMonthlyTransactions."Period Month", "Payroll Employee P9."."Period Month");
                    ObjPayrollMonthlyTransactions.SetFilter(ObjPayrollMonthlyTransactions."Transaction Code", 'D002');
                    if ObjPayrollMonthlyTransactions.Find('-') then begin
                        "Payroll Employee P9.".Pension := ObjPayrollMonthlyTransactions.Amount + 200;
                        "Payroll Employee P9.".Modify;
                    end;
                    //-----------------------------------End of Correction----------------------------------------------

                    case "Period Month" of
                        1:
                            MonthText := 'January';
                        2:
                            MonthText := 'February';
                        3:
                            MonthText := 'March';
                        4:
                            MonthText := 'April';
                        5:
                            MonthText := 'May';
                        6:
                            MonthText := 'June';
                        7:
                            MonthText := 'July';
                        8:
                            MonthText := 'August';
                        9:
                            MonthText := 'September';
                        10:
                            MonthText := 'October';
                        11:
                            MonthText := 'November';
                        12:
                            MonthText := 'December';
                        else
                            MonthText := '';
                    end;

                    if (NSSF) > 20000 then begin
                        ColG := 20000 + "Owner Occupier Interest";
                    end
                    else begin
                        ColG := (NSSF) + "Owner Occupier Interest";
                    end;
                    FixedContribution := 20000;
                    HTotal := "Gross Pay" - ColG;

                    Amount1 := 0;
                    Amount2 := 0;
                    Amount3 := 0;
                    if PenNSSF < FixedContribution then
                        Amount1 := PenNSSF
                    else
                        if FixedContribution < PenNSSF then
                            Amount1 := FixedContribution;

                    Amount2 := Amount1 + "Payroll Employee P9."."Owner Occupier Interest";
                    Amount3 := "Payroll Employee P9."."Gross Pay" - Amount2;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                PINNo := '';
                PayrollEmployeee.Reset;
                PayrollEmployeee.SetRange(PayrollEmployeee."No.", "HR Employees"."No.");
                if PayrollEmployeee.Find('-') then
                    PINNo := PayrollEmployeee."PIN No";
                TotaA := 0;
                TotalB := 0;
                totalC := 0;
                totalD := 0;
                TotalE1 := 0;
                TotalE2 := 0;
                TotalE3 := 0;
                TotalF := 0;
                TotalG := 0;
                TotalH := 0;
                TotalJ := 0;
                TotalK := 0;
                TotalL := 0;
                P9.Reset;
                P9.SetRange(P9."Employee Code", "No.");
                P9.SetRange(P9."Period Year", intYear);
                if P9.Find('-') then begin
                    repeat
                        TotaA := TotaA + P9."Basic Pay";
                        TotalB := TotalB + P9.Benefits;
                        totalC := totalC + P9."Value Of Quarters";
                        totalD := totalD + P9."Gross Pay";
                        TotalE1 := TotalE1 + (P9."Basic Pay" * 0.3);
                        TotalE2 := TotalE2 + (P9.NSSF);
                        TotalE3 := TotalE3 + 20000;
                        TotalF := TotalF + P9."Owner Occupier Interest";
                        if P9.NSSF < 20000 then begin
                            TotalH := TotalH + (P9."Gross Pay" - (P9.NSSF));
                        end else begin
                            TotalH := TotalH + (P9."Gross Pay" - 20000);
                        end;
                        TotalJ := TotalJ + P9."Tax Charged";
                        TotalK := TotalK + (P9."Tax Relief" + P9."Insurance Relief");
                        TotalL := TotalL + P9.PAYE;
                    until P9.Next = 0;
                end;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;


        layout
        {
            area(Content)
            {
                group(General)
                {
                    Caption = 'Please select the year for the report';
                    field(YearFilter; intYear)
                    {
                        Caption = 'Year';
                    }
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
        if ObjUserSetup.Get(UserId) then begin
            if ObjUserSetup."Payroll User" = false then Error('You dont have permissions for payroll, Contact your system administrator! ')
        end;

        //REPORT.RUN(REPORT::"Update P9Rports");
    end;

    trigger OnPreReport()
    begin
        CompanyInfo.Get;
        CompanyInfo.CalcFields(CompanyInfo.Picture);
        //REPORT.RUN(REPORT::"Update P9Rports");
        if CompInfoSetup.Get() then
            CompPINNo := CompInfoSetup."Company P.I.N";
    end;

    var
        intYear: Integer;
        MonthText: Text;
        ObjUserSetup: Record "User Setup";
        ColG: Decimal;
        FixedContribution: Decimal;
        HTotal: Decimal;
        TotaA: Decimal;
        TotalB: Decimal;
        totalC: Decimal;
        totalD: Decimal;
        TotalE1: Decimal;
        TotalE2: Decimal;
        TotalE3: Decimal;
        TotalF: Decimal;
        TotalG: Decimal;
        TotalH: Decimal;
        TotalI: Decimal;
        TotalJ: Decimal;
        TotalK: Decimal;
        TotalL: Decimal;
        P9: Record "Payroll Employee P9.";
        PensionAmt: Decimal;
        NSSFAmt: Decimal;
        PenNSSF: Decimal;
        Amount1: Decimal;
        Amount2: Decimal;
        Amount3: Decimal;
        PayrollEmployeee: Record "Payroll Employee.";
        PINNo: Code[20];
        CompanyInfo: Record "Company Information";
        CompInfoSetup: Record "Company Information";
        CompPINNo: Code[100];
        ObjPayrollMonthlyTransactions: Record "prPeriod Transactions.";
}

