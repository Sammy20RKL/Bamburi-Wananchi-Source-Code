report 72016 "HR Leave Statement"
{
    // version HRMIS 2016 VRS1.0

    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Investments/HR Leave Statement.rdl';

    dataset
    {

        dataitem(HREmp; "HR Employees")
        {
            DataItemTableView = SORTING("No.") WHERE(Status = CONST(New));
            RequestFilterFields = "No.";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            /* column(CurrReport_PAGENO; CurrReport.PAGENO)
             {
             }*/
            column(USERID; HREmp."User ID")
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
            column(HR_Employees__FullName; HREmp.FullName())
            {
            }
            column(HR_Employees__HR_Employees___Leave_Balance_; HREmp."Leave Balance")
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
            column(Employee_No; HREmp."No.")
            {
            }

            dataitem(DataItem4961; "HR Leave Ledger Entries")
            {
                DataItemLink = "Staff No." = FIELD("No.");
                DataItemTableView = SORTING("Entry No.")
                                    WHERE(Closed = CONST(false));
                // column(HR_Leave_Ledger_Entries__Leave_Period_; "Leave Calendar Code")
                // {
                // }
                column(HR_Leave_Ledger_Entries__Leave_Entry_Type_; "Leave Entry Type")
                {
                }
                column(HR_Leave_Ledger_Entries__Leave_Type_; "Leave Type")
                {
                }
                column(HR_Leave_Ledger_Entries__No__of_days_; "No. of days")
                {
                }
                column(HR_Leave_Ledger_Entries__Leave_Posting_Description_; "Leave Posting Description")
                {
                }
                column(HR_Leave_Ledger_Entries__Posting_Date_; "Posting Date")
                {
                }
                column(HR_Leave_Ledger_Entries__Leave_Entry_Type_Caption; FIELDCAPTION("Leave Entry Type"))
                {
                }
                column(HR_Leave_Ledger_Entries__Leave_Type_Caption; FIELDCAPTION("Leave Type"))
                {
                }
                column(HR_Leave_Ledger_Entries__No__of_days_Caption; FIELDCAPTION("No. of days"))
                {
                }
                column(HR_Leave_Ledger_Entries__Leave_Posting_Description_Caption; FIELDCAPTION("Leave Posting Description"))
                {
                }
                column(HR_Leave_Ledger_Entries__Posting_Date_Caption; FIELDCAPTION("Posting Date"))
                {
                }
                // column(HR_Leave_Ledger_Entries__Leave_Period_Caption; FIELDCAPTION("Leave Calendar Code"))
                // {
                // }
                column(HR_Leave_Ledger_Entries_Entry_No_; "Entry No.")
                {
                }
                column(HR_Leave_Ledger_Entries_Staff_No_; "Staff No.")
                {
                }
                column(Desc; Description)
                {
                }

                trigger OnAfterGetRecord();
                begin
                    //CoreTEC PROTECTED
                    Description := DataItem4961."Leave Posting Description";//+ ' App From ' + FORMAT(DataItem4961."Leave Start Date");
                end;

                trigger OnPreDataItem();
                begin
                    //CoreTEC PROTECTED
                end;
            }

            trigger OnAfterGetRecord();
            begin
                //CoreTEC PROTECTED
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
        //CoreTEC PROTECTED
        CI.GET();
        CI.CALCFIELDS(Picture);
    end;

    var
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
        UserSetup: Record "User Setup";
        Description: Text;
        HRLeaveLedg: Record "HR Leave Ledger Entries";
    //HREmp: Record "HR Employees";
}

