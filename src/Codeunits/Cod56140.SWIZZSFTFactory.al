#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
codeunit 56140 "SWIZZSFT Factory"
{
    trigger OnRun()
    begin

    end;

    var
        ObjTransCharges: Record "Transaction Charges";
        UserSetup: Record "User Setup";
        ObjVendor: Record Vendor;
        ObjProducts: Record "Loan Products Setup";
        ObjMemberLedgerEntry: Record "Cust. Ledger Entry";
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
        NLInterest: Decimal;
        TheMessage: Codeunit "Email Message";
        Email: Codeunit Email;

    //  procedure SendEmailWithAttachment(FileName:Text[100];EmailAddress:Text[100]; EmailSubject: text[100]; EmailBody: Text[200])
    // var
    //  "; 
    // begin
    //     TheMessage.Create(EmailAddress,EmailSubject,'',true);
    //     TheMessage.AddAttachment();
    //           Email.Send(TheMessage);
    // end;


    procedure FnGetCashierTransactionBudding(TransactionType: Code[100]; TransAmount: Decimal) TCharge: Decimal
    begin
        ObjTransCharges.Reset;
        ObjTransCharges.SetRange(ObjTransCharges."Transaction Type", TransactionType);
        ObjTransCharges.SetFilter(ObjTransCharges."Minimum Amount", '<=%1', TransAmount);
        ObjTransCharges.SetFilter(ObjTransCharges."Maximum Amount", '>=%1', TransAmount);
        TCharge := 0;
        if ObjTransCharges.FindSet then begin
            repeat
                TCharge := TCharge + ObjTransCharges."Charge Amount" + ObjTransCharges."Charge Amount" * 0.1;
            until ObjTransCharges.Next = 0;
        end;
    end;

    procedure FnCreateMembershipWithdrawalApplication(MemberNo: Code[20]; ApplicationDate: Date; Reason: Option Relocation,"Financial Constraints","House/Group Challages","Join another Institution","Personal Reasons",Other; ClosureDate: Date)
    var
        DateExp: Text[30];
        ObjNoSeries: Record "No. Series Line";
        ObjSalesSetup: Record "Sacco No. Series";
        //ObjNoSeriesManagement: Codeunit NoSeriesManagement;
        ObjNextNo: Code[20];
        PostingDate: Date;
        ObjMembershipWithdrawal: Record "Membership Exist";

    begin
        DateExp := '<60D>';
        ObjGenSetUp.Get();
        //DateExp:=ObjGenSetUp."Withdrawal Period";

        PostingDate := WorkDate;
        ObjSalesSetup.GET;
        ApplicationDate := today;
        ObjSalesSetup.TestField(ObjSalesSetup."Closure  Nos");
        //the below line commented out due to error 
        // ObjNextNo := ObjNoSeriesManagement.TryGetNextNo(ObjSalesSetup."Closure  Nos", PostingDate);
        ObjNoSeries.RESET;
        ObjNoSeries.SETRANGE(ObjNoSeries."Series Code", ObjSalesSetup."Closure  Nos");
        IF ObjNoSeries.FINDSET THEN BEGIN
            ObjNoSeries."Last No. Used" := INCSTR(ObjNoSeries."Last No. Used");
            ObjNoSeries."Last Date Used" := TODAY;
            ObjNoSeries.MODIFY;
        END;
        ClosureDate := CalcDate(DateExp, ApplicationDate);

        ObjMembershipWithdrawal.INIT;
        ObjMembershipWithdrawal."No." := ObjNextNo;
        ObjMembershipWithdrawal."Member No." := MemberNo;
        ObjMembershipWithdrawal."Withdrawal Application Date" := ApplicationDate;
        ObjMembershipWithdrawal."Notice Date" := ApplicationDate;
        ObjMembershipWithdrawal."Closing Date" := ClosureDate;
        ObjMembershipWithdrawal."Reason For Withdrawal" := Reason;
        ObjMembershipWithdrawal.INSERT;

        ObjMembershipWithdrawal.VALIDATE(ObjMembershipWithdrawal."Member No.");
        ObjMembershipWithdrawal.MODIFY;

        if ObjMembers.Get(MemberNo) then begin
            ObjMembers.Status := ObjMembers.Status::"Awaiting Withdrawal";
            ObjMembers."Status - Withdrawal App." := ObjMembers."Status - Withdrawal App."::"Being Processed";
            ObjMembers.Modify;
        end;

        message('The Member has been marked as awaiting exit.');

    end;

    procedure FnGetUserBranch() branchCode: Code[20]
    begin
        UserSetup.Reset;
        UserSetup.SetRange(UserSetup."User ID", UserId);
        if UserSetup.Find('-') then begin
            branchCode := UserSetup.Branch;
        end;
        exit(branchCode);
    end;

    // procedure FnGetChargeFee(ProductCode: Code[50]; InsuredAmount: Decimal; ChargeType: Code[100]) FCharged: Decimal
    // begin
    //     FCharged := 0;
    //     if ObjLoanProductSetup.Get(ProductCode) then begin
    //         ObjProductCharges.Reset;
    //         ObjProductCharges.SetRange(ObjProductCharges."Product Code", ProductCode);
    //         ObjProductCharges.SetRange(ObjProductCharges.Code, ChargeType);
    //         if ObjProductCharges.FindFirst() then begin
    //             if ObjProductCharges."Use Perc" = true then begin
    //                 FCharged := InsuredAmount * (ObjProductCharges.Percentage / 100);
    //             end else
    //                 if ObjProductCharges."Use Perc" = false then begin
    //                     if InsuredAmount < 1000000 then begin
    //                         FCharged := ObjProductCharges.Amount
    //                     end else
    //                         FCharged := ObjProductCharges.Amount2
    //                 end;
    //         end;
    //     end;
    //     exit(FCharged);
    // end;
    procedure FnGetChargeFee(ProductCode: Code[50]; InsuredAmount: Decimal; ChargeType: Code[100]) FCharged: Decimal
    begin
        FCharged := 0;

        if not ObjLoanProductSetup.Get(ProductCode) then
            exit(FCharged); // Loan product not found

        ObjProductCharges.Reset;
        ObjProductCharges.SetRange("Product Code", ProductCode);
        ObjProductCharges.SetRange(Code, ChargeType);

        if ObjProductCharges.FindFirst() then begin
            if ObjProductCharges."Use Perc" then begin
                if ObjProductCharges.Percentage <> 0 then
                    FCharged := InsuredAmount * (ObjProductCharges.Percentage / 100);
            end else begin
                if InsuredAmount < 1000000 then
                    FCharged := ObjProductCharges.Amount
                else
                    FCharged := ObjProductCharges.Amount2;
            end;
        end;

        exit(FCharged);
    end;


    procedure FnGetAccountUserBranch(UserAccount: Code[50]) branchCode: Code[20]
    begin
        UserSetup.Reset;
        UserSetup.SetRange(UserSetup."User ID", UserAccount);
        if UserSetup.Find('-') then begin
            branchCode := UserSetup.Branch;
        end;
        exit(branchCode);
    end;

    procedure FnGetMemberMonthlyContributionDepositstier(MemberNo: Code[30]) VarMemberMonthlyContribution: Decimal
    var
        ObjMember: Record Customer;
        ObjLoans: Record "Loans Register";
        VarTotalLoansIssued: Decimal;
        ObjDeposittier: Record "Member Deposit Tier";
    begin
        VarTotalLoansIssued := 0;
        VarMemberMonthlyContribution := 0;

        ObjMember.Reset;
        ObjMember.SetRange(ObjMember."No.", MemberNo);
        if ObjMember.FindSet then begin
            ObjLoans.CalcFields(ObjLoans."Outstanding Balance");

            ObjLoans.Reset;
            ObjLoans.SetRange(ObjLoans."Client Code", MemberNo);
            ObjLoans.SetRange(ObjLoans.Posted, true);
            ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>%1', 0);
            if ObjLoans.FindSet then begin
                ObjLoans.CalcSums(ObjLoans."Approved Amount");
                VarTotalLoansIssued := ObjLoans."Approved Amount";
            end;

            ObjDeposittier.Reset;
            ObjDeposittier.SetFilter(ObjDeposittier."Minimum Amount", '<=%1', VarTotalLoansIssued);
            ObjDeposittier.SetFilter(ObjDeposittier."Maximum Amount", '>=%1', VarTotalLoansIssued);
            if ObjDeposittier.FindSet then begin
                VarMemberMonthlyContribution := ObjDeposittier.Amount;
            end;

            ObjGenSetUp.Get;
            if (ObjMember."Account Category" = ObjMember."account category"::Individual)
            and (VarMemberMonthlyContribution < ObjGenSetUp."Min. Contribution") then
                VarMemberMonthlyContribution := ObjGenSetUp."Min. Contribution";
            // if (ObjMember."Account Category" <> ObjMember."account category"::Individual)
            // and (VarMemberMonthlyContribution < ObjGenSetUp."Corporate Minimum Monthly Cont") then
            //     VarMemberMonthlyContribution := ObjGenSetUp."Corporate Minimum Monthly Cont";

            exit(VarMemberMonthlyContribution);
        end;

    end;

    procedure FnSendSMS(SMSSource: Text; SMSBody: Text[200]; CurrentAccountNo: Text; MobileNumber: Text)
    var
        SMSMessages: Record "SMS Messages";
        iEntryNo: Integer;
    begin

        SMSMessages.Reset();
        if SMSMessages.Find('+') then begin
            iEntryNo := SMSMessages."Entry No";
            iEntryNo := iEntryNo + 1;
        end else begin
            iEntryNo := 1;
        end;
        SMSMessages.Reset();
        SMSMessages."Entry No" := iEntryNo;
        SMSMessages."Batch No" := '';
        SMSMessages."Document No" := CurrentAccountNo;
        SMSMessages."Account No" := CurrentAccountNo;
        SMSMessages."Date Entered" := Today;
        SMSMessages."Time Entered" := Time;
        SMSMessages.Source := 'MEMBERREGISTRATION';
        SMSMessages."Entered By" := UserId;
        SMSMessages."Sent To Server" := SMSMessages."Sent To Server"::No;
        SMSMessages."SMS Message" := SMSBody + '.' + ObjCompInfo.Name + ' ' + ObjGenSetUp."Customer Care No";
        SMSMessages."Telephone No" := MobileNumber;
        SMSMessages.Insert();
    end;



    procedure FnCreateGnlJournalLine(TemplateName: Text; BatchName: Text; DocumentNo: Code[30]; LineNo: Integer; TransactionType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account"; AccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Member,Investor; AccountNo: Code[50]; TransactionDate: Date; TransactionAmount: Decimal; DimensionActivity: Code[40]; ExternalDocumentNo: Code[50]; TransactionDescription: Text; LoanNumber: Code[50])
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
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;
    end;


    procedure FnGetFosaAccountBalance(Acc: Code[30]) Bal: Decimal
    var
        VendorTable: Record Vendor;
        AccountTypes: Record "Account Types-Saving Products";
        accountMinBalance: Decimal;
    begin
        VendorTable.Reset();
        VendorTable.SetRange(VendorTable."No.", Acc);
        VendorTable.SetAutoCalcFields(VendorTable."FOSA Balance");
        if VendorTable.Find('-') then begin

            AccountTypes.Reset;
            AccountTypes.SetRange(AccountTypes.Code, VendorTable."Account Type");
            if AccountTypes.Find('-') then begin
                accountMinBalance := AccountTypes."Minimum Balance";
            end else begin
                accountMinBalance := 200;
            end;
            exit(VendorTable."FOSA Balance" - accountMinBalance);//remember to Update the minimum balance here...
        end;
    end;

    procedure FnGetFosaAccountBalanceUsingBOSA(Acc: Code[30]) Bal: Decimal
    var
        VendorTable: Record Vendor;
    begin
        VendorTable.Reset();
        VendorTable.SetRange(VendorTable."Account Type", 'ORDINARY');
        VendorTable.SetRange(VendorTable."BOSA Account No", Acc);
        VendorTable.SetAutoCalcFields(VendorTable."FOSA Balance");
        if VendorTable.Find('-') then begin
            exit(VendorTable."FOSA Balance" - 1200);
        end;
        exit(0);
    end;

    local procedure FnGetMinimumAllowedBalance(ProductCode: Code[60]) MinimumBalance: Decimal
    begin
        /*ObjProducts.RESET;
        ObjProducts.SETRANGE(ObjProducts.Code,ProductCode);
        IF ObjProducts.FIND('-') THEN
          MinimumBalance:=ObjProducts."Minimum Balance";
          */

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
        /*ObjBanks.RESET;
        ObjBanks.SETRANGE(ObjBanks."Account Type",ObjBanks."Account Type"::"3");
        ObjBanks.SETRANGE(ObjBanks."Bank Account Branch",FnGetUserBranch());
        IF ObjBanks.FIND('-') THEN BEGIN
        TellerTillNo:=ObjBanks."No.";
        END;
        EXIT(TellerTillNo);
        */

    end;


    procedure FnGetChargeFee(ProductCode: Code[50]; MemberCategory: Option Single,Joint,Corporate,Group,Parish,Church,"Church Department",Staff; InsuredAmount: Decimal; ChargeType: Code[100]) FCharged: Decimal
    begin
        if ObjLoanProductSetup.Get(ProductCode) then begin
            ObjProductCharges.Reset;
            ObjProductCharges.SetRange(ObjProductCharges."Product Code", ProductCode);
            ObjProductCharges.SetRange(ObjProductCharges.Code, ChargeType);
            if ObjProductCharges.Find('-') then begin
                if ObjProductCharges."Use Perc" = true then begin
                    FCharged := InsuredAmount * (ObjProductCharges.Percentage / 100);
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
        UserSetup.SetRange(UserSetup."User ID", varUserId);
        if UserSetup.Find('-') then begin
            branchCode := UserSetup.Branch;
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
            FosaAccount := ObjMembers."FOSA Account";
        end;
        exit(FosaAccount);
    end;


    procedure FnCreateGnlJournalLineBalanced(TemplateName: Text; BatchName: Text; DocumentNo: Code[30]; LineNo: Integer; TransactionType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account"; AccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Member,Investor; AccountNo: Code[50]; TransactionDate: Date; TransactionAmount: Decimal; DimensionActivity: Code[40]; ExternalDocumentNo: Code[50]; TransactionDescription: Text; LoanNumber: Code[50]; BalancingAccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Member; BalancingAccountNo: Code[40])
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
        GenJournalLine."Account Type" := AccountType;
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


    procedure FnChargeExcise(ChargeCode: Code[100]): Boolean
    var
        ObjProductCharges: Record "Loan Product Charges";
    begin
        /*ObjProductCharges.RESET;
        ObjProductCharges.SETRANGE(Code,ChargeCode);
        IF ObjProductCharges.FIND('-') THEN
          EXIT(ObjProductCharges."Charge Excise");
          */

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
        ObjMembers.SetRange("No.", ObjLoans."BOSA No");
        if ObjMembers.Find('-') then
            exit(ObjMembers."Phone No.");
    end;


    procedure FnGenerateRepaymentSchedule(LoanNumber: Code[50])
    var
        LoansRec: Record "Loans Register";
        TotalsInSchedule: Decimal;
        LoanAmountSchedule: Decimal;
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
        InterestVarianceOnlyNafaka: Decimal;
    begin
        LoansRec.Reset;
        LoansRec.SetRange(LoansRec."Loan  No.", LoanNumber);
        LoansRec.SetFilter(LoansRec."Approved Amount", '>%1', 0);
        //LoansRec.SetFilter(LoansRec.Posted, '=%1', false);
        if LoansRec.Find('-') then begin
            if (LoansRec."Repayment Start Date" <> 0D) then begin
                LoansRec.TestField(LoansRec."Loan Disbursement Date");
                LoansRec.TestField(LoansRec."Repayment Start Date");

                RSchedule.Reset;
                RSchedule.SetRange(RSchedule."Loan No.", LoansRec."Loan  No.");
                RSchedule.DeleteAll;

                LoanAmount := LoansRec."Approved Amount";
                InterestRate := LoansRec.Interest;
                RepayPeriod := LoansRec.Installments;
                InitialInstal := LoansRec.Installments + LoansRec."Grace Period - Principle (M)";
                LBalance := LoansRec."Approved Amount";
                RunDate := LoansRec."Repayment Start Date";
                InstalNo := 0;

                //Repayment Frequency
                if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Daily then
                    RunDate := CalcDate('-1D', RunDate)
                else
                    if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Weekly then
                        RunDate := CalcDate('-1W', RunDate)
                    else
                        if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Monthly then
                            RunDate := CalcDate('-1M', RunDate)
                        else
                            if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Quaterly then
                                RunDate := CalcDate('-1Q', RunDate);
                //Repayment Frequency


                repeat
                    InstalNo := InstalNo + 1;
                    //Repayment Frequency
                    if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Daily then
                        RunDate := CalcDate('1D', RunDate)
                    else
                        if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Weekly then
                            RunDate := CalcDate('1W', RunDate)
                        else
                            if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Monthly then
                                RunDate := CalcDate('1M', RunDate)
                            else
                                if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Quaterly then
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

                        LPrincipal := LoansRec.Repayment;
                        LInterest := Round((LoansRec."Loan Interest Repayment") / LoansRec.Installments, 0.0001, '>');
                    end;

                    //Grace Period
                    if GrPrinciple > 0 then begin
                        LPrincipal := 0
                    end else begin
                        LBalance := LBalance - LPrincipal;

                    end;

                    GrPrinciple := GrPrinciple - 1;
                    GrInterest := GrInterest - 1;
                    Evaluate(RepayCode, Format(InstalNo));


                    RSchedule.Init;
                    RSchedule."Repayment Code" := RepayCode;
                    RSchedule."Interest Rate" := InterestRate;
                    RSchedule."Loan No." := LoansRec."Loan  No.";
                    RSchedule."Loan Amount" := LoanAmount;
                    RSchedule."Instalment No" := InstalNo;
                    //RSchedule."Repayment Date" := RunDate;
                    RSchedule."Repayment Date" := CalcDate('CM', RunDate);
                    RSchedule."Member No." := LoansRec."Client Code";
                    RSchedule."Loan Category" := LoansRec."Loan Product Type";
                    RSchedule."Monthly Repayment" := LInterest + LPrincipal;
                    RSchedule."Monthly Interest" := LInterest;
                    RSchedule."Principal Repayment" := LPrincipal;
                    RSchedule."Loan Balance" := LBalance;
                    RSchedule.Insert;
                    WhichDay := Date2dwy(RSchedule."Repayment Date", 1);
                until LBalance < 1;
            end;
        end;

        Commit;
    end;


    procedure FnGetInterestDueFiltered(ObjLoans: Record "Loans Register"; DateFilter: Text): Decimal
    var
        ObjLoanRegister: Record "Loans Register";
    begin
        ObjLoans.SetFilter("Date filter", DateFilter);
        ObjLoans.CalcFields("Schedule Interest to Date", "Outstanding Balance");
        exit(ObjLoans."Schedule Interest to Date");
    end;


    procedure FnGetUpfrontsTotal(ProductCode: Code[50]; InsuredAmount: Decimal) FCharged: Decimal
    var
        ObjLoanCharges: Record "Loan Product Charges";
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
        ObjLoans.CalcFields(ObjLoans."Schedule Repayments", ObjLoans."Principal Paid", ObjLoans."Outstanding Balance");
        if ObjLoans."Outstanding Balance" > 0 then begin
            exit((ObjLoans."Schedule Repayments") - (ObjLoans."Approved Amount" - ObjLoans."Outstanding Balance"));
        end;
        exit(0);

    end;

    local procedure FnGetDate(DFilter: Text): Date
    var
        strDate1: Text;
        date1: Date;
        convString: Text;
    begin
        Evaluate(date1, CopyStr(DFilter, 1, 10));
        exit(date1);
    end;


    procedure FnLoanPaidAmount(ObjLoans: Record "Loans Register"; DFilter: Text) LoanBalance: Decimal
    var
        ObjLoansRegister: Record "Loans Register";
    begin
        ObjLoansRegister.Reset;
        ObjLoansRegister.SetRange(ObjLoansRegister."Loan  No.", ObjLoans."Loan  No.");
        ObjLoansRegister.SetFilter("Date filter", DFilter);
        if ObjLoansRegister.Find('-') then begin
            ObjLoansRegister.CalcFields(ObjLoansRegister."Principal Paid");
            LoanBalance := ObjLoansRegister."Principal Paid";
        end;
        exit(LoanBalance);
    end;


    procedure FnGetSavingsProductAccount(MemberNo: Code[50]; ProductCode: Code[100]) FosaAccount: Code[50]
    var
        ObjVendor: Record Vendor;
    begin
        ObjVendor.Reset;
        ObjVendor.SetRange(ObjVendor."BOSA Account No", MemberNo);
        ObjVendor.SetRange(ObjVendor."Account Type", ProductCode);
        if ObjVendor.Find('-') then begin
            FosaAccount := ObjVendor."No.";
        end;
        exit(FosaAccount);
    end;


    procedure FnCreateGnlJournalLineMC(TemplateName: Text; BatchName: Text; DocumentNo: Code[30]; LineNo: Integer; TransactionType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account"; AccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Member,Investor; AccountNo: Code[50]; TransactionDate: Date; TransactionAmount: Decimal; DimensionActivity: Code[40]; ExternalDocumentNo: Code[50]; TransactionDescription: Text; LoanNumber: Code[50]; GroupCode: Code[100])
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
        GenJournalLine."Group Code" := GroupCode;
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


    procedure FnCreateGnlJournalLineBalancedCashier(TemplateName: Text; BatchName: Text; DocumentNo: Code[30]; LineNo: Integer; TransactionType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account"; AccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Member,Investor; AccountNo: Code[50]; TransactionDate: Date; TransactionAmount: Decimal; DimensionActivity: Code[40]; ExternalDocumentNo: Code[50]; TransactionDescription: Text; LoanNumber: Code[50]; BalancingAccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Member; BalancingAccountNo: Code[40]; OverdraftNo: Code[100]; OverDraftTransaction: Option " ","Overdraft Granted","Overdraft Paid","Interest Accrued","Interest paid")
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
        GenJournalLine."Account Type" := AccountType;
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
        GenJournalLine."Shortcut Dimension 2 Code" := FnGetMemberBranchUsingFosaAccount(AccountNo);
        GenJournalLine."Overdraft codes" := OverDraftTransaction;
        GenJournalLine."Overdraft NO" := OverdraftNo;
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;
    end;


    procedure FnGetBosaTransferFeeBudding(TransAmount: Decimal) TCharge: Decimal
    var
        ObjBosaTransferFee: Record "BOSA Transaction Fees";
    begin
        ObjBosaTransferFee.Reset;
        ObjBosaTransferFee.SetFilter(ObjBosaTransferFee."Lower Limit", '<=%1', TransAmount);
        ObjBosaTransferFee.SetFilter(ObjBosaTransferFee."Upper Limit", '>=%1', TransAmount);
        TCharge := 0;
        if ObjBosaTransferFee.Find('-') then
            exit(ObjBosaTransferFee."Charge Amount");
    end;


    procedure FnGetMemberBranchUsingFosaAccount(MemberNo: Code[100]) MemberBranch: Code[100]
    var
        ObjMemberLocal: Record Customer;
    begin
        ObjMemberLocal.Reset;
        ObjMemberLocal.SetRange(ObjMemberLocal."FOSA Account", MemberNo);
        if ObjMemberLocal.Find('-') then begin
            MemberBranch := ObjMemberLocal."Global Dimension 2 Code";
        end;
        exit(MemberBranch);

    end;


    procedure FnPrincipalOverPaymentDetected(TransactionAmount: Decimal; OutstandingBalance: Decimal): Boolean
    begin
        exit((OutstandingBalance - TransactionAmount) < 0);
    end;


    procedure FnGetOutstandingBalance(LoanNumber: Code[100]; DateFilter: Text): Decimal
    var
        ObjLoanRegister: Record "Loans Register";
    begin
        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Loan  No.", LoanNumber);
        ObjLoans.SetFilter("Date filter", DateFilter);
        if ObjLoans.Find('-') then begin
            ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
            exit(ObjLoans."Outstanding Balance");
        end;
    end;


    procedure FnCreateGnlJournalLineBalancedFOSA(TemplateName: Text; BatchName: Text; DocumentNo: Code[30]; LineNo: Integer; TransactionType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account"; AccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Member,Investor; AccountNo: Code[50]; TransactionDate: Date; TransactionAmount: Decimal; ObjVendor: Record Vendor; ExternalDocumentNo: Code[50]; TransactionDescription: Text; LoanNumber: Code[50]; BalancingAccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Member; BalancingAccountNo: Code[40])
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
        GenJournalLine."Account Type" := AccountType;
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
        GenJournalLine."Shortcut Dimension 1 Code" := ObjVendor."Global Dimension 1 Code";
        GenJournalLine."Shortcut Dimension 2 Code" := ObjVendor."Global Dimension 2 Code";
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;
    end;


    procedure FnGenereateDocumentNo(PostingDate: Date): Code[100]
    var
        rtVal: Code[100];
    begin
        case Date2dmy(PostingDate, 2) of
            1:
                rtVal := 'JAN';
            2:
                rtVal := 'FEB';
            3:
                rtVal := 'MAR';
            4:
                rtVal := 'APR';
            5:
                rtVal := 'MAY';
            6:
                rtVal := 'JUN';
            7:
                rtVal := 'JUL';
            8:
                rtVal := 'AUG';
            9:
                rtVal := 'SEP';
            10:
                rtVal := 'OCT';
            11:
                rtVal := 'NOV';
            12:
                rtVal := 'DEC';
        end;
        exit(rtVal + Format(Date2dmy(PostingDate, 3)));
    end;


    // procedure FnGetLoanOfficerFromMemberNo(MemberNo: Code[100]): Code[100]
    // var
    //     ObjMembers: Record Customer;
    //     ObjGroups: Record Customer;
    //     ObjLoanOfficers: Record "Loan Officers Details";
    // begin
    //     ObjMembers.Reset;
    //     ObjMembers.SetRange(ObjMembers."No.", MemberNo);
    //     if ObjMembers.Find('-') then begin
    //         ObjGroups.Reset;
    //         // ObjGroups.SetRange(ObjGroups."No.", ObjMembers."Group Account No");
    //         if ObjGroups.Find('-') then begin
    //             ObjLoanOfficers.Reset;
    //             ObjLoanOfficers.SetRange(ObjLoanOfficers.Name, ObjGroups."Loan Officer Name");
    //             if ObjLoanOfficers.Find('-') then
    //                 exit(ObjLoanOfficers."Account No.");
    //         end
    //     end;
    // end;


    procedure FnGenerateRepaymentScheduleHistorical(LoanNumber: Code[50])
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
        InterestVarianceOnlyNafaka: Decimal;
    begin
        LoansRec.Reset;
        LoansRec.SetRange(LoansRec."Loan  No.", LoanNumber);
        LoansRec.SetFilter(LoansRec."Approved Amount", '>%1', 0);
        LoansRec.SetFilter(LoansRec.Posted, '=%1', true);
        if LoansRec.Find('-') then begin
            if ((LoansRec."Issued Date" <> 0D) and (LoansRec."Repayment Start Date" <> 0D)) then begin
                LoansRec.TestField(LoansRec."Loan Disbursement Date");
                LoansRec.TestField(LoansRec."Repayment Start Date");

                RSchedule.Reset;
                RSchedule.SetRange(RSchedule."Loan No.", LoansRec."Loan  No.");
                RSchedule.DeleteAll;

                LoanAmount := LoansRec."Approved Amount";
                InterestRate := LoansRec.Interest;
                RepayPeriod := LoansRec.Installments;
                InitialInstal := LoansRec.Installments + LoansRec."Grace Period - Principle (M)";
                LBalance := LoansRec."Approved Amount";
                RunDate := LoansRec."Repayment Start Date";
                InstalNo := 0;

                //Repayment Frequency
                if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Daily then
                    RunDate := CalcDate('-1D', RunDate)
                else
                    if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Weekly then
                        RunDate := CalcDate('-1W', RunDate)
                    else
                        if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Monthly then
                            RunDate := CalcDate('-1M', RunDate)
                        else
                            if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Quaterly then
                                RunDate := CalcDate('-1Q', RunDate);
                //Repayment Frequency


                repeat
                    InstalNo := InstalNo + 1;
                    //Repayment Frequency
                    if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Daily then
                        RunDate := CalcDate('1D', RunDate)
                    else
                        if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Weekly then
                            RunDate := CalcDate('1W', RunDate)
                        else
                            if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Monthly then
                                RunDate := CalcDate('1M', RunDate)
                            else
                                if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Quaterly then
                                    RunDate := CalcDate('1Q', RunDate);

                    if LoansRec."Repayment Method" = LoansRec."repayment method"::Amortised then begin
                        //LoansRec.TESTFIELD(LoansRec.Interest);
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
                    RSchedule.Insert;
                    WhichDay := Date2dwy(RSchedule."Repayment Date", 1);
                until LBalance < 1

            end;
        end;

        Commit;
    end;

    procedure FnPostGnlJournalLine(TemplateName: Text; BatchName: Text)
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenJournalLine.RESET;
        GenJournalLine.SETRANGE(GenJournalLine."Journal Template Name", TemplateName);
        GenJournalLine.SETRANGE(GenJournalLine."Journal Batch Name", BatchName);
        IF GenJournalLine.FINDSET THEN BEGIN
            CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch", GenJournalLine);
        END;
    end;

    procedure FnCreateGnlJournalLineBalanced(JTemplate: Code[20]; JBatch: Code[20]; DocNo: Code[20]; LineNo: Integer; TransType: Option; Accounttype: Option; ChargeAccount: Code[20]; Today: Date; arg1: Text; Balaccounttype: Option; LodgeFeeAccount: Code[20]; LodgeFee: Decimal; arg2: Text; arg3: Text)
    begin
        Error('Procedure FnCreateGnlJournalLineBalanced not implemented.');
    end;

    procedure FnGetMemberApplicationAMLRiskRating(MemberNo: Code[20])
    var
        VarCategoryScore: Integer;
        VarResidencyScore: Integer;
        VarNatureofBusinessScore: Integer;
        VarEntityScore: Integer;
        VarIndustryScore: Integer;
        VarLenghtOfRelationshipScore: Integer;
        VarInternationalTradeScore: Integer;
        VarElectronicPaymentScore: Integer;
        // VarCardTypeScore: Integer;
        VarAccountTypeScore: Integer;
        // VarChannelTakenScore: Integer;
        VarAccountTypeOption: Option "International Wire Transfers","Local Wire Transfers","Mobile Transfers","None of the Above","Fixed/Call Deposit Accounts","KSA/Imara/MJA/Heritage)","Account with Sealed Safe deposit","Account with  Open Safe Deposit","All Loan Accounts",BOSA," Ufalme","ATM Debit",Credit,Both,"None","Non-face to face channels","Unsolicited Account Origination e.g. Walk-Ins","Cheque book",Others;
        MemberTotalRiskRatingScore: Decimal;
        MemberNetRiskScore: Decimal;
        ObjMemberDueDiligence: Record "Member Due Diligence Measures";
        ObjDueDiligenceSetup: Record "Due Diligence Measures";
        VarRiskRatingDescription: Text[50];
        VarRefereeScore: Decimal;
        VarRefereeRiskRate: Text;
        ObjCustRiskRates: Record "Customer Risk Rating";
        ObjRefereeSetup: Record "Referee Risk Rating Scale";
        ObjMemberRiskRate: Record "Individual Customer Risk Rate";
        ObjControlRiskRating: Record "Control Risk Rating";
        VarControlRiskRating: Decimal;
        ObjMembershipApplication: Record "Membership Applications";
        VarAccountTypeScoreVer1: Decimal;
        VarAccountTypeScoreVer2: Decimal;
        VarAccountTypeScoreVer3: Decimal;
        ObjMemberRiskRating: Record "Individual Customer Risk Rate";
        ObjNetRiskScale: Record "Member Gross Risk Rating Scale";
        ObjProductsApp: Record "Membership Applied Products";
        ObjProductRiskRating: Record "Product Risk Rating";
        VarAccountTypeOptionVer1: Option "International Wire Transfers","Local Wire Transfers","Mobile Transfers","None of the Above","Fixed/Call Deposit Accounts","KSA/Imara/MJA/Heritage)","Account with Sealed Safe deposit","Account with  Open Safe Deposit","All Loan Accounts",BOSA," Ufalme","ATM Debit",Credit,Both,"None","Non-face to face channels","Unsolicited Account Origination e.g. Walk-Ins","Cheque book",Others;
        VarAccountTypeOptionVer2: Option "International Wire Transfers","Local Wire Transfers","Mobile Transfers","None of the Above","Fixed/Call Deposit Accounts","KSA/Imara/MJA/Heritage)","Account with Sealed Safe deposit","Account with  Open Safe Deposit","All Loan Accounts",BOSA," Ufalme","ATM Debit",Credit,Both,"None","Non-face to face channels","Unsolicited Account Origination e.g. Walk-Ins","Cheque book",Others;
        VarAccountTypeOptionVer3: Option "International Wire Transfers","Local Wire Transfers","Mobile Transfers","None of the Above","Fixed/Call Deposit Accounts","KSA/Imara/MJA/Heritage)","Account with Sealed Safe deposit","Account with  Open Safe Deposit","All Loan Accounts",BOSA," Ufalme","ATM Debit",Credit,Both,"None","Non-face to face channels","Unsolicited Account Origination e.g. Walk-Ins","Cheque book",Others;
    begin

        ObjMembershipApplication.Reset;
        ObjMembershipApplication.SetRange(ObjMembershipApplication."No.", MemberNo);
        if ObjMembershipApplication.FindSet then begin
            ObjCustRiskRates.Reset;
            ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::Individuals);
            ObjCustRiskRates.SetRange(ObjCustRiskRates."Sub Category", ObjMembershipApplication."Individual Category");
            if ObjCustRiskRates.FindSet then begin
                VarCategoryScore := ObjCustRiskRates."Risk Score";

            end;
        end;


        ObjMembershipApplication.Reset;
        ObjMembershipApplication.SetRange(ObjMembershipApplication."No.", MemberNo);
        if ObjMembershipApplication.FindSet then begin
            ObjCustRiskRates.Reset;
            ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::Entities);
            ObjCustRiskRates.SetRange(ObjCustRiskRates."Sub Category", ObjMembershipApplication.Entities);
            if ObjCustRiskRates.FindSet then begin
                VarEntityScore := ObjCustRiskRates."Risk Score";

            end;
        end;

        ObjMembershipApplication.Reset;
        ObjMembershipApplication.SetRange(ObjMembershipApplication."No.", MemberNo);
        if ObjMembershipApplication.FindSet then begin
            ObjCustRiskRates.Reset;
            ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::"Residency Status");
            ObjCustRiskRates.SetRange(ObjCustRiskRates."Sub Category", ObjMembershipApplication."Member Residency Status");
            if ObjCustRiskRates.FindSet then begin
                VarResidencyScore := ObjCustRiskRates."Risk Score";
            end;
        end;


        ObjMembershipApplication.Reset;
        ObjMembershipApplication.SetRange(ObjMembershipApplication."No.", MemberNo);
        if ObjMembershipApplication.FindSet then begin
            //=============================================================Exisiting Referee
            ObjMemberRiskRate.Reset;
            ObjMemberRiskRate.SetRange(ObjMemberRiskRate."Membership Application No", ObjMembershipApplication."Referee Member No");
            if ObjMemberRiskRate.FindSet then begin
                if ObjMembershipApplication."Referee Member No" <> '' then begin

                    ObjRefereeSetup.Reset;
                    if ObjRefereeSetup.FindSet then begin
                        repeat
                            if (ObjMemberRiskRate."GROSS CUSTOMER AML RISK RATING" >= ObjRefereeSetup."Minimum Risk Rate") and
                              (ObjMemberRiskRate."GROSS CUSTOMER AML RISK RATING" <= ObjRefereeSetup."Maximum Risk Rate") then begin
                                VarRefereeScore := ObjRefereeSetup.Score;
                                VarRefereeRiskRate := ObjRefereeSetup.Description;
                            end;
                        until ObjRefereeSetup.Next = 0;
                    end;
                end;

                //=============================================================No Referee
                if ObjMembershipApplication."Referee Member No" = '' then begin
                    ObjRefereeSetup.Reset;
                    ObjRefereeSetup.SetFilter(ObjRefereeSetup.Description, '%1', 'Others with no referee');
                    if ObjRefereeSetup.FindSet then begin
                        VarRefereeScore := ObjRefereeSetup.Score;
                        VarRefereeRiskRate := 'Others with no referee';
                    end;
                end;
            end;


            ObjCustRiskRates.Reset;
            ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::"Residency Status");
            ObjCustRiskRates.SetRange(ObjCustRiskRates."Sub Category", ObjMembershipApplication."Member Residency Status");
            if ObjCustRiskRates.FindSet then begin
                VarResidencyScore := ObjCustRiskRates."Risk Score";
            end;
        end;

        ObjMembershipApplication.Reset;
        ObjMembershipApplication.SetRange(ObjMembershipApplication."No.", MemberNo);
        if ObjMembershipApplication.FindSet then begin
            ObjCustRiskRates.Reset;
            ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::Industry);
            ObjCustRiskRates.SetRange(ObjCustRiskRates."Sub Category", ObjMembershipApplication."Industry Type");
            if ObjCustRiskRates.FindSet then begin
                VarIndustryScore := ObjCustRiskRates."Risk Score";
            end;
        end;

        ObjMembershipApplication.Reset;
        ObjMembershipApplication.SetRange(ObjMembershipApplication."No.", MemberNo);
        if ObjMembershipApplication.FindSet then begin
            ObjCustRiskRates.Reset;
            ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::"Length Of Relationship");
            ObjCustRiskRates.SetRange(ObjCustRiskRates."Sub Category", ObjMembershipApplication."Length Of Relationship");
            if ObjCustRiskRates.FindSet then begin
                VarLenghtOfRelationshipScore := ObjCustRiskRates."Risk Score";
            end;
        end;

        ObjMembershipApplication.Reset;
        ObjMembershipApplication.SetRange(ObjMembershipApplication."No.", MemberNo);
        if ObjMembershipApplication.FindSet then begin
            ObjCustRiskRates.Reset;
            ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::"International Trade");
            ObjCustRiskRates.SetRange(ObjCustRiskRates."Sub Category", ObjMembershipApplication."International Trade");
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
            ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Type Code", ObjMembershipApplication."Electronic Payment");
            if ObjProductRiskRating.FindSet then begin
                VarElectronicPaymentScore := ObjProductRiskRating."Risk Score";
            end;
        end;


        //ObjProductRiskRating.GET();
        // ObjMembershipApplication.Reset;
        // ObjMembershipApplication.SetRange(ObjMembershipApplication."No.", MemberNo);
        // if ObjMembershipApplication.FindSet then begin

        //     ObjProductRiskRating.Reset;
        //     ObjProductRiskRating.SetCurrentkey(ObjProductRiskRating."Product Type Code");
        //     ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Category", ObjProductRiskRating."product category"::Cards);
        //     ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Type Code", ObjMembershipApplication."Cards Type Taken");
        //     if ObjProductRiskRating.FindSet then begin
        //         VarCardTypeScore := ObjProductRiskRating."Risk Score";
        //     end;
        // end;

        ObjProductRiskRating.Reset;
        ObjProductRiskRating.SetCurrentkey(ObjProductRiskRating."Product Type Code");
        ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Category", ObjProductRiskRating."product category"::Accounts);
        ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Type Code", ObjMembershipApplication."Accounts Type Taken");
        if ObjProductRiskRating.FindSet then begin
            VarAccountTypeScore := ObjProductRiskRating."Risk Score";
        end;

        // ObjProductRiskRating.Reset;
        // ObjProductRiskRating.SetCurrentkey(ObjProductRiskRating."Product Type Code");
        // ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Category", ObjProductRiskRating."product category"::Others);
        // ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Type Code", ObjMembershipApplication."Others(Channels)");
        // if ObjProductRiskRating.FindSet then begin
        //     VarChannelTakenScore := ObjProductRiskRating."Risk Score";
        // end;

        ObjProductsApp.Reset;
        ObjProductsApp.SetRange(ObjProductsApp."Membership Applicaton No", MemberNo);
        // ObjProductsApp.SetFilter(ObjProductsApp."Product Category", '<>%1', ObjProductsApp."Product Category"::FOSA);
        if ObjProductsApp.FindSet then begin
            repeat
                ObjProductRiskRating.Reset;
                ObjProductRiskRating.SetCurrentkey(ObjProductRiskRating."Product Type");
                ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Category", ObjProductRiskRating."product category"::Accounts);
                ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Type", ObjProductRiskRating."product type"::Credit);
                if ObjProductRiskRating.FindSet then begin
                    VarAccountTypeScoreVer1 := ObjProductRiskRating."Risk Score";
                    VarAccountTypeOptionVer1 := ObjProductRiskRating."product type"::Credit;
                    VarAccountTypeScore := ObjProductRiskRating."Risk Score";
                    VarAccountTypeOption := ObjProductRiskRating."product type"::Credit;
                end;
            until ObjProductsApp.Next = 0;
        end;

        ObjProductsApp.Reset;
        ObjProductsApp.SetRange(ObjProductsApp."Membership Applicaton No", MemberNo);
        // ObjProductsApp.SetFilter(ObjProductsApp."Product Category", '%1', ObjProductsApp."Product Category"::FOSA);
        //ObjProductsApp.SetFilter(ObjProductsApp.Product, '<>%1|%2', '503', '506');
        if ObjProductsApp.FindSet then begin

            repeat
                ObjProductRiskRating.Reset;
                ObjProductRiskRating.SetCurrentkey(ObjProductRiskRating."Product Type");
                ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Category", ObjProductRiskRating."product category"::Accounts);
                ObjProductRiskRating.SetFilter(ObjProductRiskRating."Product Type Code", '%1', ObjProductRiskRating."Product Type Code"::"Fixed/Call Deposit Accounts");// 'Ordinary Savings');
                if ObjProductRiskRating.FindSet then begin
                    VarAccountTypeScoreVer2 := ObjProductRiskRating."Risk Score";
                    VarAccountTypeOptionVer2 := ObjProductRiskRating."product type"::Both;
                    VarAccountTypeScore := ObjProductRiskRating."Risk Score";
                    VarAccountTypeOption := ObjProductRiskRating."product type"::Both;
                end;
            until ObjProductsApp.Next = 0;
        end;




        if (VarAccountTypeScoreVer1 > VarAccountTypeScoreVer2) and (VarAccountTypeScoreVer1 > VarAccountTypeScoreVer3) then begin
            VarAccountTypeScore := VarAccountTypeScoreVer1;
            VarAccountTypeOption := VarAccountTypeOptionVer1
        end else
            if (VarAccountTypeScoreVer2 > VarAccountTypeScoreVer1) and (VarAccountTypeScoreVer2 > VarAccountTypeScoreVer3) then begin
                VarAccountTypeScore := VarAccountTypeScoreVer2;
                VarAccountTypeOption := VarAccountTypeOptionVer2
            end else
                if (VarAccountTypeScoreVer3 > VarAccountTypeScoreVer1) and (VarAccountTypeScoreVer3 > VarAccountTypeScoreVer2) then begin
                    VarAccountTypeScore := VarAccountTypeScoreVer3;
                    VarAccountTypeOption := VarAccountTypeOptionVer3
                end;


        //Create Entries on Membership Risk Rating Table
        ObjMemberRiskRating.Reset;
        ObjMemberRiskRating.SetRange(ObjMemberRiskRating."Membership Application No", MemberNo);
        if ObjMemberRiskRating.FindSet then begin
            ObjMemberRiskRating.DeleteAll;
        end;


        //===============================================Get Control Risk Rating
        ObjControlRiskRating.Reset;
        if ObjControlRiskRating.FindSet then begin
            ObjControlRiskRating.CalcSums(ObjControlRiskRating."Control Weight Aggregate");
            VarControlRiskRating := ObjControlRiskRating."Control Weight Aggregate";
        end;




        ObjMemberRiskRating.Init;
        ObjMemberRiskRating."Membership Application No" := MemberNo;

        ObjMemberRiskRating."What is the Customer Category?" := ObjMembershipApplication."Individual Category";
        ObjMemberRiskRating."Customer Category Score" := VarCategoryScore;
        ObjMemberRiskRating."What is the Member residency?" := ObjMembershipApplication."Member Residency Status";
        ObjMemberRiskRating."Member Residency Score" := VarResidencyScore;
        ObjMemberRiskRating."Cust Employment Risk?" := ObjMembershipApplication.Entities;
        ObjMemberRiskRating."Cust Employment Risk Score" := VarEntityScore;
        ObjMemberRiskRating."Cust Business Risk Industry?" := ObjMembershipApplication."Industry Type";
        ObjMemberRiskRating."Cust Bus. Risk Industry Score" := VarIndustryScore;
        ObjMemberRiskRating."Lenght Of Relationship?" := ObjMembershipApplication."Length Of Relationship";
        ObjMemberRiskRating."Length Of Relation Score" := VarLenghtOfRelationshipScore;
        ObjMemberRiskRating."Cust Involved in Intern. Trade" := ObjMembershipApplication."International Trade";
        ObjMemberRiskRating."Involve in Inter. Trade Score" := VarInternationalTradeScore;
        ObjMemberRiskRating."Account Type Taken?" := (VarAccountTypeOption);
        ObjMemberRiskRating."Account Type Taken Score" := VarAccountTypeScore;
        //ObjMemberRiskRating."Card Type Taken" := ObjMembershipApplication."Cards Type Taken";
        // ObjMemberRiskRating."Card Type Taken Score" := VarCardTypeScore;
        // ObjMemberRiskRating."Channel Taken?" := ObjMembershipApplication."Others(Channels)";
        // ObjMemberRiskRating."Channel Taken Score" := VarChannelTakenScore;
        ObjMemberRiskRating."Electronic Payments?" := ObjMembershipApplication."Electronic Payment";
        // ObjMemberRiskRating."Referee Score" := VarRefereeScore;
        // ObjMemberRiskRating."Member Referee Rate" := VarRefereeRiskRate;
        ObjMemberRiskRating."Electronic Payments Score" := VarElectronicPaymentScore;
        MemberTotalRiskRatingScore := VarCategoryScore + VarEntityScore + VarIndustryScore + VarInternationalTradeScore + VarRefereeScore + VarLenghtOfRelationshipScore + VarResidencyScore + VarAccountTypeScore
        + VarElectronicPaymentScore;
        ObjMemberRiskRating."GROSS CUSTOMER AML RISK RATING" := MemberTotalRiskRatingScore;
        ObjMemberRiskRating."BANK'S CONTROL RISK RATING" := VarControlRiskRating;
        ObjMemberRiskRating."CUSTOMER NET RISK RATING" := ROUND(ObjMemberRiskRating."GROSS CUSTOMER AML RISK RATING" / ObjMemberRiskRating."BANK'S CONTROL RISK RATING", 0.01, '>');
        MemberNetRiskScore := MemberTotalRiskRatingScore / VarControlRiskRating;
        ObjMemberRiskRating.Insert(true);


        ObjNetRiskScale.Reset;
        if ObjNetRiskScale.FindSet then begin
            repeat
                if (MemberTotalRiskRatingScore >= ObjNetRiskScale."Minimum Risk Rate") and (MemberTotalRiskRatingScore <= ObjNetRiskScale."Maximum Risk Rate") then begin
                    ObjMemberRiskRating."Risk Rate Scale" := ObjNetRiskScale."Risk Scale";
                    VarRiskRatingDescription := ObjNetRiskScale.Description;
                end;
            until ObjNetRiskScale.Next = 0;
        end else begin
            ObjMemberRiskRating."Risk Rate Scale" := MemberTotalRiskRatingScore;
        end;

        ObjMemberRiskRating.Validate(ObjMemberRiskRating."Membership Application No");
        ObjMemberRiskRating.Modify;


        ObjMemberDueDiligence.Reset;
        ObjMemberDueDiligence.SetRange(ObjMemberDueDiligence."Member No", MemberNo);
        if ObjMemberDueDiligence.FindSet then begin
            ObjMemberDueDiligence.DeleteAll;
        end;

        ObjDueDiligenceSetup.Reset;
        ObjDueDiligenceSetup.SetRange(ObjDueDiligenceSetup."Risk Rating Level", ObjMemberRiskRating."Risk Rate Scale");
        if ObjDueDiligenceSetup.FindSet then begin
            repeat
                ObjMemberDueDiligence.Init;
                ObjMemberDueDiligence."Member No" := MemberNo;
                if ObjMembershipApplication.Get(MemberNo) then begin
                    ObjMemberDueDiligence."Member Name" := ObjMembershipApplication.Name;
                end;
                ObjMemberDueDiligence."Due Diligence No" := ObjDueDiligenceSetup."Due Diligence No";
                ObjMemberDueDiligence."Risk Rating Level" := ObjMemberRiskRating."Risk Rate Scale";
                ObjMemberDueDiligence."Risk Rating Scale" := VarRiskRatingDescription;
                ObjMemberDueDiligence."Due Diligence Type" := ObjDueDiligenceSetup."Due Diligence Type";
                ObjMemberDueDiligence."Due Diligence Measure" := ObjDueDiligenceSetup."Due Diligence Measure";
                ObjMemberDueDiligence.Insert;
            until ObjDueDiligenceSetup.Next = 0;
        end;

        ObjMembershipApplication.Reset;
        ObjMembershipApplication.SetRange(ObjMembershipApplication."No.", MemberNo);
        if ObjMembershipApplication.Find('-') then begin
            if (MemberNetRiskScore > 0) and (MemberNetRiskScore < 4) then begin
                ObjMembershipApplication."Member Risk Level" := ObjMembershipApplication."Member Risk Level"::"Low Risk";
            end else
                if (MemberNetRiskScore > 4) and (MemberNetRiskScore < 8) then begin
                    ObjMembershipApplication."Member Risk Level" := ObjMembershipApplication."Member Risk Level"::"Medium Risk";
                end else
                    ObjMembershipApplication."Member Risk Level" := ObjMembershipApplication."Member Risk Level"::"High Risk";

            ObjMembershipApplication."Due Diligence Measure" := Format(MemberNetRiskScore);
            //ObjMembershipApplication."Due Diligence Measure" := ObjDueDiligenceSetup."Due Diligence Type";
            ObjMembershipApplication.Modify;
        end;
    end;
    //-----------------------------------------
    procedure FnGetMemberLiability(MemberNo: Code[30]) VarTotaMemberLiability: Decimal
    var
        ObjLoanGuarantors: Record "Loans Guarantee Details";
        ObjLoans: Record "Loans Register";
        ObjLoanSecurities: Record "Loan Collateral Details";
        ObjLoanGuarantors2: Record "Loans Guarantee Details";
        VarTotalGuaranteeValue: Decimal;
        VarMemberAnountGuaranteed: Decimal;
        VarApportionedLiability: Decimal;
        VarLoanOutstandingBal: Decimal;
    begin
        ObjMembers.Reset;
        ObjMembers.SetRange(ObjMembers."No.", MemberNo);
        if ObjMembers.FindSet then begin

            VarTotalGuaranteeValue := 0;
            VarApportionedLiability := 0;
            VarTotaMemberLiability := 0;
            //Loans Guaranteed=======================================================================
            ObjLoanGuarantors.CalcFields(ObjLoanGuarantors."Outstanding Balance");
            ObjLoanGuarantors.Reset;
            ObjLoanGuarantors.SetRange(ObjLoanGuarantors."Member No", MemberNo);
            ObjLoanGuarantors.SetFilter(ObjLoanGuarantors."Outstanding Balance", '>%1', 0);
            if ObjLoanGuarantors.FindSet then begin
                repeat
                    if ObjLoanGuarantors."Amont Guaranteed" > 0 then begin
                        ObjLoanGuarantors.CalcFields(ObjLoanGuarantors."Total Loans Guaranteed");
                        if ObjLoans.Get(ObjLoanGuarantors."Loan No") then begin
                            ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                            if ObjLoans."Outstanding Balance" > 0 then begin
                                VarLoanOutstandingBal := ObjLoans."Outstanding Balance";
                                if ObjLoanGuarantors."Total Loans Guaranteed" <> 0 then begin
                                    VarApportionedLiability := ROUND((ObjLoanGuarantors."Amont Guaranteed" / ObjLoanGuarantors."Total Loans Guaranteed") * VarLoanOutstandingBal, 0.5, '=');
                                end
                            end
                        end;
                    end;
                    VarTotaMemberLiability := VarTotaMemberLiability + VarApportionedLiability;
                until ObjLoanGuarantors.Next = 0;
            end;
        end;
        exit(VarTotaMemberLiability);

    end;

    procedure FnGetMemberSelfLiability(MemberNo: Code[30]) VarTotaMemberLiability: Decimal
    var
        VarTotalGuaranteeValue: Decimal;
        VarApportionedLiability: Decimal;

        ObjLoanGuarantors: Record "Loans Guarantee Details";
        VarLoanOutstandingBal: Decimal;
        MAmountG: Decimal;
        MamountToG: Decimal;
    begin
        ObjMembers.RESET;
        ObjMembers.SETRANGE(ObjMembers."No.", MemberNo);
        IF ObjMembers.FINDSET THEN BEGIN
            VarTotalGuaranteeValue := 0;
            VarApportionedLiability := 0;
            VarTotaMemberLiability := 0;
            //Loans Guaranteed=======================================================================
            ObjLoanGuarantors.RESET;
            ObjLoanGuarantors.SETRANGE(ObjLoanGuarantors."Member No", MemberNo);
            ObjLoanGuarantors.SETRANGE(ObjLoanGuarantors."Self Guarantee", TRUE);
            IF ObjLoanGuarantors.FINDSET THEN BEGIN
                REPEAT

                    ObjLoanGuarantors.CALCFIELDS(ObjLoanGuarantors."Total Loans Guaranteed");
                    IF ObjLoans.GET(ObjLoanGuarantors."Loan No") THEN BEGIN
                        ObjLoans.CALCFIELDS(ObjLoans."Outstanding Balance");
                        VarLoanOutstandingBal := ObjLoans."Outstanding Balance";
                        IF ObjLoanGuarantors."Total Loans Guaranteed" > 0 THEN BEGIN
                            IF VarLoanOutstandingBal > 0 THEN BEGIN
                                VarApportionedLiability := ROUND((ObjLoanGuarantors."Amont Guaranteed" / ObjLoanGuarantors."Total Loans Guaranteed") * VarLoanOutstandingBal, 0.5, '=');
                                VarTotalGuaranteeValue := VarTotalGuaranteeValue + VarApportionedLiability;
                                IF ObjLoanGuarantors."Self Guarantee" = TRUE THEN
                                    VarTotalGuaranteeValue := ObjLoanGuarantors."Amont Guaranteed";
                                //MESSAGE('VarTotalGuaranteeValue %1||VarApportionedLiability %2',VarTotalGuaranteeValue,VarApportionedLiability);

                            END;
                        END;
                    END;
                UNTIL ObjLoanGuarantors.NEXT = 0;
            END;
            //********************************
            MAmountG := 0;
            MamountToG := 0;
            ObjLoanGuarantors.RESET;
            ObjLoanGuarantors.SETRANGE(ObjLoanGuarantors."Member No", MemberNo);
            ObjLoanGuarantors.SETRANGE(ObjLoanGuarantors."Application Statu", TRUE);
            ObjLoanGuarantors.SETRANGE(ObjLoanGuarantors."Self Guarantee", TRUE);
            IF ObjLoanGuarantors.FINDSET THEN BEGIN
                REPEAT
                    ObjLoanGuarantors.CALCFIELDS(ObjLoanGuarantors."Total Loans Guaranteed");
                    IF ObjLoans.GET(ObjLoanGuarantors."Loan No") THEN BEGIN
                        ObjLoans.CALCFIELDS(ObjLoans."Outstanding Balance");
                        VarLoanOutstandingBal := ObjLoans."Outstanding Balance";
                        IF ObjLoanGuarantors."Total Loans Guaranteed" > 0 THEN BEGIN
                            IF VarLoanOutstandingBal < 0 THEN BEGIN

                                MamountToG := ROUND((ObjLoanGuarantors."Amont Guaranteed" / ObjLoanGuarantors."Total Loans Guaranteed") * VarLoanOutstandingBal, 0.5, '=');
                                MAmountG := MAmountG + MamountToG;

                            END;
                        END;
                    END;
                UNTIL ObjLoanGuarantors.NEXT = 0;
            END;

            //*********************************
            VarTotaMemberLiability := MAmountG + VarTotalGuaranteeValue;
            // MESSAGE('VarTotaMemberLiability %1||MAmountG %2||VarTotalGuaranteeValue %3',VarTotaMemberLiability,MAmountG,VarTotalGuaranteeValue);


        END;
        EXIT(VarTotaMemberLiability);
    end;

    procedure FnRunGetLoanPayoffAmount(VarLoanNo: Code[30]) VarLoanPayoffAmount: Decimal
    var
        ObjLoans: Record "Loans Register";
        VarInsurancePayoff: Decimal;
        ObjProductCharge: Record "Loan Product Charges";
        VarEndYear: Date;
        VarInsuranceMonths: Integer;
        VarAmountinArrears: Decimal;
        ObjRepaymentSchedule: Record "Loan Repayment Schedule";
        VarOutstandingInterest: Decimal;
        ObjLoanSchedule: Record "Loan Repayment Schedule";
        VarLoanInsuranceCharged: Decimal;
        VarLoanInsurancePaid: Decimal;
        VarOutstandingInsurance: Decimal;
        VarOutstandingPenalty: Decimal;
        VarTotalInterestPaid: Decimal;
        VarTotalPenaltyPaid: Decimal;
    begin
        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNo);
        if ObjLoans.FindSet then begin
            ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Penalty Charged", ObjLoans."Penalty Paid", ObjLoans."Interest Due",
            ObjLoans."Interest Paid");
            //============================================================Loan Insurance Repayment
            ObjLoans.Reset;
            ObjLoans.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code");
            ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNo);
            if ObjLoans.Find('-') then begin

                ObjLoans.Reset;
                ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNo);
                if ObjLoans.FindSet then begin
                    ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Penalty Charged", ObjLoans."Penalty Paid", ObjLoans."Interest Due",
                    ObjLoans."Interest Paid");

                    if (ObjLoans."Outstanding Balance" <> 0) then begin
                        VarEndYear := CalcDate('CY', Today);

                        ObjLoanSchedule.Reset;
                        ObjLoanSchedule.SetRange(ObjLoanSchedule."Loan No.", VarLoanNo);
                        ObjLoanSchedule.SetFilter(ObjLoanSchedule."Repayment Date", '>%1&<=%2', WorkDate, VarEndYear);
                        if ObjLoanSchedule.FindSet then begin
                            VarInsurancePayoff := 0;
                        end;
                    end;
                end;


                ObjLoanSchedule.Reset;
                ObjLoanSchedule.SetRange(ObjLoanSchedule."Loan No.", VarLoanNo);
                ObjLoanSchedule.SetFilter(ObjLoanSchedule."Repayment Date", '<=%1', WorkDate);
                if ObjLoanSchedule.FindSet then begin
                    repeat
                        VarLoanInsuranceCharged := 0;
                        VarLoanInsurancePaid := 0;
                    until ObjLoanSchedule.Next = 0;
                end;

                VarOutstandingInsurance := 0;


                VarOutstandingInterest := ObjLoans."Interest Due" - (ObjLoans."Interest Paid");
                if VarOutstandingInterest < 0 then begin
                    VarOutstandingInterest := 0;
                end;

                VarOutstandingPenalty := ObjLoans."Penalty Charged" - (ObjLoans."Penalty Paid");
                if VarOutstandingPenalty < 0 then begin
                    VarOutstandingPenalty := 0;
                end;

                VarTotalInterestPaid := ObjLoans."Interest Paid";
                VarTotalPenaltyPaid := ObjLoans."Penalty Paid";
                if ObjLoans.Get(VarLoanNo) then begin
                    ObjLoans."Outstanding Penalty" := VarOutstandingPenalty;
                    ObjLoans."Outstanding Insurance" := VarOutstandingInsurance;
                    ObjLoans."Loan Insurance Charged" := VarLoanInsuranceCharged;
                    ObjLoans."Total Insurance Paid" := VarLoanInsurancePaid;
                    ObjLoans."Total Penalty Paid" := VarTotalPenaltyPaid;
                    ObjLoans."Oustanding Interest" := VarOutstandingInterest;
                    ObjLoans."Total Interest Paid" := VarTotalInterestPaid;
                    ObjLoans."Insurance Payoff" := VarInsurancePayoff;
                    ObjLoans.Modify;
                end;
                ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                VarLoanPayoffAmount := ObjLoans."Outstanding Balance" + VarOutstandingInterest + VarOutstandingPenalty + (VarOutstandingInsurance + VarInsurancePayoff);
                exit(VarLoanPayoffAmount);

            end;
        end;

    end;
    //=-----------------------
    procedure FnGeneratePostedLoansMissingRepaymentSchedule(LoanNumber: Code[50])
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
        InterestVarianceOnlyNafaka: Decimal;
    begin
        LoansRec.Reset;
        LoansRec.SetRange(LoansRec."Loan  No.", LoanNumber);
        LoansRec.SetFilter(LoansRec."Approved Amount", '>%1', 0);
        LoansRec.SetRange(LoansRec.Posted, true);
        if LoansRec.Find('-') then begin
            if (LoansRec."Repayment Start Date" <> 0D) then begin
                if LoansRec."Loan Disbursement Date" = 0D then begin
                    LoansRec."Loan Disbursement Date" := 20170101D;
                end;
                if LoansRec."Repayment Start Date" = 0D then begin
                    LoansRec."Repayment Start Date" := 20170201D;
                end;
                LoansRec.TestField(LoansRec."Loan Disbursement Date");
                LoansRec.TestField(LoansRec."Repayment Start Date");
                if LoansRec.Interest = 0 then begin
                    LoansRec.Interest := 10;
                end;
                if LoansRec.Installments = 0 then begin
                    LoansRec.Installments := 12;
                end;

                RSchedule.Reset;
                RSchedule.SetRange(RSchedule."Loan No.", LoansRec."Loan  No.");
                if RSchedule.Find('-') = false then begin
                    LoanAmount := LoansRec."Approved Amount";
                    InterestRate := LoansRec.Interest;
                    RepayPeriod := LoansRec.Installments;
                    InitialInstal := LoansRec.Installments + LoansRec."Grace Period - Principle (M)";
                    LBalance := LoansRec."Approved Amount";
                    RunDate := LoansRec."Repayment Start Date";
                    InstalNo := 0;

                    //Repayment Frequency
                    if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Daily then
                        RunDate := CalcDate('-1D', RunDate)
                    else
                        if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Weekly then
                            RunDate := CalcDate('-1W', RunDate)
                        else
                            if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Monthly then
                                RunDate := CalcDate('-1M', RunDate)
                            else
                                if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Quaterly then
                                    RunDate := CalcDate('-1Q', RunDate);
                    //Repayment Frequency


                    repeat
                        InstalNo := InstalNo + 1;
                        //Repayment Frequency
                        if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Daily then
                            RunDate := CalcDate('1D', RunDate)
                        else
                            if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Weekly then
                                RunDate := CalcDate('1W', RunDate)
                            else
                                if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Monthly then
                                    RunDate := CalcDate('1M', RunDate)
                                else
                                    if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Quaterly then
                                        RunDate := CalcDate('1Q', RunDate);

                        if LoansRec."Repayment Method" = LoansRec."repayment method"::Amortised then begin
                            //LoansRec.TESTFIELD(LoansRec.Interest);
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
                            //LoansRec.TestField(LoansRec.Repayment);
                            // if LBalance < LoansRec.Repayment then
                            //     LPrincipal := LBalance
                            // else
                            LPrincipal := LoansRec.Repayment;
                            LInterest := Round((LoansRec."Loan Interest Repayment") / LoansRec.Installments, 0.0001, '>');
                        end;

                        //Grace Period
                        if GrPrinciple > 0 then begin
                            LPrincipal := 0
                        end else begin
                            LBalance := LBalance - LPrincipal;

                        end;

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
                        RSchedule.Insert;
                        WhichDay := Date2dwy(RSchedule."Repayment Date", 1);
                    until LBalance < 1

                end;
            end;
        end;

        Commit;
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
    //.......................................................
    procedure FnCreateJournalLines(TemplateName: Text; BatchName: Text; DocumentNo: Code[30]; LineNo: Integer; TransactionType: enum TransactionTypesEnum; AccountType: enum "Gen. Journal Account Type";
                                                                                                                                    AccountNo: Code[50];
                                                                                                                                    TransactionDate: Date;
                                                                                                                                    TransactionAmount: Decimal;
                                                                                                                                    DimensionActivity: Code[40];
                                                                                                                                    ExternalDocumentNo: Code[50];
                                                                                                                                    TransactionDescription: Text;
                                                                                                                                    LoanNumber: Code[50])
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
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;
    end;
    //........................................Fn Recover On LoanOverdrafts
    procedure FnRecoverOnLoanOverdrafts(ClientCode: Code[50])
    var
        LoansRegister: Record "Loans Register";
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        VendorTable: record Vendor;
    begin
        LoansRegister.Reset();
        LoansRegister.SetRange(LoansRegister."Client Code", ClientCode);
        LoansRegister.SetAutoCalcFields(LoansRegister."Outstanding Balance", LoansRegister."Oustanding Interest");
        LoansRegister.SetFilter(LoansRegister."Outstanding Balance", '>%1', 0);
        LoansRegister.SetRange(LoansRegister."Overdraft Installements", LoansRegister."Overdraft Installements"::Loan);
        if LoansRegister.Find('-') then begin
            //...............................Remove Amount from Vendor
            LineNo := LineNo + 1000;
            GenJournalLine.Init;
            GenJournalLine."Journal Template Name" := 'GENERAL';
            GenJournalLine."Journal Batch Name" := 'ARECOVERY';
            GenJournalLine."Document No." := LoansRegister."Loan  No.";
            GenJournalLine."Line No." := LineNo;
            GenJournalLine."Account Type" := GenJournalLine."Account Type"::Vendor;
            VendorTable.Reset();
            VendorTable.SetRange(VendorTable."BOSA Account No", ClientCode);
            if VendorTable.Find('-') then begin
                GenJournalLine."Account No." := VendorTable."No.";
            end;
            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine."Posting Date" := Today;
            GenJournalLine.Description := 'Overdraft On Loan Recovered';
            GenJournalLine.Validate(GenJournalLine."Currency Code");
            GenJournalLine.Amount := LoansRegister."Oustanding Interest" + LoansRegister."Outstanding Balance";
            GenJournalLine."External Document No." := LoansRegister."Loan  No.";
            GenJournalLine.Validate(GenJournalLine.Amount);
            GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
            GenJournalLine."Shortcut Dimension 2 Code" := FnGetMemberBranch(ClientCode);
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
            if GenJournalLine.Amount <> 0 then
                GenJournalLine.Insert;
            //...............................Repay Loan Interest
            LineNo := LineNo + 1000;
            GenJournalLine.Init;
            GenJournalLine."Journal Template Name" := 'GENERAL';
            GenJournalLine."Journal Batch Name" := 'ARECOVERY';
            GenJournalLine."Document No." := LoansRegister."Loan  No.";
            GenJournalLine."Line No." := LineNo;
            GenJournalLine."Account Type" := GenJournalLine."Account Type"::Customer;
            GenJournalLine."Account No." := ClientCode;
            GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::"Interest Paid";
            GenJournalLine."Loan No" := LoansRegister."Loan  No.";
            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine."Posting Date" := Today;
            GenJournalLine.Description := 'Overdraft Interest Paid On Loan Recovery';
            GenJournalLine.Validate(GenJournalLine."Currency Code");
            GenJournalLine.Amount := -LoansRegister."Oustanding Interest";
            GenJournalLine."External Document No." := LoansRegister."Loan  No.";
            GenJournalLine.Validate(GenJournalLine.Amount);
            GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
            GenJournalLine."Shortcut Dimension 2 Code" := FnGetMemberBranch(ClientCode);
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
            if GenJournalLine.Amount <> 0 then
                GenJournalLine.Insert;
            //...............................Repay Loan Interest
            LineNo := LineNo + 1000;
            GenJournalLine.Init;
            GenJournalLine."Journal Template Name" := 'GENERAL';
            GenJournalLine."Journal Batch Name" := 'ARECOVERY';
            GenJournalLine."Document No." := LoansRegister."Loan  No.";
            GenJournalLine."Line No." := LineNo;
            GenJournalLine."Account Type" := GenJournalLine."Account Type"::Customer;
            GenJournalLine."Account No." := ClientCode;
            GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::"Loan Repayment";
            GenJournalLine."Loan No" := LoansRegister."Loan  No.";
            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine."Posting Date" := Today;
            GenJournalLine.Description := 'Overdraft Principle Paid On Loan Recovery';
            GenJournalLine.Validate(GenJournalLine."Currency Code");
            GenJournalLine.Amount := -LoansRegister."Outstanding Balance";
            GenJournalLine."External Document No." := LoansRegister."Loan  No.";
            GenJournalLine.Validate(GenJournalLine.Amount);
            GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
            GenJournalLine."Shortcut Dimension 2 Code" := FnGetMemberBranch(ClientCode);
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
            if GenJournalLine.Amount <> 0 then
                GenJournalLine.Insert;

            GenJournalLine.RESET;
            GenJournalLine.SETRANGE("Journal Template Name", 'GENERAL');
            GenJournalLine.SETRANGE("Journal Batch Name", 'ARECOVERY');
            if GenJournalLine.Find('-') then begin
                CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch", GenJournalLine);
            end;
        end;

    end;

}

