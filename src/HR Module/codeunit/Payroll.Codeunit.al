// codeunit 52002 "Payroll"
// {
//     trigger OnRun()
//     begin
//     end;

//     procedure CalculateMonths(StartDate: Date; EndDate: Date) "count": Integer
//     var
//         NextDate: Date;
//         PreviousDate: Date;
//     begin
//         PreviousDate := StartDate;
//         Count := -1;
//         while PreviousDate <= EndDate do begin
//             NextDate := CalcDate('<1M>', PreviousDate);
//             Count += 1;
//             PreviousDate := NextDate;
//         end;
//     end;

//     procedure CheckIfPartime(Emp: Code[10]): Integer
//     var
//         Employee: Record "Employee";
//         EmpContract: Record "Employment Contract";
//     begin
//         if Employee.Get(Emp) then
//             if EmpContract.Get(Employee."Nature of Employment") then
//                 exit(EmpContract."Employee Type");
//     end;

//     procedure CheckOneThirdRule(EmpNo: Code[20]; PayP: Date; var NetPay: Decimal; var TotalEarnings: Decimal; var TotalDeductions: Decimal; var ExemptionDeductions: Decimal; var Ratio: Decimal): Boolean
//     var
//         EmpRec: Record "Employee";
//         HRSetup: Record "Human Resources Setup";
//         ExemptDeductions: Decimal;
//     begin
//         HRSetup.Get();
//         if HRSetup."Enforce a third rule" then begin
//             HRSetup.TestField("Net pay ratio to Earnings");
//             ExemptDeductions := 0;
//             TotalEarnings := 0;
//             TotalDeductions := 0;

//             EmpRec.Reset();
//             EmpRec.SetRange("No.", EmpNo);
//             EmpRec.SetRange("Pay Period Filter", PayP);
//             if EmpRec.Find('-') then
//                 if not EmpRec."Exempt from third rule" then begin
//                     EmpRec.CalcFields("Total Allowances", "Total Deductions");
//                     if EmpRec."Total Allowances" <> 0 then begin
//                         GetOneThirdExemptDeductions(EmpNo, PayP, ExemptDeductions);
//                         if (EmpRec."Total Allowances" - (Abs(EmpRec."Total Deductions") - ExemptDeductions)) /
//                             (EmpRec."Total Allowances") >= HRSetup."Net pay ratio to Earnings" then
//                             exit(true)
//                         else begin
//                             NetPay := EmpRec."Total Allowances" * HRSetup."Net pay ratio to Earnings";
//                             TotalEarnings := EmpRec."Total Allowances";
//                             TotalDeductions := Abs(EmpRec."Total Deductions");
//                             ExemptionDeductions := ExemptDeductions;
//                             Ratio := (TotalEarnings - (TotalDeductions - ExemptionDeductions)) / (TotalEarnings);
//                             Ratio := Round(Ratio);
//                             exit(false);
//                         end;
//                     end;
//                 end else
//                     exit(true);
//         end else
//             exit(true);

//         /* AssignMat.Reset();
//         AssignMat.SetRange("Employee No", EmpNo);
//         AssignMat.SetRange("Payroll Period", PayP);
//         if AssignMat.Find('-') then;
//         begin
//             AssignMat.SetRange(Type, AssignMat.Type::Payment);
//             AssignMat.CalcSums(Amount);
//             Earnin := AssignMat.Amount;
//             Message(Format(Earnin));
//         end;

//         begin
//             AssignMat.SetRange(Type, AssignMat.Type::Deduction);
//             AssignMat.CalcSums(Amount);
//             Deduc := AssignMat.Amount;
//             Message(Format(Deduc));
//         end;
//         Message(Format(Earnin + Deduc));
//         if ((Earnin + Deduc) > (AssignMat."Basic Pay" / HRSetup."Net pay ratio to Earnings")) then
//             Message('Insert') else
//             Message('Reduce Deductions'); */
//     end;

