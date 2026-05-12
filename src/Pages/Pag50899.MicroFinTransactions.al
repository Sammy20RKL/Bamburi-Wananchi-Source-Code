#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50899 "Micro_Fin_Transactions"
{
    Caption = 'Micro_Fin_Receipts';
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = 51895;
    SourceTableView = where(Posted = const(false));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Group Code"; Rec."Group Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Group Account No.';
                }
                field("Group Name"; Rec."Group Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Micro Officer"; Rec."Micro Officer")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Teller No.';
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Teller Account Name';
                }
                field("Payment Description"; Rec."Payment Description")
                {
                    ApplicationArea = Basic;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Transaction Time"; Rec."Transaction Time")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = Basic;
                }
                field("Captured By"; Rec."Captured By")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Group Meeting Day"; Rec."Group Meeting Day")
                {
                    ApplicationArea = Basic;
                }
                field(Balance; Rec.Balance)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Total Repayment"; Rec."Total Repayment")
                {
                    ApplicationArea = Basic;
                }
                field("Total Savings"; Rec."Total Savings")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Total Penalty"; Rec."Total Penalty")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Total Principle"; Rec."Total Principle")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Total Interest"; Rec."Total Interest")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Total Excess"; Rec."Total Excess")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Activity Code"; Rec."Activity Code")
                {
                    ApplicationArea = Basic;
                }
                field("Branch Code"; Rec."Branch Code")
                {
                    ApplicationArea = Basic;
                }
            }
            part(Control1102755013; Micro_Fin_Schedule)
            {
                Caption = 'Receipts Allocation Schedule';
                SubPageLink = "No." = field("No.");
            }
        }
    }

    actions
    {
        area(creation)
        {
            group(ActionGroup1102755015)
            {
                action(Post)
                {
                    ApplicationArea = Basic;
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin

                        Rec.TestField("Account No");
                        Rec.TestField("Payment Description");

                        if Rec.Posted then
                            Error(Text008, Rec."No.");

                        if Rec.Amount = 0 then
                            Error(Text002, Rec."No.", Rec.Amount);

                        Rec.CalcFields("Total Amount");

                        if Rec."Total Amount" <> Rec.Amount then begin
                            Error(Text005);
                        end;

                        DistributedAmt := 0;

                        Temp.Get(UserId);



                        Jtemplate := 'GENERAL';
                        JBatch := 'MCTRANS';
                        if Jtemplate = '' then begin
                            Error(Text003)
                        end;
                        if JBatch = '' then begin
                            Error(Text004)
                        end;

                        if Confirm(Text006) = true then begin

                            //Start Of Deletion
                            GenJournalLine.Reset;
                            GenJournalLine.SetRange("Journal Template Name", Jtemplate);
                            GenJournalLine.SetRange("Journal Batch Name", JBatch);
                            GenJournalLine.DeleteAll;
                            //End of deletion

                            DefaultBatch.Reset;
                            DefaultBatch.SetRange(DefaultBatch."Journal Template Name", Jtemplate);
                            DefaultBatch.SetRange(DefaultBatch.Name, JBatch);
                            if DefaultBatch.Find('-') = false then begin
                                DefaultBatch.Init;
                                DefaultBatch."Journal Template Name" := Jtemplate;
                                DefaultBatch.Name := JBatch;
                                DefaultBatch.Description := Text007;
                                DefaultBatch.Validate(DefaultBatch."Journal Template Name");
                                DefaultBatch.Validate(DefaultBatch.Name);
                                DefaultBatch.Insert;
                            end;


                            LineNo := LineNo + 10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := Jtemplate;
                            GenJournalLine."Journal Batch Name" := JBatch;
                            GenJournalLine."Document No." := Rec."No.";
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Group Code" := Rec."Group Code";
                            GenJournalLine."Account Type" := Rec."Account Type";
                            GenJournalLine."Account No." := Rec."Account No";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Posting Date" := Rec."Transaction Date";
                            GenJournalLine.Description := Rec."Payment Description";
                            GenJournalLine.Amount := Rec.Amount;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Loan No" := Transact."Loan No.";
                            GenJournalLine."Shortcut Dimension 1 Code" := Rec."Activity Code";
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine."Shortcut Dimension 2 Code" := Rec."Branch Code";
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;

                            DistributedAmt := Rec.Amount;

                            Transact.Reset;
                            Transact.SetRange(Transact."No.", Rec."No.");
                            if Transact.Find('-') then begin
                                repeat

                                    //************************Registration Fee*****************
                                    if DistributedAmt > 0 then begin
                                        if Transact."Registration Fee" > 0 then begin
                                            LineNo := LineNo + 10000;
                                            GenJournalLine.Init;
                                            GenJournalLine."Journal Template Name" := Jtemplate;
                                            GenJournalLine."Journal Batch Name" := JBatch;
                                            GenJournalLine."Document No." := Rec."No.";
                                            GenJournalLine."Line No." := LineNo;
                                            GenJournalLine."Group Code" := Transact."Group Code";
                                            GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                                            GenJournalLine."Account No." := Transact."Account Number";
                                            GenJournalLine.Validate(GenJournalLine."Account No.");
                                            GenJournalLine."Posting Date" := Rec."Transaction Date";
                                            GenJournalLine.Description := Rec."Payment Description";
                                            GenJournalLine.Amount := -Transact."Registration Fee";
                                            GenJournalLine.Validate(GenJournalLine.Amount);
                                            GenJournalLine."Loan No" := Transact."Loan No.";
                                            GenJournalLine."Shortcut Dimension 1 Code" := Rec."Activity Code";
                                            GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Registration Fee";//Kamwana
                                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                            GenJournalLine."Shortcut Dimension 2 Code" := Rec."Branch Code";
                                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                            if GenJournalLine.Amount <> 0 then
                                                GenJournalLine.Insert;
                                            DistributedAmt := DistributedAmt - (GenJournalLine.Amount * -1)
                                        end;
                                    end;

                                    //............. INTEREST RECOVERY ................

                                    if Transact."Interest Amount" > 0 then begin
                                        GenJournalLine.Init;
                                        LineNo := LineNo + 10000;
                                        GenJournalLine."Journal Template Name" := Jtemplate;
                                        GenJournalLine."Journal Batch Name" := JBatch;

                                        GenJournalLine."Document No." := Rec."No.";
                                        GenJournalLine."Line No." := LineNo;
                                        GenJournalLine."Group Code" := Transact."Group Code";
                                        GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
                                        GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                                        GenJournalLine."Account No." := Transact."Account Number";
                                        GenJournalLine.Validate(GenJournalLine."Account No.");
                                        GenJournalLine."Posting Date" := Rec."Transaction Date";
                                        GenJournalLine.Description := Rec."Payment Description";
                                        if DistributedAmt > Transact."Interest Amount" then begin
                                            GenJournalLine.Amount := -Transact."Interest Amount";
                                        end else begin
                                            GenJournalLine.Amount := -DistributedAmt;
                                        end;
                                        GenJournalLine.Validate(GenJournalLine.Amount);
                                        GenJournalLine."Loan No" := Transact."Loans No.";
                                        GenJournalLine."Shortcut Dimension 1 Code" := Rec."Activity Code";
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                        GenJournalLine."Shortcut Dimension 2 Code" := Rec."Branch Code";
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                        if GenJournalLine.Amount <> 0 then
                                            GenJournalLine.Insert;
                                        DistributedAmt := DistributedAmt - (GenJournalLine.Amount * -1)
                                    end;

                                    //++++++++++  Savings RECOVERY +++++++++++++++++++

                                    if DistributedAmt > 0 then begin
                                        if Transact."Deposits Contribution" > 0 then begin
                                            LineNo := LineNo + 10000;
                                            GenJournalLine.Init;
                                            GenJournalLine."Journal Template Name" := Jtemplate;
                                            GenJournalLine."Journal Batch Name" := JBatch;

                                            GenJournalLine."Document No." := Rec."No.";
                                            GenJournalLine."Line No." := LineNo;
                                            GenJournalLine."Group Code" := Transact."Group Code";
                                            GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                                            GenJournalLine."Account No." := Transact."Account Number";
                                            GenJournalLine.Validate(GenJournalLine."Account No.");
                                            GenJournalLine."Posting Date" := Rec."Transaction Date";
                                            GenJournalLine.Description := Rec."Payment Description";
                                            GenJournalLine.Amount := -Transact."Deposits Contribution";
                                            GenJournalLine.Validate(GenJournalLine.Amount);
                                            GenJournalLine."Loan No" := Transact."Loan No.";
                                            GenJournalLine."Shortcut Dimension 1 Code" := Rec."Activity Code";
                                            GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Deposit Contribution";//Kamwana
                                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                            GenJournalLine."Shortcut Dimension 2 Code" := Rec."Branch Code";
                                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                            if GenJournalLine.Amount <> 0 then
                                                GenJournalLine.Insert;
                                            DistributedAmt := DistributedAmt - (GenJournalLine.Amount * -1)
                                        end;
                                    end;

                                    //*****************************Shares Recovery*****************
                                    if DistributedAmt > 0 then begin
                                        if Transact."Share Capital" > 0 then begin
                                            LineNo := LineNo + 10000;
                                            GenJournalLine.Init;
                                            GenJournalLine."Journal Template Name" := Jtemplate;
                                            GenJournalLine."Journal Batch Name" := JBatch;
                                            GenJournalLine."Document No." := Rec."No.";
                                            GenJournalLine."Line No." := LineNo;
                                            GenJournalLine."Group Code" := Transact."Group Code";
                                            GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                                            GenJournalLine."Account No." := Transact."Account Number";
                                            GenJournalLine.Validate(GenJournalLine."Account No.");
                                            GenJournalLine."Posting Date" := Rec."Transaction Date";
                                            GenJournalLine.Description := Rec."Payment Description";
                                            GenJournalLine.Amount := -Transact."Share Capital";
                                            GenJournalLine.Validate(GenJournalLine.Amount);
                                            GenJournalLine."Loan No" := Transact."Loan No.";
                                            GenJournalLine."Shortcut Dimension 1 Code" := Rec."Activity Code";
                                            GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::"Share Capital";//Kamwana
                                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                            GenJournalLine."Shortcut Dimension 2 Code" := Rec."Branch Code";
                                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                            if GenJournalLine.Amount <> 0 then
                                                GenJournalLine.Insert;
                                            DistributedAmt := DistributedAmt - (GenJournalLine.Amount * -1)
                                        end;
                                    end;

                                    //+++++++  Principle. RECOVERY +++++++++++++++
                                    if DistributedAmt > 0 then begin

                                        if Transact."Principle Amount" > 0 then begin

                                            LineNo := LineNo + 10000;
                                            GenJournalLine.Init;
                                            GenJournalLine."Journal Template Name" := Jtemplate;
                                            GenJournalLine."Journal Batch Name" := JBatch;

                                            GenJournalLine."Document No." := Rec."No.";
                                            GenJournalLine."Line No." := LineNo;
                                            GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Loan Repayment";
                                            GenJournalLine."Group Code" := Transact."Group Code";
                                            GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                                            GenJournalLine."Account No." := Transact."Account Number";
                                            GenJournalLine.Validate(GenJournalLine."Account No.");
                                            GenJournalLine."Posting Date" := Rec."Transaction Date";
                                            GenJournalLine.Description := Rec."Payment Description";
                                            GenJournalLine.Amount := -Transact."Principle Amount";
                                            GenJournalLine.Validate(GenJournalLine.Amount);
                                            GenJournalLine."Loan No" := Transact."Loans No.";
                                            GenJournalLine."Shortcut Dimension 1 Code" := Rec."Activity Code";//"Payment Description";
                                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                            GenJournalLine."Shortcut Dimension 2 Code" := Rec."Branch Code";
                                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                            if GenJournalLine.Amount <> 0 then
                                                GenJournalLine.Insert;
                                            DistributedAmt := DistributedAmt - (GenJournalLine.Amount * -1)
                                        end;
                                    end;

                                    if DistributedAmt > 0 then begin

                                        if Transact."Principle Amount" > 0 then begin

                                            LineNo := LineNo + 10000;
                                            GenJournalLine.Init;
                                            GenJournalLine."Journal Template Name" := Jtemplate;
                                            GenJournalLine."Journal Batch Name" := JBatch;

                                            GenJournalLine."Document No." := Rec."No.";
                                            GenJournalLine."Line No." := LineNo;
                                            GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
                                            GenJournalLine."Group Code" := Transact."Group Code";
                                            GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                                            GenJournalLine."Account No." := Transact."Account Number";
                                            GenJournalLine.Validate(GenJournalLine."Account No.");
                                            GenJournalLine."Posting Date" := Rec."Transaction Date";
                                            GenJournalLine.Description := Rec."Payment Description";
                                            GenJournalLine.Amount := Transact."Principle Amount" * -1;
                                            GenJournalLine.Validate(GenJournalLine.Amount);
                                            GenJournalLine."Loan No" := Transact."Loans No.";
                                            GenJournalLine."Shortcut Dimension 1 Code" := Rec."Activity Code";
                                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                            GenJournalLine."Shortcut Dimension 2 Code" := Rec."Branch Code";
                                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                            //IF GenJournalLine.Amount<>0 THEN
                                            //GenJournalLine.INSERT;

                                        end;
                                    end;

                                until Transact.Next = 0;
                            end;

                            DistributedAmt := DistributedAmt - (GenJournalLine.Amount * -1);

                            if DistributedAmt > 0 then begin

                                LoanApp.Reset;
                                LoanApp.SetRange(LoanApp."Client Code", Transact."Account Number");
                                LoanApp.SetRange(LoanApp.Posted, true);
                                if LoanApp.Find('-') then begin

                                    LoanApp.CalcFields(LoanApp."Outstanding Balance");

                                    if LoanApp."Outstanding Balance" > 0 then begin

                                        LineNo := LineNo + 10000;
                                        GenJournalLine.Init;
                                        GenJournalLine."Journal Template Name" := Jtemplate;
                                        GenJournalLine."Journal Batch Name" := JBatch;

                                        GenJournalLine."Document No." := Rec."No.";
                                        GenJournalLine."Line No." := LineNo;
                                        GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
                                        GenJournalLine."Group Code" := Transact."Group Code";
                                        GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                                        GenJournalLine."Account No." := Transact."Account Number";
                                        GenJournalLine.Validate(GenJournalLine."Account No.");

                                        GenJournalLine."Posting Date" := Rec."Transaction Date";
                                        GenJournalLine.Description := 'Excess from-' + LoanApp."Loan  No.";

                                        if LoanApp."Outstanding Balance" > DistributedAmt then
                                            GenJournalLine.Amount := DistributedAmt * -1
                                        else
                                            GenJournalLine.Amount := LoanApp."Outstanding Balance" * -1;

                                        GenJournalLine.Validate(GenJournalLine.Amount);
                                        GenJournalLine."Loan No" := Transact."Loans No.";
                                        GenJournalLine."Shortcut Dimension 1 Code" := Rec."Activity Code";
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                        GenJournalLine."Shortcut Dimension 2 Code" := Rec."Branch Code";
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                        if GenJournalLine.Amount <> 0 then
                                            GenJournalLine.Insert;

                                    end;
                                end;
                            end;

                            DistributedAmt := DistributedAmt - (GenJournalLine.Amount * -1);


                            //Shares

                            if DistributedAmt > 0 then begin
                                if Transact."Share Capital" > 0 then begin

                                    LineNo := LineNo + 10000;
                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := Jtemplate;
                                    GenJournalLine."Journal Batch Name" := JBatch;
                                    GenJournalLine."Document No." := Rec."No.";
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::"Share Capital";
                                    GenJournalLine."Group Code" := Transact."Group Code";
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                                    GenJournalLine."Account No." := Transact."Account Number";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Posting Date" := Rec."Transaction Date";
                                    GenJournalLine.Description := 'Shares-' + Transact."Account Number";
                                    GenJournalLine.Amount := -Transact."Share Capital";
                                    ;
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Shortcut Dimension 1 Code" := Rec."Activity Code";
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine."Shortcut Dimension 2 Code" := Rec."Branch Code";
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;
                                end;
                            end;


                            GenJournalLine.Reset;
                            GenJournalLine.SetRange(GenJournalLine."Journal Template Name", Jtemplate);
                            GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", JBatch);
                            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Batch", GenJournalLine);

                            GensetUp.Get();
                            MicrSchedule.Reset;
                            MicrSchedule.SetRange(MicrSchedule."No.", Rec."No.");
                            if MicrSchedule.Find('-') then begin
                                repeat
                                    if MicrSchedule.Savings <> 0 then begin

                                        CustMember.Reset;
                                        CustMember.SetRange(CustMember."No.", MicrSchedule."Account Number");
                                        if CustMember.FindFirst then begin
                                            CustMember.Status := CustMember.Status::Active;
                                            CustMember.Modify;
                                        end;
                                    end;

                                until MicrSchedule.Next = 0
                            end;
                            if DefaultBatch.Get(Jtemplate, JBatch) then
                                DefaultBatch.Delete;
                            Rec.Posted := true;
                            Rec."Posted By" := UserId;
                            Rec.Modify;

                        end else begin
                            exit;
                        end;
                    end;
                }
                action("Micro Schedule")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin

                        //TESTFIELD(Posted,TRUE);

                        MTrans.Reset;
                        MTrans.SetRange(MTrans."No.", Rec."No.");
                        if MTrans.Find('-') then begin
                            Report.Run(51516850, true, false, MTrans);
                        end;
                    end;
                }
            }
            group(Approvals)
            {
                action(Approval)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approval;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        DocumentType := Documenttype::MicroTrans;
                        ApprovalEntries.SetRecordFilters(Database::Micro_Fin_Transactions, DocumentType, Rec."No.");
                        ApprovalEntries.Run;
                    end;
                }
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Account Type" := Rec."account type"::"Bank Account";
    end;

    trigger OnOpenPage()
    begin
        if Rec.Posted = true then
            CurrPage.Editable := false;
        Rec."Account Type" := Rec."account type"::"Bank Account";
    end;

    var
        GenJournalLine: Record "Gen. Journal Line";
        Transact: Record 51896;
        LineNo: Integer;
        DefaultBatch: Record "Gen. Journal Batch";
        BranchCode: Code[20];
        Bank: Record "Bank Account";
        Group: Code[30];
        MTrans: Record 51895;
        Bcode: Code[20];
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batches,"Payment Voucher","Petty Cash",Requisition,Loan,Interbank,Imprest,Checkoff,"FOSA Account Opening",StandingOrder,HRJob,HRLeave,"HRTransport Request",HRTraining,"HREmp Requsition",MicroTrans;
        DistributedAmt: Decimal;
        MicrSchedule: Record 51896;
        CustMember: Record 51364;
        GensetUp: Record 51398;
        ChangeStatus: Boolean;
        DepDifference: Decimal;
        TotDiff: Decimal;
        Text001: label 'Account type Must be Bank Acount. The current Value is -%1 in transaction No. -%2.';
        Text002: label 'There is nothing to Post in transaction No. -%1. The current amount value is -%2.';
        Temp: Record "Funds User Setup";
        Jtemplate: Code[30];
        JBatch: Code[30];
        Text003: label 'Ensure The Receipt Journal Template is set up in cash Office set up';
        Text004: label 'Ensure The Receipt Journal Batch is set up in cash Office set up';
        Text005: label 'Please note that the Total Amount and the Amount Received Must be the same';
        Text006: label 'ARE YOU SURE YOU WANT TO POST THE RECEIPTS';
        Text007: label 'Loan  Repayment Journal';
        Text008: label 'The transaction No. -%1 is already posted';
        Text009: label 'This Till is No. %1 not assigned to this Specific User. Please contact your system administrator';
        ReceiptAllocations: Record "Receipt Allocation";
        Cust: Record 51364;
        LoanApp: Record 51371;
        LOustanding: Decimal;
}

