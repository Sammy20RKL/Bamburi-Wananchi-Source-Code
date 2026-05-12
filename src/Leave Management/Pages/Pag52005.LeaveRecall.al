page 52005 "Leave Recall"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Employee Off/Holiday";
    Caption = 'Leave Recall';
    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = Rec.Status = Rec.Status::Open;
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the No. field';
                }
                field("Recall Date"; Rec."Recall Date")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Recall Date field';
                }
                field("Leave Application"; Rec."Leave Application")
                {
                    ToolTip = 'Specifies the value of the Leave Application field';
                }
                field("Leave Start Date"; Rec."Leave Start Date")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Leave Start Date field';
                }
                field("Leave Ending Date"; Rec."Leave Ending Date")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Leave Ending Date field';
                }
                field("Employee No"; Rec."Employee No")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Employee No field';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Employee Name field';
                }
                field("Recalled From"; Rec."Recalled From")
                {
                    ToolTip = 'Specifies the value of the Recalled From field';
                }
                field("Recalled To"; Rec."Recalled To")
                {
                    Editable = true;
                    ToolTip = 'Specifies the value of the Recalled To field';
                }
                field("No. of Off Days"; Rec."No. of Off Days")
                {
                    Caption = 'No. of Days Recalled';
                    Editable = false;
                    ToolTip = 'Specifies the value of the No. of Days Recalled field';
                }
                field("Recalled By"; Rec."Recalled By")
                {
                    ToolTip = 'Specifies the value of the Recalled By field';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field';
                }
                field("Reason for Recall"; Rec."Reason for Recall")
                {
                    ToolTip = 'Specifies the value of the Reason for Recall field';
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Status field';
                }
                field(Completed; Rec.Completed)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Completed field';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Complete)
            {
                Promoted = true;
                PromotedCategory = Process;
                Visible = true;
                ToolTip = 'Executes the Complete action';
                Enabled = Rec.Status = Rec.Status::Released;

                trigger OnAction()
                begin
                    if Rec.Completed then begin
                        Message('The recall %1 has already been completed.', Rec."No.");
                        exit; // stop here, don't continue
                    end;

                    if Recall.Get(Rec."No.") then begin
                        HRMgnt.LeaveRecall(Rec."No.");
                        // "No. of Off Days" := EmpLeave."Recalled Days";
                        Recall.Completed := true;
                        Recall.Modify();
                        Message(Text0001, Rec."No.");
                    end;

                    CurrPage.Close();
                end;

            }
            action("Send For Approval")
            {
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Send For Approval action';
                Enabled = Rec.Status = Rec.Status::Open;

                trigger OnAction()
                begin
                    Rec.TestField("Leave Application");
                    Rec.TestField("Recalled From");
                    Rec.TestField("Recalled To");
                    Rec.TestField("Recalled By");
                    Rec.TestField("Reason for Recall");

                    if ApprovalsMgmt.CheckLeaveRecallWorkflowEnabled(Rec) then
                        ApprovalsMgmt.OnSendLeaveRecallRequestforApproval(Rec);
                    CurrPage.Close();
                end;
            }
            action("Cancel Approval Request")
            {
                Caption = 'Cancel Approval Request';
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Cancel Approval Request action';
                Enabled = Rec.Status = Rec.Status::"Pending Approval";

                trigger OnAction()
                begin
                    ApprovalsMgmt.OnCancelLeaveRecallApprovalRequest(Rec);
                    CurrPage.Close();
                end;
            }
            action(ViewApprovals)
            {
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Approvals action';

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                    DocumentType: Enum "Approval Document Type";
                begin
                    DocumentType := DocumentType::"Leave Recall";
                    ApprovalEntries.SetRecordFilters(Database::"Employee Off/Holiday", DocumentType, Rec."No.");
                    ApprovalEntries.Run();
                end;
            }
        }
    }

    var
        Recall: Record "Employee Off/Holiday";
        ApprovalsMgmt: Codeunit "Approval Mgt HR Ext";
        HRMgnt: Codeunit "HR Management";
        Text0001: Label 'The recall %1 has been completed';
}





