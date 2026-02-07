#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50303 "Member Shares Certificate"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/MemberSharesCertificate.rdl';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Members Register"; Customer)
        {
            RequestFilterFields = "No.", "Date Filter";
            column(ReportForNavId_1102755000; 1102755000)
            {
            }
            column(TotalCurrectshares; TotalCurrectshares)
            {
            }
            column(TotalSharecap; TotalSharecap)
            {
            }
            column(TotalLift; TotalLift)
            {
            }
            column(TotalTamba; TotalTamba)
            {
            }
            column(TotalFOSA; TotalFOSA)
            {
            }
            column(TotalPepea; TotalPepea)
            {
            }
            column(TotalVan; TotalVan)
            {
            }
            column(USERID; UserId)
            {
            }
            column(PayrollStaffNo_Members; "Payroll/Staff No")
            {
            }
            column(No_Members; "No.")
            {
            }
            column(Name_Members; Name)
            {
            }
            column(EmployerCode_Members; "Employer Code")
            {
            }
            column(PageNo_Members; CurrReport.PageNo)
            {
            }
            column(Shares_Retained; "Shares Retained")
            {
            }
            column(ShareCapBF; ShareCapBF)
            {
            }
            column(IDNo_Members; "ID No.")
            {
            }
            column(GlobalDimension2Code_Members; "Global Dimension 2 Code")
            {
            }
            column(Company_Name; Company.Name)
            {
            }
            column(Company_Address; Company.Address)
            {
            }
            column(Company_Picture; Company.Picture)
            {
            }
            column(TotalShares; TotalShares)
            {
            }
            column(CertificateNo; CertificateNo)
            {
            }
            column(IDnoMember; IDnoMember)
            {
            }
            column(FullName; FullName)
            {
            }
            column(NumberText; NumberText[1])
            {
            }

            trigger OnAfterGetRecord()
            begin
                MembersReg.Reset;
                MembersReg.SetRange(MembersReg."No.", "No.");
                MembersReg.SetAutocalcFields(MembersReg."Current Shares", MembersReg."Share Capital");
                if MembersReg.Find('-') then begin
                    TotalCurrectshares := 0;
                    TotalSharecap := 0;

                    TotalShares := MembersReg."Current Shares" + MembersReg."Share Capital";
                    CertificateNo := 'POLYTECH && ' + Format(MembersReg."No.");
                    IDnoMember := MembersReg."ID No.";
                    FullName := MembersReg.Name;
                    TotalCurrectshares := MembersReg."Current Shares";
                    TotalSharecap := MembersReg."Share Capital";

                    //................................................
                    //Amount into words
                    CheckReport.InitTextVariable;
                    CheckReport.FormatNoText(NumberText, TotalShares, '');
                    //................................................
                    //AmountInWords:='';
                end;
            end;

            trigger OnPreDataItem()
            begin
                TotalShares := 0;
                CertificateNo := '';
                IDnoMember := '';
                TotalCurrectshares := 0;
                TotalSharecap := 0;
                TotalLift := 0;
                TotalTamba := 0;
                TotalFOSA := 0;
                TotalPepea := 0;
                TotalVan := 0;
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

    trigger OnPreReport()
    begin
        Company.Get();
        Company.CalcFields(Company.Picture);
    end;

    var
        OpenBalance: Decimal;
        CLosingBalance: Decimal;
        OpenBalanceXmas: Decimal;
        CLosingBalanceXmas: Decimal;
        Cust: Record Customer;
        OpeningBal: Decimal;
        ClosingBal: Decimal;
        FirstRec: Boolean;
        PrevBal: Integer;
        BalBF: Decimal;
        LoansR: Record "Loans Register";
        DateFilterBF: Text[150];
        SharesBF: Decimal;
        InsuranceBF: Decimal;
        LoanBF: Decimal;
        PrincipleBF: Decimal;
        InterestBF: Decimal;
        ShowZeroBal: Boolean;
        ClosingBalSHCAP: Decimal;
        ShareCapBF: Decimal;
        XmasBF: Decimal;
        Company: Record "Company Information";
        OpenBalanceHse: Decimal;
        CLosingBalanceHse: Decimal;
        OpenBalanceDep1: Decimal;
        CLosingBalanceDep1: Decimal;
        OpenBalanceDep2: Decimal;
        CLosingBalanceDep2: Decimal;
        HseBF: Decimal;
        Dep1BF: Decimal;
        Dep2BF: Decimal;
        OpeningBalInt: Decimal;
        ClosingBalInt: Decimal;
        InterestPaid: Decimal;
        SumInterestPaid: Decimal;
        OpenBalanceJuja: Decimal;
        CLosingBalanceJuja: Decimal;
        OpenBalanceFani: Decimal;
        CLosingBalanceFani: Decimal;
        OpenBalancejpange: Decimal;
        CLosingBalancejpange: Decimal;
        OpenBalancejunior: Decimal;
        CLosingBalancejunior: Decimal;
        OpenBalanceholiday: Decimal;
        CLosingBalanceholiday: Decimal;
        PrincipleBF1: Decimal;
        SchoolfeesBF: Integer;
        OpenBalanceSF: Decimal;
        CLosingBalanceSF: Decimal;
        PepeaShares: Decimal;
        vanshares: Decimal;
        computershares: Decimal;
        FosaShares: Decimal;
        PepeaSharesBF: Decimal;
        OpenBalancePS: Decimal;
        CLosingBalancePS: Decimal;
        OpenBalanceFs: Decimal;
        CLosingBalanceFs: Decimal;
        ComputerSharesBF: Decimal;
        OpenBalanceCs: Decimal;
        CLosingBalanceCs: Decimal;
        FosaSharesBF: Decimal;
        VanSharesBF: Decimal;
        OpenBalanceVs: Decimal;
        CLosingBalanceVs: Decimal;
        OpenBalancePref: Decimal;
        ClosingBalPref: Decimal;
        PrefSharesBF: Decimal;
        PrefShares: Decimal;
        MembersReg: Record Customer;
        TotalShares: Decimal;
        CertificateNo: Code[30];
        IDnoMember: Code[30];
        FullName: Text[100];
        CheckReport: Report Check;
        NumberText: array[2] of Text[120];
        TotalCurrectshares: Decimal;
        TotalSharecap: Decimal;
        TotalLift: Decimal;
        TotalTamba: Decimal;
        TotalFOSA: Decimal;
        TotalPepea: Decimal;
        TotalVan: Decimal;
}

