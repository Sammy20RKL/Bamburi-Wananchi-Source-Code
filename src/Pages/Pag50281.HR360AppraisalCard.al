#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50281 "HR 360 Appraisal Card"
{
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Functions,Appraisal';
    SourceTable = "HR Appraisal Header";

    layout
    {
        area(content)
        {
            group("HR Appraisal Header")
            {
                field("Appraisal No"; Rec."Appraisal No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Promoted;
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Job Description"; Rec."Job Description")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Importance = Promoted;
                }
                field(Supervisor; Rec.Supervisor)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Appraisal Period"; Rec."Appraisal Period")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Appraisal Date"; Rec."Appraisal Date")
                {
                    ApplicationArea = Basic;
                }
                field("Evaluation Period Start"; Rec."Evaluation Period Start")
                {
                    ApplicationArea = Basic;
                }
                field("Evaluation Period End"; Rec."Evaluation Period End")
                {
                    ApplicationArea = Basic;
                }
                field("Appraisal Stage"; Rec."Appraisal Stage")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Appraisal Method"; Rec."Appraisal Method")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin

                        //Testfields
                        Rec.TestField(Status, Rec.Status::Open);
                        Rec.TestField("Appraisal Method");

                        if Confirm(Text0003, false, Rec."Appraisal Method") = false then begin
                            Error('Process aborted, Press F5 to discard changes');
                        end else begin
                            //Delete Lines
                            HRAppLines.Reset;
                            HRAppLines.SetRange(HRAppLines."Appraisal No", Rec."Appraisal No");
                            HRAppLines.SetRange(HRAppLines."Appraisal Period", Rec."Appraisal Period");
                            HRAppLines.SetRange(HRAppLines."Employee No", Rec."Employee No");
                            if HRAppLines.Find('-') then begin
                                HRAppLines.DeleteAll;
                                //Subpage Visibility
                                fn_ShowSubPages;
                            end;

                        end;
                    end;
                }
                field("Appraisal Approval Status"; Rec."Appraisal Approval Status")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Importance = Promoted;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Importance = Promoted;
                }
            }
            part(PersonalObjectives; "HR Appraisal Lines-Objectives")
            {
                ShowFilter = false;
            }
            part(JobSpecificObjectives; "HR 360 Appraisal Lines - JS")
            {
                ShowFilter = false;
            }
            part(EmployeeSubordinatesObjectives; "HR 360 Appraisal Lines - JS")
            {
                ShowFilter = false;
                Visible = SubPageVisible;
            }
            part(PeerObjectives; "HR 360 Appraisal Lines - JS")
            {
                ShowFilter = false;
                Visible = SubPageVisible;
            }
            part(ExternalSourcesObjectives; "HR 360 Appraisal Lines - ExS")
            {
                ShowFilter = false;
                Visible = SubPageVisible;
            }
        }
        area(factboxes)
        {
            systempart(Control43; Outlook)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Approvals)
            {
                Caption = 'Approvals';
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
                    end;
                }
                action("Print Form")
                {
                    ApplicationArea = Basic;
                    Caption = 'Print Form';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        HRAppHeader.Reset;
                        HRAppHeader.SetRange(HRAppHeader."Appraisal No", Rec."Appraisal No");
                        //     if HRAppHeader.Find('-') then
                        //         // Report.Run(Report::"HR Appraisal Form", true, true, HRAppHeader);
                    end;
                }
            }
            group(ActionGroup1000000008)
            {
                Caption = 'Functions';
                action("Load Appraisal Sections")
                {
                    ApplicationArea = Basic;
                    Image = CreateInteraction;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    begin
                        Rec.TestField("Job Title");
                        Rec.TestField(Status, Rec.Status::Open);
                        Rec.TestField("Appraisal Stage", Rec."appraisal stage"::"Target Setting");


                        if Confirm(Text0001, false) = false then exit;

                        //Job Specific
                        HRAppEvalAreas.Reset;
                        HRAppEvalAreas.SetRange(HRAppEvalAreas."Categorize As", HRAppEvalAreas."categorize as"::"Job Specific");
                        HRAppEvalAreas.SetRange(HRAppEvalAreas."Assign To", Rec."Job Title");
                        HRAppEvalAreas.SetRange(HRAppEvalAreas."Appraisal Period", Rec."Appraisal Period");
                        HRAppEvalAreas.SetRange(HRAppEvalAreas.Blocked, false);
                        if HRAppEvalAreas.Find('-') then begin
                            HRAppLines.Reset;
                            HRAppLines.SetRange(HRAppLines."Appraisal No", Rec."Appraisal No");
                            HRAppLines.SetRange(HRAppLines."Appraisal Period", Rec."Appraisal Period");
                            HRAppLines.SetRange(HRAppLines."Employee No", Rec."Employee No");
                            HRAppLines.SetRange(HRAppLines."Categorize As", HRAppLines."categorize as"::"Job Specific");
                            if HRAppLines.Find('-') then begin
                                HRAppLines.DeleteAll;
                                fn_LoadSections;
                            end else begin
                                fn_LoadSections;
                            end;
                        end else begin
                            //if no sections are found
                            Error(Text0002, Rec."Job Title");
                        end;

                        //Load 360 Sections
                        case Rec."Appraisal Method" of
                            Rec."appraisal method"::"360 Appraisal":
                                begin
                                    //Load 360 Sections
                                    fn_Load360Sections;
                                end;
                        end;
                        //End for 360
                    end;
                }
                action(SendSupervisor)
                {
                    ApplicationArea = Basic;
                    Caption = 'Send to Supervisor';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    begin
                        Rec.TestField("Appraisal Stage", Rec."appraisal stage"::"Target Setting");
                        Rec.TestField("Employee No");

                        if Confirm('Send to supervisor?', false) = false then exit;

                        Rec."Appraisal Stage" := Rec."appraisal stage"::"Target Approval";
                        Message('Appraisal sent to supervisor');
                    end;
                }
                action(ReturnAppraisee)
                {
                    ApplicationArea = Basic;
                    Caption = 'Return to Appraisee';
                    Image = ReopenCancelled;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    begin
                        Rec.TestField("Appraisal Stage", Rec."appraisal stage"::"Target Approval");

                        if Confirm('Return to appraisee?', false) = false then exit;

                        Rec."Appraisal Stage" := Rec."appraisal stage"::"Target Setting";
                        Message('Appraisal returned to appraisee');
                    end;
                }
                action(ReturnSupervisor)
                {
                    ApplicationArea = Basic;
                    Caption = 'Return to Supervisor';
                    Image = Return;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    begin
                        Rec.TestField("Appraisal Stage", Rec."appraisal stage"::"End Year Evalauation");

                        if Confirm('Return to supervisor?', false) = false then exit;

                        Rec."Appraisal Stage" := Rec."appraisal stage"::"Target Approval";
                        Message('Appraisal returned to supervisor');
                    end;
                }
                action(ApproveTargets)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approve Targets';
                    Image = Approval;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    begin
                        Rec.TestField("Appraisal Stage", Rec."appraisal stage"::"Target Approval");
                        Rec.TestField("Employee No");

                        if Confirm('Approve targets?', false) = false then exit;

                        Rec."Appraisal Stage" := Rec."appraisal stage"::"End Year Evalauation";
                        Message('Appraisal targets approved');
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin

        //GET APPLICANT DETAILS FROM HR EMPLOYEES TABLE AND COPY THEM TO THE GOAL SETTING TABLE
        HREmp.Reset;
        if HREmp.Get(Rec."Employee No") then begin
            Rec."Employee Name" := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
            Rec."Date of Employment" := HREmp."Date Of Joining the Company";
            Rec."Global Dimension 1 Code" := HREmp."Global Dimension 1 Code";
            Rec."Global Dimension 2 Code" := HREmp."Global Dimension 2 Code";
            Rec."Job Title" := HREmp."Job Specification";
            Rec."Contract Type" := HREmp."Contract Type";
            Rec."User ID" := HREmp."User ID";
            //Supervisor
            Rec.Supervisor := HREmpCard.GetSupervisor(Rec."User ID");
            //Superisor ID
            Rec."Supervisor ID" := HREmpCard.GetSupervisorID(Rec."User ID");
            HREmp.CalcFields(HREmp.Picture);
            Rec.Picture := HREmp.Picture;


        end else begin
            Error('Employee No' + ' ' + Rec."Employee No" + ' ' + 'is not assigned to any employee. Consult the HR Officer so as to be setup as an employee')
        end;



        //Show Hide Subpages
        fn_ShowSubPages;
    end;

    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowWorkflowStatus: Boolean;
        HRAppEvalAreas: Record 51220;
        HRAppLines: Record 51217;
        Text0001: label 'Load Appraisal Sections?. \\NB: Existing Lines will be deleted';
        HRAppLines2: Record 51217;
        HREmp: Record 51160;
        HREmpCard: Page "HR Employee Card";
        HRAppHeader: Record 51216;
        Text0002: label 'No job specific sections for [Job ID: %1] are defined';
        LastLineNo: Integer;
        HRJobResp: Record 51176;
        HRSetup: Record 51181;
        HREmp2: Record 51160;
        SubPageVisible: Boolean;
        Text0003: label 'Change Appraisal Method to [%1]? \\NB: Existing Lines will be deleted';


    procedure enableDisable() enableDisable: Boolean
    begin
        enableDisable := false;
    end;


    procedure fn_LoadSections()
    begin
        //Load Job Specific Evaluation Sections

        repeat
            //Get last no.
            HRAppLines2.Reset;
            if HRAppLines2.Find('+') then begin
                LastLineNo := HRAppLines2."Line No";
            end else begin
                LastLineNo := 1;
            end;

            HRAppLines.Init;

            HRAppLines."Line No" := LastLineNo + 1;
            HRAppLines."Appraisal No" := Rec."Appraisal No";
            HRAppLines."Appraisal Period" := Rec."Appraisal Period";
            HRAppLines."Employee No" := Rec."Employee No";
            HRAppLines."Categorize As" := HRAppEvalAreas."Categorize As";
            HRAppLines."Sub Category" := HRAppEvalAreas."Sub Category";
            HRAppLines."Perfomance Goals and Targets" := HRAppEvalAreas.Description;

            HRAppLines.Insert;
        until HRAppEvalAreas.Next = 0;

        //message('Process Complete');
    end;


    procedure fn_Load360Sections()
    begin

        //Employee's Subordinates
        HRAppEvalAreas.Reset;
        HRAppEvalAreas.SetRange(HRAppEvalAreas."Categorize As", HRAppEvalAreas."categorize as"::"Employee's Subordinates");
        HRAppEvalAreas.SetRange(HRAppEvalAreas."Appraisal Period", Rec."Appraisal Period");
        if HRAppEvalAreas.Find('-') then begin
            HRAppLines.Reset;
            HRAppLines.SetRange(HRAppLines."Appraisal No", Rec."Appraisal No");
            HRAppLines.SetRange(HRAppLines."Appraisal Period", Rec."Appraisal Period");
            HRAppLines.SetRange(HRAppLines."Employee No", Rec."Employee No");
            HRAppLines.SetRange(HRAppLines."Categorize As", HRAppLines."categorize as"::"Employee's Subordinates");
            if HRAppLines.Find('-') then begin
                HRAppLines.DeleteAll;
                fn_LoadSections;
            end else begin
                fn_LoadSections;
            end;
        end;

        //Employee's Peers
        HRAppEvalAreas.Reset;
        HRAppEvalAreas.SetRange(HRAppEvalAreas."Categorize As", HRAppEvalAreas."categorize as"::"Employee's Peers");
        HRAppEvalAreas.SetRange(HRAppEvalAreas."Appraisal Period", Rec."Appraisal Period");
        if HRAppEvalAreas.Find('-') then begin
            HRAppLines.Reset;
            HRAppLines.SetRange(HRAppLines."Appraisal No", Rec."Appraisal No");
            HRAppLines.SetRange(HRAppLines."Appraisal Period", Rec."Appraisal Period");
            HRAppLines.SetRange(HRAppLines."Employee No", Rec."Employee No");
            HRAppLines.SetRange(HRAppLines."Categorize As", HRAppLines."categorize as"::"Employee's Peers");
            if HRAppLines.Find('-') then begin
                HRAppLines.DeleteAll;
                fn_LoadSections;
            end else begin
                fn_LoadSections;
            end;
        end;

        //External Sources (Vendors and Customers)
        HRAppEvalAreas.Reset;
        HRAppEvalAreas.SetRange(HRAppEvalAreas."Categorize As", HRAppEvalAreas."categorize as"::"External Sources");
        HRAppEvalAreas.SetRange(HRAppEvalAreas."Appraisal Period", Rec."Appraisal Period");
        if HRAppEvalAreas.Find('-') then begin
            HRAppLines.Reset;
            HRAppLines.SetRange(HRAppLines."Appraisal No", Rec."Appraisal No");
            HRAppLines.SetRange(HRAppLines."Appraisal Period", Rec."Appraisal Period");
            HRAppLines.SetRange(HRAppLines."Employee No", Rec."Employee No");
            HRAppLines.SetRange(HRAppLines."Categorize As", HRAppLines."categorize as"::"External Sources");
            if HRAppLines.Find('-') then begin
                HRAppLines.DeleteAll;
                fn_LoadSections;
            end else begin
                fn_LoadSections;
            end;
        end;
    end;


    procedure fn_ShowSubPages()
    begin
        //Visbility of Subpages
        if Rec."Appraisal Method" <> Rec."appraisal method"::"360 Appraisal" then begin
            SubPageVisible := false;
        end else begin
            SubPageVisible := true;
        end;
    end;
}

