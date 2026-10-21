report 70760 "Loan Application Form"
{
    ApplicationArea = All;
    Caption = 'Loan Application Form';
    RDLCLayout = './Layouts/LoanApplicationForm.rdlc';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(OnlineLoanApplication; "Online Loan Application")
        {
            DataItemTableView = sorting("Application No");
            RequestFilterFields = "Application No";

            column(CompanyName; CompanyInfo.Name) { }
            column(CompanyAddress; CompanyInfo.Address) { }
            column(CompanyCity; CompanyInfo.City) { }
            column(CompanyPhoneNo; CompanyInfo."Phone No.") { }
            column(CompanyEmail; CompanyInfo."E-Mail") { }
            column(CompanyLogo; CompanyInfo.Picture) { }
            column(ApplicationNo; "Application No") { }
            column(ApplicationDateText; Format("Application Date", 0, '<Day,2>/<Month,2>/<Year4>')) { }
            column(LoanTypeDescription; "Loan Product Type Name") { }
            column(MemberNames; "Member Names") { }
            column(IdNo; "Id No") { }
            column(MembershipNo; "Membership No") { }
            column(EmploymentNo; "Employment No") { }
            column(MemberEmail; Email) { }
            column(MemberTelephone; Telephone) { }
            column(LoanAmountText; Format("Loan Amount", 0, '<Precision,2:2><Standard Format,9>')) { }
            column(LoanPurpose; "Loan Purpose") { }
            column(RepaymentPeriodText; Format("Repayment Period") + ' Months') { }
            column(InterestRateText; Format("Interest Rate") + ' %') { }
            column(ApplicationStatusText; Format("Application Status")) { }
            column(PrintedOnText; 'Generated on ' + Format(Today, 0, '<Day,2>/<Month,2>/<Year4>') + ' ' + Format(Time, 0, '<Hours24,2>:<Minutes,2>')) { }
            column(LoanAmountInWords; ConvertAmountToWords("Loan Amount")) { }
            column(GuarantorsText; GuarantorsBuf) { }

            trigger OnAfterGetRecord()
            var
                OnlineLoanGuarantors: Record "Online Loan Guarantors";
                LineCounter: Integer;
            begin
                // Guarantors are rendered as one pre-formatted, padded-column text
                // block (not a nested Tablix) so the whole form stays a single
                // data region - a second Tablix sibling caused the guarantors
                // table to paginate independently of the rest of the form,
                // splitting it across the wrong pages.
                Clear(GuarantorsBuf);
                OnlineLoanGuarantors.Reset();
                OnlineLoanGuarantors.SetRange("Loan Application No", "Application No");
                OnlineLoanGuarantors.SetRange(Approved, OnlineLoanGuarantors.Approved::Approved);
                OnlineLoanGuarantors.SetCurrentKey("Loan Application No", "Member No");
                if OnlineLoanGuarantors.FindSet() then
                    repeat
                        LineCounter += 1;
                        GuarantorsBuf +=
                            PadStr(Format(LineCounter) + '.', 4) +
                            PadStr(CopyStr(OnlineLoanGuarantors.Names, 1, 22), 24) +
                            PadStr(OnlineLoanGuarantors."Member No", 12) +
                            PadStr(OnlineLoanGuarantors."ID No", 13) +
                            PadStr(OnlineLoanGuarantors.Telephone, 13) +
                            PadStr(Format(OnlineLoanGuarantors.Amount, 0, '<Precision,2:2><Standard Format,9>'), 13) +
                            PadStr(Format("Application Date", 0, '<Day,2>/<Month,2>/<Year4>'), 13) +
                            PadStr(Format(OnlineLoanGuarantors.Approved), 12) +
                            NewLine;
                    until OnlineLoanGuarantors.Next() = 0
                else
                    GuarantorsBuf := '(No approved guarantors on file yet)' + NewLine;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
    }

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
        NewLine := TypeHelper.CRLFSeparator();
    end;

    var
        CompanyInfo: Record "Company Information";
        TypeHelper: Codeunit "Type Helper";
        NewLine: Text;
        GuarantorsBuf: Text;

    local procedure ConvertAmountToWords(Amount: Decimal): Text
    var
        WholePart: Integer;
        DecimalPart: Integer;
        WholeText: Text;
        DecimalText: Text;
        ResultText: Text;
    begin
        WholePart := Round(Amount, 1, '<');
        DecimalPart := Round((Amount - WholePart) * 100, 1);

        WholeText := ConvertIntegerToWords(WholePart);

        ResultText := WholeText + ' Shillings';

        if DecimalPart > 0 then begin
            DecimalText := ConvertIntegerToWords(DecimalPart);
            ResultText += ' and ' + DecimalText + ' Cents';
        end;

        ResultText += ' Only';
        exit(ResultText);
    end;

    local procedure ConvertIntegerToWords(Number: Integer): Text
    var
        Ones: array[20] of Text;
        Tens: array[10] of Text;
        Result: Text;
        Billions, Millions, Thousands, Remainder : Integer;
    begin
        if Number = 0 then
            exit('Zero');

        Ones[1] := 'One';
        Ones[2] := 'Two';
        Ones[3] := 'Three';
        Ones[4] := 'Four';
        Ones[5] := 'Five';
        Ones[6] := 'Six';
        Ones[7] := 'Seven';
        Ones[8] := 'Eight';
        Ones[9] := 'Nine';
        Ones[10] := 'Ten';
        Ones[11] := 'Eleven';
        Ones[12] := 'Twelve';
        Ones[13] := 'Thirteen';
        Ones[14] := 'Fourteen';
        Ones[15] := 'Fifteen';
        Ones[16] := 'Sixteen';
        Ones[17] := 'Seventeen';
        Ones[18] := 'Eighteen';
        Ones[19] := 'Nineteen';

        Tens[2] := 'Twenty';
        Tens[3] := 'Thirty';
        Tens[4] := 'Forty';
        Tens[5] := 'Fifty';
        Tens[6] := 'Sixty';
        Tens[7] := 'Seventy';
        Tens[8] := 'Eighty';
        Tens[9] := 'Ninety';

        Billions := Number div 1000000000;
        Number := Number mod 1000000000;
        Millions := Number div 1000000;
        Number := Number mod 1000000;
        Thousands := Number div 1000;
        Remainder := Number mod 1000;

        if Billions > 0 then
            Result += ConvertThreeDigits(Billions, Ones, Tens) + ' Billion ';

        if Millions > 0 then
            Result += ConvertThreeDigits(Millions, Ones, Tens) + ' Million ';

        if Thousands > 0 then
            Result += ConvertThreeDigits(Thousands, Ones, Tens) + ' Thousand ';

        if Remainder > 0 then
            Result += ConvertThreeDigits(Remainder, Ones, Tens);

        exit(DelChr(Result, '>', ' ') + '');
    end;

    local procedure ConvertThreeDigits(Number: Integer; Ones: array[20] of Text; Tens: array[10] of Text): Text
    var
        Result: Text;
        Hundreds, Rest : Integer;
    begin
        Hundreds := Number div 100;
        Rest := Number mod 100;

        if Hundreds > 0 then
            Result += Ones[Hundreds] + ' Hundred ';

        if Rest > 0 then begin
            if Rest < 20 then
                Result += Ones[Rest]
            else begin
                Result += Tens[Rest div 10];
                if Rest mod 10 > 0 then
                    Result += '-' + Ones[Rest mod 10];
            end;
        end;

        exit(Result);
    end;
}