//     procedure FormatNoText(var NoText: array[2] of Text[80]; No: Decimal; CurrencyCode: Code[10])
//     var
//         PrintExponent: Boolean;
//         Exponent: Integer;
//         Hundreds: Integer;
//         NoTextIndex: Integer;
//         Ones: Integer;
//         Tens: Integer;
//         DashLbl: Label '-';
//         HundredLbl: Label 'HUNDRED';
//         ZeroLbl: Label 'ZERO';
//         ExponentText: array[5] of Text[30];
//         OnesText: array[20] of Text[30];
//         TensText: array[10] of Text[30];
//     begin
//         Clear(NoText);
//         NoTextIndex := 1;
//         NoText[1] := '****';
//         if No < 1 then
//             AddToNoText(NoText, NoTextIndex, PrintExponent, ZeroLbl)
//         else
//             for Exponent := 4 downto 1 do begin
//                 PrintExponent := false;
//                 Ones := No div Power(1000, Exponent - 1);
//                 Hundreds := Ones div 100;
//                 Tens := (Ones mod 100) div 10;
//                 Ones := Ones mod 10;
//                 if Hundreds > 0 then begin
//                     AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Hundreds]);
//                     AddToNoText(NoText, NoTextIndex, PrintExponent, HundredLbl);
//                 end;
//                 if Tens >= 2 then begin
//                     AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[Tens]);
//                     if Ones > 0 then
//                         AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Ones]);
//                 end else
//                     if (Tens * 10 + Ones) > 0 then
//                         AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Tens * 10 + Ones]);
//                 if PrintExponent and (Exponent > 1) then
//                     AddToNoText(NoText, NoTextIndex, PrintExponent, ExponentText[Exponent]);
//                 No := No - (Hundreds * 100 + Tens * 10 + Ones) * Power(1000, Exponent - 1);
//             end;
//         AddToNoText(NoText, NoTextIndex, PrintExponent, DashLbl);
//         AddToNoText(NoText, NoTextIndex, PrintExponent, '');
//         //FORMAT(No * 100) + '/100');
//         if CurrencyCode <> '' then
//             AddToNoText(NoText, NoTextIndex, PrintExponent, CurrencyCode);
//     end;



//     procedure GetCurrentBasicPay(EmpNo: Code[20]; PayPeriod: Date): Decimal
//     var
//         AssignmentMatrix: Record "Assignment Matrix";
//         Earnings: Record Earnings;
//     begin
//         Earnings.Reset();
//         Earnings.SetRange("Basic Salary Code", true);
//         if Earnings.FindFirst() then begin
//             AssignmentMatrix.Reset();
//             AssignmentMatrix.SetRange(Code, Earnings.Code);
//             AssignmentMatrix.SetRange("Employee No", EmpNo);
//             AssignmentMatrix.SetRange("Payroll Period", PayPeriod);
//             AssignmentMatrix.SetCurrentKey("Employee No", Code, "Payroll Period");
//             if AssignmentMatrix.FindFirst() then
//                 exit((AssignmentMatrix.Amount * 12 / 100));
//         end;
//     end;

//     procedure GetCurrentPay(EmpNo: Code[20]; PayPeriod: Date; "Code": Code[10]): Decimal
//     var
//         AssignmentMatrix: Record "Assignment Matrix";
//     begin
//         AssignmentMatrix.Reset();
//         AssignmentMatrix.SetRange(Code, Code);
//         AssignmentMatrix.SetRange("Employee No", EmpNo);
//         AssignmentMatrix.SetRange("Payroll Period", PayPeriod);
//         AssignmentMatrix.SetCurrentKey("Employee No", Code, "Payroll Period");
//         if AssignmentMatrix.FindFirst() then
//             exit(AssignmentMatrix.Amount);
//     end;

//     procedure GetEmpName(EmpCode: Code[20]): Text
//     var
//         Employee: Record "Employee";
//     begin
//         if Employee.Get(EmpCode) then
//             exit(Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name");
//     end;

