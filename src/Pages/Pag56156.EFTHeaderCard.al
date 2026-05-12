#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 56156 "EFT Header Card"
{
    PageType = Card;
    SourceTable = "EFT Header Details";

    layout
    {
        area(content)
        {
            group("EFT Batch")
            {
                Caption = 'EFT Batch';
                field(No; Rec.No)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Bank  No"; Rec."Bank  No")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque No"; Rec."Cheque No")
                {
                    ApplicationArea = Basic;
                }
                field(Total; Rec.Total)
                {
                    ApplicationArea = Basic;
                }
                field("Total Count"; Rec."Total Count")
                {
                    ApplicationArea = Basic;
                    Caption = 'Record Count';
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic;
                }
                field(Transferred; Rec.Transferred)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date Transferred"; Rec."Date Transferred")
                {
                    ApplicationArea = Basic;
                }
                field("Time Transferred"; Rec."Time Transferred")
                {
                    ApplicationArea = Basic;
                }
                field("Transferred By"; Rec."Transferred By")
                {
                    ApplicationArea = Basic;
                }
                field(RTGS; Rec.RTGS)
                {
                    ApplicationArea = Basic;
                }
            }
            part(Control1; "EFT Details")
            {
                SubPageLink = "Header No" = field(No);
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Get)
            {
                Caption = 'Get';
                action("Standing Orders EFT")
                {
                    ApplicationArea = Basic;
                    Caption = 'Standing Orders EFT';
                    Visible = false;

                    trigger OnAction()
                    begin
                        if Rec.Transferred = true then
                            Error('EFT Batch already transfered. Please use another one.');

                        STORegister.Reset;
                        STORegister.SetRange(STORegister.EFT, true);
                        STORegister.SetRange(STORegister."Transfered to EFT", false);
                        if STORegister.Find('-') then begin
                            repeat
                                EFTDetails.Init;
                                EFTDetails.No := '';
                                EFTDetails."Header No" := Rec.No;
                                EFTDetails."Account No" := STORegister."Source Account No.";
                                //EFTDetails."Account Name":=STORegister."Account Name";
                                EFTDetails.Validate(EFTDetails."Account No");
                                //IF Accounts.GET(EFTDetails."Account No") THEN BEGIN
                                //EFTDetails."Account Type":=Accounts."Account Type";
                                //EFTDetails."Staff No":=Account."Staff No";
                                //END;
                                EFTDetails.Amount := STORegister."Amount Deducted";
                                EFTDetails."Destination Account Type" := EFTDetails."destination account type"::External;
                                //EFTDetails."Destination Account No":=STORegister."Destination Account No.";
                                if STO.Get(STORegister."Standing Order No.") then begin
                                    EFTDetails."Destination Account No" := STO."Destination Account No.";
                                    EFTDetails."Bank No" := STO."Bank Code";
                                    EFTDetails.Validate(EFTDetails."Bank No");
                                end;
                                EFTDetails."Destination Account Name" := CopyStr(STORegister."Destination Account Name", 1, 28);
                                EFTDetails."Standing Order No" := STORegister."Standing Order No.";
                                EFTDetails."Standing Order Register No" := STORegister."Register No.";
                                EFTDetails.Charges := 0;
                                if EFTDetails.Amount > 0 then
                                    EFTDetails.Insert(true)

                            until STORegister.Next = 0
                        end;
                    end;
                }
                action(Action1102760031)
                {
                    ApplicationArea = Basic;
                    Caption = 'Standing Orders EFT';

                    trigger OnAction()
                    begin
                        /*IF Transferred = TRUE THEN
                        ERROR('EFT Batch already transfered. Please use another one.');
                        
                        EFTHeader.RESET;
                        EFTHeader.SETRANGE(EFTHeader.No,No);
                        IF EFTHeader.FIND('-') THEN
                        REPORT.RUN(,TRUE,TRUE,EFTHeader)
                         */

                    end;
                }
                separator(Action1102760024)
                {
                }
                action("Salary EFT")
                {
                    ApplicationArea = Basic;
                    Caption = 'Salary EFT';
                    Image = ReverseLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin

                        if Rec.Transferred = true then
                            Error('EFT Batch already transfered. Please use another one.');

                        EFTHeader.Reset;
                        EFTHeader.SetRange(EFTHeader.No, Rec.No);
                        if EFTHeader.Find('-') then
                            Message('%1', EFTHeader.No);
                        Report.Run(50292, true, true, EFTHeader)
                    end;
                }
                separator(Action1102760027)
                {
                }
                action("Re-genarate EFT Format")
                {
                    ApplicationArea = Basic;
                    Caption = 'Re-genarate EFT Format';
                    Visible = false;

                    trigger OnAction()
                    begin

                        EFTDetails.Reset;
                        EFTDetails.SetRange(EFTDetails."Header No", Rec.No);
                        if EFTDetails.Find('-') then begin
                            repeat
                                //EFTDetails.TESTFIELD(EFTDetails."Destination Account No");
                                EFTDetails.TestField(EFTDetails.Amount);
                                //EFTDetails.TESTFIELD(EFTDetails."Destination Account Name");
                                EFTDetails.TestField(EFTDetails."Bank No");

                                if StrLen(EFTDetails."Destination Account Name") > 28 then
                                    Error('Destnation account name of staff no %1 more than 28 characters.', EFTDetails."Staff No");

                                if StrLen(EFTDetails."Destination Account No") > 14 then
                                    Error('Destnation account of staff no %1 more than 14 characters.', EFTDetails."Staff No");

                                //For STIMA, replace staff No with stima
                                ReffNo := 'STIMA';

                                if EFTDetails.Amount <> ROUND(EFTDetails.Amount, 1) then begin
                                    if EFTDetails.Amount <> ROUND(EFTDetails.Amount, 0.1) then begin
                                        EFTDetails.ExportFormat := PadStr('', 14 - StrLen(EFTDetails."Destination Account No"), ' ') + EFTDetails."Destination Account No" +
                                                                 PadStr('', 5, ' ') +
                                                                 PadStr('', 6 - StrLen(EFTDetails."Bank No"), ' ') + EFTDetails."Bank No" + ' ' +
                                                                 EFTDetails."Destination Account Name" + PadStr('', 30 - StrLen(EFTDetails."Destination Account Name"), ' ') +
                                                                 PadStr('', 9 - StrLen(DelChr(DelChr(Format(EFTDetails.Amount), '=', '.'), '=', ',')), ' ') +
                                                                        DelChr(DelChr(Format(EFTDetails.Amount), '=', '.'), '=', ',') +
                                                                 PadStr('', 8 - StrLen(CopyStr(ReffNo, 1, 8)), ' ') + ReffNo;
                                    end else begin
                                        EFTDetails.ExportFormat := PadStr('', 14 - StrLen(EFTDetails."Destination Account No"), ' ') + EFTDetails."Destination Account No" +
                                                                 PadStr('', 5, ' ') +
                                                                 PadStr('', 6 - StrLen(EFTDetails."Bank No"), ' ') + EFTDetails."Bank No" + ' ' +
                                                                 EFTDetails."Destination Account Name" + PadStr('', 30 - StrLen(EFTDetails."Destination Account Name"), ' ') +
                                                                 PadStr('', 8 - StrLen(DelChr(DelChr(Format(EFTDetails.Amount), '=', '.'), '=', ',')), ' ') +
                                                                        DelChr(DelChr(Format(EFTDetails.Amount), '=', '.'), '=', ',') + '0' +
                                                                 PadStr('', 8 - StrLen(CopyStr(ReffNo, 1, 8)), ' ') + ReffNo;
                                    end;
                                end else begin
                                    TextGen := Format(EFTDetails."Staff No");

                                    EFTDetails.ExportFormat := PadStr('', 14 - StrLen(EFTDetails."Destination Account No"), ' ') + EFTDetails."Destination Account No" +
                                                             PadStr('', 5, ' ') +
                                                             PadStr('', 6 - StrLen(EFTDetails."Bank No"), ' ') + EFTDetails."Bank No" + ' ' +
                                                             EFTDetails."Destination Account Name" + PadStr('', 30 - StrLen(EFTDetails."Destination Account Name"), ' ') +
                                                             PadStr('', 7 - StrLen(DelChr(DelChr(Format(EFTDetails.Amount), '=', '.'), '=', ',')), ' ') +
                                                                    DelChr(DelChr(Format(EFTDetails.Amount), '=', '.'), '=', ',') + '00' +
                                                             PadStr('', 8 - StrLen(CopyStr(ReffNo, 1, 8)), ' ') + ReffNo;
                                end;



                                EFTDetails.Modify;
                            until EFTDetails.Next = 0;
                        end;




                        EFTDetails.Reset;
                        EFTDetails.SetRange(EFTDetails."Header No", Rec.No);
                        //if EFTDetails.Find('-') then
                    end;
                }
                separator(Action1102760032)
                {
                }
                action("Dividends EFT")
                {
                    ApplicationArea = Basic;
                    Caption = 'Dividends EFT';
                    Visible = false;

                    trigger OnAction()
                    begin
                        //IF Transferred = TRUE THEN
                        //ERROR('EFT Batch already transfered. Please use another one.');
                        /*
                        EFTHeader.RESET;
                        EFTHeader.SETRANGE(EFTHeader.No,No);
                        IF EFTHeader.FIND('-') THEN
                        REPORT.RUN(,TRUE,TRUE,EFTHeader)
                        */

                    end;
                }
                separator(Action1102760035)
                {
                }
                action("Salary Dividends EFT")
                {
                    ApplicationArea = Basic;
                    Caption = 'Salary Dividends EFT';
                    Visible = false;

                    trigger OnAction()
                    begin
                        /*IF Transferred = TRUE THEN
                        ERROR('EFT Batch already transfered. Please use another one.');
                        
                        EFTHeader.RESET;
                        EFTHeader.SETRANGE(EFTHeader.No,No);
                        IF EFTHeader.FIND('-') THEN
                        REPORT.RUN(,TRUE,TRUE,EFTHeader)
                        */

                    end;
                }
                separator(Action1102760034)
                {
                }
                action("Generate Dividends EFT")
                {
                    ApplicationArea = Basic;
                    Caption = 'Generate Dividends EFT';
                    Visible = false;

                    trigger OnAction()
                    begin

                        EFTDetails.Reset;
                        EFTDetails.SetRange(EFTDetails."Header No", Rec.No);
                        if EFTDetails.Find('-') then begin
                            repeat
                                //EFTDetails.TESTFIELD(EFTDetails."Destination Account No");
                                EFTDetails.TestField(EFTDetails.Amount);
                                //EFTDetails.TESTFIELD(EFTDetails."Destination Account Name");
                                //EFTDetails.TESTFIELD(EFTDetails."Bank No");

                                if StrLen(EFTDetails."Destination Account Name") > 28 then
                                    Error('Destnation account name of staff no %1 more than 28 characters.', EFTDetails."Staff No");

                                if StrLen(EFTDetails."Destination Account No") > 14 then
                                    Error('Destnation account of staff no %1 more than 14 characters.', EFTDetails."Staff No");

                                //For TELEPOST, replace staff No with TELEPOST
                                ReffNo := 'TELEPOST';

                                if EFTDetails.Amount <> ROUND(EFTDetails.Amount, 1) then begin
                                    if EFTDetails.Amount <> ROUND(EFTDetails.Amount, 0.1) then begin
                                        EFTDetails.ExportFormat := PadStr('', 14 - StrLen(EFTDetails."Destination Account No"), ' ') + EFTDetails."Destination Account No" +
                                                                 PadStr('', 5, ' ') +
                                                                 PadStr('', 6 - StrLen(EFTDetails."Bank No"), ' ') + EFTDetails."Bank No" + ' ' +
                                                                 EFTDetails."Destination Account Name" + PadStr('', 30 - StrLen(EFTDetails."Destination Account Name"), ' ') +
                                                                 PadStr('', 9 - StrLen(DelChr(DelChr(Format(EFTDetails.Amount), '=', '.'), '=', ',')), ' ') +
                                                                        DelChr(DelChr(Format(EFTDetails.Amount), '=', '.'), '=', ',') +
                                                                 PadStr('', 8 - StrLen(CopyStr(ReffNo, 1, 8)), ' ') + ReffNo;
                                    end else begin
                                        EFTDetails.ExportFormat := PadStr('', 14 - StrLen(EFTDetails."Destination Account No"), ' ') + EFTDetails."Destination Account No" +
                                                                 PadStr('', 5, ' ') +
                                                                 PadStr('', 6 - StrLen(EFTDetails."Bank No"), ' ') + EFTDetails."Bank No" + ' ' +
                                                                 EFTDetails."Destination Account Name" + PadStr('', 30 - StrLen(EFTDetails."Destination Account Name"), ' ') +
                                                                 PadStr('', 8 - StrLen(DelChr(DelChr(Format(EFTDetails.Amount), '=', '.'), '=', ',')), ' ') +
                                                                        DelChr(DelChr(Format(EFTDetails.Amount), '=', '.'), '=', ',') + '0' +
                                                                 PadStr('', 8 - StrLen(CopyStr(ReffNo, 1, 8)), ' ') + ReffNo;
                                    end;
                                end else begin
                                    TextGen := Format(EFTDetails."Staff No");

                                    EFTDetails.ExportFormat := PadStr('', 14 - StrLen(EFTDetails."Destination Account No"), ' ') + EFTDetails."Destination Account No" +
                                                             PadStr('', 5, ' ') +
                                                             PadStr('', 6 - StrLen(EFTDetails."Bank No"), ' ') + EFTDetails."Bank No" + ' ' +
                                                             EFTDetails."Destination Account Name" + PadStr('', 30 - StrLen(EFTDetails."Destination Account Name"), ' ') +
                                                             PadStr('', 7 - StrLen(DelChr(DelChr(Format(EFTDetails.Amount), '=', '.'), '=', ',')), ' ') +
                                                                    DelChr(DelChr(Format(EFTDetails.Amount), '=', '.'), '=', ',') + '00' +
                                                             PadStr('', 8 - StrLen(CopyStr(ReffNo, 1, 8)), ' ') + ReffNo;
                                end;



                                EFTDetails.Modify;
                            until EFTDetails.Next = 0;
                        end;




                        EFTDetails.Reset;
                        EFTDetails.SetRange(EFTDetails."Header No", Rec.No);
                        // if EFTDetails.Find('-') then
                    end;
                }
            }
        }
        area(processing)
        {
            action("View Schedule")
            {
                ApplicationArea = Basic;
                Caption = 'View Schedule';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    /*EFTHeader.RESET;
                    EFTHeader.SETRANGE(EFTHeader.No,No);
                    IF EFTHeader.FIND('-') THEN
                    REPORT.RUN(,TRUE,TRUE,EFTHeader)
                    */

                end;
            }
            action(Transfer)
            {
                ApplicationArea = Basic;
                Caption = 'Transfer';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec.TestField("Bank  No");

                    if Rec.Transferred = true then
                        Error('Funds transfers has already been done.');

                    if Confirm('Are you absolutely sure you want to post the EFT tranfers.', false) = false then
                        exit;


                    GenJournalLine.Reset;
                    GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'PURCHASES');
                    GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'EFT');
                    if GenJournalLine.Find('-') then
                        GenJournalLine.DeleteAll;

                    EFTDetails.Reset;
                    EFTDetails.SetRange(EFTDetails."Header No", Rec.No);
                    if EFTDetails.Find('-') then begin
                        repeat
                            //EFTDetails.TESTFIELD(EFTDetails."Destination Account No");
                            EFTDetails.TestField(EFTDetails.Amount);
                            //EFTDetails.TESTFIELD(EFTDetails."Destination Account Name");
                            //EFTDetails.TESTFIELD(EFTDetails."Bank No");

                            if StrLen(EFTDetails."Destination Account Name") > 28 then
                                Error('Destnation account name of staff no %1 more than 28 characters.', EFTDetails."Staff No");

                            if StrLen(EFTDetails."Destination Account No") > 14 then
                                Error('Destnation account of staff no %1 more than 14 characters.', EFTDetails."Staff No");


                            LineNo := LineNo + 10000;

                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'PURCHASES';
                            GenJournalLine."Journal Batch Name" := 'EFT';
                            GenJournalLine."Document No." := Rec.No;
                            GenJournalLine."External Document No." := CopyStr(EFTDetails."Destination Account No", 1, 20);
                            GenJournalLine."Line No." := LineNo;
                            if EFTDetails."Standing Order No" <> '' then begin
                                if AccountType.Get(EFTDetails."Account Type") then begin
                                    AccountType.TestField(AccountType."Standing Orders Suspense");
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                                    GenJournalLine."Account No." := AccountType."Standing Orders Suspense";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine.Description := 'STO EFT - ' + EFTDetails."Standing Order No";
                                end;
                            end else begin
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := EFTDetails."Account No";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine.Description := 'EFT to Account ' + EFTDetails."Destination Account No";
                            end;
                            GenJournalLine."Posting Date" := Today;
                            GenJournalLine.Validate(GenJournalLine."Currency Code");
                            GenJournalLine.Amount := EFTDetails.Amount;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            if GenJournalLine."Shortcut Dimension 1 Code" = '' then begin
                                GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            end;
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;

                            //Charges
                            if (EFTDetails."Account No" <> '5-02-09565-00') and
                               (EFTDetails."Account No" <> '5-02-09276-01') then begin

                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'PURCHASES';
                                GenJournalLine."Journal Batch Name" := 'EFT';
                                GenJournalLine."Document No." := Rec.No;
                                GenJournalLine."External Document No." := CopyStr(EFTDetails."Destination Account No", 1, 20);
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := EFTDetails."Account No";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Today;
                                if Rec.RTGS = true then
                                    GenJournalLine.Description := 'RTGS Charges'
                                else
                                    GenJournalLine.Description := 'EFT Charges';
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := EFTDetails.Charges;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                GenJournalLine."Bal. Account No." := EFTDetails."EFT Charges Account";
                                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                if GenJournalLine."Shortcut Dimension 1 Code" = '' then begin
                                    GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                end;
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                            end;

                            //Charges

                            //Clear EFT
                            Transactions.Reset;
                            Transactions.SetRange(Transactions."Cheque No", EFTDetails.No);
                            Transactions.SetRange(Transactions."Transaction Type", 'EFT');
                            Transactions.SetRange(Transactions."Account No", EFTDetails."Account No");
                            if Transactions.Find('-') then begin
                                Transactions."Cheque Processed" := true;
                                Transactions."Date Cleared" := Today;
                                Transactions.Modify;
                            end;
                            //Clear EFT

                            //IF STRLEN(EFTDetails."Destination Account No") > 13 THEN
                            //ERROR('Destnation account %1 more than 13 characters.',EFTDetails."Destination Account No");

                            /*
                            IF EFTDetails.Amount <> ROUND(EFTDetails.Amount,1) THEN BEGIN
                            EFTDetails.ExportFormat:=PADSTR('',13-STRLEN(EFTDetails."Destination Account No"),' ')+EFTDetails."Destination Account No"+
                                                     PADSTR('',6,' ')+
                                                     PADSTR('',6-STRLEN(EFTDetails."Bank No"),' ')+EFTDetails."Bank No"+' '+
                                                     EFTDetails."Destination Account Name"+PADSTR('',30-STRLEN(EFTDetails."Destination Account Name"),' ')+
                                                     PADSTR('',9-STRLEN(DELCHR(DELCHR(FORMAT(EFTDetails.Amount),'=','.'),'=',',')),' ')+
                                                            DELCHR(DELCHR(FORMAT(EFTDetails.Amount),'=','.'),'=',',')+
                                                     PADSTR('',8-STRLEN(EFTDetails."Staff No"),' ')+EFTDetails."Staff No";

                            END ELSE BEGIN
                            EFTDetails.ExportFormat:=PADSTR('',13-STRLEN(EFTDetails."Destination Account No"),' ')+EFTDetails."Destination Account No"+
                                                     PADSTR('',6,' ')+
                                                     PADSTR('',6-STRLEN(EFTDetails."Bank No"),' ')+EFTDetails."Bank No"+' '+
                                                     EFTDetails."Destination Account Name"+PADSTR('',30-STRLEN(EFTDetails."Destination Account Name"),' ')+
                                                     PADSTR('',7-STRLEN(DELCHR(DELCHR(FORMAT(EFTDetails.Amount),'=','.'),'=',',')),' ')+
                                                            DELCHR(DELCHR(FORMAT(EFTDetails.Amount),'=','.'),'=',',')+'00'+
                                                     PADSTR('',8-STRLEN(EFTDetails."Staff No"),' ')+EFTDetails."Staff No";
                            END;
                            */

                            EFTDetails.Transferred := true;
                            EFTDetails.Modify;



                            //Mark the standing order register has transfered
                            STORegister.Reset;
                            STORegister.SetRange(STORegister."Register No.", EFTDetails."Standing Order Register No");
                            if STORegister.Find('-') then begin
                                STORegister."Transfered to EFT" := true;
                                STORegister.Modify;
                            end;

                        until EFTDetails.Next = 0;
                    end;


                    //Bank Entry
                    Rec.CalcFields(Total);

                    LineNo := LineNo + 10000;

                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'PURCHASES';
                    GenJournalLine."Journal Batch Name" := 'EFT';
                    GenJournalLine."Document No." := Rec.No;
                    GenJournalLine."External Document No." := Rec."Cheque No";
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
                    GenJournalLine."Account No." := Rec."Bank  No";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Posting Date" := Today;
                    GenJournalLine.Description := 'Electronic Funds Transfer - ' + Rec.No;
                    GenJournalLine.Validate(GenJournalLine."Currency Code");
                    GenJournalLine.Amount := -Rec.Total;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                    if GenJournalLine."Shortcut Dimension 1 Code" = '' then begin
                        GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    end;
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;
                    //Bank Entry

                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
                    GenJournalLine.SetRange("Journal Batch Name", 'EFT');
                    if GenJournalLine.Find('-') then begin
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
                    end;


                    Rec.Transferred := true;
                    Rec."Date Transferred" := Today;
                    Rec."Time Transferred" := Time;
                    Rec."Transferred By" := UserId;
                    Rec.Modify;


                    Message('EFT Posted successfully.');

                end;
            }
        }
    }

    var
        GenJournalLine: Record "Gen. Journal Line";
        //GLPosting: Codeunit "Gen. Jnl.-Post Line";
        Account: Record Vendor;
        AccountType: Record "Account Types-Saving Products";
        AvailableBal: Decimal;
        LineNo: Integer;
        EFTDetails: Record "EFT Details";
        STORegister: Record "Standing Order Register";
        Accounts: Record Vendor;
        EFTHeader: Record "EFT Header Details";
        Transactions: Record Transactions;
        TextGen: Text[250];
        STO: Record "Standing Orders";
        ReffNo: Code[20];
}

