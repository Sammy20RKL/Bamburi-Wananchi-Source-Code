report 72331 "HRLeave Applications List"
{
    // version HRMIS 2016 VRS1.0

    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './Layouts/Investments/HRLeaveApplicationsList.rdl';

    dataset
    {
        dataitem("HR Leave Application"; "HR Leave Application")
        {
            RequestFilterFields = "Application Code";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(USERID; USERID)
            {
            }
            column(HR_Leave_Application__Application_Code_; "Application Code")
            {
            }
            column(HR_Leave_Application__Application_Date_; "Application Date")
            {
            }
            column(HR_Leave_Application__Employee_No_; "Applicant Staff No.")
            {
            }
            column(Names_HRLeaveApplication; "HR Leave Application".Names)
            {
            }
            column(HR_Leave_Application__Job_Tittle_; "Job Tittle")
            {
            }
            column(HR_Leave_Application_Supervisor; "Applicant Supervisor")
            {
            }
            column(HR_Leave_Application__Leave_Type_; "Leave Type")
            {
            }
            column(HR_Leave_Application__Days_Applied_; "Days Applied")
            {
            }
            column(HR_Leave_Application__Start_Date_; "Start Date")
            {
            }
            column(HR_Leave_Application__Return_Date_; "Return Date")
            {
            }
            column(HR_Leave_Application_Reliever; Reliever)
            {
            }
            column(CurrentBalance_HRLeaveApplication; "Leave Balance")
            {
            }
            column(HR_Leave_Application__Reliever_Name_; "Reliever Name")
            {
            }
            column(HR_Leave_ApplicationCaption; HR_Leave_ApplicationCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(HR_Leave_Application__Application_Code_Caption; FIELDCAPTION("Application Code"))
            {
            }
            column(HR_Leave_Application__Application_Date_Caption; FIELDCAPTION("Application Date"))
            {
            }
            column(HR_Leave_Application__Employee_No_Caption; FIELDCAPTION("Applicant Staff No."))
            {
            }
            column(HR_Leave_Application__Job_Tittle_Caption; FIELDCAPTION("Job Tittle"))
            {
            }
            column(HR_Leave_Application_SupervisorCaption; FIELDCAPTION("Applicant Supervisor"))
            {
            }
            column(HR_Leave_Application__Leave_Type_Caption; FIELDCAPTION("Leave Type"))
            {
            }
            column(HR_Leave_Application__Days_Applied_Caption; FIELDCAPTION("Days Applied"))
            {
            }
            column(HR_Leave_Application__Start_Date_Caption; FIELDCAPTION("Start Date"))
            {
            }
            column(HR_Leave_Application__Return_Date_Caption; FIELDCAPTION("Return Date"))
            {
            }
            column(HR_Leave_Application_RelieverCaption; FIELDCAPTION(Reliever))
            {
            }
            column(HR_Leave_Application__Reliever_Name_Caption; FIELDCAPTION("Reliever Name"))
            {
            }
            column(Picture; CI.Picture)
            {
            }
            column(Status_HRLeaveApplication; "HR Leave Application".Status)
            {
            }

            trigger OnAfterGetRecord()
            var
                LeaveLedger: Record "HR Leave Ledger Entries";
                LeaveApp: Record "HR Leave Application";
                TotalAllocated: Decimal;
                TotalTaken: Decimal;
                LeaveDaysApplied: Decimal;
                "Days Applied": Decimal;
            begin
                TotalAllocated := 0;
                TotalTaken := 0;
                LeaveDaysApplied := 0;
                "Days Applied" := 0;

                // Step 1: Allocated Leave from Ledger (Positive)
                LeaveLedger.Reset;
                LeaveLedger.SetRange("Staff No.", "Applicant Staff No.");
                LeaveLedger.SetRange("Leave Type", 'ANNUAL');
                LeaveLedger.SetRange("Leave Entry Type", LeaveLedger."Leave Entry Type"::Positive);
                LeaveLedger.SetFilter("Posting Date", '<=%1', "Application Date");

                if LeaveLedger.FindSet then
                    repeat
                        TotalAllocated += LeaveLedger."No. of days";
                    until LeaveLedger.Next = 0;

                // Step 2: Taken Leave from Ledger (Negative)
                LeaveLedger.Reset;
                LeaveLedger.SetRange("Staff No.", "Applicant Staff No.");
                LeaveLedger.SetRange("Leave Type", 'ANNUAL');
                LeaveLedger.SetRange("Leave Entry Type", LeaveLedger."Leave Entry Type"::Negative);
                LeaveLedger.SetFilter("Posting Date", '<=%1', "Application Date");

                if LeaveLedger.FindSet then
                    repeat
                        TotalTaken += ABS(LeaveLedger."No. of days");
                    until LeaveLedger.Next = 0;

                // Step 3: Days Applied from Previous Leave Applications (up to and including this one)
                LeaveApp.Reset;
                LeaveApp.SetRange("Applicant Staff No.", "Applicant Staff No.");
                LeaveApp.SetRange("Leave Type", 'ANNUAL');
                LeaveApp.SetFilter("Application Date", '<=%1', LeaveApp."Application Date");
                LeaveApp.SetFilter("Status", '<>%1', LeaveApp."Status"::New); // Only count non-rejected
                LeaveApp.SetFilter("Application Code", '<>%1', "Application Code"); // Exclude current record if not yet posted

                if LeaveApp.FindSet then
                    repeat
                        LeaveDaysApplied += LeaveApp."Days Applied";
                    until LeaveApp.Next = 0;


                // Step 4: Include current application days too
                LeaveDaysApplied += LeaveApp."Days Applied";

                // Final Leave Balance
                "Leave Balance" := TotalAllocated - (TotalTaken + LeaveDaysApplied);
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
        CI.RESET;
        CI.GET;
        CI.CALCFIELDS(CI.Picture);
    end;



    var
        HR_Leave_ApplicationCaptionLbl: Label 'HR Leave Application';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        CI: Record "Company Information";
}

