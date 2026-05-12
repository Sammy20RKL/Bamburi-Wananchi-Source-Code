#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50569 "Cheque Receipt Header-Family"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Cheque Receipts-Family";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Time"; Rec."Transaction Time")
                {
                    ApplicationArea = Basic;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic;
                }
                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = Basic;
                }
                field("Unpaid By"; Rec."Unpaid By")
                {
                    ApplicationArea = Basic;
                }
                field("Refference Document"; Rec."Refference Document")
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Unpaid; Rec.Unpaid)
                {
                    ApplicationArea = Basic;
                }
            }
            part(Control1000000011; "Cheque Receipt Line-Family")
            {
                SubPageLink = "Header No" = field("No.");
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Import)
            {
                ApplicationArea = Basic;

                trigger OnAction()
                begin


                    Xmlport.Run(51516038, true);
                    //REPORT.RUN(51516517,TRUE);



                    RefNoRec.Reset;
                    RefNoRec.SetRange(RefNoRec.CurrUserID, UserId);
                    if RefNoRec.Find('-') then begin
                        RefNoRec."Reference No" := Rec."No.";
                        RefNoRec.Modify;
                    end
                    else begin
                        RefNoRec.Init;
                        RefNoRec.CurrUserID := UserId;
                        RefNoRec."Reference No" := Rec."No.";
                        RefNoRec.Insert;
                    end;

                    Rec."Created By" := UserId;
                    Rec.Modify;
                end;
            }
            action(Post)
            {
                ApplicationArea = Basic;

                trigger OnAction()
                begin

                    if Confirm('Are you sure you want post cheques', true) = true then begin
                        GenSetup.Get(0);




                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                        GenJournalLine.SetRange("Journal Batch Name", 'CHQTRANS');
                        GenJournalLine.DeleteAll;

                        ChqRecLines.Reset;
                        ChqRecLines.SetRange(ChqRecLines."Header No", Rec."No.");
                        ChqRecLines.SetRange(ChqRecLines.Status, ChqRecLines.Status::Pending);
                        ChqRecLines.SetRange(ChqRecLines."Verification Status", ChqRecLines."verification status"::Verified);
                        if ChqRecLines.Find('-') then begin
                            repeat

                                if Charges.Get('CPF') then begin
                                    Charges.TestField(Charges."GL Account");
                                    Charges.TestField(Charges."Charge Amount");

                                end;



                                //Cheque Amounts

                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Journal Batch Name" := 'CHQTRANS';
                                GenJournalLine."Document No." := Rec."No.";
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := ChqRecLines."Account No.";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Rec."Transaction Date";
                                GenJournalLine."External Document No." := ChqRecLines."Cheque Serial No";
                                GenJournalLine.Description := 'Cheque Issued' + ChqRecLines."Cheque Serial No";
                                GenJournalLine.Amount := ChqRecLines.Amount;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"Bank Account";
                                GenJournalLine."Bal. Account No." := 'BANK_0005';
                                //GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                                //Post cheque processing charges
                                GenSetup.Get();
                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Journal Batch Name" := 'CHQTRANS';
                                GenJournalLine."Document No." := Rec."No.";
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := ChqRecLines."Account No.";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Rec."Transaction Date";
                                GenJournalLine."External Document No." := ChqRecLines."Cheque Serial No";
                                GenJournalLine.Description := 'Cheque Issued Commision';
                                GenJournalLine.Amount := GenSetup."Mpesa Withdrawal Fee";
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                GenJournalLine."Bal. Account No." := GenSetup."Mpesa Cash Withdrawal fee ac";
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                                //Excise duty

                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Journal Batch Name" := 'CHQTRANS';
                                GenJournalLine."Document No." := Rec."No.";
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := ChqRecLines."Account No.";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Rec."Transaction Date";
                                GenJournalLine."External Document No." := ChqRecLines."Cheque Serial No";
                                GenJournalLine.Description := 'Excise Duty';
                                GenJournalLine.Amount := (GenSetup."Mpesa Withdrawal Fee" * (GenSetup."Excise Duty(%)" / 100));
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                GenJournalLine."Bal. Account No." := GenSetup."Excise Duty Account";
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;


                                if Vend.Get(ChqRecLines."Account No.") then begin
                                    Vend.CalcFields(Vend."Balance (LCY)");
                                    if AccountType.Get(Vend."Account Type") then begin
                                        if (Vend."Balance (LCY)") - (ChqRecLines.Amount + ROUND(Charges."Charge Amount" * 0.01, 5) + Charges."Charge Amount")
                                         < AccountType."Minimum Balance" then begin
                                            Message('TRANSACTION WILL RESULT TO ACCOUNT GOING BELOW MINIMUM BALANCE %1', ChqRecLines."Account No.");
                                        end;
                                    end;
                                end;
                                ChqRecLines.Status := ChqRecLines.Status::Approved;
                                ChqRecLines.Modify;

                            until ChqRecLines.Next = 0;
                        end;


                        //Post New
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                        GenJournalLine.SetRange("Journal Batch Name", 'CHQTRANS');
                        if GenJournalLine.Find('-') then begin
                            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                        end;

                        //Mark cheque book register
                        ChqRecLines.Reset;
                        ChqRecLines.SetRange(ChqRecLines."Header No", Rec."No.");
                        ChqRecLines.SetRange(ChqRecLines.Status, ChqRecLines.Status::Pending);
                        if ChqRecLines.Find('-') then begin
                            repeat
                                CheqReg.Reset;
                                CheqReg.SetRange(CheqReg."Cheque No.", ChqRecLines."Cheque No");
                                if CheqReg.Find('-') then begin
                                    CheqReg.Status := CheqReg.Status::Approved;
                                    CheqReg."Approval Date" := Today;
                                    CheqReg.Modify;
                                end;

                            until ChqRecLines.Next = 0;
                        end;


                        Rec.Posted := true;
                        Rec."Posted By" := UserId;
                        Rec.Modify;

                        //Update cheque register


                    end;
                end;
            }
            action("Post UnPaid Accounts")
            {
                ApplicationArea = Basic;

                trigger OnAction()
                begin

                    if Confirm('Are you sure you want to unpay accounts', false) = true then begin

                        if UpperCase(UserId) = UpperCase(Rec."Posted By") then
                            Error('This must be done by another user');

                        if Rec.Posted = false then
                            Error('It must be posted first');

                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                        GenJournalLine.SetRange("Journal Batch Name", 'CHQTRANS');
                        GenJournalLine.DeleteAll;

                        ChqRecLines.Reset;
                        ChqRecLines.SetRange(ChqRecLines."Header No", Rec."No.");
                        ChqRecLines.SetRange(ChqRecLines.Status, ChqRecLines.Status::Approved);
                        if ChqRecLines.Find('-') then begin
                            repeat

                                if ChqRecLines."Un pay Code" <> '' then begin


                                    //Cheque Amounts

                                    LineNo := LineNo + 10000;

                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := 'GENERAL';
                                    GenJournalLine."Journal Batch Name" := 'CHQTRANS';
                                    GenJournalLine."Document No." := Rec."No.";
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                    GenJournalLine."Account No." := ChqRecLines."Account No.";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Posting Date" := Rec."Transaction Date";
                                    GenJournalLine."External Document No." := ChqRecLines."Cheque Serial No";
                                    GenJournalLine.Description := 'Cheque Issued' + ChqRecLines."Cheque Serial No";
                                    GenJournalLine.Amount := ChqRecLines.Amount * -1;
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"Bank Account";
                                    GenJournalLine."Bal. Account No." := 'BANK_0005';
                                    //GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;



                                    //Cheque Charges

                                    LineNo := LineNo + 10000;

                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := 'GENERAL';
                                    GenJournalLine."Journal Batch Name" := 'CHQTRANS';
                                    GenJournalLine."Document No." := Rec."No.";
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                    GenJournalLine."Account No." := ChqRecLines."Account No.";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Posting Date" := Rec."Transaction Date";
                                    GenJournalLine."External Document No." := ChqRecLines."Cheque Serial No";
                                    GenJournalLine.Description := 'Cheque Issued' + ChqRecLines."Cheque Serial No";
                                    GenJournalLine.Amount := GenSetup."Mpesa Withdrawal Fee" * -1;
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                    GenJournalLine."Bal. Account No." := GenSetup."Mpesa Withdrawal Fee Account";
                                    //GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;



                                    //Excise

                                    LineNo := LineNo + 10000;

                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := 'GENERAL';
                                    GenJournalLine."Journal Batch Name" := 'CHQTRANS';
                                    GenJournalLine."Document No." := Rec."No.";
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                    GenJournalLine."Account No." := ChqRecLines."Account No.";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Posting Date" := Rec."Transaction Date";
                                    GenJournalLine."External Document No." := ChqRecLines."Cheque Serial No";
                                    GenJournalLine.Description := 'Cheque Issued' + ChqRecLines."Cheque Serial No";
                                    GenJournalLine.Amount := (GenSetup."Mpesa Withdrawal Fee" * (GenSetup."Excise Duty(%)" / 100)) * -1;
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                    GenJournalLine."Bal. Account No." := GenSetup."Excise Duty Account";
                                    //GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;
                                    //Post cheque processing charges
                                    GenSetup.Get();
                                    LineNo := LineNo + 10000;

                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := 'GENERAL';
                                    GenJournalLine."Journal Batch Name" := 'CHQTRANS';
                                    GenJournalLine."Document No." := Rec."No.";
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                    GenJournalLine."Account No." := ChqRecLines."Account No.";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Posting Date" := Rec."Transaction Date";
                                    GenJournalLine."External Document No." := ChqRecLines."Cheque Serial No";
                                    GenJournalLine.Description := 'Cheque unpay Commision';
                                    //GenJournalLine.Amount:=GenSetup."Unpaid Cheques Fee";
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                    //GenJournalLine."Bal. Account No.":=GenSetup."Unpaid Cheques Fee Account";
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;

                                    //Excise duty
                                    GenSetup.Get;

                                    LineNo := LineNo + 10000;

                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := 'GENERAL';
                                    GenJournalLine."Journal Batch Name" := 'CHQTRANS';
                                    GenJournalLine."Document No." := Rec."No.";
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                    GenJournalLine."Account No." := ChqRecLines."Account No.";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Posting Date" := Rec."Transaction Date";
                                    GenJournalLine."External Document No." := ChqRecLines."Cheque Serial No";
                                    GenJournalLine.Description := 'Excise Duty';
                                    //GenJournalLine.Amount:=GenSetup."Unpaid Cheques Fee"*(GenSetup."Excise Duty(%)"/100);
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                    GenJournalLine."Bal. Account No." := GenSetup."Excise Duty Account";
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;
                                    //ChqRecLines.
                                end;
                            until ChqRecLines.Next = 0;
                        end;


                        //Post New
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                        GenJournalLine.SetRange("Journal Batch Name", 'CHQTRANS');
                        if GenJournalLine.Find('-') then begin
                            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                        end;



                        Rec."Unpaid By" := UserId;
                        Rec.Unpaid := true;
                    end;
                end;
            }
            action("Export Unpaid Accounts")
            {
                ApplicationArea = Basic;

                trigger OnAction()
                begin

                    ChqRecLines.Reset;
                    ChqRecLines.SetRange(ChqRecLines."Chq Receipt No", Rec."No.");
                    //DATAPORT.RUN(50003,TRUE,ChqRecLines);
                end;
            }
            action("Load Lines")
            {
                ApplicationArea = Basic;

                trigger OnAction()
                begin
                    objChequeTransactions.Reset;
                    objChequeTransactions.SetRange(objChequeTransactions."Imported to Receipt Lines", false);
                    if objChequeTransactions.FindSet(true, false) then begin
                        repeat
                            objChequeTransactions.CalcFields(objChequeTransactions.FrontBWImage, objChequeTransactions.FrontGrayScaleImage, objChequeTransactions.RearImage);
                            ChqRecLines.Init;
                            ChqRecLines."Cheque Serial No" := Format(objChequeTransactions.SerialId);
                            ChqRecLines."Chq Receipt No" := Format(objChequeTransactions.ChequeDataId);
                            ChqRecLines."Account No." := FnGetAccountNo(objChequeTransactions.MemberNo);
                            ChqRecLines."Cheque No" := objChequeTransactions.SNO;
                            ChqRecLines."Header No" := Rec."No.";
                            ChqRecLines."Account Name" := FnGetAccountName(objChequeTransactions.MemberNo);
                            ChqRecLines.Amount := objChequeTransactions.AMOUNT;
                            ChqRecLines.Currency := 'KES';
                            ChqRecLines."Family Account No." := objChequeTransactions.DESTACC;
                            ChqRecLines."Account Balance" := FnGetAccountBalance(objChequeTransactions.MemberNo);
                            ChqRecLines.Fillers := objChequeTransactions.FILLER;
                            ChqRecLines."Branch Code" := objChequeTransactions.DESTBRANCH;
                            ChqRecLines.FrontImage := objChequeTransactions.FrontBWImage;
                            ChqRecLines.FrontGrayImage := objChequeTransactions.FrontGrayScaleImage;
                            ChqRecLines.BackImages := objChequeTransactions.RearImage;
                            ChqRecLines.Insert;
                            objChequeTransactions."Imported to Receipt Lines" := true;
                            objChequeTransactions.Modify;
                        until objChequeTransactions.Next = 0;
                    end;
                end;
            }
        }
    }

    var
        GenJournalLine: Record "Gen. Journal Line";
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        AccountType: Record "Account Types-Saving Products";
        AvailableBal: Decimal;
        LineNo: Integer;
        EFTDetails: Record "EFT Details";
        STORegister: Record "Standing Order Register";
        Accounts: Record Vendor;
        EFTHeader: Record "Bank Transfer Header Details";
        Transactions: Record Transactions;
        TextGen: Text[250];
        STO: Record "Standing Orders";
        ReffNo: Code[20];
        Account: Record Vendor;
        SMSMessage: Record Committment;
        iEntryNo: Integer;
        Vend: Record Vendor;
        UserMgt: Codeunit "Check Manual Nos";
        RefNoRec: Record "Refference Number";
        ChqRecLines: Record "Cheque Issue Lines-Family";
        AccountTypes: Record "Account Types-Saving Products";
        CheqReg: Record "Cheques Register";
        Charges: Record Charges;
        GenSetup: Record "Sacco General Set-Up";
        objChequeTransactions: Record "Cheque Truncation Buffer";

    local procedure FnGetAccountNo(MemberNo: Code[100]) AccountNo: Code[100]
    begin
        Account.Reset;
        Account.SetRange(Account."BOSA Account No", MemberNo);
        Account.SetRange(Account."Account Type", 'CURRENT');
        if Account.Find('-') then begin
            AccountNo := Account."No.";
        end
    end;

    local procedure FnGetAccountName(MemberNo: Code[100]) AccountName: Text[250]
    begin
        Account.Reset;
        Account.SetRange(Account."BOSA Account No", MemberNo);
        Account.SetRange(Account."Account Type", 'CURRENT');
        if Account.Find('-') then begin
            AccountName := Account.Name;
        end
    end;


    procedure Balance(Acc: Code[30]; Vendor: Record Vendor) Bal: Decimal
    begin
        if Vendor.Get(Acc) then begin
            Vendor.CalcFields(Vendor."Balance (LCY)", Vendor."ATM Transactions", Vendor."Mobile Transactions", Vendor."Uncleared Cheques");
            Bal := Vendor."Balance (LCY)" - (Vendor."ATM Transactions" + Vendor."Mobile Transactions" + Vendor."Uncleared Cheques" + Vendor."EFT Transactions");

        end
    end;

    local procedure FnGetAccountBalance(MemberNo: Code[100]) AccountBalance: Decimal
    begin
        Account.Reset;
        Account.SetRange(Account."BOSA Account No", MemberNo);
        Account.SetRange(Account."Account Type", 'CURRENT');
        if Account.Find('-') then begin
            AccountBalance := Balance(Account."No.", Account);
        end
    end;
}

