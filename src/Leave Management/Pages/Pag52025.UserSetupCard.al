page 52025 "User Setup Card"
{
    Caption = 'User Setup Card';
    PageType = Card;
    SourceTable = "User Setup";
    PromotedActionCategories = 'New,Process,Reports,Disbursement,Loan File,Cancellation,Associated Accounts,Post,Approval,Statement';
    DeleteAllowed = false;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    Caption = 'User ID';
                    ToolTip = 'Specifies the ID of the user who posted the entry, to be used, for example, in the change log.';
                }
                field("Allow Posting From"; Rec."Allow Posting From")
                {
                    ApplicationArea = All;
                    Caption = 'Allow Posting From';
                    ToolTip = 'Specifies the earliest date on which the user is allowed to post to the company.';
                }
                field("Allow Posting To"; Rec."Allow Posting To")
                {
                    ApplicationArea = All;
                    Caption = 'Allow Posting To';
                    ToolTip = 'Specifies the last date on which the user is allowed to post to the company.';
                }
                field("Allow Posting From [Time]"; Rec."Allow Posting From [Time]")
                {
                    ApplicationArea = All;
                    Caption = 'Allow Posting From [Time]';
                    ToolTip = 'Specifies the value of the Allow Posting From [Time] field.';
                }
                field("Allow Posting To [Time]"; Rec."Allow Posting To [Time]")
                {
                    ApplicationArea = All;
                    Caption = 'Allow Posting To [Time]';
                    ToolTip = 'Specifies the value of the Allow Posting To [Time] field.';
                }
                field("Allow FA Posting From"; Rec."Allow FA Posting From")
                {
                    ApplicationArea = All;
                    Caption = 'Allow FA Posting From';
                    ToolTip = 'Specifies the value of the Allow FA Posting From field.';
                }
                field("Allow FA Posting To"; Rec."Allow FA Posting To")
                {
                    ApplicationArea = All;
                    Caption = 'Allow FA Posting To';
                    ToolTip = 'Specifies the value of the Allow FA Posting To field.';
                }
                field("Register Time"; Rec."Register Time")
                {
                    ApplicationArea = All;
                    Caption = 'Register Time';
                    ToolTip = 'Specifies if you want to register time for this user. This is based on the time spent from when the user logs in to when the user logs out.';
                }

                field("Approver ID"; Rec."Approver ID")
                {
                    ApplicationArea = All;
                    Caption = 'Approver ID';
                    ToolTip = 'Specifies the user ID of the person who must approve records that are made by the user in the User ID field before the record can be released.';
                }
                field("Allow Deferral Posting From"; Rec."Allow Deferral Posting From")
                {
                    ApplicationArea = All;
                    Caption = 'Allow Deferral Posting From';
                    ToolTip = 'Specifies the earliest date on which the user is allowed to post deferrals to the company.';
                }
                field("Allow Deferral Posting To"; Rec."Allow Deferral Posting To")
                {
                    ApplicationArea = All;
                    Caption = 'Allow Deferral Posting To';
                    ToolTip = 'Specifies the last date on which the user is allowed to post deferrals to the company.';
                }

                field("Delegated From"; Rec."Delegated From")
                {
                    ApplicationArea = All;
                    Caption = 'Delegated From';
                    ToolTip = 'Specifies the value of the Delegated From field.';
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                    Caption = 'E-Mail';
                    ToolTip = 'Specifies the email address of the approver that you can use if you want to send approval mail notifications.';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                    Caption = 'Phone No.';
                    ToolTip = 'Specifies the user''s phone number.';
                }
            }
            group(Administration)
            {
                Caption = 'Administration';
                field("Allow Login After Hours"; Rec."Allow Login After Hours")
                {
                    ApplicationArea = All;
                    Caption = 'Allow Login After Hours';
                    ToolTip = 'Specifies the value of the Allow Login After Hours field.';
                }

                field("Approval Administrator"; Rec."Approval Administrator")
                {
                    ApplicationArea = All;
                    Caption = 'Approval Administrator';
                    ToolTip = 'Specifies the user who has rights to unblock approval workflows, for example, by delegating approval requests to new substitute approvers and deleting overdue approval requests.';
                }

                field("Post Bank Reconcilliation"; Rec."Post Bank Reconcilliation")
                {
                    ApplicationArea = All;
                    Caption = 'Post Bank Reconcilliation';
                    ToolTip = 'Specifies the value of the Post Bank Reconcilliation field.';
                }
                field("Post Journals"; Rec."Post Journals")
                {
                    ApplicationArea = All;
                    Caption = 'View Journals';
                    ToolTip = 'Specifies the value of the Post Journals field.';
                }
                field("Post Reversals"; Rec."Post Reversals")
                {
                    ApplicationArea = All;
                    Caption = 'Post Reversals';
                    ToolTip = 'Specifies the value of the Post Reversals field.';
                }
                field("Reverse Register"; Rec."Reverse Register")
                {
                    ApplicationArea = All;
                    Caption = 'Reverse Register';
                    ToolTip = 'Specifies the value of the Reverse Register field.';
                }
                field("Show Hidden"; Rec."Show Hidden")
                {
                    ApplicationArea = All;
                    Caption = 'Show Hidden';
                    ToolTip = 'Specifies the value of the Show Hidden field.';
                }
                field("Show All"; Rec."Show All")
                {
                    ApplicationArea = All;
                    Caption = 'Show All';
                    ToolTip = 'Specifies the value of the Show All field';
                }
                field("Password Does Not Expire"; Rec."Password Does Not Expire")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Overide Auto Password Expiry field.';
                }
                field("Allow Multiple Login"; Rec."Allow Multiple Login")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Allow Multiple Login field.';
                }
                field("User Type"; Rec."User Type")
                {
                    ApplicationArea = All;
                    Caption = 'User Type';
                    ToolTip = 'Specifies the value of the user type field.';
                }
                field("Multiple Login"; Rec."Multiple Login")
                {
                    ApplicationArea = All;
                    Caption = 'Multiple Login';
                    ToolTip = 'Specifies the value of the Multiple Login field.';
                }
                field("Responsibility Centre"; Rec."Responsibility Centre")
                {
                    ApplicationArea = All;
                    Caption = 'Responsibility Center';
                    ToolTip = 'Specifies the value of the User Responsibility Center field';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Caption = 'Global Dimension 1 Code';
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Caption = 'Global Dimension 2 Code';
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field';
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    ApplicationArea = All;
                    Caption = 'Approval Status';
                    ToolTip = 'Specifies the value of the Approval Status field.';
                }
                field("Last Password Change"; Rec."Last Password Change")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Last Password Change field.';
                }
            }
            group("Human Resource")
            {
                Caption = 'Human Resource';
                field("HOD User"; Rec."HOD User")
                {
                    ApplicationArea = All;
                    Caption = 'HOD User';
                    ToolTip = 'Specifies the value of the HOD User field';
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                    Caption = 'Employee No.';
                    ToolTip = 'Specifies the value of the Employee No. field';
                }

                field("Immediate Supervisor"; Rec."Immediate Supervisor")
                {
                    ApplicationArea = All;
                    Caption = 'Immediate Supervisor';
                    ToolTip = 'Specifies the value of the Immediate Supervisor field.';
                }
                field("HR User"; Rec."View HR Information")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the HR User field.';
                }
                field("Payroll User"; Rec."Edit HR Information")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payroll User field.';
                }

            }
            group("Funds Management")
            {
                Caption = 'Funds Management';
                field("Request Admin"; Rec."Request Admin")
                {
                    ApplicationArea = All;
                    Caption = 'Request Admin';
                    ToolTip = 'Specifies the value of the Request Admin field.';
                }
                field("Unlimited Purchase Approval"; Rec."Unlimited Purchase Approval")
                {
                    ApplicationArea = All;
                    Caption = 'Unlimited Purchase Approval';
                    ToolTip = 'Specifies that the user on this line is allowed to approve purchase records with no maximum amount. If you select this check box, then you cannot fill the Purchase Amount Approval Limit field.';
                }
                field("Unlimited Request Approval"; Rec."Unlimited Request Approval")
                {
                    ApplicationArea = All;
                    Caption = 'Unlimited Request Approval';
                    ToolTip = 'Specifies that the user on this line can approve all purchase quotes regardless of their amount. If you select this check box, then you cannot fill the Request Amount Approval Limit field.';
                }
                field("Unlimited Sales Approval"; Rec."Unlimited Sales Approval")
                {
                    ApplicationArea = All;
                    Caption = 'Unlimited Sales Approval';
                    ToolTip = 'Specifies that the user on this line is allowed to approve sales records with no maximum amount. If you select this check box, then you cannot fill the Sales Amount Approval Limit field.';
                }
                field("Time Sheet Admin."; Rec."Time Sheet Admin.")
                {
                    ApplicationArea = All;
                    Caption = 'Time Sheet Admin.';
                    ToolTip = 'Specifies if the user can edit, change, and delete time sheets.';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    Caption = 'Customer No.';
                    ToolTip = 'Specifies the value of the Customer No. field';
                }
                field("HOD Imprest Approver"; Rec."HOD Imprest Approver")
                {
                    ApplicationArea = All;
                    Caption = 'HOD Imprest Approver';
                    ToolTip = 'Specifies the value of the HOD Imprest Approver field.';
                }
                field("Imprest Account"; Rec."Imprest Account")
                {
                    ApplicationArea = All;
                    Caption = 'Imprest Account';
                    ToolTip = 'Specifies the value of the Imprest Account field.';
                }
                field("Purchase Amount Approval Limit"; Rec."Purchase Amount Approval Limit")
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Amount Approval Limit';
                    ToolTip = 'Specifies the maximum amount in LCY that this user is allowed to approve for this record.';
                }
                field("Purchase Resp. Ctr. Filter"; Rec."Purchase Resp. Ctr. Filter")
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Resp. Ctr. Filter';
                    ToolTip = 'Specifies the code for the responsibility center to which you want to assign the user.';
                }

                field("Request Amount Approval Limit"; Rec."Request Amount Approval Limit")
                {
                    ApplicationArea = All;
                    Caption = 'Request Amount Approval Limit';
                    ToolTip = 'Specifies the maximum amount in LCY that this user is allowed to approve for this record.';
                }

            }
        }
    }
    actions
    {

        area(Navigation)
        {
            action("User Signature")
            {
                ApplicationArea = All;
                Caption = 'User Signature';
                Image = Signature;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = page "User Signatures";
                RunPageLink = "User ID" = field("User ID");
                ToolTip = 'Executes the User Signature action';
            }
        }
    }
    trigger OnOpenPage()
    begin
        if Rec."Approval Status" = Rec."Approval Status"::Open then
            CurrPage.Editable := true
        else
            CurrPage.Editable := false;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        case Rec."Approval Status" of
            Rec."Approval Status"::Approved,
            Rec."Approval Status"::Deffered,
            Rec."Approval Status"::"Pending Approval":
                begin
                    Error('Approval status must be open, the current status is %1', Rec."Approval Status");
                end;
        end;

    end;

    trigger OnDeleteRecord(): Boolean
    begin

        case Rec."Approval Status" of
            Rec."Approval Status"::Approved,
            Rec."Approval Status"::Deffered,
            Rec."Approval Status"::"Pending Approval":
                begin
                    Error('Approval status must be open, the current status is %1', Rec."Approval Status");
                end;
        end;
    end;

    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
}