//     procedure GetOneThirdExemptDeductions(EmpNo: Code[20]; Period: Date; var ExemptDeductions: Decimal): Boolean
//     var
//         AssignMat: Record "Assignment Matrix";
//         Ded: Record Deductions;
//     begin
//         Ded.Reset();
//         Ded.SetRange("Exempt from a third rule", true);
//         if Ded.FindSet() then begin
//             repeat
//                 AssignMat.Reset();
//                 AssignMat.SetRange("Employee No", EmpNo);
//                 AssignMat.SetRange(Type, AssignMat.Type::Deduction);
//                 AssignMat.SetRange("Payroll Period", Period);
//                 AssignMat.SetRange(Code, Ded.Code);
//                 if AssignMat.FindFirst() then
//                     ExemptDeductions := ExemptDeductions + AssignMat.Amount;
//             until Ded.Next() = 0;
//             ExemptDeductions := Abs(ExemptDeductions);
//         end else
//             ExemptDeductions := 0;
//     end;

//     procedure GetIntReceivableAccount(LoanNo: Code[50]): Code[20]
//     var
//         LoanProductType: Record "Loan Product Type-Payroll";
//         LoanApp: Record "Payroll Loan Application";
//     begin
//         if LoanApp.Get(LoanNo) then
//             if LoanProductType.Get(LoanApp."Loan Product Type") then begin
//                 LoanProductType.TestField("Interest Receivable Account");
//                 exit(CopyStr(LoanProductType."Interest Receivable Account", 1, 20));
//             end;
//     end;

//     procedure GetMonthWorked(No: Code[20]) Months: Integer
//     var
//         Calender: Record Date;
//         Employee: Record "Employee";
//         EndDate: Date;
//         StartDate: Date;
//     begin
//         if Employee.Get(No) then begin
//             StartDate := Employee."Contract Start Date";
//             EndDate := Employee."Contract End Date";
//             if (StartDate <> 0D) and (EndDate > StartDate) then begin
//                 Calender.Reset();
//                 Calender.SetRange("Period Type", Calender."Period Type"::Month);
//                 Calender.SetRange("Period Start", StartDate, EndDate);
//                 Months := Calender.Count;
//                 exit(Months);
//             end;
//         end;
//     end;

//     procedure GetCurrentPayPeriodDate(): Date
//     var
//         PayPeriod: Record "Payroll Period";
//         PayStartDate: Date;
//         PayPeriodtext: Text;
//     begin
//         PayPeriod.SetRange(PayPeriod."Close Pay", false);
//         if PayPeriod.FindLast() then begin
//             PayPeriodtext := PayPeriod.Name;
//             PayStartDate := PayPeriod."Starting Date";
//             exit(PayStartDate);
//         end else
//             Error('Please define at least one open Payroll Period');
//     end;



//     procedure GetPayrollRounding(var RoundPrecision: Decimal; var RoundDirection: Text)
//     var
//         HRSetup: Record "Human Resources Setup";
//     begin
//         HRSetup.Get();
//         HRSetup.TestField("Payroll Rounding Precision");
//         RoundPrecision := HRSetup."Payroll Rounding Precision";

//         case HRSetup."Payroll Rounding Type" of
//             HRSetup."Payroll Rounding Type"::Down:
//                 RoundDirection := '<';
//             HRSetup."Payroll Rounding Type"::Nearest:
//                 RoundDirection := '=';
//             HRSetup."Payroll Rounding Type"::Up:
//                 RoundDirection := '>';
//         end;
//     end;

//     procedure GetPrevMonth(PayPeriod: Date; EmplNo: Code[10])
//     begin
//     end;

