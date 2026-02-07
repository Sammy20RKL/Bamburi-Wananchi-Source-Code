report 53019 "Leave Report"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './layout/LeaveReport.rdlc';
    Caption = 'Leave Report';
    dataset
    {
        dataitem("Leave Application"; "Leave Application")
        {
            RequestFilterFields = "Application No";

            column(Comp_Name; CompanyInfo.Name)
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
            column(Logo; CompanyInfo.Picture)
            {
            }
            column(Post_Code; CompanyInfo."Post Code")
            {
            }
            column(Email; CompanyInfo."E-Mail")
            {
            }
            column(Website; CompanyInfo."Home Page")
            {
            }
            column(Country; CompanyInfo."Country/Region Code")
            {
            }
            column(Employee_No; "Leave Application"."Employee No")
            {
            }
            column(Application_No; "Leave Application"."Application No")
            {
            }
            column(Leave_Code; GetLeaveName("Leave Application"."Leave Code"))
            {
            }
            column(Days_Applied; "Leave Application"."Days Applied")
            {
            }
            column(Start_Date; "Leave Application"."Start Date")
            {
            }
            column(End_Date; "Leave Application"."End Date")
            {
            }
            column(Application_Date; "Leave Application"."Application Date")
            {
            }
            column(Employee_Name; "Leave Application"."Employee Name")
            {
            }

            column(leaveDescription; GetLeaveName("Leave Application"."Leave Code"))
            {
            }
            column(Resumption_Date1; "Resumption Date")
            {
            }
            column(Duties_Taken_Over; "Leave Application"."Duties Taken Over By")
            {
            }
            column(Taken_Over_Name; "Leave Application"."Relieving Name")
            {
            }
            column(Department; "Leave Application"."Shortcut Dimension 2 Code")
            {
            }
            column(Prepared_By; GetUserName(Approver[1]))
            {
            }
            column(Date_Prepared; DateApproved[1])
            {
            }
            column(Prepared_By_Signature; Users1."Immediate Supervisor")
            {
            }
            column(First_Approver; GetUserName(Approver[2]))
            {
            }
            column(First_Date_Approved; DateApproved[2])
            {
            }
            column(First_Approver_Signature; Users2."Immediate Supervisor")
            {
            }
            column(Second_Approver; GetUserName(Approver[3]))
            {
            }
            column(Second_Date_Approved; DateApproved[3])
            {
            }
            column(Third_Approver; GetUserName(Approver[4]))
            {
            }
            column(Third_Date_Approved; DateApproved[4])
            {
            }

            trigger OnAfterGetRecord()
            begin
                // Calculate FlowFields to get proper start and end dates
                // CalcFields("Start Date", "End Date");

                Approver[1] := "Leave Application"."User ID";
                DateApproved[1] := CreateDateTime("Leave Application"."Application Date", "Leave Application"."Application Time");

                ApprovalEntries.Reset();
                ApprovalEntries.SetCurrentKey("Sequence No.");
                ApprovalEntries.SetRange("Table ID", Database::"Leave Application");
                ApprovalEntries.SetRange("Document No.", "Leave Application"."Application No");
                ApprovalEntries.SetRange(Status, ApprovalEntries.Status::Approved);
                if ApprovalEntries.Find('-') then
                    repeat
                        if ApprovalEntries."Sequence No." = 1 then begin
                            Approver[2] := ApprovalEntries."Last Modified By User ID";
                            DateApproved[2] := ApprovalEntries."Last Date-Time Modified";
                        end;
                        if ApprovalEntries."Sequence No." = 2 then begin
                            Approver[3] := ApprovalEntries."Last Modified By User ID";
                            DateApproved[3] := ApprovalEntries."Last Date-Time Modified";
                        end;
                        if ApprovalEntries."Sequence No." = 3 then begin
                            Approver[4] := ApprovalEntries."Last Modified By User ID";
                            DateApproved[4] := ApprovalEntries."Last Date-Time Modified";
                        end;
                    until ApprovalEntries.Next() = 0;
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

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;

    var
        ApprovalEntries: Record "Approval Entry";
        CompanyInfo: Record "Company Information";
        Users1: Record "User Setup";
        Users2: Record "User Setup";
        Approver: array[10] of Code[30];
        DateApproved: array[10] of DateTime;

    procedure GetLeaveName("Code": Code[20]): Text[250]
    var
        LeaveTypes: Record "Leave Type";
    begin
        if LeaveTypes.Get(Code) then
            exit(LeaveTypes.Description);
    end;

    procedure GetUserName(User: Code[20]): Text[250]
    begin
        // IF UserSetup.GET(User) THEN
        //  BEGIN
        //    IF Employee.GET(UserSetup.Picture) THEN
        //      EXIT(Employee."First Name"+' '+Employee."Middle Name"+' '+Employee."Last Name");
        //  END;

        exit(User);
    end;
}