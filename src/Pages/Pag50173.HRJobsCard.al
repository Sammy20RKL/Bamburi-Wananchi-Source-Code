#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50173 "HR Jobs Card"
{
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Functions,Job';
    SourceTable = "HR Jobss";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Job ID"; Rec."Job ID")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Job Description"; Rec."Job Description")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Position Reporting to"; Rec."Position Reporting to")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field(Grade; Rec.Grade)
                {
                    ApplicationArea = Basic;
                }
                field("Main Objective"; Rec."Main Objective")
                {
                    ApplicationArea = Basic;
                }
                field("Supervisor/Manager"; Rec."Supervisor/Manager")
                {
                    ApplicationArea = Basic;
                }
                field("Supervisor Name"; Rec."Supervisor Name")
                {
                    ApplicationArea = Basic;
                }
                field("No of Posts"; Rec."No of Posts")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Occupied Positions"; Rec."Occupied Positions")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Vacant Positions"; Rec."Vacant Positions")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Requisitions"; Rec."Employee Requisitions")
                {
                    ApplicationArea = Basic;
                }
                field("Key Position"; Rec."Key Position")
                {
                    ApplicationArea = Basic;
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
                field("Is Supervisor"; Rec."Is Supervisor")
                {
                    ApplicationArea = Basic;
                }
                field("G/L Account"; Rec."G/L Account")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Promoted;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
            }
        }
        area(factboxes)
        {
            part(Control1102755004; "HR Jobs Factbox")
            {
                SubPageLink = "Job ID" = field("Job ID");
            }
            systempart(Control1102755006; Outlook)
            {
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Job)
            {
                action("Raise Requisition")
                {
                    ApplicationArea = Basic;
                    Caption = 'Raise Requisition';
                    Image = Job;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "HR Employee Requisition Card";
                    RunPageLink = "Job ID" = field("Job ID");
                }
                action(Requirements)
                {
                    ApplicationArea = Basic;
                    Caption = 'Requirements';
                    Image = Card;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "HR Job Requirement Lines";
                    RunPageLink = "Job Id" = field("Job ID");
                }
                action(Responsibilities)
                {
                    ApplicationArea = Basic;
                    Caption = 'Responsibilities';
                    Image = JobResponsibility;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "HR Job Responsiblities Lines";
                    RunPageLink = "Job ID" = field("Job ID");
                }
                action(Occupants)
                {
                    ApplicationArea = Basic;
                    Caption = 'Occupants';
                    Image = ContactPerson;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "HR Job Occupants";
                    RunPageLink = "Job ID" = field("Job ID");
                }
            }
            group(Functions)
            {
                Caption = 'Functions';
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Enabled = not OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    begin
                        //IF ApprovalsMgmt.CheckSalesApprovalsWorkflowEnabled(Rec) THEN
                        // ApprovalsMgmt.OnSendSalesDocForApproval(Rec);
                        Rec.Status := Rec.Status::Approved;
                        Rec.Modify;
                        Message('Job Approved!')
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    begin
                        //ApprovalsMgmt.OnCancelSalesApprovalRequest(Rec);
                        Rec.Status := Rec.Status::New;
                        Rec.Modify;
                        Message('Approval Cancelled!')
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        UpdateControls;

        Rec.Validate(Rec."Vacant Positions");
    end;

    var
        HREmployees: Record "HR Employees";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowWorkflowStatus: Boolean;

    local procedure UpdateControls()
    begin
        if Rec.Status = Rec.Status::New then begin
            CurrPage.Editable := true;
        end else begin
            CurrPage.Editable := false;
        end;
    end;


    procedure RecordLinkCheck(job: Record "HR Jobss") RecordLnkExist: Boolean
    var
        objRecordLnk: Record "Record Link";
        TableCaption: RecordID;
        objRecord_Link: RecordRef;
    begin
        objRecord_Link.GetTable(job);
        TableCaption := objRecord_Link.RecordId;
        objRecordLnk.Reset;
        objRecordLnk.SetRange(objRecordLnk."Record ID", TableCaption);
        if objRecordLnk.Find('-') then exit(true) else exit(false);
    end;
}

