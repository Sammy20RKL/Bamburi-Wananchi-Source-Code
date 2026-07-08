xmlport 50108 "Dividend Lines Import"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Dividends_Lines"; "Dividends Lines")
            {
                XmlName = 'Dividends';

                // No "No" field here - set automatically below
                fieldelement(MemberNo; Dividends_Lines."Member No") { }
                fieldelement(Qu_Shares; Dividends_Lines."Qualifying Shares") { }
                fieldelement(Qu_Deposits; Dividends_Lines."Qualifying Amount") { }
                fieldelement(GrossDividends; Dividends_Lines."Gross Dividends") { }
                fieldelement(DividendsOnShares; Dividends_Lines."Dividends on Shares") { }
                fieldelement(InterestOnDeposits; Dividends_Lines."Interest on Deposits") { }
                fieldelement(TotalAmount; Dividends_Lines."Earned Amount") { }
                fieldelement(W_DTax; Dividends_Lines."Withholding Tax(Share&Depo)") { }
                fieldelement(NetPay; Dividends_Lines."Net Pay") { }
                fieldelement(X_Mas_Loans_P; Dividends_Lines."X-Mas Loan") { }
                fieldelement(x_Mas_Loans_Interest; Dividends_Lines."X-Mas Loan Interest") { }
                fieldelement(Emer_Loans_P; Dividends_Lines."Emer Loan Principle") { }
                fieldelement(Emer_Loans_Interest; Dividends_Lines."Emer Loan Interest") { }
                fieldelement(Hallo_Loan_Principle; Dividends_Lines."Hallo Loan Principle") { }

                fieldelement(Hallo_Loan_Interest; Dividends_Lines."Hallo Loan Interest") { }
                fieldelement(Norm2_Loan_Principle; Dividends_Lines."Norm2 Loan Principle") { }
                fieldelement(Norm2_Loans_Interest; Dividends_Lines."Norm2 Loan Interest") { }
                fieldelement(Norm1_Loans_Principle; Dividends_Lines."Norm1 Loan Principle") { }
                fieldelement(Norm1_Loans_Interest; Dividends_Lines."Norm1 Loan Interest") { }
                fieldelement(School_Loans_Principle; Dividends_Lines."School Loan Principle") { }
                fieldelement(School_Loans_Interest; Dividends_Lines."School Loan Interest") { }
                fieldelement(Mbuyu_Loans_Principle; Dividends_Lines."Mbuyu Loan Principle") { }
                fieldelement(Mbuyu_Loans_Interest; Dividends_Lines."Mbuyu Loan Interest") { }
                fieldelement(Kivukio_Loans_Principle; Dividends_Lines."Kivukio Loan Principle") { }
                fieldelement(Kivukio_Loans_Interest; Dividends_Lines."Kivukio Loan Interest") { }
                fieldelement(Instant_Loans_Principle; Dividends_Lines."Instant Loan Principle") { }
                fieldelement(Instant_Loans_Interest; Dividends_Lines."Instant Loan Interest") { }
                fieldelement(Member_Deposits; Dividends_Lines."Member Deposits") { }
                fieldelement(Holiday_Savings; Dividends_Lines."Holiday Savings") { }
                fieldelement(Unclaimed_Dividends; Dividends_Lines."Unclaimed Dividends") { }

                fieldelement(T_Shirts; Dividends_Lines."T-Shirts") { }
                fieldelement(Net_After_Deduc; Dividends_Lines."Net After Deduction") { }

                trigger OnBeforeInsertRecord()
                begin
                    LineCount += 1;
                    Dividends_Lines."No" := HeaderNo;
                    Dividends_Lines."Line No" := LineCount;
                end;
            }
        }
    }

    var
        LineCount: Integer;
        HeaderNo: Code[20];

    // This procedure is called from the page to pass the Header No
    procedure SetHeaderNo(NewHeaderNo: Code[20])
    begin
        HeaderNo := NewHeaderNo;
    end;

    trigger OnPostXmlPort()
    begin
        Message('Import Complete. %1 lines imported successfully.', LineCount);
    end;
}