#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 56144 "CashierTransactionCard-Posted"
{
    DeleteAllowed = false;
    PageType = Card;
    InsertAllowed = false;
    Editable = false;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = Transactions;

    layout
    {
        area(content)
        {
            group(Transactions)
            {
                Caption = 'Transactions';
                field(No; Rec.No)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic;
                    Style = StrongAccent;

                    trigger OnValidate()
                    begin
                        if Rec.Posted = true then
                            Error('You cannot modify an already posted record.');

                        CalcAvailableBal;

                        Rec.CalcFields("Uncleared Cheques");
                        // if AccP.Get("Account No") then begin
                        //     // AccP.CalcFields(AccP.Image, AccP.Signature);
                        //     Picture := AccP.Image;
                        //     Signature := Acc.Signature;
                        //     Modify;


                        // end;
                    end;
                }

                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = StrongAccent;
                }

                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = Basic;
                    Style = StrongAccent;

                    trigger OnValidate()
                    begin
                        if Rec.Posted = true then
                            Error('You cannot modify an already posted record.');

                        FChequeVisible := false;
                        BChequeVisible := false;
                        BReceiptVisible := false;
                        BOSAReceiptChequeVisible := false;
                        "Branch RefferenceVisible" := false;
                        LRefVisible := false;


                        if TransactionTypes.Get(Rec."Transaction Type") then begin
                            if TransactionTypes.Type = TransactionTypes.Type::"Cheque Deposit" then begin
                                FChequeVisible := true;
                                if (Rec."Account No" = '502-00-000300-00') or (Rec."Account No" = '502-00-000303-00') then
                                    BOSAReceiptChequeVisible := true;
                            end;
                            if TransactionTypes.Type = TransactionTypes.Type::"Bankers Cheque" then
                                BChequeVisible := true;

                            if Rec."Transaction Type" = 'BOSA' then
                                BReceiptVisible := true;

                            if TransactionTypes.Type = TransactionTypes.Type::Encashment then
                                BReceiptVisible := true;



                        end;

                        if Rec."Branch Transaction" = true then begin
                            "Branch RefferenceVisible" := true;
                            LRefVisible := true;
                        end;

                        if Acc.Get(Rec."Account No") then begin
                            if Acc."Account Category" = Acc."account category"::Project then begin
                                "Branch RefferenceVisible" := true;
                                LRefVisible := true;
                            end;
                        end;


                        CalcAvailableBal;
                    end;
                }
                field("Transaction Description"; Rec."Transaction Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = StrongAccent;

                }

                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                    Style = Unfavorable;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                    Caption = 'Transacted By';
                    Style = StrongAccent;
                }
                // field("Payment Voucher No"; Rec."Payment Voucher No")
                // {
                //     ApplicationArea = Basic;
                //     Visible = false;
                // }
                group(BCheque)
                {
                    Caption = '.';
                    Visible = BChequeVisible;
                    field("Bankers Cheque No"; Rec."Bankers Cheque No")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Bank Code"; Rec."Bank Code")
                    {
                        ApplicationArea = Basic;
                    }
                    field(Payee; Rec.Payee)
                    {
                        ApplicationArea = Basic;
                    }
                    field("Post Dated"; Rec."Post Dated")
                    {
                        ApplicationArea = Basic;

                        trigger OnValidate()
                        begin
                            "Transaction DateEditable" := false;
                            if Rec."Post Dated" = true then
                                "Transaction DateEditable" := true
                            else
                                Rec."Transaction Date" := Today;
                        end;
                    }
                    field("Account Type"; Rec."Account Type")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                    }
                }
                group(BReceipt)
                {
                    Caption = '.';
                    Visible = BReceiptVisible;
                    field("BOSA Account No"; Rec."BOSA Account No")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Allocated Amount"; Rec."Allocated Amount")
                    {
                        ApplicationArea = Basic;
                    }
                }
                group(FCheque)
                {
                    Caption = '.';
                    Visible = FChequeVisible;
                    field("Cheque Type"; Rec."Cheque Type")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Cheque No"; Rec."Cheque No")
                    {
                        ApplicationArea = Basic;

                        trigger OnValidate()
                        begin
                            if StrLen(Rec."Cheque No") <> 6 then
                                Error('Cheque No. cannot contain More or less than 6 Characters.');
                        end;
                    }
                    field(bank; Rec."Bank Code")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Bank';
                    }
                    field("Bank Name"; Rec."Bank Name")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Expected Maturity Date"; Rec."Expected Maturity Date")
                    {
                        ApplicationArea = Basic;
                    }
                    field(Status; Rec.Status)
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                    }
                    field("50048"; Rec."Banking Posted")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Banked';
                        Editable = false;
                    }
                    field("Bank Account"; Rec."Bank Account")
                    {
                        ApplicationArea = Basic;
                        Visible = false;
                    }
                    field("Cheque Date"; Rec."Cheque Date")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Cheque Deposit Remarks"; Rec."Cheque Deposit Remarks")
                    {
                        ApplicationArea = Basic;
                    }
                    group(BOSAReceiptCheque)
                    {
                        Caption = '.';
                        Visible = BOSAReceiptChequeVisible;
                    }
                }

                field("Branch Refference"; Rec."Branch Refference")
                {
                    ApplicationArea = Basic;
                    Caption = 'REF';
                    Visible = "Branch RefferenceVisible";
                }
                field("Book Balance"; Rec."Book Balance")
                {
                    ApplicationArea = Basic;
                }



                field("Uncleared Cheques"; Rec."Uncleared Cheques")
                {
                    ApplicationArea = Basic;
                }
                field(AvailableBalance; AvailableBalance)
                {
                    ApplicationArea = Basic;
                    Caption = 'Available Balance';
                    Editable = false;
                }

                field("N.A.H Balance"; Rec."N.A.H Balance")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    visible = false;
                }
                field("ID No"; Rec."ID No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = StrongAccent;
                }

                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = Basic;
                    Editable = "Transaction DateEditable";
                }
                field("Transaction Time"; Rec."Transaction Time")
                {
                    ApplicationArea = Basic;
                }
                field(Authorised; Rec.Authorised)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Picture; Rec.Picture)
                {
                    ApplicationArea = Basic;
                }
                field(Signature; Rec.Signature)
                {
                    ApplicationArea = Basic;
                }
                field(Cashier; Rec.Cashier)
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            // part(Control1000000004; "FOSA Statistics FactBox")
            // {
            //     SubPageLink = "No." = field("Account No");
            // }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Suggest)
            {
                Caption = 'Suggest';
                action("Cash Clearance")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cash Clearance';
                    Visible = false;

                    trigger OnAction()
                    begin
                        Cheque := false;
                        SuggestBOSAEntries();
                    end;
                }
                separator(Action1102760074)
                {
                }
                action("Cheque Clearance")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cheque Clearance';
                    Enabled = false;
                    Visible = false;

                    trigger OnAction()
                    begin
                        Cheque := true;
                        SuggestBOSAEntries();
                    end;
                }
                separator(Action1102760081)
                {
                }
                action("Monthy Repayments")
                {
                    ApplicationArea = Basic;
                    Caption = 'Monthy Repayments';
                    Enabled = false;
                    Visible = false;

                    trigger OnAction()
                    begin
                        Rec.TestField(Posted, false);
                        Rec.TestField("BOSA Account No");

                        ReceiptAllocations.Reset;
                        ReceiptAllocations.SetRange(ReceiptAllocations."Document No", Rec.No);
                        ReceiptAllocations.DeleteAll;

                        if Cust.Get(Rec."BOSA Account No") then begin
                            ReceiptAllocations.Init;
                            ReceiptAllocations."Document No" := Rec.No;
                            ReceiptAllocations."Member No" := Rec."BOSA Account No";
                            ReceiptAllocations."Transaction Type" := ReceiptAllocations."transaction type"::"Interest Due";
                            ReceiptAllocations."Loan No." := Loans."Loan  No.";
                            ReceiptAllocations.Amount := ROUND(Cust."Insurance Contribution", 0.01);
                            ReceiptAllocations."Interest Amount" := Loans."Interest Due";
                            ReceiptAllocations."Total Amount" := ReceiptAllocations.Amount + ReceiptAllocations."Interest Amount";
                            ReceiptAllocations.Insert;

                            ReceiptAllocations.Init;
                            ReceiptAllocations."Document No" := Rec.No;
                            ReceiptAllocations."Member No" := Rec."BOSA Account No";
                            ReceiptAllocations."Transaction Type" := ReceiptAllocations."transaction type"::Loan;
                            ReceiptAllocations."Loan No." := Loans."Loan  No.";
                            ReceiptAllocations.Amount := ROUND(Cust."Monthly Contribution", 0.01);
                            ReceiptAllocations."Interest Amount" := Loans."Interest Due";
                            ReceiptAllocations."Total Amount" := ReceiptAllocations.Amount + ReceiptAllocations."Interest Amount";
                            ReceiptAllocations.Insert;

                            if Cust."Investment Monthly Cont" > 0 then begin
                                ReceiptAllocations.Init;
                                ReceiptAllocations."Document No" := Rec.No;
                                ReceiptAllocations."Member No" := Rec."BOSA Account No";
                                ReceiptAllocations."Transaction Type" := ReceiptAllocations."transaction type"::"Interest Paid";
                                ReceiptAllocations."Loan No." := Loans."Loan  No.";
                                ReceiptAllocations.Amount := ROUND(Cust."Investment Monthly Cont", 0.01);
                                ReceiptAllocations."Interest Amount" := Loans."Interest Due";
                                ReceiptAllocations."Total Amount" := ReceiptAllocations.Amount + ReceiptAllocations."Interest Amount";
                                ReceiptAllocations.Insert;
                            end;



                            Loans.Reset;
                            Loans.SetCurrentkey(Loans.Source, Loans."Client Code");
                            Loans.SetRange(Loans."Client Code", Rec."BOSA Account No");
                            Loans.SetRange(Loans.Source, Loans.Source::BOSA);
                            if Loans.Find('-') then begin
                                repeat
                                    Loans.CalcFields(Loans."Outstanding Balance", Loans."Interest Due");

                                    if (Loans."Outstanding Balance") > 0 then begin
                                        LOustanding := 0;


                                        ReceiptAllocations.Init;
                                        ReceiptAllocations."Document No" := Rec.No;
                                        ReceiptAllocations."Member No" := Rec."BOSA Account No";
                                        ReceiptAllocations."Transaction Type" := ReceiptAllocations."transaction type"::"Registration Fee";
                                        ReceiptAllocations."Loan No." := Loans."Loan  No.";
                                        ReceiptAllocations.Amount := ROUND(Loans."Loan Principle Repayment", 0.01);
                                        ReceiptAllocations."Interest Amount" := ROUND(Loans."Loan Interest Repayment", 0.01);
                                        ReceiptAllocations."Total Amount" := ReceiptAllocations.Amount + ReceiptAllocations."Interest Amount";
                                        ReceiptAllocations.Insert;


                                    end;
                                until Loans.Next = 0;
                            end;
                        end;
                    end;
                }
            }
            group(ActionGroup1102760115)
            {
                Caption = 'Suggest';
                action(Action1102760116)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cash Clearance';
                    Visible = false;

                    trigger OnAction()
                    begin
                        Cheque := false;
                        SuggestBOSAEntries();
                    end;
                }
                separator(Action1102760117)
                {
                }
                action(Action1102760118)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cheque Clearance';
                    Visible = false;

                    trigger OnAction()
                    begin
                        Cheque := true;
                        SuggestBOSAEntries();
                    end;
                }
                separator(Action1102760119)
                {
                }
                action(Action1102760120)
                {
                    ApplicationArea = Basic;
                    Caption = 'Monthy Repayments';
                    Visible = false;

                    trigger OnAction()
                    begin
                        Rec.TestField(Posted, false);
                        Rec.TestField("BOSA Account No");

                        ReceiptAllocations.Reset;
                        ReceiptAllocations.SetRange(ReceiptAllocations."Document No", Rec.No);
                        ReceiptAllocations.DeleteAll;

                        if Cust.Get(Rec."BOSA Account No") then begin
                            ReceiptAllocations.Init;
                            ReceiptAllocations."Document No" := Rec.No;
                            ReceiptAllocations."Member No" := Rec."BOSA Account No";
                            ReceiptAllocations."Transaction Type" := ReceiptAllocations."transaction type"::"Interest Due";
                            ReceiptAllocations."Loan No." := Loans."Loan  No.";
                            ReceiptAllocations.Amount := ROUND(Cust."Insurance Contribution", 0.01);
                            ReceiptAllocations."Interest Amount" := Loans."Interest Due";
                            ReceiptAllocations."Total Amount" := ReceiptAllocations.Amount + ReceiptAllocations."Interest Amount";
                            ReceiptAllocations.Insert;

                            ReceiptAllocations.Init;
                            ReceiptAllocations."Document No" := Rec.No;
                            ReceiptAllocations."Member No" := Rec."BOSA Account No";
                            ReceiptAllocations."Transaction Type" := ReceiptAllocations."transaction type"::Loan;
                            ReceiptAllocations."Loan No." := Loans."Loan  No.";
                            ReceiptAllocations.Amount := ROUND(Cust."Monthly Contribution", 0.01);
                            ReceiptAllocations."Interest Amount" := Loans."Interest Due";
                            ReceiptAllocations."Total Amount" := ReceiptAllocations.Amount + ReceiptAllocations."Interest Amount";
                            ReceiptAllocations.Insert;

                            if Cust."Investment Monthly Cont" > 0 then begin
                                ReceiptAllocations.Init;
                                ReceiptAllocations."Document No" := Rec.No;
                                ReceiptAllocations."Member No" := Rec."BOSA Account No";
                                ReceiptAllocations."Transaction Type" := ReceiptAllocations."transaction type"::"Interest Paid";
                                ReceiptAllocations."Loan No." := Loans."Loan  No.";
                                ReceiptAllocations.Amount := ROUND(Cust."Investment Monthly Cont", 0.01);
                                ReceiptAllocations."Interest Amount" := Loans."Interest Due";
                                ReceiptAllocations."Total Amount" := ReceiptAllocations.Amount + ReceiptAllocations."Interest Amount";
                                ReceiptAllocations.Insert;
                            end;



                            Loans.Reset;
                            Loans.SetCurrentkey(Loans.Source, Loans."Client Code");
                            Loans.SetRange(Loans."Client Code", Rec."BOSA Account No");
                            Loans.SetRange(Loans.Source, Loans.Source::BOSA);
                            if Loans.Find('-') then begin
                                repeat
                                    Loans.CalcFields(Loans."Outstanding Balance", Loans."Interest Due");

                                    if (Loans."Outstanding Balance") > 0 then begin
                                        LOustanding := 0;


                                        ReceiptAllocations.Init;
                                        ReceiptAllocations."Document No" := Rec.No;
                                        ReceiptAllocations."Member No" := Rec."BOSA Account No";
                                        ReceiptAllocations."Transaction Type" := ReceiptAllocations."transaction type"::"Registration Fee";
                                        ReceiptAllocations."Loan No." := Loans."Loan  No.";
                                        ReceiptAllocations.Amount := ROUND(Loans."Loan Principle Repayment", 0.01);
                                        ReceiptAllocations."Interest Amount" := ROUND(Loans."Loan Interest Repayment", 0.01);
                                        ReceiptAllocations."Total Amount" := ReceiptAllocations.Amount + ReceiptAllocations."Interest Amount";
                                        ReceiptAllocations.Insert;


                                    end;
                                until Loans.Next = 0;
                            end;
                        end;
                    end;
                }
            }
            group(Transaction)
            {
                Caption = 'Transaction';
                action("Account Card")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account Card';
                    Image = Vendor;
                }
                separator(Action1102760031)
                {
                }
                action(Action1102760078)
                {
                    ApplicationArea = Basic;
                    Caption = 'Post';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    Visible = false;

                    trigger OnAction()
                    begin
                        /*IF UsersID.GET(USERID) THEN BEGIN
                        UsersID.TESTFIELD(UsersID.Branch);
                        DActivity:='FOSA';
                        DBranch:=UsersID.Branch;
                        END;*/

                        if Rec."Transaction Date" <> Today then begin
                            Rec."Transaction Date" := Today;
                            Rec.Modify;
                        end;



                        if Rec.Posted = true then
                            Error('The transaction has already been posted.');

                        VarAmtHolder := 0;

                        if Rec.Amount <= 0 then
                            Error('Please specify an amount greater than zero.');

                        if Rec."Transaction Type" = '' then
                            Error('Please select the transaction type.');

                        //BOSA Entries
                        if (Rec."Account No" = '502-00-000300-00') or (Rec."Account No" = '502-00-000303-00') then begin
                            Rec.TestField("BOSA Account No");
                            if Rec.Amount <> Rec."Allocated Amount" then
                                Error('Allocated amount must be equall to the transaction amount.');

                        end;


                        if Rec."Branch Transaction" = true then begin
                            if Rec."Branch Refference" = '' then
                                Error('You must specify the refference details for branch transactions.');
                        end;

                        //Project Accounts
                        if Acc.Get(Rec."Account No") then begin
                            if Acc."Account Category" = Acc."account category"::Project then begin
                                if Rec."Branch Refference" = '' then
                                    Error('You must specify the refference details for Project transactions.');
                            end;
                        end;
                        //Project Accounts


                        Rec."Post Attempted" := true;
                        Rec.Modify;

                        if Rec.Type = 'Cheque Deposit' then begin
                            Rec.TestField("Cheque Type");
                            Rec.TestField("Cheque No");
                            Rec.TestField("Cheque Date");

                            PostChequeDep;

                            exit;
                        end;

                        if Rec.Type = 'Bankers Cheque' then begin

                            PostBankersCheq;

                            exit;
                        end;

                        if Rec.Type = 'Encashment' then begin
                            PostEncashment;

                            exit;
                        end;

                        //NON CUST
                        /*
                        IF "Account No" = '507-10000-00' THEN BEGIN
                        PostEncashment;
                        
                        EXIT;
                        
                        END;
                        */
                        //NON CUST

                        //ADDED
                        PostCashDepWith;


                        exit;
                        //ADDED

                    end;
                }
                separator(Action1102760079)
                {
                }
                action("Stop Cheque")
                {
                    ApplicationArea = Basic;
                    Caption = 'Stop Cheque';
                    Image = Stop;
                    Promoted = true;
                    visible = false;

                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to stop the cheque?', false) = true then begin
                            Rec.Status := Rec.Status::Stopped;
                            Rec."Cheque Processed" := true;
                            Rec.Modify;
                        end;
                    end;
                }
            }
        }
        area(processing)
        {
            action(Post)
            {
                ApplicationArea = Basic;
                Caption = 'Post';
                Image = Post;
                visible = false;
                Promoted = true;
                PromotedCategory = Process;


                trigger OnAction()
                begin
                    BATCH_TEMPLATE := 'GENERAL';
                    BATCH_NAME := 'FTRANS';
                    DOCUMENT_NO := Rec.No;

                    BankLedger.Reset;
                    BankLedger.SetRange(BankLedger."Document No.", Rec.No);
                    if BankLedger.Find('-') then begin
                        Rec.Posted := true;
                        Rec.Modify;
                        Message('Transaction is aready posted');
                        exit;
                    end;
                    Rec.TestField(Description);
                    if Rec.Cashier <> UpperCase(UserId) then
                        Error('Cannot post a Transaction being processed by %1', Rec.Cashier);
                    if Rec.Description = '' then
                        Error('Please specify transacted by');
                    BankLedger.Reset;
                    BankLedger.SetRange(BankLedger."Posting Date", Today);
                    BankLedger.SetRange(BankLedger."User ID", Rec."Posted By");
                    BankLedger.SetRange(BankLedger.Description, 'END OF DAY RETURN TO TREASURY');
                    if BankLedger.Find('-') = true then begin
                        Error('You cannot post any transactions after perfoming end of day');
                    end;

                    UsersID.Reset;
                    UsersID.SetRange(UsersID."User ID", UpperCase(UserId));
                    if UsersID.Find('-') then begin
                        DBranch := UsersID.Branch;
                        DActivity := 'FOSA';
                    end;


                    if Rec."Transaction Date" <> Today then begin
                        Rec."Transaction Date" := Today;
                        Rec.Modify;
                    end;



                    if Rec.Posted = true then
                        Error('The transaction has already been posted.');

                    VarAmtHolder := 0;

                    if Rec.Amount <= 0 then
                        Error('Please specify an amount greater than zero.');

                    if Rec."Transaction Type" = '' then
                        Error('Please select the transaction type.');

                    //BOSA Entries
                    if (Rec."Account No" = '502-00-000300-00') or (Rec."Account No" = '502-00-000303-00') then begin
                        Rec.TestField("BOSA Account No");
                        if Rec.Amount <> Rec."Allocated Amount" then
                            Error('Allocated amount must be equall to the transaction amount.');

                    end;


                    if Rec."Branch Transaction" = true then begin
                        if Rec."Branch Refference" = '' then
                            Error('You must specify the refference details for branch transactions.');
                    end;

                    //Project Accounts
                    if Acc.Get(Rec."Account No") then begin
                        if Acc."Account Category" = Acc."account category"::Project then begin
                            if Rec."Branch Refference" = '' then
                                Error('You must specify the refference details for Project transactions.');
                        end;
                    end;
                    //Project Accounts


                    Rec."Post Attempted" := true;
                    Rec.Modify;

                    if Rec.Type = 'Cheque Deposit' then begin
                        Rec.TestField("Cheque Type");
                        Rec.TestField("Cheque No");
                        Rec.TestField("Cheque Date");
                        Rec.TestField("Bank Code");

                        PostChequeDep;

                        exit;
                    end;

                    if Rec.Type = 'Bankers Cheque' then begin

                        PostBankersCheq;

                        exit;
                    end;
                    if Rec.Type = 'BOSA Receipt' then begin
                        PostBOSAEntries;
                        exit;
                    end;

                    if Rec.Type = 'Encashment' then begin
                        PostEncashment;

                        exit;
                    end;

                    //NON CUST
                    /*
                    IF "Account No" = '507-10000-00' THEN BEGIN
                    PostEncashment;
                    
                    EXIT;
                    
                    END;
                    */
                    //NON CUST

                    //ADDED
                    PostCashDepWith;


                    exit;
                    //ADDED
                    //END;

                end;
            }
            action("Reprint Slip")
            {
                ApplicationArea = Basic;
                Caption = 'Reprint Slip';
                Image = "print";
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec.TestField(Posted);

                    Trans.Reset;
                    Trans.SetRange(Trans.No, Rec.No);
                    if Trans.Find('-') then begin
                        if Rec.Type = 'Cash Deposit' then
                            Report.Run(50281, true, true, Trans)
                        else
                            if Rec."Account No" = 'L01001011993' then
                                Report.Run(50857, true, true, Trans)
                            else
                                if Rec.Type = 'Withdrawal' then
                                    Report.Run(50282, true, true, Trans)
                                else
                                    if Rec.Type = 'encashment' then
                                        Report.Run(50281, true, true, Trans)
                                    else
                                        if Rec.Type = 'Cheque Deposit' then
                                            Report.Run(50433, true, true, Trans)
                    end;
                end;
            }
            action(Post1)
            {
                ApplicationArea = Basic;
                Caption = 'CC';
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    /*IF UsersID.GET(USERID) THEN BEGIN
                    UsersID.TESTFIELD(UsersID.Branch);
                    DActivity:='FOSA';
                    DBranch:=UsersID.Branch;
                    END;   */


                    //IF Posted=TRUE THEN
                    //ERROR('The transaction has already been posted.');

                    VarAmtHolder := 0;

                    if Rec.Amount <= 0 then
                        Error('Please specify an amount greater than zero.');

                    if Rec."Transaction Type" = '' then
                        Error('Please select the transaction type.');

                    //BOSA Entries
                    if (Rec."Account No" = '502-00-000300-00') or (Rec."Account No" = '502-00-000303-00') then begin
                        Rec.TestField("BOSA Account No");
                        if Rec.Amount <> Rec."Allocated Amount" then
                            Error('Allocated amount must be equall to the transaction amount.');

                    end;


                    if Rec."Branch Transaction" = true then begin
                        if Rec."Branch Refference" = '' then
                            Error('You must specify the refference detailes for branch transactions.');
                    end;

                    Rec."Post Attempted" := true;
                    Rec.Modify;

                    if Rec.Type = 'Cheque Deposit' then begin
                        Rec.TestField("Cheque Type");
                        Rec.TestField("Cheque No");
                        Rec.TestField("Cheque Date");

                        PostChequeDep;

                        exit;
                    end;

                    if Rec.Type = 'Bankers Cheque' then begin

                        PostBankersCheq;

                        exit;
                    end;

                    if Rec.Type = 'Encashment' then begin
                        PostEncashment;

                        exit;
                    end;

                    //ADDED
                    PostCashDepWith;


                    exit;
                    //ADDED

                end;
            }
            action(SendMail)
            {
                ApplicationArea = Basic;
                Caption = 'SendMail';
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    MailContent := 'Bankers cheque transaction' + ' ' + 'of Kshs' + ' ' + Format(Rec.Amount) + ' ' + 'for'
                    + ' ' + Rec."Account Name" + ' ' + 'needs your approval';


                    SendEmail;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        /*CalcAvailableBal;
        CLEAR(AccP.Picture);
        CLEAR(AccP.Signature);
        IF AccP.GET("Account No") THEN BEGIN
        AccP.CALCFIELDS(AccP.Picture);
        AccP.CALCFIELDS(AccP.Signature);
        END;
         */
        FChequeVisible := false;
        BChequeVisible := false;
        BReceiptVisible := false;
        BOSAReceiptChequeVisible := false;

        if Rec.Type = 'Cheque Deposit' then begin
            FChequeVisible := true;
            if (Rec."Account No" = '502-00-000300-00') or (Rec."Account No" = '502-00-000303-00') then
                BOSAReceiptChequeVisible := true;

        end;

        "Branch RefferenceVisible" := false;
        LRefVisible := false;


        if Rec.Type = 'Bankers Cheque' then
            BChequeVisible := true;

        if Rec.Type = 'Encashment' then
            BReceiptVisible := true;


        if Rec."Transaction Type" = 'BOSA' then
            BReceiptVisible := true;

        if Rec."Branch Transaction" = true then begin
            "Branch RefferenceVisible" := true;
            LRefVisible := true;
        end;

        if Acc.Get(Rec."Account No") then begin
            if Acc."Account Category" = Acc."account category"::Project then begin
                "Branch RefferenceVisible" := true;
                LRefVisible := true;
            end;
        end;


        "Transaction DateEditable" := false;
        if Rec."Post Dated" = true then
            "Transaction DateEditable" := true;

    end;

    trigger OnDeleteRecord(): Boolean
    begin
        if Rec.Posted = true then
            Error('You cannot delete an already posted record.');
    end;

    trigger OnInit()
    var
    begin
        "Transaction DateEditable" := true;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Clear(Acc.Image);
        Clear(Acc.Signature);

        Rec."Needs Approval" := Rec."needs approval"::No;
        FChequeVisible := false;

        CashierTrans.Reset;
        CashierTrans.SetRange(CashierTrans.Posted, false);
        CashierTrans.SetRange(CashierTrans.Cashier, UserId);
        if CashierTrans.Count > 0 then begin
            if CashierTrans."Account No." = '' then begin
                if Confirm(text002, false) = false then
                    Error(text003);
            end;
        end;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        if xRec.Posted = true then begin
            if Rec.Posted = true then
                Error('You cannot modify an already posted record.');
        end;
    end;

    trigger OnOpenPage()
    begin
        /*IF UsersID.GET(USERID) THEN BEGIN
        IF UsersID.Branch <> '' THEN
        SETRANGE("Transacting Branch",UsersID.Branch);
        END;*/
        //SETRANGE(Cashier,USERID);

        if Rec.Posted = true then
            CurrPage.Editable := false

    end;

    var
        LoanBalance: Decimal;
        AvailableBalance: Decimal;
        UnClearedBalance: Decimal;
        LoanSecurity: Decimal;
        LoanGuaranteed: Decimal;
        GenJournalLine: Record "Gen. Journal Line";
        DefaultBatch: Record "Gen. Journal Batch";
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        window: Dialog;
        Account: Record Vendor;
        TransactionTypes: Record "Transaction Types";
        TransactionCharges: Record "Transaction Charges";
        TCharges: Decimal;
        LineNo: Integer;
        AccountTypes: Record "Account Types-Saving Products";
        GenLedgerSetup: Record "General Ledger Setup";
        MinAccBal: Decimal;
        FeeBelowMinBal: Decimal;
        AccountNo: Code[30];
        NewAccount: Boolean;
        CurrentTellerAmount: Decimal;
        TellerTill: Record "Bank Account";
        IntervalPenalty: Decimal;
        StandingOrders: Record "Standing Orders";
        AccountAmount: Decimal;
        STODeduction: Decimal;
        Charges: Record Charges;
        "Total Deductions": Decimal;
        STODeductedAmount: Decimal;
        NoticeAmount: Decimal;
        AccountNotices: Record "Account Notices";
        Cust: Record Customer;
        AccountHolders: Record Vendor;
        ChargesOnFD: Decimal;
        TotalGuaranted: Decimal;
        VarAmtHolder: Decimal;
        chqtransactions: Record Transactions;
        Trans: Record Transactions;
        TotalUnprocessed: Decimal;
        CustAcc: Record Customer;
        AmtAfterWithdrawal: Decimal;
        TransactionsRec: Record Transactions;
        LoansTotal: Decimal;
        Interest: Decimal;
        InterestRate: Decimal;
        OBal: Decimal;
        Principal: Decimal;
        ATMTrans: Decimal;
        ATMBalance: Decimal;
        TotalBal: Decimal;
        DenominationsRec: Record Denominations;
        TillNo: Code[20];
        FOSASetup: Record "Purchases & Payables Setup";
        Acc: Record Vendor;
        ChequeTypes: Record "Cheque Types";
        ChargeAmount: Decimal;
        ChargeAmountTax: Decimal;
        TChargeAmount: Decimal;
        DActivity: Code[20];
        DBranch: Code[20];
        UsersID: Record "User Setup";
        ChBank: Code[20];
        DValue: Record "Dimension Value";
        ReceiptAllocations: Record "Receipt Allocation";
        Loans: Record "Loans Register";
        Commision: Decimal;
        Cheque: Boolean;
        LOustanding: Decimal;
        TotalCommision: Decimal;
        TotalOustanding: Decimal;
        BOSABank: Code[20];
        InterestPaid: Decimal;
        PaymentAmount: Decimal;
        RunBal: Decimal;
        Recover: Boolean;
        genSetup: Record "Sacco General Set-Up";
        MailContent: Text[150];
        supervisor: Record "Supervisors Approval Levels";
        TEXT1: label 'YOU HAVE A TRANSACTION AWAITING APPROVAL';
        AccP: Record Vendor;
        LoansR: Record "Loans Register";
        ClearingCharge: Decimal;
        ClearingRate: Decimal;
        [InDataSet]
        FChequeVisible: Boolean;
        [InDataSet]
        BChequeVisible: Boolean;
        [InDataSet]
        BReceiptVisible: Boolean;
        [InDataSet]
        BOSAReceiptChequeVisible: Boolean;
        [InDataSet]
        "Branch RefferenceVisible": Boolean;
        [InDataSet]
        LRefVisible: Boolean;
        [InDataSet]
        "Transaction DateEditable": Boolean;
        Excise: Decimal;
        Echarge: Decimal;
        BankLedger: Record "Bank Account Ledger Entry";
        SMSMessage: Record "SMS Messages";
        iEntryNo: Integer;
        Vend1: Record Vendor;
        TransDesc: Text;
        TransTypes: Record "Transaction Types";
        ObjTransactionCharges: Record "Transaction Charges";
        TariffDetails: Record "Tariff Details";
        CompanyInfo: Record "Company Information";
        ChqCharges: Record "Cheque Commissions";
        "Cheque Type": Record "Cheque Types";
        "Account No.": Integer;
        CashierTrans: Record Transactions;
        text002: label 'There are unused transactions. Do you wish to continue?';
        text003: label 'Please utilize the unused transactions first';
        Jtemplate: Code[30];
        BankAccount: Record "Bank Account";
        JBatch: Code[30];
        AccountOpening: Codeunit SureAccountCharges;
        AvailableOverDraft: Decimal;
        ObjVendorOverDraft: Record Vendor;
        BALRUN: Decimal;
        OVERDRAFTREC: Record Vendor;
        "overdraftcomm a/c": Code[10];
        ObjVendor: Record Vendor;
        commoverdraft: Decimal;
        OverdraftAcc: Record "Over Draft Register";
        OVERBAL: Decimal;
        RemainAmount: Decimal;
        Overdraftbank: Code[10];
        dbanch: Code[50];
        Vend: Record Vendor;
        IntBuffer: Record "Interest Buffers";
        BATCH_TEMPLATE: Code[100];
        BATCH_NAME: Code[100];
        DOCUMENT_NO: Code[100];
        SFactory: Codeunit "Swizzsoft Factory";
        CommisionOnOverdraft: Decimal;
        ODNumber: Code[100];
        InterestOnOverdraft: Decimal;
        AdjustmentAmount: Decimal;


    procedure CalcAvailableBal()
    begin
        ATMBalance := 0;

        TCharges := 0;
        AvailableBalance := 0;
        MinAccBal := 0;
        TotalUnprocessed := 0;
        IntervalPenalty := 0;


        if Account.Get(Rec."Account No") then begin
            Account.CalcFields(Account.Balance, Account."Uncleared Cheques", Account."ATM Transactions");

            //balanceov:=Account."Overdraft amount";
            AccountTypes.Reset;
            AccountTypes.SetRange(AccountTypes.Code, Rec."Account Type");
            if AccountTypes.Find('-') then begin
                MinAccBal := AccountTypes."Minimum Balance";
                FeeBelowMinBal := AccountTypes."Fee Below Minimum Balance";


                //Check Withdrawal Interval
                if Account.Status <> Account.Status::New then begin
                    if Rec.Type = 'Withdrawal' then begin
                        AccountTypes.Reset;
                        AccountTypes.SetRange(AccountTypes.Code, Rec."Account Type");
                        if Account."Last Withdrawal Date" <> 0D then begin
                            if CalcDate(AccountTypes."Withdrawal Interval", Account."Last Withdrawal Date") > Today then
                                IntervalPenalty := AccountTypes."Withdrawal Penalty";
                        end;
                    end;
                    //Check Withdrawal Interval

                    //Fixed Deposit
                    ChargesOnFD := 0;
                    if AccountTypes."Fixed Deposit" = true then begin
                        if Account."Expected Maturity Date" > Today then
                            ChargesOnFD := AccountTypes."Charge Closure Before Maturity";
                    end;
                    //Fixed Deposit


                    //Current Charges
                    TransactionCharges.Reset;
                    TransactionCharges.SetRange(TransactionCharges."Transaction Type", Rec."Transaction Type");
                    if TransactionCharges.Find('-') then begin
                        repeat
                            if TransactionCharges."Use Percentage" = true then begin
                                TransactionCharges.TestField("Percentage of Amount");
                                TCharges := TCharges + (TransactionCharges."Percentage of Amount" / 100) * Rec."Book Balance";
                            end else begin
                                TCharges := TCharges + TransactionCharges."Charge Amount";
                            end;
                        until TransactionCharges.Next = 0;
                    end;


                    TotalUnprocessed := Account."Uncleared Cheques";
                    ATMBalance := Account."ATM Transactions";

                    //FD
                    if AccountTypes."Fixed Deposit" = false then begin
                        if Account.Balance < MinAccBal then
                            AvailableBalance := Account.Balance - FeeBelowMinBal - TCharges - IntervalPenalty - MinAccBal - TotalUnprocessed - ATMBalance -
                                              Account."EFT Transactions" - Account."Piggy Amount" - Account."Junior Trip"
                        else
                            AvailableBalance := Account.Balance - TCharges - IntervalPenalty - MinAccBal - TotalUnprocessed - ATMBalance -
                                              Account."EFT Transactions" - Account."Piggy Amount" - Account."Junior Trip";
                    end else begin
                        AvailableBalance := Account.Balance - TCharges - ChargesOnFD - Account."ATM Transactions" - Account."Piggy Amount" - Account."Junior Trip";
                    end;
                end;
                //FD
                // if Rec.Withdarawal = true then begin
                //     AvailableBalance := Account.Balance - FeeBelowMinBal - TCharges - IntervalPenalty - TotalUnprocessed - ATMBalance -
                //                       Account."EFT Transactions" - Account."Piggy Amount" - Account."Junior Trip";
                //     //Abel
                //     if Account."Account Type" = 'ENCASHMENT' then
                //         AvailableBalance := Account.Balance;

                // end;



            end;
        end;

        if Rec."N.A.H Balance" <> 0 then
            AvailableBalance := Rec."N.A.H Balance";
    end;


    procedure PostChequeDep()
    begin
        if Confirm('Are You Sure You Want to Post this Cheque?', false) = true then begin

            DValue.Reset;
            DValue.SetRange(DValue."Global Dimension No.", 2);
            DValue.SetRange(DValue.Code, DBranch);


            ChBank := Rec."Bank Code";

            if ChequeTypes.Get(Rec."Cheque Type") then begin
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
                GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                GenJournalLine.DeleteAll;

                LineNo := LineNo + 10000;

                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := 'PURCHASES';
                GenJournalLine."Journal Batch Name" := 'FTRANS';
                GenJournalLine."Document No." := Rec.No;
                GenJournalLine."External Document No." := Rec."Cheque No";
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                GenJournalLine."Account No." := Rec."Account No";

                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Posting Date" := Rec."Transaction Date";
                if Rec."Branch Transaction" = true then
                    GenJournalLine.Description := Rec."Transaction Type" + '-' + Rec."Branch Refference"
                else
                    GenJournalLine.Description := Rec."Transaction Description" + '-' + Rec.Description;
                //Project Accounts
                if Acc.Get(Rec."Account No") then begin
                    if Acc."Account Category" = Acc."account category"::Project then
                        GenJournalLine.Description := Rec."Transaction Type" + '-' + Rec."Branch Refference"
                end;
                //Project Accounts
                GenJournalLine.Validate(GenJournalLine."Currency Code");
                GenJournalLine.Amount := -Rec.Amount;
                GenJournalLine.Validate(GenJournalLine.Amount);
                GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;

                LineNo := LineNo + 10000;

                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := 'PURCHASES';
                GenJournalLine."Journal Batch Name" := 'FTRANS';
                GenJournalLine."Document No." := Rec.No;
                GenJournalLine."External Document No." := Rec."Cheque No";
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
                GenJournalLine."Account No." := ChBank;
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Posting Date" := Rec."Transaction Date";
                GenJournalLine.Description := Rec."Account Name";
                GenJournalLine.Validate(GenJournalLine."Currency Code");
                GenJournalLine.Amount := Rec.Amount;
                GenJournalLine.Validate(GenJournalLine.Amount);
                GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;



                //**************************Post Charges***************************


                //*********************Local cheque charges************************
                if Rec."Cheque Type" = 'LOCAL' then begin

                    ChargeAmount := 0;

                    ChqCharges.Reset;
                    if ChqCharges.Find('-') then
                        if (Rec."Account No" <> 'SALARIES') and (Rec."Account No" <> 'ENCASHMENT') and (Rec."Account No" <> 'TEA') and (Rec."Account No" <> 'MILK') then
                            repeat
                                if ChqCharges."Use Percentage(Local)" = false then begin
                                    if (Rec.Amount >= ChqCharges."Minimum Amount(Local)") and (Rec.Amount <= ChqCharges."Maximum Amount(Local)") then begin
                                        ChargeAmount := ChqCharges."Charge(Local)";
                                    end
                                end else begin
                                    if (Rec.Amount >= ChqCharges."Minimum Amount(Local)") and (Rec.Amount <= ChqCharges."Maximum Amount(Local)") then begin
                                        ChargeAmount := (Rec.Amount * ChqCharges."% Amount(Local)") / 100;
                                    end
                                end

                            until ChqCharges.Next = 0;

                    LineNo := LineNo + 10000;

                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'PURCHASES';
                    GenJournalLine."Journal Batch Name" := 'FTRANS';
                    GenJournalLine."Document No." := Rec.No;
                    GenJournalLine."External Document No." := Rec."Cheque No";
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                    GenJournalLine."Account No." := Rec."Account No";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Posting Date" := Rec."Transaction Date";
                    GenJournalLine.Description := 'Local Cheque Deposit Commission';
                    GenJournalLine.Validate(GenJournalLine."Currency Code");
                    GenJournalLine.Amount := ChargeAmount;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                    GenJournalLine."Bal. Account No." := ChequeTypes."Clearing Charges GL Account";
                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                    GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;
                end;
                //MESSAGE('You will be charged LOCAL %1',ChargeAmount);
            end;
        end;

        genSetup.Get(0);

        LineNo := LineNo + 10000;
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := 'PURCHASES';
        GenJournalLine."Journal Batch Name" := 'FTRANS';
        GenJournalLine."Document No." := Rec.No;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
        GenJournalLine."Account No." := Rec."Account No";
        GenJournalLine."External Document No." := Rec."ID No";
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := Rec."Transaction Date";
        GenJournalLine.Description := 'Excise Duty on Cheque Commission';
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        if Rec."Cheque Type" = 'LOCAL' then
            GenJournalLine.Amount := (ChargeAmount * genSetup."Excise Duty(%)") / 100;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
        GenJournalLine."Bal. Account No." := genSetup."Excise Duty Account";
        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;

        //*********************Upcountry cheque charges************************

        if Rec."Cheque Type" = 'UPCOUNTRY' then begin
            //LineNo:=LineNo+10000;
            ChargeAmount := 0;

            ChqCharges.Reset;
            if ChqCharges.Find('-') then
                if (Rec."Account No" <> 'SALARIES') and (Rec."Account No" <> 'ENCASHMENT') and (Rec."Account No" <> 'TEA') and (Rec."Account No" <> 'MILK')

                then
                    repeat
                        if ChqCharges."Use Percentage(Upcountry)" = false then begin
                            if (Rec.Amount >= ChqCharges."Minimum Amount(Upcountry)") and (Rec.Amount <= ChqCharges."Maximum Amount(Upcountry)") then begin
                                ChargeAmount := ChqCharges."Charge(Upcountry)";
                            end
                        end else begin
                            if (Rec.Amount >= ChqCharges."Minimum Amount(Upcountry)") and (Rec.Amount <= ChqCharges."Maximum Amount(Upcountry)") then begin
                                ChargeAmount := (Rec.Amount * ChqCharges."% Amount(Upcountry)") / 100;
                            end
                        end

                    until ChqCharges.Next = 0;

            LineNo := LineNo + 10000;

            GenJournalLine.Init;
            GenJournalLine."Journal Template Name" := 'PURCHASES';
            GenJournalLine."Journal Batch Name" := 'FTRANS';
            GenJournalLine."Document No." := Rec.No;
            GenJournalLine."External Document No." := Rec."Cheque No";
            GenJournalLine."Line No." := LineNo;
            GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
            GenJournalLine."Account No." := Rec."Account No";
            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine."Posting Date" := Rec."Transaction Date";
            GenJournalLine.Description := 'Upcountry Cheque Deposit Commission';
            GenJournalLine.Validate(GenJournalLine."Currency Code");
            GenJournalLine.Amount := ChargeAmount;
            GenJournalLine.Validate(GenJournalLine.Amount);
            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
            GenJournalLine."Bal. Account No." := ChequeTypes."Clearing Charges GL Account";
            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
            if GenJournalLine.Amount <> 0 then
                GenJournalLine.Insert;
        end;

        genSetup.Get(0);

        LineNo := LineNo + 10000;
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := 'PURCHASES';
        GenJournalLine."Journal Batch Name" := 'FTRANS';
        GenJournalLine."Document No." := Rec.No;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
        GenJournalLine."Account No." := Rec."Account No";
        GenJournalLine."External Document No." := Rec."ID No";
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := Rec."Transaction Date";
        GenJournalLine.Description := 'Excise Duty on Cheque Commission';
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        if Rec."Cheque Type" = 'UPCOUNTRY' then
            GenJournalLine.Amount := (ChargeAmount * genSetup."Excise Duty(%)") / 100;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
        GenJournalLine."Bal. Account No." := genSetup."Excise Duty Account";
        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;


        //*********************Inhouse cheque charges************************

        if Rec."Cheque Type" = 'INHOUSE' then begin
            //LineNo:=LineNo+10000;
            ChargeAmount := 0;

            ChqCharges.Reset;
            if ChqCharges.Find('-') then
                if (Rec."Account No" <> 'SALARIES') and (Rec."Account No" <> 'ENCASHMENT') and (Rec."Account No" <> 'TEA') and (Rec."Account No" <> 'MILK')

                then
                    repeat
                        if ChqCharges."Use Percentage(Inhouse)" = false then begin
                            if (Rec.Amount >= ChqCharges."Minimum Amount(Inhouse)") and (Rec.Amount <= ChqCharges."Maximum Amount(Inhouse)") then begin
                                ChargeAmount := ChqCharges."Charge(Inhousel)";
                            end
                        end else begin
                            if (Rec.Amount >= ChqCharges."Minimum Amount(Inhouse)") and (Rec.Amount <= ChqCharges."Maximum Amount(Inhouse)") then begin
                                ChargeAmount := (Rec.Amount * ChqCharges."% Amount (Inhouse)") / 100;
                            end
                        end

                    until ChqCharges.Next = 0;

            LineNo := LineNo + 10000;

            GenJournalLine.Init;
            GenJournalLine."Journal Template Name" := 'PURCHASES';
            GenJournalLine."Journal Batch Name" := 'FTRANS';
            GenJournalLine."Document No." := Rec.No;
            GenJournalLine."External Document No." := Rec."Cheque No";
            GenJournalLine."Line No." := LineNo;
            GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
            GenJournalLine."Account No." := Rec."Account No";
            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine."Posting Date" := Rec."Transaction Date";
            GenJournalLine.Description := 'Inhouse Cheque Deposit Commission';
            GenJournalLine.Validate(GenJournalLine."Currency Code");
            GenJournalLine.Amount := ChargeAmount;
            GenJournalLine.Validate(GenJournalLine.Amount);
            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
            GenJournalLine."Bal. Account No." := ChequeTypes."Clearing Charges GL Account";
            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
            if GenJournalLine.Amount <> 0 then
                GenJournalLine.Insert;
        end;
        //MESSAGE('You will be charged inhouse %1',ChargeAmount);
        //END;
        //END;

        genSetup.Get(0);

        LineNo := LineNo + 10000;
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := 'PURCHASES';
        GenJournalLine."Journal Batch Name" := 'FTRANS';
        GenJournalLine."Document No." := Rec.No;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
        GenJournalLine."Account No." := Rec."Account No";
        GenJournalLine."External Document No." := Rec."ID No";
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := Rec."Transaction Date";
        GenJournalLine.Description := 'Excise Duty on Cheque Commission';
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        if Rec."Cheque Type" = 'INHOUSE' then
            GenJournalLine.Amount := (ChargeAmount * genSetup."Excise Duty(%)") / 100;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
        GenJournalLine."Bal. Account No." := genSetup."Excise Duty Account";
        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;


        //Post New
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
        if GenJournalLine.Find('-') then begin
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Batch", GenJournalLine);
        end;

        //Post New


        Rec.Posted := true;
        Rec.Authorised := Rec.Authorised::Yes;
        Rec."Supervisor Checked" := true;
        Rec."Needs Approval" := Rec."needs approval"::No;
        Rec."Frequency Needs Approval" := Rec."frequency needs approval"::No;
        Rec."Date Posted" := Today;
        Rec."Time Posted" := Time;
        Rec."Posted By" := UserId;
        if ChequeTypes."Clearing  Days" = 0 then begin
            Rec.Status := Rec.Status::Honoured;
            Rec."Cheque Processed" := true;
            Rec."Date Cleared" := Today;
        end;

        Rec.Modify;

        //SMS
        Vend1.Reset;
        Vend1.SetRange(Vend1."No.", Rec."Account No");
        if Vend1.Find('-') then begin
            TransDesc := '';
            TransTypes.Reset;
            TransTypes.SetRange(TransTypes.Code, Rec."Transaction Type");
            if TransTypes.Find('-') then begin
                TransDesc := TransTypes.Description;
            end;
            //SMS MESSAGE
            SMSMessage.Reset;
            if SMSMessage.Find('+') then begin
                iEntryNo := SMSMessage."Entry No";
                iEntryNo := iEntryNo + 1;
            end else begin
                iEntryNo := 1;
            end;
            SMSMessage.Reset;
            SMSMessage.Init;
            SMSMessage."Entry No" := iEntryNo;
            SMSMessage."Account No" := Vend1."No.";
            SMSMessage."Date Entered" := Today;
            SMSMessage."Time Entered" := Time;
            SMSMessage.Source := 'OTC SMS';
            SMSMessage."Entered By" := UserId;
            SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
            if Rec.Amount <> 0 then begin
                SMSMessage."SMS Message" := 'You have done a Transaction of KSHS. ' +
                Format(Rec.Amount) + ' of type ' + TransDesc + ' on ' + Format(Today) + ' ' + Format(Time) + ' to your Account at Polytech Sacco'; //'CompanyInfo.Name ' .';
            end;
            if Vend1."MPESA Mobile No" <> '' then begin
                //SMSMessage."Telephone No":=Vend1."MPESA Mobile No";
            end else begin
                SMSMessage."Telephone No" := Vend1."Phone No.";
            end;
            if SMSMessage."Telephone No" <> '' then
                SMSMessage.Insert;
        end;
        //END;
        //END;

        Message('Cheque deposited successfully.');
        //***********be printing after posting,users requested
        Trans.Reset;
        Trans.SetRange(Trans.No, Rec.No);
        if Trans.Find('-') then begin
            if Confirm('Print Cheque Deposit Slip?', false) = true then
                //Report.Run(50433, false, true, Trans);
                Report.Run(50433, true, true, Trans);
        end;
        CurrPage.Close;
        //END;
        Commit;
    end;


    procedure PostBankersCheq()
    begin
        //Block Payments
        if Acc.Get(Rec."Account No") then begin
            if Acc.Blocked = Acc.Blocked::Payment then
                Error('This account has been blocked from receiving payments.');
        end;

        Rec.TestField("Bank Code");

        ChBank := Rec."Bank Code";

        CalcAvailableBal;

        //Check withdrawal limits
        if Rec.Type = 'Bankers Cheque' then begin
            if AvailableBalance < Rec.Amount then begin
                if Rec.Authorised = Rec.Authorised::Yes then begin
                    Rec.Overdraft := true;
                    Rec.Modify;
                end;

                if Rec.Authorised = Rec.Authorised::No then begin
                    if Rec."Branch Transaction" = false then begin
                        Rec."Authorisation Requirement" := 'Bankers Cheque - Over draft';
                        Rec.Modify;
                        Message('You cannot issue a Bankers cheque more than the available balance unless authorised.');
                        SendEmail;
                        exit;
                    end;
                end;
                if Rec.Authorised = Rec.Authorised::Rejected then
                    Error('Bankers cheque transaction has been rejected and therefore cannot proceed.');
                //SendEmail;
            end;
        end;
        //Check withdrawal limits


        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
        GenJournalLine.DeleteAll;

        LineNo := LineNo + 10000;

        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := 'PURCHASES';
        GenJournalLine."Journal Batch Name" := 'FTRANS';
        GenJournalLine."Document No." := Rec.No;
        GenJournalLine."External Document No." := Rec."Bankers Cheque No";
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
        GenJournalLine."Account No." := Rec."Account No";
        GenJournalLine.Validate(GenJournalLine."Account No.");

        GenJournalLine."Posting Date" := Rec."Transaction Date";
        if Rec."Branch Transaction" = true then
            GenJournalLine.Description := Rec."Transaction Type" + '-' + Rec."Branch Refference"
        else
            GenJournalLine.Description := Rec."Transaction Description" + '-' + Rec.Description;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := Rec.Amount;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;

        LineNo := LineNo + 10000;

        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := 'PURCHASES';
        GenJournalLine."Journal Batch Name" := 'FTRANS';
        GenJournalLine."Document No." := Rec.No;
        GenJournalLine."External Document No." := Rec."Bankers Cheque No";
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
        GenJournalLine."Account No." := ChBank;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := Rec."Transaction Date";
        GenJournalLine.Description := Rec.Payee;//"Account Name";
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := -Rec.Amount;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;


        //Charges
        TransactionCharges.Reset;
        TransactionCharges.SetRange(TransactionCharges."Transaction Type", Rec."Transaction Type");
        if TransactionCharges.Find('-') then begin
            repeat
                LineNo := LineNo + 10000;

                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := 'PURCHASES';
                GenJournalLine."Journal Batch Name" := 'FTRANS';
                GenJournalLine."Document No." := Rec.No;
                GenJournalLine."External Document No." := Rec."Bankers Cheque No";
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                GenJournalLine."Account No." := Rec."Account No";
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Posting Date" := Rec."Transaction Date";
                GenJournalLine.Description := TransactionCharges.Description;
                GenJournalLine.Validate(GenJournalLine."Currency Code");
                GenJournalLine.Amount := TransactionCharges."Charge Amount";
                GenJournalLine.Validate(GenJournalLine.Amount);
                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                GenJournalLine."Bal. Account No." := TransactionCharges."G/L Account";
                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;

                if TransactionCharges."Due Amount" > 0 then begin
                    LineNo := LineNo + 10000;

                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'PURCHASES';
                    GenJournalLine."Journal Batch Name" := 'FTRANS';
                    GenJournalLine."Document No." := Rec.No;
                    GenJournalLine."External Document No." := Rec."Bankers Cheque No";
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                    GenJournalLine."Account No." := TransactionCharges."G/L Account";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Posting Date" := Rec."Transaction Date";
                    GenJournalLine.Description := TransactionCharges.Description;
                    GenJournalLine.Validate(GenJournalLine."Currency Code");
                    GenJournalLine.Amount := TransactionCharges."Due Amount";
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"Bank Account";
                    GenJournalLine."Bal. Account No." := ChBank;
                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                    GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;


                end;

            until TransactionCharges.Next = 0;
        end;

        //Charges

        //Excise Duty
        genSetup.Get(0);

        LineNo := LineNo + 10000;
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := 'PURCHASES';
        GenJournalLine."Journal Batch Name" := 'FTRANS';
        GenJournalLine."Document No." := Rec.No;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
        GenJournalLine."Account No." := Rec."Account No";
        GenJournalLine."External Document No." := Rec."ID No";
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := Rec."Transaction Date";
        GenJournalLine.Description := 'Excise Duty';
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        TransactionCharges.Reset;
        //GenJournalLine.Amount:=(TransactionCharges."Charge Amount"*(genSetup."Excise Duty(%)"/100));
        GenJournalLine.Amount := (TransactionCharges."Charge Amount" * 0.1);
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
        GenJournalLine."Bal. Account No." := genSetup."Excise Duty Account";
        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;



        //Post New
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
        if GenJournalLine.Find('-') then begin
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Batch", GenJournalLine);
        end;

        //Post New


        Rec."Transaction Available Balance" := AvailableBalance;
        Rec.Posted := true;
        Rec.Authorised := Rec.Authorised::Yes;
        Rec."Supervisor Checked" := true;
        Rec."Needs Approval" := Rec."needs approval"::No;
        Rec."Frequency Needs Approval" := Rec."frequency needs approval"::No;
        Rec."Date Posted" := Today;
        Rec."Time Posted" := Time;
        Rec."Posted By" := UserId;
        Rec.Modify;
        /*IF CONFIRM('Are you sure you want to print this bankers cheque?',TRUE)=TRUE THEN BEGIN
        REPORT.RUN(,TRUE,TRUE,Trans)
        END;*/
        Commit;

        Message('Bankers cheque posted successfully.');

        //SMS
        Vend1.Reset;
        Vend1.SetRange(Vend1."No.", Rec."Account No");
        if Vend1.Find('-') then begin
            TransDesc := '';
            TransTypes.Reset;
            TransTypes.SetRange(TransTypes.Code, Rec."Transaction Type");
            if TransTypes.Find('-') then begin
                TransDesc := TransTypes.Description;
            end;
            //SMS MESSAGE
            SMSMessage.Reset;
            if SMSMessage.Find('+') then begin
                iEntryNo := SMSMessage."Entry No";
                iEntryNo := iEntryNo + 1;
            end else begin
                iEntryNo := 1;
            end;
            SMSMessage.Reset;
            SMSMessage.Init;
            SMSMessage."Entry No" := iEntryNo;
            SMSMessage."Account No" := Vend1."No.";
            SMSMessage."Date Entered" := Today;
            SMSMessage."Time Entered" := Time;
            SMSMessage.Source := 'OTC SMS';
            SMSMessage."Entered By" := UserId;
            SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
            if Rec.Amount <> 0 then begin
                SMSMessage."SMS Message" := 'You have done a Bankers Cheque Transaction of KSHS. ' +
                Format(Rec.Amount) + ' of type ' + TransDesc + ' on ' + Format(Today) + ' ' + Format(Time) + ' from your Account at Polytech Sacco';
            end;
            if Vend1."MPESA Mobile No" <> '' then begin
                // SMSMessage."Telephone No":=Vend1."MPESA Mobile No";
            end else begin
                SMSMessage."Telephone No" := Vend1."Phone No.";
            end;
            if SMSMessage."Telephone No" <> '' then
                SMSMessage.Insert;


        end;
        //END;

    end;


    procedure PostEncashment()
    begin
        //Block Payments
        if Acc.Get(Rec."Account No") then begin
            if Acc.Blocked = Acc.Blocked::Payment then
                Error('This account has been blocked from receiving payments.');
        end;


        CalcAvailableBal;

        //Check withdrawal limits
        if Rec.Type = 'Encashment' then begin
            if AvailableBalance < Rec.Amount then begin
                if Rec.Authorised = Rec.Authorised::Yes then begin
                    Rec.Overdraft := true;
                    Rec.Modify;
                end;

                if Rec.Authorised = Rec.Authorised::No then begin
                    Rec."Authorisation Requirement" := 'Encashment - Over draft';
                    Rec.Modify;
                    Message('You cannot issue an encashment more than the available balance unless authorised.');
                    MailContent := 'Withdrawal transaction' + 'TR. No.' + ' ' + Rec.No + ' ' + 'of Kshs' + ' ' + Format(Rec.Amount) + ' ' + 'for'
                    + ' ' + Rec."Account Name" + ' ' + 'needs your authorization';
                    SendEmail;

                    //SendEmail;
                    exit;
                end;
                if Rec.Authorised = Rec.Authorised::Rejected then begin
                    MailContent := 'Bankers cheque transaction' + ' ' + 'of Kshs' + ' ' + Format(Rec.Amount) + ' ' + 'for'
                    + ' ' + Rec."Account Name" + ' ' + 'needs your approval';
                    SendEmail;
                    Error('Transaction has been rejected and therefore cannot proceed.');

                end;
            end;
        end;

        TillNo := '';
        TellerTill.Reset;
        TellerTill.SetRange(TellerTill."Account Type", TellerTill."account type"::Cashier);
        TellerTill.SetRange(TellerTill.CashierID, UserId);
        if TellerTill.Find('-') then begin
            TillNo := TellerTill."No.";
            TellerTill.CalcFields(TellerTill.Balance);

            CurrentTellerAmount := TellerTill.Balance;

            if CurrentTellerAmount - Rec.Amount <= TellerTill."Min. Balance" then
                Message('You need to add more money from the treasury since your balance has gone below the teller replenishing level.');

            if (Rec."Transaction Type" = 'Withdrawal') or (Rec."Transaction Type" = 'Encashment') then begin
                if (CurrentTellerAmount - Rec.Amount) < 0 then
                    Error('You do not have enough money to carry out this transaction.');

            end;

            if (Rec."Transaction Type" = 'Withdrawal') or (Rec."Transaction Type" = 'Encashment') then begin
                if CurrentTellerAmount - Rec.Amount >= TellerTill."Maximum Teller Withholding" then
                    Message('You need to transfer money back to the treasury since your balance has gone above the teller maximum withholding.');

            end else begin
                if CurrentTellerAmount + Rec.Amount >= TellerTill."Maximum Teller Withholding" then
                    Message('You need to transfer money back to the treasury since your balance has gone above the teller maximum withholding.');
            end;


        end;

        if TillNo = '' then
            Message('Teller account not set-up.');

        //Check Teller Balances




        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
        GenJournalLine.DeleteAll;

        LineNo := LineNo + 10000;

        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := 'PURCHASES';
        GenJournalLine."Journal Batch Name" := 'FTRANS';
        GenJournalLine."Document No." := Rec.No;
        GenJournalLine."External Document No." := Rec."ID No";
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
        GenJournalLine."Account No." := Rec."Account No";
        if (Rec."Account No" = '00-0000003000') or (Rec."Account No" = '00-0200003000') then
            GenJournalLine."External Document No." := Rec."ID No";

        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := Rec."Transaction Date";
        GenJournalLine.Description := Rec.Payee;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := Rec.Amount;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;


        //Charges
        TCharges := 0;
        //ADDED
        TChargeAmount := 0;


        TransactionCharges.Reset;
        TransactionCharges.SetRange(TransactionCharges."Transaction Type", Rec."Transaction Type");
        if TransactionCharges.Find('-') then begin
            repeat
                LineNo := LineNo + 10000;

                ChargeAmount := 0;

                if TransactionCharges."Use Percentage" = true then
                    ChargeAmount := (Rec.Amount * TransactionCharges."Percentage of Amount") * 0.01
                else
                    ChargeAmount := TransactionCharges."Charge Amount";

                if (TransactionCharges."Minimum Amount" <> 0) and (ChargeAmount < TransactionCharges."Minimum Amount") then
                    ChargeAmount := TransactionCharges."Minimum Amount";

                if (TransactionCharges."Maximum Amount" <> 0) and (ChargeAmount > TransactionCharges."Maximum Amount") then
                    ChargeAmount := TransactionCharges."Maximum Amount";



                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := 'PURCHASES';
                GenJournalLine."Journal Batch Name" := 'FTRANS';
                GenJournalLine."Document No." := Rec.No;
                GenJournalLine."External Document No." := Rec."ID No";
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                GenJournalLine."Account No." := TransactionCharges."G/L Account";
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Posting Date" := Rec."Transaction Date";
                GenJournalLine.Description := Rec.Payee;
                GenJournalLine.Validate(GenJournalLine."Currency Code");
                GenJournalLine.Amount := -ChargeAmount;
                GenJournalLine.Validate(GenJournalLine.Amount);
                GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;

                TChargeAmount := TChargeAmount + ChargeAmount;

            until TransactionCharges.Next = 0;
        end;

        //Charges


        //Teller Entry
        LineNo := LineNo + 10000;

        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := 'PURCHASES';
        GenJournalLine."Journal Batch Name" := 'FTRANS';
        GenJournalLine."Document No." := Rec.No;
        GenJournalLine."External Document No." := Rec."ID No";
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
        GenJournalLine."Account No." := TillNo;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := Rec."Transaction Date";
        GenJournalLine.Description := Rec.Payee;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := -(Rec.Amount - TChargeAmount);
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;


        //Post New
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
        if GenJournalLine.Find('-') then begin
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
        end;

        //Post New


        Rec."Transaction Available Balance" := AvailableBalance;
        Rec.Posted := true;
        Rec.Authorised := Rec.Authorised::Yes;
        Rec."Supervisor Checked" := true;
        Rec."Needs Approval" := Rec."needs approval"::No;
        Rec."Frequency Needs Approval" := Rec."frequency needs approval"::No;
        Rec."Date Posted" := Today;
        Rec."Time Posted" := Time;
        Rec."Posted By" := UserId;
        Rec.Modify;
        Commit;
    end;


    procedure PostBOSAEntries()
    var
        ReceiptAllocation: Record "Receipt Allocation";
    begin
        BOSABank := 'BNK00001';

        GenJournalLine.Reset;
        GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'FTRANS');
        GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'PURCHASES');
        GenJournalLine.DeleteAll;

        LineNo := LineNo + 10000;

        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := 'PURCHASES';
        GenJournalLine."Journal Batch Name" := 'FTRANS';
        GenJournalLine."Document No." := Rec.No;
        GenJournalLine."External Document No." := Rec."Cheque No";
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
        GenJournalLine."Account No." := BOSABank;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := Rec."Transaction Date";
        GenJournalLine.Description := Rec.Payee;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := Rec.Amount;
        GenJournalLine.Validate(GenJournalLine.Amount);
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;

        ReceiptAllocations.Reset;
        ReceiptAllocations.SetRange(ReceiptAllocations."Document No", Rec.No);
        if ReceiptAllocations.Find('-') then begin
            repeat

                LineNo := LineNo + 10000;

                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := 'PURCHASES';
                GenJournalLine."Journal Batch Name" := 'FTRANS';
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Document No." := Rec.No;
                GenJournalLine."External Document No." := Rec."Cheque No";
                GenJournalLine."Posting Date" := Rec."Transaction Date";
                GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                GenJournalLine."Account No." := ReceiptAllocations."Member No";
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine.Description := Format(ReceiptAllocations."Transaction Type");
                //END;
                GenJournalLine.Amount := -ReceiptAllocations.Amount;
                GenJournalLine.Validate(GenJournalLine.Amount);
                if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Interest Paid" then
                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid"
                else
                    if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Deposit Contribution" then
                        GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Deposit Contribution"
                    else
                        if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Benevolent Fund" then
                            GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Benevolent Fund"
                        else
                            if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Loan Repayment" then
                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Loan Repayment"
                            else
                                if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Registration Fee" then
                                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Registration Fee";
                GenJournalLine."Loan No" := ReceiptAllocations."Loan No.";
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;


                //Post New


                //Generate Advice
                if (ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Registration Fee") then begin
                    if LoansR.Get(ReceiptAllocations."Loan No.") then begin
                        LoansR.CalcFields(LoansR."Outstanding Balance");
                        LoansR.Advice := true;
                        if ((LoansR."Outstanding Balance" - ReceiptAllocations.Amount) < LoansR."Loan Principle Repayment") then
                            LoansR."Advice Type" := LoansR."advice type"::Stoppage
                        else
                            LoansR."Advice Type" := LoansR."advice type"::Adjustment;
                        LoansR.Modify;
                    end;
                end;
            //Generate Advice

            until ReceiptAllocations.Next = 0;


            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
            GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
            if GenJournalLine.Find('-') then begin
                Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
            end;
            //Post New


            Rec."Transaction Available Balance" := AvailableBalance;
            Rec.Posted := true;
            Rec.Authorised := Rec.Authorised::Yes;
            Rec."Supervisor Checked" := true;
            Rec."Needs Approval" := Rec."needs approval"::No;
            Rec."Frequency Needs Approval" := Rec."frequency needs approval"::No;
            Rec."Date Posted" := Today;
            Rec."Time Posted" := Time;
            Rec."Posted By" := UserId;
            Rec.Modify;
            Commit;
        end;
    end;


    procedure SuggestBOSAEntries()
    begin
        Rec.TestField(Posted, false);
        Rec.TestField("BOSA Account No");

        ReceiptAllocations.Reset;
        ReceiptAllocations.SetRange(ReceiptAllocations."Document No", Rec.No);
        ReceiptAllocations.DeleteAll;

        PaymentAmount := Rec.Amount;
        RunBal := PaymentAmount;

        Loans.Reset;
        Loans.SetCurrentkey(Loans.Source, Loans."Client Code");
        Loans.SetRange(Loans."Client Code", Rec."BOSA Account No");
        Loans.SetRange(Loans.Source, Loans.Source::BOSA);
        if Loans.Find('-') then begin
            repeat
                Loans.CalcFields(Loans."Outstanding Balance", Loans."Interest Due");
                Recover := true;

                if (Loans."Outstanding Balance") > 0 then begin
                    if ((Loans."Outstanding Balance" - Loans."Loan Principle Repayment") <= 0) and (Cheque = false) then
                        Recover := false;

                    if Recover = true then begin

                        Commision := 0;
                        if Cheque = true then begin
                            Commision := (Loans."Outstanding Balance") * 0.1;
                            LOustanding := Loans."Outstanding Balance";
                            if Loans."Interest Due" > 0 then
                                InterestPaid := Loans."Interest Due";
                        end else begin
                            LOustanding := (Loans."Outstanding Balance" - Loans."Loan Principle Repayment");
                            if LOustanding < 0 then
                                LOustanding := 0;
                            if Loans."Interest Due" > 0 then
                                InterestPaid := Loans."Interest Due";
                            if (Loans."Outstanding Balance" - Loans."Loan Principle Repayment") > 0 then begin
                                if (Loans."Outstanding Balance" - Loans."Loan Principle Repayment") > (Loans."Approved Amount" * 1 / 3) then
                                    Commision := LOustanding * 0.1;
                            end;
                        end;

                        if PaymentAmount > 0 then begin
                            if RunBal < (LOustanding + Commision + InterestPaid) then begin
                                if RunBal < InterestPaid then
                                    InterestPaid := RunBal;
                                //Commision:=(RunBal-InterestPaid)*0.1;
                                Commision := (RunBal - InterestPaid) - ((RunBal - InterestPaid) / 1.1);
                                LOustanding := (RunBal - InterestPaid) - Commision;

                            end;
                        end;


                        TotalCommision := TotalCommision + Commision;
                        TotalOustanding := TotalOustanding + LOustanding + InterestPaid + Commision;

                        RunBal := RunBal - (LOustanding + InterestPaid + Commision);

                        if (LOustanding + InterestPaid) > 0 then begin
                            ReceiptAllocations.Init;
                            ReceiptAllocations."Document No" := Rec.No;
                            ReceiptAllocations."Member No" := Rec."BOSA Account No";
                            ReceiptAllocations."Transaction Type" := ReceiptAllocations."transaction type"::"Registration Fee";
                            ReceiptAllocations."Loan No." := Loans."Loan  No.";
                            ReceiptAllocations.Amount := ROUND(LOustanding, 0.01);
                            ReceiptAllocations."Interest Amount" := ROUND(InterestPaid, 0.01);
                            ReceiptAllocations."Total Amount" := ReceiptAllocations.Amount + ReceiptAllocations."Interest Amount";
                            ReceiptAllocations.Insert;
                        end;

                        if Commision > 0 then begin
                            ReceiptAllocations.Init;
                            ReceiptAllocations."Document No" := Rec.No;
                            ReceiptAllocations."Member No" := Rec."BOSA Account No";
                            ReceiptAllocations."Transaction Type" := ReceiptAllocations."transaction type"::"Loan Repayment";
                            ReceiptAllocations."Loan No." := Loans."Loan  No.";
                            ReceiptAllocations.Amount := ROUND(Commision, 0.01);
                            ReceiptAllocations."Interest Amount" := 0;
                            ReceiptAllocations."Total Amount" := ReceiptAllocations.Amount + ReceiptAllocations."Interest Amount";
                            ReceiptAllocations.Insert;
                        end;

                    end;
                end;

            until Loans.Next = 0;
        end;

        if RunBal > 0 then begin
            ReceiptAllocations.Init;
            ReceiptAllocations."Document No" := Rec.No;
            ReceiptAllocations."Member No" := Rec."BOSA Account No";
            ReceiptAllocations."Transaction Type" := ReceiptAllocations."transaction type"::"Benevolent Fund";
            ReceiptAllocations."Loan No." := '';
            ReceiptAllocations.Amount := RunBal;
            ReceiptAllocations."Interest Amount" := 0;
            ReceiptAllocations."Total Amount" := ReceiptAllocations.Amount + ReceiptAllocations."Interest Amount";
            ReceiptAllocations.Insert;

        end;
    end;


    procedure SendEmail()
    begin
        /*
        //send e-mail to supervisor
        supervisor.RESET;
        supervisor.SETFILTER(supervisor."Transaction Type",'withdrawal');
        IF supervisor.FIND('-') THEN BEGIN
         // MailContent:=TEXT1;
        REPEAT
        
         genSetup.GET(0);
         SMTPMAIL.NewMessage(genSetup."Sender Address",'Transactions' +''+'');
         SMTPMAIL.SetWorkMode();
         SMTPMAIL.ClearAttachments();
         SMTPMAIL.ClearAllRecipients();
         SMTPMAIL.SetDebugMode();
         SMTPMAIL.SetFromAdress(genSetup."Sender Address");
         SMTPMAIL.SetHost(genSetup."Outgoing Mail Server");
         SMTPMAIL.SetUserID(genSetup."Sender User ID");
         SMTPMAIL.AddLine(MailContent);
         SMTPMAIL.SetToAdress(supervisor."E-mail Address");
         SMTPMAIL.Send;
         UNTIL supervisor.NEXT=0;
        END;
        */

    end;


    procedure PostCashDepWith()
    begin

        CalcAvailableBal;
        Jtemplate := 'GENERAL';
        JBatch := 'FTRANS';

        genSetup.Get();

        if Rec.Type = 'Withdrawal' then begin

            if Acc.Get(Rec."Account No") then begin
                if Acc.Blocked = Acc.Blocked::Payment then
                    Error('This account has been blocked from receiving payments.');
            end;
            if AvailableBalance < Rec.Amount then begin
                /*
                PostOverdraft();
                Authorised:=Authorised::Yes;
                */
                if Rec.Authorised = Rec.Authorised::No then begin
                    if Rec."Branch Transaction" = false then begin
                        Rec."Authorisation Requirement" := 'Over draft';

                        MailContent := 'Withdrawal transaction' + 'TR. No.' + ' ' + Rec.No + ' ' + 'of Kshs' + ' ' + Format(Rec.Amount) + ' ' + 'for'
                        + ' ' + Rec."Account Name" + ' ' + 'needs your approval';

                        Message('You cannot withdraw more than the available balance unless authorised.');

                        exit;
                    end;
                    if Rec.Authorised = Rec.Authorised::Rejected then
                        Error('Transaction has been rejected and therefore cannot proceed.');

                end;
            end;
        end;
        //............................................Abel//Get Bank Account Code(TellerCode)
        // BankAccount.Reset();
        // BankAccount.SetRange(BankAccount.CashierID, UserId);
        // if BankAccount.Find('-') then begin
        //     Error('....%1', BankAccount."No.");
        // end;
        //............................................
        TillNo := '';
        TellerTill.Reset;
        TellerTill.SetRange(TellerTill."Account Type", TellerTill."account type"::Cashier);
        TellerTill.SetRange(TellerTill.CashierID, UserId);
        TellerTill.SetFilter(TellerTill."No.", '%1', 'T*');
        if TellerTill.Find('-') then begin
            TillNo := TellerTill."No.";
            TellerTill.CalcFields(TellerTill.Balance);

            CurrentTellerAmount := TellerTill.Balance;

            if CurrentTellerAmount - Rec.Amount <= TellerTill."Min. Balance" then
                Message('You need to add more money from the treasury since your balance has gone below the teller replenishing level.');

            if (Rec.Type = 'Withdrawal') or (Rec.Type = 'Encashment') then begin
                if (CurrentTellerAmount - Rec.Amount) < TellerTill."Min. Balance" then
                    Error('You do not have enough money to carry out this transaction.');
            end;

            if (Rec.Type = 'Withdrawal') or (Rec.Type = 'Encashment') then begin
                if CurrentTellerAmount - Rec.Amount >= TellerTill."Maximum Teller Withholding" then
                    Message('You need to transfer money back to the treasury since your balance has gone above the teller maximum withholding.');

            end else begin
                if CurrentTellerAmount + Rec.Amount >= TellerTill."Maximum Teller Withholding" then
                    Message('You need to transfer money back to the treasury since your balance has gone above the teller maximum withholding.');
            end;


            if Rec.Type = 'Withdrawal' then begin
                if Rec.Amount > TellerTill."Max Withdrawal Limit" then begin
                    if Rec.Authorised = Rec.Authorised::No then begin
                        Rec."Authorisation Requirement" := 'Withdrawal Above teller Limit';


                        MailContent := 'The' + ' ' + 'Cashier' + ' ' + Rec.Cashier + ' ' +
                        'cannot withdraw more than allowed ,limit, Maximum limit is' + '' + Format(TellerTill."Max Withdrawal Limit") +
                        'you need to authorise';

                        Message('You cannot withdraw more than your allowed limit of %1 unless authorised.', TellerTill."Max Withdrawal Limit");

                        exit;
                    end;
                    if Rec.Authorised = Rec.Authorised::Rejected then
                        Error('Transaction has been rejected and therefore cannot proceed.');

                end;
            end;

            if Rec.Type = 'Cash Deposit' then begin
                if Rec.Amount > TellerTill."Max Deposit Limit" then begin
                    if Rec.Authorised = Rec.Authorised::No then begin
                        Rec."Authorisation Requirement" := 'Deposit above teller Limit';

                        MailContent := 'The' + ' ' + 'Cashier' + ' ' + Rec.Cashier + ' ' +
                        'cannot deposit more than allowed limit, Maximum limit is' + '' + Format(TellerTill."Max Deposit Limit") + 'you need to authorise';

                        Message('You cannot deposit more than your allowed limit of %1 unless authorised.', TellerTill."Max Deposit Limit");
                        exit;
                    end;
                    if Rec.Authorised = Rec.Authorised::Rejected then
                        Error('Transaction has been rejected therefore you cannot proceed.');
                end;
            end;
        end;

        if TillNo = '' then
            Error('Teller account not set-up.');

        if Rec.Type = 'Cash Deposit' then begin
            if Rec.Amount > TellerTill."Max Deposit Limit" then begin
                if Rec.Authorised = Rec.Authorised::No then begin
                    Rec."Authorisation Requirement" := 'Deposit Above teller Limit';


                    MailContent := 'The' + ' ' + 'Cashier' + ' ' + Rec.Cashier + ' ' +
                    'cannot Deposit more than allowed ,limit, Maximum limit is' + '' + Format(TellerTill."Max Withdrawal Limit") +
                    'you need to authorise';

                    Message('You cannot Deposit more than your allowed limit of %1 unless authorised.', TellerTill."Max Withdrawal Limit");

                    exit;
                end;
                if Rec.Authorised = Rec.Authorised::Rejected then
                    Error('Transaction has been rejected and therefore cannot proceed.');
            end;
        end;


        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", Jtemplate);
        GenJournalLine.SetRange("Journal Batch Name", JBatch);
        GenJournalLine.DeleteAll;

        //Charge Account Opening  // To Confirm
        if not ((Rec."Account Type" = 'HOLIDAY') or (Rec."Account Type" = 'JUNIOR') or (Rec."Account Type" = 'AGENTFL')) then
            //IF NOT ("Account Type"='HOLIDAY') THEN
            if (Rec.Amount > 485) then
                if (AccountOpening.FnCheckIfPaid(Rec."Account No") = false) then
                    AccountOpening.FnAccountOpen(Jtemplate, JBatch, LineNo, Rec."Account No", Rec.Amount, DActivity, DBranch, Rec.No);

        //Charge Account Opening
        LineNo := AccountOpening.FnReturnLineNo;
        LineNo := LineNo + 10000;

        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := Jtemplate;
        GenJournalLine."Journal Batch Name" := JBatch;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Document No." := Rec.No;
        if (Rec."Transaction Type" = 'BOSA') or (Rec."Transaction Type" = 'Encashment') then
            GenJournalLine."External Document No." := Rec."BOSA Account No";
        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
        GenJournalLine."Account No." := Rec."Account No";
        if Rec."Account No" = '00-0000000000' then
            GenJournalLine."External Document No." := Rec."ID No";
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := Rec."Transaction Date";
        if (Rec."Transaction Type" = 'BOSA') or (Rec."Transaction Type" = 'Encashment') then
            GenJournalLine.Description := Rec.Payee
        else begin
            if Rec."Branch Transaction" = true then
                GenJournalLine.Description := Rec."Transaction Type" + '-' + Rec."Branch Refference"
            else
                GenJournalLine.Description := Rec.Type + '-' + Rec.Description;
        end;
        //Project Accounts
        if Acc.Get(Rec."Account No") then begin
            if Acc."Account Category" = Acc."account category"::Project then
                GenJournalLine.Description := Rec."Transaction Type" + '-' + Rec."Branch Refference"
        end;
        //Project Accounts

        GenJournalLine.Validate(GenJournalLine."Currency Code");
        if (Rec.Type = 'Cash Deposit') then
            GenJournalLine.Amount := -Rec.Amount
        else
            GenJournalLine.Amount := Rec.Amount;
        if (Rec.Type = 'BOSA Receipt') then
            GenJournalLine.Amount := 0;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"Bank Account";
        GenJournalLine."Bal. Account No." := TillNo;
        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;


        //^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        TCharges := 0;

        TransactionCharges.Reset;
        TransactionCharges.SetRange(TransactionCharges."Transaction Type", Rec."Transaction Type");
        if TransactionCharges.Find('-') then begin
            repeat
                LineNo := LineNo + 10000;

                ChargeAmount := 0;
                ChargeAmountTax := 0;
                if TransactionCharges."Use Percentage" = true then
                    ChargeAmount := (Rec.Amount * TransactionCharges."Percentage of Amount") * 0.01
                else
                    ChargeAmount := TransactionCharges."Charge Amount";



                if TransactionCharges."Charge Type" = TransactionCharges."charge type"::Staggered then begin

                    if TransactionCharges."Charge Excise Duty" = true then begin
                        TransactionCharges.TestField(TransactionCharges."Staggered Charge Code");
                        TariffDetails.Reset;
                        TariffDetails.SetRange(TariffDetails."Transaction Type", Rec."Transaction Type");
                        if TariffDetails.Find('-') then begin
                            repeat
                                if TariffDetails."Use Percentage" = false then begin
                                    if (Rec.Amount >= TariffDetails."Lower Limit") and (Rec.Amount <= TariffDetails."Upper Limit") then begin
                                        ChargeAmount := TariffDetails."Charge Amount";
                                        ChargeAmountTax := (ChargeAmount * genSetup."Excise Duty(%)") * 0.01;

                                    end;
                                end else begin
                                    if (Rec.Amount >= TariffDetails."Lower Limit") and (Rec.Amount <= TariffDetails."Upper Limit") then begin
                                        ChargeAmount := (Rec.Amount * TariffDetails.Percentage) / 100;
                                        ChargeAmountTax := (ChargeAmount * genSetup."Excise Duty(%)") * 0.01;

                                    end;

                                end;
                            until TariffDetails.Next = 0;
                        end;
                    end;
                end;

                if TransactionCharges."Charge Type" = TransactionCharges."charge type"::Staggered then begin
                    if TransactionCharges."Charge Excise Duty" = false then begin
                        TransactionCharges.TestField(TransactionCharges."Staggered Charge Code");
                        TariffDetails.Reset;
                        TariffDetails.SetRange(TariffDetails."Transaction Type", Rec."Transaction Type");

                        if TariffDetails.Find('-') then begin
                            repeat
                                if TariffDetails."Use Percentage" = false then begin
                                    if (Rec.Amount >= TariffDetails."Lower Limit") and (Rec.Amount <= TariffDetails."Upper Limit") then begin
                                        ChargeAmount := TariffDetails."Charge Amount";

                                    end;
                                end else begin
                                    if (Rec.Amount >= TariffDetails."Lower Limit") and (Rec.Amount <= TariffDetails."Upper Limit") then begin
                                        ChargeAmount := (Rec.Amount * (TariffDetails.Percentage / 100));
                                    end;
                                end;

                            until TariffDetails.Next = 0;
                        end;
                    end;
                end;
                //^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := Jtemplate;
                GenJournalLine."Journal Batch Name" := JBatch;
                GenJournalLine."Document No." := Rec.No;
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                GenJournalLine."Account No." := Rec."Account No";
                if Rec."Account No" = '00-0000000000' then
                    GenJournalLine."External Document No." := Rec."ID No";
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Posting Date" := Rec."Transaction Date";
                GenJournalLine.Description := TransactionCharges.Description;
                GenJournalLine.Validate(GenJournalLine."Currency Code");
                if Rec."Account No" = 'ENCASHMENT' THEN
                    GenJournalLine.Amount := 0
                ELSE
                    GenJournalLine.Amount := ChargeAmount;
                GenJournalLine.Validate(GenJournalLine.Amount);
                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                GenJournalLine."Bal. Account No." := TransactionCharges."G/L Account";
                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;



                //EXCISE DUTY

                LineNo := LineNo + 10000;

                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := Jtemplate;
                GenJournalLine."Journal Batch Name" := JBatch;
                GenJournalLine."Document No." := Rec.No;
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                GenJournalLine."Account No." := Rec."Account No";
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Posting Date" := Rec."Transaction Date";
                if (Rec."Transaction Type" = 'ASSETD') then begin
                    Rec.TestField(Payee);
                    Rec.TestField(Remarks);
                    GenJournalLine.Description := Rec.Payee + ' ' + Rec.Remarks;
                end else
                    GenJournalLine.Description := 'Excise duty';
                GenJournalLine.Validate(GenJournalLine."Currency Code");
                if Rec."Account No" = 'ENCASHMENT' THEN
                    GenJournalLine.Amount := 0
                ELSE
                    GenJournalLine.Amount := ChargeAmountTax;
                GenJournalLine.Validate(GenJournalLine.Amount);
                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                GenJournalLine."Bal. Account No." := genSetup."Excise Duty Account";
                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;

                TChargeAmount := TChargeAmount + ChargeAmount;

            until TransactionCharges.Next = 0;
        end;

        //Charge withdrawal Freq
        if Rec.Type = 'Withdrawal' then begin
            if Account.Get(Rec."Account No") then begin
                if AccountTypes.Get(Account."Account Type") then begin
                    if Account."Last Withdrawal Date" = 0D then begin
                        Account."Last Withdrawal Date" := Today;
                        Account.Modify;
                    end else begin
                        if CalcDate(AccountTypes."Withdrawal Interval", Account."Last Withdrawal Date") > Today then begin

                            LineNo := LineNo + 10000;

                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := Jtemplate;
                            GenJournalLine."Journal Batch Name" := JBatch;
                            GenJournalLine."Document No." := Rec.No;
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                            GenJournalLine."Account No." := Rec."Account No";
                            if Rec."Account No" = '00-0000000000' then
                                GenJournalLine."External Document No." := Rec."ID No";

                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Posting Date" := Rec."Transaction Date";
                            GenJournalLine.Description := 'Commision on Withdrawal Freq.';
                            GenJournalLine.Validate(GenJournalLine."Currency Code");
                            GenJournalLine.Amount := AccountTypes."Withdrawal Penalty";
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                            GenJournalLine."Bal. Account No." := AccountTypes."Withdrawal Interval Account";
                            GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;

                        end;
                    end;
                end;
            end;

            if Rec."Account No" = '507-10000-00' then;
        end;
        //Charge 2% commision for MBSA
        if Rec.Overdraft = true then begin
            if Rec."Transacting Branch" = 'MBSA' then begin
                LineNo := LineNo + 10000;

                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := Jtemplate;
                GenJournalLine."Journal Batch Name" := JBatch;
                GenJournalLine."Document No." := Rec.No;
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                GenJournalLine."Account No." := Rec."Account No";
                if Rec."Account No" = '00-0000000000' then
                    GenJournalLine."External Document No." := Rec."ID No";

                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Posting Date" := Rec."Transaction Date";
                GenJournalLine.Description := 'Commision on Overdraft';
                GenJournalLine.Validate(GenJournalLine."Currency Code");
                GenJournalLine.Amount := Rec.Amount * 0.02;
                GenJournalLine.Validate(GenJournalLine.Amount);
                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                GenJournalLine."Bal. Account No." := '100005';
                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;


            end;
        end;



        if Rec.Type = 'BOSA Receipt' then begin
            PostBOSAEntries;
        end;



        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", Jtemplate);
        GenJournalLine.SetRange("Journal Batch Name", JBatch);
        if GenJournalLine.Find('-') then begin
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Batch", GenJournalLine);
        end;



        Rec."Transaction Available Balance" := AvailableBalance;
        Rec.Posted := true;
        Rec.Authorised := Rec.Authorised::Yes;
        Rec."Supervisor Checked" := true;
        Rec."Needs Approval" := Rec."needs approval"::No;
        Rec."Frequency Needs Approval" := Rec."frequency needs approval"::No;
        Rec."Date Posted" := Today;
        Rec."Time Posted" := Time;
        Rec."Posted By" := UserId;
        Rec.Modify;
        Commit;


        Vend1.Reset;
        Vend1.SetRange(Vend1."No.", Rec."Account No");
        if Vend1.Find('-') then begin
            if Vend."Sms Notification" = true then begin
                TransDesc := '';
                TransTypes.Reset;
                TransTypes.SetRange(TransTypes.Code, Rec."Transaction Type");
                if TransTypes.Find('-') then begin
                    TransDesc := TransTypes.Description;
                end;

                //.......................SMS GENERATION START.............................

                //.......................

                SMSMessage.Reset;
                if SMSMessage.Find('+') then begin
                    iEntryNo := SMSMessage."Entry No";
                    iEntryNo := iEntryNo + 1;
                end else begin
                    iEntryNo := 1;
                end;
                SMSMessage.Reset;
                SMSMessage.Init;
                SMSMessage."Entry No" := iEntryNo;
                SMSMessage."Account No" := Vend1."No.";
                SMSMessage."Date Entered" := Today;
                SMSMessage."Time Entered" := Time;
                SMSMessage.Source := 'OTC SMS';
                SMSMessage."Entered By" := UserId;
                SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
                if Rec.Amount <> 0 then begin
                    SMSMessage."SMS Message" := 'You have done a Transaction of KSHS. ' +
                    Format(Rec.Amount) + ' of type ' + TransDesc + ' on ' + Format(Today) + ' ' + Format(Time) + ' to your Account at Polytech Sacco'; //'CompanyInfo.Name ' .';
                end;
                if Vend1."MPESA Mobile No" <> '' then begin
                    //SMSMessage."Telephone No":=Vend1."MPESA Mobile No";
                end else begin
                    SMSMessage."Telephone No" := Vend1."Phone No.";
                end;
                if SMSMessage."Telephone No" <> '' then
                    SMSMessage.Insert;
            end;


            //............................
            /*
            SMSMessage.RESET;
            IF SMSMessage.FIND('+') THEN BEGIN
            iEntryNo:=SMSMessage."Entry No";
            iEntryNo:=iEntryNo+1;
            END
            ELSE BEGIN
            iEntryNo:=1;
            END;

            SMSMessage.RESET;
            SMSMessage.INIT;
            SMSMessage."Entry No":=iEntryNo;
            SMSMessage."Account No":=Vend1."No.";
            SMSMessage."Date Entered":=TODAY;
            SMSMessage."Time Entered":=TIME;
            SMSMessage.Source:='OTC SMS';
            SMSMessage."Entered By":=USERID;
            SMSMessage."Sent To Server":=SMSMessage."Sent To Server"::No;
            IF Amount<>0 THEN BEGIN
             IF TransDesc='Cash Deposit' THEN BEGIN
                SMSMessage."SMS Message":='You have done a transaction of KSHS. '+FORMAT(Amount)+
                                      ' of type '+TransDesc+
                                      ' on '+FORMAT(TODAY) + ' ' +FORMAT(TIME)+' to your Account at Polytech Sacco.';
              END ELSE BEGIN
                 SMSMessage."SMS Message":='You have done a transaction of KSHS. '+FORMAT(Amount)+
                                      ' of type '+TransDesc+
                                      ' on '+FORMAT(TODAY) + ' ' +FORMAT(TIME)+' from your Account at Polytech Sacco.';
             END;
            END;

            IF Vend1."Mobile Phone No"<> '' THEN BEGIN
                SMSMessage."Telephone No":=Vend1."Mobile Phone No";
            END ELSE BEGIN
               SMSMessage."Telephone No":=Vend1."Phone No.";
            END;

            IF SMSMessage."Telephone No"<>'' THEN
            SMSMessage.INSERT;
            */

            //.......................................END OF CODE ...........................................//
            // END;
        end;

        Trans.Reset;
        Trans.SetRange(Trans.No, Rec.No);
        if Trans.Find('-') then
            Trans.Reset;
        Trans.SetRange(Trans.No, Rec.No);
        if Trans.Find('-') then
            if Rec.Type = 'Cash Deposit' then begin
                postOverdraftRecover();
                if Confirm('Do you want to print this receipt') = true then  //Added to allow confirmation before printing.
                    Report.Run(50281, true, true, Trans)
            end else
                if Rec.Type = 'Withdrawal' then
                    //Report.Run(50282, false, true, Trans);
                    Report.Run(50282, true, true, Trans);

        CurrPage.Close;
        Commit;
        postOverdraftRecover();

    end;

    local procedure PostOverdraft()
    var
        OverdraftAcc: Record "Over Draft Register";
        OVERBAL: Decimal;
        RemainAmount: Decimal;
        Overdraftbank: Code[10];
        dbanch: Code[50];
        balanceov: Decimal;
        vendoroverdraft: Record Vendor;
        BALRUN: Decimal;
        OVERDRAFTREC: Record Vendor;
        "overdraftcomm a/c": Code[10];
        vendor2: Record Vendor;
        commoverdraft: Decimal;
        overdraftSetup: Record "Overdraft Setup";
    begin
        /*
        overdraftSetup.GET();
        commoverdraft:=0;
        ObjVendor.RESET;
        ObjVendor.SETRANGE(ObjVendor."No.","Account No");
        IF ObjVendor.FIND('-')THEN BEGIN
          {
          ObjVendor.CALCFIELDS(ObjVendor."Outstanding Overdraft");
          AvailableOverDraft:=FnGetTotalApprovedOverDraft();
          AvailableOverDraft:=AvailableOverDraft-ObjVendor."Outstanding Overdraft";
          }
            ObjVendor.CALCFIELDS(ObjVendor."Outstanding Overdraft",ObjVendor."Active Overdrafts Total",ObjVendor.Balance);
            AdjustmentAmount:=0;
            AvailableOverDraft:=ObjVendor."Active Overdrafts Total"-ObjVendor."Outstanding Overdraft";
            IF ((ObjVendor.Balance<1090)AND (ObjVendor.Balance>0)) THEN BEGIN
              AdjustmentAmount:=1090-ObjVendor.Balance;
            AvailableOverDraft:=AvailableOverDraft-AdjustmentAmount;
            END;
            IF ObjVendor.Balance<0 THEN BEGIN
              AdjustmentAmount:=1090+ABS(ObjVendor.Balance);
            AvailableOverDraft:=AvailableOverDraft-AdjustmentAmount;
            END;
        END;
        IF AvailableOverDraft<=0 THEN
        ERROR('Transaction blocked kindly apply for overdraft facility to Continue');
        
        OVERBAL:=ROUND((Amount-AvailableBalance+(90)),0.05,'>');
        
        CommisionOnOverdraft:=0;
        IF NOT FnCheckOverDraftCommisionStatus THEN
          FnUpdateOVerdraftCommisionStatus();
        
        InterestOnOverdraft:=0;
        IF NOT FnCheckOverDraftInterestStatus THEN
         FnUpdateOVerdraftInterestStatus();
        IF ((AvailableOverDraft) < (Amount+CommisionOnOverdraft+InterestOnOverdraft)) THEN BEGIN
        ERROR('Requested amount is more than the available amount.Available OD=%1,Requested Amount+Charges=%2.You can withdraw %1 or Apply for more Overdraft.',AvailableOverDraft,Amount+90+CommisionOnOverdraft+InterestOnOverdraft);
        END;
        GenJournalLine.RESET;
        GenJournalLine.SETRANGE("Journal Template Name",BATCH_TEMPLATE);
        GenJournalLine.SETRANGE("Journal Batch Name",BATCH_NAME);
        GenJournalLine.DELETEALL;
        ODNumber:=FnGetApprovedOverDraftNo();
        //1.----------------------CREDIT FOSA A/C---------------------------------------------------OVERBAL+COMMISSION-------------------------------------------------
        LineNo:=LineNo+10000;
        SFactory.FnCreateGnlJournalLineBalancedCashier(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::"0",GenJournalLine."Account Type"::Vendor,
        "Account No","Transaction Date",ROUND((OVERBAL+CommisionOnOverdraft+InterestOnOverdraft)*-1,0.05,'>'),'FOSA',ODNumber,"Account No"+' Overdraft amount','',
        GenJournalLine."Account Type"::"G/L Account",overdraftSetup."Control Account",ODNumber,GenJournalLine."Overdraft codes"::"Overdraft Granted");
        
        //2.----------------------DEDIT FOSA A/C---------------------------------------------------COMMISSION CHARGED-------------------------------------------------
        LineNo:=LineNo+10000;
        SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::"0",GenJournalLine."Account Type"::Vendor,
        "Account No","Transaction Date",ROUND(CommisionOnOverdraft,0.05,'>'),'FOSA',ODNumber,"Account No"+' Commission on Overdraft','',
        GenJournalLine."Account Type"::"G/L Account",overdraftSetup."Commission A/c");
        
        //3.----------------------EARN INCOME---------------------------------------------------INTEREST CHARGED-------------------------------------------------
        LineNo:=LineNo+10000;
        SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::"0",GenJournalLine."Account Type"::Vendor,
        "Account No",TODAY,InterestOnOverdraft,'FOSA',ODNumber,"Account No"+' Overdraft Int Charged','',
        GenJournalLine."Account Type"::"G/L Account",overdraftSetup."Interest Income A/c");
        
        GenJournalLine.RESET;
        GenJournalLine.SETRANGE("Journal Template Name",BATCH_TEMPLATE);
        GenJournalLine.SETRANGE("Journal Batch Name",BATCH_NAME);
        IF GenJournalLine.FIND('-') THEN BEGIN
        CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Sacco",GenJournalLine);
        END;
        MESSAGE('Over draft been successfully Credited.');
        */

    end;

    local procedure postOverdraftRecover()
    var
        AmountToDeduct: Decimal;
        NewAvailableBalance: Decimal;
        Overdraftsetup2: Record "Overdraft Setup";
    begin
        /*
        Overdraftsetup2.GET();
        AmountToDeduct:=0;
         NewAvailableBalance:=0;
       IF( Type = 'Deposit Slip')OR ( Type = 'Cash Deposit' ) THEN
         BEGIN
            OVERDRAFTREC.RESET;
            OVERDRAFTREC.SETRANGE(OVERDRAFTREC."No.","Account No");
            IF  OVERDRAFTREC.FIND('-') THEN
              BEGIN
              OVERDRAFTREC.CALCFIELDS(OVERDRAFTREC."Oustanding Overdraft interest",OVERDRAFTREC.Balance,OVERDRAFTREC."Outstanding Overdraft");
                NewAvailableBalance:=OVERDRAFTREC.Balance;
                IF  OVERDRAFTREC."Outstanding Overdraft">0 THEN
                  BEGIN
                       IF  OVERDRAFTREC."Oustanding Overdraft interest">0 THEN
                       BEGIN
                         //1.----------------------RECOVER ODInterest From FOSA----------------------------------------------------------------------------------------------------
                         LineNo:=LineNo+10000;
                         AmountToDeduct:=ModifyInterestBuffer();
                         IF AmountToDeduct >= OVERDRAFTREC."Oustanding Overdraft interest" THEN
                         AmountToDeduct:=AmountToDeduct;

                         SFactory.FnCreateGnlJournalLineBalancedCashier(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::"0",GenJournalLine."Account Type"::Vendor,
                         "Account No","Transaction Date",AmountToDeduct,'FOSA','OV'+"Account No","Account No"+' Overdraft interest paid','',
                         GenJournalLine."Account Type"::"G/L Account",Overdraftsetup2."Interest Receivable A/c",ODNumber,GenJournalLine."Overdraft codes"::"Interest paid");
                         NewAvailableBalance:=NewAvailableBalance-AmountToDeduct;
                       END;

                       IF  OVERDRAFTREC."Outstanding Overdraft">0 THEN
                       BEGIN
                           //1.----------------------RECOVER Overdraft From FOSA----------------------------------------------------------------------------------------------------
                           LineNo:=LineNo+10000;
                           AmountToDeduct:=OVERDRAFTREC."Outstanding Overdraft";
                           IF NewAvailableBalance <= OVERDRAFTREC."Outstanding Overdraft" THEN
                           AmountToDeduct:=NewAvailableBalance;
                           SFactory.FnCreateGnlJournalLineBalancedCashier(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::"0",GenJournalLine."Account Type"::Vendor,
                           "Account No","Transaction Date",AmountToDeduct,'FOSA','OV'+"Account No","Account No"+' Overdraft paid','',
                           GenJournalLine."Account Type"::"G/L Account",Overdraftsetup2."Control Account",ODNumber,GenJournalLine."Overdraft codes"::"Overdraft Paid");
                        END;
                       GenJournalLine.RESET;
                       GenJournalLine.SETRANGE("Journal Template Name",BATCH_TEMPLATE);
                       GenJournalLine.SETRANGE("Journal Batch Name",BATCH_NAME);
                       IF GenJournalLine.FIND('-') THEN BEGIN
                         CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Sacco",GenJournalLine);
                       END;
                       MESSAGE('Over draft successfully Recovered');
                  END;
              END;
       END;
       ModifyOverdraftDate();
       */

    end;

    local procedure ModifyOverdraftDate()
    begin
        Vend.Reset;
        Vend.SetRange(Vend."No.", Rec."Account No");
        if Vend.Find('-') then begin
            Vend.CalcFields(Vend."Outstanding Overdraft");
            if Vend."Outstanding Overdraft" <= 0 then begin
                Vend."Last Overdraft Date" := 0D;
                Vend.Modify;
            end;
        end;
    end;

    local procedure ModifyInterestBuffer() Interest: Decimal
    begin
        IntBuffer.Reset;
        IntBuffer.SetRange(IntBuffer."Account No", Rec."Account No");
        IntBuffer.SetRange(IntBuffer.Transferred, false);
        if IntBuffer.Find('-') then begin
            repeat
                Interest := Interest + IntBuffer."Interest Amount";
                if Interest <= Rec.Amount then begin
                    IntBuffer.Transferred := true;
                    IntBuffer.Modify;
                end else begin
                    IntBuffer."Interest Amount" := Interest - Rec.Amount;
                    IntBuffer.Modify;
                    Interest := Rec.Amount;
                end;

            until IntBuffer.Next = 0;
        end;
        exit(Interest);
    end;

    local procedure FnGetApprovedOverDraft(): Decimal
    var
        ObjOverdraftRegister: Record "Over Draft Register";
    begin
        ObjOverdraftRegister.Reset;
        ObjOverdraftRegister.SetRange(ObjOverdraftRegister."Account No", Rec."Account No");
        ObjOverdraftRegister.SetRange(ObjOverdraftRegister.Status, ObjOverdraftRegister.Status::Approved);
        ObjOverdraftRegister.SetRange(ObjOverdraftRegister."Overdraft Status", ObjOverdraftRegister."overdraft status"::Active);
        if ObjOverdraftRegister.FindLast then
            exit(ObjOverdraftRegister."Approved Amount");
    end;

    local procedure FnCheckOverDraftCommisionStatus(): Boolean
    var
        ObjOverdraftRegister: Record "Over Draft Register";
    begin
        ObjOverdraftRegister.Reset;
        ObjOverdraftRegister.SetRange(ObjOverdraftRegister."Account No", Rec."Account No");
        ObjOverdraftRegister.SetRange(ObjOverdraftRegister.Status, ObjOverdraftRegister.Status::Approved);
        ObjOverdraftRegister.SetRange(ObjOverdraftRegister."Overdraft Status", ObjOverdraftRegister."overdraft status"::Active);
        if ObjOverdraftRegister.Find('-') then
            exit(ObjOverdraftRegister."commission charged");
    end;

    local procedure FnGetApprovedOverDraftNo(): Code[100]
    var
        ObjOverdraftRegister: Record "Over Draft Register";
    begin
        ObjOverdraftRegister.Reset;
        ObjOverdraftRegister.SetRange(ObjOverdraftRegister."Account No", Rec."Account No");
        ObjOverdraftRegister.SetRange(ObjOverdraftRegister.Status, ObjOverdraftRegister.Status::Approved);
        ObjOverdraftRegister.SetRange(ObjOverdraftRegister."Overdraft Status", ObjOverdraftRegister."overdraft status"::Active);
        if ObjOverdraftRegister.FindFirst then
            exit(ObjOverdraftRegister."Over Draft No");
    end;

    local procedure FnUpdateOVerdraftCommisionStatus()
    var
        ObjOverdraftRegister: Record "Over Draft Register";
        OverdraftSetup: Record "Overdraft Setup";
    begin
        OverdraftSetup.Get();
        ObjOverdraftRegister.Reset;
        ObjOverdraftRegister.SetRange(ObjOverdraftRegister."Account No", Rec."Account No");
        ObjOverdraftRegister.SetRange(ObjOverdraftRegister.Status, ObjOverdraftRegister.Status::Approved);
        ObjOverdraftRegister.SetRange(ObjOverdraftRegister."Overdraft Status", ObjOverdraftRegister."overdraft status"::Active);
        if ObjOverdraftRegister.Find('-') then begin
            ObjOverdraftRegister."commission charged" := true;
            CommisionOnOverdraft := OverdraftSetup."Overdraft Commision Charged";
            ObjOverdraftRegister.Modify;
        end;
    end;

    local procedure FnUpdateOVerdraftInterestStatus()
    var
        ObjOverdraftRegister: Record "Over Draft Register";
    begin
        ObjOverdraftRegister.Reset;
        ObjOverdraftRegister.SetRange(ObjOverdraftRegister."Account No", Rec."Account No");
        ObjOverdraftRegister.SetRange(ObjOverdraftRegister.Status, ObjOverdraftRegister.Status::Approved);
        ObjOverdraftRegister.SetRange(ObjOverdraftRegister."Overdraft Status", ObjOverdraftRegister."overdraft status"::Active);
        if ObjOverdraftRegister.Find('-') then begin
            ObjOverdraftRegister."Interest Charged" := true;
            InterestOnOverdraft := ObjOverdraftRegister."Total Interest Charged";
            ObjOverdraftRegister.Modify;
        end;
    end;

    local procedure FnCheckOverDraftInterestStatus(): Boolean
    var
        ObjOverdraftRegister: Record "Over Draft Register";
    begin
        ObjOverdraftRegister.Reset;
        ObjOverdraftRegister.SetRange(ObjOverdraftRegister."Account No", Rec."Account No");
        ObjOverdraftRegister.SetRange(ObjOverdraftRegister.Status, ObjOverdraftRegister.Status::Approved);
        ObjOverdraftRegister.SetRange(ObjOverdraftRegister."Overdraft Status", ObjOverdraftRegister."overdraft status"::Active);
        if ObjOverdraftRegister.Find('-') then
            exit(ObjOverdraftRegister."Interest Charged");
    end;

    local procedure FnGetTotalApprovedOverDraft(): Decimal
    var
        ObjOverdraftRegister: Record "Over Draft Register";
    begin
        ObjOverdraftRegister.Reset;
        ObjOverdraftRegister.SetRange(ObjOverdraftRegister."Account No", Rec."Account No");
        ObjOverdraftRegister.SetRange(ObjOverdraftRegister.Status, ObjOverdraftRegister.Status::Approved);
        if ObjOverdraftRegister.FindSet then begin
            ObjOverdraftRegister.CalcSums(ObjOverdraftRegister."Approved Amount");
            exit(ObjOverdraftRegister."Approved Amount");
        end;
    end;
}

