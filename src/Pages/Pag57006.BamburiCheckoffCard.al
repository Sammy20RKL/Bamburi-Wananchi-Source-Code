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
                    Caption = 'Receiving Account';
                    ApplicationArea = Basic;
                    TableRelation = "G/L Account";
                    LookupPageId = "G/L Account List";


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
            action(ImportItems)
            {
                Caption = 'Import CheckOff';
                Promoted = true;
                PromotedCategory = Process;
                Image = Import;
                ApplicationArea = All;

                trigger OnAction()
                var
                    BamburiCheckoffImport: XmlPort 50200;
                begin
                    BamburiCheckoffImport.SetReceiptHeaderNo(Rec.No);
                    BamburiCheckoffImport.Run();

                    CurrPage.Update(false);
                end;
            }

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

            // NEW ACTION: Auto-Distribute Loans
            action("Distribute Total Loans")
            {
                Caption = 'Distribute Loans';
                Promoted = true;
                PromotedCategory = Process;
                Image = Allocate;
                ApplicationArea = All;

                trigger OnAction()
                var
                    LoanDistribution: Codeunit "Bamburi Loan Distribution";
                begin
                    if Rec."Loan CutOff Date" = 0D then
                        Error('Please specify the Loan CutOff Date.');
                    if Confirm('Are you sure you want to distribute the loans?', true) then begin
                        LoanDistribution.ProcessAllCheckoffLines(Rec.No, Rec."Loan CutOff Date");
                        CurrPage.Update(true);
                    end;
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
                    Jtemplate := 'GENERAL';
                    Jbatch := 'CHECKOFF';

                    //Delete journal
                    Gnljnline.Reset();
                    Gnljnline.SetRange("Journal Template Name", Jtemplate);
                    Gnljnline.SetRange("Journal Batch Name", Jbatch);
                    if Gnljnline.Find('-') then begin
                        Gnljnline.DeleteAll;
                    end;

                    if Rec."Scheduled Amount" <> Rec.Amount then begin
                        ERROR('Scheduled Amount Is Not Equal To Cheque Amount');
                    end;

                    Rec.Validate("Scheduled Amount");
                    LineN := LineN + 10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := Jtemplate;
                    Gnljnline."Journal Batch Name" := Jbatch;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Gnljnline."Account Type"::"G/L Account";
                    Gnljnline."Account No." := Rec."Account No";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    // Gnljnline."Document Type" := Gnljnline."Document Type"::Invoice;
                    Gnljnline."Document No." := Rec."Document No";
                    Gnljnline."Posting Date" := Rec."Posting date";
                    Gnljnline.Description := 'CHECKOFF ' + Rec.Remarks;
                    Gnljnline.Amount := (Rec."Scheduled Amount");
                    Gnljnline.Validate(Gnljnline.Amount);
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    Gnljnline."Shortcut Dimension 2 Code" := 'BWS';
                    Gnljnline.Validate(Gnljnline."Shortcut Dimension 1 Code");
                    Gnljnline.Validate(Gnljnline."Shortcut Dimension 2 Code");
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert(true);

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
                                                            'Insurance Contribution CheckOff',
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
                            //T-Shirts
                            if RcptBufLines."T-Shirt" > 0 then begin
                                FnInsertMemberContribution(Jtemplate, JBatch, RcptBufLines."Member No", Rec."Document No", 'T-Shirt Checkoff', RcptBufLines."T-Shirt",
                                GenJournalLine."Transaction Type"::"Sales of T-Shirt");
                            end;
                            //Add Loan lines...
                            FnPostLoansBal();

                            // Process Welfare.... Festus
                            if RcptBufLines."Welfare Contribution" > 0 then begin
                                welfareProcessing.fnPostWelfare(RcptBufLines."Member No",
                                                                Jtemplate, Jbatch,
                                                                LineN,
                                                                Rec."Document No",
                                                                Rec."Posting date",
                                                                320,
                                                                Rec."Account Type"::"Bank Account",
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
        Rec."Account Type" := Rec."Account Type"::"Bank Account";
    end;

    var
        welfareProcessing: Codeunit WelfareProcessing;
        Gnljnline: Record "Gen. Journal Line";
        GenJournalLine: Record "Gen. Journal Line";
        PDate: Date;
        DocNo: Code[20];
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
    begin
        RcptBufLines.Reset;
        RcptBufLines.SetRange(RcptBufLines."Receipt Header No", Rec.No);
        if RcptBufLines.Find('-') then begin
            repeat
                Memb.Reset;
                Memb.SetRange(Memb."Personal No", RcptBufLines."Staff/Payroll No");
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
    begin
    end;

    local procedure FnPostLoansBal()
    var
        loanNumber: Code[50];
    begin
        // Emergency Loan
        if RcptBufLines."Emergency Loan Amount" > 0 then begin
            loanNumber := fnGetLoanNumber(RcptBufLines, RcptBufLines."Emergency Loan Amount", Rec."Loan CutOff Date", 'EMER');
            if loanNumber <> '' then begin
                FnPostDistributedLoan(RcptBufLines, loanNumber, RcptBufLines."Emergency Loan Interest", RcptBufLines."Emergency Loan  Principle", 'EMER');
            end else begin
                FnTransferExcessToUnallocatedFunds(RcptBufLines, RcptBufLines."Emergency Loan Amount", 'Excess Payments for Emergency Loan');
            end;
        end;

        // Kivukio Loan
        if RcptBufLines."Kivukio Loan Amount" > 0 then begin
            loanNumber := fnGetLoanNumber(RcptBufLines, RcptBufLines."Kivukio Loan Amount", Rec."Loan CutOff Date", 'KIVUK');
            if loanNumber <> '' then begin
                FnPostDistributedLoan(RcptBufLines, loanNumber, RcptBufLines."Kivukio Loan Interest", RcptBufLines."Kivukio Loan Principle", 'KIVUK');
            end else begin
                FnTransferExcessToUnallocatedFunds(RcptBufLines, RcptBufLines."Kivukio Loan Amount", 'Excess Payments for Kivukio Loan');
            end;
        end;

        // Normal Loan 1
        if RcptBufLines."Normal Loan 1 Amount" > 0 then begin
            loanNumber := fnGetLoanNumber(RcptBufLines, RcptBufLines."Normal Loan 1 Amount", Rec."Loan CutOff Date", 'NORM1');
            if loanNumber <> '' then begin
                FnPostDistributedLoan(RcptBufLines, loanNumber, RcptBufLines."Normal Loan 1 Interest", RcptBufLines."Normal Loan 1 Principle", 'NORM1');
            end else begin
                FnTransferExcessToUnallocatedFunds(RcptBufLines, RcptBufLines."Normal Loan 1 Amount", 'Excess Payments for Normal loan 1');
            end;
        end;

        // Mwokozi Loan
        if RcptBufLines."Mwokozi Loan Amount" > 0 then begin
            loanNumber := fnGetLoanNumber(RcptBufLines, RcptBufLines."Mwokozi Loan Amount", Rec."Loan CutOff Date", 'MWOK');
            if loanNumber <> '' then begin
                FnPostDistributedLoan(RcptBufLines, loanNumber, RcptBufLines."Mwokozi Loan Interest", RcptBufLines."Mwokozi Loan Principle", 'MWOK');
            end else begin
                FnTransferExcessToUnallocatedFunds(RcptBufLines, RcptBufLines."Mwokozi Loan Amount", 'Excess Payments for Mwokozi Loan');
            end;
        end;

        // School Fees Loan
        if RcptBufLines."School Fees Amount" > 0 then begin
            loanNumber := fnGetLoanNumber(RcptBufLines, RcptBufLines."School Fees Amount", Rec."Loan CutOff Date", 'SCHLOAN');
            if loanNumber <> '' then begin
                FnPostDistributedLoan(RcptBufLines, loanNumber, RcptBufLines."School Fees Interest", RcptBufLines."School Fees Principle", 'SCHLOAN');
            end else begin
                FnTransferExcessToUnallocatedFunds(RcptBufLines, RcptBufLines."School Fees Amount", 'Excess Payments for School Fee loan');
            end;
        end;

        // Normal Loan 2
        if RcptBufLines."Normal Loan 2 Amount" > 0 then begin
            loanNumber := fnGetLoanNumber(RcptBufLines, RcptBufLines."Normal Loan 2 Amount", Rec."Loan CutOff Date", 'NORM2');
            if loanNumber <> '' then begin
                FnPostDistributedLoan(RcptBufLines, loanNumber, RcptBufLines."Normal Loan 2 Interest", RcptBufLines."Normal Loan 2 Principle", 'NORM2');
            end else begin
                FnTransferExcessToUnallocatedFunds(RcptBufLines, RcptBufLines."Normal Loan 2 Amount", 'Excess Payments for Normal loan 2');
            end;
        end;



        // HALLO HALLO Loan
        if RcptBufLines."HALLO HALLO Loan Amount" > 0 then begin
            loanNumber := fnGetLoanNumber(RcptBufLines, RcptBufLines."HALLO HALLO Loan Amount", Rec."Loan CutOff Date", 'HALL');
            if loanNumber <> '' then begin
                FnPostDistributedLoan(RcptBufLines, loanNumber, RcptBufLines."HALLO HALLO Loan Interest", RcptBufLines."HALLO HALLO Loan Principle", 'HALL');
            end else begin
                FnTransferExcessToUnallocatedFunds(RcptBufLines, RcptBufLines."HALLO HALLO Loan Amount", 'Excess Payments for Hallo Hallo loan');
            end;
        end;

        // Instant Loan
        if RcptBufLines."Instant Loan Amount" > 0 then begin
            loanNumber := fnGetLoanNumber(RcptBufLines, RcptBufLines."Instant Loan Amount", Rec."Loan CutOff Date", 'INST');
            if loanNumber <> '' then begin
                FnPostDistributedLoan(RcptBufLines, loanNumber, RcptBufLines."Instant Loan Interest", RcptBufLines."Instant Loan Principle", 'INST');
            end else begin
                FnTransferExcessToUnallocatedFunds(RcptBufLines, RcptBufLines."Instant Loan Amount", 'Excess Payments for Instant Loan');
            end;
        end;

        // New Product Loan
        if RcptBufLines."New Product Loan Amount" > 0 then begin
            loanNumber := fnGetLoanNumber(RcptBufLines, RcptBufLines."New Product Loan Amount", Rec."Loan CutOff Date", 'X-MAS');
            if loanNumber <> '' then begin
                FnPostDistributedLoan(RcptBufLines, loanNumber, RcptBufLines."New Product Loan Interest", RcptBufLines."New Product Loan Principle", 'X-MAS');
            end else begin
                FnTransferExcessToUnallocatedFunds(RcptBufLines, RcptBufLines."New Product Loan Amount", 'Excess Payments for New Product Loan');
            end;
        end;
    end;

    local procedure FnInsertMemberContribution(Jtemplate: Code[30]; Jbatch: code[30]; memberNo: Code[15]; documentNo: code[30];
    transDescription: Code[30]; transAmount: Decimal; TransactionType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds","Sales of T-Shirt",Dividend,"FOSA Account"): Code[50]
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
        Gnljnline."Transaction Type" := TransactionType;
        Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
        Gnljnline."Shortcut Dimension 2 Code" := FnGetMemberBranch(memberNo);
        Gnljnline.Validate(Gnljnline."Shortcut Dimension 1 Code");
        Gnljnline.Validate(Gnljnline."Shortcut Dimension 2 Code");
        if Gnljnline.Amount <> 0 then
            Gnljnline.Insert();
    end;

    // local procedure FnPostInterestBal(ObjRcptBuffer: Record "Bamburi CheckoffLines"; postingAmount: Decimal; LoanCutoffDate: Date; loanCode: Code[10]; loanNumber: Code[50]) balance: Decimal
    // var
    //     AmountToDeduct: Decimal;
    //     InterestToRecover: Decimal;
    // begin
    //     if postingAmount > 0 then begin
    //         LoanApp.Reset;
    //         LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No");
    //         LoanApp.SetRange(LoanApp."Client Code", ObjRcptBuffer."Member No");
    //         LoanApp.SetRange(LoanApp."Loan Product Type", loanCode);
    //         LoanApp.SetRange(LoanApp."Loan  No.", loanNumber);
    //         if LoanApp.Find('-') then begin
    //             AmountToDeduct := postingAmount;
    //             LoanApp.CalcFields("Oustanding Interest");

    //             if AmountToDeduct = 0 then exit;

    //             if LoanApp."Oustanding Interest" > 0 then begin
    //                 InterestToRecover := (LoanApp."Oustanding Interest");
    //                 if postingAmount >= InterestToRecover then
    //                     AmountToDeduct := InterestToRecover
    //                 else
    //                     AmountToDeduct := postingAmount;

    //                 LineN := LineN + 10000;
    //                 Gnljnline.Init;
    //                 Gnljnline."Journal Template Name" := Jtemplate;
    //                 Gnljnline."Journal Batch Name" := Jbatch;
    //                 Gnljnline."Line No." := LineN;
    //                 Gnljnline."Account Type" := Gnljnline."bal. account type"::Customer;
    //                 Gnljnline."Account No." := LoanApp."Client Code";
    //                 Gnljnline.Validate(Gnljnline."Account No.");
    //                 Gnljnline."Document No." := Rec."Document No";
    //                 Gnljnline."Posting Date" := Rec."Posting date";
    //                 Gnljnline.Description := LoanApp."Loan Product Type" + '-Loan Interest Paid ';
    //                 Gnljnline.Amount := -1 * AmountToDeduct;
    //                 Gnljnline.Validate(Gnljnline.Amount);
    //                 Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Interest Paid";
    //                 Gnljnline."Loan No" := LoanApp."Loan  No.";

    //                 Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
    //                 Gnljnline."Shortcut Dimension 2 Code" := FnGetMemberBranch(LoanApp."Client Code");
    //                 Gnljnline.Validate(Gnljnline."Shortcut Dimension 1 Code");
    //                 Gnljnline.Validate(Gnljnline."Shortcut Dimension 2 Code");
    //                 if Gnljnline.Amount <> 0 then
    //                     Gnljnline.Insert;
    //                 postingAmount := postingAmount - AmountToDeduct;
    //             end;
    //             balance := postingAmount;
    //         end;
    //         exit(balance);
    //     end;
    // end;

    local procedure fnGetLoanNumber(ObjRcptBuffer: Record "Bamburi CheckoffLines"; RunningBalance: Decimal; LoanCutoffDate: Date; loanCode: Code[10]) loanNumber: Code[50]
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
                    if LoanApp."Oustanding Interest" > 0 then begin
                        loanNumber := LoanApp."Loan  No.";
                    end;
                until LoanApp.Next() = 0;
            end;
        end;
        exit(loanNumber);
    end;

    // local procedure FnPostPrincipleBal(ObjRcptBuffer: Record "Bamburi CheckoffLines"; RunningBalance: Decimal; loanNumber: Code[50]) balance: Decimal
    // var
    //     AmountToDeduct: Decimal;
    // begin
    //     if RunningBalance > 0 then begin
    //         AmountToDeduct := 0;
    //         balance := RunningBalance;

    //         LoanApp.Reset;
    //         LoanApp.SetRange(LoanApp."Client Code", ObjRcptBuffer."Member No");
    //         LoanApp.SetRange(LoanApp."Loan  No.", loanNumber);
    //         if LoanApp.Find('-') then begin
    //             AmountToDeduct := RunningBalance;

    //             LineN := LineN + 10000;
    //             Gnljnline.Init;
    //             Gnljnline."Journal Template Name" := Jtemplate;
    //             Gnljnline."Journal Batch Name" := Jbatch;
    //             Gnljnline."Line No." := LineN;
    //             Gnljnline."Account Type" := Gnljnline."bal. account type"::Customer;
    //             Gnljnline."Account No." := LoanApp."Client Code";
    //             Gnljnline.Validate(Gnljnline."Account No.");
    //             Gnljnline."Document No." := Rec."Document No";
    //             Gnljnline."Posting Date" := Rec."Posting date";
    //             Gnljnline.Description := LoanApp."Loan Product Type" + '-Loan Repayment ';

    //             Gnljnline.Amount := RunningBalance * -1;
    //             Gnljnline.Validate(Gnljnline.Amount);
    //             Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Loan Repayment";
    //             Gnljnline."Loan No" := LoanApp."Loan  No.";
    //             Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
    //             Gnljnline."Shortcut Dimension 2 Code" := FnGetMemberBranch(LoanApp."Client Code");
    //             Gnljnline.Validate(Gnljnline."Shortcut Dimension 1 Code");
    //             Gnljnline.Validate(Gnljnline."Shortcut Dimension 2 Code");
    //             if Gnljnline.Amount <> 0 then
    //                 Gnljnline.Insert();
    //         end;
    //         balance := RunningBalance - AmountToDeduct;
    //     end;
    //     exit(balance);
    // end;

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
        end;
    end;

    local procedure FnPostDistributedLoan(ObjRcptBuffer: Record "Bamburi CheckoffLines"; loanNumber: Code[50]; InterestAmount: Decimal; PrincipalAmount: Decimal; loanCode: Code[10])
    var
        LoanRec: Record "Loans Register";
    begin
        // Find the loan record
        LoanRec.Reset();
        LoanRec.SetRange("Loan  No.", loanNumber);
        if not LoanRec.FindFirst() then
            exit;

        // Post Interest if amount > 0
        if InterestAmount > 0 then begin
            LineN := LineN + 10000;
            Gnljnline.Init;
            Gnljnline."Journal Template Name" := Jtemplate;
            Gnljnline."Journal Batch Name" := Jbatch;
            Gnljnline."Line No." := LineN;
            Gnljnline."Account Type" := Gnljnline."Account Type"::Customer;
            Gnljnline."Account No." := ObjRcptBuffer."Member No";
            Gnljnline.Validate(Gnljnline."Account No.");
            Gnljnline."Document No." := Rec."Document No";
            Gnljnline."Posting Date" := Rec."Posting date";
            Gnljnline.Description := loanCode + '-Loan Interest Paid';
            Gnljnline.Amount := InterestAmount * -1;
            Gnljnline.Validate(Gnljnline.Amount);
            Gnljnline."Transaction Type" := Gnljnline."Transaction Type"::"Interest Paid";
            Gnljnline."Loan No" := loanNumber;
            Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
            Gnljnline."Shortcut Dimension 2 Code" := FnGetMemberBranch(ObjRcptBuffer."Member No");
            Gnljnline.Validate(Gnljnline."Shortcut Dimension 1 Code");
            Gnljnline.Validate(Gnljnline."Shortcut Dimension 2 Code");
            Gnljnline.Insert();
        end;

        // Post Principal if amount > 0
        if PrincipalAmount > 0 then begin
            LineN := LineN + 10000;
            Gnljnline.Init;
            Gnljnline."Journal Template Name" := Jtemplate;
            Gnljnline."Journal Batch Name" := Jbatch;
            Gnljnline."Line No." := LineN;
            Gnljnline."Account Type" := Gnljnline."Account Type"::Customer;
            Gnljnline."Account No." := ObjRcptBuffer."Member No";
            Gnljnline.Validate(Gnljnline."Account No.");
            Gnljnline."Document No." := Rec."Document No";
            Gnljnline."Posting Date" := Rec."Posting date";
            Gnljnline.Description := loanCode + '-Loan Repayment';
            Gnljnline.Amount := PrincipalAmount * -1;
            Gnljnline.Validate(Gnljnline.Amount);
            Gnljnline."Transaction Type" := Gnljnline."Transaction Type"::"Loan Repayment";
            Gnljnline."Loan No" := loanNumber;
            Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
            Gnljnline."Shortcut Dimension 2 Code" := FnGetMemberBranch(ObjRcptBuffer."Member No");
            Gnljnline.Validate(Gnljnline."Shortcut Dimension 1 Code");
            Gnljnline.Validate(Gnljnline."Shortcut Dimension 2 Code");
            Gnljnline.Insert();
        end;

        // Mark the installment as Paid after successful posting
        LoanRepS.Reset();
        LoanRepS.SetRange("Loan No.", loanNumber);
        LoanRepS.SetRange("Member No.", ObjRcptBuffer."Member No");
        LoanRepS.SetRange(Paid, false);
        LoanRepS.SetFilter("Repayment Date", '..%1', Rec."Loan CutOff Date");
        LoanRepS.SetCurrentKey("Loan No.", "Member No.", "Reschedule No", "Instalment No");
        LoanRepS.Ascending(true);

        if LoanRepS.FindFirst() then begin
            LoanRepS."Actual Interest Paid" := InterestAmount;
            LoanRepS."Actual Principal Paid" := PrincipalAmount;
            LoanRepS."Actual Installment Paid" := InterestAmount + PrincipalAmount;
            LoanRepS."Actual Loan Repayment Date" := Rec."Posting date";
            LoanRepS.Paid := true;
            LoanRepS.Modify(true);
        end;
    end;
}