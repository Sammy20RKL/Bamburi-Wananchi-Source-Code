page 52010 "Leave Application Card"
{
    ApplicationArea = All;
    Caption = 'Leave Application Card';
    DeleteAllowed = false;
    InsertAllowed = true;
    PageType = Card;
    PopulateAllFields = true;
    PromotedActionCategories = 'New,Process,Report,Approvals,Attachments';
    RefreshOnActivate = true;
    SourceTable = "Leave Application";
    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = Rec."Status" = Rec."Status"::Open;

                label("Application Details")
                {
                    Caption = 'Application Details';
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Application No"; Rec."Application No")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Application No field';
                }
                field("Application Date"; Rec."Application Date")
                {
                    Caption = 'Date of Application';
                    ToolTip = 'Specifies the value of the Date of Application field';
                }
                field("Apply on behalf"; Rec."Apply on behalf")
                {
                    ToolTip = 'Specifies the value of the Apply on behalf field';
                }
                field("Employee No"; Rec."Employee No")
                {
                    Enabled = Rec."Apply on behalf";
                    ToolTip = 'Specifies the value of the Employee No field';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Employee Name field';

                }
                field("Email Adress"; Rec."Email Adress")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Email Adress field';

                }
                field("Employment Type"; Rec."Employment Type")
                {
                    ToolTip = 'Specifies the value of the Employment Type field';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Responsibility Center field';
                }
                field("Mobile No"; Rec."Mobile No")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Mobile No field';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field';
                }

                field("Leave Code"; Rec."Leave Code")
                {
                    Caption = 'Leave Type';
                    ToolTip = 'Specifies the value of the Leave Type field';
                    Visible = false;
                    trigger OnValidate()
                    begin



                        //     CurrPage.LeaveStatistics.Page.GetLeaveEarnedToDate(Rec."Leave Code");
                        //     rec."Leave Earned to Date" := HRManagement.GetLeaveDaysEarnedToDate(Rec, Rec."Leave Code");
                        CurrPage.Update();
                    end;

                }
                field("Leave Status"; Rec."Leave Status")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Leave Status field';
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Status field';
                }



                field("Duties Taken Over By"; Rec."Duties Taken Over By")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Duties Taken Over By field';
                }
                field("Relieving Name"; Rec."Relieving Name")
                {
                    Caption = 'Name';
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Name field';
                }
                field("Leave Allowance Payable"; Rec."Leave Allowance Payable")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Leave Allowance Payable field';
                }
            }
            part("Leave Application Type"; "Leave Application Type")
            {
                SubPageLink = "Leave Code" = field("Application No");
                Editable = Rec."Status" = Rec."Status"::Open;
            }
            part(Relievers; "Leave Relievers")
            {
                Visible = false;
                SubPageLink = "Leave Code" = field("Application No");
                Editable = Rec."Status" = Rec."Status"::Open;
            }

        }
        area(factboxes)
        {
            part(LeaveStatistics; "Leave Statistics Factbox")
            {
                Caption = 'Leave Statistics';
                SubPageLink = "No." = field("Employee No"),
                                            "Leave Period Filter" = field("Leave Period"),
                                                "Leave Type Filter" = field("Leave Code");
            }
            part(CommentsFactBox; "Approval Comments FactBox")
            {
                SubPageLink = "Document No." = field("Application No");
            }
            part("Attached Documents"; "Document Attachment Factbox")
            {
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(52146523),
                              "No." = FIELD("Application No");
            }
            //   part("Leave Relievers"; "Leave Relievers")
            // {
            //     SubPageLink = "Leave Code" = field("Leave Code");
            //     // Editable = Rec."Status" = Rec."Status"::Open;
            // }

        }
    }

    actions
    {
        area(Processing)
        {
            group(Action34)
            {
                action("Send For Approval")
                {
                    Caption = 'Send Approval Request';
                    Enabled = Rec."Status" = Rec."Status"::Open;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ToolTip = 'Executes the Send Approval Request action';

                    trigger OnAction()
                    begin

                        LeaveType.Reset();
                        LeaveType.SetRange("Leave Code", Rec."Application No");
                        if not LeaveType.FindFirst() then
                            Error('No leave application lines found. Cannot send for approval.');
                        begin

                            repeat
                                LeaveType.TestField("Leave Code");
                                LeaveType.TestField("Days Applied");
                                LeaveType.TestField("Start Date");
                                if LeaveType."Staff No" = '' then
                                    Error(LeaveReliverErr);
                            until LeaveType.Next() = 0;

                        end;

                        //Rec.TestField("Leave Code");

                        // HRMgt.CheckDocumentAttachmentExist(Rec);


                        if ApprovalsMgmt.CheckLeaveRequestWorkflowEnabled(Rec) then
                            ApprovalsMgmt.OnSendLeaveRequestApproval(Rec);
                        // Commit();
                        CurrPage.Close();
                        //
                        /*
                        //MESSAGE("Employee No");
                        //Check HOD approver
                        UserSetup.Reset();
                        UserSetup.SetRange(UserSetup."Employee No.","Employee No");
                        if UserSetup.FindFirst() then
                          begin
                            if UserSetup."HOD User" then
                              begin
                                ApprovalEntry.Reset();
                                ApprovalEntry.SetRange("Document No.","Application No");
                                ModifyHODApprovals.SETTABLEVIEW(ApprovalEntry);
                                ModifyHODApprovals.RunModal();
                              end;
                          end;
                          */
                    end;
                }
                action("Cancel Approval Request")
                {
                    Caption = 'Cancel Approval Request';
                    Enabled = Rec."Status" = Rec."Status"::"Pending Approval";
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ToolTip = 'Executes the Cancel Approval Request action';

                    trigger OnAction()
                    begin
                        ApprovalsMgmt.OnCancelLeaveRequestApproval(Rec);
                    end;
                }
                action(ViewApprovals)
                {
                    Caption = 'Approvals';
                    Enabled = Rec."Status" = Rec."Status"::"Pending Approval";
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ToolTip = 'Executes the Approvals action';

                    trigger OnAction()
                    var
                        Approvals: Record "Approval Entry";
                        Approvalentries: Page "Approval Entries";
                    begin
                        Approvals.Reset();
                        Approvals.SetRange("Table ID", Database::"Leave Application");
                        Approvals.SetRange("Document No.", Rec."Application No");
                        ApprovalEntries.SetTableView(Approvals);
                        ApprovalEntries.RunModal();
                    end;
                }
            }
            action(Attachments)
            {
                Caption = 'Attachments';
                Image = Attach;
                Promoted = true;
                PromotedCategory = Category5;
                ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                trigger OnAction()
                var
                    DocumentAttachmentDetails: Page "Document Attachment Details";
                    RecRef: RecordRef;
                begin
                    RecRef.GetTable(Rec);
                    DocumentAttachmentDetails.OpenForRecRef(RecRef);
                    DocumentAttachmentDetails.RunModal();
                end;
            }
            action("Notify Empoyees")
            {
                Image = Holiday;
                Visible = false;
                ToolTip = 'Executes the Notify Empoyees action';

                trigger OnAction()
                begin
                    //HRMgnt.SendLeaveNotice(HRMgnt.GetEmail("Employee No"),Employee.Name,"Application No","Employee No");
                end;
            }
        }
        area(Navigation)
        {
        }
        area(Reporting)
        {
            action(Print)
            {
                Caption = 'Print';
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                ToolTip = 'Executes the Print action';

                trigger OnAction()
                begin
                    LeaveApp.Reset();
                    LeaveApp.SetRange("Application No", Rec."Application No");
                    Report.Run(Report::"Leave Report", true, false, LeaveApp);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        /* 
                ApprovalEntry.Reset();
                ApprovalEntry.SetRange("Document No.", "Application No");
                if ApprovalEntry.Find('-') then begin
                    ShowCommentFactbox := CurrPage.CommentsFactBox.Page.SetFilterFromApprovalEntry(ApprovalEntry);
                end; */
    end;

    trigger OnAfterGetRecord()
    begin
        /*CalcFields("Leave balance");
        CalcFields("Balance brought forward");
        "Annual Leave Entitlement Bal":="Leave balance"+"Balance brought forward";*/

    end;

    var
        LeaveApp: Record "Leave Application";
        ApprovalsMgmt: Codeunit "Approval Mgt HR Ext";

        HRMgt: Codeunit "HR Management";
        HRManagement: Codeunit "HR Management";
        DocumentAttachment: Record "Document Attachment";
        LeaveType: Record "Leave Application Type";
        LeaveRelievers: Record "Leave Relievers";
        LeaveReliverErr: Label 'Please define at least one leave reliever';


}