//     procedure GetPureFormula(EmpCode: Code[20]; Payperiod: Date; strFormula: Text[250]) Formula: Text[250]
//     var
//         StartCopy: Boolean;
//         TransCode: Code[10];
//         TransCodeAmount: Decimal;
//         i: Integer;
//         Char: Text[1];
//         Where: Text[30];
//         Which: Text[30];
//         FinalFormula: Text[250];
//     begin
//         TransCode := '';
//         for i := 1 to StrLen(strFormula) do begin
//             Char := CopyStr(strFormula, i, 1);
//             if Char = '[' then StartCopy := true;
//             if StartCopy then TransCode := CopyStr((TransCode + Char), 1, MaxStrLen(TransCode));
//             //Copy Characters as long as is not within []
//             if not StartCopy then
//                 FinalFormula := CopyStr((FinalFormula + Char), 1, MaxStrLen(FinalFormula));
//             if Char = ']' then begin
//                 StartCopy := false;
//                 //Get Transcode
//                 Where := '=';
//                 Which := '[]';
//                 TransCode := DelChr(TransCode, Where, Which);
//                 //Get TransCodeAmount
//                 TransCodeAmount := GetCurrentPay(EmpCode, Payperiod, TransCode);
//                 //Reset Transcode
//                 TransCode := '';
//                 //Get Final Formula
//                 FinalFormula := FinalFormula + Format(TransCodeAmount);
//                 //End Get Transcode
//             end;
//         end;
//         Formula := FinalFormula;
//     end;

//     procedure GetQuatersEmp("Code": Code[20])
//     begin
//     end;

//     procedure GetResult(strFormula: Text[250]) Results: Decimal
//     begin
//         //Results :=
//         //AccSchedMgt.EvaluateExpression(true, strFormula, AccSchedLine, ColumnLayout, CalcAddCurr);
//     end;


//     procedure GetTaxCode() TaxCode: Code[20]
//     var
//         Deductions: Record Deductions;
//         NoPAYEDeductionErr: Label 'No PAYE Deduction has been defined';
//     begin
//         Deductions.Reset();
//         Deductions.SetRange("PAYE Code", true);
//         Deductions.SetFilter("Deduction Table", '<>%1', ' ');
//         if Deductions.FindFirst() then
//             exit(Deductions."Deduction Table")
//         else
//             Error(NoPAYEDeductionErr);
//     end;

//     procedure GetUserGroup(UserIDs: Code[10]; var PGroup: Code[20])
//     var
//         UserSetup: Record "User Setup";
//         NotSetupInPayrollErr: Label 'You haven''t been setup in the payroll';
//     begin
//         if UserSetup.Get(UserIDs) then begin
//             PGroup := UserSetup."Employee No.";
//             Message('pgroup is ' + PGroup);
//             if PGroup = '' then
//                 Error(NotSetupInPayrollErr);
//         end;
//     end;

//     procedure PayrollRounding(var Amount: Decimal) PayrollRounding: Decimal
//     var
//         HRsetup: Record "Human Resources Setup";
//         Amttoround: Decimal;
//         DecPosistion: Integer;
//         SecNo: Integer;
//         amttext: Text[30];
//         Decvalue: Text[30];
//         FirstNoText: Text[30];
//         holdamt: Text[30];
//         SecNoText: Text[30];
//         Wholeamt: Text[30];
//     begin
//         Evaluate(amttext, Format(Amount));
//         DecPosistion := StrPos(amttext, '.');
//         if DecPosistion > 0 then begin
// #pragma warning disable AA0139
//             Wholeamt := CopyStr(amttext, 1, DecPosistion - 1);
//             Decvalue := CopyStr(amttext, DecPosistion + 1, 2);
//             if StrLen(Decvalue) = 1 then
//                 holdamt := Decvalue + '0';
//             if StrLen(Decvalue) > 1 then begin
//                 FirstNoText := CopyStr(Decvalue, 1, 1);
//                 SecNoText := CopyStr(Decvalue, 2, 1);
//                 Evaluate(SecNo, Format(SecNoText));
//                 if SecNo >= 5 then
//                     holdamt := FirstNoText + '5'
//                 else
//                     holdamt := FirstNoText + '0'
//             end;
//             amttext := Wholeamt + '.' + holdamt;
// #pragma warning restore AA0139
//             Evaluate(Amttoround, Format(amttext));
//         end else begin
//             Evaluate(amttext, Format(Amount));
//             Evaluate(Amttoround, Format(amttext));
//         end;
//         Amount := Amttoround;
//         HRsetup.Get();
//         if HRsetup."Payroll Rounding Precision" = 0 then
//             Error('You must specify the rounding precision under HR setup');
//         if HRsetup."Payroll Rounding Type" = HRsetup."Payroll Rounding Type"::Nearest then
//             PayrollRounding := Round(Amount, HRsetup."Payroll Rounding Precision", '=');
//         if HRsetup."Payroll Rounding Type" = HRsetup."Payroll Rounding Type"::Up then
//             PayrollRounding := Round(Amount, HRsetup."Payroll Rounding Precision", '>');
//         if HRsetup."Payroll Rounding Type" = HRsetup."Payroll Rounding Type"::Down then
//             PayrollRounding := Round(Amount, HRsetup."Payroll Rounding Precision", '<');
//     end;


