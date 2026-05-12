#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50960 "Cheque Clearing BufferII"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = Transactions;
    SourceTableView = where(Posted = filter(true),
                            // Type = filter("Cheque Deposit"),
                            "Clear Cheque" = filter(false),
                            "Bounce Cheque" = filter(false));

    layout
    {
        area(content)
        {
            repeater(Control17)
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
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Expected Maturity Date"; Rec."Expected Maturity Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Cashier; Rec.Cashier)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Amount Discounted"; Rec."Amount Discounted")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Cheque Type"; Rec."Cheque Type")
                {
                    ApplicationArea = Basic;
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
                field("Clear Cheque"; Rec."Clear Cheque")
                {
                    ApplicationArea = Basic;
                }
                field("Bounce Cheque"; Rec."Bounce Cheque")
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
            group("Banker Cheque")
            {
                Caption = 'Banker Cheque';
                action("Bankers Cheque Schedule")
                {
                    ApplicationArea = Basic;
                    Caption = 'Bankers Cheque Schedule';
                    Visible = false;
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
                    Visible = false;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to Bank the selected cheques?', false) = true then begin

                            Transactions.Reset;
                            Transactions.SetRange(Type, 'Bankers Cheque');
                            Transactions.SetRange(Transactions.Select, true);
                            //Transactions.SETRANGE(Transactions."Cheque Processed",Transactions."Cheque Processed"::"0");
                            if Transactions.Find('-') then begin
                                repeat

                                    Transactions."Banked By" := UserId;
                                    Transactions."Date Banked" := Today;
                                    Transactions."Time Banked" := Time;
                                    Transactions."Banking Posted" := true;
                                    Transactions."Cheque Processed" := Transactions."Cheque Processed" = true;
                                    Transactions.Modify;
                                until Transactions.Next = 0;

                                Message('The selected bankers cheques banked successfully.');

                            end;
                        end;
                    end;
                }
                separator(Action1102760038)
                {
                }
                action("Commitement Cheque Schedule")
                {
                    ApplicationArea = Basic;
                    Caption = 'Commitement Cheque Schedule';
                    Visible = false;
                }
            }
        }
        area(processing)
        {
            action("Select All")
            {
                ApplicationArea = Basic;
                Caption = 'Select All';
                Image = SelectEntries;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    Transactions.Reset;
                    Transactions.SetRange(Type, 'Bankers Cheque');
                    Transactions.SetRange(Transactions.Select, false);
                    if Transactions.Find('-') then begin
                        repeat

                            Transactions.Select := true;
                            Transactions.Modify;
                        until Transactions.Next = 0;

                        Message('Bankers cheques selected successfully.');

                    end;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        //Filter based on branch
        /*IF UsersID.GET(USERID) THEN BEGIN
        IF UsersID.Branch <> '' THEN
        SETRANGE("Transacting Branch",UsersID.Branch);
        END;*/
        //Filter based on branch

    end;

    var
        Transactions: Record 51441;
        SupervisorApprovals: Record 51451;
        UsersID: Record User;
}

