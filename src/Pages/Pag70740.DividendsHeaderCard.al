#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006
page 70740 "Dividends Header Card"
{
    Caption = 'Dividend Header Card';
    PageType = Card;
    DeleteAllowed = true;
    SourceTable = "Dividends Header";
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("No"; Rec."No")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        // Add No. Series assist edit logic here if needed
                    end;
                }
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = All;
                }
                field("Year"; Rec."Year")
                {
                    ApplicationArea = All;
                }
                field("Posted"; Rec."Posted")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;

                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;

                }
            }
            part(DividendLinesFactBox; "Dividend Lines List")
            {
                ApplicationArea = Basic;
                Caption = 'Dividend Lines';
                SubPageLink = "No" = field("No");
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            action("Import Dividends")
            {
                ApplicationArea = All;
                Promoted = true;
                Image = Import;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    DividendImport: XmlPort "Dividend Lines Import";
                begin
                    DividendImport.SetHeaderNo(Rec."No");
                    DividendImport.Run();
                end;
            }

            action("Post Dividends")
            {
                ApplicationArea = Basic;
                Caption = 'Post Dividends';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    DialoBox: Dialog;

                begin
                    if Rec.Posted then
                        Error('This dividend batch has already been posted.');

                    if Rec."Posting Date" = 0D then
                        Error('Please enter a Posting Date before posting.');

                    if Rec."Document No" = '' then
                        Error('Please enter a Document No before posting.');

                    if Rec.Year = 0 then
                        Error('Please enter the Dividend Year before posting.');

                    // Confirm before proceeding
                    if not Confirm('Are you sure you want to Post dividends?', true, Rec."No") then
                        exit;



                    BATCH_TEMPLATE := 'PAYMENTS';
                    BATCH_NAME := 'DIVIDEND';

                    GenJournalLine.Reset();
                    GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                    GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                    GenJournalLine.DeleteAll();

                    DividendsLines.Reset();
                    DividendsLines.SetRange(DividendsLines.No, Rec.No);
                    if DividendsLines.Find('-') then begin
                        DialoBox.Open('Processing Dividends ' + '...');

                        repeat
                            LineNo := LineNo + 10000;

                            if DividendsLines."Member Deposits" > 0 then begin
                                FnInsertMemberContribution(BATCH_TEMPLATE, BATCH_NAME, DividendsLines."Member No", Rec."Document No",
                                'Deposit Contribution - Dividends', DividendsLines."Member Deposits", GenJournalLine."Transaction Type"::"Deposit Contribution");

                            end;
                            if DividendsLines."Holiday Savings" > 0 then begin
                                FnInsertMemberContribution(BATCH_TEMPLATE, BATCH_NAME, DividendsLines."Member No", Rec."Document No",
                                'Holiday Savings - Dividends', DividendsLines."Holiday Savings", GenJournalLine."Transaction Type"::"Holiday Savings");

                            end;
                            if DividendsLines."T-Shirts" > 0 then begin
                                FnInsertMemberContribution(BATCH_TEMPLATE, BATCH_NAME, DividendsLines."Member No", Rec."Document No",
                                'T-Shirts - Dividends', DividendsLines."T-Shirts", GenJournalLine."Transaction Type"::"Sales of T-Shirt");
                            end;


                            //post loan lines
                            PostLoanBal();

                        until DividendsLines.Next = 0;
                        DialoBox.Close();
                        PostDividends(Rec."No", Rec."Posting Date", Rec.Year, Rec."Document No");


                    end;
                    GenJournalLine.Reset();
                    GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                    GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                    if GenJournalLine.Find('-') then begin
                        Page.Run(Page::"General Journal", GenJournalLine);
                        Message('Dividends Successfully Generated. Please review and post the journal.');
                    end else
                        Message('No journal lines were generated. Please check the dividend lines.');
                end;

            }
            action("Mark as Posted")
            {
                ApplicationArea = All;
                Image = PostedPayment;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    DividendsH: Record "Dividends Header";
                begin
                    if not Confirm('Are you sure want to mark this dividend as posted?', true) then
                        exit;

                    DividendsH.Reset();
                    DividendsH.SetRange(DividendsH.No, Rec.No);
                    if DividendsH.Find('-') then begin
                        Rec.Posted := true;
                        rec.Modify(true);
                    end;
                end;
            }
        }
    }

    local procedure FnInsertMemberContribution(Jtemplate: Code[30]; Jbatch: code[30]; memberNo: Code[15]; documentNo: code[30];
    transDescription: Code[35]; transAmount: Decimal; TransactionType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Dividend","Unclaimed Dividends",Loan,"Unallocated Funds","Holiday Savings","Sales of T-Shirt","Other Products","FOSA Account"): Code[50]
    begin
        LineNo := LineNo + 10000;
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := Jtemplate;
        GenJournalLine."Journal Batch Name" := Jbatch;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := GenJournalLine."bal. account type"::Customer;
        GenJournalLine."Account No." := memberNo;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Document No." := documentNo;
        GenJournalLine."Posting Date" := Rec."Posting date";
        GenJournalLine.Description := transDescription;
        GenJournalLine.Amount := transAmount * -1;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Transaction Type" := TransactionType;
        GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
        GenJournalLine."Shortcut Dimension 2 Code" := FnGetMemberBranch(memberNo);
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert();
    end;

    local procedure FnGetMemberBranch(MemberNo: Code[50]): Code[100]
    var
        MemberBranch: Code[100];
        payment: page 256;
    begin
        Cust.Reset;
        Cust.SetRange(Cust."No.", MemberNo);
        if Cust.Find('-') then begin
            MemberBranch := Cust."Global Dimension 2 Code";
        end;
        exit(MemberBranch);
    end;

    local procedure PostLoanBal()
    var
        loanNumber: Code[50];
    begin
        if (DividendsLines."X-Mas Loan" > 0) OR (DividendsLines."X-Mas Loan Interest" > 0) then begin
            loanNumber := fnGetLoanNumber(DividendsLines, DividendsLines."X-Mas Loan", Rec."Posting Date", 'X-MAS');
            if loanNumber <> '' then begin
                FnPostDistributedLoan(DividendsLines, loanNumber, DividendsLines."X-Mas Loan Interest", DividendsLines."X-Mas Loan", 'X-MAS');
            end else begin
                FnTransferExcessToUnallocatedFunds(DividendsLines, DividendsLines."X-Mas Loan" + DividendsLines."X-Mas Loan Interest", 'Excess Payments for X-Mas Loan');
            end;
        end;

        if (DividendsLines."Emer Loan Principle" > 0) OR (DividendsLines."Emer Loan Interest" > 0) then begin
            loanNumber := fnGetLoanNumber(DividendsLines, DividendsLines."Emer Loan Principle", Rec."Posting Date", 'EMER');
            if loanNumber <> '' then begin
                FnPostDistributedLoan(DividendsLines, loanNumber, DividendsLines."Emer Loan Interest", DividendsLines."Emer Loan Principle", 'EMER');
            end else begin
                FnTransferExcessToUnallocatedFunds(DividendsLines, DividendsLines."Emer Loan Principle" + DividendsLines."Emer Loan Interest", 'Excess Payments for Emer Loan');
            end;
        end;

        if (DividendsLines."Hallo Loan Principle" > 0) OR (DividendsLines."Hallo Loan Interest" > 0) then begin
            loanNumber := fnGetLoanNumber(DividendsLines, DividendsLines."Hallo Loan Principle", Rec."Posting Date", 'HALL');
            if loanNumber <> '' then begin
                FnPostDistributedLoan(DividendsLines, loanNumber, DividendsLines."Hallo Loan Interest", DividendsLines."Hallo Loan Principle", 'Hall');
            end else begin
                FnTransferExcessToUnallocatedFunds(DividendsLines, DividendsLines."Hallo Loan Principle" + DividendsLines."Hallo Loan Interest", 'Excess Payments for Hallo Loan');
            end;
        end;

        if (DividendsLines."Norm2 Loan Principle" > 0) OR (DividendsLines."Norm2 Loan Interest" > 0) then begin
            loanNumber := fnGetLoanNumber(DividendsLines, DividendsLines."Norm2 Loan Principle", Rec."Posting Date", 'NORM2');
            if loanNumber <> '' then begin
                FnPostDistributedLoan(DividendsLines, loanNumber, DividendsLines."Norm2 Loan Interest", DividendsLines."Norm2 Loan Principle", 'NORM2');
            end else begin
                FnTransferExcessToUnallocatedFunds(DividendsLines, DividendsLines."Norm2 Loan Principle" + DividendsLines."Norm2 Loan Interest", 'Excess Payments for Norm2 Loan');
            end;
        end;

        if (DividendsLines."Norm1 Loan Principle" > 0) OR (DividendsLines."Norm1 Loan Interest" > 0) then begin
            loanNumber := fnGetLoanNumber(DividendsLines, DividendsLines."Norm1 Loan Principle", Rec."Posting Date", 'NORM1');
            if loanNumber <> '' then begin
                FnPostDistributedLoan(DividendsLines, loanNumber, DividendsLines."Norm1 Loan Interest", DividendsLines."Norm1 Loan Principle", 'Norm1');
            end else begin
                FnTransferExcessToUnallocatedFunds(DividendsLines, DividendsLines."Norm1 Loan Principle" + DividendsLines."Norm1 Loan Interest", 'Excess Payments for Norm1 Loan');
            end;
        end;
        if (DividendsLines."School Loan Principle" > 0) OR (DividendsLines."School Loan Interest" > 0) then begin
            loanNumber := fnGetLoanNumber(DividendsLines, DividendsLines."School Loan Principle", Rec."Posting Date", 'SCHLOAN');
            if loanNumber <> '' then begin
                FnPostDistributedLoan(DividendsLines, loanNumber, DividendsLines."School Loan Interest", DividendsLines."School Loan Principle", 'SCHLOAN');
            end else begin
                FnTransferExcessToUnallocatedFunds(DividendsLines, DividendsLines."School Loan Principle" + DividendsLines."School Loan Interest", 'Excess Payments for School Loan');
            end;
        end;
        if (DividendsLines."Mbuyu Loan Principle" > 0) OR (DividendsLines."Mbuyu Loan Interest" > 0) then begin
            loanNumber := fnGetLoanNumber(DividendsLines, DividendsLines."Mbuyu Loan Principle", Rec."Posting Date", 'MBUY');
            if loanNumber <> '' then begin
                FnPostDistributedLoan(DividendsLines, loanNumber, DividendsLines."Mbuyu Loan Interest", DividendsLines."Mbuyu Loan Principle", 'MBUY');
            end else begin
                FnTransferExcessToUnallocatedFunds(DividendsLines, DividendsLines."Mbuyu Loan Principle" + DividendsLines."Mbuyu Loan Interest", 'Excess Payments for Mbuyu Loan');
            end;
        end;
        if (DividendsLines."Kivukio Loan Principle" > 0) OR (DividendsLines."Kivukio Loan Interest" > 0) then begin
            loanNumber := fnGetLoanNumber(DividendsLines, DividendsLines."Kivukio Loan Principle", Rec."Posting Date", 'KIVUK');
            if loanNumber <> '' then begin
                FnPostDistributedLoan(DividendsLines, loanNumber, DividendsLines."Kivukio Loan Interest", DividendsLines."Kivukio Loan Principle", 'KIVUK');
            end else begin
                FnTransferExcessToUnallocatedFunds(DividendsLines, DividendsLines."Kivukio Loan Principle" + DividendsLines."Kivukio Loan Interest", 'Excess Payments for Kivukio Loan');
            end;
        end;
        if (DividendsLines."Instant Loan Principle" > 0) OR (DividendsLines."Instant Loan Interest" > 0) then begin
            loanNumber := fnGetLoanNumber(DividendsLines, DividendsLines."Instant Loan Principle", Rec."Posting Date", 'INST');
            if loanNumber <> '' then begin
                FnPostDistributedLoan(DividendsLines, loanNumber, DividendsLines."Instant Loan Interest", DividendsLines."Instant Loan Principle", 'INST');
            end else begin
                FnTransferExcessToUnallocatedFunds(DividendsLines, DividendsLines."Instant Loan Principle" + DividendsLines."Instant Loan Interest", 'Excess Payments for Instant Loan');
            end;
        end;

    end;

    local procedure fnGetLoanNumber(DividendsLines: Record "Dividends Lines"; RunningBalance: Decimal; PostingDate: Date; loanCode: Code[10]) loanNumber: Code[50]
    begin
        loanNumber := '';
        LoanApp.Reset;
        LoanApp.SetRange(LoanApp."Client Code", DividendsLines."Member No");
        LoanApp.SetRange(LoanApp."Loan Product Type", loanCode);
        LoanApp.SetFilter(LoanApp."Date filter", '..' + Format(PostingDate));
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
            LoanApp.SetRange(LoanApp."Client Code", DividendsLines."Member No");
            LoanApp.SetRange(LoanApp."Loan Product Type", loanCode);
            LoanApp.SetFilter(LoanApp."Date filter", '..' + Format(PostingDate));
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

    local procedure FnPostDistributedLoan(DividendLines: Record "Dividends Lines"; loanNumber: Code[50]; InterestAmount: Decimal; PrincipalAmount: Decimal; loanCode: Code[10])
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
            LineNo := LineNo + 10000;
            GenJournalLine.Init;
            GenJournalLine."Journal Template Name" := BATCH_TEMPLATE;
            GenJournalLine."Journal Batch Name" := BATCH_NAME;
            GenJournalLine."Line No." := LineNo;
            GenJournalLine."Account Type" := GenJournalLine."Account Type"::Customer;
            GenJournalLine."Account No." := DividendLines."Member No";
            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine."Document No." := Rec."Document No";
            GenJournalLine."Posting Date" := Rec."Posting date";
            GenJournalLine.Description := loanCode + '-Loan Interest Paid';
            GenJournalLine.Amount := InterestAmount * -1;
            GenJournalLine.Validate(GenJournalLine.Amount);
            GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::"Interest Paid";
            GenJournalLine."Loan No" := loanNumber;
            GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
            GenJournalLine."Shortcut Dimension 2 Code" := FnGetMemberBranch(DividendLines."Member No");
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
            GenJournalLine.Insert();
        end;

        // Post Principal if amount > 0
        if PrincipalAmount > 0 then begin
            LineNo := LineNo + 10000;
            GenJournalLine.Init;
            GenJournalLine."Journal Template Name" := BATCH_TEMPLATE;
            GenJournalLine."Journal Batch Name" := BATCH_NAME;
            GenJournalLine."Line No." := LineNo;
            GenJournalLine."Account Type" := GenJournalLine."Account Type"::Customer;
            GenJournalLine."Account No." := DividendLines."Member No";
            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine."Document No." := Rec."Document No";
            GenJournalLine."Posting Date" := Rec."Posting date";
            GenJournalLine.Description := loanCode + '-Loan Repayment';
            GenJournalLine.Amount := PrincipalAmount * -1;
            GenJournalLine.Validate(GenJournalLine.Amount);
            GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::"Loan Repayment";
            GenJournalLine."Loan No" := loanNumber;
            GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
            GenJournalLine."Shortcut Dimension 2 Code" := FnGetMemberBranch(DividendLines."Member No");
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
            GenJournalLine.Insert();
        end;

        // Mark the installment as Paid after successful posting
        LoanRepS.Reset();
        LoanRepS.SetRange("Loan No.", loanNumber);
        LoanRepS.SetRange("Member No.", DividendLines."Member No");
        LoanRepS.SetRange(Paid, false);
        // LoanRepS.SetFilter("Repayment Date", '..%1', Rec."Loan CutOff Date");
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

    local procedure FnTransferExcessToUnallocatedFunds(DividendLines: Record "Dividends Lines"; RunningBalance: Decimal; description: Code[50])
    var
        ObjMember: Record Customer;
    begin
        ObjMember.Reset;
        ObjMember.SetRange(ObjMember."No.", DividendLines."Member No");
        if ObjMember.Find('-') then begin
            LineNo := LineNo + 10000;
            GenJournalLine.Init;
            GenJournalLine."Journal Template Name" := BATCH_TEMPLATE;
            GenJournalLine."Journal Batch Name" := BATCH_NAME;
            GenJournalLine."Line No." := LineNo;
            GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
            GenJournalLine."Account No." := DividendLines."Member No";
            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine."Document No." := Rec."Document No";
            GenJournalLine."Posting Date" := Rec."Posting date";
            GenJournalLine.Description := description;
            GenJournalLine.Amount := RunningBalance * -1;
            GenJournalLine.Validate(GenJournalLine.Amount);
            GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Unallocated Funds";
            GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
            GenJournalLine."Shortcut Dimension 2 Code" := ObjMember."Global Dimension 2 Code";
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
            if GenJournalLine.Amount <> 0 then
                GenJournalLine.Insert;
        end;
    end;


    procedure PostDividends(HeaderNo: Code[20]; SettlementDate: Date; DividendYear: Integer; DocumentNo: Code[20])
    var
        DivHeader: Record "Dividends Header";
        DivLine: Record "Dividends Lines";
        TotalGrossDividends: Decimal;
        TotalGrossInterest: Decimal;
        YearEndDate: Date;
    begin
        GenSetUp.Get();
        GenSetUp.TestField("Dividend Payable Account");
        GenSetUp.TestField("WithHolding Tax Account");
        GenSetUp.TestField("Dividends Paying Bank Account");
        GenSetUp.TestField("Dividend Expense Account");
        GenSetUp.TestField("Interest Expense Account");
        GenSetUp.TestField("Unclaimed Dividends Account");

        YearEndDate := DMY2Date(31, 12, DividendYear);


        TotalGrossDividends := 0;
        TotalGrossInterest := 0;

        DivLine.Reset();
        DivLine.SetRange("No", HeaderNo);
        if DivLine.FindSet() then begin
            repeat
                TotalGrossDividends += DivLine."Dividends on Shares";
                TotalGrossInterest += DivLine."Interest on Deposits";
            until DivLine.Next() = 0;
        end;


        // Debit Dividend Expense 
        LineNo += 10000;
        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DocumentNo, LineNo, GenJournalLine."transaction type"::" ", GenJournalLine."account type"::"G/L Account",
            GenSetUp."Dividend Expense Account", YearEndDate, TotalGrossDividends, 'BOSA', DocumentNo, 'Dividend Expense - ' + Format(DividendYear), '');

        // Debit Interest Exp
        LineNo += 10000;
        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DocumentNo, LineNo, GenJournalLine."transaction type"::" ", GenJournalLine."account type"::"G/L Account",
            GenSetUp."Interest Expense Account", YearEndDate, TotalGrossInterest, 'BOSA', DocumentNo, 'Interest on Deposits Expense - ' + Format(DividendYear), '');


        DivLine.Reset();
        DivLine.SetRange("No", HeaderNo);
        if DivLine.FindSet() then begin
            repeat
                if DivLine."Net Pay" > 0 then begin
                    if DivLine."Net Pay" > 0 then begin
                        FnInsertMemberContributionLastYear(BATCH_TEMPLATE, BATCH_NAME, DivLine."Member No", Rec."Document No",
                        'Dividend Payable ' + DivLine."Member Name", DivLine."Net Pay", GenJournalLine."Transaction Type"::Dividend, YearEndDate);
                    end;


                    // CREDIT: Dividend Pay
                    // if DivLine."Net Pay" > 0 then begin
                    //     LineNo += 10000;
                    //     SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DocumentNo, LineNo, GenJournalLine."transaction type"::" ", GenJournalLine."account type"::"G/L Account",
                    //         GenSetUp."Dividend Payable Account", YearEndDate, DivLine."Net Pay" * -1, 'BOSA', DocumentNo, 'Dividend Payable - ' + DivLine."Member Name", '');
                    // end;

                    // CREDIT: Withholding Tax GL (per member)
                    if DivLine."Withholding Tax(Share&Depo)" > 0 then begin
                        LineNo += 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DocumentNo, LineNo, GenJournalLine."transaction type"::" ", GenJournalLine."account type"::"G/L Account",
                            GenSetUp."WithHolding Tax Account", YearEndDate, DivLine."Withholding Tax(Share&Depo)" * -1, 'BOSA', DocumentNo, 'WHT - ' + DivLine."Member Name", '');
                    end;

                end;
            until DivLine.Next() = 0;
        end;

        //Posting New year
        DivLine.Reset();
        DivLine.SetRange("No", HeaderNo);
        if DivLine.FindSet() then begin
            repeat
                if DivLine."Net Pay" > 0 then begin

                    // DEBIT: 
                    LineNo += 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DocumentNo, LineNo, GenJournalLine."transaction type"::" ", GenJournalLine."account type"::"G/L Account",
                        GenSetUp."Dividend Payable Account", SettlementDate, DivLine."Net Pay", 'BOSA', DocumentNo, 'Provision Div Payable - ' + DivLine."Member Name", '');
                    // CREDIT: Bank GL 
                    if DivLine."Net After Deduction" > 0 then begin
                        LineNo += 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DocumentNo, LineNo, GenJournalLine."transaction type"::" ", GenJournalLine."account type"::"Bank Account",
                            GenSetUp."Dividends Paying Bank Account", SettlementDate, DivLine."Net After Deduction" * -1, 'BOSA', DocumentNo, 'Net Pay to Bank - ' + DivLine."Member Name", '');
                    end;
                    // Credit: Unclaimed Dividends GL
                    // if DivLine."Unclaimed Dividends" > 0 then begin
                    //     LineNo += 10000;
                    //     SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DocumentNo, LineNo, GenJournalLine."transaction type"::" ", GenJournalLine."account type"::"G/L Account",
                    //         GenSetUp."Unclaimed Dividends Account", SettlementDate, DivLine."Unclaimed Dividends" * -1, 'BOSA', DocumentNo, 'Unclaimed Dividends - ' + DivLine."Member Name", '');
                    // end;
                    if DivLine."Unclaimed Dividends" > 0 then begin
                        LineNo += 10000;
                        FnInsertMemberContribution(BATCH_TEMPLATE, BATCH_NAME, DivLine."Member No", Rec."Document No", 'Unclaimed Dividends ' + DivLine."Member Name", DivLine."Unclaimed Dividends",
                      GenJournalLine."Transaction Type"::"Unclaimed Dividends")
                    end;


                end;
            until DivLine.Next() = 0;
        end;

    end;

    local procedure FnInsertMemberContributionLastYear(Jtemplate: Code[30]; Jbatch: code[30]; memberNo: Code[15]; documentNo: code[30];
transDescription: Code[35]; transAmount: Decimal; TransactionType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Unclaimed Dividends","Benevolent Fund",Loan,"Unallocated Funds","Holiday Savings","Sales of T-Shirt","Other Products",Dividend,"FOSA Account"; PostingDate: Date): Code[50]
    begin
        LineNo := LineNo + 10000;
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := Jtemplate;
        GenJournalLine."Journal Batch Name" := Jbatch;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := GenJournalLine."bal. account type"::Customer;
        GenJournalLine."Account No." := memberNo;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Document No." := documentNo;
        GenJournalLine."Posting Date" := PostingDate;
        GenJournalLine.Description := transDescription;
        GenJournalLine.Amount := transAmount * -1;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Transaction Type" := TransactionType;
        GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
        GenJournalLine."Shortcut Dimension 2 Code" := FnGetMemberBranch(memberNo);
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert();
    end;

    var
        Cust: Record Customer;
        LoanRepS: Record "Loan Repayment Schedule";
        IsEditable: Boolean;
        GenSetUp: Record "Sacco General Set-Up";
        GenJournalLine: Record "Gen. Journal Line";
        SFactory: Codeunit "SWIZZSFT Factory";
        LineNo: Integer;
        BATCH_TEMPLATE: Code[50];
        BATCH_NAME: Code[40];
        LoanProductSetup: Record "Loan Products Setup";
        DividendsLines: Record "Dividends Lines";
        LoanApp: Record "Loans Register";

    trigger OnAfterGetRecord()
    begin
        IsEditable := not Rec.Posted;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        IsEditable := not Rec.Posted;
    end;
}
