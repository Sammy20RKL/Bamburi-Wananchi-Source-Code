#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50303 "HR Applicants Qualified Card"
{
    PageType = Card;
    SourceTable = "HR Job Applications";
    SourceTableView = where("Qualification Status" = const(Qualified));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Application No"; Rec."Application No")
                {
                    ApplicationArea = Basic;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = Basic;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = Basic;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = Basic;
                }
                field("Job Applied For"; Rec."Job Applied For")
                {
                    ApplicationArea = Basic;
                }
                field(Qualified; Rec.Qualified)
                {
                    ApplicationArea = Basic;
                }
                field("Date of Interview"; Rec."Date of Interview")
                {
                    ApplicationArea = Basic;
                }
                field("From Time"; Rec."From Time")
                {
                    ApplicationArea = Basic;
                }
                field("To Time"; Rec."To Time")
                {
                    ApplicationArea = Basic;
                }
                field(Venue; Rec.Venue)
                {
                    ApplicationArea = Basic;
                }
                field("Interview Type"; Rec."Interview Type")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Applicant)
            {
                Caption = 'Applicant';
                action("Send Interview Invitation")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Interview Invitation';
                    Image = SendMail;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin

                        //IF CONFIRM('Send this Requisition for Approval?',TRUE)=FALSE THEN EXIT;
                        if not Confirm(Text002, false) then exit;

                        Rec.TestField(Qualified, Rec.Qualified = true);
                        HRJobApplications.SetRange(HRJobApplications."Application No", Rec."Application No");
                        CurrPage.SetSelectionFilter(HRJobApplications);
                        if HRJobApplications.Find('-') then
                            //GET E-MAIL PARAMETERS FOR JOB APPLICATIONS
                            HREmailParameters.Reset;
                        HREmailParameters.SetRange(HREmailParameters."Associate With", HREmailParameters."associate with"::"Interview Invitations");
                        if HREmailParameters.Find('-') then begin
                            repeat
                                HRJobApplications.TestField(HRJobApplications."E-Mail");
                            // SMTP.CreateMessage(HREmailParameters."Sender Name", HREmailParameters."Sender Address", HRJobApplications."E-Mail",
                            // HREmailParameters.Subject, 'Dear' + ' ' + HRJobApplications."First Name" + ' ' + HREmailParameters.Body + ' ' + HRJobApplications."Job Applied for Description" + ' ' + 'applied on' + Format(Rec."Date Applied") + ' ' + HREmailParameters."Body 2" +//,TRUE);
                            // Format(HRJobApplications."Date of Interview") + ' ' + 'Starting ' + ' ' + Format(HRJobApplications."From Time") + ' ' + 'to' + Format(HRJobApplications."To Time") + ' ' + 'at' + HRJobApplications.Venue + '.', true);
                            //HREmailParameters.Body,TRUE);
                            // SMTP.Send();
                            until HRJobApplications.Next = 0;

                            if Confirm('Do you want to send this invitation alert?', false) = true then begin
                                Rec."Interview Invitation Sent" := true;
                                Rec.Modify;
                                Message('All Qualified shortlisted candidates have been invited for the interview ')
                            end;
                        end;
                    end;
                }
            }
        }
    }

    var
        Text001: label 'Are you sure you want to Upload Applicants Details to the Employee Card?';
        Text002: label 'Are you sure you want to Send this Interview invitation?';
        HRJobApplications: Record "HR Job Applications";
        HREmailParameters: Record "HR E-Mail Parameters";
    // SMTP: Codeunit 400;
}

