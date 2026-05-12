#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 51418 "Payroll Processinguse"//not pulling SHIF on payslip
{
    // ++Note
    // Tax on Excess Pension Not Clear /Not indicated anywhere
    // Low Interest Benefits
    // VOQ


    trigger OnRun()
    begin
    end;

    var
        Text020: label 'Because of circular references, the program cannot calculate a formula.';
        Text012: label 'You have entered an illegal value or a nonexistent row number.';
        Text013: label 'You have entered an illegal value or a nonexistent column number.';
        Text017: label 'The error occurred when the program tried to calculate:\';
        Text018: label 'Acc. Sched. Line: Row No. = %1, Line No. = %2, Totaling = %3\';
        Text019: label 'Acc. Sched. Column: Column No. = %4, Line No. = %5, Formula  = %6';
        Text023: label 'Formulas ending with a percent sign require %2 %1 on a line before it.';
        AHLRelief: Decimal;
        Curhouselevy: Decimal;
        VitalSetup: Record "Payroll General Setup.";
        curReliefPersonal: Decimal;
        curReliefInsurance: Decimal;
        curReliefMorgage: Decimal;
        curMaximumRelief: Decimal;
        curNssfEmployee: Decimal;
        curNssf_Employer_Factor: Decimal;
        intNHIF_BasedOn: Option Gross,Basic,"Taxable Pay";
        intNSSF_BasedOn: Option Gross,Basic,"Taxable Pay";
        curMaxPensionContrib: Decimal;
        curRateTaxExPension: Decimal;
        curOOIMaxMonthlyContrb: Decimal;
        curOOIDecemberDedc: Decimal;
        curLoanMarketRate: Decimal;
        curLoanCorpRate: Decimal;
        PostingGroup: Record "Payroll Posting Groups.";
        TaxAccount: Code[20];
        salariesAcc: Code[20];
        PayablesAcc: Code[20];
        NSSFEMPyer: Code[20];
        PensionEMPyer: Code[20];
        NSSFEMPyee: Code[20];
        NHIFEMPyer: Code[20];
        NHIFEMPyee: Code[20];
        HrEmployee: Record "Payroll Employee.";
        CoopParameters: Option "none",shares,loan,"Loan Interest","Emergency loan","Emergency Loan Interest","School Fees loan","School Fees Loan Interest",Welfare,Pension,NSSF,Overtime,DevShare,NHIF,"Insurance Contribution";
        PayrollType: Code[20];
        SpecialTranAmount: Decimal;
        EmpSalary: Record "Payroll Employee.";
        txBenefitAmt: Decimal;
        TelTaxACC: Code[20];
        loans: Record "Loans Register";
        Management: Boolean;
        intRate: Decimal;
        // PayrollPeriodBuffer: Record UnknownRecord51516974;
        NhifRelief: Decimal;


    procedure fnInitialize()
    begin
        //Initialize Global Setup Items
        VitalSetup.FindFirst;
        with VitalSetup do begin
            curReliefPersonal := "Tax Relief";
            curReliefInsurance := "Insurance Relief";
            curReliefMorgage := "Mortgage Relief"; //Same as HOSP
            curMaximumRelief := "Max Relief";
            curNssfEmployee := "NSSF Employee";
            curNssf_Employer_Factor := "NSSF Employer Factor";
            intNHIF_BasedOn := "NHIF Based on";
            curMaxPensionContrib := "Max Pension Contribution";
            curRateTaxExPension := "Tax On Excess Pension";
            curOOIMaxMonthlyContrb := "OOI Deduction";
            curOOIDecemberDedc := "OOI December";
            curLoanMarketRate := "Loan Market Rate";
            curLoanCorpRate := "Loan Corporate Rate";


        end;
    end;

    procedure fnGetJournalDet(strEmpCode: Code[20])
    var
        SalaryCard: Record "Payroll Employee.";
        HousingLevyEmployee: Code[50];
        HosingLevyEmployer: Code[50];
        GrossPayAccount: Code[50];
    begin
        //Get Payroll Posting Accounts
        if SalaryCard.Get(strEmpCode) then begin
            if PostingGroup.Get(SalaryCard."Posting Group") then begin
                //Comment This for the Time Being

                PostingGroup.TestField("Salary Account");
                PostingGroup.TestField("PAYE Account");
                PostingGroup.TestField("Net Salary Payable");
                PostingGroup.TestField("SSF Employer Account");
                // PostingGroup.TESTFIELD("Pension Employer Acc");

                TaxAccount := PostingGroup."PAYE Account";
                salariesAcc := PostingGroup."Salary Account";
                PayablesAcc := PostingGroup."Net Salary Payable";
                // PayablesAcc:=SalaryCard."Bank Account Number";
                NSSFEMPyer := PostingGroup."SSF Employer Account";
                NSSFEMPyee := PostingGroup."SSF Employee Account";
                NHIFEMPyee := PostingGroup."NHIF Employee Account";
                PensionEMPyer := PostingGroup."Pension Employer Acc";
                HousingLevyEmployee := PostingGroup.EmployeeHousingLevy;
                HosingLevyEmployer := PostingGroup."Employer Housing Levy";
                GrossPayAccount := PostingGroup."Gross Pay";


            end else begin
                //ERROR('Please specify Posting Group in Employee No.  '+strEmpCode);
            end;
        end;
        //End Get Payroll Posting Accounts
    end;

    procedure fnProcesspayroll(strEmpCode: Code[20]; dtDOE: Date; curBasicPay: Decimal; blnPaysPaye: Boolean; blnPaysNssf: Boolean; blnPaysNhif: Boolean; SelectedPeriod: Date; dtOpenPeriod: Date; Membership: Text[30]; ReferenceNo: Text[30]; dtTermination: Date; blnGetsPAYERelief: Boolean; Dept: Code[20]; PayrollCode: Code[20])
    var
        strTableName: Text[50];
        curTransAmount: Decimal;
        curTransBalance: Decimal;
        strTransDescription: Text[50];
        TGroup: Text[30];
        TGroupOrder: Integer;
        TSubGroupOrder: Integer;
        curSalaryArrears: Decimal;
        curPayeArrears: Decimal;
        curGrossPay: Decimal;
        curTotAllowances: Decimal;
        curExcessPension: Decimal;
        curNSSF: Decimal;
        curDefinedContrib: Decimal;
        curPensionStaff: Decimal;
        curNonTaxable: Decimal;
        curGrossTaxable: Decimal;
        curBenefits: Decimal;
        curValueOfQuarters: Decimal;
        curUnusedRelief: Decimal;
        curInsuranceReliefAmount: Decimal;
        curMorgageReliefAmount: Decimal;
        curTaxablePay: Decimal;
        curTaxCharged: Decimal;
        curPAYE: Decimal;
        prPeriodTransactions: Record "prPeriod Transactions.";
        intYear: Integer;
        intMonth: Integer;
        LeapYear: Boolean;
        CountDaysofMonth: Integer;
        DaysWorked: Integer;
        prSalaryArrears: Record "Payroll Salary Arrears.";
        prEmployeeTransactions: Record "Payroll Employee Transactions.";
        prTransactionCodes: Record "Payroll Transaction Code.";
        strExtractedFrml: Text[250];
        SpecialTransType: Option Ignore,"Defined Contribution","Home Ownership Savings Plan","Life Insurance","Owner Occupier Interest","Prescribed Benefit","Salary Arrears","Staff Loan","Value of Quarters",Morgage;
        TransactionType: Option Income,Deduction;
        curPensionCompany: Decimal;
        curTaxOnExcessPension: Decimal;
        prUnusedRelief: Record "Employee Unused Relief Buffer";
        curNhif_Base_Amount: Decimal;
        curNHIF: Decimal;
        curTotalDeductions: Decimal;
        curNetRnd_Effect: Decimal;
        curNetPay: Decimal;
        curTotCompanyDed: Decimal;
        curOOI: Decimal;
        curHOSP: Decimal;
        curLoanInt: Decimal;
        strTransCode: Text[250];
        fnCalcFringeBenefit: Decimal;
        prEmployerDeductions: Record "Payroll Employee Deductions.";
        JournalPostingType: Option " ","G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Staff,"None",Member;
        JournalAcc: Code[20];
        Customer: Record Customer;
        JournalPostAs: Option " ",Debit,Credit;
        IsCashBenefit: Decimal;
        Teltax: Decimal;
        Teltax2: Decimal;
        prEmployeeTransactions2: Record "Payroll Employee Transactions.";
        prTransactionCodes3: Record "Payroll Transaction Code.";
        curTransAmount2: Decimal;
        curNssf_Base_Amount: Decimal;
        CurrInsuranceRel: Decimal;
        EmployeeP: Record "Payroll Employee.";
        intRate: Decimal;
        LoanRegister: Record "Loans Register";
    begin
        //Initialize
        fnInitialize;
        fnGetJournalDet(strEmpCode);
        //PayrollType
        PayrollType := PayrollCode;

        if EmployeeP.Get(strEmpCode) then
            Management := EmployeeP."Is Management";

        //check if the period selected=current period. If not, do NOT run this function
        if SelectedPeriod <> dtOpenPeriod then exit;
        intMonth := Date2dmy(SelectedPeriod, 2);
        intYear := Date2dmy(SelectedPeriod, 3);

        if curBasicPay > 0 then begin
            //Get the Basic Salary (prorate basc pay if needed) //Termination Remaining
            if (Date2dmy(dtDOE, 2) = Date2dmy(dtOpenPeriod, 2)) and (Date2dmy(dtDOE, 3) = Date2dmy(dtOpenPeriod, 3)) then begin
                CountDaysofMonth := fnDaysInMonth(dtDOE);
                DaysWorked := fnDaysWorked(dtDOE, false);
                curBasicPay := fnBasicPayProrated(strEmpCode, intMonth, intYear, curBasicPay, DaysWorked, CountDaysofMonth)
            end;

            //Prorate Basic Pay on    {What if someone leaves within the same month they are employed}
            if dtTermination <> 0D then begin
                if (Date2dmy(dtTermination, 2) = Date2dmy(dtOpenPeriod, 2)) and (Date2dmy(dtTermination, 3) = Date2dmy(dtOpenPeriod, 3)) then begin
                    CountDaysofMonth := fnDaysInMonth(dtTermination);
                    DaysWorked := fnDaysWorked(dtTermination, true);
                    curBasicPay := fnBasicPayProrated(strEmpCode, intMonth, intYear, curBasicPay, DaysWorked, CountDaysofMonth)
                end;
            end;

            curTransAmount := curBasicPay;
            strTransDescription := 'Basic Pay';
            TGroup := 'BASIC SALARY';
            TGroupOrder := 1;
            TSubGroupOrder := 1;
            fnUpdatePeriodTrans(strEmpCode, 'BPAY', TGroup, TGroupOrder,
            TSubGroupOrder, strTransDescription, curTransAmount, 0, intMonth, intYear, Membership, ReferenceNo, SelectedPeriod, Dept,
            salariesAcc, Journalpostas::Debit, Journalpostingtype::"G/L Account", '', Coopparameters::none);

            //Salary Arrears
            prSalaryArrears.Reset;
            prSalaryArrears.SetRange(prSalaryArrears."Employee Code", strEmpCode);
            prSalaryArrears.SetRange(prSalaryArrears."Period Month", intMonth);
            prSalaryArrears.SetRange(prSalaryArrears."Period Year", intYear);
            if prSalaryArrears.Find('-') then begin
                repeat
                    curSalaryArrears := prSalaryArrears."Salary Arrears";
                    curPayeArrears := prSalaryArrears."PAYE Arrears";

                    //Insert [Salary Arrears] into period trans [ARREARS]
                    curTransAmount := curSalaryArrears;
                    strTransDescription := 'Salary Arrears';
                    TGroup := 'ARREARS';
                    TGroupOrder := 1;
                    TSubGroupOrder := 2;
                    fnUpdatePeriodTrans(strEmpCode, prSalaryArrears."Transaction Code", TGroup, TGroupOrder, TSubGroupOrder,
                      strTransDescription, curTransAmount, 0, intMonth, intYear, Membership, ReferenceNo, SelectedPeriod, Dept, salariesAcc,
                      Journalpostas::Debit, Journalpostingtype::"G/L Account", '', Coopparameters::none);

                    //Insert [PAYE Arrears] into period trans [PYAR]
                    curTransAmount := curPayeArrears;
                    strTransDescription := 'P.A.Y.E Arrears';
                    TGroup := 'STATUTORIES';
                    TGroupOrder := 7;
                    TSubGroupOrder := 5;
                    fnUpdatePeriodTrans(strEmpCode, 'PYAR', TGroup, TGroupOrder, TSubGroupOrder,
                       strTransDescription, curTransAmount, 0, intMonth, intYear, Membership, ReferenceNo, SelectedPeriod, Dept,
                       TaxAccount, Journalpostas::Debit, Journalpostingtype::"G/L Account", '', Coopparameters::none)

                until prSalaryArrears.Next = 0;
            end;

            //Get Earnings

            prEmployeeTransactions.Reset;
            prEmployeeTransactions.SetRange(prEmployeeTransactions."No.", strEmpCode);
            prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Month", intMonth);
            prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Year", intYear);
            // prEmployeeTransactions.SETRANGE(prEmployeeTransactions.Suspended,FALSE);

            if prEmployeeTransactions.Find('-') then begin
                curTotAllowances := 0;
                IsCashBenefit := 0;

                repeat
                    prTransactionCodes.Reset;
                    prTransactionCodes.SetRange(prTransactionCodes."Transaction Code", prEmployeeTransactions."Transaction Code");
                    prTransactionCodes.SetRange(prTransactionCodes."Transaction Type", prTransactionCodes."transaction type"::Income);
                    //prTransactionCodes.SETRANGE(prTransactionCodes."Special Transaction",prTransactionCodes."Special Transaction"::Ignore);

                    if prTransactionCodes.Find('-') then begin

                        curTransAmount := 0;
                        curTransBalance := 0;
                        strTransDescription := '';
                        strExtractedFrml := '';

                        if prTransactionCodes."Is Formulae" then begin
                            //         IF Management THEN
                            //           //strExtractedFrml:=fnPureFormula(strEmpCode, intMonth, intYear,prTransactionCodes."Leave Reimbursement")
                            //         //ELSE
                            strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, prTransactionCodes.Formulae);

                            curTransAmount := ROUND(fnFormulaResult(strExtractedFrml), 0.05, '<'); //Get the calculated amount

                        end else begin
                            curTransAmount := prEmployeeTransactions.Amount;
                            //  MESSAGE(FORMAT(curTransAmount));
                        end;

                        if prTransactionCodes."Balance Type" = prTransactionCodes."balance type"::None then //[0=None, 1=Increasing, 2=Reducing]
                            curTransBalance := 0;
                        if prTransactionCodes."Balance Type" = prTransactionCodes."balance type"::Increasing then
                            curTransBalance := prEmployeeTransactions.Balance + curTransAmount;
                        if prTransactionCodes."Balance Type" = prTransactionCodes."balance type"::Reducing then
                            curTransBalance := prEmployeeTransactions.Balance - curTransAmount;


                        //Prorate Allowances Here
                        //Get the Basic Salary (prorate basc pay if needed) //Termination Remaining
                        if (Date2dmy(dtDOE, 2) = Date2dmy(dtOpenPeriod, 2)) and (Date2dmy(dtDOE, 3) = Date2dmy(dtOpenPeriod, 3)) then begin
                            CountDaysofMonth := fnDaysInMonth(dtDOE);
                            DaysWorked := fnDaysWorked(dtDOE, false);
                            curTransAmount := fnBasicPayProrated(strEmpCode, intMonth, intYear, curTransAmount, DaysWorked, CountDaysofMonth)
                        end;

                        //Prorate Basic Pay on    {What if someone leaves within the same month they are employed}
                        if dtTermination <> 0D then begin
                            if (Date2dmy(dtTermination, 2) = Date2dmy(dtOpenPeriod, 2)) and (Date2dmy(dtTermination, 3) = Date2dmy(dtOpenPeriod, 3)) then begin
                                CountDaysofMonth := fnDaysInMonth(dtTermination);
                                DaysWorked := fnDaysWorked(dtTermination, true);
                                curTransAmount := fnBasicPayProrated(strEmpCode, intMonth, intYear, curTransAmount, DaysWorked, CountDaysofMonth)
                            end;
                        end;
                        // Prorate Allowances Here



                        //Add Non Taxable Here
                        if (not prTransactionCodes.Taxable) and (prTransactionCodes."Special Transaction" =
                        prTransactionCodes."special transaction"::Ignore) then
                            curNonTaxable := curNonTaxable + curTransAmount;


                        //Added to ensure special transaction that are not taxable are not inlcuded in list of Allowances
                        if (not prTransactionCodes.Taxable) and (prTransactionCodes."Special Transaction" <>
                        prTransactionCodes."special transaction"::Ignore) then
                            curTransAmount := 0;


                        curTotAllowances := curTotAllowances + curTransAmount; //Sum-up all the allowances
                        curTransAmount := curTransAmount;
                        curTransBalance := curTransBalance;
                        strTransDescription := prTransactionCodes."Transaction Name";
                        TGroup := 'ALLOWANCE';
                        TGroupOrder := 3;
                        TSubGroupOrder := 0;


                        //Get the posting Details
                        JournalPostingType := Journalpostingtype::" ";
                        JournalAcc := '';
                        if prTransactionCodes.SubLedger <> prTransactionCodes.Subledger::" " then begin
                            if prTransactionCodes.SubLedger = prTransactionCodes.Subledger::Customer then begin

                                HrEmployee.Get(strEmpCode);
                                Customer.Reset;
                                Customer.SetRange(Customer."No.", HrEmployee."Sacco Membership No.");
                                if Customer.Find('-') then begin
                                    JournalAcc := Customer."No.";
                                    JournalPostingType := Journalpostingtype::Member;
                                end;
                            end;
                        end else begin
                            JournalAcc := prTransactionCodes."G/L Account";
                            JournalPostingType := Journalpostingtype::"G/L Account";
                        end;

                        //Get is Cash Benefits
                        if prTransactionCodes."Is Cash" then
                            IsCashBenefit := IsCashBenefit + curTransAmount;
                        //End posting Details

                        fnUpdatePeriodTrans(strEmpCode, prTransactionCodes."Transaction Code", TGroup, TGroupOrder, TSubGroupOrder,
                        strTransDescription, curTransAmount, curTransBalance, intMonth, intYear, prEmployeeTransactions.Membership,
                        prEmployeeTransactions."Reference No", SelectedPeriod, Dept, JournalAcc, Journalpostas::Debit, JournalPostingType, '',
                        prTransactionCodes."Co-Op Parameters");

                    end;
                until prEmployeeTransactions.Next = 0;
            end;


            //Calc GrossPay = (BasicSalary + Allowances + SalaryArrears) [Group Order = 4]
            curGrossPay := (curBasicPay + curTotAllowances + curSalaryArrears);
            curTransAmount := curGrossPay;
            strTransDescription := 'Gross Pay';
            TGroup := 'GROSS PAY';
            TGroupOrder := 4;
            TSubGroupOrder := 0;
            fnUpdatePeriodTrans(strEmpCode, 'GPAY', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription, curTransAmount, 0, intMonth,
             intYear, '', '', SelectedPeriod, Dept, '', Journalpostas::" ", Journalpostingtype::" ", '', Coopparameters::none);

            //Get the NSSF amount

            //Get the N.S.S.F amount for the month GBT
            curNssf_Base_Amount := 0;

            if intNSSF_BasedOn = Intnssf_basedon::Gross then //>NHIF calculation can be based on:
                curNssf_Base_Amount := curGrossPay;
            if intNSSF_BasedOn = Intnssf_basedon::Basic then
                curNssf_Base_Amount := curBasicPay;



            if blnPaysNssf then
                // curNSSF := curNssfEmployee;
                if curNssf_Base_Amount > 72000 then begin
                    curNSSF := 72000 * 0.06;
                end else begin
                    curNSSF := curNssf_Base_Amount * 0.06;
                end;
            //fnGetEmployeeNSSF(curNssf_Base_Amount);//client using the old rates
            curTransAmount := curNSSF;
            curNSSF := curNSSF;
            strTransDescription := 'N.S.S.F';
            TGroup := 'STATUTORIES';
            TGroupOrder := 7;
            TSubGroupOrder := 1;
            fnUpdatePeriodTrans(strEmpCode, 'NSSF', TGroup, TGroupOrder, TSubGroupOrder,
            strTransDescription, curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, NSSFEMPyee,
            Journalpostas::Credit, Journalpostingtype::"G/L Account", '', Coopparameters::NSSF);

            ///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>.house Levy
            Curhouselevy := curGrossPay * 1.5 / 100;
            if Curhouselevy > 0 then begin
                curTransAmount := Curhouselevy;
                strTransDescription := 'House Levy';
                TGroup := 'STATUTORIES';
                TGroupOrder := 7;
                TSubGroupOrder := 5;
                // fnUpdatePeriodTrans(strEmpCode, 'HL', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                // curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', Journalpostas::" ", Journalpostingtype::" ", '',
                // Coopparameters::none);
                fnUpdatePeriodTrans(strEmpCode, 'HL', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
               curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '201007', Journalpostas::Credit, Journalpostingtype::"G/L Account", '',
               Coopparameters::none)
            end;
            //Get the N.H.I.F amount for the month GBT
            curNhif_Base_Amount := 0;

            if intNHIF_BasedOn = Intnhif_basedon::Gross then //>NHIF calculation can be based on:
                curNhif_Base_Amount := curGrossPay;
            if intNHIF_BasedOn = Intnhif_basedon::Basic then
                curNhif_Base_Amount := curBasicPay;
            if intNHIF_BasedOn = Intnhif_basedon::"Taxable Pay" then
                curNhif_Base_Amount := curTaxablePay;

            if blnPaysNhif then begin
                // curNHIF := 450;
                // curNHIF := fnGetEmployeeNHIF(curNhif_Base_Amount);
                // curNHIF := 320;
                curNHIF := (2.75 * curGrossPay) / 100;
                Message('THis SHIF New@ %1', curNHIF);

                curTransAmount := curNHIF;
                strTransDescription := 'S.H.I.F';
                TGroup := 'STATUTORIES';
                TGroupOrder := 7;
                TSubGroupOrder := 2;
                fnUpdatePeriodTrans(strEmpCode, 'SHIF', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                 curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept,
                 NHIFEMPyee, Journalpostas::Credit, Journalpostingtype::"G/L Account", '', Coopparameters::NHIF);
            end;
            //SHIF

            // if blnPaysNhif then begin
            //     //curNHIF:=450;
            //     curNHIF := (2.75 * curGrossPay) / 100;
            //     // curNHIF:=320;
            //     curTransAmount := curNHIF;
            //     strTransDescription := 'S.H.I.F';
            //     TGroup := 'STATUTORIES';
            //     TGroupOrder := 7;
            //     TSubGroupOrder := 2;
            //     fnUpdatePeriodTrans(strEmpCode, 'SHIF', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
            //      curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept,
            //      NHIFEMPyee, Journalpostas::Credit, Journalpostingtype::"G/L Account", '', Coopparameters::NHIF);
            // end;
            //Get the Defined contribution to post based on the Max Def contrb allowed   ****************All Defined Contributions not included
            curDefinedContrib := curNSSF + Curhouselevy + curNHIF; //(curNSSF + curPensionStaff + curNonTaxable) - curMorgageReliefAmount
                                                                   // curDefinedContrib:= fnGetEmployeeNSSF
            curTransAmount := curDefinedContrib;
            strTransDescription := 'Defined Contributions';
            TGroup := 'TAX CALCULATIONS';
            TGroupOrder := 6;
            TSubGroupOrder := 1;

            fnUpdatePeriodTrans(strEmpCode, 'DEFCON', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription, curTransAmount, 0, intMonth,
            intYear, '', '', SelectedPeriod, Dept, '', Journalpostas::" ", Journalpostingtype::" ", '', Coopparameters::none);


            //Get the Gross taxable amount
            //>GrossTaxable = Gross + Benefits + nValueofQuarters  ******Confirm CurValueofQuaters
            curGrossTaxable := curGrossPay + curBenefits + curValueOfQuarters;

            //>If GrossTaxable = 0 Then TheDefinedToPost = 0
            if curGrossTaxable = 0 then curDefinedContrib := 0;


            VitalSetup.Get();
            //Get Insurance Relief
            EmployeeP.Reset;
            EmployeeP.SetRange(EmployeeP."No.", strEmpCode);
            if EmployeeP.Find('-') then begin

                CurrInsuranceRel := EmployeeP."Insurance Premium" * (VitalSetup."Insurance Relief" / 100);
                //Insert Insurance Relief
                curTransAmount := CurrInsuranceRel;
                strTransDescription := 'Insurance Relief';
                TGroup := 'TAX CALCULATIONS';
                TGroupOrder := 6;
                TSubGroupOrder := 8;
                fnUpdatePeriodTrans(strEmpCode, 'INSRD', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
           curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', Journalpostas::" ", Journalpostingtype::" ", '',
           Coopparameters::"Insurance Contribution");

            end;

            //Personal Relief
            if blnGetsPAYERelief then begin
                curReliefPersonal := curReliefPersonal + curUnusedRelief; //*****Get curUnusedRelief
                curTransAmount := curReliefPersonal;
                strTransDescription := 'Personal Relief';
                TGroup := 'TAX CALCULATIONS';
                TGroupOrder := 6;
                TSubGroupOrder := 9;
                fnUpdatePeriodTrans(strEmpCode, 'PSNR', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                 curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', Journalpostas::" ", Journalpostingtype::" ", '',
                 Coopparameters::none);
            end;
            //ELSE
            // curReliefPersonal := 0;

            //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            //>Pension Contribution [self] relief
            curPensionStaff := fnGetSpecialTransAmount(strEmpCode, intMonth, intYear,
            Specialtranstype::"Defined Contribution", false);//Self contrib Pension is 1 on [Special Transaction]
            if curPensionStaff > 0 then begin
                if curPensionStaff > curMaxPensionContrib then
                    curTransAmount := curMaxPensionContrib
                else
                    curTransAmount := curPensionStaff;
                strTransDescription := 'Pension Relief';
                TGroup := 'TAX CALCULATIONS';
                TGroupOrder := 6;
                TSubGroupOrder := 2;
                fnUpdatePeriodTrans(strEmpCode, 'PNSR', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', Journalpostas::" ", Journalpostingtype::" ", '',
                Coopparameters::none)
            end;

            //if he PAYS paye only*******************I
            if blnPaysPaye and blnGetsPAYERelief then begin
                //Get Insurance Relief
                SpecialTranAmount := 0;
                curInsuranceReliefAmount := fnGetSpecialTransAmount(strEmpCode, intMonth, intYear,
                Specialtranstype::"Life Insurance", false); //Insurance is 3 on [Special Transaction]

                if curInsuranceReliefAmount > 0 then begin
                    curTransAmount := curInsuranceReliefAmount;
                    strTransDescription := 'Insurance Relief';
                    TGroup := 'TAX CALCULATIONS';
                    TGroupOrder := 6;
                    TSubGroupOrder := 8;
                    fnUpdatePeriodTrans(strEmpCode, 'INSR', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                    curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', Journalpostas::" ", Journalpostingtype::" ", '',
                    Coopparameters::"Insurance Contribution");
                end;

                //>OOI
                curOOI := fnGetSpecialTransAmount(strEmpCode, intMonth, intYear,
                Specialtranstype::"Owner Occupier Interest", false); //Morgage is LAST on [Special Transaction]
                if curOOI > 0 then begin
                    if curOOI <= curOOIMaxMonthlyContrb then
                        curTransAmount := curOOI
                    else
                        curTransAmount := curOOIMaxMonthlyContrb;

                    strTransDescription := 'Owner Occupier Interest';
                    TGroup := 'TAX CALCULATIONS';
                    TGroupOrder := 6;
                    TSubGroupOrder := 3;
                    fnUpdatePeriodTrans(strEmpCode, 'OOI', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                    curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', Journalpostas::" ", Journalpostingtype::" ", '',
                    Coopparameters::none);
                end;

                //HOSP
                curHOSP := fnGetSpecialTransAmount(strEmpCode, intMonth, intYear,
                Specialtranstype::"Home Ownership Savings Plan", false); //Home Ownership Savings Plan
                if curHOSP > 0 then begin
                    if curHOSP <= curReliefMorgage then
                        curTransAmount := curHOSP
                    else
                        curTransAmount := curReliefMorgage;

                    strTransDescription := 'Home Ownership Savings Plan';
                    TGroup := 'TAX CALCULATIONS';
                    TGroupOrder := 6;
                    TSubGroupOrder := 4;
                    fnUpdatePeriodTrans(strEmpCode, 'HOSP', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                    curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', Journalpostas::" ", Journalpostingtype::" ", '',
                    Coopparameters::none);
                end;

                /*//Enter NonTaxable Amount
                IF curNonTaxable>3499 THEN BEGIN
                           Teltax:=0;
                           Teltax2:=0;

                           Teltax:=curNonTaxable*0.3;
                           Teltax2:=Teltax*0.3;
                           //curTransAmount := Teltax2;
                           //MESSAGE('The telephone tax is %1',Teltax2);


                     strTransDescription := 'Telephone Tax';
                     TGroup := 'TAX CALCULATIONS'; TGroupOrder := 6; TSubGroupOrder := 5;
                     fnUpdatePeriodTrans (strEmpCode, 'NONTAX', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                     Teltax2, 0, intMonth, intYear,'','',SelectedPeriod,Dept,TelTaxACC,JournalPostAs::Credit,JournalPostingType::"G/L Account",'',
                     CoopParameters::none);
                END; */

                /*
                IF curNonTaxable>0 THEN BEGIN
                     strTransDescription := 'Other Non-Taxable Benefits';
                     TGroup := 'TAX CALCULATIONS'; TGroupOrder := 6; TSubGroupOrder := 5;
                     fnUpdatePeriodTrans (strEmpCode, 'NONTAX', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                     curNonTaxable, 0, intMonth, intYear,'','',SelectedPeriod,Dept,'',JournalPostAs::" ",JournalPostingType::" ",'',
                     CoopParameters::none);
                END;
                */

            end;

            curNhif_Base_Amount := 0;

            if intNHIF_BasedOn = Intnhif_basedon::Gross then //>NHIF calculation can be based on:
                curNhif_Base_Amount := curGrossPay;
            if intNHIF_BasedOn = Intnhif_basedon::Basic then
                curNhif_Base_Amount := curBasicPay;
            if intNHIF_BasedOn = Intnhif_basedon::"Taxable Pay" then
                curNhif_Base_Amount := curTaxablePay;

            //**************************************************************************
            IF blnPaysNhif THEN BEGIN
                //curNHIF:=450;
                //curNHIF:= fnGetEmployeeNHIF(curNhif_Base_Amount);
                curNHIF := curNhif_Base_Amount * 2.75 / 100;
                Message('Here nhif/shif is %1', curNHIF);
                curTransAmount := curNHIF;
                strTransDescription := 'S.H.I.F';
                TGroup := 'STATUTORIES';
                TGroupOrder := 7;
                TSubGroupOrder := 2;
                fnUpdatePeriodTrans(strEmpCode, 'SHIF', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                 curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept,
                 NHIFEMPyee, JournalPostAs::Credit, JournalPostingType::"G/L Account", '', CoopParameters::NHIF);
            END;
            ///NHIF RELIEF
            if blnPaysNhif then begin
                //curNHIF:=450;
                curNHIF := fnGetEmployeeNHIF(curNhif_Base_Amount);
                //curNHIF:=curNHIF*0.15;
                NhifRelief := curNHIF * 0.15;
                //MESSAGE(FORMAT(curNHIF));
                // curNHIF:=320;
                curTransAmount := NhifRelief;
                strTransDescription := 'N.H.I.F R';
                TGroup := 'STATUTORIES';
                TGroupOrder := 7;
                TSubGroupOrder := 2;
                fnUpdatePeriodTrans(strEmpCode, 'NHIF RELIEF', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                 curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept,
                 NHIFEMPyee, Journalpostas::Credit, Journalpostingtype::"G/L Account", '', Coopparameters::NHIF);
            end;
            //Get the Taxable amount for calculation of PAYE
            //>prTaxablePay = (GrossTaxable - SalaryArrears) - (TheDefinedToPost + curSelfPensionContrb + MorgageRelief)
            if curPensionStaff > curMaxPensionContrib then
                curTaxablePay := curGrossTaxable - (curSalaryArrears + curDefinedContrib + curMaxPensionContrib + curOOI + curHOSP + curNonTaxable)

            else
                curTaxablePay := curGrossTaxable - (curSalaryArrears + curDefinedContrib + curPensionStaff + curOOI + curHOSP + curNonTaxable);
            //Taxable Benefit
            txBenefitAmt := 0;
            if EmpSalary.Get(strEmpCode) then begin
                if EmpSalary."Pays NSSF" = false then begin
                    if fnCheckPaysPension(strEmpCode, SelectedPeriod) = true then begin
                        if (EmpSalary."Basic Pay" * 0.1) > 20000 then begin
                            txBenefitAmt := EmpSalary."Basic Pay" * 0.2;
                        end else begin
                            txBenefitAmt := ((EmpSalary."Basic Pay" * 0.2) + (EmpSalary."Basic Pay" * 0.1)) - 20000;
                            if txBenefitAmt < 0 then
                                txBenefitAmt := 0;
                        end;
                        strTransDescription := 'Taxable Pension';
                        TGroup := 'TAX CALCULATIONS';
                        TGroupOrder := 6;
                        TSubGroupOrder := 6;
                        fnUpdatePeriodTrans(strEmpCode, 'TXBB', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
                         txBenefitAmt, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', Journalpostas::" ", Journalpostingtype::" ", '',
                         Coopparameters::none);
                    end;
                end;
            end;
            curTransAmount := curTaxablePay + txBenefitAmt;
            strTransDescription := 'Taxable Pay';
            TGroup := 'TAX CALCULATIONS';
            TGroupOrder := 6;
            TSubGroupOrder := 6;
            fnUpdatePeriodTrans(strEmpCode, 'TXBP', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
             curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', Journalpostas::" ", Journalpostingtype::" ", '',
             Coopparameters::none);

            //Get the Tax charged for the month
            curTaxablePay := curTaxablePay + txBenefitAmt;
            curTaxCharged := fnGetEmployeePaye(curTaxablePay);//-(curInsuranceReliefAmount+curReliefPersonal+CurrInsuranceRel+NhifRelief);
            curTransAmount := curTaxCharged;
            strTransDescription := 'Tax Charged';
            TGroup := 'TAX CALCULATIONS';
            TGroupOrder := 6;
            TSubGroupOrder := 7;
            fnUpdatePeriodTrans(strEmpCode, 'TXCHRG', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
            curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, '', Journalpostas::" ", Journalpostingtype::" ", '',
            Coopparameters::none);



            //Get the Net PAYE amount to post for the month
            if (curReliefPersonal + curInsuranceReliefAmount) > curMaximumRelief then
                //curPAYE :=ROUND( curTaxCharged - curMaximumRelief,1,'<')
                curPAYE := (curTaxCharged - curReliefPersonal)
            else
                //curPAYE := curTaxCharged - (curReliefPersonal + curInsuranceReliefAmount);
                //curPAYE := ROUND(curTaxCharged,1,'<');
                curPAYE := (curTaxCharged - curReliefPersonal);
            if not blnPaysPaye then curPAYE := 0; //Get statutory Exemption for the staff. If exempted from tax, set PAYE=0
            curTransAmount := curPAYE;//+curTransAmount2;
            if curPAYE < 0 then curTransAmount := 0;
            strTransDescription := 'P.A.Y.E';
            TGroup := 'STATUTORIES';
            TGroupOrder := 7;
            TSubGroupOrder := 4;
            fnUpdatePeriodTrans(strEmpCode, 'PAYE', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
             curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept, TaxAccount, Journalpostas::Credit,
             Journalpostingtype::"G/L Account", '', Coopparameters::none);

            //Store the unused relief for the current month
            //>If Paye<0 then "Insert into tblprUNUSEDRELIEF



            if curPAYE < 0 then begin
                //cj
                prUnusedRelief.Reset;
                prUnusedRelief.SetRange(prUnusedRelief."Employee No.", strEmpCode);
                prUnusedRelief.SetRange(prUnusedRelief."Period Month", intMonth);
                prUnusedRelief.SetRange(prUnusedRelief."Period Year", intYear);
                if prUnusedRelief.Find('-') then
                    prUnusedRelief.Delete;

                prUnusedRelief.Reset;
                with prUnusedRelief do begin
                    Init;
                    "Employee No." := strEmpCode;
                    "Unused Relief" := curPAYE;
                    "Period Month" := intMonth;
                    "Period Year" := intYear;
                    Insert;

                    curPAYE := 0;
                end;

            end;

            prEmployeeTransactions.Reset;
            prEmployeeTransactions.SetRange(prEmployeeTransactions."No.", strEmpCode);
            prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Month", intMonth);
            prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Year", intYear);
            prEmployeeTransactions.SetRange(prEmployeeTransactions.Suspended, false);

            if prEmployeeTransactions.Find('-') then begin
                curTotalDeductions := 0;
                repeat
                    prTransactionCodes.Reset;
                    prTransactionCodes.SetRange(prTransactionCodes."Transaction Code", prEmployeeTransactions."Transaction Code");
                    prTransactionCodes.SetRange(prTransactionCodes."Transaction Type", prTransactionCodes."transaction type"::Deduction);
                    if prTransactionCodes.Find('-') then begin
                        curTransAmount := 0;
                        curTransBalance := 0;
                        strTransDescription := '';
                        strExtractedFrml := '';

                        if prTransactionCodes."Is Formulae" then begin
                            //          IF Management THEN
                            // //            strExtractedFrml:=fnPureFormula(strEmpCode, intMonth, intYear, prTransactionCodes."Leave Reimbursement")
                            // //          ELSE
                            strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, prTransactionCodes.Formulae);

                            curTransAmount := fnFormulaResult(strExtractedFrml); //Get the calculated amount

                        end else begin
                            curTransAmount := prEmployeeTransactions.Amount;
                        end;

                        //**************************If "deduct Premium" is not ticked and the type is insurance- Dennis*****
                        if (prTransactionCodes."Special Transaction" = prTransactionCodes."special transaction"::"Life Insurance")
                          and (prTransactionCodes."Deduct Premium" = false) then begin
                            curTransAmount := 0;
                        end;

                        //**************************If "deduct Premium" is not ticked and the type is mortgage- Dennis*****
                        if (prTransactionCodes."Special Transaction" = prTransactionCodes."special transaction"::Morgage)
                         and (prTransactionCodes."Deduct Mortgage" = false) then begin
                            curTransAmount := 0;
                        end;

                        if prTransactionCodes."IsCo-Op/LnRep" = true then begin
                            CoopParameters := prTransactionCodes."Co-Op Parameters";
                        end;


                        //Get the posting Details
                        JournalPostingType := Journalpostingtype::" ";
                        JournalAcc := '';
                        if prTransactionCodes.SubLedger <> prTransactionCodes.Subledger::" " then begin
                            if prTransactionCodes.SubLedger = prTransactionCodes.Subledger::Customer then begin
                                HrEmployee.Get(strEmpCode);

                                //IF prTransactionCodes.CustomerPostingGroup ='' THEN
                                //Customer.SETRANGE(Customer."Employer Code",'KPSS');

                                if prTransactionCodes."Customer Posting Group" <> '' then begin
                                    Customer.SetRange(Customer."Customer Posting Group", prTransactionCodes."Customer Posting Group");
                                end;
                                Customer.Reset;
                                Customer.SetRange(Customer."No.", HrEmployee."Payroll No");
                                //MESSAGE('%1,%2,%3',JournalAcc,strEmpCode,Customer."Payroll/Staff No");
                                if Customer.Find('-') then begin
                                    JournalAcc := Customer."No.";
                                    JournalPostingType := Journalpostingtype::Member;
                                end;
                            end;
                        end else begin
                            JournalAcc := prTransactionCodes."G/L Account";
                            JournalPostingType := Journalpostingtype::"G/L Account";
                        end;


                        //End Loan transaction calculation
                        //Fringe Benefits and Low interest Benefits
                        if prTransactionCodes."Fringe Benefit" = true then begin
                            if prTransactionCodes."Interest Rate" < curLoanMarketRate then begin
                                fnCalcFringeBenefit := (((curLoanMarketRate - prTransactionCodes."Interest Rate") * curLoanCorpRate) / 1200)
                                 * prEmployeeTransactions.Balance;
                            end;
                        end else begin
                            fnCalcFringeBenefit := 0;
                        end;
                        if fnCalcFringeBenefit > 0 then begin
                            fnUpdateEmployerDeductions(strEmpCode, prEmployeeTransactions."Transaction Code" + '-FRG',
                             'EMP', TGroupOrder, TSubGroupOrder, 'Fringe Benefit Tax', fnCalcFringeBenefit, 0, intMonth, intYear,
                              prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No", SelectedPeriod)

                        end;
                        //End Fringe Benefits


                        //Loan Calculation is Amortized do Calculations here -Monthly Principal and Interest Keeps on Changing
                        if (prTransactionCodes."Special Transaction" = prTransactionCodes."special transaction"::"Staff Loan") and
                           (prTransactionCodes."Repayment Method" = prTransactionCodes."repayment method"::Reducing) then begin
                            curTransAmount := 0;
                            curLoanInt := 0;

                            LoanRegister.RESET;
                            LoanRegister.SETRANGE(LoanRegister."Loan  No.", prEmployeeTransactions."Loan Number");

                            IF LoanRegister.FINDFIRST THEN BEGIN
                                LoanRegister.CALCFIELDS(LoanRegister."Outstanding Balance"); // Ensure calculated field is updated
                                prEmployeeTransactions.Balance := Round(LoanRegister."Outstanding Balance", 0.01); // Update balance before calculation
                            END;

                            if (FnLoanInterestExempted(prEmployeeTransactions."Loan Number") = false) then
                                curLoanInt := fnCalcLoanInterest(strEmpCode, prEmployeeTransactions."Transaction Code", //prEmployeeTransactions."Outstanding Interest";
                                FnGetInterestRate(prEmployeeTransactions."Transaction Code"), prTransactionCodes."Repayment Method",
                                   prEmployeeTransactions.Amount, prEmployeeTransactions.Balance, SelectedPeriod, false);
                            curTransAmount := curLoanInt;
                            //for Reducing mk
                            prEmployeeTransactions."Interest Charged" := curTransAmount;
                            prEmployeeTransactions.Modify;


                            //end
                            curTotalDeductions := curTotalDeductions + curTransAmount; //Sum-up all the deductions
                            curTransBalance := 0;
                            strTransCode := prEmployeeTransactions."Transaction Code" + '-INT';
                            strTransDescription := prEmployeeTransactions."Transaction Name" + 'Interest';
                            TGroup := 'DEDUCTIONS';
                            TGroupOrder := 8;
                            TSubGroupOrder := 1;
                            if curTransAmount <> 0 then
                                fnUpdatePeriodTrans(strEmpCode, strTransCode, TGroup, TGroupOrder, TSubGroupOrder,
                                  strTransDescription, curTransAmount, curTransBalance, intMonth, intYear,
                                  prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No", SelectedPeriod, Dept,
                                  JournalAcc, Journalpostas::Credit, JournalPostingType, prEmployeeTransactions."Loan Number",
                                  Coopparameters::"loan Interest");
                            curTransAmount := prEmployeeTransactions.Amount;
                            prEmployeeTransactions.Amount := curTransAmount;
                            prEmployeeTransactions.Modify;

                            // Message('Reducing Loan %1, Loan Interest amnt %2', strTransDescription, curTransAmount);

                        end;
                        //Loan Calculation Amortized


                        case prTransactionCodes."Balance Type" of //[0=None, 1=Increasing, 2=Reducing]
                            prTransactionCodes."balance type"::None:
                                curTransBalance := 0;
                            prTransactionCodes."balance type"::Increasing:
                                curTransBalance := prEmployeeTransactions.Balance + curTransAmount;
                            prTransactionCodes."balance type"::Reducing:
                                begin
                                    //curTransBalance := prEmployeeTransactions.Balance - curTransAmount;
                                    if prEmployeeTransactions.Balance < prEmployeeTransactions.Amount then begin
                                        curTransAmount := prEmployeeTransactions.Balance;
                                        curTransBalance := 0;
                                    end else begin
                                        curTransBalance := prEmployeeTransactions.Balance - curTransAmount;
                                    end;
                                    if curTransBalance < 0 then begin
                                        curTransAmount := 0;
                                        curTransBalance := 0;
                                    end;
                                end
                        end;

                        if (prTransactionCodes."Special Transaction" = prTransactionCodes."special transaction"::"Staff Loan") and
                           (prTransactionCodes."Repayment Method" = prTransactionCodes."repayment method"::Amortized) then begin
                            curTransAmount := 0;
                            curLoanInt := 0;

                            LoanRegister.RESET;
                            LoanRegister.SETRANGE(LoanRegister."Loan  No.", prEmployeeTransactions."Loan Number");

                            IF LoanRegister.FINDFIRST THEN BEGIN
                                LoanRegister.CALCFIELDS(LoanRegister."Outstanding Balance"); // Ensure calculated field is updated
                                prEmployeeTransactions.Balance := Round(LoanRegister."Outstanding Balance", 0.01); // Update balance before calculation
                            END;
                            curLoanInt := fnCalcLoanInterest(strEmpCode, prEmployeeTransactions."Transaction Code",
                            prTransactionCodes."Interest Rate", prTransactionCodes."Repayment Method",
                              prEmployeeTransactions."Original Amount", prEmployeeTransactions.Balance, SelectedPeriod, false);
                            //Post the Interest
                            //MESSAGE('Loanno %1|curLoanInt %2|prEmployeeTransactions."Original Amount" %3',prEmployeeTransactions."Loan Number",curLoanInt,prEmployeeTransactions."Original Amount");
                            //IF (curLoanInt<>0) THEN BEGIN
                            curTransAmount := curLoanInt;

                            // curTransAmount := prEmployeeTransactions.Amount-curLoanInt;

                            curTotalDeductions := curTotalDeductions + curTransAmount; //Sum-up all the deductions
                            curTransBalance := 0;
                            //curTransBalance := prEmployeeTransactions.Balance - prEmployeeTransactions."Amtzd Loan Repay Amt";
                            strTransCode := prEmployeeTransactions."Transaction Code" + '-INT';
                            strTransDescription := prEmployeeTransactions."Transaction Name" + 'Interest';
                            TGroup := 'DEDUCTIONS';
                            TGroupOrder := 8;
                            TSubGroupOrder := 1;
                            fnUpdatePeriodTrans(strEmpCode, strTransCode, TGroup, TGroupOrder, TSubGroupOrder,
                              strTransDescription, curTransAmount, curTransBalance, intMonth, intYear,
                              prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No", SelectedPeriod, Dept,
                              JournalAcc, Journalpostas::Credit, JournalPostingType, prEmployeeTransactions."Loan Number",
                              Coopparameters::"loan Interest");
                            //mk

                            prEmployeeTransactions."Interest Charged" := curTransAmount;

                            prEmployeeTransactions.Modify;

                            // END;
                            //Get the Principal Amt
                            curTransAmount := prEmployeeTransactions."Amtzd Loan Repay Amt" - curLoanInt;
                            // curTransAmount :=curLoanInt;// prEmployeeTransactions.Amount;
                            //Modify PREmployeeTransaction Table
                            prEmployeeTransactions.Amount := curTransAmount;
                            prEmployeeTransactions.Modify;

                            // Final debug message for confirmation
                            // MESSAGE('Final Prn Repayment Amount: %1 |Amr Amnt: %8| Description -> %5| Interest Amount: %2 | Original Amount: %3 | Interest Rate: %4|prEmployeeTransactions.Balance %6|curTransBalance %7 ',
                            //         curTransAmount, curLoanInt, prEmployeeTransactions."Original Amount", prTransactionCodes."Interest Rate", strTransDescription, prEmployeeTransactions.Balance, curTransBalance, prEmployeeTransactions."Amtzd Loan Repay Amt");

                        end;
                        //Loan Calculation Amortized

                        case prTransactionCodes."Balance Type" of //[0=None, 1=Increasing, 2=Reducing]
                            prTransactionCodes."balance type"::None:
                                curTransBalance := 0;
                            prTransactionCodes."balance type"::Increasing:
                                curTransBalance := prEmployeeTransactions.Balance + curTransAmount;
                            prTransactionCodes."balance type"::Reducing:
                                begin
                                    //curTransBalance := prEmployeeTransactions.Balance - curTransAmount;
                                    if prEmployeeTransactions.Balance < prEmployeeTransactions.Amount then begin
                                        curTransAmount := prEmployeeTransactions.Balance;
                                        curTransBalance := 0;
                                    end else begin
                                        curTransBalance := prEmployeeTransactions.Balance - curTransAmount;
                                    end;
                                    if curTransBalance < 0 then begin
                                        curTransAmount := 0;
                                        curTransBalance := 0;
                                    end;
                                end
                        end;

                        curTotalDeductions := curTotalDeductions + curTransAmount; //Sum-up all the deductions
                        curTransAmount := curTransAmount;
                        curTransBalance := curTransBalance;
                        strTransDescription := prTransactionCodes."Transaction Name";
                        TGroup := 'DEDUCTIONS';
                        TGroupOrder := 8;
                        TSubGroupOrder := 0;
                        fnUpdatePeriodTrans(strEmpCode, prEmployeeTransactions."Transaction Code", TGroup, TGroupOrder, TSubGroupOrder,
                         strTransDescription, curTransAmount, curTransBalance, intMonth,
                         intYear, prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No", SelectedPeriod, Dept,
                         JournalAcc, Journalpostas::Credit, JournalPostingType, prEmployeeTransactions."Loan Number",
                         prTransactionCodes."Co-Op Parameters");

                        //Create Employer Deduction
                        if (prTransactionCodes."Employer Deduction") or (prTransactionCodes."Include Employer Deduction") then begin
                            if prTransactionCodes."Formulae for Employer" <> '' then begin
                                strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, prTransactionCodes."Formulae for Employer");
                                curTransAmount := fnFormulaResult(strExtractedFrml); //Get the calculated amount
                            end else begin
                                curTransAmount := prEmployeeTransactions."Employer Amount";
                            end;
                            if curTransAmount > 0 then
                                fnUpdateEmployerDeductions(strEmpCode, prEmployeeTransactions."Transaction Code",
                                 'EMP', TGroupOrder, TSubGroupOrder, '', curTransAmount, 0, intMonth, intYear,
                                  prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No", SelectedPeriod);
                        end;
                        //Employer deductions

                    end;

                until prEmployeeTransactions.Next = 0;
                //GET TOTAL DEDUCTIONS
                /*curTotalDeductions:=curTotalDeductions;
                      curTransBalance:=0;
                      strTransCode := 'OTHER-DED';
                      strTransDescription := 'Other Deductions';
                      TGroup := 'DEDUCTIONS'; TGroupOrder := 8; TSubGroupOrder := 8;
                      fnUpdatePeriodTrans(strEmpCode, strTransCode, TGroup, TGroupOrder, TSubGroupOrder,
                        strTransDescription, curTotalDeductions, curTransBalance, intMonth, intYear,
                        prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No",SelectedPeriod,Dept,
                        '',JournalPostAs::" ",JournalPostingType::" ",'',CoopParameters::none);
                        */
                curTotalDeductions := curTotalDeductions + curDefinedContrib + curPAYE /* - Curhouselevy */;

                curTransBalance := 0;
                strTransCode := 'TOT-DED';
                strTransDescription := 'TOTAL DEDUCTION';
                TGroup := 'DEDUCTIONS';
                TGroupOrder := 8;
                TSubGroupOrder := 9;
                fnUpdatePeriodTrans(strEmpCode, strTransCode, TGroup, TGroupOrder, TSubGroupOrder,
                  strTransDescription, curTotalDeductions, curTransBalance, intMonth, intYear,
                  prEmployeeTransactions.Membership, prEmployeeTransactions."Reference No", SelectedPeriod, Dept,
                  '', Journalpostas::" ", Journalpostingtype::" ", '', Coopparameters::none)

                //END GET TOTAL DEDUCTIONS
            end;

            //Net Pay: calculate the Net pay for the month in the following manner:
            //>Nett = Gross - (xNssfAmount + curMyNhifAmt + PAYE + PayeArrears + prTotDeductions)
            //...Tot Deductions also include (SumLoan + SumInterest)
            //curNetPay := curGrossPay - (curNSSF + curNHIF + curPAYE + curPayeArrears + curTotalDeductions+IsCashBenefit+Teltax2);
            curNetPay := curGrossPay - ROUND((curTotalDeductions + IsCashBenefit + Teltax2), 0.05, '<');

            //>Nett = Nett - curExcessPension
            //...Excess pension is only used for tax. Staff is not paid the amount hence substract it

            //  IF strEmpCode='011687' THEN
            // ERROR('%1 %2 %3',curGrossPay,curNetPay,ROUND(curNetPay,0.05,'<'));

            curNetPay := ROUND(curNetPay, 0.05, '<'); //- curExcessPension
                                                      // IF strEmpCode='011687' THEN
                                                      // ERROR('%1 %2 %3',curGrossPay,ROUND((curTotalDeductions+IsCashBenefit+Teltax2),0.05,'<'),curNetPay);
                                                      //>Nett = Nett - cSumEmployerDeductions
                                                      //...Employer Deductions are used for reporting as cost to company BUT dont affect Net pay
            curNetPay := curNetPay - ROUND(curTotCompanyDed, 0.05, '<'); //******Get Company Deduction*****

            // MESSAGE ('...curNetPay %1...#...curTotCompanyDed  %2....#curGrossPay  %3...#..curTotalDeductions  %4..#...strEmpCode%5',curNetPay,curTotCompanyDed,curGrossPay,curTotalDeductions,strEmpCode);

            curNetRnd_Effect := ROUND(curNetPay, 0.05, '<') - ROUND(curNetPay, 0.05, '<');
            curTransAmount := ROUND(curNetPay, 0.05, '<');
            strTransDescription := 'Net Pay';
            TGroup := 'NET PAY';
            TGroupOrder := 9;
            TSubGroupOrder := 0;

            fnUpdatePeriodTrans(strEmpCode, 'NPAY', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
            curTransAmount, 0, intMonth, intYear, '', '', SelectedPeriod, Dept,
            PayablesAcc, Journalpostas::Credit, Journalpostingtype::"G/L Account", '', Coopparameters::none);

            //Rounding Effect: if the Net pay is rounded, take the rounding effect &
            //save it as an earning for the staff for the next month
            //>Insert the Netpay rounding effect into the tblRoundingEffect table


            //Negative pay: if the NetPay<0 then log the entry
            //>Display an on screen report
            //>Through a pop-up to the user
            //>Send an email to the user or manager
        end
        //***************************************************************************************************************************

    end;


    procedure fnBasicPayProrated(strEmpCode: Code[20]; Month: Integer; Year: Integer; BasicSalary: Decimal; DaysWorked: Integer; DaysInMonth: Integer) ProratedAmt: Decimal
    begin
        ProratedAmt := ROUND((DaysWorked / DaysInMonth) * BasicSalary, 0.05, '<');
    end;


    procedure fnDaysInMonth(dtDate: Date) DaysInMonth: Integer
    var
        Day: Integer;
        SysDate: Record Date;
        Expr1: Text[30];
        FirstDay: Date;
        LastDate: Date;
        TodayDate: Date;
    begin
        TodayDate := dtDate;

        Day := DATE2DMY(TodayDate, 1);
        Expr1 := FORMAT(-Day) + 'D+1D';
        FirstDay := CALCDATE(Expr1, TodayDate);
        LastDate := CALCDATE('1M-1D', FirstDay);

        SysDate.RESET;
        SysDate.SETRANGE(SysDate."Period Type", SysDate."Period Type"::Date);
        SysDate.SETRANGE(SysDate."Period Start", FirstDay, LastDate);
        // SysDate.SETFILTER(SysDate."Period No.",'1..5');
        IF SysDate.FIND('-') THEN
            DaysInMonth := SysDate.COUNT;
    end;

    procedure fnUpdateEmployerDeductions(EmpCode: Code[20]; TCode: Code[20]; TGroup: Code[20]; GroupOrder: Integer; SubGroupOrder: Integer; Description: Text[50]; curAmount: Decimal; curBalance: Decimal; Month: Integer; Year: Integer; mMembership: Text[30]; ReferenceNo: Text[30]; dtOpenPeriod: Date)
    var
        prEmployerDeductions: Record "Payroll Employer Deductions.";
    begin

        if curAmount = 0 then exit;
        prEmployerDeductions.Init;
        prEmployerDeductions."Employee Code" := EmpCode;
        prEmployerDeductions."Transaction Code" := TCode;
        prEmployerDeductions.Amount := curAmount;
        prEmployerDeductions."Period Month" := Month;
        prEmployerDeductions."Period Year" := Year;
        prEmployerDeductions."Payroll Period" := dtOpenPeriod;
        prEmployerDeductions.Insert;
    end;

    local procedure FnGetInterestRate(LoanProductCode: Code[40]) InterestRate: Decimal
    var
        ObjLoanProducts: Record "Loan Products Setup";
    begin
        ObjLoanProducts.Reset;
        ObjLoanProducts.SetRange(ObjLoanProducts.Code, LoanProductCode);
        if ObjLoanProducts.Find('-') then begin
            InterestRate := ObjLoanProducts."Interest rate";
        end;
        exit(InterestRate);
    end;

    procedure fnGetEmployeePaye(curTaxablePay: Decimal) PAYE: Decimal
    var
        prPAYE: Record "Payroll PAYE Setup.";
        curTempAmount: Decimal;
        KeepCount: Integer;
    begin
        KeepCount := 0;
        prPAYE.RESET;
        IF prPAYE.FINDFIRST THEN BEGIN
            IF curTaxablePay < prPAYE."PAYE Tier" THEN EXIT;
            REPEAT
                KeepCount += 1;
                curTempAmount := curTaxablePay;
                IF curTaxablePay = 0 THEN EXIT;
                IF KeepCount = prPAYE.COUNT THEN   //this is the last record or loop
                    curTaxablePay := curTempAmount
                ELSE
                    IF curTempAmount >= prPAYE."PAYE Tier" THEN
                        curTempAmount := prPAYE."PAYE Tier"
                    ELSE
                        curTempAmount := curTempAmount;

                PAYE := PAYE + (curTempAmount * (prPAYE.Rate / 100));
                curTaxablePay := curTaxablePay - curTempAmount;

            UNTIL prPAYE.NEXT = 0;
        END;
    end;

    procedure fnGetEmployeeNHIF(curBaseAmount: Decimal) NHIF: Decimal
    var
        prNHIF: Record "Payroll NHIF Setup.";
    begin

        prNHIF.RESET;
        prNHIF.SETCURRENTKEY(prNHIF."Tier Code");
        IF prNHIF.FINDFIRST THEN BEGIN
            REPEAT
                IF ((curBaseAmount >= prNHIF."Lower Limit") AND (curBaseAmount <= prNHIF."Upper Limit")) THEN
                    NHIF := prNHIF.Amount;
            UNTIL prNHIF.NEXT = 0;
        END;
    end;

    procedure fnCheckPaysPension(pnEmpCode: Code[20]; pnPayperiod: Date) PaysPens: Boolean
    var
        pnTranCode: Record "Payroll Transaction Code.";
        pnEmpTrans: Record "Payroll Employee Transactions.";
    begin
        PaysPens := false;
        pnEmpTrans.Reset;
        pnEmpTrans.SetRange(pnEmpTrans."No.", pnEmpCode);
        pnEmpTrans.SetRange(pnEmpTrans."Payroll Period", pnPayperiod);
        if pnEmpTrans.Find('-') then begin
            repeat
            // if pnTranCode.Get(pnEmpTrans."Transaction Code") then
            //     if pnTranCode."Co-Op Parameters" = pnTranCode."co-op parameters"::Welfare then
            //PaysPens := true;
            until pnEmpTrans.Next = 0;
        end;
    end;

    procedure fnClosePayrollPeriod(dtOpenPeriod: Date; PayrollCode: Code[20]) Closed: Boolean
    var
        dtNewPeriod: Date;
        intNewMonth: Integer;
        intNewYear: Integer;
        prEmployeeTransactions: Record "Payroll Employee Transactions.";
        prPeriodTransactions: Record "prPeriod Transactions.";
        intMonth: Integer;
        intYear: Integer;
        prTransactionCodes: Record "Payroll Transaction Code.";
        curTransAmount: Decimal;
        curTransBalance: Decimal;
        prEmployeeTrans: Record "Payroll Employee Transactions.";
        prPayrollPeriods: Record "Payroll Calender.";
        prNewPayrollPeriods: Record "Payroll Calender.";
        CreateTrans: Boolean;
        ControlInfo: Record "Control-Information.";
    begin
        //ControlInfo.GET();
        dtNewPeriod := CalcDate('1M', dtOpenPeriod);
        intNewMonth := Date2dmy(dtNewPeriod, 2);
        intNewYear := Date2dmy(dtNewPeriod, 3);

        intMonth := Date2dmy(dtOpenPeriod, 2);
        intYear := Date2dmy(dtOpenPeriod, 3);

        prEmployeeTransactions.Reset;
        prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Month", intMonth);
        prEmployeeTransactions.SetRange(prEmployeeTransactions."Period Year", intYear);

        //Multiple Payroll
        if ControlInfo."Multiple Payroll" then
            prEmployeeTransactions.SetRange(prEmployeeTransactions."Payroll Code", PayrollCode);

        if prEmployeeTransactions.Find('-') then begin
            repeat
                prTransactionCodes.Reset;
                prTransactionCodes.SetRange(prTransactionCodes."Transaction Code", prEmployeeTransactions."Transaction Code");
                if prTransactionCodes.Find('-') then begin
                    with prTransactionCodes do begin
                        case prTransactionCodes."Balance Type" of
                            prTransactionCodes."balance type"::None:
                                begin
                                    curTransAmount := prEmployeeTransactions.Amount;
                                    curTransBalance := 0;
                                end;
                            prTransactionCodes."balance type"::Increasing:
                                begin
                                    curTransAmount := prEmployeeTransactions.Amount;
                                    curTransBalance := prEmployeeTransactions.Balance + prEmployeeTransactions.Amount;
                                end;
                            prTransactionCodes."balance type"::Reducing:
                                begin
                                    curTransAmount := prEmployeeTransactions.Amount;
                                    if prEmployeeTransactions.Balance < prEmployeeTransactions.Amount then begin
                                        curTransAmount := prEmployeeTransactions.Balance;
                                        curTransBalance := 0;
                                    end else begin
                                        curTransBalance := prEmployeeTransactions.Balance - prEmployeeTransactions.Amount;
                                    end;

                                    if curTransBalance < 0 then begin
                                        curTransAmount := 0;
                                        curTransBalance := 0;
                                    end;
                                end;
                        end;
                    end;
                end;

                //For those transactions with Start and End Date Specified
                if (prEmployeeTransactions."Start Date" <> 0D) and (prEmployeeTransactions."End Date" <> 0D) then begin
                    if prEmployeeTransactions."End Date" < dtNewPeriod then begin
                        curTransAmount := 0;
                        curTransBalance := 0;
                    end;
                end;
                //End Transactions with Start and End Date

                if (prTransactionCodes.Frequency = prTransactionCodes.Frequency::Fixed) and
                   (prEmployeeTransactions."Stop for Next Period" = false) then //DENNO ADDED THIS TO CHECK FREQUENCY AND STOP IF MARKED
                 begin
                    if (curTransAmount <> 0) then  //Update the employee transaction table
                     begin
                        if ((prTransactionCodes."Balance Type" = prTransactionCodes."balance type"::Reducing) and (curTransBalance <> 0)) or
                         (prTransactionCodes."Balance Type" <> prTransactionCodes."balance type"::Reducing) then
                            prEmployeeTransactions.Balance := curTransBalance;
                        prEmployeeTransactions.Modify;


                        //Insert record for the next period
                        with prEmployeeTrans do begin
                            prEmployeeTrans.Init;
                            prEmployeeTrans."No." := prEmployeeTransactions."No.";
                            prEmployeeTrans."Transaction Code" := prEmployeeTransactions."Transaction Code";
                            prEmployeeTrans."Transaction Name" := prEmployeeTransactions."Transaction Name";
                            prEmployeeTrans."Transaction Type" := prEmployeeTransactions."Transaction Type";
                            prEmployeeTrans.Amount := curTransAmount;
                            prEmployeeTrans.Balance := curTransBalance;
                            prEmployeeTrans."Amtzd Loan Repay Amt" := prEmployeeTransactions."Amtzd Loan Repay Amt";
                            prEmployeeTrans."Original Amount" := prEmployeeTransactions."Original Amount";
                            prEmployeeTrans.Membership := prEmployeeTransactions.Membership;
                            prEmployeeTrans."Reference No" := prEmployeeTransactions."Reference No";
                            prEmployeeTrans."Loan Number" := prEmployeeTransactions."Loan Number";
                            prEmployeeTrans."Period Month" := intNewMonth;
                            prEmployeeTrans."Period Year" := intNewYear;
                            prEmployeeTrans."Payroll Period" := dtNewPeriod;
                            prEmployeeTrans."Payroll Code" := PayrollCode;
                            prEmployeeTrans.Insert;
                        end;
                    end;
                end
            until prEmployeeTransactions.Next = 0;
        end;

        //Update the Period as Closed
        prPayrollPeriods.Reset;
        prPayrollPeriods.SetRange(prPayrollPeriods."Period Month", intMonth);
        prPayrollPeriods.SetRange(prPayrollPeriods."Period Year", intYear);
        prPayrollPeriods.SetRange(prPayrollPeriods.Closed, false);
        if ControlInfo."Multiple Payroll" then
            prPayrollPeriods.SetRange(prPayrollPeriods."Payroll Code", PayrollCode);

        if prPayrollPeriods.Find('-') then begin
            prPayrollPeriods.Closed := true;
            prPayrollPeriods."Date Closed" := Today;
            prPayrollPeriods.Modify;
        end;

        //Enter a New Period
        prNewPayrollPeriods.Init;
        prNewPayrollPeriods."Period Month" := intNewMonth;
        prNewPayrollPeriods."Period Year" := intNewYear;
        prNewPayrollPeriods."Period Name" := Format(dtNewPeriod, 0, '<Month Text>') + '' + Format(intNewYear);
        prNewPayrollPeriods."Date Opened" := dtNewPeriod;
        prNewPayrollPeriods.Closed := false;
        prNewPayrollPeriods."Payroll Code" := PayrollCode;
        prNewPayrollPeriods.Insert;

        //Effect the transactions for the P9
        fnP9PeriodClosure(intMonth, intYear, dtOpenPeriod, PayrollCode);

        //Take all the Negative pay (Net) for the current month & treat it as a deduction in the new period
        fnGetNegativePay(intMonth, intYear, dtOpenPeriod);
    end;

    procedure fnGetNegativePay(intMonth: Integer; intYear: Integer; dtOpenPeriod: Date)
    var
        prPeriodTransactions: Record "prPeriod Transactions.";
        prEmployeeTransactions: Record "Payroll Employee Transactions.";
        intNewMonth: Integer;
        intNewYear: Integer;
        dtNewPeriod: Date;
    begin
        dtNewPeriod := CalcDate('1M', dtOpenPeriod);
        intNewMonth := Date2dmy(dtNewPeriod, 2);
        intNewYear := Date2dmy(dtNewPeriod, 3);

        prPeriodTransactions.Reset;
        prPeriodTransactions.SetRange(prPeriodTransactions."Period Month", intMonth);
        prPeriodTransactions.SetRange(prPeriodTransactions."Period Year", intYear);
        prPeriodTransactions.SetRange(prPeriodTransactions."Group Order", 9);
        prPeriodTransactions.SetFilter(prPeriodTransactions.Amount, '<0');

        if prPeriodTransactions.Find('-') then begin
            repeat
                prEmployeeTransactions.Init;
                prEmployeeTransactions."No." := prPeriodTransactions."Employee Code";
                prEmployeeTransactions."Transaction Code" := 'NEGP';
                prEmployeeTransactions."Transaction Name" := 'Negative Pay';
                prEmployeeTransactions.Amount := prPeriodTransactions.Amount;
                prEmployeeTransactions.Balance := 0;
                prEmployeeTransactions."Original Amount" := 0;
                prEmployeeTransactions."Period Month" := intNewMonth;
                prEmployeeTransactions."Period Year" := intNewYear;
                prEmployeeTransactions."Payroll Period" := dtNewPeriod;
                prEmployeeTransactions.Insert;
            until prPeriodTransactions.Next = 0;
        end;
    end;


    procedure fnP9PeriodClosure(intMonth: Integer; intYear: Integer; dtCurPeriod: Date; PayrollCode: Code[20])
    var
        P9EmployeeCode: Code[20];
        P9BasicPay: Decimal;
        P9Allowances: Decimal;
        P9Benefits: Decimal;
        P9ValueOfQuarters: Decimal;
        P9DefinedContribution: Decimal;
        P9OwnerOccupierInterest: Decimal;
        P9GrossPay: Decimal;
        P9TaxablePay: Decimal;
        P9TaxCharged: Decimal;
        P9InsuranceRelief: Decimal;
        P9TaxRelief: Decimal;
        P9Paye: Decimal;
        P9NSSF: Decimal;
        P9NHIF: Decimal;
        P9Deductions: Decimal;
        P9NetPay: Decimal;
        prPeriodTransactions: Record "prPeriod Transactions.";
        prEmployee: Record "Payroll Employee.";
    begin
        P9BasicPay := 0;
        P9Allowances := 0;
        P9Benefits := 0;
        P9ValueOfQuarters := 0;
        P9DefinedContribution := 0;
        P9OwnerOccupierInterest := 0;
        P9GrossPay := 0;
        P9TaxablePay := 0;
        P9TaxCharged := 0;
        P9InsuranceRelief := 0;
        P9TaxRelief := 0;
        P9Paye := 0;
        P9NSSF := 0;
        P9NHIF := 0;
        P9Deductions := 0;
        P9NetPay := 0;

        prEmployee.Reset;
        prEmployee.SetRange(prEmployee.Status, prEmployee.Status::Active);
        if prEmployee.Find('-') then begin
            repeat

                P9BasicPay := 0;
                P9Allowances := 0;
                P9Benefits := 0;
                P9ValueOfQuarters := 0;
                P9DefinedContribution := 0;
                P9OwnerOccupierInterest := 0;
                P9GrossPay := 0;
                P9TaxablePay := 0;
                P9TaxCharged := 0;
                P9InsuranceRelief := 0;
                P9TaxRelief := 0;
                P9Paye := 0;
                P9NSSF := 0;
                P9NHIF := 0;
                P9Deductions := 0;
                P9NetPay := 0;

                prPeriodTransactions.Reset;
                prPeriodTransactions.SetRange(prPeriodTransactions."Period Month", intMonth);
                prPeriodTransactions.SetRange(prPeriodTransactions."Period Year", intYear);
                prPeriodTransactions.SetRange(prPeriodTransactions."Employee Code", prEmployee."No.");
                if prPeriodTransactions.Find('-') then begin
                    repeat
                        case prPeriodTransactions."Group Order" of
                            1: //Basic pay & Arrears
                                begin
                                    if prPeriodTransactions."Sub Group Order" = 1 then P9BasicPay := prPeriodTransactions.Amount; //Basic Pay
                                    if prPeriodTransactions."Sub Group Order" = 2 then P9BasicPay := P9BasicPay + prPeriodTransactions.Amount; //Basic Pay Arrears
                                end;
                            3:  //Allowances
                                begin
                                    P9Allowances := P9Allowances + prPeriodTransactions.Amount
                                end;
                            4: //Gross Pay
                                begin
                                    P9GrossPay := prPeriodTransactions.Amount
                                end;
                            6: //Taxation
                                begin
                                    if prPeriodTransactions."Sub Group Order" = 1 then P9DefinedContribution := prPeriodTransactions.Amount; //Defined Contribution
                                    if prPeriodTransactions."Sub Group Order" = 9 then P9TaxRelief := prPeriodTransactions.Amount; //Tax Relief
                                    if prPeriodTransactions."Sub Group Order" = 8 then P9InsuranceRelief := prPeriodTransactions.Amount; //Insurance Relief
                                    if prPeriodTransactions."Sub Group Order" = 6 then P9TaxablePay := prPeriodTransactions.Amount; //Taxable Pay
                                    if prPeriodTransactions."Sub Group Order" = 7 then P9TaxCharged := prPeriodTransactions.Amount; //Tax Charged
                                end;
                            7: //Statutories
                                begin
                                    if prPeriodTransactions."Sub Group Order" = 1 then P9NSSF := prPeriodTransactions.Amount; //Nssf
                                    if prPeriodTransactions."Sub Group Order" = 2 then P9NHIF := prPeriodTransactions.Amount; //Nhif
                                    if prPeriodTransactions."Sub Group Order" = 3 then P9Paye := prPeriodTransactions.Amount; //paye

                                    // if "Sub Group Order" = 4 then P9Paye := P9Paye + Amount; //Paye Arrears
                                end;
                            8://Deductions
                                begin
                                    P9Deductions := P9Deductions + prPeriodTransactions.Amount;
                                end;
                            9: //NetPay
                                begin
                                    P9NetPay := prPeriodTransactions.Amount;
                                end;
                        end;
                    until prPeriodTransactions.Next = 0;
                end;
                //Update the P9 Details

                if P9NetPay <> 0 then
                    fnUpdateP9Table(prEmployee."No.", P9BasicPay, P9Allowances, P9Benefits, P9ValueOfQuarters, P9DefinedContribution,
                        P9OwnerOccupierInterest, P9GrossPay, P9TaxablePay, P9TaxCharged, P9InsuranceRelief, P9TaxRelief, P9Paye, P9NSSF,
                        P9NHIF, P9Deductions, P9NetPay, dtCurPeriod, PayrollCode);

            until prEmployee.Next = 0;
        end;
    end;

    procedure fnUpdateP9Table(P9EmployeeCode: Code[20]; P9BasicPay: Decimal; P9Allowances: Decimal; P9Benefits: Decimal; P9ValueOfQuarters: Decimal; P9DefinedContribution: Decimal; P9OwnerOccupierInterest: Decimal; P9GrossPay: Decimal; P9TaxablePay: Decimal; P9TaxCharged: Decimal; P9InsuranceRelief: Decimal; P9TaxRelief: Decimal; P9Paye: Decimal; P9NSSF: Decimal; P9NHIF: Decimal; P9Deductions: Decimal; P9NetPay: Decimal; dtCurrPeriod: Date; prPayrollCode: Code[20])
    var
        prEmployeeP9Info: Record "Payroll Employee P9.";
        intYear: Integer;
        intMonth: Integer;
    begin
        intMonth := Date2dmy(dtCurrPeriod, 2);
        intYear := Date2dmy(dtCurrPeriod, 3);

        prEmployeeP9Info.Reset;
        prEmployeeP9Info.Init;
        prEmployeeP9Info."Employee Code" := P9EmployeeCode;
        prEmployeeP9Info."Basic Pay" := P9BasicPay;
        prEmployeeP9Info.Allowances := P9Allowances;
        prEmployeeP9Info.Benefits := P9Allowances;
        prEmployeeP9Info."Value Of Quarters" := P9ValueOfQuarters;//Housing 
        prEmployeeP9Info."Defined Contribution" := P9DefinedContribution;
        prEmployeeP9Info."Owner Occupier Interest" := P9OwnerOccupierInterest;
        prEmployeeP9Info."Gross Pay" := P9GrossPay;
        prEmployeeP9Info."Taxable Pay" := P9TaxablePay;
        prEmployeeP9Info."Tax Charged" := P9TaxCharged;
        prEmployeeP9Info."Insurance Relief" := P9InsuranceRelief;
        prEmployeeP9Info."Tax Relief" := P9TaxRelief;
        prEmployeeP9Info.PAYE := P9Paye;
        prEmployeeP9Info.NSSF := P9NSSF;
        prEmployeeP9Info.NHIF := P9NHIF;
        prEmployeeP9Info.Deductions := P9Deductions;
        prEmployeeP9Info."Net Pay" := P9NetPay;
        prEmployeeP9Info."Period Month" := intMonth;
        prEmployeeP9Info."Period Year" := intYear;
        prEmployeeP9Info."Payroll Period" := dtCurrPeriod;
        prEmployeeP9Info."Payroll Code" := prPayrollCode;
        prEmployeeP9Info.Insert;
    end;


    procedure fnUpdatePeriodTrans(
    EmpCode: Code[20];
    TCode: Code[20];
    TGroup: Code[20];
    GroupOrder: Integer;
    SubGroupOrder: Integer;
    Description: Text[50];
    curAmount: Decimal;
    curBalance: Decimal;
    Month: Integer;
    Year: Integer;
    mMembership: Text[30];
    ReferenceNo: Text[30];
    dtOpenPeriod: Date;
    Department: Code[20];
    JournalAC: Code[20];
    PostAs: Option " ",Debit,Credit;
    JournalACType: Option " ","G/L Account",Customer,Vendor;
    LoanNo: Code[20];
    CoopParam: Option "none",shares,loan,"Loan Interest","Emergency loan","Emergency Loan Interest","School Fees loan","School Fees Loan Interest",Welfare,Pension
)
    var
        prPeriodTransactions: Record "prPeriod Transactions.";
        prSalCard: Record "Payroll Employee.";
    begin
        IF curAmount = 0 THEN EXIT; // Exit if amount is zero

        WITH prPeriodTransactions DO BEGIN
            // Check if the record already exists
            Reset();
            SetRange("Employee Code", EmpCode);
            SetRange("Transaction Code", TCode);
            SetRange("Period Month", Month);
            SetRange("Period Year", Year);
            SetRange("Membership", mMembership);
            SetRange("Reference No", ReferenceNo);
            SetRange("Loan Number", LoanNo);

            IF NOT FindFirst() THEN BEGIN
                // Only insert if no existing record is found
                Init();
                "Employee Code" := EmpCode;
                "Transaction Code" := TCode;
                "Group Text" := TGroup;
                "Transaction Name" := Description;
                Amount := ROUND(curAmount, 0.05, '<');
                Balance := curBalance;
                "Original Amount" := Balance;
                "Group Order" := GroupOrder;
                "Sub Group Order" := SubGroupOrder;
                Membership := mMembership;
                "Reference No" := ReferenceNo;
                "Period Month" := Month;
                "Period Year" := Year;
                "Payroll Period" := dtOpenPeriod;
                "Department Code" := Department;
                "Journal Account Type" := JournalACType;
                "Post As" := PostAs;
                "Journal Account Code" := JournalAC;
                "Loan Number" := LoanNo;
                "coop parameters" := CoopParam;
                "Payroll Code" := PayrollType;

                // Retrieve and set payment mode from Payroll Employee Card
                IF prSalCard.GET(EmpCode) THEN
                    "Payment Mode" := prSalCard."Payment Mode";

                INSERT; // Insert only if the record does not exist

                // Update the Payroll Employee Transactions with the Amount
                fnUpdateEmployeeTrans("Employee Code", "Transaction Code", Amount, "Period Month", "Period Year", "Payroll Period");
            END /* ELSE BEGIN
                // If record already exists, log a message (optional)
                Message('Transaction for Employee %1, Code %2, Period %3/%4 already exists. Skipping insert.',
                    EmpCode, TCode, Month, Year);
            END; */
        END;
    end;

    procedure fnCalcLoanInterest(strEmpCode: Code[20]; strTransCode: Code[20]; InterestRate: Decimal; RecoveryMethod: Option Reducing,"Straight line",Amortized; LoanAmount: Decimal; Balance: Decimal; CurrPeriod: Date; Welfare: Boolean) LnInterest: Decimal
    var
        curLoanInt: Decimal;
        intMonth: Integer;
        intYear: Integer;
    begin
        intMonth := Date2dmy(CurrPeriod, 2);
        intYear := Date2dmy(CurrPeriod, 3);
        curLoanInt := 0;

        if InterestRate > 0 then begin
            if RecoveryMethod = Recoverymethod::"Straight line" then //Straight Line Method [1]
                curLoanInt := (InterestRate / 1200) * LoanAmount;

            if RecoveryMethod = Recoverymethod::Reducing then //Reducing Balance [0]

                 curLoanInt := (InterestRate / 1200) * Balance;

            if RecoveryMethod = Recoverymethod::Amortized then //Amortized [2]
                curLoanInt := (InterestRate / 1200) * Balance;
        end else
            curLoanInt := 0;

        //Return the Amount
        LnInterest := ROUND(curLoanInt, 0.05, '<');
    end;

    procedure fnGetSpecialTransAmount(strEmpCode: Code[20]; intMonth: Integer; intYear: Integer; intSpecTransID: Option Ignore,"Defined Contribution","Home Ownership Savings Plan","Life Insurance","Owner Occupier Interest","Prescribed Benefit","Salary Arrears","Staff Loan","Value of Quarters",Morgage; blnCompDedc: Boolean) SpecialTransAmount: Decimal
    var
        prEmployeeTransactions: Record "Payroll Employee Transactions.";
        prTransactionCodes: Record "Payroll Transaction Code.";
        strExtractedFrml: Text[250];
    begin
        SpecialTransAmount := 0;
        prTransactionCodes.RESET;
        prTransactionCodes.SETRANGE(prTransactionCodes."Special Transaction", intSpecTransID);
        IF prTransactionCodes.FIND('-') THEN BEGIN
            REPEAT
                prEmployeeTransactions.RESET;
                prEmployeeTransactions.SETRANGE(prEmployeeTransactions."No.", strEmpCode);
                prEmployeeTransactions.SETRANGE(prEmployeeTransactions."Transaction Code", prTransactionCodes."Transaction Code");
                prEmployeeTransactions.SETRANGE(prEmployeeTransactions."Period Month", intMonth);
                prEmployeeTransactions.SETRANGE(prEmployeeTransactions."Period Year", intYear);
                // prEmployeeTransactions.SETRANGE(prEmployeeTransactions.Suspended,FALSE);
                IF prEmployeeTransactions.FIND('-') THEN BEGIN

                    //Ignore,Defined Contribution,Home Ownership Savings Plan,Life Insurance,
                    //Owner Occupier Interest,Prescribed Benefit,Salary Arrears,Staff Loan,Value of Quarters
                    CASE intSpecTransID OF
                        intSpecTransID::"Defined Contribution":
                            IF prTransactionCodes."Is Formulae" THEN BEGIN
                                //            strExtractedFrml := '';
                                //            IF Management THEN
                                // //              strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, prTransactionCodes."Leave Reimbursement")
                                //            ELSE
                                strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, prTransactionCodes.Formulae);

                                SpecialTransAmount := SpecialTransAmount + (fnFormulaResult(strExtractedFrml)); //Get the calculated amount
                            END ELSE
                                SpecialTransAmount := SpecialTransAmount + prEmployeeTransactions.Amount;

                        intSpecTransID::"Life Insurance":
                            SpecialTransAmount := SpecialTransAmount + ((curReliefInsurance / 100) * prEmployeeTransactions.Amount);

                        //
                        intSpecTransID::"Owner Occupier Interest":
                            SpecialTransAmount := SpecialTransAmount + prEmployeeTransactions.Amount;


                        intSpecTransID::"Home Ownership Savings Plan":
                            SpecialTransAmount := SpecialTransAmount + prEmployeeTransactions.Amount;

                        intSpecTransID::Morgage:
                            BEGIN
                                SpecialTransAmount := SpecialTransAmount + curReliefMorgage;

                                IF SpecialTransAmount > curReliefMorgage THEN BEGIN
                                    SpecialTransAmount := curReliefMorgage
                                END;

                            END;

                    END;
                END;
            UNTIL prTransactionCodes.NEXT = 0;
        END;
        SpecialTranAmount := SpecialTransAmount;
    end;

    procedure fnPureFormula(strEmpCode: Code[20]; intMonth: Integer; intYear: Integer; strFormula: Text[250]) Formula: Text[250]
    var
        Where: Text[30];
        Which: Text[30];
        i: Integer;
        TransCode: Code[20];
        Char: Text[1];
        FirstBracket: Integer;
        StartCopy: Boolean;
        FinalFormula: Text[250];
        TransCodeAmount: Decimal;
        AccSchedLine: Record "Acc. Schedule Line";
        ColumnLayout: Record "Column Layout";
        CalcAddCurr: Boolean;
    //AccSchedMgt: Codeunit AccSchedManagementCodeunit "";
    begin

    end;


    procedure fnUpdateEmployeeTrans(EmpCode: Code[20]; TransCode: Code[20]; Amount: Decimal; Month: Integer; Year: Integer; PayrollPeriod: Date)
    var
        prEmployeeTrans: Record "Payroll Employee Transactions.";
    begin
        prEmployeeTrans.Reset;
        prEmployeeTrans.SetRange(prEmployeeTrans."No.", EmpCode);
        /*prEmployeeTrans.SETRANGE(prEmployeeTrans."Transaction Code",TransCode);
        prEmployeeTrans.SETRANGE(prEmployeeTrans."Payroll Period",PayrollPeriod);
        prEmployeeTrans.SETRANGE(prEmployeeTrans."Period Month",Month);
        prEmployeeTrans.SETRANGE(prEmployeeTrans."Period Year",Year);*/
        if prEmployeeTrans.Find('-') then begin
            // prEmployeeTrans.Amount:=Amount;
            //prEmployeeTrans.MODIFY;
            FnUpdateBalances(prEmployeeTrans);
        end;

    end;

    local procedure FnUpdateBalances("Payroll Employee Transactions.": Record "Payroll Employee Transactions.")
    var
        ObjMemberLedger: Record "Cust. Ledger Entry";
        Totalshares: Decimal;
        ObjLoanRegister: Record "Loans Register";
        LNPric: Decimal;
        ObjPRTransactioons: Record "prPeriod Transactions.";
    begin
        ObjPRTransactioons.Reset;
        ObjPRTransactioons.SetRange(ObjPRTransactioons."Employee Code", "Payroll Employee Transactions."."No.");
        // Check if record already exists
        if not ObjPRTransactioons.FindFirst() then begin
            Report.Run(50591, false, false, ObjPRTransactioons);
        end;
    end;


    procedure fnDaysWorked(dtDate: Date; IsTermination: Boolean) DaysWorked: Integer
    var
        Day: Integer;
        SysDate: Record Date;
        Expr1: Text[30];
        FirstDay: Date;
        LastDate: Date;
        TodayDate: Date;
    begin
        TodayDate := dtDate;

        Day := Date2dmy(TodayDate, 1);
        Expr1 := Format(-Day) + 'D+1D';
        FirstDay := CalcDate(Expr1, TodayDate);
        LastDate := CalcDate('1M-1D', FirstDay);

        SysDate.Reset;
        SysDate.SetRange(SysDate."Period Type", SysDate."period type"::Date);
        if not IsTermination then
            SysDate.SetRange(SysDate."Period Start", dtDate, LastDate)
        else
            SysDate.SetRange(SysDate."Period Start", FirstDay, dtDate);
        // SysDate.SETFILTER(SysDate."Period No.",'1..5');
        if SysDate.Find('-') then
            DaysWorked := SysDate.Count;
    end;

    procedure fnFormulaResult(strFormula: Text[250]) Results: Decimal
    var
        AccSchedLine: Record "Acc. Schedule Line";
        ColumnLayout: Record "Column Layout";
        CalcAddCurr: Boolean;
        AccSchedMgt: Codeunit AccSchedManagement;
    begin
        // Results :=
        //  AccSchedMgt.EvaluateExpression(true, strFormula, AccSchedLine, ColumnLayout, CalcAddCurr);
    end;

    procedure FnLoanInterestExempted(LoanNo: Code[50]) Found: Boolean
    var
        ObjExemptedLoans: Record "Loan Repay Schedule-Calc";
    begin
        ObjExemptedLoans.Reset;
        ObjExemptedLoans.SetRange(ObjExemptedLoans."Loan Category", LoanNo);
        if ObjExemptedLoans.Find('-') then begin
            Found := true;
        end;
        exit(Found);
    end;


}