//     procedure ValidateFormulaAmounts(AssignRec: Record "Assignment Matrix")
//     var
//         AssignmentMatrixX: Record "Assignment Matrix";
//         Deductions: Record Deductions;
//         Earnings: Record Earnings;
//         ValidateAmountTxt: Label 'You have earnings or deductions that depend on changing this amount.\Do you wish to update them?';
//     begin
//         if AssignRec.Amount > 0 then
//             if AssignRec."Basic Salary Code" or AssignRec."House Allowance Code" or AssignRec."Commuter Allowance Code" or AssignRec."Salary Arrears Code" or AssignRec."Insurance Code" then begin
//                 AssignmentMatrixX.Reset();
//                 AssignmentMatrixX.SetRange(AssignmentMatrixX."Employee No", AssignRec."Employee No");
//                 AssignmentMatrixX.SetRange(AssignmentMatrixX."Payroll Period", AssignRec."Payroll Period");
//                 if AssignmentMatrixX.Find('-') then
//                     repeat
//                         //Deductions
//                         Deductions.Reset();
//                         Deductions.SetRange(Code, AssignmentMatrixX.Code);
//                         Deductions.SetFilter("Calculation Method", '%1|%2|%3', Deductions."Calculation Method"::"% of Basic Pay",
//                                               Deductions."Calculation Method"::"% of Basic Pay+Hse Allowance",
//                                               Deductions."Calculation Method"::"% of Basic Pay+Hse Allowance + Comm Allowance + Sal Arrears");
//                         if not Deductions.IsEmpty() then
//                             if Confirm(ValidateAmountTxt, false) then begin
//                                 AssignmentMatrixX.Validate(Code);
//                                 AssignmentMatrixX.Modify();
//                             end;

//                         //Earnings
//                         Earnings.Reset();
//                         Earnings.SetRange(Code, AssignmentMatrixX.Code);
//                         Earnings.SetFilter("Calculation Method", '%1|%2', Earnings."Calculation Method"::"% of Basic pay",
//                                               Earnings."Calculation Method"::"% of Insurance Amount");
//                         if not Earnings.IsEmpty() then begin
//                             AssignmentMatrixX.Validate(Code);
//                             AssignmentMatrixX.Modify();
//                         end;
//                     until AssignmentMatrixX.Next() = 0;
//             end;
//     end;

//     local procedure AddToNoText(var NoText: array[2] of Text[80]; var NoTextIndex: Integer; var PrintExponent: Boolean; AddText: Text[30])
//     var
//         TooLongErr: Label '%1 results in a written number that is too long.', Comment = '%1 = AddText';
//     begin
//         PrintExponent := true;
//         while StrLen(NoText[NoTextIndex] + ' ' + AddText) > MaxStrLen(NoText[1]) do begin
//             NoTextIndex := NoTextIndex + 1;
//             if NoTextIndex > ArrayLen(NoText) then
//                 Error(TooLongErr, AddText);
//         end;
//         NoText[NoTextIndex] := CopyStr((DelChr(NoText[NoTextIndex] + ' ' + AddText, '<')), 1, 80);
//     end;


//     local procedure GetLoanProductName(LoanType: Code[50]): Text
//     var
//         LoanProductType: Record "Loan Product Type-Payroll";
//     begin
//         if LoanProductType.Get(LoanType) then
//             exit(LoanProductType.Description);
//     end;


