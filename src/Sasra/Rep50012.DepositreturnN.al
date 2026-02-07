#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50012 "Deposit returnN"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Deposit returnN.rdlc';
    UsageCategory = ReportsandAnalysis;
    Caption = 'Form 2C';

    dataset
    {
        dataitem("Company Information"; "Company Information")
        {
            column(ReportForNavId_1; 1)
            {
            }
            column(Name; "Company Information".Name)
            {
            }
            column(Count2; Count2)
            {
            }
            column(Balance2; Balance2)
            {
            }
            column(Count3; Count3)
            {
            }
            column(Balance3; Balance3)
            {
            }
            column(Count4; Count4)
            {
            }
            column(Balance4; Balance4)
            {
            }
            column(Count5; Count5)
            {
            }
            column(Balance5; Balance5)
            {
            }
            column(GrandTotalCount; GrandTotalCount)
            {
            }
            column(GrantTotalBalances; GrantTotalBalance)
            {
            }
            column(Count1; Count1)
            {
            }
            column(Balance; Balance)
            {
            }
            column(ASAT; ASAT)
            {
            }
            column(startdate; startdate)
            {
            }
            column(FinancialYear; FinancialYear)
            {
            }
            column(rdate; rdate)
            {
            }

            trigger OnAfterGetRecord()
            begin

                MemberRegister.Reset;
                MemberRegister.SetFilter(MemberRegister."Date Filter", DateFilterNew);
                MemberRegister.SetAutocalcFields("Current Shares");
                // MemberRegister.SetFilter(MemberRegister."Current Shares",'>0');
                if MemberRegister.Find('-') then begin
                    repeat
                        if MemberRegister."Current Shares" > 0 then begin

                            Shares := MemberRegister."Current Shares";
                            if (Shares <> 0) and (Shares <= 50000) then begin
                                Count1 += 1;
                                Balance += MemberRegister."Current Shares";
                            end else
                                if (Shares > 50000) and (Shares <= 100000) then begin
                                    Count2 += 1;
                                    Balance2 += MemberRegister."Current Shares";
                                end else
                                    if (Shares > 100000) and (Shares <= 300000) then begin
                                        Count3 += 1;
                                        Balance3 += MemberRegister."Current Shares";
                                    end else
                                        if (Shares > 300000) and (Shares <= 1000000) then begin
                                            Count4 += 1;
                                            Balance4 += MemberRegister."Current Shares";
                                        end else
                                            if (Shares > 1000000) then begin
                                                Count5 += 1;
                                                Balance5 += MemberRegister."Current Shares";
                                            end;
                        end;
                    until MemberRegister.Next = 0;
                end;
                GrandTotalCount := Count1 + Count2 + Count3 + Count4 + Count5;
                GrantTotalBalance := Balance + Balance2 + Balance3 + Balance4 + Balance5;
                //MESSAGE('%1|%2',GrandTotalCount,GrantTotalBalance);
                //MESSAGE('%1',DateFilterNew);
                rdate := Today;
            end;

            trigger OnPreDataItem()
            begin
                FinancialYear := Date2dmy(ASAT, 3);
                startdate := CalcDate('-CY', ASAT);
                DateFilterNew := '..' + Format(ASAT);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(ASAT; ASAT)
                {
                    ApplicationArea = Basic;
                    Caption = 'AsAt....';
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        MemberRegister: Record Customer;
        Shares: Decimal;
        Count1: Integer;
        Balance: Decimal;
        Balance2: Decimal;
        Count2: Integer;
        Count3: Integer;
        Balance3: Decimal;
        Count4: Integer;
        Balance4: Decimal;
        Balance5: Decimal;
        Count5: Integer;
        GrantTotalBalance: Decimal;
        GrandTotalCount: Integer;
        FinancialYear: Integer;
        startdate: Date;
        DateFilterNew: Text;
        ASAT: Date;
        rdate: Date;
}

