#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 56121 "Membership Exit Card"
{
    DeleteAllowed = true;
    Editable = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption';
    SourceTable = "Membership Exist";
    SourceTableView = where(Posted = filter(false));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = Basic;

                    // Editable = false;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Closing Date"; Rec."Closing Date")
                {
                    ApplicationArea = Basic;
                    Editable = ClosingDateEditable;
                    Caption = 'Expected Maturity Date';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Closure Type"; Rec."Closure Type")
                {
                    ApplicationArea = Basic;
                    Editable = ClosureTypeEditable;
                }

                field("Total Loan"; Rec."Total Loan")
                {
                    ApplicationArea = Basic;
                    Caption = 'Total Loans';
                    Editable = false;
                }
                field("Total Interest"; Rec."Total Interest")
                {
                    ApplicationArea = Basic;
                    Caption = 'Total Interest Due';
                    Editable = false;
                }
                field("Ledger Fee"; Rec."Ledger Fee")
                {
                    ApplicationArea = Basic;
                    Editable = False;
                }
                field("Member Deposits"; Rec."Member Deposits")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = Attention;
                    StyleExpr = true;
                }
                field("Shares Capital"; Rec."Share Capital")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = Attention;
                    StyleExpr = true;
                }
                field("Net Payable to the Member"; Rec."Net Payable to the Member")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field(Payee; Rec.Payee)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Mode Of Disbursement"; Rec."Mode Of Disbursement")
                {
                    ApplicationArea = Basic;
                    Caption = 'Payment mode';
                    trigger OnValidate()
                    begin
                        UpdateControl();
                    end;
                }
                field("Paying Bank"; Rec."Paying Bank")
                {
                    ApplicationArea = Basic;
                    Visible = true;
                    ShowMandatory = true;
                }
                field("Cheque No."; Rec."Cheque No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cheque No';
                    Enabled = EnableCheque;
                    Visible = false;
                }
                field("EFT Charge"; Rec."EFT Charge")
                {
                    ApplicationArea = basic;

                }
                field("Reason For Withdrawal"; Rec."Reason For Withdrawal")
                {
                    ApplicationArea = Basic;
                }
                field("Closed By"; Rec."Closed By")
                {
                    ApplicationArea = Basic;
                }
                field("Closed On"; Rec."Closed On")
                {
                    ApplicationArea = Basic;
                }
                field("Notice Date"; Rec."Notice Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }


            }
        }
        area(factboxes)
        {
            part(Control24; "Member Statistics FactBox")
            {
                Caption = 'Member Statistics FactBox';
                SubPageLink = "No." = field("Member No.");
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Function")
            {
                Caption = 'Function';
                /*  action("Member is  a Guarantor")
                  {
                      ApplicationArea = Basic;
                      Caption = 'Member is  a Guarantor';
                      Image = "Report";

                      trigger OnAction()
                      begin

                          Cust.Reset;
                          cust.SetRange(cust."No.", Rec."Member No.");
                          if Cust.Find('-') then
                              Report.Run(50226, true, false, Cust);
                      end;
                  }
                  action("Member is  Guaranteed")
                  {
                      ApplicationArea = Basic;
                      Caption = 'Member is  Guaranteed';
                      Image = "Report";

                      trigger OnAction()
                      begin
                          Cust.Reset;
                          cust.SetRange(cust."No.", Rec."Member No.");
                          if Cust.Find('-') then
                              Report.Run(50225, true, false, Cust);
                      end;
                  }*/
                action("Send Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        text001: label 'This batch is already pending approval';
                        SrestepApprovalsCodeUnit: Codeunit SurestepApprovalsCodeUnit;
                    begin

                        // if Rec."Mode Of Disbursement" = Rec."Mode Of Disbursement"::Cheque then begin
                        //     Rec.TestField("Cheque No.");
                        // end;
                        if Rec.Status <> Rec.Status::Open then
                            Error(text001);
                        //.................................
                        if Confirm('Proceed with exiting member?', false) = true then begin
                            SrestepApprovalsCodeUnit.SendMembershipExitApplicationsRequestForApproval(Rec."No.", Rec);
                            Message('Member Exit Sent for approval');
                            //Rec.Status := Rec.Status::Approved;
                            CurrPage.Close();


                        end;
                        //.................................
                        GenSetUp.Get();
                        //..................Send Withdrawal Approval request
                        FnSendWithdrawalApplicationSMS();
                        //...................................................


                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel A&pproval Request';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                    begin
                        if Rec.Status <> Rec.Status::Open then
                            Error(text001);

                    end;
                }
                action("Account closure Slip")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        cust.Reset;
                        cust.SetRange(cust."No.", Rec."Member No.");
                        if cust.FindLast() then
                            Report.Run(50250, true, false, cust);
                    end;
                }
                action("Post Membership Exit")
                {
                    ApplicationArea = Basic;
                    Image = PostDocument;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                    begin
                        TemplateName := 'GENERAL';
                        BatchName := 'CLOSURE';
                        case Rec."Closure Type" of
                            Rec."closure type"::"Member Exit - Normal":
                                FnRunPostNormalExitApplication(Rec."Member No.");
                            Rec."closure type"::"Member Exit - Deceased":
                                FnRunPostDeceasedExitApplication(Rec."Member No.");
                        end;
                        FnSendWithdrawalApplicationSMS
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateControl();
        GenSetUp.Get();
        rec."Ledger Fee" := GenSetUp."Ledger Fee";
        rec.Modify();
    end;

    trigger OnAfterGetRecord()
    begin
        UpdateControl();
        ShareCapitalTransferVisible := false;
        ShareCapSellPageVisible := false;
        if Rec."Sell Share Capital" = true then begin
            ShareCapitalTransferVisible := true;
            ShareCapSellPageVisible := true;
        end;



        UpdateControl();
    end;

    trigger OnOpenPage()
    begin
        UpdateControl();
    end;

    var
        Closure: Integer;
        Text001: label 'Not Approved';
        cust: Record Customer;
        UBFRefund: Decimal;
        Generalsetup: Record "Sacco General Set-Up";
        Totalavailable: Decimal;
        UnpaidDividends: Decimal;
        TotalOustanding: Decimal;
        // Vend: Record Vendor;
        value2: Decimal;
        Gnljnline: Record "Gen. Journal Line";
        Totalrecovered: Decimal;
        Advice: Boolean;
        TotalDefaulterR: Decimal;
        AvailableShares: Decimal;
        Loans: Record "Loans Register";
        Value1: Decimal;
        Interest: Decimal;
        LineN: Integer;
        LRepayment: Decimal;
        Vendno: Code[20];
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication,BulkWithdrawal,PackageLodging,PackageRetrieval;
        MNoEditable: Boolean;
        ClosingDateEditable: Boolean;
        ClosureTypeEditable: Boolean;
        PostingDateEditable: Boolean;
        TotalFOSALoan: Decimal;
        TotalInsuarance: Decimal;
        DActivity: Code[30];
        DBranch: Code[30];
        LineNo: Integer;
        GenJournalLine: Record "Gen. Journal Line";
        "Remaining Amount": Decimal;
        LoansR: Record "Loans Register";
        "AMOUNTTO BE RECOVERED": Decimal;
        PrincipInt: Decimal;
        TotalLoansOut: Decimal;
        ClosureR: Record "Membership Exist";
        Table_id: Integer;
        Doc_No: Code[20];
        Doc_Type: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication,BulkWithdrawal,PackageLodging,PackageRetrieval;
        PTEN: Text;
        DataSheet: Record "Data Sheet Main";
        Customer: Record Customer;
        GenSetUp: Record "Sacco General Set-Up";
        compinfo: Record "Company Information";
        SMSMessage: Record "SMS Messages";
        iEntryNo: Integer;
        ShareCapitalTransferVisible: Boolean;
        ShareCapSellPageVisible: Boolean;
        // ObjShareCapSell: Record "Share Capital Sell";
        SwizzsoftFactory: Codeunit "SWIZZSFT Factory";
        JVTransactionType: Option " ","Registration Fee","Shares Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account","Loan Insurance Charged","Loan Insurance Paid","Recovery Account","FOSA Shares","Additional Shares";
        JVAccountType: Enum "Gen. Journal Account Type";
        TemplateName: Code[20];
        BatchName: Code[20];
        JVBalAccounttype: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee;
        JVBalAccountNo: Code[20];
        TransferFee: Decimal;
        AvailableBal: Decimal;
        ObjMember: Record Customer;
        VarMemberAvailableAmount: Decimal;
        ObjCust: Record Customer;
        ObjGensetup: Record "Sacco General Set-Up";
        VarWithdrawalFee: Decimal;
        VarTaxonWithdrawalFee: Decimal;
        VarShareCapSellFee: Decimal;
        VarTaxonShareCapSellFee: Decimal;
        ObjNoSeries: Record "Sacco No. Series";
        VarDocumentNo: Code[30];
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        VarShareCapitalFee: Decimal;
        VarShareCapitaltoSell: Decimal;
        EnableCheque: Boolean;
        GenBatch: Record "Gen. Journal Batch";

    procedure UpdateControl()
    begin
        // if Rec."Mode Of Disbursement" = Rec."Mode Of Disbursement"::Cheque then begin
        //     EnableCheque := true;
        // end else
        //     if Rec."Mode Of Disbursement" <> Rec."Mode Of Disbursement"::Cheque then begin
        //         EnableCheque := false;
        //     end;
        if Rec.Status = Rec.Status::Open then begin
            MNoEditable := true;
            ClosingDateEditable := false;
            ClosureTypeEditable := true;
            PostingDateEditable := false;
        end;

        if Rec.Status = Rec.Status::Pending then begin
            MNoEditable := false;
            ClosingDateEditable := false;
            ClosureTypeEditable := false;
            PostingDateEditable := false;
        end;

        if Rec.Status = Rec.Status::Rejected then begin
            MNoEditable := false;
            ClosingDateEditable := false;
            ClosureTypeEditable := false;
            PostingDateEditable := false;
        end;

        if Rec.Status = Rec.Status::Approved then begin
            MNoEditable := false;
            ClosingDateEditable := true;
            ClosureTypeEditable := false;
            PostingDateEditable := true;
        end;
    end;


    procedure FnSendWithdrawalApplicationSMS()
    begin

        GenSetUp.Get;
        compinfo.Get;



        //SMS MESSAGE
        SMSMessage.Reset;
        if SMSMessage.Find('+') then begin
            iEntryNo := SMSMessage."Entry No";
            iEntryNo := iEntryNo + 1;
        end
        else begin
            iEntryNo := 1;
        end;


        SMSMessage.Init;
        SMSMessage."Entry No" := iEntryNo;
        SMSMessage."Batch No" := Rec."No.";
        SMSMessage."Document No" := Rec."No.";
        SMSMessage."Account No" := Rec."Member No.";
        SMSMessage."Date Entered" := Today;
        SMSMessage."Time Entered" := Time;
        SMSMessage.Source := 'MEMBERSHIPWITH';
        SMSMessage."Entered By" := UserId;
        SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
        SMSMessage."SMS Message" := 'Dear Member,Your Membership Withdrawal Application has been received and is being Processed '
        + compinfo.Name + ' ' + GenSetUp."Customer Care No";
        cust.Reset;
        cust.SetRange(cust."No.", Rec."Member No.");
        if cust.Find('-') then begin
            SMSMessage."Telephone No" := cust."Mobile Phone No";
        end;
        if cust."Mobile Phone No" <> '' then
            SMSMessage.Insert;
    end;

    local procedure FnRunPostNormalExitApplication(MemberNo: Code[20])
    Var
        Gnljnline: Record "Gen. Journal Line";
        TotalAmount: Decimal;
        NetMemberAmounts: Decimal;
        Doc_No: Code[20];
        DActivity: code[20];
        DBranch: Code[50];
        Cust: Record customer;
        Generalsetup: Record "Sacco General Set-Up";
        RunningBal: Decimal;
        SFactory: Codeunit "SWIZZSFT Factory";
        InterestTobeRecovered: Decimal;
        LoanTobeRecovered: Decimal;
    begin
        GenSetUp.Get;
        IF Cust.get(MemberNo) then begin
            if Confirm('Proceed With Account Closure ?', false) = false then begin
                exit;
            end else begin
                //....................Ensure that If Batch doesnt exist then create
                IF NOT GenBatch.GET(TemplateName, BatchName) THEN BEGIN
                    GenBatch.INIT;
                    GenBatch."Journal Template Name" := TemplateName;
                    GenBatch.Name := BatchName;
                    GenBatch.INSERT;
                END;
                //....................Reset General Journal Lines
                GenJournalLine.RESET;
                GenJournalLine.SETRANGE("Journal Template Name", TemplateName);
                GenJournalLine.SETRANGE("Journal Batch Name", BatchName);
                GenJournalLine.DELETEALL;
                //....................Loan Posting Lines
                NetMemberAmounts := 0;
                InterestTobeRecovered := 0;
                LoanTobeRecovered := 0;
                GenSetUp.Validate(GenSetUp."Banks Charges");
                //................................................
                DActivity := Cust."Global Dimension 1 Code";
                DBranch := Cust."Global Dimension 2 Code";
                //.................................
                RunningBal := 0;
                RunningBal := Rec."Member Deposits";
                Doc_No := Rec."No.";


                //debit Deposits - Interest Repayment
                //Interest Repayment - Credit

                //debit Deposits - Loan Repayment
                //credit Loan Repayment

                //Debit Deposits - bank Charges
                //credit bank charges

                //debit Deposits- Ledger fee
                //Credit legder fee

                //debit deposits - excise duty
                //credit excise duty

                //credit bank -the remaining AMount
                //Debit Deposits - the remaining Amount - Payout



                // //Debit Member Deposist
                // LineNo := LineNo + 10000;
                // SFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."Transaction Type"::"Deposit Contribution",
                // GenJournalLine."Account Type"::Customer, MemberNo, Rec."Posting Date", RunningBal, 'BOSA', MemberNo, 'Deposits on exit - for ' + MemberNo, '');



                //Interest Repayment
                Loans.Reset;
                Loans.SetRange(Loans."Client Code", MemberNo);
                if Loans.Findset then begin
                    repeat
                        Loans.CalcFields(Loans."Oustanding Interest");// 
                        if Loans."Oustanding Interest" > 0 then begin
                            if Loans."Oustanding Interest" > RunningBal then
                                InterestTobeRecovered := RunningBal else
                                InterestTobeRecovered := Loans."Oustanding Interest";
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."Transaction Type"::"Interest Paid",
                            GenJournalLine."Account Type"::Customer, Loans."Client Code", Rec."Posting Date", InterestTobeRecovered * -1, 'BOSA', Loans."Loan  No.", 'Interest Due Paid on Exit - ' + MemberNo, Loans."Loan  No.");

                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."Transaction Type"::"Deposit Contribution",
                            GenJournalLine."Account Type"::Customer, MemberNo, Rec."Posting Date", InterestTobeRecovered, 'BOSA', MemberNo, 'Interest deducted for loan ' + Loans."Loan  No.", '');

                            RunningBal := RunningBal - InterestTobeRecovered;
                        end;

                    until Loans.Next = 0;

                end;

                //Loan Repayment
                Loans.Reset;
                Loans.SetRange(Loans."Client Code", MemberNo);
                if Loans.Findset then begin
                    repeat
                        Loans.CalcFields(Loans."Outstanding Balance", Loans."Oustanding Interest");
                        if Loans."Outstanding Balance" > 0 then begin
                            If RunningBal > Loans."Outstanding Balance" then
                                LoanTobeRecovered := Loans."Outstanding Balance" else
                                LoanTobeRecovered := RunningBal;
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."Transaction Type"::"Loan Repayment", GenJournalLine."Account Type"::Customer, Loans."Client Code", Rec."Posting Date", LoanTobeRecovered * -1,
                            'BOSA', Loans."Loan  No.", 'Loan Balance paid on exit - ' + Loans."Loan  No.", Loans."Loan  No.");

                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."Transaction Type"::"Deposit Contribution",
                            GenJournalLine."Account Type"::Customer, MemberNo, Rec."Posting Date", LoanTobeRecovered, 'BOSA', MemberNo, 'Loan balance deducted for loan ' + Loans."Loan  No.", '');

                            RunningBal := RunningBal - LoanTobeRecovered;
                        end;

                    until Loans.Next = 0;

                end;

                //Bank Charges
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::"G/L Account", GenSetUp."Banks Charges", Rec."Posting Date", Rec."EFT Charge" * -1, 'BOSA', MemberNo, 'Bank Charges for exit - ' + MemberNo, '');

                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."Transaction Type"::"Deposit Contribution",
                GenJournalLine."Account Type"::Customer, MemberNo, Rec."Posting Date", Rec."EFT Charge", 'BOSA', MemberNo, 'Bank EFT Charges deducted for ' + MemberNo, '');

                RunningBal := RunningBal - Rec."EFT Charge";


                //Ledger Fee Charges
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::"G/L Account", GenSetUp."Ledger Fee Account", Rec."Posting Date", (Rec."Ledger Fee" - (Rec."Ledger Fee" * GenSetUp."Excise Duty(%)" / 100)) * -1, 'BOSA', MemberNo, 'Ledger fees charge for exit - ' + MemberNo, '');

                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."Transaction Type"::"Deposit Contribution",
                GenJournalLine."Account Type"::Customer, MemberNo, Rec."Posting Date", Rec."Ledger Fee", 'BOSA', MemberNo, 'Ledger fee charges deducted for ' + MemberNo, '');

                RunningBal := RunningBal - Rec."Ledger Fee";

                //Excise Duty 15% Charges
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::"G/L Account", GenSetUp."Excise Duty Account", Rec."Posting Date", (Rec."Ledger Fee" * GenSetUp."Excise Duty(%)" / 100) * -1, 'BOSA', MemberNo, 'Excise Duty charge for exit - ' + MemberNo, '');

                // LineNo := LineNo + 10000;
                // SFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."Transaction Type"::"Deposit Contribution",
                // GenJournalLine."Account Type"::Customer, MemberNo, Rec."Posting Date", (Rec."Ledger Fee" * GenSetUp."Excise Duty(%)" / 100), 'BOSA', MemberNo, 'Excise duty charge for ' + MemberNo, '');


                //Credit Bank
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::"G/L Account", Rec."Paying Bank", Rec."Posting Date", RunningBal * -1, 'BOSA', MemberNo, 'credit Refund Deposits Account Exit - ' + MemberNo, '');

                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."Transaction Type"::"Deposit Contribution",
                GenJournalLine."Account Type"::Customer, MemberNo, Rec."Posting Date", RunningBal, 'BOSA', MemberNo, 'Net Deposits on exit - for ' + MemberNo, '');

            end;

        end;
        //............................Post Lines
        GenJournalLine.RESET;
        GenJournalLine.SETRANGE("Journal Template Name", TemplateName);
        GenJournalLine.SETRANGE("Journal Batch Name", BatchName);
        IF GenJournalLine.FIND('-') THEN BEGIN
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Batch", GenJournalLine);
            //Exit Member
            Cust.Reset();
            cust.SETRANGE(cust."No.", Rec."Member No.");
            IF cust.FIND('-') THEN BEGIN
                if (Cust."Outstanding Balance" <= 0) and (Cust."Outstanding Interest" <= 0) then begin
                    cust.Status := cust.Status::Withdrawal;
                    cust."Withdrawal Application Date" := Rec."Notice Date";
                    Cust."Withdrawal Date" := Today;
                    Cust."Withdrawal Fee" := Rec."EFT Charge";
                    Cust."Reason For Membership Withdraw" := Rec."Reason For Withdrawal";
                    Cust."Status - Withdrawal App." := Cust."Status - Withdrawal App."::Approved;
                    if cust.Modify(true) then begin
                        Rec.Posted := true;
                        Rec."Closed By" := UserId;
                        Rec."Closing Date" := Today;
                        Rec."Branch Code" := Cust."Global Dimension 2 Code";
                        Rec."Closed On" := Today;
                        Rec.Status := Rec.Status::Closed;
                        Rec.Modify(true);
                        Message('Member Account Closure was successful');
                        CurrPage.Close();
                    end;
                end else
                    Message('The Member cannot be withdrawn because of pending Balances');

            END;
        end;
    END;


    //......................................
    local procedure FnRunPostDeceasedExitApplication(MemberNo: Code[20])
    Var
        Gnljnline: Record "Gen. Journal Line";
        TotalAmount: Decimal;
        NetMemberAmounts: Decimal;
        Doc_No: Code[20];
        DActivity: code[20];
        DBranch: Code[50];
        Cust: Record customer;
        Generalsetup: Record "Sacco General Set-Up";
        RunningBal: Decimal;
        SFactory: Codeunit "SWIZZSFT Factory";
        InterestTobeRecovered: Decimal;
        LoanTobeRecovered: Decimal;
    begin
        GenSetUp.Get;

        IF Cust.get(MemberNo) then begin
            if Confirm('Proceed With Account Closure ?', false) = false then begin
                exit;
            end else begin
                //....................Ensure that If Batch doesnt exist then create
                IF NOT GenBatch.GET(TemplateName, BatchName) THEN BEGIN
                    GenBatch.INIT;
                    GenBatch."Journal Template Name" := TemplateName;
                    GenBatch.Name := BatchName;
                    GenBatch.INSERT;
                END;
                //....................Reset General Journal Lines
                GenJournalLine.RESET;
                GenJournalLine.SETRANGE("Journal Template Name", TemplateName);
                GenJournalLine.SETRANGE("Journal Batch Name", BatchName);
                GenJournalLine.DELETEALL;
                //....................Loan Posting Lines
                NetMemberAmounts := 0;
                InterestTobeRecovered := 0;
                LoanTobeRecovered := 0;
                GenSetUp.Validate(GenSetUp."Banks Charges");
                //................................................
                DActivity := Cust."Global Dimension 1 Code";
                DBranch := Cust."Global Dimension 2 Code";
                //.................................
                RunningBal := 0;
                RunningBal := Rec."Member Deposits";
                Doc_No := Rec."No.";

                //Debit Member Deposist
                // LineNo := LineNo + 10000;
                // SFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."Transaction Type"::"Deposit Contribution",
                // GenJournalLine."Account Type"::Customer, MemberNo, Rec."Posting Date", RunningBal, 'BOSA', MemberNo, 'Deposits on exit - ' + MemberNo, '');

                //Interest Repayment
                Loans.Reset;
                Loans.SetRange(Loans."Client Code", MemberNo);
                if Loans.Findset then begin
                    repeat
                        Loans.CalcFields(Loans."Outstanding Balance", Loans."Oustanding Interest");
                        if Loans."Oustanding Interest" > 0 then begin
                            //...........................Recover Loan Interest
                            if Loans."Oustanding Interest" > RunningBal then
                                InterestTobeRecovered := RunningBal else
                                InterestTobeRecovered := Loans."Oustanding Interest";

                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."Transaction Type"::"Interest Paid", GenJournalLine."Account Type"::Customer, Loans."Client Code", Rec."Posting Date", InterestTobeRecovered * -1, 'BOSA', Loans."Loan  No.", 'Interest Due Paid on Exit - ' + MemberNo, Loans."Loan  No.");

                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."Transaction Type"::"Deposit Contribution",
                            GenJournalLine."Account Type"::Customer, MemberNo, Rec."Posting Date", InterestTobeRecovered, 'BOSA', MemberNo, 'Interest recovered on exit - ' + Loans."Loan  No.", '');

                            RunningBal := RunningBal - InterestTobeRecovered;
                        end;

                    until Loans.Next = 0;
                end;

                //Loan Repayment
                Loans.Reset;
                Loans.SetRange(Loans."Client Code", MemberNo);
                if Loans.Findset then begin
                    repeat
                        Loans.CalcFields(Loans."Outstanding Balance", Loans."Oustanding Interest");
                        if Loans."Outstanding Balance" > 0 then begin
                            if Loans."Outstanding Balance" > RunningBal then
                                LoanTobeRecovered := RunningBal else
                                LoanTobeRecovered := Loans."Outstanding Balance";
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."Transaction Type"::"Loan Repayment", GenJournalLine."Account Type"::Customer, Loans."Client Code", Rec."Posting Date", LoanTobeRecovered * -1, 'BOSA', Loans."Loan  No.", 'Loan Balance paid on exit - ' + Loans."Loan  No.", Loans."Loan  No.");

                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."Transaction Type"::"Deposit Contribution",
                            GenJournalLine."Account Type"::Customer, MemberNo, Rec."Posting Date", LoanTobeRecovered, 'BOSA', MemberNo, 'Loan balance recovered for ' + Loans."Loan  No.", '');

                            RunningBal := RunningBal - LoanTobeRecovered;
                        end;
                    until Loans.Next = 0;
                end;

                //Bank Charges
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::"G/L Account", GenSetUp."Banks Charges", Rec."Posting Date", Rec."EFT Charge" * -1, 'BOSA', MemberNo, 'Bank Charges for exit - ' + MemberNo, '');

                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."Transaction Type"::"Deposit Contribution",
                GenJournalLine."Account Type"::Customer, MemberNo, Rec."Posting Date", Rec."EFT Charge", 'BOSA', MemberNo, 'Bank charges deducted on exit - ' + MemberNo, '');
                RunningBal := RunningBal - Rec."EFT Charge";


                //Credit Bank
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::"Bank Account", Rec."Paying Bank", Rec."Posting Date", RunningBal * -1, 'BOSA', MemberNo, 'credit Bank Member Exit - ' + MemberNo, '');

                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."Transaction Type"::"Deposit Contribution",
                GenJournalLine."Account Type"::Customer, MemberNo, Rec."Posting Date", RunningBal, 'BOSA', MemberNo, 'Net Deposits on exit - ' + MemberNo, '');
            end;

        end;
        //............................Post Lines
        GenJournalLine.RESET;
        GenJournalLine.SETRANGE("Journal Template Name", TemplateName);
        GenJournalLine.SETRANGE("Journal Batch Name", BatchName);
        IF GenJournalLine.FIND('-') THEN BEGIN
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Batch", GenJournalLine);
            //Exit Member
            Cust.Reset();
            cust.SETRANGE(cust."No.", Rec."Member No.");
            IF cust.FIND('-') THEN BEGIN
                cust.CalcFields("Outstanding Balance", "Outstanding Interest");
                if (Cust."Outstanding Balance" <= 0) and (Cust."Outstanding Interest" <= 0) then begin
                    cust.Status := cust.Status::Deceased;
                    cust."Withdrawal Application Date" := Rec."Notice Date";
                    Cust."Reason For Membership Withdraw" := Rec."Reason For Withdrawal"::Death;
                    Cust."Withdrawal Date" := Today;
                    Cust."Withdrawal Fee" := Rec."EFT Charge";
                    Cust."Status - Withdrawal App." := Cust."Status - Withdrawal App."::Approved;
                    if cust.Modify(true) then begin
                        Rec.Posted := true;
                        Rec."Closed By" := UserId;
                        Rec."Closing Date" := Today;
                        Rec."Branch Code" := Cust."Global Dimension 2 Code";
                        Rec."Closed On" := Today;
                        Rec.Status := Rec.Status::Closed;
                        Rec.Modify(true);
                        Message('Member Account Closure was successful');
                        CurrPage.Close();
                    end;
                end else
                    Message('The Member cannot be withdrawn because of pending Balances');

            END;
        end;
    END;

}