//     procedure GeneratePayrollEFT(PayPeriod: Date): Boolean
//     var
//         EmployeeRec: Record "Employee";
//         TempExcelBuffer: Record "Excel Buffer" temporary;
//         TempBlob: Codeunit "Temp Blob";
//         XlsxInStream: InStream;
//         DialogTitleTok: Label 'Generate EFT as Xlsx';
//         FileNameTok: Label 'Pay_%1_%2.xlsx', Comment = '%1 = Pay Period. %2 = Current Date', Locked = true;
//         XlsxFilterTok: Label 'Xlsx Files (*.xlsx)|*.xlsx';
//         XlsxOutStream: OutStream;
//         FileName: Text;
//     begin
//         CreateEFTHeader(TempExcelBuffer);

//         EmployeeRec.Reset();
//         EmployeeRec.SetFilter("Employee Type", '<>%1', EmployeeRec."Employee Type"::"Board Member");
//         EmployeeRec.SetRange(Status, EmployeeRec.Status::Active);
//         if EmployeeRec.Findset() then
//             repeat
//                 EmployeeRec.SetRange("Pay Period Filter", PayPeriod);
//                 EmployeeRec.CalcFields("Net Pay");
//                 if EmployeeRec."Net Pay" <> 0 then begin
//                     EmployeeRec.TestField("Employee's Bank");
//                     EmployeeRec.TestField("Bank Branch");
//                     EmployeeRec.TestField("Bank Account Number");
//                     CreateEFTLine(EmployeeRec, TempExcelBuffer, PayPeriod);
//                 end;
//             until EmployeeRec.Next() = 0;

//         TempExcelBuffer.CreateNewBook(CopyStr(EmployeeRec.TableCaption(), 1, 250));
//         TempExcelBuffer.WriteSheet(EmployeeRec.TableCaption(), CompanyName(), UserId());
//         TempExcelBuffer.CloseBook();

//         TempBlob.CreateOutStream(XlsxOutStream, TextEncoding::UTF8);
//         TempExcelBuffer.SaveToStream(XlsxOutStream, true);
//         TempBlob.CreateInStream(XlsxInStream, TextEncoding::UTF8);

//         FileName := StrSubstNo(FileNameTok, Format(PayPeriod, 0, '<Month,2><Year4>'), CurrentDateTime());
//         exit(File.DownloadFromStream(XlsxInStream, DialogTitleTok, '', XlsxFilterTok, FileName));
//     end;

//     local procedure CreateEFTHeader(var TempExcelBuffer: Record "Excel Buffer")
//     begin
//         TempExcelBuffer.Reset();
//         TempExcelBuffer.NewRow();
//         TempExcelBuffer.AddColumn('Name', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
//         TempExcelBuffer.AddColumn('Amount', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Number);
//         TempExcelBuffer.AddColumn('Ref_No', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
//         TempExcelBuffer.AddColumn('Account_No', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
//         TempExcelBuffer.AddColumn('Bank_Code', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
//         TempExcelBuffer.AddColumn('RTGS(Y/N)', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
//         TempExcelBuffer.AddColumn('Bene Address 1', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
//         TempExcelBuffer.AddColumn('Bene Address 2', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
//         TempExcelBuffer.AddColumn('Payment_Details 1', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
//         TempExcelBuffer.AddColumn('Payment_Details 2', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
//         TempExcelBuffer.AddColumn('Payment_Details 3', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
//         TempExcelBuffer.AddColumn('Payment_Details 4', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
//     end;

//     local procedure CreateEFTLine(Employee: Record "Employee"; var TempExcelBuffer: Record "Excel Buffer"; PayPeriod: Date)
//     begin
//         TempExcelBuffer.NewRow();
//         TempExcelBuffer.AddColumn(Employee.FullName(), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
//         TempExcelBuffer.AddColumn(Employee."Net Pay", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
//         TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
//         TempExcelBuffer.AddColumn(Employee."Bank Account Number", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
//         TempExcelBuffer.AddColumn(StrSubstNo(Employee."Employee's Bank" + Employee."Bank Branch"), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
//         TempExcelBuffer.AddColumn('Y', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
//         TempExcelBuffer.AddColumn(Employee.Address, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
//         TempExcelBuffer.AddColumn(Employee."Address 2", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
//         TempExcelBuffer.AddColumn((Format(PayPeriod, 0, '<Month Text><Year4>') + ' Salary'), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
//     end;

