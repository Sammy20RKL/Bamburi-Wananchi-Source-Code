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
    transDescription: Code[35]; transAmount: Decimal; TransactionType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds","Sales of T-Shirt","Other Products",Dividend,"FOSA Account"): Code[50]
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
        if DividendsLines."X-Mas Loan" > 0 then begin
            loanNumber := fnGetLoanNumber(DividendsLines, DividendsLines."X-Mas Loan", Rec."Posting Date", 'X-MAS');
            if loanNumber <> '' then begin
                FnPostDistributedLoan(DividendsLines, loanNumber, DividendsLines."X-Mas interest", DividendsLines."X-Mas Loan", 'X-MAS');
            end else begin
                FnTransferExcessToUnallocatedFunds(DividendsLines, DividendsLines."X-Mas Loan", 'Excess Payments for X-Mas Loan');
            end;
        end;

    end;

    local procedure fnGetLoanNumber(DividendsLines: Record "Dividends Lines"; RunningBalance: Decimal; LoanCutoffDate: Date; loanCode: Code[10]) loanNumber: Code[50]
    begin
        loanNumber := '';
        LoanApp.Reset;
        LoanApp.SetRange(LoanApp."Client Code", DividendsLines."Member No");
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
            LoanApp.SetRange(LoanApp."Client Code", DividendsLines."Member No");
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
                if DivLine."Earned Amount" > 0 then begin

                    // CREDIT: Dividend Pay
                    if DivLine."Net Pay" > 0 then begin
                        LineNo += 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DocumentNo, LineNo, GenJournalLine."transaction type"::Dividend, GenJournalLine."account type"::"G/L Account",
                            GenSetUp."Dividend Payable Account", YearEndDate, DivLine."Net Pay" * -1, 'BOSA', DocumentNo, 'Dividend Payable - ' + DivLine."Member Name", '');
                    end;



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



                    // CREDIT: Others -- not specified 
                    if DivLine."To Others" > 0 then begin
                        LineNo += 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DocumentNo, LineNo, GenJournalLine."transaction type"::" ", GenJournalLine."account type"::"G/L Account",
                            GenSetUp."Interest Payable Account", SettlementDate, DivLine."To Others" * -1, 'BOSA', DocumentNo, 'Others - ' + DivLine."Member Name", '');
                    end;

                    // CREDIT: Bank GL 
                    if DividendsLines."Net After Deduction" > 0 then begin
                        LineNo += 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DocumentNo, LineNo, GenJournalLine."transaction type"::" ", GenJournalLine."account type"::"Bank Account",
                            GenSetUp."Dividends Paying Bank Account", SettlementDate, DivLine."Net After Deduction" * -1, 'BOSA', DocumentNo, 'Net Pay to Bank - ' + DivLine."Member Name", '');
                    end;

                end;
            until DivLine.Next() = 0;
        end;




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
