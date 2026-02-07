Page 56170 "share Capital Card"
{
    ApplicationArea = All;
    Caption = 'share Capital Trading Card';
    PageType = Card;
    SourceTable = SharecapitalTrading;


    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the value of the No. field.';
                }

                field("Seller No"; Rec."Seller No")
                {
                    ApplicationArea = all;

                    ToolTip = 'Specifies the value of the No field.';
                }
                field("Name of Seller"; Rec."Name of Seller")
                {
                    ToolTip = 'Specifies the value of the Name of Seller field.';
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Seller Share Balance"; Rec."Seller Share Balance")
                {
                    ToolTip = 'Specifies the value of the Share Balance field.';
                    ApplicationArea = all;
                    Editable = false;

                }
                field("Partially Sell"; Rec."Partially Sell")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        if Rec."Partially Sell" = false then begin
                            partiallyVisible := false
                        end else
                            partiallyVisible := true;

                    end;
                }
                field("Amount to Sell"; Rec."Amount to Sell")
                {
                    ToolTip = 'Specifies the value of the Amount to Sell field.';
                    ApplicationArea = all;
                    Editable = partiallyVisible;
                }
                field(Reason; Rec.Reason)
                {
                    ToolTip = 'Specifies the value of the Reason field.';
                    ApplicationArea = all;
                    Caption = 'Reason for Selling';
                    ShowMandatory = true;
                }
                field("Selling price"; Rec."Selling price")
                {
                    ToolTip = 'Specifies the value of the Selling price field.';
                    ApplicationArea = all;
                }
                field("Buyer No."; Rec."Buyer No.")
                {
                    ToolTip = 'Specifies the value of the Buyer No. field.';
                    ApplicationArea = all;
                }
                field("Buyer Name"; Rec."Buyer Name")
                {
                    ToolTip = 'Specifies the value of the Buyer Name field.';
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Buyer Shares Balance"; Rec."Buyer Shares Balance")
                {
                    ToolTip = 'Specifies the value of the Buyer Shares Amount field.';
                    ApplicationArea = all;
                    Editable = false;
                }
                field(cashier; Rec.cashier)
                {
                    ToolTip = 'Specifies the value of the cashier field.';
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Trasaction Date"; Rec."Trasaction Date")
                {
                    ToolTip = 'Specifies the value of the Trasaction Date field.';
                    ApplicationArea = all;
                    Editable = false;
                }

            }
            part("Member Statistics Seller"; "Member Stats")
            {
                SubPageLink = "No." = field("Seller No");
                Visible = true;
                ApplicationArea = all;
                Caption = 'Member Statistics Seller';

            }
            part("Member Statistics Buyer"; "Member Stats")
            {
                SubPageLink = "No." = field("Buyer No.");
                Visible = true;
                ApplicationArea = all;
                Caption = 'Member Statistics Buyer';
            }

        }

    }
    actions
    {
        area(Processing)
        {
            action(Post)
            {
                ApplicationArea = Basic;
                Caption = 'Sell shares';
                Image = Statistics;
                Promoted = true;
                PromotedCategory = Process;
                Visible = true;

                trigger OnAction()
                begin
                    Rec.TestField("Buyer No.");
                    Rec.TestField("Seller No");
                    if Rec."Buyer Shares Balance" > 0 then begin
                        TempBatch.Reset;
                        TempBatch.SetRange(TempBatch.UserID, UserId);
                        if TempBatch.Find('-') then begin
                            TemplateName := TempBatch."FundsTransfer Template Name";
                            BatchName := TempBatch."FundsTransfer Batch Name";
                        end;
                        //....................Reset General Journal Lines
                        GenJournalLine.RESET;
                        GenJournalLine.SETRANGE("Journal Template Name", TemplateName);
                        GenJournalLine.SETRANGE("Journal Batch Name", BatchName);
                        GenJournalLine.DELETEALL;
                        //.sharecapital Transfer Seller
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Rec."No.", LineNo, GenJournalLine."Transaction Type"::"Share Capital", GenJournalLine."Account Type"::Customer, Rec."Seller No", Rec."Trasaction Date", Rec."Amount to Sell", 'BOSA', Rec."No.", 'Share Capital Tranfer' + Format(Rec."Seller No"), '');
                        //.sharecapital Buyer
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Rec."No.", LineNo, GenJournalLine."Transaction Type"::"Share Capital", GenJournalLine."Account Type"::Customer, Rec."Buyer No.", Rec."Trasaction Date", Rec."Amount to Sell" * -1, 'BOSA', Rec."No.", 'Share Capital Tranfer' + Format(Rec."Buyer Name"), '');

                        GenJournalLine.SETRANGE("Journal Batch Name", BatchName);
                        if GenJournalLine.Find('-') then begin
                            CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch", GenJournalLine);
                            //Send Notifications
                            FnSendNotificationstoBuyer();
                            FnSendNotificationstoBuyer();
                        end;
                        Rec.Posted := true;
                    end;

                end;
            }

        }
    }
    var
        LineNo: Integer;
        SFactory: Codeunit "Swizzsoft Factory";
        TemplateName: Code[50];
        BatchName: Code[50];
        GenJournalLine: Record "Gen. Journal Line";
        Cust: Record Customer;
        partiallyVisible: Boolean;
        TempBatch: Record "Funds User Setup";
        SMSMessages: Record "SMS Messages";
        i: Integer;
        iEntryNo: Integer;




    local procedure FnSendNotificationstoSeller()
    var
        msg: Text[250];
        PhoneNo: Text[250];
    begin
        Cust.Reset();
        Cust.SetRange(Cust."No.", Rec."Seller No");
        if Cust.Find('-') then begin
            msg := '';
            msg := 'Dear Member, Your have transfered' + Format(Rec."Amount to Sell") + ' Share Capital to ' + Format(Rec."Buyer No.");
            PhoneNo := FnGetPhoneNo(Rec."Seller No");
            SendSMSMessage(Rec."Seller No", msg, PhoneNo);
        end;
    end;

    local procedure FnSendNotificationstoBuyer()
    var
        msg: Text[250];
        PhoneNo: Text[250];
    begin
        Cust.Reset();
        Cust.SetRange(Cust."No.", Rec."Buyer No.");
        if Cust.Find('-') then begin
            msg := '';
            msg := 'Dear Member, Your have Received' + Format(Rec."Amount to Sell") + ' Share Capital from ' + Format(Rec."Seller No");
            PhoneNo := FnGetPhoneNo(Rec."Buyer No.");
            SendSMSMessage(Rec."Buyer No.", msg, PhoneNo);
        end;
    end;

    local procedure SendSMSMessage(BOSANo: Code[20]; msg: Text[250]; PhoneNo: Text[250])
    begin
        SMSMessages.Reset;
        if SMSMessages.Find('+') then begin
            iEntryNo := SMSMessages."Entry No";
            iEntryNo := iEntryNo + 1;
        end
        else begin
            iEntryNo := 1;
        end;
        //--------------------------------------------------
        SMSMessages.Reset;
        SMSMessages.Init;
        SMSMessages."Entry No" := iEntryNo;
        SMSMessages."Account No" := BOSANo;
        SMSMessages."Date Entered" := Today;
        SMSMessages."Time Entered" := Time;
        SMSMessages.Source := 'SHARECAPSELL';
        SMSMessages."Entered By" := UserId;
        SMSMessages."Sent To Server" := SMSMessages."sent to server"::No;
        SMSMessages."SMS Message" := msg;
        SMSMessages."Telephone No" := PhoneNo;
        SMSMessages.Insert;
    end;

    local procedure FnGetPhoneNo(ClientCode: Code[50]): Text[250]
    var
        Member: Record Customer;
        Vendor: Record Vendor;
    begin
        Member.Reset();
        Member.SetRange(Member."No.", ClientCode);
        if Member.Find('-') = true then begin
            if (Member."Mobile Phone No." <> '') and (Member."Mobile Phone No." <> '0') then begin
                exit(Member."Mobile Phone No.");
            end;
            if (Member."Mobile Phone No" <> '') and (Member."Mobile Phone No" <> '0') then begin
                exit(Member."Mobile Phone No");
            end;
            if (Member."Phone No." <> '') and (Member."Phone No." <> '0') then begin
                exit(Member."Phone No.");
            end;

        end;

    end;

}
