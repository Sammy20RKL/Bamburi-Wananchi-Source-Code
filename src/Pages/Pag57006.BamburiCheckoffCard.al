
page 57006 "Bamburi Checkoff Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Bamburi Checkoff Header";
    SourceTableView = where(Posted = const(false));

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = Basic;
                }
                field("Date Entered"; Rec."Date Entered")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Posting date"; Rec."Posting date")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Loan CutOff Date"; Rec."Loan CutOff Date")
                {
                    ApplicationArea = Basic;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic;
                }
                field("Total Count"; Rec."Total Count")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = Basic;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Account No"; Rec."Account No")
                {
                    Caption = 'Receiving Bank';
                    ApplicationArea = Basic;


                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Employer Code"; Rec."Employer Code")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Employer Name"; Rec."Employer Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }

                field(Amount; Rec.Amount)
                {
                    Caption = 'Cheque Amount';
                    ApplicationArea = Basic;
                }
                field("Scheduled Amount"; Rec."Scheduled Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("Entered By"; Rec."Entered By")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
            }
            part("Bosa receipt lines"; "Bamburi CheckoffLines")
            {
                SubPageLink = "Receipt Header No" = field(No);
            }
        }
    }
    actions
    {
        area(processing)
        {
            // 1. Import Checkoff
            // action(ImportItems)
            // {
            //     Caption = 'Import CheckOff';
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     Image = Import;
            //     ApplicationArea = All;

            //     RunObject = xmlport "Bamburi Checkoff Import";
            action(ImportItems)
            {
                Caption = 'Import CheckOff';
                Promoted = true;
                PromotedCategory = Process;
                Image = Import;
                ApplicationArea = All;

                trigger OnAction()
                var
                    BamburiCheckoffImport: XmlPort "Bamburi Checkoff Import";
                begin
                    // Pass the current header number to the XMLport
                    BamburiCheckoffImport.SetReceiptHeaderNo(Rec.No);
                    BamburiCheckoffImport.Run();

                    // Refresh the page to show imported lines
                    CurrPage.Update(false);
                end;
            }
            // }        
            // 2. Validate Receipts
            action("Validate Receipts")
            {
                ApplicationArea = Basic;
                Caption = 'Validate Receipts';
                Image = ValidateEmailLoggingSetup;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    RcptBufLines.Reset;
                    RcptBufLines.SetRange(RcptBufLines."Receipt Header No", Rec.No);
                    if RcptBufLines.Find('-') then begin
                        repeat

                            Memb.Reset;
                            Memb.SetRange(Memb."Personal No", RcptBufLines."Staff/Payroll No");
                            //Memb.SETRANGE(Memb."Employer Code",RcptBufLines."Employer Code");
                            if Memb.Find('-') then begin

                                RcptBufLines."Member No" := Memb."No.";
                                RcptBufLines.Name := Memb.Name;
                                RcptBufLines."ID No." := Memb."ID No.";
                                RcptBufLines."Member Found" := true;
                                RcptBufLines.Modify;
                            end;
                        until RcptBufLines.Next = 0;
                    end;
                    Message('Successfully validated');
                end;
            }
            // 3. Refresh Page
            action(RefreshPage)
            {
                Caption = 'Refresh page';
                Promoted = true;
                PromotedCategory = Process;
                Image = Refresh;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    // Message('Refreshing...');
                    CurrPage.Update; // Refresh the current page UI
                    Rec.Validate("Scheduled Amount");
                    FnValidateMembers();
                    FnValidateAmounts();
                    Rec.UpdateTotalAmount();
                    Rec.Modify(true);
                    Message('Page refreshed and data updated.');
                end;
            }
            // 4. Post Checkoff
            action("Post check off")
            {
                ApplicationArea = Basic;
                Caption = 'Post check off';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                // PromotedIsBig = true;

                trigger OnAction()
                var
                    UsersID: Record User;
                    FundsUSer: Record "Funds User Setup";
                    GenJnlManagement: Codeunit GenJnlManagement;
                    GenBatch: Record "Gen. Journal Batch";
                    dialogBox: Dialog;
                begin
                    Rec.SetRange(Rec.No);
                    genstup.Get();
                    if Rec.Posted = true then
                        Error('This Check Off has already been posted');
                    if Rec."Account No" = '' then
                        Error('You must specify the Account No.');
                    if Rec."Document No" = '' then
                        Error('You must specify the Document No.');
                    if Rec."Posting date" = 0D then
                        Error('You must specify the Posting date.');
                    if Rec."Posting date" = 0D then
                        Error('You must specify the Posting date.');
                    if Rec."Loan CutOff Date" = 0D then
                        Error('You must specify the Loan CutOff Date.');
                    Datefilter := '..' + Format(Rec."Loan CutOff Date");
                    IssueDate := Rec."Loan CutOff Date";
                    //General Journals
                    // if FundsUSer.Get(UserId) then begin
                    Jtemplate := 'GENERAL';
                    Jbatch := 'CHECKOFF';
                    // end;
                    //Delete journal
                    Gnljnline.Reset();
                    Gnljnline.SetRange("Journal Template Name", Jtemplate);
                    Gnljnline.SetRange("Journal Batch Name", Jbatch);
                    if Gnljnline.Find('-') then begin
                        Gnljnline.DeleteAll;
                    end;

                    // Rec.CalcFields("Scheduled Amount");
                    if Rec."Scheduled Amount" <> Rec.Amount then begin
                        ERROR('Scheduled Amount Is Not Equal To Cheque Amount');
                    end;

                    Rec.Validate("Scheduled Amount");
                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := Jtemplate;
                    Gnljnline."Journal Batch Name" := Jbatch;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Rec."Account Type";//Gnljnline."Account Type"::"Bank Account";// Rec."Account Type";
                    Gnljnline."Account No." := Rec."Account No";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := Rec."Document No";
                    Gnljnline."Posting Date" := Rec."Posting date";
                    Gnljnline.Description := 'CHECKOFF ' + Rec.Remarks;
                    Gnljnline.Amount := (Rec."Scheduled Amount");//Minus welfare amount
                    Gnljnline.Validate(Gnljnline.Amount);
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    Gnljnline."Shortcut Dimension 2 Code" := 'NAIROBI';
                    Gnljnline.Validate(Gnljnline."Shortcut Dimension 1 Code");
                    Gnljnline.Validate(Gnljnline."Shortcut Dimension 2 Code");
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert(true);
                    //End Of control


                    RcptBufLines.Reset;
                    RcptBufLines.SetRange(RcptBufLines."Receipt Header No", Rec.No);
                    RcptBufLines.SetRange(RcptBufLines.Posted, false);
                    if RcptBufLines.Find('-') then begin
                        repeat
                            dialogBox.Open('Processing Check Off for ' + Format(RcptBufLines."Member No") + ': ' + RcptBufLines.Name + '...');
                            LineN := LineN + 10000;
                            //Share_Capital
                            if RcptBufLines."Share Capital" > 0 then begin
                                FnInsertMemberContribution(Jtemplate,
                                                            Jbatch,
                                                            RcptBufLines."Member No",
                                                            Rec."Document No",
                                                            'Share Capital - Checkoff',
                                                            RcptBufLines."Share Capital",
                                                            GenJournalLine."Transaction Type"::"Share Capital"
                                                            );
                            end;
                            //Deposit_Contribution
                            if RcptBufLines."Deposit Contribution" > 0 then begin
                                FnInsertMemberContribution(Jtemplate,
                                                            Jbatch,
                                                            RcptBufLines."Member No",
                                                            Rec."Document No",
                                                            'Deposit Contribution Checkoff',
                                                            RcptBufLines."Deposit Contribution",
                                                            GenJournalLine."Transaction Type"::"Deposit Contribution"
                                                            );
                            end;

                            //Benevolent
                            if RcptBufLines.Benevolent > 0 then begin
                                FnInsertMemberContribution(Jtemplate,
                                                            Jbatch,
                                                            RcptBufLines."Member No",
                                                            Rec."Document No",
                                                            'Benevolent Fund - Checkoff',
                                                            RcptBufLines.Benevolent,
                                                            GenJournalLine."Transaction Type"::"Benevolent Fund"
                                                            );
                            end;
                            //Insurance
                            if RcptBufLines.Insurance > 0 then begin
                                FnInsertMemberContribution(Jtemplate,
                                                            Jbatch,
                                                            RcptBufLines."Member No",
                                                            Rec."Document No",
                                                            'Insurance Contribution ChkOff',
                                                            RcptBufLines.Insurance,
                                                            GenJournalLine."Transaction Type"::"Insurance Contribution"
                                                            );
                            end;
                            //Registration
                            if RcptBufLines.Registration > 0 then begin
                                FnInsertMemberContribution(Jtemplate,
                                                            Jbatch,
                                                            RcptBufLines."Member No",
                                                            Rec."Document No",
                                                            'Registration Fee - Checkoff',
                                                            RcptBufLines.Registration,
                                                            GenJournalLine."Transaction Type"::"Registration Fee"
                                                            );
                            end;
                            //Holiday
                            if RcptBufLines.Holiday > 0 then begin
                                FnInsertMemberContribution(Jtemplate,
                                                            Jbatch,
                                                            RcptBufLines."Member No",
                                                            Rec."Document No",
                                                            'Holiday Savings - Checkoff',
                                                            RcptBufLines.Holiday,
                                                            GenJournalLine."Transaction Type"::"Holiday Savings"
                                                            );
                            end;
                            //Add Loan lines...
                            FnPostLoansBal();

                            // Process Welfare.... Festus
                            // ################KINDLY NOTE - WELFARE BALANCES ITSELF----
                            if RcptBufLines."Welfare Contribution" > 0 then begin
                                welfareProcessing.fnPostWelfare(RcptBufLines."Member No",
                                                                Jtemplate, Jbatch,
                                                                LineN,
                                                                Rec."Document No",
                                                                Rec."Posting date",
                                                                320,
                                                                Rec."Account Type",
                                                                Rec."Account No"
                                                            );

                                LineN := LineN + 40000;
                            end;
                            dialogBox.Close();

                        until RcptBufLines.Next = 0;
                    end;

                    // Reinitialize the record and open the journal page
                    Gnljnline.Reset();
                    Gnljnline.SetRange("Journal Template Name", Jtemplate);
                    Gnljnline.SetRange("Journal Batch Name", Jbatch);
                    if Gnljnline.Find('-') then begin
                        Page.Run(page::"General Journal", Gnljnline);
                        Message('CheckOff Successfully Generated');
                    end;


                end;
            }
            // 5. Mark as Posted
            action("Processed Checkoff")
            {
                Caption = 'Mark as Posted';
                ApplicationArea = Basic;
                Image = POST;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to mark this Checkoff as Processed', false) = true then begin
                        Rec.Posted := true;
                        Rec."Posted By" := UserId;
                        Rec.Modify;
                        CurrPage.close();
                    end;
                end;
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Posting date" := Today;
        Rec."Date Entered" := Today;
    end;

    var
        welfareProcessing: Codeunit WelfareProcessing;
        Gnljnline: Record "Gen. Journal Line";
        GenJournalLine: Record "Gen. Journal Line";
        PDate: Date;
        DocNo: Code[20];
        // RunBal: Decimal;
        emergencyLoanBalance: Decimal;
        KivukioLoanBalance: Decimal;
        NormalLoan1Balance: Decimal;
        MwokoziLoanBalance: Decimal;
        schoolFeesLoanBalance: Decimal;
        NormalLoan2Balance: Decimal;
        NormalLoan3Balance: Decimal;
        normalLoan4Balance: Decimal;
        normal21LoanBalance: Decimal;
        InstantLoanBalance: Decimal;
        development23LoanBalance: Decimal;
        NewproductLoanBalance: Decimal;
        merchandiseLoanBalance: Decimal;
        welfarecontributionbalance: Decimal;
        ReceiptsProcessingLines: Record "Bamburi CheckoffLines";
        // LineNo: Integer;
        LBatches: Record "Loan Disburesment-Batching";
        Jtemplate: Code[30];
        JBatch: Code[30];
        "Cheque No.": Code[20];
        DActivityBOSA: Code[20];
        DBranchBOSA: Code[20];
        ReptProcHeader: Record "Bamburi Checkoff Header";
        Cust: Record Customer;
        MembPostGroup: Record "Customer Posting Group";
        Loantable: Record "Loans Register";
        LRepayment: Decimal;
        RcptBufLines: Record "Bamburi CheckoffLines";
        AmountToDeduct: Decimal;
        WelfareAmount: Decimal;
        CommissionAmount: Decimal;
        LoanType: Record "Loan Products Setup";
        LoanApp: Record "Loans Register";
        Interest: Decimal;
        LineN: Integer;
        TotalRepay: Decimal;
        MultipleLoan: Integer;
        LType: Text;
        MonthlyAmount: Decimal;
        ShRec: Decimal;
        SHARESCAP: Decimal;
        DIFF: Decimal;
        DIFFPAID: Decimal;
        genstup: Record "Sacco General Set-Up";
        Memb: Record Customer;
        INSURANCE: Decimal;
        GenBatches: Record "Gen. Journal Batch";
        Datefilter: Text[50];
        ReceiptLine: Record "Bamburi CheckoffLines";
        XMAS: Decimal;
        MemberRec: Record Customer;
        Vendor: Record Vendor;
        IssueDate: Date;
        startDate: Date;
        TotalWelfareAmount: Decimal;
        LoanRepS: Record "Loan Repayment Schedule";
        MonthlyRepay: Decimal;
        cm: Date;
        mm: Code[10];
        Lschedule: Record "Loan Repayment Schedule";
        ScheduleRepayment: Decimal;

    local procedure FnValidateMembers()
    var
    begin
        RcptBufLines.Reset;
        RcptBufLines.SetRange(RcptBufLines."Receipt Header No", Rec.No);
        if RcptBufLines.Find('-') then begin
            repeat

                Memb.Reset;
                Memb.SetRange(Memb."Personal No", RcptBufLines."Staff/Payroll No");
                //Memb.SETRANGE(Memb."Employer Code",RcptBufLines."Employer Code");
                if Memb.Find('-') then begin

                    RcptBufLines."Member No" := Memb."No.";
                    RcptBufLines.Name := Memb.Name;
                    RcptBufLines."ID No." := Memb."ID No.";
                    RcptBufLines."Member Found" := true;
                    RcptBufLines.Modify;
                end;
            until RcptBufLines.Next = 0;
        end;
    end;

    local procedure FnValidateAmounts()
    var
    begin

    end;

    local procedure FnPostLoansBal()
    var
        loanNumber: Code[50];
    // balance: Decimal;
    begin
        //Emergency_Loan
        emergencyLoanBalance := 0;
        emergencyLoanBalance := RcptBufLines."Emergency Loan Amount";
        if emergencyLoanBalance > 0 then begin

            loanNumber := fnGetLoanNumber(RcptBufLines, emergencyLoanBalance, Rec."Loan CutOff Date", 'EMER');
            if loanNumber = '' then begin
                FnTransferExcessToUnallocatedFunds(RcptBufLines, emergencyLoanBalance, 'Excess Payments for Emergency Loan');
            end else begin
                emergencyLoanBalance := FnPostInterestBal(RcptBufLines, emergencyLoanBalance, Rec."Loan CutOff Date", 'EMER', loanNumber);
                emergencyLoanBalance := FnPostPrincipleBal(RcptBufLines, emergencyLoanBalance, loanNumber);

                FnTransferExcessToUnallocatedFunds(RcptBufLines, emergencyLoanBalance, 'Excess Payments for Emergency Loan');
            end;
        end;
        //Kivukio_Loan_
        KivukioloanBalance := 0;
        KivukioloanBalance := RcptBufLines."Kivukio Loan Amount";
        if KivukioloanBalance > 0 then begin

            loanNumber := fnGetLoanNumber(RcptBufLines, KivukioloanBalance, Rec."Loan CutOff Date", 'KIVUK');
            if loanNumber = '' then begin
                FnTransferExcessToUnallocatedFunds(RcptBufLines, KivukioloanBalance, 'Excess Payments for Kivukio Loan');
            end else begin
                KivukioloanBalance := FnPostInterestBal(RcptBufLines, KivukioloanBalance, Rec."Loan CutOff Date", 'KIVUK', loanNumber);
                KivukioloanBalance := FnPostPrincipleBal(RcptBufLines, KivukioloanBalance, loanNumber);

                FnTransferExcessToUnallocatedFunds(RcptBufLines, KivukioloanBalance, 'Excess Payments for Kivukio Loan');
            end;
        end;
        //Normal_Loan_1
        NormalLoan1Balance := 0;
        NormalLoan1Balance := RcptBufLines."Normal Loan 1 Amount";
        if NormalLoan1Balance > 0 then begin

            loanNumber := fnGetLoanNumber(RcptBufLines, NormalLoan1Balance, Rec."Loan CutOff Date", 'NORM1');
            if loanNumber = '' then begin
                FnTransferExcessToUnallocatedFunds(RcptBufLines, NormalLoan1Balance, 'Excess Payments for Normal loan 1');
            end else begin
                NormalLoan1Balance := FnPostInterestBal(RcptBufLines, NormalLoan1Balance, Rec."Loan CutOff Date", 'NORM1', loanNumber);
                NormalLoan1Balance := FnPostPrincipleBal(RcptBufLines, NormalLoan1Balance, loanNumber);

                FnTransferExcessToUnallocatedFunds(RcptBufLines, NormalLoan1Balance, 'Excess Payments for Normal loan 1');
            end;
        end;
        //Mwokozi_Loan
        MwokoziLoanBalance := 0;
        MwokoziLoanBalance := RcptBufLines."Mwokozi Loan Amount";
        if MwokoziLoanBalance > 0 then begin

            loanNumber := fnGetLoanNumber(RcptBufLines, MwokoziLoanBalance, Rec."Loan CutOff Date", 'MWOK');
            if loanNumber = '' then begin
                FnTransferExcessToUnallocatedFunds(RcptBufLines, MwokoziLoanBalance, 'Excess Payments for Mwokozi Loan');
            end else begin
                MwokoziLoanBalance := FnPostInterestBal(RcptBufLines, MwokoziLoanBalance, Rec."Loan CutOff Date", 'MWOK', loanNumber);
                MwokoziLoanBalance := FnPostPrincipleBal(RcptBufLines, MwokoziLoanBalance, loanNumber);

                FnTransferExcessToUnallocatedFunds(RcptBufLines, MwokoziLoanBalance, 'Excess Payments for Mwokozi loan');
            end;
        end;
        //School_fees_loan
        schoolFeesLoanBalance := 0;
        schoolFeesLoanBalance := RcptBufLines."School Fees Amount";
        if schoolFeesLoanBalance > 0 then begin

            loanNumber := fnGetLoanNumber(RcptBufLines, schoolFeesLoanBalance, Rec."Loan CutOff Date", 'SCHLOAN');
            if loanNumber = '' then begin
                FnTransferExcessToUnallocatedFunds(RcptBufLines, schoolFeesLoanBalance, 'Excess Payments for School Fee loan');
            end else begin
                schoolFeesLoanBalance := FnPostInterestBal(RcptBufLines, schoolFeesLoanBalance, Rec."Loan CutOff Date", 'SCHLOAN', loanNumber);
                schoolFeesLoanBalance := FnPostPrincipleBal(RcptBufLines, schoolFeesLoanBalance, loanNumber);

                FnTransferExcessToUnallocatedFunds(RcptBufLines, schoolFeesLoanBalance, 'Excess Payments for School Fee loan');
            end;
        end;
        //Normal_loan_2
        NormalLoan2Balance := 0;
        NormalLoan2Balance := ROUND(RcptBufLines."Normal Loan 2 Amount", 1, '=');
        if NormalLoan2Balance > 0 then begin

            loanNumber := fnGetLoanNumber(RcptBufLines, NormalLoan2Balance, Rec."Loan CutOff Date", 'NORM2');
            if loanNumber = '' then begin
                FnTransferExcessToUnallocatedFunds(RcptBufLines, NormalLoan2Balance, 'Excess Payments for Normal loan 2');
            end else begin
                NormalLoan2Balance := FnPostInterestBal(RcptBufLines, NormalLoan2Balance, Rec."Loan CutOff Date", 'NORM2', loanNumber);
                NormalLoan2Balance := FnPostPrincipleBal(RcptBufLines, NormalLoan2Balance, loanNumber);

                FnTransferExcessToUnallocatedFunds(RcptBufLines, NormalLoan2Balance, 'Excess Payments for Normal loan 2');
            end;
        end;
        //Normal_Loan_3
        NormalLoan3Balance := 0;
        NormalLoan3Balance := RcptBufLines."Normal Loan 3 Amount";
        if NormalLoan3Balance > 0 then begin

            loanNumber := fnGetLoanNumber(RcptBufLines, NormalLoan3Balance, Rec."Loan CutOff Date", 'NORM3');
            if loanNumber = '' then begin
                FnTransferExcessToUnallocatedFunds(RcptBufLines, NormalLoan3Balance, 'Excess Payments for Normal loan 3');
            end else begin
                NormalLoan3Balance := FnPostInterestBal(RcptBufLines, NormalLoan3Balance, Rec."Loan CutOff Date", 'NORM3', loanNumber);
                NormalLoan3Balance := FnPostPrincipleBal(RcptBufLines, NormalLoan3Balance, loanNumber);

                FnTransferExcessToUnallocatedFunds(RcptBufLines, NormalLoan3Balance, 'Excess Payments for Normal loan 3');
            end;
        end;
        //Normal_loan_4_
        normalLoan4Balance := 0;
        normalLoan4Balance := RcptBufLines."Normal loan 4 Amount";
        if normalLoan4Balance > 0 then begin

            loanNumber := fnGetLoanNumber(RcptBufLines, normalLoan4Balance, Rec."Loan CutOff Date", 'NORM4');
            if loanNumber = '' then begin
                FnTransferExcessToUnallocatedFunds(RcptBufLines, normalLoan4Balance, 'Excess Payments for Normal loan 4');
            end else begin
                normalLoan4Balance := FnPostInterestBal(RcptBufLines, normalLoan4Balance, Rec."Loan CutOff Date", 'NORM4', loanNumber);
                normalLoan4Balance := FnPostPrincipleBal(RcptBufLines, normalLoan4Balance, loanNumber);

                FnTransferExcessToUnallocatedFunds(RcptBufLines, normalLoan4Balance, 'Excess Payments for Normal loan 4');
            end;
        end;
        //HALLO_HALLO_loan_
        normal21LoanBalance := 0;
        normal21LoanBalance := RcptBufLines."HALLO HALLO Loan Amount";
        if normal21LoanBalance > 0 then begin

            loanNumber := fnGetLoanNumber(RcptBufLines, normal21LoanBalance, Rec."Loan CutOff Date", 'HALL');
            if loanNumber = '' then begin
                FnTransferExcessToUnallocatedFunds(RcptBufLines, normal21LoanBalance, 'Excess Payments for Hallo Hallo loan');
            end else begin
                normal21LoanBalance := FnPostInterestBal(RcptBufLines, normal21LoanBalance, Rec."Loan CutOff Date", 'HALL', loanNumber);
                normal21LoanBalance := FnPostPrincipleBal(RcptBufLines, normal21LoanBalance, loanNumber);

                FnTransferExcessToUnallocatedFunds(RcptBufLines, normal21LoanBalance, 'Excess Payments for Hallo Hallo loan');
            end;
        end;
        //Instant_loan_
        InstantLoanBalance := 0;
        InstantLoanBalance := RcptBufLines."Instant Loan Amount";
        if InstantLoanBalance > 0 then begin

            loanNumber := fnGetLoanNumber(RcptBufLines, InstantLoanBalance, Rec."Loan CutOff Date", 'INST');
            if loanNumber = '' then begin
                FnTransferExcessToUnallocatedFunds(RcptBufLines, InstantLoanBalance, 'Excess Payments for Instant Loan');
            end else begin
                InstantLoanBalance := FnPostInterestBal(RcptBufLines, InstantLoanBalance, Rec."Loan CutOff Date", 'INST', loanNumber);
                InstantLoanBalance := FnPostPrincipleBal(RcptBufLines, InstantLoanBalance, loanNumber);

                FnTransferExcessToUnallocatedFunds(RcptBufLines, InstantLoanBalance, 'Excess Payments for Instant Loan');
            end;
        end;

        //New_Product_Loan
        NewproductLoanBalance := 0;
        NewproductLoanBalance := RcptBufLines."New Product Loan Amount";
        if NewproductLoanBalance > 0 then begin

            loanNumber := fnGetLoanNumber(RcptBufLines, NewproductLoanBalance, Rec."Loan CutOff Date", 'NEWPRO');
            if loanNumber = '' then begin
                FnTransferExcessToUnallocatedFunds(RcptBufLines, NewproductLoanBalance, 'Excess Payments for New Product Loan');
            end else begin
                NewproductLoanBalance := FnPostInterestBal(RcptBufLines, NewproductLoanBalance, Rec."Loan CutOff Date", 'NEWPRO', loanNumber);
                NewproductLoanBalance := FnPostPrincipleBal(RcptBufLines, NewproductLoanBalance, loanNumber);

                FnTransferExcessToUnallocatedFunds(RcptBufLines, NewproductLoanBalance, 'Excess Payments for New Product Loan');
            end;
        end;

    end;


    local procedure FnInsertMemberContribution(Jtemplate: Code[30]; Jbatch: code[30]; memberNo: Code[15]; documentNo: code[30];
    transDescription: Code[30]; transAmount: Decimal; TransactionType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account"): Code[50]
    var
    begin
        LineN := LineN + 10000;
        Gnljnline.Init;
        Gnljnline."Journal Template Name" := Jtemplate;
        Gnljnline."Journal Batch Name" := Jbatch;
        Gnljnline."Line No." := LineN;
        Gnljnline."Account Type" := Gnljnline."bal. account type"::Customer;
        Gnljnline."Account No." := memberNo;
        Gnljnline.Validate(Gnljnline."Account No.");
        Gnljnline."Document No." := documentNo;
        Gnljnline."Posting Date" := Rec."Posting date";
        Gnljnline.Description := transDescription;
        Gnljnline.Amount := transAmount * -1;
        Gnljnline.Validate(Gnljnline.Amount);
        Gnljnline."Transaction Type" := TransactionType;//Gnljnline."transaction type"::"Deposit Contribution";
        Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
        Gnljnline."Shortcut Dimension 2 Code" := FnGetMemberBranch(memberNo);
        Gnljnline.Validate(Gnljnline."Shortcut Dimension 1 Code");
        Gnljnline.Validate(Gnljnline."Shortcut Dimension 2 Code");
        if Gnljnline.Amount <> 0 then
            Gnljnline.Insert();
    end;

    local procedure FnInsertWelfareContribution(Jtemplate: Code[30]; Jbatch: code[30]; memberNo: Code[15]; documentNo: code[30];
    transDescription: Code[100]; transAmount: Decimal; TransactionType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account","Welfare Contribution"): Code[50]
    var
    begin
        // Welfare contribution
        begin
            LineN := LineN + 10000;
            Gnljnline.Init;
            Gnljnline."Journal Template Name" := Jtemplate;
            Gnljnline."Journal Batch Name" := Jbatch;
            Gnljnline."Line No." := LineN;
            Gnljnline."Account Type" := Gnljnline."bal. account type"::Customer;
            Gnljnline."Account No." := memberNo;
            Gnljnline.Validate(Gnljnline."Account No.");
            Gnljnline."Document No." := documentNo;
            Gnljnline."Posting Date" := Rec."Posting date";
            Gnljnline.Description := transDescription;
            Gnljnline.Amount := transAmount;
            Gnljnline.Validate(Gnljnline.Amount);
            Gnljnline."Transaction Type" := TransactionType;//Gnljnline."transaction type"::"Welfare Contribution";
            Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
            Gnljnline."Shortcut Dimension 2 Code" := FnGetMemberBranch(memberNo);
            Gnljnline.Validate(Gnljnline."Shortcut Dimension 1 Code");
            Gnljnline.Validate(Gnljnline."Shortcut Dimension 2 Code");
            if Gnljnline.Amount <> 0 then
                Gnljnline.Insert();
        end;
        //End of welfare contribution
    end;

    local procedure FnInsertWelfareAccountCredit(Jtemplate: Code[30]; Jbatch: code[30]; memberNo: Code[15]; documentNo: code[30];
    transDescription: Code[30]; transAmount: Decimal; TransactionType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account","Welfare Contribution"): Code[50]
    var
    begin
        // Welfare contribution
        begin
            LineN := LineN + 10000;
            Gnljnline.Init;
            Gnljnline."Journal Template Name" := Jtemplate;
            Gnljnline."Journal Batch Name" := Jbatch;
            Gnljnline."Line No." := LineN;
            Gnljnline."Account Type" := Gnljnline."bal. account type"::"G/L Account";
            Gnljnline."Account No." := '200908';
            Gnljnline.Validate(Gnljnline."Account No.");
            Gnljnline."Document No." := documentNo;
            Gnljnline."Posting Date" := Rec."Posting date";
            Gnljnline.Description := transDescription;
            Gnljnline.Amount := transAmount * -1;
            Gnljnline.Validate(Gnljnline.Amount);
            Gnljnline."Transaction Type" := TransactionType;//Gnljnline."transaction type"::"Welfare Contribution";
            Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
            Gnljnline."Shortcut Dimension 2 Code" := FnGetMemberBranch(memberNo);
            Gnljnline.Validate(Gnljnline."Shortcut Dimension 1 Code");
            Gnljnline.Validate(Gnljnline."Shortcut Dimension 2 Code");
            if Gnljnline.Amount <> 0 then
                Gnljnline.Insert();
        end;
        //End of welfare contribution
    end;

    local procedure FnInsertWelfareCommisionCredit(Jtemplate: Code[30]; Jbatch: code[30]; memberNo: Code[15]; documentNo: code[30];
   transDescription: Code[30]; transAmount: Decimal; TransactionType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account","Welfare Contribution"): Code[50]
    var
    begin
        // Welfare contribution
        begin
            LineN := LineN + 10000;
            Gnljnline.Init;
            Gnljnline."Journal Template Name" := Jtemplate;
            Gnljnline."Journal Batch Name" := Jbatch;
            Gnljnline."Line No." := LineN;
            Gnljnline."Account Type" := Gnljnline."bal. account type"::"G/L Account";
            Gnljnline."Account No." := '301424';
            Gnljnline.Validate(Gnljnline."Account No.");
            Gnljnline."Document No." := documentNo;
            Gnljnline."Posting Date" := Rec."Posting date";
            Gnljnline.Description := transDescription;
            Gnljnline.Amount := transAmount * -1;
            Gnljnline.Validate(Gnljnline.Amount);
            Gnljnline."Transaction Type" := TransactionType;//Gnljnline."transaction type"::"Welfare Contribution";
            Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
            Gnljnline."Shortcut Dimension 2 Code" := FnGetMemberBranch(memberNo);
            Gnljnline.Validate(Gnljnline."Shortcut Dimension 1 Code");
            Gnljnline.Validate(Gnljnline."Shortcut Dimension 2 Code");
            if Gnljnline.Amount <> 0 then
                Gnljnline.Insert();
        end;
        //End of welfare contribution
    end;


    local procedure FnPostInterestBal(ObjRcptBuffer: Record "Bamburi CheckoffLines"; postingAmount: Decimal; LoanCutoffDate: Date; loanCode: Code[10]; loanNumber: Code[50]) balance: Decimal
    var
        AmountToDeduct: Decimal;
        InterestToRecover: Decimal;
    begin
        if postingAmount > 0 then begin
            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No");
            LoanApp.SetRange(LoanApp."Client Code", ObjRcptBuffer."Member No");
            LoanApp.SetRange(LoanApp."Loan Product Type", loanCode);
            LoanApp.SetRange(LoanApp."Loan  No.", loanNumber);
            if LoanApp.Find('-') then begin// FindSet() then begin
                AmountToDeduct := postingAmount;
                // repeat
                LoanApp.CalcFields("Oustanding Interest");

                if AmountToDeduct = 0 then exit;

                // Check if the outstanding interest is greater than 0
                if LoanApp."Oustanding Interest" > 0 then begin

                    InterestToRecover := (LoanApp."Oustanding Interest");
                    if postingAmount >= InterestToRecover then
                        AmountToDeduct := InterestToRecover
                    else
                        AmountToDeduct := postingAmount;

                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := Jtemplate;
                    Gnljnline."Journal Batch Name" := Jbatch;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."bal. account type"::Customer;
                    Gnljnline."Account No." := LoanApp."Client Code";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := Rec."Document No";
                    Gnljnline."Posting Date" := Rec."Posting date";
                    Gnljnline.Description := LoanApp."Loan Product Type" + '-Loan Interest Paid ';
                    Gnljnline.Amount := -1 * AmountToDeduct;
                    Gnljnline.Validate(Gnljnline.Amount);
                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Interest Paid";
                    Gnljnline."Loan No" := LoanApp."Loan  No.";

                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    Gnljnline."Shortcut Dimension 2 Code" := FnGetMemberBranch(LoanApp."Client Code");
                    Gnljnline.Validate(Gnljnline."Shortcut Dimension 1 Code");
                    Gnljnline.Validate(Gnljnline."Shortcut Dimension 2 Code");
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;
                    postingAmount := postingAmount - AmountToDeduct;
                end;
                // until LoanApp.Next() = 0;
                balance := postingAmount;
            end;
            //return balance
            exit(balance);
        end;
    end;


    local procedure fnGetLoanNumber(ObjRcptBuffer: Record "Bamburi CheckoffLines"; RunningBalance: Decimal; LoanCutoffDate: Date; loanCode: Code[10]) loanNumber: Code[50]
    var
    begin
        loanNumber := '';
        LoanApp.Reset;
        LoanApp.SetRange(LoanApp."Client Code", ObjRcptBuffer."Member No");
        LoanApp.SetRange(LoanApp."Loan Product Type", loanCode);
        LoanApp.SetFilter(LoanApp."Date filter", '..' + Format(LoanCutoffDate));
        LoanApp.SetCurrentKey("Client Code", "Application Date");
        LoanApp.Ascending(false);
        if LoanApp.FindFirst() then begin
            repeat
                LoanApp.CalcFields("Outstanding Balance");

                // Check if the outstanding Balance is greater than 0
                if LoanApp."Outstanding Balance" > 0 then begin
                    loanNumber := LoanApp."Loan  No.";
                end;

            until LoanApp.Next() = 0;
        end;
        if loanNumber = '' then begin
            LoanApp.Reset;
            LoanApp.SetRange(LoanApp."Client Code", ObjRcptBuffer."Member No");
            LoanApp.SetRange(LoanApp."Loan Product Type", loanCode);
            LoanApp.SetFilter(LoanApp."Date filter", '..' + Format(LoanCutoffDate));
            LoanApp.SetCurrentKey("Client Code", "Application Date");
            LoanApp.Ascending(false);
            if LoanApp.FindFirst() then begin
                repeat
                    LoanApp.CalcFields("Outstanding Balance");
                    LoanApp.CalcFields("Oustanding Interest");

                    // Check if the outstanding Interest is greater than 0
                    if LoanApp."Oustanding Interest" > 0 then begin
                        loanNumber := LoanApp."Loan  No.";
                    end;

                until LoanApp.Next() = 0;
            end;
        end;
        exit(loanNumber);
    end;

    local procedure FnPostPrincipleBal(ObjRcptBuffer: Record "Bamburi CheckoffLines"; RunningBalance: Decimal; loanNumber: Code[50]) balance: Decimal
    var
        AmountToDeduct: Decimal;
        NewOutstandingBal: Decimal;
    begin

        if RunningBalance > 0 then begin
            AmountToDeduct := 0;
            balance := RunningBalance;

            LoanApp.Reset;
            LoanApp.SetRange(LoanApp."Client Code", ObjRcptBuffer."Member No");
            LoanApp.SetRange(LoanApp."Loan  No.", loanNumber);
            if LoanApp.Find('-') then begin
                AmountToDeduct := RunningBalance;
                // // repeat
                // LoanApp.CalcFields("Outstanding Balance");
                // if LoanApp."Outstanding Balance" < RunningBalance then
                //     AmountToDeduct := LoanApp."Outstanding Balance";

                // //check if thi has already been posted in the loop..
                // if AmountToDeduct = 0 then
                //     exit;

                LineN := LineN + 10000;
                Gnljnline.Init;
                Gnljnline."Journal Template Name" := Jtemplate;
                Gnljnline."Journal Batch Name" := Jbatch;
                Gnljnline."Line No." := LineN;
                Gnljnline."Account Type" := Gnljnline."bal. account type"::Customer;
                Gnljnline."Account No." := LoanApp."Client Code";
                Gnljnline.Validate(Gnljnline."Account No.");
                Gnljnline."Document No." := Rec."Document No";
                Gnljnline."Posting Date" := Rec."Posting date";
                Gnljnline.Description := LoanApp."Loan Product Type" + '-Loan Repayment ';

                Gnljnline.Amount := RunningBalance * -1;// AmountToDeduct * -1;
                Gnljnline.Validate(Gnljnline.Amount);
                Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Loan Repayment";
                Gnljnline."Loan No" := LoanApp."Loan  No.";
                Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                Gnljnline."Shortcut Dimension 2 Code" := FnGetMemberBranch(LoanApp."Client Code");
                Gnljnline.Validate(Gnljnline."Shortcut Dimension 1 Code");
                Gnljnline.Validate(Gnljnline."Shortcut Dimension 2 Code");
                if Gnljnline.Amount <> 0 then
                    Gnljnline.Insert();

            end;
            balance := RunningBalance - AmountToDeduct;
        end;
        exit(balance);
    end;

    local procedure FnGetMemberBranch(MemberNo: Code[50]): Code[100]
    var
        MemberBranch: Code[100];
    begin
        Cust.Reset;
        Cust.SetRange(Cust."No.", MemberNo);
        if Cust.Find('-') then begin
            MemberBranch := Cust."Global Dimension 2 Code";
        end;
        exit(MemberBranch);
    end;

    local procedure FnTransferExcessToUnallocatedFunds(ObjRcptBuffer: Record "Bamburi CheckoffLines"; RunningBalance: Decimal; description: Code[50])
    var

        ObjMember: Record Customer;
    begin

        ObjMember.Reset;
        ObjMember.SetRange(ObjMember."No.", ObjRcptBuffer."Member No");
        // ObjMember.SetRange(ObjMember."Customer Type", ObjMember."customer type"::Member);
        if ObjMember.Find('-') then begin

            LineN := LineN + 10000;
            Gnljnline.Init;
            Gnljnline."Journal Template Name" := Jtemplate;
            Gnljnline."Journal Batch Name" := Jbatch;
            Gnljnline."Line No." := LineN;
            Gnljnline."Account Type" := Gnljnline."account type"::Customer;
            Gnljnline."Account No." := ObjRcptBuffer."Member No";
            Gnljnline.Validate(Gnljnline."Account No.");
            Gnljnline."Document No." := Rec."Document No";
            Gnljnline."Posting Date" := Rec."Posting date";
            Gnljnline.Description := description;
            Gnljnline.Amount := RunningBalance * -1;
            Gnljnline.Validate(Gnljnline.Amount);
            Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Unallocated Funds";
            Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
            Gnljnline."Shortcut Dimension 2 Code" := ObjMember."Global Dimension 2 Code";
            Gnljnline.Validate(Gnljnline."Shortcut Dimension 1 Code");
            Gnljnline.Validate(Gnljnline."Shortcut Dimension 2 Code");
            if Gnljnline.Amount <> 0 then
                Gnljnline.Insert;
        end else begin
            LineN := LineN + 10000;
            Gnljnline.Init;
            Gnljnline."Journal Template Name" := Jtemplate;
            Gnljnline."Journal Batch Name" := Jbatch;
            Gnljnline."Line No." := LineN;
            Gnljnline."Account Type" := Gnljnline."account type"::Customer;
            Gnljnline."Account No." := ObjRcptBuffer."Member No";
            Gnljnline.Validate(Gnljnline."Account No.");
            Gnljnline."Document No." := Rec."Document No";
            Gnljnline."Posting Date" := Rec."Posting date";
            Gnljnline.Description := description;
            Gnljnline.Amount := RunningBalance * -1;
            Gnljnline.Validate(Gnljnline.Amount);
            Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Unallocated Funds";
            Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
            Gnljnline."Shortcut Dimension 2 Code" := ObjMember."Global Dimension 2 Code";
            Gnljnline.Validate(Gnljnline."Shortcut Dimension 1 Code");
            Gnljnline.Validate(Gnljnline."Shortcut Dimension 2 Code");
            if Gnljnline.Amount <> 0 then
                Gnljnline.Insert;
        end;
    end;


}
