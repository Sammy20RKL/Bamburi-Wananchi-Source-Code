/// <summary>
/// Report HR Leave Balances (ID 51532278).
/// </summary>
report 72278 "HR Leave Balances"
{
    // version HRMIS 2016 VRS1.0

    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './Layouts/Investments/HR Leave Balances.rdl';

    dataset
    {
        dataitem("HR Employees"; "HR Employees")
        {
            RequestFilterFields = "No.";//,Field2038;
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(USERID; "HR Employees"."User ID")
            {
            }
            column(CI_Picture; CI.Picture)
            {
            }
            column(CI_City; CI.City)
            {
            }
            column(CI__Address_2______CI__Post_Code_; CI."Address 2" + ' ' + CI."Post Code")
            {
            }
            column(CI_Address; CI.Address)
            {
            }
            column(HR_Employees__No__; "No.")
            {
            }
            column(HR_Employees__FullName; "HR Employees"."First Name" + ' ' + "HR Employees"."Middle Name")
            {
            }
            column(HR_Employees__HR_Employees___Leave_Balance_; "HR Employees"."Leave Balance")
            {
            }
            column(EmployeeCaption; EmployeeCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Employee_Leave_StatementCaption; Employee_Leave_StatementCaptionLbl)
            {
            }
            column(P_O__BoxCaption; P_O__BoxCaptionLbl)
            {
            }
            column(HR_Employees__No__Caption; FIELDCAPTION("No."))
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(Leave_BalanceCaption; Leave_BalanceCaptionLbl)
            {
            }
            column(Day_s_Caption; Day_s_CaptionLbl)
            {
            }
            column(No; No)
            {
            }
            column(Allocated; Allocated)
            {
            }
            column(Balance; Balance)
            {
            }
            column(Taken; Taken)
            {
            }
            column(Total; Total)
            {
            }
            column(Remb; Remb)
            {
            }
            column(Employee_No; "HR Employees"."No.")
            {
            }
            dataitem("HR Leave Ledger Entries"; "HR Leave Ledger Entries")
            {
                DataItemLink = "Staff No." = FIELD("No.");
                DataItemTableView = SORTING("Entry No.");

                trigger OnAfterGetRecord();
                begin
                    No := No + 1;
                end;

                trigger OnPreDataItem();
                begin
                    //"HR Leave Ledger Entries".SETFILTER("HR Leave Ledger Entries"."Leave Type",
                    //"HR-Employee".GETFILTER("HR-Employee"."Leave Type Filter"));
                end;
            }

            trigger OnAfterGetRecord();
            begin
                //"HR Employees".VALIDATE("HR Employees"."Allocated Leave Days");
                //LeaveBalance:="HR Employees"."Leave Balance";


                Allocated := 0;
                Taken := 0;
                Balance := 0;
                Remb := 0;
                LeaveType := 'ANNUAL';

                IF HREmp.GET("HR Employees"."No.") THEN BEGIN
                    HREmp.SETFILTER(HREmp."Leave Type Filter", LeaveType);
                    HREmp.CALCFIELDS(HREmp."Allocated Leave Days");
                    Allocated := HREmp."Allocated Leave Days";
                    //message(format(Allocated));

                    HREmp.VALIDATE(HREmp."Allocated Leave Days");
                    //dEarnd := HREmp."Total (Leave Days)";
                    HREmp.CALCFIELDS(HREmp."Total Leave Taken");
                    Taken := HREmp."Total Leave Taken";
                    Balance := Allocated + Taken;
                    //dLeft :=  HREmp."Leave Balance";
                    Remb := HREmp."Cash - Leave Earned";
                    //cPerDay := HREmp."Cash per Leave Day" ;
                    HREmp.CALCFIELDS(HREmp."Reimbursed Leave Days");
                    Remb := HREmp."Reimbursed Leave Days";
                END;
                Total := Allocated + Remb;
                Balance := Total - Taken;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport();
    begin
        CI.GET();
        CI.CALCFIELDS(CI.Picture);
    end;

    var
        LeaveType: Code[20];
        CI: Record "Company Information";
        LeaveBalance: Decimal;
        EmployeeCaptionLbl: Label 'Employee';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Employee_Leave_StatementCaptionLbl: Label 'Employee Leave Statement';
        P_O__BoxCaptionLbl: Label 'P.O. Box';
        NameCaptionLbl: Label 'Name';
        Leave_BalanceCaptionLbl: Label 'Leave Balance';
        Day_s_CaptionLbl: Label 'Day(s)';
        No: Decimal;
        Remb: Decimal;
        Allocated: Decimal;
        Total: Decimal;
        Taken: Decimal;
        Balance: Decimal;
        HREmp: Record "HR Employees";
}

