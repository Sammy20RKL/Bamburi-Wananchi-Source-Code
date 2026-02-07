Page 50145 "Member Re-Application Page"
{
    ApplicationArea = All;
    Caption = 'Member Re-Application Page';
    PageType = Card;
    SourceTable = "Member Reapplication";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    Editable = false;
                }
                field("Member No."; Rec."Member No.")
                {
                    ToolTip = 'Specifies the value of the Member No. field.';
                }
                field("Member Name"; Rec."Member Name")
                {
                    ToolTip = 'Specifies the value of the Member Name field.';
                    Editable = false;
                }
                field("Share Capital"; Rec."Share Capital")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Caption = 'Current Share capital';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Caption = 'Workflow Status';
                    trigger OnValidate()
                    begin
                        UpdateControl();
                    end;

                }
                field("Reason for Re-Application"; Rec."Reason for Re-Application")
                {
                    ToolTip = 'Specifies the value of the Reason for Re-Application field.';
                }
                field("Reason for Exit"; Rec."Reason for Exit")
                {
                    ToolTip = 'Specifies the value of the Reason for Exit field.';
                    Editable = false;
                }
                field("Re-Application By"; Rec."Re-Application By")
                {
                    ToolTip = 'Specifies the value of the Re-Application By field.';
                    Editable = false;
                }
                field("Re-Application On"; Rec."Re-Application On")
                {
                    ToolTip = 'Specifies the value of the Re-Application On field.';
                    Editable = false;
                }
                field("Re-Application status"; Rec."Re-Application status")
                {
                    ToolTip = 'Specifies the value of the Re-Application status field.';
                    Editable = false;
                }
                field("Status on Exit"; Rec."Status on Exit")
                {
                    ToolTip = 'Specifies the value of the Status on Exit field.';
                    Editable = false;
                }
                field("Exit Date"; Rec."Exit Date")
                {
                    ToolTip = 'Specifies the value of the Exit Date field.';
                    Editable = false;
                }
                field("Exited By"; Rec."Exited By")
                {
                    ToolTip = 'Specifies the value of the Exited By field.';
                    Editable = false;
                }
            }

        }


    }
    actions
    {
        area(Processing)
        {
            action("Reactivate Member")
            {
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    myInt: Integer;
                    GenJournalLine: Record "Gen. Journal Line";
                    LineNo: integer;
                    MembershipExit: Record "Membership Exist";

                    Gnljnline: Record "Gen. Journal Line";
                    TotalAmount: Decimal;
                    NetMemberAmounts: Decimal;
                    Doc_No: Code[20];
                    DActivity: code[20];
                    DBranch: Code[50];
                    Cust: Record customer;
                    Generalsetup: Record "Sacco General Set-Up";
                    RunningBal: Decimal;
                    SFactory: Codeunit "SWIZZSFT Factory";
                    InterestTobeRecovered: Decimal;
                    LoanTobeRecovered: Decimal;

                begin
                    TemplateName := 'GENERAL';
                    BatchName := 'REJOINFEE';
                    GenSetup.Get();

                    /*  IF CONFIRM('Are You Sure You Want To Re-Join This Member?', TRUE) = FALSE THEN EXIT;

                      //IF GenSetUp."Charge BOSA Registration Fee"=TRUE THEN BEGIN

                      GenJournalLine.RESET;
                      GenJournalLine.SETRANGE("Journal Template Name", 'GENERAL');
                      GenJournalLine.SETRANGE("Journal Batch Name", 'REJOINFEE');
                      GenJournalLine.DELETEALL;


                      Cust.RESET;
                      Cust.SETRANGE(Cust."No.", Rec."Member No.");
                      IF Cust.FIND('-') THEN BEGIN

                          MESSAGE('%1', Cust."No.");
                          Cust.Blocked := Cust.Blocked::" ";
                          Cust.Status := Cust.Status::Active;
                          Cust."Withdrawal Posted" := FALSE;
                          Cust."Rejoining Date" := TODAY;

                          Cust."Rejoin status" := TRUE;
                          Cust.MODIFY;
                          // END;

                          LineNo := LineNo + 10000;
                          Message('Line No is %1', LineNo);

                          GenJournalLine.INIT;
                          GenJournalLine."Journal Template Name" := 'GENERAL';
                          GenJournalLine."Journal Batch Name" := 'REJOINFEE';
                          GenJournalLine."Document No." := Rec."Member No.";
                          GenJournalLine."Line No." := LineNo;
                          GenJournalLine."Account Type" := GenJournalLine."Account Type"::Customer;
                          GenJournalLine."Account No." := Rec."Member No.";
                          GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                          GenJournalLine."Posting Date" := TODAY;
                          GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::"Deposit Contribution";
                          GenJournalLine."External Document No." := 'REJOINFEE/';///+FORMAT("Payroll No");
                          GenJournalLine.Description := 'Membership Rejoining Fee';
                          GenJournalLine.Amount := 3000;//GenSetUp."Rejoining Fee";
                          GenJournalLine.VALIDATE(GenJournalLine.Amount);
                          GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
                          GenJournalLine."Bal. Account No." := '301412';//GenSetUp."Rejoining Fees Account";
                          GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");

                          GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                          GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");

                          IF GenJournalLine.Amount <> 0 THEN
                              GenJournalLine.INSERT;
                          GenJournalLine.RESET;
                          GenJournalLine.SETRANGE("Journal Template Name", 'GENERAL');
                          GenJournalLine.SETRANGE("Journal Batch Name", 'REJOINFEE');

                          IF GenJournalLine.FIND('-') THEN BEGIN
                              CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Sacco", GenJournalLine);
                              Message('Posted Successfully');
                          END;
                          //END;


                          MembershipExit.RESET;
                          MembershipExit.SETRANGE(MembershipExit."Member No.", Rec."Member No.");
                          IF MembershipExit.FIND('-') THEN BEGIN
                              MESSAGE(MembershipExit."No.");
                              MembershipExit.DELETEALL;


                              //   "Application Date":=TODAY;
                              //   "Registration Date":=TODAY;
                              //   "Last Payment Date":=0D;
                              //   "Last Date Modified":=0D;
                              //   "Status - Withdrawal App.":="Status - Withdrawal App."::Open;
                              //   "Withdrawal Application Date":=0D;
                              //   "Withdrawal Date":=0D;
                              //   "Member Category":="Member Category"::"Account Reactivation";
                              //   

                              //   MODIFY;
                          END;
                      END;
                      //CurrPage.CLOSE;
                      // Cust.reset;
                      // Cust.SetRange(Cust."No.", Rec."Member No.");
                      // if Cust.FindSet() then begin
                      //     Cust.Status := Cust.Status::Active;
                      //     Cust."Reason For Membership Withdraw" := ' ';
                      //     Cust."Re-instated" := true;
                      //     Cust."Rejoining Date" := Rec."Re-Application On";
                      //     //Cust.rejoined := Rec."Re-Application By";
                      //     Cust.Modify();
                      // end;
                      Rec.Reactivated := true;*/

                    IF Cust.get(Rec."Member No.") then begin
                        if Confirm('Proceed with Member Reapplication Process ?', false) = false then begin
                            exit;
                        end else begin
                            // 1. Ensure the status is not Approved
                            Rec.TestField(Status, Rec.Status::Approved); // This throws an error if not Approved, so we invert the logic below

                            if Rec.Status <> Rec.Status::Approved then
                                Error('The loan must be approved before reapplying.');
                            //....................Ensure that If Batch doesnt exist then create
                            IF NOT GenBatch.GET(TemplateName, BatchName) THEN BEGIN
                                GenBatch.INIT;
                                GenBatch."Journal Template Name" := TemplateName;
                                GenBatch.Name := BatchName;
                                GenBatch.INSERT;
                            END;
                            //....................Reset General Journal Lines
                            GenJournalLine.RESET;
                            GenJournalLine.SETRANGE("Journal Template Name", TemplateName);
                            GenJournalLine.SETRANGE("Journal Batch Name", BatchName);
                            GenJournalLine.DELETEALL;

                            GenSetUp.Validate(GenSetUp."Rejoining Fees Account");
                            //................................................
                            DActivity := Cust."Global Dimension 1 Code";
                            DBranch := Cust."Global Dimension 2 Code";
                            //.................................
                            // RunningBal := 0;
                            // RunningBal := Rec."Member Deposits";
                            Doc_No := Rec."No.";
                            //Message('Post Start!%1, Duty is %2, Fee of rejoining %3', Rec."Member No.", GenSetUp."Excise Duty(%)", Gensetup."Rejoining Fee");


                            //Debit Member Deposist
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."Transaction Type"::"Deposit Contribution",
                            GenJournalLine."Account Type"::Customer, Rec."Member No.", Today, Gensetup."Rejoining Fee", 'BOSA', 'BC24REJOINFEE/', 'For Member No. MemNo' + Rec."Member No.", '');


                            //Excise Duty 15% Charges
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::"G/L Account", GenSetUp."Excise Duty Account", Today, (Gensetup."Rejoining Fee" * GenSetUp."Excise Duty(%)" / 100) * -1, 'BOSA', Rec."Member No.", 'Excise Duty charge On Rejoining', '');

                            //Credit  Bank
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::"G/L Account", GenSetUp."Rejoining Fees Account", Today, (1 - (GenSetUp."Excise Duty(%)" / 100)) * Gensetup."Rejoining Fee" * -1, 'BOSA', 'REJOINFEE/', 'Credit ReJoinining Fees Account', '');
                        end;

                    end;
                    //............................Post Lines
                    GenJournalLine.RESET;
                    GenJournalLine.SETRANGE("Journal Template Name", TemplateName);
                    GenJournalLine.SETRANGE("Journal Batch Name", BatchName);
                    IF GenJournalLine.FIND('-') THEN BEGIN
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post Batch", GenJournalLine);
                        Message('Posted Successfully!');

                        Cust.Blocked := Cust.Blocked::" ";
                        Cust.Status := Cust.Status::Active;
                        Cust."Withdrawal Posted" := FALSE;
                        //Cust."Rejoining Date" := TODAY;
                        Cust."Re-instated" := true;
                        Cust."Rejoining Date" := Rec."Re-Application On";

                        Cust."Rejoin status" := TRUE;
                        Cust.MODIFY;

                        MembershipExit.RESET;
                        MembershipExit.SETRANGE(MembershipExit."Member No.", Rec."Member No.");
                        IF MembershipExit.FIND('-') THEN BEGIN
                            MESSAGE(MembershipExit."No.");
                            MembershipExit.DELETEALL;
                        end;

                        Rec.Reactivated := true;

                    end;
                END;
            }
            action("Send Approval Request")
            {
                Promoted = true;
                PromotedCategory = Process;
                Enabled = (not OpenApprovalEntriesExist) AND EnabledApprovalWorkflowsExist AND (not RecordApproved);

                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    if Rec.Status <> Rec.Status::Open then
                        Message('The document has already been sent for approval')
                    else
                        SrestepApprovalsCodeUnit.SendMemberReapplicationRequestForApproval(rec."No.", rec);
                end;
            }
            action("Cancel Approval Request")
            {
                ApplicationArea = Basic;
                Caption = 'Cancel Approval Request';
                Image = Cancel;
                Enabled = CanCancelApprovalForRecord;


                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()

                begin
                    if Confirm('Cancel Approval?', false) = true then begin
                        SrestepApprovalsCodeUnit.CancelMemberReapplicationRequestForApproval(rec."No.", Rec);
                    end;
                end;
            }
        }
    }
    var
        Cust: Record Customer;
        GenSetUp: Record "Sacco General Set-Up";
        SrestepApprovalsCodeUnit: Codeunit SurestepApprovalsCodeUnit;
        //Approval Controls
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        OpenApprovalEntriesExist: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        RecordApproved: Boolean;
        CanCancelApprovalForRecord: Boolean;

        TemplateName: Code[20];
        BatchName: Code[20];
        GenBatch: Record "Gen. Journal Batch";


    trigger OnAfterGetRecord()
    begin
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(REC.RecordId);//Return No and allow sending of approval request.

        EnabledApprovalWorkflowsExist := true;
        //............................
        UpdateControl();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        UpdateControl();
    end;

    local procedure UpdateControl()
    begin
        if Rec.Status = Rec.Status::Pending then begin
            CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        end else
            if Rec.Status = Rec.Status::Approved then begin
                RecordApproved := true;
                CanCancelApprovalForRecord := false;
            end;
    end;


}
