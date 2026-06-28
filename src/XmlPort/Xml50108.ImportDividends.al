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
                fieldelement(X_Mas_Loans; Dividends_Lines."X-Mas Loan") { }
                fieldelement(Member_Deposits; Dividends_Lines."Member Deposits") { }
                fieldelement(Other; Dividends_Lines."To Others") { }
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