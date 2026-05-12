#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 57201 "Guarantors Recovery Header"
{
    PageType = Card;
    SourceTable = "Guarantors Recovery Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic;
                    Editable = MemberNoEditable;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Current Shares"; Rec."Current Shares")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Deposits';
                    Editable = false;
                }
                field("Loan Liabilities"; Rec."Loan Liabilities")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan to Attach"; Rec."Loan to Attach")
                {
                    ApplicationArea = Basic;
                    Editable = LoantoAttachEditable;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Recovery Type"; Rec."Recovery Type")
                {
                    ApplicationArea = Basic;
                    Editable = RecoveryTypeEditable;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Editable = Global1Editable;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = Global2Editable;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            part(Control1000000009; "Guarantors Loan Details")
            {
                Editable = GuarantorLoansDetailsEdit;
                SubPageLink = "Document No" = field("Document No");
            }
        }
    }

    actions
    {
        area(creation)
        {
            group("Function")
            {
                Caption = 'Function';
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approval;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                    end;
                }
                action("Send Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        text001: label 'This batch is already pending approval';
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if Rec.Status <> Rec.Status::Open then
                            Error(text001);


                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel A&pproval Request';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        text001: label 'This batch is already pending approval';
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        if Rec.Status <> Rec.Status::Open then
                            Error(text001);

                        //End allocate batch number
                        //ApprovalMgt.CancelClosureApprovalRequest(Rec);
                    end;
                }
                action("Post Transaction")
                {
                    ApplicationArea = Basic;
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        if Rec."Recovery Type" = Rec."recovery type"::"Recover From Loanee Deposits" then begin
                            FnRecoverFromDeposits();
                        end else
                            if Rec."Recovery Type" = Rec."recovery type"::"Attach Defaulted Loans to Guarantors" then begin
                                FnAttachDefaultedLoans(LoansRec)
                            end else
                                if Rec."Recovery Type" = Rec."recovery type"::"Recover From Guarantors Deposits" then begin
                                    FnRecoverFromGuarantorShares(LoansRec);
                                end;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateControls();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Created By" := UserId;
        Rec."Application Date" := Today;
    end;

    trigger OnOpenPage()
    begin
        //UpdateControls();
    end;

    var
        PayOffDetails: Record "Loans PayOff Details";
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        LoanType: Record "Loan Products Setup";
        LoansRec: Record "Loans Register";
        TotalRecovered: Decimal;
        TotalInsuarance: Decimal;
        DActivity: Code[20];
        DBranch: Code[20];
        GLoanDetails: Record "Guarantors Member Loans";
        TotalOustanding: Decimal;
        ClosingDepositBalance: Decimal;
        RemainingAmount: Decimal;
        LoansR: Record "Loans Register";
        AMOUNTTOBERECOVERED: Decimal;
        PrincipInt: Decimal;
        TotalLoansOut: Decimal;
        Cust: Record Customer;
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        PDate: Date;
        Interest: Decimal;
        GenSetUp: Record "Sacco General Set-Up";
        TextDateFormula2: Text[30];
        TextDateFormula1: Text[30];
        DateFormula2: DateFormula;
        DateFormula1: DateFormula;
        Vend: Record Vendor;
        LoanGuar: Record "Loans Guarantee Details";
        Lbal: Decimal;
        GenLedgerSetup: Record "General Ledger Setup";
        Hesabu: Integer;
        Loanapp: Record "Loans Register";
        "Loan&int": Decimal;
        TotDed: Decimal;
        Available: Decimal;
        Distributed: Decimal;
        WINDOW: Dialog;
        PostingCode: Codeunit "Gen. Jnl.-Post Line";
        SHARES: Decimal;
        TOTALLOANS: Decimal;
        Gnljnline: Record "Gen. Journal Line";
        LineN: Integer;
        instlnclr: Decimal;
        appotbal: Decimal;
        LOANAMOUNT: Decimal;
        PRODATA: Decimal;
        LOANAMOUNT2: Decimal;
        TOTALLOANSB: Decimal;
        NETSHARES: Decimal;
        Tinst: Decimal;
        Finst: Decimal;
        Floans: Decimal;
        GrAmount: Decimal;
        TGrAmount: Decimal;
        FGrAmount: Decimal;
        LOANBAL: Decimal;
        Serie: Integer;
        DLN: Code[10];
        "LN Doc": Code[20];
        INTBAL: Decimal;
        COMM: Decimal;
        loanTypes: Record "Loan Products Setup";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery;
        MemberNoEditable: Boolean;
        RecoveryTypeEditable: Boolean;
        Global1Editable: Boolean;
        Global2Editable: Boolean;
        LoantoAttachEditable: Boolean;
        GuarantorLoansDetailsEdit: Boolean;

    local procedure FnRecoverFromDeposits()
    begin
        if Confirm('Are you absolutely sure you want to recover the loans from member deposit') = false then
            exit;



        //Delete journal line
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
        GenJournalLine.SetRange("Journal Batch Name", 'RECOVERIES');
        GenJournalLine.DeleteAll;
        //End of Deletion

        TotalRecovered := 0;
        TotalInsuarance := 0;

        //IF GLoanDetails.GET("Document No") THEN BEGIN



        DActivity := Rec."Global Dimension 1 Code";
        DBranch := Rec."Global Dimension 2 Code";

        ClosingDepositBalance := (Rec."Current Shares");


        if ClosingDepositBalance > 0 then begin
            RemainingAmount := ClosingDepositBalance;

            LoansR.Reset;
            LoansR.SetRange(LoansR."Client Code", Rec."Member No");
            LoansR.SetRange(LoansR.Source, LoansR.Source::BOSA);
            if LoansR.Find('-') then begin
                repeat
                    //AMOUNTTOBERECOVERED:=0;
                    LoansR.CalcFields(LoansR."Outstanding Balance", LoansR."Oustanding Interest");//, LoansR."Loans Insurance");
                    TotalInsuarance := TotalInsuarance + LoansR."Loans Insurance";
                until LoansR.Next = 0;
            end;

            LoansR.Reset;
            LoansR.SetRange(LoansR."Client Code", Rec."Member No");
            LoansR.SetRange(LoansR.Source, LoansR.Source::BOSA);
            if LoansR.Find('-') then begin
                repeat
                    AMOUNTTOBERECOVERED := 0;
                    LoansR.CalcFields(LoansR."Outstanding Balance", LoansR."Oustanding Interest");//, LoansR."Loans Insurance");

                    //Off Set BOSA Loans
                    //Interest
                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'RECOVERIES';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Document No." := Rec."Document No";
                    GenJournalLine."Posting Date" := Today;
                    GenJournalLine."External Document No." := Rec."Document No";
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                    GenJournalLine."Account No." := Rec."Member No";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine.Description := 'Interest Capitalized: ' + Rec."Document No";
                    GenJournalLine.Amount := -ROUND(LoansR."Oustanding Interest");
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
                    GenJournalLine."Loan No" := LoansR."Loan  No.";
                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                    GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;


                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'RECOVERIES';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Document No." := Rec."Document No";
                    GenJournalLine."Posting Date" := Today;
                    GenJournalLine."External Document No." := Rec."Document No";
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                    GenJournalLine."Account No." := Rec."Member No";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine.Description := 'Interest Capitalized: ' + Rec."Document No";
                    GenJournalLine.Amount := ROUND(LoansR."Oustanding Interest");
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Loan;
                    GenJournalLine."Loan No" := LoansR."Loan  No.";
                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                    GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;

                    PrincipInt := 0;
                    TotalLoansOut := 0;
                    ClosingDepositBalance := (Rec."Current Shares");

                    if RemainingAmount > 0 then begin
                        PrincipInt := (LoansR."Outstanding Balance" + LoansR."Oustanding Interest");
                        TotalLoansOut := (GLoanDetails."Outstanding Balance" + GLoanDetails."Outstanding Interest");

                        //Principle
                        LineNo := LineNo + 10000;
                        //AMOUNTTOBERECOVERED:=ROUND(((LoansR."Outstanding Balance"+LoansR."Oustanding Interest")/("Outstanding Balance"+"Outstanding Interest")))*ClosingDepositBalance;
                        AMOUNTTOBERECOVERED := ROUND((PrincipInt / Rec."Loan Liabilities") * ClosingDepositBalance, 0.01, '=');
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'GENERAL';
                        GenJournalLine."Journal Batch Name" := 'RECOVERIES';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Document No." := Rec."Document No";
                        GenJournalLine."Posting Date" := Today;
                        GenJournalLine."External Document No." := Rec."Document No";
                        GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                        GenJournalLine."Account No." := Rec."Member No";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine.Description := 'Loan Against Deposits: ' + Rec."Document No";
                        if AMOUNTTOBERECOVERED > (LoansR."Outstanding Balance" + LoansR."Oustanding Interest") then begin
                            if RemainingAmount > (LoansR."Outstanding Balance" + LoansR."Oustanding Interest") then begin
                                GenJournalLine.Amount := -ROUND(LoansR."Outstanding Balance" + LoansR."Oustanding Interest");
                            end else begin
                                GenJournalLine.Amount := -RemainingAmount;

                            end;

                        end else begin
                            if RemainingAmount > AMOUNTTOBERECOVERED then begin
                                GenJournalLine.Amount := -AMOUNTTOBERECOVERED;
                            end else begin
                                GenJournalLine.Amount := -RemainingAmount;
                            end;
                        end;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Loan Repayment";
                        GenJournalLine."Loan No" := LoansR."Loan  No.";
                        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;
                        RemainingAmount := RemainingAmount + GenJournalLine.Amount;

                        TotalRecovered := TotalRecovered + ((GenJournalLine.Amount));

                    end;




                until LoansR.Next = 0;
            end;
        end;
        //Deposit
        LineNo := LineNo + 10000;
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := 'GENERAL';
        GenJournalLine."Journal Batch Name" := 'RECOVERIES';
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Document No." := Rec."Document No";
        GenJournalLine."Posting Date" := Today;
        GenJournalLine."External Document No." := Rec."Document No";
        GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
        GenJournalLine."Account No." := Rec."Member No";
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine.Description := 'Defaulted Loans Against Deposits';
        GenJournalLine.Amount := (TotalRecovered) * -1;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Deposit Contribution";
        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;


        if Cust.Get(Rec."Member No") then begin
            Cust."Defaulted Loans Recovered" := true;
            Cust.Modify;
        end;

        //Post New
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
        GenJournalLine.SetRange("Journal Batch Name", 'Recoveries');
        if GenJournalLine.Find('-') then begin
            //Codeunit.Run(Codeunit::"Gen. Jnl.-Post Batch", GenJournalLine);
            page.Run(Page::"General Journal", GenJournalLine);
        end;

        //END;

        Message('Loan recovery from Deposits posted successfully.');
    end;

    local procedure FnAttachDefaultedLoans(LoanRec: Record "Loans Register")
    var
        LoanNo: Code[20];
    begin
        TGrAmount := 0;
        GrAmount := 0;
        FGrAmount := 0;

        //LoanGuar.RESET;
        //LoanGuar.SETRANGE(LoanGuar."Loan No","Loan to Attach");

        LoanGuar.Reset;
        LoanGuar.SetRange(LoanGuar."Loan No", Rec."Loan to Attach");
        if LoanGuar.Find('-') then begin
            repeat
                TGrAmount := TGrAmount + GrAmount;
                GrAmount := LoanGuar."Amont Guaranteed";
                FGrAmount := TGrAmount + LoanGuar."Amont Guaranteed";
            until LoanGuar.Next = 0;
        end;



        //Delete journal line
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
        GenJournalLine.SetRange("Journal Batch Name", 'LNAttach');
        GenJournalLine.DeleteAll;
        //End of Deletion



        if LoansRec.Get(Rec."Loan to Attach") then begin
            //Defaulter loan clear
            LoansRec.CalcFields(LoansRec."Outstanding Balance", LoansRec."Interest Due");
            Lbal := ROUND(LoansRec."Outstanding Balance", 1, '=');
            if LoansRec."Oustanding Interest" > 0 then begin
                INTBAL := ROUND(LoansRec."Oustanding Interest", 1, '=');
                COMM := ROUND((LoansRec."Oustanding Interest" * 0.5), 1, '=');
                LoansRec."Attached Amount" := Lbal;
                LoansRec.PenaltyAttached := COMM;
                LoansRec.InDueAttached := INTBAL;
                Rec.Modify;
            end;


            LoansRec.Attached := true;
            Message('BALANCE %1', Lbal);
            GenJournalLine."Line No." := GenJournalLine."Line No." + 1000;
            GenJournalLine.Init;
            GenJournalLine."Journal Template Name" := 'GENERAL';
            GenJournalLine."Journal Batch Name" := 'LNattach';
            GenJournalLine."Document No." := LoansRec."Loan  No.";
            GenJournalLine."External Document No." := Loanapp."Loan  No.";
            GenJournalLine."Line No." := GenJournalLine."Line No." + 900;
            GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Loan Repayment";
            GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
            GenJournalLine."Account No." := Rec."Member No";
            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine."Posting Date" := Today;
            GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
            GenJournalLine.Description := 'Def Loan' + Rec."Member No";
            GenJournalLine.Amount := -Lbal;
            GenJournalLine.Validate(GenJournalLine.Amount);
            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
            GenJournalLine."Loan No" := LoansRec."Loan  No.";
            if GenJournalLine.Amount <> 0 then
                GenJournalLine.Insert;


            "LN Doc" := LoansRec."Loan  No.";
            // int due
            GenJournalLine."Line No." := GenJournalLine."Line No." + 1000;
            GenJournalLine.Init;
            GenJournalLine."Journal Template Name" := 'GENERAL';
            GenJournalLine."Journal Batch Name" := 'LNattach';
            GenJournalLine."Document No." := LoansRec."Loan  No.";
            GenJournalLine."External Document No." := Loanapp."Loan  No.";
            GenJournalLine."Line No." := GenJournalLine."Line No." + 900;
            GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
            GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
            GenJournalLine."Account No." := Rec."Member No";
            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine."Posting Date" := Today;
            GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
            //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
            GenJournalLine.Description := 'Defaulted Loan int' + ' ';
            GenJournalLine.Amount := -INTBAL;
            GenJournalLine.Validate(GenJournalLine.Amount);
            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
            GenJournalLine."Loan No" := LoansRec."Loan  No.";
            if GenJournalLine.Amount <> 0 then
                GenJournalLine.Insert;

            //commisision
            GenSetUp.Get();

            GenJournalLine."Line No." := GenJournalLine."Line No." + 1000;
            GenJournalLine.Init;
            GenJournalLine."Journal Template Name" := 'GENERAL';
            GenJournalLine."Journal Batch Name" := 'LNattach';
            GenJournalLine."Document No." := LoansRec."Loan  No.";
            GenJournalLine."External Document No." := Loanapp."Loan  No.";
            GenJournalLine."Line No." := GenJournalLine."Line No." + 900;
            GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
            GenJournalLine."Account No." := GenSetUp."Loan Attachment Comm. Account";
            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine."Posting Date" := Today;
            GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
            GenJournalLine.Description := 'Penalty' + ' ';
            GenJournalLine.Amount := -COMM;
            GenJournalLine.Validate(GenJournalLine.Amount);
            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
            GenJournalLine."Loan No" := LoansRec."Loan  No.";
            if GenJournalLine.Amount <> 0 then
                GenJournalLine.Insert;




            LoanGuar.Reset;
            LoanGuar.SetRange(LoanGuar."Loan No", LoansRec."Loan  No.");
            if LoanGuar.Find('-') then begin
                LoanGuar.Reset;
                LoanGuar.SetRange(LoanGuar."Loan No", LoansRec."Loan  No.");
                DLN := 'DLN';
                repeat
                    LoansRec.Reset;
                    LoansRec.SetRange(LoansRec."Client Code", LoanGuar."Member No");
                    LoansRec.SetRange(LoansRec."Loan Product Type", 'DEFAULTER');
                    if LoansRec.Find('-') then begin
                        LoansRec.CalcFields(LoansRec."Outstanding Balance");
                        if LoansRec."Outstanding Balance" = 0 then
                            LoansRec.DeleteAll;
                    end;

                    GenSetUp.Get();
                    GenSetUp."Defaulter LN" := GenSetUp."Defaulter LN" + 10;
                    GenSetUp.Modify;
                    DLN := 'DLN_' + Format(GenSetUp."Defaulter LN");
                    TGrAmount := TGrAmount + GrAmount;
                    GrAmount := LoanGuar."Amont Guaranteed";
                    Message('Guarnteed Amount %1', FGrAmount);

                    ////Insert Journal Lines
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'LNattach';
                    GenJournalLine."Document No." := "LN Doc";
                    GenJournalLine."External Document No." := "LN Doc";
                    GenJournalLine."Line No." := GenJournalLine."Line No." + 1000;
                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Loan;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                    GenJournalLine."Account No." := LoanGuar."Member No";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Posting Date" := Today;
                    GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                    GenJournalLine.Description := 'Defaulted Loan' + ' ';
                    GenJournalLine.Amount := ((GrAmount / FGrAmount) * (Lbal + INTBAL + COMM));
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                    GenJournalLine."Loan No" := DLN;
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;
                    if loanTypes.Get(LoansRec."Loan Product Type") then begin
                        LoansRec.Init;
                        LoansRec."Loan  No." := DLN;
                        LoansRec."Client Code" := LoanGuar."Member No";
                        LoansRec."Loan Product Type" := 'DEFAULTER';
                        LoansRec."Loan Status" := LoansRec."loan status"::Issued;
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", LoanGuar."Member No");
                        if Cust.Find('-') then begin
                            LoansRec."Client Name" := Cust.Name;
                        end;
                        LoansRec."Application Date" := Today;
                        LoansRec."Issued Date" := Today;
                        LoansRec.Installments := loanTypes."No of Installment";
                        LoansRec.Repayment := ((GrAmount / FGrAmount) * (Lbal + INTBAL + COMM)) / loanTypes."No of Installment";
                        LoansRec."Requested Amount" := ((GrAmount / FGrAmount) * (Lbal + INTBAL + COMM));
                        LoansRec."Approved Amount" := ((GrAmount / FGrAmount) * (Lbal + INTBAL + COMM));
                        LoansRec.Posted := true;
                        LoansRec."Advice Date" := Today;
                        LoansRec.Source := loanTypes.Source;
                        LoansRec.Insert;

                    end;
                until LoanGuar.Next = 0;
            end;
            LoansRec.Posted := true;
            LoansRec."Attachement Date" := Today;
            Rec.Modify;
        end;


        //Post New
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
        GenJournalLine.SetRange("Journal Batch Name", 'LNattach');
        if GenJournalLine.Find('-') then begin
            // Codeunit.Run(Codeunit::"Gen. Jnl.-Post Batch", GenJournalLine);
            page.Run(Page::"General Journal", GenJournalLine);
        end;
    end;

    local procedure FnRecoverFromGuarantorShares(LoanRec: Record "Loans Register")
    var
        LoanNo: Code[20];
    begin
        TGrAmount := 0;
        GrAmount := 0;
        FGrAmount := 0;

        //LoanGuar.RESET;
        //LoanGuar.SETRANGE(LoanGuar."Loan No","Loan to Attach");

        LoanGuar.Reset;
        LoanGuar.SetRange(LoanGuar."Loan No", Rec."Loan to Attach");
        if LoanGuar.Find('-') then begin
            repeat
                TGrAmount := TGrAmount + GrAmount;
                GrAmount := LoanGuar."Amont Guaranteed";
                FGrAmount := TGrAmount + LoanGuar."Amont Guaranteed";
            until LoanGuar.Next = 0;
        end;



        //Delete journal line
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
        GenJournalLine.SetRange("Journal Batch Name", 'LNAttach');
        GenJournalLine.DeleteAll;
        //End of Deletion



        if LoansRec.Get(Rec."Loan to Attach") then begin
            //Defaulter loan clear
            LoansRec.CalcFields(LoansRec."Outstanding Balance", LoansRec."Interest Due");
            Lbal := ROUND(LoansRec."Outstanding Balance", 1, '=');
            if LoansRec."Oustanding Interest" > 0 then begin
                INTBAL := ROUND(LoansRec."Oustanding Interest", 1, '=');
                COMM := ROUND((LoansRec."Oustanding Interest" * 0.5), 1, '=');
                LoansRec."Attached Amount" := Lbal;
                LoansRec.PenaltyAttached := COMM;
                LoansRec.InDueAttached := INTBAL;
                Rec.Modify;
            end;


            LoansRec.Attached := true;
            Message('BALANCE %1', Lbal);
            GenJournalLine."Line No." := GenJournalLine."Line No." + 1000;
            GenJournalLine.Init;
            GenJournalLine."Journal Template Name" := 'GENERAL';
            GenJournalLine."Journal Batch Name" := 'LNattach';
            GenJournalLine."Document No." := LoansRec."Loan  No.";
            GenJournalLine."External Document No." := Loanapp."Loan  No.";
            GenJournalLine."Line No." := GenJournalLine."Line No." + 900;
            GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Loan Repayment";
            GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
            GenJournalLine."Account No." := Rec."Member No";
            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine."Posting Date" := Today;
            GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
            GenJournalLine.Description := 'Def Loan' + Rec."Member No";
            GenJournalLine.Amount := -Lbal;
            GenJournalLine.Validate(GenJournalLine.Amount);
            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
            GenJournalLine."Loan No" := LoansRec."Loan  No.";
            if GenJournalLine.Amount <> 0 then
                GenJournalLine.Insert;


            "LN Doc" := LoansRec."Loan  No.";
            // int due
            GenJournalLine."Line No." := GenJournalLine."Line No." + 1000;
            GenJournalLine.Init;
            GenJournalLine."Journal Template Name" := 'GENERAL';
            GenJournalLine."Journal Batch Name" := 'LNattach';
            GenJournalLine."Document No." := LoansRec."Loan  No.";
            GenJournalLine."External Document No." := Loanapp."Loan  No.";
            GenJournalLine."Line No." := GenJournalLine."Line No." + 900;
            GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
            GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
            GenJournalLine."Account No." := Rec."Member No";
            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine."Posting Date" := Today;
            GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
            //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
            GenJournalLine.Description := 'Defaulted Loan int' + ' ';
            GenJournalLine.Amount := -INTBAL;
            GenJournalLine.Validate(GenJournalLine.Amount);
            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
            GenJournalLine."Loan No" := LoansRec."Loan  No.";
            if GenJournalLine.Amount <> 0 then
                GenJournalLine.Insert;

            //commisision
            GenSetUp.Get();

            GenJournalLine."Line No." := GenJournalLine."Line No." + 1000;
            GenJournalLine.Init;
            GenJournalLine."Journal Template Name" := 'GENERAL';
            GenJournalLine."Journal Batch Name" := 'LNattach';
            GenJournalLine."Document No." := LoansRec."Loan  No.";
            GenJournalLine."External Document No." := Loanapp."Loan  No.";
            GenJournalLine."Line No." := GenJournalLine."Line No." + 900;
            GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
            GenJournalLine."Account No." := GenSetUp."Loan Attachment Comm. Account";
            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine."Posting Date" := Today;
            GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
            GenJournalLine.Description := 'Penalty' + ' ';
            GenJournalLine.Amount := -COMM;
            GenJournalLine.Validate(GenJournalLine.Amount);
            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
            GenJournalLine."Loan No" := LoansRec."Loan  No.";
            if GenJournalLine.Amount <> 0 then
                GenJournalLine.Insert;




            LoanGuar.Reset;
            LoanGuar.SetRange(LoanGuar."Loan No", LoansRec."Loan  No.");
            if LoanGuar.Find('-') then begin
                LoanGuar.Reset;
                LoanGuar.SetRange(LoanGuar."Loan No", LoansRec."Loan  No.");
                DLN := 'DLN';
                repeat
                    LoansRec.Reset;
                    LoansRec.SetRange(LoansRec."Client Code", LoanGuar."Member No");
                    LoansRec.SetRange(LoansRec."Loan Product Type", 'DEFAULTER');
                    if LoansRec.Find('-') then begin
                        LoansRec.CalcFields(LoansRec."Outstanding Balance");
                        if LoansRec."Outstanding Balance" = 0 then
                            LoansRec.DeleteAll;
                    end;

                    GenSetUp.Get();
                    GenSetUp."Defaulter LN" := GenSetUp."Defaulter LN" + 10;
                    GenSetUp.Modify;
                    DLN := 'DLN_' + Format(GenSetUp."Defaulter LN");
                    TGrAmount := TGrAmount + GrAmount;
                    GrAmount := LoanGuar."Amont Guaranteed";
                    //MESSAGE('Guarnteed Amount %1',FGrAmount);

                    ////Insert Journal Lines
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'LNattach';
                    GenJournalLine."Document No." := "LN Doc";
                    GenJournalLine."External Document No." := "LN Doc";
                    GenJournalLine."Line No." := GenJournalLine."Line No." + 1000;
                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Deposit Contribution";
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                    GenJournalLine."Account No." := LoanGuar."Member No";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Posting Date" := Today;
                    GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                    GenJournalLine.Description := 'Defaulted Loan' + ' ';
                    GenJournalLine.Amount := ((GrAmount / FGrAmount) * (Lbal + INTBAL + COMM));
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                    GenJournalLine."Loan No" := DLN;
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;
                    if loanTypes.Get(LoansRec."Loan Product Type") then begin
                        LoansRec.Init;
                        LoansRec."Loan  No." := DLN;
                        LoansRec."Client Code" := LoanGuar."Member No";
                        LoansRec."Loan Product Type" := 'DEFAULTER';
                        LoansRec."Loan Status" := LoansRec."loan status"::Issued;
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", LoanGuar."Member No");
                        if Cust.Find('-') then begin
                            LoansRec."Client Name" := Cust.Name;
                        end;
                        LoansRec."Application Date" := Today;
                        LoansRec."Issued Date" := Today;
                        LoansRec.Installments := loanTypes."No of Installment";
                        LoansRec.Repayment := ((GrAmount / FGrAmount) * (Lbal + INTBAL + COMM)) / loanTypes."No of Installment";
                        LoansRec."Requested Amount" := ((GrAmount / FGrAmount) * (Lbal + INTBAL + COMM));
                        LoansRec."Approved Amount" := ((GrAmount / FGrAmount) * (Lbal + INTBAL + COMM));
                        LoansRec.Posted := true;
                        LoansRec."Advice Date" := Today;
                        LoansRec.Source := loanTypes.Source;
                        //LoansRec.INSERT;

                    end;
                until LoanGuar.Next = 0;
            end;
            LoansRec.Posted := true;
            LoansRec."Attachement Date" := Today;
            Rec.Modify;
        end;

        //Post New
        Message('Journal Lines Created Successfully');
        GenJournalLine.RESET;
        GenJournalLine.SETRANGE("Journal Template Name", 'GENERAL');
        GenJournalLine.SETRANGE("Journal Batch Name", 'LNattach');
        IF GenJournalLine.FIND('-') THEN BEGIN
            //CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch", GenJournalLine);
            page.Run(Page::"General Journal", GenJournalLine);
        END;


    end;


    procedure UpdateControls()
    begin

        if Rec.Status = Rec.Status::Open then begin
            MemberNoEditable := true;
            RecoveryTypeEditable := true;
            LoantoAttachEditable := true;
            Global1Editable := true;
            Global2Editable := true;
            GuarantorLoansDetailsEdit := true;
        end;
        if Rec.Status = Rec.Status::Pending then begin
            MemberNoEditable := false;
            RecoveryTypeEditable := false;
            LoantoAttachEditable := false;
            Global1Editable := false;
            Global2Editable := false;
            GuarantorLoansDetailsEdit := true;
        end;
        if Rec.Status = Rec.Status::Approved then begin
            MemberNoEditable := false;
            RecoveryTypeEditable := false;
            LoantoAttachEditable := false;
            Global1Editable := false;
            Global2Editable := false;
            GuarantorLoansDetailsEdit := true;
        end
    end;
}

