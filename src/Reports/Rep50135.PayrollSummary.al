#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50135 "Payroll Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layout/Payroll Summary.rdlc';

    dataset
    {
        dataitem("prPeriod Transactions."; "prPeriod Transactions.")
        {
            DataItemTableView = sorting("Employee Code", "Department Code") order(ascending) where("Transaction Code" = filter('NPAY'));
            RequestFilterFields = "Payroll Period";
            column(ReportForNavId_1; 1)
            {
            }
            column(CompName; info.Name)
            {
            }
            column(pic; info.Picture)
            {
            }
            column(Addr1; info.Address)
            {
            }
            column(Addr2; info."Address 2")
            {
            }
            column(Email; info."E-Mail")
            {
            }
            column(Year; Year)
            {
            }
            column(PeriodName; PeriodName)
            {
            }
            column(EmployeeCode_prPeriodTransactions; "prPeriod Transactions."."Employee Code")
            {
            }
            column(TransactionCode_prPeriodTransactions; "prPeriod Transactions."."Transaction Code")
            {
            }
            column(GroupText_prPeriodTransactions; "prPeriod Transactions."."Group Text")
            {
            }
            column(TransactionName_prPeriodTransactions; "prPeriod Transactions."."Transaction Name")
            {
            }
            column(Amount_prPeriodTransactions; "prPeriod Transactions.".Amount)
            {
            }
            column(Balance_prPeriodTransactions; "prPeriod Transactions.".Balance)
            {
            }
            column(OriginalAmount_prPeriodTransactions; "prPeriod Transactions."."Original Amount")
            {
            }
            column(GroupOrder_prPeriodTransactions; "prPeriod Transactions."."Group Order")
            {
            }
            column(SubGroupOrder_prPeriodTransactions; "prPeriod Transactions."."Sub Group Order")
            {
            }
            column(PeriodMonth_prPeriodTransactions; "prPeriod Transactions."."Period Month")
            {
            }
            column(PeriodYear_prPeriodTransactions; "prPeriod Transactions."."Period Year")
            {
            }
            column(PeriodFilter_prPeriodTransactions; "prPeriod Transactions."."Period Filter")
            {
            }
            column(PayrollPeriod_prPeriodTransactions; "prPeriod Transactions."."Payroll Period")
            {
            }
            column(Membership_prPeriodTransactions; "prPeriod Transactions.".Membership)
            {
            }
            column(ReferenceNo_prPeriodTransactions; "prPeriod Transactions."."Reference No")
            {
            }
            column(DepartmentCode_prPeriodTransactions; "prPeriod Transactions."."Department Code")
            {
            }
            column(Lumpsumitems_prPeriodTransactions; "prPeriod Transactions.".Lumpsumitems)
            {
            }
            column(TravelAllowance_prPeriodTransactions; "prPeriod Transactions.".TravelAllowance)
            {
            }
            column(GLAccount_prPeriodTransactions; "prPeriod Transactions."."GL Account")
            {
            }
            column(CompanyDeduction_prPeriodTransactions; "prPeriod Transactions."."Company Deduction")
            {
            }
            column(EmpAmount_prPeriodTransactions; "prPeriod Transactions."."Emp Amount")
            {
            }
            column(EmpBalance_prPeriodTransactions; "prPeriod Transactions."."Emp Balance")
            {
            }
            column(JournalAccountCode_prPeriodTransactions; "prPeriod Transactions."."Journal Account Code")
            {
            }
            column(JournalAccountType_prPeriodTransactions; "prPeriod Transactions."."Journal Account Type")
            {
            }
            column(PostAs_prPeriodTransactions; "prPeriod Transactions."."Post As")
            {
            }
            column(LoanNumber_prPeriodTransactions; "prPeriod Transactions."."Loan Number")
            {
            }
            column(coopparameters_prPeriodTransactions; "prPeriod Transactions."."coop parameters")
            {
            }
            column(PayrollCode_prPeriodTransactions; "prPeriod Transactions."."Payroll Code")
            {
            }
            column(PaymentMode_prPeriodTransactions; "prPeriod Transactions."."Payment Mode")
            {
            }
            column(FosaAccountNo_prPeriodTransactions; "prPeriod Transactions."."Fosa Account No.")
            {
            }
            column(employeeName; employeeName)
            {
            }
            column(SaccoDeductions; SaccoDeductions)
            {

            }
            column(Loans; Loans) { }
            column(Deposits; Deposits) { }
            column(Likizo; Likizo) { }
            column(Interests; Interests) { }
            column(Organization_prPeriodTransactions; "prPeriod Transactions.".Organization)
            {
            }
            column(Basicpay; Basicpay)
            {
            }
            column(Totalallowances; Totalallowances)
            {
            }
            column(grosspay; grosspay)
            {
            }
            column(nssf; nssf)
            {
            }
            column(nhif; nhif)
            {
            }
            column(paye; paye)
            {
            }
            column(HousingLevy; "HOUSING LEVY")
            {
            }
            column(totaldeductions; totaldeductions)
            {
            }
            column(net; net)
            {
            }
            column(Transfer; Transfer)
            {
            }
            column(SN; SN)
            {
            }
            dataitem("Payroll Employee."; "Payroll Employee.")
            {
                DataItemLink = "No." = field("Employee Code");
                DataItemTableView = where(Status = const(Active));
                column(ReportForNavId_47; 47)
                {

                }
            }

            trigger OnAfterGetRecord()
            begin

                objPeriod.Reset;
                objPeriod.SetRange(objPeriod."Date Opened", "prPeriod Transactions."."Payroll Period");
                if objPeriod.Find('-') then begin
                    PeriodName := objPeriod."Period Name";
                end;


                HREmployees.Get("prPeriod Transactions."."Employee Code");
                if "Employee Posting Group" <> '' then
                    if "Employee Posting Group" <> HREmployees."Posting Group" then CurrReport.Skip;

                employeeName := HREmployees."Full Name";
                Organization := HREmployees."Posting Group";
                if "prPeriod Transactions."."Group Order" = 6 then
                    CurrReport.Skip;
                if PeriodTrans.Find('-') then begin
                    Year := PeriodTrans."Period Year";
                    //Organization:=HREmployees.."Posting Group";
                    if PeriodTrans.Amount = 0 then
                        CurrReport.Skip;


                end;
                //IF PeriodTrans."Transaction Code"='E009' THEN
                // CurrReport.SKIP;
                Basicpay := 0;
                Totalallowances := 0;
                grosspay := 0;
                nssf := 0;
                nhif := 0;
                paye := 0;
                "HOUSING LEVY" := 0;
                totaldeductions := 0;
                SaccoDeductions := 0;
                net := 0;
                Transfer := 0;
                Likizo := 0;
                Deposits := 0;
                Interests := 0;
                Loans := 0;

                //Basic pay
                PeriodTrans2.Reset;
                PeriodTrans2.SetRange("Transaction Code", 'BPAY');
                PeriodTrans2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
                PeriodTrans2.SetRange("Payroll Period", "prPeriod Transactions."."Payroll Period");
                if PeriodTrans2.FindFirst then begin
                    Basicpay := PeriodTrans2.Amount;
                end;
                //END;


                PeriodTrans2.Reset;
                PeriodTrans2.SetRange("Group Text", 'ALLOWANCE');
                PeriodTrans2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
                PeriodTrans2.SetRange("Payroll Period", "prPeriod Transactions."."Payroll Period");
                if PeriodTrans2.FindSet then begin
                    repeat
                        Totalallowances := Totalallowances + PeriodTrans2.Amount;
                    until PeriodTrans2.Next = 0;
                end;
                //END;

                //gross
                PeriodTrans2.Reset;
                PeriodTrans2.SetRange("Transaction Code", 'GPAY');
                PeriodTrans2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
                PeriodTrans2.SetRange("Payroll Period", "prPeriod Transactions."."Payroll Period");
                if PeriodTrans2.FindFirst then begin
                    repeat
                        grosspay := PeriodTrans2.Amount;
                    until PeriodTrans2.Next = 0;
                end;
                //END;

                //nssf
                PeriodTrans2.Reset;
                PeriodTrans2.SetRange("Transaction Code", 'NSSF');
                PeriodTrans2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
                PeriodTrans2.SetRange("Payroll Period", "prPeriod Transactions."."Payroll Period");
                if PeriodTrans2.FindFirst then begin
                    repeat
                        nssf := PeriodTrans2.Amount;
                    until PeriodTrans2.Next = 0;
                end;
                //END;

                //nhif
                PeriodTrans2.Reset;
                PeriodTrans2.SetRange("Transaction Code", 'NHIF');
                PeriodTrans2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
                PeriodTrans2.SetRange("Payroll Period", "prPeriod Transactions."."Payroll Period");
                if PeriodTrans2.FindFirst then begin
                    repeat
                        nhif := PeriodTrans2.Amount;
                    until PeriodTrans2.Next = 0;
                end;
                //END;

                //paye
                PeriodTrans2.Reset;
                PeriodTrans2.SetRange("Transaction Code", 'PAYE');
                PeriodTrans2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
                PeriodTrans2.SetRange("Payroll Period", "prPeriod Transactions."."Payroll Period");
                if PeriodTrans2.FindFirst then begin
                    repeat
                        paye := PeriodTrans2.Amount;
                    until PeriodTrans2.Next = 0;
                end;
                //END;

                //"HOUSING LEVY"
                PeriodTrans2.Reset;
                PeriodTrans2.SetRange("Transaction Code", 'HOUSING LEVY');
                PeriodTrans2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
                PeriodTrans2.SetRange("Payroll Period", "prPeriod Transactions."."Payroll Period");
                if PeriodTrans2.FindFirst then begin
                    repeat
                        "HOUSING LEVY" := PeriodTrans2.Amount;
                    until PeriodTrans2.Next = 0;
                end;
                //END;


                //other deductions
                PeriodTrans2.Reset;
                PeriodTrans2.SetFilter("Transaction Code", '<>%1', 'PNSRLF');
                PeriodTrans2.SetRange("Group Text", 'DEDUCTIONS');
                PeriodTrans2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
                PeriodTrans2.SetRange("Payroll Period", "prPeriod Transactions."."Payroll Period");
                if PeriodTrans2.FindFirst then begin
                    repeat
                        totaldeductions := totaldeductions + PeriodTrans2.Amount;
                    until PeriodTrans2.Next = 0;
                end;
                //END;
                //transfer Allowance
                // PeriodTrans2.Reset;
                // PeriodTrans2.SetRange("Transaction Code", '0011');
                // PeriodTrans2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
                // PeriodTrans2.SetRange("Payroll Period", "prPeriod Transactions."."Payroll Period");
                // if PeriodTrans2.FindFirst then begin
                //     repeat
                //         Transfer := PeriodTrans2.Amount;
                //     until PeriodTrans2.Next = 0;
                // end;

                //END Acting Allowance;

                //net pay
                PeriodTrans2.Reset;
                PeriodTrans2.SetRange("Transaction Code", 'NPAY');
                PeriodTrans2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
                PeriodTrans2.SetRange("Payroll Period", "prPeriod Transactions."."Payroll Period");
                if PeriodTrans2.FindFirst then begin
                    repeat
                        net := PeriodTrans2.Amount;
                    until PeriodTrans2.Next = 0;
                end;

                //Loans Deductions
                PeriodTrans2.Reset;
                PeriodTrans2.SetRange("Transaction Code", 'LOAN');
                PeriodTrans2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
                PeriodTrans2.SetRange("Payroll Period", "prPeriod Transactions."."Payroll Period");
                if PeriodTrans2.FindFirst then begin
                    repeat
                        Loans := PeriodTrans2.Amount;
                    until PeriodTrans2.Next = 0;
                end;

                //Sacco Deductions
                PeriodTrans2.Reset;
                PeriodTrans2.SetRange("Transaction Code", 'DEPOSIT');
                PeriodTrans2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
                PeriodTrans2.SetRange("Payroll Period", "prPeriod Transactions."."Payroll Period");
                if PeriodTrans2.FindFirst then begin
                    repeat
                        Deposits := PeriodTrans2.Amount;
                    until PeriodTrans2.Next = 0;
                end;
                //Interests

                //Likizo

                PeriodTrans2.Reset;
                PeriodTrans2.SetRange("Transaction Code", 'LIKIZO');
                PeriodTrans2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
                PeriodTrans2.SetRange("Payroll Period", "prPeriod Transactions."."Payroll Period");
                if PeriodTrans2.FindFirst then begin
                    repeat
                        Likizo := PeriodTrans2.Amount;
                    until PeriodTrans2.Next = 0;
                end;
                //end of Likizo



                PeriodTrans2.Reset;
                PeriodTrans2.SetRange("Transaction Code", 'SHARE CAPITAL');
                PeriodTrans2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
                PeriodTrans2.SetRange("Payroll Period", "prPeriod Transactions."."Payroll Period");
                if PeriodTrans2.FindFirst then begin
                    repeat
                        Sharecapital := PeriodTrans2.Amount;
                    until PeriodTrans2.Next = 0;
                end;


                PeriodTrans2.Reset;
                PeriodTrans2.SetRange("Transaction Code", 'INTEREST');
                PeriodTrans2.SetRange("Employee Code", "prPeriod Transactions."."Employee Code");
                PeriodTrans2.SetRange("Payroll Period", "prPeriod Transactions."."Payroll Period");
                if PeriodTrans2.FindFirst then begin
                    repeat
                        Interests := PeriodTrans2.Amount;
                    until PeriodTrans2.Next = 0;
                end;
                SaccoDeductions := (Interests + Deposits + Loans + Likizo + Sharecapital);
                //END;
                SN := SN + 1;
            end;

            trigger OnPreDataItem()
            begin
                /*IF UserSetup.GET(USERID) THEN
                BEGIN
                IF UserSetup."View Payroll"=FALSE THEN ERROR ('You dont have permissions for payroll, Contact your system administrator! ')
                END ELSE BEGIN
                ERROR('You have been setup in the user setup!');
                END;*/



                info.Get;
                info.CalcFields(Picture);

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
        HREmployees: Record "Payroll Employee.";
        Sharecapital: Decimal;
        SaccoDeductions: Decimal;
        employeeName: Text;
        info: Record "Company Information";
        Loans: Decimal;
        Deposits: Decimal;
        Likizo: Decimal;
        Interests: Decimal;
        CompName: Text[50];
        Addr1: Text[50];
        Addr2: Text[50];
        Email: Text[50];
        UserSetup: Record "User Setup";
        SelectedPeriod: Date;
        objPeriod: Record "Payroll Calender.";
        PeriodFilter: Date;
        PeriodName: Text;
        PeriodTrans: Record "prPeriod Transactions.";
        Year: Integer;
        Organization: Text;
        PostingGroup: Text;
        "Employee Posting Group": Code[10];
        Basicpay: Decimal;
        Totalallowances: Decimal;
        grosspay: Decimal;
        nssf: Decimal;
        nhif: Decimal;
        paye: Decimal;
        "HOUSING LEVY": Decimal;
        totaldeductions: Decimal;
        net: Decimal;
        PeriodTrans2: Record "prPeriod Transactions.";
        Transfer: Decimal;
        Transfer2: Decimal;
        SN: Integer;
}

