#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50186 "Check Off Advice-Lumpsum"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Check Off Advice-Lumpsum.rdlc';

    dataset
    {
        dataitem("Members Register"; Customer)
        {
            DataItemTableView = where(Status = filter(Active));
            RequestFilterFields = "No.", "Employer Code", "Date Filter";
            column(ReportForNavId_1; 1)
            {
            }
            column(MonthlyContribution_MembersRegister; "Members Register"."Monthly Contribution")
            {
            }
            column(No_MembersRegister; "Members Register"."No.")
            {
            }
            column(Name_MembersRegister; "Members Register".Name)
            {
            }
            column(EmployerCode_MembersRegister; "Members Register"."Employer Code")
            {
            }
            column(Total_Loan_Repayment; TRepayment)
            {
            }
            column(MonthlyAdvice; MonthlyAdvice)
            {
            }
            column(mothlcommitment; "Members Register"."Monthly Contribution")
            {
            }
            column(Insurancecontributions; Insurance)
            {
            }
            column(LIKIZO_CONTRIBUTION; LIKIZO)
            {
            }
            column(Share_Capital; scapital)
            {
            }
            column(HOUSING_CONTRIBUTION; HOUSING)
            {
            }
            column(Deposit_Contribution; DEPOSIT)
            {
            }
            column(Interest_Repayment; interest)
            {
            }
            column(Principle_Repayment; principle)
            {
            }
            column(EmployerName; LoansRec."Employer Name")
            {
            }
            column(Employercode; LoansRec."Employer Code")
            {
            }
            column(DOCNAME; DOCNAME)
            {
            }
            column(CName; CompanyInfo.Name)
            {
            }
            column(Caddress; CompanyInfo.Address)
            {
            }
            column(CmobileNo; CompanyInfo."Phone No.")
            {
            }
            column(clogo; CompanyInfo.Picture)
            {
            }
            column(Cwebsite; CompanyInfo."Home Page")
            {
            }
            column(Employer_Name; employername)
            {
            }
            column(normloan; normloan)
            {
            }
            column(College; College)
            {
            }
            column(AssetL; AssetL)
            {
            }
            column(scfee; scfee)
            {
            }
            column(emmerg; emmerg)
            {
            }
            column(Quick; Quick)
            {
            }
            column(karibu; karibu)
            {
            }

            trigger OnAfterGetRecord()
            begin
                DOCNAME := 'EMPLOYER CHECKOFF ADVICE';
                Prepayment := 0;
                IntRepayment := 0;
                AlphaSavings := 0;
                TRepayment := 0;
                PrincipalInterest := 0;
                MonthlyAdvice := 0;
                Juniorcontribution := 0;
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

                Cust.Reset;
                Cust.SetRange(Cust."No.", "Members Register"."No.");
                Cust.SetRange(Cust."Employer Code", "Members Register"."Employer Code");
                if Cust.Find('-') then begin
                    Gsetup.Get();
                    Cust.CalcFields(Cust."Shares Retained");
                    if Cust."Shares Retained" < Gsetup."Retained Shares" then
                        scapital := cust."Monthly ShareCap Cont.";
                    Likizo := Cust."Holiday Contribution";// "Holiday Monthly Contribution";
                    AlphaSavings := cust."Alpha Monthly Contribution";
                    Juniorcontribution := Cust."Junior Monthly Contribution";
                    HOUSING := Cust."Investment Monthly Cont";
                    DEPOSIT := Cust."Monthly Contribution" + cust."Monthly ShareCap Cont.";

                    //normloan
                    TRepayment := 0;

                    loans.Reset;
                    loans.SetRange(loans."Client Code", "Members Register"."No.");
                    loans.SetRange(loans."Loan Product Type", 'NORMAL');
                    loans.SetFilter(loans."Outstanding Balance", '>0');
                    loans.SetAutocalcFields(loans."Outstanding Balance", loans."Oustanding Interest");
                    loans.SetRange(loans.Posted, true);
                    if loans.Find('-') then begin
                        repeat
                            TRepayment := Loans."Oustanding Interest" + Loans."Outstanding Balance";
                            if TRepayment < Loans.Repayment then begin
                                normloan := TRepayment
                            end else begin
                                normloan := loans.Repayment;
                            end;
                            normloan := normloan;//
                        until loans.Next = 0;
                    end;
                    //END
                    //LCount:=LCount+1;
                    //college
                    TRepayment := 0;
                    loans.Reset;
                    loans.SetRange(loans."Client Code", "Members Register"."No.");
                    loans.SetRange(loans."Loan Product Type", 'COLLEGE');
                    loans.SetFilter(loans."Outstanding Balance", '>0');
                    loans.SetAutocalcFields(loans."Outstanding Balance", loans."Oustanding Interest");
                    loans.SetRange(loans.Posted, true);
                    if loans.Find('-') then begin
                        repeat
                            TRepayment := Loans."Oustanding Interest" + Loans."Outstanding Balance";
                            if TRepayment < Loans.Repayment then begin
                                College := TRepayment
                            end else Begin
                                College += loans.Repayment;
                            End;

                            College := College;//
                        until loans.Next = 0;
                    end;
                    //Make over
                    TRepayment := 0;
                    loans.Reset;
                    loans.SetRange(loans."Client Code", "Members Register"."No.");
                    loans.SetRange(loans."Loan Product Type", 'MAKEOVER');
                    loans.SetFilter(loans."Outstanding Balance", '>0');
                    loans.SetAutocalcFields(loans."Outstanding Balance", loans."Oustanding Interest");
                    loans.SetRange(loans.Posted, true);
                    if loans.Find('-') then begin
                        repeat
                            TRepayment := Loans."Oustanding Interest" + Loans."Outstanding Balance";
                            if TRepayment < Loans.Repayment then begin
                                Makeover := TRepayment;
                            end else begin
                                Makeover := loans.Repayment;
                            end;

                            Makeover := Makeover;//
                        until loans.Next = 0;
                    end;
                    //Premium
                    TRepayment := 0;
                    loans.Reset;
                    loans.SetRange(loans."Client Code", "Members Register"."No.");
                    loans.SetRange(loans."Loan Product Type", 'PREMIUM');
                    loans.SetFilter(loans."Outstanding Balance", '>0');
                    loans.SetAutocalcFields(loans."Outstanding Balance", loans."Oustanding Interest");
                    loans.SetRange(loans.Posted, true);
                    if loans.Find('-') then begin
                        repeat
                            TRepayment := Loans."Oustanding Interest" + Loans."Outstanding Balance";
                            if TRepayment < Loans.Repayment then begin
                                Premium := TRepayment;
                            end else begin
                                Premium := loans.Repayment;
                            end;
                            Premium := Premium;//
                        until loans.Next = 0;
                    end;

                    //school fee
                    TRepayment := 0;
                    loans.Reset;
                    loans.SetRange(loans."Client Code", "Members Register"."No.");
                    loans.SetRange(loans."Loan Product Type", 'SCH_FEES');
                    loans.SetFilter(loans."Outstanding Balance", '>0');
                    loans.SetAutocalcFields(loans."Outstanding Balance", loans."Oustanding Interest");
                    loans.SetRange(loans.Posted, true);
                    if loans.Find('-') then begin
                        repeat
                            TRepayment := Loans."Oustanding Interest" + Loans."Outstanding Balance";
                            if TRepayment < Loans.Repayment then begin
                                scfee := TRepayment;
                            end else begin
                                scfee := loans.Repayment;
                            end;
                            scfee := scfee;//
                        until loans.Next = 0;
                    end;
                    //emmergency fee
                    TRepayment := 0;
                    loans.Reset;
                    loans.SetRange(loans."Client Code", "Members Register"."No.");
                    loans.SetRange(loans."Loan Product Type", 'EMERGENCY');
                    loans.SetFilter(loans."Outstanding Balance", '>0');
                    loans.SetAutocalcFields(loans."Outstanding Balance", loans."Oustanding Interest");
                    loans.SetRange(loans.Posted, true);
                    if loans.Find('-') then begin
                        repeat
                            TRepayment := Loans."Oustanding Interest" + Loans."Outstanding Balance";
                            if TRepayment < Loans.Repayment then begin
                                emmerg := TRepayment;
                            end else begin
                                emmerg := loans.Repayment;
                            end;
                            emmerg := emmerg;//
                        until loans.Next = 0;
                    end;

                    //Qickcash
                    TRepayment := 0;
                    loans.Reset;
                    loans.SetRange(loans."Client Code", "Members Register"."No.");
                    loans.SetRange(loans."Loan Product Type", 'QUICK CASH');
                    loans.SetFilter(loans."Outstanding Balance", '>0');
                    loans.SetAutocalcFields(loans."Outstanding Balance", loans."Oustanding Interest");
                    loans.SetRange(loans.Posted, true);
                    if loans.Find('-') then begin
                        repeat
                            TRepayment := Loans."Oustanding Interest" + Loans."Outstanding Balance";
                            if TRepayment < Loans.Repayment then begin
                                Quick := TRepayment;
                            end else begin
                                Quick := loans.Repayment;
                            end;
                            Quick := Quick;//
                        until loans.Next = 0;
                    end;
                    //quic fee
                    loans.Reset;
                    loans.SetRange(loans."Client Code", "Members Register"."No.");
                    loans.SetRange(loans."Loan Product Type", 'KARIBU');
                    loans.SetFilter(loans."Outstanding Balance", '>0');
                    loans.SetAutocalcFields(loans."Outstanding Balance", loans."Oustanding Interest");
                    loans.SetRange(loans.Posted, true);
                    if loans.Find('-') then begin
                        repeat
                            TRepayment := Loans."Oustanding Interest" + Loans."Outstanding Balance";
                            if TRepayment < Loans.Repayment then begin
                                karibu := TRepayment;
                            end else begin
                                karibu := loans.Repayment;
                            end;
                            karibu := karibu;//
                        until loans.Next = 0;
                    end;
                    //quic fee
                    loans.Reset;
                    loans.SetRange(loans."Client Code", "Members Register"."No.");
                    loans.SetRange(loans."Loan Product Type", 'ASSET LOAN');
                    loans.SetFilter(loans."Outstanding Balance", '>0');
                    loans.SetAutocalcFields(loans."Outstanding Balance");
                    loans.SetRange(loans.Posted, true);
                    if loans.Find('-') then begin
                        repeat
                            TRepayment := Loans."Oustanding Interest" + Loans."Outstanding Balance";
                            if TRepayment < Loans.Repayment then begin
                                AssetL := TRepayment;
                            end else begin
                                AssetL := loans.Repayment;
                            end;
                            AssetL := AssetL;//
                        until loans.Next = 0;
                    end;
                    // //quic fee
                    // loans.Reset;
                    // loans.SetRange(loans."Client Code", "Members Register"."No.");
                    // loans.SetRange(loans."Loan Product Type", 'Likizo');
                    // loans.SetFilter(loans."Outstanding Balance", '>0');
                    // loans.SetAutocalcFields(loans."Outstanding Balance");
                    // loans.SetRange(loans.Posted, true);
                    // if loans.Find('-') then begin
                    //     repeat
                    //         Likizo := loans."Loan Principle Repayment" + loans."Loan Interest Repayment";
                    //         Likizo := Likizo;//
                    //     until loans.Next = 0;
                    // end;


                    MonthlyAdvice := HOUSING + AlphaSavings + Juniorcontribution + DEPOSIT + Likizo + normloan + College + scfee + emmerg + Quick + karibu + AssetL + Makeover + Premium;



                end;

            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;

    var
        AlphaSavings: Decimal;
        LoansRec: Record "Loans Register";
        Juniorcontribution: Decimal;
        Prepayment: Decimal;
        IntRepayment: Decimal;
        TRepayment: Decimal;
        Makeover: Decimal;
        Premium: Decimal;
        PrincipalInterest: Decimal;
        MonthlyAdvice: Decimal;
        DOCNAME: Text[30];
        CompanyInfo: Record "Company Information";
        Gsetup: Record "Sacco General Set-Up";
        Insurance: Decimal;
        insuranceContribution: Decimal;
        scapital: Decimal;
        minbal: Decimal;
        DEPOSIT: Decimal;
        LIKIZO: Decimal;
        HOUSING: Decimal;
        interest: Decimal;
        principle: Decimal;
        loans: Record "Loans Register";
        maxscap: Decimal;
        Cust: Record Customer;
        employername: Text;
        member: Record "Sacco Employers";
        normloan: Decimal;
        College: Decimal;
        scfee: Decimal;
        emmerg: Decimal;
        Quick: Decimal;
        karibu: Decimal;
        AssetL: Decimal;
        Lkizo: Decimal;
        Alpha: Decimal;
}

