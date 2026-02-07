#pragma warning disable AA0005, AA0008, AL0603, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 50007 "Swizzsoft Factory."
{

    trigger OnRun()
    begin
        Message(Format(FnGetLoanAmountPaid('VL000286')));
    end;

    var
        ObjTransCharges: Record "Transaction Charges";
        UserSetup: Record "User Setup";
        ObjVendor: Record Vendor;
        Date: Date;
        ObjProducts: Record "Account Types-Saving Products";
        ObjMemberLedgerEntry: Record "Member Ledger Entry";
        ObjLoans: Record "Loans Register";
        ObjBanks: Record "Bank Account";
        ObjLoanProductSetup: Record "Loan Products Setup";
        ObjProductCharges: Record "Loan Product Charges";
        ObjMembers: Record Customer;
        ObjMembers2: Record Customer;
        ObjGenSetUp: Record "Sacco General Set-Up";
        ObjCompInfo: Record "Company Information";
        BAND1: Decimal;
        BAND2: Decimal;
        BAND3: Decimal;
        BAND4: Decimal;
        BAND5: Decimal;
        ObjMembershipWithdrawal: Record "Membership Exit";
        ObjSalesSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit "No. Series";
        ObjNoSeriesManagement: Codeunit "No. Series";
        ObjNextNo: Code[20];
        PostingDate: Date;
        ObjNoSeries: Record "No. Series Line";
        VarRepaymentPeriod: Date;
        VarLoanNo: Code[20];
        VarLastMonth: Date;
        ObjLSchedule: Record "Loan Repayment Schedule";
        VarScheduledLoanBal: Decimal;
        VarDateFilter: Text;
        VarLBal: Decimal;
        VarArrears: Decimal;
        VarDate: Integer;
        VarMonth: Integer;
        VarYear: Integer;
        VarLastMonthBeginDate: Date;
        VarScheduleDateFilter: Text;
        VarScheduleRepayDate: Date;
        ObjCustRiskRates: Record 51931;
        ObjMembershipApplication: Record 51360;
        ObjMemberRiskRating: Record 51933;
        ObjProductRiskRating: Record 51934;
        ObjProductsApp: Record 51509;
        ObjNetRiskScale: Record 51935;
        BATCH_TEMPLATE: Code[100];
        BATCH_NAME: Code[100];
        DOCUMENT_NO: Code[100];
        PCharges: Record "Loan Product Charges";
        GenSetUp: Record "Sacco General Set-Up";
        LoanTopUp: Record 51376;
        AmountToDisburse: Decimal;
        Insurance: Decimal;


    procedure FnGetCashierTransactionBudding(TransactionType: Code[100]; TransAmount: Decimal) TCharge: Decimal
    begin
        ObjTransCharges.Reset;
        ObjTransCharges.SetRange(ObjTransCharges."Transaction Type", TransactionType);
        ObjTransCharges.SetFilter(ObjTransCharges."Minimum Amount", '<=%1', TransAmount);
        ObjTransCharges.SetFilter(ObjTransCharges."Maximum Amount", '>=%1', TransAmount);
        TCharge := 0;
        if ObjTransCharges.FindSet then begin
            repeat
                TCharge := TCharge + ObjTransCharges."Charge Amount";//+ObjTransCharges."Charge Amount"*0.1;
            until ObjTransCharges.Next = 0;
        end;
    end;

    procedure FnGetDocumentApprover(DocumentNo: Code[20]): Code[100]
    var
        ApprovedEntries: Record "Posted Approval Entry";
    begin
        ApprovedEntries.Reset();
        ApprovedEntries.SetRange(ApprovedEntries."Document No.", DocumentNo);
        if ApprovedEntries.Find('-') then begin
            exit(ApprovedEntries."Approver ID");
        end;
        exit('Direct Posting');
    end;

    procedure FnGetUserBranch() branchCode: Code[20]
    begin
        UserSetup.Reset;
        UserSetup.SetRange(UserSetup."User id", UserId);
        if UserSetup.Find('-') then begin
            branchCode := 'NAIROBI';
        end;
        exit(branchCode);
    end;


    procedure FnSendSMS(SMSSource: Text; SMSBody: Text; CurrentAccountNo: Text; MobileNumber: Text)
    var
        SMSMessage: Record 51471;
        iEntryNo: Integer;
    begin
        ObjGenSetUp.Get;
        ObjCompInfo.Get;

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
        SMSMessage."Batch No" := CurrentAccountNo;
        SMSMessage."Document No" := '';
        SMSMessage."Account No" := CurrentAccountNo;
        SMSMessage."Date Entered" := Today;
        SMSMessage."Time Entered" := Time;
        SMSMessage.Source := SMSSource;
        SMSMessage."Entered By" := UserId;
        SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
        SMSMessage."SMS Message" := SMSBody + '.' + ObjCompInfo.Name + ' ' + ObjGenSetUp."Customer Care No";
        SMSMessage."Telephone No" := MobileNumber;
        if ((MobileNumber <> '') and (SMSBody <> '')) then
            SMSMessage.Insert;
    end;


    procedure FnCreateGnlJournalLinew(TemplateName: Text; BatchName: Text; DocumentNo: Code[30]; LineNo: Integer; TransactionType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"Mwanangu Savings","Loan Insurance Charged","Loan Insurance Paid","Recovery Account","FOSA Shares","Additional Shares","Interest Due","Jiokoe Savings"; AccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee,Member,Investor; AccountNo: Code[50]; TransactionDate: Date; TransactionAmount: Decimal; DimensionActivity: Code[40]; ExternalDocumentNo: Code[50]; TransactionDescription: Text; LoanNumber: Code[50])
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        ObjMembershipWithdrawal.Reset;
        ObjMembershipWithdrawal.SetRange(ObjMembershipWithdrawal."No.", DocumentNo);
        if ObjMembershipWithdrawal.Find('-') then begin

            GenJournalLine.Init;
            //MESSAGE('TEST');
            GenJournalLine."Journal Template Name" := TemplateName;
            //MESSAGE('TemplateName %1',TemplateName);
            GenJournalLine."Journal Batch Name" := BatchName;
            //MESSAGE('BatchName %1',BatchName);
            GenJournalLine."Document No." := DocumentNo;
            //MESSAGE('DocumentNo %1',DocumentNo);
            //GenJournalLine."Posting Date":=TransactionDate;
            GenJournalLine."Line No." := LineNo;
            GenJournalLine."Account Type" := AccountType;
            //MESSAGE('AccountType %1',AccountType);
            GenJournalLine."Account No." := AccountNo;
            GenJournalLine."Transaction Type" := TransactionType;
            //MESSAGE('TransactionType %1',TransactionType);
            GenJournalLine."Loan No" := LoanNumber;
            //MESSAGE('LoanNumber %1',LoanNumber);
            GenJournalLine.Validate(GenJournalLine."Account No.");
            //GenJournalLine."Posting Date":=TransactionDate;
            GenJournalLine."Posting Date" := ObjMembershipWithdrawal."Posting Date";
            /*IF ObjMembershipWithdrawal.FIND('-') THEN
              GenJournalLine."Posting Date":=ObjMembershipWithdrawal."Application Date";*/
            Message('Date %1', GenJournalLine."Posting Date");
            GenJournalLine.Description := TransactionDescription;
            GenJournalLine.Validate(GenJournalLine."Currency Code");
            GenJournalLine.Amount := TransactionAmount;
            //MESSAGE('TransactionAmount %1',TransactionAmount);
            GenJournalLine."External Document No." := ExternalDocumentNo;
            GenJournalLine.Validate(GenJournalLine.Amount);
            GenJournalLine."Shortcut Dimension 1 Code" := DimensionActivity;
            GenJournalLine."Shortcut Dimension 2 Code" := FnGetUserBranch();
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
            if GenJournalLine.Amount <> 0 then
                GenJournalLine.Insert;
        end;

    end;


    procedure FnCreateGnlJournalLine(TemplateName: Text; BatchName: Text; DocumentNo: Code[30]; LineNo: Integer; TransactionType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"Mwanangu Savings","Loan Insurance Charged","Loan Insurance Paid","Recovery Account","FOSA Shares","Additional Shares","Interest Due","Jiokoe Savings"; AccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee,Member,Investor; AccountNo: Code[50]; TransactionDate: Date; TransactionAmount: Decimal; DimensionActivity: Code[40]; ExternalDocumentNo: Code[50]; TransactionDescription: Text; LoanNumber: Code[50])
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenJournalLine.Init;
        //MESSAGE('TEST');
        GenJournalLine."Journal Template Name" := TemplateName;
        //MESSAGE('TemplateName %1',TemplateName);
        GenJournalLine."Journal Batch Name" := BatchName;
        //MESSAGE('BatchName %1',BatchName);
        GenJournalLine."Document No." := DocumentNo;
        //MESSAGE('DocumentNo %1',DocumentNo);
        //GenJournalLine."Posting Date":=TransactionDate;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := AccountType;
        //MESSAGE('AccountType %1',AccountType);
        GenJournalLine."Account No." := AccountNo;
        GenJournalLine."Transaction Type" := TransactionType;
        //MESSAGE('TransactionType %1',TransactionType);
        GenJournalLine."Loan No" := LoanNumber;
        //MESSAGE('LoanNumber %1',LoanNumber);
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := TransactionDate;
        //GenJournalLine."Posting Date":=PostingDate;
        /*IF ObjMembershipWithdrawal.FIND('-') THEN
          GenJournalLine."Posting Date":=ObjMembershipWithdrawal."Application Date";*/
        //MESSAGE('Datep %1',GenJournalLine.TransactionDate);
        GenJournalLine.Description := TransactionDescription;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := TransactionAmount;
        //MESSAGE('TransactionAmount %1',TransactionAmount);
        GenJournalLine."External Document No." := ExternalDocumentNo;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Shortcut Dimension 1 Code" := DimensionActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := FnGetUserBranch();
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;

    end;


    procedure FnCreateGnlJournalLineAtm(TemplateName: Text; BatchName: Text; DocumentNo: Code[30]; LineNo: Integer; TransactionType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account"; AccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Member,Investor; AccountNo: Code[50]; TransactionDate: Date; TransactionAmount: Decimal; DimensionActivity: Code[40]; ExternalDocumentNo: Code[50]; TransactionDescription: Text; LoanNumber: Code[50]; TraceID: Code[100])
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := TemplateName;
        GenJournalLine."Journal Batch Name" := BatchName;
        GenJournalLine."Document No." := DocumentNo;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := AccountType;
        GenJournalLine."Account No." := AccountNo;
        GenJournalLine."Transaction Type" := TransactionType;
        GenJournalLine."Loan No" := LoanNumber;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := TransactionDate;
        GenJournalLine.Description := TransactionDescription;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := TransactionAmount;
        GenJournalLine."External Document No." := ExternalDocumentNo;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Shortcut Dimension 1 Code" := DimensionActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := FnGetUserBranch();
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        GenJournalLine."ATM SMS" := true;
        GenJournalLine."Trace ID" := TraceID;
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;
    end;


    procedure FnGetFosaAccountBalance(Acc: Code[30]) Bal: Decimal
    begin
        if ObjVendor.Get(Acc) then begin
            ObjVendor.CalcFields(ObjVendor."Balance (LCY)", ObjVendor."ATM Transactions", ObjVendor."Mobile Transactions", ObjVendor."Uncleared Cheques");
            Bal := ObjVendor."Balance (LCY)" - (ObjVendor."ATM Transactions" + ObjVendor."Mobile Transactions" + FnGetMinimumAllowedBalance(ObjVendor."Account Type"));
        end
    end;

    local procedure FnGetMinimumAllowedBalance(ProductCode: Code[60]) MinimumBalance: Decimal
    begin
        ObjProducts.Reset;
        ObjProducts.SetRange(ObjProducts.Code, ProductCode);
        if ObjProducts.Find('-') then
            MinimumBalance := ObjProducts."Minimum Balance";
    end;

    local procedure FnGetMemberLoanBalance(LoanNo: Code[50]; DateFilter: Date; TotalBalance: Decimal)
    begin
        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Loan  No.", LoanNo);
        ObjLoans.SetFilter(ObjLoans."Date filter", '..%1', DateFilter);
        if ObjMemberLedgerEntry.FindSet then begin
            TotalBalance := TotalBalance + ObjMemberLedgerEntry."Amount (LCY)";
        end;
    end;


    procedure FnGetTellerTillNo() TellerTillNo: Code[40]
    begin
        ObjBanks.Reset;
        ObjBanks.SetRange(ObjBanks."Account Type", ObjBanks."account type"::Cashier);
        ObjBanks.SetRange(ObjBanks.CashierID, UserId);
        if ObjBanks.Find('-') then begin
            TellerTillNo := ObjBanks."No.";
        end;
        exit(TellerTillNo);
    end;


    procedure FnGetMpesaAccount() TellerTillNo: Code[40]
    begin
        ObjBanks.Reset;
        ObjBanks.SetRange(ObjBanks."Account Type", ObjBanks."account type"::Treasury);
        ObjBanks.SetRange(ObjBanks."Bank Branch No.", FnGetUserBranch());
        if ObjBanks.Find('-') then begin
            TellerTillNo := ObjBanks."No.";
        end;
        exit(TellerTillNo);
    end;


    procedure FnGetChargeFee(ProductCode: Code[50]; InsuredAmount: Decimal; ChargeType: Code[100]) FCharged: Decimal
    begin
        if ObjLoanProductSetup.Get(ProductCode) then begin
            ObjProductCharges.Reset;
            ObjProductCharges.SetRange(ObjProductCharges."Product Code", ProductCode);
            ObjProductCharges.SetRange(ObjProductCharges.Code, ChargeType);
            if ObjProductCharges.Find('-') then begin
                if ObjProductCharges."Use Perc" = true then begin
                    FCharged := ROUND(InsuredAmount * (ObjProductCharges.Percentage / 100), 1, '=');
                end
                else
                    FCharged := ObjProductCharges.Amount;
            end;
        end;
        exit(FCharged);
    end;


    procedure FnGetChargeAccount(ProductCode: Code[50]; MemberCategory: Option Single,Joint,Corporate,Group,Parish,Church,"Church Department",Staff; ChargeType: Code[100]) ChargeGLAccount: Code[50]
    begin
        if ObjLoanProductSetup.Get(ProductCode) then begin
            ObjProductCharges.Reset;
            ObjProductCharges.SetRange(ObjProductCharges."Product Code", ProductCode);
            ObjProductCharges.SetRange(ObjProductCharges.Code, ChargeType);
            if ObjProductCharges.Find('-') then begin
                ChargeGLAccount := ObjProductCharges."G/L Account";
            end;
        end;
        exit(ChargeGLAccount);
    end;

    local procedure FnUpdateMonthlyContributions()
    begin
        ObjMembers.Reset;
        ObjMembers.SetCurrentkey(ObjMembers."No.");
        ObjMembers.SetRange(ObjMembers."Monthly Contribution", 0.0);
        if ObjMembers.FindSet then begin
            repeat
                ObjMembers2."Monthly Contribution" := 500;
                ObjMembers2.Modify;
            until ObjMembers.Next = 0;
            Message('Succesfully done');
        end;
    end;


    procedure FnGetUserBranchB(varUserId: Code[100]) branchCode: Code[20]
    begin
        UserSetup.Reset;
        UserSetup.SetRange(UserSetup."User id", varUserId);
        if UserSetup.Find('-') then begin
            branchCode := UserSetup."Branch";
        end;
        exit(branchCode);
    end;


    procedure FnGetMemberBranch(MemberNo: Code[100]) MemberBranch: Code[100]
    var
        ObjMemberLocal: Record Customer;
    begin
        ObjMemberLocal.Reset;
        ObjMemberLocal.SetRange(ObjMemberLocal."No.", MemberNo);
        if ObjMemberLocal.Find('-') then begin
            MemberBranch := ObjMemberLocal."Global Dimension 2 Code";
        end;
        exit(MemberBranch);
    end;

    local procedure FnReturnRetirementDate(MemberNo: Code[50]): Date
    var
        ObjMembers: Record Customer;
    begin
        ObjGenSetUp.Get();
        ObjMembers.Reset;
        ObjMembers.SetRange(ObjMembers."No.", MemberNo);
        if ObjMembers.Find('-') then
            Message(Format(CalcDate(ObjGenSetUp."Retirement Age", ObjMembers."Date of Birth")));
        exit(CalcDate(ObjGenSetUp."Retirement Age", ObjMembers."Date of Birth"));
    end;


    procedure FnGetTransferFee(DisbursementMode: Option " ",Cheque,"Bank Transfer",EFT,RTGS,"Cheque NonMember"): Decimal
    var
        TransferFee: Decimal;
    begin
        ObjGenSetUp.Get();
        case DisbursementMode of
            Disbursementmode::"Bank Transfer":
                TransferFee := ObjGenSetUp."Loan Trasfer Fee-FOSA";

            Disbursementmode::Cheque:
                TransferFee := ObjGenSetUp."Loan Trasfer Fee-Cheque";

            Disbursementmode::"Cheque NonMember":
                TransferFee := ObjGenSetUp."Loan Trasfer Fee-EFT";

            Disbursementmode::EFT:
                TransferFee := ObjGenSetUp."Loan Trasfer Fee-RTGS";
        end;
        exit(TransferFee);
    end;


    procedure FnGetFosaAccount(MemberNo: Code[50]) FosaAccount: Code[50]
    var
        ObjMembers: Record Customer;
    begin
        ObjMembers.Reset;
        ObjMembers.SetRange(ObjMembers."No.", MemberNo);
        if ObjMembers.Find('-') then begin
            FosaAccount := ObjMembers."FOSA Account No.";
        end;
        exit(FosaAccount);
    end;


    procedure FnClearGnlJournalLine(TemplateName: Text; BatchName: Text)
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenJournalLine.Reset;
        GenJournalLine.SetRange(GenJournalLine."Journal Template Name", TemplateName);
        GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", BatchName);
        if GenJournalLine.FindSet then begin
            GenJournalLine.DeleteAll;
        end;
    end;


    procedure FnPostGnlJournalLine(TemplateName: Text; BatchName: Text)
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        /*GenJournalLine.RESET;
        GenJournalLine.SETRANGE(GenJournalLine."Journal Template Name",TemplateName);
        GenJournalLine.SETRANGE(GenJournalLine."Journal Batch Name",BatchName);
        IF GenJournalLine.FINDSET THEN BEGIN
          CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch",GenJournalLine);
          END;
        */

    end;


    procedure FnCreateGnlJournalLineBalanced(TemplateName: Text; BatchName: Text; DocumentNo: Code[30]; LineNo: Integer; TransactionType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account","Loan Insurance Charged","Loan Insurance Paid"; AccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee,Member,Investor; AccountNo: Code[50]; TransactionDate: Date; TransactionDescription: Text; BalancingAccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Member,Investor; BalancingAccountNo: Code[50]; TransactionAmount: Decimal; DimensionActivity: Code[40]; LoanNo: Code[20])
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := TemplateName;
        GenJournalLine."Journal Batch Name" := BatchName;
        GenJournalLine."Document No." := DocumentNo;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Transaction Type" := TransactionType;
        GenJournalLine."Account Type" := AccountType;
        GenJournalLine."Account No." := AccountNo;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := PostingDate;
        GenJournalLine.Description := TransactionDescription;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := TransactionAmount;
        GenJournalLine."Loan No" := LoanNo;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Bal. Account Type" := BalancingAccountType;
        GenJournalLine."Bal. Account No." := BalancingAccountNo;
        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
        GenJournalLine."Shortcut Dimension 1 Code" := DimensionActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := FnGetUserBranch();
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;
    end;


    procedure FnChargeExcise(ChargeCode: Code[100]): Boolean
    var
        ObjProductCharges: Record 51382;
    begin
        ObjProductCharges.Reset;
        ObjProductCharges.SetRange(Code, ChargeCode);
        if ObjProductCharges.Find('-') then
            exit(ObjProductCharges."Charge Excise");
    end;


    procedure FnGetInterestDueTodate(ObjLoans: Record "Loans Register"): Decimal
    var
        ObjLoanRegister: Record "Loans Register";
    begin
        ObjLoans.SetFilter("Date filter", '..' + Format(Today));
        ObjLoans.CalcFields("Schedule Interest to Date", "Outstanding Balance");
        exit(ObjLoans."Schedule Interest to Date");
    end;


    procedure FnGetPhoneNumber(ObjLoans: Record "Loans Register"): Code[50]
    begin
        ObjMembers.Reset;
        ObjMembers.SetRange("No.", ObjLoans."Client Code");
        if ObjMembers.Find('-') then
            exit(ObjMembers."Mobile Phone No");
    end;

    local procedure FnBoosterLoansDisbursement(ObjLoanDetails: Record "Loans Register"): Code[40]
    var
        GenJournalLine: Record "Gen. Journal Line";
        CUNoSeriesManagement: Codeunit "No. Series";
        DocNumber: Code[100];
        loanTypes: Record "Loan Products Setup";
        ObjLoanX: Record "Loans Register";
        LoansRec: Record "Loans Register";
        Cust: Record Customer;
    begin
        loanTypes.Reset;
        loanTypes.SetRange(loanTypes.Code, 'BLOAN');
        if loanTypes.Find('-') then begin
            DocNumber := CUNoSeriesManagement.GetNextNo('LOANSB', 0D, true);
            LoansRec.Init;
            LoansRec."Loan  No." := DocNumber;
            // LoansRec.INSERT;

            if LoansRec.Get('BLN_00041') then begin
                LoansRec."Client Code" := ObjLoanDetails."Client Code";
                LoansRec.Validate(LoansRec."Client Code");
                LoansRec."Loan Product Type" := 'BLOAN';
                LoansRec.Validate(LoansRec."Loan Product Type");
                LoansRec.Interest := ObjLoanDetails.Interest;
                LoansRec."Loan Status" := LoansRec."loan status"::Issued;
                LoansRec."Application Date" := ObjLoanDetails."Application Date";
                LoansRec."Issued Date" := ObjLoanDetails."Posting Date";
                LoansRec."Loan Disbursement Date" := ObjLoanDetails."Loan Disbursement Date";
                LoansRec.Validate(LoansRec."Loan Disbursement Date");
                LoansRec."Mode of Disbursement" := LoansRec."mode of disbursement"::"Bank Transfer";
                LoansRec."Repayment Start Date" := ObjLoanDetails."Repayment Start Date";
                LoansRec."Global Dimension 1 Code" := 'BOSA';
                LoansRec."Global Dimension 2 Code" := FnGetUserBranch();
                LoansRec.Source := ObjLoanDetails.Source;
                LoansRec."Approval Status" := ObjLoanDetails."Approval Status";
                LoansRec.Repayment := ObjLoanDetails."Boosted Amount";
                LoansRec."Requested Amount" := ObjLoanDetails."Boosted Amount";
                LoansRec."Approved Amount" := ObjLoanDetails."Boosted Amount";
                LoansRec.Interest := ObjLoanDetails.Interest;
                LoansRec."Mode of Disbursement" := LoansRec."mode of disbursement"::"Bank Transfer";
                LoansRec.Posted := true;
                LoansRec."Advice Date" := Today;
                LoansRec.Modify;
            end;
        end;
        exit(DocNumber);
    end;


    procedure FnGenerateRepaymentSchedule(LoanNumber: Code[50])
    var
        LoansRec: Record "Loans Register";
        RSchedule: Record "Loan Repayment Schedule";
        LoanAmount: Decimal;
        InterestRate: Decimal;
        RepayPeriod: Integer;
        InitialInstal: Decimal;
        LBalance: Decimal;
        RunDate: Date;
        InstalNo: Decimal;
        TotalMRepay: Decimal;
        LInterest: Decimal;
        LPrincipal: Decimal;
        GrPrinciple: Integer;
        GrInterest: Integer;
        RepayCode: Code[10];
        WhichDay: Integer;
        LoanProductsSetup: Record "Loan Products Setup";
    begin
        //MESSAGE('here');
        LoansRec.Reset;
        LoansRec.SetRange(LoansRec."Loan  No.", LoanNumber);
        LoansRec.SetFilter(LoansRec."Approved Amount", '>%1', 0);
        //LoansRec.SETFILTER(LoansRec.Posted,'=%1',TRUE);
        if LoansRec.Find('-') then begin
            // MESSAGE('1here');

            if ((LoansRec."Issued Date" <> 0D) and (LoansRec."Repayment Start Date" <> 0D)) then begin
                LoansRec.TestField(LoansRec."Loan Disbursement Date");
                LoansRec.TestField(LoansRec."Repayment Start Date");
                // MESSAGE('2here');
                RSchedule.Reset;
                RSchedule.SetRange(RSchedule."Loan No.", LoansRec."Loan  No.");
                RSchedule.DeleteAll;

                //LoanAmount:=LoansRec."Approved Amount";
                LoanAmount := LoansRec."Approved Amount";
                Insurance := LoansRec.Insurance;
                InterestRate := LoansRec.Interest;
                RepayPeriod := LoansRec.Installments;
                InitialInstal := LoansRec.Installments + LoansRec."Grace Period - Principle (M)";
                LBalance := LoansRec."Approved Amount";
                //LBalance:=LoansRec."Approved Amount";
                RunDate := LoansRec."Repayment Start Date";
                InstalNo := 0;

                //Installment 0

                RSchedule.Init;
                RSchedule."Repayment Code" := RepayCode;
                RSchedule."Interest Rate" := InterestRate;
                RSchedule."Loan No." := LoansRec."Loan  No.";
                RSchedule."Loan Amount" := LoanAmount;
                RSchedule."Instalment No" := InstalNo;
                RSchedule."Monthly Insurance" := Insurance;
                RSchedule."Repayment Date" := 0D;//CALCDATE('CM',RunDate);
                RSchedule."Member No." := LoansRec."Client Code";
                RSchedule."Loan Category" := LoansRec."Loan Product Type";
                if (LoansRec."Loan Product Type" = 'SUKUMA') or (LoansRec."Loan Product Type" = 'KARIBU') or (LoansRec."Loan Product Type" = 'INSTANT') then
                    RSchedule."Monthly Repayment" := LPrincipal
                else
                    RSchedule."Monthly Repayment" := LInterest + LPrincipal;
                if LoansRec."Loan Product Type" = 'SUKUMA' then
                    RSchedule."Monthly Interest" := LoansRec."Loan Interest Repayment";
                RSchedule."Principal Repayment" := LPrincipal;
                RSchedule."Loan Balance" := LBalance;
                RSchedule.Insert;

                //Repayment Frequency
                //IF RunDate<>0D then BEGIN
                if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Daily then
                    RunDate := CalcDate('-1D', RunDate)
                else if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Weekly then
                    RunDate := CalcDate('-1W', RunDate)
                else if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Monthly then
                    RunDate := CalcDate('-1M', RunDate)
                else if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Quaterly then
                    RunDate := CalcDate('-1Q', RunDate);

                // IF LoansRec."Repayment Frequency"=LoansRec."Repayment Frequency"::Daily THEN
                // RunDate:=CALCDATE('1D',RunDate)
                // ELSE IF LoansRec."Repayment Frequency"=LoansRec."Repayment Frequency"::Weekly THEN
                // RunDate:=CALCDATE('1W',RunDate)
                // ELSE IF LoansRec."Repayment Frequency"=LoansRec."Repayment Frequency"::Monthly THEN
                // RunDate:=CALCDATE('1M',RunDate)
                // ELSE IF LoansRec."Repayment Frequency"=LoansRec."Repayment Frequency"::Quaterly THEN
                // RunDate:=CALCDATE('1Q',RunDate);
                // //Repayment Frequency
                //
                //  MESSAGE(FORMAT(RunDate));
                repeat
                    //IF RunDate<>0D then
                    InstalNo := InstalNo + 1;
                    //Repayment Frequency
                    if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Daily then
                        RunDate := CalcDate('1D', RunDate)
                    else if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Weekly then
                        RunDate := CalcDate('1W', RunDate)
                    else if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Monthly then
                        RunDate := CalcDate('1M', RunDate)
                    else if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Quaterly then
                        RunDate := CalcDate('1Q', RunDate);

                    LoanProductsSetup.Get(LoansRec."Loan Product Type");
                    if LoanProductsSetup."Interest rate" = 0 then begin
                        LoansRec.TestField(LoansRec.Installments);
                        LPrincipal := LoanAmount / RepayPeriod;
                    end;

                    if InterestRate > 0 then begin
                        if LoansRec."Repayment Method" = LoansRec."repayment method"::Amortised then begin
                            LoansRec.TestField(LoansRec.Installments);
                            TotalMRepay := ROUND((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -(RepayPeriod))) * (LoanAmount), 0.0001, '>');
                            LInterest := ROUND(LBalance / 100 / 12 * InterestRate, 0.0001, '>');
                            LPrincipal := TotalMRepay - LInterest;
                        end;

                        if LoansRec."Repayment Method" = LoansRec."repayment method"::"Straight Line" then begin
                            LoansRec.TestField(LoansRec.Interest);
                            LoansRec.TestField(LoansRec.Installments);
                            LPrincipal := LoanAmount / RepayPeriod;
                            ///LInterest:=(InterestRate/12/100)*LoanAmount/RepayPeriod;
                            LInterest := (InterestRate / 12 / 100) * LoanAmount;

                        end;

                        if LoansRec."Repayment Method" = LoansRec."repayment method"::"Reducing Balance" then begin
                            LoansRec.TestField(LoansRec.Interest);
                            LoansRec.TestField(LoansRec.Installments);
                            LPrincipal := LoanAmount / RepayPeriod;
                            LInterest := (InterestRate / 12 / 100) * LBalance;
                        end;
                    end;
                    if LoansRec."Repayment Method" = LoansRec."repayment method"::Constants then begin
                        LoansRec.TestField(LoansRec.Repayment);
                        if LBalance < LoansRec.Repayment then
                            LPrincipal := LBalance
                        else
                            LPrincipal := LoansRec.Repayment;
                        LInterest := LoansRec.Interest;
                    end;

                    //Grace Period
                    if GrPrinciple > 0 then begin
                        LPrincipal := 0
                    end else begin
                        LBalance := LBalance - LPrincipal;

                    end;

                    if GrInterest > 0 then
                        LInterest := 0;

                    GrPrinciple := GrPrinciple - 1;
                    GrInterest := GrInterest - 1;
                    Evaluate(RepayCode, Format(InstalNo));


                    RSchedule.Init;
                    RSchedule."Repayment Code" := RepayCode;
                    RSchedule."Interest Rate" := InterestRate;
                    RSchedule."Loan No." := LoansRec."Loan  No.";
                    RSchedule."Loan Amount" := LoanAmount;
                    RSchedule."Instalment No" := InstalNo;
                    RSchedule."Repayment Date" := CalcDate('CM', RunDate);
                    RSchedule."Member No." := LoansRec."Client Code";
                    RSchedule."Loan Category" := LoansRec."Loan Product Type";
                    if (LoansRec."Loan Product Type" = 'SUKUMA') or (LoansRec."Loan Product Type" = 'KARIBU') or (LoansRec."Loan Product Type" = 'INSTANT') then
                        RSchedule."Monthly Repayment" := LPrincipal
                    else
                        RSchedule."Monthly Repayment" := LInterest + LPrincipal;
                    if LoansRec."Loan Product Type" <> 'SUKUMA' then
                        RSchedule."Monthly Interest" := LInterest;
                    RSchedule."Principal Repayment" := LPrincipal;
                    RSchedule."Loan Balance" := LBalance;
                    RSchedule.Insert;
                    WhichDay := Date2dwy(RSchedule."Repayment Date", 1);
                until LBalance < 1
                //UNTIL InstalNo =0;

            end;
        end;
        //END ;
        Commit;
    end;


    procedure FnGetInterestDueFiltered(ObjLoans: Record "Loans Register"; DateFilter: Text): Decimal
    var
        ObjLoanRegister: Record "Loans Register";
    begin
        ObjLoans.SetFilter("Date filter", DateFilter);
        //ObjLoans.CALCFIELDS("Schedule Interest to Date","Outstanding Balance");
        ObjLoans.CalcFields("Interest Due", "Outstanding Balance");
        exit(ObjLoans."Interest Due");
    end;


    procedure FnGetPAYEBudCharge(ChargeCode: Code[10]): Decimal
    var
        ObjpayeCharges: Record 51478;
    begin
        ObjpayeCharges.Reset;
        ObjpayeCharges.SetRange("Tax Band", ChargeCode);
        if ObjpayeCharges.FindFirst then
            exit(ObjpayeCharges."Taxable Amount" * ObjpayeCharges.Percentage / 100);
    end;


    procedure FnPayeRate(ChargeCode: Code[10]): Decimal
    var
        ObjpayeCharges: Record 51478;
    begin
        ObjpayeCharges.Reset;
        ObjpayeCharges.SetRange("Tax Band", ChargeCode);
        if ObjpayeCharges.FindFirst then
            exit(ObjpayeCharges.Percentage / 100);
    end;


    procedure FnCalculatePaye(Chargeable: Decimal) PAYE: Decimal
    var
        TAXABLEPAY: Record 51478;
        Taxrelief: Decimal;
        OTrelief: Decimal;
    begin
        PAYE := 0;
        if TAXABLEPAY.Find('-') then begin
            repeat
                if Chargeable > 0 then begin
                    case TAXABLEPAY."Tax Band" of
                        '01':
                            begin
                                if Chargeable > TAXABLEPAY."Upper Limit" then begin
                                    BAND1 := FnGetPAYEBudCharge('01');
                                    Chargeable := Chargeable - TAXABLEPAY."Taxable Amount";
                                end else begin
                                    if Chargeable > TAXABLEPAY."Taxable Amount" then begin
                                        BAND1 := FnGetPAYEBudCharge('01');
                                        Chargeable := Chargeable - TAXABLEPAY."Taxable Amount";
                                    end else begin
                                        BAND1 := Chargeable * FnPayeRate('01');
                                        Chargeable := 0;
                                    end;
                                end;
                            end;
                        '02':
                            begin
                                if Chargeable > TAXABLEPAY."Upper Limit" then begin
                                    BAND2 := FnGetPAYEBudCharge('02');
                                    Chargeable := Chargeable - TAXABLEPAY."Taxable Amount";
                                end else begin
                                    if Chargeable > TAXABLEPAY."Taxable Amount" then begin
                                        BAND2 := FnGetPAYEBudCharge('02');
                                        Chargeable := Chargeable - TAXABLEPAY."Taxable Amount";
                                    end else begin
                                        BAND2 := Chargeable * FnPayeRate('02');
                                        Chargeable := 0;
                                    end;
                                end;
                            end;
                        '03':
                            begin
                                if Chargeable > TAXABLEPAY."Upper Limit" then begin
                                    BAND3 := FnGetPAYEBudCharge('03');
                                    Chargeable := Chargeable - TAXABLEPAY."Taxable Amount";
                                end else begin
                                    if Chargeable > TAXABLEPAY."Taxable Amount" then begin
                                        BAND3 := FnGetPAYEBudCharge('03');
                                        Chargeable := Chargeable - TAXABLEPAY."Taxable Amount";
                                    end else begin
                                        BAND3 := Chargeable * FnPayeRate('03');
                                        Chargeable := 0;
                                    end;
                                end;
                            end;
                        '04':
                            begin
                                if Chargeable > TAXABLEPAY."Upper Limit" then begin
                                    BAND4 := FnGetPAYEBudCharge('04');
                                    Chargeable := Chargeable - TAXABLEPAY."Taxable Amount";
                                end else begin
                                    if Chargeable > TAXABLEPAY."Taxable Amount" then begin
                                        BAND4 := FnGetPAYEBudCharge('04');
                                        Chargeable := Chargeable - TAXABLEPAY."Taxable Amount";
                                    end else begin
                                        BAND4 := Chargeable * FnPayeRate('04');
                                        Chargeable := 0;
                                    end;
                                end;
                            end;
                        '05':
                            begin
                                BAND5 := Chargeable * FnPayeRate('05');
                            end;
                    end;
                end;
            until TAXABLEPAY.Next = 0;
        end;
        exit(BAND1 + BAND2 + BAND3 + BAND4 + BAND5 - 1408);
    end;


    procedure FnGetUpfrontsTotal(ProductCode: Code[50]; InsuredAmount: Decimal) FCharged: Decimal
    var
        ObjLoanCharges: Record 51382;
    begin
        ObjProductCharges.Reset;
        ObjProductCharges.SetRange(ObjProductCharges."Product Code", ProductCode);
        if ObjProductCharges.Find('-') then begin
            repeat
                if ObjProductCharges."Use Perc" = true then begin
                    FCharged := InsuredAmount * (ObjProductCharges.Percentage / 100) + FCharged;
                    if ObjLoanCharges.Get(ObjProductCharges.Code) then begin
                        if ObjLoanCharges."Charge Excise" = true then
                            FCharged := FCharged + (InsuredAmount * (ObjProductCharges.Percentage / 100)) * 0.1;
                    end
                end
                else begin
                    FCharged := ObjProductCharges.Amount + FCharged;
                    if ObjLoanCharges.Get(ObjProductCharges.Code) then begin
                        if ObjLoanCharges."Charge Excise" = true then
                            FCharged := FCharged + ObjProductCharges.Amount * 0.1;
                    end
                end

            until ObjProductCharges.Next = 0;
        end;

        exit(FCharged);
    end;


    procedure FnGetPrincipalDueFiltered(ObjLoans: Record "Loans Register"; DateFilter: Text): Decimal
    var
        ObjLoanRegister: Record "Loans Register";
    begin
        ObjLoans.SetFilter("Date filter", DateFilter);
        ObjLoans.CalcFields("Scheduled Principal to Date", "Outstanding Balance");
        exit(ObjLoans."Scheduled Principal to Date");
    end;


    procedure FnCreateMembershipWithdrawalApplication(MemberNo: Code[20]; ApplicationDate: Date; Reason: Option Relocation,"Financial Constraints","House/Group Challages","Join another Institution","Personal Reasons",Other; ClosureDate: Date)
    begin
        PostingDate := ObjMembershipWithdrawal."Posting Date";
        ObjSalesSetup.Get;
        //ObjNextNo := ObjNoSeriesManagement.TryGetNextNo(ObjSalesSetup."Closure  Nos", PostingDate);
        ObjNoSeries.Reset;
        ObjNoSeries.SetRange(ObjNoSeries."Series Code", ObjSalesSetup."Closure  Nos");
        if ObjNoSeries.FindSet then begin
            ObjNoSeries."Last No. Used" := IncStr(ObjNoSeries."Last No. Used");
            ObjNoSeries."Last Date Used" := Today;
            ObjNoSeries.Modify;
        end;


        ObjMembershipWithdrawal.Init;
        ObjMembershipWithdrawal."No." := ObjNextNo;
        ObjMembershipWithdrawal."Member No." := MemberNo;
        if ObjMembers.Get(MemberNo) then begin
            ObjMembershipWithdrawal."Member Name" := ObjMembers.Name;
        end;
        ObjMembershipWithdrawal."Withdrawal Application Date" := ApplicationDate;
        ObjMembershipWithdrawal."Closing Date" := ClosureDate;
        ObjMembershipWithdrawal."Posting Date" := PostingDate;
        ObjMembershipWithdrawal."Reason For Withdrawal" := Reason;
        ObjMembershipWithdrawal.Insert;

        ObjMembershipWithdrawal.Validate(ObjMembershipWithdrawal."Member No.");
        ObjMembershipWithdrawal.Modify;

        Message('Withdrawal Application Created Succesfully,Application No  %1 ', ObjNextNo);
    end;

    local procedure FnGetDepreciationValueofCollateral()
    begin
    end;


    procedure FnGetLoanAmountinArrears(VarLoanNo: Code[20]) VarArrears: Decimal
    begin
        VarRepaymentPeriod := Date;
        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNo);
        if ObjLoans.FindSet then begin
            ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Interest Due", ObjLoans."Oustanding Interest", ObjLoans."Penalty Charged");
            VarLoanNo := ObjLoans."Loan  No.";

            //================Get Last Day of the previous month===================================
            if ObjLoans."Repayment Frequency" = ObjLoans."repayment frequency"::Monthly then begin
                if VarRepaymentPeriod = CalcDate('CM', VarRepaymentPeriod) then begin
                    VarLastMonth := VarRepaymentPeriod;
                end else begin
                    VarLastMonth := CalcDate('-1M', VarRepaymentPeriod);
                end;
                VarLastMonth := CalcDate('CM', VarLastMonth);
            end;
            VarDate := 1;
            VarMonth := Date2dmy(VarLastMonth, 2);
            VarYear := Date2dmy(VarLastMonth, 3);
            VarLastMonthBeginDate := Dmy2date(VarDate, VarMonth, VarYear);
            VarScheduleDateFilter := Format(VarLastMonthBeginDate) + '..' + Format(VarLastMonth);
            //End ===========Get Last Day of the previous month==========================================


            //================Get Scheduled Balance=======================================================
            ObjLSchedule.Reset;
            ObjLSchedule.SetRange(ObjLSchedule."Loan No.", VarLoanNo);
            ObjLSchedule.SetRange(ObjLSchedule."Close Schedule", false);
            ObjLSchedule.SetFilter(ObjLSchedule."Repayment Date", VarScheduleDateFilter);
            if ObjLSchedule.FindFirst then begin
                VarScheduledLoanBal := ObjLSchedule."Loan Balance";
                VarScheduleRepayDate := ObjLSchedule."Repayment Date";
            end;

            ObjLSchedule.Reset;
            ObjLSchedule.SetCurrentkey(ObjLSchedule."Repayment Date");
            ObjLSchedule.SetRange(ObjLSchedule."Loan No.", VarLoanNo);
            ObjLSchedule.SetRange(ObjLSchedule."Close Schedule", false);
            if ObjLSchedule.FindLast then begin
                if ObjLSchedule."Repayment Date" < Today then begin
                    VarScheduledLoanBal := ObjLSchedule."Loan Balance";
                    VarScheduleRepayDate := ObjLSchedule."Repayment Date";
                end;
            end;
            //================End Get Scheduled Balance====================================================

            //================Get Loan Bal as per the date filter===========================================
            if VarScheduleRepayDate <> 0D then begin
                VarDateFilter := '..' + Format(VarScheduleRepayDate);
                ObjLoans.SetFilter(ObjLoans."Date filter", VarDateFilter);
                ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                VarLBal := ObjLoans."Outstanding Balance";
                //===============End Get Loan Bal as per the date filter=========================================

                VarLBal := ObjLoans."Outstanding Balance";

                //============Amount in Arrears================================================================
                VarArrears := VarScheduledLoanBal - VarLBal;
                if (VarArrears > 0) or (VarArrears = 0) then begin
                    VarArrears := 0
                end else
                    VarArrears := VarArrears;
            end;
        end;
        exit(VarArrears * -1);
    end;


    procedure FnCreateGnlJournalLineGuarantorRecovery(TemplateName: Text; BatchName: Text; DocumentNo: Code[30]; LineNo: Integer; TransactionType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account"; AccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee,Member,Investor; AccountNo: Code[50]; TransactionDate: Date; TransactionAmount: Decimal; DimensionActivity: Code[40]; ExternalDocumentNo: Code[50]; TransactionDescription: Text; LoanNumber: Code[50]; VarRecoveryType: Option Normal,"Guarantor Recoverd","Guarantor Paid"; VarLoanRecovered: Code[20])
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := TemplateName;
        GenJournalLine."Journal Batch Name" := BatchName;
        GenJournalLine."Document No." := DocumentNo;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := AccountType;
        GenJournalLine."Account No." := AccountNo;
        GenJournalLine."Transaction Type" := TransactionType;
        GenJournalLine."Loan No" := LoanNumber;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := TransactionDate;
        GenJournalLine.Description := TransactionDescription;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := TransactionAmount;
        GenJournalLine."External Document No." := ExternalDocumentNo;
        GenJournalLine."Recovery Transaction Type" := VarRecoveryType;
        GenJournalLine."Recoverd Loan" := VarLoanRecovered;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Shortcut Dimension 1 Code" := DimensionActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := FnGetUserBranch();
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;
    end;


    procedure FnGetMemberApplicationAMLRiskRating(MemberNo: Code[20]; VarIndividualCategory: Option "Politically Exposed Persons (PEPs)","High Net worth",Other,"Publicly Held Companies","Privately Held Companies","Domestic Government Entities",Churches,SMEs,Schools,"Welfare Groups","Financial entities Regulated by local regulators",Resident,"Non-Resident","Money Services Businesses","Charities and Non-Profit Organizations",Trusts,"Real Estate Agencies","High Value Goods Businesses","Precious Metals Businesses","Cash Intensive Businesses","Art Galleries & related businesses","Professional Service Providers","None of the above industries","0 – 1 Year","1 – 3 Years","Trade/Export Finance","Local Trade"; VarEntities: Option "Politically Exposed Persons (PEPs)","High Net worth",Other,"Publicly Held Companies","Privately Held Companies","Domestic Government Entities",Churches,SMEs,Schools,"Welfare Groups","Financial entities Regulated by local regulators",Resident,"Non-Resident","Money Services Businesses","Charities and Non-Profit Organizations",Trusts,"Real Estate Agencies","High Value Goods Businesses","Precious Metals Businesses","Cash Intensive Businesses","Art Galleries & related businesses","Professional Service Providers","None of the above industries","0 – 1 Year","1 – 3 Years","Trade/Export Finance","Local Trade"; VarResidency: Option "Politically Exposed Persons (PEPs)","High Net worth",Other,"Publicly Held Companies","Privately Held Companies","Domestic Government Entities",Churches,SMEs,Schools,"Welfare Groups","Financial entities Regulated by local regulators",Resident,"Non-Resident","Money Services Businesses","Charities and Non-Profit Organizations",Trusts,"Real Estate Agencies","High Value Goods Businesses","Precious Metals Businesses","Cash Intensive Businesses","Art Galleries & related businesses","Professional Service Providers","None of the above industries","0 – 1 Year","1 – 3 Years","Trade/Export Finance","Local Trade"; VarIndustryType: Option "Politically Exposed Persons (PEPs)","High Net worth",Other,"Publicly Held Companies","Privately Held Companies","Domestic Government Entities",Churches,SMEs,Schools,"Welfare Groups","Financial entities Regulated by local regulators",Resident,"Non-Resident","Money Services Businesses","Charities and Non-Profit Organizations",Trusts,"Real Estate Agencies","High Value Goods Businesses","Precious Metals Businesses","Cash Intensive Businesses","Art Galleries & related businesses","Professional Service Providers","None of the above industries","0 – 1 Year","1 – 3 Years","Trade/Export Finance","Local Trade"; VarLenghtOfRelationship: Option "Politically Exposed Persons (PEPs)","High Net worth",Other,"Publicly Held Companies","Privately Held Companies","Domestic Government Entities",Churches,SMEs,Schools,"Welfare Groups","Financial entities Regulated by local regulators",Resident,"Non-Resident","Money Services Businesses","Charities and Non-Profit Organizations",Trusts,"Real Estate Agencies","High Value Goods Businesses","Precious Metals Businesses","Cash Intensive Businesses","Art Galleries & related businesses","Professional Service Providers","None of the above industries","0 – 1 Year","1 – 3 Years","Trade/Export Finance","Local Trade"; VarInternationalTrade: Option "Politically Exposed Persons (PEPs)","High Net worth",Other,"Publicly Held Companies","Privately Held Companies","Domestic Government Entities",Churches,SMEs,Schools,"Welfare Groups","Financial entities Regulated by local regulators",Resident,"Non-Resident","Money Services Businesses","Charities and Non-Profit Organizations",Trusts,"Real Estate Agencies","High Value Goods Businesses","Precious Metals Businesses","Cash Intensive Businesses","Art Galleries & related businesses","Professional Service Providers","None of the above industries","0 – 1 Year","1 – 3 Years","Trade/Export Finance","Local Trade"; VarCardType: Option "International Wire Transfers","Local Wire Transfers","Mobile Transfers","None of the Above","Fixed/Call Deposit Accounts","FOSA(KSA",Imara," MJA","Heritage)","Account with Sealed Safe deposit","Account with  Open Safe Deposit","All Loan Accounts",BOSA," Ufalme","ATM Debit",Credit,Both,"None","Non-face to face channels","Unsolicited Account Origination e.g. Walk-Ins","Cheque book",Others; VarChannelTaken: Option "International Wire Transfers","Local Wire Transfers","Mobile Transfers","None of the Above","Fixed/Call Deposit Accounts","FOSA(KSA",Imara," MJA","Heritage)","Account with Sealed Safe deposit","Account with  Open Safe Deposit","All Loan Accounts",BOSA," Ufalme","ATM Debit",Credit,Both,"None","Non-face to face channels","Unsolicited Account Origination e.g. Walk-Ins","Cheque book",Others; VarElectronicPayment: Option "International Wire Transfers","Local Wire Transfers","Mobile Transfers","None of the Above","Fixed/Call Deposit Accounts","FOSA(KSA",Imara," MJA","Heritage)","Account with Sealed Safe deposit","Account with  Open Safe Deposit","All Loan Accounts",BOSA," Ufalme","ATM Debit",Credit,Both,"None","Non-face to face channels","Unsolicited Account Origination e.g. Walk-Ins","Cheque book",Others; VarAccountType: Option "International Wire Transfers","Local Wire Transfers","Mobile Transfers","None of the Above","Fixed/Call Deposit Accounts","FOSA(KSA",Imara," MJA","Heritage)","Account with Sealed Safe deposit","Account with  Open Safe Deposit","All Loan Accounts",BOSA," Ufalme","ATM Debit",Credit,Both,"None","Non-face to face channels","Unsolicited Account Origination e.g. Walk-Ins","Cheque book",Others)
    var
        VarCategoryScore: Integer;
        VarResidencyScore: Integer;
        VarNatureofBusinessScore: Integer;
        VarEntityScore: Integer;
        VarIndustryScore: Integer;
        VarLenghtOfRelationshipScore: Integer;
        VarInternationalTradeScore: Integer;
        VarElectronicPaymentScore: Integer;
        VarCardTypeScore: Integer;
        VarAccountTypeScore: Integer;
        VarChannelTakenScore: Integer;
        VarAccountTypeOption: Option "International Wire Transfers","Local Wire Transfers","Mobile Transfers","None of the Above","Fixed/Call Deposit Accounts","FOSA(KSA",Imara," MJA","Heritage)","Account with Sealed Safe deposit","Account with  Open Safe Deposit","All Loan Accounts",BOSA," Ufalme","ATM Debit",Credit,Both,"None","Non-face to face channels","Unsolicited Account Origination e.g. Walk-Ins","Cheque book",Others;
        MemberTotalRiskRatingScore: Decimal;
        MemberNetRiskScore: Decimal;
    begin


        ObjMembershipApplication.Reset;
        ObjMembershipApplication.SetRange(ObjMembershipApplication."No.", MemberNo);
        if ObjMembershipApplication.FindSet then begin
            ObjCustRiskRates.Reset;
            ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::Individuals);
            ObjCustRiskRates.SetRange(ObjCustRiskRates."Sub Category Option", VarIndividualCategory);
            if ObjCustRiskRates.FindSet then begin
                VarCategoryScore := ObjCustRiskRates."Risk Score";
            end;
        end;


        ObjMembershipApplication.Reset;
        ObjMembershipApplication.SetRange(ObjMembershipApplication."No.", MemberNo);
        if ObjMembershipApplication.FindSet then begin
            ObjCustRiskRates.Reset;
            ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::Entities);
            ObjCustRiskRates.SetRange(ObjCustRiskRates."Sub Category Option", VarEntities);
            if ObjCustRiskRates.FindSet then begin
                VarEntityScore := ObjCustRiskRates."Risk Score";
            end;
        end;

        ObjMembershipApplication.Reset;
        ObjMembershipApplication.SetRange(ObjMembershipApplication."No.", MemberNo);
        if ObjMembershipApplication.FindSet then begin
            ObjCustRiskRates.Reset;
            ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::"Residency Status");
            ObjCustRiskRates.SetRange(ObjCustRiskRates."Sub Category Option", VarResidency);
            if ObjCustRiskRates.FindSet then begin
                VarResidencyScore := ObjCustRiskRates."Risk Score";
            end;
        end;

        ObjMembershipApplication.Reset;
        ObjMembershipApplication.SetRange(ObjMembershipApplication."No.", MemberNo);
        if ObjMembershipApplication.FindSet then begin
            ObjCustRiskRates.Reset;
            ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::Industry);
            ObjCustRiskRates.SetRange(ObjCustRiskRates."Sub Category Option", VarIndustryType);
            if ObjCustRiskRates.FindSet then begin
                VarIndustryScore := ObjCustRiskRates."Risk Score";
            end;
        end;

        ObjMembershipApplication.Reset;
        ObjMembershipApplication.SetRange(ObjMembershipApplication."No.", MemberNo);
        if ObjMembershipApplication.FindSet then begin
            ObjCustRiskRates.Reset;
            ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::"Length Of Relationship");
            ObjCustRiskRates.SetRange(ObjCustRiskRates."Sub Category Option", VarLenghtOfRelationship);
            if ObjCustRiskRates.FindSet then begin
                VarLenghtOfRelationshipScore := ObjCustRiskRates."Risk Score";
            end;
        end;

        ObjMembershipApplication.Reset;
        ObjMembershipApplication.SetRange(ObjMembershipApplication."No.", MemberNo);
        if ObjMembershipApplication.FindSet then begin
            ObjCustRiskRates.Reset;
            ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::"International Trade");
            ObjCustRiskRates.SetRange(ObjCustRiskRates."Sub Category Option", VarInternationalTrade);
            if ObjCustRiskRates.FindSet then begin
                VarInternationalTradeScore := ObjCustRiskRates."Risk Score";
            end;
        end;


        ObjMembershipApplication.Reset;
        ObjMembershipApplication.SetRange(ObjMembershipApplication."No.", MemberNo);
        if ObjMembershipApplication.FindSet then begin
            ObjProductRiskRating.Reset;
            ObjProductRiskRating.SetCurrentkey(ObjProductRiskRating."Product Type Code");
            ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Category", ObjProductRiskRating."product category"::"Electronic Payment");
            ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Type", VarElectronicPayment);
            if ObjProductRiskRating.FindSet then begin
                VarElectronicPaymentScore := ObjProductRiskRating."Risk Score";
            end;
        end;


        //ObjProductRiskRating.GET();
        ObjMembershipApplication.Reset;
        ObjMembershipApplication.SetRange(ObjMembershipApplication."No.", MemberNo);
        if ObjMembershipApplication.FindSet then begin

            ObjProductRiskRating.Reset;
            ObjProductRiskRating.SetCurrentkey(ObjProductRiskRating."Product Type Code");
            ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Category", ObjProductRiskRating."product category"::Cards);
            //ObjProductRiskRating.SETRANGE(ObjProductRiskRating."Product Type",ObjMembershipApplication."Cards Type Taken");//VarCardType
            if ObjProductRiskRating.FindSet then begin
                VarCardTypeScore := ObjProductRiskRating."Risk Score";
            end;
        end;

        ObjProductRiskRating.Reset;
        ObjProductRiskRating.SetCurrentkey(ObjProductRiskRating."Product Type Code");
        ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Category", ObjProductRiskRating."product category"::Accounts);
        ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Type", VarAccountType);
        if ObjCustRiskRates.FindSet then begin
            VarAccountTypeScore := ObjProductRiskRating."Risk Score";
        end;

        ObjProductRiskRating.Reset;
        ObjProductRiskRating.SetCurrentkey(ObjProductRiskRating."Product Type Code");
        ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Category", ObjProductRiskRating."product category"::Others);
        ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Type", VarChannelTaken);
        if ObjCustRiskRates.FindSet then begin
            VarChannelTakenScore := ObjProductRiskRating."Risk Score";
        end;

        ObjProductsApp.Reset;
        ObjProductsApp.SetRange(ObjProductsApp."Membership Applicaton No", MemberNo);
        ObjProductsApp.SetFilter(ObjProductsApp."Product Source", '<>%1', ObjProductsApp."product source"::BOSA);
        if ObjProductsApp.FindSet then begin
            repeat
                ObjProductRiskRating.Reset;
                ObjProductRiskRating.SetCurrentkey(ObjProductRiskRating."Product Type");
                ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Category", ObjProductRiskRating."product category"::Accounts);
                ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Type", ObjProductRiskRating."product type"::BOSA);
                if ObjCustRiskRates.FindSet then begin
                    VarAccountTypeScore := ObjProductRiskRating."Risk Score";
                    VarAccountTypeOption := ObjProductRiskRating."product type"::BOSA;
                end;
            until ObjProductsApp.Next = 0;
        end;

        ObjProductsApp.Reset;
        ObjProductsApp.SetRange(ObjProductsApp."Membership Applicaton No", MemberNo);
        ObjProductsApp.SetFilter(ObjProductsApp."Product Source", '%1', ObjProductsApp."product source"::BOSA);
        ObjProductsApp.SetFilter(ObjProductsApp.Product, '<>%1|%2', '503', '506');
        if ObjProductsApp.FindSet then begin

            repeat
                ObjProductRiskRating.Reset;
                ObjProductRiskRating.SetCurrentkey(ObjProductRiskRating."Product Type");
                ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Category", ObjProductRiskRating."product category"::Accounts);
                ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Type", ObjProductRiskRating."product type"::"FOSA(KSA");
                if ObjCustRiskRates.FindSet then begin
                    VarAccountTypeScore := ObjProductRiskRating."Risk Score";
                    VarAccountTypeOption := ObjProductRiskRating."product type"::"FOSA(KSA";
                end;
            until ObjProductsApp.Next = 0;
        end;


        ObjProductsApp.Reset;
        ObjProductsApp.SetRange(ObjProductsApp."Membership Applicaton No", MemberNo);
        ObjProductsApp.SetFilter(ObjProductsApp.Product, '%1|%2', '503', '506');
        if ObjProductsApp.FindSet then begin
            repeat
                ObjProductRiskRating.Reset;
                ObjProductRiskRating.SetCurrentkey(ObjProductRiskRating."Product Type");
                ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Category", ObjProductRiskRating."product category"::Accounts);
                ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Type", ObjProductRiskRating."product type"::"Fixed/Call Deposit Accounts");
                if ObjCustRiskRates.FindSet then begin
                    VarAccountTypeScore := ObjProductRiskRating."Risk Score";
                    VarAccountTypeOption := ObjProductRiskRating."product type"::"Fixed/Call Deposit Accounts";
                end;
            until ObjProductsApp.Next = 0;
        end;

        /*//Create Entries on Membership Risk Rating Table
        ObjMemberRiskRating.RESET;
        ObjMemberRiskRating.SETRANGE(ObjMemberRiskRating."Membership Application No",MemberNo);
        IF ObjMemberRiskRating.FINDSET THEN
          BEGIN
            ObjMemberRiskRating.DELETEALL;
            END;
        
        
        ObjMemberRiskRating.INIT;
        ObjMemberRiskRating."Membership Application No":=MemberNo;
        //ObjMemberRiskRating."What is the customer category?":=ObjMembershipApplication."Individual Category";
        ObjMemberRiskRating."Customer Category Score":=VarCategoryScore;
        //ObjMemberRiskRating."What is the Member residency?":=ObjMembershipApplication."Member Residency Status";
        ObjMemberRiskRating."Member Residency Score":=VarResidencyScore;
        //ObjMemberRiskRating."Cust Employment Risk?":=ObjMembershipApplication.Entities;
        ObjMemberRiskRating."Cust Employment Risk Score":=VarEntityScore;
        //ObjMemberRiskRating."Cust Business Risk Industry?":=ObjMembershipApplication."Industry Type";
        ObjMemberRiskRating."Cust Bus. Risk Industry Score":=VarIndustryScore;
        //ObjMemberRiskRating."Lenght Of Relationship?":=ObjMembershipApplication."Lenght Of Relationship";
        ObjMemberRiskRating."Length Of Relation Score":=VarLenghtOfRelationshipScore;
        ObjMemberRiskRating."Cust Involved in Intern. Trade":=ObjMembershipApplication."International Trade";
        ObjMemberRiskRating."Involve in Inter. Trade Score":=VarInternationalTradeScore;
        ObjMemberRiskRating."Account Type Taken?":=VarAccountTypeOption;
        ObjMemberRiskRating."Account Type Taken Score":=VarAccountTypeScore;
        ObjMemberRiskRating."Card Type Taken":=ObjMembershipApplication."Cards Type Taken";
        ObjMemberRiskRating."Card Type Taken Score":=VarCardTypeScore;
        ObjMemberRiskRating."Channel Taken?":=ObjMembershipApplication."Others(Channels)";
        ObjMemberRiskRating."Channel Taken Score":=VarChannelTakenScore;
        ObjMemberRiskRating."Electronic Payments?":=ObjMembershipApplication."Electronic Payment";
        ObjMemberRiskRating."Electronic Payments Score":=VarElectronicPaymentScore;
        MemberTotalRiskRatingScore:=VarCategoryScore+VarEntityScore+VarIndustryScore+VarInternationalTradeScore+VarLenghtOfRelationshipScore+VarResidencyScore+VarAccountTypeScore
        +VarCardTypeScore+VarChannelTakenScore+VarElectronicPaymentScore;
        ObjMemberRiskRating."GROSS CUSTOMER AML RISK RATING":=MemberTotalRiskRatingScore;
        ObjMemberRiskRating."BANK'S CONTROL RISK RATING":=9;
        ObjMemberRiskRating."CUSTOMER NET RISK RATING":=ROUND(ObjMemberRiskRating."GROSS CUSTOMER AML RISK RATING"/ObjMemberRiskRating."BANK'S CONTROL RISK RATING",0.5,'>');
        MemberNetRiskScore:=MemberTotalRiskRatingScore/9;
        
        ObjNetRiskScale.RESET;
        IF ObjNetRiskScale.FINDSET THEN
          BEGIN
            REPEAT
            IF (MemberNetRiskScore>=ObjNetRiskScale."Minimum Risk Rate") AND (MemberNetRiskScore<=ObjNetRiskScale."Maximum Risk Rate") THEN BEGIN
             ObjMemberRiskRating."Risk Rate Scale":=ObjNetRiskScale."Risk Scale";
              END;
            UNTIL ObjNetRiskScale.NEXT=0;
          END;
        ObjMemberRiskRating.INSERT;
        
        ObjMemberRiskRating.VALIDATE(ObjMemberRiskRating."Membership Application No");
        ObjMemberRiskRating.MODIFY;
         //END;
        */

    end;


    procedure FnGetMemberAMLRiskRating(MemberNo: Code[20]; VarIndividualCategory: Option "Politically Exposed Persons (PEPs)","High Net worth",Other,"Publicly Held Companies","Privately Held Companies","Domestic Government Entities",Churches,SMEs,Schools,"Welfare Groups","Financial entities Regulated by local regulators",Resident,"Non-Resident","Money Services Businesses","Charities and Non-Profit Organizations",Trusts,"Real Estate Agencies","High Value Goods Businesses","Precious Metals Businesses","Cash Intensive Businesses","Art Galleries & related businesses","Professional Service Providers","None of the above industries","0 – 1 Year","1 – 3 Years","Trade/Export Finance","Local Trade"; VarEntities: Option "Politically Exposed Persons (PEPs)","High Net worth",Other,"Publicly Held Companies","Privately Held Companies","Domestic Government Entities",Churches,SMEs,Schools,"Welfare Groups","Financial entities Regulated by local regulators",Resident,"Non-Resident","Money Services Businesses","Charities and Non-Profit Organizations",Trusts,"Real Estate Agencies","High Value Goods Businesses","Precious Metals Businesses","Cash Intensive Businesses","Art Galleries & related businesses","Professional Service Providers","None of the above industries","0 – 1 Year","1 – 3 Years","Trade/Export Finance","Local Trade"; VarResidency: Option "Politically Exposed Persons (PEPs)","High Net worth",Other,"Publicly Held Companies","Privately Held Companies","Domestic Government Entities",Churches,SMEs,Schools,"Welfare Groups","Financial entities Regulated by local regulators",Resident,"Non-Resident","Money Services Businesses","Charities and Non-Profit Organizations",Trusts,"Real Estate Agencies","High Value Goods Businesses","Precious Metals Businesses","Cash Intensive Businesses","Art Galleries & related businesses","Professional Service Providers","None of the above industries","0 – 1 Year","1 – 3 Years","Trade/Export Finance","Local Trade"; VarIndustryType: Option "Politically Exposed Persons (PEPs)","High Net worth",Other,"Publicly Held Companies","Privately Held Companies","Domestic Government Entities",Churches,SMEs,Schools,"Welfare Groups","Financial entities Regulated by local regulators",Resident,"Non-Resident","Money Services Businesses","Charities and Non-Profit Organizations",Trusts,"Real Estate Agencies","High Value Goods Businesses","Precious Metals Businesses","Cash Intensive Businesses","Art Galleries & related businesses","Professional Service Providers","None of the above industries","0 – 1 Year","1 – 3 Years","Trade/Export Finance","Local Trade"; VarLenghtOfRelationship: Option "Politically Exposed Persons (PEPs)","High Net worth",Other,"Publicly Held Companies","Privately Held Companies","Domestic Government Entities",Churches,SMEs,Schools,"Welfare Groups","Financial entities Regulated by local regulators",Resident,"Non-Resident","Money Services Businesses","Charities and Non-Profit Organizations",Trusts,"Real Estate Agencies","High Value Goods Businesses","Precious Metals Businesses","Cash Intensive Businesses","Art Galleries & related businesses","Professional Service Providers","None of the above industries","0 – 1 Year","1 – 3 Years","Trade/Export Finance","Local Trade"; VarInternationalTrade: Option "Politically Exposed Persons (PEPs)","High Net worth",Other,"Publicly Held Companies","Privately Held Companies","Domestic Government Entities",Churches,SMEs,Schools,"Welfare Groups","Financial entities Regulated by local regulators",Resident,"Non-Resident","Money Services Businesses","Charities and Non-Profit Organizations",Trusts,"Real Estate Agencies","High Value Goods Businesses","Precious Metals Businesses","Cash Intensive Businesses","Art Galleries & related businesses","Professional Service Providers","None of the above industries","0 – 1 Year","1 – 3 Years","Trade/Export Finance","Local Trade"; VarCardType: Option "International Wire Transfers","Local Wire Transfers","Mobile Transfers","None of the Above","Fixed/Call Deposit Accounts","FOSA(KSA",Imara," MJA","Heritage)","Account with Sealed Safe deposit","Account with  Open Safe Deposit","All Loan Accounts",BOSA," Ufalme","ATM Debit",Credit,Both,"None","Non-face to face channels","Unsolicited Account Origination e.g. Walk-Ins","Cheque book",Others; VarChannelTaken: Option "International Wire Transfers","Local Wire Transfers","Mobile Transfers","None of the Above","Fixed/Call Deposit Accounts","FOSA(KSA",Imara," MJA","Heritage)","Account with Sealed Safe deposit","Account with  Open Safe Deposit","All Loan Accounts",BOSA," Ufalme","ATM Debit",Credit,Both,"None","Non-face to face channels","Unsolicited Account Origination e.g. Walk-Ins","Cheque book",Others; VarElectronicPayment: Option "International Wire Transfers","Local Wire Transfers","Mobile Transfers","None of the Above","Fixed/Call Deposit Accounts","FOSA(KSA",Imara," MJA","Heritage)","Account with Sealed Safe deposit","Account with  Open Safe Deposit","All Loan Accounts",BOSA," Ufalme","ATM Debit",Credit,Both,"None","Non-face to face channels","Unsolicited Account Origination e.g. Walk-Ins","Cheque book",Others; VarAccountType: Option "International Wire Transfers","Local Wire Transfers","Mobile Transfers","None of the Above","Fixed/Call Deposit Accounts","FOSA(KSA",Imara," MJA","Heritage)","Account with Sealed Safe deposit","Account with  Open Safe Deposit","All Loan Accounts",BOSA," Ufalme","ATM Debit",Credit,Both,"None","Non-face to face channels","Unsolicited Account Origination e.g. Walk-Ins","Cheque book",Others)
    var
        VarCategoryScore: Integer;
        VarResidencyScore: Integer;
        VarNatureofBusinessScore: Integer;
        VarEntityScore: Integer;
        VarIndustryScore: Integer;
        VarLenghtOfRelationshipScore: Integer;
        VarInternationalTradeScore: Integer;
        VarElectronicPaymentScore: Integer;
        VarCardTypeScore: Integer;
        VarAccountTypeScore: Integer;
        VarChannelTakenScore: Integer;
        VarAccountTypeOption: Option "International Wire Transfers","Local Wire Transfers","Mobile Transfers","None of the Above","Fixed/Call Deposit Accounts","FOSA(KSA",Imara," MJA","Heritage)","Account with Sealed Safe deposit","Account with  Open Safe Deposit","All Loan Accounts",BOSA," Ufalme","ATM Debit",Credit,Both,"None","Non-face to face channels","Unsolicited Account Origination e.g. Walk-Ins","Cheque book",Others;
        MemberTotalRiskRatingScore: Decimal;
        MemberNetRiskScore: Decimal;
        VarMemberAnnualIncome: Decimal;
        ObjNetWorth: Record 51932;
        ObjPeps: Record 51918;
        VarPepsRiskScore: Decimal;
        VarHighNet: Decimal;
        VarIndividualCategoryOption: Option "Politically Exposed Persons (PEPs)","High Net worth",Other,"Publicly Held Companies","Privately Held Companies","Domestic Government Entities",Churches,SMEs,Schools,"Welfare Groups","Financial entities Regulated by local regulators",Resident,"Non-Resident","Money Services Businesses","Charities and Non-Profit Organizations",Trusts,"Real Estate Agencies","High Value Goods Businesses","Precious Metals Businesses","Cash Intensive Businesses","Art Galleries & related businesses","Professional Service Providers","None of the above industries","0 – 1 Year","1 – 3 Years","Trade/Export Finance","Local Trade";
        VarLenghtOfRelationshipOption: Option "Politically Exposed Persons (PEPs)","High Net worth",Other,"Publicly Held Companies","Privately Held Companies","Domestic Government Entities",Churches,SMEs,Schools,"Welfare Groups","Financial entities Regulated by local regulators",Resident,"Non-Resident","Money Services Businesses","Charities and Non-Profit Organizations",Trusts,"Real Estate Agencies","High Value Goods Businesses","Precious Metals Businesses","Cash Intensive Businesses","Art Galleries & related businesses","Professional Service Providers","None of the above industries","0 – 1 Year","1 – 3 Years","Trade/Export Finance","Local Trade";
        VarMemberSaccoAge: Integer;
    begin

        //Member Category(High Net Worth|PEPS|Others)==============================================================================================
        ObjMembers.Reset;
        ObjMembers.SetRange(ObjMembers."No.", MemberNo);
        if ObjMembers.FindSet then begin


            //High Net Worth==============================================================================
            VarMemberAnnualIncome := ObjMembers."Expected Monthly Income" * 12;
            ObjNetWorth.Reset;
            //ObjNetWorth.SETFILTER(ObjNetWorth."Minimum Risk Rate",'<=%1',VarMemberAnnualIncome);
            if ObjNetWorth.FindSet then begin
                repeat
                    if (VarMemberAnnualIncome >= ObjNetWorth."Min Annual Income") and (VarMemberAnnualIncome <= ObjNetWorth."Max Annual Income") then begin
                        VarHighNet := ObjNetWorth."Risk Rate";
                    end;
                until ObjNetWorth.Next = 0;
            end;
            //End High Net Worth==========================================================================

            //Politicall Exposed Persons====================================================================
            ObjPeps.Reset;
            ObjPeps.SetFilter(ObjPeps.Name, ObjMembers.Name);
            if ObjPeps.FindSet then begin
                ObjCustRiskRates.Reset;
                ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::Individuals);
                ObjCustRiskRates.SetRange(ObjCustRiskRates."Sub Category Option", ObjCustRiskRates."sub category option"::"Politically Exposed Persons (PEPs)");
                if ObjCustRiskRates.FindSet then begin
                    VarPepsRiskScore := ObjCustRiskRates."Risk Score";
                end;
            end;
            //End Politicall Exposed Persons================================================================

            if (VarHighNet < 5) and (VarPepsRiskScore = 0) then begin

                ObjCustRiskRates.Reset;
                ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::Individuals);
                ObjCustRiskRates.SetRange(ObjCustRiskRates."Sub Category Option", ObjCustRiskRates."sub category option"::Other);
                if ObjCustRiskRates.FindSet then begin
                    VarCategoryScore := ObjCustRiskRates."Risk Score";
                    VarIndividualCategoryOption := Varindividualcategoryoption::Other;
                end;

            end else
                if (VarHighNet = 5) and (VarPepsRiskScore = 0) then begin

                    ObjCustRiskRates.Reset;
                    ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::Individuals);
                    ObjCustRiskRates.SetRange(ObjCustRiskRates."Sub Category Option", ObjCustRiskRates."sub category option"::"High Net worth");
                    if ObjCustRiskRates.FindSet then begin
                        VarCategoryScore := ObjCustRiskRates."Risk Score";
                        VarIndividualCategoryOption := Varindividualcategoryoption::"High Net worth";
                    end;

                end else
                    if (VarHighNet <> 5) and (VarPepsRiskScore = 5) then begin

                        ObjCustRiskRates.Reset;
                        ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::Individuals);
                        ObjCustRiskRates.SetRange(ObjCustRiskRates."Sub Category Option", ObjCustRiskRates."sub category option"::"Politically Exposed Persons (PEPs)");
                        if ObjCustRiskRates.FindSet then begin
                            VarCategoryScore := ObjCustRiskRates."Risk Score";
                            VarIndividualCategoryOption := Varindividualcategoryoption::"Politically Exposed Persons (PEPs)";
                        end;
                    end;
        end;
        //END Member Category(High Net Worth|PEPS|Others)==============================================================================================

        ObjMembers.Reset;
        ObjMembers.SetRange(ObjMembers."No.", MemberNo);
        if ObjMembers.FindSet then begin
            ObjCustRiskRates.Reset;
            ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::Entities);
            ObjCustRiskRates.SetRange(ObjCustRiskRates."Sub Category Option", VarEntities);
            if ObjCustRiskRates.FindSet then begin
                VarEntityScore := ObjCustRiskRates."Risk Score";
            end;
        end;

        ObjMembers.Reset;
        ObjMembers.SetRange(ObjMembers."No.", MemberNo);
        if ObjMembers.FindSet then begin
            ObjCustRiskRates.Reset;
            ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::"Residency Status");
            ObjCustRiskRates.SetRange(ObjCustRiskRates."Sub Category Option", VarResidency);
            if ObjCustRiskRates.FindSet then begin
                VarResidencyScore := ObjCustRiskRates."Risk Score";
            end;
        end;

        ObjMembers.Reset;
        ObjMembers.SetRange(ObjMembers."No.", MemberNo);
        if ObjMembers.FindSet then begin
            ObjCustRiskRates.Reset;
            ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::Industry);
            ObjCustRiskRates.SetRange(ObjCustRiskRates."Sub Category Option", VarIndustryType);
            if ObjCustRiskRates.FindSet then begin
                VarIndustryScore := ObjCustRiskRates."Risk Score";
            end;
        end;

        //Lenght Of Relationship=========================================================================================================
        ObjMembers.Reset;
        ObjMembers.SetRange(ObjMembers."No.", MemberNo);
        if ObjMembers.FindSet then begin
            VarMemberSaccoAge := ROUND((Today - ObjMembers."Registration Date") / 365, 1, '<');

            ObjCustRiskRates.Reset;
            ObjCustRiskRates.SetCurrentkey(ObjCustRiskRates."Min Relationship Length(Years)");
            ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::"Length Of Relationship");
            if ObjCustRiskRates.FindSet then begin
                repeat
                    if (VarMemberSaccoAge >= ObjCustRiskRates."Min Relationship Length(Years)") and (VarMemberSaccoAge <= ObjCustRiskRates."Max Relationship Length(Years)") then begin
                        Message('VarMemberSaccoAge is %1', VarMemberSaccoAge);
                        VarLenghtOfRelationshipScore := ObjCustRiskRates."Risk Score";
                        VarLenghtOfRelationshipOption := ObjCustRiskRates."Sub Category Option";
                        Message('VarLenghtOfRelationshipOption %1 VarLenghtOfRelationshipScore%2,', VarLenghtOfRelationshipOption, VarLenghtOfRelationshipScore);
                    end;
                until ObjNetWorth.Next = 0;
            end;
        end;
        //End Lenght Of Relationship=========================================================================================================

        ObjMembers.Reset;
        ObjMembers.SetRange(ObjMembers."No.", MemberNo);
        if ObjMembers.FindSet then begin
            ObjCustRiskRates.Reset;
            ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::"International Trade");
            ObjCustRiskRates.SetRange(ObjCustRiskRates."Sub Category Option", VarInternationalTrade);
            if ObjCustRiskRates.FindSet then begin
                VarInternationalTradeScore := ObjCustRiskRates."Risk Score";
            end;
        end;


        ObjMembers.Reset;
        ObjMembers.SetRange(ObjMembers."No.", MemberNo);
        if ObjMembers.FindSet then begin
            ObjProductRiskRating.Reset;
            ObjProductRiskRating.SetCurrentkey(ObjProductRiskRating."Product Type Code");
            ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Category", ObjProductRiskRating."product category"::"Electronic Payment");
            ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Type", VarElectronicPayment);
            if ObjProductRiskRating.FindSet then begin
                VarElectronicPaymentScore := ObjProductRiskRating."Risk Score";
            end;
        end;


        //ObjProductRiskRating.GET();
        ObjMembers.Reset;
        ObjMembers.SetRange(ObjMembers."No.", MemberNo);
        if ObjMembers.FindSet then begin

            ObjProductRiskRating.Reset;
            ObjProductRiskRating.SetCurrentkey(ObjProductRiskRating."Product Type Code");
            ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Category", ObjProductRiskRating."product category"::Cards);
            ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Type", ObjMembers."Cards Type Taken");//VarCardType
            if ObjProductRiskRating.FindSet then begin
                VarCardTypeScore := ObjProductRiskRating."Risk Score";
            end;
        end;

        ObjProductRiskRating.Reset;
        ObjProductRiskRating.SetCurrentkey(ObjProductRiskRating."Product Type Code");
        ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Category", ObjProductRiskRating."product category"::Accounts);
        ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Type", VarAccountType);
        if ObjCustRiskRates.FindSet then begin
            VarAccountTypeScore := ObjProductRiskRating."Risk Score";
        end;

        ObjProductRiskRating.Reset;
        ObjProductRiskRating.SetCurrentkey(ObjProductRiskRating."Product Type Code");
        ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Category", ObjProductRiskRating."product category"::Others);
        ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Type", VarChannelTaken);
        if ObjCustRiskRates.FindSet then begin
            VarChannelTakenScore := ObjProductRiskRating."Risk Score";
        end;

        ObjProductsApp.Reset;
        ObjProductsApp.SetRange(ObjProductsApp."Membership Applicaton No", MemberNo);
        ObjProductsApp.SetFilter(ObjProductsApp."Product Source", '<>%1', ObjProductsApp."product source"::BOSA);
        if ObjProductsApp.FindSet then begin
            repeat
                ObjProductRiskRating.Reset;
                ObjProductRiskRating.SetCurrentkey(ObjProductRiskRating."Product Type");
                ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Category", ObjProductRiskRating."product category"::Accounts);
                ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Type", ObjProductRiskRating."product type"::BOSA);
                if ObjCustRiskRates.FindSet then begin
                    VarAccountTypeScore := ObjProductRiskRating."Risk Score";
                    VarAccountTypeOption := ObjProductRiskRating."product type"::BOSA;
                end;
            until ObjProductsApp.Next = 0;
        end;

        ObjProductsApp.Reset;
        ObjProductsApp.SetRange(ObjProductsApp."Membership Applicaton No", MemberNo);
        ObjProductsApp.SetFilter(ObjProductsApp."Product Source", '%1', ObjProductsApp."product source"::BOSA);
        ObjProductsApp.SetFilter(ObjProductsApp.Product, '<>%1|%2', '503', '506');
        if ObjProductsApp.FindSet then begin

            repeat
                ObjProductRiskRating.Reset;
                ObjProductRiskRating.SetCurrentkey(ObjProductRiskRating."Product Type");
                ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Category", ObjProductRiskRating."product category"::Accounts);
                ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Type", ObjProductRiskRating."product type"::"FOSA(KSA");
                if ObjCustRiskRates.FindSet then begin
                    VarAccountTypeScore := ObjProductRiskRating."Risk Score";
                    VarAccountTypeOption := ObjProductRiskRating."product type"::"FOSA(KSA";
                end;
            until ObjProductsApp.Next = 0;
        end;

        ObjProductsApp.Reset;
        ObjProductsApp.SetRange(ObjProductsApp."Membership Applicaton No", MemberNo);
        ObjProductsApp.SetFilter(ObjProductsApp.Product, '%1|%2', '503', '506');
        if ObjProductsApp.FindSet then begin
            repeat
                ObjProductRiskRating.Reset;
                ObjProductRiskRating.SetCurrentkey(ObjProductRiskRating."Product Type");
                ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Category", ObjProductRiskRating."product category"::Accounts);
                ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Type", ObjProductRiskRating."product type"::"Fixed/Call Deposit Accounts");
                if ObjCustRiskRates.FindSet then begin
                    VarAccountTypeScore := ObjProductRiskRating."Risk Score";
                    VarAccountTypeOption := ObjProductRiskRating."product type"::"Fixed/Call Deposit Accounts";
                end;
            until ObjProductsApp.Next = 0;
        end;

        //Create Entries on Membership Risk Rating Table
        ObjMemberRiskRating.Reset;
        ObjMemberRiskRating.SetRange(ObjMemberRiskRating."Membership Application No", MemberNo);
        if ObjMemberRiskRating.FindSet then begin
            ObjMemberRiskRating.DeleteAll;
        end;


        if ObjMembers.Get(MemberNo) then begin
            ObjMembers."Individual Category" := VarIndividualCategoryOption;
            ObjMembers."Lenght Of Relationship" := VarLenghtOfRelationshipOption;
            ObjMembers.Modify;
        end;

        ObjMemberRiskRating.Init;
        ObjMemberRiskRating."Membership Application No" := MemberNo;
        ObjMemberRiskRating."What is the customer category?" := VarIndividualCategoryOption;
        ObjMemberRiskRating."Customer Category Score" := VarCategoryScore;
        ObjMemberRiskRating."What is the Member residency?" := ObjMembers."Member Residency Status";
        ObjMemberRiskRating."Member Residency Score" := VarResidencyScore;
        ObjMemberRiskRating."Cust Employment Risk?" := ObjMembers.Entities;
        ObjMemberRiskRating."Cust Employment Risk Score" := VarEntityScore;
        ObjMemberRiskRating."Cust Business Risk Industry?" := ObjMembers."Industry Type";
        ObjMemberRiskRating."Cust Bus. Risk Industry Score" := VarIndustryScore;
        ObjMemberRiskRating."Lenght Of Relationship?" := VarLenghtOfRelationshipOption;
        ObjMemberRiskRating."Length Of Relation Score" := VarLenghtOfRelationshipScore;
        ObjMemberRiskRating."Cust Involved in Intern. Trade" := ObjMembers."International Trade";
        ObjMemberRiskRating."Involve in Inter. Trade Score" := VarInternationalTradeScore;
        ObjMemberRiskRating."Account Type Taken?" := VarAccountTypeOption;
        ObjMemberRiskRating."Account Type Taken Score" := VarAccountTypeScore;
        ObjMemberRiskRating."Card Type Taken" := ObjMembers."Cards Type Taken";
        ObjMemberRiskRating."Card Type Taken Score" := VarCardTypeScore;
        ObjMemberRiskRating."Channel Taken?" := ObjMembers."Others(Channels)";
        ObjMemberRiskRating."Channel Taken Score" := VarChannelTakenScore;
        ObjMemberRiskRating."Electronic Payments?" := ObjMembers."Electronic Payment";
        ObjMemberRiskRating."Electronic Payments Score" := VarElectronicPaymentScore;
        MemberTotalRiskRatingScore := VarCategoryScore + VarEntityScore + VarIndustryScore + VarInternationalTradeScore + VarLenghtOfRelationshipScore + VarResidencyScore + VarAccountTypeScore
        + VarCardTypeScore + VarChannelTakenScore + VarElectronicPaymentScore;
        ObjMemberRiskRating."GROSS CUSTOMER AML RISK RATING" := MemberTotalRiskRatingScore;
        ObjMemberRiskRating."BANK'S CONTROL RISK RATING" := 9;
        ObjMemberRiskRating."CUSTOMER NET RISK RATING" := ROUND(ObjMemberRiskRating."GROSS CUSTOMER AML RISK RATING" / ObjMemberRiskRating."BANK'S CONTROL RISK RATING", 0.5, '>');
        MemberNetRiskScore := MemberTotalRiskRatingScore / 9;

        ObjNetRiskScale.Reset;
        if ObjNetRiskScale.FindSet then begin
            repeat
                if (MemberNetRiskScore >= ObjNetRiskScale."Minimum Risk Rate") and (MemberNetRiskScore <= ObjNetRiskScale."Maximum Risk Rate") then begin
                    ObjMemberRiskRating."Risk Rate Scale" := ObjNetRiskScale."Risk Scale";
                end;
            until ObjNetRiskScale.Next = 0;
        end;
        ObjMemberRiskRating.Insert;

        ObjMemberRiskRating.Validate(ObjMemberRiskRating."Membership Application No");
        ObjMemberRiskRating.Modify;
    end;

    procedure FnGetMemberLiability(MemberNo: Code[30]) VarTotaMemberLiability: Decimal
    var
        ObjLoanGuarantors: Record 51372;
        ObjLoans: Record "Loans Register";
        ObjLoanSecurities: Record 51374;
        ObjLoanGuarantors2: Record 51372;
        VarTotalGuaranteeValue: Decimal;
        VarMemberAnountGuaranteed: Decimal;
        VarApportionedLiability: Decimal;
        VarLoanOutstandingBal: Decimal;
        MAmountG: Decimal;
    begin
        ObjMembers.Reset;
        ObjMembers.SetRange(ObjMembers."No.", MemberNo);
        if ObjMembers.FindSet then begin
            VarTotalGuaranteeValue := 0;
            VarApportionedLiability := 0;
            VarTotaMemberLiability := 0;
            //Loans Guaranteed=======================================================================
            ObjLoanGuarantors.Reset;
            ObjLoanGuarantors.SetRange(ObjLoanGuarantors."Member No", MemberNo);
            ObjLoanGuarantors.SetRange(Substituted, false);
            ObjLoanGuarantors.SetRange(ObjLoanGuarantors."Self Guarantee", false);
            if ObjLoanGuarantors.FindSet then begin
                repeat
                    ObjLoanGuarantors.CalcFields(ObjLoanGuarantors."Outstanding Balance");
                    //              ObjLoanGuarantors.CALCFIELDS(ObjLoanGuarantors."Amont Guaranteed");
                    if ObjLoanGuarantors."Outstanding Balance" > 0 then begin
                        VarTotalGuaranteeValue := VarTotalGuaranteeValue + ObjLoanGuarantors."Amont Guaranteed";

                    end;
                until ObjLoanGuarantors.Next = 0;
            end;
            //***********************
            MAmountG := 0;
            ObjLoanGuarantors.Reset;
            ObjLoanGuarantors.SetRange(ObjLoanGuarantors."Member No", MemberNo);
            ObjLoanGuarantors.SetRange(ObjLoanGuarantors."Application Statu", true);
            ObjLoanGuarantors.SetRange(ObjLoanGuarantors."Self Guarantee", false);
            ObjLoanGuarantors.SetRange(Substituted, false);
            if ObjLoanGuarantors.FindSet then begin
                repeat
                    ObjLoanGuarantors.CalcFields(ObjLoanGuarantors."Outstanding Balance");
                    if ObjLoanGuarantors."Outstanding Balance" < 0 then begin
                        MAmountG := MAmountG + ObjLoanGuarantors."Amont Guaranteed";

                    end;
                until ObjLoanGuarantors.Next = 0;
            end;

            //*********************************
            VarTotaMemberLiability := MAmountG + VarTotalGuaranteeValue;

        end;
        exit(VarTotaMemberLiability);


        //................................................................................
    end;


    procedure FnGetPreviousMonthLastDate(LoanNum: Code[10]; RunDate: Date) LastMonthDate: Date
    var
        ObjLoansReg: Record "Loans Register";
    begin
        if ObjLoansReg.Get(LoanNum) then begin
            if (ObjLoansReg."Repayment Frequency" = ObjLoansReg."repayment frequency"::Monthly) then begin
                if (RunDate = CalcDate('CM', RunDate)) then begin
                    LastMonthDate := RunDate;
                end else begin
                    LastMonthDate := CalcDate('-1M', RunDate);
                end;
                LastMonthDate := CalcDate('CM', LastMonthDate);
            end;
        end;

        exit(LastMonthDate);
    end;


    procedure FnGetScheduledExpectedBalance(LoanNum: Code[10]; RunDate: Date) ScheduleBal: Decimal
    var
        ObjRepaySch: Record "Loan Repayment Schedule";
    begin
        ScheduleBal := 0;
        ObjRepaySch.Reset;
        ObjRepaySch.SetRange(ObjRepaySch."Loan No.", LoanNum);
        ObjRepaySch.SetRange(ObjRepaySch."Repayment Date", RunDate);
        if ObjRepaySch.Find('-') then begin
            ScheduleBal := ObjRepaySch."Loan Balance";
        end;
        exit(ScheduleBal);
    end;


    procedure FnGetLoanBalance(LoanNum: Code[10]; RunDate: Date) LoanBal: Decimal
    var
        ObjLoanReg: Record "Loans Register";
    begin
        LoanBal := 0;

        ObjLoanReg.Reset;
        ObjLoanReg.SetRange(ObjLoanReg."Loan  No.", LoanNum);
        ObjLoanReg.SetFilter(ObjLoanReg."Date filter", '..' + Format(RunDate));
        if ObjLoanReg.FindSet then begin
            ObjLoanReg.CalcFields(ObjLoanReg."Outstanding Balance");
            LoanBal := ObjLoanReg."Outstanding Balance";
        end;

        exit(LoanBal);
    end;


    procedure FnCalculateLoanArrears(ScheduleBalance: Decimal; LoanBalance: Decimal; RunDate: Date; ExpCompDate: Date) Arrears: Decimal
    begin
        Arrears := 0;

        if ExpCompDate < RunDate then begin
            Arrears := LoanBalance;
        end else begin
            Arrears := ScheduleBalance - LoanBalance;

            if Arrears > 0 then
                Arrears := 0
            else
                Arrears := Arrears;
        end;

        exit(Arrears);
    end;


    procedure FnCalculatePeriodInArrears(Arrears: Decimal; PRepay: Decimal; RunDate: Date; ExpCompletionDate: Date) PeriodArrears: Decimal
    begin
        PeriodArrears := 0;

        if Arrears <> 0 then begin
            if ExpCompletionDate < RunDate then begin
                PeriodArrears := ROUND((RunDate - ExpCompletionDate) / 30, 1, '=');
            end else
                PeriodArrears := ROUND(Arrears / PRepay, 1, '=') * -1;
        end;

        exit(PeriodArrears);
    end;


    procedure FnClassifyLoans(LoanNum: Code[10]; PeriodArrears: Decimal; AmountArrears: Decimal) Class: Integer
    var
        ObjLoansReg: Record "Loans Register";
    begin
        if ObjLoansReg.Get(LoanNum) then begin
            if (AmountArrears = 0) or (PeriodArrears < 2) then begin
                ObjLoansReg."Loans Category" := ObjLoansReg."loans category"::Perfoming;
                ObjLoansReg."Loans Category-SASRA" := ObjLoansReg."loans category-sasra"::Perfoming;
                ObjLoansReg."Amount in Arrears" := AmountArrears;
                Class := 1;
            end else
                if (PeriodArrears >= 2) and (PeriodArrears < 3) then begin
                    ObjLoansReg."Loans Category" := ObjLoansReg."loans category"::Watch;
                    ObjLoansReg."Loans Category-SASRA" := ObjLoansReg."loans category-sasra"::Watch;
                    ObjLoansReg."Amount in Arrears" := AmountArrears;
                    Class := 2;
                end else
                    if (PeriodArrears >= 3) and (PeriodArrears <= 6) then begin
                        ObjLoansReg."Loans Category" := ObjLoansReg."loans category"::Substandard;
                        ObjLoansReg."Loans Category-SASRA" := ObjLoansReg."loans category-sasra"::Substandard;
                        ObjLoansReg."Amount in Arrears" := AmountArrears;
                        Class := 3;
                    end else
                        if (PeriodArrears > 6) and (PeriodArrears <= 12) then begin
                            ObjLoansReg."Loans Category" := ObjLoansReg."loans category"::Doubtful;
                            ObjLoansReg."Loans Category-SASRA" := ObjLoansReg."loans category-sasra"::Doubtful;
                            ObjLoansReg."Amount in Arrears" := AmountArrears;
                            Class := 4;
                        end else
                            if (PeriodArrears > 12) then begin
                                ObjLoansReg."Loans Category" := ObjLoansReg."loans category"::Loss;
                                ObjLoansReg."Loans Category-SASRA" := ObjLoansReg."loans category-sasra"::Loss;
                                ObjLoansReg."Amount in Arrears" := AmountArrears;
                                Class := 5;
                            end;

            ObjLoansReg.Modify;
        end;

        exit(Class);
    end;


    procedure FnCalculateDividendProrated(MemberNo: Code[10]; StartDate: Date; EndDate: Date)
    var
        ObjCust: Record Customer;
        ObjDivProg: Record 51393;
        FromBate: Date;
        "To Date": Date;
    begin


        if ObjCust.Get(MemberNo) then begin

        end;
    end;


    procedure FnDisburseToCurrentAccount(LoanApps: Record "Loans Register"; LineNumber: Integer): Integer
    var
        ProcessingFees: Decimal;
        ProcessingFeesAcc: Code[50];
        PChargeAmount: Decimal;
        BLoan: Code[30];
        TCharges: Decimal;
        TopUpComm: Decimal;
        TotalTopupComm: Decimal;
        LineNo: Integer;
        GenJournalLine: Record "Gen. Journal Line";
    begin
        if (FnGetFosaAccount(LoanApps."Client Code") = '') then
            Error('Member must be assigned the ordinary Account.');

        BATCH_TEMPLATE := 'PAYMENTS';
        BATCH_NAME := 'LOANS';
        DOCUMENT_NO := LoanApps."Batch No.";
        if DOCUMENT_NO = '' then
            DOCUMENT_NO := LoanApps."Loan  No.";

        ObjGenSetUp.Get();
        LoanApps.CalcFields(LoanApps."Top Up Amount", LoanApps."Topup iNTEREST");
        TCharges := 0;
        TopUpComm := 0;
        TotalTopupComm := LoanApps."Top Up Amount";
        AmountToDisburse := LoanApps."Approved Amount";
        if LoanApps."Initial Trunch" > 0 then
            AmountToDisburse := LoanApps."Initial Trunch";

        //------------------------------------1. DEBIT MEMBER LOAN A/C---------------------------------------------------------------------------------------------
        LineNo := LineNumber;
        FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::Loan,
GenJournalLine."account type"::Customer, LoanApps."Client Code", LoanApps."Loan Disbursement Date", AmountToDisburse, Format(LoanApps.Source), LoanApps."Loan  No.",
        'Loan principle- ' + LoanApps."Loan Product Type" + '-' + LoanApps."Loan  No.", LoanApps."Loan  No.");
        //--------------------------------(Debit Member Loan Account)---------------------------------------------

        //-----------------------------------1B. ACCRUE INTEREST IF Constant-----------------------------------------------------
        if ((LoanApps."Repayment Method" = LoanApps."repayment method"::Constants) and (ObjLoanProductSetup.Get(LoanApps."Loan Product Type"))) then begin

            LineNo := LineNo + 1000;
            FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Due",
            GenJournalLine."account type"::Customer, LoanApps."Client Code", LoanApps."Loan Disbursement Date", LoanApps."Interest Upfront Amount", Format(LoanApps.Source), LoanApps."Loan  No.",
            'Interest Due', LoanApps."Loan  No.");

            LineNo := LineNo + 1000;
            FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::"G/L Account", ObjLoanProductSetup."Loan Interest Account", LoanApps."Loan Disbursement Date", LoanApps."Interest Upfront Amount" * -1, Format(LoanApps.Source), LoanApps."Loan  No.",
            'Interest Due', LoanApps."Loan  No.");

            LineNo := LineNo + 1000;
            FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
            GenJournalLine."account type"::Customer, LoanApps."Client Code", LoanApps."Loan Disbursement Date", LoanApps."Interest Upfront Amount" * -1, Format(LoanApps.Source), LoanApps."Loan  No.",
            'Interest Paid', LoanApps."Loan  No.");
        end;

        //-------------------------------------End-------------------------------------------------------------------------------

        //------------------------------------2. CREDIT MEMBER FOSA A/C---------------------------------------------------------------------------------------------
        LineNo := LineNo + 1000;
        FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
        GenJournalLine."account type"::Vendor, FnGetFosaAccount(LoanApps."Client Code"), LoanApps."Loan Disbursement Date", (AmountToDisburse - LoanApps."Interest Due") * -1, 'BOSA', LoanApps."Loan  No.",
        'Loan Issued- ' + LoanApps."Loan Product Type", LoanApps."Loan  No.");
        //----------------------------------(Credit Member Fosa Account)------------------------------------------------
        /*
        //------------------------------------2. DEBIT MEMBER FOSA A/C---------------------------------------------------------------------------------------------
         LineNo:=LineNo+1000;
         FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::" ",
         GenJournalLine."Account Type"::Vendor,FnGetFosaAccount(LoanApps."Client Code"),LoanApps."Loan Disbursement Date",(AmountToDisburse-LoanApps."Interest Due"),'BOSA',LoanApps."Loan  No.",
         'Loan Issued- '+LoanApps."Loan Product Type",LoanApps."Loan  No.");
        //----------------------------------(DEBIT Member Fosa Account)------------------------------------------------
        
        //Credit Bank A/C
         LineNo:=LineNo+1000;
         FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::" ",
         GenJournalLine."Account Type"::"Bank Account",FnGetFosaAccount(LoanApps."Client Code"),LoanApps."Loan Disbursement Date",(AmountToDisburse-LoanApps."Interest Due")*-1,'BOSA',LoanApps."Loan  No.",
         'Loan Issued- '+LoanApps."Loan Product Type",LoanApps."Loan  No.");
        
        //------------------------------------3. EARN/RECOVER PRODUCT CHARGES FROM FOSA A/C--------------------------------------
        END;*/
        PCharges.Reset;
        PCharges.SetRange(PCharges."Product Code", LoanApps."Loan Product Type");
        if PCharges.Find('-') then begin
            repeat
                PCharges.TestField(PCharges."G/L Account");
                ObjGenSetUp.TestField(ObjGenSetUp."Excise Duty Account");
                PChargeAmount := PCharges.Amount;
                if PCharges."Use Perc" = true then
                    PChargeAmount := (LoanApps."Approved Amount" * PCharges.Percentage / 100);
                //-------------------EARN CHARGE-------------------------------------------
                LineNo := LineNo + 1000;
                FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::"G/L Account", PCharges."G/L Account", LoanApps."Loan Disbursement Date", PChargeAmount * -1, 'BOSA', LoanApps."Loan  No.",
                LoanApps."Loan Product Type" + '-' + LoanApps."Loan  No." + PCharges.Description, LoanApps."Loan  No.");
                //-------------------RECOVER-----------------------------------------------
                LineNo := LineNo + 1000;
                FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::Vendor, FnGetFosaAccount(LoanApps."Client Code"), LoanApps."Loan Disbursement Date", PChargeAmount, 'BOSA', LoanApps."Loan  No.",
               LoanApps."Loan Product Type" + '-' + LoanApps."Loan  No." + PCharges.Description, LoanApps."Loan  No.");

                //------------------10% EXCISE DUTY----------------------------------------
                if FnChargeExcise(PCharges.Code) then begin
                    //-------------------Earn---------------------------------
                    LineNo := LineNo + 1000;
                    FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::"G/L Account", ObjGenSetUp."Excise Duty Account", LoanApps."Loan Disbursement Date", (PChargeAmount * -1) * 0.1, 'BOSA', LoanApps."Loan  No.",
                    LoanApps."Loan Product Type" + '-' + LoanApps."Loan  No.", LoanApps."Loan  No.");
                    //-----------------Recover---------------------------------
                    LineNo := LineNo + 1000;
                    FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, FnGetFosaAccount(LoanApps."Client Code"), LoanApps."Loan Disbursement Date", PChargeAmount * 0.1, 'BOSA', LoanApps."Loan  No.",
                    LoanApps."Loan Product Type" + '-' + LoanApps."Loan  No." + 'Excise', LoanApps."Loan  No.");
                end
            //----------------END 10% EXCISE--------------------------------------------
            until PCharges.Next = 0;
        end;


        //----------------------------------------4. PAY/RECOVER TOP UPS------------------------------------------------------------------------------------------
        if LoanApps."Top Up Amount" > 0 then begin
            LoanTopUp.Reset;
            LoanTopUp.SetRange(LoanTopUp."Loan No.", LoanApps."Loan  No.");
            LoanTopUp.SetRange(LoanTopUp."Client Code", LoanApps."Client Code");
            if LoanTopUp.Find('-') then begin
                repeat
                    //------------------------------------PAY-----------------------------------------------------------------------------------------------------------
                    //------------------------------------Principal---------------------
                    LineNo := LineNo + 1000;
                    FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                    GenJournalLine."account type"::Customer, LoanApps."Client Code", LoanApps."Loan Disbursement Date", LoanTopUp."Principle Top Up" * -1, 'BOSA', LoanTopUp."Loan Top Up",
                    'Off Set By - ' + LoanApps."Client Code" + '-' + LoanApps."Loan Product Type" + '-' + LoanApps."Loan  No.", LoanTopUp."Loan Top Up");
                    //------------------------------------Outstanding Interest----------
                    LineNo := LineNo + 1000;
                    FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                    GenJournalLine."account type"::Customer, LoanApps."Client Code", LoanApps."Loan Disbursement Date", LoanTopUp."Interest Top Up" * -1, 'BOSA', LoanTopUp."Loan Top Up",
                    'Interest Paid-' + '-' + LoanApps."Loan Product Type" + '-' + LoanApps."Loan  No.", LoanTopUp."Loan Top Up");
                    //-------------------------------------Levy--------------------------
                    LineNo := LineNo + 1000;
                    if ObjLoanProductSetup.Get(LoanApps."Loan Product Type") then begin
                        FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::"G/L Account", ObjLoanProductSetup."Top Up Commision Account", LoanApps."Loan Disbursement Date", LoanTopUp.Commision * -1, 'BOSA', LoanTopUp."Loan Top Up",
                        'Commision on offset -' + LoanApps."Client Code" + '-' + LoanApps."Loan Product Type", LoanTopUp."Loan Top Up");
                    end;

                    //-------------------------------------RECOVER-------------------------------------------------------------------------------------------------------
                    //-------------------------------------Principal-----------------------------------------------------------------------------------------------
                    LineNo := LineNo + 1000;
                    FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, FnGetFosaAccount(LoanApps."Client Code"), LoanApps."Loan Disbursement Date", LoanTopUp."Principle Top Up", 'BOSA', LoanTopUp."Loan Top Up",
                    'Loan Offset  - ' + LoanApps."Loan Product Type", LoanTopUp."Loan Top Up");
                    //-------------------------------------Outstanding Interest-------------------------------------------------------------------------------------
                    LineNo := LineNo + 1000;
                    FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, FnGetFosaAccount(LoanApps."Client Code"), LoanApps."Loan Disbursement Date", LoanTopUp."Interest Top Up", 'BOSA', LoanTopUp."Loan Top Up",
                    'Interest Due Paid on top up - ' + LoanApps."Loan Product Type", LoanTopUp."Loan Top Up");
                    //--------------------------------------Levies--------------------------------------------------------------------------------------------------
                    LineNo := LineNo + 1000;
                    if ObjLoanProductSetup.Get(LoanApps."Loan Product Type") then begin
                        FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::Vendor, FnGetFosaAccount(LoanApps."Client Code"), LoanApps."Loan Disbursement Date", LoanTopUp.Commision, 'BOSA', LoanTopUp."Loan Top Up",
                        'Levy on Bridging - ' + LoanApps."Loan Product Type", LoanTopUp."Loan Top Up");
                    end;
                //-------------------------------------Update Datasheet for Top up-------------------------------------------------------------------------------
                //SFactory.FnUpdateDatasheetTopup(LoanTopUp,LoanApps);
                until LoanTopUp.Next = 0;
            end;
        end;







        //-----------------------------------------5. BOOST DEPOSITS / RECOVER FROM FOSA A/C--------------------------------------------------------------------------------------------
        if LoanApps."Boost this Loan" then begin
            //---------------------------------------BOOST-----------------------------------------------
            LineNo := LineNo + 1000;
            BLoan := LoanApps."Booster Loan No";
            if BLoan = '' then begin
                BLoan := FnBoosterLoansDisbursementNew(LoanApps, LineNo); //Issue Loan
                LoanApps."Booster Loan No" := BLoan;
            end;
            // FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::"Deposit Contribution",
            //GenJournalLine."Account type"::Customer,LoanApps."Client Code",LoanApps."Loan Disbursement Date",LoanApps."Boosted Amount",'BOSA',BLoan,
            //'Deposits Booster for '+LoanApps."Loan  No.",BLoan);

            //----------------------debit FOSA a/c-----------------------------------------------------
            LineNo := LineNo + 1000;
            FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::Vendor, FnGetFosaAccount(LoanApps."Client Code"), LoanApps."Loan Disbursement Date", LoanApps."Boosted Amount", 'BOSA', BLoan,
            'Deposits Booster Loan-Booster Loan', BLoan);


            //------------------------------Boost Deposits-----------------------------------------------
            LineNo := LineNo + 1000;
            FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
            GenJournalLine."account type"::Customer, LoanApps."Client Code", LoanApps."Loan Disbursement Date", LoanApps."Boosted Amount" * -1, 'BOSA', BLoan,
            'Deposits Booster Loan', BLoan);

            //--------------------------------------RECOVER-----------------------------------------------
            // LineNo:=LineNo+1000;
            //FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::" ",
            //GenJournalLine."Account Type"::Vendor,FnGetFosaAccount(LoanApps."Client Code"),LoanApps."Loan Disbursement Date",LoanApps."Boosted Amount",'BOSA',BLoan,
            //'Deposits Booster Loan Recov.',BLoan);
        end;







        //-----------------------------------------6. EARN/RECOVER BOOSTING COMMISSION--------------------------------------------------------------------------------------------
        if LoanApps."Boosting Commision" > 0 then begin
            //---------------------------------------EARN-----------------------------------------------
            LineNo := LineNo + 1000;
            FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::"G/L Account", ObjGenSetUp."Boosting Fees Account", LoanApps."Loan Disbursement Date", LoanApps."Boosting Commision" * -1, 'BOSA', BLoan,
            'Boosting Commision- ' + LoanApps."Client Code" + LoanApps."Loan Product Type" + '-' + LoanApps."Loan  No.", LoanApps."Loan  No.");
            //--------------------------------------RECOVER-----------------------------------------------
            LineNo := LineNo + 1000;
            FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::Vendor, FnGetFosaAccount(LoanApps."Client Code"), LoanApps."Loan Disbursement Date", LoanApps."Boosting Commision", 'BOSA', BLoan,
            'Deposits Booster Comm. Recov.', LoanApps."Loan  No.");
        end;
        //for BLA Loan
        if LoanApps."Is BLA" = true then begin
            FnCreateBLAClearingLine(LoanApps);
        end;

        //
        /*//-----------------------------------------7. EARN/RECOVER BOOSTER LOAN PRINCIPAL--------------------------------------------------------------------------------------------
        IF LoanApps."Boosting Commision" > 0 THEN
          BEGIN
         //---------------------------------------PAY-----------------------------------------------
          LineNo:=LineNo+1000;
          FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::"Loan Repayment",
          GenJournalLine."Account type"::Customer,LoanApps."Client Code",LoanApps."Loan Disbursement Date",LoanApps."Boosted Amount"*-1,'BOSA',BLoan,
          'Deposits Booster Repayment-'+LoanApps."Client Code"+LoanApps."Loan Product Type",BLoan);
          //--------------------------------------RECOVER-----------------------------------------------
          LineNo:=LineNo+1000;
          FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::" ",
          GenJournalLine."Account Type"::Vendor,FnGetFosaAccount(LoanApps."Client Code"),LoanApps."Loan Disbursement Date",LoanApps."Boosted Amount",'BOSA',BLoan,
          'Deposits Booster Loan Recov.',BLoan);
        END;
        */
        /*IF LoanApps."Boosting Commision" > 0 THEN
          BEGIN
         //---------------------------------------PAY-----------------------------------------------
          LineNo:=LineNo+1000;
          FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::"Interest Paid",
          GenJournalLine."Account type"::Customer,LoanApps."Client Code",LoanApps."Loan Disbursement Date",LoanApps."Boosted Amount Interest"*-1,'BOSA',BLoan,
          'Deposits Booster Int - '+LoanApps."Client Code"+LoanApps."Loan Product Type",BLoan);
          //--------------------------------------RECOVER-----------------------------------------------
          LineNo:=LineNo+1000;
          FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::" ",
          GenJournalLine."Account Type"::Vendor,FnGetFosaAccount(LoanApps."Client Code"),LoanApps."Loan Disbursement Date",LoanApps."Boosted Amount Interest",'BOSA',BLoan,
          'Deposits Booster Int Recov.',BLoan);
        END;
        */
        LoanApps."Net Payment to FOSA" := AmountToDisburse;
        LoanApps."Processed Payment" := true;
        LoanApps.Posted := true;
        LoanApps."Loan Status" := LoanApps."loan status"::Issued;
        LoanApps."Issued Date" := LoanApps."Loan Disbursement Date";
        LoanApps.Modify;
        exit(LineNo);

    end;

    local procedure FnBoosterLoansDisbursementNew(ObjLoanDetails: Record "Loans Register"; LineNo: Integer): Code[40]
    var
        GenJournalLine: Record "Gen. Journal Line";
        CUNoSeriesManagement: Codeunit "No. Series";
        DocNumber: Code[100];
        loanTypes: Record "Loan Products Setup";
        ObjLoanX: Record "Loans Register";
    begin
        loanTypes.Reset;
        loanTypes.SetRange(loanTypes.Code, 'BLOAN');
        if loanTypes.Find('-') then begin
            DocNumber := CUNoSeriesManagement.GetNextNo('LOANSB', 0D, true);
            ObjLoans.Init;
            ObjLoans."Loan  No." := DocNumber;
            ObjLoans.Insert;

            if ObjLoans.Get(ObjLoans."Loan  No.") then begin
                ObjLoans."Client Code" := ObjLoanDetails."Client Code";
                ObjLoans.Validate(ObjLoans."Client Code");
                ObjLoans."Loan Product Type" := 'BLOAN';
                ObjLoans.Validate(ObjLoans."Loan Product Type");
                ObjLoans.Interest := ObjLoanDetails.Interest;
                ObjLoans."Loan Status" := ObjLoans."loan status"::Issued;
                ObjLoans."Application Date" := ObjLoanDetails."Application Date";
                ObjLoans."Issued Date" := ObjLoanDetails."Posting Date";
                ObjLoans."Loan Disbursement Date" := ObjLoanDetails."Loan Disbursement Date";
                ObjLoans.Validate(ObjLoans."Loan Disbursement Date");
                ObjLoans."Mode of Disbursement" := ObjLoans."mode of disbursement"::"Bank Transfer";
                ObjLoans."Repayment Start Date" := ObjLoanDetails."Repayment Start Date";
                ObjLoans."Global Dimension 1 Code" := 'BOSA';
                ObjLoans."Global Dimension 2 Code" := FnGetUserBranch();
                ObjLoans.Source := ObjLoanDetails.Source;
                ObjLoans."Approval Status" := ObjLoanDetails."Approval Status";
                ObjLoans.Repayment := ObjLoanDetails."Boosted Amount";
                ObjLoans."Requested Amount" := ObjLoanDetails."Boosted Amount";
                ObjLoans."Approved Amount" := ObjLoanDetails."Boosted Amount";
                ObjLoans.Interest := ObjLoanDetails.Interest;
                ObjLoans."Mode of Disbursement" := ObjLoans."mode of disbursement"::"Bank Transfer";
                ObjLoans.Posted := true;
                ObjLoans."Advice Date" := Today;
                ObjLoans.Modify;
            end;
        end;
        exit(DocNumber);
    end;


    procedure FnDisburseToExternalAccount(LoanApps: Record "Loans Register"; LineNumber: Integer): Integer
    var
        ProcessingFees: Decimal;
        ProcessingFeesAcc: Code[50];
        PChargeAmount: Decimal;
        BLoan: Code[30];
        TCharges: Decimal;
        TopUpComm: Decimal;
        TotalTopupComm: Decimal;
        LineNo: Integer;
        GenJournalLine: Record "Gen. Journal Line";
        RunningBalance: Decimal;
    begin
        //BATCH_TEMPLATE:='GENERAL';
        if (LoanApps."Account No" = '201215') or (LoanApps."Account No" = '101053') then
            BATCH_TEMPLATE := 'PAYMENTS';
        BATCH_NAME := 'LOANS';
        DOCUMENT_NO := LoanApps."Batch No.";
        if DOCUMENT_NO = '' then
            DOCUMENT_NO := LoanApps."Loan  No.";

        LoanApps.Validate("G/L Account");
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
        GenJournalLine.DeleteAll;
        RunningBalance := LoanApps."Approved Amount";

        ObjGenSetUp.Get();
        LoanApps.CalcFields(LoanApps."Top Up Amount", LoanApps."Topup iNTEREST");
        TCharges := 0;
        TopUpComm := 0;
        TotalTopupComm := LoanApps."Top Up Amount";

        //------------------------------------1. DEBIT MEMBER LOAN A/C---------------------------------------------------------------------------------------------
        LineNo := LineNumber;
        FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::Loan,
        GenJournalLine."account type"::Customer, LoanApps."Client Code", LoanApps."Loan Disbursement Date", RunningBalance, Format(LoanApps.Source), LoanApps."Cheque No.",
        'Loan principle- ' + LoanApps."Loan Product Type" + '-' + LoanApps."Loan  No.", LoanApps."Loan  No.");
        //--------------------------------(Debit Member Loan Account)------------------------------------------------------------
        //-----------------------------------1B. ACCRUE INTEREST IF Constant-----------------------------------------------------
        if ((LoanApps."Repayment Method" = LoanApps."repayment method"::Constants) and (ObjLoanProductSetup.Get(LoanApps."Loan Product Type"))) then begin
            LineNo := LineNo + 1000;
            FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Due",
            GenJournalLine."account type"::Customer, LoanApps."Client Code", LoanApps."Loan Disbursement Date", LoanApps."Interest Upfront Amount", Format(LoanApps.Source), LoanApps."Cheque No.",
            'Interest Due', LoanApps."Loan  No.");
            LineNo := LineNo + 1000;
            FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::"G/L Account", ObjLoanProductSetup."Loan Interest Account", LoanApps."Loan Disbursement Date", LoanApps."Interest Upfront Amount" * -1, Format(LoanApps.Source), LoanApps."Cheque No.",
            'Interest Due', LoanApps."Loan  No.");

            LineNo := LineNo + 1000;
            FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
            GenJournalLine."account type"::Customer, LoanApps."Client Code", LoanApps."Loan Disbursement Date", LoanApps."Interest Upfront Amount" * -1, Format(LoanApps.Source), LoanApps."Cheque No.",
            'Interest Paid', LoanApps."Loan  No.");
            RunningBalance := RunningBalance - LoanApps."Interest Due";
        end;

        //-------------------------------------End-------------------------------------------------------------------------------

        //------------------------------------2. EARN/RECOVER PRODUCT CHARGES FROM FOSA A/C--------------------------------------
        PCharges.Reset;
        PCharges.SetRange(PCharges."Product Code", LoanApps."Loan Product Type");
        if PCharges.Find('-') then begin
            repeat
                PCharges.TestField(PCharges."G/L Account");
                ObjGenSetUp.TestField(ObjGenSetUp."Excise Duty Account");
                PChargeAmount := PCharges.Amount;
                if PCharges."Use Perc" = true then
                    PChargeAmount := (LoanApps."Approved Amount" * PCharges.Percentage / 100);
                //-------------------EARN CHARGE-------------------------------------------
                LineNo := LineNo + 1000;
                FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::"G/L Account", PCharges."G/L Account", LoanApps."Loan Disbursement Date", PChargeAmount * -1, 'BOSA', LoanApps."Cheque No.",
                LoanApps."Loan Product Type" + '-' + LoanApps."Loan  No.", LoanApps."Loan  No.");
                //-------------------RECOVER-----------------------------------------------
                RunningBalance := RunningBalance - PChargeAmount;

                //------------------10% EXCISE DUTY----------------------------------------
                if FnChargeExcise(PCharges.Code) then begin
                    //-------------------Earn---------------------------------
                    LineNo := LineNo + 1000;
                    FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::"G/L Account", ObjGenSetUp."Excise Duty Account", LoanApps."Loan Disbursement Date", (PChargeAmount * -1) * 0.1, 'BOSA', LoanApps."Cheque No.",
                   LoanApps."Loan  No." + '- Excise(10%)', LoanApps."Loan  No.");
                    //-----------------Recover---------------------------------
                    RunningBalance := RunningBalance - PChargeAmount * 0.1;
                end
            //----------------END 10% EXCISE--------------------------------------------
            until PCharges.Next = 0;
        end;


        //----------------------------------------3. PAY/RECOVER TOP UPS------------------------------------------------------------------------------------------
        if LoanApps."Top Up Amount" > 0 then begin
            LoanTopUp.Reset;
            LoanTopUp.SetRange(LoanTopUp."Loan No.", LoanApps."Loan  No.");
            if LoanTopUp.Find('-') then begin
                repeat
                    //------------------------------------PAY-----------------------------------------------------------------------------------------------------------
                    //------------------------------------Principal---------------------
                    LineNo := LineNo + 1000;
                    FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                    GenJournalLine."account type"::Customer, LoanApps."Client Code", LoanApps."Loan Disbursement Date", LoanTopUp."Principle Top Up" * -1, 'BOSA', LoanApps."Loan  No.",
                    'Off Set By - ' + LoanApps."Loan  No.", LoanTopUp."Loan Top Up");
                    //------------------------------------Outstanding Interest----------
                    LineNo := LineNo + 1000;
                    FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                    GenJournalLine."account type"::Customer, LoanApps."Client Code", LoanApps."Loan Disbursement Date", LoanTopUp."Interest Top Up" * -1, 'BOSA', LoanApps."Loan  No.",
                    'Interest Paid-' + '-' + LoanApps."Loan  No.", LoanTopUp."Loan Top Up");
                    //-------------------------------------Levy--------------------------
                    LineNo := LineNo + 1000;
                    if ObjLoanProductSetup.Get(LoanApps."Loan Product Type") then begin
                        FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::"G/L Account", ObjLoanProductSetup."Top Up Commision Account", LoanApps."Loan Disbursement Date", LoanTopUp.Commision * -1, 'BOSA', LoanApps."Loan  No.",
                        'Levy on Bridging -' + LoanApps."Loan Product Type" + '-' + LoanApps."Loan  No.", LoanTopUp."Loan Top Up");
                    end;

                    //-------------------------------------RECOVER-------------------------------------------------------------------------------------------------------
                    //---Principal---------------------------------------------------
                    RunningBalance := RunningBalance - LoanTopUp."Principle Top Up";
                    //---Outstanding Interest----------------------------------------
                    RunningBalance := RunningBalance - LoanTopUp."Interest Top Up";
                    //---Levies-------------------------------------------------------
                    RunningBalance := RunningBalance - LoanTopUp.Commision;
                //-------------------------------------Update Datasheet for Top up-------------------------------------------------------------------------------
                //SFactory.FnUpdateDatasheetTopup(LoanTopUp,LoanApps);
                until LoanTopUp.Next = 0;
            end;
        end;

        //-----------------------------------------4. BOOST DEPOSITS /(NB:No effect on RunningBalance)--------------------------------------------------------------------------------------------
        if LoanApps."Boost this Loan" then begin
            //---------------------------------------BOOST-----------------------------------------------
            LineNo := LineNo + 1000;
            BLoan := LoanApps."Booster Loan No";
            if BLoan = '' then begin
                BLoan := FnBoosterLoansDisbursementNew(LoanApps, LineNo); //Issue Loan
                LoanApps."Booster Loan No" := BLoan;
            end;
            FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::Loan,
            GenJournalLine."account type"::Customer, LoanApps."Client Code", LoanApps."Loan Disbursement Date", LoanApps."Boosted Amount", 'BOSA', LoanApps."Loan  No.",
            'Deposits Booster for ' + LoanApps."Loan  No.", BLoan);

            //------------------------------Boost Deposits-----------------------------------------------
            LineNo := LineNo + 1000;
            FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
            GenJournalLine."account type"::Customer, LoanApps."Client Code", LoanApps."Loan Disbursement Date", LoanApps."Boosted Amount" * -1, 'BOSA', LoanApps."Loan  No.",
            'Deposits Booster Loan', BLoan);
        end;

        //-----------------------------------------5. EARN/RECOVER BOOSTING COMMISSION--------------------------------------------------------------------------------------------
        if LoanApps."Boosting Commision" > 0 then begin
            //---------------------------------------EARN-----------------------------------------------
            LineNo := LineNo + 1000;
            FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::"G/L Account", ObjGenSetUp."Boosting Fees Account", LoanApps."Loan Disbursement Date", LoanApps."Boosting Commision" * -1, 'BOSA', LoanApps."Loan  No.",
            'Boosting Commision- ' + LoanApps."Loan Product Type" + '-' + LoanApps."Loan  No.", LoanApps."Loan  No.");
            //--------------------------------------RECOVER-----------------------------------------------
            RunningBalance := RunningBalance - LoanApps."Boosting Commision";
        end;

        //-----------------------------------------7. EARN/RECOVER BOOSTER LOAN PRINCIPAL--------------------------------------------------------------------------------------------
        if LoanApps."Boosting Commision" > 0 then begin
            //---------------------------------------PAY-----------------------------------------------
            LineNo := LineNo + 1000;
            FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
            GenJournalLine."account type"::Customer, LoanApps."Client Code", LoanApps."Loan Disbursement Date", LoanApps."Boosted Amount" * -1, 'BOSA', LoanApps."Loan  No.",
            'Deposits Booster Repayment-' + LoanApps."Client Code" + LoanApps."Loan Product Type", BLoan);
            //--------------------------------------RECOVER-----------------------------------------------
            RunningBalance := RunningBalance - LoanApps."Boosted Amount";
        end;

        //-----------------------------------------8. EARN/RECOVER BOOSTER LOAN INTEREST--------------------------------------------------------------------------------------------
        if LoanApps."Boosting Commision" > 0 then begin
            //---------------------------------------PAY-----------------------------------------------
            LineNo := LineNo + 1000;
            FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
            GenJournalLine."account type"::Customer, LoanApps."Client Code", LoanApps."Loan Disbursement Date", LoanApps."Boosted Amount Interest" * -1, 'BOSA', LoanApps."Loan  No.",
            'Deposits Booster Int - ' + LoanApps."Loan Product Type", BLoan);
            //--------------------------------------RECOVER-----------------------------------------------
            RunningBalance := RunningBalance - LoanApps."Boosted Amount Interest";
        end;
        Message('LoanApps."G/L Account", is %1', LoanApps."G/L Account");
        //---------------------------------------9. CREDIT PAYING BANK A/C-----------------------------------------------------------------------------------------------------------

        LineNo := LineNo + 1000;
        FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
        GenJournalLine."account type"::"G/L Account", LoanApps."G/L Account", LoanApps."Loan Disbursement Date", RunningBalance * -1, 'BOSA', LoanApps."Cheque No.",
        'Loan Issued- ' + LoanApps."Loan Product Type", LoanApps."Loan  No.");
        //----------------------------------(Credit Paying Bank Account)-------------------------------------------------------------------------------------------------------------

        LoanApps."Amount Disbursed" := RunningBalance;
        LoanApps."Processed Payment" := true;
        LoanApps.Posted := true;
        LoanApps."Loan Status" := LoanApps."loan status"::Issued;
        LoanApps."Issued Date" := LoanApps."Loan Disbursement Date";
        LoanApps.Modify;
        exit(LineNo);
    end;


    procedure FnGenerateRepaymentScheduleReschedule(LoanNumber: Code[50])
    var
        LoansRec: Record "Loans Register";
        RSchedule: Record "Loan Repayment Schedule";
        LoanAmount: Decimal;
        InterestRate: Decimal;
        RepayPeriod: Integer;
        InitialInstal: Decimal;
        LBalance: Decimal;
        RunDate: Date;
        InstalNo: Decimal;
        TotalMRepay: Decimal;
        LInterest: Decimal;
        LPrincipal: Decimal;
        GrPrinciple: Integer;
        GrInterest: Integer;
        RepayCode: Code[10];
        WhichDay: Integer;
    begin
        LoansRec.Reset;
        LoansRec.SetRange(LoansRec."Loan  No.", LoanNumber);
        LoansRec.SetFilter(LoansRec."Approved Amount", '>%1', 0);
        LoansRec.SetFilter(LoansRec.Posted, '=%1', true);
        if LoansRec.Find('-') then begin

            if ((LoansRec."Issued Date" <> 0D) and (LoansRec."Repayment Start Date" <> 0D)) then begin
                LoansRec.CalcFields("Outstanding Balance");
                LoansRec.TestField(LoansRec."Loan Disbursement Date");
                LoansRec.TestField(LoansRec."Repayment Start Date");

                RSchedule.Reset;
                RSchedule.SetRange(RSchedule."Loan No.", LoansRec."Loan  No.");
                RSchedule.DeleteAll;

                //LoanAmount:=LoansRec."Approved Amount";
                LoanAmount := LoansRec."Outstanding Balance";
                InterestRate := LoansRec.Interest;
                RepayPeriod := LoansRec.Installments;
                InitialInstal := LoansRec.Installments + LoansRec."Grace Period - Principle (M)";
                //LBalance:=LoansRec."Approved Amount";
                LBalance := LoansRec."Outstanding Balance";
                RunDate := LoansRec."Repayment Start Date";
                InstalNo := 0;

                //Repayment Frequency
                if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Daily then
                    RunDate := CalcDate('-1D', RunDate)
                else if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Weekly then
                    RunDate := CalcDate('-1W', RunDate)
                else if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Monthly then
                    RunDate := CalcDate('-1M', RunDate)
                else if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Quaterly then
                    RunDate := CalcDate('-1Q', RunDate);
                //Repayment Frequency


                repeat
                    InstalNo := InstalNo + 1;
                    //Repayment Frequency
                    if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Daily then
                        RunDate := CalcDate('1D', RunDate)
                    else if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Weekly then
                        RunDate := CalcDate('1W', RunDate)
                    else if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Monthly then
                        RunDate := CalcDate('1M', RunDate)
                    else if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Quaterly then
                        RunDate := CalcDate('1Q', RunDate);

                    if LoansRec."Repayment Method" = LoansRec."repayment method"::Amortised then begin
                        LoansRec.TestField(LoansRec.Installments);
                        TotalMRepay := ROUND((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -(RepayPeriod))) * (LoanAmount), 0.0001, '>');
                        LInterest := ROUND(LBalance / 100 / 12 * InterestRate, 0.0001, '>');
                        LPrincipal := TotalMRepay - LInterest;
                    end;

                    if LoansRec."Repayment Method" = LoansRec."repayment method"::"Straight Line" then begin
                        LoansRec.TestField(LoansRec.Interest);
                        LoansRec.TestField(LoansRec.Installments);
                        LPrincipal := LoanAmount / RepayPeriod;
                        LInterest := (InterestRate / 12 / 100) * LoanAmount / RepayPeriod;
                    end;

                    if LoansRec."Repayment Method" = LoansRec."repayment method"::"Reducing Balance" then begin
                        LoansRec.TestField(LoansRec.Interest);
                        LoansRec.TestField(LoansRec.Installments);
                        LPrincipal := LoanAmount / RepayPeriod;
                        LInterest := (InterestRate / 12 / 100) * LBalance;
                    end;

                    if LoansRec."Repayment Method" = LoansRec."repayment method"::Constants then begin
                        LoansRec.TestField(LoansRec.Repayment);
                        if LBalance < LoansRec.Repayment then
                            LPrincipal := LBalance
                        else
                            LPrincipal := LoansRec.Repayment;
                        LInterest := LoansRec.Interest;
                    end;

                    //Grace Period
                    if GrPrinciple > 0 then begin
                        LPrincipal := 0
                    end else begin
                        LBalance := LBalance - LPrincipal;

                    end;

                    if GrInterest > 0 then
                        LInterest := 0;

                    GrPrinciple := GrPrinciple - 1;
                    GrInterest := GrInterest - 1;
                    Evaluate(RepayCode, Format(InstalNo));


                    RSchedule.Init;
                    RSchedule."Repayment Code" := RepayCode;
                    RSchedule."Interest Rate" := InterestRate;
                    RSchedule."Loan No." := LoansRec."Loan  No.";
                    RSchedule."Loan Amount" := LoanAmount;
                    RSchedule."Instalment No" := InstalNo;
                    RSchedule."Repayment Date" := CalcDate('CM', RunDate);
                    RSchedule."Member No." := LoansRec."Client Code";
                    RSchedule."Loan Category" := LoansRec."Loan Product Type";
                    RSchedule."Monthly Repayment" := LInterest + LPrincipal;
                    RSchedule."Monthly Interest" := LInterest;
                    RSchedule."Principal Repayment" := LPrincipal;
                    RSchedule."Loan Balance" := LBalance;
                    RSchedule.Insert;
                    WhichDay := Date2dwy(RSchedule."Repayment Date", 1);
                until LBalance < 1

            end;
        end;

        Commit;
    end;

    local procedure FnCreateBLAClearingLine(LoansRec: Record "Loans Register")
    var
        LoanOffset: Record 51376;
    begin


        LoanOffset.Init;
        LoanOffset."Loan No." := LoansRec."BLA Clearance Loan";
        LoanOffset."Client Code" := LoansRec."Client Code";
        LoanOffset."Loan Top Up" := LoansRec."Loan  No.";
        LoanOffset."Loan Type" := LoansRec."Loan Product Type";
        LoanOffset."Principle Top Up" := LoansRec."Approved Amount";
        LoanOffset."Interest Top Up" := ROUND(((LoansRec."Approved Amount" * LoansRec.Interest) / 200), 0.05, '=');
        LoanOffset.Commision := 0;
        LoanOffset."Total Top Up" := LoanOffset."Principle Top Up" + LoanOffset."Interest Top Up" + LoanOffset.Commision;
        LoanOffset.Insert;
    end;


    procedure KnCalculateLoanTopUpFee(LoanNo: Code[10]): Decimal
    var
        TopUpFee: Decimal;
        ObjLoanTopUp: Record 51376;
        TotalAmount: Decimal;
        Commision: Decimal;
        ObjSaccoGenSetUp: Record "Sacco General Set-Up";
    begin
        ObjSaccoGenSetUp.Get;
        ObjLoanTopUp.Reset;
        ObjLoanTopUp.SetRange(ObjLoanTopUp."Loan No.", LoanNo);
        if ObjLoanTopUp.Find('-') then begin
            repeat
                TotalAmount := ObjLoanTopUp."Total Top Up" + TotalAmount;
            until ObjLoanTopUp.Next = 0;
            Commision := (ObjSaccoGenSetUp."Loan Top Up Commision(%)" / 100) * TotalAmount;
            if Commision > ObjSaccoGenSetUp."Loan Top Up Commision(Min)" then
                TopUpFee := Commision
            else
                TopUpFee := ObjSaccoGenSetUp."Loan Top Up Commision(Min)";
        end;
        exit(TopUpFee);
    end;


    procedure KnGetMemberPhoneNo(MemberNo: Code[15]): Code[20]
    var
        ObjMembersReg: Record Customer;
        PhoneNo: Code[20];
    begin
        if ObjMembersReg.Get(MemberNo) then begin
            PhoneNo := ObjMembersReg."Mobile Phone No";
        end;

        exit(PhoneNo);
    end;


    procedure KnGetMemberEmailAddress(MemberNo: Code[15]): Code[50]
    var
        ObjMembersReg: Record Customer;
        Email: Code[50];
    begin
        if ObjMembersReg.Get(MemberNo) then begin
            Email := ObjMembersReg."E-Mail";
        end;

        exit(Email);
    end;


    procedure KnCheckIfMemberHasConsolidaterLoan(MemberNo: Code[20]; LoanType: Code[20]): Boolean
    var
        ObjLoansReg: Record "Loans Register";
    begin
        ObjLoansReg.Reset;
        ObjLoansReg.SetRange(ObjLoansReg."Client Code", MemberNo);
        ObjLoansReg.SetRange(ObjLoansReg."Loan Product Type", LoanType);
        if ObjLoansReg.Find('-') then begin
            exit(true);
        end else
            exit(false);
    end;


    procedure KnCheckIfLoanTypeIsConsolidater(LoanType: Code[10]): Boolean
    var
        ObjLoanProductSetUp: Record "Loan Products Setup";
    begin
        if ObjLoanProductSetUp.Get(LoanType) then begin
            if ObjLoanProductSetUp.Consolidater then
                exit(true)
            else
                exit(false);
        end;
    end;


    procedure FnGetMemberSelfLiability(MemberNo: Code[30]) VarTotaMemberLiability: Decimal
    var
        ObjLoanGuarantors: Record 51372;
        ObjLoans: Record "Loans Register";
        ObjLoanSecurities: Record 51374;
        ObjLoanGuarantors2: Record 51372;
        VarTotalGuaranteeValue: Decimal;
        VarMemberAnountGuaranteed: Decimal;
        VarApportionedLiability: Decimal;
        VarLoanOutstandingBal: Decimal;
        MAmountG: Decimal;
        MamountToG: Decimal;
    begin
        ObjMembers.Reset;
        ObjMembers.SetRange(ObjMembers."No.", MemberNo);
        if ObjMembers.FindSet then begin
            VarTotalGuaranteeValue := 0;
            VarApportionedLiability := 0;
            VarTotaMemberLiability := 0;
            //Loans Guaranteed=======================================================================
            ObjLoanGuarantors.Reset;
            ObjLoanGuarantors.SetRange(ObjLoanGuarantors."Member No", MemberNo);
            ObjLoanGuarantors.SetRange(ObjLoanGuarantors."Self Guarantee", true);
            if ObjLoanGuarantors.FindSet then begin
                repeat

                    ObjLoanGuarantors.CalcFields(ObjLoanGuarantors."Total Loans Guaranteed");
                    if ObjLoans.Get(ObjLoanGuarantors."Loan No") then begin
                        ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                        VarLoanOutstandingBal := ObjLoans."Outstanding Balance";
                        if ObjLoanGuarantors."Total Loans Guaranteed" > 0 then begin
                            if VarLoanOutstandingBal > 0 then begin
                                VarApportionedLiability := ROUND((ObjLoanGuarantors."Amont Guaranteed" / ObjLoanGuarantors."Total Loans Guaranteed") * VarLoanOutstandingBal, 0.5, '=');
                                VarTotalGuaranteeValue := VarTotalGuaranteeValue + VarApportionedLiability;
                                if ObjLoanGuarantors."Self Guarantee" = true then
                                    VarTotalGuaranteeValue := ObjLoanGuarantors."Amont Guaranteed";
                                //MESSAGE('VarTotalGuaranteeValue %1||VarApportionedLiability %2',VarTotalGuaranteeValue,VarApportionedLiability);

                            end;
                        end;
                    end;
                until ObjLoanGuarantors.Next = 0;
            end;
            //********************************
            MAmountG := 0;
            MamountToG := 0;
            ObjLoanGuarantors.Reset;
            ObjLoanGuarantors.SetRange(ObjLoanGuarantors."Member No", MemberNo);
            ObjLoanGuarantors.SetRange(ObjLoanGuarantors."Application Statu", true);
            ObjLoanGuarantors.SetRange(ObjLoanGuarantors."Self Guarantee", true);
            if ObjLoanGuarantors.FindSet then begin
                repeat
                    ObjLoanGuarantors.CalcFields(ObjLoanGuarantors."Total Loans Guaranteed");
                    if ObjLoans.Get(ObjLoanGuarantors."Loan No") then begin
                        ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                        VarLoanOutstandingBal := ObjLoans."Outstanding Balance";
                        if ObjLoanGuarantors."Total Loans Guaranteed" > 0 then begin
                            if VarLoanOutstandingBal < 0 then begin

                                MamountToG := ROUND((ObjLoanGuarantors."Amont Guaranteed" / ObjLoanGuarantors."Total Loans Guaranteed") * VarLoanOutstandingBal, 0.5, '=');
                                MAmountG := MAmountG + MamountToG;

                            end;
                        end;
                    end;
                until ObjLoanGuarantors.Next = 0;
            end;

            //*********************************
            VarTotaMemberLiability := MAmountG + VarTotalGuaranteeValue;
            // MESSAGE('VarTotaMemberLiability %1||MAmountG %2||VarTotalGuaranteeValue %3',VarTotaMemberLiability,MAmountG,VarTotalGuaranteeValue);


        end;
        exit(VarTotaMemberLiability);
    end;


    procedure KnGetInterestBalanceOneLoan(LoanNo: Code[20]) Amount: Decimal
    var
        ObjLoansRegister: Record "Loans Register";
    begin
        ObjLoansRegister.Reset;
        ObjLoansRegister.SetRange(ObjLoansRegister."Loan  No.", LoanNo);
        if ObjLoansRegister.Find('-') then begin
            ObjLoansRegister.CalcFields("Oustanding Interest");
            Amount := Amount + ObjLoansRegister."Oustanding Interest";
        end;

        exit(Amount);


        //*******calculate a third of a members netpay**********//
    end;


    procedure KnGetLoanBalanceOneLoan(LoanNo: Code[20]) Amount: Decimal
    var
        ObjLoansRegister: Record "Loans Register";
        MeReg: Record Customer;
    begin
        ObjLoansRegister.Reset;
        ObjLoansRegister.SetRange(ObjLoansRegister."Loan  No.", LoanNo);
        if ObjLoansRegister.Find('-') then begin
            ObjLoansRegister.CalcFields(ObjLoansRegister."Outstanding Balance");
            Amount := Amount + ObjLoansRegister."Outstanding Balance";
        end;

        exit(Amount);


        //*******calculate a third of a members netpay**********//
    end;


    procedure knCheckIfMemberIsWithdrawn(MemberNo: Code[30]): Boolean
    var
        MembersRegisterLocal: Record Customer;
    begin
        MembersRegisterLocal.Reset;
        MembersRegisterLocal.SetRange("No.", MemberNo);
        MembersRegisterLocal.SetRange(MembersRegisterLocal.Blocked, MembersRegisterLocal.Blocked::All);
        if MembersRegisterLocal.Find('-') then
            exit(true)
        else
            exit(false);
    end;


    procedure KnCheckIfMemberHasWithdrawalNotice(MemberNo: Code[10]): Boolean
    var
        MembershipExit: Record "Membership Exit";
    begin
        MembershipExit.Reset;
        MembershipExit.SetRange(MembershipExit."Member No.", MemberNo);
        MembershipExit.SetRange(MembershipExit.Posted, false);
        if MembershipExit.Find('-') then begin
            exit(true)
        end;
    end;


    // procedure KnGetCurrentPeriodForLoan(LoanNo: Code[20]) Period: Integer
    // var
    //     ObjLoanRepaymentSchedule: Record "Loan Repayment Schedule";
    //     PrevMonth: Date;
    //     DateParm: Date;
    //     RepaymentDate: Date;
    // begin
    //     ObjLoanRepaymentSchedule.Reset;
    //     ObjLoanRepaymentSchedule.SetRange(ObjLoanRepaymentSchedule."Loan No.",LoanNo);
    //     if ObjLoanRepaymentSchedule.Find('-') then
    //       begin
    //         PrevMonth:=KnGetPreviousMonthLastDate(LoanNo,Today);
    //         repeat
    //         //ObjLoanRepaymentSchedule.SETRANGE(ObjLoanRepaymentSchedule."Repayment Date",PrevMonth);
    //         if ObjLoanRepaymentSchedule."Repayment Date"<>0D then
    //           DateParm:=CalcDate ('CM',ObjLoanRepaymentSchedule."Repayment Date");
    //         if DateParm=PrevMonth then
    //           begin
    //             Period:=ObjLoanRepaymentSchedule."Instalment No";
    //           end;
    //           until ObjLoanRepaymentSchedule.Next=0;
    //       end;
    // end;
    /*  procedure KnGetCurrentPeriodForLoan(LoanNo: Code[20]) Period: Integer
var
    ObjLoanRepaymentSchedule: Record "Loan Repayment Schedule";
    PrevMonth: Date;
    DateParm: Date;
    LastRepaymentSchedule: Integer;
    LastRepaymentDate: Date;
    MonthsElapsed: Integer;
begin
    Period := 0; // Default value if no match is found

    ObjLoanRepaymentSchedule.Reset;
    ObjLoanRepaymentSchedule.SetRange("Loan No.", LoanNo);

    // Fetch the last date of the previous month
    PrevMonth := KnGetPreviousMonthLastDate(LoanNo, Today);

    if ObjLoanRepaymentSchedule.FindSet then begin
        repeat
            if ObjLoanRepaymentSchedule."Repayment Date" <> 0D then begin
                DateParm := CalcDate('CM', ObjLoanRepaymentSchedule."Repayment Date");

                // If the repayment date matches the previous month
                if DateParm = PrevMonth then begin
                    Period := ObjLoanRepaymentSchedule."Instalment No";
                    exit; // Exit as we've found the matching period
                end;

                // Track the last repayment schedule and its date
                LastRepaymentSchedule := ObjLoanRepaymentSchedule."Instalment No";
                LastRepaymentDate := ObjLoanRepaymentSchedule."Repayment Date";
            end;
        until ObjLoanRepaymentSchedule.Next() = 0;
    end;

    // If no exact match, assign the last repayment schedule
    if Period = 0 then
        Period := LastRepaymentSchedule;

    // If today's date is beyond the last repayment date, keep counting
    if Today > LastRepaymentDate then begin
        MonthsElapsed := Date2DMY(Today, 3) - Date2DMY(LastRepaymentDate, 3);
        Period := LastRepaymentSchedule + MonthsElapsed;
    end;
end;*/
    procedure KnGetCurrentPeriodForLoan(LoanNo: Code[20]) Period: Integer
    var
        ObjLoanRepaymentSchedule: Record "Loan Repayment Schedule";
        PrevMonth: Date;
        DateParm: Date;
        LastRepaymentSchedule: Integer;
        LastRepaymentDate: Date;
        MonthsElapsed: Integer;
        YearToday, MonthToday, YearLast, MonthLast : Integer;
    begin
        Period := 0; // Default value if no match is found

        ObjLoanRepaymentSchedule.Reset;
        ObjLoanRepaymentSchedule.SetRange("Loan No.", LoanNo);

        // Fetch the last date of the previous month
        PrevMonth := KnGetPreviousMonthLastDate(LoanNo, Today);

        if ObjLoanRepaymentSchedule.FindSet then begin
            repeat
                if ObjLoanRepaymentSchedule."Repayment Date" <> 0D then begin
                    DateParm := CalcDate('CM', ObjLoanRepaymentSchedule."Repayment Date");

                    // If the repayment date matches the previous month
                    if DateParm = PrevMonth then begin
                        Period := ObjLoanRepaymentSchedule."Instalment No";
                        exit; // Exit as we've found the matching period
                    end;

                    // Track the last repayment schedule
                    LastRepaymentSchedule := ObjLoanRepaymentSchedule."Instalment No";
                    LastRepaymentDate := ObjLoanRepaymentSchedule."Repayment Date";
                end;
            until ObjLoanRepaymentSchedule.Next() = 0;
        end;

        // If no exact match, calculate elapsed months since the last repayment
        if LastRepaymentDate <> 0D then begin
            YearToday := Date2DMY(Today, 3);
            MonthToday := Date2DMY(Today, 2);
            YearLast := Date2DMY(LastRepaymentDate, 3);
            MonthLast := Date2DMY(LastRepaymentDate, 2);

            // Calculate months difference correctly
            MonthsElapsed := (YearToday - YearLast) * 12 + (MonthToday - MonthLast);

            // Ensure we keep counting beyond last installment
            Period := LastRepaymentSchedule + MonthsElapsed;
        end;
    end;



    procedure KnGetPreviousMonthLastDate(LoanNo_: Text[30]; Date_: Date) Lastdate: Date
    var
        ObjLoansReg: Record "Loans Register";
    begin
        if ObjLoansReg.Get(LoanNo_) then begin
            if (ObjLoansReg."Repayment Frequency" = ObjLoansReg."repayment frequency"::Monthly) then begin
                if (Date_ = CalcDate('CM', Date_)) then begin
                    Lastdate := Date_;
                end else begin
                    Lastdate := CalcDate('-1M', Date_);
                end;
                Lastdate := CalcDate('CM', Lastdate);
            end;
        end;

        exit(Lastdate);
    end;


    procedure KnUpdateAmountGuaranteed(LoanNo: Code[20]; AmountPaid: Decimal; ClientCode: Code[20])
    var
        ObjLoansGuaranteeDetails: Record 51372;
        Amount: Decimal;
        LoanBalance: Decimal;
        ApprovedAmount: Decimal;
        AmountGuaranteed: Decimal;
        MembersReg: Record Customer;
        freedSharesRetained: Decimal;
        PrevAmount: Decimal;
        SavingsGuarantorship: Record 51711;
        VarTotaMemberLiability: Decimal;
        AmtPaid: Decimal;
    begin
        SavingsGuarantorship.Reset;
        SavingsGuarantorship.SetRange(SavingsGuarantorship."Loan No", LoanNo);
        if SavingsGuarantorship.FindSet then begin
            SavingsGuarantorship.CalcFields(SavingsGuarantorship.Liability);
            VarTotaMemberLiability := SavingsGuarantorship.Liability;
            if VarTotaMemberLiability > 0 then
                SavingsGuarantorship.Liability := SavingsGuarantorship.Liability - AmountPaid;
            SavingsGuarantorship.Modify;
        end;


        ObjLoansGuaranteeDetails.Reset;
        ObjLoansGuaranteeDetails.SetRange(ObjLoansGuaranteeDetails."Loan No", LoanNo);
        if ObjLoansGuaranteeDetails.FindSet then begin
            repeat
                AmtPaid := 0;
                AmtPaid := FnGetLoanAmountPaid(LoanNo);
                if ObjLoansGuaranteeDetails."Original Amount" > 0 then
                    ObjLoansGuaranteeDetails.CalcFields("Outstanding Balance", "Total Loans Guaranteed");
                if ObjLoansGuaranteeDetails."Total Loans Guaranteed" > 0 then
                    //IF VarTotaMemberLiability>0 THEN

                    ObjLoansGuaranteeDetails."Amont Guaranteed" := ROUND(((ObjLoansGuaranteeDetails."Original Amount" / ObjLoansGuaranteeDetails."Total Loans Guaranteed") * (ObjLoansGuaranteeDetails."Total Loans Guaranteed" - AmtPaid + AmountPaid)), 1, '=');
                ObjLoansGuaranteeDetails.Modify(true);
            until ObjLoansGuaranteeDetails.Next = 0;
        end;
    end;


    procedure FnGetMemberSavingsLiability(MemberNo: Code[30]) VarTotaMemberLiability: Decimal
    var
        ObjLoanGuarantors: Record 51372;
        ObjLoans: Record "Loans Register";
        ObjLoanSecurities: Record 51374;
        ObjLoanGuarantors2: Record 51372;
        VarTotalGuaranteeValue: Decimal;
        VarMemberAnountGuaranteed: Decimal;
        VarApportionedLiability: Decimal;
        VarLoanOutstandingBal: Decimal;
        SavingsGuarantorship: Record 51711;
    begin
        ObjMembers.Reset;
        ObjMembers.SetRange(ObjMembers."No.", MemberNo);
        if ObjMembers.FindSet then begin

            VarTotalGuaranteeValue := 0;
            VarApportionedLiability := 0;
            VarTotaMemberLiability := 0;
            //Loans Guaranteed=======================================================================
            SavingsGuarantorship.Reset;
            SavingsGuarantorship.SetRange(SavingsGuarantorship."Member No", MemberNo);
            if SavingsGuarantorship.FindSet then begin
                SavingsGuarantorship.CalcFields(SavingsGuarantorship.Liability);
                SavingsGuarantorship.CalcSums(SavingsGuarantorship.Liability);
                VarTotaMemberLiability := SavingsGuarantorship.Liability;
            end;
        end;
        exit(VarTotaMemberLiability);
    end;


    procedure FnGetLoanAmountPaid(LoanNo: Code[30]) AmountPaid: Decimal
    var
        MemberLedgerEntry: Record "Member Ledger Entry";
    begin
        MemberLedgerEntry.Reset;
        MemberLedgerEntry.SetRange("Loan No", LoanNo);
        MemberLedgerEntry.SetRange("Transaction Type", MemberLedgerEntry."transaction type"::"Loan Repayment");
        MemberLedgerEntry.SetRange(Reversed, false);
        if MemberLedgerEntry.Find('-') then begin
            MemberLedgerEntry.CalcSums(Amount);
            AmountPaid := -1 * MemberLedgerEntry.Amount;
        end;
        exit(AmountPaid);
    end;


    procedure KnGetLastPayrollPeriod(): Date
    var
        PayrollCalender: Record 51322;
        Period: Date;
    begin
        PayrollCalender.Reset;
        PayrollCalender.SetRange(PayrollCalender.Closed, false);
        if PayrollCalender.FindLast then begin
            Period := PayrollCalender."Date Opened";
        end;

        exit(Period);
    end;


    procedure FnCreateGnlJournalLineBalanced2(TemplateName: Text; BatchName: Text; DocumentNo: Code[30]; LineNo: Integer; TransactionType: Option " ","Registration Fee",Loan,Repayment,"Interest Due","Interest Paid","Deposit Contribution","Shares Capital",Dividend,"Insurance Contribution","Demand Savings","Insurance Charge","Retained Shares","Demand Savings Withdrawal","Stock Due","Stock paid","Insurance Benefits","Demand Activation",ByLaws,"Dividend Advance","Rejoining Fee","Unallocated Funds"; AccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Member,Investor; AccountNo: Code[50]; TransactionDate: Date; TransactionAmount: Decimal; DimensionActivity: Code[40]; ExternalDocumentNo: Code[50]; TransactionDescription: Text; LoanNumber: Code[50]; BalancingAccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Member; BalancingAccountNo: Code[40])
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := TemplateName;
        GenJournalLine."Journal Batch Name" := BatchName;
        GenJournalLine."Document No." := DocumentNo;
        GenJournalLine."External Document No." := ExternalDocumentNo;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Transaction Type" := TransactionType;
        //GenJournalLine."Defaulter Payment Type":=DefaulterPaymentType;
        GenJournalLine."Account Type" := AccountType;
        GenJournalLine."Loan No" := LoanNumber;
        GenJournalLine."Account No." := AccountNo;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := TransactionDate;
        GenJournalLine.Description := TransactionDescription;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := TransactionAmount;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Bal. Account Type" := BalancingAccountType;
        GenJournalLine."Bal. Account No." := BalancingAccountNo;
        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
        GenJournalLine."Shortcut Dimension 1 Code" := DimensionActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := FnGetUserBranch();
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;
    end;


    procedure FnGetLoanInArrears(LoanNo: Code[50]; CurrentLoanAmount: Decimal): Decimal
    var
        LoanRepaymentSchedule: Record "Loan Repayment Schedule";
        LoansRegTable: Record "Loans Register";
        ExpectedPayments: Decimal;
        LoanDisbursed: Decimal;
    begin
        begin
            LoanRepaymentSchedule.Reset;
            LoanRepaymentSchedule.SetRange(LoanRepaymentSchedule."Loan No.", LoanNo);
            LoanRepaymentSchedule.SetFilter(LoanRepaymentSchedule."Repayment Date", '..' + Format(Today));
            if LoanRepaymentSchedule.Find('-') then begin
                LoanDisbursed := 0;
                LoanDisbursed := LoanRepaymentSchedule."Loan Amount";
                repeat
                    ExpectedPayments += LoanRepaymentSchedule."Principal Repayment";
                until LoanRepaymentSchedule.Next = 0;
            end;

            IF (CurrentLoanAmount - (LoanDisbursed - ExpectedPayments)) > 0 THEN
                EXIT(ROUND(CurrentLoanAmount - (LoanDisbursed - ExpectedPayments), 1, '='))
            ELSE
                EXIT(0);

        end;
    end;
}

