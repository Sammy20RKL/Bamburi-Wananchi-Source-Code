#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 51120 PORTALIntegration
{
    trigger OnRun()
    begin
        SubmitLoan('BWS1163', 'PLN24');
    end;

    var
        i: Integer;
        Rschedule: Record "Loan Repayment Schedule";
        Lperiod: Integer;
        LastPayDate: Date;
        objMember: Record Customer;
        Vendor: Record Vendor;
        VendorLedgEntry: Record "Vendor Ledger Entry";
        FILESPATH: label 'D:\SERVICES\Hosted\Downloads\';
        objLoanRegister: Record "Loans Register";
        objRegMember: Record "Membership Applications";
        objNextKin: Record "Members Next Kin Details";
        GenSetup: Record "Sacco General Set-Up";
        FreeShares: Decimal;
        glamount: Decimal;
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
        CloudPesaLive: Codeunit SwizzKashMobile;
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

    procedure FnGetMonthlyDeduction_Json(MemberNo: Code[20]) OutputText: Text
    var
        objMember: Record Customer;
        objLoanRegister: Record "Loans Register";
        MonthlyContribution: Decimal;
        ShareCapital: Decimal;
        WelfareContribution: Decimal;
        HolidayContribution: Decimal;
        TotalLoanPrincipalRepayment: Decimal;
        TotalLoanInterest: Decimal;
        TotalMonthlyRepayment: Decimal;
        AsAtStart: Date;
        AsAtEnd: Date;
        LoanText: Text;
        IsFirst: Boolean;
        Principal: Decimal;
        Interest: Decimal;
    begin
        // --- Setup current month range ---
        AsAtStart := DMY2DATE(1, Date2DMY(Today, 2), Date2DMY(Today, 3));
        AsAtEnd := CALCDATE('<CM>', AsAtStart);

        OutputText := '{';
        IsFirst := true;
        ShareCapital := 0;
        WelfareContribution := 0;
        HolidayContribution := 0;

        // --- Fetch Member Info ---
        objMember.Reset;
        objMember.SetRange("No.", MemberNo);

        if objMember.FindFirst() then begin
            MonthlyContribution := objMember."Monthly Contribution";

            objMember.CalcFields("Shares Retained");
            if objMember."Shares Retained" >= 30000 then
                ShareCapital := 0
            else if objMember."Shares Retained" > 15000 then
                ShareCapital := 15000
            else
                ShareCapital := 10000;

            WelfareContribution := objMember."Welfare Contr";
            HolidayContribution := objMember."Holiday Contribution";

            // Base contribution details
            OutputText += '"MonthlyContribution":"' + Format(ROUND(MonthlyContribution, 0.01)) + '",';
            OutputText += '"ShareCapital":"' + Format(ROUND(ShareCapital, 0.01)) + '",';
            OutputText += '"WelfareContribution":"' + Format(ROUND(WelfareContribution, 0.01)) + '",';
            OutputText += '"HolidayContribution":"' + Format(ROUND(HolidayContribution, 0.01)) + '",';
        end else begin
            OutputText := '{"error":"Member ' + MemberNo + ' not found."}';
            exit(OutputText);
        end;

        // --- Initialize Totals ---
        TotalLoanPrincipalRepayment := 0;
        TotalLoanInterest := 0;
        TotalMonthlyRepayment := 0;

        // --- Get All Active Loans ---
        objLoanRegister.Reset();
        objLoanRegister.SetRange("Client Code", MemberNo);
        objLoanRegister.SetRange(Posted, true);
        objLoanRegister.SetFilter("Outstanding Balance", '>0');

        if objLoanRegister.FindSet() then begin
            LoanText := '"Loans":[';
            IsFirst := true;

            repeat
                if not IsFirst then
                    LoanText += ','
                else
                    IsFirst := false;

                // Use the NEW calculation logic
                CalculateLoanRepayment(
                    objLoanRegister."Loan Product Type",
                    Principal,
                    Interest,
                    MemberNo,
                    Today,
                    AsAtStart
                );

                // Append loan info
                LoanText += '{' +
                    '"LoanNo":"' + objLoanRegister."Loan  No." + '",' +
                    '"ProductType":"' + objLoanRegister."Loan Product Type" + '",' +
                    '"PrincipalRepayment":"' + Format(ROUND(Principal, 0.01)) + '",' +
                    '"Interest":"' + Format(ROUND(Interest, 0.01)) + '",' +
                    '"MonthlyRepayment":"' + Format(ROUND(Principal + Interest, 0.01)) + '"}';

                // Accumulate totals
                TotalLoanPrincipalRepayment += Principal;
                TotalLoanInterest += Interest;
                TotalMonthlyRepayment += (Principal + Interest);

            until objLoanRegister.Next() = 0;

            LoanText += '],';
            OutputText += LoanText;

            // Append totals
            OutputText += '"TotalPrincipalRepayment":"' + Format(ROUND(TotalLoanPrincipalRepayment, 0.01)) + '",';
            OutputText += '"TotalInterestRepayment":"' + Format(ROUND(TotalLoanInterest, 0.01)) + '",';
            OutputText += '"TotalMonthlyRepayment":"' + Format(ROUND(TotalMonthlyRepayment, 0.01)) + '",';
        end else begin
            // No loans found
            OutputText += '"Loans":[],' +
                        '"TotalPrincipalRepayment":"0.00",' +
                        '"TotalInterestRepayment":"0.00",' +
                        '"TotalMonthlyRepayment":"0.00",' +
                        '"LoanMessage":"No active loans found",';
        end;

        // --- Grand Total ---
        OutputText += '"GrandTotal":"' +
            Format(ROUND(
                TotalMonthlyRepayment +
                MonthlyContribution +
                ShareCapital +
                WelfareContribution +
                HolidayContribution, 0.01)) +
            '"}';

        exit(OutputText);
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

    procedure MiniStatement_Json(MemberNo: Text[100]) MiniStmt: Text
    var
        minimunCount: Integer;
        amount: Decimal;
        fosano: Code[100];
        minText: Text;
    begin
        begin
            MiniStmt := '';
            minText := '';
            objMember.Reset;
            objMember.SetRange("No.", MemberNo);
            if objMember.Find('-') then begin
                fosano := objMember."FOSA Account No.";

                Vendor.Reset;
                Vendor.SetFilter("Account Type", '<>511');
                Vendor.SetRange("No.", fosano);
                if Vendor.Find('-') then
                    minimunCount := 1;
                Vendor.CalcFields(Vendor.Balance);
                VendorLedgEntry.SetCurrentkey(VendorLedgEntry."Entry No.");
                VendorLedgEntry.Ascending(false);
                VendorLedgEntry.SetRange(VendorLedgEntry."Vendor No.", fosano);
                VendorLedgEntry.SetRange(VendorLedgEntry.Reversed, false);
                if VendorLedgEntry.FindSet then begin
                    MiniStmt := '';
                    repeat
                        VendorLedgEntry.CalcFields(Amount);
                        amount := VendorLedgEntry.Amount;
                        if amount < 1 then amount := amount * -1;
                        if minText = '' then begin
                            minText := '"Date":"' + Format(VendorLedgEntry."Posting Date") + '"'
                                                                + '"Description":"' + CopyStr(Format(VendorLedgEntry.Description), 1, 25) + '"'
                                                                + '"Amount":"' + Format(amount) + '"';
                        end else begin
                            minText := minText + ',"Date":"' + Format(VendorLedgEntry."Posting Date") + '"'
                                                                + '"Description":"' + CopyStr(Format(VendorLedgEntry.Description), 1, 25) + '"'
                                                                + '"Amount":"' + Format(amount) + '"';
                        end;

                        MiniStmt := MiniStmt + Format(VendorLedgEntry."Posting Date") + ':::' + CopyStr(Format(VendorLedgEntry.Description), 1, 25) + ':::' +
                        Format(amount) + '::::';
                        minimunCount := minimunCount + 1;
                        if minimunCount > 20 then begin
                            exit(minText);
                        end
                    until VendorLedgEntry.Next = 0;
                end;

            end;

        end;
        exit(minText);
    end;


    procedure fnMemberStatement(MemberNo: Code[50]; "filter": Text; var BigText: BigText) exitString: Text
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

    procedure fnMemberStatementActive(MemberNo: Code[50]; startDate: Text; endDate: Text) exitString: Text
    var
        Filename: Text[100];
        Outputstream: OutStream;
        RecRef: RecordRef;
        TempBlob: Codeunit "Temp Blob";
        Outstr: OutStream;
        Instr: InStream;
        Base64Convert: Codeunit "Base64 Convert";
        dateFilter: Text;
    begin
        dateFilter := startDate + '..' + endDate;
        objMember.Reset;
        objMember.SetRange(objMember."No.", MemberNo);
        if objMember.Find('-') then begin
            RecRef.GetTable(objMember);
            Clear(TempBlob);
            TempBlob.CreateOutStream(Outstr);
            TempBlob.CreateInStream(Instr);
            // if Report.SaveAs(Report::"Member Account Statement(act1)", '', ReportFormat::Pdf, Outstr, RecRef) then begin
            if Report.SaveAs(Report::"Detailed Active Statement", '', ReportFormat::Pdf, Outstr, RecRef) then begin
                exitString := Base64Convert.ToBase64(Instr);
                exit;
            end;
        end;
    end;

    procedure fnCheckOffAdviceReport(employerCode: Code[20]; memberNo: Code[20]) exitString: Text
    var
        MembersRegister: Record Customer;
        JsonResponse: JsonObject;
        JsonData: JsonObject;
        JsonMembersArray: JsonArray;
        JsonMember: JsonObject;
        ResponseText: Text;
        Cust: Record Customer;
        Gsetup: Record "Sacco General Set-Up";
        loans: Record "Loans Register";
        CompanyInfo: Record "Company Information";
        // Variables for calculations (same as in original report)
        TRepayment: Decimal;
        MonthlyAdvice: Decimal;
        Juniorcontribution: Decimal;
        AlphaSavings: Decimal;
        Likizo: Decimal;
        HOUSING: Decimal;
        DEPOSIT: Decimal;
        scapital: Decimal;
        normloan: Decimal;
        College: Decimal;
        scfee: Decimal;
        emmerg: Decimal;
        Quick: Decimal;
        karibu: Decimal;
        AssetL: Decimal;
        Makeover: Decimal;
        Premium: Decimal;
        employername: Text;
        member: Record "Sacco Employers";
    begin
        // Reset and filter the Members Register (Customer table)
        MembersRegister.Reset();
        MembersRegister.SetRange(Status, MembersRegister.Status::Active);

        // Apply filters based on parameters
        if memberNo <> '' then
            MembersRegister.SetRange("No.", memberNo);
        if employerCode <> '' then
            MembersRegister.SetRange("Employer Code", employerCode);

        // Get company info
        CompanyInfo.Get();

        // Get employer name
        if employerCode <> '' then begin
            member.Reset();
            member.SetRange(Code, employerCode);
            if member.FindFirst() then
                employername := member.TableName;
        end;

        if MembersRegister.Find('-') then begin
            repeat
                // Initialize all variables (same as original report)
                TRepayment := 0;
                MonthlyAdvice := 0;
                Juniorcontribution := 0;
                AlphaSavings := 0;
                Likizo := 0;
                normloan := 0;
                College := 0;
                AssetL := 0;
                scfee := 0;
                emmerg := 0;
                Quick := 0;
                karibu := 0;
                Makeover := 0;
                Premium := 0;
                HOUSING := 0;
                DEPOSIT := 0;
                scapital := 0;

                // Get customer details and calculate contributions (same logic as original)
                Cust.Reset;
                Cust.SetRange("No.", MembersRegister."No.");
                Cust.SetRange("Employer Code", MembersRegister."Employer Code");
                if Cust.Find('-') then begin
                    Gsetup.Get();
                    Cust.CalcFields("Shares Retained");
                    if Cust."Shares Retained" < Gsetup."Retained Shares" then
                        scapital := Cust."Monthly ShareCap Cont.";
                    Likizo := Cust."Holiday Contribution";
                    AlphaSavings := Cust."Alpha Monthly Contribution";
                    Juniorcontribution := Cust."Junior Monthly Contribution";
                    HOUSING := Cust."Investment Monthly Cont";
                    DEPOSIT := Cust."Monthly Contribution" + Cust."Monthly ShareCap Cont.";

                    // Calculate NORMAL loan repayment
                    loans.Reset;
                    loans.SetRange("Client Code", MembersRegister."No.");
                    loans.SetRange("Recovery Mode", loans."Recovery Mode");
                    loans.SetRange("Loan Product Type", 'NORMAL');
                    loans.SetFilter("Outstanding Balance", '>0');
                    loans.SetAutocalcFields("Outstanding Balance", "Oustanding Interest");
                    loans.SetRange(Posted, true);
                    if loans.Find('-') then begin
                        repeat
                            TRepayment := loans."Oustanding Interest" + loans."Outstanding Balance";
                            if TRepayment < loans.Repayment then
                                normloan := TRepayment
                            else
                                normloan := loans.Repayment;
                        until loans.Next = 0;
                    end;

                    // Calculate COLLEGE loan repayment
                    TRepayment := 0;
                    loans.Reset;
                    loans.SetRange("Client Code", MembersRegister."No.");
                    loans.SetRange("Loan Product Type", 'COLLEGE');
                    loans.SetFilter("Outstanding Balance", '>0');
                    loans.SetAutocalcFields("Outstanding Balance", "Oustanding Interest");
                    loans.SetRange(Posted, true);
                    if loans.Find('-') then begin
                        repeat
                            TRepayment := loans."Oustanding Interest" + loans."Outstanding Balance";
                            if TRepayment < loans.Repayment then
                                College := TRepayment
                            else
                                College += loans.Repayment;
                        until loans.Next = 0;
                    end;

                    // Calculate MAKEOVER loan repayment
                    TRepayment := 0;
                    loans.Reset;
                    loans.SetRange("Client Code", MembersRegister."No.");
                    loans.SetRange("Loan Product Type", 'MAKEOVER');
                    loans.SetFilter("Outstanding Balance", '>0');
                    loans.SetAutocalcFields("Outstanding Balance", "Oustanding Interest");
                    loans.SetRange(Posted, true);
                    if loans.Find('-') then begin
                        repeat
                            TRepayment := loans."Oustanding Interest" + loans."Outstanding Balance";
                            if TRepayment < loans.Repayment then
                                Makeover := TRepayment
                            else
                                Makeover := loans.Repayment;
                        until loans.Next = 0;
                    end;

                    // Calculate PREMIUM loan repayment
                    TRepayment := 0;
                    loans.Reset;
                    loans.SetRange("Client Code", MembersRegister."No.");
                    loans.SetRange("Loan Product Type", 'PREMIUM');
                    loans.SetFilter("Outstanding Balance", '>0');
                    loans.SetAutocalcFields("Outstanding Balance", "Oustanding Interest");
                    loans.SetRange(Posted, true);
                    if loans.Find('-') then begin
                        repeat
                            TRepayment := loans."Oustanding Interest" + loans."Outstanding Balance";
                            if TRepayment < loans.Repayment then
                                Premium := TRepayment
                            else
                                Premium := loans.Repayment;
                        until loans.Next = 0;
                    end;

                    // Calculate SCH_FEES loan repayment
                    TRepayment := 0;
                    loans.Reset;
                    loans.SetRange("Client Code", MembersRegister."No.");
                    loans.SetRange("Loan Product Type", 'SCH_FEES');
                    loans.SetFilter("Outstanding Balance", '>0');
                    loans.SetAutocalcFields("Outstanding Balance", "Oustanding Interest");
                    loans.SetRange(Posted, true);
                    if loans.Find('-') then begin
                        repeat
                            TRepayment := loans."Oustanding Interest" + loans."Outstanding Balance";
                            if TRepayment < loans.Repayment then
                                scfee := TRepayment
                            else
                                scfee := loans.Repayment;
                        until loans.Next = 0;
                    end;

                    // Calculate EMERGENCY loan repayment
                    TRepayment := 0;
                    loans.Reset;
                    loans.SetRange("Client Code", MembersRegister."No.");
                    loans.SetRange("Loan Product Type", 'EMERGENCY');
                    loans.SetFilter("Outstanding Balance", '>0');
                    loans.SetAutocalcFields("Outstanding Balance", "Oustanding Interest");
                    loans.SetRange(Posted, true);
                    if loans.Find('-') then begin
                        repeat
                            TRepayment := loans."Oustanding Interest" + loans."Outstanding Balance";
                            if TRepayment < loans.Repayment then
                                emmerg := TRepayment
                            else
                                emmerg := loans.Repayment;
                        until loans.Next = 0;
                    end;

                    // Calculate QUICK CASH loan repayment
                    TRepayment := 0;
                    loans.Reset;
                    loans.SetRange("Client Code", MembersRegister."No.");
                    loans.SetRange("Loan Product Type", 'QUICK CASH');
                    loans.SetFilter("Outstanding Balance", '>0');
                    loans.SetAutocalcFields("Outstanding Balance", "Oustanding Interest");
                    loans.SetRange(Posted, true);
                    if loans.Find('-') then begin
                        repeat
                            TRepayment := loans."Oustanding Interest" + loans."Outstanding Balance";
                            if TRepayment < loans.Repayment then
                                Quick := TRepayment
                            else
                                Quick := loans.Repayment;
                        until loans.Next = 0;
                    end;

                    // Calculate KARIBU loan repayment
                    loans.Reset;
                    loans.SetRange("Client Code", MembersRegister."No.");
                    loans.SetRange("Loan Product Type", 'KARIBU');
                    loans.SetFilter("Outstanding Balance", '>0');
                    loans.SetAutocalcFields("Outstanding Balance", "Oustanding Interest");
                    loans.SetRange(Posted, true);
                    if loans.Find('-') then begin
                        repeat
                            TRepayment := loans."Oustanding Interest" + loans."Outstanding Balance";
                            if TRepayment < loans.Repayment then
                                karibu := TRepayment
                            else
                                karibu := loans.Repayment;
                        until loans.Next = 0;
                    end;

                    // Calculate ASSET LOAN repayment
                    loans.Reset;
                    loans.SetRange("Client Code", MembersRegister."No.");
                    loans.SetRange("Loan Product Type", 'ASSET LOAN');
                    loans.SetFilter("Outstanding Balance", '>0');
                    loans.SetAutocalcFields("Outstanding Balance");
                    loans.SetRange(Posted, true);
                    if loans.Find('-') then begin
                        repeat
                            TRepayment := loans."Oustanding Interest" + loans."Outstanding Balance";
                            if TRepayment < loans.Repayment then
                                AssetL := TRepayment
                            else
                                AssetL := loans.Repayment;
                        until loans.Next = 0;
                    end;

                    // Calculate total monthly advice
                    MonthlyAdvice := HOUSING + AlphaSavings + Juniorcontribution + DEPOSIT + Likizo +
                                   normloan + College + scfee + emmerg + Quick + karibu + AssetL +
                                   Makeover + Premium;
                end;

                // Build JSON object for this member
                Clear(JsonMember);
                JsonMember.Add('memberNo', MembersRegister."No.");
                JsonMember.Add('memberName', MembersRegister.Name);
                JsonMember.Add('employerCode', MembersRegister."Employer Code");
                JsonMember.Add('monthlyContribution', MembersRegister."Monthly Contribution");

                // Contributions
                JsonMember.Add('shareCapital', scapital);
                JsonMember.Add('holidayContribution', Likizo);
                JsonMember.Add('alphaSavings', AlphaSavings);
                JsonMember.Add('juniorContribution', Juniorcontribution);
                JsonMember.Add('housingContribution', HOUSING);
                JsonMember.Add('depositContribution', DEPOSIT);

                // Loan repayments
                JsonMember.Add('normalLoanRepayment', normloan);
                JsonMember.Add('collegeLoanRepayment', College);
                JsonMember.Add('schoolFeesRepayment', scfee);
                JsonMember.Add('emergencyLoanRepayment', emmerg);
                JsonMember.Add('quickCashRepayment', Quick);
                JsonMember.Add('karibuLoanRepayment', karibu);
                JsonMember.Add('assetLoanRepayment', AssetL);
                JsonMember.Add('makeoverLoanRepayment', Makeover);
                JsonMember.Add('premiumLoanRepayment', Premium);

                // Total
                JsonMember.Add('totalMonthlyAdvice', MonthlyAdvice);

                JsonMembersArray.Add(JsonMember);

            until MembersRegister.Next = 0;

            // Create successful response
            JsonData.Add('success', true);
            JsonData.Add('message', 'Check Off Advice data retrieved successfully');
            JsonData.Add('reportType', 'CHECK_OFF_ADVICE');
            JsonData.Add('employerCode', employerCode);
            JsonData.Add('employerName', employername);
            JsonData.Add('filterMemberNo', memberNo);
            JsonData.Add('generatedDate', Format(Today, 0, '<Year4>-<Month,2>-<Day,2>'));
            JsonData.Add('generatedTime', Format(Time, 0, '<Hours24,2>:<Minutes,2>:<Seconds,2>'));
            JsonData.Add('companyName', CompanyInfo.Name);
            JsonData.Add('companyAddress', CompanyInfo.Address);
            JsonData.Add('companyPhone', CompanyInfo."Phone No.");
            JsonData.Add('companyWebsite', CompanyInfo."Home Page");
            JsonData.Add('totalRecords', JsonMembersArray.Count);
            JsonData.Add('members', JsonMembersArray);

            JsonResponse.Add('status', 'SUCCESS');
            JsonResponse.Add('statusCode', 200);
            JsonResponse.Add('data', JsonData);

        end else begin
            // No records found
            JsonData.Add('success', false);
            JsonData.Add('message', 'No active members found for the specified criteria');
            JsonData.Add('employerCode', employerCode);
            JsonData.Add('memberNo', memberNo);
            JsonData.Add('errorCode', 'NO_RECORDS_FOUND');

            JsonResponse.Add('status', 'ERROR');
            JsonResponse.Add('statusCode', 404);
            JsonResponse.Add('data', JsonData);
        end;

        JsonResponse.WriteTo(ResponseText);
        exitString := ResponseText;
    end;

    procedure fnGetMonthlyDeductions(memberNumber: Code[20]): Decimal
    var
        EndMonth_Date: Date;
        BeginMonth_Date: Date;
        ASAT: Date;
        LoansRegister: Record "Loans Register";
        ShareCapital: Decimal;
        DevP: Decimal;
        DevLNO: Code[20];
        Devint: Decimal;
        montlycon: Decimal;
        lndev: Code[30];
        EMERGENCYp: Decimal;
        EMERGENCYi: Decimal;
        EMERGENCYLNO: Code[20];
        EMERGENCYlnb: Code[30];
        SUPEREMERGENCYLNO: Code[20];
        SUPEREMERGENCYp: Decimal;
        SUPEREMERGENCYi: Decimal;
        QUICKLOANNO: Code[20];
        QUICKLOANp: Decimal;
        QUICKLOANi: Decimal;
        SUPERQUICKLNO: Code[20];
        SUPERQUICKp: Decimal;
        SUPERQUICKi: Decimal;
        SCHOOLFEESLNNO: Code[20];
        SCHOOLFEESp: Decimal;
        SCHOOLFEESi: Decimal;
        SUPERSCHOOLFEESLNO: Code[20];
        SUPERSCHOOLFEESp: Decimal;
        SUPERSCHOOLFEESi: Decimal;
        INVESTMENTLOANLNO: Code[20];
        INVESTMENTLOANp: Decimal;
        INVESTMENTLOANi: Decimal;
        TOTALREMMITANCE: Decimal;
        NORMALLOANLNO: Code[20];
        NORMALLOANp: Decimal;
        NORMALLOANi: Decimal;
        NORMALLOAN1LNO: Code[20];
        NORMALLOAN1p: Decimal;
        NORMALLOAN1i: Decimal;
        DevP1LNO: Code[20];
        DevP1: Decimal;
        Devint1: Decimal;
        inDev1: Code[50];
        LoanRepaymentSchedule: Record "Loan Repayment Schedule";
        DevelopmentLoanP: Decimal;
        DevelopmentLoanInt: Decimal;
        developmentLoan_No: Code[20];
        TotalMRepay: Decimal;
        MERCHANDISEPr: Decimal;
        MERCHANDISEIn: Decimal;
        MERCHANDISE_No: Code[20];
        SwizzFactory: Codeunit "Swizzsoft Factory";
        Customer: Record Customer;
        tottalDeductions: Decimal;
        "Welfare Contr": Decimal;

    begin
        ASAT := Today;
        Customer.Reset();
        Customer.SetRange(Customer."No.", memberNumber);

        ShareCapital := 0;
        Customer.CalcFields(Customer."Shares Retained");
        //MESSAGE (FORMAT(Customer."Shares Retained"));
        if Customer."Shares Retained" >= 15000 then begin
            ShareCapital := 0
        end else
            if Customer."Shares Retained" > 5000 then begin
                ShareCapital := 417
            end else
                if Customer."Shares Retained" < 5000 then begin
                    ShareCapital := 1000
                end;

        BeginMonth_Date := CalcDate('<-CM +14D>', ASAT);

        montlycon := Customer."Monthly Contribution";
        "Welfare Contr" := Customer."Welfare Contr";
        Customer.SetFilter(Customer."Monthly Contribution", '>%1', 0);
        // 

        // DEVELOPMENT
        CalculateLoanRepayment2('20', DevP, Devint, Customer."No.", ASAT, BeginMonth_Date);

        // DEVELOPMENT 1
        CalculateLoanRepayment('23', DevP1, Devint1, Customer."No.", ASAT, BeginMonth_Date);

        // EMERGENCY
        CalculateLoanRepayment('12', EMERGENCYp, EMERGENCYi, Customer."No.", ASAT, BeginMonth_Date);

        //SUPER SCHOOL FEE
        CalculateLoanRepayment2('18', SUPERSCHOOLFEESp, SUPERSCHOOLFEESi, Customer."No.", ASAT, BeginMonth_Date);

        // SUPER EMERGENCY LOAN
        SUPEREMERGENCYp := 0;
        SUPEREMERGENCYi := 0;
        TotalMRepay := 0;

        LoansRegister.Reset;
        LoansRegister.SetRange("Client Code", Customer."No.");
        LoansRegister.SetRange("Loan Product Type", '13');
        LoansRegister.SetAutocalcFields(LoansRegister."Outstanding Balance", LoansRegister."Oustanding Interest");
        LoansRegister.SetRange(LoansRegister.Posted, true);
        LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
        LoansRegister.SetCurrentKey("Client Code", "Application Date");
        LoansRegister.Ascending(false);

        if LoansRegister.FindSet then begin
            LoansRegister.CalcFields("Outstanding Balance", "Oustanding Interest", "Interest Due");
            //SwizzFactory.FnGenerateRepaymentSchedule(LoansRegister."Loan  No.");

            if LoansRegister."Expected Date of Completion" <= ASAT then begin
                LoanRepaymentSchedule.Reset;
                LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
                if LoanRepaymentSchedule.FindLast then begin
                    if LoanRepaymentSchedule."Principal Repayment" > LoansRegister."Outstanding Balance" then
                        SUPEREMERGENCYp := ROUND(LoansRegister."Outstanding Balance", 1, '>')
                    else
                        SUPEREMERGENCYp := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');

                    SUPEREMERGENCYi := ROUND(LoansRegister."Oustanding Interest", 1, '>');
                    if LoanRepaymentSchedule."Principal Repayment" < LoansRegister."Outstanding Balance" then
                        SUPEREMERGENCYi := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
                end;

            end else if LoansRegister."Loan Disbursement Date" < BeginMonth_Date then begin
                LoanRepaymentSchedule.Reset;
                LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
                LoanRepaymentSchedule.SetFilter("Repayment Date", '%1..%2', ASAT, CalcDate('CM', ASAT));
                if LoanRepaymentSchedule.Find('-') then begin
                    SUPEREMERGENCYi := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
                    SUPEREMERGENCYp := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');
                end;
            end else begin
                LoanRepaymentSchedule.Reset;
                LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
                if LoanRepaymentSchedule.FindLast then begin
                    if LoanRepaymentSchedule."Principal Repayment" > LoansRegister."Outstanding Balance" then
                        SUPEREMERGENCYp := ROUND(LoansRegister."Outstanding Balance", 1, '>')
                    else
                        SUPEREMERGENCYp := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');

                    SUPEREMERGENCYi := ROUND(LoansRegister."Oustanding Interest", 1, '>');
                    if LoanRepaymentSchedule."Principal Repayment" < LoansRegister."Outstanding Balance" then
                        SUPEREMERGENCYi := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
                end;
            end;
        end;

        //SUPER EMERGENCY LOAN end=============================================================================================================================================
        //QUICK LOAN start==========================================================================================================================================
        // QUICK LOAN start
        QUICKLOANp := 0;
        QUICKLOANi := 0;
        TotalMRepay := 0;

        LoansRegister.Reset;
        LoansRegister.SetRange("Client Code", Customer."No.");
        LoansRegister.SetRange("Loan Product Type", '15');
        LoansRegister.SetAutocalcFields(LoansRegister."Outstanding Balance", LoansRegister."Oustanding Interest");
        LoansRegister.SetRange(LoansRegister.Posted, true);
        LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
        LoansRegister.SetCurrentKey("Client Code", "Application Date");
        LoansRegister.Ascending(false);

        if LoansRegister.FindSet then begin
            LoansRegister.CalcFields("Outstanding Balance", "Oustanding Interest", "Interest Due");
            //SwizzFactory.FnGenerateRepaymentSchedule(LoansRegister."Loan  No.");

            if LoansRegister."Expected Date of Completion" <= ASAT then begin
                LoanRepaymentSchedule.Reset;
                LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");

                if LoanRepaymentSchedule.FindLast then begin
                    if LoanRepaymentSchedule."Principal Repayment" > LoansRegister."Outstanding Balance" then
                        QUICKLOANp := ROUND(LoansRegister."Outstanding Balance", 1, '>')
                    else
                        QUICKLOANp := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');

                    QUICKLOANi := ROUND(LoansRegister."Oustanding Interest", 1, '>');
                    if LoanRepaymentSchedule."Principal Repayment" < LoansRegister."Outstanding Balance" then
                        QUICKLOANi := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
                end;

            end else if LoansRegister."Loan Disbursement Date" < BeginMonth_Date then begin
                LoansRegister.CalcFields("Outstanding Balance", "Oustanding Interest", "Interest Due");

                LoanRepaymentSchedule.Reset;
                LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
                LoanRepaymentSchedule.SetFilter(LoanRepaymentSchedule."Repayment Date", '%1..%2', ASAT, CalcDate('CM', ASAT));

                if LoanRepaymentSchedule.Find('-') then begin
                    QUICKLOANi := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
                    QUICKLOANp := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');
                end;
            end else begin
                LoanRepaymentSchedule.Reset;
                LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");

                if LoanRepaymentSchedule.FindLast then begin
                    if LoanRepaymentSchedule."Principal Repayment" > LoansRegister."Outstanding Balance" then
                        QUICKLOANp := ROUND(LoansRegister."Outstanding Balance", 1, '>')
                    else
                        QUICKLOANp := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');

                    QUICKLOANi := ROUND(LoansRegister."Oustanding Interest", 1, '>');
                    if LoanRepaymentSchedule."Principal Repayment" < LoansRegister."Outstanding Balance" then
                        QUICKLOANi := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
                end;
            end;
        end;
        // QUICK LOAN end


        // SUPER QUICK start
        SUPERQUICKp := 0;
        SUPERQUICKi := 0;
        TotalMRepay := 0;

        LoansRegister.Reset;
        LoansRegister.SetRange("Client Code", Customer."No.");
        LoansRegister.SetRange("Loan Product Type", '16');
        LoansRegister.SetAutocalcFields(LoansRegister."Outstanding Balance", LoansRegister."Oustanding Interest");
        LoansRegister.SetRange(LoansRegister.Posted, true);
        LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
        LoansRegister.SetCurrentKey("Client Code", "Application Date");
        LoansRegister.Ascending(false);

        if LoansRegister.FindSet then begin
            LoansRegister.CalcFields("Outstanding Balance", "Oustanding Interest", "Interest Due");
            //SwizzFactory.FnGenerateRepaymentSchedule(LoansRegister."Loan  No.");

            if LoansRegister."Expected Date of Completion" <= ASAT then begin
                LoanRepaymentSchedule.Reset;
                LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");

                if LoanRepaymentSchedule.FindLast then begin
                    if LoanRepaymentSchedule."Principal Repayment" > LoansRegister."Outstanding Balance" then
                        SUPERQUICKp := ROUND(LoansRegister."Outstanding Balance", 1, '>')
                    else
                        SUPERQUICKp := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');

                    SUPERQUICKi := ROUND(LoansRegister."Oustanding Interest", 1, '>');
                    if LoanRepaymentSchedule."Principal Repayment" < LoansRegister."Outstanding Balance" then
                        SUPERQUICKi := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
                end;

            end else if LoansRegister."Loan Disbursement Date" < BeginMonth_Date then begin
                LoansRegister.CalcFields("Outstanding Balance", "Oustanding Interest", "Interest Due");

                LoanRepaymentSchedule.Reset;
                LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
                LoanRepaymentSchedule.SetFilter(LoanRepaymentSchedule."Repayment Date", '%1..%2', ASAT, CalcDate('CM', ASAT));

                if LoanRepaymentSchedule.Find('-') then begin
                    SUPERQUICKi := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
                    SUPERQUICKp := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');
                end;
            end else begin
                LoanRepaymentSchedule.Reset;
                LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");

                if LoanRepaymentSchedule.FindLast then begin
                    if LoanRepaymentSchedule."Principal Repayment" > LoansRegister."Outstanding Balance" then
                        SUPERQUICKp := ROUND(LoansRegister."Outstanding Balance", 1, '>')
                    else
                        SUPERQUICKp := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');

                    SUPERQUICKi := ROUND(LoansRegister."Oustanding Interest", 1, '>');
                    if LoanRepaymentSchedule."Principal Repayment" < LoansRegister."Outstanding Balance" then
                        SUPERQUICKi := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
                end;
            end;
        end;


        SCHOOLFEESp := 0;
        SCHOOLFEESi := 0;
        TotalMRepay := 0;

        LoansRegister.Reset;
        LoansRegister.SetRange("Client Code", Customer."No.");
        LoansRegister.SetRange("Loan Product Type", '17'); // School Fees
        LoansRegister.SetAutocalcFields(LoansRegister."Outstanding Balance", LoansRegister."Oustanding Interest");
        LoansRegister.SetRange(LoansRegister.Posted, true);
        LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
        LoansRegister.SetCurrentKey("Client Code", "Application Date");
        LoansRegister.Ascending(false);

        if LoansRegister.FindSet then begin
            LoansRegister.CalcFields("Outstanding Balance", "Oustanding Interest", "Interest Due");
            //SwizzFactory.FnGenerateRepaymentSchedule(LoansRegister."Loan  No.");

            if LoansRegister."Expected Date of Completion" <= ASAT then begin
                LoanRepaymentSchedule.Reset;
                LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");

                if LoanRepaymentSchedule.FindLast then begin
                    if LoanRepaymentSchedule."Principal Repayment" > LoansRegister."Outstanding Balance" then
                        SCHOOLFEESp := ROUND(LoansRegister."Outstanding Balance", 1, '>')
                    else
                        SCHOOLFEESp := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');

                    SCHOOLFEESi := ROUND(LoansRegister."Oustanding Interest", 1, '>');
                    if LoanRepaymentSchedule."Principal Repayment" < LoansRegister."Outstanding Balance" then
                        SCHOOLFEESi := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
                end;

            end else if LoansRegister."Loan Disbursement Date" < BeginMonth_Date then begin
                LoansRegister.CalcFields("Outstanding Balance", "Oustanding Interest", "Interest Due");

                LoanRepaymentSchedule.Reset;
                LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
                LoanRepaymentSchedule.SetFilter(LoanRepaymentSchedule."Repayment Date", '%1..%2', ASAT, CalcDate('CM', ASAT));

                if LoanRepaymentSchedule.Find('-') then begin
                    SCHOOLFEESi := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
                    SCHOOLFEESp := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');
                end;
            end else begin
                LoanRepaymentSchedule.Reset;
                LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");

                if LoanRepaymentSchedule.FindLast then begin
                    if LoanRepaymentSchedule."Principal Repayment" > LoansRegister."Outstanding Balance" then
                        SCHOOLFEESp := ROUND(LoansRegister."Outstanding Balance", 1, '>')
                    else
                        SCHOOLFEESp := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');

                    SCHOOLFEESi := ROUND(LoansRegister."Oustanding Interest", 1, '>');
                    if LoanRepaymentSchedule."Principal Repayment" < LoansRegister."Outstanding Balance" then
                        SCHOOLFEESi := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
                end;
            end;
        end;

        INVESTMENTLOANp := 0;
        INVESTMENTLOANi := 0;
        TotalMRepay := 0;

        LoansRegister.Reset;
        LoansRegister.SetRange("Client Code", Customer."No.");
        LoansRegister.SetRange("Loan Product Type", '19'); // Investment loans
        LoansRegister.SetAutocalcFields(LoansRegister."Outstanding Balance", LoansRegister."Oustanding Interest");
        LoansRegister.SetRange(LoansRegister.Posted, true);
        LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
        LoansRegister.SetCurrentKey("Client Code", "Application Date");
        LoansRegister.Ascending(false);

        if LoansRegister.FindSet then begin
            LoansRegister.CalcFields("Outstanding Balance", "Oustanding Interest", "Interest Due");
            //SwizzFactory.FnGenerateRepaymentSchedule(LoansRegister."Loan  No.");

            // Case 1: Loan should be completed by ASAT (overdue)
            if LoansRegister."Expected Date of Completion" <= ASAT then begin
                LoanRepaymentSchedule.Reset;
                LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");

                if LoanRepaymentSchedule.FindLast then begin
                    // Principal: use the smaller of scheduled or actual outstanding
                    if LoanRepaymentSchedule."Principal Repayment" > LoansRegister."Outstanding Balance" then
                        INVESTMENTLOANp := ROUND(LoansRegister."Outstanding Balance", 1, '>')
                    else
                        INVESTMENTLOANp := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');

                    // Interest: default to outstanding interest
                    INVESTMENTLOANi := ROUND(LoansRegister."Oustanding Interest", 1, '>');

                    // But if scheduled principal is lower than outstanding, prefer monthly interest
                    if LoanRepaymentSchedule."Principal Repayment" < LoansRegister."Outstanding Balance" then
                        INVESTMENTLOANi := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
                end;

            end else
                // Case 2: Active loan disbursed before this month
                if LoansRegister."Loan Disbursement Date" < BeginMonth_Date then begin
                    LoanRepaymentSchedule.Reset;
                    LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
                    LoanRepaymentSchedule.SetFilter(LoanRepaymentSchedule."Repayment Date", '%1..%2', ASAT, CalcDate('CM', ASAT));

                    if LoanRepaymentSchedule.Find('-') then begin
                        INVESTMENTLOANi := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
                        INVESTMENTLOANp := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');
                    end;
                end else begin
                    LoanRepaymentSchedule.Reset;
                    LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");

                    if LoanRepaymentSchedule.FindLast then begin
                        // Principal: use the smaller of scheduled or actual outstanding
                        if LoanRepaymentSchedule."Principal Repayment" > LoansRegister."Outstanding Balance" then
                            INVESTMENTLOANp := ROUND(LoansRegister."Outstanding Balance", 1, '>')
                        else
                            INVESTMENTLOANp := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');

                        // Interest: default to outstanding interest
                        INVESTMENTLOANi := ROUND(LoansRegister."Oustanding Interest", 1, '>');

                        // But if scheduled principal is lower than outstanding, prefer monthly interest
                        if LoanRepaymentSchedule."Principal Repayment" < LoansRegister."Outstanding Balance" then
                            INVESTMENTLOANi := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
                    end;
                end;
        end;

        //INVESTMENT LOAN end=============================================================================================================================================
        //NORMAL LOAN start==========================================================================================================================================
        NORMALLOANp := 0;
        NORMALLOANi := 0;
        TotalMRepay := 0;

        LoansRegister.Reset;
        LoansRegister.SetRange("Client Code", Customer."No.");
        LoansRegister.SetRange("Loan Product Type", '21'); // Normal loans
        LoansRegister.SetAutocalcFields(LoansRegister."Outstanding Balance", LoansRegister."Oustanding Interest");
        LoansRegister.SetRange(LoansRegister.Posted, true);
        LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
        LoansRegister.SetCurrentKey("Client Code", "Application Date");
        LoansRegister.Ascending(false);

        if LoansRegister.FindSet then begin
            LoansRegister.CalcFields("Outstanding Balance", "Oustanding Interest", "Interest Due");
            //SwizzFactory.FnGenerateRepaymentSchedule(LoansRegister."Loan  No.");

            // Case 1: Loan should be completed by ASAT (overdue)
            if LoansRegister."Expected Date of Completion" <= ASAT then begin
                LoanRepaymentSchedule.Reset;
                LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");

                if LoanRepaymentSchedule.FindLast then begin
                    // Principal: use actual outstanding if smaller than scheduled
                    if LoanRepaymentSchedule."Principal Repayment" > LoansRegister."Outstanding Balance" then
                        NORMALLOANp := ROUND(LoansRegister."Outstanding Balance", 1, '>')
                    else
                        NORMALLOANp := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');

                    // Interest: default to outstanding interest
                    NORMALLOANi := ROUND(LoansRegister."Oustanding Interest", 1, '>');

                    // If scheduled principal < outstanding, use monthly interest
                    if LoanRepaymentSchedule."Principal Repayment" < LoansRegister."Outstanding Balance" then
                        NORMALLOANi := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
                end;

            end else
                // Case 2: Active loan disbursed before this month
                if LoansRegister."Loan Disbursement Date" < BeginMonth_Date then begin
                    LoansRegister.CalcFields("Outstanding Balance", "Oustanding Interest", "Interest Due");
                    LoanRepaymentSchedule.Reset;
                    LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
                    LoanRepaymentSchedule.SetFilter(LoanRepaymentSchedule."Repayment Date", '%1..%2', ASAT, CalcDate('CM', ASAT));

                    if LoanRepaymentSchedule.Find('-') then begin
                        NORMALLOANi := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
                        NORMALLOANp := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');
                    end;
                end else begin
                    LoanRepaymentSchedule.Reset;
                    LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");

                    if LoanRepaymentSchedule.FindLast then begin
                        // Principal: use actual outstanding if smaller than scheduled
                        if LoanRepaymentSchedule."Principal Repayment" > LoansRegister."Outstanding Balance" then
                            NORMALLOANp := ROUND(LoansRegister."Outstanding Balance", 1, '>')
                        else
                            NORMALLOANp := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');

                        // Interest: default to outstanding interest
                        NORMALLOANi := ROUND(LoansRegister."Oustanding Interest", 1, '>');

                        // If scheduled principal < outstanding, use monthly interest
                        if LoanRepaymentSchedule."Principal Repayment" < LoansRegister."Outstanding Balance" then
                            NORMALLOANi := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
                    end;
                end;
        end;

        //Development NORMAL 1 LOAN start==========================================================================================================================================
        DevelopmentLoanInt := 0;
        DevelopmentLoanP := 0;
        TotalMRepay := 0;

        LoansRegister.Reset;
        LoansRegister.SetRange("Client Code", Customer."No.");
        LoansRegister.SetRange("Loan Product Type", '25');
        LoansRegister.SetAutocalcFields(LoansRegister."Outstanding Balance", LoansRegister."Oustanding Interest");
        LoansRegister.SetRange(LoansRegister.Posted, true);
        LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
        LoansRegister.SetCurrentKey("Client Code", "Application Date");
        LoansRegister.Ascending(false);

        if LoansRegister.FindSet then begin
            LoansRegister.CalcFields("Outstanding Balance", "Oustanding Interest", "Interest Due");
            //SwizzFactory.FnGenerateRepaymentSchedule(LoansRegister."Loan  No.");

            if LoansRegister."Expected Date of Completion" <= ASAT then begin
                LoanRepaymentSchedule.Reset;
                LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");

                if LoanRepaymentSchedule.FindLast then begin
                    // Principal logic
                    if LoanRepaymentSchedule."Principal Repayment" > LoansRegister."Outstanding Balance" then
                        DevelopmentLoanP := ROUND(LoansRegister."Outstanding Balance", 1, '>')
                    else
                        DevelopmentLoanP := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');

                    // Interest logic
                    DevelopmentLoanInt := ROUND(LoansRegister."Oustanding Interest", 1, '>');
                    if LoanRepaymentSchedule."Principal Repayment" < LoansRegister."Outstanding Balance" then
                        DevelopmentLoanInt := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
                end;

            end else if LoansRegister."Loan Disbursement Date" < BeginMonth_Date then begin
                LoansRegister.CalcFields("Outstanding Balance", "Oustanding Interest", "Interest Due");

                LoanRepaymentSchedule.Reset;
                LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
                LoanRepaymentSchedule.SetFilter(LoanRepaymentSchedule."Repayment Date", '%1..%2', ASAT, CalcDate('CM', ASAT));

                if LoanRepaymentSchedule.Find('-') then begin
                    DevelopmentLoanInt := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
                    DevelopmentLoanP := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');
                end;
            end else begin
                LoanRepaymentSchedule.Reset;
                LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");

                if LoanRepaymentSchedule.FindLast then begin
                    // Principal logic
                    if LoanRepaymentSchedule."Principal Repayment" > LoansRegister."Outstanding Balance" then
                        DevelopmentLoanP := ROUND(LoansRegister."Outstanding Balance", 1, '>')
                    else
                        DevelopmentLoanP := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');

                    // Interest logic
                    DevelopmentLoanInt := ROUND(LoansRegister."Oustanding Interest", 1, '>');
                    if LoanRepaymentSchedule."Principal Repayment" < LoansRegister."Outstanding Balance" then
                        DevelopmentLoanInt := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
                end;
            end;
        end;
        //NORMAL 1 LOAN start==========================================================================================================================================
        NORMALLOAN1i := 0;
        NORMALLOAN1p := 0;
        TotalMRepay := 0;

        LoansRegister.Reset;
        LoansRegister.SetRange("Client Code", Customer."No.");
        LoansRegister.SetRange("Loan Product Type", '22');
        LoansRegister.SetAutocalcFields(LoansRegister."Outstanding Balance", LoansRegister."Oustanding Interest");
        LoansRegister.SetRange(LoansRegister.Posted, true);
        LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
        LoansRegister.SetCurrentKey("Client Code", "Application Date");
        LoansRegister.Ascending(false);

        if LoansRegister.FindSet then begin
            LoansRegister.CalcFields("Outstanding Balance", "Oustanding Interest", "Interest Due");
            //SwizzFactory.FnGenerateRepaymentSchedule(LoansRegister."Loan  No.");

            if LoansRegister."Expected Date of Completion" <= ASAT then begin
                LoanRepaymentSchedule.Reset;
                LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");

                if LoanRepaymentSchedule.FindLast then begin
                    // Principal logic
                    if LoanRepaymentSchedule."Principal Repayment" > LoansRegister."Outstanding Balance" then
                        NORMALLOAN1p := ROUND(LoansRegister."Outstanding Balance", 1, '>')
                    else
                        NORMALLOAN1p := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');

                    // Interest logic
                    NORMALLOAN1i := ROUND(LoansRegister."Oustanding Interest", 1, '>');
                    if LoanRepaymentSchedule."Principal Repayment" < LoansRegister."Outstanding Balance" then
                        NORMALLOAN1i := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
                end;

            end else if LoansRegister."Loan Disbursement Date" < BeginMonth_Date then begin
                LoansRegister.CalcFields("Outstanding Balance", "Oustanding Interest", "Interest Due");

                LoanRepaymentSchedule.Reset;
                LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
                LoanRepaymentSchedule.SetFilter(LoanRepaymentSchedule."Repayment Date", '%1..%2', ASAT, CalcDate('CM', ASAT));

                if LoanRepaymentSchedule.Find('-') then begin
                    NORMALLOAN1i := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
                    NORMALLOAN1p := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');
                end;
            end else begin
                LoanRepaymentSchedule.Reset;
                LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");

                if LoanRepaymentSchedule.FindLast then begin
                    // Principal logic
                    if LoanRepaymentSchedule."Principal Repayment" > LoansRegister."Outstanding Balance" then
                        NORMALLOAN1p := ROUND(LoansRegister."Outstanding Balance", 1, '>')
                    else
                        NORMALLOAN1p := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');

                    // Interest logic
                    NORMALLOAN1i := ROUND(LoansRegister."Oustanding Interest", 1, '>');
                    if LoanRepaymentSchedule."Principal Repayment" < LoansRegister."Outstanding Balance" then
                        NORMALLOAN1i := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
                end;
            end;
        end;

        MERCHANDISEPr := 0;
        MERCHANDISEIn := 0;
        TotalMRepay := 0;

        LoansRegister.Reset;
        LoansRegister.SetRange("Client Code", Customer."No.");
        LoansRegister.SetRange("Loan Product Type", '26');
        LoansRegister.SetAutocalcFields(LoansRegister."Outstanding Balance", LoansRegister."Oustanding Interest");
        LoansRegister.SetRange(LoansRegister.Posted, true);
        LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
        LoansRegister.SetCurrentKey("Client Code", "Application Date");
        LoansRegister.Ascending(false);

        if LoansRegister.FindSet then begin
            repeat
                //SwizzFactory.FnGenerateRepaymentSchedule(LoansRegister."Loan  No.");
                if LoansRegister."Loan Disbursement Date" < BeginMonth_Date then begin
                    LoansRegister.CalcFields("Outstanding Balance", "Oustanding Interest", "Interest Due");

                    // === PRINCIPAL ===
                    MERCHANDISEPr := MERCHANDISEPr + ROUND(LoansRegister."Loan Principle Repayment", 1, '>');

                    // === INTEREST DEFAULT CALCULATION ===
                    MERCHANDISEIn := MERCHANDISEIn + ROUND(LoansRegister."Outstanding Balance" / 12 * LoansRegister.Interest / 100, 1, '>');

                    // === AMORTIZED METHOD OVERRIDE ===
                    if LoansRegister."Repayment Method" = LoansRegister."repayment method"::Amortised then begin
                        TotalMRepay := ROUND(
                            (LoansRegister.Interest / 12 / 100) /
                            (1 - Power(1 + (LoansRegister.Interest / 12 / 100), -LoansRegister.Installments)) *
                            LoansRegister."Requested Amount", 0.05, '>');

                        // Set interest portion for amortized repayment
                        MERCHANDISEIn := ROUND(LoansRegister."Outstanding Balance" / 100 / 12 * LoansRegister.Interest, 1, '>');

                        // Principal is total monthly repay - interest
                        MERCHANDISEPr := ROUND(TotalMRepay - MERCHANDISEIn, 1, '>');
                    end;
                end;
            until LoansRegister.Next() = 0;
        end;



        TOTALREMMITANCE := 0;
        TOTALREMMITANCE := montlycon + "Welfare Contr" + ShareCapital + NORMALLOAN1i + NORMALLOANp + NORMALLOANi + NORMALLOAN1p + EMERGENCYp + EMERGENCYi + SUPEREMERGENCYp + SUPEREMERGENCYi + QUICKLOANp + QUICKLOANi + SUPERQUICKp + SUPERQUICKi + SCHOOLFEESp + SCHOOLFEESi + SUPERSCHOOLFEESp + SUPERSCHOOLFEESi +
        INVESTMENTLOANi + DevP + Devint + DevelopmentLoanP + DevelopmentLoanInt + MERCHANDISEPr + MERCHANDISEIn;

        exit(TOTALREMMITANCE);
    end;

    procedure CalculateLoanRepayment(
                                       LoanProductType: Code[10];
                                       var Principal: Decimal;
                                       var Interest: Decimal;
                                       CustomerNo: Code[20];
                                       ASAT: Date;
                                       BeginMonthDate: Date
                                       )
    var
        LoansRegister: Record "Loans Register";
        LoanRepaymentSchedule: Record "Loan Repayment Schedule";
    begin
        Principal := 0;
        Interest := 0;

        LoansRegister.Reset;
        LoansRegister.SetRange("Client Code", CustomerNo);
        LoansRegister.SetRange("Loan Product Type", LoanProductType);
        LoansRegister.SetAutocalcFields(LoansRegister."Outstanding Balance", LoansRegister."Oustanding Interest");
        LoansRegister.SetRange(LoansRegister.Posted, true);
        LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
        LoansRegister.SetCurrentKey("Client Code", "Application Date");
        LoansRegister.Ascending(false);

        if LoansRegister.FindSet then begin
            LoansRegister.CalcFields("Outstanding Balance", "Oustanding Interest", "Interest Due");
            //SwizzFactory.FnGenerateRepaymentSchedule(LoansRegister."Loan  No.");

            if LoansRegister."Expected Date of Completion" <= ASAT then begin
                LoanRepaymentSchedule.Reset;
                LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
                if LoanRepaymentSchedule.FindLast then begin
                    if LoanRepaymentSchedule."Principal Repayment" > LoansRegister."Outstanding Balance" then
                        Principal := ROUND(LoansRegister."Outstanding Balance", 1, '>')
                    else
                        Principal := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');

                    Interest := ROUND(LoansRegister."Oustanding Interest", 1, '>');
                    if LoanRepaymentSchedule."Principal Repayment" < LoansRegister."Outstanding Balance" then
                        Interest := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
                end;

            end else if LoansRegister."Loan Disbursement Date" < BeginMonthDate then begin
                LoanRepaymentSchedule.Reset;
                LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
                LoanRepaymentSchedule.SetFilter("Repayment Date", '%1..%2', ASAT, CalcDate('CM', ASAT));
                if LoanRepaymentSchedule.Find('-') then begin
                    Interest := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
                    Principal := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');
                end;
            end else begin
                LoanRepaymentSchedule.Reset;
                LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
                if LoanRepaymentSchedule.FindLast then begin
                    if LoanRepaymentSchedule."Principal Repayment" > LoansRegister."Outstanding Balance" then
                        Principal := ROUND(LoansRegister."Outstanding Balance", 1, '>')
                    else
                        Principal := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');

                    Interest := ROUND(LoansRegister."Oustanding Interest", 1, '>');
                    if LoanRepaymentSchedule."Principal Repayment" < LoansRegister."Outstanding Balance" then
                        Interest := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
                end;
            end;
        end;
    end;

    procedure CalculateLoanRepayment2(
      LoanProductType: Code[10];
      var Principal: Decimal;
      var Interest: Decimal;
      CustomerNo: Code[20];
      ASAT: Date;
      BeginMonthDate: Date
  )
    var
        LoansRegister: Record "Loans Register";
        LoanRepaymentSchedule: Record "Loan Repayment Schedule";
    begin
        Principal := 0;
        Interest := 0;

        LoansRegister.Reset;
        LoansRegister.SetRange("Client Code", CustomerNo);
        LoansRegister.SetRange("Loan Product Type", LoanProductType);
        LoansRegister.SetAutocalcFields(LoansRegister."Outstanding Balance", LoansRegister."Oustanding Interest");
        LoansRegister.SetRange(LoansRegister.Posted, true);
        LoansRegister.SetFilter("Outstanding Balance", '>%1', 0);
        LoansRegister.SetCurrentKey("Client Code", "Application Date");
        LoansRegister.Ascending(false);

        if not LoansRegister.FindFirst then
            exit;

        //SwizzFactory.FnGenerateRepaymentSchedule(LoansRegister."Loan  No.");
        LoansRegister.CalcFields("Outstanding Balance", "Oustanding Interest", "Interest Due");

        if LoansRegister."Outstanding Balance" <= 1 then
            exit;

        if LoansRegister."Expected Date of Completion" <= ASAT then begin
            // Case 1: Loan expected to end on or before ASAT
            LoanRepaymentSchedule.Reset;
            LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");

            if LoanRepaymentSchedule.FindLast then begin
                if LoanRepaymentSchedule."Principal Repayment" > LoansRegister."Outstanding Balance" then
                    Principal := ROUND(LoansRegister."Outstanding Balance", 1, '>')
                else
                    Principal := LoanRepaymentSchedule."Principal Repayment";

                Interest := ROUND(LoansRegister."Oustanding Interest", 1, '>');
                if LoanRepaymentSchedule."Principal Repayment" < LoansRegister."Outstanding Balance" then
                    Interest := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
            end;

        end else if LoansRegister."Loan Disbursement Date" < BeginMonthDate then begin
            // Case 2: Active long-term loan, disbursed before current month
            LoanRepaymentSchedule.Reset;
            LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");
            LoanRepaymentSchedule.SetFilter("Repayment Date", '%1..%2', ASAT, CalcDate('CM', ASAT));

            if LoanRepaymentSchedule.Find('-') then begin
                Principal := ROUND(LoanRepaymentSchedule."Principal Repayment", 1, '>');
                Interest := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
            end;

        end else begin
            // Case 3: Loan expected to complete in the future and not disbursed before the month
            Principal := 0;
            Interest := 0;
            LoanRepaymentSchedule.Reset;
            LoanRepaymentSchedule.SetRange("Loan No.", LoansRegister."Loan  No.");

            if LoanRepaymentSchedule.FindLast then begin
                if LoanRepaymentSchedule."Principal Repayment" > LoansRegister."Outstanding Balance" then
                    Principal := ROUND(LoansRegister."Outstanding Balance", 1, '>')
                else
                    Principal := LoanRepaymentSchedule."Principal Repayment";

                Interest := ROUND(LoansRegister."Oustanding Interest", 1, '>');
                if LoanRepaymentSchedule."Principal Repayment" < LoansRegister."Outstanding Balance" then
                    Interest := ROUND(LoanRepaymentSchedule."Monthly Interest", 1, '>');
            end;
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


    procedure FnMemberDefaultStatement(MemberNo: Code[50]; var BigText: BigText) exitString: Text
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


    procedure fnFosaStatement(MemberNo: Code[50]; "filter": Text; var BigText: BigText) exitString: Text
    var
        Filename: Text[100];
        Outputstream: OutStream;
        RecRef: RecordRef;
        TempBlob: Codeunit "Temp Blob";
        Outstr: OutStream;
        Instr: InStream;
        Base64Convert: Codeunit "Base64 Convert";
    begin
        Vendor.Reset;
        Vendor.SetRange(Vendor."No.", MemberNo);
        Vendor.SetFilter("Date Filter", filter);
        if Vendor.Find('-') then begin
            RecRef.GetTable(Vendor);
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

    procedure FnGetLoanProductJson(productType: Text) response: Text
    var
        loansData: Text;
    begin
        BEGIN
            loansData := '';
            Loansetup.RESET;
            Loansetup.SETRANGE(Code, productType);
            IF Loansetup.FIND('-') THEN BEGIN
                loansData := '"MinLoanAmount":"' + FORMAT(Loansetup."Min. Loan Amount") + '"'
                            + '"MaxLoanAmount":"' + FORMAT(Loansetup."Max. Loan Amount") + '"'
                            + '"InterestRate":"' + FORMAT(Loansetup."Interest rate") + '"'
                            + '"Installment":"' + FORMAT(Loansetup."No of Installment") + '"';
                response := loansData;//FORMAT(Loansetup."Min. Loan Amount") + ':::' + FORMAT(Loansetup."Max. Loan Amount") + ':::' + FORMAT(Loansetup."Interest rate") + ':::' + FORMAT(Loansetup."No of Installment");
            END;
        END;
    end;

    procedure FnGetMonthlyDeductionOld(MemberNo: Code[20]) Amount: Decimal
    begin
        Amount := 0;
        objMember.RESET();
        objMember.SETRANGE(objMember."No.", MemberNo);
        IF objMember.FIND('-') THEN BEGIN
            Amount += objMember."Monthly Contribution";

            objLoanRegister.RESET();
            objLoanRegister.SETRANGE("Client Code", objMember."No.");
            objLoanRegister.SETFILTER("Outstanding Balance", '>%1', 0);
            IF objLoanRegister.FINDSET() THEN BEGIN
                REPEAT
                    Amount += objLoanRegister.Repayment;
                UNTIL objLoanRegister.NEXT = 0;
            END;
            EXIT(Amount);
        END;
    end;

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
            if Report.SaveAs(Report::"Loans Guaranteed Report", '', ReportFormat::Pdf, Outstr, RecRef) then begin
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
            if Report.SaveAs(Report::"Members Loans Guarantors", '', ReportFormat::Pdf, Outstr, RecRef) then begin
                exitString := Base64Convert.ToBase64(Instr);
                exit;
            end;
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

    procedure fnRunningLoans(memberNumber: Code[20]) runningLoans: Text
    var
        balancesText: Text;
    begin
        balancesText := '';
        objLoanRegister.RESET;
        objLoanRegister.SETRANGE(objLoanRegister."BOSA No", memberNumber);
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

    procedure FnRegisterKin("Full Names": Text; Relationship: Text; "ID Number": Code[10]; "Phone Contact": Code[10]; Address: Text; Idnomemberapp: Code[10])
    begin
        begin
            objRegMember.Reset;
            objNextKin.Reset;
            objNextKin.Init();
            objRegMember.SetRange("ID No.", Idnomemberapp);
            if objRegMember.Find('-') then begin
                objNextKin."Account No" := objRegMember."No.";
                objNextKin.Name := "Full Names";
                objNextKin.Relationship := Relationship;
                objNextKin."Id No." := "ID Number";
                objNextKin.Telephone := "Phone Contact";
                objNextKin.Insert(true);
            end;
        end;
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
        onlineloans.SetRange(onlineloans."Application Status", onlineloans."Application Status"::Application);
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
                    + ',"InterestCalculationMethod":"' + FORMAT(onlineloans."Interest Calculation Method") + '"'
                    + '}';
                end else begin
                    balancesText := balancesText + ',{'
                    + '"LoanNo":"' + FORMAT(onlineloans."Application No") + '"'
                    + ',"ProductType":"' + onlineloans."Loan Type" + '"'
                    + ',"ProductName":"' + onlineloans."Loan Product Type Name" + '"'
                    + ',"Installments":"' + FORMAT(onlineloans."Repayment Period") + '"'
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
        onlineloans.SetRange(onlineloans."Application Status", onlineloans."Application Status"::Application);
        IF onlineloans.FIND('-') THEN BEGIN
            loanData := '{'
                    + '"LoanNo":"' + FORMAT(onlineloans."Application No") + '"'
                    + ',"ProductType":"' + onlineloans."Loan Type" + '"'
                    + ',"ProductName":"' + onlineloans."Loan Product Type Name" + '"'
                    + ',"Installments":"' + FORMAT(onlineloans."Repayment Period") + '"'
                    + ',"InterestRate":"' + FORMAT(onlineloans."Interest Rate") + '"'
                    + ',"RequestedAmount":"' + FORMAT(onlineloans."Loan Amount") + '"'
                    + ',"InterestCalculationMethod":"' + FORMAT(onlineloans."Interest Calculation Method") + '"'
                    + ',"ApplicationDate":"' + FORMAT(onlineloans."Application Date") + '"'
                    + '}';
        END;
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
                  + Format(StartDate) + '. Thanks for using BAMBURI SACCO Portal.';
            FnSMSMessage(SourceAcc, phoneNumber, sms);
            //MESSAGE('All Cool');
        end
    end;

    procedure fnAccountInfo2(Memberno: Code[20]) info: Text
    begin
        objMember.RESET;
        objMember.SETRANGE(objMember."No.", Memberno);

        IF objMember.FIND('-') THEN BEGIN

            // FOSAbal:=FNFosaBalance(objMember."FOSA Account No.");
            objMember.CALCFIELDS(objMember."Shares Retained");// "Total Committed Shares");
            objMember.CALCFIELDS(objMember."Current Shares");
            //objMember.CALCFIELDS("Demand Savings");
            objMember.CALCFIELDS(objMember."Shares Retained");
            info := FORMAT(objMember."Current Shares") + ':' + FORMAT(objMember."Shares Retained") + ':' + FORMAT(objMember."Risk Fund") + ':' + FORMAT(objMember."Dividend Amount") + ':' + FORMAT(objMember."FOSA Account No.")
            + ':' + FORMAT(objMember."Current Shares" - objMember."Shares Retained");
        END;
    end;

    procedure fnLoanBalancesJson(MemberNo: Code[20]) loans: Text
    var
        balancesText: Text;
    begin
        balancesText := '';
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
                if balancesText = '' then begin
                    balancesText := '"LoanNo":"' + FORMAT(objLoanRegister."Loan  No.") + '"'
                    + '"LoanProductType":"' + objLoanRegister."Loan Product Type" + '"'
                    + '"Installments":"' + FORMAT(objLoanRegister.Installments) + '"'
                    + '"RemainingPeriod":"' + FORMAT(objLoanRegister.Installments - Loanperiod) + '"'
                    + '"RequestedAmount":"' + FORMAT(objLoanRegister."Requested Amount") + '"'
                    + '"ApprovalStatus":"' + FORMAT(objLoanRegister."Approval Status") + '"';
                end else begin
                    balancesText := balancesText + '"LoanNo":"' + FORMAT(objLoanRegister."Loan  No.") + '"'
                + '"LoanProductType":"' + objLoanRegister."Loan Product Type" + '"'
                + '"Installments":"' + FORMAT(objLoanRegister.Installments) + '"'
                + '"RemainingPeriod":"' + FORMAT(objLoanRegister.Installments - Loanperiod) + '"'
                + '"RequestedAmount":"' + FORMAT(objLoanRegister."Requested Amount") + '"'
                + '"ApprovalStatus":"' + FORMAT(objLoanRegister."Approval Status") + '"';
                end;
            // loans := loans + objLoanRegister."Loan Product Type" + ':' + FORMAT(objLoanRegister."Outstanding Balance") + ':' + FORMAT(objLoanRegister."Loans Category-SASRA") + ':' + FORMAT(objLoanRegister.Installments) + ':'
            // + FORMAT(objLoanRegister.Installments - Loanperiod) + ':' + FORMAT(objLoanRegister."Outstanding Balance") + ':' + FORMAT(objLoanRegister."Requested Amount") + ':' + FORMAT(objLoanRegister."Loan  No.") + ':' + FORMAT(objLoanRegister."Approval Status")
            // + ':' + FORMAT(objLoanRegister."Amount Disbursed") + ':' + FORMAT(objLoanRegister."Approved Amount") + '::'

            UNTIL
            objLoanRegister.NEXT = 0;
            loans := balancesText;
        END;
    end;

    procedure FnGetMemberProfile(MemberNo: Code[30]) info: Text
    begin
        objMember.RESET;
        objMember.SETRANGE(objMember."No.", MemberNo);
        IF objMember.FIND('-') THEN BEGIN
            info := objMember."No." + ':' + objMember.Name + ':' + objMember."E-Mail" + ':' + FORMAT(objMember.Status) + ':' + objMember."Mobile Phone No"
             + ':' + objMember."ID No." + ':' + FORMAT(objMember."Date of Birth") + ':' + FORMAT(objMember."Personal No") + ':' + FORMAT(objMember.Gender) + ':' + FORMAT(objMember.Pin) + ':'
             + FORMAT(objMember."Country/Region Code") + ':' + FORMAT(objMember.City) + ':' + FORMAT(objMember."Registration Date") + ':' + FORMAT(objMember."Bank Code") + ':'
             + FORMAT(objMember."Bank Code") + ':' + FORMAT(objMember."Bank Branch Code") + ':' + FORMAT(objMember."Bank Branch Code") + ':' + FORMAT(objMember."Bank Account No.");
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

    procedure FnGetNOKProfile(MemberNo: Code[20]) info: Text
    var
        accountsList: Text;
    begin
        accountsList := '';
        objMember.RESET;
        objMember.SETRANGE(objMember."No.", MemberNo);
        IF objMember.FIND('-') THEN BEGIN
            objNextKin.RESET();
            objNextKin.SETRANGE("Account No", objMember."No.");
            IF objNextKin.FIND('-') THEN BEGIN
                REPEAT
                    // info := info + FORMAT(objNextKin.Name) + ':' + FORMAT(objNextKin."Date of Birth") + ':' + FORMAT(objNextKin."%Allocation") + ':' + FORMAT(objNextKin.Relationship) + '::';
                    info := '';
                    IF accountsList = '' THEN BEGIN
                        accountsList := '{ "KinName":"' + FORMAT(objNextKin.Name) + '","DateofBirth":"' + FORMAT(objNextKin."Date of Birth") + '","Allocation":"' + FORMAT(objNextKin."%Allocation") + '","Relationship":"' + FORMAT(objNextKin.Relationship) + '" }';
                    END ELSE BEGIN
                        accountsList += ',{ "KinName":"' + FORMAT(objNextKin.Name) + '","DateofBirth":"' + FORMAT(objNextKin."Date of Birth") + '","Allocation":"' + FORMAT(objNextKin."%Allocation") + '","Relationship":"' + FORMAT(objNextKin.Relationship) + '" }';
                    END;
                UNTIL objNextKin.NEXT() = 0;
            END;
            info := accountsList;
        END;
    end;

    procedure FnUpdateMonthlyContrib("Member No": Code[30]; "Updated Fig": Decimal)
    begin
        objMember.Reset;
        objMember.SetRange(objMember."No.", "Member No");

        if objMember.Find('-') then begin
            phoneNumber := objMember."Phone No.";
            FAccNo := objMember."FOSA Account No.";
            objMember."Monthly Contribution" := "Updated Fig";
            objMember.Modify;
            sms := 'You have adjusted your monthly contributions to: ' + Format("Updated Fig") + ' account number ' + FAccNo +
                  '. Thank you for using Bamburi Sacco Portal';
            FnSMSMessage(FAccNo, phoneNumber, sms);

            //MESSAGE('Updated');
        end
    end;


    procedure FnSMSMessage(accfrom: Text[30]; phone: Text[20]; message: Text[250])
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
        SMSMessages."Sent To Server" := SMSMessages."sent to server"::No;// PENDING;
        SMSMessages."SMS Message" := message;
        SMSMessages."Telephone No" := phone;
        if SMSMessages."Telephone No" <> '' then
            SMSMessages.Insert;

        SendMail(accfrom,
        message);
    end;

    procedure SendMail(accfrom: Text[70]; message: Code[2000])
    var
        EmailBody: Text[1000];
        EmailSubject: Text[100];
        Emailaddress: Text[100];
        Companyinfo: Record "Company Information";
        memberRegister: Record Customer;
        memberName: Text;
        EmailCodeunit: Codeunit Emailcodeunit;
    begin
        memberRegister.Reset();
        memberRegister.SetRange(memberRegister."No.", accfrom);
        if memberRegister.Find('-') then begin
            Emailaddress := memberRegister."E-Mail";
            Emailaddress := memberRegister."E-Mail (Personal)";
            memberName := memberRegister.Name;
        end;
        EmailSubject := 'Bamburi Portal Notification';
        CompanyInfo.Get();

        EMailBody := 'Dear <b>' + memberName + '</b>,</br></br>' +
            message + '</br>' +
            ' Thank You For Choosing to Save With Us ' + '</br>' +
            'Kind regards, ' + '<br></br>' +

            Companyinfo.Name + ' </br>' + Companyinfo."Address 2" + ' </br>' + Companyinfo.City + ' </br>' +
            Companyinfo."Post Code" + ' </br>' + Companyinfo."Country/Region Code" + ' </br>' +
            Companyinfo."Phone No." + ' </br>' + Companyinfo."E-Mail";
        if Emailaddress <> '' then
            EmailCodeunit.SendMail(Emailaddress, EmailSubject, EmailBody);
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

    procedure MemberAccountDetails(MemberNo: Code[20]) info: Text
    begin
        objMember.Reset;
        objMember.SetRange(objMember."No.", MemberNo);
        if objMember.Find('-') then begin

            info := '{ "MemberNumber":"' + objMember."No." +
                      '","MemberName":"' + objMember.Name +
                      '","EmailAddress":"' + FORMAT(objMember."E-Mail") +
                      '","AccountStatus":"' + FORMAT(objMember.Status) +
                      '","MobileNumber":"' + FORMAT(objMember."Mobile Phone No") +
                      '","IdNumber":"' + FORMAT(objMember."ID No.") +
                      '","AccountCategory":"' + FORMAT(objMember."Account Category") +
                      '","FosaAccount":"' + FORMAT(objMember."FOSA Account No.") +
                      '","DateofBirth":"' + Format(objMember."Date of Birth") +
                      '","Gender":"' + FORMAT(objMember.Gender) + '" }';
        end;
    end;

    procedure MemberAccountStatistics(MemberNo: Code[20]) info: Text
    var
        memberGuarantorshipAbility: Decimal;
        selfGuarantorshipAbility: Decimal;
        guarantorshipMngt: Codeunit "Guarantor Management";
    begin
        objMember.Reset;
        objMember.SetRange(objMember."No.", MemberNo);
        if objMember.Find('-') then begin
            objMember.CalcFields("Current Shares");
            objMember.CalcFields("Shares Retained");
            objMember.CalcFields("FOSA Account Bal");
            objMember.CalcFields("Outstanding Balance");
            objMember.CalcFields("Outstanding Interest");
            objMember.CalcFields("Total Arrears");
            objMember.CalcFields("Holiday Savings");
            memberGuarantorshipAbility := guarantorshipMngt.fnGetMemberGuarantorshipLiability(objMember."No.");
            selfGuarantorshipAbility := guarantorshipMngt.fnGetMemberSelfGuarantorshipLiability(objMember."No.");
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
                    '","MemberGuarantorshipAbility":"' + FORMAT(memberGuarantorshipAbility) +
                    '","SelfGuarantorshipAbility":"' + FORMAT(selfGuarantorshipAbility) +
                    '" }';
        end;
    end;

    procedure fnloaninfo(Memberno: Code[20]) info: Text
    begin
        objMember.Reset;
        objMember.SetRange(objMember."No.", Memberno);
        // objMember.Get(objMember."FOSA Account No.");
        if objMember.Find('-') then begin
            // Message('fosa %1', objMember."FOSA Account No.");
            objMember.CalcFields("Outstanding Balance");
            objMember.CalcFields("Outstanding Interest");
            // objMember.CalcFields("Outstanding Loan FOSA", "Outstanding Interest FOSA");
            info := Format(objMember."Outstanding Balance") + ':' + Format(objMember."Outstanding Interest");// + ':' + Format(200) + ':' + Format(objMember."FOSA Oustanding Interest")
        end;
    end;


    procedure fnLoans2(MemberNo: Code[20]) loans: Text
    begin
        objLoanRegister.Reset;
        objLoanRegister.SetRange("Client Code", MemberNo);
        //objLoanRegister.SETFILTER("Loan Product Type Name",'');
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
                    LInterest := ROUND((Loansetup."Interest rate" / 12 / 100) * LBalance, 0.05, '>');
                    TotalMRepay := LPrincipal + LInterest;
                    InstallmentCounts := InstallmentCounts + 1;
                    LBalance := LBalance - LPrincipal;  // reduce immediately, no if/else
                    Date := CalcDate('+1M', Date);
                    text := text + Format(Date) + '!!' + Format(ROUND(LPrincipal)) + '!!' + Format(ROUND(LInterest)) + '!!' + Format(ROUND(TotalMRepay)) + '!!' + Format(ROUND(LoanAmount)) + '!!' + Format(ROUND(LBalance)) + '??';
                until InstallmentCounts = RepayPeriod;
            end;
            //--------------------------------------------------------------------------------------------------------- 
            if Loansetup."Repayment Method" = Loansetup."repayment method"::"One-Time" then begin
                Date := Today;
                InstallmentCounts := 0;
                LBalance := LoanAmount;
                repeat
                    Date := CalcDate('+1M', Date);
                    InstallmentCounts := InstallmentCounts + 1;
                until InstallmentCounts = RepayPeriod;
                LPrincipal := LoanAmount;
                LInterest := ROUND((Loansetup."Interest rate" / 100) * LoanAmount, 0.05, '>');
                TotalMRepay := LPrincipal + LInterest;
                LBalance := 0;
                text := text + Format(Date) + '!!' + Format(ROUND(LPrincipal)) + '!!' + Format(ROUND(LInterest)) + '!!' + Format(ROUND(TotalMRepay)) + '!!' + Format(ROUND(LoanAmount)) + '!!' + Format(ROUND(LBalance)) + '??';
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


    procedure FnloansProducts() loanType: Text
    begin
        Loansetup.Reset;
        Loansetup.SETRANGE(Source, Loansetup.Source::BOSA);
        if Loansetup.Find('-') then begin
            //loanType:='';
            repeat
                loanType := Format(Loansetup.Code) + ':' + Loansetup."Product Description" + ':::' + loanType;
            //   loanType:=loanType+Loansetup."Product Description"+'!!'+ FORMAT(Loansetup."Repayment Method")+'!!'+FORMAT(Loansetup."Max. Loan Amount")+'!!'+FORMAT(Loansetup."Instalment Period")+'!!'+FORMAT(Loansetup."Interest rate")+'!!'
            //  +FORMAT(Loansetup."Repayment Frequency")+'??';
            until Loansetup.Next = 0;
        end;
    end;


    procedure Fnloanssetup() loanType: Text
    begin
        Loansetup.Reset;
        Loansetup.SETRANGE(Source, Loansetup.Source::BOSA);
        if Loansetup.Find('-') then begin
            //loanType:='';
            repeat
                loanType := Format(Loansetup.Code) + ':' + Loansetup."Product Description" + ':::' + loanType;
            //   loanType:=loanType+Loansetup."Product Description"+'!!'+ FORMAT(Loansetup."Repayment Method")+'!!'+FORMAT(Loansetup."Max. Loan Amount")+'!!'+FORMAT(Loansetup."Instalment Period")+'!!'+FORMAT(Loansetup."Interest rate")+'!!'
            //  +FORMAT(Loansetup."Repayment Frequency")+'??';
            until Loansetup.Next = 0;
        end;
    end;


    procedure fnLoanDetails2(Loancode: Code[20]) loandetail: Text
    begin
        Loansetup.Reset;
        Loansetup.SetRange("Loan Calculator", true);
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

    procedure editOnlineLoan(loanNumber: Code[20]; memberNumber: Code[20]; amountRequest: Decimal; loanType: Code[20]; repaymentPeriod: Integer) response: Text;
    var
        onlineLoanTable: Record "Online Loan Application";
    begin
        response := 'failed to update the loan details';

        onlineLoanTable.Reset();
        onlineLoanTable.SetRange(onlineLoanTable."Application No", loanNumber);
        onlineLoanTable.SetRange(onlineLoanTable."BOSA No", memberNumber);
        if onlineLoanTable.Find('-') then begin
            if onlineLoanTable.Posted = true then
                response := 'You cannot edit this loan, Already submited';
            exit;

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
            response := 'Could not find such a loan, please contact the administrator.'
        end;
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
            onlineLoanTable.Modify();

            isDeleted := true;
            exit;
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


    procedure fnFundsTransfer(Acountfrom: Code[20]; AccountTo: Code[20]; Amount: Decimal; DocNo: Code[20]) result: Text
    begin
        // result := CloudPesaLive.FundsTransferFOSA(Acountfrom, AccountTo, DocNo, Amount);
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
                return := return + objNextKin.Name + ':::' + objNextKin.Relationship + ':::' + objNextKin.Email + ':::' + Format(objNextKin."%Allocation") + '::::';
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


    procedure OnlineLoanApplication(BosaNo: Code[30]; LoanType: Code[100]; LoanAmount: Decimal; loanpurpose: Text; repaymentPeriod: Integer) GeneratedApplicationNo: Code[20]
    var
        ObjLoanApplications: Record "Online Loan Application";
    begin
        //check defaulter status,
        //same loan product, in application or applied
        //check arrears
        //check all parameters, 6 month, min, max, installments, 
        //pre qualify



        ObjLoanApplications.Reset;

        LoanProductType.Get(LoanType);

        objMember.Reset;
        objMember.SetRange(objMember."No.", BosaNo);
        if objMember.Find('-') then begin

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

    procedure fnEditMemberDetails(
     memberNumber: Code[20];
     fullNames: Code[100];
     phoneNumber: Code[20];
     email: Code[250];
     IDNumber: Code[20];
     KRAPin: Code[20];
     kinName: Text[100];
     kinDOB: Date;
    //  kinAllocation: Decimal;
     kinRelationship: Text[50]
 ) isEdited: Boolean
    var
        customer: Record Customer;
        objNextKin: Record "Members Next Kin Details";
    begin
        isEdited := false;
        customer.Reset();
        customer.SetRange("No.", memberNumber);
        if customer.FindFirst() then begin
            if fullNames <> '' then
                customer.Name := fullNames;
            if phoneNumber <> '' then
                customer."Mobile Phone No." := phoneNumber;
            if email <> '' then
                customer."E-Mail (Personal)" := email;
            if IDNumber <> '' then
                customer."ID No." := IDNumber;
            if KRAPin <> '' then
                customer.Pin := KRAPin;
            customer.Modify(true);
            isEdited := true;
            if (kinName <> '') or (kinDOB <> 0D) or (kinRelationship <> '') then begin
                objNextKin.Init();
                objNextKin."Account No" := customer."No.";
                objNextKin.Name := kinName;
                objNextKin."Date of Birth" := kinDOB;
                // objNextKin."%Allocation" := kinAllocation;
                objNextKin.Relationship := kinRelationship;
                objNextKin.Insert(true);
            end;
        end;
    end;

    procedure SubmitLoan(memberNumber: Code[20]; loanNumber: Code[20]) response: Text;
    var
        localsms: Text;
    begin
        response := 'Failed, Please try again Later';
        if objMember.Get(memberNumber) then begin
            objMember.CalcFields("Total Arrears");
            if objMember."Total Arrears" > 0 then begin
                response := 'Failed, You cannot apply for a loan because you have arrears of ' +
                            Format(objMember."Total Arrears") +
                            '. Please contact the office for assistance.';
                exit;
            end;
            ObjLoanApplications.Reset;
            ObjLoanApplications.SetRange(ObjLoanApplications."Application No", loanNumber);
            ObjLoanApplications.SetRange("BOSA No", memberNumber);
            if ObjLoanApplications.Find('-') then begin
                if ObjLoanApplications."Application Status" <> ObjLoanApplications."Application Status"::Application then begin
                    response := 'Failed, This loan has already been submitted';
                    exit;
                end;
                OnlineLoanGuarantors.Reset();
                OnlineLoanGuarantors.SetRange(OnlineLoanGuarantors."Loan Application No", loanNumber);
                if OnlineLoanGuarantors.Find('-') then begin
                    repeat
                        if OnlineLoanGuarantors.Approved <> OnlineLoanGuarantors.Approved::Approved then begin
                            response := '{ "StatusCode":"400", "StatusDescription":"Failed", "Message":"You cannot submit the loan until all the Guarantors have Accepted your Request" }';
                            exit;
                        end;
                    until OnlineLoanGuarantors.Next = 0;
                end;
                ObjLoansregister.Init();
                ObjLoansregister."Client Code" := ObjLoanApplications."BOSA No";
                ObjLoansregister.Source := ObjLoansregister.Source::BOSA;
                ObjLoansregister."Application Date" := ObjLoanApplications."Application Date";
                ObjLoansregister."Loan Product Type" := ObjLoanApplications."Loan Type";
                ObjLoansregister."Loan Status" := ObjLoansregister."Loan Status"::Application;
                ObjLoansregister.Posted := false;
                ObjLoansregister."Approval Status" := ObjLoansregister."Approval Status"::Open;
                ObjLoansregister.Installments := ObjLoanApplications."Repayment Period";
                ObjLoansregister."Requested Amount" := ObjLoanApplications."Loan Amount";
                if ObjLoansregister.Insert(true) then begin
                    ObjLoanApplications."Sent To Bosa Loans" := true;
                    ObjLoanApplications.submitted := true;
                    ObjLoanApplications."Application Status" := ObjLoanApplications."Application Status"::Submitted;
                    ObjLoanApplications.Posted := true;
                    ObjLoanApplications.Modify(true);
                    OnlineLoanGuarantors.Reset();
                    OnlineLoanGuarantors.SetRange(OnlineLoanGuarantors."Loan Application No", loanNumber);
                    OnlineLoanGuarantors.SetRange(OnlineLoanGuarantors.Approved, OnlineLoanGuarantors.Approved::Approved);
                    if OnlineLoanGuarantors.Find('-') then begin
                        repeat
                            submitGuarantors(OnlineLoanGuarantors."Member No", loanNumber, ObjLoansregister."Loan  No.");
                        until OnlineLoanGuarantors.Next = 0;
                    end;
                    localsms := 'Dear Member, you have submitted Loan ' +
                                Format(ObjLoanApplications."Application No") +
                                ' for loan type ' + ObjLoanApplications."Loan Type" +
                                '. Your loan application has been submitted for appraisal.';
                    if (objMember."Phone No." <> '') then
                        FnSMSMessage(ClientName, objMember."Phone No.", localsms);
                    response := 'Success, your loan has been submitted to Credit for Appraisal';
                end else begin
                    response := 'Failed, Please contact the office for assistance';
                end;
            end;
        end;
    end;

    procedure submitGuarantors(memberNumber: Code[20]; loanNumber: Code[20]; loanNo: Code[20])
    var
        loanGuarantors: Record "Loans Guarantee Details";
    begin
        OnlineLoanGuarantors.Reset();
        OnlineLoanGuarantors.SetRange(OnlineLoanGuarantors."Loan Application No", loanNumber);
        if OnlineLoanGuarantors.Find('-') then begin
            loanGuarantors.Init();
            loanGuarantors."Loan No" := loanNo;
            loanGuarantors."Account No." := OnlineLoanGuarantors."Member No";
            loanGuarantors."Member No" := OnlineLoanGuarantors."Member No";
            loanGuarantors."Amont Guaranteed" := OnlineLoanGuarantors.Amount;
            loanGuarantors.Validate(loanGuarantors."Member No");
            loanGuarantors.Validate(loanGuarantors."Amont Guaranteed");
            loanGuarantors.Insert(true);

            // OnlineLoanGuarantors
        end;

    end;

    procedure FnRequestGuarantorship(BosaNo: Code[30]; LoanNumber: Code[20]; Amount: Decimal) guaranteed: Boolean
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
                OnlineLoanGuarantors.Amount := Amount;
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


    procedure ApproveGuarantorship(MemberNo: Text; LoanNo: Code[20]; ApprovedStatus: Integer): Text
    begin
        OnlineLoanGuarantors.Reset;
        OnlineLoanGuarantors.SetRange(OnlineLoanGuarantors."Loan Application No", LoanNo);
        OnlineLoanGuarantors.SetRange(OnlineLoanGuarantors."Member No", MemberNo);
        if OnlineLoanGuarantors.Find('-') then begin

            //Rejected
            if ApprovedStatus = 0 then begin
                OnlineLoanGuarantors.Approved := OnlineLoanGuarantors.Approved::Approved;
                // OnlineLoanGuarantors.Amount := Amount;
                OnlineLoanGuarantors."Approval Status" := true;
                OnlineLoanGuarantors.Modify;

                ReturnList := 'Dear Member, your loan guarantorship have been approved by,' + OnlineLoanGuarantors.Names + '. Login to members portal to Submit for appraisal ';
                FnSMSMessage('WebPortal', objMember."Mobile Phone No", ReturnList);
            end else if ApprovedStatus = 1 then begin
                OnlineLoanGuarantors.Approved := OnlineLoanGuarantors.Approved::Rejected;
                // OnlineLoanGuarantors.Amount := Amount;
                OnlineLoanGuarantors."Approval Status" := false;
                OnlineLoanGuarantors.Modify;

                ReturnList := 'Dear Member, you have rejected loan Guarantorship.';
                FnSMSMessage('WebPortal', objMember."Mobile Phone No", ReturnList);
            end;
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
        GuaranteedT: Decimal;
        TotalLoans: Decimal;
        Multiplier: Decimal;
    begin
        ReturnDecimal := 0;
        objMember.Reset;
        objMember.SetRange(objMember."No.", BosaNo);
        if objMember.Find('-') then begin

            if LoanProductType.Get(LoanProdType) then begin
                Message('test2 %1', LoanProdType);
                Deposits := FnGetMemberTotalDeposits(BosaNo);
                Message('test3 %1', Deposits);
                DepositsM := Deposits * LoanProductType."Deposits Multiplier";
                Message('test %4', DepositsM);
                TotalLoans := FnGetLoanBalance(BosaNo);
                Message('test %5', TotalLoans);
                ReturnDecimal := DepositsM - TotalLoans;
                Message('test%6', ReturnDecimal);
                if ReturnDecimal < 0 then ReturnDecimal := 0;
            end;
        end;
        exit(ReturnDecimal);
    end;


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

    procedure fnLoansTracking()
    begin

    end;
    //Board Portal Modules....
    #region Board
    procedure fnLoansInAppraisal(memberNumber: Code[20]) runningLoans: Text
    var
        balancesText: Text;
        requestedLoans: Record "Loans Register";
    begin
        balancesText := '';
        requestedLoans.RESET;
        // requestedLoans.SETRANGE(requestedLoans."BOSA No", memberNumber);
        requestedLoans.SETFILTER(requestedLoans.Posted, '%1', false);
        // requestedLoans.SETFILTER(requestedLoans.submitted, '%1', false);
        requestedLoans.SetRange(requestedLoans."Loan Status", requestedLoans."Loan Status"::Application);
        IF requestedLoans.FIND('-') THEN BEGIN
            requestedLoans.ASCENDING(TRUE);
            REPEAT
                if balancesText = '' then begin
                    balancesText := '{'
                    + '"LoanNo":"' + FORMAT(requestedLoans."Loan  No.") + '"'
                    + ',"ProductType":"' + requestedLoans."Loan Product Type" + '"'
                    + ',"ProductName":"' + requestedLoans."Loan Product Type Name" + '"'
                    + ',"Installments":"' + FORMAT(requestedLoans.Installments) + '"'
                    + ',"InterestRate":"' + FORMAT(requestedLoans."Interest") + '"'
                    + ',"RequestedAmount":"' + FORMAT(requestedLoans."Loan Amount") + '"'
                    + ',"InterestCalculationMethod":"' + FORMAT(requestedLoans."Interest Calculation Method") + '"'
                    + '}';
                end else begin
                    balancesText := balancesText + ',{'
                    + '"LoanNo":"' + FORMAT(requestedLoans."Loan  No.") + '"'
                    + ',"ProductType":"' + requestedLoans."Loan Product Type" + '"'
                    + ',"ProductName":"' + requestedLoans."Loan Product Type Name" + '"'
                    + ',"Installments":"' + FORMAT(requestedLoans.Installments) + '"'
                    + ',"InterestRate":"' + FORMAT(requestedLoans."Interest") + '"'
                    + ',"RequestedAmount":"' + FORMAT(requestedLoans."Loan Amount") + '"'
                    + ',"InterestCalculationMethod":"' + FORMAT(requestedLoans."Interest Calculation Method") + '"'
                    + '}';
                end;

            UNTIL
            requestedLoans.NEXT = 0;
            IF balancesText <> '' THEN BEGIN
                runningLoans := '{ "StatusCode":"200","StatusDescription":"OK","RequestedLoans":[' + balancesText + '] }';
            END ELSE BEGIN
                runningLoans := '{ "StatusCode":"400","StatusDescription":"NoLoans","RequestedLoans":[] }';
            END;
        END;
    end;

    procedure fnLoanAppraisalReport(loanNumber: Code[20]) exitString: Text
    var
        Filename: Text[100];
        Outputstream: OutStream;
        RecRef: RecordRef;
        TempBlob: Codeunit "Temp Blob";
        Outstr: OutStream;
        Instr: InStream;
        Base64Convert: Codeunit "Base64 Convert";
    begin
        ObjLoansregister.Reset();
        ObjLoansregister.SetRange("Loan  No.", loanNumber);
        // ObjLoansregister.SetRange("Loan Status",'<>');
        if ObjLoansregister.Find('-') then begin
            RecRef.GetTable(ObjLoansregister);
            Clear(TempBlob);
            TempBlob.CreateOutStream(Outstr);
            TempBlob.CreateInStream(Instr);
            if Report.SaveAs(Report::"Loan Appraisal", '', ReportFormat::Pdf, Outstr, RecRef) then begin
                exitString := Base64Convert.ToBase64(Instr);
                exit;
            end;
        end;
    end;
    #endregion
}
