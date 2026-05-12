#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50453 "Banking Schedule Cheques"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = Transactions;
    SourceTableView = where(Type = const('"Cheque Deposit"'),
                            Posted = const(true),
                            "Banking Posted" = const(false));

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Transaction Description"; Rec."Transaction Description")
                {
                    ApplicationArea = Basic;
                    Caption = 'Transaction';
                    Editable = false;
                }
                field("Cheque No"; Rec."Cheque No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Cheque Date"; Rec."Cheque Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Expected Maturity Date"; Rec."Expected Maturity Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("BIH No"; Rec."BIH No")
                {
                    ApplicationArea = Basic;
                }
                field(Select; Rec.Select)
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
            group(Banking)
            {
                Caption = 'Banking';
                action("Banking Schedule")
                {
                    ApplicationArea = Basic;
                    Caption = 'Banking Schedule';
                    Promoted = true;
                    Visible = true;
                }
                separator(Action1102760029)
                {
                }
                action("Process Banking")
                {
                    ApplicationArea = Basic;
                    Caption = 'Process Banking';
                    Image = PutawayLines;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to Bank the selected cheques?', false) = true then begin

                            Transactions.Reset;
                            Transactions.SetRange(Type, 'Cheque Deposit');
                            Transactions.SetRange(Transactions.Select, true);
                            Transactions.SetRange("Banking Posted", false);
                            if Transactions.Find('-') then begin
                                repeat

                                    Transactions."Banked By" := UserId;
                                    Transactions."Date Banked" := Today;
                                    Transactions."Time Banked" := Time;
                                    Transactions."Banking Posted" := true;
                                    Transactions.Modify;
                                until Transactions.Next = 0;

                                Message('The selected cheque deposits banked successfully.');

                            end;
                        end;
                    end;
                }
            }
        }
        area(processing)
        {
            action(Mail)
            {
                ApplicationArea = Basic;
                Caption = 'Mail';
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    GenSetup.Get(0);

                    /*SMTPMAIL.NewMessage(GenSetup."Sender Address",GenSetup."Email Subject"+''+'');
                    SMTPMAIL.SetWorkMode();
                    SMTPMAIL.ClearAttachments();
                    SMTPMAIL.ClearAllRecipients();
                    SMTPMAIL.SetDebugMode();
                    SMTPMAIL.SetFromAdress('info@stima-sacco.com');
                    SMTPMAIL.SetHost(GenSetup."Outgoing Mail Server");
                    SMTPMAIL.SetUserID(GenSetup."Sender User ID");
                    SMTPMAIL.AddLine(Text1);
                    SMTPMAIL.SetToAdress('razaaki@gmail.com');
                    SMTPMAIL.Send;
                    MESSAGE('the mail server %1',GenSetup."Outgoing Mail Server");   */
                    //MESSAGE('the e-mail %1',text2);

                end;
            }
            action("Banked Cheques")
            {
                ApplicationArea = Basic;
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;
                // RunObject = Report 51516434;
            }
        }
    }

    trigger OnOpenPage()
    begin
        //Filter based on branch
        /*IF UsersID.GET(USERID) THEN BEGIN
        IF UsersID.Branch <> '' THEN
        SETRANGE("Transacting Branch",UsersID.Branch);
        END;  */
        //Filter based on branch

    end;

    var
        Transactions: Record Transactions;
        SupervisorApprovals: Record "Supervisors Approval Levels";
        UsersID: Record User;
        GenSetup: Record "Sacco General Set-Up";
        Text1: label 'We are sending this mail to test the mail server';
        text2: label 'kisemy@yahoo.com';
}

