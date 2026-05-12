#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 50122 "KSACCO Postings"
{

    trigger OnRun()
    begin
        TransfeeNOK();
    end;

    var
        SwizzsoftFactory: Codeunit "Swizzsoft Factory.";
        LoansGuaranteeDetails: Record 51372;
        LoansReg: Record 51371;
        MemberRegister: Record 51364;
        MembersNominee: Record 51366;
        NextofKinAccountSign: Record 51353;
        LoanProductsSetup: Record 51381;
        Jtemplate: Text;
        JBatch: Text;
        LineNo: Integer;
        GenJournalLine: Record "Gen. Journal Line";
        InsuranceAcc: Text;
        InsuranceIncomeAcc: Text;
        FundsUserSetup: Record "Funds User Setup";
        Customer: Record Customer;
        SaccoEmployers: Record 51401;

    local procedure FnRebookSPackage()
    var
        SPackageRegister: Record 51904;
        ObjVendors: Record Vendor;
        AvailableBal: Decimal;
        ObjAccTypes: Record 51436;
        JTemplate: Code[30];
        JBatch: Code[30];
        DocNo: Code[30];
        GenSetup: Record 51398;
        LineNo: Integer;
        TransType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account","Loan Insurance Charged","Loan Insurance Paid","Recovery Account","FOSA Shares","Additional Shares";
        AccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee,Member,Investor;
        BalAccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee;
        ObjPackageTypes: Record 51908;
        LodgeFee: Decimal;
        LodgeFeeAccount: Code[20];
        ExciseDuty: Decimal;
        ExciseDutyAccount: Code[20];
        GenJournalLine: Record "Gen. Journal Line";
    begin
        if (SPackageRegister."Maturity Date" = Today) and (SPackageRegister."Maturity Instruction" = SPackageRegister."maturity instruction"::Rebook) then begin


            ObjVendors.Reset;
            ObjVendors.SetRange(ObjVendors."No.", SPackageRegister."Charge Account");
            if ObjVendors.Find('-') then begin
                ObjVendors.CalcFields(ObjVendors.Balance, ObjVendors."Uncleared Cheques");
                AvailableBal := (ObjVendors.Balance - ObjVendors."Uncleared Cheques");

                ObjAccTypes.Reset;
                ObjAccTypes.SetRange(ObjAccTypes.Code, ObjVendors."Account Type");
                if ObjAccTypes.Find('-') then
                    AvailableBal := AvailableBal - ObjAccTypes."Minimum Balance";
            end;




            JTemplate := 'GENERAL';
            JBatch := 'SCUSTODY';
            DocNo := 'Lodge_' + Format(SPackageRegister."Package ID");
            GenSetup.Get();
            LineNo := LineNo + 10000;
            SwizzsoftFactory.FnClearGnlJournalLine(JTemplate, JBatch);//Clear Journal Batch=============================
            TransType := Transtype::" ";
            AccountType := Accounttype::Vendor;
            BalAccountType := Balaccounttype::"G/L Account";

            ObjPackageTypes.Reset;
            ObjPackageTypes.SetRange(ObjPackageTypes.Code, SPackageRegister."Package Type");
            if ObjPackageTypes.FindSet then begin
                LodgeFee := ObjPackageTypes."Package Charge";
                LodgeFeeAccount := ObjPackageTypes."Package Charge Account";
            end;
            GenSetup.Get();
            if AvailableBal >= (LodgeFee + (LodgeFee * (GenSetup."Excise Duty(%)" / 100))) then begin


                //Lodge Fee=============================================================================
                LineNo := LineNo + 10000;
                SwizzsoftFactory.FnCreateGnlJournalLineBalanced(JTemplate, JBatch, DocNo, LineNo, TransType, AccountType, SPackageRegister."Charge Account", Today, 'Package Rebook Charge_' + Format(SPackageRegister."Package ID"), BalAccountType,
 LodgeFeeAccount,
                LodgeFee, 'BOSA', '');
                //Lodge Fee=============================================================================
                GenSetup.Get();
                ExciseDuty := (LodgeFee * (GenSetup."Excise Duty(%)" / 100));
                ExciseDutyAccount := GenSetup."Excise Duty Account";

                GenSetup.Get();
                //Excise On Lodge Fee=============================================================================
                LineNo := LineNo + 10000;
                SwizzsoftFactory.FnCreateGnlJournalLineBalanced(JTemplate, JBatch, DocNo, LineNo, TransType, AccountType, SPackageRegister."Charge Account", Today, 'Excise Rebook Charge_' + Format(SPackageRegister."Package ID"), BalAccountType, ExciseDutyAccount
   ,
                ExciseDuty, 'BOSA', '');
                //Excise On Lodge Fee=============================================================================

                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                GenJournalLine.SetRange("Journal Batch Name", 'SCUSTODY');
                if GenJournalLine.Find('-') then
                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
                SPackageRegister."Package Re_Lodge Fee Charged" := true;
                SPackageRegister."Package Re_Booked On" := Today;
                SPackageRegister."Package Rebooked By" := UserId;
                SPackageRegister."Maturity Date" := CalcDate('1Y', SPackageRegister."Maturity Date");
                SPackageRegister.Modify;
            end;
        end;
    end;

    local procedure UpdateGuarantorInfo()
    begin
        LoansGuaranteeDetails.Reset;
        LoansGuaranteeDetails.SetFilter("Loan No", '<>%1', '');
        //LoansGuaranteeDetails.SETFILTER("Loan No",'BLN0001');
        if LoansGuaranteeDetails.Find('-') then begin
            repeat
            //  LoansGuaranteeDetails."Original Amount":=LoansGuaranteeDetails."Amont Guaranteed";
            //  LoansGuaranteeDetails.MODIFY(TRUE);

            //  LoansGuaranteeDetails.CALCFIELDS("Outstanding Balance","Total Loans Guaranteed");
            //  IF LoansGuaranteeDetails."Total Loans Guaranteed">0 THEN
            //  LoansGuaranteeDetails."Amont Guaranteed":=ROUND(((LoansGuaranteeDetails."Original Amount"/LoansGuaranteeDetails."Total Loans Guaranteed")*(LoansGuaranteeDetails."Outstanding Balance")),1,'=');
            //  LoansGuaranteeDetails.MODIFY(TRUE);
            until LoansGuaranteeDetails.Next = 0;
            //LoansGuaranteeDetails.VALIDATE("Amont Guaranteed");
        end;
        Message('Done');
    end;

    local procedure TransfeeNOK()
    var
        members: Record 51364;
        InsuranceAmt: Decimal;
        InsuranceAmt2: Decimal;
    begin
        // LoansReg.RESET;
        // //LoansReg.SETFILTER("Loan  No.",'<>%1','');
        // LoansReg.SETRANGE(Posted,TRUE);
        // LoansReg.SETRANGE("Loan  No.",'BLN0142');
        // IF LoansReg.FIND('-') THEN BEGIN
        //    REPEAT
        //      LoansReg.CALCFIELDS("Top Up Amount");
        //      InsuranceAmt:=ROUND((((5.03*LoansReg.Installments)+3.03)*(LoansReg."Approved Amount"-LoansReg."Top Up Amount"))/12000,1,'=');
        //      InsuranceAmt2:=ROUND((((5.03*LoansReg.Installments)+3.03)*(LoansReg."Approved Amount"))/12000,1,'=');
        //
        //      InsuranceAcc:='20038';
        //      InsuranceIncomeAcc:='20041';
        //
        //      FundsUserSetup.GET(USERID);
        //      Jtemplate:=FundsUserSetup."Payment Journal Template";
        //      JBatch:=FundsUserSetup."Payment Journal Batch";
        //
        //      GenJournalLine.RESET;
        //      GenJournalLine.SETRANGE("Journal Template Name",Jtemplate);
        //      GenJournalLine.SETRANGE("Journal Batch Name",JBatch);
        //      GenJournalLine.DELETEALL;
        //
        //      //Loaninsurance:=Loaninsurance;
        //      LineNo:=LineNo+10000;
        //      GenJournalLine.INIT;
        //      GenJournalLine."Journal Template Name":=Jtemplate;
        //      GenJournalLine."Journal Batch Name":=JBatch;
        //      GenJournalLine."Line No.":=LineNo;
        //      GenJournalLine."Document No.":=LoansReg."Batch No.";
        //      GenJournalLine."Posting Date":=LoansReg."Loan Disbursement Date";
        //      GenJournalLine."External Document No.":=LoansReg."Loan  No.";
        //      GenJournalLine."Account Type":=GenJournalLine."Account Type"::Member;
        //      GenJournalLine."Transaction Type":=GenJournalLine."Transaction Type"::"Loan Insurance Charged";
        //      GenJournalLine."Account No.":=LoansReg."Client Code";
        //      GenJournalLine.Amount:=InsuranceAmt-InsuranceAmt2;
        //      GenJournalLine.Description:='Loan Insurance correction';
        //      GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"G/L Account";
        //      GenJournalLine."Bal. Account No.":=InsuranceAcc;
        //      GenJournalLine.VALIDATE("Bal. Account No.");
        //      GenJournalLine.VALIDATE(GenJournalLine."Account No.");
        //      GenJournalLine.VALIDATE(GenJournalLine.Amount);
        //      GenJournalLine."Loan No":=LoansReg."Loan  No.";
        //      GenJournalLine."Shortcut Dimension 1 Code":='BOSA';
        //      GenJournalLine."Shortcut Dimension 2 Code":='NAIROBI';
        //      IF GenJournalLine.Amount<>0 THEN
        //      GenJournalLine.INSERT;
        //
        //      GenJournalLine.RESET;
        //      GenJournalLine.SETRANGE("Journal Template Name",Jtemplate);
        //      GenJournalLine.SETRANGE("Journal Batch Name",JBatch);
        //      IF GenJournalLine.FIND('-') THEN BEGIN
        //       CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Sacco",GenJournalLine);
        //      END;
        //
        //      LoansReg.Insurance:=InsuranceAmt;
        //      LoansReg.MODIFY(TRUE);
        //    UNTIL LoansReg.NEXT=0;
        // END;
        // MESSAGE('Done');
        SaccoEmployers.Reset;
        SaccoEmployers.SetFilter(Code, '<>%1', 'EXPRESS');
        if SaccoEmployers.Find('-') then begin
            repeat
                Customer.Init;
                Customer."No." := SaccoEmployers.Code;
                if SaccoEmployers.Description = '' then
                    Customer.Name := SaccoEmployers.Code else
                    Customer.Name := SaccoEmployers.Description;
                Customer."Gen. Bus. Posting Group" := 'LOCAL';
                Customer."Customer Posting Group" := 'EMPLOYER';
                Customer.Insert;
            until SaccoEmployers.Next = 0;
        end;
    end;
}

