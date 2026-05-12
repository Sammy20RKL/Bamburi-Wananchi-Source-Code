#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 50120 "PORTALIntegration MFS"
{
    trigger OnRun()
    begin
        // Message(SubmitLoan('2736', 'PLN36'));

        // SubmitLoan('BWS1165', 'PN0014');
        // OnlineLoanApplication('BWS1973', 'SCHLOAN', 500000, 'Test Loan', 12);
    end;

    var
        i: Integer;
        Rschedule: Record "Loan Repayment Schedule";
        Lperiod: Integer;
        LastPayDate: Date;
        objMember: Record Customer;
        Vendor: Record Vendor;
        // VendorLedgEntry: Record "Vendor Ledger Entry";
        custLedEntry: Record "Cust. Ledger Entry";
        FILESPATH: label 'D:\Kentours Revised\KENTOURS\Kentours\Kentours\Downloads\';
        objLoanRegister: Record "Loans Register";
        objRegMember: Record "Membership Applications";
        GenSetup: Record "Sacco General Set-Up";
        FreeShares: Decimal;
        glamount: Decimal;
        objNextKin: Record "Members Next Kin Details";
        LoansGuaranteeDetails: Record "Loans Guarantee Details";
        objStandingOrders: Record "Standing Orders";
        freq: DateFormula;
        dur: DateFormula;
        phoneNumber: Code[20];
        SMSMessages: Record "SMS Messages";
        iEntryNo: Integer;
        FAccNo: Text[250];
        sms: Text[250];
        objLoanApplication: Record "Main Sector";
        ClientName: Code[20];
        Loansetup: Record "Loan Products Setup";
        feedback: Record Portal;
        LoansPurpose: Record "Loans Purpose";
        ObjLoansregister: Record "Loans Register";
        LPrincipal: Decimal;
        LInterest: Decimal;
        Amount: Decimal;
        LBalance: Decimal;
        LoansRec: Record "Loans Register";
        TotalMRepay: Decimal;
        InterestRate: Decimal;
        Date: Date;
        FormNo: Code[40];
        PortaLuPS: Record PortalUps;
        Loanperiod: Integer;
        Questinnaires: Record Questionnaire;
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        Cust: Record customer;
        StartDate: Date;
        DateFilter: Text[100];
        FromDate: Date;
        ToDate: Date;
        FromDateS: Text[100];
        ToDateS: Text[100];
        DivTotal: Decimal;
        CDeposits: Decimal;
        CustDiv: Record customer;
        DivProg: Record "Dividends Progression";
        CDiv: Decimal;
        BDate: Date;
        CustR: Record customer;
        CapDiv: Decimal;
        DivCapTotal: Decimal;
        RunningPeriod: Code[10];
        LineNo: Integer;
        Gnjlline: Record "Gen. Journal Line";
        PostingDate: Date;
        "W/Tax": Decimal;
        CommDiv: Decimal;
        DivInTotal: Decimal;
        WTaxInTotal: Decimal;
        CapTotal: Decimal;
        Period: Code[20];
        WTaxShareCap: Decimal;
        Online: Record "Online Users";
        SaccoSetup: Record "Sacco No. Series";
        NoSeriesMgmt: Codeunit "No. Series";
        ObjLoanApplications: Record "Online Loan Application";
        LoanProductType: Record "Loan Products Setup";
        ReturnList: Text;
        source: Text;
        OnlineLoanGuarantors: Record "Online Loan Guarantors";
        NewApplicationNumber: Integer;
        ReturnDecimal: Decimal;
        LoanBalancing: Decimal;
        InstallmentCounts: Integer;

        TransactionType: Enum TransactionTypesEnum;

        SalesSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit "No. Series";
        NewLoanNo: Code[30];


    procedure fnUpdatePassword(MemberNo: Code[50]; idNo: Code[50]; NewPassword: Text; smsport: Text) emailAddress: Boolean
    var
        OutStream: OutStream;
    begin
        sms := smsport + NewPassword;
        objMember.Reset;
        objMember.SetRange(objMember."No.", MemberNo);
        objMember.SetRange(objMember."ID No.", idNo);
        if objMember.Find('-') then begin

            phoneNumber := objMember."Mobile Phone No";
            FAccNo := objMember."No.";
            Online.Reset;
            Online.SetRange("User Name", MemberNo);
            if Online.Find('-') then begin
                //Online.INIT;
                Online."User Name" := objMember."No.";
                Online.MobileNumber := objMember."Mobile Phone No";
                Online.IdNumber := idNo;
                Online.Password := NewPassword;
                Online."Changed Password" := true;
                Online.Modify;
                FnSMSMessage(FAccNo, phoneNumber, sms);
                emailAddress := true;
            end else begin
                Online.Init;
                Online."User Name" := objMember."No.";
                Online.MobileNumber := objMember."Mobile Phone No";
                Online.Email := objMember."E-Mail";
                Online."Date Created" := Today;
                Online.IdNumber := idNo;
                Online.Password := NewPassword;
                Online."Changed Password" := true;
                Online.Insert;

                FnSMSMessage(FAccNo, phoneNumber, sms);
                emailAddress := true;
            end;
        end;
    end;


    procedure MiniStatement(MemberNo: Text[100]) MiniStmt: Text
    var
        minimunCount: Integer;
        amount: Decimal;
    begin
        begin
            MiniStmt := '';
            objMember.Reset;
            objMember.SetRange("No.", MemberNo);
            if objMember.Find('-') then begin

                custLedEntry.SetCurrentkey(custLedEntry."Entry No.");
                custLedEntry.Ascending(false);
                custLedEntry.SetRange(custLedEntry."Customer No.", MemberNo);
                custLedEntry.SetRange(custLedEntry.Reversed, false);
                if custLedEntry.FindSet then begin
                    MiniStmt := '';
                    repeat
                        custLedEntry.CalcFields(Amount);
                        amount := custLedEntry.Amount;
                        if amount < 1 then amount := amount * -1;
                        MiniStmt := MiniStmt + Format(custLedEntry."Posting Date") + ':::' + CopyStr(Format(custLedEntry.Description), 1, 25) + ':::' +
                        Format(amount) + '::::';
                        minimunCount := minimunCount + 1;
                        if minimunCount > 20 then begin
                            exit(MiniStmt);
                        end
                    until custLedEntry.Next = 0;
                end;

            end;

        end;
        exit(MiniStmt);
    end;


    procedure fnMemberStatement(MemberNo: Code[50]; filter: Text) exitString: Text
    var
        Filename: Text[100];
        Outputstream: OutStream;
        RecRef: RecordRef;
        TempBlob: Codeunit "Temp Blob";
        Outstr: OutStream;
        Instr: InStream;
        Base64Convert: Codeunit "Base64 Convert";
    begin
        objMember.Reset;
        objMember.SetRange(objMember."No.", MemberNo);
        objMember.SetFilter("Date Filter", filter);
        if objMember.Find('-') then begin
            RecRef.GetTable(objMember);
            Clear(TempBlob);
            TempBlob.CreateOutStream(Outstr);
            TempBlob.CreateInStream(Instr);
            if Report.SaveAs(Report::"Member Detailed Statement", '', ReportFormat::Pdf, Outstr, RecRef) then begin
                exitString := Base64Convert.ToBase64(Instr);
                exit;
            end;
        end;
    end;


    procedure FnMemberDefaultStatement(MemberNo: Code[50]) exitString: Text
    var
        Filename: Text[100];
        Outputstream: OutStream;
        RecRef: RecordRef;
        TempBlob: Codeunit "Temp Blob";
        Outstr: OutStream;
        Instr: InStream;
        Base64Convert: Codeunit "Base64 Convert";
    begin
        objMember.Reset;
        objMember.SetRange(objMember."No.", MemberNo);
        if objMember.Find('-') then begin
            RecRef.GetTable(objMember);
            Clear(TempBlob);
            TempBlob.CreateOutStream(Outstr);
            TempBlob.CreateInStream(Instr);
            if Report.SaveAs(Report::"Member Detailed Statement", '', ReportFormat::Pdf, Outstr, RecRef) then begin
                exitString := Base64Convert.ToBase64(Instr);
                exit;
            end;
        end;
    end;

    procedure fndividentstatement(No: Code[50]; Path: Text[100]) exitString: Text
    var
        filename: Text;
        "Member No": Code[50];
    begin
        objMember.Reset;
        objMember.SetRange(objMember."No.", No);

        if objMember.Find('-') then begin

        end;
    end;

    procedure FnGetLoanProductDetails(productType: Text) response: Text
    begin
        BEGIN

            Loansetup.RESET;
            Loansetup.SETRANGE(Code, productType);
            IF Loansetup.FIND('-') THEN BEGIN
                response := FORMAT(Loansetup."Min. Loan Amount") + ':::' + FORMAT(Loansetup."Max. Loan Amount") + ':::' + FORMAT(Loansetup."Interest rate") + ':::' + FORMAT(Loansetup."No of Installment");
            END;
        END;
    end;

    // procedure FnGetMonthlyDeduction(MemberNo: Code[20]) Amount: Decimal
    // begin
    //     Amount := 0;
    //     objMember.RESET();
    //     objMember.SETRANGE(objMember."No.", MemberNo);
    //     IF objMember.FIND('-') THEN BEGIN
    //         Amount += objMember."Monthly Contribution";

    //         // objLoanRegister.RESET();
    //         // objLoanRegister.SETRANGE("Client Code", objMember."No.");
    //         // objLoanRegister.SETFILTER("Outstanding Balance", '>%1', 0);
    //         // IF objLoanRegister.FINDSET() THEN BEGIN
    //         //     REPEAT
    //         //         Amount += objLoanRegister.Repayment;
    //         //     UNTIL objLoanRegister.NEXT = 0;
    //         // END;
    //         EXIT(Amount);
    //     END;
    // end;

    procedure GetLastContribution(MemberNo: Code[20]) Amount: Decimal
    var
        CustomerLedgerEntry: Record 21;
    begin
        Amount := 0;
        CustomerLedgerEntry.Reset();
        CustomerLedgerEntry.SetRange("Customer No.", MemberNo);
        CustomerLedgerEntry.SetFilter(CustomerLedgerEntry.Description, '<>%1', 'Opening Balance');
        CustomerLedgerEntry.SetFilter(CustomerLedgerEntry.Description, '<>%1', 'INTEREST TO LOAN');
        CustomerLedgerEntry.SetCurrentKey(CustomerLedgerEntry."Posting Date");
        //  CustomerLedgerEntry.SetAscending("Posting Date", false);
        CustomerLedgerEntry.SetFilter(CustomerLedgerEntry."Credit Amount", '>%1', 0);
        if (CustomerLedgerEntry.FindLast) then begin
            CustomerLedgerEntry.CalcFields(CustomerLedgerEntry."Credit Amount");
            Amount := CustomerLedgerEntry."Credit Amount";
        end;

    end;

    procedure GetMonthlyContribution(MemberNo: Code[20]) Amount: Decimal
    var
        CustomerLedgerEntry: Record 21;
    begin
        Amount := 0;
        objMember.Reset();
        objMember.SetRange("No.", MemberNo);
        if (objMember.find('-')) then begin//si calcfield
            //objMember.CalcFields(objMember."Monthly Contribution");
            Amount := objMember."Monthly Contribution";
        end;
        // Amount := 0;


    end;

    procedure fnLoanGuranteed(MemberNo: Code[50]; "filter": Text; BigText: BigText) exitString: Text
    var
        Filename: Text[100];
        Outputstream: OutStream;
        RecRef: RecordRef;
        TempBlob: Codeunit "Temp Blob";
        Outstr: OutStream;
        Instr: InStream;
        Base64Convert: Codeunit "Base64 Convert";
    begin

        objMember.Reset;
        objMember.SetRange(objMember."No.", MemberNo);
        if objMember.Find('-') then begin
            RecRef.GetTable(objMember);
            Clear(TempBlob);
            TempBlob.CreateOutStream(Outstr);
            TempBlob.CreateInStream(Instr);
            if Report.SaveAs(Report::"Members Loans Guarantors", '', ReportFormat::Pdf, Outstr, RecRef) then begin
                exitString := Base64Convert.ToBase64(Instr);
                exit;
            end;
        end;
    end;


    procedure fnLoanRepaymentShedule("Loan No": Code[50]; path: Text[100])
    var
        "Member No": Code[100];
        filename: Text[250];
    begin
        filename := FILESPATH + path;
        objLoanRegister.Reset;
        objLoanRegister.SetRange(objLoanRegister."Loan  No.", "Loan No");

        if objLoanRegister.Find('-') then begin

        end;
    end;


    procedure fnMemberDepositStatement(MemberNo: Code[50]; "filter": Text) exitString: Text
    var
        Filename: Text[100];
        Outputstream: OutStream;
        RecRef: RecordRef;
        TempBlob: Codeunit "Temp Blob";
        Outstr: OutStream;
        Instr: InStream;
        Base64Convert: Codeunit "Base64 Convert";
    begin

        objMember.Reset;
        objMember.SetRange(objMember."No.", MemberNo);
        objMember.SetFilter("Date Filter", filter);
        if objMember.Find('-') then begin
            RecRef.GetTable(objMember);
            Clear(TempBlob);
            TempBlob.CreateOutStream(Outstr);
            TempBlob.CreateInStream(Instr);
            if Report.SaveAs(Report::"Members Deposits Statement", '', ReportFormat::Pdf, Outstr, RecRef) then begin
                exitString := Base64Convert.ToBase64(Instr);
                exit;
            end;
        end;
    end;

    // procedure fnMemberWithdrawableStatement(MemberNo: Code[50]; "filter": Text) exitString: Text
    // var
    //     Filename: Text[100];
    //     Outputstream: OutStream;
    //     RecRef: RecordRef;
    //     TempBlob: Codeunit "Temp Blob";
    //     Outstr: OutStream;
    //     Instr: InStream;
    //     Base64Convert: Codeunit "Base64 Convert";
    // begin

    //     objMember.Reset;
    //     objMember.SetRange(objMember."No.", MemberNo);
    //     objMember.SetFilter("Date Filter", filter);
    //     if objMember.Find('-') then begin
    //         RecRef.GetTable(objMember);
    //         Clear(TempBlob);
    //         TempBlob.CreateOutStream(Outstr);
    //         TempBlob.CreateInStream(Instr);
    //         if Report.SaveAs(Report::"Members Withdrawable Statement", '', ReportFormat::Pdf, Outstr, RecRef) then begin
    //             exitString := Base64Convert.ToBase64(Instr);
    //             exit;
    //         end;
    //     end;
    // end;

    procedure fnLoanGuranteedFosa(MemberNo: Code[50]; "filter": Text; BigText: BigText) exitString: Text
    var
        Filename: Text[100];
        Outputstream: OutStream;
        RecRef: RecordRef;
        TempBlob: Codeunit "Temp Blob";
        Outstr: OutStream;
        Instr: InStream;
        Base64Convert: Codeunit "Base64 Convert";
    begin

        objMember.Reset;
        objMember.SetRange(objMember."No.", MemberNo);
        if objMember.Find('-') then begin
            RecRef.GetTable(objMember);
            Clear(TempBlob);
            TempBlob.CreateOutStream(Outstr);
            TempBlob.CreateInStream(Instr);
            if Report.SaveAs(Report::"Loans Guaranteed Report", '', ReportFormat::Pdf, Outstr, RecRef) then begin
                exitString := Base64Convert.ToBase64(Instr);
                exit;
            end;
        end;
    end;

    procedure fnLoanGurantorsReportFosa(MemberNo: Code[50]; "filter": Text; BigText: BigText) exitString: Text
    var
        Filename: Text[100];
        Outputstream: OutStream;
        RecRef: RecordRef;
        TempBlob: Codeunit "Temp Blob";
        Outstr: OutStream;
        Instr: InStream;
        Base64Convert: Codeunit "Base64 Convert";
    begin


        objMember.Reset;
        objMember.SetRange(objMember."No.", MemberNo);
        if objMember.Find('-') then begin
            RecRef.GetTable(objMember);
            Clear(TempBlob);
            TempBlob.CreateOutStream(Outstr);
            TempBlob.CreateInStream(Instr);
            if Report.SaveAs(Report::"Members Loans Guarantors", '', ReportFormat::Pdf, Outstr, RecRef) then begin //blank report
                exitString := Base64Convert.ToBase64(Instr);
                exit;
            end;
        end;
    end;


    procedure fnLoanGurantorsReport(MemberNo: Code[50]; "filter": Text; BigText: BigText) exitString: Text
    var
        Filename: Text[100];
        Outputstream: OutStream;
        RecRef: RecordRef;
        TempBlob: Codeunit "Temp Blob";
        Outstr: OutStream;
        Instr: InStream;
        Base64Convert: Codeunit "Base64 Convert";
    begin


        objMember.Reset;
        objMember.SetRange(objMember."No.", MemberNo);
        if objMember.Find('-') then begin
            RecRef.GetTable(objMember);
            Clear(TempBlob);
            TempBlob.CreateOutStream(Outstr);
            TempBlob.CreateInStream(Instr);
            if Report.SaveAs(Report::"Loans Guaranteed", '', ReportFormat::Pdf, Outstr, RecRef) then begin
                exitString := Base64Convert.ToBase64(Instr);
                exit;
            end;
        end;
    end;

    // procedure fnChangePassword(memberNumber: Code[100]; currentPass: Text; newPass: Text) updated: Boolean
    // var
    //     InStream: InStream;
    //     PasswordText: Text;
    //     OutStream: OutStream;
    //     DecryptPassword: Text;
    // begin
    //     sms := 'You have successfully updated your password. Your new password is: ' + newPass;
    //     Online.Reset;
    //     Online.SetRange("User Name", memberNumber);
    //     Online.SetRange(Password, currentPass);
    //     if Online.Find('-') then begin
    //         Online.Password := newPass;
    //         Online."Changed Password" := true;
    //         Online.Modify;
    //         updated := true;
    //     end
    //     else begin
    //         Error('Previous password is not correct');
    //     end;
    // end;


    procedure fnTotalRepaidGraph(Mno: Code[10]; year: Code[10]) total: Decimal
    begin
        objMember.Reset;
        objMember.SetRange("No.", Mno);
        if objMember.Find('-') then begin

            objMember.SetFilter("Date Filter", '0101' + year + '..1231' + year);
            //objMember.CALCFIELDS("Current Shares");
            total := objMember."Total Repayments";
            Message('current repaid is %1', total);
        end;
    end;


    procedure fnCurrentShareGraph(Mno: Code[10]; year: Code[10]) total: Decimal
    begin
        objMember.Reset;
        objMember.SetRange("No.", Mno);
        if objMember.Find('-') then begin

            objMember.SetFilter("Date Filter", '0101' + year + '..1231' + year);
            objMember.CalcFields("Current Shares");
            total := objMember."Current Shares";
            Message('current shares is %1', total);
        end;
    end;


    procedure fnTotalDepositsGraph(Mno: Code[10]; year: Code[10]) total: Decimal
    begin
        objMember.Reset;
        objMember.SetRange("No.", Mno);
        if objMember.Find('-') then begin

            objMember.SetFilter("Date Filter", '0101' + year + '..1231' + year);
            objMember.CalcFields("Shares Retained");
            total := objMember."Shares Retained";
            Message('current deposits is %1', total);
        end;
    end;


    procedure FnRegisterKin("Full Names": Text; Relationship: Text; "ID Number": Code[10]; "Phone Contact": Code[10]; Address: Text; Idnomemberapp: Code[10])
    begin
        begin
            objRegMember.Reset;
            objNextKin.Reset;
            objNextKin.Init();
            objRegMember.SetRange("ID No.", Idnomemberapp);
            if objRegMember.Find('-') then begin
                objNextKin."Account No" := objRegMember."No.";
                objNextKin."Name" := "Full Names";
                objNextKin.Relationship := Relationship;
                objNextKin."Id No." := "ID Number";
                objNextKin.Telephone := "Phone Contact";
                objNextKin.Insert(true);
            end;
        end;
    end;


    procedure FnMemberApply("First Name": Code[30]; "Mid Name": Code[30]; "Last Name": Code[30]; "PO Box": Text; Residence: Code[30]; "Postal Code": Text; Town: Code[30]; "Phone Number": Code[30]; Email: Text; "ID Number": Code[30]; "Branch Code": Code[30]; "Branch Name": Code[30]; "Account Number": Code[30]; Gender: Option; "Marital Status": Option; "Account Category": Option; "Application Category": Option; "Customer Group": Code[30]; "Employer Name": Code[30]; "Date of Birth": Date) num: Text
    begin
        begin

            objRegMember.Reset;
            objRegMember.SetRange("ID No.", "ID Number");
            if objRegMember.Find('-') then begin
                Message('already registered');
            end
            else begin
                objRegMember.Init;
                objRegMember.Name := "First Name" + ' ' + "Mid Name" + ' ' + "Last Name";
                objRegMember.Address := "PO Box";
                objRegMember."Address 2" := Residence;
                objRegMember."Postal Code" := "Postal Code";
                objRegMember.Town := Town;
                objRegMember."Phone No." := "Phone Number";
                objRegMember."E-Mail (Personal)" := Email;
                objRegMember."Date of Birth" := "Date of Birth";
                objRegMember."ID No." := "ID Number";
                objRegMember."Bank Code" := "Branch Code";
                objRegMember."Bank Name" := "Branch Name";
                objRegMember."Bank Account No" := "Account Number";
                objRegMember.Gender := Gender;
                objRegMember."Created By" := UserId;
                objRegMember."Global Dimension 1 Code" := 'BOSA';
                objRegMember."Date of Registration" := Today;
                objRegMember.Status := objRegMember.Status::Open;
                objRegMember."Application Category" := "Application Category";
                objRegMember."Account Category" := "Account Category";
                objRegMember."Marital Status" := "Marital Status";
                objRegMember."Employer Name" := "Employer Name";
                objRegMember."Customer Posting Group" := "Customer Group";
                objRegMember.Insert(true);
            end;
        end;
    end;

    local procedure FnFreeShares("Member No": Text) Shares: Text
    begin
        begin
            begin
                GenSetup.Get();
                FreeShares := 0;
                glamount := 0;

                objMember.Reset;
                objMember.SetRange(objMember."No.", "Member No");
                if objMember.Find('-') then begin
                    objMember.CalcFields("Current Shares");
                    LoansGuaranteeDetails.Reset;
                    LoansGuaranteeDetails.SetRange(LoansGuaranteeDetails."Member No", objMember."No.");
                    LoansGuaranteeDetails.SetRange(LoansGuaranteeDetails.Substituted, false);
                    if LoansGuaranteeDetails.Find('-') then begin
                        repeat
                            glamount := glamount + LoansGuaranteeDetails."Amont Guaranteed";
                        //MESSAGE('Member No %1 Account no %2',Members."No.",glamount);
                        until LoansGuaranteeDetails.Next = 0;
                    end;
                    FreeShares := (objMember."Current Shares" * GenSetup."Contactual Shares (%)") - glamount;
                    Shares := Format(FreeShares, 0, '<Precision,2:2><Integer><Decimals>');
                end;
            end;
        end;
    end;


    procedure FnStandingOrders(BosaAcNo: Code[30]; SourceAcc: Code[50]; frequency: Text; Duration: Text; DestAccNo: Code[30]; StartDate: Date; Amount: Decimal; DestAccType: Option)
    begin
        objStandingOrders.Init();
        objStandingOrders."BOSA Account No." := BosaAcNo;
        objStandingOrders."Source Account No." := SourceAcc;
        objStandingOrders.Validate(objStandingOrders."Source Account No.");
        if Format(freq) = '' then
            Evaluate(freq, frequency);
        objStandingOrders.Frequency := freq;
        if Format(dur) = '' then
            Evaluate(dur, Duration);
        objStandingOrders.Duration := dur;
        objStandingOrders."Destination Account No." := DestAccNo;
        objStandingOrders.Validate(objStandingOrders."Destination Account No.");
        objStandingOrders."Destination Account Type" := DestAccType;
        objStandingOrders.Amount := Amount;
        objStandingOrders."Effective/Start Date" := StartDate;
        objStandingOrders.Validate(objStandingOrders.Duration);
        objStandingOrders.Status := objStandingOrders.Status::Open;
        objStandingOrders.Insert(true);
        objMember.Reset;
        objMember.SetRange(objMember."No.", BosaAcNo);
        if objMember.Find('-') then begin
            phoneNumber := objMember."Phone No.";
            sms := 'You have created a standing order of amount : ' + Format(Amount) + ' from Account ' + SourceAcc + ' start date: '
                  + Format(StartDate) + '. Thanks for using SWIZZSOFT SACCO Portal.';
            FnSMSMessage(SourceAcc, phoneNumber, sms);
            //MESSAGE('All Cool');
        end
    end;

    procedure fnAccountInfo2(Memberno: Code[20]) info: Text
    begin
        objMember.RESET;
        objMember.SETRANGE(objMember."No.", Memberno);

        IF objMember.FIND('-') THEN BEGIN

            objMember.CALCFIELDS(objMember."Shares Retained");// "Total Committed Shares");
            objMember.CALCFIELDS(objMember."Current Shares");
            objMember.CALCFIELDS(objMember."Shares Retained");
            info := FORMAT(objMember."Current Shares") + ':' + FORMAT(objMember."Shares Retained") + ':' + FORMAT(objMember."Risk Fund") + ':' + FORMAT(objMember."Dividend Amount") + ':' + FORMAT(objMember."Payroll/Staff No")
            + ':' + FORMAT(objMember."Current Shares" - objMember."Shares Retained");
        END;
    end;

    procedure fnLoans(MemberNo: Code[20]) loans: Text
    begin
        objLoanRegister.RESET;
        objLoanRegister.SETRANGE(objLoanRegister."BOSA No", MemberNo);
        objLoanRegister.SETFILTER(objLoanRegister.Posted, '%1', TRUE);
        objLoanRegister.SETFILTER(objLoanRegister."Outstanding Balance", '>%1', 0);
        //IF (objLoanRegister."Outstanding Balance">0)OR(objLoanRegister."Oustanding Interest">0) THEN BEGIN
        IF objLoanRegister.FIND('-') THEN BEGIN
            // objLoanRegister.SETCURRENTKEY("Application Date");
            objLoanRegister.ASCENDING(TRUE);

            REPEAT
                objLoanRegister.CALCFIELDS("Total Loans Outstanding", objLoanRegister."Outstanding Balance");
                loans := loans + objLoanRegister."Loan Product Type" + ':' + FORMAT(objLoanRegister."Outstanding Balance") + ':' + FORMAT(objLoanRegister."Loans Category-SASRA") + ':' + FORMAT(objLoanRegister.Installments) + ':'
                + FORMAT(objLoanRegister.Installments - Loanperiod) + ':' + FORMAT(objLoanRegister."Outstanding Balance") + ':' + FORMAT(objLoanRegister."Requested Amount") + ':' + FORMAT(objLoanRegister."Loan  No.") + ':' + FORMAT(objLoanRegister."Approval Status")
                + ':' + FORMAT(objLoanRegister."Amount Disbursed") + ':' + FORMAT(objLoanRegister."Approved Amount") + '::'

            UNTIL
            objLoanRegister.NEXT = 0;
            // END;
        END;
    end;

    procedure fnRunningLoans(memberNumber: Code[20]) runningLoans: Text
    var
        balancesText: Text;
    begin
        balancesText := '';
        objLoanRegister.RESET;
        objLoanRegister.SETRANGE(objLoanRegister."Client Code", memberNumber);
        objLoanRegister.SETFILTER(objLoanRegister.Posted, '%1', TRUE);
        objLoanRegister.SETFILTER(objLoanRegister."Outstanding Balance", '>%1', 0);
        IF objLoanRegister.FIND('-') THEN BEGIN
            objLoanRegister.ASCENDING(TRUE);

            REPEAT
                objLoanRegister.CALCFIELDS("Total Loans Outstanding", objLoanRegister."Outstanding Balance");
                if balancesText = '' then begin
                    balancesText := '{"LoanNo":"' + FORMAT(objLoanRegister."Loan  No.") + '"'
                    + ',"LoanProductType":"' + objLoanRegister."Loan Product Type Name" + '"'
                    + ',"Installments":"' + FORMAT(objLoanRegister.Installments) + '"'
                    + ',"LoanBalance":"' + FORMAT(objLoanRegister."Outstanding Balance") + '"'
                    + ',"RemainingPeriod":"' + FORMAT(objLoanRegister.Installments - Loanperiod) + '"'//AmountArrears
                    + ',"RequestedAmount":"' + FORMAT(objLoanRegister."Requested Amount") + '"'
                    + ',"AmountArrears":"' + FORMAT(objLoanRegister."Amount in Arrears") + '"'
                    + ',"LoanStatus":"' + FORMAT(objLoanRegister."Loan Status") + '"}';
                end else begin
                    balancesText := balancesText + ',{"LoanNo":"' + FORMAT(objLoanRegister."Loan  No.") + '"'
                + ',"LoanProductType":"' + objLoanRegister."Loan Product Type Name" + '"'
                + ',"Installments":"' + FORMAT(objLoanRegister.Installments) + '"'
                + ',"LoanBalance":"' + FORMAT(objLoanRegister."Outstanding Balance") + '"'
                + ',"RemainingPeriod":"' + FORMAT(objLoanRegister.Installments - Loanperiod) + '"'
                + ',"RequestedAmount":"' + FORMAT(objLoanRegister."Requested Amount") + '"'
                    + ',"AmountArrears":"' + FORMAT(objLoanRegister."Amount in Arrears") + '"'
                + ',"LoanStatus":"' + FORMAT(objLoanRegister."Loan Status") + '"}';
                end;

            UNTIL
            objLoanRegister.NEXT = 0;
            IF balancesText <> '' THEN BEGIN
                runningLoans := '{ "StatusCode":"200","StatusDescription":"OK","RunningLoans":[' + balancesText + '] }';
            END ELSE BEGIN
                runningLoans := '{ "StatusCode":"400","StatusDescription":"NoLoans","RunningLoans":[] }';
            END;
        END;
    end;

    procedure FnGetMemberProfile(MemberNo: Code[30]) info: Text
    var
        TempBlob: Codeunit "Temp Blob";
        OutStr: OutStream;
        InStr: InStream;
        Base64Convert: Codeunit "Base64 Convert";
        ImageBase64: Text;
    begin
        objMember.RESET;
        objMember.SETRANGE(objMember."No.", MemberNo);
        IF objMember.FIND('-') THEN BEGIN
            // Handle image if exists
            IF objMember.Image.HasValue THEN BEGIN
                Clear(TempBlob);
                TempBlob.CreateOutStream(OutStr);
                objMember.Image.ExportStream(OutStr);
                OutStr.WriteText(''); // Ensure stream is flushed
                TempBlob.CreateInStream(InStr);
                ImageBase64 := Base64Convert.ToBase64(InStr);
            END ELSE BEGIN
                ImageBase64 := '';
            END;

            info := objMember."No." + ':' + objMember.Name + ':' + objMember."E-Mail" + ':' + FORMAT(objMember.Status) + ':' +
                    objMember."Mobile Phone No" + ':' + objMember."ID No." + ':' + FORMAT(objMember."Date of Birth") + ':' +
                    FORMAT(objMember."Payroll/Staff No") + ':' + FORMAT(objMember.Gender) + ':' + FORMAT(objMember.Pin) + ':' +
                    FORMAT(objMember."Country/Region Code") + ':' + FORMAT(objMember.City) + ':' + FORMAT(objMember."Registration Date") + ':' +
                    FORMAT(objMember."Bank Code") + ':' + FORMAT(objMember."Bank Branch Code") + ':' + FORMAT(objMember."Bank Account No.") + ':' +
                    ImageBase64;
        END;
    end;


    procedure fnLoanDetails(Loancode: Code[20]) loandetail: Text
    begin
        Loansetup.RESET;
        Loansetup.SETRANGE(Code, Loancode);
        IF Loansetup.FIND('-') THEN BEGIN
            REPEAT
                loandetail := loandetail + Loansetup."Product Description" + '!!' + FORMAT(Loansetup."Repayment Method") + '!!' + FORMAT(Loansetup."Max. Loan Amount") + '!!' + FORMAT(Loansetup."Instalment Period") + '!!' + FORMAT(Loansetup."Interest rate") + '!!'
                + FORMAT(Loansetup."Repayment Frequency") + '??';
            UNTIL Loansetup.NEXT = 0;
        END;
    end;

    procedure fnOnlineLoans(memberNumber: Code[20]) runningLoans: Text
    var
        balancesText: Text;
        onlineloans: Record "Online Loan Application";
    begin
        balancesText := '';
        onlineloans.RESET;
        onlineloans.SETRANGE(onlineloans."BOSA No", memberNumber);

        onlineloans.SETFILTER(onlineloans.Posted, '%1', false);
        onlineloans.SETFILTER(onlineloans.submitted, '%1', false);
        IF onlineloans.FIND('-') THEN BEGIN
            onlineloans.ASCENDING(TRUE);
            REPEAT
                if balancesText = '' then begin
                    balancesText := '{'
                    + '"LoanNo":"' + FORMAT(onlineloans."Application No") + '"'
                    + ',"ProductType":"' + onlineloans."Loan Type" + '"'
                    + ',"ProductName":"' + onlineloans."Loan Product Type Name" + '"'
                    + ',"Installments":"' + FORMAT(onlineloans."Repayment Period") + '"'
                    + ',"InterestRate":"' + FORMAT(onlineloans."Interest Rate") + '"'
                    + ',"RequestedAmount":"' + FORMAT(onlineloans."Loan Amount") + '"'
                    + ',"LoanSubmittedStatus":"' + FORMAT(onlineloans."submitted") + '"'
                    + ',"InterestCalculationMethod":"' + FORMAT(onlineloans."Interest Calculation Method") + '"'
                    + '}';
                end else begin
                    balancesText := balancesText + ',{'
                    + '"LoanNo":"' + FORMAT(onlineloans."Application No") + '"'
                    + ',"ProductType":"' + onlineloans."Loan Type" + '"'
                    + ',"ProductName":"' + onlineloans."Loan Product Type Name" + '"'
                    + ',"Installments":"' + FORMAT(onlineloans.Installments) + '"'
                    + ',"InterestRate":"' + FORMAT(onlineloans."Interest Rate") + '"'
                    + ',"RequestedAmount":"' + FORMAT(onlineloans."Loan Amount") + '"'
                    + ',"InterestCalculationMethod":"' + FORMAT(onlineloans."Interest Calculation Method") + '"'
                    + '}';
                end;

            UNTIL
            onlineloans.NEXT = 0;
            IF balancesText <> '' THEN BEGIN
                runningLoans := '{ "StatusCode":"200","StatusDescription":"OK","OnlineLoans":[' + balancesText + '] }';
            END ELSE BEGIN
                runningLoans := '{ "StatusCode":"400","StatusDescription":"NoLoans","OnlineLoans":[] }';
            END;
        END;
    end;

    procedure fnOnlineLoan(memberNumber: Code[20]; loanNumber: Code[20]) loanData: Text
    var
        onlineloans: Record "Online Loan Application";
    begin
        loanData := '';
        onlineloans.RESET;
        onlineloans.SETRANGE(onlineloans."BOSA No", memberNumber);
        onlineloans.SetRange(onlineloans."Application No", loanNumber);
        onlineloans.SETFILTER(onlineloans.Posted, '%1', false);
        onlineloans.SETFILTER(onlineloans.submitted, '%1', false);
        IF onlineloans.FIND('-') THEN BEGIN
            loanData := '{'
                    + '"LoanNo":"' + FORMAT(onlineloans."Application No") + '"'
                    + ',"ProductType":"' + onlineloans."Loan Type" + '"'
                    + ',"ProductName":"' + onlineloans."Loan Product Type Name" + '"'
                    + ',"Installments":"' + FORMAT(onlineloans.Installments) + '"'
                    + ',"InterestRate":"' + FORMAT(onlineloans."Interest Rate") + '"'
                    + ',"RequestedAmount":"' + FORMAT(onlineloans."Loan Amount") + '"'
                    + ',"InterestCalculationMethod":"' + FORMAT(onlineloans."Interest Calculation Method") + '"'
                    + ',"ApplicationDate":"' + FORMAT(onlineloans."Application Date") + '"'
                    + '}';
        END;
    end;

    procedure FnGetNOKProfile(MemberNo: Code[20]) info: Text
    var
        memberNominee: Record "Members Nominee";
        memberNextOfKin: Record "Members Next Kin Details";
    begin
        objMember.RESET;
        objMember.SETRANGE(objMember."No.", MemberNo);
        IF objMember.FIND('-') THEN BEGIN
            memberNextOfKin.Reset();
            memberNextOfKin.SetRange(memberNextOfKin."Account No", objMember."No.");
            if memberNextOfKin.Find('-') then begin
                REPEAT
                    info := info + FORMAT(memberNextOfKin."Name") + ':' + FORMAT(memberNextOfKin."Date of Birth") + ':' + FORMAT(memberNextOfKin."%Allocation") + ':' + Format(memberNextOfKin.Beneficiary) + ':' + FORMAT(memberNextOfKin.Relationship) + '::';
                UNTIL memberNextOfKin.NEXT() = 0;
            end;
            // objNextKin.RESET();
            // objNextKin.SETRANGE("Account No", objMember."No.");
            // IF objNextKin.FIND('-') THEN BEGIN
            //     REPEAT
            //         info := info + FORMAT(objNextKin."Name") + ':' + FORMAT(objNextKin."Date of Birth") + ':' + FORMAT(objNextKin."%Allocation") + ':' + FORMAT(objNextKin.Relationship) + '::';
            //     UNTIL objNextKin.NEXT() = 0;
            // END;
        END;
    end;

    procedure FnUpdateMonthlyContrib("Member No": Code[30]; "Updated Fig": Decimal)
    begin
        objMember.Reset;
        objMember.SetRange(objMember."No.", "Member No");

        if objMember.Find('-') then begin
            phoneNumber := objMember."Phone No.";
            FAccNo := objMember."Payroll/Staff No";
            objMember."Monthly Contribution" := "Updated Fig";
            objMember.Modify;
            sms := 'You have adjusted your monthly contributions to: ' + Format("Updated Fig") + ' account number ' + FAccNo +
                  '. Thank you for using Bamburi Wananchi Sacco Portal';
            FnSMSMessage(FAccNo, phoneNumber, sms);

            //MESSAGE('Updated');
        end
    end;


    procedure


    FnSMSMessage(accfrom: Text[30]; phone: Text[20]; message: Text[250])
    begin

        SMSMessages.Reset;
        if SMSMessages.Find('+') then begin
            iEntryNo := SMSMessages."Entry No";
            iEntryNo := iEntryNo + 1;
        end
        else begin
            iEntryNo := 1;
        end;
        SMSMessages.Init;
        SMSMessages."Entry No" := iEntryNo;
        //SMSMessages."Batch No":=documentNo;
        //SMSMessages."Document No":=documentNo;
        SMSMessages."Account No" := accfrom;
        SMSMessages."Date Entered" := Today;
        SMSMessages."Time Entered" := Time;
        SMSMessages.Source := 'WEBPORTAL';
        SMSMessages."Entered By" := UserId;
        SMSMessages."Sent To Server" := SMSMessages."sent to server"::No;
        SMSMessages."SMS Message" := message;
        SMSMessages."Telephone No" := phone;
        if SMSMessages."Telephone No" <> '' then
            SMSMessages.Insert;
    end;


    procedure FnLoanApplication(Member: Code[30]; LoanProductType: Code[10]; AmountApplied: Decimal; LoanPurpose: Code[30]; RepaymentFrequency: Integer) Result: Boolean
    begin
        objMember.Reset;
        objMember.SetRange(objMember."No.", Member);
        if objMember.Find('-') then begin
            Loansetup.Reset;
            if Loansetup.Get(LoanProductType) then begin
                objLoanRegister.Source := Loansetup.Source;
                // source=Loansetup.Source;
            end;

            objLoanRegister.Init;
            Message('test');
            objLoanRegister."Client Code" := Member;
            objLoanRegister."Loan Product Type" := LoanProductType;
            // objLoanRegister.VALIDATE("Loan Product Type");
            objLoanRegister.Installments := RepaymentFrequency;
            // objLoanRegister.VALIDATE(Installments);
            objLoanRegister."Requested Amount" := AmountApplied;
            // objLoanRegister.VALIDATE("Requested Amount");
            objLoanRegister."Captured By" := UserId;
            objLoanRegister."Loan Purpose" := LoanPurpose;
            objLoanRegister."Loan Status" := objLoanRegister."loan status"::Application;
            Message('test');
            objLoanRegister.Insert;
            Message('test');
            Result := true;
            phoneNumber := objMember."Mobile Phone No";
            ClientName := objMember.Name;
            sms := 'We have received your ' + LoanProductType + ' loan application of  amount : ' + Format(AmountApplied) +
            '. We are processing your loan, you will hear from us soon. Thanks for using SWIZZSOFT SACCO  Portal.';
            FnSMSMessage(ClientName, phoneNumber, sms);
            PortaLuPS.Init;
            // PortaLuPS.INSERT(TRUE);
            objLoanRegister.Reset;
            objLoanRegister.SetRange("Client Code", Member);
            objLoanRegister.SetCurrentkey("Application Date");
            objLoanRegister.Ascending(true);
            if objLoanRegister.FindLast
              then
                PortaLuPS.LaonNo := objLoanRegister."Loan  No.";
            PortaLuPS.RequestedAmount := AmountApplied;
            PortaLuPS.Insert;
            //MESSAGE('All Cool');
            //MESSAGE('Am just cool');
        end;
    end;


    procedure FnDepositsStatement("Account No": Code[30]; path: Text[100]) exitString: Text
    var
        Filename: Text[100];
        Outputstream: OutStream;
        RecRef: RecordRef;
        TempBlob: Codeunit "Temp Blob";
        Outstr: OutStream;
        Instr: InStream;
        Base64Convert: Codeunit "Base64 Convert";
    begin
        objMember.Reset;
        objMember.SetRange(objMember."No.", "Account No");
        if objMember.Find('-') then begin
            RecRef.GetTable(objMember);
            Clear(TempBlob);
            TempBlob.CreateOutStream(Outstr);
            TempBlob.CreateInStream(Instr);
            if Report.SaveAs(Report::"Members Deposits Statement", '', ReportFormat::Pdf, Outstr, RecRef) then begin
                exitString := Base64Convert.ToBase64(Instr);
                exit;
            end;
        end;
    end;


    procedure FnLoanStatement(MemberNo: Code[50]; "filter": Text; var BigText: BigText) exitString: Text
    var
        Filename: Text[100];
        Outputstream: OutStream;
        RecRef: RecordRef;
        TempBlob: Codeunit "Temp Blob";
        Outstr: OutStream;
        Instr: InStream;
        Base64Convert: Codeunit "Base64 Convert";
    begin
        objMember.Reset;
        objMember.SetRange(objMember."No.", MemberNo);
        // objMember.SetFilter("Date Filter", filter);
        if objMember.Find('-') then begin
            RecRef.GetTable(objMember);
            Clear(TempBlob);
            TempBlob.CreateOutStream(Outstr);
            TempBlob.CreateInStream(Instr);
            if Report.SaveAs(Report::"Member Loans Statement", '', ReportFormat::Pdf, Outstr, RecRef) then begin
                exitString := Base64Convert.ToBase64(Instr);
                exit;
            end;
        end;
    end;

    procedure FnLoanSchedule(MemberNo: Code[50]; loanNo: Code[20]) exitString: Text
    var
        Filename: Text[100];
        Outputstream: OutStream;
        RecRef: RecordRef;
        TempBlob: Codeunit "Temp Blob";
        Outstr: OutStream;
        Instr: InStream;
        Base64Convert: Codeunit "Base64 Convert";
    begin
        objLoanRegister.Reset();
        objLoanRegister.SetFilter(objLoanRegister."Client Code", MemberNo);
        objLoanRegister.SetRange(objLoanRegister."Loan  No.", loanNo);
        if objLoanRegister.Find('-') then begin
            RecRef.GetTable(objLoanRegister);
            Clear(TempBlob);
            TempBlob.CreateOutStream(Outstr);
            TempBlob.CreateInStream(Instr);
            if Report.SaveAs(Report::"Loans Repayment Schedule New", '', ReportFormat::Pdf, Outstr, RecRef) then begin
                exitString := Base64Convert.ToBase64(Instr);
                exit;
            end;
        end;
    end;


    procedure FnLoanStatementFosa(MemberNo: Code[50]; "filter": Text; BigText: BigText) exitString: Text
    var
        Filename: Text[100];
        Outputstream: OutStream;
        RecRef: RecordRef;
        TempBlob: Codeunit "Temp Blob";
        Outstr: OutStream;
        Instr: InStream;
        Base64Convert: Codeunit "Base64 Convert";
    begin
        objMember.Reset;
        objMember.SetRange(objMember."No.", MemberNo);
        if objMember.Find('-') then begin
            RecRef.GetTable(objMember);
            Clear(TempBlob);
            TempBlob.CreateOutStream(Outstr);
            TempBlob.CreateInStream(Instr);
            if Report.SaveAs(Report::"Member Loans Statement", '', ReportFormat::Pdf, Outstr, RecRef) then begin
                exitString := Base64Convert.ToBase64(Instr);
                exit;
            end;
        end;
    end;

    procedure Fnlogin(username: Code[50]; password: Text) status: Boolean
    var
        InStream: InStream;
        PasswordText: Text;
        DecrypText: Text;
        ObjLog: Record "Portal Logs";
        ObjMember: Record customer;
    begin
        Online.Reset;
        Online.SetRange("User Name", username);
        Online.SetRange(Password, password);
        if Online.Find('-') then begin
            status := true;
            ObjLog.Reset;
            ObjLog.Init;
            ObjLog."Member No" := username;
            ObjLog.Date := Today;
            ObjLog.Time := Time;
            ObjLog."Login Status" := ObjLog."login status"::Successfull;
            Online."Last Login" := CurrentDateTime;
            ObjMember.Reset;
            if ObjMember.Get(username) then begin
                ObjLog."Member Name" := ObjMember.Name;
            end;
            ObjLog.Insert;
        end else begin
            status := false;
            ObjLog.Reset;
            ObjLog.Init;
            ObjLog."Member No" := username;
            ObjLog.Date := Today;
            ObjLog.Time := Time;
            ObjLog."Login Status" := ObjLog."login status"::Failed;
            ObjMember.Reset;
            if ObjMember.Get(username) then begin
                ObjLog."Member Name" := ObjMember.Name;
            end;
            ObjLog.Insert
        end;
    end;

    // procedure fnSendOTPCode(memberNumber: Code[10]; otpCode: Code[5]) validated: Boolean
    // begin
    //     validated := false;
    //     Online.Reset();
    //     Online.SetRange("User Name", memberNumber);
    //     if Online.Find('-') then begin
    //         sms := 'Your Portal verification code is ' + otpCode;
    //         Online."Login OTP" := otpCode;
    //         FnSMSMessage(memberNumber, Online.MobileNumber, sms);
    //         Online.Modify(true);
    //         validated := true;
    //     end;
    // end;

    // procedure fnConfirmOTPCode(memberNumber: Code[10]; otpCode: Code[5]) validated: Boolean
    // begin
    //     validated := false;
    //     Online.Reset();
    //     Online.SetRange("User Name", memberNumber);
    //     Online.SetRange("Login OTP", otpCode);
    //     if Online.Find('-') then begin

    //         validated := true;
    //     end;
    // end;

    procedure FnmemberInfo(MemberNo: Code[20]) info: Text
    begin
        objMember.Reset;
        objMember.SetRange(objMember."No.", MemberNo);
        if objMember.Find('-') then begin
            info := objMember."No." + '.' + ':' + objMember.Name + '.' + ':' + objMember."E-Mail" + '.' + ':' + Format(objMember.Status) + '.' + ':' + Format(objMember."Account Category") + '.' + ':' + objMember."Mobile Phone No"
            + '.' + ':' + objMember."ID No." + '.' + ':' + objMember."Payroll/Staff No";
        end
        else
            objMember.Reset;
        objMember.SetRange(objMember."ID No.", MemberNo);
        if objMember.Find('-') then begin
            info := objMember."No." + '.' + ':' + objMember.Name + '.' + ':' + objMember."E-Mail" + '.' + ':' + objMember."Employer Name" + '.' + ':' + Format(objMember."Account Category") + '.' + ':' + objMember."Mobile Phone No"
            + '.' + ':' + objMember."Bank Code" + '.' + ':' + objMember."Bank Account No." + '.' + ':' + objMember."Payroll/Staff No";

        end;
    end;


    // procedure MemberAccountDetails(MemberNo: Code[20]) info: Text
    // var
    //     dateOfBirth: Date;
    // begin
    //     objMember.Reset;
    //     objMember.SetRange(objMember."No.", MemberNo);
    //     if objMember.Find('-') then begin
    //         dateOfBirth := objMember."Date of Birth";
    //         if FORMAT(dateOfBirth) = '' then
    //             dateOfBirth := Today;

    //         info := '{ "MemberNumber":"' + objMember."No." + '.' +
    //                   '","MemberName":"' + objMember.Name + '.' +
    //                   '","EmailAddress":"' + FORMAT(objMember."E-Mail") + '.' +
    //                   '","AccountStatus":"' + FORMAT(objMember.Status) + '.' +
    //                   '","MobileNumber":"' + FORMAT(objMember."Mobile Phone No") + '.' +
    //                   '","IdNumber":"' + FORMAT(objMember."ID No.") + '.' +
    //                   '","AccountCategory":"' + FORMAT(objMember."Account Category") + '.' +
    //                   '","PayrollNumber":"' + FORMAT(objMember."Payroll/Staff No") + '.' +
    //                   '","DateofBirth":"' + Format(dateOfBirth) +
    //                   '","Gender":"' + FORMAT(objMember.Gender) + '." }';
    //     end;
    // end;


    procedure MemberAccountStatistics(MemberNo: Code[20]) info: Text
    begin
        objMember.Reset;
        objMember.SetRange(objMember."No.", MemberNo);
        if objMember.Find('-') then begin
            objMember.CalcFields("Current Shares");
            objMember.CalcFields("Shares Retained");
            objMember.CalcFields("FOSA Account Bal");
            objMember.CalcFields("FOSA Account Bal");
            objMember.CalcFields("Outstanding Interest");
            objMember.CalcFields("Total Arrears");
            info := '{ ' +
                      '"MemberNumber":"' + objMember."No." +
                      '","MemberDeposits":"' + FORMAT(objMember."Current Shares") +
                      '","ShareCapital":"' + FORMAT(objMember."Shares Retained") +
                      '","M_WalletBalance":"' + FORMAT(objMember."FOSA Account Bal") +
                      '","HolidaySavings":"' + FORMAT(objMember."Holiday Savings") +
                      '","OutstandingLoanBalance":"' + FORMAT(objMember."Outstanding Balance") +
                      '","OutstandingInterest":"' + FORMAT(objMember."Outstanding Interest") +
                      '","LoanArrears":"' + FORMAT(objMember."Total Arrears") +
                      '","M_Walletccount":"' + FORMAT(objMember."FOSA Account No.") +
                      '" }';
        end;
    end;


    procedure fnAccountInfo(Memberno: Code[20]) info: Text
    var
        FOSAbal: Text;
        AccountTypes: Record "Account Types-Saving Products";
        miniBalance: Decimal;
        accBalance: Decimal;
    begin
        objMember.Reset;
        objMember.SetRange(objMember."No.", Memberno);
        objMember.Get(objMember."FOSA Account No.");
        if objMember.Find('-') then begin
            Vendor.Reset;
            Vendor.SetRange("No.", objMember."FOSA Account No.");
            if Vendor.FindFirst then begin
                repeat
                    AccountTypes.Reset;
                    AccountTypes.SetRange(AccountTypes.Code, Vendor."Account Type");
                    if AccountTypes.Find('-') then begin
                        miniBalance := AccountTypes."Minimum Balance";
                    end;
                    Vendor.CalcFields(Vendor."Balance (LCY)");
                    Vendor.CalcFields(Vendor."ATM Transactions");
                    Vendor.CalcFields(Vendor."Uncleared Cheques");
                    Vendor.CalcFields(Vendor."EFT Transactions");
                    accBalance := accBalance + (Vendor."Balance (LCY)" - (Vendor."ATM Transactions" + Vendor."Uncleared Cheques" + Vendor."EFT Transactions" + miniBalance));

                    FOSAbal := Format(accBalance);
                    Message('bal%1', FOSAbal);
                until Vendor.Next = 0;
            end;

            objMember.CalcFields("Current Shares");
            objMember.CalcFields("Dividend Amount");
            objMember.CalcFields("Shares Retained");
            info := Format(objMember."Shares Retained") + ':' + Format(objMember."Shares Retained") + ':' + Format(objMember."Current Shares") + ':' + Format(FOSAbal)
            + ':' + Format(objMember."Dividend Amount", 0, '<Precision,2:2><Integer><Decimals>');
        end;
    end;

    procedure fnOutstandingLoan(memberNo: Code[20]) loanBalance: Decimal
    begin
        loanBalance := 0;
        objMember.Reset();
        objMember.SetRange(objMember."No.", memberNo);
        if objMember.Find('-') then begin
            objMember.CalcFields(objMember."Outstanding Balance");
            loanBalance := objMember."Outstanding Balance";
        end;
    end;

    procedure fnLoans2(MemberNo: Code[20]) loans: Text
    begin
        objLoanRegister.Reset;
        objLoanRegister.SetRange("Client Code", MemberNo);
        objLoanRegister.SetCurrentkey("Outstanding Balance");
        objLoanRegister.Ascending(false);
        if objLoanRegister.Find('-') then begin
            repeat

                LastPayDate := objLoanRegister."Issued Date";
                Rschedule.Reset;
                Rschedule.SetRange("Loan No.", objLoanRegister."Loan  No.");
                Rschedule.SetFilter(Rschedule."Repayment Date", '.. %1', Today);
                if Rschedule.FindFirst then begin
                    Lperiod := Rschedule.Count;
                    i := objLoanRegister.Installments - Lperiod;
                end;
                objLoanRegister.CalcFields("Outstanding Balance");
                if objLoanRegister."Outstanding Balance" > 0 then
                    loans := loans + objLoanRegister."Loan Product Type Name" + ':' + Format(objLoanRegister."Outstanding Balance") + ':' + Format(objLoanRegister."Loan Status") + ':' + Format(objLoanRegister.Installments) + ':'
                    + Format(i) + ':' + Format(objLoanRegister."Outstanding Balance") + ':' + Format(objLoanRegister."Requested Amount") + '::';

            until
              objLoanRegister.Next = 0;

        end;
    end;


    procedure FnloanCalc(LoanAmount: Decimal; RepayPeriod: Integer; LoanCode: Code[30]) text: Text
    begin
        //....................................................................................................................
        Loansetup.Reset;
        Loansetup.SetRange(Code, LoanCode);

        if Loansetup.Find('-') then begin
            if Loansetup."Repayment Method" = Loansetup."repayment method"::Amortised then begin
                Date := Today;
                InstallmentCounts := 0;
                LBalance := LoanAmount;
                repeat
                    TotalMRepay := ROUND((Loansetup."Interest rate" / 12 / 100) / (1 - Power((1 + (Loansetup."Interest rate" / 12 / 100)), -(RepayPeriod))) * (LoanAmount), 0.05, '>');
                    LInterest := ROUND(LBalance / 100 / 12 * InterestRate, 0.05, '>');//Interest repayment
                    LPrincipal := TotalMRepay - LInterest;//principal repayment
                    InstallmentCounts := InstallmentCounts + 1;
                    if InstallmentCounts = 1 then begin
                        LBalance := LoanAmount;
                    end else begin
                        LBalance := LBalance - LPrincipal;
                    end;
                    Date := CalcDate('+1M', Date);
                    text := text + Format(Date) + '!!' + Format(ROUND(LPrincipal)) + '!!' + Format(ROUND(LInterest)) + '!!' + Format(ROUND(TotalMRepay)) + '!!' + Format(ROUND(LoanAmount)) + '!!' + Format(ROUND(LBalance)) + '??';
                until InstallmentCounts = RepayPeriod;
            end;
            //........................................................................................................
            if Loansetup."Repayment Method" = Loansetup."repayment method"::"Straight Line" then begin
                Date := Today;
                InstallmentCounts := 0;
                LBalance := LoanAmount;
                repeat
                    LPrincipal := ROUND(LoanAmount / RepayPeriod, 0.05, '>');
                    LInterest := ROUND((Loansetup."Interest rate" / 12 / 100) * LoanAmount, 0.05, '>');
                    TotalMRepay := LPrincipal + LInterest;
                    InstallmentCounts := InstallmentCounts + 1;
                    if InstallmentCounts = 1 then begin
                        LBalance := LoanAmount;
                    end else begin
                        LBalance := LBalance - LPrincipal;
                    end;
                    Date := CalcDate('+1M', Date);
                    text := text + Format(Date) + '!!' + Format(ROUND(LPrincipal)) + '!!' + Format(ROUND(LInterest)) + '!!' + Format(ROUND(TotalMRepay)) + '!!' + Format(ROUND(LoanAmount)) + '!!' + Format(ROUND(LBalance)) + '??';
                until InstallmentCounts = RepayPeriod;
            end;
            //-----------------------------------------------------------------------------------------------------------
            if Loansetup."Repayment Method" = Loansetup."repayment method"::"Reducing Balance" then begin
                Date := Today;
                InstallmentCounts := 0;
                LBalance := LoanAmount;
                repeat
                    LPrincipal := ROUND(LoanAmount / RepayPeriod, 0.05, '>');
                    LInterest := ROUND((Loansetup."Interest rate" / 12 / 100) * LoanAmount, 0.05, '>');
                    TotalMRepay := LPrincipal + LInterest;
                    InstallmentCounts := InstallmentCounts + 1;
                    if InstallmentCounts = 1 then begin
                        LBalance := LoanAmount;
                    end else begin
                        LBalance := LBalance - LPrincipal;
                    end;
                    Date := CalcDate('+1M', Date);
                    text := text + Format(Date) + '!!' + Format(ROUND(LPrincipal)) + '!!' + Format(ROUND(LInterest)) + '!!' + Format(ROUND(TotalMRepay)) + '!!' + Format(ROUND(LoanAmount)) + '!!' + Format(ROUND(LBalance)) + '??';
                until InstallmentCounts = RepayPeriod;
            end;

            //---------------------------------------------------------------------------------------------------------
            if Loansetup."Repayment Method" = Loansetup."repayment method"::Constants then begin
                Date := Today;
                InstallmentCounts := 0;
                LBalance := LoanAmount;
                repeat
                    LPrincipal := ROUND(LoanAmount / RepayPeriod, 0.05, '>');
                    LInterest := ROUND((Loansetup."Interest rate" / 12 / 100) * LoanAmount, 0.05, '>');
                    TotalMRepay := LPrincipal + LInterest;
                    InstallmentCounts := InstallmentCounts + 1;
                    if InstallmentCounts = 1 then begin
                        LBalance := LoanAmount;
                    end else begin
                        LBalance := LBalance - LPrincipal;
                    end;
                    Date := CalcDate('+1M', Date);
                    text := text + Format(Date) + '!!' + Format(ROUND(LPrincipal)) + '!!' + Format(ROUND(LInterest)) + '!!' + Format(ROUND(TotalMRepay)) + '!!' + Format(ROUND(LoanAmount)) + '!!' + Format(ROUND(LBalance)) + '??';
                until InstallmentCounts = RepayPeriod;
            end;
        end;
    end;


    // procedure FnloansProducts() loanType: Text
    // begin
    //     Loansetup.Reset;
    //     //Loansetup.SETRANGE(Source, Loansetup.Source::FOSA);
    //     Loansetup.SetRange(Loansetup."Show On Portal", true);
    //     if Loansetup.Find('-') then begin
    //         //loanType:='';
    //         repeat
    //             loanType := Format(Loansetup.Code) + ':' + Loansetup."Product Description" + ':::' + loanType;
    //         //   loanType:=loanType+Loansetup."Product Description"+'!!'+ FORMAT(Loansetup."Repayment Method")+'!!'+FORMAT(Loansetup."Max. Loan Amount")+'!!'+FORMAT(Loansetup."Instalment Period")+'!!'+FORMAT(Loansetup."Interest rate")+'!!'
    //         //  +FORMAT(Loansetup."Repayment Frequency")+'??';
    //         until Loansetup.Next = 0;
    //     end;
    // end;


    // procedure Fnloanssetup(): Text
    // var
    //     loanType: Text;
    // begin
    //     loanType := '';
    //     Loansetup.Reset();
    //     Loansetup.SetRange(Source, Loansetup.Source::BOSA);

    //     if Loansetup.FindSet() then begin
    //         repeat
    //             loanType +=
    //                 'Loan Code: ' + Format(Loansetup.Code) + '\n' +
    //                 'Product Description: ' + Loansetup."Product Description" + '\n' +
    //                 'Repayment Method: ' + Format(Loansetup."Repayment Method") + '\n' +
    //                 'Max Loan Amount: ' + Format(Loansetup."Max. Loan Amount") + '\n' +
    //                 'Installment Period: ' + Format(Loansetup."Instalment Period") + '\n' +
    //                 'Interest Rate: ' + Format(Loansetup."Interest rate") + '%\n' +
    //                 'Repayment Frequency: ' + Format(Loansetup."Repayment Frequency") + '\n' +
    //                 '--------------------------------------------------\n';
    //         until Loansetup.Next() = 0;
    //     end else begin
    //         loanType := 'No BOSA loan products found.';
    //     end;

    //     exit(loanType);
    // end;


    // procedure Fnloanssetup(): Text
    // var
    //     loanType: Text;
    // begin
    //     loanType := '';
    //     Loansetup.Reset();
    //     Loansetup.SetRange(Source, Loansetup.Source::BOSA);
    //     if Loansetup.FindSet() then begin
    //         repeat
    //             loanType +=
    //                 'Loan Code: ' + Format(Loansetup.Code) + '\n' +
    //                 'Product Description: ' + Loansetup."Product Description" + '\n' +
    //                 'Repayment Method: ' + Format(Loansetup."Repayment Method") + '\n' +
    //                 'Max Loan Amount: ' + Format(Loansetup."Max. Loan Amount") + '\n' +
    //                 'Installment Period: ' + Format(Loansetup."Instalment Period") + '\n' +
    //                 'Interest Rate: ' + Format(Loansetup."Interest rate") + '%\n' +
    //                 'Repayment Frequency: ' + Format(Loansetup."Repayment Frequency") + '\n' +
    //                 '--------------------------------------------------\n';
    //         until Loansetup.Next() = 0;
    //     end else begin
    //         loanType := 'No BOSA loan products found.';
    //     end;
    //     exit(loanType);
    // end;


    procedure Fnloanssetup() loanType: Text
    begin
        Loansetup.Reset;
        Loansetup.SETRANGE(Source, Loansetup.Source::BOSA);
        if Loansetup.Find('-') then begin
            //loanType:='';
            repeat
                loanType := Format(Loansetup.Code) + ':' + Loansetup."Product Description" + ':::' + loanType;
                loanType := loanType + Loansetup."Product Description" + '!!' + FORMAT(Loansetup."Repayment Method") + '!!' + FORMAT(Loansetup."Max. Loan Amount") + '!!' + FORMAT(Loansetup."Instalment Period") + '!!' + FORMAT(Loansetup."Interest rate") + '!!'
               + FORMAT(Loansetup."Repayment Frequency") + '??';
            until Loansetup.Next = 0;
        end;
    end;



    // procedure Fnloanssetup() loanType: Text
    // begin
    //     Loansetup.Reset;
    //     Loansetup.SETRANGE(Source, Loansetup.Source::BOSA);
    //     // Loansetup.SetRange(Loansetup."Loan Calculator", true);
    //     if Loansetup.Find('-') then begin
    //         //loanType:='';
    //         repeat
    //             loanType := Format(Loansetup.Code) + ':' + Loansetup."Product Description" + ':::' + loanType;
    //             loanType := loanType + Loansetup."Product Description" + '!!' + FORMAT(Loansetup."Repayment Method") + '!!' + FORMAT(Loansetup."Max. Loan Amount") + '!!' + FORMAT(Loansetup."Instalment Period") + '!!' + FORMAT(Loansetup."Interest rate") + '!!'
    //            + FORMAT(Loansetup."Repayment Frequency") + '??';
    //         until Loansetup.Next = 0;
    //     end;
    // end;

    // procedure Fnloanssetup(): Text
    // var
    //     loanType: Text;
    // begin
    //     loanType := '';
    //     Loansetup.Reset();
    //     Loansetup.SetRange(Source, Loansetup.Source::BOSA);

    //     if Loansetup.FindSet() then begin
    //         repeat
    //             loanType += Format(Loansetup.Code) + ':' +
    //                         Loansetup."Product Description" + ':::' +
    //                         Loansetup."Product Description" + '!!' +
    //                         Format(Loansetup."Repayment Method") + '!!' +
    //                         Format(Loansetup."Max. Loan Amount") + '!!' +
    //                         Format(Loansetup."Instalment Period") + '!!' +
    //                         Format(Loansetup."Interest rate") + '!!' +
    //                         Format(Loansetup."Repayment Frequency") + '??';
    //         until Loansetup.Next() = 0;
    //     end else begin
    //         loanType := 'No BOSA loan setups found.';
    //     end;

    //     exit(loanType);
    // end;


    procedure fnLoanDetails2(Loancode: Code[20]) loandetail: Text
    begin
        Loansetup.Reset;
        Loansetup.SETRANGE(Source, Loansetup.Source::BOSA);
        if Loansetup.Find('-') then begin
            repeat
                loandetail := loandetail + Loansetup."Product Description" + '!!' + Format(Loansetup."Repayment Method") + '!!' + Format(Loansetup."Max. Loan Amount") + '!!' + Format(Loansetup."Instalment Period") + '!!' + Format(Loansetup."Interest rate") + '!!'
                + Format(Loansetup."Repayment Frequency") + '??';
            until Loansetup.Next = 0;
        end;
    end;


    procedure fnFeedback(No: Code[20]; Subject: Text; Comment: Text[200]; Inquiry: Option)
    begin
        /*
         objMember.RESET;
         objMember.SETRANGE("No.", No);
         IF objMember.FIND('-') THEN BEGIN
          IF feedback.FIND('+') THEN
          feedback.Entry:=feedback.Entry+1
          ELSE
          feedback.Entry:=1;
          feedback.INIT;
          feedback.No:=No;
          feedback.Portalfeedback:=Comment;
          feedback.Inquiry:=Inquiry;
          feedback.DatePosted:=TODAY;
          feedback.INSERT(TRUE)
        
        
         END
         ELSE
         EXIT;
         */

    end;


    procedure fnLoansPurposes() LoanType: Text
    begin
        LoansPurpose.Reset;
        begin
            LoanType := '';
            repeat
                LoanType := Format(LoansPurpose.Code) + ':' + LoansPurpose.Description + ':::' + LoanType;
            until LoansPurpose.Next = 0;
        end;
    end;


    procedure fnReplys(No: Code[20]) text: Text
    begin
        feedback.Reset;
        feedback.SetRange(No, No);
        feedback.SetCurrentkey(Entry);
        feedback.Ascending(false);
        if feedback.Find('-') then begin
            repeat
                if (feedback.Reply = '') then begin

                end else
                    text := text + Format(feedback.DatePosted) + '!!' + feedback.Portalfeedback + '!!' + feedback.Reply + '??';
            until feedback.Next = 0;
        end;
    end;


    procedure FnNotifications("Member No": Code[10]; path: Text) text: Text
    var
        Filename: Text[100];
    begin
    end;


    procedure fnGuarantorsPortal(Member: Code[40]; Number: Code[40]; LoanNo: Code[40]; Message: Text[100])
    begin
        objMember.Reset;
        objMember.SetRange("No.", Member);
        if objMember.Find('-') then begin
            if feedback.Find('+') then
                feedback.Entry := feedback.Entry + 1
            else
                feedback.Entry := 1;
            feedback.No := Member;
            feedback.LoanNo := LoanNo;
            // feedback.Portalfeedback:=Message;
            feedback.DatePosted := Today;
            feedback.Guarantor := Number;

            //feedback.LoanNo:=objLoanRegister."Loan  No.";
            feedback.Accepted := 0;
            feedback.Rejected := 0;
            feedback.Insert(true)


        end
        else
            exit;
    end;


    procedure FnApproveGurarantors(Approval: Integer; Number: Code[40]; LoanNo: Integer; reply: Text; Amount: Decimal)
    begin
        feedback.Init;
        if (Approval = 0) then begin
            feedback.SetRange(Entry, LoanNo);
            feedback.SetRange(Guarantor, Number);
            if feedback.Find('-') then begin


                feedback.Accepted := 0;
                feedback.Rejected := 1;
                feedback.Modify;
            end;
        end

        else
            if Approval = 1 then begin
                feedback.Reset;

                feedback.SetRange(Entry, LoanNo);
                feedback.SetRange(Guarantor, Number);
                if feedback.Find('-') then begin


                    feedback.Accepted := 1;
                    feedback.Rejected := 0;
                    feedback.Amount := Amount;
                    objMember.SetRange("No.", Number);
                    if objMember.Find('-') then
                        reply := objMember.Name + ' ' + 'Has accepted to quarantee your loan';

                    objLoanRegister.Reset;
                    objLoanRegister.SetRange("Loan  No.", feedback.LoanNo);
                    Message(feedback.LoanNo);
                    if objLoanRegister.Find('-') then
                        reply := reply + 'of amount ' + Format(objLoanRegister."Requested Amount");
                    LoansGuaranteeDetails.Init;
                    LoansGuaranteeDetails.CalcFields("Loanees  No");

                    LoansGuaranteeDetails."Member No" := Number;
                    LoansGuaranteeDetails.Validate("Member No");
                    LoansGuaranteeDetails.Validate("Substituted Guarantor");
                    LoansGuaranteeDetails."Loan No" := feedback.LoanNo;
                    LoansGuaranteeDetails.Validate("Loan No");
                    LoansGuaranteeDetails."Amont Guaranteed" := Amount;
                    LoansGuaranteeDetails.Validate("Amont Guaranteed");
                    PortaLuPS.SetRange(LaonNo, feedback.LoanNo);
                    if PortaLuPS.Find('-') then begin
                        // PortaLuPS.INIT;
                        PortaLuPS.TotalGuaranteed := PortaLuPS.TotalGuaranteed + Amount;
                        PortaLuPS.Modify;

                        //LoansGuaranteeDetails.VALIDATE("Amont Guaranteed");
                        //LoansGuaranteeDetails."Loanees  No":=feedback.No;

                        //LoansGuaranteeDetails.VALIDATE("Loanees  No");
                        feedback.Reply := reply;
                        feedback.Modify;
                        LoansGuaranteeDetails.Insert;
                    end;
                end;
            end;
    end;


    procedure FNAppraisalLoans(Member: Code[10]) loans: Text
    begin
        objLoanRegister.Reset;
        objLoanRegister.SetRange("Client Code", Member);
        if objLoanRegister.Find('-') then begin
            objLoanRegister.SetCurrentkey("Application Date");

            // objLoanRegister.ASCENDING(FALSE);
            objLoanRegister.SetFilter("Loan Status", '=%1', objLoanRegister."loan status"::Application);
            objLoanRegister.SetFilter("Requested Amount", '>%1', 0);
            // objLoanRegister."Loan Status"::Appraisal;
            repeat
                objLoanRegister.CalcFields("Total Loans Outstanding");
                loans := loans + objLoanRegister."Loan  No." + ':' + objLoanRegister."Loan Product Type" + ':' + Format(objLoanRegister."Requested Amount") + '::';
            until
              objLoanRegister.Next = 0;
        end;
    end;

    procedure FnEditableLoans(MemberNo: Code[10]; Loan: Code[20]) Edit: Text
    var
        Loantpe: Text;
        Loanpurpose: Text;
    begin
        LoansGuaranteeDetails.Reset;
        LoansGuaranteeDetails.SetRange("Member No", MemberNo);
        LoansGuaranteeDetails.SetRange("Loan No", Loan);

        if LoansGuaranteeDetails.Find('-') then begin
            repeat
                Edit := Edit + LoansGuaranteeDetails."Loan No" + LoansGuaranteeDetails."Loanees  Name" + Format(LoansGuaranteeDetails."Amont Guaranteed");
            until LoansGuaranteeDetails.Next = 0;

        end;
    end;


    procedure fnedtitloan(Amount: Decimal; Loan: Code[20]; Repaymperiod: Integer; LoanPurpose: Code[20]; LoanType: Code[20])
    begin
        objLoanRegister.Reset;
        //objLoanRegister.SETRANGE("Client Code", Member);
        objLoanRegister.SetRange("Loan  No.", Loan);
        if objLoanRegister.Find('-') then begin
            objLoanRegister.Init;
            objLoanRegister."Requested Amount" := Amount;
            objLoanRegister.Validate("Requested Amount");
            objLoanRegister.Installments := Repaymperiod;
            // objLoanRegister.VALIDATE(Installments);
            objLoanRegister."Loan Product Type" := LoanType;
            objLoanRegister.Validate("Loan Product Type");
            objLoanRegister."Loan Purpose" := LoanPurpose;
            objLoanRegister.Validate("Loan Purpose");
            objLoanRegister.Modify;
        end;
    end;


    procedure FnApprovedGuarantors(Member: Code[40]; Loan: Code[40]) Guarantee: Text
    begin
        feedback.Reset;
        feedback.SetRange(No, Member);
        feedback.SetRange(Accepted, 1);
        feedback.SetRange(Rejected, 0);
        feedback.SetRange(LoanNo, Loan);

        if feedback.Find('-') then begin

            repeat
                objMember.SetRange("No.", feedback.Guarantor);
                if objMember.Find('-') then
                    FAccNo := objMember.Name;
                phoneNumber := objMember."Phone No.";
                objLoanRegister.SetRange("Loan  No.", feedback.LoanNo);
                if objLoanRegister.Find('-') then
                    Amount := objLoanRegister."Requested Amount";
                Guarantee := Guarantee + Format(feedback.Entry) + ':' + FAccNo + ':' + Format(phoneNumber) + '>>' + ':' + Format(feedback.Amount) + '::';

            until feedback.Next = 0;
        end;
    end;


    procedure FnPendingGuarantors(Member: Code[40]; Loan: Code[40]) Guarantee: Text
    begin
        feedback.Reset;
        feedback.SetRange(No, Member);
        feedback.SetRange(Accepted, 1);
        feedback.SetRange(Rejected, 0);
        feedback.SetRange(LoanNo, Loan);

        if feedback.Find('-') then begin

            repeat
                objMember.SetRange("No.", feedback.Guarantor);
                if objMember.Find('-') then
                    FAccNo := objMember.Name;
                phoneNumber := objMember."Phone No.";
                objLoanRegister.SetRange("Loan  No.", feedback.LoanNo);
                if objLoanRegister.Find('-') then
                    Amount := objLoanRegister."Requested Amount";
                Guarantee := Guarantee + Format(feedback.Entry) + ':' + FAccNo + ':' + Format(phoneNumber) + '>>' + ':' + Format(Amount) + '::';

            until feedback.Next = 0;
        end;
    end;


    procedure FnrejectedGuarantors(Member: Code[40]; Loan: Code[40]) Guarantee: Text
    begin
        feedback.Reset;
        feedback.SetRange(No, Member);
        feedback.SetRange(Accepted, 0);
        feedback.SetRange(Rejected, 1);
        feedback.SetRange(LoanNo, Loan);

        if feedback.Find('-') then begin

            repeat
                objMember.SetRange("No.", feedback.Guarantor);
                if objMember.Find('-') then
                    FAccNo := objMember.Name;
                phoneNumber := objMember."Phone No.";
                objLoanRegister.SetRange("Loan  No.", feedback.LoanNo);
                if objLoanRegister.Find('-') then
                    Amount := objLoanRegister."Requested Amount";
                Guarantee := Guarantee + Format(feedback.Entry) + ':' + FAccNo + ':' + Format(phoneNumber) + '>>' + '::';

            until feedback.Next = 0;
        end;
    end;


    procedure FnApplytoAppraise(LoanNo: Code[20])
    begin
        objLoanRegister.Reset;
        objLoanRegister.SetRange("Loan  No.", LoanNo);
        if objLoanRegister.Find('-') then begin
            // objLoanRegister.INIT;
            objLoanRegister."Loan Status" := objLoanRegister."loan status"::Appraisal;
            objLoanRegister.Modify;
        end;
    end;


    procedure fnTotalLoanAm(Loan: Code[10]) amount: Decimal
    begin
        PortaLuPS.Reset;
        PortaLuPS.SetRange(LaonNo, Loan);
        if PortaLuPS.Find('-') then begin
            amount := (PortaLuPS.RequestedAmount - PortaLuPS.TotalGuaranteed);

        end;
    end;


    procedure Fnquestionaire(Member: Code[20]; reason: Text; time: Text; Leastimpressed: Text; Mostimpressed: Text; suggestion: Text; accounts: Option; customercare: Option; atmosphere: Option; serveby: Text)
    begin
        Questinnaires.Init;
        if Questinnaires.Find('+') then
            Questinnaires.Entry := Questinnaires.Entry + 1

        else
            //Questinnaires.INSERT;
            Questinnaires.Entry := 1;
        Questinnaires.Member := Member;
        Questinnaires.ReasonForVisit := reason;
        Questinnaires.LeastImpressedWIth := Leastimpressed;
        Questinnaires.MostImpressedwith := Mostimpressed;
        Questinnaires.Suggestions := suggestion;
        Questinnaires.Accounts := accounts;
        Questinnaires.Customercare := customercare;
        Questinnaires.OfficeAtmosphere := atmosphere;
        Questinnaires.ServedBy := serveby;
        Questinnaires.Insert;
    end;

    procedure FnSendFeedback(MemberNo: Code[20]; Body: Text) Sent: Boolean
    var
    // smtpsetup: Record "O365 Email Setup";
    // smtp: Codeunit smtp mail
    begin
        Sent := FALSE;
        Questinnaires.Init;
        if Questinnaires.Find('+') then
            Questinnaires.Entry := Questinnaires.Entry + 1

        else
            Questinnaires.Entry := 1;
        Questinnaires.Member := MemberNo;
        Questinnaires.Suggestions := Body;
        Questinnaires.Insert;
        Sent := TRUE;
        EXIT(Sent);


    end;

    procedure FnLoanfo(MemberNo: Code[20]) dividend: Text
    begin
        DivProg.Reset;
        DivProg.SetRange("Member No", MemberNo);
        if DivProg.Find('-') then begin
            repeat
                dividend := dividend + Format(DivProg.Date) + ':::' + Format(DivProg."Gross Dividends") + ':::' + Format(DivProg."Witholding Tax") + ':::' + Format(DivProg."Net Dividends") + ':::' + Format(DivProg."Qualifying Shares") + ':::'
                + Format(DivProg.Shares) + '::::';
            until DivProg.Next = 0;
        end;
    end;

    procedure fnGetFosaAccounts(BosaNo: Code[20]) fosas: Text
    begin
        /*
        objMember.RESET;
        objMember.SETRANGE("No.",BosaNo);
        IF objMember.FIND('-') THEN BEGIN
        */

        Vendor.Reset;
        Vendor.SetRange("BOSA Account No", BosaNo);
        Vendor.SetRange("Creditor Type", Vendor."creditor type"::Account);
        //Vendor.SETFILTER("Account Type",'501|502|503|504|505|506|507|508|509');
        if Vendor.Find('-') then begin
            repeat
                fosas := fosas + Vendor."No." + '>' + Vendor."Account Type" + ':::';
            until Vendor.Next = 0;
        end;
        //  END;
    end;

    procedure fnGetNextofkin(MemberNumber: Code[20]) return: Text
    begin
        objNextKin.Reset;
        objNextKin.SetRange("Account No", MemberNumber);
        if objNextKin.Find('-') then begin
            repeat
                return := return + objNextKin."Name" + ':::' + objNextKin.Relationship + ':::' + objNextKin.Email + ':::' + Format(objNextKin."%Allocation") + '::::';
            until objNextKin.Next = 0;
        end;
    end;


    procedure FNFosaBalance(Acc: Code[30]) Bal: Text[1024]
    var
        AccountTypes: Record "Account Types-Saving Products";
        miniBalance: Decimal;
        accBalance: Decimal;
    begin

        accBalance := 0;
        Vendor.Reset;
        Vendor.SetRange(Vendor."No.", Acc);
        if Vendor.Find('-') then begin
            repeat
                AccountTypes.Reset;
                AccountTypes.SetRange(AccountTypes.Code, Vendor."Account Type");
                if AccountTypes.Find('-') then begin
                    miniBalance := AccountTypes."Minimum Balance";
                end;
                Vendor.CalcFields(Vendor."Balance (LCY)");
                Vendor.CalcFields(Vendor."ATM Transactions");
                Vendor.CalcFields(Vendor."Uncleared Cheques");
                Vendor.CalcFields(Vendor."EFT Transactions");
                accBalance := accBalance + (Vendor."Balance (LCY)" - (Vendor."ATM Transactions" + Vendor."Uncleared Cheques" + Vendor."EFT Transactions" + miniBalance));
                Bal := Format(accBalance);
            until Vendor.Next = 0;
        end;
    end;


    procedure FnAuditTrail(MemberNo: Code[30]; Accessed: Text)
    var
        ObjLog: Record "Portal Logs";
        ObjMember: Record 18;//customer;
    begin
        ObjLog.Reset;
        ObjLog.Init;
        ObjLog."Member No" := MemberNo;
        ObjLog.Date := Today;
        ObjLog.Time := Time;
        ObjLog."Accessed Page" := Accessed;
        ObjMember.Reset;
        if ObjMember.Get(MemberNo) then begin
            ObjLog."Member Name" := ObjMember.Name;
        end;
        ObjLog.Insert;
    end;


    procedure OnlineLoanApplication(BosaNo: Code[30]; LoanType: Code[100]; LoanAmount: Decimal; loanpurpose: Text; repaymentPeriod: Integer) GeneratedApplicationNo: Code[100]
    var
        ObjLoanApplications: Record "Online Loan Application";
    begin
        ObjLoanApplications.Reset;

        //LoanProductType.Get(LoanType);

        objMember.Reset;
        objMember.SetRange(objMember."No.", BosaNo);
        if objMember.Find('-') then begin
            objMember.CalcFields(objMember."Current Shares");

            if not LoanProductType.Get(LoanType) then
                Error('Loan Product %1 does not exist in the system', LoanType);

            // Now validate safely
            if (LoanType = 'KIVUK') or (LoanType = 'HALL') or (LoanType = 'INST') then begin
                if LoanAmount > LoanProductType."Max. Loan Amount" then
                    Error('Amount Requested exceeds the maximum allowed limit of %1 for %2 product',
                        LoanProductType."Max. Loan Amount",
                        LoanProductType."Product Description");
            end else begin
                if LoanAmount > (objMember."Current Shares" * 3) then
                    Error('Amount Requested of %1 exceeds your loan eligibility of %2',
                        LoanAmount,
                        objMember."Current Shares" * 3);
            end;


            // ObjLoanApplications."Application No" := NewApplicationNo;
            ObjLoanApplications."Application Date" := Date;
            ObjLoanApplications."Id No" := objMember."ID No.";
            ObjLoanApplications."BOSA No" := objMember."No.";
            ObjLoanApplications."Employment No" := objMember."Payroll/Staff No";
            ObjLoanApplications."Member Names" := objMember.Name;
            ObjLoanApplications.Email := objMember."E-Mail";
            ObjLoanApplications."Date of Birth" := objMember."Date of Birth";
            ObjLoanApplications."Membership No" := objMember."No.";
            ObjLoanApplications.Telephone := objMember."Mobile Phone No";
            ObjLoanApplications."Loan Type" := LoanType;
            ObjLoanApplications.Validate("BOSA No");
            ObjLoanApplications.Validate("Loan Type");
            ObjLoanApplications."Home Address" := objMember.Address;
            ObjLoanApplications.Station := objMember."Station/Department";
            ObjLoanApplications."Loan Amount" := LoanAmount;
            ObjLoanApplications."Repayment Period" := repaymentPeriod;
            ObjLoanApplications.Source := LoanProductType.Source;
            ObjLoanApplications."Interest Rate" := LoanProductType."Interest rate";
            // ObjLoanApplications."Min No Of Guarantors" := LoanProductType."Min No. Of Guarantors";
            ObjLoanApplications."Loan Purpose" := loanpurpose;
            ObjLoanApplications."Sent To Bosa Loans" := false;
            ObjLoanApplications.submitted := false;
            ObjLoanApplications."Application Status" := ObjLoanApplications."Application Status"::Application;
            ObjLoanApplications.Posted := false;
            ObjLoanApplications.Refno := '0';
            ObjLoanApplications."Loan No" := '0';
            //objLoanApplications."Payment Mode" :=disbursementMode;
            ObjLoanApplications.Insert(true);

            GeneratedApplicationNo := ObjLoanApplications."Application No";
        end;
    end;


    procedure SubmitLoan(memberNumber: Code[20]; loanNumber: Code[20]): Text
    var
        response: Text;
        localsms: Text[1000];
        ObjOnlineLoandToOffset: Record "Online Loan Offset Details";
        ObjLoansToOffset: Record "Loan Offset Details";
        OffsetLoan: Record "Loans Register";
        EmailMessage: Codeunit "Email Message";
        EmailSender: Codeunit Email;

    begin
        if objMember.Get(memberNumber) then begin
            ObjLoanApplications.Reset;
            ObjLoanApplications.SetRange("Application No", loanNumber);
            ObjLoanApplications.SetRange("BOSA No", memberNumber);

            if ObjLoanApplications.Find('-') then begin
                if ObjLoanApplications."Application Status" <> ObjLoanApplications."Application Status"::Application then begin
                    response := 'Failed, This loan has already been submitted';
                    exit;
                end;
                //sending tp loan Register
                SalesSetup.Get();


                ObjLoansregister.LockTable();

                ObjLoansregister.Init();
                ObjLoansregister."Loan  No." := NoSeriesMgt.GetNextNo(SalesSetup."BOSA Loans Nos", Today, true);

                // ObjLoansregister."BOSA No" := ObjLoanApplications."BOSA No";
                ObjLoansregister.Source := ObjLoansregister.Source::BOSA;

                ObjLoansregister.Validate("Client Code", ObjLoanApplications."BOSA No");
                //ObjLoansregister."Client Name" := ObjLoanApplications."Member Names";

                ObjLoansregister."Application Date" := ObjLoanApplications."Application Date";
                ObjLoansregister.Validate("Loan Product Type", ObjLoanApplications."Loan Type");
                ObjLoansregister."Loan Status" := ObjLoansregister."Loan Status"::Application;
                // ObjLoansregister.Validate(ObjLoansregister."BOSA No");
                //ObjLoansregister.Validate(ObjLoansregister."Loan Product Type");


                ObjLoansregister.Installments := ObjLoanApplications."Repayment Period";
                ObjLoansregister.Validate("Requested Amount", ObjLoanApplications."Loan Amount");
                ObjLoansregister."Captured By" := UserId;
                if ObjLoansregister.Insert() then begin
                    //  ObjLoansregister.Insert();

                    ObjLoanApplications."Sent To Bosa Loans" := true;
                    ObjLoanApplications.Posted := true;
                    ObjLoanApplications.Submitted := true;
                    ObjLoanApplications."Application Status" := ObjLoanApplications."Application Status"::Submitted;
                    ObjLoanApplications.Modify();

                    ObjOnlineLoandToOffset.Reset();
                    ObjOnlineLoandToOffset.SetRange("Loan No.", loanNumber);
                    ObjOnlineLoandToOffset.SetRange(Submitted, false);

                    If ObjOnlineLoandToOffset.FindSet() then begin  // ← was missing
                        repeat
                            ObjLoansToOffset.Reset();  // ← reset before setting filters
                            ObjLoansToOffset.SetRange("Loan No.", ObjLoansregister."Loan  No.");
                            ObjLoansToOffset.SetRange("Loan Top Up", ObjOnlineLoandToOffset."Loan Top Up");

                            if not ObjLoansToOffset.FindFirst() then begin
                                ObjLoansToOffset.INIT();
                                ObjLoansToOffset."Loan No." := ObjLoansregister."Loan  No.";
                                ObjLoansToOffset."Client Code" := ObjOnlineLoandToOffset."Client Code";
                                ObjLoansToOffset."Loan Top Up" := ObjOnlineLoandToOffset."Loan Top Up";
                                ObjLoansToOffset."Principle Top Up" := ObjOnlineLoandToOffset."Principle Top Up";
                                ObjLoansToOffset."Loan Type" := ObjOnlineLoandToOffset."Loan Type";

                                OffsetLoan.Reset();
                                OffsetLoan.SetRange("Loan  No.", ObjOnlineLoandToOffset."Loan Top Up");
                                if OffsetLoan.Find('-') then begin
                                    OffsetLoan.CalcFields("Outstanding Balance", "Oustanding Interest");
                                    ObjLoansToOffset."Interest Rate" := OffsetLoan.Interest;
                                    ObjLoansToOffset."Interest Top Up" := OffsetLoan."Oustanding Interest";
                                    ObjLoansToOffset."Total Top Up" := ObjLoansToOffset."Principle Top Up" + ObjLoansToOffset."Interest Top Up";
                                    ObjLoansToOffset."Outstanding Balance" := OffsetLoan."Outstanding Balance";
                                    ObjLoansToOffset."Monthly Repayment" := OffsetLoan.Repayment;
                                    OffsetLoan.Bridged := true;
                                    OffsetLoan.Modify();
                                end;

                                ObjLoansToOffset.ImportGuarantors(
                                    ObjOnlineLoandToOffset."Loan Top Up",
                                    ObjLoansregister."Loan  No."
                                );

                                ObjLoansToOffset.Insert(TRUE);
                                ObjOnlineLoandToOffset.Submitted := true;
                                ObjOnlineLoandToOffset.Modify();
                            end;
                        until ObjOnlineLoandToOffset.Next() = 0;
                    end;

                    //Submitt Guarantors
                    OnlineLoanGuarantors.Reset();
                    OnlineLoanGuarantors.SetRange(OnlineLoanGuarantors."Loan Application No", loanNumber);
                    OnlineLoanGuarantors.SetRange(OnlineLoanGuarantors.Approved, OnlineLoanGuarantors.Approved::Approved);
                    if OnlineLoanGuarantors.FindSet() then begin
                        repeat
                            submitGuarantors(OnlineLoanGuarantors, ObjLoansregister."Loan  No.");
                        until OnlineLoanGuarantors.Next = 0;
                    end;
                    localsms := 'Dear Member, you have submitted Loan No. ' + Format(ObjLoanApplications."Application No") + ' for loan type ' + ObjLoanApplications."Loan Type" + ' your  loan application for appraisal.';
                    if (objMember."Phone No." <> '') then
                        FnSMSMessage(ClientName, objMember."Phone No.", localsms);
                    if objMember."E-Mail" <> '' then begin

                        EmailMessage.Create(
                            objMember."E-Mail",
                            'Loan Submitted',
                            localsms,
                            false
                        );

                        EmailSender.Send(EmailMessage);
                    end;
                    response := 'Success, your loan has been submitted to Credit for Appraisal';
                    exit(response);
                end else begin
                    response := 'Failed, Please contact the office for assistance';
                    exit(response);
                end;



                response := 'Success, loan submitted';
                exit(response);
            end else
                response := 'Failed, loan not found';
        end else
            response := 'Failed, member not found';
    end;


    procedure OnlineLoanRefinancing(BosaNo: Code[60]; LoanNo: Code[20]; LoanTopUpNo: Code[20]; LoanType: Code[30]; Amount: Decimal): Boolean

    var
        //LoanOffsetDetails: Record "Loan Offset Details";
        TrueOrFalse: Boolean;
        OnlineLoanOffsetDetails: Record "Online Loan Offset Details";
    BEGIN

        TrueOrFalse := False;



        OnlineLoanOffsetDetails.Init();
        OnlineLoanOffsetDetails."Loan No." := LoanNo;
        OnlineLoanOffsetDetails."Client Code" := BosaNo;
        OnlineLoanOffsetDetails."Loan Top Up" := LoanTopUpNo;
        OnlineLoanOffsetDetails."Loan Type" := LoanType;
        OnlineLoanOffsetDetails."Principle Top Up" := Amount;

        if (OnlineLoanOffsetDetails.Insert(TRUE)) then begin

            TrueOrFalse := true;
            exit(TrueOrFalse);
        end else begin
            exit(TrueOrFalse);
        end;
    END;

    procedure GetMemberExistingLoans(BosaNo: Code[60]): Text
    var
        LoansRegisterRec: Record "Loans Register";
        Result: Text;
        InterestRate: Decimal;
    begin
        Result := '';

        LoansRegisterRec.Reset();
        LoansRegisterRec.SetRange("Client Code", BosaNo);

        if LoansRegisterRec.FindSet() then begin
            repeat
                LoansRegisterRec.CalcFields("Outstanding Balance");

                if LoansRegisterRec."Outstanding Balance" > 0 then begin
                    Result +=
                    'LoanNo:' + Format(LoansRegisterRec."Loan  No.") + '!!' +
                    'ProductName:' + LoansRegisterRec."Loan Product Type Name" + '!!' +
                    'ProductCode:' + LoansRegisterRec."Loan Product Type" + '!!' +
                    'Outstanding:' + Format(LoansRegisterRec."Outstanding Balance") + '!!' +
                    'ArrearsAmt:' + Format(LoansRegisterRec."Amount In Arrears") + '!!' +
                    'ArrearsDays:' + Format(LoansRegisterRec."Days In Arrears") + '!!' +
                    'IssueDate:' + Format(LoansRegisterRec."Issued Date") + '!!' +
                    'ExpectedCompletion:' + Format(LoansRegisterRec."Expected Date of Completion") +
                    '??';
                end;

            until LoansRegisterRec.Next() = 0;
        end;

        exit(Result);
    end;



    procedure FnActiveMembers() responseText: Text

    var
        ActiveMembers: Record "Customer";
        customersText: Text;

    begin

        ActiveMembers.Reset;
        ActiveMembers.SetRange("Status", 0);
        if ActiveMembers.FindFirst then begin
            repeat
                if customersText = '' then begin
                    customersText := '{'
                                        + '"MemberNo":"' + FORMAT(ActiveMembers."No.") + '"'
                                        + ',"MemberName":"' + ActiveMembers.Name + '"'
                                        + '}';
                end else begin
                    customersText := customersText + ',{'
                                                            + '"MemberNo":"' + FORMAT(ActiveMembers."No.") + '"'
                                                            + ',"MemberName":"' + ActiveMembers.Name + '"'
                                                            + '}';
                end;
            until ActiveMembers.Next = 0;

        end;
        IF customersText <> '' THEN BEGIN
            responseText := '{ "StatusCode":"200","StatusDescription":"OK","OnlineGuarantors":[' + customersText + '] }';
        END ELSE BEGIN
            responseText := '{ "StatusCode":"400","StatusDescription":"No Members","ActiveMembers":[] }';
        END;


    end;


    procedure FnRequestGuarantorship(BosaNo: Code[30]; LoanNumber: Code[20]) guaranteed: Boolean
    var
        EmailMessage: Codeunit "Email Message";
        EmailSender: Codeunit Email;
    begin
        guaranteed := false;
        ObjLoanApplications.Reset;
        ObjLoanApplications.SetRange("Application No", LoanNumber);
        if ObjLoanApplications.Find('-') then begin
            OnlineLoanGuarantors.Reset;
            if OnlineLoanGuarantors.FindLast then
                NewApplicationNumber := OnlineLoanGuarantors."Entry No" + 1
            else
                NewApplicationNumber := 1;
            //create in online gurantors table
            objMember.Reset;
            objMember.SetRange(objMember."No.", BosaNo);
            objMember.SetFilter(Status, '%1', objMember.Status::Active);
            Message('test1');
            if objMember.Find('-') then begin
                OnlineLoanGuarantors.Init;
                OnlineLoanGuarantors."Entry No" := NewApplicationNumber;
                OnlineLoanGuarantors."Loan Application No" := LoanNumber;
                OnlineLoanGuarantors."Member No" := objMember."No.";
                OnlineLoanGuarantors.Names := objMember.Name;
                // OnlineLoanGuarantors.Amount := Amount;
                OnlineLoanGuarantors."Email Address" := objMember."E-Mail";
                OnlineLoanGuarantors."ID No" := objMember."ID No.";
                OnlineLoanGuarantors.Telephone := objMember."Mobile Phone No";
                OnlineLoanGuarantors.ApplicantNo := ObjLoanApplications."BOSA No";
                OnlineLoanGuarantors.ApplicantName := ObjLoanApplications."Member Names";
                OnlineLoanGuarantors."Applicant Mobile" := ObjLoanApplications.Telephone;
                OnlineLoanGuarantors.Approved := OnlineLoanGuarantors.Approved::Pending;
                OnlineLoanGuarantors."Approval Status" := false;
                OnlineLoanGuarantors.Insert;
                guaranteed := true;
                Message('test3');

                ObjLoanApplications.Get(LoanNumber);
                //send sms to guarantor
                ReturnList := 'Dear Member, ' + ObjLoanApplications."Member Names" + ' has requested loan Guarantorship,' + 'of.' + Format(Amount) + 'Kindly login to the portal to accept or reject the request';
                // SMSMessage('PORTALTRAN',FAccNo,objMember."Phone No.",ReturnList);
                FnSMSMessage('PORTAL', objMember."Mobile Phone No", ReturnList);
                if objMember."E-Mail" <> '' then begin

                    EmailMessage.Create(
                        objMember."E-Mail",
                        'Loan Guarantorship Request',
                        ReturnList,
                        false
                    );

                    EmailSender.Send(EmailMessage);
                end;

            end;

        end;
    end;



    procedure GuaranteeingPower(idNo: Code[30]; MemberNo: Code[30]; LoanType: Code[30]) GPower: Boolean
    begin
    end;


    procedure GuaranteeLoan(LoanNo: Integer; MemberNo: Text): Text
    begin
        // OnlineLoanGuarantors.Reset;
        // OnlineLoanGuarantors.SetRange(OnlineLoanGuarantors."Loan Application No", LoanNo);
        // OnlineLoanGuarantors.SetRange(OnlineLoanGuarantors."Member No", MemberNo);
        // if OnlineLoanGuarantors.Find('-') then begin
        //     OnlineLoanGuarantors.Approved := OnlineLoanGuarantors.Approved::Rejected;
        //     OnlineLoanGuarantors."Approval Status" := true;
        //     OnlineLoanGuarantors.Modify;

        //     //send sms/email to loanee
        //     objMember.Get(OnlineLoanGuarantors.ApplicantNo);
        //     if OnlineLoanGuarantors.Approved = OnlineLoanGuarantors.Approved::Rejected then
        //         ReturnList := 'Dear Member, your loan guarantorship have been rejected. Login to member portal for details';
        //     //SMSMessage('PORTALTRAN',FAccNo,objMember."Phone No.",ReturnList);
        //     FnSMSMessage('PORTAL', objMember."Mobile Phone No", ReturnList);
        //     //send sms/email to guarantor
        //     objMember.Get(MemberNo);
        //     if OnlineLoanGuarantors.Approved = OnlineLoanGuarantors.Approved::Rejected then
        //         ReturnList := 'Dear Member, you have rejected loan Guarantorship.';
        //     //SMSMessage('PORTALTRAN',FAccNo,objMember."Phone No.",ReturnList);
        //     FnSMSMessage('PORTAL', objMember."Mobile Phone No", ReturnList);
        // end;

    end;


    procedure ApproveGuarantorship(MemberNo: Text; LoanNo: Code[20]; ApprovedStatus: Integer) response: text;
    var
        LoanApplicant: Record Customer; // Assuming your member table
        LoanApplication: Record "Online Loan Application";
        objMember: Record Customer;
        AllApproved: Boolean;
        localSMS: Text;
        EmailMessage: Codeunit "Email Message";
        EmailSender: Codeunit Email;
    begin

        if (MemberNo = '') or (LoanNo = '') then begin
            response := 'Failed, Member number or Loan number is missing';
            exit;
        end;

        response := 'Failed, Please try again Later';

        OnlineLoanGuarantors.Reset;
        OnlineLoanGuarantors.SetRange("Loan Application No", LoanNo);
        OnlineLoanGuarantors.SetRange("Member No", MemberNo);

        if OnlineLoanGuarantors.Find('-') then begin
            if not objMember.Get(MemberNo) then
                Error('Member record not found.');

            if ApprovedStatus = 0 then begin
                // Approved
                OnlineLoanGuarantors.Approved := OnlineLoanGuarantors.Approved::Approved;
                OnlineLoanGuarantors."Approval Status" := true;
                OnlineLoanGuarantors.Modify;

                ReturnList := 'Dear Member, your loan guarantorship has been approved by ' + OnlineLoanGuarantors.Names + '. Login to the members portal to submit for appraisal.';
                FnSMSMessage('WebPortal', objMember."Mobile Phone No", ReturnList);
                if objMember."E-Mail" <> '' then begin

                    EmailMessage.Create(
                        objMember."E-Mail",
                        'Loan Guarantorship Approved',
                        ReturnList,
                        false
                    );

                    EmailSender.Send(EmailMessage);
                end;
            end else if ApprovedStatus = 1 then begin
                // Rejected
                OnlineLoanGuarantors.Approved := OnlineLoanGuarantors.Approved::Rejected;
                OnlineLoanGuarantors."Approval Status" := false;
                OnlineLoanGuarantors.Modify;

                ReturnList := 'Dear Member, the loan guarantorship request has been declined. Please choose another guarantor.';
                FnSMSMessage('WebPortal', objMember."Mobile Phone No", ReturnList);
                if objMember."E-Mail" <> '' then begin

                    EmailMessage.Create(
                        objMember."E-Mail",
                        'Loan Guarantorship Rejected',
                        ReturnList,
                        false
                    );

                    EmailSender.Send(EmailMessage);
                end;


                LoanApplication.Reset;
                LoanApplication.SetRange("Application No", LoanNo);
                if LoanApplication.Find('-') then begin
                    LoanApplicant.Reset;
                    LoanApplicant.SetRange("No.", LoanApplication."Membership No");
                    if LoanApplicant.Find('-') then begin
                        ReturnList := 'Dear Member, your loan guarantorship request has been rejected by ' + OnlineLoanGuarantors.Names + '. Please find another guarantor to proceed with your loan application.';
                        FnSMSMessage('WebPortal', LoanApplicant."Mobile Phone No", ReturnList);
                        if objMember."E-Mail" <> '' then begin

                            EmailMessage.Create(
                                objMember."E-Mail",
                                'Loan Guarantorship Rejected',
                                ReturnList,
                                false
                            );

                            EmailSender.Send(EmailMessage);
                        end;
                    end;
                end;
            end;

            OnlineLoanGuarantors.Reset();
            OnlineLoanGuarantors.SetRange("Loan Application No", LoanNo);
            OnlineLoanGuarantors.SetRange("Approval Status", false);

            AllApproved := not OnlineLoanGuarantors.FindFirst();

            if AllApproved then begin

                ObjLoanApplications.Reset;
                ObjLoanApplications.SetRange("Application No", LoanNo);

                if ObjLoanApplications.Find('-') then begin

                    ObjLoansregister.Reset();
                    ObjLoansregister.Init();

                    ObjLoansregister."BOSA No" := ObjLoanApplications."BOSA No";
                    ObjLoansregister.Source := ObjLoansregister.Source::BOSA;
                    SalesSetup.Get();
                    ObjLoansregister."Loan  No." := NoSeriesMgt.GetNextNo(SalesSetup."BOSA Loans Nos", Today, true);

                    ObjLoansregister."Client Code" := ObjLoanApplications."Membership No";
                    ObjLoansregister."Client Name" := ObjLoanApplications."Member Names";

                    ObjLoansregister."Application Date" := ObjLoanApplications."Application Date";
                    ObjLoansregister."Loan Product Type" := ObjLoanApplications."Loan Type";
                    ObjLoansregister."Loan Status" := ObjLoansregister."Loan Status"::Application;
                    ObjLoansregister.Validate(ObjLoansregister."BOSA No");
                    ObjLoansregister.Validate(ObjLoansregister."Loan Product Type");


                    ObjLoansregister.Installments := ObjLoanApplications."Repayment Period";
                    ObjLoansregister."Requested Amount" := ObjLoanApplications."Loan Amount";
                    if ObjLoansregister.Insert() then begin
                        ObjLoanApplications."Sent To Bosa Loans" := true;

                        ObjLoanApplications.Posted := true;
                        ObjLoanApplications.Modify;

                        //Submitt Guarantors
                        OnlineLoanGuarantors.Reset();
                        OnlineLoanGuarantors.SetRange(OnlineLoanGuarantors."Loan Application No", LoanNo);
                        OnlineLoanGuarantors.SetRange(OnlineLoanGuarantors.Approved, OnlineLoanGuarantors.Approved::Approved);
                        if OnlineLoanGuarantors.Find('-') then begin
                            repeat
                                submitGuarantors(OnlineLoanGuarantors, ObjLoansregister."Loan  No.");
                            until OnlineLoanGuarantors.Next = 0;
                        end;
                        localsms := 'Dear Member, you have submitted Loan No. ' + Format(ObjLoanApplications."Application No") + ' for loan type ' + ObjLoanApplications."Loan Type" + ' your  loan application for appraisal.';
                        if (objMember."Phone No." <> '') then
                            FnSMSMessage(ClientName, objMember."Phone No.", localsms);
                        if objMember."E-Mail" <> '' then begin

                            EmailMessage.Create(
                                objMember."E-Mail",
                                'Loan Submitted',
                                localsms,
                                false
                            );

                            EmailSender.Send(EmailMessage);
                        end;
                        response := 'Success, your loan has been submitted to Credit for Appraisal';
                    end else begin
                        response := 'Failed, Please contact the office for assistance';
                    end;


                end;
            end
        end;
    end;




    procedure FnGetLoanNo(No: Text; LoanType: Text) Text: Text
    begin
        /*ObjLoanApplications.RESET;
        ObjLoanApplications.SETRANGE("Membership No",No);
        ObjLoanApplications.SETRANGE("Loan Type",LoanType);
        IF objAtmapplication.FIND('-') THEN BEGIN
          Text:=
          END;*/

    end;


    procedure FnGetLoanTypeBalance(LoanType: Code[30]; MemberNo: Code[30]): Decimal
    begin
        ReturnDecimal := 0;

        objLoanRegister.Reset;
        objLoanRegister.SetRange(objLoanRegister."Loan Product Type", LoanType);
        objLoanRegister.SetRange(objLoanRegister."BOSA No", MemberNo);

        if objLoanRegister.Find('-') then begin
            repeat
                objLoanRegister.CalcFields(objLoanRegister."Outstanding Balance");
                // IF (Loan."Outstanding Balance" >0) THEN
                begin
                    ReturnDecimal := ReturnDecimal + objLoanRegister."Outstanding Balance";//+objLoanRegister.Interest;
                end

            until objLoanRegister.Next = 0;
        end;
        exit(ReturnDecimal)
    end;

    procedure GetLoanQualification(BosaNo: Code[30]; LoanProdType: Text): Decimal
    var
        Deposits: Decimal;
        DepositsM: Decimal;
        TotalLoans: Decimal;
    begin
        ReturnDecimal := 0;
        objMember.Reset;
        objMember.SetRange(objMember."No.", BosaNo);
        if objMember.Find('-') then begin
            if LoanProductType.Get(LoanProdType) then begin

                // Special products return Max Amount directly
                if (LoanProdType = 'KIVUK') or (LoanProdType = 'HALL') or (LoanProdType = 'INST') then begin
                    ReturnDecimal := LoanProductType."Max. Loan Amount";
                end else begin
                    // All other products calculate from deposits
                    Deposits := FnGetMemberTotalDeposits(BosaNo);
                    DepositsM := Deposits * LoanProductType."Deposits Multiplier";
                    TotalLoans := FnGetLoanBalance(BosaNo);
                    ReturnDecimal := DepositsM - TotalLoans;
                    if ReturnDecimal < 0 then ReturnDecimal := 0;
                end;

            end;
        end;
        exit(ReturnDecimal);
    end;
    // procedure GetLoanQualification(BosaNo: Code[30]; LoanProdType: Text): Decimal
    // var
    //     Deposits: Decimal;
    //     DepositsM: Decimal;
    //     GuaranteedT: Decimal;
    //     TotalLoans: Decimal;
    //     Multiplier: Decimal;
    // begin
    //     ReturnDecimal := 0;
    //     objMember.Reset;
    //     objMember.SetRange(objMember."No.", BosaNo);
    //     if objMember.Find('-') then begin

    //         if LoanProductType.Get(LoanProdType) then begin
    //             Message('test2 %1', LoanProdType);
    //             Deposits := FnGetMemberTotalDeposits(BosaNo);
    //             Message('test3 %1', Deposits);
    //             DepositsM := Deposits * LoanProductType."Deposits Multiplier";
    //             Message('test %4', DepositsM);
    //             TotalLoans := FnGetLoanBalance(BosaNo);
    //             Message('test %5', TotalLoans);
    //             ReturnDecimal := DepositsM - TotalLoans;
    //             Message('test%6', ReturnDecimal);
    //             if ReturnDecimal < 0 then ReturnDecimal := 0;
    //         end;
    //     end;
    //     exit(ReturnDecimal);
    // end;


    procedure FnGetMemberTotalDeposits(MemberNo: Code[30]): Decimal
    begin
        ReturnDecimal := 0;
        objMember.Reset;
        objMember.SetRange(objMember."No.", MemberNo);
        if objMember.Find('-') then begin
            objMember.CalcFields("Current Shares");
            ReturnDecimal := ReturnDecimal + Abs(objMember."Current Shares");
            Message('test%1', ReturnDecimal);
            exit(ReturnDecimal);
        end;
    end;


    procedure FnGetLoanBalance(MemberNo: Code[30]): Decimal
    begin
        ReturnDecimal := 0;
        objLoanRegister.Reset;
        objLoanRegister.SetRange(objLoanRegister."BOSA No", MemberNo);
        objLoanRegister.SetRange(objLoanRegister.Posted, true);
        if objLoanRegister.Find('-') then begin
            repeat
                objLoanRegister.CalcFields(objLoanRegister."Outstanding Balance");
                begin
                    ReturnDecimal := ReturnDecimal + objLoanRegister."Outstanding Balance";
                end

            until objLoanRegister.Next = 0;
        end;
        exit(ReturnDecimal);
    end;

    procedure FnGetGuarantors(LoanNo: Code[20]; memberNumber: Code[20]) responseText: Text
    var
        OnlineLoanGuarantors: Record "Online Loan Guarantors";
        guarantorsText: Text;
    begin
        guarantorsText := '';
        OnlineLoanGuarantors.Reset;
        OnlineLoanGuarantors.SetRange("Loan Application No", LoanNo);
        // OnlineLoanGuarantors.SetRange(OnlineLoanGuarantors.ApplicantNo, memberNumber);
        if OnlineLoanGuarantors.FindFirst then begin
            repeat
                if guarantorsText = '' then begin
                    guarantorsText := '{'
                                        + '"AccountNo":"' + FORMAT(OnlineLoanGuarantors."Member No") + '"'
                                        + ',"AmountGuaranteed":"' + FORMAT(OnlineLoanGuarantors.Amount) + '"'
                                        + ',"GuarantorName":"' + OnlineLoanGuarantors.Names + '"'
                                        + ',"IdNumber":"' + FORMAT(OnlineLoanGuarantors."ID No") + '"'
                                        + ',"EmailAddress":"' + FORMAT(OnlineLoanGuarantors."Email Address") + '"'
                                        + ',"Telephone":"' + FORMAT(OnlineLoanGuarantors.Telephone) + '"'
                                        + ',"ApprovalStatus":"' + FORMAT(OnlineLoanGuarantors."Approval Status") + '"'
                                        + '}';
                end else begin
                    guarantorsText := guarantorsText + ',{'
                                                            + '"AccountNo":"' + FORMAT(OnlineLoanGuarantors."Member No") + '"'
                                                            + ',"AmountGuaranteed":"' + FORMAT(OnlineLoanGuarantors.Amount) + '"'
                                                            + ',"GuarantorName":"' + OnlineLoanGuarantors.Names + '"'
                                                            + ',"IdNumber":"' + FORMAT(OnlineLoanGuarantors."ID No") + '"'
                                                            + ',"EmailAddress":"' + FORMAT(OnlineLoanGuarantors."Email Address") + '"'
                                                            + ',"Telephone":"' + FORMAT(OnlineLoanGuarantors.Telephone) + '"'
                                                            + ',"ApprovalStatus":"' + FORMAT(OnlineLoanGuarantors."Approval Status") + '"'
                                                            + '}';
                end;
            until OnlineLoanGuarantors.Next = 0;

        end;
        IF guarantorsText <> '' THEN BEGIN
            responseText := '{ "StatusCode":"200","StatusDescription":"OK","OnlineGuarantors":[' + guarantorsText + '] }';
        END ELSE BEGIN
            responseText := '{ "StatusCode":"400","StatusDescription":"NoLoans","OnlineGuarantors":[] }';
        END;
    end;

    procedure FnGetLoansForGuarantee(Member: Code[40]) responseText: Text
    var
        guarantorsText: Text;
    begin

        OnlineLoanGuarantors.Reset;
        OnlineLoanGuarantors.SetRange("Member No", Member);
        OnlineLoanGuarantors.SetFilter(Approved, '%1', OnlineLoanGuarantors.Approved::Pending);
        if OnlineLoanGuarantors.FindFirst then begin
            ObjLoanApplications.Reset;
            ObjLoanApplications.SetRange("Application No", OnlineLoanGuarantors."Loan Application No");
            if ObjLoanApplications.FindFirst then begin
                repeat
                    if guarantorsText = '' then begin
                        guarantorsText := '{'
                                      + '"LoanApplicationNo":"' + FORMAT(OnlineLoanGuarantors."Loan Application No") + '"'
                                      + ',"LoanType":"' + FORMAT(OnlineLoanGuarantors."Loan Type") + '"'
                                      + ',"ApplicantNo":"' + OnlineLoanGuarantors.ApplicantNo + '"'
                                      + ',"ApplicantName":"' + FORMAT(OnlineLoanGuarantors.ApplicantName) + '"'
                                      + ',"Amount":"' + FORMAT(OnlineLoanGuarantors."Amount") + '"'
                                      + ',"EntryNo":"' + FORMAT(OnlineLoanGuarantors."Entry No") + '"'
                                      + '}';
                    end else begin
                        guarantorsText := guarantorsText + ',{'
                                                              + '"LoanApplicationNo":"' + FORMAT(OnlineLoanGuarantors."Loan Application No") + '"'
                                                              + ',"LoanType":"' + FORMAT(OnlineLoanGuarantors."Loan Type") + '"'
                                                              + ',"ApplicantNo":"' + OnlineLoanGuarantors.ApplicantNo + '"'
                                                              + ',"ApplicantName":"' + FORMAT(OnlineLoanGuarantors.ApplicantName) + '"'
                                                              + ',"Amount":"' + FORMAT(OnlineLoanGuarantors."Amount") + '"'
                                                              + ',"EntryNo":"' + FORMAT(OnlineLoanGuarantors."Entry No") + '"'
                                                              + '}';
                    end;

                until OnlineLoanGuarantors.Next = 0;
            end;
        end;
        IF guarantorsText <> '' THEN BEGIN
            responseText := '{ "StatusCode":"200","StatusDescription":"OK","OnlineRequests":[' + guarantorsText + '] }';
        END ELSE BEGIN
            responseText := '{ "StatusCode":"400","StatusDescription":"NoLoans","OnlineRequests":[] }';
        END;
    end;

    procedure FnGetOnlineLoans(MemberNo: Code[30]) text: Text
    begin
        ObjLoanApplications.Reset;
        ObjLoanApplications.SetRange("BOSA No", MemberNo);
        if ObjLoanApplications.Find('-') then begin
            repeat
                text := Format(ObjLoanApplications."Application No") + '.' + ':' + ObjLoanApplications."Loan Type" + '.' + ':' + Format(ObjLoanApplications."Loan Amount")
                + '.' + ':' + Format(ObjLoanApplications."Application Date") + '.' + ':' + Format(ObjLoanApplications.submitted) + '.' + ':' + text;
            until ObjLoanApplications.Next = 0;
        end;
    end;

    procedure editOnlineLoan(loanNumber: Code[20]; memberNumber: Code[20]; amountRequest: Decimal; loanType: Code[20]; repaymentPeriod: Integer) response: Text;
    var
        onlineLoanTable: Record "Online Loan Application";
    begin
        response := 'failed to update the loan details';

        onlineLoanTable.Reset();
        onlineLoanTable.SetRange(onlineLoanTable."Application No", loanNumber);
        onlineLoanTable.SetRange(onlineLoanTable."BOSA No", memberNumber);
        if onlineLoanTable.Find('-') then begin
            if onlineLoanTable.submitted = true then begin
                response := 'You cannot edit this loan, Already submitted';
                exit;
            end;

            onlineLoanTable."Loan Type" := loanType;
            onlineLoanTable.Validate(onlineLoanTable."Loan Type");
            onlineLoanTable."Loan Amount" := amountRequest;
            onlineLoanTable."Repayment Period" := repaymentPeriod;

            if onlineLoanTable.Modify() = true then begin
                response := 'You have successfully edited Loan ' + loanNumber;
            end else begin
                response := 'Failed to update the Loan details';
            end;
        end else begin
            response := 'Could not find such a loan, please contact the administrator.';
        end;
    end;

    procedure fnSharesCertificate(MemberNo: Code[50]) exitString: Text
    var
        Filename: Text[100];
        Outputstream: OutStream;
        RecRef: RecordRef;
        TempBlob: Codeunit "Temp Blob";
        Outstr: OutStream;
        Instr: InStream;
        Base64Convert: Codeunit "Base64 Convert";
    begin
        objMember.Reset;
        objMember.SetRange(objMember."No.", MemberNo);
        if objMember.Find('-') then begin
            RecRef.GetTable(objMember);
            Clear(TempBlob);
            TempBlob.CreateOutStream(Outstr);
            TempBlob.CreateInStream(Instr);
            if Report.SaveAs(Report::"Member Shares Certificate", '', ReportFormat::Pdf, Outstr, RecRef) then begin
                exitString := Base64Convert.ToBase64(Instr);
                exit;
            end;
        end;
    end;


    // procedure fnGetMonthlyContribution(memberNumber: Code[20]) monthlyContribution: Decimal
    // var
    //     customers: Record Customer;

    // begin
    //     monthlyContribution := 0;

    //     customers.Reset();
    //     customers.SetRange(customers."No.", memberNumber);
    //     if customers.Find('-') then begin
    //         monthlyContribution := customers."Monthly contribution";
    //     end;
    // end;


    procedure fnEditMemberDetails(memberNumber: Code[20]; fullNames: Code[100]; phoneNumber: Code[20]; email: Code[250]; IDNumber: Code[20]; KRAPin: Code[20]; ImageBlob: Text) isEdited: Boolean
    var
        customer: Record Customer;
        TempBlob: Codeunit "Temp Blob";
        Base64Convert: Codeunit "Base64 Convert";
        InStream: InStream;
        OutStream: OutStream;
    begin
        isEdited := false;

        customer.Reset();
        customer.SetRange(customer."No.", memberNumber);
        if customer.Find('-') then begin
            customer."Mobile Phone No." := phoneNumber;
            customer."E-Mail (Personal)" := email;
            customer."ID No." := IDNumber;
            customer.Pin := KRAPin;

            // Handle Media image
            if ImageBlob <> '' then begin
                Clear(TempBlob);
                TempBlob.CreateOutStream(OutStream);
                Base64Convert.FromBase64(ImageBlob, OutStream); // Convert base64 to stream
                TempBlob.CreateInStream(InStream);
                customer.Image.ImportStream(InStream, 'Member Image'); // Import to Media field
            end;

            if customer.Modify() then begin
                isEdited := true;
            end;
        end;
    end;


    procedure MemberDepositContributions(MemberNo: Text[100]) MonthlyContributions: Text
    var
        minimunCount: Integer;
        amount: Decimal;
    begin
        begin
            MonthlyContributions := '';
            objMember.Reset;
            objMember.SetRange("No.", MemberNo);
            if objMember.Find('-') then begin

                custLedEntry.SetCurrentkey(custLedEntry."Entry No.");
                custLedEntry.Ascending(false);
                custLedEntry.SetRange(custLedEntry."Customer No.", MemberNo);
                custLedEntry.SetRange(custLedEntry."Transaction Type", TransactionType::"Deposit Contribution");
                custLedEntry.SetRange(custLedEntry.Reversed, false);
                if custLedEntry.FindSet then begin
                    MonthlyContributions := '';
                    repeat
                        custLedEntry.CalcFields(Amount);
                        amount := custLedEntry.Amount;
                        if amount < 1 then amount := amount * -1;
                        MonthlyContributions := MonthlyContributions + Format(custLedEntry."Posting Date") + ':::' + CopyStr(Format(custLedEntry.Description), 1, 25) + ':::' +
                        Format(amount) + '::::' + Format(custLedEntry."Transaction Type") + ':::';
                    // minimunCount := minimunCount + 1;
                    // if minimunCount > 20 then begin
                    //     exit(MiniStmt);
                    //end
                    until custLedEntry.Next = 0;
                end;

            end;

        end;
        exit(MonthlyContributions);
    end;

    procedure removeGuarantorRequest(memberNumber: Code[20]; loanNumber: Code[20]; guarantorNumber: Code[20]) isRemoved: Boolean
    var
        onlineGuarantors: Record "Online Loan Guarantors";
    begin
        isRemoved := false;
        onlineGuarantors.Reset();
        onlineGuarantors.SetRange(onlineGuarantors."Loan Application No", loanNumber);
        onlineGuarantors.SetRange(onlineGuarantors.ApplicantNo, memberNumber);
        onlineGuarantors.SetRange(onlineGuarantors."Member No", guarantorNumber);
        if onlineGuarantors.Find('-') then begin

            if onlineGuarantors.Delete() = true then
                isRemoved := true;
        end;
    end;

    procedure fnChangePassword(memberNumber: Code[100]; currentPass: Text; newPass: Text) updated: Boolean
    var
        InStream: InStream;
        PasswordText: Text;
        OutStream: OutStream;
        DecryptPassword: Text;
    begin
        sms := 'You have successfully updated your password. Your new password is: ' + newPass;
        Online.Reset;
        Online.SetRange("User Name", memberNumber);
        Online.SetRange(Password, currentPass);
        if Online.Find('-') then begin
            Online.Password := newPass;
            Online.Modify;
            updated := true;
        end
        else begin
            Error('Previous password is not correct');
        end;
    end;


    procedure fnSendOTPCode(memberNumber: Code[10]; otpCode: Code[5]) validated: Boolean
    begin
        validated := false;
        Online.Reset();
        Online.SetRange("User Name", memberNumber);
        if Online.Find('-') then begin
            sms := 'Your Portal verification code is ' + otpCode;
            Online."Login OTP" := otpCode;
            FnSMSMessage(memberNumber, Online.MobileNumber, sms);
            Online.Modify(true);
            validated := true;
        end;
    end;


    procedure fnConfirmOTPCode(memberNumber: Code[10]; otpCode: Code[5]) validated: Boolean
    begin
        validated := false;
        Online.Reset();
        Online.SetRange("User Name", memberNumber);
        Online.SetRange("Login OTP", otpCode);
        if Online.Find('-') then begin

            validated := true;
        end;
    end;


    procedure FnGetMonthlyDeductionDetails(MemberNo: Code[20]) DeductionSummary: Text
    var
        TotalDeductions: Decimal;
        TotalLoanDeductions: Decimal;
        MonthlyContribution: Decimal;
        MinShareCapital: Decimal;
        ShareCapital: Decimal;
        IndividualLoanAmount: Decimal;
        MemberFound: Boolean;
    begin
        // Initialize variables
        TotalDeductions := 0;
        TotalLoanDeductions := 0;
        ShareCapital := 0;
        DeductionSummary := '';
        MemberFound := false;

        // Get setup values with error handling
        if GenSetup.GET() then begin
            MonthlyContribution := GenSetup."Min. Contribution";
            MinShareCapital := GenSetup."Monthly Share Contributions";
        end else begin
            DeductionSummary := 'Error: Unable to retrieve system setup values';
            exit;
        end;

        // Find the member
        objMember.RESET();
        objMember.SETRANGE("No.", MemberNo);

        IF objMember.FINDFIRST() THEN BEGIN
            MemberFound := true;

            // Calculate member-specific monthly contribution
            // Use member's specific contribution if set, otherwise use minimum
            if objMember."Monthly Contribution" > 0 then
                MonthlyContribution := objMember."Monthly Contribution"
            else
                MonthlyContribution := GenSetup."Min. Contribution";

            // Calculate required share capital contribution
            if objMember."Shares Retained" < MinShareCapital then
                ShareCapital := MinShareCapital - objMember."Shares Retained";

            // Calculate base deductions (contributions + share capital)
            TotalDeductions := MonthlyContribution + ShareCapital;

            // Build formatted summary header
            DeductionSummary := STRSUBSTNO('MONTHLY DEDUCTION SUMMARY\n');
            DeductionSummary += STRSUBSTNO('================================\n');
            DeductionSummary += STRSUBSTNO('MEMBER: %1\n', MemberNo);
            if objMember.Name <> '' then
                DeductionSummary += STRSUBSTNO('NAME: %1\n', objMember.Name);
            DeductionSummary += STRSUBSTNO('DATE: %1\n\n', FORMAT(TODAY));

            // Add contribution details
            DeductionSummary += STRSUBSTNO('CONTRIBUTIONS:\n');
            DeductionSummary += STRSUBSTNO('- Monthly Contribution: %1\n', FORMAT(MonthlyContribution, 0, '<Precision,2:2><Standard Format,0>'));
            DeductionSummary += STRSUBSTNO('- Share Capital Due: %1\n', FORMAT(ShareCapital, 0, '<Precision,2:2><Standard Format,0>'));
            //DeductionSummary += STRSUBSTNO('- Current Shares: %1\n\n', FORMAT(objMember."Shares Retained", 0, '<Precision,2:2><Standard Format,0>'));

            // Process loan deductions
            DeductionSummary += STRSUBSTNO('LOAN DEDUCTIONS:\n');

            objLoanRegister.RESET();
            objLoanRegister.SETRANGE("Client Code", objMember."No.");
            objLoanRegister.SETFILTER("Outstanding Balance", '>%1', 0);
            objLoanRegister.SETFILTER(Repayment, '>%1', 0); // Only loans with repayment amount

            IF objLoanRegister.FINDSET() THEN BEGIN
                REPEAT
                    IndividualLoanAmount := objLoanRegister.Repayment;
                    TotalLoanDeductions += IndividualLoanAmount;

                    // Add detailed loan information
                    DeductionSummary += STRSUBSTNO('- Loan No: %1\n', objLoanRegister."Loan  No.");
                    DeductionSummary += STRSUBSTNO('  Type: %1 (%2)\n',
                        objLoanRegister."Loan Product Type Name",
                        objLoanRegister."Loan Product Type");
                    DeductionSummary += STRSUBSTNO('  Monthly Repayment: %1\n\n',
                        FORMAT(IndividualLoanAmount, 0, '<Precision,2:2><Standard Format,0>'));

                UNTIL objLoanRegister.NEXT = 0;
            END ELSE BEGIN
                DeductionSummary += '- No active loans requiring payment\n\n';
            END;

            // Calculate final total
            TotalDeductions += TotalLoanDeductions;

            // Add summary section
            DeductionSummary += STRSUBSTNO('SUMMARY:\n');
            DeductionSummary += STRSUBSTNO('================================\n');
            DeductionSummary += STRSUBSTNO('Total Loan Reayments: %1\n', FORMAT(TotalLoanDeductions, 0, '<Precision,2:2><Standard Format,0>'));
            DeductionSummary += STRSUBSTNO('TOTAL MONTHLY DEDUCTIONS: %1\n', FORMAT(TotalDeductions, 0, '<Precision,2:2><Standard Format,0>'));

            // Add processing timestamp
            DeductionSummary += STRSUBSTNO('\nGenerated: %1 at %2', FORMAT(TODAY), FORMAT(TIME));

        END ELSE BEGIN
            DeductionSummary := STRSUBSTNO('ERROR: Member %1 not found in the system', MemberNo);
        END;
    end;

    procedure submitGuarantors(OnlineLoanGuarantor: Record "Online Loan Guarantors"; loanRegisterNumber: Code[20])
    var
        loanGuarantors: Record "Loans Guarantee Details";
    begin
        loanGuarantors.Init();
        loanGuarantors."Loan No" := loanRegisterNumber;
        loanGuarantors."Account No." := OnlineLoanGuarantor."Member No";
        loanGuarantors."Member No" := OnlineLoanGuarantor."Member No";
        loanGuarantors."Amont Guaranteed" := OnlineLoanGuarantor.Amount;

        loanGuarantors.Validate("Member No");
        loanGuarantors.Validate("Amont Guaranteed");

        loanGuarantors.Insert();
    end;

    procedure deleteLoanApplication(memberNumber: Code[20]; loanNumber: Code[20]) isDeleted: Boolean
    var
        onlineLoanTable: Record "Online Loan Application";
    begin
        isDeleted := false;
        onlineLoanTable.Reset();
        onlineLoanTable.SetRange("BOSA No", memberNumber);
        onlineLoanTable.SetRange("Application No", loanNumber);
        if onlineLoanTable.Find('-') then begin
            onlineLoanTable."Application Status" := onlineLoanTable."Application Status"::Deleted;
            if onlineLoanTable.Modify() then begin
                isDeleted := true;
            end;
        end;
    end;






}

