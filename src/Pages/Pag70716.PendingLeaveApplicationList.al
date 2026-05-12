/// <summary>
/// Page Pending Leave Application List (ID 51532716).
/// </summary>
page 70716 "Pending Leave Application List"
{
    ApplicationArea = All;
    Caption = 'Pending Leave Application List';
    // CardPageID = "Pending Leave Application Card";
    DeleteAllowed = false;
    ModifyAllowed = false;
    SourceTableView = WHERE(Status = FILTER(Pending));
    PageType = List;
    SourceTable = "HR Leave Application";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Sthng)
            {
                Editable = false;
                field("Application Code"; Rec."Application Code")
                {
                    ApplicationArea = All;
                    Caption = 'Application No';
                }
                field("Applicant Staff No."; Rec."Applicant Staff No.")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field(Names; Rec.Names)
                {
                    ApplicationArea = All;
                }
                field("Days Applied"; Rec."Days Applied")
                {
                    ApplicationArea = All;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("Return Date"; Rec."Return Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Style = Attention;
                    StyleExpr = TRUE;
                }
            }
        }
        area(factboxes)
        {
            part("HR Leave Applicaitons Factbox"; "HR Leave Applicaitons Factbox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("Applicant Staff No.");
            }
            systempart(Outlook; Outlook)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord();
    begin
        HREmp.RESET;
        IF HREmp.GET(Rec."Applicant Staff No.") THEN BEGIN
            EmpName := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
        END ELSE BEGIN
            EmpName := 'n/a';
        END;
    end;

    trigger OnOpenPage();
    begin
        //SETFILTER("Applicant User ID",USERID);
    end;

    var
        EmpName: Text;
        HREmp: Record "HR Employees";

    /// <summary>
    /// TESTFIELDS.
    /// </summary>
    procedure TESTFIELDS();
    begin
        Rec.TESTFIELD("Leave Type");
        Rec.TESTFIELD("Days Applied");
        Rec.TESTFIELD("Start Date");
        Rec.TESTFIELD(Reliever);
        Rec.TESTFIELD("Applicant Supervisor");
    end;

    /// <summary>
    /// TestLeaveFamily.
    /// </summary>
    procedure TestLeaveFamily();
    var
        LeaveFamily: Record "HR Leave Family Groups";
        LeaveFamilyEmployees: Record "HR Leave Family Employees";
        Employees: Record "HR Employees";
    begin
        /*
        LeaveFamilyEmployees.SETRANGE(LeaveFamilyEmployees."Employee No","Employee No");
        IF LeaveFamilyEmployees.FINDSET THEN //find the leave family employee is associated with
        REPEAT
          LeaveFamily.SETRANGE(LeaveFamily.Code,LeaveFamilyEmployees.Family);
          LeaveFamily.SETFILTER(LeaveFamily."Max Employees On Leave",'>0');
          IF LeaveFamily.FINDSET THEN //find the status other employees on the same leave family
            BEGIN
              Employees.SETRANGE(Employees."No.",LeaveFamilyEmployees."Employee No");
              Employees.SETRANGE(Employees."Leave Status",Employees."Leave Status"::"0");
              IF Employees.COUNT>LeaveFamily."Max Employees On Leave" THEN
              ERROR('The Maximum number of employees on leave for this family has been exceeded, Contact th HR manager for more information');
            END
        UNTIL LeaveFamilyEmployees.NEXT = 0;
        */
    end;
}