//     procedure GetNextSalaryScale(Employee: Record "Employee"; var NextScale: Code[20]; var NextPointer: Code[20])
//     var
//         SalaryPointer: Record "Salary Pointer";
//         SalaryScale: Record "Salary Scale";
//         MaxPointerMsg: Label 'Employee No. %1 - %2 is on the maximum allowable step for their job group. Please assign a new step manually and adjust their next increment date to be the following year';
//     begin
//         NextScale := '';
//         NextPointer := '';

//         Employee.TestField("Salary Scale");
//         Employee.TestField("Present Pointer");
//         Employee.TestField("Date Of Join");

//         if SalaryScale.Get(Employee."Salary Scale") then begin
//             SalaryScale.TestField("Minimum Pointer");
//             SalaryScale.TestField("Maximum Pointer");

//             //Check if employee max pointer achieved
//             if Employee."Present Pointer" = SalaryScale."Maximum Pointer" then begin
//                 if GuiAllowed then
//                     Message(MaxPointerMsg, Employee."No.", Employee.FullName());

//                 /*SalaryScale.Next(-1);
//                 NextScale := SalaryScale.Scale;
//                 NextPointer := SalaryScale."Minimum Pointer";*/
//             end else
//                 if SalaryPointer.Get(Employee."Salary Scale", Employee."Present Pointer") then begin
//                     SalaryPointer.Next();
//                     NextScale := SalaryPointer."Salary Scale";
//                     NextPointer := SalaryPointer."Salary Pointer";
//                 end;
//         end;
//     end;

//     procedure UpdateSalaryIncrementDetails(Employee: Record "Employee"; PayPeriod: Date)
//     var
//         SalaryPointerIncrement: Record "Salary Pointer Increment";
//     begin
//         if not SalaryPointerIncrement.Get(Employee."No.", PayPeriod) then begin
//             SalaryPointerIncrement."Employee No." := Employee."No.";
//             SalaryPointerIncrement."Payroll Period" := PayPeriod;
//             SalaryPointerIncrement.Validate("Increment Date", Employee."Last Increment Date");
//             SalaryPointerIncrement."Previous Scale" := Employee."Previous Salary Scale";
//             SalaryPointerIncrement."Previous Pointer" := Employee.Previous;
//             SalaryPointerIncrement."Present Scale" := Employee."Salary Scale";
//             SalaryPointerIncrement."Present Pointer" := Employee."Present Pointer";
//             SalaryPointerIncrement."Processed By" := UserId();
//             SalaryPointerIncrement.Insert();
//         end;
//     end;

//     procedure CheckIfIncrementEffectedInCurrentYear(Employee: Record "HR Employees"; CurrentYear: Integer): Boolean
//     var
//         SalaryPointerIncrement: Record "Salary Pointer Increment";
//     begin
//         SalaryPointerIncrement.Reset();
//         SalaryPointerIncrement.SetRange("Employee No.", Employee."No.");
//         SalaryPointerIncrement.SetRange("Increment Year", CurrentYear);
//         exit(SalaryPointerIncrement.FindFirst());
//     end;

//     local procedure GetPreviousAmount(EmpCode: Code[20]; PayCode: Code[20]; CurrentPeriod: Date): Decimal
//     var
//         AssignmentMatrix: Record "Assignment Matrix";
//     begin
//         AssignmentMatrix.Reset();
//         AssignmentMatrix.SetRange("Employee No", EmpCode);
//         AssignmentMatrix.SetFilter("Payroll Period", '<>%1', CurrentPeriod);
//         AssignmentMatrix.SetRange(Code, PayCode);
//         if AssignmentMatrix.FindLast() then
//             exit(AssignmentMatrix.Amount);

//         exit(0);
//     end;

// }


