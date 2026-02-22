report 53003 "Leave Applications"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './layout/LeaveApplications.rdl';
    Caption = 'Leave Applications';
    dataset
    {
        dataitem("Leave Application"; "Leave Application")
        {
            DataItemTableView = where(Status = filter(Released));
            RequestFilterFields = "Employee No", "Leave Code", "Responsibility Center", "Application Date", "Leave Status";

            column(Company_Name; CompanyInfo.Name)
            {
            }
            column(Company_Logo; CompanyInfo.Picture)
            {
            }
            column(Address; CompanyInfo.Address)
            {
            }
            column(City; CompanyInfo.City)
            {
            }
            column(Phone_No; CompanyInfo."Phone No.")
            {
            }
            column(PostCode; CompanyInfo."Post Code")
            {
            }
            column(Email; CompanyInfo."E-Mail")
            {
            }
            column(Website; CompanyInfo."Home Page")
            {
            }
            column(EmployeeNo_LeaveApplication; "Leave Application"."Employee No")
            {
            }
            column(ApplicationNo_LeaveApplication; "Leave Application"."Application No")
            {
            }
            column(LeaveCode_LeaveApplication; GetLeaveName("Leave Application"."Leave Code"))
            {
            }
            column(DaysApplied_LeaveApplication; "Leave Application"."Days Applied")
            {
            }
            column(StartDate_LeaveApplication; "Leave Application"."Start Date")
            {
            }
            column(EndDate_LeaveApplication; "Leave Application"."End Date")
            {
            }
            column(leaveDescription; GetLeaveName("Leave Application"."Leave Code"))
            {
            }
            column(Resumption_Date; "Resumption Date")
            {
            }
            column(EmployeeName_LeaveApplication; "Leave Application"."Employee Name")
            {
            }
            column(DaysApplied; "Leave Application"."Days Applied")
            {
            }
            column(Status_LeaveApplication; Status)
            {
            }
            column(Leave_Balance; LeaveBal)
            {
            }
            column(Area_LeaveApplication; "Leave Application".Area)
            {
            }
            column(ResponsibilityCenter_LeaveApplication; "Responsibility Center")
            {
            }
            column(ApplicationDate_LeaveApplication; "Application Date")
            {
            }
            column(ReportFilters; ReportFilters)
            {
            }

            trigger OnAfterGetRecord()
            begin
                HrLeaveledger.Reset();
                HrLeaveledger.SetRange("Staff No.", "Leave Application"."Employee No");
                HrLeaveledger.SetRange(Closed, false);
                HrLeaveledger.SetFilter("Leave Period", '..%1', "Leave Application"."Start Date");
                if HrLeaveledger.FindFirst() then begin
                    HrLeaveledger.CalcSums("No. of days");
                    LeaveBal := HrLeaveledger."No. of days";
                end;
            end;

            trigger OnPreDataItem()
            begin
                ReportFilters := GetFilters();

                // Apply Leave Type filter to the dataset - FIXED VERSION
                if LeaveTypeFilter <> '' then begin
                    // Use the correct field for filtering
                    SetRange("Leave Type", LeaveTypeFilter);

                    // Add Leave Type filter to display in header
                    if ReportFilters <> '' then
                        ReportFilters := ReportFilters + ', ';
                    ReportFilters := ReportFilters + 'Leave Type: ' + GetLeaveTypeDescriptionDirect(LeaveTypeFilter);
                end;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options';

                    field(LeaveTypeFilterField; LeaveTypeFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Leave Type';
                        ToolTip = 'Select or enter the leave type to filter by';
                        TableRelation = "Leave Type".Code where(Status = const(Active));
                    }
                }
            }
        }
    }
    labels
    {
    }

    trigger OnPreReport()
    begin

        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        HrLeaveledger: Record "HR Leave Ledger Entries Lv";
        LeaveBal: Decimal;
        ReportFilters: Text;
        LeaveTypeFilter: Code[20];

    procedure GetLeaveName("Code": Code[20]): Text[250]
    var
        LeaveTypes: Record "Leave Type";
    begin
        if LeaveTypes.Get(Code) then
            exit(LeaveTypes.Description);
    end;

    procedure GetLeaveTypeDescriptionDirect(LeaveTypeCode: Code[20]): Text[200]
    var
        LeaveTypeRec: Record "Leave Type";
    begin
        if LeaveTypeRec.Get(LeaveTypeCode) then
            exit(LeaveTypeRec.Description)
        else
            exit('No Leave type');
    end;
}


